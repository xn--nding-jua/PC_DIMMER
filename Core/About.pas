unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, jpeg, JvComponent, JvExControls,
  JvScrollText, pngimage, JvGradient, gnugettext;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    Panel2: TPanel;
    JvGradient1: TJvGradient;
    Scrolltext: TPanel;
    Shape1: TShape;
    JvScrolltext: TJvScrollText;
    Version: TLabel;
    Button1: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel3: TPanel;
    Image1: TImage;
    Shape2: TShape;
    JvGradient2: TJvGradient;
    Label11: TLabel;
    JvGradient3: TJvGradient;
    Panel4: TPanel;
    Shape3: TShape;
    Label4: TLabel;
    Panel6: TPanel;
    Shape4: TShape;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
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

procedure TAboutBox.FormShow(Sender: TObject);
begin
  JvScrolltext.Active:=true;
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

