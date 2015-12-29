unit picturechangefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, JvExControls, JvGradient, gnugettext,
  ComCtrls, ShlObj, cxShellCommon, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxListView, cxShellListView;

type
  Tpicturechangeform = class(TForm)
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
    OpenDialog1: TOpenDialog;
    Panel4: TPanel;
    Label1: TLabel;
    cxShellListView1: TcxShellListView;
    cxShellListView2: TcxShellListView;
    Button3: TButton;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure cxShellListView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxShellListView2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxShellListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cxShellListView2SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    aktuellebilddatei:string;
  end;

var
  picturechangeform: Tpicturechangeform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tpicturechangeform.FormShow(Sender: TObject);
begin
  cxShellListView1.Root.CustomPath:=ExtractFilepath(paramstr(0))+'Devicepictures\32 x 32\';
  cxShellListView2.Root.CustomPath:=ExtractFilepath(paramstr(0))+'Devicepictures\Gobos\';
end;

procedure Tpicturechangeform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tpicturechangeform.Button3Click(Sender: TObject);
begin
  if Opendialog1.Execute then
  begin
    aktuellebilddatei:=opendialog1.FileName;
    Image1.Picture.LoadFromFile(aktuellebilddatei);
  end;
end;

procedure Tpicturechangeform.CreateParams(var Params:TCreateParams);
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

procedure Tpicturechangeform.cxShellListView1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_return then
    modalresult:=mrOK
  else if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tpicturechangeform.cxShellListView2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_return then
    modalresult:=mrOK
  else if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tpicturechangeform.cxShellListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if (Item<>nil) and (Item.Caption<>'') then
  begin
    aktuellebilddatei:=ExtractFilepath(paramstr(0))+'Devicepictures\32 x 32\'+Item.Caption;
  end;
end;

procedure Tpicturechangeform.cxShellListView2SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if (Item<>nil) and (Item.Caption<>'') then
  begin
    aktuellebilddatei:=ExtractFilepath(paramstr(0))+'Devicepictures\Gobos\'+Item.Caption;
  end;
end;

end.
