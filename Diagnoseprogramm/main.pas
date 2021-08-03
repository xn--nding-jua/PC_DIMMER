unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ComCtrls, XPMan, ExtCtrls, Registry;

type
  TForm1 = class(TForm)
    Button8: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox1: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    XPManifest1: TXPManifest;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label15: TLabel;
    GroupBox2: TGroupBox;
    Comport: TCommPortDriver;
    ListBox1: TListBox;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    sinusfrequenz: TLabel;
    zerocrossing: TLabel;
    adresse: TLabel;
    uebertragungsrate: TLabel;
    frequenz: TLabel;
    hardware: TLabel;
    datum: TLabel;
    version: TLabel;
    beschreibung: TLabel;
    Label26: TLabel;
    typ: TLabel;
    GroupBox4: TGroupBox;
    portchange: TComboBox;
    baudratechange: TComboBox;
    Label16: TLabel;
    Label27: TLabel;
    Button2: TButton;
    kanal1: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    kanal2: TLabel;
    kanal3: TLabel;
    kanal4: TLabel;
    kanal5: TLabel;
    kanal6: TLabel;
    kanal7: TLabel;
    kanal8: TLabel;
    Label32: TLabel;
    dimmkurve: TLabel;
    Button3: TButton;
    Button4: TButton;
    Edit5: TEdit;
    Label41: TLabel;
    Label42: TLabel;
    Label29: TLabel;
    Button1: TButton;
    Label28: TLabel;
    Bevel3: TBevel;
    Label43: TLabel;
    pd5_checkbox: TCheckBox;
    pd6_checkbox: TCheckBox;
    Bevel4: TBevel;
    Label30: TLabel;
    Label31: TLabel;
    ScrollBar9: TScrollBar;
    procedure DLLSenddata(address, startvalue, endvalue, fadetime: integer);
    procedure Button8Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure baudratechangeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar9Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure portchangeDropDown(Sender: TObject);
    procedure portchangeCloseUp(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate: integer;
    rs232_inframe:array of byte;
    device:byte;
  end;

var
  Form1: TForm1;

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

procedure TForm1.DLLSenddata(address, startvalue, endvalue, fadetime: integer);
var
  b:byte;
  t3,t2,t1:byte;
  rs232frame:array[0..5] of Byte;
  nsteps,stp:integer;
  timestep:longint;
begin
// Routine für COM1 bis COM16

// im Puffer alles auf 0 setzen
  FillChar(rs232frame, SizeOf(rs232frame), 0);

  startvalue:=255-startvalue;
  endvalue:=255-endvalue;

  fadetime:=fadetime div 10;
  stp:=0;

  nsteps:=abs(startvalue-endvalue);

  if (nsteps<>0) and (fadetime<>0) then
  begin
    repeat
      inc(stp);
      timestep:=fadetime*stp;
      timestep:=round(timestep/nsteps);
    until (abs(((fadetime-((timestep*nsteps)/stp))*100)/fadetime) <= 15) or (stp>=4);
  end
  else
  begin
    timestep:=0;
    inc(stp);
  end;

  dec(address);
  b:=address;
  b:=b or $80;                                {erste byte high für Synchronisation}
  rs232frame[0]:=b;                           {erste Byte in Puffer schreiben}

//Steps in Byte 2 schreiben
  dec(stp);
  b:=0;
  b:=b or stp;
  rs232frame[1]:=b;                           {zweite Byte in Puffer schreiben}

  // zusätzliche GPIOs schalten, sofern Option gewählt
  if pd5_checkbox.Checked then
    rs232frame[1]:=rs232frame[1]+32;  // 0b0x100000
  if pd6_checkbox.Checked then
    rs232frame[1]:=rs232frame[1]+64;  // 0b01x00000

// Fadezeiten in Byte 3..5 senden
  t1:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t2:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t3:=(lo(timestep) and $7F);
  rs232frame[2]:=t3;                           {dritte Byte in Puffer schreiben}
  rs232frame[3]:=t2;                           {vierte Byte in Puffer schreiben}
  rs232frame[4]:=t1;                           {fünfte Byte in Puffer schreiben}

// Endwert im Byte 6 senden
  b:=(endvalue div 2) and $7F;
  rs232frame[5]:=b;                           {sechste Byte in Puffer schreiben}
  comport.SendData(@rs232frame,6);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
	DLLSenddata(strtoint(edit1.Text),strtoint(edit2.Text),strtoint(edit2.Text),0);
  sleep(50);
	DLLSenddata(strtoint(edit1.Text),strtoint(edit2.Text),strtoint(edit3.Text),strtoint(edit4.Text));
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
	i:integer;
begin
  for i:=1 to 8 do
  if (Sender=FindComponent('Scrollbar'+inttostr(i))) and (i+device<=128) then
		DLLSenddata(i+(device),TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position,TScrollbar(FindComponent('Scrollbar'+inttostr(i))).Position,0);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
	close;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
	if edit3.text <> '' then
  begin
		if strtoint(edit3.Text) > 255 then edit3.text:='255';
		if strtoint(edit3.Text) < 0 then edit3.text:='0';
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
	if edit2.text <> '' then
  begin
  	if strtoint(edit2.Text) > 255 then edit2.text:='255';
		if strtoint(edit2.Text) < 0 then edit2.text:='0';
  end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
	if edit1.text <> '' then
  begin
		if strtoint(edit1.Text) > 128 then edit1.text:='128';
		if strtoint(edit1.Text) < 1 then edit1.text:='1';
  end;
end;

procedure TForm1.ComportReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var i: integer;
    s, ss: string;
begin
  // Convert incoming data into a string
  s := StringOfChar( ' ', DataSize );
  move( DataPtr^, pchar(s)^, DataSize );
  // Exit if s is empty. This usually occurs when one or more NULL characters
  // (chr(0)) are received.

  while pos( #0, s ) > 0 do
    delete( s, pos( #0, s ), 1 );
  if s = '' then
    exit;

  // Remove line feeds from the string
  i := pos( #10, s );
  while i <> 0 do
  begin
    delete( s, i, 1 );
    i := pos( #10, s );
  end;
  // Remove carriage returns from the string (break lines)
  i := pos( #13, s );

  while i <> 0 do
  begin
    ss := copy( s, 1, i-1 );
    delete( s, 1, i );
    listbox1.items.Append( ss );
    i := pos( #13, s );
  end;
  listbox1.Items.append( s );

  // Auswertung der eingegangenen Daten
	for i:=0 to listbox1.Items.Count-1 do
  begin
  	if copy(listbox1.Items[0],0,2)='n:' then beschreibung.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='v:' then version.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='d:' then datum.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='t:' then typ.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='c:' then hardware.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='q:' then frequenz.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0]))+' MHz' else
	  if copy(listbox1.Items[0],0,2)='r:' then uebertragungsrate.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0]))+' kBit/s' else
	  if copy(listbox1.Items[0],0,2)='a:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then begin adresse.Caption:=inttostr(Ord(s[1]))+copy(listbox1.Items[0],4,length(listbox1.Items[0])); scrollbar9.Position:=Ord(s[1])-1; end else adresse.caption:='?' end else
	  if copy(listbox1.Items[0],0,2)='k:' then dimmkurve.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0])) else
	  if copy(listbox1.Items[0],0,2)='z:' then begin if copy(listbox1.Items[0],3,length(listbox1.Items[0]))='OK' then	begin zerocrossing.Font.Color:=clGreen;	zerocrossing.Caption:='SYNCHRONIZED'; end	else if copy(listbox1.Items[0],3,length(listbox1.Items[0]))='SY' then	begin zerocrossing.Font.Color:=clRed; zerocrossing.Caption:='TRY TO FIND SYNC'; end else if copy(listbox1.Items[0],3,length(listbox1.Items[0]))='NA' then begin zerocrossing.Font.Color:=clGray; zerocrossing.Caption:='NO ZC DEVICE INSTALLED'; end else begin zerocrossing.Font.Color:=clRed;	zerocrossing.caption:='ERROR!'; end; end else
	  if copy(listbox1.Items[0],0,2)='f:' then sinusfrequenz.Caption:=copy(listbox1.Items[0],3,length(listbox1.Items[0]))+' Hz' else
	  if copy(listbox1.Items[0],0,2)='1:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal1.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal1.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='2:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal2.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal2.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='3:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal3.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal3.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='4:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal4.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal4.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='5:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal5.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal5.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='6:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal6.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal6.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='7:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal7.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal7.Caption:='err%' end else
	  if copy(listbox1.Items[0],0,2)='8:' then begin s:=copy(listbox1.Items[0],3,1); if s<>'' then kanal8.Caption:=inttostr(round((250-Ord(s[1])) / 250 * 100))+'%' else kanal8.Caption:='err%' end;
    listbox1.Items.Delete(0);
  end;
end;

procedure TForm1.baudratechangeChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  baudrate:=strtoint(baudratechange.Items[baudratechange.Itemindex]);
  comport.Disconnect;
  comport.BaudRateValue:=baudrate;
  comport.Connect;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER Diagnoseprogramm') then
        LReg.CreateKey('PC_DIMMER Diagnoseprogramm');
      if LReg.OpenKey('PC_DIMMER Diagnoseprogramm',true) then
      begin
        LReg.WriteInteger('Baudrate',baudrate);
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TForm1.FormCreate(Sender: TObject);
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
  serialport, regbaudrate:integer;
  TestHandle, i : integer;
begin
  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

  // enumerate all serial devices (COM port devices)
    SerialGUID := GUID_DEVINTERFACE_COMPORT;
  // SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
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

  {
  // COM-Ports von 1 bis 16 abklappern
	portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    portchange.Items.Add('COM '+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
  }

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_LOCAL_MACHINE;

  serialport:=2;
  regbaudrate:=115200;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER Diagnoseprogramm') then
        LReg.CreateKey('PC_DIMMER Diagnoseprogramm');
      if LReg.OpenKey('PC_DIMMER Diagnoseprogramm',true) then
      begin
        if not LReg.ValueExists('COMPort') then
          LReg.WriteInteger('COMPort',2);
        serialport:=LReg.ReadInteger('COMPort');
        if not LReg.ValueExists('Baudrate') then
          LReg.WriteInteger('Baudrate',115200);
        regbaudrate:=LReg.ReadInteger('Baudrate');
      end;
    end;
  end;
  LReg.CloseKey;

  ActivateCOMPort(serialport);
  portchange.Visible:=(portchange.Items.Count>0);
  portchangeSelect(Sender);
  
{
  portchange.ItemIndex:=0;
  for i:=1 to 16 do
    if ('COM '+inttostr(serialport))=portchange.Items[i-1] then
      portchange.ItemIndex:=i-1;

  if portchange.Items.Count > 0 then
  begin
    portchangeChange(Sender);
    portchange.Visible:=true;
  end else
    portchange.Visible:=false;
}

  case regbaudrate of
    115200: baudratechange.ItemIndex:=0;
    57600: baudratechange.ItemIndex:=1;
    38400: baudratechange.ItemIndex:=2;
    9600: baudratechange.ItemIndex:=3;
  else
    baudratechange.ItemIndex:=0;
  end;
  baudratechangeChange(Sender);
end;

procedure TForm1.ScrollBar9Change(Sender: TObject);
var
	i:integer;
begin
  Label31.Caption:='Gerät '+inttostr(scrollbar9.Position+1);
  Label42.caption:='Gerät '+inttostr(scrollbar9.Position+1)+' ändern';
	device:=scrollbar9.Position*8;

  for i:=1 to 8 do
  begin
    if i+device<=128 then
    begin
    	TLabel(FindComponent('Label'+inttostr(i))).Caption:='Kanal '+inttostr(i+(device));
  		TLabel(FindComponent('Label'+inttostr(32+i))).Caption:='Kanal '+inttostr(i+(device));
    end else
    begin
    	TLabel(FindComponent('Label'+inttostr(i))).Caption:='-';
			TLabel(FindComponent('Label'+inttostr(32+i))).Caption:='-';
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
	rs232frame:array[0..5] of byte;
begin
	rs232frame[0]:=127+((device+1));
	rs232frame[1]:=4; //0b00000100
	rs232frame[2]:=0;
	rs232frame[3]:=0;
	rs232frame[4]:=0;
	rs232frame[5]:=0;
  comport.SendData(@rs232frame,6);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
	rs232frame:array[0..5] of byte;
begin
	rs232frame[0]:=127+((device+1));
	rs232frame[1]:=8; //0b00001000
	rs232frame[2]:=0;
	rs232frame[3]:=0;
	rs232frame[4]:=0;
	rs232frame[5]:=0;
  comport.SendData(@rs232frame,6);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
	rs232frame:array[0..5] of byte;
begin
	rs232frame[0]:=127+((device+1));
	rs232frame[1]:=16; // 0b00010000
	rs232frame[2]:=0;
	rs232frame[3]:=0;
	rs232frame[4]:=0;
	rs232frame[5]:=(strtoint(edit5.text)-1);
  comport.SendData(@rs232frame,6);
end;

procedure TForm1.Edit5Change(Sender: TObject);
begin
	if edit5.Text<>'' then
  begin
		if strtoint(edit5.Text)<1 then edit5.Text:='1';
		if strtoint(edit5.Text)>128 then edit5.Text:='128';
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
end;

procedure TForm1.portchangeDropDown(Sender: TObject);
begin
  portchange.Width:=289;
end;

procedure TForm1.portchangeCloseUp(Sender: TObject);
begin
  portchange.Width:=137;
end;

procedure TForm1.ActivateCOMPort(portnumber: integer);
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

procedure TForm1.portchangeSelect(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if portchange.Items.Count > 0 then
  begin
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    comport.Disconnect;
      case comportnumber of
        1: comport.port:=pnCOM1;   2: comport.port:=pnCOM2;
        3: comport.port:=pnCOM3;   4: comport.port:=pnCOM4;
        5: comport.port:=pnCOM5;   6: comport.port:=pnCOM6;
        7: comport.port:=pnCOM7;   8: comport.port:=pnCOM8;
        9: comport.port:=pnCOM9;   10: comport.port:=pnCOM10;
        11: comport.port:=pnCOM11;   12: comport.port:=pnCOM12;
        13: comport.port:=pnCOM13;   14: comport.port:=pnCOM14;
        15: comport.port:=pnCOM15;   16: comport.port:=pnCOM16;
      end;
    comport.Connect;

    LReg := TRegistry.Create;
    LReg.RootKey:=HKEY_LOCAL_MACHINE;

    if LReg.OpenKey('Software', True) then
    begin
      if not LReg.KeyExists('PHOENIXstudios') then
        LReg.CreateKey('PHOENIXstudios');
      if LReg.OpenKey('PHOENIXstudios',true) then
      begin
        if not LReg.KeyExists('PC_DIMMER Diagnoseprogramm') then
          LReg.CreateKey('PC_DIMMER Diagnoseprogramm');
        if LReg.OpenKey('PC_DIMMER Diagnoseprogramm',true) then
        begin
          LReg.WriteInteger('COMPort',comportnumber);
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;
end;

end.
