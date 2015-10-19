unit konsolensteuerungfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvSwitch, Menus, Grids,
  Registry, ExtCtrls;

type
  Tkonsolensteuerung = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CopyBtn: TJvSwitch;
    MoveBtn: TJvSwitch;
    DeleteBtn: TJvSwitch;
    SaveBtn: TJvSwitch;
    Button1: TButton;
    Button2: TButton;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupsBtn: TJvSwitch;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ListBox1: TListBox;
    StringGrid3: TStringGrid;
    GroupBox6: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    PresetsBtn: TJvSwitch;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChangedChannelsTimer: TTimer;
    Button5: TButton;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure SaveBtnOn(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure ChangedChannelsTimerTimer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
    { Public-Deklarationen }
  end;

var
  konsolensteuerung: Tkonsolensteuerung;

implementation

uses PCDIMMER, Tastenabfragefrm, midievent, geraetelistefrm;

{$R *.dfm}

function levelstr(pos,max:integer):string;
begin
  result:='';
  case MainForm.levelanzeigeoptionen of
    0: result:=inttostr(round((pos*100) / max))+'%';
    1: result:=inttostr(round((pos*100) / max))+'.'+copy(inttostr((pos*100) mod max),0,1)+'%';
    2: result:=inttostr(pos);
  end;
end;

procedure Tkonsolensteuerung.CreateParams(var Params:TCreateParams);
begin
  inherited;// CreateParams(Params);
  Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
  konsolensteuerung.ParentWindow := GetDesktopWindow;
//  Params.Caption:=PChar(konsolensteuerung.Caption);//'Kontrollpanel';
end;

procedure Tkonsolensteuerung.SaveBtnOn(Sender: TObject);
begin
  if not (Sender=SaveBtn) then SaveBtn.StateOn:=false;
  if not (Sender=DeleteBtn) then DeleteBtn.StateOn:=false;
  if not (Sender=CopyBtn) then CopyBtn.StateOn:=false;
  if not (Sender=MoveBtn) then MoveBtn.StateOn:=false;
end;

procedure TKonsolensteuerung.WMHotKey(var Msg: TWMHotKey);
var
  i:integer;
  key:Word;
  Shift:TShiftState;
begin
  for i:=0 to length(mainform.KonsolensteuerungTastencodeArray)-1 do
  begin
    ShortCutToKey(mainform.KonsolensteuerungTastencodeArray[i].Hotkey,Key,Shift);
    if (Msg.HotKey = mainform.KonsolensteuerungTastencodeArrayNumber[i]) then
    if konsolensteuerung.Active then
    begin
    //  ShowMessage(ShortCutToText(TastencodeArray[i].Hotkey));
      case mainform.KonsolensteuerungTastencodeArray[i].Typ of
        0: // Speichern
          SaveBtn.StateOn:=not SaveBtn.StateOn;
        1: // Löschen
          DeleteBtn.StateOn:=not DeleteBtn.StateOn;
        2: // Kopieren
          CopyBtn.StateOn:=not CopyBtn.StateOn;
        3: // Verschieben
          MoveBtn.StateOn:=not MoveBtn.StateOn;
      end;
    end;
  end;
end;

procedure Tkonsolensteuerung.Button1Click(Sender: TObject);
var
  i:integer;
  key:Word;
  Shift:TShiftState;
  ShiftNumber:Cardinal;
begin
  with mainform do
  begin
    setlength(TastencodeArray,length(KonsolensteuerungTastencodeArray));
    setlength(TastencodeArrayNumber,length(KonsolensteuerungTastencodeArrayNumber));
    for i:=0 to length(KonsolensteuerungTastencodeArray)-1 do
      TastencodeArray[i]:=KonsolensteuerungTastencodeArray[i];
    for i:=0 to length(KonsolensteuerungTastencodeArrayNumber)-1 do
      TastencodeArrayNumber[i]:=KonsolensteuerungTastencodeArrayNumber[i];
  end;

  with Tastenabfrage do
  begin
    SetupKonsolensteuerung:=true;
    Combobox1.Enabled:=false;
    Combobox2.Clear;
    Combobox2.Items.Add(_('Speichern'));
    Combobox2.Items.Add(_('Löschen'));
    Combobox2.Items.Add(_('Kopieren'));
    Combobox2.Items.Add(_('Verschieben'));
    Combobox2.ItemIndex:=0;

    StringGrid1.RowCount:=length(mainform.KonsolensteuerungTastencodeArray)+1;
    StringGrid1.Enabled:=(length(mainform.KonsolensteuerungTastencodeArray)>0);
    RefreshGrid;
    Button4.Enabled:=(length(mainform.KonsolensteuerungTastencodeArray)>0);
    Combobox2.Enabled:=(length(mainform.KonsolensteuerungTastencodeArray)>0);
    Hotkey1.Enabled:=(length(mainform.KonsolensteuerungTastencodeArray)>0);

    for i:=0 to length(mainform.KonsolensteuerungTastencodeArray)-1 do
    begin
      UnRegisterHotKey(konsolensteuerung.Handle, mainform.Konsolensteuerungtastencodearraynumber[i]);
      GlobalDeleteAtom(mainform.Konsolensteuerungtastencodearraynumber[i]);
    end;

    ShowModal;

    with mainform do
    begin
      setlength(KonsolensteuerungTastencodeArray,length(TastencodeArray));
      setlength(KonsolensteuerungTastencodeArrayNumber,length(TastencodeArrayNumber));
      for i:=0 to length(TastencodeArray)-1 do
        KonsolensteuerungTastencodeArray[i]:=TastencodeArray[i];
      for i:=0 to length(TastencodeArrayNumber)-1 do
        KonsolensteuerungTastencodeArrayNumber[i]:=TastencodeArrayNumber[i];
    end;

      for i:=0 to length(mainform.KonsolensteuerungTastencodeArray)-1 do
      begin
        ShortCutToKey(mainform.KonsolensteuerungTastencodeArray[i].Hotkey,Key,Shift);
        ShiftNumber:=0;
        if Shift=[ssAlt] then
          ShiftNumber:=1
        else if Shift=[ssCtrl] then
          ShiftNumber:=ShiftNumber+2
        else if Shift=[ssShift] then
        begin
          ShiftNumber:=ShiftNumber+4;
        end;

        mainform.KonsolensteuerungTastencodeArrayNumber[i] := GlobalAddAtom(PChar(ShortCutToText(mainform.KonsolensteuerungTastencodeArray[i].Hotkey)));
        if mainform.KonsolensteuerungTastencodeArray[i].active then
          RegisterHotKey(konsolensteuerung.Handle, mainform.KonsolensteuerungTastencodeArrayNumber[i], ShiftNumber, Key);
      end;
  end;
end;

procedure Tkonsolensteuerung.Button2Click(Sender: TObject);
var
	i:integer;
  CSV : TStrings;
begin
  midieventfrm.ShowModal;

  // MIDI-Ereignisse in CSV-Datei schreiben
  with mainform do
  begin
  if length(MidiEventArray)>0 then
  begin
	  CSV := TStringlist.Create;
	  For i :=0 To length(MidiEventArray)-1 do
	  	CSV.Add(inttostr(MidiEventArray[i].MIDIMessage)+','+inttostr(MidiEventArray[i].MIDIData1)+','+inttostr(MidiEventArray[i].MIDIData2)+','+inttostr(MidiEventArray[i].Typ)+','+inttostr(MidiEventArray[i].Wert1)+','+inttostr(MidiEventArray[i].Wert2)+','+inttostr(MidiEventArray[i].Data1orData2)+','+GUIDtoString(MidiEventArray[i].ID));
	  CSV.SaveToFile(ExtractFilepath(paramstr(0))+'Projekt\MIDISettings.pcdmidi');
	  CSV.Free;
  end else
  begin
  	if FileExists(ExtractFilepath(paramstr(0))+'Projekt\MIDISettings.pcdmidi') then
    	DeleteFile(ExtractFilepath(paramstr(0))+'Projekt\MIDISettings.pcdmidi');
  end;
  end;
end;

procedure Tkonsolensteuerung.FormActivate(Sender: TObject);
var
  i:integer;
  key:Word;
  Shift:TShiftState;
  ShiftNumber:Cardinal;
begin
  // Hotkeys aktivieren
      for i:=0 to length(mainform.KonsolensteuerungTastencodeArray)-1 do
      begin
        ShortCutToKey(mainform.KonsolensteuerungTastencodeArray[i].Hotkey,Key,Shift);
        ShiftNumber:=0;
        if Shift=[ssAlt] then
          ShiftNumber:=1
        else if Shift=[ssCtrl] then
          ShiftNumber:=ShiftNumber+2
        else if Shift=[ssShift] then
        begin
          ShiftNumber:=ShiftNumber+4;
        end;

        mainform.KonsolensteuerungTastencodeArrayNumber[i] := GlobalAddAtom(PChar(ShortCutToText(mainform.KonsolensteuerungTastencodeArray[i].Hotkey)));
        if mainform.KonsolensteuerungTastencodeArray[i].active then
          RegisterHotKey(konsolensteuerung.Handle, mainform.KonsolensteuerungTastencodeArrayNumber[i], ShiftNumber, Key);
      end;
end;

procedure Tkonsolensteuerung.FormDeactivate(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.KonsolensteuerungTastencodeArray)-1 do
  begin
    UnRegisterHotKey(konsolensteuerung.Handle, mainform.Konsolensteuerungtastencodearraynumber[i]);
    GlobalDeleteAtom(mainform.Konsolensteuerungtastencodearraynumber[i]);
  end;
end;

procedure Tkonsolensteuerung.Button3Click(Sender: TObject);
begin
  geraeteliste.showmodal;
end;

procedure Tkonsolensteuerung.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not mainform.shutdown then
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
         	LReg.WriteBool('Showing Konsolensteuerung',false);

          if not LReg.KeyExists('Konsolensteuerung') then
  	        LReg.CreateKey('Konsolensteuerung');
  	      if LReg.OpenKey('Konsolensteuerung',true) then
          begin
          end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
  end;
end;

procedure Tkonsolensteuerung.FormShow(Sender: TObject);
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
				LReg.WriteBool('Showing Konsolensteuerung',true);

        if not LReg.KeyExists('Konsolensteuerung') then
	        LReg.CreateKey('Konsolensteuerung');
	      if LReg.OpenKey('Konsolensteuerung',true) then
	      begin
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+konsolensteuerung.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              konsolensteuerung.Left:=LReg.ReadInteger('PosX')
            else
              konsolensteuerung.Left:=screen.DesktopLeft;
          end else
            konsolensteuerung.Left:=screen.DesktopLeft;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              konsolensteuerung.Top:=LReg.ReadInteger('PosY')
            else
              konsolensteuerung.Top:=screen.DesktopTop;
          end else
            konsolensteuerung.Top:=screen.DesktopTop;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure Tkonsolensteuerung.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
          if not LReg.KeyExists('Konsolensteuerung') then
  	        LReg.CreateKey('Konsolensteuerung');
  	      if LReg.OpenKey('Konsolensteuerung',true) then
          begin
            LReg.WriteInteger('PosX',konsolensteuerung.Left);
            LReg.WriteInteger('PosY',konsolensteuerung.Top);
          end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
end;

procedure Tkonsolensteuerung.Button4Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to chan do
    mainform.changedchannels[i]:=false;
  ChangedChannelsTimer.Enabled:=true;
end;

procedure Tkonsolensteuerung.ChangedChannelsTimerTimer(Sender: TObject);
var
  i:integer;
begin
  ChangedChannelsTimer.Enabled:=false;
  LockWindow(Listbox1.Handle);
  Listbox1.Clear;
  for i:=1 to chan do
  begin
    if mainform.changedchannels[i] then
      Listbox1.Items.Add(_('Kanal ')+inttostr(i)+_(' auf ')+levelstr(round(((100-mainform.GrandMaster.Position)/100)*(maxres-mainform.channel_value[i])),maxres));
  end;
  UnlockWindow(Listbox1.Handle);
end;

procedure Tkonsolensteuerung.Button5Click(Sender: TObject);
begin
  ChangedChannelsTimerTimer(nil);
end;

end.
