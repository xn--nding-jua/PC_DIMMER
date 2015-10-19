unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CPort, CHHighResTimer, CPDrv;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    portchange: TComboBox;
    Label2: TLabel;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    comport2: TComPort;
    DMXValueRefreshTimer: TCHHighResTimer;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label7: TLabel;
    Label3: TLabel;
    statuslabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure InitializeInterface;
    procedure DMXValueRefreshTimerTimer(Sender: TObject);
    procedure input_number(var pos:integer; var s:string);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure portchangeDropDown(Sender: TObject);
    procedure portchangeCloseUp(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
  private
    { Private-Deklarationen }
    ConnectionProblem:boolean;
    TimerInterval:Cardinal;
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    rs232frame_new:array[0..513] of Byte;
    rs232frame:array of array[0..3] of Byte;
    rs232frame_locked:boolean;
    maxchan:word;
    procedure Startup;
  end;

var
  Config: TConfig;

implementation

uses
  JwaWinType,
  SetupApi, Cfg, CfgMgr32;

{$R *.dfm}

// Delphi wrapper for CM_Get_Device_ID

function GetDeviceID(Inst: DEVINST): string;
var
  Buffer: PTSTR;
  Size: ULONG;
begin
  CM_Get_Device_ID_Size(Size, Inst, 0);
  // Required! See DDK help for CM_Get_Device_ID
  Inc(Size);
  Buffer := AllocMem(Size * SizeOf(TCHAR));
  CM_Get_Device_ID(Inst, Buffer, Size, 0);
  Result := Buffer;
  FreeMem(Buffer);
end;

// Delphi wrapper for SetupDiGetDeviceRegistryProperty

function GetRegistryPropertyString(PnPHandle: HDEVINFO; const DevData: TSPDevInfoData; Prop: DWORD): string;
var
  BytesReturned: DWORD;
  RegDataType: DWORD;
  Buffer: array [0..1023] of TCHAR;
begin
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, Prop,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result := Buffer;
end;

function ExtractBus(DeviceID: string): string;
begin
  Result := Copy(DeviceID, 1, Pos('\', DeviceID) - 1);
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

procedure TConfig.FormShow(Sender: TObject);
begin
  Edit2.Text:=inttostr(TimerInterval);
  Edit2.Color:=clWindow;
end;

procedure TConfig.InitializeInterface;
begin
  if comport2.Connected then
    comport2.WriteStr('R'); // Konverter Resetten
end;

procedure TConfig.DMXValueRefreshTimerTimer(Sender: TObject);
begin
// "P" ; 5 ; 0; 10; 255; 128; 50; "P" ; 5 ; 0; 10; 255; 128; 50;
  if comport2.Connected then
  begin
    rs232frame_new[0]:=ord('P'); // "P"
    rs232frame_new[1]:=maxchan+1; // Anzahl der Kanäle
    rs232frame_new[2]:=0; // Kanal 0 = 0

    if comport2.Connected then
      connectionproblem:=(comport2.Write(rs232frame_new,maxchan+3)<>(maxchan+3));
    if connectionproblem then
    begin
      statuslabel.Caption:='Verbindungsproblem!';
      statuslabel.Font.Color:=clRed;
      DMXValueRefreshTimer.Interval:=2000;
    end else
    begin
      statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
      statuslabel.Font.Color:=clGreen;
      DMXValueRefreshTimer.Interval:=TimerInterval;
    end;
  end;
end;

procedure TConfig.Edit1Change(Sender: TObject);
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

procedure TConfig.input_number(var pos:integer; var s:string);
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

procedure TConfig.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  Edit2.Color:=$00BFBFFF;
end;

procedure TConfig.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LReg:TRegistry;
begin
  if key=vk_return then
  begin
    Edit2.Color:=clWindow;

    case strtoint(Edit1.text) of
      1..24: if (strtoint(Edit2.Text)<25) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>25ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
      25..80: if (strtoint(Edit2.Text)<50) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>50ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
      81..100: if (strtoint(Edit2.Text)<75) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>75ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
      101..150: if (strtoint(Edit2.Text)<100) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>100ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
      151..200: if (strtoint(Edit2.Text)<150) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>150ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
      201..254: if (strtoint(Edit2.Text)<200) then if MessageDlg('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des sicheren Bereichs (>200ms). Ein niedrigerer Wert kann den PC_DIMMER zum Absturz bringen. Möchten Sie dennoch fortfahren (die Werte können in der Registry zurückgesetzt werden)?', mtInformation,[mbYes, mbCancel], 0)=mrCancel then exit;
    end;

    DMXValueRefreshTimer.Interval:=strtoint(Edit2.text);

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
            LReg.WriteInteger('Timerspeed',DMXValueRefreshTimer.Interval);
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure TConfig.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LReg:TRegistry;
  kanalzahl:integer;
begin
  if key=vk_return then
  begin
    if strtoint(Edit1.text)>254 then
    Edit1.text:='254';

    kanalzahl:=strtoint(Edit1.text);

    case kanalzahl of
      1..24: Edit2.text:='25';
      25..80: Edit2.text:='50';
      81..100: Edit2.text:='75';
      101..150: Edit2.text:='100';
      151..200: Edit2.text:='150';
      201..254: Edit2.text:='200';
    end;
    Edit2KeyUp(Edit1,key,[]);

    maxchan:=strtoint(Edit1.text);

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
	          LReg.WriteInteger('Last Chan',maxchan);
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure TConfig.portchangeDropDown(Sender: TObject);
begin
  portchange.Width:=169;
end;

procedure TConfig.portchangeCloseUp(Sender: TObject);
begin
  portchange.Width:=97;
end;

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  portchange.ItemIndex:=0;
  for i:=0 to portchange.items.count-1 do
  begin
    temp:=copy(portchange.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        portchange.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        portchange.ItemIndex:=i;
        break;
      end;
    end;
  end;
end;

procedure TConfig.portchangeSelect(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if (portchange.Items.Count > 0) and (portchange.Itemindex<portchange.Items.Count) and (portchange.Items[portchange.Itemindex]<>'') then
  begin
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    try
      if comport2.Connected then
        comport2.close;
    except
    end;
      case comportnumber of
        1: comport2.port:='COM1';   2: comport2.port:='COM2';
        3: comport2.port:='COM3';   4: comport2.port:='COM4';
        5: comport2.port:='COM5';   6: comport2.port:='COM6';
        7: comport2.port:='COM7';   8: comport2.port:='COM8';
        9: comport2.port:='COM9';   10: comport2.port:='COM10';
        11: comport2.port:='COM11';   12: comport2.port:='COM12';
        13: comport2.port:='COM13';   14: comport2.port:='COM14';
        15: comport2.port:='COM15';   16: comport2.port:='COM16';
      end;
    comport2.open;

    InitializeInterface;

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
            LReg.WriteInteger('COMPort',comportnumber);
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;

  if comport2.Connected then
  begin
    statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
    statuslabel.Font.Color:=clGreen;
  end else
  begin
    statuslabel.Caption:='Nicht verbunden...';
    statuslabel.Font.Color:=clRed;
  end;
end;

procedure TConfig.Startup;
const
  GUID_DEVINTERFACE_COMPORT: TGUID                = '{86e0d1e0-8089-11d0-9ce4-08003e301f73}';
  GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR: TGUID = '{4D36E978-E325-11CE-BFC1-08002BE10318}';
var
  PnPHandle: HDEVINFO;
  DevData: TSPDevInfoData;
  DeviceInterfaceData: TSPDeviceInterfaceData;
  FunctionClassDeviceData: PSPDeviceInterfaceDetailData;
  Success: LongBool;
  Devn: Integer;
  BytesReturned: DWORD;
  SerialGUID: TGUID;
  Inst: DEVINST;
  RegKey: HKEY;
  RegBuffer: array [0..1023] of Char;
  RegSize, RegType: DWORD;
  FriendlyName: string;
  PortName: string;
  DeviceDescription: string;
  Bus: string;

  LReg:TRegistry;
  serialport:integer;
//  i:integer;
  TestHandle : integer;
begin
  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

	shutdown:=false;
	issending:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  serialport:=2;

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
	        if not LReg.ValueExists('COMPort') then
	          LReg.WriteInteger('COMPort',2);
	        serialport:=LReg.ReadInteger('COMPort');
	        if not LReg.ValueExists('Timerspeed') then
	          LReg.WriteInteger('Timerspeed',75);

      	  TimerInterval:=LReg.ReadInteger('Timerspeed');
          if TimerInterval<=50 then
            TimerInterval:=50;
          DMXValueRefreshTimer.Interval:=TimerInterval;

	        if not LReg.ValueExists('Last Chan') then
	          LReg.WriteInteger('Last Chan',64);
	        maxchan:=LReg.ReadInteger('Last Chan');
          if maxchan>254 then maxchan:=254;
          Edit1.Text:=inttostr(maxchan);
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  try
    if comport2.Connected then
	  	comport2.close;
  except
  end;
{
// COM-Ports von 1 bis 16 abklappern
	portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    portchange.Items.Add('COM'+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
}
  // enumerate all serial devices (COM port devices)
    SerialGUID := GUID_DEVINTERFACE_COMPORT;
//    SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
  PnPHandle := SetupDiGetClassDevs(@SerialGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = Pointer(INVALID_HANDLE_VALUE) then
    Exit;
  portchange.Items.BeginUpdate;
  portchange.Items.Clear;
  Devn := 0;
  repeat
    DeviceInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
    Success := SetupDiEnumDeviceInterfaces(PnPHandle, nil, SerialGUID, Devn, DeviceInterfaceData);
    if Success then
    begin
      TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(Devn+1)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
//    	if (TestHandle > 0) then
      begin
        DevData.cbSize := SizeOf(DevData);
        BytesReturned := 0;
        // get size required for call
        SetupDiGetDeviceInterfaceDetail(PnPHandle, @DeviceInterfaceData, nil, 0, BytesReturned, @DevData);
        if (BytesReturned <> 0) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
        begin
          // allocate buffer and initialize it for call
          FunctionClassDeviceData := AllocMem(BytesReturned);
          FunctionClassDeviceData.cbSize := SizeOf(TSPDeviceInterfaceDetailData);

          if SetupDiGetDeviceInterfaceDetail(PnPHandle, @DeviceInterfaceData,
            FunctionClassDeviceData, BytesReturned, BytesReturned, @DevData) then
          begin
            // gives the friendly name of the device as shown in Device Manager
            FriendlyName := GetRegistryPropertyString(PnPHandle, DevData, SPDRP_FRIENDLYNAME);
            // gives a device description
            DeviceDescription := GetRegistryPropertyString(PnPHandle, DevData, SPDRP_DEVICEDESC);
            // now try to get the assigned COM port name
            RegKey := SetupDiOpenDevRegKey(PnPHandle, DevData, DICS_FLAG_GLOBAL, 0, DIREG_DEV, KEY_READ);
            RegType := REG_SZ;
            RegSize := SizeOf(RegBuffer);
            RegQueryValueEx(RegKey, 'PortName', nil, @RegType, @RegBuffer[0], @RegSize);
            RegCloseKey(RegKey);
            PortName := RegBuffer;
            Inst := DevData.DevInst;
            CM_Get_Parent(Inst, Inst, 0);
            Bus := ExtractBus(GetDeviceID(Inst));
            portchange.Items.Add(PortName + ' (' + DeviceDescription + ', ' + Bus+')');
          end;
          FreeMem(FunctionClassDeviceData);
        end;
      end;
	    CloseHandle(TestHandle);
    end;
    Inc(Devn);
  until not Success;
  SetupDiDestroyDeviceInfoList(PnPHandle);
  portchange.Items.EndUpdate;
  if serialport>0 then
    ActivateCOMPort(serialport);

  if portchange.Items.Count > 0 then
  begin
    portchangeSelect(nil);
    portchange.Visible:=true;
  end else
    portchange.Visible:=false;

  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
end;

end.
