unit midievent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, Mask, JvExMask, JvSpin, PngBitBtn,
  ExtCtrls, Registry, gnugettext, JvToolEdit, JvCombobox, MidiIn, MidiOut,
  pngimage, JvExControls, JvGradient;

type
  Tmidieventfrm = class(TForm)
    GroupBox1: TGroupBox;
    MIDIGrid: TStringGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    okbtn: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SendValueToSelCountEdit: TJvSpinEdit;
    SendValueToSelCombobox: TComboBox;
    SendValueToSelData1Radiobox: TRadioButton;
    SendValueToSelData2Radiobox: TRadioButton;
    SendValueToSelMSGEdit: TEdit;
    SendValueToSelData1Edit: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    addmidievent: TPngBitBtn;
    editmidievent: TPngBitBtn;
    deletemidievent: TPngBitBtn;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    message1b: TLabel;
    data1b: TLabel;
    data2b: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    upBtn: TPngBitBtn;
    downBtn: TPngBitBtn;
    MIDIResetBtn: TButton;
    CheckBox1: TCheckBox;
    midiindevicelist: TJvCheckedComboBox;
    midioutdevicelist: TJvCheckedComboBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    UseControl7: TCheckBox;
    UseMIDIThru: TCheckBox;
    Timer1: TTimer;
    MidiChannelControlBox: TComboBox;
    MidiChannelControlEdit: TJvSpinEdit;
    Label12: TLabel;
    recordbox: TCheckBox;
    Panel9: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
		procedure refreshList(line: integer);
    procedure editmidieventClick(Sender: TObject);
    procedure addmidieventClick(Sender: TObject);
    procedure deletemidieventClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MIDIGridDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SendValueToSelCountEditChange(Sender: TObject);
    procedure SendValueToSelComboboxSelect(Sender: TObject);
    procedure SendValueToSelMSGEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SendValueToSelData1EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SendValueToSelData1RadioboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SendValueToSelData1RadioboxKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure upBtnClick(Sender: TObject);
    procedure downBtnClick(Sender: TObject);
    procedure MIDIResetBtnClick(Sender: TObject);
    procedure midiindevicelistChange(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure midioutdevicelistChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure UseControl7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UseMIDIThruMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure MidiChannelControlBoxSelect(Sender: TObject);
    procedure MidiChannelControlEditChange(Sender: TObject);
    procedure MIDIGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MIDIGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private-Deklarationen }
    LocalLastMidiMSG, LocalLastMidiData1, LocalLastMidiData2:byte;
    midisettings:boolean;
    procedure FlipEntry(Source, Destination:integer);
  public
    { Public-Deklarationen }
    procedure Openfile(Filename:string);
  end;

var
  midieventfrm: Tmidieventfrm;

implementation

uses pcdimmer, editmidievent;

{$R *.dfm}

procedure Tmidieventfrm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  TranslateComponent(self);

  midisettings:=true;

	midigrid.Cells[0,0]:='Message';
  midigrid.cells[1,0]:='Data1';
  midigrid.cells[2,0]:='Data2';
  midigrid.cells[3,0]:='Typ';
  midigrid.cells[4,0]:='Wert1';
  midigrid.cells[5,0]:='Wert2';
  midigrid.cells[6,0]:='Wert3';
  midigrid.cells[7,0]:='Unten';
  midigrid.cells[8,0]:='Ein';
  midigrid.cells[9,0]:='Oben';
  midigrid.cells[10,0]:='Data1/2';
  midigrid.ColWidths[0]:=50;
  midigrid.ColWidths[1]:=50;
  midigrid.ColWidths[2]:=50;
  midigrid.ColWidths[3]:=275;
  midigrid.ColWidths[4]:=50;
  midigrid.ColWidths[5]:=45;
  midigrid.ColWidths[6]:=45;
  midigrid.ColWidths[7]:=35;
  midigrid.ColWidths[8]:=35;
  midigrid.ColWidths[9]:=35;
  midigrid.ColWidths[10]:=45;
  midigrid.ColWidths[11]:=15;
  MIDIGrid.cells[0,1]:='-';
  MIDIGrid.cells[1,1]:='-';
  MIDIGrid.cells[2,1]:='-';
  MIDIGrid.cells[3,1]:='-';
  MIDIGrid.cells[4,1]:='-';
  MIDIGrid.cells[5,1]:='-';
  MIDIGrid.cells[6,1]:='-';
  MIDIGrid.cells[7,1]:='-';
  MIDIGrid.cells[8,1]:='-';
  MIDIGrid.cells[9,1]:='-';
  MIDIGrid.cells[10,1]:='-';
  MIDIGrid.cells[11,1]:='-';

  MidiChannelControlBox.Items.Clear;
  for i:=0 to 15 do
    MidiChannelControlBox.Items.Add('Kanal '+inttostr(i+1));
  MidiChannelControlBox.Itemindex:=0;
  MidiChannelControlEdit.Value:=mainform.LastMIDIController[MidiChannelControlBox.Itemindex+1];
end;

procedure Tmidieventfrm.refreshList(line: integer);
var
  i,j:integer;
  text:string;
begin
  if line>MIDIGrid.RowCount-1 then exit;
  MIDIGrid.cells[0,line]:=inttostr(mainform.MidiEventArray[line-1].MIDIMessage);	// Message

  if mainform.MidiEventArray[line-1].Data1orData2=2 then
  begin
    MIDIGrid.cells[1,line]:=inttostr(mainform.MidiEventArray[line-1].MIDIData1);	// Data1
    MIDIGrid.cells[2,line]:='-';
  end else
  begin
    MIDIGrid.cells[1,line]:='-';
    MIDIGrid.cells[2,line]:='-';//inttostr(mainform.MidiEventArray[line-1].MIDIData2);	// Data2
  end;

  for i:=0 to length(mainform.Befehlssystem)-1 do
  begin
    for j:=0 to length(mainform.Befehlssystem[i].Steuerung)-1 do
    begin
      if IsEqualGUID(mainform.Befehlssystem[i].Steuerung[j].GUID, mainform.MidiEventArray[line-1].Befehl.Typ) then
      begin
        MIDIGrid.cells[3,line]:=mainform.Befehlssystem[i].Programmteil+': '+mainform.Befehlssystem[i].Steuerung[j].Bezeichnung;
        if length(mainform.MidiEventArray[line-1].Befehl.ArgGUID)>0 then
        begin
          mainform.GetInfo(mainform.MidiEventArray[line-1].Befehl.ArgGUID[0], text);
          if text<>'' then
            MIDIGrid.cells[3,line]:=MIDIGrid.cells[3,line]+' ('+text+')';
        end;
        break;
      end;
    end;
  end;

  if length(mainform.MidiEventArray[line-1].Befehl.ArgInteger)>0 then
    MIDIGrid.cells[4,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.ArgInteger[0]);	// Wert1
  if length(mainform.MidiEventArray[line-1].Befehl.ArgInteger)>1 then
    MIDIGrid.cells[5,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.ArgInteger[1]);	// Wert2
  if length(mainform.MidiEventArray[line-1].Befehl.ArgInteger)>2 then
    MIDIGrid.cells[6,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.ArgInteger[1]);	// Wert2

  MIDIGrid.cells[7,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.OffValue div 2);
  MIDIGrid.cells[8,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.SwitchValue div 2);
  MIDIGrid.cells[9,line]:=inttostr(mainform.MidiEventArray[line-1].Befehl.OnValue div 2);

  if mainform.MidiEventArray[line-1].Data1orData2=1 then				// Data1 oder Data2
    MIDIGrid.cells[10,line]:='Data 1'
  else
    MIDIGrid.cells[10,line]:='Data 2';
end;

procedure Tmidieventfrm.editmidieventClick(Sender: TObject);
var
  i:integer;
begin
	// Werte an EditForm übergeben
	EditMIDIEVENTfrm.Message1a.text:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1].MIDIMessage);
	EditMIDIEVENTfrm.Data1a.text:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1].MIDIData1);
	EditMIDIEVENTfrm.Data2a.text:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1].MIDIData2);

  EditMIDIEVENTfrm.AktuellerBefehl.Typ:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.Typ;
  EditMIDIEVENTfrm.AktuellerBefehl.OnValue:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OnValue;
  EditMIDIEVENTfrm.AktuellerBefehl.SwitchValue:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.SwitchValue;
  EditMIDIEVENTfrm.AktuellerBefehl.InvertSwitchValue:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.InvertSwitchValue;
  EditMIDIEVENTfrm.AktuellerBefehl.OffValue:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OffValue;
  EditMIDIEVENTfrm.AktuellerBefehl.ScaleValue:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ScaleValue;

  setlength(EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger, length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger)-1 do
    EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger[i]:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger[i];
  setlength(EditMIDIEVENTfrm.AktuellerBefehl.ArgString, length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString));
  for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString)-1 do
    EditMIDIEVENTfrm.AktuellerBefehl.ArgString[i]:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString[i];
  setlength(EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID, length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID)-1 do
    EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID[i]:=mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGuid[i];

	EditMIDIEVENTfrm.data1chk.checked:=(mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2=1);
	EditMIDIEVENTfrm.data2chk.checked:=(mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2=2);
	EditMIDIEVENTfrm.usemidibacktrack.Checked:=mainform.MidiEventArray[MIDIGrid.row-1].UseMidiBacktrack;

	// Editform anzeigen
	EditMIDIEVENTfrm.Showmodal;

	// Werte bei "OK" in Array kopieren und Liste aktualisieren
	if EditMIDIEVENTfrm.modalresult=mrOK then
	begin
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIMessage := strtoint(EditMIDIEVENTfrm.Message1a.text);
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIData1 := strtoint(EditMIDIEVENTfrm.Data1a.text);
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIData2 := strtoint(EditMIDIEVENTfrm.Data2a.text);

    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.Typ:=EditMIDIEVENTfrm.AktuellerBefehl.Typ;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OnValue:=EditMIDIEVENTfrm.AktuellerBefehl.OnValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.SwitchValue:=EditMIDIEVENTfrm.AktuellerBefehl.SwitchValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.InvertSwitchValue:=EditMIDIEVENTfrm.AktuellerBefehl.InvertSwitchValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OffValue:=EditMIDIEVENTfrm.AktuellerBefehl.OffValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ScaleValue:=EditMIDIEVENTfrm.AktuellerBefehl.ScaleValue;

    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger[i];
    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgString));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgString[i];
    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGuid[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID[i];

    if EditMIDIEVENTfrm.data1chk.checked then
    	mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2 := 1
    else
    	mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2 := 2;
	  mainform.MidiEventArray[MIDIGrid.row-1].UseMidiBacktrack:=EditMIDIEVENTfrm.usemidibacktrack.Checked;

		refreshList(MIDIGrid.row);
	end;
end;

procedure Tmidieventfrm.addmidieventClick(Sender: TObject);
var
  i:integer;
begin
	// EditForm zurücksetzen
	EditMIDIEVENTfrm.Message1a.text:='0';
	EditMIDIEVENTfrm.Data1a.text:='0';
	EditMIDIEVENTfrm.Data2a.text:='0';
	EditMIDIEVENTfrm.data2chk.checked:=true;
	EditMIDIEVENTfrm.usemidibacktrack.checked:=true;

  EditMIDIEVENTfrm.AktuellerBefehl.Name:='MIDI-Event';
  EditMIDIEVENTfrm.AktuellerBefehl.Beschreibung:='';
  EditMIDIEVENTfrm.AktuellerBefehl.OnValue:=255;
  EditMIDIEVENTfrm.AktuellerBefehl.SwitchValue:=128;
  EditMIDIEVENTfrm.AktuellerBefehl.OffValue:=0;
  EditMIDIEVENTfrm.AktuellerBefehl.ScaleValue:=false;

	// EditForm anzeigen
	EditMIDIEVENTfrm.Showmodal;

	// Array um eine Position verlängern und Werte aus EditForm in Array kopieren und Liste aktualisieren
	if EditMIDIEVENTfrm.modalresult=mrOK then
	begin
		setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)+1);
    if not ((MIDIGrid.rowcount-1)=length(mainform.MidiEventArray)) then
		begin
    	MIDIGrid.rowcount:=MIDIGrid.rowcount+1;
      MIDIGrid.RowHeights[MIDIGrid.rowcount-1]:=15;
    end;
		MIDIGrid.row:=MIDIGrid.rowcount-1;
    CreateGUID(mainform.MidiEventArray[MidiGrid.row-1].ID);
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIMessage := strtoint(EditMIDIEVENTfrm.Message1a.text);
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIData1 := strtoint(EditMIDIEVENTfrm.Data1a.text);
		mainform.MidiEventArray[MIDIGrid.row-1].MIDIData2 := strtoint(EditMIDIEVENTfrm.Data2a.text);

    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.Typ:=EditMIDIEVENTfrm.AktuellerBefehl.Typ;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OnValue:=EditMIDIEVENTfrm.AktuellerBefehl.OnValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.SwitchValue:=EditMIDIEVENTfrm.AktuellerBefehl.SwitchValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.InvertSwitchValue:=EditMIDIEVENTfrm.AktuellerBefehl.InvertSwitchValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.OffValue:=EditMIDIEVENTfrm.AktuellerBefehl.OffValue;
    mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ScaleValue:=EditMIDIEVENTfrm.AktuellerBefehl.ScaleValue;

    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgInteger[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgInteger[i];
    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgString));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgString[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgString[i];
    setlength(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID, length(EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID));
    for i:=0 to length(mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGUID)-1 do
      mainform.MidiEventArray[MIDIGrid.row-1].Befehl.ArgGuid[i]:=EditMIDIEVENTfrm.AktuellerBefehl.ArgGUID[i];

    if EditMIDIEVENTfrm.data1chk.checked then
			mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2 := 1
    else
    	mainform.MidiEventArray[MIDIGrid.row-1].Data1orData2 := 2;
    mainform.MidiEventArray[MIDIGrid.Row-1].UseMidiBacktrack:=EditMIDIEVENTfrm.usemidibacktrack.Checked;

   	deletemidievent.Enabled:=true;
    editmidievent.Enabled:=true;

		refreshList(MIDIGrid.row);
	end;
end;

procedure Tmidieventfrm.deletemidieventClick(Sender: TObject);
var
	i,k:integer;
begin
	// Ab aktueller Position alle nachfolgenden Einträge um eins nach oben kopieren
	for i:=MIDIGrid.row to MIDIGrid.rowcount-2 do
	begin
//		for j:=1 to 7 do
		begin
      mainform.MidiEventArray[i-1].ID:=mainform.MidiEventArray[i].ID;
      mainform.MidiEventArray[i-1].MIDIMessage:=mainform.MidiEventArray[i].MIDIMessage;
      mainform.MidiEventArray[i-1].MIDIData1:=mainform.MidiEventArray[i].MIDIData1;
      mainform.MidiEventArray[i-1].MIDIData2:=mainform.MidiEventArray[i].MIDIData2;
      mainform.MidiEventArray[i-1].Typ:=mainform.MidiEventArray[i].Typ;
      mainform.MidiEventArray[i-1].Wert1:=mainform.MidiEventArray[i].Wert1;
      mainform.MidiEventArray[i-1].Wert2:=mainform.MidiEventArray[i].Wert2;
      mainform.MidiEventArray[i-1].Data1orData2:=mainform.MidiEventArray[i].Data1orData2;
      mainform.MidiEventArray[i-1].Arg3:=mainform.MidiEventArray[i].Arg3;
      mainform.MidiEventArray[i-1].UseMidiBacktrack:=mainform.MidiEventArray[i].UseMidiBacktrack;
      mainform.MidiEventArray[i-1].ExternMidiValue:=mainform.MidiEventArray[i].ExternMidiValue;
      mainform.MidiEventArray[i-1].ExternMidiSwitchState:=mainform.MidiEventArray[i].ExternMidiSwitchState;

      mainform.MidiEventArray[i-1].Befehl.ID:=mainform.MidiEventArray[i].Befehl.ID;
      mainform.MidiEventArray[i-1].Befehl.Typ:=mainform.MidiEventArray[i].Befehl.Typ;
      mainform.MidiEventArray[i-1].Befehl.Name:=mainform.MidiEventArray[i].Befehl.Name;
      mainform.MidiEventArray[i-1].Befehl.Beschreibung:=mainform.MidiEventArray[i].Befehl.Beschreibung;
      mainform.MidiEventArray[i-1].Befehl.OnValue:=mainform.MidiEventArray[i].Befehl.OnValue;
      mainform.MidiEventArray[i-1].Befehl.SwitchValue:=mainform.MidiEventArray[i].Befehl.SwitchValue;
      mainform.MidiEventArray[i-1].Befehl.InvertSwitchValue:=mainform.MidiEventArray[i].Befehl.InvertSwitchValue;
      mainform.MidiEventArray[i-1].Befehl.OffValue:=mainform.MidiEventArray[i].Befehl.OffValue;
      mainform.MidiEventArray[i-1].Befehl.ScaleValue:=mainform.MidiEventArray[i].Befehl.ScaleValue;

      setlength(mainform.MidiEventArray[i-1].Befehl.ArgInteger,length(mainform.MidiEventArray[i].Befehl.ArgInteger));
      setlength(mainform.MidiEventArray[i-1].Befehl.ArgString,length(mainform.MidiEventArray[i].Befehl.ArgString));
      setlength(mainform.MidiEventArray[i-1].Befehl.ArgGUID,length(mainform.MidiEventArray[i].Befehl.ArgGUID));

      for k:=0 to length(mainform.MidiEventArray[i-1].Befehl.ArgInteger)-1 do
      begin
        mainform.MidiEventArray[i-1].Befehl.ArgInteger[k]:=mainform.MidiEventArray[i].Befehl.ArgInteger[k];
      end;
      for k:=0 to length(mainform.MidiEventArray[i-1].Befehl.ArgString)-1 do
      begin
        mainform.MidiEventArray[i-1].Befehl.ArgString[k]:=mainform.MidiEventArray[i].Befehl.ArgString[k];
      end;
      for k:=0 to length(mainform.MidiEventArray[i-1].Befehl.ArgGUID)-1 do
      begin
        mainform.MidiEventArray[i-1].Befehl.ArgGUID[k]:=mainform.MidiEventArray[i].Befehl.ArgGUID[k];
      end;
    end;
	end;

	// Letzten Eintrag löschen
	setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)-1);

  if MIDIGrid.RowCount>2 then
	begin
  	MIDIGrid.rowcount:=MIDIGrid.rowcount-1;
		// komplette Liste aktualisieren
		for i:=1 to MIDIGrid.rowcount-1 do
		begin
			refreshList(i);
		end;
	end else
  begin
		MIDIGrid.cells[0,1]:='-';
		MIDIGrid.cells[1,1]:='-';
		MIDIGrid.cells[2,1]:='-';
		MIDIGrid.cells[3,1]:='-';
		MIDIGrid.cells[4,1]:='-';
		MIDIGrid.cells[5,1]:='-';
		MIDIGrid.cells[6,1]:='-';
		MIDIGrid.cells[7,1]:='-';
		MIDIGrid.cells[8,1]:='-';
		MIDIGrid.cells[9,1]:='-';
		MIDIGrid.cells[10,1]:='-';
		MIDIGrid.cells[11,1]:='-';
  	deletemidievent.Enabled:=false;
    editmidievent.Enabled:=false;
  end;
end;

procedure Tmidieventfrm.FormShow(Sender: TObject);
begin
  Timer1.enabled:=true;

  upBtn.enabled:=MidiGrid.Row>1;
  downBtn.enabled:=MidiGrid.Row<MidiGrid.RowCount-1;

  MIDIGrid.RowHeights[0]:=15;
  UseMIDIThru.checked:=mainform.UseMIDIThru;
  UseControl7.Checked:=mainform.UseControl7ForLevel;
  Label12.enabled:=UseControl7.Checked;
  MidiChannelControlBox.enabled:=UseControl7.Checked;
  MidiChannelControlEdit.enabled:=UseControl7.Checked;
end;

procedure Tmidieventfrm.MIDIGridDblClick(Sender: TObject);
begin
	if editmidievent.Enabled then
  	editmidieventClick(Sender);
end;

procedure Tmidieventfrm.SpeedButton3Click(Sender: TObject);
begin
if messagedlg(_('Möchten Sie wirklich alle MIDI-Events löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
	  MIDIGrid.RowCount:=2;
		setlength(mainform.MidiEventArray,0);

		MIDIGrid.cells[0,1]:='-';
		MIDIGrid.cells[1,1]:='-';
		MIDIGrid.cells[2,1]:='-';
		MIDIGrid.cells[3,1]:='-';
		MIDIGrid.cells[4,1]:='-';
		MIDIGrid.cells[5,1]:='-';
		MIDIGrid.cells[6,1]:='-';
		MIDIGrid.cells[7,1]:='-';
		MIDIGrid.cells[8,1]:='-';
		MIDIGrid.cells[9,1]:='-';
		MIDIGrid.cells[10,1]:='-';
		MIDIGrid.cells[11,1]:='-';
	 	deletemidievent.Enabled:=false;
	  editmidievent.Enabled:=false;
	end;
end;

procedure Tmidieventfrm.Openfile(Filename:string);
var
  i,j,Count,Count2:integer;
begin
  if FileExists(Filename) then
  begin
    with mainform do
    begin
      Filestream:=TFileStream.Create(Filename, fmOpenRead);
      Filestream.ReadBuffer(Count,sizeof(Count));
      setlength(MidiEventArray,Count);
      for i:=0 to Count-1 do
      begin
        Filestream.ReadBuffer(MidiEventArray[i].ID,sizeof(MidiEventArray[i].ID));
        Filestream.ReadBuffer(MidiEventArray[i].MIDIMessage,sizeof(MidiEventArray[i].MIDIMessage));
        Filestream.ReadBuffer(MidiEventArray[i].MIDIData1,sizeof(MidiEventArray[i].MIDIData1));
        Filestream.ReadBuffer(MidiEventArray[i].MIDIData2,sizeof(MidiEventArray[i].MIDIData2));

        Filestream.ReadBuffer(MidiEventArray[i].Befehl.Typ,sizeof(MidiEventArray[i].Befehl.Typ));
        Filestream.ReadBuffer(MidiEventArray[i].Befehl.OnValue,sizeof(MidiEventArray[i].Befehl.OnValue));
        Filestream.ReadBuffer(MidiEventArray[i].Befehl.SwitchValue,sizeof(MidiEventArray[i].Befehl.SwitchValue));
        Filestream.ReadBuffer(MidiEventArray[i].Befehl.InvertSwitchValue,sizeof(MidiEventArray[i].Befehl.InvertSwitchValue));
        Filestream.ReadBuffer(MidiEventArray[i].Befehl.OffValue,sizeof(MidiEventArray[i].Befehl.OffValue));
        Filestream.ReadBuffer(MidiEventArray[i].Befehl.ScaleValue,sizeof(MidiEventArray[i].Befehl.ScaleValue));
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(MidiEventArray[i].Befehl.ArgInteger,Count2);
        for j:=0 to Count2-1 do
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgInteger[j],sizeof(MidiEventArray[i].Befehl.ArgInteger[j]));
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(MidiEventArray[i].Befehl.ArgString,Count2);
        for j:=0 to Count2-1 do
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgString[j],sizeof(MidiEventArray[i].Befehl.ArgString[j]));
        Filestream.ReadBuffer(Count2,sizeof(Count2));
        setlength(MidiEventArray[i].Befehl.ArgGUID,Count2);
        for j:=0 to Count2-1 do
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgGUID[j],sizeof(MidiEventArray[i].Befehl.ArgGUID[j]));

        Filestream.ReadBuffer(MidiEventArray[i].Data1orData2,sizeof(MidiEventArray[i].Data1orData2));
        Filestream.ReadBuffer(MidiEventArray[i].UseMidiBacktrack,sizeof(MidiEventArray[i].UseMidiBacktrack))
      end;
      FileStream.Free;
    end;
  end;
end;

procedure Tmidieventfrm.SpeedButton2Click(Sender: TObject);
var
  i,j,startindex,Count,Count2:integer;
  additiv:boolean;
begin
  additiv:=true;

	case mainform.mymessagedlg(_('Wie sollen die MIDI-Einstellungen aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog1.Execute then
  begin
    if additiv then
    begin
      // Hinzufügen
      startindex:=length(mainform.MidiEventArray)-1;

      with mainform do
      begin
        Filestream:=TFileStream.Create(OpenDialog1.Filename, fmOpenRead);
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(MidiEventArray,Count+startindex+1);
        for i:=startindex+1 to length(MidiEventArray)-1 do
        begin
          Filestream.ReadBuffer(MidiEventArray[i].ID,sizeof(MidiEventArray[i].ID));
          Filestream.ReadBuffer(MidiEventArray[i].MIDIMessage,sizeof(MidiEventArray[i].MIDIMessage));
          Filestream.ReadBuffer(MidiEventArray[i].MIDIData1,sizeof(MidiEventArray[i].MIDIData1));
          Filestream.ReadBuffer(MidiEventArray[i].MIDIData2,sizeof(MidiEventArray[i].MIDIData2));

          Filestream.ReadBuffer(MidiEventArray[i].Befehl.Typ,sizeof(MidiEventArray[i].Befehl.Typ));
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.OnValue,sizeof(MidiEventArray[i].Befehl.OnValue));
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.SwitchValue,sizeof(MidiEventArray[i].Befehl.SwitchValue));
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.InvertSwitchValue,sizeof(MidiEventArray[i].Befehl.InvertSwitchValue));
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.OffValue,sizeof(MidiEventArray[i].Befehl.OffValue));
          Filestream.ReadBuffer(MidiEventArray[i].Befehl.ScaleValue,sizeof(MidiEventArray[i].Befehl.ScaleValue));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(MidiEventArray[i].Befehl.ArgInteger,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgInteger[j],sizeof(MidiEventArray[i].Befehl.ArgInteger[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(MidiEventArray[i].Befehl.ArgString,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgString[j],sizeof(MidiEventArray[i].Befehl.ArgString[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(MidiEventArray[i].Befehl.ArgGUID,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(MidiEventArray[i].Befehl.ArgGUID[j],sizeof(MidiEventArray[i].Befehl.ArgGUID[j]));

          Filestream.ReadBuffer(MidiEventArray[i].Data1orData2,sizeof(MidiEventArray[i].Data1orData2));
          Filestream.ReadBuffer(MidiEventArray[i].UseMidiBacktrack,sizeof(MidiEventArray[i].UseMidiBacktrack))
        end;
        FileStream.Free;
      end;
    end else
    begin
      // Ersetzen
      Openfile(OpenDialog1.Filename);
    end;

    if length(mainform.MidiEventArray)>0 then
    begin
      editmidievent.Enabled:=true;
      deletemidievent.Enabled:=true;
    end else
    begin
      editmidievent.Enabled:=false;
      deletemidievent.Enabled:=false;
    end;
	end;

  // komplette Liste aktualisieren
  MIDIGrid.RowCount:=length(mainform.MidiEventArray)+1;
  for i:=1 to MIDIGrid.rowcount-1 do
  begin
    refreshList(i);
  end;
end;

procedure Tmidieventfrm.SpeedButton1Click(Sender: TObject);
var
  i,j,Count,Count2:integer;
//  FileStream:TFileStream;
begin
  with mainform do
	if SaveDialog1.Execute then
  begin
    Filestream:=TFileStream.Create(SaveDialog1.FileName, fmCreate);
    Count:=length(MidiEventArray);
    Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
    begin
      Filestream.WriteBuffer(MidiEventArray[i].ID,sizeof(MidiEventArray[i].ID));
      Filestream.WriteBuffer(MidiEventArray[i].MIDIMessage,sizeof(MidiEventArray[i].MIDIMessage));
      Filestream.WriteBuffer(MidiEventArray[i].MIDIData1,sizeof(MidiEventArray[i].MIDIData1));
      Filestream.WriteBuffer(MidiEventArray[i].MIDIData2,sizeof(MidiEventArray[i].MIDIData2));

      Filestream.WriteBuffer(MidiEventArray[i].Befehl.Typ,sizeof(MidiEventArray[i].Befehl.Typ));
      Filestream.WriteBuffer(MidiEventArray[i].Befehl.OnValue,sizeof(MidiEventArray[i].Befehl.OnValue));
      Filestream.WriteBuffer(MidiEventArray[i].Befehl.SwitchValue,sizeof(MidiEventArray[i].Befehl.SwitchValue));
      Filestream.WriteBuffer(MidiEventArray[i].Befehl.InvertSwitchValue,sizeof(MidiEventArray[i].Befehl.InvertSwitchValue));
      Filestream.WriteBuffer(MidiEventArray[i].Befehl.OffValue,sizeof(MidiEventArray[i].Befehl.OffValue));
      Filestream.WriteBuffer(MidiEventArray[i].Befehl.ScaleValue,sizeof(MidiEventArray[i].Befehl.ScaleValue));
      Count2:=length(MidiEventArray[i].Befehl.ArgInteger);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(MidiEventArray[i].Befehl.ArgInteger[j],sizeof(MidiEventArray[i].Befehl.ArgInteger[j]));
      Count2:=length(MidiEventArray[i].Befehl.ArgString);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(MidiEventArray[i].Befehl.ArgString[j],sizeof(MidiEventArray[i].Befehl.ArgString[j]));
      Count2:=length(MidiEventArray[i].Befehl.ArgGUID);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(MidiEventArray[i].Befehl.ArgGUID[j],sizeof(MidiEventArray[i].Befehl.ArgGUID[j]));

      Filestream.WriteBuffer(MidiEventArray[i].Data1orData2,sizeof(MidiEventArray[i].Data1orData2));
      Filestream.WriteBuffer(MidiEventArray[i].UseMidiBacktrack,sizeof(MidiEventArray[i].UseMidiBacktrack));
    end;
    FileStream.Free;
  end;
end;

procedure Tmidieventfrm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrOk;
end;

procedure Tmidieventfrm.SendValueToSelCountEditChange(Sender: TObject);
var
  i:integer;
begin
  setlength(mainform.SendValueOfSelectedDevicesToMidi,round(SendValueToSelCountEdit.Value));
  SendValueToSelCombobox.Clear;
  for i:=0 to length(mainform.SendValueOfSelectedDevicesToMidi)-1 do
    SendValueToSelCombobox.Items.Add(inttostr(i+1));
end;

procedure Tmidieventfrm.SendValueToSelComboboxSelect(Sender: TObject);
begin
  SendValueToSelMSGEdit.text:=inttostr(mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].MSG);
  SendValueToSelData1Edit.text:=inttostr(mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].Data1);
  SendValueToSelData2Radiobox.checked:=mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].UseData2;
  SendValueToSelData1Edit.Enabled:=SendValueToSelData2Radiobox.Checked;
end;

procedure Tmidieventfrm.SendValueToSelMSGEditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].MSG:=strtoint(SendValueToSelMSGEdit.text);
end;

procedure Tmidieventfrm.SendValueToSelData1EditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].Data1:=strtoint(SendValueToSelData1Edit.text);
end;

procedure Tmidieventfrm.SendValueToSelData1RadioboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].UseData2:=SendValueToSelData2Radiobox.Checked;
  SendValueToSelData1Edit.Enabled:=SendValueToSelData2Radiobox.Checked;
end;

procedure Tmidieventfrm.SendValueToSelData1RadioboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].UseData2:=SendValueToSelData2Radiobox.Checked;
  SendValueToSelData1Edit.Enabled:=SendValueToSelData2Radiobox.Checked;
end;

procedure Tmidieventfrm.FlipEntry(Source, Destination:integer);
var
  i:integer;
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)+1);
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ID:=mainform.MidiEventArray[Source].ID;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIMessage:=mainform.MidiEventArray[Source].MIDIMessage;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIData1:=mainform.MidiEventArray[Source].MIDIData1;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIData2:=mainform.MidiEventArray[Source].MIDIData2;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Typ:=mainform.MidiEventArray[Source].Typ;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Wert1:=mainform.MidiEventArray[Source].Wert1;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Wert2:=mainform.MidiEventArray[Source].Wert2;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Arg3:=mainform.MidiEventArray[Source].Arg3;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Data1orData2:=mainform.MidiEventArray[Source].Data1orData2;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].UseMidiBacktrack:=mainform.MidiEventArray[Source].UseMidiBacktrack;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ExternMidiValue:=mainform.MidiEventArray[Source].ExternMidiValue;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ExternMidiSwitchState:=mainform.MidiEventArray[Source].ExternMidiSwitchState;

  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ID:=mainform.MidiEventArray[Source].Befehl.ID;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Typ:=mainform.MidiEventArray[Source].Befehl.Typ;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Name:=mainform.MidiEventArray[Source].Befehl.Name;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Beschreibung:=mainform.MidiEventArray[Source].Befehl.Beschreibung;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.OnValue:=mainform.MidiEventArray[Source].Befehl.OnValue;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.SwitchValue:=mainform.MidiEventArray[Source].Befehl.SwitchValue;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.InvertSwitchValue:=mainform.MidiEventArray[Source].Befehl.InvertSwitchValue;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.OffValue:=mainform.MidiEventArray[Source].Befehl.OffValue;
  mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ScaleValue:=mainform.MidiEventArray[Source].Befehl.ScaleValue;
  setlength(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgInteger, length(mainform.MidiEventArray[Source].Befehl.ArgInteger));
  for i:=0 to length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgInteger)-1 do
    mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgInteger[i]:=mainform.MidiEventArray[Source].Befehl.ArgInteger[i];
  setlength(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgString, length(mainform.MidiEventArray[Source].Befehl.ArgString));
  for i:=0 to length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgString)-1 do
    mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgString[i]:=mainform.MidiEventArray[Source].Befehl.ArgString[i];
  setlength(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgGUID, length(mainform.MidiEventArray[Source].Befehl.ArgGUID));
  for i:=0 to length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgGUID)-1 do
    mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgGUID[i]:=mainform.MidiEventArray[Source].Befehl.ArgGUID[i];

  // oberen Einträge aufrutschen
  mainform.MidiEventArray[Source].ID:=mainform.MidiEventArray[Destination].ID;
  mainform.MidiEventArray[Source].MIDIMessage:=mainform.MidiEventArray[Destination].MIDIMessage;
  mainform.MidiEventArray[Source].MIDIData1:=mainform.MidiEventArray[Destination].MIDIData1;
  mainform.MidiEventArray[Source].MIDIData2:=mainform.MidiEventArray[Destination].MIDIData2;
  mainform.MidiEventArray[Source].Typ:=mainform.MidiEventArray[Destination].Typ;
  mainform.MidiEventArray[Source].Wert1:=mainform.MidiEventArray[Destination].Wert1;
  mainform.MidiEventArray[Source].Wert2:=mainform.MidiEventArray[Destination].Wert2;
  mainform.MidiEventArray[Source].Arg3:=mainform.MidiEventArray[Destination].Arg3;
  mainform.MidiEventArray[Source].Data1orData2:=mainform.MidiEventArray[Destination].Data1orData2;
  mainform.MidiEventArray[Source].UseMidiBacktrack:=mainform.MidiEventArray[Destination].UseMidiBacktrack;
  mainform.MidiEventArray[Source].ExternMidiValue:=mainform.MidiEventArray[Destination].ExternMidiValue;
  mainform.MidiEventArray[Source].ExternMidiSwitchState:=mainform.MidiEventArray[Destination].ExternMidiSwitchState;

  mainform.MidiEventArray[Source].Befehl.ID:=mainform.MidiEventArray[Destination].Befehl.ID;
  mainform.MidiEventArray[Source].Befehl.Typ:=mainform.MidiEventArray[Destination].Befehl.Typ;
  mainform.MidiEventArray[Source].Befehl.Name:=mainform.MidiEventArray[Destination].Befehl.Name;
  mainform.MidiEventArray[Source].Befehl.Beschreibung:=mainform.MidiEventArray[Destination].Befehl.Beschreibung;
  mainform.MidiEventArray[Source].Befehl.OnValue:=mainform.MidiEventArray[Destination].Befehl.OnValue;
  mainform.MidiEventArray[Source].Befehl.SwitchValue:=mainform.MidiEventArray[Destination].Befehl.SwitchValue;
  mainform.MidiEventArray[Source].Befehl.InvertSwitchValue:=mainform.MidiEventArray[Destination].Befehl.InvertSwitchValue;
  mainform.MidiEventArray[Source].Befehl.OffValue:=mainform.MidiEventArray[Destination].Befehl.OffValue;
  mainform.MidiEventArray[Source].Befehl.ScaleValue:=mainform.MidiEventArray[Destination].Befehl.ScaleValue;
  setlength(mainform.MidiEventArray[Source].Befehl.ArgInteger, length(mainform.MidiEventArray[Destination].Befehl.ArgInteger));
  for i:=0 to length(mainform.MidiEventArray[Source].Befehl.ArgInteger)-1 do
    mainform.MidiEventArray[Source].Befehl.ArgInteger[i]:=mainform.MidiEventArray[Destination].Befehl.ArgInteger[i];
  setlength(mainform.MidiEventArray[Source].Befehl.ArgString, length(mainform.MidiEventArray[Destination].Befehl.ArgString));
  for i:=0 to length(mainform.MidiEventArray[Source].Befehl.ArgString)-1 do
    mainform.MidiEventArray[Source].Befehl.ArgString[i]:=mainform.MidiEventArray[Destination].Befehl.ArgString[i];
  setlength(mainform.MidiEventArray[Source].Befehl.ArgGUID, length(mainform.MidiEventArray[Destination].Befehl.ArgGUID));
  for i:=0 to length(mainform.MidiEventArray[Source].Befehl.ArgGUID)-1 do
    mainform.MidiEventArray[Source].Befehl.ArgGUID[i]:=mainform.MidiEventArray[Destination].Befehl.ArgGUID[i];

  // letzten Eintrag einfügen
  mainform.MidiEventArray[Destination].ID:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ID;
  mainform.MidiEventArray[Destination].MIDIMessage:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIMessage;
  mainform.MidiEventArray[Destination].MIDIData1:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIData1;
  mainform.MidiEventArray[Destination].MIDIData2:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].MIDIData2;
  mainform.MidiEventArray[Destination].Typ:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Typ;
  mainform.MidiEventArray[Destination].Wert1:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Wert1;
  mainform.MidiEventArray[Destination].Wert2:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Wert2;
  mainform.MidiEventArray[Destination].Arg3:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Arg3;
  mainform.MidiEventArray[Destination].Data1orData2:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Data1orData2;
  mainform.MidiEventArray[Destination].UseMidiBacktrack:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].UseMidiBacktrack;
  mainform.MidiEventArray[Destination].ExternMidiValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ExternMidiValue;
  mainform.MidiEventArray[Destination].ExternMidiSwitchState:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].ExternMidiSwitchState;

  mainform.MidiEventArray[Destination].Befehl.ID:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ID;
  mainform.MidiEventArray[Destination].Befehl.Typ:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Typ;
  mainform.MidiEventArray[Destination].Befehl.Name:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Name;
  mainform.MidiEventArray[Destination].Befehl.Beschreibung:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.Beschreibung;
  mainform.MidiEventArray[Destination].Befehl.OnValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.OnValue;
  mainform.MidiEventArray[Destination].Befehl.SwitchValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.SwitchValue;
  mainform.MidiEventArray[Destination].Befehl.InvertSwitchValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.InvertSwitchValue;
  mainform.MidiEventArray[Destination].Befehl.OffValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.OffValue;
  mainform.MidiEventArray[Destination].Befehl.ScaleValue:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ScaleValue;
  setlength(mainform.MidiEventArray[Destination].Befehl.ArgInteger, length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.MidiEventArray[Destination].Befehl.ArgInteger)-1 do
    mainform.MidiEventArray[Destination].Befehl.ArgInteger[i]:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgInteger[i];
  setlength(mainform.MidiEventArray[Destination].Befehl.ArgString, length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgString));
  for i:=0 to length(mainform.MidiEventArray[Destination].Befehl.ArgString)-1 do
    mainform.MidiEventArray[Destination].Befehl.ArgString[i]:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgString[i];
  setlength(mainform.MidiEventArray[Destination].Befehl.ArgGUID, length(mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.MidiEventArray[Destination].Befehl.ArgGUID)-1 do
    mainform.MidiEventArray[Destination].Befehl.ArgGUID[i]:=mainform.MidiEventArray[length(mainform.MidiEventArray)-1].Befehl.ArgGUID[i];
  setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)-1);
end;

procedure Tmidieventfrm.upBtnClick(Sender: TObject);
var
  i:integer;
begin
  if length(mainform.MidiEventArray)>0 then
  if MidiGrid.Row>1 then
  begin
    // nach unten verschieben
    FlipEntry(MidiGrid.Row-1,MidiGrid.Row-2);
    // Position mitführen
    MidiGrid.Row:=MidiGrid.Row-1;
  end;
  for i:=1 to MIDIGrid.rowcount-1 do
  begin
    refreshList(i);
  end;

  upBtn.enabled:=MidiGrid.Row>1;
  downBtn.enabled:=MidiGrid.Row<MidiGrid.RowCount-1;
end;

procedure Tmidieventfrm.downBtnClick(Sender: TObject);
var
  i:integer;
begin
  if length(mainform.MidiEventArray)>0 then
  if MidiGrid.Row<MidiGrid.RowCount-1 then
  begin
    // nach unten verschieben
    FlipEntry(MidiGrid.Row-1,MidiGrid.Row);
    // Position mitführen
    MidiGrid.Row:=MidiGrid.Row+1;
  end;
  for i:=1 to MIDIGrid.rowcount-1 do
  begin
    refreshList(i);
  end;

  upBtn.enabled:=MidiGrid.Row>1;
  downBtn.enabled:=MidiGrid.Row<MidiGrid.RowCount-1;
end;

procedure Tmidieventfrm.MIDIResetBtnClick(Sender: TObject);
begin
  mainform.MidiOutput1.Close;
  mainform.MidiInput1.Close;

  mainform.startmidiin(nil);
  mainform.startmidiout(nil);
end;

procedure Tmidieventfrm.midiindevicelistChange(Sender: TObject);
var
  i:integer;
	thisControl: TMidiInput;
begin
  mainform.lastmidiinputdevices:='';

  for i:=0 to midiindevicelist.Items.Count-1 do
  begin
    thisControl:=mainform.MidiInControls[i];

    if midiindevicelist.Checked[i] then
    begin
      if length(mainform.lastmidiinputdevices)>0 then
        mainform.lastmidiinputdevices:=mainform.lastmidiinputdevices+','+thisControl.ProductName
      else
        mainform.lastmidiinputdevices:=thisControl.ProductName;

      thisControl.Stop;
      thisControl.Close;
      thisControl.Open;
      thisControl.Start;
      thisControl.Capacity:=1024;
    end else
    begin
      thisControl.Stop;
      thisControl.Close;
    end;
  end;
end;

procedure Tmidieventfrm.okbtnClick(Sender: TObject);
begin
  close;
end;

procedure Tmidieventfrm.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  mainform.UseMidiBackTrack:=CheckBox1.checked;

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
        LReg.WriteBool('Use Midi Backtrack',mainform.UseMidiBackTrack);
      end;
    end;
  end;
end;

procedure Tmidieventfrm.midioutdevicelistChange(Sender: TObject);
var
  i:integer;
	thisControl: TMidiOutput;
begin
  mainform.lastmidioutputdevices:='';

  for i:=0 to midioutdevicelist.Items.Count-1 do
  begin
    thisControl:=mainform.MidioutControls[i];

    if midioutdevicelist.Checked[i] then
    begin
      if length(mainform.lastmidioutputdevices)>0 then
        mainform.lastmidioutputdevices:=mainform.lastmidioutputdevices+','+thisControl.ProductName
      else
        mainform.lastmidioutputdevices:=thisControl.ProductName;

      thisControl.Close;
      thisControl.Open;
      thisControl.SetVolume(65535,65535);
    end else
    begin
      thisControl.Close;
    end;
  end;
end;

procedure Tmidieventfrm.Button1Click(Sender: TObject);
begin
  mainform.SendMidi(144, 64, 64);
  ShowMessage(_('Es wurde eine Note (MSG=144, Data1=64) mit der Lautstärke 64 (Data2=64) gesendet.'+#13#10+'Nach Klick auf "OK" wird diese Note wieder ausgeschaltet (MSG=144, Data1=64, Data2=0).'));
  mainform.SendMidi(144, 64, 0);
end;

procedure Tmidieventfrm.UseControl7MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  mainform.UseControl7ForLevel:=UseControl7.Checked;

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
        LReg.WriteBool('Use Midi Control7',mainform.UseControl7ForLevel);
      end;
    end;
  end;

  Label12.enabled:=UseControl7.Checked;
  MidiChannelControlBox.enabled:=UseControl7.Checked;
  MidiChannelControlEdit.enabled:=UseControl7.Checked;
end;

procedure Tmidieventfrm.UseMIDIThruMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  mainform.UseMIDIThru:=UseMIDIThru.checked;

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
        LReg.WriteBool('Use Midi Thru',mainform.UseMIDIThru);
      end;
    end;
  end;
end;

procedure Tmidieventfrm.Timer1Timer(Sender: TObject);
begin
  midieventfrm.Message1b.caption:=inttostr(mainform.LastMidiMSG);
  midieventfrm.Data1b.caption:=inttostr(mainform.LastMidiData1);
  midieventfrm.Data2b.caption:=inttostr(mainform.LastMidiData2);

  if (recordbox.Checked) and ((LocalLastMidiMSG<>mainform.LastMidiMSG) or (LocalLastMidiData1<>mainform.LastMidiData1) or (LocalLastMidiData2<>mainform.LastMidiData2)) then
  begin
    recordbox.Checked:=false;

    SendValueToSelMSGEdit.Text:=inttostr(mainform.LastMidiMSG);
    mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].MSG:=strtoint(SendValueToSelMSGEdit.text);

    if SendValueToSelData2Radiobox.Checked then
    begin
      SendValueToSelData1Edit.Text:=inttostr(mainform.LastMidiData1);
      mainform.SendValueOfSelectedDevicesToMidi[SendValueToSelCombobox.ItemIndex].Data1:=strtoint(SendValueToSelData1Edit.text);
    end;
  end;

  LocalLastMidiMSG:=mainform.LastMidiMSG;
  LocalLastMidiData1:=mainform.LastMidiData1;
  LocalLastMidiData2:=mainform.LastMidiData2;
end;

procedure Tmidieventfrm.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure Tmidieventfrm.MidiChannelControlBoxSelect(Sender: TObject);
begin
  MidiChannelControlEdit.Value:=mainform.LastMIDIController[MidiChannelControlBox.Itemindex+1];
end;

procedure Tmidieventfrm.MidiChannelControlEditChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  if (MidiChannelControlBox.Itemindex>-1) and (MidiChannelControlBox.Itemindex<16) then
    mainform.LastMIDIController[MidiChannelControlBox.Itemindex+1]:=round(MidiChannelControlEdit.Value);

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
        LReg.WriteInteger('Midi Control Channel '+inttostr(MidiChannelControlBox.Itemindex+1),mainform.LastMIDIController[MidiChannelControlBox.Itemindex+1]);
      end;
    end;
  end;
end;

procedure Tmidieventfrm.MIDIGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  upBtn.enabled:=MidiGrid.Row>1;
  downBtn.enabled:=MidiGrid.Row<MidiGrid.RowCount;
end;

procedure Tmidieventfrm.MIDIGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  upBtn.enabled:=MidiGrid.Row>1;
  downBtn.enabled:=(MidiGrid.Row<MidiGrid.RowCount-1);
end;

procedure Tmidieventfrm.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tmidieventfrm.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tmidieventfrm.CreateParams(var Params:TCreateParams);
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
