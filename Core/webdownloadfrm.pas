unit webdownloadfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, JvGradient,
  ComCtrls, JvAnimatedImage, JvGIFCtrl, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, gnugettext, HTTPApp;

type
  Twebdownloadform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Label34: TLabel;
    Label35: TLabel;
    Shape2: TShape;
    Button2: TButton;
    Shape1: TShape;
    JvGIFAnimator1: TJvGIFAnimator;
    Label1: TLabel;
    filenamelbl: TLabel;
    Label3: TLabel;
    filesizelbl: TLabel;
    Label5: TLabel;
    progressbar: TProgressBar;
    actualsizelbl: TLabel;
    IdHTTP: TIdHTTP;
    Button1: TButton;
    CheckFileSizeTimer: TTimer;
    Label2: TLabel;
    Label4: TLabel;
    localversionlbl: TLabel;
    onlineversionlbl: TLabel;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Integer);
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);
    procedure CheckFileSizeTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    FileStream:TFileStream;
  public
    { Public-Deklarationen }
    downloadfile:string;
  end;

var
  webdownloadform: Twebdownloadform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Twebdownloadform.FormShow(Sender: TObject);
begin
  progressbar.enabled:=false;
  actualsizelbl.enabled:=false;

  progressbar.Position:=0;
  actualsizelbl.Caption:='0% (0,00 kB)';

  filenamelbl.Caption:=ExtractFileName(UnixPathToDosPath(downloadfile));
  filesizelbl.caption:=_('Wird ermittelt...');
  CheckFileSizeTimer.enabled:=true;
end;

procedure Twebdownloadform.Button2Click(Sender: TObject);
begin
  progressbar.enabled:=true;
  actualsizelbl.enabled:=true;

  try
    If not DirectoryExists(mainform.workingdirectory+'Downloads') then
      CreateDir(mainform.workingdirectory+'Downloads');
    if FileExists(mainform.workingdirectory+'Downloads\'+ExtractFileName(UnixPathToDosPath(downloadfile))) then
      DeleteFile(mainform.workingdirectory+'Downloads\'+ExtractFileName(UnixPathToDosPath(downloadfile)));
    FileStream:=TFileStream.Create(mainform.workingdirectory+'Downloads\'+ExtractFileName(UnixPathToDosPath(downloadfile)), fmCreate or fmShareDenyNone);
    idHTTP.Get(downloadfile, FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure Twebdownloadform.Button1Click(Sender: TObject);
begin
  idHTTP.Disconnect;
  ModalResult:=mrCancel;
end;

procedure Twebdownloadform.IdHTTPWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  ModalResult:=mrOK;
end;

procedure Twebdownloadform.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Integer);
begin
  progressbar.Max:=AWorkCountMax;
end;

procedure Twebdownloadform.IdHTTPWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Integer);
begin
  Application.ProcessMessages;
  progressbar.Position:=AWorkCount;
  actualsizelbl.caption:=inttostr(round((AWorkCount / progressbar.max)*100))+'% ('+mainform.FileSize2String(AWorkCount)+')';
end;

procedure Twebdownloadform.CheckFileSizeTimerTimer(Sender: TObject);
begin
  CheckFileSizeTimer.Enabled:=false;

  Application.ProcessMessages;
  filesizelbl.caption:=mainform.FileSize2String(mainform.GetWebFileSize2(downloadfile));
end;

procedure Twebdownloadform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Twebdownloadform.CreateParams(var Params:TCreateParams);
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
