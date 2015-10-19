unit Tastenabfragefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, szenenverwaltung, Menus, Mask,
  JvExMask, JvSpin, Buttons, PngBitBtn, ExtCtrls, gnugettext;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

{
  TBefehl = record
    ID : TGUID;
    Typ : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    OnValue : Word;
    OffValue : Word;
    ArgInteger : array of Integer;
    ArgString : array of string[255];
    ArgGUID : array of TGUID;
  end;
}

  TBefehlposition = record
    GUID:TGUID;
    Bezeichnung:string;
    IntegerArgCount:Word;
    StringArgCount:Word;
    GUIDArgCount:Word;
    PositionCombobox2: integer;
  end;

  TTastenabfrage = class(TForm)
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    EnableHotKeys: TCheckBox;
    keycheckinterval: TJvSpinEdit;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Button3: TPngBitBtn;
    Button4: TPngBitBtn;
    RestoreDefautKeymapBtn: TPngBitBtn;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    upBtn: TPngBitBtn;
    downBtn: TPngBitBtn;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    ZeitBox: TGroupBox;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    hEdit: TEdit;
    minEdit: TEdit;
    sEdit: TEdit;
    msEdit: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Optionen1Box: TGroupBox;
    Arg1Label: TLabel;
    Arg1Edit: TEdit;
    Arg1Combobox: TComboBox;
    Optionen2Box: TGroupBox;
    Arg2Label: TLabel;
    Arg2Edit: TEdit;
    Arg2Combobox: TComboBox;
    devicelist: TComboBox;
    Optionen3Box: TGroupBox;
    Arg3Label: TLabel;
    Arg3Edit: TEdit;
    Arg3Combobox: TComboBox;
    grouplist: TComboBox;
    effektlist: TComboBox;
    HotKey1: THotKey;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    KeyDownValue: TJvSpinEdit;
    KeyUpValue: TJvSpinEdit;
    Label6: TLabel;
    Label8: TLabel;
    OnValue: TJvSpinEdit;
    OffValue: TJvSpinEdit;
    Shape4: TShape;
    Shape1: TShape;
    SwitchValue: TJvSpinEdit;
    ScaleValue: TCheckBox;
    InvertSwitchValue: TCheckBox;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure HotKey1Change(Sender: TObject);
    procedure RefreshGrid;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure EnableHotKeysMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure keycheckintervalChange(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RestoreDefautKeymapBtnClick(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure downBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure hEditChange(Sender: TObject);
    procedure Arg1EditChange(Sender: TObject);
    procedure Arg2EditChange(Sender: TObject);
    procedure Arg2bEditChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Arg1ComboboxSelect(Sender: TObject);
    procedure Arg2ComboboxSelect(Sender: TObject);
    procedure Arg3ComboboxSelect(Sender: TObject);
    procedure devicelistSelect(Sender: TObject);
    procedure grouplistSelect(Sender: TObject);
    procedure effektlistSelect(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FillTimeBox(time: integer);
    procedure Arg3EditChange(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KeyDownValueChange(Sender: TObject);
    procedure KeyUpValueChange(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure SwitchValueChange(Sender: TObject);
  private
    { Private-Deklarationen }
    nousersetting:boolean;
    ManualEditingOfCombobox2:boolean;
    Befehlposition:array of TBefehlposition;
    midisettings:boolean;
//    FileStream:TFileStream;
    procedure FlipEntry(Source, Destination:integer);
  public
    { Public-Deklarationen }
    lastrow:integer;
    procedure RestoreDefautKeymap;
  end;

var
  Tastenabfrage: TTastenabfrage;

implementation

uses PCDIMMER, befehleditorform, beatfrm, joysticksetupfrm;

{$R *.dfm}

procedure TTastenabfrage.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  with StringGrid1.Canvas do
  begin
    if Rect.Top = 0 then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Pen.Color := clWhite;
      Rectangle(Rect);
      TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
      Exit;
    end;

    if (ACol=Stringgrid1.Col) and (ARow=Stringgrid1.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);

    if (ARow>0) and ((ACol = 0) or (ACol = 3) or (ACol = 4) or (ACol = 5)) then
    begin
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if (ARow>0) and (ARow<=length(mainform.TastencodeArray)) and (ACol = 0) then
      if mainform.TastencodeArray[ARow-1].active then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;

      // Abfrage ob Haken zeichnen oder nicht
      if (ARow>0) and (ARow<=length(mainform.TastencodeArray)) and (ACol = 3) then
      if mainform.TastencodeArray[ARow-1].Global then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clRed; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;

      if (ARow>0) and (ARow<=length(mainform.TastencodeArray)) and (ACol = 4) then
      if mainform.TastencodeArray[ARow-1].Repeated then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;

      if (ARow>0) and (ARow<=length(mainform.TastencodeArray)) and (ACol = 5) then
      if mainform.TastencodeArray[ARow-1].UseKeyUp then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;
    end;
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure TTastenabfrage.FormShow(Sender: TObject);
begin
//  mainform.ShortCutChecker.Enabled:=false;
  Keycheckinterval.Value:=mainform.ShortCutChecker.Interval;

  if length(mainform.TastencodeArray)+1>1 then
    StringGrid1.RowCount:=length(mainform.TastencodeArray)+1
  else
    StringGrid1.RowCount:=2;
  Stringgrid1.FixedRows:=1;

  StringGrid1.Enabled:=(length(mainform.TastencodeArray)>0);
  Button4.Enabled:=(length(mainform.TastencodeArray)>0);
  upBtn.enabled:=StringGrid1.Row>1;
  downBtn.enabled:=StringGrid1.Row<StringGrid1.RowCount-1;
  Combobox1.Enabled:=(length(mainform.TastencodeArray)>0);
  Combobox2.Enabled:=(length(mainform.TastencodeArray)>0);
  Hotkey1.Enabled:=(length(mainform.TastencodeArray)>0);

  StringGrid1.Row:=1;
	stringgrid1.Cols[1].Strings[0]:=_('Tastencode');
	stringgrid1.Cols[2].Strings[0]:=_('Typ');
	stringgrid1.Cols[3].Strings[0]:=_('Global');
	stringgrid1.Cols[4].Strings[0]:=_('Repeat');
	stringgrid1.Cols[5].Strings[0]:=_('KeyUp');
	stringgrid1.Cols[6].Strings[0]:=_('Aktuell');
  StringGrid1.Col:=1;

  if lastrow<StringGrid1.RowCount then
  begin
    StringGrid1.Row:=lastrow;
    StringGrid1MouseUp(nil, mbLeft, [], 0, 0);
  end else
  begin
    StringGrid1.Row:=1;
    StringGrid1MouseUp(nil, mbLeft, [], 0, 0);
  end;
end;

procedure TTastenabfrage.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,j:integer;
begin
  if StringGrid1.Row>0 then
  begin
    if StringGrid1.Col=0 then
    begin
  	  if Shift=[ssCtrl] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].active:=true;
      end else if Shift=[ssAlt] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].active:=false;
      end else
    	begin
  			mainform.TastencodeArray[Stringgrid1.Row-1].active:=not mainform.TastencodeArray[StringGrid1.Row-1].active;
  	  end;
      StringGrid1.Refresh;
    end;

    if StringGrid1.Col=3 then
    begin
    	if Shift=[ssCtrl] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].Global:=true;
      end else if Shift=[ssAlt] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].Global:=false;
      end else
    	begin
		  	mainform.TastencodeArray[Stringgrid1.Row-1].Global:=not mainform.TastencodeArray[StringGrid1.Row-1].Global;
  	  end;
      StringGrid1.Refresh;
    end;

    if StringGrid1.Col=4 then
    begin
    	if Shift=[ssCtrl] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].Repeated:=true;
      end else if Shift=[ssAlt] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].Repeated:=false;
      end else
    	begin
		  	mainform.TastencodeArray[Stringgrid1.Row-1].Repeated:=not mainform.TastencodeArray[StringGrid1.Row-1].Repeated;
  	  end;
      StringGrid1.Refresh;
    end;

    if StringGrid1.Col=5 then
    begin
    	if Shift=[ssCtrl] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].UseKeyUp:=true;
      end else if Shift=[ssAlt] then
      begin
      	for i:=0 to length(mainform.TastencodeArray)-1 do
        	mainform.TastencodeArray[i].UseKeyUp:=false;
      end else
    	begin
		  	mainform.TastencodeArray[Stringgrid1.Row-1].UseKeyUp:=not mainform.TastencodeArray[StringGrid1.Row-1].UseKeyUp;
  	  end;
      StringGrid1.Refresh;
    end;

    if (Stringgrid1.Row>0) and (length(mainform.TastencodeArray)>0) then
    begin
      HotKey1.HotKey:=mainform.TastencodeArray[Stringgrid1.Row-1].Hotkey;

      nousersetting:=true;
      Edit1.text:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Name;
      Edit2.text:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Beschreibung;

      Checkbox1.checked:=mainform.TastencodeArray[Stringgrid1.Row-1].Repeated;
      Checkbox2.checked:=mainform.TastencodeArray[Stringgrid1.Row-1].UseKeyUp;

      KeyDownValue.value:=mainform.TastencodeArray[Stringgrid1.Row-1].KeyDownValue;
      KeyUpValue.value:=mainform.TastencodeArray[Stringgrid1.Row-1].KeyUpValue;
      KeyUpValue.Enabled:=mainform.TastencodeArray[Stringgrid1.Row-1].UseKeyUp;
      Label6.Enabled:=mainform.TastencodeArray[Stringgrid1.Row-1].UseKeyUp;
    end;
    
    devicelist.items.clear;
    for i:=0 to length(mainform.devices)-1 do
      devicelist.items.add(mainform.devices[i].Name);

    grouplist.items.clear;
    for i:=0 to length(mainform.DeviceGroups)-1 do
      grouplist.items.add(mainform.DeviceGroups[i].Name);

    effektlist.items.clear;
    for i:=0 to length(mainform.effektsequenzereffekte)-1 do
      effektlist.items.add(mainform.effektsequenzereffekte[i].name);

    Combobox1.Items.Clear;
    for i:=0 to length(mainform.Befehlssystem)-1 do
    begin
      Combobox1.Items.Add(mainform.Befehlssystem[i].Programmteil);
    end;

    if (Stringgrid1.Row>0) and (length(mainform.TastencodeArray)>0) then
    begin
      // Aktuellen Befehl anzeigen
      for i:=0 to length(mainform.Befehlssystem)-1 do
      begin
        for j:=0 to length(mainform.Befehlssystem[i].Steuerung)-1 do
        begin
          if IsEqualGUID(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Typ, mainform.Befehlssystem[i].Steuerung[j].GUID) then
          begin
            Combobox1.ItemIndex:=i;
            ComboBox1Select(nil); // über Combobox1.Select wird Combobox2 gefüllt
            break;
          end;
        end;
      end;
    end;
    nousersetting:=false;
  end;

  upBtn.enabled:=StringGrid1.Row>1;
  downBtn.enabled:=StringGrid1.Row<StringGrid1.RowCount-1;
  RefreshGrid;
end;

procedure TTastenabfrage.Button3Click(Sender: TObject);
begin
  setlength(mainform.TastencodeArray,length(mainform.TastencodeArray)+1);
  setlength(mainform.TastencodePressedArray,length(mainform.TastencodePressedArray)+1);
  CreateGUID(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].ID);
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OnValue:=255;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.SwitchValue:=128;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OffValue:=0;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].KeyDownValue:=255;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].KeyUpValue:=0;

  StringGrid1.RowCount:=length(mainform.TastencodeArray)+1;
  StringGrid1.Enabled:=(length(mainform.TastencodeArray)>0);
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].active:=true;
  Button4.Enabled:=(length(mainform.TastencodeArray)>0);
  Combobox1.Enabled:=(length(mainform.TastencodeArray)>0);
  Combobox2.Enabled:=(length(mainform.TastencodeArray)>0);
  Hotkey1.Enabled:=(length(mainform.TastencodeArray)>0);
  RefreshGrid;

  // Letzte Zeile selektieren
  StringGrid1.Row:=StringGrid1.RowCount-1;
  StringGrid1MouseUp(nil, mbLeft, [], 0, 0);
end;

procedure TTastenabfrage.Button4Click(Sender: TObject);
var
  i:integer;
begin
  if length(mainform.TastencodeArray)>1 then
  begin
    // Alle nachfolgenden Elemente um eins nach vorne kopieren
    for i:=StringGrid1.Row-1 to length(mainform.TastencodeArray)-2 do
    begin
      mainform.TastencodeArray[i]:=mainform.TastencodeArray[i+1];
    end;
  end;

  if length(mainform.TastencodeArray)>0 then
  begin
    setlength(mainform.TastencodeArray,length(mainform.TastencodeArray)-1);
    setlength(mainform.TastencodePressedArray,length(mainform.TastencodePressedArray)-1);
    Tastenabfrage.StringGrid1.RowCount:=length(mainform.TastencodeArray)+1;
    Tastenabfrage.StringGrid1.Enabled:=(length(mainform.TastencodeArray)>0);
  end;
  Button4.Enabled:=(length(mainform.TastencodeArray)>0);
  Combobox1.Enabled:=(length(mainform.TastencodeArray)>0);
  Combobox2.Enabled:=(length(mainform.TastencodeArray)>0);
  Hotkey1.Enabled:=(length(mainform.TastencodeArray)>0);

  RefreshGrid;

  // Letzte Zeile selektieren
  StringGrid1.Row:=StringGrid1.RowCount-1;
  StringGrid1MouseUp(nil, mbLeft, [], 0, 0);
end;

procedure TTastenabfrage.HotKey1Change(Sender: TObject);
var
  i, count:integer;
  keyexists:boolean;
begin
  if Sender=HotKey1 then
  begin
    keyexists:=false;
    count:=0;
    for i:=0 to length(mainform.TastencodeArray)-1 do
    begin
      if mainform.TastencodeArray[i].Hotkey=Hotkey1.HotKey then
      begin
        keyexists:=true;
        count:=count+1;
      end;
    end;
    if keyexists then
      if messagedlg(_('Dieser Hotkey ist bereits ')+inttostr(count)+_('x vergeben. Soll er ein ')+inttostr(count+1)+_('. mal vergeben werden?'),mtConfirmation,
        [mbYes,mbNo],0)=mrNo then exit;

    mainform.TastencodeArray[Stringgrid1.Row-1].Hotkey:=Hotkey1.HotKey;
    RefreshGrid;
  end;
end;

procedure TTastenabfrage.RefreshGrid;
var
  i,j,k:integer;
  text:string;
begin
  for i:=1 to Stringgrid1.RowCount-1 do
  begin
    if i>length(mainform.TastencodeArray) then exit;

  	stringgrid1.Cols[1].Strings[i]:=ShortCutToText(mainform.TastencodeArray[i-1].Hotkey);

    for k:=0 to length(mainform.Befehlssystem)-1 do
    begin
      for j:=0 to length(mainform.Befehlssystem[k].Steuerung)-1 do
      begin
        if IsEqualGUID(mainform.Befehlssystem[k].Steuerung[j].GUID, mainform.TastencodeArray[i-1].Befehl.Typ) then
        begin
          stringgrid1.Cols[2].Strings[i]:=mainform.Befehlssystem[k].Programmteil+': '+mainform.Befehlssystem[k].Steuerung[j].Bezeichnung;
          if length(mainform.TastencodeArray[i-1].Befehl.ArgGUID)>0 then
          begin
            mainform.GetInfo(mainform.TastencodeArray[i-1].Befehl.ArgGUID[0], text);
            if text<>'' then
              stringgrid1.cols[2].Strings[i]:=stringgrid1.cols[2].Strings[i]+' ('+text+')';
          end;
          break;
        end;
      end;
    end;
  end;
  StringGrid1.Repaint;
end;

procedure TTastenabfrage.EnableHotKeysMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.EnableHotKeys:=EnableHotKeys.Checked;
  mainform.ShortCutChecker.Enabled:=EnableHotKeys.Checked;
end;

procedure TTastenabfrage.FormHide(Sender: TObject);
begin
  mainform.ShortCutChecker.Enabled:=EnableHotKeys.Checked;
end;

procedure TTastenabfrage.keycheckintervalChange(Sender: TObject);
begin
  if Sender=keycheckinterval then
    mainform.ShortCutChecker.Interval:=round(Keycheckinterval.Value);
end;

procedure TTastenabfrage.SpeedButton3Click(Sender: TObject);
begin
if messagedlg(_('Möchten Sie wirklich alle ShortCuts löschen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    setlength(mainform.TastencodeArray,0);
    setlength(mainform.TastencodePressedArray,0);
    StringGrid1.RowCount:=2;
    StringGrid1.Cells[1,1]:='-';
    StringGrid1.Cells[2,1]:='-';
    StringGrid1.Cells[6,1]:='-';
    FormShow(nil);
    RefreshGrid;
  end;
end;

procedure TTastenabfrage.SpeedButton2Click(Sender: TObject);
var
  i,j,startindex,Count,Count2:integer;
  additiv:boolean;
//  Filestream:TFilestream;
begin
  additiv:=true;

	case mainform.mymessagedlg(_('Wie sollen die Tasten-Einstellungen aus der Datei geladen werden?'),mtConfirmation,[mbYes,mbAll,mbCancel],[_('&Hinzufügen'),_('&Ersetzen'),_('Ab&brechen')]) of
    mrYes: additiv:=true;
    mrCancel: additiv:=false;
    mrAll: exit;
  end;

  if OpenDialog1.Execute then
  begin
    mainform.ShortCutChecker.Enabled:=false;

    if additiv then
    begin
      // Hinzufügen
      startindex:=length(mainform.TastencodeArray)-1;

      with mainform do
      begin
        Filestream:=TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(TastencodeArray,Count+startindex+1);
        setlength(TastencodePressedArray, Count+startindex+1);
        for i:=startindex+1 to length(TastencodeArray)-1 do
        begin
          Filestream.ReadBuffer(TastencodeArray[i].ID,sizeof(TastencodeArray[i].ID));
          Filestream.ReadBuffer(TastencodeArray[i].active,sizeof(TastencodeArray[i].active));
          Filestream.ReadBuffer(TastencodeArray[i].Hotkey,sizeof(TastencodeArray[i].Hotkey));
          Filestream.ReadBuffer(TastencodeArray[i].Global,sizeof(TastencodeArray[i].Global));
          Filestream.ReadBuffer(TastencodeArray[i].Repeated,sizeof(TastencodeArray[i].Repeated));
          Filestream.ReadBuffer(TastencodeArray[i].UseKeyUp,sizeof(TastencodeArray[i].UseKeyUp));

          Filestream.ReadBuffer(TastencodeArray[i].Befehl.Typ,sizeof(TastencodeArray[i].Befehl.Typ));
          Filestream.ReadBuffer(TastencodeArray[i].Befehl.OnValue,sizeof(TastencodeArray[i].Befehl.OnValue));
          Filestream.ReadBuffer(TastencodeArray[i].Befehl.OffValue,sizeof(TastencodeArray[i].Befehl.OffValue));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgInteger,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgInteger[j],sizeof(TastencodeArray[i].Befehl.ArgInteger[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgString,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgString[j],sizeof(TastencodeArray[i].Befehl.ArgString[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgGUID,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgGUID[j],sizeof(TastencodeArray[i].Befehl.ArgGUID[j]));
        end;
        Filestream.Free;
      end;
    end else
    begin
      // ersetzen
      with mainform do
      begin
        Filestream:=TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
        Filestream.ReadBuffer(Count,sizeof(Count));
        setlength(TastencodeArray,Count);
        setlength(TastencodePressedArray, Count);
        for i:=0 to Count-1 do
        begin
          Filestream.ReadBuffer(TastencodeArray[i].ID,sizeof(TastencodeArray[i].ID));
          Filestream.ReadBuffer(TastencodeArray[i].active,sizeof(TastencodeArray[i].active));
          Filestream.ReadBuffer(TastencodeArray[i].Hotkey,sizeof(TastencodeArray[i].Hotkey));
          Filestream.ReadBuffer(TastencodeArray[i].Global,sizeof(TastencodeArray[i].Global));
          Filestream.ReadBuffer(TastencodeArray[i].Repeated,sizeof(TastencodeArray[i].Repeated));
          Filestream.ReadBuffer(TastencodeArray[i].UseKeyUp,sizeof(TastencodeArray[i].UseKeyUp));

          Filestream.ReadBuffer(TastencodeArray[i].Befehl.Typ,sizeof(TastencodeArray[i].Befehl.Typ));
          Filestream.ReadBuffer(TastencodeArray[i].Befehl.OnValue,sizeof(TastencodeArray[i].Befehl.OnValue));
          Filestream.ReadBuffer(TastencodeArray[i].Befehl.OffValue,sizeof(TastencodeArray[i].Befehl.OffValue));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgInteger,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgInteger[j],sizeof(TastencodeArray[i].Befehl.ArgInteger[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgString,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgString[j],sizeof(TastencodeArray[i].Befehl.ArgString[j]));
          Filestream.ReadBuffer(Count2,sizeof(Count2));
          setlength(TastencodeArray[i].Befehl.ArgGUID,Count2);
          for j:=0 to Count2-1 do
            Filestream.ReadBuffer(TastencodeArray[i].Befehl.ArgGUID[j],sizeof(TastencodeArray[i].Befehl.ArgGUID[j]));
        end;
        Filestream.Free;
      end;
    end;

    mainform.ShortCutChecker.Enabled:=true;
    Tastenabfrage.FormShow(Sender);
    RefreshGrid;
  end;
end;

procedure TTastenabfrage.SpeedButton1Click(Sender: TObject);
var
  Count,Count2,i,j:integer;
begin
  with mainform do
  if SaveDialog1.Execute then
  begin
    FileStream:=TFileStream.Create(SaveDialog1.FileName,fmCreate);

    Count:=length(TastencodeArray);
		Filestream.WriteBuffer(Count,sizeof(Count));
    for i:=0 to Count-1 do
  	begin
    	Filestream.WriteBuffer(TastencodeArray[i].ID,sizeof(TastencodeArray[i].ID));
    	Filestream.WriteBuffer(TastencodeArray[i].active,sizeof(TastencodeArray[i].active));
    	Filestream.WriteBuffer(TastencodeArray[i].Hotkey,sizeof(TastencodeArray[i].Hotkey));
    	Filestream.WriteBuffer(TastencodeArray[i].Global,sizeof(TastencodeArray[i].Global));
    	Filestream.WriteBuffer(TastencodeArray[i].Repeated,sizeof(TastencodeArray[i].Repeated));
    	Filestream.WriteBuffer(TastencodeArray[i].UseKeyUp,sizeof(TastencodeArray[i].UseKeyUp));

      Filestream.WriteBuffer(TastencodeArray[i].Befehl.Typ,sizeof(TastencodeArray[i].Befehl.Typ));
      Filestream.WriteBuffer(TastencodeArray[i].Befehl.OnValue,sizeof(TastencodeArray[i].Befehl.OnValue));
      Filestream.WriteBuffer(TastencodeArray[i].Befehl.OffValue,sizeof(TastencodeArray[i].Befehl.OffValue));
      Count2:=length(TastencodeArray[i].Befehl.ArgInteger);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(TastencodeArray[i].Befehl.ArgInteger[j],sizeof(TastencodeArray[i].Befehl.ArgInteger[j]));
      Count2:=length(TastencodeArray[i].Befehl.ArgString);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(TastencodeArray[i].Befehl.ArgString[j],sizeof(TastencodeArray[i].Befehl.ArgString[j]));
      Count2:=length(TastencodeArray[i].Befehl.ArgGUID);
      Filestream.WriteBuffer(Count2,sizeof(Count2));
      for j:=0 to Count2-1 do
        Filestream.WriteBuffer(TastencodeArray[i].Befehl.ArgGUID[j],sizeof(TastencodeArray[i].Befehl.ArgGUID[j]));
    end;

    FileStream.Free;
  end;
end;

procedure TTastenabfrage.RestoreDefautKeymapBtnClick(Sender: TObject);
begin
  if length(mainform.TastencodeArray)=0 then
  begin
    RestoreDefautKeymap;

    Tastenabfrage.FormShow(Sender);
    RefreshGrid;
  end else
  if messagedlg(_('Es werden alle bisherigen ShortCuts gelöscht und die Standard-ShortCuts wieder hergestellt. Fortfahren?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
    RestoreDefautKeymap;

    Tastenabfrage.FormShow(Sender);
    RefreshGrid;
  end;
end;

procedure TTastenabfrage.RestoreDefautKeymap;
var
  i:integer;
  EnableHotKeysTemp:boolean;
begin
  EnableHotKeysTemp:=mainform.EnableHotKeys;
  mainform.EnableHotKeys:=false;
  Application.ProcessMessages;
  sleep(50);

  setlength(mainform.TastencodeArray,16);
  setlength(mainform.TastencodePressedArray,16);

  for i:=0 to 8 do
  begin
    CreateGUID(mainform.TastencodeArray[i].ID);
    mainform.TastencodeArray[i].active:=true;
    mainform.TastencodeArray[i].Global:=false;
    mainform.TastencodeArray[i].Repeated:=false;
    mainform.TastencodeArray[i].KeyDownValue:=255;
    mainform.TastencodeArray[i].KeyUpValue:=0;
    mainform.TastencodeArray[i].Befehl.Typ:=StringToGUID('{27A2A8A7-6664-4767-B4B6-5A1DB700EC51}');
    setlength(mainform.TastencodeArray[i].Befehl.ArgInteger, 1);
    mainform.TastencodeArray[i].Befehl.OnValue:=255;
    mainform.TastencodeArray[i].Befehl.OffValue:=0;
  end;

  mainform.TastencodeArray[0].Befehl.ArgInteger[0]:=0;
  mainform.TastencodeArray[0].Hotkey:=TextToShortCut('Strg+N'); // Neues Projekt
  mainform.TastencodeArray[1].Befehl.ArgInteger[0]:=1;
  mainform.TastencodeArray[1].Hotkey:=TextToShortCut('Strg+O'); // Projekt öffnen
  mainform.TastencodeArray[2].Befehl.ArgInteger[0]:=2;
  mainform.TastencodeArray[2].Hotkey:=TextToShortCut('Strg+S'); // Projekt speichern
  mainform.TastencodeArray[3].Befehl.ArgInteger[0]:=3;
  mainform.TastencodeArray[3].Hotkey:=TextToShortCut('Alt+S'); // Projekt schnellspeichern
  mainform.TastencodeArray[4].Befehl.ArgInteger[0]:=4;
  mainform.TastencodeArray[4].Hotkey:=TextToShortCut('Umsch+Alt+S'); // Projekt speichern unter
  mainform.TastencodeArray[5].Befehl.ArgInteger[0]:=5;
  mainform.TastencodeArray[5].Hotkey:=TextToShortCut('Strg+B'); // Projektverwaltung
  mainform.TastencodeArray[6].Befehl.ArgInteger[0]:=6;
  mainform.TastencodeArray[6].Hotkey:=TextToShortCut('Strg+P'); // Kanalnamen drucken
  mainform.TastencodeArray[7].Befehl.ArgInteger[0]:=7;
  mainform.TastencodeArray[7].Hotkey:=TextToShortCut('Strg+X'); // PC_DIMMER beenden
  mainform.TastencodeArray[8].Befehl.ArgInteger[0]:=8;
  mainform.TastencodeArray[8].Hotkey:=TextToShortCut('Strg+L'); // PC_DIMMER sperren

  CreateGUID(mainform.TastencodeArray[9].ID);
  mainform.TastencodeArray[9].active:=true;
  mainform.TastencodeArray[9].Global:=true;
  mainform.TastencodeArray[9].KeyDownValue:=255;
  mainform.TastencodeArray[9].KeyUpValue:=0;
  mainform.TastencodeArray[9].Befehl.Typ:=StringToGUID('{820E7B36-4F4E-4CFB-8ADF-6F21CAEC4077}');
  mainform.TastencodeArray[9].Hotkey:=TextToShortCut('F12'); // Manueller Beatimpuls
  mainform.TastencodeArray[9].Befehl.OnValue:=255;
  mainform.TastencodeArray[9].Befehl.OffValue:=0;

  CreateGUID(mainform.TastencodeArray[10].ID);
  mainform.TastencodeArray[10].active:=true;
  mainform.TastencodeArray[10].Global:=false;
  mainform.TastencodeArray[10].KeyDownValue:=255;
  mainform.TastencodeArray[10].KeyUpValue:=0;
  mainform.TastencodeArray[10].Befehl.Typ:=StringToGuid('{CFC95C94-F45F-4BF3-BFF1-6CBECD67C3F3}');
  mainform.TastencodeArray[10].Hotkey:=TextToShortCut('Strg+M'); // Mute ein/aus
  mainform.TastencodeArray[10].Befehl.OnValue:=255;
  mainform.TastencodeArray[10].Befehl.OffValue:=0;

  CreateGUID(mainform.TastencodeArray[11].ID);
  mainform.TastencodeArray[11].active:=true;
  mainform.TastencodeArray[11].Global:=true;
  mainform.TastencodeArray[11].Repeated:=true;
  mainform.TastencodeArray[11].KeyDownValue:=255;
  mainform.TastencodeArray[11].KeyUpValue:=0;
  mainform.TastencodeArray[11].Befehl.Typ:=StringToGuid('{BF05FF52-BFBA-4F2B-96E0-2ADB39056443}');
  mainform.TastencodeArray[11].Hotkey:=TextToShortCut('+ (ZEHNERTASTATUR)'); // Selektierte Geräte +
  mainform.TastencodeArray[11].Befehl.OnValue:=255;
  mainform.TastencodeArray[11].Befehl.OffValue:=0;
  setlength(mainform.TastencodeArray[11].Befehl.ArgInteger, 2);
  mainform.TastencodeArray[11].Befehl.ArgInteger[0]:=19;
  mainform.TastencodeArray[11].Befehl.ArgInteger[1]:=5;

  CreateGUID(mainform.TastencodeArray[12].ID);
  mainform.TastencodeArray[12].active:=true;
  mainform.TastencodeArray[12].Global:=true;
  mainform.TastencodeArray[12].Repeated:=true;
  mainform.TastencodeArray[12].KeyDownValue:=255;
  mainform.TastencodeArray[12].KeyUpValue:=0;
  mainform.TastencodeArray[12].Befehl.Typ:=StringToGuid('{7D0395FC-FF95-45B2-96DA-460A9F73666E}');
  mainform.TastencodeArray[12].Hotkey:=TextToShortCut('- (ZEHNERTASTATUR)'); // Selektierte Geräte -
  mainform.TastencodeArray[12].Befehl.OnValue:=255;
  mainform.TastencodeArray[12].Befehl.OffValue:=0;
  setlength(mainform.TastencodeArray[12].Befehl.ArgInteger, 2);
  mainform.TastencodeArray[12].Befehl.ArgInteger[0]:=19;
  mainform.TastencodeArray[12].Befehl.ArgInteger[1]:=5;

  CreateGUID(mainform.TastencodeArray[13].ID);
  mainform.TastencodeArray[13].active:=true;
  mainform.TastencodeArray[13].Global:=true;
  mainform.TastencodeArray[13].Repeated:=true;
  mainform.TastencodeArray[13].KeyDownValue:=255;
  mainform.TastencodeArray[13].KeyUpValue:=0;
  mainform.TastencodeArray[13].Befehl.Typ:=StringToGuid('{1010A77A-1FD9-46F0-8BEA-D516CC4B8965}');
  mainform.TastencodeArray[13].Hotkey:=TextToShortCut('STRG++'); // Bühnenansichtgeräte +
  mainform.TastencodeArray[13].Befehl.OnValue:=255;
  mainform.TastencodeArray[13].Befehl.OffValue:=0;
  setlength(mainform.TastencodeArray[13].Befehl.ArgInteger, 2);
  mainform.TastencodeArray[13].Befehl.ArgInteger[0]:=19;
  mainform.TastencodeArray[13].Befehl.ArgInteger[1]:=5;

  CreateGUID(mainform.TastencodeArray[14].ID);
  mainform.TastencodeArray[14].active:=true;
  mainform.TastencodeArray[14].Global:=true;
  mainform.TastencodeArray[14].Repeated:=true;
  mainform.TastencodeArray[14].KeyDownValue:=255;
  mainform.TastencodeArray[14].KeyUpValue:=0;
  mainform.TastencodeArray[14].Befehl.Typ:=StringToGuid('{6E119210-6CF4-4124-867E-79F25C0CDF20}');
  mainform.TastencodeArray[14].Hotkey:=TextToShortCut('STRG+-'); // Bühnenansichtgeräte -
  mainform.TastencodeArray[14].Befehl.OnValue:=255;
  mainform.TastencodeArray[14].Befehl.OffValue:=0;
  setlength(mainform.TastencodeArray[14].Befehl.ArgInteger, 2);
  mainform.TastencodeArray[14].Befehl.ArgInteger[0]:=19;
  mainform.TastencodeArray[14].Befehl.ArgInteger[1]:=5;

  CreateGUID(mainform.TastencodeArray[15].ID);
  mainform.TastencodeArray[15].active:=true;
  mainform.TastencodeArray[15].Global:=false;
  mainform.TastencodeArray[14].Repeated:=false;
  mainform.TastencodeArray[15].KeyDownValue:=255;
  mainform.TastencodeArray[15].KeyUpValue:=0;
  mainform.TastencodeArray[15].Befehl.Typ:=StringToGUID('{09EA8D16-3389-45CB-82A4-34F71D0D4646}');
  setlength(mainform.TastencodeArray[15].Befehl.ArgString, 2);
  setlength(mainform.TastencodeArray[15].Befehl.ArgInteger, 3);
  mainform.TastencodeArray[15].Befehl.OnValue:=255;
  mainform.TastencodeArray[15].Befehl.OffValue:=0;
  mainform.TastencodeArray[15].Befehl.ArgString[0]:='http://www.pcdimmer.de/wiki/index.php/Kategorie:Handbuch';
  mainform.TastencodeArray[15].Befehl.ArgString[1]:='';
  mainform.TastencodeArray[15].Befehl.ArgInteger[0]:=0;
  mainform.TastencodeArray[15].Befehl.ArgInteger[1]:=0;
  mainform.TastencodeArray[15].Befehl.ArgInteger[2]:=0;
  mainform.TastencodeArray[15].Hotkey:=TextToShortCut('F1'); // PC_DIMMER sperren

  mainform.EnableHotKeys:=EnableHotKeysTemp;
  mainform.ShortCutChecker.Enabled:=EnableHotKeysTemp;
end;

procedure TTastenabfrage.FlipEntry(Source, Destination:integer);
var
  i:integer;
begin
  // aktuellen Eintrag temporär ans Ende kopieren
  setlength(mainform.TastencodeArray,length(mainform.TastencodeArray)+1);
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].ID:=mainform.TastencodeArray[Source].ID;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Active:=mainform.TastencodeArray[Source].Active;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Hotkey:=mainform.TastencodeArray[Source].Hotkey;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Global:=mainform.TastencodeArray[Source].Global;

  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ID:=mainform.TastencodeArray[Source].Befehl.ID;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Typ:=mainform.TastencodeArray[Source].Befehl.Typ;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Name:=mainform.TastencodeArray[Source].Befehl.Name;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Beschreibung:=mainform.TastencodeArray[Source].Befehl.Beschreibung;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OnValue:=mainform.TastencodeArray[Source].Befehl.OnValue;
  mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OffValue:=mainform.TastencodeArray[Source].Befehl.OffValue;
  setlength(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgInteger, length(mainform.TastencodeArray[Source].Befehl.ArgInteger));
  for i:=0 to length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgInteger)-1 do
    mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgInteger[i]:=mainform.TastencodeArray[Source].Befehl.ArgInteger[i];
  setlength(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgString, length(mainform.TastencodeArray[Source].Befehl.ArgString));
  for i:=0 to length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgString)-1 do
    mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgString[i]:=mainform.TastencodeArray[Source].Befehl.ArgString[i];
  setlength(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgGUID, length(mainform.TastencodeArray[Source].Befehl.ArgGUID));
  for i:=0 to length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgGUID)-1 do
    mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgGUID[i]:=mainform.TastencodeArray[Source].Befehl.ArgGUID[i];

  // oberen Einträge aufrutschen
  mainform.TastencodeArray[Source].ID:=mainform.TastencodeArray[Destination].ID;
  mainform.TastencodeArray[Source].Active:=mainform.TastencodeArray[Destination].Active;
  mainform.TastencodeArray[Source].Hotkey:=mainform.TastencodeArray[Destination].Hotkey;
  mainform.TastencodeArray[Source].Global:=mainform.TastencodeArray[Destination].Global;

  mainform.TastencodeArray[Source].Befehl.ID:=mainform.TastencodeArray[Destination].Befehl.ID;
  mainform.TastencodeArray[Source].Befehl.Typ:=mainform.TastencodeArray[Destination].Befehl.Typ;
  mainform.TastencodeArray[Source].Befehl.Name:=mainform.TastencodeArray[Destination].Befehl.Name;
  mainform.TastencodeArray[Source].Befehl.Beschreibung:=mainform.TastencodeArray[Destination].Befehl.Beschreibung;
  mainform.TastencodeArray[Source].Befehl.OnValue:=mainform.TastencodeArray[Destination].Befehl.OnValue;
  mainform.TastencodeArray[Source].Befehl.OffValue:=mainform.TastencodeArray[Destination].Befehl.OffValue;
  setlength(mainform.TastencodeArray[Source].Befehl.ArgInteger, length(mainform.TastencodeArray[Destination].Befehl.ArgInteger));
  for i:=0 to length(mainform.TastencodeArray[Source].Befehl.ArgInteger)-1 do
    mainform.TastencodeArray[Source].Befehl.ArgInteger[i]:=mainform.TastencodeArray[Destination].Befehl.ArgInteger[i];
  setlength(mainform.TastencodeArray[Source].Befehl.ArgString, length(mainform.TastencodeArray[Destination].Befehl.ArgString));
  for i:=0 to length(mainform.TastencodeArray[Source].Befehl.ArgString)-1 do
    mainform.TastencodeArray[Source].Befehl.ArgString[i]:=mainform.TastencodeArray[Destination].Befehl.ArgString[i];
  setlength(mainform.TastencodeArray[Source].Befehl.ArgGUID, length(mainform.TastencodeArray[Destination].Befehl.ArgGUID));
  for i:=0 to length(mainform.TastencodeArray[Source].Befehl.ArgGUID)-1 do
    mainform.TastencodeArray[Source].Befehl.ArgGUID[i]:=mainform.TastencodeArray[Destination].Befehl.ArgGUID[i];

  // letzten Eintrag einfügen
  mainform.TastencodeArray[Destination].ID:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].ID;
  mainform.TastencodeArray[Destination].Active:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Active;
  mainform.TastencodeArray[Destination].Hotkey:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Hotkey;
  mainform.TastencodeArray[Destination].Global:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Global;

  mainform.TastencodeArray[Destination].Befehl.ID:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ID;
  mainform.TastencodeArray[Destination].Befehl.Typ:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Typ;
  mainform.TastencodeArray[Destination].Befehl.Name:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Name;
  mainform.TastencodeArray[Destination].Befehl.Beschreibung:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.Beschreibung;
  mainform.TastencodeArray[Destination].Befehl.OnValue:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OnValue;
  mainform.TastencodeArray[Destination].Befehl.OffValue:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.OffValue;
  setlength(mainform.TastencodeArray[Destination].Befehl.ArgInteger, length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.TastencodeArray[Destination].Befehl.ArgInteger)-1 do
    mainform.TastencodeArray[Destination].Befehl.ArgInteger[i]:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgInteger[i];
  setlength(mainform.TastencodeArray[Destination].Befehl.ArgString, length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgString));
  for i:=0 to length(mainform.TastencodeArray[Destination].Befehl.ArgString)-1 do
    mainform.TastencodeArray[Destination].Befehl.ArgString[i]:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgString[i];
  setlength(mainform.TastencodeArray[Destination].Befehl.ArgGUID, length(mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.TastencodeArray[Destination].Befehl.ArgGUID)-1 do
    mainform.TastencodeArray[Destination].Befehl.ArgGUID[i]:=mainform.TastencodeArray[length(mainform.TastencodeArray)-1].Befehl.ArgGUID[i];
  setlength(mainform.TastencodeArray,length(mainform.TastencodeArray)-1);
end;

procedure TTastenabfrage.upBtnClick(Sender: TObject);
begin
  if StringGrid1.Row>1 then
  begin
    // nach unten verschieben
    FlipEntry(StringGrid1.Row-1,StringGrid1.Row-2);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row-1;
  end;
//  Tastenabfrage.FormShow(Sender);
  RefreshGrid;

  upBtn.enabled:=StringGrid1.Row>1;
  downBtn.enabled:=StringGrid1.Row<StringGrid1.RowCount-1;
end;

procedure TTastenabfrage.downBtnClick(Sender: TObject);
begin
  if StringGrid1.Row<StringGrid1.RowCount-1 then
  begin
    // nach unten verschieben
    FlipEntry(StringGrid1.Row-1,StringGrid1.Row);
    // Position mitführen
    StringGrid1.Row:=StringGrid1.Row+1;
  end;
//  Tastenabfrage.FormShow(Sender);
  RefreshGrid;

  upBtn.enabled:=StringGrid1.Row>1;
  downBtn.enabled:=StringGrid1.Row<StringGrid1.RowCount-1;
end;

procedure TTastenabfrage.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TTastenabfrage.hEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger)-1]:=strtoint(msEdit.Text)+strtoint(sEdit.text)*1000+strtoint(minEdit.Text)*60*1000+strtoint(hEdit.Text)*60*60*1000;
end;

procedure TTastenabfrage.Arg1EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[0]:=strtoint(Arg1Edit.Text);
end;

procedure TTastenabfrage.Arg2EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure TTastenabfrage.Arg2bEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure TTastenabfrage.ComboBox1Select(Sender: TObject);
var
  i:integer;
begin
  Combobox2.Items.Clear;
  setlength(Befehlposition, 0);
  for i:=0 to length(mainform.Befehlssystem[Combobox1.itemindex].Steuerung)-1 do
  begin
//    if (not mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].InputValueOnly) then
    begin
      Combobox2.items.Add(mainform.Befehlssystem[Combobox1.itemindex].Steuerung[i].Bezeichnung);

      setlength(Befehlposition, length(Befehlposition)+1);
      Befehlposition[length(Befehlposition)-1].GUID:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].GUID;
      Befehlposition[length(Befehlposition)-1].Bezeichnung:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].Bezeichnung;
      Befehlposition[length(Befehlposition)-1].IntegerArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].IntegerArgCount;
      Befehlposition[length(Befehlposition)-1].StringArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].StringArgCount;
      Befehlposition[length(Befehlposition)-1].GUIDArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].GUIDArgCount;

      Befehlposition[length(Befehlposition)-1].PositionCombobox2:=Combobox2.Items.Count-1;
    end;
  end;

  // Aktuellen Befehl anzeigen
  for i:=0 to length(Befehlposition)-1 do
  begin
    if IsEqualGUID(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Typ, Befehlposition[i].GUID) then
    begin
      Combobox2.ItemIndex:=Befehlposition[i].PositionCombobox2;
      ComboBox2Select(nil);
      break;
    end;
  end;
  RefreshGrid;
end;

procedure TTastenabfrage.ComboBox2Select(Sender: TObject);
var
  i,j:integer;
  cancel:boolean;
  AktuellerBefehl: TBefehl2;
  SzenenData:PTreeData;
begin
  AktuellerBefehl.ID:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ID;
  AktuellerBefehl.Typ:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Typ;
  AktuellerBefehl.Name:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Name;
  AktuellerBefehl.Beschreibung:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Beschreibung;
  AktuellerBefehl.OnValue:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.OnValue;
  AktuellerBefehl.OffValue:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.OffValue;
  setlength(AktuellerBefehl.ArgInteger, length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger));
  for i:=0 to length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger)-1 do
    AktuellerBefehl.ArgInteger[i]:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[i];
  setlength(AktuellerBefehl.ArgString, length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgString));
  for i:=0 to length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgString)-1 do
    AktuellerBefehl.ArgString[i]:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgString[i];
  setlength(AktuellerBefehl.ArgGUID, length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID));
  for i:=0 to length(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID)-1 do
    AktuellerBefehl.ArgGUID[i]:=mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID[i];

  {$I EditBefehl.inc}
  
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ID:=AktuellerBefehl.ID;
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Typ:=AktuellerBefehl.Typ;
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Name:=AktuellerBefehl.Name;
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Beschreibung:=AktuellerBefehl.Beschreibung;
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.OnValue:=AktuellerBefehl.OnValue;
  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.OffValue:=AktuellerBefehl.OffValue;
  setlength(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger, length(AktuellerBefehl.ArgInteger));
  for i:=0 to length(AktuellerBefehl.ArgInteger)-1 do
    mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[i]:=AktuellerBefehl.ArgInteger[i];
  setlength(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgString, length(AktuellerBefehl.ArgString));
  for i:=0 to length(AktuellerBefehl.ArgString)-1 do
    mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgString[i]:=AktuellerBefehl.ArgString[i];
  setlength(mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID, length(AktuellerBefehl.ArgGUID));
  for i:=0 to length(AktuellerBefehl.ArgGUID)-1 do
    mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID[i]:=AktuellerBefehl.ArgGUID[i];
  RefreshGrid;
end;

procedure TTastenabfrage.Arg1ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[0]:=Arg1Combobox.ItemIndex;
end;

procedure TTastenabfrage.Arg2ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[1]:=Arg2Combobox.ItemIndex;
end;

procedure TTastenabfrage.Arg3ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[2]:=Arg3Combobox.ItemIndex;
end;

procedure TTastenabfrage.devicelistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID[0]:=mainform.devices[devicelist.itemindex].ID;
end;

procedure TTastenabfrage.grouplistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID[0]:=mainform.devicegroups[grouplist.itemindex].ID;
end;

procedure TTastenabfrage.effektlistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgGUID[0]:=mainform.effektsequenzereffekte[effektlist.itemindex].ID;

  ComboBox2Select(effektlist);
end;

procedure TTastenabfrage.Edit1Change(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Name:=Edit1.text;
end;

procedure TTastenabfrage.Edit2Change(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.Beschreibung:=Edit2.text;
end;

procedure TTastenabfrage.FillTimeBox(time: integer);
var
  t,h,min,s,ms:integer;
begin
  ZeitBox.Visible:=true;

  t:=time;
  h:=t div 3600000;
  t:=t mod 3600000;
  min:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;

  hEdit.text:=inttostr(h);
  minEdit.text:=inttostr(min);
  sEdit.text:=inttostr(s);
  msEdit.text:=inttostr(ms);
end;

procedure TTastenabfrage.Arg3EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.ArgInteger[2]:=strtoint(Arg3Edit.Text);
end;

procedure TTastenabfrage.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.TastencodeArray[Stringgrid1.Row-1].Repeated:=Checkbox1.checked;
  StringGrid1.Refresh;
end;

procedure TTastenabfrage.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.TastencodeArray[Stringgrid1.Row-1].UseKeyUp:=Checkbox2.checked;
  StringGrid1.Refresh;
end;

procedure TTastenabfrage.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  StringGrid1MouseUp(nil, mbLeft, [], 0, 0);
end;

procedure TTastenabfrage.KeyDownValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].KeyDownValue:=round(KeyDownValue.Value);
end;

procedure TTastenabfrage.KeyUpValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].KeyUpValue:=round(KeyUpValue.Value);
end;

procedure TTastenabfrage.CreateParams(var Params:TCreateParams);
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

procedure TTastenabfrage.ComboBox2Enter(Sender: TObject);
begin
  ManualEditingOfCombobox2:=true;
end;

procedure TTastenabfrage.ComboBox2Exit(Sender: TObject);
begin
  ManualEditingOfCombobox2:=false;
end;

procedure TTastenabfrage.SwitchValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.TastencodeArray[Stringgrid1.Row-1].Befehl.SwitchValue:=round(SwitchValue.Value);
end;

end.
