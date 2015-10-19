unit onlineupdatefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InternetUpdate, ExtCtrls, ComCtrls, StdCtrls, ShellApi, Registry,
  JvExControls, JvAnimatedImage, JvGIFCtrl, JvGradient, TokenTools,
  gnugettext, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, HTTPApp;

type
  Tonlineupdate = class(TForm)
    InternetUpdate: TInternetUpdate;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    filesizelbl: TLabel;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Label34: TLabel;
    Label35: TLabel;
    JvGIFAnimator2: TJvGIFAnimator;
    Shape2: TShape;
    Shape1: TShape;
    Label8: TLabel;
    filenamelbl: TLabel;
    actualfilesizelbl: TLabel;
    CloseBtn: TButton;
    procedure FormShow(Sender: TObject);
    procedure InternetUpdateText(Sender: TObject; MessageText: String;
      ProcessID: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure InternetUpdateDownloadProgress(Sender: TObject; TotalSize,
      Readed: Integer);
    procedure InternetUpdateDownloadStart(Sender: TObject);
    procedure InternetUpdateDownloadComplete(Sender: TObject;
      SetupEXE: String);
    procedure Button2Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure InternetUpdateUpdateFound(Sender: TObject; LocalVersion,
      RemoteVersion: TIUVersionInfo; Info: TDownloadInfo;
      var DownloadNow: Boolean; var DestinationFilename: String);
    procedure InternetUpdateNoUpdate(Sender: TObject);
    procedure InternetUpdateContactingHost(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure InternetUpdateHostNotFound(Sender: TObject);
  private
    { Private-Deklarationen }
    updatedatei:string;
  public
    { Public-Deklarationen }
    function GetCurrUserName: string;
    function Impersonate(User, PW: string): Boolean;
  end;

var
  onlineupdate: Tonlineupdate;

implementation

uses PCDIMMER, webdownloadfrm;

{$R *.dfm}

procedure Tonlineupdate.FormShow(Sender: TObject);
var
  LReg:TRegistry;
begin
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
        if LReg.ValueExists('Last Onlineupdatefile') then
        	updatedatei:=LReg.ReadString('Last Onlineupdatefile');
      end;
    end;
  end;
  LReg.CloseKey;

  label4.Caption:=_('Wird ermittelt...');
  label4.Font.Color:=clBlack;
  label4.Refresh;
  actualfilesizelbl.Caption:='0,00 kB';
	progressbar1.enabled:=false;

  button2.Hint:=_('Führt die bereits heruntergeladene Datei "')+updatedatei+_('" aus.');

  if fileexists(updatedatei) then
  	button2.Visible:=true
  else
    button2.Visible:=false;

	InternetUpdate.Execute;
end;

procedure Tonlineupdate.InternetUpdateText(Sender: TObject;
  MessageText: String; ProcessID: Integer);
begin
  if MessageText<>'' then
  	label7.Caption:=MessageText;
  if InternetUpdate.RemoteVersion.Text<>'' then
    label4.Caption:=InternetUpdate.RemoteVersion.Text;
end;

procedure Tonlineupdate.InternetUpdateDownloadProgress(Sender: TObject;
  TotalSize, Readed: Integer);
begin
	progressbar1.Max:=TotalSize;
  progressbar1.Position:=Readed;
  actualfilesizelbl.caption:=mainform.FileSize2String(Readed);
end;

procedure Tonlineupdate.InternetUpdateDownloadStart(Sender: TObject);
begin
	progressbar1.enabled:=true;
end;

procedure Tonlineupdate.InternetUpdateDownloadComplete(Sender: TObject;
  SetupEXE: String);
var
  LReg:TRegistry;
  msg:string;
begin
	updatedatei:=setupexe;

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
        LReg.WriteString('Last Onlineupdatefile',updatedatei);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  if fileexists(updatedatei) then
  begin
  	button2.Visible:=true;
    button2.Hint:=_('Führt die bereits heruntergeladene Datei "')+updatedatei+_('" aus.');
  end else
    button2.Visible:=false;

  if InternetUpdate.CloseBeforeRun then
    Msg := _('Der Download ist beendet. Soll die laufende Anwendung jetzt beendet werden und die Updateroutine jetzt starten?')
  else
    Msg := _('Der Download ist beendet. Soll das Update jetzt gestartet werden?');

  if MessageDlg(msg, mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    if InternetUpdate.CloseBeforeRun then
    begin
      close;
      MainForm.shutdown:=true;
      Mainform.QuitWithoutConfirmation:=true;
      MainForm.close;
      Application.Terminate;
    end;

    if IsUserAnAdmin then
    begin
      // User ist Admin - also kein Problem
      shellexecute(0, 'open', PChar(SetupEXE), '', PChar(ExtractFilePath(SetupEXE)), SW_SHOWNORMAL);
    end else
    begin
     // User ist kein Admin - Benutzernamen anfragen
      shellexecute(0, 'runas', PChar(SetupEXE), '', PChar(ExtractFilePath(SetupEXE)), SW_SHOWNORMAL);
    end;
  end;
end;

procedure Tonlineupdate.Button2Click(Sender: TObject);
begin
  InternetUpdateDownloadComplete(nil, updatedatei);
end;

procedure Tonlineupdate.FormDblClick(Sender: TObject);
begin
  button2.visible:=true;
end;

procedure Tonlineupdate.InternetUpdateUpdateFound(Sender: TObject;
  LocalVersion, RemoteVersion: TIUVersionInfo; Info: TDownloadInfo;
  var DownloadNow: Boolean; var DestinationFilename: String);
begin
  filenamelbl.caption:=ExtractFileName(UnixPathToDosPath(InternetUpdate.Download.FileURL));
//  filesizelbl.Caption:=mainform.FileSize2String(mainform.GetWebFileSize2(InternetUpdate.Download.FileURL));
//  filesizelbl.Refresh;
  label4.Font.color:=clGreen;
end;

procedure Tonlineupdate.InternetUpdateNoUpdate(Sender: TObject);
begin
  label4.Font.color:=clRed;
  filesizelbl.caption:='-';
  filenamelbl.caption:='-';
  ShowMessage(_('Ihre Version des PC_DIMMERs ist noch aktuell.'));
end;

procedure Tonlineupdate.InternetUpdateContactingHost(Sender: TObject);
begin
  label4.Caption:=_('Wird ermittelt...');
  label4.Font.color:=clBlack;
end;

function Tonlineupdate.GetCurrUserName: string;
var
  Size              : DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, Size);
  if GetUserName(PChar(Result), Size) then
    SetLength(Result, Size)
  else
    Result := '';
end;

function Tonlineupdate.Impersonate(User, PW: string): Boolean;
var
  LogonType         : Integer;
  LogonProvider     : Integer;
  TokenHandle       : THandle;
  strAdminUser      : string;
  strAdminDomain    : string;
  strAdminPassword  : string;
begin
  LogonType := LOGON32_LOGON_INTERACTIVE;
  LogonProvider := LOGON32_PROVIDER_DEFAULT;
  strAdminUser := User;
  strAdminDomain := '';
  strAdminPassword := PW;
  Result := LogonUser(PChar(strAdminUser), nil,
    PChar(strAdminPassword), LogonType, LogonProvider, TokenHandle);
  if Result then
  begin
    Result := ImpersonateLoggedOnUser(TokenHandle);
  end;
end;

procedure Tonlineupdate.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tonlineupdate.CloseBtnClick(Sender: TObject);
begin
  close;
  MainForm.shutdown:=true;
  Mainform.QuitWithoutConfirmation:=true;
  MainForm.close;
  application.Terminate;
end;

procedure Tonlineupdate.InternetUpdateHostNotFound(Sender: TObject);
begin
  ShowMessage(_('Der Updateserver konnte nicht gefunden werden. Bitte schauen Sie auf "http://downloads.pcdimmer.de" nach neuen Updates. Vielen Dank.'));
end;

procedure Tonlineupdate.CreateParams(var Params:TCreateParams);
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
