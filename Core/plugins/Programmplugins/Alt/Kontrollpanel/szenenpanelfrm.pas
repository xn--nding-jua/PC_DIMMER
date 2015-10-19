unit szenenpanelfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, JvExControls, JvComponent,
  JvColorBox, JvColorButton, CHButton, Mask, JvExMask, JvSpin,
  JvZlibMultiple, MPlayer, Menus, Buttons, ImgList, Registry,
  messagesystem, Math, VistaAltFixUnit;

const
  chan=512;
	maxzeile=24;
	maxspalte=24;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  TAct = record
            opt : array[1..chan] of string;
            ch_ready : array[1..chan] of boolean;
            start : array[1..chan] of TDateTime;
            wt : array[1..chan] of TDateTime;
          end;

  Tkontrollpanelrecord = record
              zeilenanzahl:integer;
              spaltenanzahl:integer;
              buttonname:array[0..maxzeile] of array[0..maxspalte] of string[30];
              buttonfarbe:array[0..maxzeile] of array[0..maxspalte] of TColor;
              buttontyp:array[0..maxzeile] of array[0..maxspalte] of byte;
              buttonshortcut:array[0..maxzeile] of array[0..maxspalte] of TShortCut;
              kanalwerte:array[0..maxzeile] of array[0..maxspalte] of array[1..chan] of integer;
              fadezeit:array[0..maxzeile] of array[0..maxspalte] of longword;
              audiodatei:array[0..maxzeile] of array[0..maxspalte] of string[255];
              formwidth:integer;
              formheight:integer;
              formtop:integer;
              formleft:integer;
  					end;
type
  Tmainform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    buttonname: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    buttonfarbe: TJvColorButton;
    zeilen: TJvSpinEdit;
    spalten: TJvSpinEdit;
    szenebearbeiten: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ListBox: TListBox;
    temposlider: TScrollBar;
    repeatskript: TCheckBox;
    ComboBox1: TComboBox;
    stop: TButton;
    Label7: TLabel;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    Compress: TJvZlibMultiple;
    MediaPlayer1: TMediaPlayer;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    HotKey1: THotKey;
    CheckFileExists: TTimer;
    sync_btn: TButton;
    beattime_blinker: TTimer;
    Shape1: TShape;
    buttonsup: TTimer;
    MIDI: TSpeedButton;
    MainMenu1: TMainMenu;
    Ansicht1: TMenuItem;
    IndenVordergrund1: TMenuItem;
    Normal1: TMenuItem;
    MenanzeigenDoppelklickaufStatusleiste1: TMenuItem;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    N1: TMenuItem;
    Einstellungen: TMenuItem;
    MIDISetup1: TMenuItem;
    Neu1: TMenuItem;
    Speichern1: TMenuItem;
    ffnen1: TMenuItem;
    N2: TMenuItem;
    tempokoppeln: TMenuItem;
    hauptprogrammeffekteaus: TMenuItem;
    ButtonPopup: TPopupMenu;
    Kopieren1: TMenuItem;
    Einfgen1: TMenuItem;
    Lschen1: TMenuItem;
    ooltipsanzeigen1: TMenuItem;
    N3: TMenuItem;
    VistaAltFix1: TVistaAltFix;
    Ausschneiden1: TMenuItem;
    Bearbeiten1: TMenuItem;
    N4: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure zeilenChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CHButton1Click(Sender: TObject);
    procedure buttonfarbeChange(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure openClick(Sender: TObject);
    procedure szenebearbeitenClick(Sender: TObject);
    procedure buttonnameEnter(Sender: TObject);
    procedure buttonnameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RunSkript(Sender:TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure temposliderChange(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure newClick(Sender: TObject);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure MediaPlayer1Notify(Sender: TObject);
    procedure CHButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Exit(Sender: TObject);
    procedure HotKey1Change(Sender: TObject);
    procedure CheckFileExistsTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CHButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sync_btnClick(Sender: TObject);
    procedure beattime_blinkerTimer(Sender: TObject);
    procedure CheckBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure buttonsupTimer(Sender: TObject);
    procedure MidiInput(MidiMessage,Data1,Data2:byte);
    procedure MIDIClick(Sender: TObject);
    procedure IndenVordergrund1Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
		procedure ExecuteMIDIEvents(i:Byte; Data:Byte);
    procedure tempokoppelnClick(Sender: TObject);
    procedure hauptprogrammeffekteausClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
		procedure MSGOpen(Sender: TObject);
		procedure MSGSave(Sender: TObject);
    procedure FormHide(Sender: TObject);
		procedure NewPanel;
    procedure Einfgen1Click(Sender: TObject);
    procedure Kopieren1Click(Sender: TObject);
    procedure Lschen1Click(Sender: TObject);
    procedure ooltipsanzeigen1Click(Sender: TObject);
    procedure Bearbeiten1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    cut:boolean;
  public
    { Public-Deklarationen }
		MSGFROMMAINPROGRAM:boolean;
    channelvalue:array[1..chan] of integer;
    channelnames:array[1..chan] of string;
    channelvalue_temp:array[1..chan] of integer;
    button:array[0..maxzeile] of array[0..maxspalte] of TCHButton;
    labelshortcut:array[0..maxzeile] of array[0..maxspalte] of TStaticText;
    labeltype:array[0..maxzeile] of array[0..maxspalte] of TStaticText;
    buttononline:array[0..maxzeile] of array[0..maxspalte] of boolean;
    knopf:TButton;
    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    SendMSG:TCallbackSendMessage;
    aktuellezeile,aktuellespalte:integer;
    FileStream:TFileStream;
    kontrollpanelrecord:Tkontrollpanelrecord;
    closing,keypressed,waitkey:boolean;
    shutdown:boolean;
		shutdownbypcdimmeroff:boolean;
    inprogram: array[1..chan] of boolean;
    actualfadevalue: array[1..chan] of string;
    quellzeile,quellspalte:integer;
		lastchan:Word;    
    beat_starttime,beat_endtime: TTimeStamp;
    beat_syncFirstclick:boolean;
    flashingkey:Word;
    flashingshift:TShiftState;
		MidiEventArray : array of array[1..7] of Byte;
    skriptisrunning:boolean;
  end;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

var
  mainform: Tmainform;

implementation

uses insscene, presskey, editskript, editmidievent, midievent;

{$R *.dfm}

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure Tmainform.FormShow(Sender: TObject);
var
  CSV:TStrings;
  temp:string;
  i:integer;
	LReg:TRegistry;
begin
  i:=0;

	shutdown:=false;
	closing:=false;
  keypressed:=false;
  waitkey:=false;
  
 	panel1.DoubleBuffered:=true;
  panel2.DoubleBuffered:=true;

  mainform.Width:=kontrollpanelrecord.formwidth;
  mainform.Height:=kontrollpanelrecord.formheight;

  // MIDI-Ereignisse aus CSV-Datei lesen
  try
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi') then
  begin
	  CSV := TStringlist.Create;
	  CSV.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
	  if csv.Count>0 then
	  begin
		  setlength(MidiEventArray,csv.Count);
	  	MIDIEVENTfrm.MIDIGrid.RowCount:=csv.Count+1;

		  For i:=0 To length(MidiEventArray)-1 do
		  begin
		    temp:=CSV.Strings[i];
		    MidiEventArray[i][1]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][2]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][3]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][4]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][5]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][6]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][7]:=strtoint(temp);
		    MIDIEVENTfrm.MIDIGrid.RowHeights[i+1]:=15;
		  	MIDIEVENTfrm.refreshList(i+1);
		  end;
		  CSV.Free;

		  if length(MidiEventArray)>0 then
		  begin
		    MIDIEVENTfrm.editmidievent.Enabled:=true;
		    MIDIEVENTfrm.deletemidievent.Enabled:=true;
		  end else
		  begin
		    MIDIEVENTfrm.editmidievent.Enabled:=false;
		    MIDIEVENTfrm.deletemidievent.Enabled:=false;
		  end;
	  end;
	end;
  except
  	ShowMessage(_('Beim Laden der Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi'+_('" ist ein Fehler in Zeile ')+inttostr(i+1)+_(' aufgetreten. Die MIDI-Einstellungen können unter Umständen nicht korrekt geladen werden.'));
		// Letzten Eintrag löschen
		setlength(MidiEventArray,length(MidiEventArray)-1);
	  if MIDIEVENTfrm.MIDIGrid.RowCount>2 then
		begin
	  	MIDIEVENTfrm.MIDIGrid.rowcount:=MIDIEVENTfrm.MIDIGrid.rowcount-1;
			// komplette Liste aktualisieren
			for i:=1 to MIDIEVENTfrm.MIDIGrid.rowcount do
			begin
				MIDIEVENTfrm.refreshList(i);
			end;
		end else
	  begin
			MIDIEVENTfrm.MIDIGrid.cells[0,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[1,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[2,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[3,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[4,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[5,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[6,1]:='';
	  	MIDIEVENTfrm.deletemidievent.Enabled:=false;
	    MIDIEVENTfrm.editmidievent.Enabled:=false;
	  end;
  end;

  if length(MidiEventArray)>0 then
  begin
    MIDIEVENTfrm.editmidievent.Enabled:=true;
    MIDIEVENTfrm.deletemidievent.Enabled:=true;
  end else
  begin
    MIDIEVENTfrm.editmidievent.Enabled:=false;
    MIDIEVENTfrm.deletemidievent.Enabled:=false;
  end;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
        if not LReg.ValueExists('Last channel') then
          LReg.WriteInteger('Last channel',128);
        lastchan:=LReg.ReadInteger('Last channel');
        if lastchan<32 then lastchan:=32;
        if lastchan>chan then lastchan:=chan;

        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
	        if not LReg.ValueExists('Couple speed with Mainprogram') then
	          LReg.WriteBool('Couple speed with Mainprogram',true);
	        tempokoppeln.Checked:=LReg.ReadBool('Couple speed with Mainprogram');
	        if not LReg.ValueExists('Show setup') then
	          LReg.WriteBool('Show setup',true);
         	panel1.Visible:=LReg.ReadBool('Show setup');
         	MenanzeigenDoppelklickaufStatusleiste1.checked:=LReg.ReadBool('Show setup');
	        if not LReg.ValueExists('Deactivate Mainprogrameffects on click') then
	          LReg.WriteBool('Deactivate Mainprogrameffects on click',false);
         	hauptprogrammeffekteaus.checked:=LReg.ReadBool('Deactivate Mainprogrameffects on click');
	        if not LReg.ValueExists('Enable Tooltips') then
	          LReg.WriteBool('Enable Tooltips',false);
         	ooltipsanzeigen1.checked:=LReg.ReadBool('Enable Tooltips');

					LReg.WriteBool('Showing Plugin',true);

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+mainform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              mainform.Left:=LReg.ReadInteger('PosX')
            else
              mainform.Left:=screen.DesktopLeft;
          end else
            mainform.Left:=screen.DesktopLeft;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              mainform.Top:=LReg.ReadInteger('PosY')
            else
              mainform.Top:=screen.DesktopTop;
          end else
            mainform.Top:=screen.DesktopTop;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure Tmainform.zeilenChange(Sender: TObject);
var
	i,j:integer;
begin
//  SetWindowLong(button2.Handle, GWL_STYLE, GetWindowLong(button2.Handle, GWL_STYLE) or BS_MULTILINE);

  panel2.Visible:=false;
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
      if not buttononline[i][j] then
     	begin
      	button[i][j]:=TCHButton.Create(self);
        buttononline[i][j]:=true;
        labelshortcut[i][j]:=TStaticText.Create(Self);
        labeltype[i][j]:=TStaticText.Create(Self);
      end;
      button[i][j].Parent:=Panel2;
      button[i][j].OnClick:=CHButton1Click;
      button[i][j].OnMouseDown:=CHButton1MouseDown;
      button[i][j].OnMouseUp:=CHButton1Mouseup;
      button[i][j].Width:=panel2.Width div spalten.AsInteger;
      button[i][j].Height:=panel2.Height div zeilen.AsInteger;
      button[i][j].Left:=j*button[i][j].Width;
      button[i][j].Top:=i*button[i][j].Height;
      button[i][j].Caption:=kontrollpanelrecord.buttonname[i][j];
      button[i][j].Hint:=kontrollpanelrecord.buttonname[i][j];
      button[i][j].Color:=kontrollpanelrecord.buttonfarbe[i][j];
//      button[i][j].DragMode:=dmAutomatic;
      button[i][j].Visible:=true;
      button[i][j].PopupMenu:=ButtonPopup;

      labelshortcut[i][j].Parent:=button[i][j];
      labelshortcut[i][j].OnClick:=CHButton1Click;
      labelshortcut[i][j].OnMouseDown:=CHButton1MouseDown;
      labelshortcut[i][j].OnMouseUp:=CHButton1MouseUp;
      labelshortcut[i][j].Caption:=ShortCutToText(kontrollpanelrecord.buttonshortcut[i][j]);
      labelshortcut[i][j].Top:=5;
      labelshortcut[i][j].Left:=10;
      labelshortcut[i][j].Hint:=_('Hotkey des aktuellen Buttons');
      labelshortcut[i][j].ShowHint:=true;
      labelshortcut[i][j].Transparent:=true;
      labelshortcut[i][j].Visible:=true;

      labeltype[i][j].Parent:=button[i][j];
      labeltype[i][j].OnClick:=CHButton1Click;
      labeltype[i][j].OnMouseDown:=CHButton1MouseDown;
      labeltype[i][j].OnMouseUp:=CHButton1MouseUp;
      case kontrollpanelrecord.buttontyp[i][j] of
      	0: labeltype[i][j].Caption:=' ';
      	1: labeltype[i][j].Caption:=_('Szene');
      	2: labeltype[i][j].Caption:=_('Skript');
      	3: labeltype[i][j].Caption:=_('Audiodatei');
   		4: labeltype[i][j].Caption:=_('Flashszene');
   		5: labeltype[i][j].Caption:=_('Flashskript');
   		6: labeltype[i][j].Caption:=_('Flashaudio');
      end;
      labeltype[i][j].Top:=button[i][j].Height-22;
      labeltype[i][j].Left:=10;
      labeltype[i][j].Hint:=_('Typ des aktuellen Buttons');
      labeltype[i][j].ShowHint:=true;
      labeltype[i][j].Transparent:=true;
      labeltype[i][j].Visible:=true;
    end;
  end;

	for i:=zeilen.AsInteger to maxzeile do
  begin
  	for j:=0 to maxspalte do
    begin
      if buttononline[i][j] then
      begin
	      button[i][j].Visible:=false;
  	    button[i][j].Free;
        buttononline[i][j]:=false;
      end;
    end;
  end;

	for j:=spalten.AsInteger to maxspalte do
  begin
  	for i:=0 to maxzeile do
    begin
      if buttononline[i][j] then
      begin
	      button[i][j].Visible:=false;
  	    button[i][j].Free;
        buttononline[i][j]:=false;
      end;
    end;
  end;

  panel2.Visible:=true;
end;

procedure Tmainform.FormResize(Sender: TObject);
var
	i,j:integer;
begin
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
      button[i][j].Width:=panel2.Width div spalten.AsInteger;
      button[i][j].Height:=panel2.Height div zeilen.AsInteger;
      button[i][j].Left:=j*button[i][j].Width;
      button[i][j].Top:=i*button[i][j].Height;

      labeltype[i][j].Top:=button[i][j].Height-22;
    end;
  end;
end;

procedure Tmainform.CHButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,j,k,l:integer;
	szenenarray:Variant;
begin
  if hauptprogrammeffekteaus.checked then
   	SendMSG(MSG_EFFECTSPLAY,False,0);

  for i:=0 to maxzeile do
  	for j:=0 to maxspalte do
	 	begin
			if ((Sender=mainform.button[i][j]) or (Sender=labeltype[i][j]) or (Sender=labelshortcut[i][j])) then
      begin
      	if Button=mbLeft then
        begin
	        aktuellezeile:=i;
	        aktuellespalte:=j;
          mainform.button[aktuellezeile][aktuellespalte].down:=true;
					case kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte] of
			    4:
			    begin
			      // FLASHSZENE STARTEN
			      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
			      for l:=1 to lastchan do
			      	szenenarray[l]:=kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][l]>-1;
				    for k:=1 to lastchan do
			  	    if kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][k]>-1 then
						  begin
                channelvalue_temp[k]:=channelvalue[k];
              	RefreshDLLValues(k,kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][k],kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][k],0);
              end;
            SendMSG(MSG_RECORDSCENE,szenenarray,0);
			      StatusBar1.Panels.Items[2].Text:=_('Flash!');
			    end;
          5:
          begin
						// Aktuelles Skript abbrechen
{
				    waitkey:=false;
					  closing:=true;
				    waitkey:=false;
					  for k:=1 to lastchan do
				    	inprogram[k]:=false;
}
			      // FLASHSKRIPT STARTEN
			      if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
			      begin
              repeatskript.checked:=true;
				      StatusBar1.Panels.Items[2].Text:='Skriptabruf aus '+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp';
			      	listbox.Items.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');

			        if listbox.items[0]<>inttostr(listbox.items.count-1) then
			          begin
			            listbox.items.clear;
			            messagedlg(_('Sorry, fehlerhafte Skriptdatei!'),mtError,[mbOK],0);
			          end
			        else
			          listbox.items.delete(0);

			        listbox.itemindex:=0;
			        if listbox.items.count>0 then
			        begin
			//	        stop.Enabled:=true;
			    	    RunSkript(Sender);
			        end;
			      end;
          end;
          6:
          begin
			      // FLASHAUDIO STARTEN
			      if fileexists(kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]) then
			      begin
				      StatusBar1.Panels.Items[2].Text:=_('Flashaudio ')+kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte];
			//        stop.Enabled:=true;
			      	mediaplayer1.FileName:=kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte];
			        mediaplayer1.Open;
			        mediaplayer1.Play;
			      end;
          end;
          end;
        end else
        begin
          if (aktuellezeile=i) and (aktuellespalte=j) then
            ButtonPopup.AutoPopup:=true
          else
            ButtonPopup.AutoPopup:=false;
        end;
      end;
    end;
end;

procedure Tmainform.CHButton1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
	i,j,k,l:integer;
  szenenarray:Variant;
begin
  for i:=0 to maxzeile do
  	for j:=0 to maxspalte do
    begin
			if ((Sender=mainform.button[i][j]) or (Sender=labeltype[i][j]) or (Sender=labelshortcut[i][j])) then
      begin
      	if Button=mbLeft then
        begin
	        aktuellezeile:=i;
	        aktuellespalte:=j;
					case kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte] of
			    4:
			    begin
			      // FLASHSZENE STOPPEN
			      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
			      for l:=1 to lastchan do
			      	szenenarray[l]:=kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][l]>-1;
				    for k:=1 to lastchan do
			  	    if kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][k]>-1 then
						  begin
              	RefreshDLLValues(k,channelvalue_temp[k],channelvalue_temp[k],0);
              end;
            SendMSG(MSG_RECORDSCENE,szenenarray,0);
			      StatusBar1.Panels.Items[2].Text:='';
			    end;
				  5:
				  begin
				    // FLASHSKRIPT ABBRECHEN
            repeatskript.checked:=false;
				    waitkey:=false;
					  closing:=true;
				    waitkey:=false;
{					  for k:=1 to lastchan do
					  begin
				    	inprogram[k]:=false;
							RefreshDLLValues(k,channelvalue[k],channelvalue[k],0);
				    end;
}  				end;
          6:
          begin
				    // AUDIODATEI STOPPEN   
				  	mediaplayer1.Stop;
          end;
          end;
					buttonsup.Enabled:=true;
        end;
      	if Button=mbRight then
        begin
	        aktuellezeile:=i;
	        aktuellespalte:=j;
        end;
{
        if Shift=[ssCtrl] then
        begin
        	quellzeile:=i;
          quellspalte:=j;
        end;
        if Shift=[ssAlt] then
        begin
					kontrollpanelrecord.buttonname[i][j]:=kontrollpanelrecord.buttonname[quellzeile][quellspalte];
				  kontrollpanelrecord.buttonfarbe[i][j]:=kontrollpanelrecord.buttonfarbe[quellzeile][quellspalte];
				  kontrollpanelrecord.buttontyp[i][j]:=kontrollpanelrecord.buttontyp[quellzeile][quellspalte];
				  kontrollpanelrecord.buttonshortcut[i][j]:=kontrollpanelrecord.buttonshortcut[quellzeile][quellspalte];
				  kontrollpanelrecord.kanalwerte[i][j]:=kontrollpanelrecord.kanalwerte[quellzeile][quellspalte];
				  kontrollpanelrecord.fadezeit[i][j]:=kontrollpanelrecord.fadezeit[quellzeile][quellspalte];
				  kontrollpanelrecord.audiodatei[i][j]:=kontrollpanelrecord.audiodatei[quellzeile][quellspalte];
          if FileExists(ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp') then CopyFile(PChar((ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp')),PChar((ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp')),False);
					zeilenChange(Sender);
        end;
}
      end;
    end;
  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
	buttonname.Text:=mainform.button[aktuellezeile][aktuellespalte].Caption;
  buttonfarbe.Color:=mainform.button[aktuellezeile][aktuellespalte].Color;
	combobox1.ItemIndex:=kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte];
  HotKey1.HotKey:=kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte];
end;

procedure Tmainform.CHButton1Click(Sender: TObject);
var
	i,j:integer;
  szenenarray:Variant;
begin
    for i:=0 to maxzeile do
    	for j:=0 to maxspalte do
				if (Sender=button[i][j]) or (Sender=labeltype[i][j]) or (Sender=labelshortcut[i][j]) then
        begin
          aktuellezeile:=i;
          aktuellespalte:=j;
        end;

		case kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte] of
    0:
    begin
    end;
    1:
    begin
      // SZENE STARTEN           
      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
      for i:=1 to lastchan do
      	szenenarray[i]:=kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]>-1;
	    for i:=1 to lastchan do
  	    if kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]>-1 then
			  	RefreshDLLValues(i,channelvalue[i],kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i],kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte]);
      SendMSG(MSG_RECORDSCENE,szenenarray,0);
      StatusBar1.Panels.Items[2].Text:=_('Szenenabruf mit ')+inttostr(kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte])+_('ms Einblendzeit');
    end;
    2:
    begin
			// Aktuelles Skript abbrechen
	    for i:=0 to maxzeile do
  	  	for j:=0 to maxspalte do
    			if (buttononline[i][j]) and not (mainform.button[i][j]=Sender) then
          	TChButton(mainform.button[i][j]).Down:=false;

      // SKRIPTABLAUF STARTEN
      if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
      begin
	      StatusBar1.Panels.Items[2].Text:=_('Skriptabruf aus ')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp';
      	listbox.Items.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');

        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          begin
            listbox.items.clear;
            messagedlg(_('Sorry, fehlerhafte Skriptdatei!'),mtError,[mbOK],0);
          end
        else
          listbox.items.delete(0);

        listbox.itemindex:=0;
        if listbox.items.count>0 then
        begin
//	        stop.Enabled:=true;
    	    RunSkript(Sender);
        end;
      end;

{			// Aktuelles Skript abbrechen
	    waitkey:=false;
		  closing:=true;
	    waitkey:=false;
		  for i:=1 to chan do
	    	inprogram[i]:=false;

	    for i:=0 to maxzeile do
  	  	for j:=0 to maxspalte do
    			if (buttononline[i][j]) and not (mainform.button[i][j]=Sender) then
          	TChButton(mainform.button[i][j]).Down:=false;

      // SKRIPTABLAUF STARTEN
      if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
      begin
	      StatusBar1.Panels.Items[2].Text:='Skriptabruf aus '+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp';
      	listbox.Items.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');

        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          begin
            listbox.items.clear;
            messagedlg('Sorry, fehlerhafte Skriptdatei!',mtError,[mbOK],0);
          end
        else
          listbox.items.delete(0);

        listbox.itemindex:=0;
        if listbox.items.count>0 then
        begin
//	        stop.Enabled:=true;
    	    RunSkript(Sender);
        end;
      end;
}    end;
    3:
    begin
      // AUDIODATEI STARTEN
      if fileexists(kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]) then
      begin
	      StatusBar1.Panels.Items[2].Text:=_('Audiodatei ')+kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte];
//        stop.Enabled:=true;
      	mediaplayer1.FileName:=kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte];
        mediaplayer1.Open;
        mediaplayer1.Play;
      end;
    end;
    end;

    StatusBar1.Panels.Items[0].Text:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
  	buttonname.Text:=mainform.button[aktuellezeile][aktuellespalte].Caption;
    buttonfarbe.Color:=mainform.button[aktuellezeile][aktuellespalte].Color;
		combobox1.ItemIndex:=kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte];
    HotKey1.HotKey:=kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte];
end;

procedure Tmainform.buttonfarbeChange(Sender: TObject);
begin
  	button[aktuellezeile][aktuellespalte].Color:=buttonfarbe.Color;
    kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=buttonfarbe.Color;
end;

procedure Tmainform.saveClick(Sender: TObject);
begin
  kontrollpanelrecord.formwidth:=mainform.Width;
  kontrollpanelrecord.formheight:=mainform.Height;
	kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

  savedialog1.DefaultExt:='*.pcdcpnl';
  savedialog1.Filter:=_('PC_DIMMER Kontrollpaneldatei (*.pcdcpnl)|*.pcdcpnl|Alle Dateien|*.*');
  savedialog1.Title:=_('PC_DIMMER Kontrollpanel-Datei öffnen');

	if savedialog1.Execute then
  begin
	  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
	   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
    If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel') then
    	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel');
    try
	    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmCreate);
	    Filestream.WriteBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
	    FileStream.Free;
	    Compress.CompressDirectory(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\',false,savedialog1.FileName);
    except
    	ShowMessage(_('Fehler beim Zugriff auf die Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel'+'"');
    end;
  end;
end;

procedure Tmainform.openClick(Sender: TObject);
begin
  opendialog1.DefaultExt:='*.pcdcpnl';
  opendialog1.Filter:=_('PC_DIMMER Kontrollpaneldatei (*.pcdcpnl)|*.pcdcpnl|Alle Dateien|*.*');
  opendialog1.Title:=_('PC_DIMMER Kontrollpanel-Datei öffnen');
	if opendialog1.Execute then
  begin
    Compress.DecompressFile(opendialog1.FileName,ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\',true,false);
    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmOpenRead);
		FileStream.ReadBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
		FileStream.Free;

    zeilen.AsInteger:=kontrollpanelrecord.zeilenanzahl+1;
		spalten.AsInteger:=kontrollpanelrecord.spaltenanzahl+1;
    mainform.Width:=kontrollpanelrecord.formwidth;
	  mainform.Height:=kontrollpanelrecord.formheight;
    zeilenChange(Sender);
  end;
end;

procedure Tmainform.szenebearbeitenClick(Sender: TObject);
var
	i,h,m,s,t:integer;
begin
case kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte] of
0:
begin
end;
1:
begin
	// SZENE BEARBEITEN
	for i:=1 to chan do
	  insscenedlg.active[i]:=false;

  insscenedlg.StringGrid1.RowCount:=lastchan+1;

  for i:=1 to lastchan do
  begin
    if kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]<>-1 then
    begin
    	insscenedlg.active[i]:=true;
    	insscenedlg.StringGrid1.Cells[3,i]:=inttostr(round(kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]*100 / 255));
    end else
	    insscenedlg.StringGrid1.Cells[3,i]:='0';
    insscenedlg.StringGrid1.Cells[1,i]:=inttostr(i);
    insscenedlg.StringGrid1.Cells[2,i]:=channelnames[i];
  end;

  t:=kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte];
  h:=t div 3600000;
  t:=t mod 3600000;
  m:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  insscenedlg.scenefade_time_h.Text:=inttostr(h);
  insscenedlg.scenefade_time_min.Text:=inttostr(m);
  insscenedlg.scenefade_time.Text:=inttostr(s);
  insscenedlg.scenefade_time_msec.Text:=inttostr(t);

	insscenedlg.Szenenbeschreibung.Text:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];

	if Insscenedlg.Showmodal=mrOK then
	begin
		for i:=1 to lastchan do
		  kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=strtoint(insscenedlg.StringGrid1.cells[3,i])*255 div 100;
	  for i:=1 to lastchan do
		  if not insscenedlg.active[i] then kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=-1;

    kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte]:=strtoint(Insscenedlg.scenefade_time_h.Text)*3600000+strtoint(Insscenedlg.scenefade_time_min.Text)*60000+strtoint(Insscenedlg.scenefade_time.Text)*1000+strtoint(Insscenedlg.scenefade_time_msec.Text);
 		kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=insscenedlg.Szenenbeschreibung.Text;
    button[aktuellezeile][aktuellespalte].Caption:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
    button[aktuellezeile][aktuellespalte].Hint:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
  end;
end;
2:
begin
	// SKRIPT BEARBEITEN
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
	 	listbox.Items.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');
      if listbox.Items.Count>0 then
        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          listbox.items.clear
        else
          listbox.items.delete(0);
//  if (copy(listbox.items[listbox.Items.count-2],0,1)='L') and (listbox.items[listbox.Items.Count-1]='Schalte Kanal:  1 to -1%') then listbox.Items.Delete(listbox.Items.Count-1);
  editskriptfrm.ListBox.Items:=listbox.items;
  editskriptfrm.aktuellezeile:=aktuellezeile;
  editskriptfrm.aktuellespalte:=aktuellespalte;
  editskriptfrm.showmodal;
end;
3:
begin
	// Audiodateipfad eingeben
  opendialog1.DefaultExt:='*.wav';
  opendialog1.Filter:=_('Audiodateien|*.wav;*.mp3;*.wma;*.mid|Alle Dateien|*.*');
  opendialog1.Title:=_('Audiodatei öffnen');
  if opendialog1.Execute then
  begin
  	kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]:=opendialog1.FileName;
    kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=ExtractFilename(kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]);
    button[aktuellezeile][aktuellespalte].caption:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
		button[aktuellezeile][aktuellespalte].Hint:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
  end;
end;
4:
begin
	// FLASHSZENE BEARBEITEN
	for i:=1 to chan do
	  insscenedlg.active[i]:=false;

  insscenedlg.StringGrid1.RowCount:=lastchan+1;

  for i:=1 to lastchan do
  begin
    if kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]<>-1 then
    begin
    	insscenedlg.active[i]:=true;
    	insscenedlg.StringGrid1.Cells[3,i]:=inttostr(round(kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]*100 / 255));
    end else
	    insscenedlg.StringGrid1.Cells[3,i]:='0';
    insscenedlg.StringGrid1.Cells[1,i]:=inttostr(i);
    insscenedlg.StringGrid1.Cells[2,i]:=channelnames[i];
  end;

  insscenedlg.scenefade_time_h.enabled:=false;
  insscenedlg.scenefade_time_min.enabled:=false;
  insscenedlg.scenefade_time.enabled:=false;
  insscenedlg.scenefade_time_msec.enabled:=false;
	insscenedlg.scenefade_timelabel.visible:=false;
  insscenedlg.scenefade_time_h.visible:=false;
  insscenedlg.scenefade_time_min.visible:=false;
  insscenedlg.scenefade_time.visible:=false;
  insscenedlg.scenefade_time_msec.visible:=false;

	insscenedlg.Szenenbeschreibung.Text:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];

	if Insscenedlg.Showmodal=mrOK then
	begin
		for i:=1 to lastchan do
		  kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=strtoint(insscenedlg.StringGrid1.cells[3,i])*255 div 100;
	  for i:=1 to lastchan do
		  if not insscenedlg.active[i] then kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=-1;

    kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte]:=0;
 		kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=insscenedlg.Szenenbeschreibung.Text;
    button[aktuellezeile][aktuellespalte].Caption:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
    button[aktuellezeile][aktuellespalte].Hint:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
  end;

  insscenedlg.scenefade_time_h.enabled:=true;
  insscenedlg.scenefade_time_min.enabled:=true;
  insscenedlg.scenefade_time.enabled:=true;
  insscenedlg.scenefade_time_msec.enabled:=true;
	insscenedlg.scenefade_timelabel.visible:=true;
  insscenedlg.scenefade_time_h.visible:=true;
  insscenedlg.scenefade_time_min.visible:=true;
  insscenedlg.scenefade_time.visible:=true;
  insscenedlg.scenefade_time_msec.visible:=true;
end;
5:
begin
	// SKRIPT BEARBEITEN
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
	 	listbox.Items.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');
      if listbox.Items.Count>0 then
        if listbox.items[0]<>inttostr(listbox.items.count-1) then
          listbox.items.clear
        else
          listbox.items.delete(0);
//  if (copy(listbox.items[listbox.Items.count-2],0,1)='L') and (listbox.items[listbox.Items.Count-1]='Schalte Kanal:  1 to -1%') then listbox.Items.Delete(listbox.Items.Count-1);
  editskriptfrm.ListBox.Items:=listbox.items;
  editskriptfrm.aktuellezeile:=aktuellezeile;
  editskriptfrm.aktuellespalte:=aktuellespalte;
  editskriptfrm.showmodal;
end;
6:
begin
	// Audiodateipfad eingeben
  opendialog1.DefaultExt:='*.wav';
  opendialog1.Filter:=_('Audiodateien|*.wav;*.mp3;*.wma;*.mid|Alle Dateien|*.*');
  opendialog1.Title:=_('Audiodatei öffnen');
  if opendialog1.Execute then
  begin
    kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]:=opendialog1.FileName;
    kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=ExtractFilename(kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]);
    button[aktuellezeile][aktuellespalte].caption:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
    button[aktuellezeile][aktuellespalte].Hint:=kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte];
  end;
end;
end;
	CheckFileExistsTimer(nil);
end;

procedure Tmainform.buttonnameEnter(Sender: TObject);
begin
	if buttonname.Text='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1) then
  	buttonname.Text:='';
end;

procedure Tmainform.buttonnameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if not shutdown then
	begin
  	button[aktuellezeile][aktuellespalte].caption:=buttonname.Text;
    button[aktuellezeile][aktuellespalte].Hint:=buttonname.Text;
    kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=buttonname.Text;
		if buttonname.Text=_('Rot') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clRed;
		if buttonname.Text=_('Gelb') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clYellow;
		if buttonname.Text=_('Grün') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clLime;
		if buttonname.Text=_('Schwarz') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clBlack;
		if buttonname.Text=_('Weiß') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clWhite;
		if buttonname.Text=_('Grau') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clGray;
		if buttonname.Text=_('Rosa') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clFuchsia;
		if buttonname.Text=_('Blau') then kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clBlue;
    button[aktuellezeile][aktuellespalte].color:=kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte];
	end;
end;

procedure LockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure UnlockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0,
    RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure TMainForm.RunSkript(Sender: TObject);
var
  h,m,s,msec,c,vs,ve,i,j,k,animationszeit:integer;
  nsteps,stp:integer;
  timestep,t,fadezeit:longint;
  wt,start,tijd:TDateTime;
  opt,st,st1,st2:string;
  itemidx:integer;
  ready,waitkey:boolean;
  act: TAct;
  beg,n:integer;
  list: array[1..chan] of TStringList;
begin
try
skriptisrunning:=true;
if listbox.Items.count>0 then
begin
  if (copy(listbox.Items[listbox.Items.Count-1],0,1)='L') and (listbox.Items.Count-1>0) then listbox.Items.Add(_('Schalte Kanal:  1 to -1%'));

  for j:=1 to lastchan do
  	list[j]:=TStringList.Create;  {Listen generieren}

  closing:=false;
  keypressed:=false;
  waitkey:=false;

// letzten Eintrag auf Sync-Option überprüfen
  if listbox.items.count<>0 then
  repeat
    st1:=listbox.items[listbox.items.count-1];
    if copy(st1,0,1)='L' then listbox.items.delete(listbox.items.count-1);
  until (copy(st1,0,1)<>'L') or (listbox.items.count=0) ;
// ersten Eintrag auf Sync-Option überprüfen
  if listbox.items.count<>0 then
  repeat
    st1:=listbox.items[0];
    if (copy(st1,0,1)='L') then listbox.items.delete(0);
  until (copy(st1,0,1)<>'L') or (listbox.items.count=0) ;

if listbox.items.count<>0 then
repeat
  {}

  beg:=0;
  n:=0;

// große repeat Schleife beginnen
  repeat
    beg:=beg+n+1;
    n:=0;
    repeat
      st1:=listbox.items[beg-1+n];
      if (copy(st1,0,1)<>'L') then inc(n);
    until (copy(st1,0,1)='L') or ((beg+n-1)>=listbox.items.count);
    if (copy(st1,0,1)='L') and (length(st1)>30) then {falls "auf Tastendruck warten"}
      waitkey:=true;
  {}

  for i:=1 to lastchan do
  	inprogram[i]:=false;

  for i:=beg to (beg+n-1) do {Welche Kanäle sind im Programm}
    begin
      st:=listbox.items[i-1];
      opt:=copy(st,1,1);
      while pos(',',st)<>0 do
        begin
          c:=strtoint(copy(st,pos(',',st)-3,3));
            inprogram[c]:=true;
          if c<10 then delete(st,pos(inttostr(c),st),2)
          else if c<100 then delete(st,pos(inttostr(c),st),3)
          else delete(st,pos(inttostr(c),st),4);
        end;
      if opt='W' then
        begin
          if listbox.Count>0 then
          begin
            c:=strtoint(copy(st,pos('for',st)-4,3));
            inprogram[c]:=true;
          end;
        end;
      if opt='S' then
        begin
          c:=strtoint(copy(st,pos('to',st)-4,3));
          inprogram[c]:=true;
        end;
      if opt='F' then
        begin
          c:=strtoint(copy(st,pos('from',st)-4,3));
          inprogram[c]:=true;
        end;
    end;

//  UpdateLevels;

  for i:=beg to (beg+n-1) do {Listen für alle Kanäle erstellen}
    begin
      st:=listbox.items[i-1];
      delete(st,pos(':',st),1); {das brauchen wir später für die Zeit}
      opt:=copy(st,1,1);
      while pos(',',st)<>0 do
        begin
          c:=strtoint(copy(st,pos(',',st)-3,3));
          if c<10 then
          	delete(st,pos(inttostr(c),st),2)
          else
          	if c<100 then delete(st,pos(inttostr(c),st),3)
          else
          	delete(st,pos(inttostr(c),st),4);
//{
          if opt='F' then
            begin
              st1:='Schalte Kanal:  ' + inttostr(c) + ' to ' +
                   inttostr(strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)))) + '%';
              for j:=1 to lastchan do (if (c=j) then list[j].add(st1));
            end;
              for j:=1 to lastchan do (if (c=j) then list[j].add(st));
//}
        end;
      if opt='W' then
        begin
          c:=strtoint(copy(st,pos('for',st)-4,3));
          for j:=1 to lastchan do (if (c=j) then list[j].add(st));
        end;
      if opt='S' then
        begin
          c:=strtoint(copy(st,pos('to',st)-4,3));
          for j:=1 to lastchan do (if (c=j) then list[j].add(st));
        end;
      if opt='F' then
        begin
          c:=strtoint(copy(st,pos('from',st)-4,3));
          st1:='Schalte Kanal:  ' + inttostr(c) + ' to ' +
               inttostr(strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)))) + '%';
          for j:=1 to lastchan do (if (c=j) then list[j].add(st1));
          for j:=1 to lastchan do (if (c=j) then list[j].add(st));
        end;
    end;
  for i:=1 to lastchan do
    act.ch_ready[i]:=true; {Alle Kanäle bereit}
  ready:=false;
  while not ready and not closing do
    begin
      tijd:=time;
      for i:=1 to lastchan do {Prüfen, ob "Warte-" oder "Fade-" Aktion fertig sind}
        if not act.ch_ready[i] then act.ch_ready[i]:=(tijd-act.start[i])>=act.wt[i];
      ready:=true; {Prüfen, ob Script abgearbeitet wurde}
      for j:=1 to lastchan do (if ((list[j].count<>0) or not (act.ch_ready[j])) then ready:=false else inprogram[j]:=false);

      tijd:=time;
      for i:=1 to lastchan do
       if act.ch_ready[i] and inprogram[i] then
        begin
		  		actualfadevalue[i]:=inttostr((channelvalue[i])*100 div 255)+'%';
          for j:=1 to lastchan do (if ((i=j) and (list[j].count<>0)) then st:=list[j][0]);
          opt:=copy(st,1,1);
          if opt='W' then
            begin
              h:=strtoint(copy(st,pos(':',st)-2,2));
              m:=strtoint(copy(st,pos(':',st)+1,2));
              s:=strtoint(copy(st,pos('.',st)-2,2));
              msec:=strtoint(copy(st,pos('.',st)+1,3));
              if ((h=0) and (m=0) and (s=0) and (msec=0)) then
              begin
              	h:=temposlider.Position div 3600000;
                m:=(temposlider.Position mod 3600000) div 60000;
                s:=((temposlider.Position mod 3600000) mod 60000) div 1000;
                msec:=(((temposlider.Position mod 3600000) mod 60000) mod 1000);
              end;
              act.opt[i]:=opt;
              act.ch_ready[i]:=false;
              act.wt[i]:=encodetime(h,m,s,msec);
              act.start[i]:=tijd;
            end;
          if opt='S' then
            begin
              vs:=strtoint(copy(st,pos('to',st)+3,pos('%',st)-(pos('to',st)+3)));
              if vs=-1 then   // wenn Startwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                vs:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              vs:=round((vs*255)/100);
//              vs:=255-vs;
              RefreshDLLValues(i,vs,vs,0);
            end;
          if opt='F' then
            begin
              vs:=strtoint(copy(st,pos('from',st)+5,pos('%',st)-(pos('from',st)+5)));
              if vs=-1 then   // wenn Startwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                vs:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              vs:=round((vs*255)/100);
//              vs:=255-vs;
              ve:=strtoint(copy(st,pos('to',st)+3,pos('% in',st)-(pos('to',st)+3)));
              if ve=-1 then   // wenn Endwert = -1, dann soll aktueller Wert eingesetzt werden
              begin
                st2:=actualfadevalue[i];
                ve:=strtoint(copy(st2,1,pos('%',st2)-1));
              end;
              ve:=round((ve*255)/100);
//              ve:=255-ve;

              h:=strtoint(copy(st,pos(':',st)-2,2));
              m:=strtoint(copy(st,pos(':',st)+1,2));
              s:=strtoint(copy(st,pos('.',st)-2,2));
              msec:=strtoint(copy(st,pos('.',st)+1,3));

              if ((h=0) and (m=0) and (s=0) and (msec=0)) then
              begin
              	h:=temposlider.Position div 3600000;
                m:=(temposlider.Position mod 3600000) div 60000;
                s:=((temposlider.Position mod 3600000) mod 60000) div 1000;
                msec:=(((temposlider.Position mod 3600000) mod 60000) mod 1000);
              end;
              
              stp:=0;
              t:=(h*3600)+(m*60)+s;
              t:=t*100; {Umwandeln in 10ms}
              t:=t+(msec div 10);
              fadezeit:=(((h*3600)+(m*60)+s)*1000)+msec;
              nsteps:=abs(vs-ve);

              RefreshDLLValues(i,vs,ve,fadezeit);

              if (nsteps<>0) and (t<>0) then
                begin
                  repeat
                    inc(stp);
                    timestep:=t*stp;
                    timestep:=round(timestep/nsteps);
                  until (abs(((t-((timestep*nsteps)/stp))*100)/t) <= 15) or (stp>=4);
                end
              else
                begin
                  timestep:=0;
                  inc(stp);
                end;

              t:=(timestep*nsteps) div stp;
              h:=t div 360000; t:=t mod 360000;
              m:=t div 6000; t:=t mod 6000;
              s:=t div 100; t:=t mod 100;
              act.opt[i]:=opt;
              act.ch_ready[i]:=false;
              act.wt[i]:=encodetime(h,m,s,t*10);
              act.start[i]:=tijd;
            end;
          for j:=1 to lastchan do (if (i=j) then (list[j].Delete(0))); {aktuelles Kommando löschen}
        end;
      application.processmessages;
      sleep(1);
    end;

  {}

    if waitkey then
      begin
       presskeyfrm.ShowModal;
        while presskeyfrm.Showing and not closing do
          begin
            application.processmessages;
          end;
        keypressed:=false;
        waitkey:=false;
      end;
  until ((beg+n-1)=listbox.items.count) or closing;
  {}
  until (repeatskript.checked=false) or closing;

  for j:=1 to lastchan do (list[j].Free); {Liste löschen}

end;
//  stop.Enabled:=false;
skriptisrunning:=false;
except
end;
end;

procedure Tmainform.ComboBox1Select(Sender: TObject);
var
	i:integer;
begin
  case combobox1.ItemIndex of
    0:
    begin
      if messagedlg(_('Durch setzen des Buttontyps auf "<Leer>" werden gespeicherte Szenen und eventuell vorhandene Skriptdateien gelöscht. Fortfahren?'),mtConfirmation,
        [mbYes,mbNo],0)=mrNo then exit;
      labeltype[aktuellezeile][aktuellespalte].Caption:=' ';
      button[aktuellezeile][aktuellespalte].Color:=clBtnFace;
      kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
      button[aktuellezeile][aktuellespalte].Caption:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
      kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clBtnFace;
      kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]:=0;
      kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]:='';
		  labelshortcut[aktuellezeile][aktuellespalte].Caption:=ShortCutToText(kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]);
      if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');
      for i:=1 to chan do
      	kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=-1;
    end;
   	1: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Szene');
   	2: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Skript');
   	3: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Audiodatei');
   	4: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Flashszene');
   	5: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Flashskript');
   	6: labeltype[aktuellezeile][aktuellespalte].Caption:=_('Flashaudio');
  end;
	kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte]:=combobox1.ItemIndex;
	CheckFileExistsTimer(nil);
end;

procedure Tmainform.stopClick(Sender: TObject);
var
  i:integer;
begin
	case kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte] of
  0:
  begin
  end;
  1:
  begin
    // SZENE ABBRECHEN
	  for i:=1 to lastchan do
			RefreshDLLValues(i,channelvalue[i],channelvalue[i],0);
  end;
  2:
  begin
    // SKRIPT ABBRECHEN
    waitkey:=false;
	  closing:=true;
    waitkey:=false;
{
	  for i:=1 to lastchan do
	  begin
    	inprogram[i]:=false;
			RefreshDLLValues(i,channelvalue[i],channelvalue[i],0);
    end;
}
  end;
  3:
  begin
    // AUDIODATEI STOPPEN   
  	mediaplayer1.Stop;
  end;
  end;

//	stop.Enabled:=false;
end;

procedure Tmainform.temposliderChange(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text:=floattostrf(60000 / temposlider.Position, ffGeneral , 4, 2)+' BPM / '+floattostrf(temposlider.Position / 1000, ffGeneral , 4, 2)+'s';
	beattime_blinker.Interval:=temposlider.Position;
//  beattime_blinker.Interval:=(beat_endtime.Time - beat_starttime.Time);
	edit1.Text:=floattostrf(60000 / temposlider.Position, ffGeneral , 4, 2);
  if tempokoppeln.Checked and not MSGFROMMAINPROGRAM and not shutdown then
  	SendMSG(MSG_SYSTEMSPEED,temposlider.Position,0);
end;

procedure Tmainform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
	try
    temposlider.Position:=60000 div strtoint(edit1.text);
  except
  	edit1.Text:='60';
  end;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
var
	i:integer;
  CSV : TStrings;
	LReg:TRegistry;
begin
  shutdown:=true;
  for i:=1 to lastchan do
		inprogram[i]:=false;
  waitkey:=false;
  closing:=true;
  waitkey:=false;

  kontrollpanelrecord.formwidth:=mainform.Width;
  kontrollpanelrecord.formheight:=mainform.Height;
	kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
  if not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel') then
  	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel');
  try
    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmCreate);
	  Filestream.WriteBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
	  FileStream.Free;
  except
  	ShowMessage(_('Fehler beim Zugriff auf die Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel'+'"');
  end;

  // MIDI-Ereignisse in CSV-Datei schreiben
  if length(MidiEventArray)>0 then
  begin
	  CSV := TStringlist.Create;
	  For i :=0 To length(MidiEventArray)-1 do
	  	CSV.Add(inttostr(MidiEventArray[i][1])+','+inttostr(MidiEventArray[i][2])+','+inttostr(MidiEventArray[i][3])+','+inttostr(MidiEventArray[i][4])+','+inttostr(MidiEventArray[i][5])+','+inttostr(MidiEventArray[i][6])+','+inttostr(MidiEventArray[i][7]));
	  CSV.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
	  CSV.Free;
  end else
  begin
  	if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi') then
    	DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
  end;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          LReg.WriteBool('Couple speed with Mainprogram',tempokoppeln.Checked);
	        LReg.WriteBool('Show setup',MenanzeigenDoppelklickaufStatusleiste1.Checked);
          LReg.WriteBool('Deactivate Mainprogrameffects on click',hauptprogrammeffekteaus.checked);
          LReg.WriteBool('Enable Tooltips',ooltipsanzeigen1.checked);
          LReg.WriteInteger('PosX',mainform.Left);
          LReg.WriteInteger('PosY',mainform.Top);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure Tmainform.newClick(Sender: TObject);
begin
if messagedlg(_('Möchten Sie das Kontrollpanelpanel wirklich zurücksetzen?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
	begin
		NewPanel;
	end;
end;

procedure Tmainform.StatusBar1DblClick(Sender: TObject);
begin
  if panel1.Visible then
  begin
	  panel1.Visible:=false;
	  mainform.Height:=mainform.Height-panel1.Height;
    mainform.Top:=mainform.Top+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=false;
  end else
  begin
    mainform.Top:=mainform.Top-panel1.Height;
	  panel1.Visible:=true;
	  mainform.Height:=mainform.Height+panel1.Height;
    MenanzeigenDoppelklickaufStatusleiste1.Checked:=true;
  end;

//  mainform.Resize();
end;

procedure Tmainform.MediaPlayer1Notify(Sender: TObject);
begin
	if (mediaplayer1.Position=mediaplayer1.Length) and (repeatskript.Checked) then
  begin
  	mediaplayer1.Rewind;
    mediaplayer1.Play;
  end else if (mediaplayer1.Position=mediaplayer1.Length) then
//  	stop.enabled:=false;
end;

procedure Tmainform.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	i,j:integer;
  MyKey:Word;
  MyShift:TShiftState;
begin
  if (flashingkey<>key) and (flashingshift<>Shift) then
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
			ShortCutToKey(kontrollpanelrecord.buttonshortcut[i][j],MyKey,MyShift);
      if (MyKey=Key) and (MyShift=Shift) then
      begin
        flashingkey:=Key;
        flashingshift:=shift;
      	button[i][j].OnMouseDown(button[i][j],mbLeft,[ssLeft],0,0);
      	button[i][j].OnClick(button[i][j]);
      end;
    end;
  end;
end;

procedure Tmainform.CheckBox1Exit(Sender: TObject);
begin
  CheckBox1.Checked:=false;
end;

procedure Tmainform.HotKey1Change(Sender: TObject);
begin
	kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]:=HotKey1.HotKey;
  labelshortcut[aktuellezeile][aktuellespalte].Caption:=ShortCutToText(kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]);
end;

procedure Tmainform.CheckFileExistsTimer(Sender: TObject);
var
	i,j:integer;
begin
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
      if buttononline[i][j] then
    	case kontrollpanelrecord.buttontyp[i][j] of
				0:
				begin
		      labeltype[i][j].Transparent:=True;
    		  labeltype[i][j].Color:=clBtnFace;
        end;        
        1:
        begin
		      labeltype[i][j].Transparent:=True;
    		  labeltype[i][j].Color:=clBtnFace;
        end;
	      2:
	      begin
          // Skriptdatei
          if not FileExists(ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp') then
   				begin
          	labeltype[i][j].Caption:=_('Skript (Datei fehlt!)');
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:=_('Skript');
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=clBtnFace;
          end;
	      end;
	      3:
	      begin
        	// Audiodatei
          if not FileExists(kontrollpanelrecord.audiodatei[i][j]) then
   				begin
          	labeltype[i][j].Caption:=_('Audiodatei (Datei fehlt!)');
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:=_('Audiodatei');
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=clBtnFace;
          end;
	      end;
				4:
        begin
		      labeltype[i][j].Transparent:=True;
          labeltype[i][j].Color:=clBtnFace;
        end;
	      5:
	      begin
          // Skriptdatei
          if not FileExists(ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp') then
   				begin
          	labeltype[i][j].Caption:=_('Flashskript (Datei fehlt!)');
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:=_('Flashskript');
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=clBtnFace;
          end;
	      end;
        6:
        begin
        	// Audiodatei
          if not FileExists(kontrollpanelrecord.audiodatei[i][j]) then
   				begin
          	labeltype[i][j].Caption:=_('Audiodatei (Datei fehlt!)');
            labeltype[i][j].Transparent:=false;
            labeltype[i][j].Color:=clRed;
          end else
          begin
          	labeltype[i][j].Caption:=_('Audiodatei');
            labeltype[i][j].Transparent:=True;
            labeltype[i][j].Color:=clBtnFace;
          end;
        end;
      end;
		end;
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
	i,j,k:integer;
begin
	shutdownbypcdimmeroff:=false;

  beat_syncFirstclick:=true;
  flashingkey:=0;
  flashingshift:=[ssLeft];

	aktuellezeile:=0;
	aktuellespalte:=0;

	for i:=0 to maxzeile do
  	for j:=0 to maxspalte do
    begin
    	kontrollpanelrecord.buttonname[i][j]:='Button '+inttostr(i+1)+'x'+inttostr(j+1);
      kontrollpanelrecord.buttonfarbe[i][j]:=clBtnFace;
      for k:=1 to chan do
      	kontrollpanelrecord.kanalwerte[i][j][k]:=-1;
      kontrollpanelrecord.fadezeit[i][j]:=0;
      kontrollpanelrecord.buttontyp[i][j]:=0;
      kontrollpanelrecord.audiodatei[i][j]:='';
      kontrollpanelrecord.formwidth:=626;
      kontrollpanelrecord.formheight:=272;
    end;

  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel') then
   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel');
  if fileexists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel') then
  begin
    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmOpenRead);
		FileStream.ReadBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
		FileStream.Free;

    zeilen.AsInteger:=kontrollpanelrecord.zeilenanzahl+1;
		spalten.AsInteger:=kontrollpanelrecord.spaltenanzahl+1;
  end;
	zeilenChange(Sender);
end;

procedure Tmainform.sync_btnClick(Sender: TObject);
begin
  if beat_syncFirstclick then
  begin
    beat_starttime:=DateTimeToTimeStamp(now);
    sync_btn.Caption:='End';
    beat_syncFirstclick:=false;
  end else
  begin
    beat_endtime:=DateTimeToTimeStamp(now);
    temposlider.Position:=(beat_endtime.Time - beat_starttime.Time);
    sync_btn.Caption:='Sync';
    beat_syncFirstclick:=true;
//    edit1.Text:=inttostr(round(60000 div temposlider.Position));
  end;end;

procedure Tmainform.beattime_blinkerTimer(Sender: TObject);
begin
	if shape1.Brush.Color=clMaroon then
    shape1.Brush.Color:=clRed
  else
    shape1.Brush.Color:=clMaroon;
end;

procedure Tmainform.CheckBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	i,j:integer;
  MyKey:Word;
  MyShift:TShiftState;
begin
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
			ShortCutToKey(kontrollpanelrecord.buttonshortcut[i][j],MyKey,MyShift);
      if (MyKey=Key) and (MyShift=Shift) then
      begin
        flashingkey:=0;
        flashingshift:=[ssLeft];
      	button[i][j].OnMouseUp(button[i][j],mbLeft,[ssLeft],0,0);
      end;
    end;
  end;
end;

procedure Tmainform.buttonsupTimer(Sender: TObject);
var
	i,j:integer;
begin
 	for i:=0 to maxzeile do
		for j:=0 to maxspalte do
    	if (buttononline[i][j]) then
				TChButton(mainform.button[i][j]).Down:=false;
	buttonsup.Enabled:=false;
end;

procedure Tmainform.MidiInput(MidiMessage,Data1,Data2:byte);
var
  i:integer;
begin
	// EditForm bei MIDI-Daten aktualisieren, wenn Form angezeigt wird
	if EditMIDIEVENTfrm.showing then
	begin
		EditMIDIEVENTfrm.Message1b.caption:=inttostr(MidiMessage);
		EditMIDIEVENTfrm.Data1b.caption:=inttostr(Data1);
		EditMIDIEVENTfrm.Data2b.caption:=inttostr(Data2);
		if EditMIDIEVENTfrm.recordmidi.checked then
		begin
			EditMIDIEVENTfrm.Message1a.caption:=inttostr(MidiMessage);
			EditMIDIEVENTfrm.Data1a.caption:=inttostr(Data1);
			EditMIDIEVENTfrm.Data2a.caption:=inttostr(Data2);
			EditMIDIEVENTfrm.recordmidi.checked:=false;
		end;
	end;

	// Zugewiesenes Ereignis bei MIDI-Daten ausführen
	if length(MidiEventArray)>0 then
	for i:=0 to length(MidiEventArray)-1 do
	begin
		if (MidiMessage=MidiEventArray[i][1]) then
		begin
			if MidiEventArray[i][7]=2 then
			begin
				if Data1=MidiEventArray[i][2] then
				begin
          // Wenn Tastendruck, dann entsprechende Zeile markieren
         	if (Data2>0) and (MidiMessage=144) then
         		midieventfrm.MIDIGrid.Cells[7,i+1]:='X'
         	else
						midieventfrm.MIDIGrid.Cells[7,i+1]:='';

          // Aktuellen MIDI-Wert in Liste anzeigen
		    	midieventfrm.MIDIGrid.cells[1,i+1]:=inttostr(mainform.MidiEventArray[i][2]);	// Data1
		      midieventfrm.MIDIGrid.cells[2,i+1]:=inttostr(Data2);

					// Zugewiesenes Ereignis herausfinden und Ausführen
        ExecuteMIDIEvents(i,Data2);
				end;
			end else
			begin
          // Wenn Tastendruck, dann entsprechende Zeile markieren
          if (Data1>0) and (MidiMessage=144) then
          	midieventfrm.MIDIGrid.Cells[7,i+1]:='X'
          else
						midieventfrm.MIDIGrid.Cells[7,i+1]:='';

          // Aktuellen MIDI-Wert in Liste anzeigen
		      midieventfrm.MIDIGrid.cells[1,i+1]:=inttostr(Data1);
					midieventfrm.MIDIGrid.cells[2,i+1]:=inttostr(Data2);

				// Zugewiesenes Ereignis herausfinden und Ausführen
        ExecuteMIDIEvents(i,Data1);
			end;
		end;
	end;
end;

procedure Tmainform.ExecuteMIDIEvents(i:Byte; Data:Byte);
var
	szenenarray:Variant;
  j:integer;
begin
	if not shutdown then
	case MidiEventArray[i][4] of
		0: // Single Channel change with dynamic Key input
		begin
      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
      for j:=1 to lastchan do
      	szenenarray[j]:=(j=MidiEventArray[i][5]);
			if Data>0 then
      begin
        if MidiEventArray[i][1]=144 then
        	channelvalue_temp[MidiEventArray[i][5]]:=channelvalue[MidiEventArray[i][5]];
	      RefreshDLLValues(MidiEventArray[i][5],Data*2,Data*2,0);
      end else
	    begin
        if MidiEventArray[i][1]=144 then
	        RefreshDLLValues(MidiEventArray[i][5],channelvalue_temp[MidiEventArray[i][5]],channelvalue_temp[MidiEventArray[i][5]],0)
        else
	      	RefreshDLLValues(MidiEventArray[i][5],Data*2,Data*2,0);
      end;
      SendMSG(MSG_RECORDSCENE,szenenarray,0);
      StatusBar1.Panels.Items[2].Text:='MIDI: Kanal '+inttostr(MidiEventArray[i][5])+' auf '+inttostr(round(Data/127*100))+'%';
		end;
		1: // Single Channel change
		begin
      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
      for j:=1 to lastchan do
      	szenenarray[j]:=(j=MidiEventArray[i][5]);
			if Data > 0 then
      begin
        if MidiEventArray[i][1]=144 then
        	channelvalue_temp[MidiEventArray[i][5]]:=channelvalue[MidiEventArray[i][5]];
        RefreshDLLValues(MidiEventArray[i][5],MidiEventArray[i][6],MidiEventArray[i][6],0);
			end else
      begin
        if MidiEventArray[i][1]=144 then
	        RefreshDLLValues(MidiEventArray[i][5],channelvalue_temp[MidiEventArray[i][5]],channelvalue_temp[MidiEventArray[i][5]],0)
        else
	      	RefreshDLLValues(MidiEventArray[i][5],0,0,0);
      end;
      SendMSG(MSG_RECORDSCENE,szenenarray,0);
      StatusBar1.Panels.Items[2].Text:='MIDI: Kanal '+inttostr(MidiEventArray[i][5])+' auf '+inttostr(round(MidiEventArray[i][6]/255*100))+'%';
		end;
		2: // Button press
		begin
			if Data > 0 then
			begin
      	button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1].OnMouseDown(button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1],mbLeft,[ssLeft],0,0);
      	button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1].OnClick(button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1]);
      end	else
      begin
				button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1].OnMouseUp(button[MidiEventArray[i][5]-1][MidiEventArray[i][6]-1],mbLeft,[ssLeft],0,0);
      end;
      StatusBar1.Panels.Items[2].Text:='MIDI: Button '+inttostr(MidiEventArray[i][5])+'x'+inttostr(MidiEventArray[i][6]);
		end;
		3: // Speed change
		begin
      StatusBar1.Panels.Items[2].Text:=_('MIDI: Geschwindigkeit setzen');
      temposlider.Position:=round(( {}power((127-Data),10)/power(127,10){} )*60000);
      //temposlider.Position:=round((Data/127)*60000);
			// SetSpeed to Data;
		end;
		4: // Lautstärke
		begin
      StatusBar1.Panels.Items[2].Text:=_('MIDI: Lautstärke setzen');
      SendMSG(MSG_SYSTEMVOLUME,Data*2,0);
		end;
		5: // Mute
		begin
      StatusBar1.Panels.Items[2].Text:='MIDI: Mute on/off';
      if Data>=MidiEventArray[i][5] then
      	SendMSG(MSG_SYSTEMMUTE,False,0)
      else
				SendMSG(MSG_SYSTEMMUTE,True,0);
		end;
		6: // Grandmaster
		begin
      StatusBar1.Panels.Items[2].Text:=_('MIDI: Grandmaster setzen');
      SendMSG(MSG_GRANDMASTER,Data*2,0);
		end;
		7: // Flashmaster
		begin
      StatusBar1.Panels.Items[2].Text:=_('MIDI: Flashmaster setzen');
      SendMSG(MSG_FLASHMASTER,Data*2,0);
		end;
    8: // Jump to Channel
    begin
      StatusBar1.Panels.Items[2].Text:=_('MIDI: Kanal ändern');
      if ((data*MidiEventArray[i][5])<=(chan-MidiEventArray[i][5])) and ((data*MidiEventArray[i][5])<=(chan-8)) then
        SendMSG(MSG_JUMPTOCHANNEL,Data*MidiEventArray[i][5],0);
    end;
	end;
end;

procedure Tmainform.MIDIClick(Sender: TObject);
begin
	midieventfrm.ShowModal;
end;

procedure Tmainform.IndenVordergrund1Click(Sender: TObject);
begin
  mainform.FormStyle:=fsStayOnTop;
	Normal1.Checked:=false;
	IndenVordergrund1.Checked:=true;
end;

procedure Tmainform.Normal1Click(Sender: TObject);
begin
  mainform.FormStyle:=fsNormal;
	Normal1.Checked:=true;
	IndenVordergrund1.Checked:=false;
end;

procedure Tmainform.tempokoppelnClick(Sender: TObject);
begin
  tempokoppeln.Checked:=not tempokoppeln.Checked;
end;

procedure Tmainform.hauptprogrammeffekteausClick(Sender: TObject);
begin
	hauptprogrammeffekteaus.Checked:=not hauptprogrammeffekteaus.Checked;
end;

procedure Tmainform.Beenden1Click(Sender: TObject);
begin
	close;
end;

procedure Tmainform.MSGOpen(Sender: TObject);
var
  CSV:TStrings;
  i:integer;
  temp:string;
begin
  i:=0;
  // Hauptdatei laden
  if fileexists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel') then
  begin
    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmOpenRead);
		FileStream.ReadBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
		FileStream.Free;

    zeilen.AsInteger:=kontrollpanelrecord.zeilenanzahl+1;
		spalten.AsInteger:=kontrollpanelrecord.spaltenanzahl+1;
    mainform.Width:=kontrollpanelrecord.formwidth;
	  mainform.Height:=kontrollpanelrecord.formheight;
  end;
	zeilenChange(Sender);

  // MIDI-Ereignisse aus CSV-Datei lesen
  try
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi') then
  begin
	  CSV := TStringlist.Create;
	  CSV.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
	  if csv.Count>0 then
	  begin
		  setlength(MidiEventArray,csv.Count);
	  	MIDIEVENTfrm.MIDIGrid.RowCount:=csv.Count+1;

		  For i:=0 To length(MidiEventArray)-1 do
		  begin
		    temp:=CSV.Strings[i];
		    MidiEventArray[i][1]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][2]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][3]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][4]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][5]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][6]:=strtoint(copy(temp,0,pos(',',temp)-1));
		    temp:=copy(temp,pos(',',temp)+1,length(temp));
		    MidiEventArray[i][7]:=strtoint(temp);
		    MIDIEVENTfrm.MIDIGrid.RowHeights[i+1]:=15;
		  	MIDIEVENTfrm.refreshList(i+1);
		  end;
		  CSV.Free;

		  if length(MidiEventArray)>0 then
		  begin
		    MIDIEVENTfrm.editmidievent.Enabled:=true;
		    MIDIEVENTfrm.deletemidievent.Enabled:=true;
		  end else
		  begin
		    MIDIEVENTfrm.editmidievent.Enabled:=false;
		    MIDIEVENTfrm.deletemidievent.Enabled:=false;
		  end;
	  end;
	end;
  except
  	ShowMessage(_('Beim Laden der Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi'+_('" ist ein Fehler in Zeile ')+inttostr(i+1)+_(' aufgetreten. Die MIDI-Einstellungen können unter Umständen nicht korrekt geladen werden.'));
		// Letzten Eintrag löschen
		setlength(MidiEventArray,length(MidiEventArray)-1);
	  if MIDIEVENTfrm.MIDIGrid.RowCount>2 then
		begin
	  	MIDIEVENTfrm.MIDIGrid.rowcount:=MIDIEVENTfrm.MIDIGrid.rowcount-1;
			// komplette Liste aktualisieren
			for i:=1 to MIDIEVENTfrm.MIDIGrid.rowcount do
			begin
				MIDIEVENTfrm.refreshList(i);
			end;
		end else
	  begin
			MIDIEVENTfrm.MIDIGrid.cells[0,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[1,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[2,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[3,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[4,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[5,1]:='';
			MIDIEVENTfrm.MIDIGrid.cells[6,1]:='';
	  	MIDIEVENTfrm.deletemidievent.Enabled:=false;
	    MIDIEVENTfrm.editmidievent.Enabled:=false;
	  end;
  end;

  if length(MidiEventArray)>0 then
  begin
    MIDIEVENTfrm.editmidievent.Enabled:=true;
    MIDIEVENTfrm.deletemidievent.Enabled:=true;
  end else
  begin
    MIDIEVENTfrm.editmidievent.Enabled:=false;
    MIDIEVENTfrm.deletemidievent.Enabled:=false;
  end;
end;

procedure Tmainform.MSGSave(Sender: TObject);
var
  CSV:TStrings;
  i:integer;
begin
  // Hauptdatei speichern
  kontrollpanelrecord.formwidth:=mainform.Width;
  kontrollpanelrecord.formheight:=mainform.Height;
	kontrollpanelrecord.zeilenanzahl:=zeilen.AsInteger-1;
  kontrollpanelrecord.spaltenanzahl:=spalten.AsInteger-1;

  If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
  if not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel') then
  	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel');
  try
    FileStream:=TFileStream.Create(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel',fmCreate);
	  Filestream.WriteBuffer(kontrollpanelrecord,sizeof(kontrollpanelrecord));
	  FileStream.Free;
  except
  	ShowMessage(_('Fehler beim Zugriff auf die Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Kontrollpanel'+'"');
  end;

  // MIDI-Ereignisse in CSV-Datei schreiben
  if length(MidiEventArray)>0 then
  begin
	  CSV := TStringlist.Create;
	  For i :=0 To length(MidiEventArray)-1 do
	  	CSV.Add(inttostr(MidiEventArray[i][1])+','+inttostr(MidiEventArray[i][2])+','+inttostr(MidiEventArray[i][3])+','+inttostr(MidiEventArray[i][4])+','+inttostr(MidiEventArray[i][5])+','+inttostr(MidiEventArray[i][6])+','+inttostr(MidiEventArray[i][7]));
	  CSV.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
	  CSV.Free;
  end else
  begin
  	if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi') then
    	DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\MIDISettings.pcdmidi');
  end;
end;

procedure Tmainform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not shutdownbypcdimmeroff then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_LOCAL_MACHINE;

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
	        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
		        LReg.CreateKey(ExtractFileName(GetModulePath));
		      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
		      begin
							LReg.WriteBool('Showing Plugin',false);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
	end;
end;

procedure Tmainform.NewPanel;
var
	i,j,k:integer;
begin
		aktuellezeile:=0;
		aktuellespalte:=0;

    zeilen.AsInteger:=1;
    spalten.AsInteger:=4;

    Combobox1.ItemIndex:=0;

		for i:=0 to maxzeile do
	  	for j:=0 to maxspalte do
	    begin
	    	kontrollpanelrecord.buttonname[i][j]:='Button '+inttostr(i+1)+'x'+inttostr(j+1);
	      kontrollpanelrecord.buttonfarbe[i][j]:=clBtnFace;
	      for k:=1 to chan do
	      	kontrollpanelrecord.kanalwerte[i][j][k]:=-1;
	      kontrollpanelrecord.fadezeit[i][j]:=0;
	      kontrollpanelrecord.buttontyp[i][j]:=0;
        kontrollpanelrecord.audiodatei[i][j]:='';
        kontrollpanelrecord.buttonshortcut[i][j]:=0;
	      if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp') then DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(i+1)+'x'+inttostr(j+1)+'.pcdscrp');
	    end;
    mainform.Height:=272;
    mainform.Width:=626;
    zeilenchange(nil);
end;

procedure Tmainform.Einfgen1Click(Sender: TObject);
var
  i:integer;
begin
	kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.buttonname[quellzeile][quellspalte];
  kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.buttonfarbe[quellzeile][quellspalte];
  kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.buttontyp[quellzeile][quellspalte];
  kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.buttonshortcut[quellzeile][quellspalte];
  kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.kanalwerte[quellzeile][quellspalte];
  kontrollpanelrecord.fadezeit[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.fadezeit[quellzeile][quellspalte];
  kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]:=kontrollpanelrecord.audiodatei[quellzeile][quellspalte];
  if FileExists(ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp') then
    CopyFile(PChar((ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp')),PChar((ExtractFilePath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp')),False);
	zeilenChange(Sender);

  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
	buttonname.Text:=mainform.button[aktuellezeile][aktuellespalte].Caption;
  buttonfarbe.Color:=mainform.button[aktuellezeile][aktuellespalte].Color;
	combobox1.ItemIndex:=kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte];
  HotKey1.HotKey:=kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte];
  if cut then
  begin
    cut:=false;
    labeltype[quellzeile][quellspalte].Caption:=' ';
    button[quellzeile][quellspalte].Color:=clBtnFace;
    kontrollpanelrecord.buttonname[quellzeile][quellspalte]:='Button '+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1);
    button[quellzeile][quellspalte].Caption:='Button '+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1);
    kontrollpanelrecord.buttonfarbe[quellzeile][quellspalte]:=clBtnFace;
    kontrollpanelrecord.buttonshortcut[quellzeile][quellspalte]:=0;
    kontrollpanelrecord.audiodatei[quellzeile][quellspalte]:='';
    labelshortcut[quellzeile][quellspalte].Caption:=ShortCutToText(kontrollpanelrecord.buttonshortcut[quellzeile][quellspalte]);
    if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp') then DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(quellzeile+1)+'x'+inttostr(quellspalte+1)+'.pcdscrp');
    for i:=1 to chan do
    	kontrollpanelrecord.kanalwerte[quellzeile][quellspalte][i]:=-1;
  end;
end;

procedure Tmainform.Kopieren1Click(Sender: TObject);
begin
 	quellzeile:=aktuellezeile;
  quellspalte:=aktuellespalte;
  Einfgen1.Enabled:=true;
  if Sender=Ausschneiden1 then
    cut:=true;
end;

procedure Tmainform.Lschen1Click(Sender: TObject);
var
  i:integer;
begin
  if messagedlg(_('Durch setzen des Buttontyps auf "<Leer>" werden gespeicherte Szenen und eventuell vorhandene Skriptdateien gelöscht. Fortfahren?'),mtConfirmation,
    [mbYes,mbNo],0)=mrNo then exit;
 	labeltype[aktuellezeile][aktuellespalte].Caption:=' ';
  button[aktuellezeile][aktuellespalte].Color:=clBtnFace;
  kontrollpanelrecord.buttonname[aktuellezeile][aktuellespalte]:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
  button[aktuellezeile][aktuellespalte].Caption:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
  kontrollpanelrecord.buttonfarbe[aktuellezeile][aktuellespalte]:=clBtnFace;
  kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]:=0;
  kontrollpanelrecord.audiodatei[aktuellezeile][aktuellespalte]:='';
  labelshortcut[aktuellezeile][aktuellespalte].Caption:=ShortCutToText(kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte]);
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp') then
    DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Kontrollpanel\Button'+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1)+'.pcdscrp');
  for i:=1 to chan do
   	kontrollpanelrecord.kanalwerte[aktuellezeile][aktuellespalte][i]:=-1;
	kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte]:=0;
	CheckFileExistsTimer(nil);

  StatusBar1.Panels.Items[0].Text:='Button '+inttostr(aktuellezeile+1)+'x'+inttostr(aktuellespalte+1);
	buttonname.Text:=mainform.button[aktuellezeile][aktuellespalte].Caption;
  buttonfarbe.Color:=mainform.button[aktuellezeile][aktuellespalte].Color;
	combobox1.ItemIndex:=kontrollpanelrecord.buttontyp[aktuellezeile][aktuellespalte];
  HotKey1.HotKey:=kontrollpanelrecord.buttonshortcut[aktuellezeile][aktuellespalte];
end;

procedure Tmainform.ooltipsanzeigen1Click(Sender: TObject);
var
  i,j:integer;
begin
  ooltipsanzeigen1.Checked:=not ooltipsanzeigen1.Checked;
	for i:=0 to zeilen.AsInteger-1 do
  begin
  	for j:=0 to spalten.AsInteger-1 do
    begin
      button[i][j].ShowHint:=ooltipsanzeigen1.Checked;
      labelshortcut[i][j].ShowHint:=ooltipsanzeigen1.Checked;
      labeltype[i][j].ShowHint:=ooltipsanzeigen1.Checked;
    end;
  end;
end;

procedure Tmainform.Bearbeiten1Click(Sender: TObject);
begin
  szenebearbeitenClick(nil);
end;

end.
