unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, Menus, Buttons, Registry,
  messagesystem, VistaAltFixUnit, CHLabel, midievent, editmidievent,
  CHHighResTimer, JvExStdCtrls, JvExExtCtrls, JvComponent,
  JvOfficeColorPanel, JvExControls, JvGammaPanel;

const
  chan=512;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

type
  TDevice = record
    DeviceTyp:Byte;
    startaddress: Word;
    name:string[255];
    hasdimmer:boolean;
    gobo:byte;
    color:byte;
    shutter:byte;
    shuttervalue:byte;
    rotation:byte;
    rotationvalue:byte;
    invertpan:boolean;
    inverttilt:boolean;
    zusatzfunktion1:byte;
    zusatzfunktion2:byte;
    zusatzfunktion3:byte;
    zusatzfunktion4:byte;
  end;

  Tmainform = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    VistaAltFix1: TVistaAltFix;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CloseBtn: TButton;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DevList: TListBox;
    Shape1: TShape;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    panmirror: TCheckBox;
    tiltmirror: TCheckBox;
    GroupBox3: TGroupBox;
    DevNameEdit: TEdit;
    PopupMenu1: TPopupMenu;
    Gerthinzufgen1: TMenuItem;
    Gertlschen1: TMenuItem;
    DevSettings: TNotebook;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GoboList: TComboBox;
    ColorList: TComboBox;
    ShutterList: TComboBox;
    ShutterScrollbar: TScrollBar;
    RotationList: TComboBox;
    RotationScrollbar: TScrollBar;
    Label7: TLabel;
    DevStartaddressEdit: TEdit;
    DevTypCombobox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Timer1: TTimer;
    Button3: TButton;
    Button4: TButton;
    Colorbox: TJvGammaPanel;
    Colorbox2: TJvOfficeColorPanel;
    LightmaxxScrollBar: TScrollBar;
    LightmaxxCombobox: TComboBox;
    Label11: TLabel;
    LightmaxxUseBlendTime: TCheckBox;
    LightmaxxTimeh: TEdit;
    LightmaxxTimemin: TEdit;
    LightmaxxTimes: TEdit;
    LightmaxxTimems: TEdit;
    TS255Kanalbeschriftung: TButton;
    TS255SendAllData: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
		procedure ExecuteMIDIEvents(i:Byte; Data:Byte);
    procedure Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SendPosition;
    procedure panmirrorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GoboListChange(Sender: TObject);
    procedure ColorListChange(Sender: TObject);
    procedure ShutterListChange(Sender: TObject);
    procedure RotationListChange(Sender: TObject);
    procedure RotationScrollbarChange(Sender: TObject);
    procedure ShutterScrollbarChange(Sender: TObject);
    procedure DevStartaddressEditChange(Sender: TObject);
    procedure TS255KanalbeschriftungClick(Sender: TObject);
    procedure DevListChange;
    procedure DevNameEditChange(Sender: TObject);
    procedure Gerthinzufgen1Click(Sender: TObject);
    procedure Gertlschen1Click(Sender: TObject);
    procedure DevListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tiltmirrorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DevTypComboboxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TS255SendAllDataClick(Sender: TObject);
    procedure LightmaxxComboboxChange(Sender: TObject);
    procedure LightmaxxScrollBarChange(Sender: TObject);
    procedure ColorboxChangeColor(Sender: TObject; Foreground,
      Background: TColor);
    procedure Colorbox2ColorChange(Sender: TObject);
    procedure DevListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure input_number(var pos:integer; var s:string);
    procedure LightmaxxTimehChange(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
		MidiEventArray : array of array[1..7] of Byte;
		MSGFROMMAINPROGRAM:boolean;
    channelvalue:array[1..chan] of integer;
    channelnames:array[1..chan] of string;
    channelvalue_temp:array[1..chan] of integer;
    flashmastervalue:byte;

    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    SendMSG:TCallbackSendMessage;

    shutdown:boolean;
		shutdownbypcdimmeroff:boolean;
		lastchan:Word;
    slidervalue_temp:array[1..15] of byte;
    refreshGUI:boolean;

    FileStream:TFileStream;
    Device:array of TDevice;

    active:array[1..15] of array[1..chan] of boolean;
    names:array[1..15] of string[255];
    scrollbarvalue:array[1..15] of byte;
    procedure NewFile;
    procedure OpenFile(FileName: string);
    procedure SaveFile(FileName: string);
    procedure MidiInput(MidiMessage,Data1,Data2:byte);
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

procedure TMainform.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin
          delete(s,i,1);
          dec(pos);
        end
      else
        inc(i);
    end;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

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

procedure Tmainform.FormCreate(Sender: TObject);
begin
  if not DirectoryExists(ExtractFilePath(paramstr(0))+'Projekt\Gerätesteuerung') then
    CreateDir(ExtractFilePath(paramstr(0))+'Projekt\Gerätesteuerung');
  ShutterScrollbar.Enabled:=false;
  RotationScrollbar.Enabled:=false;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LReg:TRegistry;
begin
  shutdown:=true;

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
          LReg.WriteInteger('PosX',mainform.Left);
          LReg.WriteInteger('PosY',mainform.Top);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure Tmainform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  SaveFile(ExtractFilePath(paramstr(0))+'Projekt\Gerätesteuerung\Gerätesteuerung');

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

procedure Tmainform.FormShow(Sender: TObject);
var
  CSV:TStrings;
  temp:string;
  i:integer;
  LReg:TRegistry;
begin
  OpenFile(ExtractFilePath(paramstr(0))+'Projekt\Gerätesteuerung\Gerätesteuerung');

  // MIDI-Ereignisse aus CSV-Datei lesen
  i:=0;
  try
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi') then
  begin
	  CSV := TStringlist.Create;
	  CSV.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi');
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
  	ShowMessage('Beim Laden der Datei "'+ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi'+'" ist ein Fehler in Zeile '+inttostr(i+1)+' aufgetreten. Die MIDI-Einstellungen können unter Umständen nicht korrekt geladen werden.');
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

  if DevList.Items.count>0 then
  begin
    DevList.Selected[0]:=true;
    DevListChange;
  end;
end;

procedure Tmainform.SpeedButton3Click(Sender: TObject);
begin
  NewFile;
end;

procedure Tmainform.CloseBtnClick(Sender: TObject);
begin
  close;
end;

procedure Tmainform.SpeedButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveFile(SaveDialog1.FileName);
  end;
end;

procedure Tmainform.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    OpenFile(OpenDialog1.FileName);
  end;
end;

procedure Tmainform.NewFile;
begin
  DevNameEdit.Text:='';
  DevStartaddressEdit.Text:='1';
  DevTypCombobox.ItemIndex:=0;
  DevList.Clear;
  DevSettings.PageIndex:=0;

  setlength(Device,0);
  DevListChange;
end;

procedure Tmainform.OpenFile(FileName: string);
var
  i,DevCount:integer;
begin
  if FileExists(FileName) then
  begin
    DevList.Clear;
    FileStream:=TFileStream.Create(FileName,fmOpenRead);
    Filestream.ReadBuffer(DevCount,sizeof(DevCount));
    setlength(Device,DevCount);
    for i:=0 to DevCount-1 do
    begin
   	  Filestream.ReadBuffer(Device[i],sizeof(Device[i]));
      DevList.Items.Add(Device[i].name);
    end;
	  FileStream.Free;
  end;
  DevListChange;
end;

procedure Tmainform.SaveFile(FileName: string);
var
  i,DevCount:integer;
begin
    if not DirectoryExists(ExtractFilepath(Filename)) then
      CreateDir(ExtractFilepath(Filename));
    FileStream:=TFileStream.Create(FileName,fmCreate);
    DevCount:=length(Device);
	  Filestream.WriteBuffer(DevCount,sizeof(DevCount));
    for i:=0 to DevCount-1 do
    begin
   	  Filestream.WriteBuffer(Device[i],sizeof(Device[i]));
    end;
	  FileStream.Free;
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

procedure Tmainform.BitBtn1Click(Sender: TObject);
var
	i:integer;
  CSV : TStrings;
begin
  editmidieventfrm.ComboBox1.Clear;
  for i:=0 to DevList.Items.Count-1 do
    editmidieventfrm.ComboBox1.Items.Add(Device[i].name);

  midieventfrm.ShowModal;

  // MIDI-Ereignisse in CSV-Datei schreiben
  if length(MidiEventArray)>0 then
  begin
	  CSV := TStringlist.Create;
	  For i :=0 To length(MidiEventArray)-1 do
	  	CSV.Add(inttostr(MidiEventArray[i][1])+','+inttostr(MidiEventArray[i][2])+','+inttostr(MidiEventArray[i][3])+','+inttostr(MidiEventArray[i][4])+','+inttostr(MidiEventArray[i][5])+','+inttostr(MidiEventArray[i][6])+','+inttostr(MidiEventArray[i][7]));
	  CSV.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi');
	  CSV.Free;
  end else
  begin
  	if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi') then
    	DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Gerätesteuerung\MIDISettings.pcdmidi');
  end;
end;

procedure Tmainform.ExecuteMIDIEvents(i:Byte; Data:Byte);
begin
	if not shutdown then
	case MidiEventArray[i][4] of
		0: // Pan für eingestelltes Gerät setzen
		begin
      if Device[MidiEventArray[i][5]].invertpan then
        RefreshDllValues(Device[MidiEventArray[i][5]].startaddress,255-(Data*2),255-(Data*2),0)
      else
        RefreshDllValues(Device[MidiEventArray[i][5]].startaddress,(Data*2),(Data*2),0);
		end;
		1: // Tilt für eingestelltes Gerät setzen
		begin
      if Device[MidiEventArray[i][5]].inverttilt then
        RefreshDllValues(Device[MidiEventArray[i][5]].startaddress+1,255-(Data*2),255-(Data*2),0)
      else
        RefreshDllValues(Device[MidiEventArray[i][5]].startaddress+1,(Data*2),(Data*2),0);
		end;
	end;
end;

procedure Tmainform.Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((Shape1.Left+x-(Shape1.Width div 2))>=0-(Shape1.Width div 2)) and ((Shape1.Left+x-(Shape1.Width div 2))<=Panel1.Width-(Shape1.Width div 2)) then Shape1.Left:=Shape1.Left+x-(Shape1.Width div 2);
    if ((Shape1.Top+y-(Shape1.Height div 2))>=0-(Shape1.Height div 2)) and ((Shape1.Top+y-(Shape1.Height div 2))<=Panel1.Height-(Shape1.Height div 2)) then Shape1.Top:=Shape1.Top+y-(Shape1.Height div 2);
    Shape1.Refresh;

    SendPosition;
  end;
end;

procedure Tmainform.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    Shape1.Top:=Y-Shape1.Height div 2;
    Shape1.Left:=X-Shape1.Width div 2;
  end else
  begin
    Shape1.Top:=103;
    Shape1.Left:=103;
  end;

  SendPosition;
end;

procedure Tmainform.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
  begin
    Shape1.Top:=103;
    Shape1.Left:=103;
  end;

  SendPosition;
end;

procedure Tmainform.SendPosition;
var
  pan,tilt,posx,posy,i:integer;
begin
  posx:=round(((Shape1.Left+(Shape1.Width div 2))/Panel1.Width)*255);
  posy:=round(((Shape1.Top+(Shape1.Height div 2))/Panel1.Height)*255);

  for i:=0 to DevList.Items.Count-1 do
  begin
    if DevList.Selected[i] then
    begin
      pan:=posx;
      tilt:=posy;
      
      if Device[i].invertpan then
        pan:=255-pan;
      if Device[i].inverttilt then
        tilt:=255-tilt;

      case Device[i].DeviceTyp of
        1: // Eurolite TS-255
        begin
          RefreshDllValues(Device[i].Startaddress,pan,pan,0);
          RefreshDllValues(Device[i].Startaddress+1,tilt,tilt,0);
        end;
      end;
    end;
  end;
end;

procedure Tmainform.panmirrorMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Device[DevList.ItemIndex].invertpan:=panmirror.Checked;
  SendPosition;
end;

procedure Tmainform.GoboListChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
  if DevList.Selected[i] and (Device[i].DeviceTyp=1) then
  begin
    if Sender=Gobolist then
      Device[i].gobo:=Gobolist.ItemIndex;
    case GoboList.ItemIndex of
      0: RefreshDllValues(Device[i].Startaddress+3,0,0,0);
      1: RefreshDllValues(Device[i].Startaddress+3,40,40,0);
      2: RefreshDllValues(Device[i].Startaddress+3,80,80,0);
      3: RefreshDllValues(Device[i].Startaddress+3,120,120,0);
      4: RefreshDllValues(Device[i].Startaddress+3,150,150,0);
      5: RefreshDllValues(Device[i].Startaddress+3,170,170,0);
      6: RefreshDllValues(Device[i].Startaddress+3,220,220,0);
      7: RefreshDllValues(Device[i].Startaddress+3,250,250,0);
    end;
  end;
end;

procedure Tmainform.ColorListChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
  if DevList.Selected[i] and (Device[i].DeviceTyp=1) then
  begin
    if Sender=Colorlist then
      Device[i].color:=ColorList.ItemIndex;
    case ColorList.ItemIndex of
      0: RefreshDllValues(Device[i].Startaddress+2,0,0,0);
      1: RefreshDllValues(Device[i].Startaddress+2,50,50,0);
      2: RefreshDllValues(Device[i].Startaddress+2,80,80,0);
      3: RefreshDllValues(Device[i].Startaddress+2,110,110,0);
      4: RefreshDllValues(Device[i].Startaddress+2,140,140,0);
      5: RefreshDllValues(Device[i].Startaddress+2,170,170,0);
      6: RefreshDllValues(Device[i].Startaddress+2,210,210,0);
      7: RefreshDllValues(Device[i].Startaddress+2,250,250,0);
    end;
  end;
end;

procedure Tmainform.ShutterListChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
  if DevList.Selected[i] and (Device[i].DeviceTyp=1) then
  begin
    if Sender=Shutterlist then
      Device[i].shutter:=ShutterList.ItemIndex;
    case ShutterList.ItemIndex of
      0:
      begin
        ShutterScrollbar.Enabled:=false;
        RefreshDllValues(Device[i].Startaddress+4,0,0,0);
      end;
      1:
      begin
        ShutterScrollbar.Enabled:=false;
        RefreshDllValues(Device[i].Startaddress+4,255,255,0);
      end;
      2:
      begin
        ShutterScrollbar.Enabled:=true;
        RefreshDllValues(Device[i].Startaddress+4,ShutterScrollbar.Position,ShutterScrollbar.Position,0);
      end;
    end;
  end;
end;

procedure Tmainform.RotationListChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
  if DevList.Selected[i] and (Device[i].DeviceTyp=1) then
  begin
    if Sender=Rotationlist then
      Device[i].rotation:=Rotationlist.ItemIndex;
    case RotationList.ItemIndex of
      0:
      begin
        RotationScrollbar.Enabled:=false;
        RefreshDllValues(Device[i].Startaddress+5,0,0,0);
      end;
      1:
      begin
        RotationScrollbar.Enabled:=true;
        RotationScrollbar.Min:=5;
        RotationScrollbar.Max:=120;
//        RotationScrollbar.Position:=120;
        RefreshDllValues(Device[i].Startaddress+5,RotationScrollbar.Position,RotationScrollbar.Position,0);
      end;
      2:
      begin
        RotationScrollbar.Enabled:=true;
        RotationScrollbar.Max:=255;
        RotationScrollbar.Min:=140;
//        RotationScrollbar.Position:=255;
        RefreshDllValues(Device[i].Startaddress+5,RotationScrollbar.Position,RotationScrollbar.Position,0);
      end;
    end;
  end;
end;

procedure Tmainform.RotationScrollbarChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
    if DevList.Selected[i] and (Device[i].DeviceTyp=1) and (not RotationList.ItemIndex=1) then
    begin
      if Sender=RotationScrollbar then
        Device[i].rotationvalue:=RotationScrollbar.Position;
      RefreshDllValues(Device[i].Startaddress+5,RotationScrollbar.Position,RotationScrollbar.Position,0);
    end;
end;

procedure Tmainform.ShutterScrollbarChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
    if DevList.Selected[i] and (Device[i].DeviceTyp=1) and (ShutterList.ItemIndex=2) then
    begin
      if Sender=ShutterScrollbar then
        Device[i].shuttervalue:=ShutterScrollbar.Position;
      RefreshDllValues(Device[i].Startaddress+4,ShutterScrollbar.Position,ShutterScrollbar.Position,0);
    end;
end;

procedure Tmainform.DevStartaddressEditChange(Sender: TObject);
begin
//  inttostr(Device[DevList.ItemIndex].startaddress)
  Device[DevList.ItemIndex].Startaddress:=strtoint(DevStartaddressEdit.Text);
end;

procedure Tmainform.TS255KanalbeschriftungClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
  begin
    if DevList.Selected[i] then
    begin
      case Device[i].DeviceTyp of
        1: // Eurolite TS-255
        begin
          RefreshDllNames(Device[i].Startaddress,PChar(' '+Device[i].Name+': Pan'));
          RefreshDllNames(Device[i].Startaddress+1,PChar(' '+Device[i].Name+': Tilt'));
          RefreshDllNames(Device[i].Startaddress+2,PChar(' '+Device[i].Name+': Farbe'));
          RefreshDllNames(Device[i].Startaddress+3,PChar(' '+Device[i].Name+': Gobo'));
          RefreshDllNames(Device[i].Startaddress+4,PChar(' '+Device[i].Name+': Dimmer'));
          RefreshDllNames(Device[i].Startaddress+5,PChar(' '+Device[i].Name+': Gobo-Rotation'));
        end;
        2: // LightmaXX LED-Par
        begin
          RefreshDllNames(Device[i].Startaddress,PChar(' '+Device[i].Name+': Rot'));
          RefreshDllNames(Device[i].Startaddress+1,PChar(' '+Device[i].Name+': Grün'));
          RefreshDllNames(Device[i].Startaddress+2,PChar(' '+Device[i].Name+': Blau'));
          RefreshDllNames(Device[i].Startaddress+3,PChar(' '+Device[i].Name+': Dimmer'));
        end;
      end;
    end;
  end;
end;

procedure Tmainform.DevNameEditChange(Sender: TObject);
begin
  Device[DevList.ItemIndex].name:=DevNameEdit.Text;
  DevList.Items.Strings[DevList.ItemIndex]:=DevNameEdit.Text;
end;

procedure Tmainform.Gerthinzufgen1Click(Sender: TObject);
var
  i:integer;
begin
  setlength(Device,length(Device)+1);
  for i:=0 to DevList.Items.Count-1 do
    DevList.Selected[i]:=false;
  DevList.Items.Add('Neues Gerät');
  DevList.ItemIndex:=DevList.Items.Count-1;
  DevList.Selected[DevList.ItemIndex]:=true;
  DevTypCombobox.ItemIndex:=0;
  Device[DevList.Items.Count-1].DeviceTyp:=0;
  Device[DevList.Items.Count-1].startaddress:=1;
  Device[DevList.Items.Count-1].name:='Neues Gerät';
  DevListChange;
end;

procedure Tmainform.Gertlschen1Click(Sender: TObject);
var
  i:integer;
begin
  // Alle Elemente um eins nach vorne rutschen
  for i:=DevList.ItemIndex to DevList.Items.Count-2 do
  begin
    Device[i]:=Device[i+1];
    DevList.Items.Strings[i]:=DevList.Items.Strings[i+1]
  end;

  // Letzte Position löschen
  setlength(Device,length(Device)-1);
  DevList.Items.Delete(DevList.Items.Count-1);
  DevListChange;

  if DevList.Items.count=0 then
  begin
    GroupBox1.Enabled:=false;
    Shape1.Visible:=false;
    DevSettings.PageIndex:=0;
  end;
end;

procedure Tmainform.DevListChange;
var
  i,position:integer;
  first,thesame:boolean;
  mastertype:byte;
begin
  // Wenn mindestens ein Objekt, dann Groupboxes aktivieren
  if DevList.SelCount>0 then
  begin
    Groupbox1.Enabled:=true;
    Groupbox3.Enabled:=true;
    DevTypCombobox.Enabled:=true;
  end else
  begin
    Groupbox1.Enabled:=false;
    Groupbox3.Enabled:=false;
    DevTypCombobox.Enabled:=false;
  end;

  // Wenn nur ein Objekt, dann Einzelgeräteinstellungen freischalten
  if DevList.SelCount=1 then
  begin
    DevStartaddressEdit.Enabled:=true;
    DevNameEdit.Enabled:=true;
    Gertlschen1.Enabled:=true;
    Button4.Enabled:=true;
    panmirror.Enabled:=true;
    tiltmirror.Enabled:=true;

    position:=DevList.ItemIndex;
    DevStartaddressEdit.Text:=inttostr(Device[DevList.ItemIndex].startaddress);
    DevNameEdit.Text:=Device[DevList.ItemIndex].name;
    panmirror.Checked:=Device[DevList.ItemIndex].invertpan;
    tiltmirror.Checked:=Device[DevList.ItemIndex].inverttilt;
    DevTypCombobox.ItemIndex:=Device[DevList.ItemIndex].DeviceTyp;
    DevSettings.PageIndex:=DevTypCombobox.ItemIndex;

    if Device[DevList.ItemIndex].invertpan then
      Shape1.Left:=round((((255-channelvalue[Device[DevList.ItemIndex].startaddress])/255)*Panel1.Width)-(Shape1.Width/2))
    else
      Shape1.Left:=round((((channelvalue[Device[DevList.ItemIndex].startaddress])/255)*Panel1.Width)-(Shape1.Width/2));

    if Device[DevList.ItemIndex].inverttilt then
      Shape1.Top:=round((((255-channelvalue[Device[DevList.ItemIndex].startaddress+1])/255)*Panel1.Height)-(Shape1.Height/2))
    else
      Shape1.Top:=round((((channelvalue[Device[DevList.ItemIndex].startaddress+1])/255)*Panel1.Height)-(Shape1.Height/2));


    DevList.SetFocus;
    DevList.ItemIndex:=position;
    DevList.Selected[position]:=true;

    case Device[DevList.ItemIndex].DeviceTyp of
      1:
      begin
        GoboList.ItemIndex:=Device[DevList.ItemIndex].gobo;
        ColorList.ItemIndex:=Device[DevList.ItemIndex].color;
        ShutterList.ItemIndex:=Device[DevList.ItemIndex].shutter;
        if ShutterList.ItemIndex=2 then
          ShutterScrollbar.Enabled:=true
        else
          ShutterScrollbar.Enabled:=false;
        ShutterScrollbar.Position:=Device[DevList.ItemIndex].shuttervalue;
        RotationList.ItemIndex:=Device[DevList.ItemIndex].rotation;
        if RotationList.ItemIndex=0 then
          RotationScrollbar.Enabled:=false
        else
          RotationScrollbar.Enabled:=true;
        RotationScrollbar.Position:=Device[DevList.ItemIndex].rotationvalue;
      end;
    end;
  end;

  // Wenn mehr als ein Gerät oder kein Gerät
  if (DevList.SelCount>1) or (DevList.SelCount=0) then
  begin
    DevStartaddressEdit.Enabled:=false;
    DevNameEdit.Enabled:=false;
    Gertlschen1.Enabled:=false;
    Button4.Enabled:=false;
    panmirror.Enabled:=false;
    tiltmirror.Enabled:=false;
  end;

  if (DevList.SelCount>1) then
  begin
    thesame:=true;
    first:=true;
    mastertype:=0;
    for i:=0 to DevList.items.Count-1 do
    begin
      if DevList.Selected[i] then
      begin
        if first then
        begin
          first:=false;
          mastertype:=Device[i].DeviceTyp;
        end;
        if Device[i].DeviceTyp<>mastertype then
          thesame:=false;
      end;
    end;

    if thesame then
    begin
      // alle selektierten Objekte sind identischen Typs
      Groupbox3.Enabled:=true;
      DevSettings.PageIndex:=mastertype;
    end else
    begin
      // unterschiedliche Typen
      DevSettings.PageIndex:=0;
      Groupbox3.Enabled:=false;
    end;
  end;

//  DevSettings.PageIndex:=DevTypCombobox.ItemIndex;
  case DevTypCombobox.ItemIndex of
    0:
    begin
      GroupBox1.Enabled:=false;
      Shape1.Visible:=false;
    end;
    1:
    begin
      GroupBox1.Enabled:=true;
      Shape1.Visible:=true;
    end;
    2:
    begin
      GroupBox1.Enabled:=false;
      Shape1.Visible:=false;
    end;
  end;
end;

procedure Tmainform.DevListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DevListChange;
end;

procedure Tmainform.tiltmirrorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Device[DevList.ItemIndex].inverttilt:=tiltmirror.Checked;
  SendPosition;
end;

procedure Tmainform.DevTypComboboxChange(Sender: TObject);
begin
  Device[DevList.ItemIndex].DeviceTyp:=DevTypCombobox.ItemIndex;
  DevListChange;
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
begin
  if refreshGUI and (DevList.SelCount=1) then
  begin
    refreshGUI:=false;

    if Device[DevList.ItemIndex].invertpan then
      Shape1.Left:=round((((255-channelvalue[Device[DevList.ItemIndex].startaddress])/255)*Panel1.Width)-(Shape1.Width/2))
    else
      Shape1.Left:=round((((channelvalue[Device[DevList.ItemIndex].startaddress])/255)*Panel1.Width)-(Shape1.Width/2));

    if Device[DevList.ItemIndex].inverttilt then
      Shape1.Top:=round((((255-channelvalue[Device[DevList.ItemIndex].startaddress+1])/255)*Panel1.Height)-(Shape1.Height/2))
    else
      Shape1.Top:=round((((channelvalue[Device[DevList.ItemIndex].startaddress+1])/255)*Panel1.Height)-(Shape1.Height/2));
  end;
end;

procedure Tmainform.TS255SendAllDataClick(Sender: TObject);
begin
  GoboListChange(nil);
  ColorListChange(nil);
  ShutterListChange(nil);
  RotationlistChange(nil);

  ColorboxChangeColor(nil, Colorbox.ForegroundColor, Colorbox.BackgroundColor);
  LightmaxxComboboxChange(nil);
end;

procedure Tmainform.LightmaxxComboboxChange(Sender: TObject);
var
  i:integer;
begin
  case LightmaxxCombobox.ItemIndex of
    0: // Dimmen
    begin
      LightmaxxScrollBar.Enabled:=true;
      LightmaxxScrollBarChange(nil);
    end;
    1: // Stroboskopeffekt
    begin
      LightmaxxScrollBar.Enabled:=false;
      for i:=0 to DevList.Items.Count-1 do
        if DevList.Selected[i] and (Device[i].DeviceTyp=2) then
        begin
          RefreshDllValues(Device[i].Startaddress+3,255,255,0);
        end;
    end;
  end;
end;

procedure Tmainform.LightmaxxScrollBarChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to DevList.Items.Count-1 do
    if DevList.Selected[i] and (Device[i].DeviceTyp=2) then
    begin
      RefreshDllValues(Device[i].Startaddress+3,LightmaxxScrollBar.Position,LightmaxxScrollBar.Position,0);
    end;
end;

procedure Tmainform.ColorboxChangeColor(Sender: TObject; Foreground,
  Background: TColor);
var
  R,G,B:byte;
  i:integer;
  blendtime:integer;
	szenenarray:Variant;
begin
  TColor2RGB(ColorBox.ForegroundColor,R,G,B);
  ColorBox2.Color:=ColorBox.ForegroundColor;

  blendtime:=0;
  if LightmaxxUseBlendTime.Checked then
  begin
    blendtime:=strtoint(LightmaxxTimems.text);
    blendtime:=blendtime+strtoint(LightmaxxTimes.text)*1000;
    blendtime:=blendtime+strtoint(LightmaxxTimemin.text)*60*1000;
    blendtime:=blendtime+strtoint(LightmaxxTimeh.text)*60*60*1000;
  end;

  szenenarray:=VarArrayCreate([1,lastchan], varInteger);

  for i:=1 to lastchan do
    szenenarray[i]:=-1;

  for i:=0 to DevList.Items.Count-1 do
  begin
    if DevList.Selected[i] then
    begin
      szenenarray[Device[i].Startaddress]:=R;
      szenenarray[Device[i].Startaddress+1]:=G;
      szenenarray[Device[i].Startaddress+2]:=B;
      RefreshDllValues(Device[i].Startaddress,channelvalue[Device[i].Startaddress],R,blendtime);
      RefreshDllValues(Device[i].Startaddress+1,channelvalue[Device[i].Startaddress+1],G,blendtime);
      RefreshDllValues(Device[i].Startaddress+2,channelvalue[Device[i].Startaddress+2],B,blendtime);
    end;
  end;
  SendMSG(MSG_RECORDSCENE,szenenarray,blendtime);
end;

procedure Tmainform.Colorbox2ColorChange(Sender: TObject);
begin
  if Sender=Colorbox2 then
    ColorBox.ForegroundColor:=ColorBox2.Color;
end;

procedure Tmainform.DevListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DevListChange;
end;

procedure Tmainform.LightmaxxTimehChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Tmainform.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((x-(Shape1.Width div 2))>=0-(Shape1.Width div 2)) and ((x-(Shape1.Width div 2))<=Panel1.Width-(Shape1.Width div 2)) then Shape1.Left:=x-(Shape1.Width div 2);
    if ((y-(Shape1.Height div 2))>=0-(Shape1.Height div 2)) and ((y-(Shape1.Height div 2))<=Panel1.Height-(Shape1.Height div 2)) then Shape1.Top:=y-(Shape1.Height div 2);
    Shape1.Refresh;

    SendPosition;
  end;
end;

end.
