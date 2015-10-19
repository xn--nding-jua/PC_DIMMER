program Md5Check;

uses
  Windows,
  messages,
  CommDlg,
  SysUtils,
  CommCtrl,
  ShlObj,
  ShellApi,
  Richedit,
  Hash,
  MD5;

{$R md5.res}

const

  //dialog items...
  idFilename = 9;
  idBrowse = 8;
  idCalculate = 3;
  idResult = 4;
  idMatch = 5;
  idClose = 7;       
  idMessage = 11;

type

  {this structure definition changes between delphi versions hence
  to enable consistency between compilers...}
  TOpenFilename = packed record
    lStructSize: DWORD;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PAnsiChar;
    lpstrCustomFilter: PAnsiChar;
    nMaxCustFilter: DWORD;
    nFilterIndex: DWORD;
    lpstrFile: PAnsiChar;
    nMaxFile: DWORD;
    lpstrFileTitle: PAnsiChar;
    nMaxFileTitle: DWORD;
    lpstrInitialDir: PAnsiChar;
    lpstrTitle: PAnsiChar;
    Flags: DWORD;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PAnsiChar;
    lCustData: LPARAM;
    lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
    lpTemplateName: PAnsiChar;
    pvReserved: Pointer;
    dwReserved: DWORD;
    FlagsEx: DWORD;
  end;

  function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall;
    external 'comdlg32.dll'  name 'GetOpenFileNameA';

var
  dlg: THandle;
  boldFont: HFont;

  YellowBrush: HBrush;
  LimeBrush: HBrush;
  BtnFaceBrush: HBrush;

  osVersionInfo: TOSVersionInfo;

//---------------------------------------------------------------------
//---------------------------------------------------------------------

function OpenFileDialog(Owner: THandle; const Caption, Filter,
  InitialDir: string; var Filename: string; MultiSelect: boolean): boolean;
var
  ofn: TOpenFilename;
  filepath: array [0..1024] of char;
  i: integer;
  newfilter: string;
begin
  strPCopy(filepath,Filename); //nb: ofn.lpstrFile must be initialized (or #0)

  //nb: assumes only a single filter here...
  i := pos('|',Filter);
  if i > 0 then
  begin
    newfilter  := copy(Filter,1,i-1)+#0+copy(filter,i+1,255)+#0#0;
  end;
  if newfilter = '' then
    newfilter  := 'All Files (*.*)'+#0'*.*'#0#0;


  fillchar(ofn,sizeof(ofn),0);
  //prior to win2000 & WinME the last 3 fields of TOpenFilename aren't supported
  if ((osVersionInfo.dwMajorVersion > 4) and
      (osVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT)) {win2000 or winXP} or
      ((osVersionInfo.dwMajorVersion > 3) and
      (osVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
      (osVersionInfo.dwMinorVersion >= 90)) {winME} then
    ofn.lStructSize := sizeof(TOpenFilename) else
    ofn.lStructSize := sizeof(TOpenFilename) -12;

  ofn.hWndOwner := Owner;
  ofn.lpstrFilter := pchar(newfilter);
  ofn.nFilterIndex := 1;
  ofn.lpstrFile := pchar(@filepath[0]);
  ofn.nMaxFile := MAX_PATH;
  ofn.lpstrFileTitle := nil;

  ofn.lpstrInitialDir := pchar(InitialDir);
  ofn.lpstrTitle := pchar(caption);
  ofn.Flags := OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST or OFN_HIDEREADONLY;
  if MultiSelect then
    ofn.Flags := ofn.Flags or OFN_ALLOWMULTISELECT or OFN_EXPLORER;
  result := GetOpenFileName(ofn);
  if not result then exit;
  //if MultiSelect then filepath can have 2 general forms:
  //  1. 'path&name'#0#0 or
  //  2. 'path'#0'name1'#0'name2'#0' ..nameN'#0#0
  if MultiSelect then
  begin
    //here, we're just interested in the first filename, so ...
    Filename := pchar(@filepath[strlen(filepath)+1]);
    if Filename = '' then
      Filename := filepath else
      Filename := format('%s\%s',[filepath, Filename]);
  end
  else
    Filename := filepath;
end;
//--------------------------------------------------------------------------

function MD5DigestToString(md5: TMD5Digest):string;
var
  i: integer;
begin
  result := '';
  for i := 0 to 15 do
    result := result + inttohex(md5[i],2);
end;
//--------------------------------------------------------------------------

procedure CalcMD5Sum;
var
  oldCursor: HCursor;
  fn_buff: array[0..254] of char;
  buffer: array[0..$8000 -1] of char;
  err: word;
  md5: TMD5Digest;
  s: string;
begin
   oldCursor := SetCursor(LoadCursor(0, IDC_WAIT));
   try
     sendDlgItemMessage(dlg, idFilename, WM_GETTEXT, 254,longint(@fn_buff[0]));

     MD5File(fn_buff, md5, buffer[0], $8000, err);
     if err = 0 then
       s := MD5DigestToString(md5) else
       s := 'Error!';
     sendDlgItemMessage(dlg, idResult, WM_SETTEXT, 0, longint(pchar(s)));
   finally
     SetCursor(oldCursor);
   end;
end;
//--------------------------------------------------------------------------

procedure DoCompare;
var
  s1, s2: string;
  buff: array[0..254] of char;
begin
  sendDlgItemMessage(dlg, idResult, WM_GETTEXT, 254,longint(@buff[0]));
  s1 := buff;
  sendDlgItemMessage(dlg, idMatch, WM_GETTEXT, 254,longint(@buff[0]));
  s2 := buff;
  if CompareText(trim(s1), trim(s2)) = 0 then
    StrPCopy(buff,'MD5 checksums match.') else
    StrPCopy(buff,'MD5 checksums DON''T match.');
  sendDlgItemMessage(dlg, idMessage, WM_SETTEXT, 0, longint(@buff[0]));
end;
//--------------------------------------------------------------------------

function Main(Dialog: HWnd; AMessage, WParam: LongInt; LParam: Longint): Bool; stdcall;
var
  buff: array[0..254] of char;
  s1, s2, fn: string;
  hdl: THandle;
begin
  result := true;
  case AMessage of
    WM_INITDIALOG:
      begin
        //set the application icon...
        SetClassLong( Dialog, GCL_HICON, LoadIcon( hInstance, 'MAINICON'));
      end;
    WM_COMMAND:
      case LoWord(WParam) of
        IDCANCEL, idClose: PostQuitMessage(0); //modeless dialogs only
        idFilename:
          if HiWord(WParam) = EN_CHANGE then
          begin
            //enable/disable Calculate button based on Filename ...
            sendDlgItemMessage(dlg, idFilename, WM_GETTEXT, 254,longint(@buff[0]));
            EnableWindow(GetDlgItem(dlg,idCalculate), fileExists(buff));
            //clear Result and Message windows ...
            buff[0] := #0;
            sendDlgItemMessage(dlg, idResult, WM_SETTEXT, 0, longint(@buff[0]));
            sendDlgItemMessage(dlg, idMessage, WM_SETTEXT, 0, longint(@buff[0]));
          end;
        idCalculate: CalcMD5Sum;
        idBrowse:
          if (HIWORD(wParam) = BN_CLICKED) and
            OpenFileDialog(dlg,'Select File ...', 'All Files (*.*)|*.*','',fn, false) then
          begin
            sendDlgItemMessage(dlg, idFilename, WM_SETTEXT, 0, longint(pchar(fn)));
            SetFocus(GetDlgItem(dlg,idCalculate));
          end;
        idResult, idMatch:
          if HiWord(WParam) = EN_CHANGE then
          begin
            sendDlgItemMessage(dlg, idResult, WM_GETTEXT, 254,longint(@buff[0]));
            s1 := buff;
            sendDlgItemMessage(dlg, idMatch, WM_GETTEXT, 254,longint(@buff[0]));
            s2 := buff;
            if (s1 <> '') and (s2 <> '') then
              DoCompare
            else
            begin
              buff[0] := #0;
              sendDlgItemMessage(dlg, idMessage, WM_SETTEXT, 0, longint(@buff[0]));
            end;
          end;
      end;
    WM_CTLCOLORSTATIC:
      begin
        hdl := GetDlgItem(dlg, idMessage);
        if (lparam = hdl) then
        begin
          GetWindowText(hdl,buff,254);
          if buff = '' then
          begin
            result := Bool(BtnFaceBrush);
          end
          else if buff = 'MD5 checksums match.' then
          begin
            SetBkColor(wParam, RGB(0,255,0));
            result := Bool(LimeBrush);
          end
          else
          begin
            SetBkColor(wParam, RGB(255,255,0));
            result := Bool(YellowBrush);
          end;
        end
        else result := false;
      end;
    else result := False; //ie not handled
  end;
end;

//--------------------------------------------------------------------------
// Main prog. entry point...
//--------------------------------------------------------------------------
var
  msg: TMsg;
  param1: string;
begin

  osVersionInfo.dwOSVersionInfoSize := sizeof(osVersionInfo);
  GetVersionEx(osVersionInfo);

  dlg := CreateDialog( hInstance, 'MAIN', 0, @Main);
  if dlg = 0 then exit;

  //Create a bold font for the about dialog...
  boldFont := CreateFont(-11, 0, 0, 0, FW_EXTRABOLD, 0, 0, 0, DEFAULT_CHARSET,
                      OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
                      DEFAULT_PITCH or FF_DONTCARE, 'Arial');
  SendDlgItemMessage(dlg, idMessage, WM_SETFONT, boldFont, 0);

  YellowBrush := CreateSolidBrush(RGB(255,255,0));
  LimeBrush := CreateSolidBrush(RGB(0,255,0));
  BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  
  if (paramcount > 0) then
  begin
    param1 := paramstr(1);
    sendDlgItemMessage(dlg, idFilename, WM_SETTEXT, 0, longint(pchar(param1)));
    if fileExists(param1) then
    begin
      EnableWindow(GetDlgItem(dlg,idCalculate), true);
      SetFocus(GetDlgItem(dlg,idCalculate));
    end
    else
      sendDlgItemMessage(dlg, idFilename, EM_SETSEL, 0, -1);
  end;

  while GetMessage(msg, 0, 0, 0) do
    IsDialogMessage(dlg, msg);

  //cleanup...
  DeleteObject(YellowBrush);
  DeleteObject(LimeBrush);
  DeleteObject(BtnFaceBrush);

  DeleteObject(boldFont);
  DestroyWindow(dlg);
end.

