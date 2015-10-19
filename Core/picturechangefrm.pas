unit picturechangefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, JvExControls, JvGradient, gnugettext;

type
  Tpicturechangeform = class(TForm)
    ListBox1: TListBox;
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
    Panel3: TPanel;
    Label2: TLabel;
    Image1: TImage;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Panel4: TPanel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    Dateien:array of string;
    procedure ListboxChanged;
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
var
  SR: TSearchRec;
  searchdirectory:string;
  i:integer;
begin
  Listbox1.Items.Clear;
  setlength(Dateien,0);

  searchdirectory:=mainform.workingdirectory+'\DevicePictures\32 x 32';
  if (FindFirst(searchdirectory+'\*.png',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        setlength(Dateien, length(Dateien)+1);
        Dateien[length(Dateien)-1]:=mainform.workingdirectory+'\DevicePictures\32 x 32\'+SR.Name;
        Listbox1.Items.Add(SR.Name);
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;
  searchdirectory:=mainform.workingdirectory+'\DevicePictures\Gobos';
  if (FindFirst(searchdirectory+'\*.png',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        setlength(Dateien, length(Dateien)+1);
        Dateien[length(Dateien)-1]:=mainform.workingdirectory+'\DevicePictures\Gobos\'+SR.Name;
        Listbox1.Items.Add(SR.Name);
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
  end;

  Listbox1.ItemIndex:=0;
  if Listbox1.items.count>0 then
  begin
    for i:=0 to Listbox1.Items.count-1 do
    begin
      if lowercase(Listbox1.items[i])=lowercase(ExtractFileName(aktuellebilddatei)) then
        Listbox1.ItemIndex:=i;
    end;
    ListboxChanged;
  end;
end;

procedure Tpicturechangeform.ListboxChanged;
begin
  if (Listbox1.items.count>0) and (Listbox1.itemindex>-1) then
  begin
    Image1.Picture.LoadFromFile(Dateien[Listbox1.ItemIndex]);
    aktuellebilddatei:=Dateien[Listbox1.ItemIndex];
  end;
end;

procedure Tpicturechangeform.ListBox1Click(Sender: TObject);
begin
  ListboxChanged;
end;

procedure Tpicturechangeform.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ListboxChanged;

  if Key=vk_return then
    modalresult:=mrOK;
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tpicturechangeform.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tpicturechangeform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tpicturechangeform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  setlength(Dateien, 0);
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

end.
