unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, jpeg, JvComponent, JvComputerInfoEx,
  JvExControls, JvGradient, JvComponentBase, JvMRUList, JvAnimatedImage,
  JvGIFCtrl, JvScrollText, pngimage, gnugettext;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    RAMAnzeigeTimer: TTimer;
    Panel2: TPanel;
    JvMruList1: TJvMruList;
    JvGradient1: TJvGradient;
    JvGIFAnimator2: TJvGIFAnimator;
    Scrolltext: TPanel;
    Shape1: TShape;
    Label9: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    JvScrolltext: TJvScrollText;
    Version: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Button1: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel3: TPanel;
    ramauslastung_label: TLabel;
    ramauslastung_progressbar: TProgressBar;
    Image1: TImage;
    Shape2: TShape;
    JvGradient2: TJvGradient;
    Label11: TLabel;
    JvComputerInfoEx1: TJvComputerInfoEx;
    JvGradient3: TJvGradient;
    Panel4: TPanel;
    Shape3: TShape;
    windowsversion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    Panel6: TPanel;
    Shape4: TShape;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure RAMAnzeigeonTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
		function GetFileVersion(Const FileName:String):String;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
  public
    { Public declarations }
    workingdirectory:string;
  end;

var
  AboutBox: TAboutBox;

implementation

uses splashscreen, PCDIMMER;

{$R *.DFM}

function RDTSC: Int64; assembler;
asm
  RDTSC  // result Int64 in EAX and EDX
end;

procedure TAboutBox.FormShow(Sender: TObject);
var
  x, y : real;
  memory: TMemoryStatus;
  Auslastung: integer;
  text:string;
  i: integer;
begin
  i:=0;
  repeat
    i:=i+1;
  until JvComputerInfoEx1.CPU.Name[i]<>' ';
  label9.caption:=copy(JvComputerInfoEx1.CPU.Name,i,32);

  label10.caption:=_('Cores: ')+inttostr(JvComputerInfoEx1.CPU.PhysicalCore);
  label17.caption:=_('Frequenz: ')+inttostr(JvComputerInfoEx1.CPU.NormFreq)+_(' MHz');
  if JvComputerInfoEx1.CPU.Is64Bits then text:='64bit ' else text:='32bit ';
  if JvComputerInfoEx1.CPU.MMX then text:=text+'MMX ';
  if JvComputerInfoEx1.CPU._3DNow then text:=text+'3DNow ';
  if JvComputerInfoEx1.CPU.SSE=vSSE1 then text:=text+'SSE ';
  if JvComputerInfoEx1.CPU.SSE=vSSE2 then  text:=text+'SSE2 ';
  if JvComputerInfoEx1.CPU.SSE=vSSE3 then text:=text+'SSE3 ';
  if JvComputerInfoEx1.CPU.SSE=vSSSE3 then text:=text+'SSSE3 ';
  if JvComputerInfoEx1.CPU.HyperThreadingTechnology then text:=text+'HT';
  label18.caption:=text;

  memory.dwLength := SizeOf(memory);
  GlobalMemoryStatus(memory);
  x := memory.dwTotalPhys - memory.dwAvailPhys;
  y := memory.dwTotalPhys;
  Auslastung := round(((x/y)*100));
  ramauslastung_label.Caption:=_('Speicherauslastung: ')+inttostr(Auslastung)+'%';
  ramauslastung_progressbar.Position := Auslastung;
  ramanzeigetimer.Enabled:=true;

  windowsversion.Visible:=true;
  panel3.Visible:=true;
  label11.Visible:=true;
  label13.Visible:=true;
  label14.Visible:=true;
  label15.Visible:=true;

  Label16MouseMove(nil, [], 0,0);
  JvScrolltext.Active:=true;
end;

procedure TAboutBox.RAMAnzeigeonTimer(Sender: TObject);
var
  x, y : real;
  memory: TMemoryStatus;
  Auslastung: integer;
begin
  memory.dwLength := SizeOf(memory);
  GlobalMemoryStatus(memory);
  x := memory.dwTotalPhys - memory.dwAvailPhys;
  y := memory.dwTotalPhys;
  Auslastung := round(((x/y)*100));
  ramauslastung_label.Caption:=_('Speicherauslastung: ')+inttostr(Auslastung)+'%';
  ramauslastung_progressbar.Position := Auslastung;

  Label16MouseMove(nil, [], 0,0);
end;

procedure TAboutBox.FormHide(Sender: TObject);
begin
  ramanzeigetimer.Enabled:=false;
end;

procedure TAboutBox.Label16MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  t, h, min:integer;
begin
  t:=jvcomputerinfoex1.Misc.TimeRunning;
  h:=t div 3600000; t:=t mod 3600000;
  min:=t div 60000;
  label16.Caption:=inttostr(h)+_('h ')+inttostr(min)+_('min');
end;

procedure TAboutBox.Button1Click(Sender: TObject);
var
  osversion:string;
begin
  splash:=tsplash.Create(Application,true);
  splash.versioninfo:=_('Version ')+GetFileVersion(paramstr(0)) + ' (' + osversion + ')';
  splash.captioninfo:='Christian Nöding';
  Splash.AddText('PC_DIMMER v'+GetFileVersion(paramstr(0)));
  Splash.AddText(osversion);
  Splash.AddText('');
  Splash.AddText(_('Ich danke meiner Frau für Ihr Verständnis'));
  Splash.AddText(_('wegen sehr vieler Stunden vor dem Computer :-)'));
  Splash.ea:=true;
  splash.BlendValue:=255;
  splash.Timer1Timer(nil);
  Splash.showmodal;
  Splash.free;
  Splash:=nil;
end;

Function TAboutBox.GetFileVersion(Const FileName: String): String;
  Var i, W: LongWord;
    P: Pointer;
    FI: PVSFixedFileInfo;

  Begin
    Result := _('NoVersionInfo');
    i := GetFileVersionInfoSize(PChar(FileName), W);
    If i = 0 Then Exit;
    GetMem(P, i);
    Try
      If not GetFileVersionInfo(PChar(FileName), W, i, P)
        or not VerQueryValue(P, '\', Pointer(FI), W) Then Exit;
      Result := IntToStr(FI^.dwFileVersionMS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionMS and $FFFF)
        + '.' + IntToStr(FI^.dwFileVersionLS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionLS and $FFFF);
      If FI^.dwFileFlags and VS_FF_DEBUG        <> 0 Then Result := Result + _(' Debug');
      If FI^.dwFileFlags and VS_FF_PRERELEASE   <> 0 Then Result := Result + _(' Beta');
      If FI^.dwFileFlags and VS_FF_PRIVATEBUILD <> 0 Then Result := Result + _(' Private');
      If FI^.dwFileFlags and VS_FF_SPECIALBUILD <> 0 Then Result := Result + _(' RC');
    Finally
      FreeMem(P);
    End;
End;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TAboutBox.CreateParams(var Params:TCreateParams);
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

