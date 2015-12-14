unit welcomefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, JvExControls, JvXPCore, JvXPButtons,
  StdCtrls, Registry, ShellAPI, JvComputerInfoEx, gnugettext,
  TokenTools, Menus, ImgList, PngImageList, Contnrs, dxGDIPlusClasses;

type
  Twelcomeform = class(TForm)
    Image1: TImage;
    JvXPButton1: TJvXPButton;
    JvXPButton2: TJvXPButton;
    JvXPButton3: TJvXPButton;
    JvXPButton5: TJvXPButton;
    OpenDialog1: TOpenDialog;
    lastproject1: TLabel;
    lastproject2: TLabel;
    lastproject3: TLabel;
    lastproject4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lastproject0: TLabel;
    lastproject5: TLabel;
    StartTimer: TTimer;
    JvXPButton7: TJvXPButton;
    restorelastvalues: TCheckBox;
    PopupMenu1: TPopupMenu;
    Videoscreenffnen1: TMenuItem;
    MediaCenterServerstarten1: TMenuItem;
    PCDIMMERServerstarten1: TMenuItem;
    SoftScannerstarten1: TMenuItem;
    Plugintesterstarten1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    PngImageList1: TPngImageList;
    JvXPButton4: TJvXPButton;
    CDPlayer1: TMenuItem;
    procedure JvXPButton1Click(Sender: TObject);
    procedure JvXPButton2Click(Sender: TObject);
    procedure JvXPButton5Click(Sender: TObject);
    procedure lastproject1Click(Sender: TObject);
    procedure lastproject2Click(Sender: TObject);
    procedure lastproject3Click(Sender: TObject);
    procedure lastproject4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lastproject0Click(Sender: TObject);
    procedure lastproject5Click(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure JvXPButton7Click(Sender: TObject);
    procedure Videoscreenffnen1Click(Sender: TObject);
    procedure JvXPButton3Click(Sender: TObject);
    procedure MediaCenterServerstarten1Click(Sender: TObject);
    procedure PCDIMMERServerstarten1Click(Sender: TObject);
    procedure SoftScannerstarten1Click(Sender: TObject);
    procedure Plugintesterstarten1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure JvXPButton4Click(Sender: TObject);
    procedure CDPlayer1Click(Sender: TObject);
  private
    { Private-Deklarationen }
//    FileStream:TFileStream;
    openhistory : array[0..4] of string[255];
    validfiles:array[1..5] of string;
    firststart:boolean;
    startimmediatly:boolean;

    ProjectToLoad:string;
    workingdirectory:string;
    nowelcomeagain:boolean;
 	  osversion:string;
    procedure StartPCDIMMER(switch: string);
    procedure RefreshOpenHistory;
		function GetFileVersionBuild(Const FileName:String):String;
  public
    { Public-Deklarationen }
    function GetWindowsVersion:string;
    function GetWindowsLanguage: string;
  end;

var
  welcomeform: Twelcomeform;

implementation

{$R *.dfm}

function Twelcomeform.GetWindowsLanguage: string;
var
  langcode: string;
  CountryName: array[0..4] of char;
  LanguageName: array[0..4] of char;
  works: boolean;
begin
  // The return value of GetLocaleInfo is compared with 3 = 2 characters and a zero
  works := 3 = GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SISO639LANGNAME, LanguageName, SizeOf(LanguageName));
  works := works and (3 = GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SISO3166CTRYNAME, CountryName,
    SizeOf(CountryName)));
  if works then begin
    // Windows 98, Me, NT4, 2000, XP, Vista and newer
    LangCode := PChar(@LanguageName[0]);
    if lowercase(LangCode)='no' then LangCode:='nb';
//    LangCode:=LangCode + '_' + PChar(@CountryName[0]);
  end else begin
    langcode := 'C';
  end;
  Result := UpperCase(langcode);
end;

procedure Twelcomeform.JvXPButton1Click(Sender: TObject);
begin
  ProjectToLoad:='';
  StartPCDIMMER('');
end;

procedure Twelcomeform.JvXPButton2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ProjectToLoad:=OpenDialog1.FileName;
    StartPCDIMMER('');
  end;
end;

procedure Twelcomeform.JvXPButton5Click(Sender: TObject);
begin
  close;
end;

procedure Twelcomeform.StartPCDIMMER(switch: string);
var
  restore:string;
begin
  if restorelastvalues.Checked then
    restore:='restorelastvalues';

  if length(ProjectToLoad)>0 then
    ProjectToLoad:='"'+ProjectToLoad+'"';
    ShellExecute( 0, 'Open', pchar(workingdirectory+'PC_DIMMER.exe'),PChar('/sp2 '+ProjectToLoad+' '+switch+' '+restore) ,pChar(workingdirectory),SW_SHOW);
  Close;
end;

procedure Twelcomeform.lastproject1Click(Sender: TObject);
begin
  ProjectToLoad:=validfiles[1];
  StartPCDIMMER('');
end;

procedure Twelcomeform.lastproject2Click(Sender: TObject);
begin
  ProjectToLoad:=validfiles[2];
  StartPCDIMMER('');
end;

procedure Twelcomeform.lastproject3Click(Sender: TObject);
begin
  ProjectToLoad:=validfiles[3];
  StartPCDIMMER('');
end;

procedure Twelcomeform.lastproject4Click(Sender: TObject);
begin
  ProjectToLoad:=validfiles[4];
  StartPCDIMMER('');
end;

function Twelcomeform.GetWindowsVersion:string;
var
  OsVinfo: TOSVERSIONINFO;
  tempstring:string;
begin
  ZeroMemory(@OsVinfo, SizeOf(OsVinfo));
  OsVinfo.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

  if GetVersionEx(OsVinfo) then
  begin
    // WINDOWS9x
    if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
    begin
      if (OsVinfo.dwMajorVersion < 4) then
        tempstring:='Windows 3.11';

      if (OsVinfo.dwMajorVersion = 4) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='Windows95';
          1: tempstring:='Windows98/98SE';
          10: tempstring:='Windows98/98SE';
          90: tempstring:='WindowsME';
        else
          tempstring:='Windows9x '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;
    end;

    // WINDOWSNT
    if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
    begin
      if (OsVinfo.dwMajorVersion < 4) then
      begin
        tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
      end;

      if (OsVinfo.dwMajorVersion = 4) then
      begin
        tempstring:='WindowsNT4';
      end;

      if (OsVinfo.dwMajorVersion = 5) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='Windows2000';
          1: tempstring:='WindowsXP';
          2: tempstring:='WindowsXP 64Bit';
        else
          tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;

      if (OsVinfo.dwMajorVersion = 6) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='WindowsVista';
          1: tempstring:='Windows 7';
          2: tempstring:='Windows 8';
          3: tempstring:='Windows 8.1';
        else
          tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;

  	  // MajorVersion = 7, 8 and 9 will not be released

      if (OsVinfo.dwMajorVersion >=10) then
      begin
		    // Windows 10.0 will have MajorVersion = 10 and MinorVersion = x
        tempstring:='Windows '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion) + ' Build '+inttostr(OsVInfo.dwBuildNumber)
      end;
    end;
  end;
  Result:=tempstring;//+' '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)+'.'+inttostr(OsVinfo.dwBuildNumber);
end;

procedure Twelcomeform.FormCreate(Sender: TObject);
var
  i:integer;
  sprache, LastLanguage:string;
//  OsVinfo: TOSVERSIONINFO;
  LReg:TRegistry;
begin
  // PC_DIMMER nur auf dem ersten CPU-Core ausführen (andernfalls Abstürze durch BASS.DLL!!!)
  SetProcessAffinityMask(GetCurrentProcess, 1); // 1=CPU0 , 2=CPU1
                      
{
  if not IsUserAnAdmin then
  begin
    ZeroMemory(@OsVinfo, SizeOf(OsVinfo));
    OsVinfo.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

    if GetVersionEx(OsVinfo) then
    begin
      if OsVinfo.dwMajorVersion>=6 then
      begin
        ShowMessage(_('PC_DIMMER benötigt Admin-Rechte auf diesem Computer.'+#13#10#13#10+'Klicken Sie bitte mit der rechten Maustaste auf das PC_DIMMER-Icon und wählen Sie "Als Administrator ausführen..." aus dem Kontextmenü.'));
      end else
      begin
        ShowMessage(_('PC_DIMMER benötigt Admin-Rechte auf diesem Computer.'+#13#10#13#10+'Bitte stellen Sie dies für einen korrekten Betrieb sicher.'));
      end;
    end else
    begin
      ShowMessage(_('PC_DIMMER benötigt Admin-Rechte auf diesem Computer.'+#13#10#13#10+'Bitte stellen Sie dies für einen korrekten Betrieb sicher.'));
    end;
  end;
}

  workingdirectory:=ExtractFilePath(paramstr(0));

  // Sprache checken
  sprache:=GetWindowsLanguage;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.ValueExists('Language') then
          LReg.WriteString('Language', sprache);
        LastLanguage:=LReg.ReadString('Language');
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  if LastLanguage='' then
    LastLanguage:='EN';
  if ((uppercase(LastLanguage)<>'DE') and (not DirectoryExists(workingdirectory+'locale\'+LastLanguage))) or
     ((uppercase(LastLanguage)<>'DE') and (not DirectoryExists(workingdirectory+'locale\'+LastLanguage+'\LC_MESSAGES'))) then
  begin
    ShowMessage('The PC_DIMMER does not have a languagefile for your language "'+LastLanguage+'". The PC_DIMMER will start in English now...');
    LastLanguage:='EN';
  end;
  UseLanguage(LastLanguage);

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        LReg.WriteString('Language', LastLanguage);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  TranslateComponent(self);

  firststart:=true;
  nowelcomeagain:=false;

  osversion:=GetWindowsVersion;

  startimmediatly:=false;
  for i:=1 to paramcount do
    if (paramstr(i)='/nowelcome') or (paramstr(i)='-nowelcome') or FileExists(paramstr(i)) then
      startimmediatly:=true;

  if startimmediatly then
  begin
    Application.ShowMainForm:=false;

    firststart:=false;
    StartTimer.enabled:=true;
  end;

  MediaCenterServerstarten1.Visible:=FileExists(workingdirectory+'MediaCenterServer.exe');
  PCDIMMERServerstarten1.Visible:=FileExists(workingdirectory+'PC_DIMMER_SVR.exe');
  SoftScannerstarten1.Visible:=FileExists(workingdirectory+'SoftScanner.exe');
  Plugintesterstarten1.Visible:=FileExists(workingdirectory+'PC_DIMMER_Plugintester.exe');
  CDPlayer1.Visible:=FileExists(workingdirectory+'CDPlayer.exe');
end;

procedure Twelcomeform.FormShow(Sender: TObject);
var
  i:integer;
  nowelcome:boolean;
begin
  RefreshOpenHistory;

  if firststart then
  begin
    nowelcome:=false;
    for i:=1 to paramcount do
    begin
      if (paramstr(i)='/nowelcome') or (paramstr(i)='-nowelcome') then
      begin
        nowelcome:=true;
      end;
    end;

    JvXPButton4.Enabled:=FileExists(ExtractFilePath(paramstr(0))+'ProjectTemp\Projekt');

    label2.caption:='('+osversion+', '+GetWindowsLanguage+')';
    label2.Alignment:=taRightJustify;

    if FileExists(ExtractFilePath(paramstr(0))+'PC_DIMMER.EXE') then
      label3.caption:=GetFileVersionBuild(ExtractFilePath(paramstr(0))+'PC_DIMMER.EXE')
    else
      label3.caption:='';
    label3.Alignment:=taRightJustify;

    if (startimmediatly and firststart) or (nowelcome and firststart) then
    begin
      firststart:=false;
      StartTimer.enabled:=true;
    end;
  end;

  firststart:=false;
end;

procedure Twelcomeform.StartTimerTimer(Sender: TObject);
begin
  StartTimer.enabled:=false;
  StartPCDIMMER('');
end;

Function Twelcomeform.GetFileVersionBuild(Const FileName: String): String;
  Var i, W: LongWord;
    P: Pointer;
    FI: PVSFixedFileInfo;
    version,zusatz,text,text2:string;
  Begin
    version := 'NoVersionInfo';
    i := GetFileVersionInfoSize(PChar(FileName), W);
    If i = 0 Then Exit;
    GetMem(P, i);
    Try
      If not GetFileVersionInfo(PChar(FileName), W, i, P)
        or not VerQueryValue(P, '\', Pointer(FI), W) Then Exit;
      version := IntToStr(FI^.dwFileVersionMS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionMS and $FFFF)
        + '.' + IntToStr(FI^.dwFileVersionLS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionLS and $FFFF);
      If FI^.dwFileFlags and VS_FF_DEBUG        <> 0 Then zusatz := 'Debug ';
      If FI^.dwFileFlags and VS_FF_PRERELEASE   <> 0 Then zusatz := 'Beta ';
      If FI^.dwFileFlags and VS_FF_PRIVATEBUILD <> 0 Then zusatz := 'Private ';
      If FI^.dwFileFlags and VS_FF_SPECIALBUILD <> 0 Then zusatz := 'RC ';
    Finally
      FreeMem(P);
    End;

    text:=version; //4.0.0.0
    text2:=copy(text,0,pos('.',text)); // 4.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)); // 4.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)-1); // 4.0.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0

    result:='Version '+text2+' Build '+text+' '+zusatz;
End;

procedure Twelcomeform.lastproject0Click(Sender: TObject);
begin
  ProjectToLoad:='lastproject';
  StartPCDIMMER('');
end;

procedure Twelcomeform.lastproject5Click(Sender: TObject);
begin
  ProjectToLoad:=validfiles[5];
  StartPCDIMMER('');
end;

procedure Twelcomeform.RefreshOpenHistory;
var
  i,j,counter:integer;
  doesexists:boolean;
  LReg:TRegistry;
begin
{
  if FileExists(workingdirectory+'\'+configfilename) then
  begin
    FileStream:=TFilestream.Create(workingdirectory+'\'+configfilename,fmOpenRead);
    if FileStream.Size=10088 then
    begin
      FileStream.Position:=8808;
    end else if FileStream.Size=18536 then
    begin
      FileStream.Position:=17256;
    end;
    FileStream.ReadBuffer(openhistory,sizeof(openhistory));
    FileStream.Free;
  end;
}
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if LReg.ValueExists('Openhistory1') then
          openhistory[0]:=LReg.ReadString('Openhistory1');
        if LReg.ValueExists('Openhistory2') then
          openhistory[1]:=LReg.ReadString('Openhistory2');
        if LReg.ValueExists('Openhistory3') then
          openhistory[2]:=LReg.ReadString('Openhistory3');
        if LReg.ValueExists('Openhistory4') then
          openhistory[3]:=LReg.ReadString('Openhistory4');
        if LReg.ValueExists('Openhistory5') then
          openhistory[4]:=LReg.ReadString('Openhistory5');
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  for i:=1 to 5 do
    validfiles[i]:='';

  counter:=0;
  for i:=0 to 4 do
  begin
    if FileExists(openhistory[i]) then
    begin
      doesexists:=false;
      for j:=1 to 5 do
      begin
        if validfiles[j]=openhistory[i] then
          doesexists:=true;
      end;

      if not doesexists then
      begin
        counter:=counter+1;
        if counter<=5 then
        begin
          validfiles[counter]:=openhistory[i];
        end;
      end;
    end;
  end;

  for i:=1 to 5 do
  begin
    if validfiles[i]<>'' then
    begin
      TLabel(FindComponent('lastproject'+inttostr(i))).Caption:=ExtractFileName(validfiles[i]);
      TLabel(FindComponent('lastproject'+inttostr(i))).Visible:=true;
    end;
  end;
end;

procedure Twelcomeform.JvXPButton7Click(Sender: TObject);
begin
//  ShellExecute(Handle, 'Open', PChar(workingdirectory+'\Hilfe\pptview.exe'), PChar('"'+workingdirectory+'\Hilfe\PC_DIMMER.ppt"'), nil, SW_SHOW);
  ShellExecute(Handle, 'Open', PChar('http://www.pcdimmer.de/wiki/index.php/Kategorie:Handbuch'), PChar(''), nil, SW_SHOW);
end;

procedure Twelcomeform.Videoscreenffnen1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'Videoscreen.exe'),'' ,pChar(workingdirectory),SW_SHOW);
end;

procedure Twelcomeform.JvXPButton3Click(Sender: TObject);
begin
  PopupMenu1.Popup(welcomeform.left+JvXPButton3.Left+(JvXPButton3.Width div 2), welcomeform.top+JvXPButton3.Top+(JvXPButton3.Height div 2)+25);
end;

procedure Twelcomeform.MediaCenterServerstarten1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'MediaCenterServer.exe'),'' ,pChar(workingdirectory),SW_SHOW);
end;

procedure Twelcomeform.PCDIMMERServerstarten1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'PC_DIMMER_SVR.exe'),'' ,pChar(workingdirectory),SW_SHOW)
{
  if IsUserAnAdmin then
    ShellExecute( 0, 'Open', pchar(workingdirectory+'PC_DIMMER_SVR.exe'),'' ,pChar(workingdirectory),SW_SHOW)
  else
    ShellExecute( 0, 'RunAs', pchar(workingdirectory+'PC_DIMMER_SVR.exe'),'' ,pChar(workingdirectory),SW_SHOW);
}
end;

procedure Twelcomeform.SoftScannerstarten1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'SoftScanner.exe'),'' ,pChar(workingdirectory),SW_SHOW)
{
  if IsUserAnAdmin then
    ShellExecute( 0, 'Open', pchar(workingdirectory+'SoftScanner.exe'),'' ,pChar(workingdirectory),SW_SHOW)
  else
    ShellExecute( 0, 'RunAs', pchar(workingdirectory+'SoftScanner.exe'),'' ,pChar(workingdirectory),SW_SHOW);
}
end;

procedure Twelcomeform.Plugintesterstarten1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'PC_DIMMER_Plugintester.exe'),'' ,pChar(workingdirectory),SW_SHOW)
{
  if IsUserAnAdmin then
    ShellExecute( 0, 'Open', pchar(workingdirectory+'PC_DIMMER_Plugintester.exe'),'' ,pChar(workingdirectory),SW_SHOW)
  else
    ShellExecute( 0, 'RunAs', pchar(workingdirectory+'PC_DIMMER_Plugintester.exe'),'' ,pChar(workingdirectory),SW_SHOW);
}
end;

procedure Twelcomeform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  
//  Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
//  Params.WndParent:=GetDesktopWindow;
//  welcomeform.ParentWindow := GetDesktopWindow;
end;

procedure Twelcomeform.JvXPButton4Click(Sender: TObject);
begin
  ProjectToLoad:='';
  StartPCDIMMER('/loadfastsave');
end;

procedure Twelcomeform.CDPlayer1Click(Sender: TObject);
begin
  ShellExecute( 0, 'Open', pchar(workingdirectory+'CDPlayer.exe'),'sp0' ,pChar(workingdirectory),SW_SHOW);
end;

end.
