unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, U_Usb, Registry;

type
  // Funktionen für PC_DIMMER
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  // Gerätecontainer
  TDevice = record
    Handle:THandle;
    UniverseOut:byte;
    UniverseIn:byte;
    UseDMXIN: boolean;
  end;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Image1: TImage;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    Button1: TButton;
    DMXTimer: TTimer;
    Bevel1: TBevel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    ComboBox3: TComboBox;
    procedure DMXTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    NumberOfShowjockeyDevices:byte;
    USBCheck: TComponentUSB;
    procedure NewUSBDevice(Sender: TObject);
    procedure RemoveUSBDevice(Sender: TObject);
    procedure OnDeviceChange(var Msg: TMsg);
    procedure LoadSettings;
    procedure SaveSettings;
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;
    pVID_PID:PChar;

    Devices:array of TDevice;
    DMXOUTBuffer:array[0..15] of array[0..511] of byte;
    DMXINBuffer:array[0..15] of array[0..511] of byte;
    DMXINCompareBuffer:array[0..15] of array[0..511] of byte;

    procedure ConnectDevices;
    procedure DisconnectDevices;
  end;

var
  mainform: Tmainform;

// VID 0483, PID 57FE, REC 0200

function USBIO_GetDllVersion(strVersion: PChar): Boolean; stdcall external 'usbio.dll';
function USBIO_GetDeviceCount(pVID_PID: PChar): DWORD; stdcall external 'usbio.dll';
function USBIO_OpenDevice(dwDeviceNum: DWORD; pVID_PID: PChar): THandle; stdcall external 'usbio.dll';
function USBIO_SendDmx(hDrive: THandle; txBuffer: Pointer; txLen: Word): DWORD; stdcall external 'usbio.dll';
function USBIO_RecvDmx(hDrive: THandle; pBuffer: Pointer): DWORD; stdcall external 'usbio.dll';
function USBIO_CloseDevice(hDrive: THandle): Boolean; stdcall external 'usbio.dll';
function USBIO_GetDeviceType(hDrive: THandle): Word; stdcall external 'usbio.dll';


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

procedure Tmainform.ConnectDevices;
var
  i:integer;
begin
  // Angeschlossene Interfaces suchen
  memo1.Lines.Add('Searching for devices...');
  NumberOfShowjockeyDevices:=USBIO_GetDeviceCount(pVID_PID);
  setlength(Devices, NumberOfShowjockeyDevices);
  memo1.Lines.Add('Found '+inttostr(length(Devices))+' devices');

  // Angeschlossene Interfaces öffnen
  combobox1.Items.Clear;
  for i:=0 to length(Devices)-1 do
  begin
    combobox1.Items.Add('Interface '+inttostr(i+1));

    Devices[i].Handle:=USBIO_OpenDevice(i, pVID_PID);
    if Devices[i].Handle<>INVALID_HANDLE_VALUE then
      memo1.Lines.Add('Connected to Interface No. '+inttostr(i+1)+' successfully (Type '+inttostr(USBIO_GetDeviceType(Devices[i].Handle))+')')
    else
      memo1.Lines.Add('Error on opening Interface No. '+inttostr(i+1));
  end;
  memo1.Lines.Add(' ');

  DMXTimer.Enabled:=true;
  memo1.Lines.Add('DMX512-Timer enabled');
  LoadSettings;
  memo1.Lines.Add('Settings loaded');
  memo1.lines.add('');
end;

procedure Tmainform.DisconnectDevices;
var
  i:integer;
begin
  DMXTimer.Enabled:=false;

  memo1.lines.add('Stopping devices...');
  combobox1.Items.Clear;
  for i:=0 to length(Devices)-1 do
  begin
    if USBIO_CloseDevice(Devices[i].Handle) then
      memo1.Lines.Add('Closed Interface Nr. '+inttostr(i+1)+' succesfully')
    else
      memo1.Lines.Add('Error on closing Interface Nr. '+inttostr(i+1));
  end;
  memo1.lines.add('');
end;

procedure Tmainform.DMXTimerTimer(Sender: TObject);
var
  i,j:integer;
begin
  // Schreibe und lese Daten
  for i:=0 to length(Devices)-1 do
  begin
    if Devices[i].UseDMXIN then
    begin
      USBIO_RecvDmx(Devices[i].Handle, @DMXInBuffer[Devices[i].UniverseIn]);

      for j:=0 to 511 do
      begin
        // prüfen, ob sich ein Kanalwert im Eingangsarray verändert hat
        if (DMXInBuffer[Devices[i].UniverseIn][j]<>DMXInCompareBuffer[Devices[i].UniverseIn][j]) then
        begin
          // Veränderung in Compare-Array speichern
          DMXInCompareBuffer[Devices[i].UniverseIn][j]:=DMXInBuffer[Devices[i].UniverseIn][j];
          // Neuen Wert zum PC_DIMMER senden
          SetDLLValueEvent(j+1+512*Devices[i].UniverseIn, DMXInBuffer[Devices[i].UniverseIn][j])
        end;
      end;
    end else
    begin
      USBIO_SendDmx(Devices[i].Handle, @DMXOUTBuffer[Devices[i].UniverseOut], 512);
    end;
  end;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  memo1.Lines.Add('==================================');
  DisconnectDevices;
  ConnectDevices;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  strVersion: string[32];
begin
  memo1.Lines.Add('ShowJockey PC_DIMMER Plugin started');

  // DLL-Version herausfinden
  if USBIO_GetDllVersion(@strVersion) then
    memo1.Lines.Add('Found DLL v'+strVersion)
  else
    memo1.Lines.Add('Error reading DLL Version!');
  memo1.Lines.Add('');

  // USB-Änderungen erkennen
  USBCheck := TComponentUSB.Create(MainForm);
  // Handler zum Erkennen neuer Laufwerke
  USBCheck.OnUSBArrival := NewUSBDevice;
  USBCheck.OnUSBRemove := RemoveUSBDevice;
end;

procedure TMainForm.NewUSBDevice(Sender: TObject);
var
  Msg: TMsg;
begin
  Msg.message := DBT_DEVICEARRIVAL;
  OnDeviceChange(Msg);
end;

procedure TMainForm.RemoveUSBDevice(Sender: TObject);
var
  Msg: TMsg;
begin
  Msg.message := DBT_DEVICEREMOVECOMPLETE;
  OnDeviceChange(Msg);
end;

procedure TMainForm.OnDeviceChange(var Msg: TMsg);
begin
  if (Msg.message = DBT_DEVICEARRIVAL) or (Msg.message = DBT_DEVICEREMOVECOMPLETE) then
  begin
    if NumberOfShowjockeyDevices<>USBIO_GetDeviceCount(pVID_PID) then
    begin
      memo1.Lines.Add('==================================');
      if Msg.message = DBT_DEVICEARRIVAL then
        memo1.Lines.Add('New Showjockey Interface found...');
      if Msg.message = DBT_DEVICEREMOVECOMPLETE then
        memo1.Lines.Add('Showjockey Interface removed...');
      DisconnectDevices;
      ConnectDevices;
    end;
  end;
end;

procedure Tmainform.ComboBox2Change(Sender: TObject);
begin
  if combobox1.ItemIndex>-1 then
  begin
    Devices[combobox1.ItemIndex].UniverseOut:=combobox2.ItemIndex;
    SaveSettings;
    memo1.Lines.Add('Settings saved');
  end;
end;

procedure Tmainform.ComboBox3Change(Sender: TObject);
begin
  if combobox1.ItemIndex>-1 then
  begin
    Devices[combobox1.ItemIndex].UniverseIn:=combobox3.ItemIndex;
    SaveSettings;
    memo1.Lines.Add('Settings saved');
  end;
end;

procedure Tmainform.ComboBox1Change(Sender: TObject);
begin
  combobox2.ItemIndex:=Devices[combobox1.ItemIndex].UniverseOut;
  combobox3.ItemIndex:=Devices[combobox1.ItemIndex].UniverseIn;
  checkbox1.Checked:=Devices[combobox1.ItemIndex].UseDMXIN;
end;

procedure TMainform.LoadSettings;
var
  LReg:TRegistry;
  i:integer;
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
            if LReg.ValueExists('DMXIn enabled') then
              checkbox1.Checked:=LReg.ReadBool('DMXIn enabled');
            for i:=0 to length(Devices)-1 do
            begin
              if LReg.ValueExists('Interface '+inttostr(i+1)+' UniverseOut') then
                Devices[i].UniverseOut:=LReg.ReadInteger('Interface '+inttostr(i+1)+' UniverseOut');
              if LReg.ValueExists('Interface '+inttostr(i+1)+' UniverseIn') then
                Devices[i].UniverseIn:=LReg.ReadInteger('Interface '+inttostr(i+1)+' UniverseIn');
              if LReg.ValueExists('Interface '+inttostr(i+1)+' UseDMXIN') then
                Devices[i].UseDMXIN:=LReg.ReadBool('Interface '+inttostr(i+1)+' UseDMXIN');
            end;
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
end;

procedure TMainform.SaveSettings;
var
  LReg:TRegistry;
  i:integer;
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
            LReg.WriteBool('DMXIn enabled', checkbox1.Checked);

            for i:=0 to length(Devices)-1 do
            begin
              LReg.WriteInteger('Interface '+inttostr(i+1)+' UniverseOut', Devices[i].UniverseOut);
              LReg.WriteInteger('Interface '+inttostr(i+1)+' UniverseIn', Devices[i].UniverseIn);
              LReg.WriteBool('Interface '+inttostr(i+1)+' UseDMXIN', Devices[i].UseDMXIN);
            end;
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if combobox1.ItemIndex>-1 then
  begin
    Devices[combobox1.ItemIndex].UseDMXIN:=checkbox1.checked;
    SaveSettings;
    memo1.Lines.Add('Settings saved');
  end;
end;

end.
