unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, MPlayer, Menus,
  Buttons, ImgList, Registry, messagesystem, VistaAltFixUnit, kanalwahl,
  CHLabel, midievent, editmidievent;

const
  chan=512;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

type
  TSubmasterpanel = record
    active:array[1..15] of array[1..chan] of boolean;
    names:array[1..15] of string[30];
  end;

  Tmainform = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    VistaAltFix1: TVistaAltFix;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GroupBox1: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    ScrollBar9: TScrollBar;
    ScrollBar10: TScrollBar;
    ScrollBar11: TScrollBar;
    ScrollBar12: TScrollBar;
    ScrollBar13: TScrollBar;
    ScrollBar14: TScrollBar;
    ScrollBar15: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    ProgressBar5: TProgressBar;
    ProgressBar6: TProgressBar;
    ProgressBar7: TProgressBar;
    ProgressBar8: TProgressBar;
    ProgressBar9: TProgressBar;
    ProgressBar10: TProgressBar;
    ProgressBar11: TProgressBar;
    ProgressBar12: TProgressBar;
    ProgressBar13: TProgressBar;
    ProgressBar14: TProgressBar;
    ProgressBar15: TProgressBar;
    CHLabel1: TCHLabel;
    CHLabel2: TCHLabel;
    CHLabel3: TCHLabel;
    CHLabel4: TCHLabel;
    CHLabel5: TCHLabel;
    CHLabel6: TCHLabel;
    CHLabel7: TCHLabel;
    CHLabel8: TCHLabel;
    CHLabel9: TCHLabel;
    CHLabel10: TCHLabel;
    CHLabel11: TCHLabel;
    CHLabel12: TCHLabel;
    CHLabel13: TCHLabel;
    CHLabel14: TCHLabel;
    CHLabel15: TCHLabel;
    CloseBtn: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    FlashMasterScrollbar: TScrollBar;
    FlashMasterProgressBar: TProgressBar;
    FlashMasterLabel: TLabel;
    Setup1: TButton;
    Setup2: TButton;
    Setup3: TButton;
    Setup4: TButton;
    Setup5: TButton;
    Setup6: TButton;
    Setup7: TButton;
    Setup8: TButton;
    Setup9: TButton;
    Setup10: TButton;
    Setup11: TButton;
    Setup12: TButton;
    Setup13: TButton;
    Setup14: TButton;
    Setup15: TButton;
    procedure Label1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CHLabel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CloseBtnClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
		procedure ExecuteMIDIEvents(i:Byte; Data:Byte);
    procedure FlashMasterScrollbarChange(Sender: TObject);
    procedure FlashMasterScrollbarScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure Setup1Click(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
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
    Submasterpanel:TSubmasterpanel;
    scrollbarvalue:array[1..15] of byte;

    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    SendMSG:TCallbackSendMessage;

    shutdown:boolean;
		shutdownbypcdimmeroff:boolean;
		lastchan:Word;
    slidervalue_temp:array[1..15] of byte;

    FileStream:TFileStream;

    procedure NewFile;
    procedure OpenFile(FileName: string);
    procedure SaveFile(FileName: string);
    procedure MidiInput(MidiMessage,Data1,Data2:byte);
  end;

var
  mainform: Tmainform;

implementation

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

procedure Tmainform.Label1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,k:integer;
begin
  kanalwahlform.StringGrid1.RowCount:=lastchan+1;

  for i:=1 to 15 do
  begin
    if Sender=FindComponent(_('Label')+inttostr(i)) then
    begin
      for k:=1 to lastchan do
      begin
        kanalwahlform.active[k]:=submasterpanel.active[i][k];
        kanalwahlform.StringGrid1.Cells[1,k]:=inttostr(k);
        kanalwahlform.StringGrid1.Cells[2,k]:=channelnames[k];
      end;

      kanalwahlform.ShowModal;

      for k:=1 to lastchan do
        submasterpanel.active[i][k]:=kanalwahlform.active[k];
    end;
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  i:integer;
begin
  if not DirectoryExists(ExtractFilePath(paramstr(0))+'Projekt\Submaster') then
    CreateDir(ExtractFilePath(paramstr(0))+'Projekt\Submaster');

  flashmastervalue:=255;

  for i:=1 to 15 do
    submasterpanel.names[i]:='Submaster '+inttostr(i);
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LReg:TRegistry;
begin
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
  SaveFile(ExtractFilePath(paramstr(0))+'Projekt\Submaster\Submaster');

	if not shutdownbypcdimmeroff then
  begin
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
  OpenFile(ExtractFilePath(paramstr(0))+'Projekt\Submaster\Submaster');

  // MIDI-Ereignisse aus CSV-Datei lesen
  i:=0;
  try
  if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi') then
  begin
	  CSV := TStringlist.Create;
	  CSV.LoadFromFile(ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi');
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
  	ShowMessage(_('Beim Laden der Datei "')+ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi'+_('" ist ein Fehler in Zeile ')+inttostr(i+1)+_(' aufgetreten. Die MIDI-Einstellungen können unter Umständen nicht korrekt geladen werden.'));
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
end;

procedure Tmainform.SpeedButton3Click(Sender: TObject);
begin
  NewFile();
end;

procedure Tmainform.CHLabel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 15 do
    if Sender=FindComponent('CHLabel'+inttostr(i)) then
    begin
      submasterpanel.names[i]:=InputBox(_('Neue Submaster-Beschriftung'),_('Bitte geben Sie eine neue Bezeichnung für diesen Submaster ein:'),submasterpanel.names[i]);
      if submasterpanel.names[i]='' then submasterpanel.names[i]:='                            ';
      TCHLabel(FindComponent('CHLabel'+inttostr(i))).Caption:=submasterpanel.names[i];
    end;
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

procedure Tmainform.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 15 do
    if Sender=FindComponent('Button'+inttostr(i)) then
    begin
      scrollbarvalue[i]:=TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position;
      TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position:=255-flashmastervalue;
      
    end;
end;

procedure Tmainform.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 15 do
    if Sender=FindComponent('Button'+inttostr(i)) then
    begin
      TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position:=scrollbarvalue[i];
      scrollbarvalue[i]:=TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position;
    end;
end;

procedure Tmainform.NewFile;
var
  i,k:integer;
begin
  for i:=1 to 15 do
  begin
    for k:=1 to lastchan do
      submasterpanel.active[i][k]:=false;

    submasterpanel.names[i]:='Submaster '+inttostr(i);
    TCHLabel(FindComponent('CHLabel'+inttostr(i))).Caption:=submasterpanel.names[i];
    TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position:=255;
    TProgressbar(FindComponent('ProgressBar'+inttostr(i))).Position:=0;
  end;
end;

procedure Tmainform.OpenFile(FileName: string);
var
  i:integer;
begin
  if FileExists(FileName) then
  begin
    FileStream:=TFileStream.Create(FileName,fmOpenRead);
    Filestream.ReadBuffer(submasterpanel,sizeof(submasterpanel));
	  FileStream.Free;

    for i:=1 to 15 do
    begin
      TCHLabel(FindComponent('CHLabel'+inttostr(i))).Caption:=submasterpanel.names[i];
      TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position:=255;
      TProgressbar(FindComponent('ProgressBar'+inttostr(i))).Position:=0;
    end;
  end;
end;

procedure Tmainform.SaveFile(FileName: string);
begin
    if not DirectoryExists(ExtractFilepath(Filename)) then
      CreateDir(ExtractFilepath(Filename));

    FileStream:=TFileStream.Create(FileName,fmCreate);
 	  Filestream.WriteBuffer(submasterpanel,sizeof(submasterpanel));
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
  midieventfrm.ShowModal;

  // MIDI-Ereignisse in CSV-Datei schreiben
  if length(MidiEventArray)>0 then
  begin
	  CSV := TStringlist.Create;
	  For i :=0 To length(MidiEventArray)-1 do
	  	CSV.Add(inttostr(MidiEventArray[i][1])+','+inttostr(MidiEventArray[i][2])+','+inttostr(MidiEventArray[i][3])+','+inttostr(MidiEventArray[i][4])+','+inttostr(MidiEventArray[i][5])+','+inttostr(MidiEventArray[i][6])+','+inttostr(MidiEventArray[i][7]));
	  CSV.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi');
	  CSV.Free;
  end else
  begin
  	if FileExists(ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi') then
    	DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\Submaster\MIDISettings.pcdmidi');
  end;
end;

procedure Tmainform.ExecuteMIDIEvents(i:Byte; Data:Byte);
var
  j:integer;
	szenenarray:Variant;
begin
	if not shutdown then
	case MidiEventArray[i][4] of
		0: // Slider bewegen
		begin
      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
      for j:=1 to lastchan do
      	szenenarray[j]:=(submasterpanel.active[MidiEventArray[i][5]][j]);
			if Data > 0 then
      begin
        if MidiEventArray[i][1]=144 then
        	slidervalue_temp[MidiEventArray[i][5]]:=TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position;
        TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=255-(Data*2);
			end else
      begin
        if MidiEventArray[i][1]=144 then
          TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=slidervalue_temp[MidiEventArray[i][5]]
        else
          TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=255;
      end;
      SendMSG(MSG_RECORDSCENE,szenenarray,0);
		end;
		1: // Slider setzen
		begin
      szenenarray:=VarArrayCreate([1,lastchan], varInteger);
      for j:=1 to lastchan do
      	szenenarray[j]:=(submasterpanel.active[MidiEventArray[i][5]][j]);
			if Data > 0 then
      begin
        if MidiEventArray[i][1]=144 then
        	slidervalue_temp[MidiEventArray[i][5]]:=TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position;
        TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=255-MidiEventArray[i][6];
			end else
      begin
        if MidiEventArray[i][1]=144 then
          TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=slidervalue_temp[MidiEventArray[i][5]]
        else
          TScrollbar(FindComponent('Scrollbar'+inttostr(MidiEventArray[i][5]))).Position:=255;
      end;
      SendMSG(MSG_RECORDSCENE,szenenarray,0);
		end;
	end;
end;

procedure Tmainform.FlashMasterScrollbarChange(Sender: TObject);
begin
  flashmastervalue:=255-FlashmasterScrollbar.Position;
  FlashmasterProgressBar.Position:=flashmastervalue;
  FlashmasterProgressBar.Position:=flashmastervalue-1;
  FlashmasterProgressBar.Position:=flashmastervalue;
  FlashmasterLabel.Caption:=inttostr(round((flashmastervalue/255)*100))+'%';
end;

procedure Tmainform.FlashMasterScrollbarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  SendMSG(MSG_FLASHMASTER,flashmastervalue,0);
end;

procedure Tmainform.Setup1Click(Sender: TObject);
var
  i,k:integer;
begin
  kanalwahlform.StringGrid1.RowCount:=lastchan+1;

  for i:=1 to 15 do
  begin
    if Sender=FindComponent('Setup'+inttostr(i)) then
    begin
      for k:=1 to lastchan do
      begin
        kanalwahlform.active[k]:=submasterpanel.active[i][k];
        kanalwahlform.StringGrid1.Cells[1,k]:=inttostr(k);
        kanalwahlform.StringGrid1.Cells[2,k]:=channelnames[k];
      end;

      kanalwahlform.ShowModal;

      for k:=1 to lastchan do
        submasterpanel.active[i][k]:=kanalwahlform.active[k];
    end;
  end;
end;

procedure Tmainform.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  i,k:integer;
begin
  if not shutdown then
  for i:=1 to 15 do
  begin
    if Sender=FindComponent('ScrollBar'+inttostr(i)) then
    begin
      TProgressBar(FindComponent('ProgressBar'+inttostr(i))).Position:=255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position;
      TProgressBar(FindComponent('ProgressBar'+inttostr(i))).Position:=255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position-1;
      TProgressBar(FindComponent('ProgressBar'+inttostr(i))).Position:=255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position;
      TLabel(FindComponent('Label'+inttostr(i))).Caption:=inttostr(round((255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position)*100/255))+'%';
      for k:=1 to lastchan do
      begin
        if submasterpanel.active[i][k] then
        begin
          RefreshDLLValues(k,255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position,255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position,0);
        end;
      end;
    end;
  end;
end;

end.
