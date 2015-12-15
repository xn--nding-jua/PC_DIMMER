unit colormanagerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExControls, JvColorBox, JvColorButton,
  HSLColorPicker, Buttons, PngBitBtn, pngimage, JvGradient, gnugettext;

type
  Tcolormanagerform = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    HSLColorPicker1: THSLColorPicker;
    buttonfarbe: TJvColorButton;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Edit2: TEdit;
    ListBox2: TListBox;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape2: TShape;
    Shape1: TShape;
    Edit3: TEdit;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    ListBox3: TListBox;
    HSLColorPicker2: THSLColorPicker;
    buttonfarbe2: TJvColorButton;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn4: TPngBitBtn;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure HSLColorPicker1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure buttonfarbeChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit2Change(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure PngBitBtn4Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure HSLColorPicker2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    procedure ListboxChange;
  public
    { Public-Deklarationen }
    aktuellesgeraet:integer;
  end;

var
  colormanagerform: Tcolormanagerform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tcolormanagerform.FormShow(Sender: TObject);
var
  i:integer;
begin
  Groupbox1.Visible:=mainform.devices[aktuellesgeraet].hasColor;
  Groupbox2.Visible:=mainform.devices[aktuellesgeraet].hasColor2;

  if (aktuellesgeraet>=0) and (aktuellesgeraet<length(mainform.devices)) then
  begin
    label4.Caption:=mainform.devices[aktuellesgeraet].Name;

    if mainform.devices[aktuellesgeraet].hasColor then
    begin
      Listbox1.Items.clear;
      for i:=0 to length(mainform.devices[aktuellesgeraet].colors)-1 do
      begin
        Listbox1.Items.Add(mainform.devices[aktuellesgeraet].colornames[i]);
      end;

      if listbox1.Items.count>0 then
      begin
        listbox1.ItemIndex:=0;
        listboxchange;
      end;
    end;

    if mainform.devices[aktuellesgeraet].hasColor2 then
    begin
      Listbox3.Items.clear;
      for i:=0 to length(mainform.devices[aktuellesgeraet].colors2)-1 do
      begin
        Listbox3.Items.Add(mainform.devices[aktuellesgeraet].colornames2[i]);
      end;

      if listbox3.Items.count>0 then
      begin
        listbox3.ItemIndex:=0;
        listboxchange;
      end;
    end;
  end;
end;

procedure Tcolormanagerform.HSLColorPicker1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    buttonfarbe.Color:=HSLColorPicker1.SelectedColor;
    mainform.devices[aktuellesgeraet].colors[listbox1.itemindex]:=buttonfarbe.Color;
  end;
end;

procedure Tcolormanagerform.buttonfarbeChange(Sender: TObject);
begin
  if Sender=buttonfarbe then
  begin
    HSLColorPicker1.SelectedColor:=buttonfarbe.Color;
    mainform.devices[aktuellesgeraet].colors[listbox1.itemindex]:=buttonfarbe.Color;
  end;
end;

procedure Tcolormanagerform.Edit1Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(edit1.text)<0 then edit1.text:='0';
  if strtoint(edit1.text)>255 then edit1.text:='255';

  mainform.devices[aktuellesgeraet].colorlevels[Listbox1.itemindex]:=strtoint(edit1.text);
end;

procedure Tcolormanagerform.PngBitBtn1Click(Sender: TObject);
begin
  setlength(mainform.devices[aktuellesgeraet].colors,length(mainform.devices[aktuellesgeraet].colors)+1);
  setlength(mainform.devices[aktuellesgeraet].colorlevels,length(mainform.devices[aktuellesgeraet].colorlevels)+1);
  setlength(mainform.devices[aktuellesgeraet].colorendlevels,length(mainform.devices[aktuellesgeraet].colorendlevels)+1);
  setlength(mainform.devices[aktuellesgeraet].colornames,length(mainform.devices[aktuellesgeraet].colornames)+1);
  mainform.devices[aktuellesgeraet].colornames[length(mainform.devices[aktuellesgeraet].colornames)-1]:=_('Neue Farbe ')+inttostr(Listbox1.Items.Count+1);
  mainform.devices[aktuellesgeraet].colortolerance:=75;
  Listbox1.items.add(_('Neue Farbe ')+inttostr(Listbox1.Items.Count+1));
  listbox1.ItemIndex:=listbox1.Items.Count-1;
  listboxchange;
end;

procedure Tcolormanagerform.ListboxChange;
begin
  if mainform.devices[aktuellesgeraet].hasColor then
  begin
    if (listbox1.Items.Count>0) and (listbox1.itemindex>-1) then
    begin
      HSLColorPicker1.SelectedColor:=mainform.devices[aktuellesgeraet].colors[listbox1.itemindex];
      buttonfarbe.Color:=mainform.devices[aktuellesgeraet].colors[listbox1.itemindex];
      edit1.text:=inttostr(mainform.devices[aktuellesgeraet].colorlevels[listbox1.itemindex]);
      edit3.text:=inttostr(mainform.devices[aktuellesgeraet].colorendlevels[listbox1.itemindex]);
      edit2.text:=mainform.devices[aktuellesgeraet].colornames[listbox1.itemindex];
      combobox1.text:=inttostr(mainform.devices[aktuellesgeraet].colortolerance);

      edit1.Enabled:=true;
      edit2.Enabled:=true;
      edit3.Enabled:=true;
      combobox1.Enabled:=true;
      HSLColorPicker1.Enabled:=true;
      PngBitBtn2.Enabled:=true;
    end else
    begin
      edit1.Enabled:=false;
      edit2.Enabled:=false;
      edit3.Enabled:=false;
      combobox1.Enabled:=false;
      HSLColorPicker1.Enabled:=false;
      PngBitBtn2.Enabled:=false;
    end;
  end;

  if mainform.devices[aktuellesgeraet].hasColor2 then
  begin
    if (Listbox3.Items.Count>0) and (Listbox3.itemindex>-1) then
    begin
      HSLColorPicker2.SelectedColor:=mainform.devices[aktuellesgeraet].colors2[Listbox3.itemindex];
      buttonfarbe2.Color:=mainform.devices[aktuellesgeraet].colors2[Listbox3.itemindex];
      edit4.text:=inttostr(mainform.devices[aktuellesgeraet].colorlevels2[Listbox3.itemindex]);
      edit6.text:=inttostr(mainform.devices[aktuellesgeraet].colorendlevels2[Listbox3.itemindex]);
      edit5.text:=mainform.devices[aktuellesgeraet].colornames2[Listbox3.itemindex];
      combobox1.text:=inttostr(mainform.devices[aktuellesgeraet].colortolerance);

      edit4.Enabled:=true;
      edit5.Enabled:=true;
      edit6.Enabled:=true;
      combobox1.Enabled:=true;
      HSLColorPicker2.Enabled:=true;
      PngBitBtn4.Enabled:=true;
    end else
    begin
      edit4.Enabled:=false;
      edit5.Enabled:=false;
      edit6.Enabled:=false;
      combobox1.Enabled:=false;
      HSLColorPicker2.Enabled:=false;
      PngBitBtn4.Enabled:=false;
    end;
  end;
end;

procedure Tcolormanagerform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ListboxChange;
end;

procedure Tcolormanagerform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListboxChange;
end;

procedure Tcolormanagerform.Edit2Change(Sender: TObject);
begin
  if Sender=Edit2 then
  begin
    mainform.devices[aktuellesgeraet].colornames[Listbox1.itemindex]:=edit2.text;
    Listbox1.Items[Listbox1.itemindex]:=Edit2.Text;
  end;
end;

procedure Tcolormanagerform.PngBitBtn2Click(Sender: TObject);
begin
  if Listbox1.itemindex<length(mainform.Devices[aktuellesgeraet].colors)-1 then
  begin
    mainform.Devices[aktuellesgeraet].colors[Listbox1.itemindex]:=mainform.Devices[aktuellesgeraet].colors[length(mainform.Devices[aktuellesgeraet].colors)-1];
    mainform.Devices[aktuellesgeraet].colorlevels[Listbox1.itemindex]:=mainform.Devices[aktuellesgeraet].colorlevels[length(mainform.Devices[aktuellesgeraet].colorlevels)-1];
    mainform.Devices[aktuellesgeraet].colorendlevels[Listbox1.itemindex]:=mainform.Devices[aktuellesgeraet].colorendlevels[length(mainform.Devices[aktuellesgeraet].colorendlevels)-1];
    mainform.Devices[aktuellesgeraet].colornames[Listbox1.itemindex]:=mainform.Devices[aktuellesgeraet].colornames[length(mainform.Devices[aktuellesgeraet].colornames)-1];
  end;

  setlength(mainform.devices[aktuellesgeraet].colors,length(mainform.devices[aktuellesgeraet].colors)-1);
  setlength(mainform.devices[aktuellesgeraet].colorlevels,length(mainform.devices[aktuellesgeraet].colorlevels)-1);
  setlength(mainform.devices[aktuellesgeraet].colorendlevels,length(mainform.devices[aktuellesgeraet].colorendlevels)-1);
  setlength(mainform.devices[aktuellesgeraet].colornames,length(mainform.devices[aktuellesgeraet].colornames)-1);

  listbox1.DeleteSelected;
  ListboxChange;
end;

procedure Tcolormanagerform.ComboBox1Change(Sender: TObject);
begin
  mainform.devices[aktuellesgeraet].colortolerance:=strtoint(Combobox1.text);
end;

procedure Tcolormanagerform.BitBtn1Click(Sender: TObject);
var
  j:integer;
  tempstr:string;
  R,G,B:byte;
begin
  Opendialog1.InitialDir:=mainform.pcdimmerdirectory+'Devices';
  if Opendialog1.Execute then
  begin
      listbox2.Items.LoadFromFile(opendialog1.FileName);
      setlength(mainform.devices[aktuellesgeraet].colors,listbox2.Items.Count);
      setlength(mainform.devices[aktuellesgeraet].colorlevels,listbox2.Items.Count);
      setlength(mainform.devices[aktuellesgeraet].colorendlevels,listbox2.Items.Count);
      setlength(mainform.devices[aktuellesgeraet].colornames,listbox2.Items.Count);
      for j:=0 to listbox2.items.count-1 do
      begin
        tempstr:=listbox2.items[j];
        R:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        G:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        B:=strtoint(copy(tempstr,0,pos(',',tempstr)-1));
        mainform.devices[aktuellesgeraet].colors[j]:=R + G shl 8 + B shl 16;

        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        mainform.devices[aktuellesgeraet].colornames[j]:=copy(tempstr,0,pos(',',tempstr)-1);
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        mainform.devices[aktuellesgeraet].colorlevels[j]:=strtoint(tempstr);
        tempstr:=copy(tempstr,pos(',',tempstr)+1,length(tempstr));
        mainform.devices[aktuellesgeraet].colorendlevels[j]:=strtoint(tempstr);
      end;
      if listbox1.Items.Count>0 then 
        listbox1.Itemindex:=0;
      formshow(nil);
  end;
end;

procedure Tcolormanagerform.BitBtn3Click(Sender: TObject);
begin
if messagedlg(_('Alle Farbeinstellungen für das aktuelle Gerät entfernen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.devices[aktuellesgeraet].colors,0);
    setlength(mainform.devices[aktuellesgeraet].colorlevels,0);
    setlength(mainform.devices[aktuellesgeraet].colorendlevels,0);
    setlength(mainform.devices[aktuellesgeraet].colornames,0);
    setlength(mainform.devices[aktuellesgeraet].colors2,0);
    setlength(mainform.devices[aktuellesgeraet].colorlevels2,0);
    setlength(mainform.devices[aktuellesgeraet].colorendlevels2,0);
    setlength(mainform.devices[aktuellesgeraet].colornames2,0);
    listbox1.Items.Clear;
    listbox2.Items.Clear;
    listboxchange;
  end;
end;

procedure Tcolormanagerform.BitBtn2Click(Sender: TObject);
var
  i:integer;
  tempstr:string;
  R,G,B:byte;
begin
  Savedialog1.InitialDir:=mainform.pcdimmerdirectory+'Devices';
  if Savedialog1.Execute then
  begin
    listbox2.Items.Clear;
    for i:=0 to length(mainform.Devices[aktuellesgeraet].colors)-1 do
    begin
      tempstr:='';
      R := mainform.Devices[aktuellesgeraet].colors[i] and $FF;
      G := (mainform.Devices[aktuellesgeraet].colors[i] shr 8) and $FF;
      B := (mainform.Devices[aktuellesgeraet].colors[i] shr 16) and $FF;

      tempstr:=inttostr(R)+','+inttostr(G)+','+inttostr(B)+','+mainform.Devices[aktuellesgeraet].colornames[i]+','+inttostr(mainform.Devices[aktuellesgeraet].colorlevels[i])+','+inttostr(mainform.Devices[aktuellesgeraet].colorendlevels[i]);

      listbox2.Items.Add(tempstr);
    end;
    listbox2.Items.SaveToFile(savedialog1.FileName);
  end;
end;

procedure Tcolormanagerform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tcolormanagerform.Edit3Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(edit3.text)<0 then edit3.text:='0';
  if strtoint(edit3.text)>255 then edit3.text:='255';

  mainform.devices[aktuellesgeraet].colorendlevels[Listbox1.itemindex]:=strtoint(edit3.text);
end;

procedure Tcolormanagerform.PngBitBtn3Click(Sender: TObject);
begin
  setlength(mainform.devices[aktuellesgeraet].colors2,length(mainform.devices[aktuellesgeraet].colors2)+1);
  setlength(mainform.devices[aktuellesgeraet].colorlevels2,length(mainform.devices[aktuellesgeraet].colorlevels2)+1);
  setlength(mainform.devices[aktuellesgeraet].colorendlevels2,length(mainform.devices[aktuellesgeraet].colorendlevels2)+1);
  setlength(mainform.devices[aktuellesgeraet].colornames2,length(mainform.devices[aktuellesgeraet].colornames2)+1);
  mainform.devices[aktuellesgeraet].colornames2[length(mainform.devices[aktuellesgeraet].colornames2)-1]:=_('Neue Farbe ')+inttostr(Listbox3.Items.Count+1);
  Listbox3.items.add(_('Neue Farbe ')+inttostr(Listbox3.Items.Count+1));
  listbox3.ItemIndex:=listbox3.Items.Count-1;
  listboxchange;
end;

procedure Tcolormanagerform.PngBitBtn4Click(Sender: TObject);
begin
  if Listbox3.itemindex<length(mainform.Devices[aktuellesgeraet].colors2)-1 then
  begin
    mainform.Devices[aktuellesgeraet].colors2[Listbox3.itemindex]:=mainform.Devices[aktuellesgeraet].colors2[length(mainform.Devices[aktuellesgeraet].colors2)-1];
    mainform.Devices[aktuellesgeraet].colorlevels2[Listbox3.itemindex]:=mainform.Devices[aktuellesgeraet].colorlevels2[length(mainform.Devices[aktuellesgeraet].colorlevels2)-1];
    mainform.Devices[aktuellesgeraet].colorendlevels2[Listbox3.itemindex]:=mainform.Devices[aktuellesgeraet].colorendlevels2[length(mainform.Devices[aktuellesgeraet].colorendlevels2)-1];
    mainform.Devices[aktuellesgeraet].colornames2[Listbox3.itemindex]:=mainform.Devices[aktuellesgeraet].colornames2[length(mainform.Devices[aktuellesgeraet].colornames2)-1];
  end;

  setlength(mainform.devices[aktuellesgeraet].colors2,length(mainform.devices[aktuellesgeraet].colors2)-1);
  setlength(mainform.devices[aktuellesgeraet].colorlevels2,length(mainform.devices[aktuellesgeraet].colorlevels2)-1);
  setlength(mainform.devices[aktuellesgeraet].colorendlevels2,length(mainform.devices[aktuellesgeraet].colorendlevels2)-1);
  setlength(mainform.devices[aktuellesgeraet].colornames2,length(mainform.devices[aktuellesgeraet].colornames2)-1);

  listbox3.DeleteSelected;
  ListboxChange;
end;

procedure Tcolormanagerform.Edit4Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(edit4.text)<0 then edit4.text:='0';
  if strtoint(edit4.text)>255 then edit4.text:='255';

  mainform.devices[aktuellesgeraet].colorlevels2[Listbox3.itemindex]:=strtoint(edit4.text);
end;

procedure Tcolormanagerform.Edit6Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  if strtoint(edit6.text)<0 then edit6.text:='0';
  if strtoint(edit6.text)>255 then edit6.text:='255';

  mainform.devices[aktuellesgeraet].colorendlevels2[Listbox3.itemindex]:=strtoint(edit6.text);
end;

procedure Tcolormanagerform.Edit5Change(Sender: TObject);
begin
  if Sender=Edit5 then
  begin
    mainform.devices[aktuellesgeraet].colornames2[Listbox3.itemindex]:=edit5.text;
    Listbox3.Items[Listbox3.itemindex]:=Edit5.Text;
  end;
end;

procedure Tcolormanagerform.HSLColorPicker2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    buttonfarbe2.Color:=HSLColorPicker2.SelectedColor;
    mainform.devices[aktuellesgeraet].colors2[listbox3.itemindex]:=buttonfarbe2.Color;
  end;
end;

procedure Tcolormanagerform.CreateParams(var Params:TCreateParams);
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
