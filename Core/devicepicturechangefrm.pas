unit devicepicturechangefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, JvExControls, JvGradient, gnugettext;

type
  Tdevicepicturechangeform = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label4: TLabel;
    px32: TLabel;
    px64: TLabel;
    px96: TLabel;
    px128: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape2: TShape;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    procedure ListboxChanged;
  public
    { Public-Deklarationen }
    aktuellebilddatei:string;
  end;

var
  devicepicturechangeform: Tdevicepicturechangeform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tdevicepicturechangeform.FormShow(Sender: TObject);
var
  SR: TSearchRec;
  searchdirectory:string;
  i:integer;
begin
  searchdirectory:=mainform.workingdirectory+'\DevicePictures\32 x 32';
  Listbox1.Items.Clear;
  if (FindFirst(searchdirectory+'\*.bmp',faAnyFile-faDirectory,SR)=0) or
  (FindFirst(searchdirectory+'\*.jpg',faAnyFile-faDirectory,SR)=0) or
  (FindFirst(searchdirectory+'\*.gif',faAnyFile-faDirectory,SR)=0) or
  (FindFirst(searchdirectory+'\*.ico',faAnyFile-faDirectory,SR)=0) or
  (FindFirst(searchdirectory+'\*.png',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
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
      if lowercase(Listbox1.items[i])=lowercase(aktuellebilddatei) then
        Listbox1.ItemIndex:=i;
    end;
    ListboxChanged;
  end;
end;

procedure Tdevicepicturechangeform.ListboxChanged;
var
  bildname,bildpfad,loadpicturefile:string;
begin
  if (Listbox1.items.count>0) and (Listbox1.itemindex>-1) then
  begin
    bildname:=Listbox1.Items[Listbox1.ItemIndex];
    bildpfad:=mainform.workingdirectory+'Devicepictures\32 x 32\';

    // das größte Bild für die Vorschau suchen
    if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname) then
    begin
      loadpicturefile:=(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname);
    end
    else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname) then
    begin
      loadpicturefile:=(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname);
    end
    else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname) then
    begin
      loadpicturefile:=(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname);
    end
    else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname) then
    begin
      loadpicturefile:=(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname);
    end;

    try
      Image1.Picture.LoadFromFile(loadpicturefile);
      aktuellebilddatei:=copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname;
    except
      ShowMessage(_('Die Datei scheint kein gültiges Bild zu sein...'));
    end;

    px32.Visible:=FileExists(mainform.workingdirectory+'Devicepictures\32 x 32\'+Listbox1.Items[Listbox1.ItemIndex]);
    px64.Visible:=FileExists(mainform.workingdirectory+'Devicepictures\64 x 64\'+Listbox1.Items[Listbox1.ItemIndex]);
    px96.Visible:=FileExists(mainform.workingdirectory+'Devicepictures\96 x 96\'+Listbox1.Items[Listbox1.ItemIndex]);
    px128.Visible:=FileExists(mainform.workingdirectory+'Devicepictures\128x128\'+Listbox1.Items[Listbox1.ItemIndex]);
  end;
end;

procedure Tdevicepicturechangeform.ListBox1Click(Sender: TObject);
begin
  ListboxChanged;
end;

procedure Tdevicepicturechangeform.ListBox1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ListboxChanged;

  if Key=vk_return then
    modalresult:=mrOK;
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tdevicepicturechangeform.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

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

end.
