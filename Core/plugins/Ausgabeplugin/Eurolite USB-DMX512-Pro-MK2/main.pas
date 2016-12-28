unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D2XXUnit, CHHighResTimer, StdCtrls, Mask, JvExMask, JvSpin,
  jpeg, ExtCtrls, Registry;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  Tmainform = class(TForm)
    DMXTimer: TCHHighResTimer;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    deviceselectionlist: TComboBox;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    Label1: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    sendalwayscheck: TCheckBox;
    Label15: TLabel;
    disconnectedlbl: TLabel;
    connectedlbl: TLabel;
    Button1: TButton;
    Button2: TButton;
    autoconnectcheckbox: TCheckBox;
    SlowTimer: TTimer;
    Button3: TButton;
    Button4: TButton;
    LastErrorLbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure deviceselectionlistChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SlowTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    AutoConnectRetrys:byte;
    num_devices:byte;
    device_connected:Word;
    device_num:integer;
    DMXoutOK:boolean;
  public
    { Public-Deklarationen }
  	device_handle:THANDLE;//DWORD;
    issending:boolean;
    NewDataForOutput:boolean;

    LastErrorString:string;

    DMXOutputBuffer:array[0..517] of byte; // DMX-Startbyte, 512 Datenbytes

    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;

    function FTDI_OpenDevice(device_num:integer):word;
  	function FTDI_ListDevices:integer;
	  procedure FTDI_ClosePort;
  	procedure FTDI_PurgeBuffer;
	procedure FTDI_Reload;

    procedure ConnectToInterface;
    procedure ReconnectInterface;
    procedure DisconnectInterface;

    procedure CheckFTDIStatus(ftStatus:integer);
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

procedure Tmainform.FTDI_ClosePort;
begin
//  FT_ResetDevice(device_handle);

	if (device_handle <> 0) then
  	FT_Close(device_handle);
end;

function Tmainform.FTDI_ListDevices:integer;
var
	ftStatus:FT_RESULT;
	numDevs:Dword;
begin
	numDevs:=0;
	ftStatus := FT_GetNumDevices(@numDevs,nil,FT_LIST_NUMBER_ONLY);
  CheckFTDIStatus(ftStatus);

	if (ftStatus = FT_OK) then
		result:=numDevs
	else
		result:=0;
end;

procedure Tmainform.FTDI_PurgeBuffer;
begin
	FT_Purge(device_handle, FT_PURGE_TX);
	FT_Purge(device_handle, FT_PURGE_RX);
end;


procedure Tmainform.FTDI_Reload;
var
	wVID, wPID:word;
	ftStatus:FT_RESULT;
begin
	wVID:=1027;
	wPID:=24577;
	
	ftStatus:=FT_Reload(wVID, wPID);
	Sleep(3500);
	
	if ftStatus<>FT_OK then
		showMessage('Reloading Driver failed!')
	else
		showMessage('Reloading Driver D2XX successful.');
end;

function Tmainform.FTDI_OpenDevice(device_num:integer):word;
var
	RTimeout:integer;
	WTimeout:integer;
	version:longint;
	major_ver, minor_ver, build_ver:byte;
	tries:integer;
	latencyTimer:byte;
	ftStatus:FT_RESULT;
begin
	RTimeout := 120;
	WTimeout := 100;
	tries := 0;

	// Try at least 3 times
	repeat
		memo1.lines.add('Try to connect to interface '+inttostr(device_num)+' - '+inttostr(tries+1)+' of 3 tries');

    // delay for next try
    if tries>0 then
      sleep(750);

		// Open the PRO
		ftStatus := FT_Open(device_num,@device_handle);
    memo1.lines.add('Opening device...');
    CheckFTDIStatus(ftStatus);
		inc(tries);
	until ((ftStatus = FT_OK) or (tries < 3));

	// PRO Opened succesfully
	if (ftStatus = FT_OK) then
	begin
    memo1.lines.add('Read Driver Version...');
		// GET D2XX Driver Version
		ftStatus := FT_GetDriverVersion(device_handle,@version);
    CheckFTDIStatus(ftStatus);
		if (ftStatus = FT_OK) then
		begin
			major_ver := version shr 16;
			minor_ver := version shr 8;
			build_ver := version AND 255;
			memo1.lines.add('D2XX Driver Version: '+inttostr(major_ver)+'.'+inttostr(minor_ver)+'.'+inttostr(build_ver));
		end else
		begin
			memo1.lines.add('Unable to Get D2XX Driver Version') ;
		end;

		// GET Latency Timer
		ftStatus := FT_GetLatencyTimer(device_handle, @latencyTimer);
		if (ftStatus = FT_OK)  then
			memo1.lines.add('Latency Timer: '+inttostr(latencyTimer))
		else
			memo1.lines.add('Unable to Get Latency Timer') ;

    memo1.lines.add('Set Baudrate to 250000...');
    CheckFTDIStatus(FT_SetBaudRate(device_handle, 250000));
    memo1.lines.add('Set Databits, Stopbits and Parity...');
    CheckFTDIStatus(FT_SetDataCharacteristics(device_handle, FT_DATA_BITS_8, FT_STOP_BITS_1, FT_PARITY_NONE));

		// SET Default Read & Write Timeouts (in micro sec ~ 100)
		FT_SetTimeouts(device_handle,RTimeout,WTimeout);

		// Clear (purges) the buffer
		FT_Purge(device_handle,FT_PURGE_RX);

		// Clear (purges) the buffer again
		FT_Purge(device_handle,FT_PURGE_RX);

		// return success
		result:=1;
	end	else // Can't open Device
	begin
    memo1.lines.add('Error: can''t open connection to interface');
		result:=0;
	end;
end;

procedure Tmainform.CheckFTDIStatus(ftStatus:integer);
begin
  case ftStatus of
    0: memo1.text:=memo1.text+'OK';
    1: memo1.text:=memo1.text+'Invalid Handle';
    2: memo1.text:=memo1.text+'Device not found';
    3: memo1.text:=memo1.text+'Device not opened';
    4: memo1.text:=memo1.text+'IO-Error';
    5: memo1.text:=memo1.text+'Insufficient resources';
    6: memo1.text:=memo1.text+'Invalid parameter';
    7: memo1.text:=memo1.text+'Invalid baudrate';
    8: memo1.text:=memo1.text+'Device not opened for erase';
    9: memo1.text:=memo1.text+'Device not opened for write';
    10: memo1.text:=memo1.text+'Failed to write device';
    11: memo1.text:=memo1.text+'Eeprom read failed';
    12: memo1.text:=memo1.text+'Eeprom write failed';
    13: memo1.text:=memo1.text+'Eeprom erase faild';
    14: memo1.text:=memo1.text+'Eeprom not present';
    15: memo1.text:=memo1.text+'Eeprom not programmed';
    16: memo1.text:=memo1.text+'Invalid Args';
    17: memo1.text:=memo1.text+'Other error';
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
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
	        if not LReg.ValueExists('Refreshrate') then
	          LReg.WriteInteger('Refreshrate',1);
	        JvSpinEdit1.value:=LReg.ReadInteger('Refreshrate');
          DMXTimer.Interval:=round(JvSpinEdit1.value);

	        if not LReg.ValueExists('Send continuously') then
	          LReg.WriteBool('Send continuously',false);
          sendalwayscheck.checked:=LReg.ReadBool('Send continuously');

	        if not LReg.ValueExists('Autoconnect') then
	          LReg.WriteBool('Autoconnect',true);
          autoconnectcheckbox.checked:=LReg.ReadBool('Autoconnect');
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  issending:=false;

  NewDataForOutput:=true;

{
  // FTDI resetten
  FT_Reload(1027, 24577); // VID:0403, PID:6001
  FT_Rescan();
}
end;

procedure Tmainform.DMXTimerTimer(Sender: TObject);
var
  bytes_written:DWORD;
begin
  // Send DMX Data
  if (device_connected>0) then
  begin
    DMXOutputBuffer[0]:=126; // Package Header (always 0x7E)
    DMXOutputBuffer[1]:=6; // Message Type (alway 0x06 for sending DMX data)
    DMXOutputBuffer[2]:=1; // DMX Startcode + Datalength LSB (für 512 Kanäle: 0x01)
    DMXOutputBuffer[3]:=2; // DMX Startcode + Datalength MSB (für 512 Kanäle: 0x02)
    DMXOutputBuffer[4]:=0; // DMX Startcode = always 0x00
    DMXOutputBuffer[517]:=231; // Package Footer (always 0xE7)

    if (NewDataForOutput or sendalwayscheck.checked) then
    begin
      FT_Write(device_handle,@DMXOutputBuffer,sizeof(DMXOutputBuffer),@bytes_written);
      if (bytes_written <> sizeof(DMXOutputBuffer)) then
      begin
        LastErrorString:='Error Sending DMX-Data to Interface';
        DMXOutOK:=false;
      end else
      begin
        NewDataForOutput:=false;
        DMXOutOK:=true;
      end;
    end;
  end;
end;

procedure Tmainform.ConnectToInterface;
var
  oldone,i:integer;
begin
  LastErrorString:='';

  memo1.lines.add('Looking for Devices...');
	Num_Devices := FTDI_ListDevices;

  oldone:=deviceselectionlist.ItemIndex;
  deviceselectionlist.Items.Clear;
  for i:=1 to Num_Devices do
  begin
    deviceselectionlist.Items.Add(inttostr(i))
  end;
  if oldone=-1 then
    oldone:=0;
  if oldone<deviceselectionlist.Items.Count then
    deviceselectionlist.ItemIndex:=oldone;

	if (Num_Devices = 0) then
	begin
		memo1.lines.add('  -> 0 Eurolite USB-DMX512 Pro MK2 found');
	end	else
	begin
		memo1.lines.add('  -> '+inttostr(Num_Devices)+' Eurolite USB-DMX512 Pro MK2 found');
		memo1.lines.add('Opening the first device...');

		device_num := deviceselectionlist.ItemIndex;
		device_connected := FTDI_OpenDevice(device_num);

    if device_connected=1 then
      memo1.Lines.Add('Device opened successfully.');

    connectedlbl.Visible:=device_connected<>0;
    disconnectedlbl.Visible:=(device_connected=0);
  end;
  DMXTimer.Enabled:=true;
end;

procedure Tmainform.DisconnectInterface;
begin
  LastErrorString:='';
  DMXTimer.Enabled:=false;
  memo1.lines.add('Interface disconnected.');
  device_connected:=0;

  connectedlbl.Visible:=device_connected<>0;
  disconnectedlbl.Visible:=(device_connected=0);

  FTDI_ClosePort;
end;

procedure Tmainform.ReconnectInterface;
begin
  LastErrorString:='Rebooting...';
  memo1.Lines.Clear;
  DisconnectInterface;
  ConnectToInterface;
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  ReconnectInterface;
  AutoConnectRetrys:=0;
end;

procedure Tmainform.JvSpinEdit1Change(Sender: TObject);
begin
  DMXTimer.Interval:=round(JvSpinEdit1.Value);
end;

procedure Tmainform.deviceselectionlistChange(Sender: TObject);
begin
  ReconnectInterface;
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  if mainform.ClientWidth=721 then
    mainform.ClientWidth:=345
  else
    mainform.ClientWidth:=721;

  groupbox3.Visible:=mainform.ClientWidth=721;
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  DisconnectInterface;
  AutoConnectRetrys:=0;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
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
          LReg.WriteInteger('Refreshrate',round(JvSpinEdit1.value));
          LReg.WriteBool('Send continuously',sendalwayscheck.checked);
          LReg.WriteBool('Autoconnect',autoconnectcheckbox.checked);
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.SlowTimerTimer(Sender: TObject);
begin
  if LastErrorString='' then
    LastErrorLbl.Caption:='Meldung: ...'
  else
    LastErrorLbl.Caption:='Meldung: '+LastErrorString;

  if DMXOutOK then
    LastErrorString:='';
end;

end.
