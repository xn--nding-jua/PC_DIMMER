unit datainevent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, CheckLst, PngBitBtn, ExtCtrls, gnugettext,
  pngimage, JvExControls, JvGradient;

type
  Tdataineventfrm = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Panel6: TPanel;
    GroupBox1: TGroupBox;
    DataGrid: TStringGrid;
    Panel5: TPanel;
    okbtn: TButton;
    Panel7: TPanel;
    adddatainevent: TPngBitBtn;
    editdatainevent: TPngBitBtn;
    deletedatainevent: TPngBitBtn;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    upBtn: TPngBitBtn;
    downBtn: TPngBitBtn;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel15: TPanel;
    Listbox1: TCheckListBox;
    CheckListBox1: TCheckListBox;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Label1: TLabel;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    lastdatainchannel: TLabel;
    lastdatainvalue: TLabel;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    Panel12: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Button4: TButton;
    Panel21: TPanel;
    ListBox2: TCheckListBox;
    CheckListBox2: TCheckListBox;
    Panel22: TPanel;
    Label5: TLabel;
    Panel23: TPanel;
    Panel24: TPanel;
    Timer1: TTimer;
    Button1: TButton;
    Button3: TButton;
    Panel25: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
		procedure refreshList(line: integer);
    procedure editdataineventClick(Sender: TObject);
    procedure adddataineventClick(Sender: TObject);
    procedure deletedataineventClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataGridDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure CheckListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure checklistbox;
    procedure checklistboxb;
    procedure Listbox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure upBtnClick(Sender: TObject);
    procedure downBtnClick(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
    procedure ListBox2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Listbox1Click(Sender: TObject);
    procedure Listbox1ClickCheck(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2ClickCheck(Sender: TObject);
    procedure DataGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DataGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure FlipEntry(Source, Destination:integer);
  public
    { Public-Deklarationen }
    lastdatainaddress:integer;
    lastdatainendvalue:integer;
  end;

var
  dataineventfrm: Tdataineventfrm;

implementation

uses pcdimmer, editdatainevent;

{$R *.dfm}

procedure Tdataineventfrm.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
	DataGrid.Cells[0,0]:=_('Name');
	DataGrid.Cells[1,0]:=_('Beschreibung');
	DataGrid.Cells[2,0]:=_('Kanal');
  DataGrid.cells[3,0]:=_('Wert');
  DataGrid.cells[4,0]:=_('Typ');
  DataGrid.cells[5,0]:=_('Wert1');
  DataGrid.cells[6,0]:=_('Wert2');
  DataGrid.cells[7,0]:=_('Wert3');
  DataGrid.cells[8,0]:=_('Unten');
  DataGrid.cells[9,0]:=_('Ein');
  DataGrid.cells[10,0]:=_('Oben');
  DataGrid.cells[11,0]:=_('Aktuell');
  DataGrid.ColWidths[0]:=75;
  DataGrid.ColWidths[1]:=75;
  DataGrid.ColWidths[2]:=40;
  DataGrid.ColWidths[3]:=40;
  DataGrid.ColWidths[4]:=200;
  DataGrid.ColWidths[5]:=45;
  DataGrid.ColWidths[6]:=45;
  DataGrid.ColWidths[7]:=45;
  DataGrid.ColWidths[8]:=35;
  DataGrid.ColWidths[9]:=35;
  DataGrid.ColWidths[10]:=35;
  DataGrid.ColWidths[11]:=45;
  DataGrid.cells[0,1]:='-';
  DataGrid.cells[1,1]:='-';
  DataGrid.cells[2,1]:='-';
  DataGrid.cells[3,1]:='-';
  DataGrid.cells[4,1]:='-';
  DataGrid.cells[5,1]:='-';
  DataGrid.cells[6,1]:='-';
  DataGrid.cells[7,1]:='-';
  DataGrid.cells[8,1]:='-';
  DataGrid.cells[9,1]:='-';
  DataGrid.cells[10,1]:='-';
  DataGrid.cells[11,1]:='-';
end;

procedure Tdataineventfrm.refreshList(line: integer);
var
  i,j:integer;
  text:string;
begin
  DataGrid.cells[0,line]:=mainform.dataineventArray[line-1].Befehl.Name;	// Name
  DataGrid.cells[1,line]:=mainform.dataineventArray[line-1].Befehl.Beschreibung;	// Beschreibung
  DataGrid.cells[2,line]:=inttostr(mainform.dataineventArray[line-1].Channel);	// Kanal
  DataGrid.cells[3,line]:=inttostr(mainform.dataineventArray[line-1].Value);	// Wert

  for i:=0 to length(mainform.Befehlssystem)-1 do
  begin
    for j:=0 to length(mainform.Befehlssystem[i].Steuerung)-1 do
    begin
      if IsEqualGUID(mainform.Befehlssystem[i].Steuerung[j].GUID, mainform.DataInEventArray[line-1].Befehl.Typ) then
      begin
        DATAGrid.cells[4,line]:=mainform.Befehlssystem[i].Programmteil+': '+mainform.Befehlssystem[i].Steuerung[j].Bezeichnung;
        if length(mainform.DataInEventArray[line-1].Befehl.ArgGUID)>0 then
        begin
          mainform.GetInfo(mainform.DataInEventArray[line-1].Befehl.ArgGUID[0], text);
          if text<>'' then
            DATAGrid.cells[4,line]:=DATAGrid.cells[4,line]+' ('+text+')';
        end;
        break;
      end;
    end;
  end;

  if length(mainform.dataineventArray[line-1].Befehl.ArgInteger)>0 then
		DataGrid.cells[5,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.ArgInteger[0]);	// Wert1
  if length(mainform.dataineventArray[line-1].Befehl.ArgInteger)>1 then
		DataGrid.cells[6,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.ArgInteger[1]);	// Wert2
  if length(mainform.dataineventArray[line-1].Befehl.ArgInteger)>2 then
		DataGrid.cells[7,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.ArgInteger[2]);	// Wert3

  DataGrid.cells[8,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.OffValue);
  DataGrid.cells[9,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.SwitchValue);
  DataGrid.cells[10,line]:=inttostr(mainform.dataineventArray[line-1].Befehl.OnValue);
end;

procedure Tdataineventfrm.editdataineventClick(Sender: TObject);
var
  i:integer;
begin
	// Werte an EditForm übergeben
	Editdataineventfrm.Message1a.text:=inttostr(mainform.dataineventArray[DataGrid.row-1].Channel);
	Editdataineventfrm.Data1a.text:=inttostr(mainform.dataineventArray[DataGrid.row-1].Value);

  EditDATAINEVENTfrm.AktuellerBefehl.Typ:=mainform.DatainEventArray[DataGrid.row-1].Befehl.Typ;
  EditDATAINEVENTfrm.AktuellerBefehl.Name:=mainform.DatainEventArray[DataGrid.row-1].Befehl.Name;
  EditDATAINEVENTfrm.AktuellerBefehl.Beschreibung:=mainform.DatainEventArray[DataGrid.row-1].Befehl.Beschreibung;
  EditDATAINEVENTfrm.AktuellerBefehl.OnValue:=mainform.DatainEventArray[DataGrid.row-1].Befehl.OnValue;
  EditDATAINEVENTfrm.AktuellerBefehl.SwitchValue:=mainform.DatainEventArray[DataGrid.row-1].Befehl.SwitchValue;
  EditDATAINEVENTfrm.AktuellerBefehl.InvertSwitchValue:=mainform.DatainEventArray[DataGrid.row-1].Befehl.InvertSwitchValue;
  EditDATAINEVENTfrm.AktuellerBefehl.OffValue:=mainform.DatainEventArray[DataGrid.row-1].Befehl.OffValue;
  EditDATAINEVENTfrm.AktuellerBefehl.ScaleValue:=mainform.DatainEventArray[DataGrid.row-1].Befehl.ScaleValue;
  setlength(EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger, length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger)-1 do
    EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger[i]:=mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger[i];
  setlength(EditDATAINEVENTfrm.AktuellerBefehl.ArgString, length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString));
  for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString)-1 do
    EditDATAINEVENTfrm.AktuellerBefehl.ArgString[i]:=mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString[i];
  setlength(EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID, length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID)-1 do
    EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID[i]:=mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGuid[i];

	// Editform anzeigen
	Editdataineventfrm.Showmodal;

	// Werte bei "OK" in Array kopieren und Liste aktualisieren
	if Editdataineventfrm.modalresult=mrOK then
	begin
		mainform.dataineventArray[DataGrid.row-1].Channel := strtoint(Editdataineventfrm.Message1a.text);
		mainform.dataineventArray[DataGrid.row-1].Value := strtoint(Editdataineventfrm.Data1a.text);

    mainform.DatainEventArray[DataGrid.row-1].Befehl.Typ:=EditDATAINEVENTfrm.AktuellerBefehl.Typ;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.Name:=EditDATAINEVENTfrm.AktuellerBefehl.Name;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.Beschreibung:=EditDATAINEVENTfrm.AktuellerBefehl.Beschreibung;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.OnValue:=EditDATAINEVENTfrm.AktuellerBefehl.OnValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.SwitchValue:=EditDATAINEVENTfrm.AktuellerBefehl.SwitchValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.InvertSwitchValue:=EditDATAINEVENTfrm.AktuellerBefehl.InvertSwitchValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.OffValue:=EditDATAINEVENTfrm.AktuellerBefehl.OffValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.ScaleValue:=EditDATAINEVENTfrm.AktuellerBefehl.ScaleValue;
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger[i];
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgString));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgString[i];
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGuid[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID[i];

		refreshList(DataGrid.row);
	end;
end;

procedure Tdataineventfrm.adddataineventClick(Sender: TObject);
var
  i:integer;
begin
	// EditForm zurücksetzen
	Editdataineventfrm.Message1a.text:='0';
	Editdataineventfrm.Data1a.text:='0';

  Editdataineventfrm.AktuellerBefehl.Name:='DataIn-Event';
  Editdataineventfrm.AktuellerBefehl.Beschreibung:='';
  Editdataineventfrm.AktuellerBefehl.OnValue:=255;
  Editdataineventfrm.AktuellerBefehl.SwitchValue:=128;
  Editdataineventfrm.AktuellerBefehl.OffValue:=0;
  Editdataineventfrm.AktuellerBefehl.ScaleValue:=false;

	// EditForm anzeigen
	Editdataineventfrm.Showmodal;

	// Array um eine Position verlängern und Werte aus EditForm in Array kopieren und Liste aktualisieren
	if Editdataineventfrm.modalresult=mrOK then
	begin
		setlength(mainform.dataineventArray,length(mainform.dataineventArray)+1);
    if not ((DataGrid.rowcount-1)=length(mainform.dataineventArray)) then
		begin
    	DataGrid.rowcount:=DataGrid.rowcount+1;
      DataGrid.RowHeights[DataGrid.rowcount-1]:=15;
    end;
		DataGrid.row:=DataGrid.rowcount-1;
    CreateGUID(mainform.dataineventArray[DataGrid.row-1].ID);
		mainform.dataineventArray[DataGrid.row-1].Channel := strtoint(Editdataineventfrm.Message1a.text);
		mainform.dataineventArray[DataGrid.row-1].Value := strtoint(Editdataineventfrm.Data1a.text);

    mainform.DatainEventArray[DataGrid.row-1].Befehl.Typ:=EditDATAINEVENTfrm.AktuellerBefehl.Typ;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.Name:=EditDATAINEVENTfrm.AktuellerBefehl.Name;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.Beschreibung:=EditDATAINEVENTfrm.AktuellerBefehl.Beschreibung;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.OnValue:=EditDATAINEVENTfrm.AktuellerBefehl.OnValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.SwitchValue:=EditDATAINEVENTfrm.AktuellerBefehl.SwitchValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.InvertSwitchValue:=EditDATAINEVENTfrm.AktuellerBefehl.InvertSwitchValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.OffValue:=EditDATAINEVENTfrm.AktuellerBefehl.OffValue;
    mainform.DatainEventArray[DataGrid.row-1].Befehl.ScaleValue:=EditDATAINEVENTfrm.AktuellerBefehl.ScaleValue;
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgInteger[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgInteger[i];
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgString));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgString[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgString[i];
    setlength(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID, length(EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID));
    for i:=0 to length(mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGUID)-1 do
      mainform.DatainEventArray[DataGrid.row-1].Befehl.ArgGuid[i]:=EditDATAINEVENTfrm.AktuellerBefehl.ArgGUID[i];

   	deletedatainevent.Enabled:=true;
    editdatainevent.Enabled:=true;

		refreshList(DataGrid.row);
	end;
end;

procedure Tdataineventfrm.deletedataineventClick(Sender: TObject);
var
	i,k:integer;
begin
	// Ab aktueller Position alle nachfolgenden Einträge um eins nach oben kopieren
	for i:=DataGrid.row to DataGrid.rowcount-2 do
	begin
//		for j:=1 to 7 do
		begin
      mainform.dataineventArray[i-1].ID:=mainform.dataineventArray[i].ID;
      mainform.dataineventArray[i-1].Channel:=mainform.dataineventArray[i].Channel;
      mainform.dataineventArray[i-1].Value:=mainform.dataineventArray[i].Value;
      mainform.dataineventArray[i-1].Typ:=mainform.dataineventArray[i].Typ;
      mainform.dataineventArray[i-1].Wert1:=mainform.dataineventArray[i].Wert1;
      mainform.dataineventArray[i-1].Wert2:=mainform.dataineventArray[i].Wert2;
      mainform.dataineventArray[i-1].Arg3:=mainform.dataineventArray[i].Arg3;

      mainform.dataineventArray[i-1].Befehl.ID:=mainform.dataineventArray[i].Befehl.ID;
      mainform.dataineventArray[i-1].Befehl.Typ:=mainform.dataineventArray[i].Befehl.Typ;
      mainform.dataineventArray[i-1].Befehl.Name:=mainform.dataineventArray[i].Befehl.Name;
      mainform.dataineventArray[i-1].Befehl.Beschreibung:=mainform.dataineventArray[i].Befehl.Beschreibung;
      mainform.dataineventArray[i-1].Befehl.OnValue:=mainform.dataineventArray[i].Befehl.OnValue;
      mainform.dataineventArray[i-1].Befehl.SwitchValue:=mainform.dataineventArray[i].Befehl.SwitchValue;
      mainform.dataineventArray[i-1].Befehl.InvertSwitchValue:=mainform.dataineventArray[i].Befehl.InvertSwitchValue;
      mainform.dataineventArray[i-1].Befehl.OffValue:=mainform.dataineventArray[i].Befehl.OffValue;
      mainform.dataineventArray[i-1].Befehl.ScaleValue:=mainform.dataineventArray[i].Befehl.ScaleValue;

      setlength(mainform.dataineventArray[i-1].Befehl.ArgInteger,length(mainform.dataineventArray[i].Befehl.ArgInteger));
      setlength(mainform.dataineventArray[i-1].Befehl.ArgString,length(mainform.dataineventArray[i].Befehl.ArgString));
      setlength(mainform.dataineventArray[i-1].Befehl.ArgGUID,length(mainform.dataineventArray[i].Befehl.ArgGUID));

      for k:=0 to length(mainform.dataineventArray[i-1].Befehl.ArgInteger)-1 do
      begin
        mainform.dataineventArray[i-1].Befehl.ArgInteger[k]:=mainform.dataineventArray[i].Befehl.ArgInteger[k];
      end;
      for k:=0 to length(mainform.dataineventArray[i-1].Befehl.ArgString)-1 do
      begin
        mainform.dataineventArray[i-1].Befehl.ArgString[k]:=mainform.dataineventArray[i].Befehl.ArgString[k];
      end;
      for k:=0 to length(mainform.dataineventArray[i-1].Befehl.ArgGUID)-1 do
      begin
        mainform.dataineventArray[i-1].Befehl.ArgGUID[k]:=mainform.dataineventArray[i].Befehl.ArgGUID[k];
      end;
    end;
	end;

	// Letzten Eintrag löschen
	setlength(mainform.dataineventArray,length(mainform.dataineventArray)-1);

  if DataGrid.RowCount>2 then
	begin
  	DataGrid.rowcount:=DataGrid.rowcount-1;
		// komplette Liste aktualisieren
		for i:=1 to DataGrid.rowcount-1 do
		begin
			refreshList(i);
		end;
	end else
  begin
		DataGrid.cells[0,1]:='-';
		DataGrid.cells[1,1]:='-';
		DataGrid.cells[2,1]:='-';
		DataGrid.cells[3,1]:='-';
		DataGrid.cells[4,1]:='-';
		DataGrid.cells[5,1]:='-';
		DataGrid.cells[6,1]:='-';
		DataGrid.cells[7,1]:='-';
		DataGrid.cells[8,1]:='-';
    DataGrid.cells[9,1]:='-';
    DataGrid.cells[10,1]:='-';
    DataGrid.cells[11,1]:='-';

  	deletedatainevent.Enabled:=false;
    editdatainevent.Enabled:=false;
  end;
end;

procedure Tdataineventfrm.FormShow(Sender: TObject);
var
  i,j:integer;
begin
  DataGrid.RowHeights[0]:=15;

  Listbox1.Items.Clear;
  CheckListbox1.Items.Clear;
  Listbox2.Items.Clear;
  CheckListbox2.Items.Clear;
  for i:=1 to mainform.lastchan do
  begin
//    Listbox1.items.Add(inttostr(i)+' - '+mainform.data.names[i]);
//    CheckListbox1.Items.Add(inttostr(i)+' - '+mainform.data.names[i]);
    Listbox1.items.Add(inttostr(i));
    CheckListbox1.Items.Add(inttostr(i));

    Listbox2.items.Add(inttostr(i));
    CheckListbox2.Items.Add(inttostr(i));
  end;
  Listbox1.ItemIndex:=0;
  Listbox2.ItemIndex:=0;

  for i:=0 to length(mainform.Softpatch)-1 do
  begin
    // Alle Softpatch-Kanäle markieren
    listbox1.Checked[mainform.Softpatch[i].Channel-1]:=true;
    if mainform.Softpatch[i].Channel-1=0 then
    begin
      for j:=0 to length(mainform.Softpatch[i].RouteToInputChan)-1 do
      begin
        Checklistbox1.Checked[mainform.Softpatch[i].RouteToInputChan[j]-1]:=true;
      end;
    end;
  end;

  for i:=0 to length(mainform.Softpatch2)-1 do
  begin
    // Alle Softpatch-Kanäle markieren
    listbox2.Checked[mainform.Softpatch2[i].Channel2-1]:=true;
    if mainform.Softpatch2[i].Channel2-1=0 then
    begin
      for j:=0 to length(mainform.Softpatch2[i].RouteToPC_DIMMERChan)-1 do
      begin
        Checklistbox2.Checked[mainform.Softpatch2[i].RouteToPC_DIMMERChan[j]-1]:=true;
      end;
    end;
  end;

  upBtn.enabled:=DataGrid.Row>1;
  downBtn.enabled:=DataGrid.Row<DataGrid.RowCount-1;
  Timer1.enabled:=true;
end;

procedure Tdataineventfrm.DataGridDblClick(Sender: TObject);
begin
	if editdatainevent.Enabled then
  	editdataineventClick(Sender);
end;

procedure Tdataineventfrm.SpeedButton3Click(Sender: TObject);
begin
if messagedlg(_('Möchten Sie wirklich alle DataIn-Events löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
	  DataGrid.RowCount:=2;
		setlength(mainform.dataineventArray,0);

		DataGrid.cells[0,1]:='-';
		DataGrid.cells[1,1]:='-';
		DataGrid.cells[2,1]:='-';
		DataGrid.cells[3,1]:='-';
		DataGrid.cells[4,1]:='-';
		DataGrid.cells[5,1]:='-';
		DataGrid.cells[6,1]:='-';
		DataGrid.cells[7,1]:='-';
		DataGrid.cells[8,1]:='-';
		DataGrid.cells[9,1]:='-';
		DataGrid.cells[10,1]:='-';
		DataGrid.cells[11,1]:='-';
   	deletedatainevent.Enabled:=false;
	  editdatainevent.Enabled:=false;
	end;
end;

procedure Tdataineventfrm.SpeedButton2Click(Sender: TObject);
var
  i,j,FileVersion,startindex,Count,Count2:integer;
  additiv:boolean;
//  FileStream:TFileStream;
begin
  additiv:=true;

	case mainform.mymessagedlg(_('Wie sollen die DataIn-Einstellungen aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog1.Execute then
  begin
    if additiv then
    begin
      // Hinzufügen
      startindex:=length(mainform.dataineventArray)-1;
      with mainform do
      begin
        FileStream:=TFileStream.Create(OpenDialog1.Filename,fmOpenRead);

        Filestream.ReadBuffer(FileVersion,sizeof(FileVersion));
        if FileVersion>=477 then
        begin
          Filestream.ReadBuffer(Count,sizeof(Count));
        end else
        begin
          Count:=FileVersion; // old format has only number of elements here
        end;

        setlength(DatainEventArray,Count+startindex+1);
        for i:=startindex+1 to length(DatainEventArray)-1 do
        begin
          Filestream.ReadBuffer(DatainEventArray[i].ID,sizeof(DatainEventArray[i].ID));
          Filestream.ReadBuffer(DatainEventArray[i].Channel,sizeof(DatainEventArray[i].Channel));
          Filestream.ReadBuffer(DatainEventArray[i].Value,sizeof(DatainEventArray[i].Value));

          Filestream.ReadBuffer(DatainEventArray[i].Befehl.Typ,sizeof(DatainEventArray[i].Befehl.Typ));
          if FileVersion>477 then
          begin
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.Name,sizeof(DatainEventArray[i].Befehl.Name));
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.Beschreibung,sizeof(DatainEventArray[i].Befehl.Beschreibung));
          end;
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.OnValue,sizeof(DatainEventArray[i].Befehl.OnValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.SwitchValue,sizeof(DatainEventArray[i].Befehl.SwitchValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.InvertSwitchValue,sizeof(DatainEventArray[i].Befehl.InvertSwitchValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.OffValue,sizeof(DatainEventArray[i].Befehl.OffValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.ScaleValue,sizeof(DatainEventArray[i].Befehl.ScaleValue));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgInteger,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgInteger[j],sizeof(DatainEventArray[i].Befehl.ArgInteger[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgString,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgString[j],sizeof(DatainEventArray[i].Befehl.ArgString[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgGUID,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgGUID[j],sizeof(DatainEventArray[i].Befehl.ArgGUID[j]));
        end;
        Filestream.Free;
      end;
    end else
    begin
      // Ersetzen
      with mainform do
      begin
        FileStream:=TFileStream.Create(OpenDialog1.Filename,fmOpenRead);

        Filestream.ReadBuffer(FileVersion,sizeof(FileVersion));
        if FileVersion>=477 then
        begin
          Filestream.ReadBuffer(Count,sizeof(Count));
        end else
        begin
          Count:=FileVersion; // old format has only number of elements here
        end;

        setlength(DatainEventArray,Count);
        for i:=0 to length(DatainEventArray)-1 do
        begin
          Filestream.ReadBuffer(DatainEventArray[i].ID,sizeof(DatainEventArray[i].ID));
          Filestream.ReadBuffer(DatainEventArray[i].Channel,sizeof(DatainEventArray[i].Channel));
          Filestream.ReadBuffer(DatainEventArray[i].Value,sizeof(DatainEventArray[i].Value));

          Filestream.ReadBuffer(DatainEventArray[i].Befehl.Typ,sizeof(DatainEventArray[i].Befehl.Typ));
          if FileVersion>477 then
          begin
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.Name,sizeof(DatainEventArray[i].Befehl.Name));
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.Beschreibung,sizeof(DatainEventArray[i].Befehl.Beschreibung));
          end;
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.OnValue,sizeof(DatainEventArray[i].Befehl.OnValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.SwitchValue,sizeof(DatainEventArray[i].Befehl.SwitchValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.InvertSwitchValue,sizeof(DatainEventArray[i].Befehl.InvertSwitchValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.OffValue,sizeof(DatainEventArray[i].Befehl.OffValue));
          Filestream.ReadBuffer(DatainEventArray[i].Befehl.ScaleValue,sizeof(DatainEventArray[i].Befehl.ScaleValue));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgInteger,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgInteger[j],sizeof(DatainEventArray[i].Befehl.ArgInteger[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgString,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgString[j],sizeof(DatainEventArray[i].Befehl.ArgString[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(DatainEventArray[i].Befehl.ArgGUID,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(DatainEventArray[i].Befehl.ArgGUID[j],sizeof(DatainEventArray[i].Befehl.ArgGUID[j]));
        end;
        Filestream.Free;
      end;
    end;

    if length(mainform.dataineventArray)>0 then
    begin
      editdatainevent.Enabled:=true;
      deletedatainevent.Enabled:=true;
    end else
    begin
      editdatainevent.Enabled:=false;
      deletedatainevent.Enabled:=false;
    end;
	end;

  // komplette Liste aktualisieren
  DataGrid.RowCount:=length(mainform.DatainEventArray)+1;
  for i:=1 to DataGrid.rowcount-1 do
  begin
    refreshList(i);
  end;
end;

procedure Tdataineventfrm.SpeedButton1Click(Sender: TObject);
var
  i,j,Count,Count2:integer;
//  FileStream:TFilestream;
begin
  with mainform do
	if SaveDialog1.Execute then
  begin
    FileStream:=TFilestream.Create(SaveDialog1.Filename, fmCreate);
    Count:=length(DataInEventArray);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
      Filestream.WriteBuffer(DatainEventArray[i].ID,sizeof(DatainEventArray[i].ID));
      Filestream.WriteBuffer(DataInEventArray[i].Channel,sizeof(DataInEventArray[i].Channel));
      Filestream.WriteBuffer(DataInEventArray[i].Value,sizeof(DataInEventArray[i].Value));

      Filestream.WriteBuffer(DatainEventArray[i].Befehl.Typ,sizeof(DatainEventArray[i].Befehl.Typ));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.Name,sizeof(DatainEventArray[i].Befehl.Name));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.Beschreibung,sizeof(DatainEventArray[i].Befehl.Beschreibung));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.OnValue,sizeof(DatainEventArray[i].Befehl.OnValue));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.SwitchValue,sizeof(DatainEventArray[i].Befehl.SwitchValue));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.InvertSwitchValue,sizeof(DatainEventArray[i].Befehl.InvertSwitchValue));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.OffValue,sizeof(DatainEventArray[i].Befehl.OffValue));
      Filestream.WriteBuffer(DatainEventArray[i].Befehl.ScaleValue,sizeof(DatainEventArray[i].Befehl.ScaleValue));
      Count2:=length(DatainEventArray[i].Befehl.ArgInteger);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(DatainEventArray[i].Befehl.ArgInteger[j],sizeof(DatainEventArray[i].Befehl.ArgInteger[j]));
      Count2:=length(DatainEventArray[i].Befehl.ArgString);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(DatainEventArray[i].Befehl.ArgString[j],sizeof(DatainEventArray[i].Befehl.ArgString[j]));
      Count2:=length(DatainEventArray[i].Befehl.ArgGUID);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(DatainEventArray[i].Befehl.ArgGUID[j],sizeof(DatainEventArray[i].Befehl.ArgGUID[j]));
    end;
    FileStream.Free;
  end;
end;

procedure Tdataineventfrm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrOk;
end;

procedure Tdataineventfrm.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  checklistbox;
end;

procedure Tdataineventfrm.Button2Click(Sender: TObject);
var
  i:integer;
begin
  if messagedlg(_('Möchten Sie wirklich das gesamte Patchfeld der PC_DIMMER-Kanäle löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to listbox1.Items.Count-1 do
      Listbox1.Checked[i]:=false;

    setlength(mainform.Softpatch,0);

    checklistbox;
  end;
end;

procedure Tdataineventfrm.CheckListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.Softpatch)-1 do
  begin
    if mainform.Softpatch[i].Channel=Listbox1.ItemIndex+1 then
    begin
      // Richtiges Softpatch gefunden
      setlength(mainform.Softpatch[i].RouteToInputChan,0);

      for j:=0 to CheckListbox1.Items.Count-1 do
      begin
        if checklistbox1.Checked[j] then
        begin
          // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
          setlength(mainform.Softpatch[i].RouteToInputChan,length(mainform.Softpatch[i].RouteToInputChan)+1);
          mainform.Softpatch[i].RouteToInputChan[length(mainform.Softpatch[i].RouteToInputChan)-1]:=j+1;
        end;
      end;
    end;
  end;
end;

procedure Tdataineventfrm.checklistbox;
var
  i,j,k:integer;
  channelexists:boolean;
  position:integer;
begin
  position:=0;

  if Listbox1.Checked[listbox1.ItemIndex] then
  begin
    // Aktueller Kanal ist aktiviert
    // Herausfinden, ob der Kanal bereits im Array vorhanden ist
    channelexists:=false;
    for i:=0 to length(mainform.Softpatch)-1 do
    begin
      if mainform.Softpatch[i].Channel=listbox1.ItemIndex+1 then
      begin
        channelexists:=true;
        position:=i;
      end;
    end;
    if not channelexists then
    begin
      // Kanal existiert noch nicht, also hinzufügen
      setlength(mainform.Softpatch, length(mainform.Softpatch)+1);
      mainform.Softpatch[length(mainform.Softpatch)-1].Channel:=listbox1.ItemIndex+1;
      for j:=0 to length(mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan)-1 do
      begin
        for k:=0 to Checklistbox1.Items.Count-1 do
          Checklistbox1.Checked[k]:=(k+1=mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan[j]);
      end;
    end else
    begin
      // Alle Markierungen auf der rechten Seite löschen
      for k:=0 to Checklistbox1.Items.Count-1 do
        Checklistbox1.Checked[k]:=false;

      // Selektionen in rechter Box anzeigen
      for j:=0 to length(mainform.Softpatch[position].RouteToInputChan)-1 do
      begin
        for k:=0 to Checklistbox1.Items.Count-1 do
          if (k+1=mainform.Softpatch[position].RouteToInputChan[j]) then
            Checklistbox1.Checked[k]:=true;
      end;
    end;
  end else
  begin
    // Aktueller Kanal nicht selektiert
    // Herausfinden, ob der Kanal bereits im Array gelöscht wurde
    channelexists:=false;
    for i:=0 to length(mainform.Softpatch)-1 do
    begin
      if mainform.Softpatch[i].Channel=listbox1.ItemIndex+1 then
      begin
        channelexists:=true;
        position:=i;
      end;
    end;
    if channelexists then
    begin
      // Kanal existiert noch, also löschen (letzte Arrayposition auf aktuelle und letzte löschen)
      // Letzte Arrayposition auf aktuelle Position kopieren
      mainform.Softpatch[position].Channel:=mainform.Softpatch[length(mainform.Softpatch)-1].Channel;
      setlength(mainform.Softpatch[position].RouteToInputChan,length(mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan));
      for i:=0 to length(mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan)-1 do
      begin
        mainform.Softpatch[position].RouteToInputChan[i]:=mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan[i];
      end;
      // Letzte Arrayposition löschen
      setlength(mainform.Softpatch,length(mainform.Softpatch)-1);
    end;

    // Alle Markierungen auf der rechten Seite löschen
    for k:=0 to Checklistbox1.Items.Count-1 do
      Checklistbox1.Checked[k]:=false;
  end;

  Checklistbox1.enabled:=Listbox1.Checked[listbox1.ItemIndex];
  Button1.Enabled:=Listbox1.Checked[listbox1.ItemIndex];
end;

procedure Tdataineventfrm.checklistboxb;
var
  i,j,k:integer;
  channelexists:boolean;
  position:integer;
begin
  position:=0;

  if Listbox2.Checked[Listbox2.ItemIndex] then
  begin
    // Aktueller Kanal ist aktiviert
    // Herausfinden, ob der Kanal bereits im Array vorhanden ist
    channelexists:=false;
    for i:=0 to length(mainform.Softpatch2)-1 do
    begin
      if mainform.Softpatch2[i].Channel2=Listbox2.ItemIndex+1 then
      begin
        channelexists:=true;
        position:=i;
      end;
    end;
    if not channelexists then
    begin
      // Kanal existiert noch nicht, also hinzufügen
      setlength(mainform.softpatch2, length(mainform.softpatch2)+1);
      mainform.softpatch2[length(mainform.softpatch2)-1].Channel2:=listbox2.ItemIndex+1;
      for j:=0 to length(mainform.softpatch2[length(mainform.softpatch2)-1].RouteToPC_DIMMERChan)-1 do
      begin
        for k:=0 to Checklistbox2.Items.Count-1 do
          Checklistbox2.Checked[k]:=(k+1=mainform.softpatch2[length(mainform.softpatch2)-1].RouteToPC_DIMMERChan[j]);
      end;
    end else
    begin
      // Alle Markierungen auf der rechten Seite löschen
      for k:=0 to Checklistbox2.Items.Count-1 do
        Checklistbox2.Checked[k]:=false;

      // Selektionen in rechter Box anzeigen
      for j:=0 to length(mainform.softpatch2[position].RouteToPC_DIMMERChan)-1 do
      begin
        for k:=0 to Checklistbox2.Items.Count-1 do
          if (k+1=mainform.softpatch2[position].RouteToPC_DIMMERChan[j]) then
            Checklistbox2.Checked[k]:=true;
      end;
    end;
  end else
  begin
    // Aktueller Kanal nicht selektiert
    // Herausfinden, ob der Kanal bereits im Array gelöscht wurde
    channelexists:=false;
    for i:=0 to length(mainform.softpatch2)-1 do
    begin
      if mainform.softpatch2[i].Channel2=listbox2.ItemIndex+1 then
      begin
        channelexists:=true;
        position:=i;
      end;
    end;
    if channelexists then
    begin
      // Kanal existiert noch, also löschen (letzte Arrayposition auf aktuelle und letzte löschen)
      // Letzte Arrayposition auf aktuelle Position kopieren
      mainform.softpatch2[position].Channel2:=mainform.softpatch2[length(mainform.softpatch2)-1].Channel2;
      setlength(mainform.softpatch2[position].RouteToPC_DIMMERChan,length(mainform.softpatch2[length(mainform.softpatch2)-1].RouteToPC_DIMMERChan));
      for i:=0 to length(mainform.softpatch2[length(mainform.softpatch2)-1].RouteToPC_DIMMERChan)-1 do
      begin
        mainform.softpatch2[position].RouteToPC_DIMMERChan[i]:=mainform.softpatch2[length(mainform.softpatch2)-1].RouteToPC_DIMMERChan[i];
      end;
      // Letzte Arrayposition löschen
      setlength(mainform.softpatch2,length(mainform.softpatch2)-1);
    end;

    // Alle Markierungen auf der rechten Seite löschen
    for k:=0 to Checklistbox2.Items.Count-1 do
      Checklistbox2.Checked[k]:=false;
  end;

  Checklistbox2.enabled:=Listbox2.Checked[Listbox2.ItemIndex];
  Button3.Enabled:=Listbox2.Checked[Listbox2.ItemIndex];
end;

procedure Tdataineventfrm.Listbox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j:integer;
begin
  checklistbox;

  if (key=vk_space) and Listbox1.Checked[Listbox1.ItemIndex] then
  begin
    CheckListbox1.itemindex:=Listbox1.ItemIndex;
    CheckListbox1.Checked[CheckListbox1.itemindex]:=true;

    for i:=0 to length(mainform.Softpatch)-1 do
    begin
      if mainform.Softpatch[i].Channel=Listbox1.ItemIndex+1 then
      begin
        // Richtiges Softpatch gefunden
        setlength(mainform.Softpatch[i].RouteToInputChan,0);

        for j:=0 to CheckListbox1.Items.Count-1 do
        begin
          if checklistbox1.Checked[j] then
          begin
            // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
            setlength(mainform.Softpatch[i].RouteToInputChan,length(mainform.Softpatch[i].RouteToInputChan)+1);
            mainform.Softpatch[i].RouteToInputChan[length(mainform.Softpatch[i].RouteToInputChan)-1]:=j+1;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tdataineventfrm.FlipEntry(Source, Destination:integer);
var
  i:integer;
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.DataInEventArray,length(mainform.DataInEventArray)+1);
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].ID:=mainform.DataInEventArray[Source].ID;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Channel:=mainform.DataInEventArray[Source].Channel;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Value:=mainform.DataInEventArray[Source].Value;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Typ:=mainform.DataInEventArray[Source].Typ;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Wert1:=mainform.DataInEventArray[Source].Wert1;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Wert2:=mainform.DataInEventArray[Source].Wert2;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Arg3:=mainform.DataInEventArray[Source].Arg3;

  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ID:=mainform.DataInEventArray[Source].Befehl.ID;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.Typ:=mainform.DataInEventArray[Source].Befehl.Typ;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.Name:=mainform.DataInEventArray[Source].Befehl.Name;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.Beschreibung:=mainform.DataInEventArray[Source].Befehl.Beschreibung;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.OnValue:=mainform.DataInEventArray[Source].Befehl.OnValue;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.SwitchValue:=mainform.DataInEventArray[Source].Befehl.SwitchValue;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.InvertSwitchValue:=mainform.DataInEventArray[Source].Befehl.InvertSwitchValue;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.OffValue:=mainform.DataInEventArray[Source].Befehl.OffValue;
  mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ScaleValue:=mainform.DataInEventArray[Source].Befehl.ScaleValue;
  setlength(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgInteger, length(mainform.DataInEventArray[Source].Befehl.ArgInteger));
  for i:=0 to length(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgInteger)-1 do
    mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgInteger[i]:=mainform.DataInEventArray[Source].Befehl.ArgInteger[i];
  setlength(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgString, length(mainform.DataInEventArray[Source].Befehl.ArgString));
  for i:=0 to length(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgString)-1 do
    mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgString[i]:=mainform.DataInEventArray[Source].Befehl.ArgString[i];
  setlength(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgGUID, length(mainform.DataInEventArray[Source].Befehl.ArgGUID));
  for i:=0 to length(mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgGUID)-1 do
    mainform.DataInEventArray[length(mainform.DataInEventArray)-1].Befehl.ArgGUID[i]:=mainform.DataInEventArray[Source].Befehl.ArgGUID[i];

  // oberen Eintrag aufrutschen
  mainform.DataInEventArray[Source].ID:=mainform.DataInEventArray[Destination].ID;
  mainform.DataInEventArray[Source].Channel:=mainform.DataInEventArray[Destination].Channel;
  mainform.DataInEventArray[Source].Value:=mainform.DataInEventArray[Destination].Value;
  mainform.DataInEventArray[Source].Typ:=mainform.DataInEventArray[Destination].Typ;
  mainform.DataInEventArray[Source].Wert1:=mainform.DataInEventArray[Destination].Wert1;
  mainform.DataInEventArray[Source].Wert2:=mainform.DataInEventArray[Destination].Wert2;
  mainform.DataInEventArray[Source].Arg3:=mainform.DataInEventArray[Destination].Arg3;

  mainform.DataInEventArray[Source].Befehl.ID:=mainform.DataInEventArray[Destination].Befehl.ID;
  mainform.DataInEventArray[Source].Befehl.Typ:=mainform.DataInEventArray[Destination].Befehl.Typ;
  mainform.DataInEventArray[Source].Befehl.Name:=mainform.DataInEventArray[Destination].Befehl.Name;
  mainform.DataInEventArray[Source].Befehl.Beschreibung:=mainform.DataInEventArray[Destination].Befehl.Beschreibung;
  mainform.DataInEventArray[Source].Befehl.OnValue:=mainform.DataInEventArray[Destination].Befehl.OnValue;
  mainform.DataInEventArray[Source].Befehl.SwitchValue:=mainform.DataInEventArray[Destination].Befehl.SwitchValue;
  mainform.DataInEventArray[Source].Befehl.InvertSwitchValue:=mainform.DataInEventArray[Destination].Befehl.InvertSwitchValue;
  mainform.DataInEventArray[Source].Befehl.OffValue:=mainform.DataInEventArray[Destination].Befehl.OffValue;
  mainform.DataInEventArray[Source].Befehl.ScaleValue:=mainform.DataInEventArray[Destination].Befehl.ScaleValue;
  setlength(mainform.DataInEventArray[Source].Befehl.ArgInteger, length(mainform.DataInEventArray[Destination].Befehl.ArgInteger));
  for i:=0 to length(mainform.DataInEventArray[Source].Befehl.ArgInteger)-1 do
    mainform.DataInEventArray[Source].Befehl.ArgInteger[i]:=mainform.DataInEventArray[Destination].Befehl.ArgInteger[i];
  setlength(mainform.DataInEventArray[Source].Befehl.ArgString, length(mainform.DataInEventArray[Destination].Befehl.ArgString));
  for i:=0 to length(mainform.DataInEventArray[Source].Befehl.ArgString)-1 do
    mainform.DataInEventArray[Source].Befehl.ArgString[i]:=mainform.DataInEventArray[Destination].Befehl.ArgString[i];
  setlength(mainform.DataInEventArray[Source].Befehl.ArgGUID, length(mainform.DataInEventArray[Destination].Befehl.ArgGUID));
  for i:=0 to length(mainform.DataInEventArray[Source].Befehl.ArgGUID)-1 do
    mainform.DataInEventArray[Source].Befehl.ArgGUID[i]:=mainform.DataInEventArray[Destination].Befehl.ArgGUID[i];

  // letzten Eintrag einfügen
  mainform.DataInEventArray[Destination].ID:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].ID;
  mainform.DataInEventArray[Destination].Channel:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Channel;
  mainform.DataInEventArray[Destination].Value:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Value;
  mainform.DataInEventArray[Destination].Typ:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Typ;
  mainform.DataInEventArray[Destination].Wert1:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Wert1;
  mainform.DataInEventArray[Destination].Wert2:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Wert2;
  mainform.DataInEventArray[Destination].Arg3:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Arg3;

  mainform.DataInEventArray[Destination].Befehl.ID:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ID;
  mainform.DataInEventArray[Destination].Befehl.Typ:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.Typ;
  mainform.DataInEventArray[Destination].Befehl.Name:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.Name;
  mainform.DataInEventArray[Destination].Befehl.Beschreibung:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.Beschreibung;
  mainform.DataInEventArray[Destination].Befehl.OnValue:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.OnValue;
  mainform.DataInEventArray[Destination].Befehl.SwitchValue:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.SwitchValue;
  mainform.DataInEventArray[Destination].Befehl.InvertSwitchValue:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.InvertSwitchValue;
  mainform.DataInEventArray[Destination].Befehl.OffValue:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.OffValue;
  mainform.DataInEventArray[Destination].Befehl.ScaleValue:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ScaleValue;
  setlength(mainform.DataInEventArray[Destination].Befehl.ArgInteger, length(mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.DataInEventArray[Destination].Befehl.ArgInteger)-1 do
    mainform.DataInEventArray[Destination].Befehl.ArgInteger[i]:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgInteger[i];
  setlength(mainform.DataInEventArray[Destination].Befehl.ArgString, length(mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgString));
  for i:=0 to length(mainform.DataInEventArray[Destination].Befehl.ArgString)-1 do
    mainform.DataInEventArray[Destination].Befehl.ArgString[i]:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgString[i];
  setlength(mainform.DataInEventArray[Destination].Befehl.ArgGUID, length(mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.DataInEventArray[Destination].Befehl.ArgGUID)-1 do
    mainform.DataInEventArray[Destination].Befehl.ArgGUID[i]:=mainform.DataInEventArray[length(mainform.DatainEventArray)-1].Befehl.ArgGUID[i];
  setlength(mainform.DataInEventArray,length(mainform.DataInEventArray)-1);
end;

procedure Tdataineventfrm.upBtnClick(Sender: TObject);
var
  i:integer;
begin
  if length(mainform.DataInEventArray)>0 then
  if DataGrid.Row>1 then
  begin
    // nach unten verschieben
    FlipEntry(DataGrid.Row-1,DataGrid.Row-2);
    // Position mitführen
    DataGrid.Row:=DataGrid.Row-1;
  end;

  for i:=1 to DataGrid.rowcount-1 do
  begin
    refreshList(i);
  end;

  upBtn.enabled:=DataGrid.Row>1;
  downBtn.enabled:=DataGrid.Row<DataGrid.RowCount-1;
end;

procedure Tdataineventfrm.downBtnClick(Sender: TObject);
var
  i:integer;
begin
  if length(mainform.DataInEventArray)>0 then
  if DataGrid.Row<DataGrid.RowCount-1 then
  begin
    // nach unten verschieben
    FlipEntry(DataGrid.Row-1,DataGrid.Row);
    // Position mitführen
    DataGrid.Row:=DataGrid.Row+1;
  end;

  for i:=1 to DataGrid.rowcount-1 do
  begin
    refreshList(i);
  end;

  upBtn.enabled:=DataGrid.Row>1;
  downBtn.enabled:=DataGrid.Row<DataGrid.RowCount-1;
end;

procedure Tdataineventfrm.okbtnClick(Sender: TObject);
begin
  close;
end;

procedure Tdataineventfrm.ListBox2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j:integer;
begin
  checklistboxb;

  if (key=vk_space) and Listbox2.Checked[Listbox2.ItemIndex] then
  begin
    CheckListbox2.itemindex:=Listbox2.ItemIndex;
    CheckListbox2.Checked[CheckListbox2.itemindex]:=true;

    for i:=0 to length(mainform.softpatch2)-1 do
    begin
      if mainform.softpatch2[i].Channel2=Listbox2.ItemIndex+1 then
      begin
        // Richtiges softpatch2 gefunden
        setlength(mainform.softpatch2[i].RouteToPC_DIMMERChan,0);

        for j:=0 to CheckListbox2.Items.Count-1 do
        begin
          if checklistbox2.Checked[j] then
          begin
            // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
            setlength(mainform.softpatch2[i].RouteToPC_DIMMERChan,length(mainform.softpatch2[i].RouteToPC_DIMMERChan)+1);
            mainform.softpatch2[i].RouteToPC_DIMMERChan[length(mainform.softpatch2[i].RouteToPC_DIMMERChan)-1]:=j+1;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tdataineventfrm.ListBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  checklistboxb;
end;

procedure Tdataineventfrm.CheckListBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.softpatch2)-1 do
  begin
    if mainform.softpatch2[i].Channel2=Listbox2.ItemIndex+1 then
    begin
      // Richtiges softpatch2 gefunden
      setlength(mainform.softpatch2[i].RouteToPC_DIMMERChan,0);

      for j:=0 to CheckListbox2.Items.Count-1 do
      begin
        if checklistbox2.Checked[j] then
        begin
          // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
          setlength(mainform.softpatch2[i].RouteToPC_DIMMERChan,length(mainform.softpatch2[i].RouteToPC_DIMMERChan)+1);
          mainform.softpatch2[i].RouteToPC_DIMMERChan[length(mainform.softpatch2[i].RouteToPC_DIMMERChan)-1]:=j+1;
        end;
      end;
    end;
  end;
end;

procedure Tdataineventfrm.Button4Click(Sender: TObject);
var
  i:integer;
begin
  if messagedlg(_('Möchten Sie wirklich das gesamte Patchfeld der DataIn-Kanäle löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    for i:=0 to listbox2.Items.Count-1 do
      Listbox2.Checked[i]:=false;

    setlength(mainform.softpatch2,0);

    checklistboxb;
  end;
end;

procedure Tdataineventfrm.Listbox1Click(Sender: TObject);
begin
  checklistbox;
end;

procedure Tdataineventfrm.Listbox1ClickCheck(Sender: TObject);
begin
  checklistbox;
end;

procedure Tdataineventfrm.ListBox2Click(Sender: TObject);
begin
  checklistboxb;
end;

procedure Tdataineventfrm.ListBox2ClickCheck(Sender: TObject);
begin
  checklistboxb;
end;

procedure Tdataineventfrm.DataGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  upBtn.enabled:=DataGrid.Row>1;
  downBtn.enabled:=DataGrid.Row<DataGrid.RowCount-1;
end;

procedure Tdataineventfrm.DataGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  upBtn.enabled:=DataGrid.Row>1;
  downBtn.enabled:=DataGrid.Row<DataGrid.RowCount-1;
end;

procedure Tdataineventfrm.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tdataineventfrm.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tdataineventfrm.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  lastdatainchannel.Caption:=inttostr(lastdatainaddress);
  lastdatainvalue.Caption:=inttostr(lastdatainendvalue);

  if length(mainform.DataInEventArray)>0 then
  for i:=0 to length(mainform.DataInEventArray)-1 do
  begin
    if (lastdatainaddress=mainform.DataInEventArray[i].channel) then
    begin
      // Werte in Liste aktualisieren
      DataGrid.cells[2,i+1]:=inttostr(mainform.DataInEventArray[i].Channel);	// Value
      DataGrid.cells[3,i+1]:=inttostr(mainform.DataInEventArray[i].value);	// Value
      DataGrid.cells[11,i+1]:=inttostr(lastdatainendvalue);
    end;
  end;
end;

procedure Tdataineventfrm.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure Tdataineventfrm.Button1Click(Sender: TObject);
begin
  ShowMessage(_('Benutzen Sie die Leertaste in der linken Liste, um 1:1 Routing für einen Kanal zu aktivieren.'));
end;

procedure Tdataineventfrm.Button5Click(Sender: TObject);
var
  i,j,k,start,ende:integer;
  ok1,ok2:boolean;
begin
  start:=strtoint(inputbox(_('Auto-Patching'), _('Bitte geben Sie den ersten Kanal des 1:1-Patchings an...'), '1'));
  ende:=strtoint(inputbox(_('Auto-Patching'), _('Bitte geben Sie den letzten Kanal des 1:1-Patchings an...'), '512'));

  // Von Start- bis Endkanal durchiterieren
  for k:=start to ende do
  begin
    ok1:=false;

    // Alle bisherigen Softpatches abklappern
    for i:=0 to length(mainform.Softpatch)-1 do
    begin
      if mainform.Softpatch[i].Channel=k then
      begin
        // Richtiges Softpatch gefunden
        ok2:=false;

        // Prüfen, ob Kanal schon geroutet ist
        for j:=0 to length(mainform.Softpatch[i].RouteToInputChan)-1 do
        begin
          if mainform.Softpatch[i].RouteToInputChan[j]=k then
          begin
            ok2:=true;
            break;
          end;
        end;

        // Kanal noch nicht geroutet
        if not ok2 then
        begin
          // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
          setlength(mainform.Softpatch[i].RouteToInputChan,length(mainform.Softpatch[i].RouteToInputChan)+1);
          mainform.Softpatch[i].RouteToInputChan[length(mainform.Softpatch[i].RouteToInputChan)-1]:=k;
        end;

        ok1:=true;
        break;
      end;
    end;

    if not ok1 then
    begin
      // Softpatch ist für den Kanal noch nicht eingerichtet
      setlength(mainform.Softpatch,length(mainform.Softpatch)+1);
      mainform.Softpatch[length(mainform.Softpatch)-1].Channel:=k;
      setlength(mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan, 1);
      mainform.Softpatch[length(mainform.Softpatch)-1].RouteToInputChan[0]:=k;
    end;
  end;
//  checklistbox;
  FormShow(nil);
end;

procedure Tdataineventfrm.Button6Click(Sender: TObject);
var
  i,j,k,start,ende:integer;
  ok1,ok2:boolean;
begin
  start:=strtoint(inputbox(_('Auto-Patching'), _('Bitte geben Sie den ersten Kanal des 1:1-Patchings an...'), '1'));
  ende:=strtoint(inputbox(_('Auto-Patching'), _('Bitte geben Sie den letzten Kanal des 1:1-Patchings an...'), '512'));

  // Von Start- bis Endkanal durchiterieren
  for k:=start to ende do
  begin
    ok1:=false;

    // Alle bisherigen Softpatches abklappern
    for i:=0 to length(mainform.Softpatch2)-1 do
    begin
      if mainform.Softpatch2[i].Channel2=k then
      begin
        // Richtiges Softpatch gefunden
        ok2:=false;

        // Prüfen, ob Kanal schon geroutet ist
        for j:=0 to length(mainform.Softpatch2[i].RouteToPC_DIMMERChan)-1 do
        begin
          if mainform.Softpatch2[i].RouteToPC_DIMMERChan[j]=k then
          begin
            ok2:=true;
            break;
          end;
        end;

        // Kanal noch nicht geroutet
        if not ok2 then
        begin
          // Unterarray um eins erweitern und den aktuellen Kanal hinzufügen
          setlength(mainform.Softpatch2[i].RouteToPC_DIMMERChan,length(mainform.Softpatch2[i].RouteToPC_DIMMERChan)+1);
          mainform.Softpatch2[i].RouteToPC_DIMMERChan[length(mainform.Softpatch2[i].RouteToPC_DIMMERChan)-1]:=k;
        end;

        ok1:=true;
        break;
      end;
    end;

    if not ok1 then
    begin
      // Softpatch ist für den Kanal noch nicht eingerichtet
      setlength(mainform.Softpatch2,length(mainform.Softpatch2)+1);
      mainform.Softpatch2[length(mainform.Softpatch2)-1].Channel2:=k;
      setlength(mainform.Softpatch2[length(mainform.Softpatch2)-1].RouteToPC_DIMMERChan, 1);
      mainform.Softpatch2[length(mainform.Softpatch2)-1].RouteToPC_DIMMERChan[0]:=k;
    end;
  end;
//  checklistboxb;
  FormShow(nil);
end;

procedure Tdataineventfrm.CreateParams(var Params:TCreateParams);
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
