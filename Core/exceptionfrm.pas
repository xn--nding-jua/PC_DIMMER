unit exceptionfrm;

{$I jcl.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JclDebug, pngimage, JvExControls, JvGradient,
  gnugettext, dxGDIPlusClasses;

type
  TExcDialogSystemInfo = (siStackList, siOsInfo, siModuleList, siActiveControls);
  TExcDialogSystemInfos = set of TExcDialogSystemInfo;

  Texceptionform = class(TForm)
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    DetailsMemo: TMemo;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    JvGradient1: TJvGradient;
    Shape4: TShape;
    Shape1: TShape;
    Bevel1: TBevel;
    procedure CreateExceptionReport(const SystemInfo: TExcDialogSystemInfos);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    FLastActiveControl: TWinControl;
  end;

resourcestring
  RsAppError = '%s - application error';
  RsExceptionClass = 'Exception class: %s';
  RsExceptionAddr = 'Exception address: %p';
  RsStackList = 'Stack list, generated %s';
  RsModulesList = 'List of loaded modules:';
  RsOSVersion = 'System   : %s %s, Version: %d.%d, Build: %x, "%s"';
  RsProcessor = 'Processor: %s, %s, %d MHz %s%s';
  RsScreenRes = 'Display  : %dx%d pixels, %d bpp';
  RsActiveControl = 'Active Controls hierarchy:';
  RsThread = 'Thread: %s';
  RsMissingVersionInfo = '(no version info)';

var
  exceptionform: Texceptionform;

implementation

{$R *.dfm}

uses
  ClipBrd, Math,
  JclBase, JclFileUtils, JclHookExcept, JclPeImage, JclStrings, JclSysInfo, JclSysUtils,
  PCDIMMER;

function GetBPP: Integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES);
  ReleaseDC(0, DC);
end;

function SortModulesListByAddressCompare(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := Integer(List.Objects[Index1]) - Integer(List.Objects[Index2]);
end;

procedure Texceptionform.CreateExceptionReport(const SystemInfo: TExcDialogSystemInfos);
const
  MMXText: array[Boolean] of PChar = ('', 'MMX');
  FDIVText: array[Boolean] of PChar = (' [FDIV Bug]', '');
var
  SL: TStringList;
{
  I:Integer;
  NtHeaders: PImageNtHeaders;
  ModuleBase: Cardinal;
  ImageBaseStr: string;
  ModuleName: TFileName;
}
  CpuInfo: TCpuInfo;
  C: TWinControl;
  StackList: TJclStackInfoList;
begin
  SL := TStringList.Create;
  try
    // System and OS information
    if siOsInfo in SystemInfo then
    begin
      exceptionform.DetailsMemo.Lines.Add(Format(RsOSVersion, [GetWindowsVersionString, NtProductTypeString,
        Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, Win32CSDVersion]));
      GetCpuInfo(CpuInfo);
      with CpuInfo do
        DetailsMemo.Lines.Add(Format(RsProcessor, [Manufacturer, CpuName,
          RoundFrequency(FrequencyInfo.NormFreq),
          MMXText[MMX], FDIVText[IsFDIVOK]]));
      exceptionform.DetailsMemo.Lines.Add(Format(RsScreenRes, [Screen.Width, Screen.Height, GetBPP]));
      DetailsMemo.Lines.Add(StrRepeat('-', 100));
    end;
    // Stack list
    if siStackList in SystemInfo then
    begin
      StackList := JclLastExceptStackList;
      if Assigned(StackList) then
      begin
        DetailsMemo.Lines.Add(Format(RsStackList, [DateTimeToStr(StackList.TimeStamp)]));
        StackList.AddToStrings(DetailsMemo.Lines, False, True, True);
        DetailsMemo.Lines.Add(StrRepeat('-', 100));
      end;
    end;
    // Modules list
{
    if (siModuleList in SystemInfo) and LoadedModulesList(SL, GetCurrentProcessId) then
    begin
      exceptionform.DetailsMemo.Lines.Add(RsModulesList);
      SL.CustomSort(SortModulesListByAddressCompare);
      for I := 0 to SL.Count - 1 do
      begin
        ModuleName := SL[I];
        ModuleBase := Cardinal(SL.Objects[I]);
        exceptionform.DetailsMemo.Lines.Add(Format('[%.8x] %s', [ModuleBase, ModuleName]));
        NtHeaders := PeMapImgNtHeaders(Pointer(ModuleBase));
        if (NtHeaders <> nil) and (NtHeaders^.OptionalHeader.ImageBase <> ModuleBase) then
          ImageBaseStr := Format('<%.8x> ', [NtHeaders^.OptionalHeader.ImageBase])
        else
          ImageBaseStr := StrRepeat(' ', 11);
        if VersionResourceAvailable(ModuleName) then
          with TJclFileVersionInfo.Create(ModuleName) do
          try
            exceptionform.DetailsMemo.Lines.Add(ImageBaseStr + BinFileVersion + ' - ' + FileVersion);
            if FileDescription <> '' then
              exceptionform.DetailsMemo.Lines.Add(StrRepeat(' ', 11) + FileDescription);
          finally
            Free;
          end
        else
          exceptionform.DetailsMemo.Lines.Add(ImageBaseStr + RsMissingVersionInfo);
      end;
      DetailsMemo.Lines.Add(StrRepeat('-', 100));
    end;
}
    // Active controls
    if (siActiveControls in SystemInfo) and (FLastActiveControl <> nil) then
    begin
      exceptionform.DetailsMemo.Lines.Add(RsActiveControl);
      C := FLastActiveControl;
      while C <> nil do
      begin
        exceptionform.DetailsMemo.Lines.Add(Format('%s "%s"', [C.ClassName, C.Name]));
        C := C.Parent;
      end;
      DetailsMemo.Lines.Add(StrRepeat('-', 100));
    end;
  finally
    SL.Free;
  end;
end;

procedure Texceptionform.FormShow(Sender: TObject);
begin
  exceptionform.Height:=350;
  Button2.Caption:='Details >>';
  Listbox1.Items.Text:=DetailsMemo.Text;
  Listbox1.Items.SaveToFile(mainform.workingdirectory+'\PC_DIMMER_Error.log');
end;

procedure Texceptionform.Button2Click(Sender: TObject);
begin
  if exceptionform.Height=590 then
  begin
    exceptionform.Height:=350;
    Button2.Caption:='Details >>';
  end else
  begin
    exceptionform.Height:=590;
    Button2.Caption:='<< Details';
  end;
end;

procedure Texceptionform.Button3Click(Sender: TObject);
begin
  DetailsMemo.SelectAll;
  DetailsMemo.CopyToClipboard;
end;

procedure Texceptionform.RadioGroup1Click(Sender: TObject);
begin
  mainform.errorhandlingmode:=RadioGroup1.ItemIndex;
end;

procedure Texceptionform.FormCreate(Sender: TObject);
begin
//  TranslateComponent(self);
end;

procedure Texceptionform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

end.
