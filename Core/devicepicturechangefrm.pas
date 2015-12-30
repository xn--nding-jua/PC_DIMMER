unit devicepicturechangefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, JvExControls, JvGradient, gnugettext,
  dximctrl, ImgList, PngImageList, ComCtrls, ShlObj, cxShellCommon,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxListView, cxShellListView;

type
  Tdevicepicturechangeform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Button1: TButton;
    Button2: TButton;
    cxShellListView1: TcxShellListView;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure cxShellListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cxShellListView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    aktuellebilddatei:string;
  end;

var
  devicepicturechangeform: Tdevicepicturechangeform;

implementation

uses PCDIMMER, ProgressScreenSmallFrm;

{$R *.dfm}

procedure Tdevicepicturechangeform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tdevicepicturechangeform.CreateParams(var Params:TCreateParams);
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

procedure Tdevicepicturechangeform.cxShellListView1SelectItem(
  Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if (Item<>nil) and (Item.Caption<>'') then
  begin
    aktuellebilddatei:='64 x 64\'+Item.Caption;
  end;
end;

procedure Tdevicepicturechangeform.cxShellListView1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_return then
    modalresult:=mrOK
  else if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tdevicepicturechangeform.FormShow(Sender: TObject);
begin
  cxShellListView1.Root.CustomPath:=ExtractFilepath(paramstr(0))+'Devicepictures\64 x 64\';
  cxShellListView1.Root.BrowseFolder:=bfCustomPath;
end;

end.
