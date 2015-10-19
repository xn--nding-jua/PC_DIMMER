unit midievent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons;

type
  Tmidieventfrm = class(TForm)
    GroupBox1: TGroupBox;
    okbtn: TButton;
    MIDIGrid: TStringGrid;
    addmidievent: TButton;
    deletemidievent: TButton;
    editmidievent: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
		procedure refreshList(line: integer);
    procedure editmidieventClick(Sender: TObject);
    procedure addmidieventClick(Sender: TObject);
    procedure deletemidieventClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MIDIGridDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  midieventfrm: Tmidieventfrm;

implementation

uses main, editmidievent;

{$R *.dfm}

procedure Tmidieventfrm.FormCreate(Sender: TObject);
begin
	midigrid.Cells[0,0]:=_('Message');
  midigrid.cells[1,0]:=_('Data1');
  midigrid.cells[2,0]:=_('Data2');
  midigrid.cells[3,0]:=_('Typ');
  midigrid.cells[4,0]:=_('Wert1');
  midigrid.cells[5,0]:=_('Wert2');
  midigrid.cells[6,0]:=_('Data1/2');
  midigrid.ColWidths[0]:=50;
  midigrid.ColWidths[1]:=50;
  midigrid.ColWidths[2]:=50;
  midigrid.ColWidths[3]:=120;
  midigrid.ColWidths[4]:=50;
  midigrid.ColWidths[5]:=50;
  midigrid.ColWidths[6]:=50;
  midigrid.ColWidths[7]:=15;
end;

procedure Tmidieventfrm.refreshList(line: integer);
begin
		MIDIGrid.cells[0,line]:=inttostr(mainform.MidiEventArray[line-1][1]);	// Message

    if mainform.MidiEventArray[line-1][7]=2 then
		begin
    	MIDIGrid.cells[1,line]:=inttostr(mainform.MidiEventArray[line-1][2]);	// Data1
      MIDIGrid.cells[2,line]:='-';
    end else
    begin
      MIDIGrid.cells[1,line]:='-';
			MIDIGrid.cells[2,line]:='-';//inttostr(mainform.MidiEventArray[line-1][3]);	// Data2
    end;

		case mainform.MidiEventArray[line-1][4] of				// Typ
			0: MIDIGrid.cells[3,line]:='Pan';
			1: MIDIGrid.cells[3,line]:='Tilt';
		end;
		MIDIGrid.cells[4,line]:=inttostr(mainform.MidiEventArray[line-1][5]);	// Wert1
		MIDIGrid.cells[5,line]:=inttostr(mainform.MidiEventArray[line-1][6]);	// Wert2
		if mainform.MidiEventArray[line-1][7]=1 then				// Data1 oder Data2
			MIDIGrid.cells[6,line]:=_('Data 1')
		else
			MIDIGrid.cells[6,line]:=_('Data 2');
end;

procedure Tmidieventfrm.editmidieventClick(Sender: TObject);
begin
	// Werte an EditForm übergeben
	EditMIDIEVENTfrm.Message1a.caption:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1][1]);
	EditMIDIEVENTfrm.Data1a.caption:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1][2]);
	EditMIDIEVENTfrm.Data2a.caption:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1][3]);
	EditMIDIEVENTfrm.typ.itemindex:=mainform.MidiEventArray[MIDIGrid.row-1][4];
  EditMIDIEVENTfrm.typChange(Sender);
	EditMIDIEVENTfrm.wert1.text:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1][5]);
  EditMIDIEVENTfrm.ComboBox1.ItemIndex:=mainform.MidiEventArray[MIDIGrid.row-1][5];
	EditMIDIEVENTfrm.wert2.text:=inttostr(mainform.MidiEventArray[MIDIGrid.row-1][6]);
	EditMIDIEVENTfrm.data1chk.checked:=(mainform.MidiEventArray[MIDIGrid.row-1][7]=1);
	EditMIDIEVENTfrm.data2chk.checked:=(mainform.MidiEventArray[MIDIGrid.row-1][7]=2);

	// Editform anzeigen
	EditMIDIEVENTfrm.Showmodal;

	// Werte bei "OK" in Array kopieren und Liste aktualisieren
	if EditMIDIEVENTfrm.modalresult=mrOK then
	begin
		mainform.MidiEventArray[MIDIGrid.row-1][1] := strtoint(EditMIDIEVENTfrm.Message1a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][2] := strtoint(EditMIDIEVENTfrm.Data1a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][3] := strtoint(EditMIDIEVENTfrm.Data2a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][4] := EditMIDIEVENTfrm.typ.itemindex;
		mainform.MidiEventArray[MIDIGrid.row-1][5] := strtoint(EditMIDIEVENTfrm.wert1.text);
		mainform.MidiEventArray[MIDIGrid.row-1][6] := strtoint(EditMIDIEVENTfrm.wert2.text);
    if EditMIDIEVENTfrm.data1chk.checked then
    	mainform.MidiEventArray[MIDIGrid.row-1][7] := 1
    else
    	mainform.MidiEventArray[MIDIGrid.row-1][7] := 2;

		refreshList(MIDIGrid.row);
	end;
end;

procedure Tmidieventfrm.addmidieventClick(Sender: TObject);
begin
	// EditForm zurücksetzen
	EditMIDIEVENTfrm.Message1a.caption:='0';
	EditMIDIEVENTfrm.Data1a.caption:='0';
	EditMIDIEVENTfrm.Data2a.caption:='0';
//	EditMIDIEVENTfrm.typ.itemindex:=0;
	EditMIDIEVENTfrm.wert1.text:='0';
	EditMIDIEVENTfrm.wert2.text:='0';
	EditMIDIEVENTfrm.data2chk.checked:=true;

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
		mainform.MidiEventArray[MIDIGrid.row-1][1] := strtoint(EditMIDIEVENTfrm.Message1a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][2] := strtoint(EditMIDIEVENTfrm.Data1a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][3] := strtoint(EditMIDIEVENTfrm.Data2a.caption);
		mainform.MidiEventArray[MIDIGrid.row-1][4] := EditMIDIEVENTfrm.typ.itemindex;
		mainform.MidiEventArray[MIDIGrid.row-1][5] := strtoint(EditMIDIEVENTfrm.wert1.text);
		mainform.MidiEventArray[MIDIGrid.row-1][6] := strtoint(EditMIDIEVENTfrm.wert2.text);
    if EditMIDIEVENTfrm.data1chk.checked then
			mainform.MidiEventArray[MIDIGrid.row-1][7] := 1
    else
    	mainform.MidiEventArray[MIDIGrid.row-1][7] := 2;

   	deletemidievent.Enabled:=true;
    editmidievent.Enabled:=true;

		refreshList(MIDIGrid.row);
	end;
end;

procedure Tmidieventfrm.deletemidieventClick(Sender: TObject);
var
	i,j:integer;
begin
	// Ab aktueller Position alle nachfolgenden Einträge um eins nach oben kopieren
	for i:=MIDIGrid.row to MIDIGrid.rowcount-1 do
	begin
		for j:=1 to 7 do
			mainform.MidiEventArray[i-1][j]:=mainform.MidiEventArray[i][j];
	end;

	// Letzten Eintrag löschen
	setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)-1);

  if MIDIGrid.RowCount>2 then
	begin
  	MIDIGrid.rowcount:=MIDIGrid.rowcount-1;
		// komplette Liste aktualisieren
		for i:=1 to MIDIGrid.rowcount do
		begin
			refreshList(i);
		end;
	end else
  begin
		MIDIGrid.cells[0,1]:='';
		MIDIGrid.cells[1,1]:='';
		MIDIGrid.cells[2,1]:='';
		MIDIGrid.cells[3,1]:='';
		MIDIGrid.cells[4,1]:='';
		MIDIGrid.cells[5,1]:='';
		MIDIGrid.cells[6,1]:='';
  	deletemidievent.Enabled:=false;
    editmidievent.Enabled:=false;
  end;
end;

procedure Tmidieventfrm.FormShow(Sender: TObject);
begin
  MIDIGrid.RowHeights[0]:=15;
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

		MIDIGrid.cells[0,1]:='';
		MIDIGrid.cells[1,1]:='';
		MIDIGrid.cells[2,1]:='';
		MIDIGrid.cells[3,1]:='';
		MIDIGrid.cells[4,1]:='';
		MIDIGrid.cells[5,1]:='';
		MIDIGrid.cells[6,1]:='';
	 	deletemidievent.Enabled:=false;
	  editmidievent.Enabled:=false;
	end;
end;

procedure Tmidieventfrm.SpeedButton2Click(Sender: TObject);
var
  CSV:TStrings;
  temp:string;
  i:integer;
begin
  i:=0;
  if OpenDialog1.Execute then
  begin
  // MIDI-Ereignisse aus CSV-Datei lesen
  try
	  CSV := TStringlist.Create;
	  CSV.LoadFromFile(OpenDialog1.FileName);
	  if csv.Count>0 then
	  begin
		  setlength(mainform.MidiEventArray,csv.Count);
	  	MIDIGrid.RowCount:=csv.Count+1;

		  For i:=0 To length(mainform.MidiEventArray)-1 do
		  begin
		    temp:=CSV.Strings[i];
		    mainform.MidiEventArray[i][1]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][2]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][3]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][4]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][5]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][6]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    mainform.MidiEventArray[i][7]:=strtoint(temp);
		    MIDIGrid.RowHeights[i+1]:=15;
		  	refreshList(i+1);
		  end;
		  CSV.Free;
	  end;
  except
  	ShowMessage(_('Beim Laden der Datei "')+OpenDialog1.FileName+_('" ist ein Fehler in Zeile ')+inttostr(i+1)+_(' aufgetreten. Die MIDI-Einstellungen können unter Umständen nicht korrekt geladen werden.'));

		// Letzten Eintrag löschen
		setlength(mainform.MidiEventArray,length(mainform.MidiEventArray)-1);
	  if MIDIGrid.RowCount>2 then
		begin
	  	MIDIGrid.rowcount:=MIDIGrid.rowcount-1;
			// komplette Liste aktualisieren
			for i:=1 to MIDIGrid.rowcount do
			begin
				refreshList(i);
			end;
		end else
	  begin
			MIDIGrid.cells[0,1]:='';
			MIDIGrid.cells[1,1]:='';
			MIDIGrid.cells[2,1]:='';
			MIDIGrid.cells[3,1]:='';
			MIDIGrid.cells[4,1]:='';
			MIDIGrid.cells[5,1]:='';
			MIDIGrid.cells[6,1]:='';
	  	deletemidievent.Enabled:=false;
	    editmidievent.Enabled:=false;
	  end;
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
end;

procedure Tmidieventfrm.SpeedButton1Click(Sender: TObject);
var
  i:integer;
  CSV : TStrings;
begin
	if SaveDialog1.Execute then
  begin
	  // MIDI-Ereignisse in CSV-Datei schreiben
	  CSV := TStringlist.Create;
	  For i :=0 To length(mainform.MidiEventArray)-1 do
	  	CSV.Add(inttostr(mainform.MidiEventArray[i][1])+','+inttostr(mainform.MidiEventArray[i][2])+','+inttostr(mainform.MidiEventArray[i][3])+','+inttostr(mainform.MidiEventArray[i][4])+','+inttostr(mainform.MidiEventArray[i][5])+','+inttostr(mainform.MidiEventArray[i][6])+','+inttostr(mainform.MidiEventArray[i][7]));
	  CSV.SaveToFile(SaveDialog1.FileName);
	  CSV.Free;
  end;
end;

end.
