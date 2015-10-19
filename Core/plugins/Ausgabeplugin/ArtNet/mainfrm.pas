unit mainfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UdpSockUtil, WinSock, Mask, JvExMask, JvSpin,
  pngimage, JvExControls, NB30, Registry, XPMan, ComCtrls, Grids,
  JvToolEdit, JvCombobox, CHHighResTimer;

const
  MAX_HOSTNAME_LEN                = 128;
  MAX_DOMAIN_NAME_LEN             = 128;
  MAX_SCOPE_ID_LEN                = 256;
  MAX_ADAPTER_NAME                = 128;
  MAX_ADAPTER_DESCRIPTION_LENGTH  = 128;
  MAX_ADAPTER_NAME_LENGTH         = 256;
  MAX_ADAPTER_ADDRESS_LENGTH      = 8;

type
  // Prototypen für Callbackfunktionen (PC_DIMMER Plugin)
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  TBytes=array of Byte;
  PDMXArray = ^TDMXArray;
  TDMXArray = array of byte;

  // Prototypen für Callbackfunktion (Library)
  TReceiveDMXUniverse = procedure(ArtNETSubNet:integer; ArtNETUniverse:integer; Buffer: PDMXArray; Length:integer);stdcall;
  TReceiveSingleValue = procedure(ArtNETSubNet:integer; ArtNETUniverse:integer; Channel:integer; Value:integer);stdcall;

  PIP_ADAPTER_INFO = ^IP_ADAPTER_INFO;
  IP_ADAPTER_INFO = record
    Next        : PIP_ADAPTER_INFO;
    ComboIndex  : DWORD;
    AdapterName : array [1..MAX_ADAPTER_NAME_LENGTH+4] of Char ;
  end;

  Tmainform = class(TForm)
    udp: TUdpSockUtil;
    ViewTimer: TTimer;
    Timer1: TTimer;
    XPManifest1: TXPManifest;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    artnetstatus: TShape;
    Label17: TLabel;
    edipaddress: TEdit;
    edsubnetmask: TEdit;
    cbReceiverEnabled: TCheckBox;
    cbMAC: TComboBox;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    OutViewImage: TImage;
    cbViewSubnet: TComboBox;
    cbViewUniverse: TComboBox;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    lbArtNetNodes: TListBox;
    Button1: TButton;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblPolling: TLabel;
    lblDMX: TLabel;
    lblAddress: TLabel;
    lblInput: TLabel;
    Label10: TLabel;
    lblShortName: TLabel;
    Label12: TLabel;
    lblLongName: TLabel;
    lblsonstiges: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    lblLastSender: TLabel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    btnTestSendUniverse: TButton;
    cbTestSubnet: TComboBox;
    cbTestUniverse: TComboBox;
    edipaddressdestination: TEdit;
    Button3: TButton;
    Panel1: TPanel;
    Shape1: TShape;
    Image1: TImage;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Button5: TButton;
    lblLastOEM: TLabel;
    lblLastOEMProduct: TLabel;
    SendTimer: TCHHighResTimer;
    ScanTimer: TCHHighResTimer;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Image2: TImage;
    TabSheet5: TTabSheet;
    GroupBox7: TGroupBox;
    cbSendUniverse1: TCheckBox;
    cbSendUniverse2: TCheckBox;
    cbSendUniverse3: TCheckBox;
    cbSendUniverse4: TCheckBox;
    cbSendToSubNet1: TComboBox;
    cbSendToSubNet2: TComboBox;
    cbSendToSubNet3: TComboBox;
    cbSendToSubNet4: TComboBox;
    cbSendToUniverse1: TComboBox;
    cbSendToUniverse2: TComboBox;
    cbSendToUniverse3: TComboBox;
    cbSendToUniverse4: TComboBox;
    Label26: TLabel;
    Label27: TLabel;
    GroupBox8: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    cbReceiveUniverse1: TCheckBox;
    cbReceiveUniverse2: TCheckBox;
    cbReceiveUniverse3: TCheckBox;
    cbReceiveUniverse4: TCheckBox;
    cbReceiveFromSubNet1: TComboBox;
    cbReceiveFromSubNet2: TComboBox;
    cbReceiveFromSubNet3: TComboBox;
    cbReceiveFromSubNet4: TComboBox;
    cbReceiveFromUniverse1: TComboBox;
    cbReceiveFromUniverse2: TComboBox;
    cbReceiveFromUniverse3: TComboBox;
    cbReceiveFromUniverse4: TComboBox;
    GroupBox9: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    cbMergeUniverse1: TComboBox;
    cbMergeUniverse2: TComboBox;
    cbMergeUniverse3: TComboBox;
    cbMergeUniverse4: TComboBox;
    Label35: TLabel;
    cbMergeOn1: TComboBox;
    cbMergeOn2: TComboBox;
    cbMergeOn3: TComboBox;
    cbMergeOn4: TComboBox;
    TabSheet6: TTabSheet;
    GroupBox10: TGroupBox;
    errormemo: TMemo;
    Label36: TLabel;
    Image3: TImage;
    Label37: TLabel;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label20: TLabel;
    Label18: TLabel;
    cbArtNETSubnet: TComboBox;
    cbReceiveUniverse: TJvCheckedComboBox;
    cbSendUniverse: TJvCheckedComboBox;
    cbAllowAllUniverses: TCheckBox;
    cbSendUniversesRepeatingly: TCheckBox;
    cbLoopBack: TCheckBox;
    Label38: TLabel;
    Label39: TLabel;
    lblmyOEM: TLabel;
    Label30: TLabel;
    lblSetupLocalOrNetwork: TLabel;
    edremoteipaddress: TEdit;
    Label41: TLabel;
    Button8: TButton;
    Label40: TLabel;
    currentmaclbl: TLabel;
    procedure udpReceive(Sender: TObject);
    procedure ArtInit;
    procedure ArtShutdown;
    function GetMACAddress: string;
    function GetMACAddresses: TStringList;
    function GetLocalIPs:TStringList;
    function GetConnectionNameList : TStringList;
    procedure ArtPacketReceived(SourceIp: string; Buffer: array of char; Length: integer);
    procedure ArtOpPoll(SourceIp: string; Buffer: array of char; Length: integer);
    procedure ArtOpPollReceive(SourceIp: string; Buffer: array of char; Length: integer);
    procedure ArtSendOpPollReply(DestIp: string);
    procedure ArtSendOpPollRequest(DestIp: string);
    procedure ArtOpDmx(SourceIp: string; Buffer: array of char; Length: integer);
    procedure ArtOpAddress(SourceIp: string; Buffer: array of char; Length: integer);
    procedure ArtOpInput(SourceIp: string; Buffer: array of char; Length: integer);
    procedure SendArtPacket(DestIp: string; Buffer: array of char; Length: integer);
    procedure SendDMXUniverse(Destination:string; Subnet:byte; Universe: byte; DMXBuf: array of byte; Length: integer);
    procedure FormCreate(Sender: TObject);
    procedure btnTestSendUniverseClick(Sender: TObject);
    procedure cbReceiverEnabledMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ViewTimerTimer(Sender: TObject);
    procedure cbArtNETSubnetSelect(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbMACSelect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbReceiveUniverseChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetOEMName(OEMCode: word):string;
    function GetOEMProduct(OEMCode: word):string;
    procedure PageControl1Change(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure ScanTimerTimer(Sender: TObject);
    procedure cbSendUniverseChange(Sender: TObject);
    procedure SettingsChanged;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure CheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboboxSelect(Sender: TObject);
    procedure cbAllowAllUniversesMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure udpError(Sender: TObject; Error: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure edipaddressKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edsubnetmaskKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edremoteipaddressKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;

    ReceiveDMXUniverse:TReceiveDMXUniverse;
    ReceiveSingleValue:TReceiveSingleValue;

    issending:boolean;

    DMXInUniverseSpec:array[0..3] of array[0..511] of byte;
    DMXInUniverseSpec_old:array[0..3] of array[0..511] of byte;

    DMXInUniverse:array[0..15] of array[0..15] of array[0..511] of byte;
    DMXInUniverse_old:array[0..15] of array[0..15] of array[0..511] of byte;
    DMXInEnabled:array[0..15] of array[0..15] of boolean;

    DMXOutUniverseSpec:array[0..3] of array[0..511] of byte;
    DMXOutUniverseSpec_old:array[0..3] of array[0..511] of byte;

    DMXOutUniverse:array[0..15] of array[0..15] of array[0..511] of byte;
    DMXOutUniverse_old:array[0..15] of array[0..15] of array[0..511] of byte;
    DMXOutEnabled:array[0..15] of array[0..15] of boolean;

    ArtBroadcastIP: string;
    ArtOEMCode: word;// $0390 = Digital Enlightenment OEM Code
    ArtShortName: array[0..17] of char;
    ArtLongName: array[0..63] of char;
  end;

function GetAdaptersInfo(const pAdapterInfo : PIP_ADAPTER_INFO;const pOutBufLen : PULONG) : DWORD; stdcall;
     external 'IPHLPAPI.DLL' name 'GetAdaptersInfo';

resourcestring
  w2knetcard = 'SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}';

var
  mainform: Tmainform;

  //--- Artnet Variables:
  ArtProtokollVersion: word = 14;
  ArtDMXSequence: byte;
  ArtPollReply_OnChange: boolean;
  ArtPollReply_Broadcast: boolean;

  ArtLEDIndicator: byte; // 0 = Mute, 1 = Normal, 2 = Locate
  ArtEnableIn:array[0..3] of boolean;
  DMX_OutEnabled:array[0..3] of boolean;
  DMX_OutToSubNet:array[0..3] of byte;
  DMX_OutToUniverse:array[0..3] of byte;
  DMX_InEnabled:array[0..3] of boolean;
  DMX_InFromSubNet:array[0..3] of byte;
  DMX_InFromUniverse:array[0..3] of byte;
  ArtMergeMode:array[0..3] of byte; // 0=HTP, 1=LTP
  ArtMergeEnable:array[0..3] of byte; // 0=OFF, 1=ON

  ArtLastAddressNetProg: boolean; //true = Last Address programmed from Network
  ArtIP: string;
  ArtNetSubnet:byte;
  ArtLastOpPollIP: string;
  ArtSubnetmask: string;
  ArtMAC: string;
  ArtStatusCode: word;
  ArtPollReplyCounter: word;
  ArtInTimerCount: byte;
  ArtCustomIPBac: string;
  ArtCustomSubnetmaskBac: string;

  pollingpackages, dmxpackages, addresspackages, inputpackages, sonstigespackages:Cardinal; 
  LastSender:string;
  LastOem,LastOEMProduct:string;

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

// Netzwerkhilfsfunktionen ------------------------------
function Tmainform.GetMACAddress: string;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;

  RetCode: char;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
begin
  Result    := '';
  _SystemID := '';
  Getmem(NCB, SizeOf(TNCB));
  Fillchar(NCB^, SizeOf(TNCB), 0);

  Getmem(Lenum, SizeOf(TLanaEnum));
  Fillchar(Lenum^, SizeOf(TLanaEnum), 0);

  Getmem(Adapter, SizeOf(TAdapterStatus));
  Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);

  Lenum.Length    := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(Lenum);
  NCB.ncb_length  := SizeOf(Lenum);
  RetCode         := Netbios(NCB);

  i := 0;
  repeat
    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBRESET);

    Ncb.ncb_lana_num := lenum.lana[I];
    RetCode          := Netbios(Ncb);

    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBASTAT);
    Ncb.ncb_lana_num := lenum.lana[I];
    // Must be 16
    Ncb.ncb_callname := '*               ';

    Ncb.ncb_buffer := Pointer(Adapter);

    Ncb.ncb_length := SizeOf(TAdapterStatus);
    RetCode        := Netbios(Ncb);
    //---- calc _systemId from mac-address[2-5] XOR mac-address[1]...
    if (RetCode = chr(0)) or (RetCode = chr(6)) then
    begin
      _SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[1]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[2]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[3]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[4]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[5]), 2);
    end;
    Inc(i);
  until (I >= Ord(Lenum.Length)) or (_SystemID <> '00-00-00-00-00-00');
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
  GetMacAddress := _SystemID;
end;

function Tmainform.GetMACAddresses: TStringList;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;

  RetCode: char;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
begin
  result := TStringList.Create;
  result.Clear;

  _SystemID := '';
  Getmem(NCB, SizeOf(TNCB));
  Fillchar(NCB^, SizeOf(TNCB), 0);

  Getmem(Lenum, SizeOf(TLanaEnum));
  Fillchar(Lenum^, SizeOf(TLanaEnum), 0);

  Getmem(Adapter, SizeOf(TAdapterStatus));
  Fillchar(Adapter^, SizeOf(TAdapterStatus), 0);

  Lenum.Length    := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(Lenum);
  NCB.ncb_length  := SizeOf(Lenum);
  RetCode         := Netbios(NCB);

  i := 0;
  repeat
    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBRESET);
    Ncb.ncb_lana_num := lenum.lana[I];
    RetCode          := Netbios(Ncb);

    Fillchar(NCB^, SizeOf(TNCB), 0);
    Ncb.ncb_command  := chr(NCBASTAT);
    Ncb.ncb_lana_num := lenum.lana[I];
    // Must be 16
    Ncb.ncb_callname := '*               ';

    Ncb.ncb_buffer := Pointer(Adapter);

    Ncb.ncb_length := SizeOf(TAdapterStatus);
    RetCode        := Netbios(Ncb);
    //---- calc _systemId from mac-address[2-5] XOR mac-address[1]...
    if (RetCode = chr(0)) or (RetCode = chr(6)) then
    begin
      _SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[1]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[2]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[3]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[4]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[5]), 2);
      if _SystemID <> '00:00:00:00:00:00' then result.Add(_SystemID);
    end;
    Inc(i);
  until (I >= Ord(Lenum.Length));
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
end;

function Tmainform.GetLocalIPs:TStringList;
type
  PPInAddr= ^PInAddr;
var
  wsaData: TWSAData;
  HostInfo: PHostEnt;
  HostName: Array[0..255] of Char;
  Addr: PPInAddr;
begin
  result := TStringList.Create;
  result.Clear;

  if WSAStartup($0102, wsaData)=0 then
  try
    if gethostname(HostName, SizeOf(HostName)) = 0 then
    begin
      HostInfo:= gethostbyname(HostName);
      if HostInfo<>nil then
      begin
        Addr:=Pointer(HostInfo^.h_addr_list);
        if (Addr<>nil) and (Addr^<>nil) then
        repeat
          result.Add(StrPas(inet_ntoa(Addr^^)));
          inc(Addr);
        until Addr^=nil;
      end;
    end;
  finally
    WSACleanup;
  end;
end;

function Tmainform.GetConnectionNameList : TStringList;
var
  pAdapterList : PIP_ADAPTER_INFO;
  dwLenAdapter : integer;
  reg          : TRegistry;
  I            : Integer;
  AdapterName  : string;
begin
  result := TStringList.Create;
  result.Clear;

  pAdapterList := nil;
  dwLenAdapter := 0;
  if GetAdaptersInfo(pAdapterList,@dwLenAdapter) <> ERROR_BUFFER_OVERFLOW then exit;
  pAdapterList := AllocMem(dwLenAdapter);
  if GetAdaptersInfo(pAdapterList,@dwLenAdapter) <> ERROR_SUCCESS then exit;
  repeat
    AdapterName := '';                 
    for I := 0 to Length(pAdapterList.AdapterName) - 1 do
      if pAdapterList.AdapterName[i] <> '' then
        AdapterName := AdapterName + pAdapterList.AdapterName[i];
    reg := TRegistry.Create();
    reg.RootKey := HKEY_LOCAL_MACHINE;
    try
      if reg.OpenKeyReadOnly(w2knetcard + '\' + AdapterName + '\Connection') then
        result.Add(reg.ReadString('Name'));
    finally
      reg.CloseKey;
      reg.Free;
    end;
    pAdapterList := pAdapterList.Next;
  until pAdapterList = nil;
end;

function IpstringToDword(ipstr: string): dword;
var
  a,b,c,d, tmp: string;
begin
  tmp := ipstr;
  a := copy(tmp, 1, (pos('.',tmp) -1));
  tmp := copy(tmp, (pos('.',tmp) + 1), (length(tmp) - pos('.',tmp) + 1));
  b := copy(tmp, 1, (pos('.',tmp) -1));
  tmp := copy(tmp, (pos('.',tmp) + 1), (length(tmp) - pos('.',tmp) + 1));
  c := copy(tmp, 1, (pos('.',tmp) -1));
  tmp := copy(tmp, (pos('.',tmp) + 1), (length(tmp) - pos('.',tmp) + 1));
  d := tmp;
  Result := (StrToInt(a) shl 24) or (StrToInt(b) shl 16) or (StrToInt(c) shl 8) or StrToInt(d);
end;
// Ende Netzwerkhilfsfunktionen

// Funktionen für ArtNET --------------------------------
procedure Tmainform.ArtInit;
begin
  ArtDMXSequence := 0;
  ArtPollReply_OnChange := false;
  ArtPollReply_Broadcast := true;
  ArtLastAddressNetProg := false;
  ArtLEDIndicator := 1;
  ArtInTimerCount := 0;

//  ArtOEMCode:= $00FF; // Vorläufig Produkt als Unregistriert anmelden
  ArtOEMCode:= $0890; // PHOENIXstudios Remsfeld OEM Code

  ArtStatusCode := $0001; //PowerUp OK
  ArtPollReplyCounter := $0;

  if ArtPollReply_Broadcast then
    ArtSendOpPollReply(ArtBroadcastIP)
  else
    ArtSendOpPollReply(ArtLastOpPollIP); //Power Up Reply
end;

procedure Tmainform.ArtShutdown;
begin
//
end;

procedure Tmainform.ArtPacketReceived(SourceIp: string; Buffer: array of char; Length: integer);
var
  opcode: word;
begin
{
  if (IpstringToDword(SourceIp) and IpstringToDword(ArtSubnetmask)) <> (IpstringToDword(ArtIP) and IpstringToDword(ArtSubnetmask)) then
  begin
    errormemo.Lines.Add(DateToStr(now)+', '+TimeToStr(now)+': SourceIP&ArtSubnetmask <> ArtIP&ArtSubnetmask');
    Exit;
  end;
}

  if Length < 10 then
  begin
    errormemo.Lines.Add(DateToStr(now)+', '+TimeToStr(now)+': Länge des UDP-Pakets <10 Byte');
    Exit;
  end;

  if not ((Buffer[0] = 'A') and (Buffer[1] = 'r') and (Buffer[2] = 't') and (Buffer[3] = '-') and (Buffer[4] = 'N') and (Buffer[5] = 'e') and (Buffer[6] = 't') and (Buffer[7] = chr(0))) then
  begin
    errormemo.Lines.Add(DateToStr(now)+', '+TimeToStr(now)+': Kein "Art-Net" im Header');
    Exit;
  end;
  opcode := (ord(Buffer[9]) shl 8) or ord(Buffer[8]);

  case opcode of
    $2000:
    begin
      // Eine Polling-Anfrage
      lastSender:=SourceIp;
      inc(pollingpackages);
      ArtOpPoll(SourceIp, Buffer, Length);
    end;
    $2100:
    begin
      // Antwort auf eine Polling-Anfrage
      lastSender:=SourceIp;
      ArtOpPollReceive(SourceIp, Buffer, Length);
    end;
    $5000:
    begin
      // Ein Universe wurde übertragen
      if ((IpstringToDword(SourceIp)=IpstringToDword(ArtIP))) and (not cbLoopBack.Checked) then exit; // Loopback vermeiden
      lastSender:=SourceIp;
      inc(dmxpackages);
      ArtOpDmx(SourceIp, Buffer, Length);
    end;
    $6000:
    begin
      // Remote programming Informationen
      lastSender:=SourceIp;
      inc(addresspackages);
      ArtOpAddress(SourceIp, Buffer, Length);
    end;
    $7000:
    begin
      // Ein-/Ausschalten von DMX-Inputs
      lastSender:=SourceIp;
      inc(inputpackages);
      ArtOpInput(SourceIp, Buffer, Length);
    end;
  else
    inc(sonstigespackages);
  end;
end;

// Dem Sender antworten (als Antwort auf das Polling)
procedure Tmainform.ArtOpPoll(SourceIp: string; Buffer: array of char; Length: integer);
begin
  if Length < 14 then Exit;
  if (Ord(Buffer[12]) and $02) = $02 then ArtPollReply_OnChange := true else ArtPollReply_OnChange := false; // Jedesmal ein PollReply senden, wenn sich was am Node tut
  if (Ord(Buffer[12]) and $01) = $01 then ArtPollReply_Broadcast := false else ArtPollReply_Broadcast := true; // Zukünftig nur noch an Sender antworten

  ArtLastOpPollIP := SourceIp;
  if ArtPollReply_Broadcast then
    ArtSendOpPollReply(ArtBroadcastIP)
  else
    ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure Tmainform.ArtOpPollReceive(SourceIp: string; Buffer: array of char; Length: integer);
var
  i:integer;
  ShortName:string;
  text:string;
begin
  if Length < 239 then Exit;

  ShortName:='';
  for i := 0 to 17 do
  begin
    if Buffer[26+i]<>'' then
      ShortName:=ShortName+Buffer[26+i];
  end;
  ShortName:=ShortName+' ('+inttostr(Byte(Buffer[173]))+' Ports)';

  LastOEM:=GetOEMName(strtoint('$'+inttohex(ord(Buffer[20]),2)+inttohex(ord(Buffer[21]),2)));
  LastOEMProduct:=GetOEMProduct(strtoint('$'+inttohex(ord(Buffer[20]),2)+inttohex(ord(Buffer[21]),2)));

  text:=ShortName+' ('+SourceIp+')';

  if pos(text,lbArtNetNodes.Items.Text)=0 then
  begin
    lbArtNetNodes.Items.Add(text);
  end;
end;

procedure Tmainform.ArtSendOpPollReply(DestIp: string);
var
  Buffer: array[0..238] of char;
  tmp, i: dword;
begin
  Buffer[0] := 'A'; //ID
  Buffer[1] := 'r';
  Buffer[2] := 't';
  Buffer[3] := '-';
  Buffer[4] := 'N';
  Buffer[5] := 'e';
  Buffer[6] := 't';
  Buffer[7] := chr(0);
  Buffer[8] := chr($00); //OpCode
  Buffer[9] := chr($21);
  tmp := IpstringToDword(ArtIP);
  Buffer[10] := chr((tmp shr 24) and $FF); //ArtIP
  Buffer[11] := chr((tmp shr 16) and $FF);
  Buffer[12] := chr((tmp shr 8) and $FF);
  Buffer[13] := chr(tmp and $FF);
  Buffer[14] := chr($36); //ArtPort
  Buffer[15] := chr($19);
  Buffer[16] := chr($01); //Firmware Revision
  Buffer[17] := chr($00);
  Buffer[18] := chr($00); //Subnet Switch
  Buffer[19] := chr(ArtNetSubnet and $0F);
  Buffer[20] := chr((ArtOEMCode shr 8) and $FF); //OEM Code
  Buffer[21] := chr(ArtOEMCode and $FF);
  Buffer[22] := chr($00); //UBEA Version
  if ArtLastAddressNetProg then Buffer[23] := chr($20) else Buffer[23] := chr($10); //Status
  case (ArtLEDIndicator) of
    0: Buffer[23] := chr(ord(Buffer[23]) or $80); //Mute
    1: Buffer[23] := chr(ord(Buffer[23]) or $C0); //Normal
    2: Buffer[23] := chr(ord(Buffer[23]) or $40); //Locate
  end;
  Buffer[24] := 'P'; //Esta Man
  Buffer[25] := 'R';
  for i := 0 to 17 do Buffer[26+i] := ArtShortName[i]; //ShortName
  for i := 0 to 63 do Buffer[44+i] := ArtLongName[i]; //LongName
  Buffer[108] := chr((ArtStatusCode shr 8) and $FF); //NodeReport
  Buffer[109] := chr(ArtStatusCode and $FF);
  Buffer[110] := chr((ArtPollReplyCounter shr 8) and $FF);
  Buffer[111] := chr(ArtPollReplyCounter and $FF);
  inc(ArtPollReplyCounter);
  for i := 0 to 59 do Buffer[112+i] := chr(0);
  Buffer[172] := chr($00); //NumPorts
  Buffer[173] := chr($04);
  Buffer[174] := chr($C0); //PortTypes (C0=Senden und Empfangen)
  Buffer[175] := chr($C0);
  Buffer[176] := chr($C0);
  Buffer[177] := chr($C0);

  if cbAllowAllUniverses.Checked then
  begin
    // Inputs alle aktiviert
    Buffer[178] := chr($00);
    Buffer[178] := chr(ord(Buffer[178]) or $80);
    Buffer[179] := chr($00);
    Buffer[179] := chr(ord(Buffer[179]) or $80);
    Buffer[180] := chr($00);
    Buffer[180] := chr(ord(Buffer[180]) or $80);
    Buffer[181] := chr($00);
    Buffer[181] := chr(ord(Buffer[181]) or $80);

    // Alle Outputs aktiviert
    Buffer[182] := chr($80);
    Buffer[183] := chr($80);
    Buffer[184] := chr($80);
    Buffer[185] := chr($80);
    Buffer[182] := chr(ord(Buffer[182]) or $02);
    Buffer[183] := chr(ord(Buffer[183]) or $02);
    Buffer[184] := chr(ord(Buffer[184]) or $02);
    Buffer[185] := chr(ord(Buffer[185]) or $02);

    // Auf Welchen Subnets/Universes liegen Ein- und Ausgänge
    Buffer[186] := chr(((ArtNetSubnet shl 4) and $0F) or (0 and $0F)); //Swin
    Buffer[187] := chr(((ArtNetSubnet shl 4) and $0F) or (1 and $0F));
    Buffer[188] := chr(((ArtNetSubnet shl 4) and $0F) or (2 and $0F));
    Buffer[189] := chr(((ArtNetSubnet shl 4) and $0F) or (3 and $0F));
    Buffer[190] := chr(((ArtNetSubnet shl 4) and $0F) or (0 and $0F)); //Swout
    Buffer[191] := chr(((ArtNetSubnet shl 4) and $0F) or (1 and $0F));
    Buffer[192] := chr(((ArtNetSubnet shl 4) and $0F) or (2 and $0F));
    Buffer[193] := chr(((ArtNetSubnet shl 4) and $0F) or (3 and $0F));
  end else
  begin
    if not ArtEnableIn[0] then Buffer[178] := chr($08) else Buffer[178] := chr($00); //GoodInput
    if DMX_InEnabled[0] then Buffer[178] := chr(ord(Buffer[178]) or $80);
    if not ArtEnableIn[1] then Buffer[179] := chr($08) else Buffer[179] := chr($00);
    if DMX_InEnabled[1] then Buffer[179] := chr(ord(Buffer[179]) or $80);
    if not ArtEnableIn[2] then Buffer[180] := chr($08) else Buffer[180] := chr($00);
    if DMX_InEnabled[2] then Buffer[180] := chr(ord(Buffer[180]) or $80);
    if not ArtEnableIn[3] then Buffer[181] := chr($08) else Buffer[181] := chr($00);
    if DMX_InEnabled[3] then Buffer[181] := chr(ord(Buffer[181]) or $80);

    if DMX_OutEnabled[0] then Buffer[182] := chr($80) else Buffer[182] := chr($00); //GoodOutput
    if DMX_OutEnabled[1] then Buffer[183] := chr($80) else Buffer[183] := chr($00);
    if DMX_OutEnabled[2] then Buffer[184] := chr($80) else Buffer[184] := chr($00);
    if DMX_OutEnabled[3] then Buffer[185] := chr($80) else Buffer[185] := chr($00);
    if ArtMergeEnable[0] = 1 then Buffer[182] := chr(ord(Buffer[182]) or $08);
    if ArtMergeMode[0] = 1 then Buffer[182] := chr(ord(Buffer[182]) or $02);
    if ArtMergeEnable[1] = 1 then Buffer[183] := chr(ord(Buffer[183]) or $08);
    if ArtMergeMode[1] = 1 then Buffer[183] := chr(ord(Buffer[183]) or $02);
    if ArtMergeEnable[2] = 1 then Buffer[184] := chr(ord(Buffer[184]) or $08);
    if ArtMergeMode[2] = 1 then Buffer[184] := chr(ord(Buffer[184]) or $02);
    if ArtMergeEnable[3] = 1 then Buffer[185] := chr(ord(Buffer[185]) or $08);
    if ArtMergeMode[3] = 1 then Buffer[185] := chr(ord(Buffer[185]) or $02);
  end;

  Buffer[186] := chr(((DMX_InFromSubNet[0] shl 4) and $0F) or (DMX_InFromUniverse[0] and $0F)); //Swin
  Buffer[187] := chr(((DMX_InFromSubNet[1] shl 4) and $0F) or (DMX_InFromUniverse[1] and $0F));
  Buffer[188] := chr(((DMX_InFromSubNet[2] shl 4) and $0F) or (DMX_InFromUniverse[2] and $0F));
  Buffer[189] := chr(((DMX_InFromSubNet[3] shl 4) and $0F) or (DMX_InFromUniverse[3] and $0F));
  Buffer[190] := chr(((DMX_OutToSubNet[0] shl 4) and $0F) or (DMX_OutToUniverse[0] and $0F)); //Swout
  Buffer[191] := chr(((DMX_OutToSubNet[1] shl 4) and $0F) or (DMX_OutToUniverse[1] and $0F));
  Buffer[192] := chr(((DMX_OutToSubNet[2] shl 4) and $0F) or (DMX_OutToUniverse[2] and $0F));
  Buffer[193] := chr(((DMX_OutToSubNet[3] shl 4) and $0F) or (DMX_OutToUniverse[3] and $0F));

  Buffer[194] := chr($00); //SwVideo
  Buffer[195] := chr($00); //SwMacro
  Buffer[196] := chr($00); //SwRemote
  Buffer[197] := chr($00); //Spare
  Buffer[198] := chr($00); //Spare
  Buffer[199] := chr($00); //Spare
  Buffer[200] := chr($00); //Stype = Node
  Buffer[201] := chr(StrToInt('$' + Copy(ArtMAC, 1, 2))); //MAC
  Buffer[202] := chr(StrToInt('$' + Copy(ArtMAC, 4, 2)));
  Buffer[203] := chr(StrToInt('$' + Copy(ArtMAC, 7, 2)));
  Buffer[204] := chr(StrToInt('$' + Copy(ArtMAC, 10, 2)));
  Buffer[205] := chr(StrToInt('$' + Copy(ArtMAC, 13, 2)));
  Buffer[206] := chr(StrToInt('$' + Copy(ArtMAC, 16, 2)));
  for i := 0 to 31 do Buffer[207+i] := chr($00); //Filler
  SendArtPacket(DestIp, Buffer, sizeof(Buffer));
end;

procedure Tmainform.ArtSendOpPollRequest(DestIp: string);
var
  Buffer: array[0..238] of char;
begin
  Buffer[0] := 'A'; //ID
  Buffer[1] := 'r';
  Buffer[2] := 't';
  Buffer[3] := '-';
  Buffer[4] := 'N';
  Buffer[5] := 'e';
  Buffer[6] := 't';
  Buffer[7] := chr(0);
  Buffer[8] := chr($00); //OpCode
  Buffer[9] := chr($20);
  Buffer[10] := chr((ArtProtokollVersion shr 8) and $FF); //Protokoll Version
  Buffer[11] := chr(ArtProtokollVersion and $FF);
  Buffer[12] := chr($01); //Sequence
  Buffer[12] := chr(ord(Buffer[23]) or $80);
  SendArtPacket(DestIp, Buffer, sizeof(Buffer));
end;

// Empfang der DMX-Werte
procedure Tmainform.ArtOpDmx(SourceIp: string; Buffer: array of char; Length: integer);
var
  dmxbuflength: word;
  ArtNETSubNet, ArtNETUniverse:integer;
  i:integer;
begin
  if Length < 19 then Exit;

  ArtNETSubNet:=Byte((ord(Buffer[14]) shr 4) and $0F);
  ArtNETUniverse:=Byte((ord(Buffer[14]) and $0F));

  if cbAllowAllUniverses.Checked then
  begin
    if not DMXInEnabled[ArtNETSubNet][ArtNETUniverse] then
      exit;
  end;
  
  dmxbuflength := ((ord(Buffer[16]) shl 8) and $FF00) or (ord(Buffer[17]) and $FF);

  if Length >= (dmxbuflength + 18) then
  begin
//    ArtSourceIP := IpstringToDword(SourceIP);

    // Universe in entsprechendes Array verschieben: DMXInUniverse[SubNET][Universe][Channel]
    if cbAllowAllUniverses.Checked then
    begin
      Move(Buffer[18], DMXInUniverse[ArtNETSubNet][ArtNETUniverse], dmxbuflength);

      ScanTimer.enabled:=true;
    end else
    begin
      for i:=0 to 3 do
      begin
        if (DMX_InEnabled[i]) and (DMX_InFromSubNet[i]=ArtNETSubNet) and (DMX_InFromUniverse[i]=ArtNETUniverse) then
        begin
          Move(Buffer[18], DMXInUniverseSpec[i], dmxbuflength);
          ScanTimer.enabled:=true;
        end;
      end;
    end;

    if ArtPollReply_OnChange then
    begin
      if ArtPollReply_Broadcast then
        ArtSendOpPollReply(ArtBroadcastIP)
      else
        ArtSendOpPollReply(ArtLastOpPollIP);
    end;
  end;
end;

procedure Tmainform.ArtOpAddress(SourceIp: string; Buffer: array of char; Length: integer);
var
  i: word;
begin
  if Length < 107 then Exit;
  if ord(Buffer[14]) <> 0 then for i := 0 to 17 do ArtShortName[i] := Buffer[14+i];
  if ord(Buffer[32]) <> 0 then for i := 0 to 63 do ArtLongName[i] := Buffer[32+i];

  if ord(Buffer[96]) = $00 then DMX_InFromUniverse[0] := cbReceiveFromUniverse1.ItemIndex;
  if (ord(Buffer[96]) and $80) = $80 then DMX_InFromUniverse[0] := ord(Buffer[96]) and $0F;
  if ord(Buffer[97]) = $00 then DMX_InFromUniverse[1] := cbReceiveFromUniverse2.ItemIndex;
  if (ord(Buffer[97]) and $80) = $80 then DMX_InFromUniverse[1] := ord(Buffer[97]) and $0F;
  if ord(Buffer[98]) = $00 then DMX_InFromUniverse[2] := cbReceiveFromUniverse3.ItemIndex;
  if (ord(Buffer[98]) and $80) = $80 then DMX_InFromUniverse[2] := ord(Buffer[98]) and $0F;
  if ord(Buffer[99]) = $00 then DMX_InFromUniverse[3] := cbReceiveFromUniverse4.ItemIndex;
  if (ord(Buffer[99]) and $80) = $80 then DMX_InFromUniverse[3] := ord(Buffer[99]) and $0F;

  if ord(Buffer[100]) = $00 then DMX_OutToUniverse[0] := cbSendToUniverse1.ItemIndex;
  if (ord(Buffer[100]) and $80) = $80 then DMX_OutToUniverse[0] := ord(Buffer[100]) and $0F;
  if ord(Buffer[101]) = $00 then DMX_OutToUniverse[1] := cbSendToUniverse2.ItemIndex;
  if (ord(Buffer[101]) and $80) = $80 then DMX_OutToUniverse[1] := ord(Buffer[101]) and $0F;
  if ord(Buffer[102]) = $00 then DMX_OutToUniverse[2] := cbSendToUniverse3.ItemIndex;
  if (ord(Buffer[102]) and $80) = $80 then DMX_OutToUniverse[2] := ord(Buffer[102]) and $0F;
  if ord(Buffer[103]) = $00 then DMX_OutToUniverse[3] := cbSendToUniverse4.ItemIndex;
  if (ord(Buffer[103]) and $80) = $80 then DMX_OutToUniverse[3] := ord(Buffer[103]) and $0F;

  if ord(Buffer[104]) = $00 then
  begin
    ArtNetSubnet := cbArtNETSubnet.ItemIndex;
    DMX_OutToSubNet[0]:=cbSendToSubNet1.ItemIndex;
    DMX_OutToSubNet[1]:=cbSendToSubNet2.ItemIndex;
    DMX_OutToSubNet[2]:=cbSendToSubNet3.ItemIndex;
    DMX_OutToSubNet[3]:=cbSendToSubNet4.ItemIndex;
    DMX_InFromSubNet[0]:=cbReceiveFromSubNet1.ItemIndex;
    DMX_InFromSubNet[1]:=cbReceiveFromSubNet2.ItemIndex;
    DMX_InFromSubNet[2]:=cbReceiveFromSubNet3.ItemIndex;
    DMX_InFromSubNet[3]:=cbReceiveFromSubNet4.ItemIndex;
  end;

  if (ord(Buffer[104]) and $80) = $80 then
  begin
    ArtNetSubnet := ord(Buffer[104]) and $0F;
    DMX_OutToSubNet[0]:=ArtNetSubnet;
    DMX_OutToSubNet[1]:=ArtNetSubnet;
    DMX_OutToSubNet[2]:=ArtNetSubnet;
    DMX_OutToSubNet[3]:=ArtNetSubnet;
    DMX_InFromSubNet[0]:=ArtNetSubnet;
    DMX_InFromSubNet[1]:=ArtNetSubnet;
    DMX_InFromSubNet[2]:=ArtNetSubnet;
    DMX_InFromSubNet[3]:=ArtNetSubnet;
  end;

  if (DMX_InFromUniverse[0] = cbReceiveFromUniverse1.ItemIndex) and
     (DMX_InFromUniverse[1] = cbReceiveFromUniverse2.ItemIndex) and
     (DMX_InFromUniverse[2] = cbReceiveFromUniverse3.ItemIndex) and
     (DMX_InFromUniverse[3] = cbReceiveFromUniverse4.ItemIndex) and
     (DMX_OutToUniverse[0] = cbSendToUniverse1.ItemIndex) and
     (DMX_OutToUniverse[1] = cbSendToUniverse2.ItemIndex) and
     (DMX_OutToUniverse[2] = cbSendToUniverse3.ItemIndex) and
     (DMX_OutToUniverse[3] = cbSendToUniverse4.ItemIndex) and
     (ArtNetSubnet = cbArtNETSubnet.ItemIndex) then
    ArtLastAddressNetProg := false
  else
    ArtLastAddressNetProg := true;


  if ord(Buffer[106]) = $01 then
  begin
    ArtMergeEnable[0] := 0;
    ArtMergeEnable[1] := 0;
    ArtMergeEnable[2] := 0;
    ArtMergeEnable[3] := 0;
{
    ArtMergeIP1_A := 0;
    ArtMergeIP1_B := 0;
    ArtMergeIP2_A := 0;
    ArtMergeIP2_B := 0;
    ArtMergeIP3_A := 0;
    ArtMergeIP3_B := 0;
    ArtMergeIP4_A := 0;
    ArtMergeIP4_B := 0;
}
  end;

  if ord(Buffer[106]) = $02 then ArtLEDIndicator := 1;
  if ord(Buffer[106]) = $03 then ArtLEDIndicator := 0;
  if ord(Buffer[106]) = $04 then ArtLEDIndicator := 2;

  if ord(Buffer[106]) = $10 then ArtMergeMode[0] := 1;
  if ord(Buffer[106]) = $11 then ArtMergeMode[1] := 1;
  if ord(Buffer[106]) = $12 then ArtMergeMode[2] := 1;
  if ord(Buffer[106]) = $13 then ArtMergeMode[3] := 1;
  if ord(Buffer[106]) = $50 then ArtMergeMode[0] := 0;
  if ord(Buffer[106]) = $51 then ArtMergeMode[1] := 0;
  if ord(Buffer[106]) = $52 then ArtMergeMode[2] := 0;
  if ord(Buffer[106]) = $53 then ArtMergeMode[3] := 0;
{
  UpdateArtMergeIndicator;
  if ord(Buffer[106]) = $90 then DMXOutputSet(0, DMXBuf, 512);
  if ord(Buffer[106]) = $91 then DMXOutputSet(1, DMXBuf, 512);
  if ord(Buffer[106]) = $92 then DMXOutputSet(2, DMXBuf, 512);
  if ord(Buffer[106]) = $93 then DMXOutputSet(3, DMXBuf, 512);
}
  if ArtPollReply_Broadcast then
    ArtSendOpPollReply(ArtBroadcastIP)
  else
    ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure Tmainform.ArtOpInput(SourceIp: string; Buffer: array of char; Length: integer);
begin
  if Length < 20 then Exit;

  if ArtPollReply_OnChange then
  begin
    if ArtPollReply_Broadcast then
      ArtSendOpPollReply(ArtBroadcastIP)
    else
      ArtSendOpPollReply(ArtLastOpPollIP);
  end;
end;

procedure Tmainform.SendArtPacket(DestIp: string; Buffer: array of char; Length: integer);
begin
  if (Length > 0) and (Length <= 1500) then
  begin
//    if ArtMAC<>'00:00:00:00:00:00' then
    begin
      udp.RemoteHost:=DestIp;
      udp.RemotePort := 6454;
      udp.SendBuf(Buffer, Length);
    end;
  end;
end;

function Tmainform.GetOEMName(OEMCode: word):string;
begin
  case OEMCode of
    $0000: result:='Artistic License';
    $0001: result:='ADB';
    $0002: result:='MA Lighting';
    $0003: result:='Artistic License';
    $0004: result:='LewLight';
    $0005: result:='High End';
    $0006: result:='Avolites';
    $0010: result:='Artistic License';
    $0011: result:='Artistic License';
    $0014: result:='Artistic License';
    $0015: result:='Artistic License';
    $0030: result:='Doug Fleenor';
    $0031: result:='Doug Fleenor';
    $0050: result:='Goddard Design';
    $0051: result:='Goddard Design';
    $0070: result:='ADB';
    $0071: result:='ADB';

    $0072: result:='ADB';
    $0073..$007F: result:='ADB';
    $008C: result:='Zero 88';
    $008D: result:='Zero 88';
    $008E: result:='Flying Pig';
    $008F: result:='Flying Pig';
    $0090: result:='ELC';
    $0091: result:='ELC';
    $0092..$009F: result:='ELC';
    $0120: result:='Artistic License';
    $0180: result:='Martin';
    $0190..$019F: result:='Enttec';
    $01A0: result:='IES';
    $01A1: result:='IES';
    $01A2: result:='IES';
    $01A3..$01AF: result:='IES';
    $01B0: result:='EDI';
    $01C0: result:='Nondim Ent';
    $01D0: result:='Green Hippo';
    $01E0: result:='VNR';
    $01F0: result:='Robe';
    $01F1: result:='Robe';
    $0210: result:='Artistic License';
    $0211: result:='Artistic License';
    $0214: result:='Artistic License';
    $0215: result:='Artistic License';
    $0230: result:='Doug Fleenor';
    $0231: result:='Doug Fleenor';
    $0250: result:='Goddard Design';
    $0251: result:='Goddard Design';
    $0270: result:='ADB';
    $0271: result:='ADB';
    $0280: result:='LSC';
    $0281: result:='LSC';
    $0300: result:='Golden Stage';
    $0301: result:='Golden Stage';
    $0302: result:='Golden Stage';
    $0303: result:='Golden Stage';
    $0304: result:='Golden Stage';
    $0305: result:='Golden Stage';
    $0306: result:='Golden Stage';
    $0307: result:='Golden Stage';
    $0308: result:='Golden Stage';
    $0309..$030F: result:='Golden Stage';
    $0310: result:='Sunset Dynamics';
    $0320: result:='Luminex Light';
    $0321: result:='Luminex Light';
    $0330: result:='Invisible Rival';
    $0340: result:='Avolites';
    $0341: result:='Avolites';
    $0342: result:='Avolites';
    $0350: result:='Big Foot';
    $0351: result:='Big Foot';
    $0352: result:='Big Foot';

    $0360: result:='E:Cue';
    $0361: result:='E:Cue';
    $0362: result:='E:Cue';
    $0370: result:='Kiss Box';
    $0380: result:='Arkaos';
    $0390: result:='Digital Enlightenment';
    $03A0: result:='Des';
    $03B0: result:='Daslight';
    $03B1: result:='Daslight';
    $03C0: result:='HES';
    $03D0: result:='PixelMad';
    $03E0: result:='LeHigh';
    $03F0: result:='Horizon';
    $0400: result:='Audio Scene';
    $0401: result:='Audio Scene';
    $0410: result:='Pathport';
    $0411: result:='Pathport';
    $0412: result:='Pathport';
    $0413: result:='Pathport';
    $0420: result:='Botex';
    $0430: result:='Simon Newton';
    $0431: result:='Simon Newton';
    $0440: result:='XLNT';
    $0441: result:='XLNT';
    $0450: result:='Schnick-Schnak-Systems';
    $0460: result:='Dom Dv';
    $0470: result:='Sean Christopher';
    $0471: result:='Sean Christopher';
    $0472: result:='LSS Lighting';
    $0473: result:='LSS Lighting';
    $0490..$049F: result:='Open Clear';
    $04B0: result:='MA Lighting';
    $04B1: result:='MA Lighting';
    $04B2: result:='MA Lighting';
    $04B3: result:='MA Lighting';
    $04B4..$04BF: result:='MA Lighting';
    $04C0: result:='Inoage';
    $04D0: result:='Xilver';
    $04E0: result:='Wybron';
    $0890: result:='PHOENIXstudios Remsfeld';
    $8000: result:='ADB';
    $8001: result:='Artistic License';
    $8002: result:='Artistic License';
    $8003: result:='Artistic License';
    $00FF: result:='Unregistriert';
  else
    result:='Unknown vendor';
  end;
end;

function Tmainform.GetOEMProduct(OEMCode: word):string;
begin
  case OEMCode of
    $0000: result:='DMX-Hub';
    $0001: result:='Netgate';
    $0002: result:='DMX-Hub';
    $0003: result:='Ether-Lynx';
    $0004: result:='Capture v2';
    $0005: result:='TBA';
    $0006: result:='Art 2000';
    $0010: result:='Down-Link';
    $0011: result:='Up-Link';
    $0014: result:='Net-Link O/P';
    $0015: result:='Net-Link I/P';
    $0030: result:='TBA';
    $0031: result:='TBA';
    $0050: result:='DMX-Link (TM) O/P';
    $0051: result:='DMX-Link (TM) I/P';
    $0070: result:='Net-Port O/P';
    $0071: result:='Net-Port I/P';

    $0072: result:='WiFi Remote';
    $0073..$007F: result:='Reserved';
    $008C: result:='TBA';
    $008D: result:='TBA';
    $008E: result:='TBA';
    $008F: result:='TBA';
    $0090: result:='ELC 2';
    $0091: result:='ELC 4';
    $0092..$009F: result:='Reserved';
    $0120: result:='Pixi-Power F1a';
    $0180: result:='Maxxyz';
    $0190..$019F: result:='Reserved';
    $01A0: result:='PBX';
    $01A1: result:='Executive';
    $01A2: result:='Matrix';
    $01A3..$01AF: result:='Reserved';
    $01B0: result:='Edig';
    $01C0: result:='OpenLux';
    $01D0: result:='Hippotizer';
    $01E0: result:='Merger-Booster';
    $01F0: result:='ILE';
    $01F1: result:='ILE Controller';
    $0210: result:='Down-Lynx RDM';
    $0211: result:='Up-Lynx RDM';
    $0214: result:='Net-Lyny O/P RDM';
    $0215: result:='Net-Lynx I/P RDM';
    $0230: result:='TBA';
    $0231: result:='TBA';
    $0250: result:='DMX-Link (TM) O/P';
    $0251: result:='DMX-Link (TM) I/P';
    $0270: result:='Net-Port O/P';
    $0271: result:='Net-Port I/P';
    $0280: result:='Down-Lynx';
    $0281: result:='Up-Lynx';
    $0300: result:='DMX-net/O';
    $0301: result:='DMX-net/I';
    $0302: result:='TBA';
    $0303: result:='TBA';
    $0304: result:='GT-96';
    $0305: result:='Goldstage III';
    $0306: result:='TBA';
    $0307: result:='TBA';
    $0308: result:='KTG-5S';
    $0309..$030F: result:='Reserved';
    $0310: result:='Star Gate DMX';
    $0320: result:='DMX8';
    $0321: result:='DMX2';
    $0330: result:='Blue Hysteria';
    $0340: result:='Diamond 4 Vision';
    $0341: result:='Diamond 4 Elite';
    $0342: result:='Pearl Offline';
    $0350: result:='EtherMux Remote';
    $0351: result:='EtherMux Server';
    $0352: result:='EtherMux Desktop';

    $0360: result:='ELink512';
    $0361: result:='ELink1024';
    $0362: result:='ELink2048';
    $0370: result:='DMX Box 1';
    $0380: result:='VJD';
    $0390: result:='Show Gate';
    $03A0: result:='Neli 6/12/24';
    $03B0: result:='SunLight Easy';
    $03B1: result:='SunLight Magic 3D';
    $03C0: result:='Catalyst 1';
    $03D0: result:='PixelMad 1';
    $03E0: result:='Dx2';
    $03F0: result:='Horizon Controller';
    $0400: result:='Audio Scene O';
    $0401: result:='Audio Scene I';
    $0410: result:='Pathport 2 Out';
    $0411: result:='Pathport 2 In';
    $0412: result:='Pathport 1 Out';
    $0413: result:='Pathport 1 In';
    $0420: result:='Botex';
    $0430: result:='SN ArtNet Lib';
    $0431: result:='SN LLA Live';
    $0440: result:='DMX Input Node';
    $0441: result:='DMX Output Node';
    $0450: result:='SSS 4E';
    $0460: result:='Net DMX';
    $0470: result:='Projection Pal';
    $0471: result:='The Lighting Remote';
    $0472: result:='Master Gate';
    $0473: result:='Rail Controller';
    $0490..$049F: result:='Reserved';
    $04B0: result:='2 Port Node';
    $04B1: result:='Network Signal Processor';
    $04B2: result:='Network Dimmer Processor';
    $04B3: result:='Network Remote';
    $04B4..$04BF: result:='Reserved';
    $04C0: result:='Madrix 1';
    $04D0: result:='Controller';
    $04E0: result:='Ethernet PSU';
    $0890: result:='PC_DIMMER ShowGate';
    $8000: result:='Netgate XT';
    $8001: result:='Net-Patch';
    $8002: result:='DMX-Hub XT';
    $8003: result:='Four-Play';
    $00FF: result:='Unregistriert';
  else
    result:='Unknown product';
  end;
end;
// Ende Funktionen für ArtNET ------------------------------

procedure Tmainform.udpReceive(Sender: TObject);
var
  Buffer: array[0..1499] of char;
  NumberBytes:integer;
  Length: integer;
  Address:in_addr;
begin
  NumberBytes:=udp.ReceiveLength;

  if NumberBytes > 1500 then
    Length := 1500
  else
    Length := NumberBytes;

  if Length > 0 then
  begin
    udp.ReceiveBuf(Buffer, Length, Address);
    ArtPacketReceived(inet_ntoa(Address), Buffer, Length);
  end;
end;

procedure Tmainform.SendDMXUniverse(Destination:string; Subnet:byte; Universe: byte; DMXBuf: array of byte; Length: integer);
var
  Buffer: array[0..529] of char;
begin
  Buffer[0] := 'A'; //ID
  Buffer[1] := 'r';
  Buffer[2] := 't';
  Buffer[3] := '-';
  Buffer[4] := 'N';
  Buffer[5] := 'e';
  Buffer[6] := 't';
  Buffer[7] := chr(0);
  Buffer[8] := chr($00); //OpCode
  Buffer[9] := chr($50);
  Buffer[10] := chr((ArtProtokollVersion shr 8) and $FF); //Protokoll Version
  Buffer[11] := chr(ArtProtokollVersion and $FF);
  Buffer[12] := chr(ArtDMXSequence); //Sequence
  inc(ArtDMXSequence);
  Buffer[13] := chr(Universe); //Physical
  Buffer[14] := chr((Subnet shl 4) or Universe); //Universe
  Buffer[15] := chr($00);
  Buffer[16] := chr((Length shr 8) and $FF); //Length
  Buffer[17] := chr(Length and $FF);
  Move(DMXBuf, Buffer[18], Length); //Data
//  SendArtPacket(ArtBroadcastIP, Buffer, sizeof(Buffer));
  SendArtPacket(Destination, Buffer, sizeof(Buffer));
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  tmpd: dword;
  text:string;
  i:integer;
begin
  ArtSubnetmask:=edsubnetmask.Text;

  cbMAC.items.Clear;

  for i:=0 to GetLocalIPs.Count-1 do
  begin
//    text:=GetConnectionNameList.Strings[i]; // !!! GetConnectionNameList.Strings[i] NICHT synchron mit GetLocalIPs.Strings[i] oder GetMACAddresses.Strings[i] !!!

    text:=GetLocalIPs.Strings[i];

    if i<GetMACAddresses.Count then
      text:=text+', MAC: '+GetMACAddresses.Strings[i]+''
    else
      text:=text+', MAC: n/a';

    cbMAC.items.Add(text);
  end;

  if cbMAC.Items.Count>0 then
  begin
    cbMAC.itemindex:=0;

    if cbMAC.itemindex<GetLocalIPs.Count then
    begin
      edipaddress.Text:=GetLocalIPs.Strings[cbMAC.ItemIndex];
      ArtIP:=GetLocalIPs.Strings[cbMAC.ItemIndex];
    end else
    begin
      edipaddress.Text:='127.0.0.1';
      ArtIP:='127.0.0.1';
    end;

    if cbMAC.itemindex<GetMACAddresses.Count then
    begin
      ArtMAC:=GetMACAddresses.Strings[cbMAC.ItemIndex];
      currentmaclbl.caption:=ArtMAC;
    end else
    begin
      ArtMAC:='00:00:00:00:00:00';
      currentmaclbl.caption:=ArtMAC;
    end;
  end;

  OutViewImage.Canvas.MoveTo(0,0);
  OutViewImage.Canvas.Pen.Color := clwhite;
  OutViewImage.Canvas.LineTo(0,1);

  tmpd := (not IpstringToDword(ArtSubnetmask)) or (IpstringToDword(ArtSubnetmask) and IpstringToDword(ArtIP));
  ArtBroadcastIP := IntToStr((tmpd shr 24) and $FF) + '.' + IntToStr((tmpd shr 16) and $FF) + '.' + IntToStr((tmpd shr 8) and $FF) + '.' + IntToStr(tmpd and $FF);
  edremoteipaddress.Text:=ArtBroadcastIP;

  // ArtNet-Empfänger einschalten
  udp.Listen:=true;

  // Letzte Einstellungen aus Registry laden
  LoadSettings;

  // ArtNet initialisieren
  ArtInit;
end;

procedure Tmainform.btnTestSendUniverseClick(Sender: TObject);
var
  i:integer;
  DMXTestUniverse:array[0..511] of byte;
begin
  Randomize;
  for i:=0 to 511 do
    DMXTestUniverse[i]:=Random(256);
  SendDMXUniverse(edipaddressdestination.text, cbTestSubnet.itemindex, cbTestUniverse.itemindex, DMXTestUniverse, 512);
end;

procedure Tmainform.cbReceiverEnabledMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SettingsChanged;
end;

procedure Tmainform.ViewTimerTimer(Sender: TObject);
var
  i:integer;
begin
  for i := 0 to 511 do
  begin
    MainForm.OutViewImage.Canvas.MoveTo(i,OutViewImage.Height-1);
    MainForm.OutViewImage.Canvas.Pen.Color := clRed;

    if cbAllowAllUniverses.Checked then
      MainForm.OutViewImage.Canvas.LineTo(i,OutViewImage.Height - Round(DMXInUniverse[cbViewSubnet.ItemIndex][cbViewUniverse.ItemIndex][i]*(OutViewImage.Height-1)/255) - 1)
    else
      MainForm.OutViewImage.Canvas.LineTo(i,OutViewImage.Height - Round(DMXInUniverseSpec[cbViewUniverse.ItemIndex][i]*(OutViewImage.Height-1)/255) - 1);
    MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
    MainForm.OutViewImage.Canvas.LineTo(i,0);
  end;
end;

procedure Tmainform.cbArtNETSubnetSelect(Sender: TObject);
var
  i:integer;
  text1,text2:string;
begin
  ArtNetSubnet:=cbArtNETSubnet.itemindex;

  text1:='';
  text2:='';
  for i:=0 to 15 do
  begin
    if DMXInEnabled[cbArtNETSubnet.ItemIndex][i] then
    begin
      cbReceiveUniverse.State[i]:=cbChecked;
      text1:=text1+inttostr(i)+',';
    end else
    begin
      cbReceiveUniverse.State[i]:=cbUnChecked;
    end;

    if DMXOutEnabled[cbArtNETSubnet.ItemIndex][i] then
    begin
      cbSendUniverse.State[i]:=cbChecked;
      text2:=text2+inttostr(i)+',';
    end else
    begin
      cbSendUniverse.State[i]:=cbUnChecked;
    end;
  end;
  cbReceiveUniverse.Text:=copy(text1,0,length(text1)-1);
  cbSendUniverse.Text:=copy(text2,0,length(text2)-1);
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
begin
  lblPolling.Caption:=inttostr(pollingpackages);
  lblDMX.Caption:=inttostr(dmxpackages);
  lblAddress.Caption:=inttostr(addresspackages);
  lblInput.Caption:=inttostr(inputpackages);
  lblsonstiges.caption:=inttostr(sonstigespackages);
  lblLastSender.Caption:=LastSender;
  lblLastOEM.Caption:=LastOEM;
  lblLastOEMProduct.Caption:=LastOEMProduct;
  lblmyOEM.caption:=GetOEMName(ArtOEMCode);

  if ArtLastAddressNetProg then
  begin
    lblSetupLocalOrNetwork.Caption:='netzwerkprogrammiert';
    lblSetupLocalOrNetwork.Font.Color:=clRed;
  end else
  begin
    lblSetupLocalOrNetwork.Caption:='lokal eingestellt';
    lblSetupLocalOrNetwork.Font.Color:=clGreen;
  end;

  lblShortName.caption:=ArtShortName;
  lblLongName.Caption:=ArtLongName;

  case ArtLEDIndicator of
    0:
    begin
      artnetstatus.Brush.Color:=clBlack;
      artnetstatus.Hint:='Mute';
    end;
    1:
    begin
      artnetstatus.Brush.Color:=clLime;
      artnetstatus.Hint:='Normal';
    end;
    2:
    begin
      artnetstatus.Brush.Color:=clRed;
      artnetstatus.Hint:='Locate';
    end;
  end;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  lbArtNetNodes.Items.Clear;
  ArtSendOpPollRequest('255.255.255.255');
end;

procedure Tmainform.cbMACSelect(Sender: TObject);
begin
  if cbMAC.itemindex<GetLocalIPs.Count then
  begin
    edipaddress.Text:=GetLocalIPs.Strings[cbMAC.ItemIndex];
    ArtIP:=GetLocalIPs.Strings[cbMAC.ItemIndex];
  end else
  begin
    edipaddress.Text:='127.0.0.1';
    ArtIP:='127.0.0.1';
  end;

  if cbMAC.itemindex<GetMACAddresses.Count then
  begin
    ArtMAC:=GetMACAddresses.Strings[cbMAC.ItemIndex];
    currentmaclbl.caption:=ArtMAC;
  end else
  begin
    ArtMAC:='00:00:00:00:00:00';
    currentmaclbl.caption:=ArtMAC;
  end;
end;

procedure Tmainform.Button2Click(Sender: TObject);
var
  A,B,C,D,N,M,X,Y,Z:byte;
  MACAddress:string;
begin
  MACAddress:=GetMACAddresses.Strings[cbMAC.ItemIndex];

  N:=ArtOEMCode shr 8;
  M:=ArtOEMCode;

  X:=strtoint('$'+copy(MACAddress, length(MACAddress)-1,2));
  Y:=strtoint('$'+copy(MACAddress, length(MACAddress)-4,2));
  Z:=strtoint('$'+copy(MACAddress, length(MACAddress)-7,2));

  A:=2;
  B:=X+N+M;
  C:=Y;
  D:=Z;

  ShowMessage('Gültige ArtNET IP-Adressen sind:'+#13#10#13#10+
              'Primärnetz: '+inttostr(A)+'.'+inttostr(B)+'.'+inttostr(C)+'.'+inttostr(D)+#13#10+
              'Sekundärnetz: '+inttostr(10)+'.'+inttostr(B)+'.'+inttostr(C)+'.'+inttostr(D)+#13#10+
              'Custom: '+GetLocalIPs.Strings[cbMAC.ItemIndex]+#13#10#13#10+
              'Die Adressen für Primär- und Sekundärnetz halten sich an die'+#13#10+
              'Spezifikationen nach Rev 1.4 des Art-Net Standards und bilden'+#13#10+
              'sich aus der MAC-Adresse des aktiven Netzwerkadapters.');
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  ShowMessage('Verwenden Sie 255.255.255.255 als Zieladresse zum Broadcasten des Universe an alle Netzwerkgeräte...');
end;

procedure Tmainform.cbReceiveUniverseChange(Sender: TObject);
var
  i:integer;
begin
  if Sender=cbReceiveUniverse then
  for i:=0 to 15 do
  begin
    DMXInEnabled[cbArtNETSubnet.ItemIndex][i]:=cbReceiveUniverse.Checked[i];
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  cbArtNETSubnetSelect(nil);
  Timer1Timer(nil);
  Timer1.Enabled:=true;

  if errormemo.Lines.Count>0 then
    PageControl1.ActivePageIndex:=4;
end;

Function GetFileVersionBuild(Const FileName: String): String;
  Var i, W: LongWord;
    P: Pointer;
    FI: PVSFixedFileInfo;
    version,zusatz,text,text2:string;
  Begin
    version := 'NoVersionInfo';
    i := GetFileVersionInfoSize(PChar(FileName), W);
    If i = 0 Then Exit;
    GetMem(P, i);
    Try
      If not GetFileVersionInfo(PChar(FileName), W, i, P)
        or not VerQueryValue(P, '\', Pointer(FI), W) Then Exit;
      version := IntToStr(FI^.dwFileVersionMS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionMS and $FFFF)
        + '.' + IntToStr(FI^.dwFileVersionLS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionLS and $FFFF);
      If FI^.dwFileFlags and VS_FF_DEBUG        <> 0 Then zusatz := ' Debug';
      If FI^.dwFileFlags and VS_FF_PRERELEASE   <> 0 Then zusatz := ' Beta';
      If FI^.dwFileFlags and VS_FF_PRIVATEBUILD <> 0 Then zusatz := ' Private';
      If FI^.dwFileFlags and VS_FF_SPECIALBUILD <> 0 Then zusatz := ' Special';
    Finally
      FreeMem(P);
    End;

    text:=version; //4.0.0.0
    text2:=copy(text,0,pos('.',text)); // 4.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)); // 4.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)-1); // 4.0.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0

    result:='Version '+text2+' Build '+text+' '+zusatz;
End;

procedure Tmainform.PageControl1Change(Sender: TObject);
var
  i,last:integer;
begin
  ViewTimer.enabled:=PageControl1.ActivePageIndex=2;

  if PageControl1.ActivePageIndex=2 then
  begin
    cbViewSubNet.Enabled:=cbAllowAllUniverses.Checked;
    last:=cbViewUniverse.ItemIndex;
    cbViewUniverse.Items.Clear;

    Label38.visible:=not cbLoopback.Checked;

    if cbAllowAllUniverses.Checked then
    begin
      for i:=0 to 15 do
        cbViewUniverse.Items.Add(inttostr(i));
    end else
    begin
      for i:=0 to 3 do
        cbViewUniverse.Items.Add(inttostr(i));
    end;

    if last<cbViewUniverse.Items.Count then
      cbViewUniverse.ItemIndex:=last
    else
      cbViewUniverse.ItemIndex:=0;
  end;

  if PageControl1.ActivePageIndex=PageControl1.PageCount-1 then
  begin
    label25.Caption:=GetFileVersionBuild(GetModulePath);
  end;
end;

procedure Tmainform.FormHide(Sender: TObject);
begin
  Timer1.Enabled:=false;
  ViewTimer.Enabled:=false;
  PageControl1.ActivePageIndex:=0;

  SaveSettings;
end;

procedure Tmainform.SendTimerTimer(Sender: TObject);
var
  i,j:integer;
begin
  if cbAllowAllUniverses.Checked then
  begin
//    for i:=0 to 15 do
    i:=cbArtNetSubNet.ItemIndex;
    begin
      for j:=0 to 15 do
      begin
        if DMXOutEnabled[i][j] and (not CompareMem(@DMXOutUniverse[i][j],@DMXOutUniverse_old[i][j],512)) then
        begin
//          SendDMXUniverse(ArtBroadcastIP, i, j, DMXOutUniverse[i][j], 512);
          if ArtPollReply_Broadcast then
            SendDMXUniverse(ArtBroadcastIP, i, j, DMXOutUniverse[i][j], 512)
          else
            SendDMXUniverse(ArtLastOpPollIP, i, j, DMXOutUniverse[i][j], 512);
          Move(DMXOutUniverse[i][j], DMXOutUniverse_Old[i][j], 512);
        end;
      end;
    end;
  end else
  begin
    for i:=0 to 3 do
    begin
      if DMX_OutEnabled[i] then
      begin
        if (not CompareMem(@DMXOutUniverseSpec[i],@DMXOutUniverseSpec_old[i],512)) or cbSendUniversesRepeatingly.checked then
        begin
//          SendDMXUniverse(ArtBroadcastIP, DMX_OutToSubNet[i], DMX_OutToUniverse[i], DMXOutUniverseSpec[i], 512);
          if ArtPollReply_Broadcast then
            SendDMXUniverse(ArtBroadcastIP, DMX_OutToSubNet[i], DMX_OutToUniverse[i], DMXOutUniverseSpec[i], 512)
          else
            SendDMXUniverse(ArtLastOpPollIP, DMX_OutToSubNet[i], DMX_OutToUniverse[i], DMXOutUniverseSpec[i], 512);

          Move(DMXOutUniverseSpec[i], DMXOutUniverseSpec_Old[i], 512);
        end;
      end;
    end;
  end;
end;

procedure Tmainform.ScanTimerTimer(Sender: TObject);
var
  i,j:integer;
begin
  ScanTimer.enabled:=false;

  if cbAllowAllUniverses.Checked then
  begin
    for i:=0 to 15 do
    begin
      if (not CompareMem(@DMXInUniverse[cbArtNetSubnet.ItemIndex][i],@DMXInUniverse_old[cbArtNetSubnet.ItemIndex][i],512)) then
      begin
        for j:=0 to 511 do
        begin
          if DMXInUniverse_old[cbArtNetSubnet.ItemIndex][i][j]<>DMXInUniverse[cbArtNetSubnet.ItemIndex][i][j] then
          begin
            // Nur an Hauptanwendung senden, wenn neue Werte vorhanden sind
            issending:=true;

            if @SetDLLValueEvent<>nil then
              SetDLLValueEvent(j+1+(512*i), DMXInUniverse[cbArtNetSubnet.ItemIndex][i][j]);
            if @ReceiveSingleValue<>nil then
              ReceiveSingleValue(cbArtNetSubnet.ItemIndex, i, j+1, DMXInUniverse[cbArtNetSubnet.ItemIndex][i][j]);
          end;
        end;

        if @ReceiveDMXUniverse<>nil then
          ReceiveDMXUniverse(cbArtNetSubNet.ItemIndex, i, @DMXInUniverse[cbArtNetSubnet.ItemIndex][i], 512);

        Move(DMXInUniverse[cbArtNetSubnet.ItemIndex][i], DMXInUniverse_old[cbArtNetSubnet.ItemIndex][i], 512);
      end;
    end;
  end else
  begin
    for i:=0 to 3 do
    begin
      if DMX_InEnabled[i] and (not CompareMem(@DMXInUniverseSpec[i],@DMXInUniverseSpec_old[i],512)) then
      begin
        for j:=0 to 511 do
        begin
          if DMXInUniverseSpec_old[i][j]<>DMXInUniverseSpec[i][j] then
          begin
            // Nur an Hauptanwendung senden, wenn neue Werte vorhanden sind
            issending:=true;

            if @SetDLLValueEvent<>nil then
              SetDLLValueEvent(j+1+(512*i), DMXInUniverseSpec[i][j]);
            if @ReceiveSingleValue<>nil then
              ReceiveSingleValue(0, i, j+1, DMXInUniverseSpec[i][j]);
          end;
        end;

        if @ReceiveDMXUniverse<>nil then
          ReceiveDMXUniverse(0, i, @DMXInUniverseSpec[i], 512);

        Move(DMXInUniverseSpec[i], DMXInUniverseSpec_old[i], 512);
      end;
    end;
  end;
end;

procedure Tmainform.cbSendUniverseChange(Sender: TObject);
var
  i:integer;
begin
  if Sender=cbSendUniverse then
  for i:=0 to 15 do
  begin
    DMXOutEnabled[cbArtNETSubnet.ItemIndex][i]:=cbSendUniverse.Checked[i];
  end;
end;

procedure Tmainform.SettingsChanged;
begin
  DMX_OutEnabled[0]:=cbSendUniverse1.Checked;
  DMX_OutEnabled[1]:=cbSendUniverse2.Checked;
  DMX_OutEnabled[2]:=cbSendUniverse3.Checked;
  DMX_OutEnabled[3]:=cbSendUniverse4.Checked;

  DMX_OutToSubNet[0]:=cbSendToSubNet1.ItemIndex;
  DMX_OutToSubNet[1]:=cbSendToSubNet2.ItemIndex;
  DMX_OutToSubNet[2]:=cbSendToSubNet3.ItemIndex;
  DMX_OutToSubNet[3]:=cbSendToSubNet4.ItemIndex;

  DMX_OutToUniverse[0]:=cbSendToUniverse1.ItemIndex;
  DMX_OutToUniverse[1]:=cbSendToUniverse2.ItemIndex;
  DMX_OutToUniverse[2]:=cbSendToUniverse3.ItemIndex;
  DMX_OutToUniverse[3]:=cbSendToUniverse4.ItemIndex;

  DMX_InEnabled[0]:=cbReceiveUniverse1.Checked;
  DMX_InEnabled[1]:=cbReceiveUniverse2.Checked;
  DMX_InEnabled[2]:=cbReceiveUniverse3.Checked;
  DMX_InEnabled[3]:=cbReceiveUniverse4.Checked;
  ArtEnableIn[0]:=cbReceiveUniverse1.Checked;
  ArtEnableIn[1]:=cbReceiveUniverse2.Checked;
  ArtEnableIn[2]:=cbReceiveUniverse3.Checked;
  ArtEnableIn[3]:=cbReceiveUniverse4.Checked;

  DMX_InFromSubNet[0]:=cbReceiveFromSubNet1.ItemIndex;
  DMX_InFromSubNet[1]:=cbReceiveFromSubNet2.ItemIndex;
  DMX_InFromSubNet[2]:=cbReceiveFromSubNet3.ItemIndex;
  DMX_InFromSubNet[3]:=cbReceiveFromSubNet4.ItemIndex;

  DMX_InFromUniverse[0]:=cbReceiveFromUniverse1.ItemIndex;
  DMX_InFromUniverse[1]:=cbReceiveFromUniverse2.ItemIndex;
  DMX_InFromUniverse[2]:=cbReceiveFromUniverse3.ItemIndex;
  DMX_InFromUniverse[3]:=cbReceiveFromUniverse4.ItemIndex;

  ArtMergeMode[0]:=cbMergeUniverse1.ItemIndex; // 0=HTP, 1=LTP
  ArtMergeMode[1]:=cbMergeUniverse2.ItemIndex; // 0=HTP, 1=LTP
  ArtMergeMode[2]:=cbMergeUniverse3.ItemIndex; // 0=HTP, 1=LTP
  ArtMergeMode[3]:=cbMergeUniverse4.ItemIndex; // 0=HTP, 1=LTP

  ArtMergeEnable[0]:=cbMergeOn1.ItemIndex; // 0=OFF, 1=ON
  ArtMergeEnable[1]:=cbMergeOn2.ItemIndex; // 0=OFF, 1=ON
  ArtMergeEnable[2]:=cbMergeOn3.ItemIndex; // 0=OFF, 1=ON
  ArtMergeEnable[3]:=cbMergeOn4.ItemIndex; // 0=OFF, 1=ON

  if cbAllowAllUniverses.Checked then
    SendTimer.Interval:=75
  else
    SendTimer.Interval:=25;

  cbArtNetSubNet.Enabled:=cbAllowAllUniverses.Checked;
  cbReceiveUniverse.Enabled:=cbAllowAllUniverses.Checked;
  cbSendUniverse.Enabled:=cbAllowAllUniverses.Checked;
  cbSendUniversesRepeatingly.Enabled:=not cbAllowAllUniverses.Checked;

  cbSendUniverse1.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendUniverse2.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendUniverse3.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendUniverse4.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToSubNet1.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToSubNet2.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToSubNet3.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToSubNet4.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToUniverse1.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToUniverse2.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToUniverse3.Enabled:=not cbAllowAllUniverses.Checked;
  cbSendToUniverse4.Enabled:=not cbAllowAllUniverses.Checked;

  cbReceiveUniverse1.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveUniverse2.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveUniverse3.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveUniverse4.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromSubNet1.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromSubNet2.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromSubNet3.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromSubNet4.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromUniverse1.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromUniverse2.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromUniverse3.Enabled:=not cbAllowAllUniverses.Checked;
  cbReceiveFromUniverse4.Enabled:=not cbAllowAllUniverses.Checked;

  udp.Listen:=cbReceiverEnabled.Checked;
end;

procedure Tmainform.LoadSettings;
var
  LReg:TRegistry;
  i:integer;
  short:string[18];
  long:string[64];
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('ArtNet Library') then
        LReg.CreateKey('ArtNet Library');
      if LReg.OpenKey('ArtNet Library',true) then
      begin
{
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
}
	      begin
          if LReg.ValueExists('ArtNet ShortName') then
            short:=LReg.ReadString('ArtNet ShortName')
          else
            short:='PC_DIMMER';
          for i := 0 to 17 do ArtShortName[i] := chr(0);
          for i:=1 to length(short) do
          begin
            if i<=18 then
              ArtShortName[i-1]:=short[i]
          end;

          if LReg.ValueExists('ArtNet LongName') then
            long:=LReg.ReadString('ArtNet LongName')
          else
            long:='PC_DIMMER Art-Net Node';
          for i := 0 to 63 do ArtLongName[i] := chr(0);
          for i:=1 to length(long) do
          begin
            if i<=64 then
              ArtLongName[i-1]:=long[i]
          end;

          if LReg.ValueExists('ArtNet Subnet') then
          begin
            cbArtNetSubnet.ItemIndex:=LReg.ReadInteger('ArtNet Subnet');
            cbArtNetSubnetSelect(nil);
          end;
          if LReg.ValueExists('DMXInEnabled') then
            LReg.ReadBinaryData('DMXInEnabled', DMXInEnabled, sizeof(DMXInEnabled));
          if LReg.ValueExists('DMXOutEnabled') then
            LReg.ReadBinaryData('DMXOutEnabled', DMXOutEnabled, sizeof(DMXOutEnabled));

          if LReg.ValueExists('Receiver enabled') then
            cbReceiverEnabled.Checked:=LReg.ReadBool('Receiver enabled');
          if LReg.ValueExists('Allow Loopback') then
            cbLoopback.Checked:=LReg.ReadBool('Allow Loopback');
          if LReg.ValueExists('Send continuously') then
            cbSendUniversesRepeatingly.Checked:=LReg.ReadBool('Send continuously');
          if LReg.ValueExists('Allow all Universes') then
            cbAllowAllUniverses.Checked:=LReg.ReadBool('Allow all Universes');

          if LReg.ValueExists('Used Network-Card') then
          begin
            cbMAC.ItemIndex:=LReg.ReadInteger('Used Network-Card');
            cbMacSelect(nil);
          end;
          if LReg.ValueExists('IP-Address') then
          begin
            edipaddress.Text:=LReg.ReadString('IP-Address');
            ArtIP:=edipaddress.Text;
          end;
          if LReg.ValueExists('SubNet Mask') then
          begin
            edsubnetmask.Text:=LReg.ReadString('SubNet Mask');
            ArtSubnetmask:=edsubnetmask.text;
          end;
          if LReg.ValueExists('Remote IP') then
          begin
            edremoteipaddress.Text:=LReg.ReadString('Remote IP');
            ArtBroadcastIP:=edremoteipaddress.text;
          end;

          if LReg.ValueExists('Send Universe 1') then
            cbSendUniverse1.Checked:=LReg.ReadBool('Send Universe 1');
          if LReg.ValueExists('Send Universe 2') then
            cbSendUniverse2.Checked:=LReg.ReadBool('Send Universe 2');
          if LReg.ValueExists('Send Universe 3') then
            cbSendUniverse3.Checked:=LReg.ReadBool('Send Universe 3');
          if LReg.ValueExists('Send Universe 4') then
            cbSendUniverse4.Checked:=LReg.ReadBool('Send Universe 4');
          if LReg.ValueExists('Send Universe 1 SubNet') then
            cbSendToSubnet1.ItemIndex:=LReg.ReadInteger('Send Universe 1 SubNet');
          if LReg.ValueExists('Send Universe 2 SubNet') then
            cbSendToSubnet2.ItemIndex:=LReg.ReadInteger('Send Universe 2 SubNet');
          if LReg.ValueExists('Send Universe 3 SubNet') then
            cbSendToSubnet3.ItemIndex:=LReg.ReadInteger('Send Universe 3 SubNet');
          if LReg.ValueExists('Send Universe 4 SubNet') then
            cbSendToSubnet4.ItemIndex:=LReg.ReadInteger('Send Universe 4 SubNet');
          if LReg.ValueExists('Send Universe 1 Universe') then
            cbSendToUniverse1.ItemIndex:=LReg.ReadInteger('Send Universe 1 Universe');
          if LReg.ValueExists('Send Universe 2 Universe') then
            cbSendToUniverse2.ItemIndex:=LReg.ReadInteger('Send Universe 2 Universe');
          if LReg.ValueExists('Send Universe 3 Universe') then
            cbSendToUniverse3.ItemIndex:=LReg.ReadInteger('Send Universe 3 Universe');
          if LReg.ValueExists('Send Universe 4 Universe') then
            cbSendToUniverse4.ItemIndex:=LReg.ReadInteger('Send Universe 4 Universe');
          if LReg.ValueExists('Receive Universe 1') then
            cbReceiveUniverse1.Checked:=LReg.ReadBool('Receive Universe 1');
          if LReg.ValueExists('Receive Universe 2') then
            cbReceiveUniverse2.Checked:=LReg.ReadBool('Receive Universe 2');
          if LReg.ValueExists('Receive Universe 3') then
            cbReceiveUniverse3.Checked:=LReg.ReadBool('Receive Universe 3');
          if LReg.ValueExists('Receive Universe 4') then
            cbReceiveUniverse4.Checked:=LReg.ReadBool('Receive Universe 4');
          if LReg.ValueExists('Receive Universe SubNet') then
            cbReceiveFromSubnet1.ItemIndex:=LReg.ReadInteger('Receive Universe 1 SubNet');
          if LReg.ValueExists('Receive Universe 2 SubNet') then
            cbReceiveFromSubnet2.ItemIndex:=LReg.ReadInteger('Receive Universe 2 SubNet');
          if LReg.ValueExists('Receive Universe 3 SubNet') then
            cbReceiveFromSubnet3.ItemIndex:=LReg.ReadInteger('Receive Universe 3 SubNet');
          if LReg.ValueExists('Receive Universe 4 SubNet') then
            cbReceiveFromSubnet4.ItemIndex:=LReg.ReadInteger('Receive Universe 4 SubNet');
          if LReg.ValueExists('Receive Universe 1 Universe') then
            cbReceiveFromUniverse1.ItemIndex:=LReg.ReadInteger('Receive Universe 1 Universe');
          if LReg.ValueExists('Receive Universe 2 Universe') then
            cbReceiveFromUniverse2.ItemIndex:=LReg.ReadInteger('Receive Universe 2 Universe');
          if LReg.ValueExists('Receive Universe 3 Universe') then
            cbReceiveFromUniverse3.ItemIndex:=LReg.ReadInteger('Receive Universe 3 Universe');
          if LReg.ValueExists('Receive Universe 4 Universe') then
            cbReceiveFromUniverse4.ItemIndex:=LReg.ReadInteger('Receive Universe 4 Universe');

          if LReg.ValueExists('Merge Universe 1') then
            cbMergeOn1.ItemIndex:=LReg.ReadInteger('Merge Universe 1');
          if LReg.ValueExists('Merge Universe 2') then
            cbMergeOn2.ItemIndex:=LReg.ReadInteger('Merge Universe 2');
          if LReg.ValueExists('Merge Universe 3') then
            cbMergeOn3.ItemIndex:=LReg.ReadInteger('Merge Universe 3');
          if LReg.ValueExists('Merge Universe 4') then
            cbMergeOn4.ItemIndex:=LReg.ReadInteger('Merge Universe 4');
          if LReg.ValueExists('Merge Universe 1 Mode') then
            cbMergeUniverse1.ItemIndex:=LReg.ReadInteger('Merge Universe 1 Mode');
          if LReg.ValueExists('Merge Universe 2 Mode') then
            cbMergeUniverse2.ItemIndex:=LReg.ReadInteger('Merge Universe 2 Mode');
          if LReg.ValueExists('Merge Universe 3 Mode') then
            cbMergeUniverse3.ItemIndex:=LReg.ReadInteger('Merge Universe 3 Mode');
          if LReg.ValueExists('Merge Universe 4 Mode') then
            cbMergeUniverse4.ItemIndex:=LReg.ReadInteger('Merge Universe 4 Mode');
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  SettingsChanged;
end;

procedure Tmainform.SaveSettings;
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
      if not LReg.KeyExists('ArtNet Library') then
        LReg.CreateKey('ArtNet Library');
      if LReg.OpenKey('ArtNet Library',true) then
      begin
{
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
}
	      begin
          LReg.WriteString('ArtNet ShortName',String(ArtShortName));
          LReg.WriteString('ArtNet LongName',String(ArtLongName));

          LReg.WriteInteger('ArtNet Subnet',cbArtNetSubnet.ItemIndex);
          LReg.WriteBinaryData('DMXInEnabled', DMXInEnabled, sizeof(DMXInEnabled));
          LReg.WriteBinaryData('DMXOutEnabled', DMXOutEnabled, sizeof(DMXOutEnabled));

          LReg.WriteBool('Receiver enabled',cbReceiverEnabled.Checked);
          LReg.WriteBool('Allow Loopback',cbLoopback.Checked);
          LReg.WriteBool('Send continuously',cbSendUniversesRepeatingly.Checked);
          LReg.WriteBool('Allow all Universes',cbAllowAllUniverses.Checked);

          LReg.WriteInteger('Used Network-Card', cbMAC.ItemIndex);
          LReg.WriteString('IP-Address',edipaddress.Text);
          LReg.WriteString('SubNet Mask',edsubnetmask.Text);
          LReg.WriteString('Remote IP',edremoteipaddress.Text);

          LReg.WriteBool('Send Universe 1',cbSendUniverse1.Checked);
          LReg.WriteBool('Send Universe 2',cbSendUniverse2.Checked);
          LReg.WriteBool('Send Universe 3',cbSendUniverse3.Checked);
          LReg.WriteBool('Send Universe 4',cbSendUniverse4.Checked);
          LReg.WriteInteger('Send Universe 1 SubNet',cbSendToSubnet1.ItemIndex);
          LReg.WriteInteger('Send Universe 2 SubNet',cbSendToSubnet2.ItemIndex);
          LReg.WriteInteger('Send Universe 3 SubNet',cbSendToSubnet3.ItemIndex);
          LReg.WriteInteger('Send Universe 4 SubNet',cbSendToSubnet4.ItemIndex);
          LReg.WriteInteger('Send Universe 1 Universe',cbSendToUniverse1.ItemIndex);
          LReg.WriteInteger('Send Universe 2 Universe',cbSendToUniverse2.ItemIndex);
          LReg.WriteInteger('Send Universe 3 Universe',cbSendToUniverse3.ItemIndex);
          LReg.WriteInteger('Send Universe 4 Universe',cbSendToUniverse4.ItemIndex);
          LReg.WriteBool('Receive Universe 1',cbReceiveUniverse1.Checked);
          LReg.WriteBool('Receive Universe 2',cbReceiveUniverse2.Checked);
          LReg.WriteBool('Receive Universe 3',cbReceiveUniverse3.Checked);
          LReg.WriteBool('Receive Universe 4',cbReceiveUniverse4.Checked);
          LReg.WriteInteger('Receive Universe 1 SubNet',cbReceiveFromSubnet1.ItemIndex);
          LReg.WriteInteger('Receive Universe 2 SubNet',cbReceiveFromSubnet2.ItemIndex);
          LReg.WriteInteger('Receive Universe 3 SubNet',cbReceiveFromSubnet3.ItemIndex);
          LReg.WriteInteger('Receive Universe 4 SubNet',cbReceiveFromSubnet4.ItemIndex);
          LReg.WriteInteger('Receive Universe 1 Universe',cbReceiveFromUniverse1.ItemIndex);
          LReg.WriteInteger('Receive Universe 2 Universe',cbReceiveFromUniverse2.ItemIndex);
          LReg.WriteInteger('Receive Universe 3 Universe',cbReceiveFromUniverse3.ItemIndex);
          LReg.WriteInteger('Receive Universe 4 Universe',cbReceiveFromUniverse4.ItemIndex);

          LReg.WriteInteger('Merge Universe 1',cbMergeOn1.ItemIndex);
          LReg.WriteInteger('Merge Universe 2',cbMergeOn2.ItemIndex);
          LReg.WriteInteger('Merge Universe 3',cbMergeOn3.ItemIndex);
          LReg.WriteInteger('Merge Universe 4',cbMergeOn4.ItemIndex);
          LReg.WriteInteger('Merge Universe 1 Mode',cbMergeUniverse1.ItemIndex);
          LReg.WriteInteger('Merge Universe 2 Mode',cbMergeUniverse2.ItemIndex);
          LReg.WriteInteger('Merge Universe 3 Mode',cbMergeUniverse3.ItemIndex);
          LReg.WriteInteger('Merge Universe 4 Mode',cbMergeUniverse4.ItemIndex);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.CheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SettingsChanged;
end;

procedure Tmainform.ComboboxSelect(Sender: TObject);
begin
  SettingsChanged;
end;

procedure Tmainform.cbAllowAllUniversesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SettingsChanged;
end;

procedure Tmainform.udpError(Sender: TObject; Error: Integer);
begin
  if Error=10048 then
    errormemo.Lines.Add(DateToStr(now)+', '+TimeToStr(now)+' (Fehler '+inttostr(Error)+'): Der ArtNet-Port "6454" ist bereits durch ein anderes Programm belegt.')
  else
    errormemo.Lines.Add(DateToStr(now)+', '+TimeToStr(now)+' (Fehler '+inttostr(Error)+'): '+SysErrorMessage(error));

  PageControl1.ActivePageIndex:=4;
end;

procedure Tmainform.Button4Click(Sender: TObject);
var
  text:string;
  i:integer;
begin
  text:=InputBox('Kurzbeschreibung ändern', 'Bitte geben Sie eine neue ArtNet Kurzbeschreibung ein:',ArtShortName);
  for i:=0 to 17 do ArtShortName[i]:=chr(0);

  for i:=1 to length(text) do
  begin
    if i<=18 then
      ArtShortName[i-1]:=text[i];
  end;
end;

procedure Tmainform.Button6Click(Sender: TObject);
var
  text:string;
  i:integer;
begin
  text:=InputBox('Langbeschreibung ändern', 'Bitte geben Sie eine neue ArtNet Langbeschreibung ein:',ArtLongName);
  for i:=0 to 63 do ArtLongName[i]:=chr(0);

  for i:=1 to length(text) do
  begin
    if i<=64 then
      ArtLongName[i-1]:=text[i];
  end;
end;

procedure Tmainform.Button7Click(Sender: TObject);
begin
  SaveSettings;
  ShowMessage('Ihre Einstellungen wurden gespeichert...');
end;

procedure Tmainform.Button8Click(Sender: TObject);
begin
  ShowMessage('Für Broadcast (also Senden an alle Empfänger): xxx.xxx.xxx.255'+#13#10+
              'Für Senden an speziellen Node z.B. 192.168.0.31');
end;

procedure Tmainform.edipaddressKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edipaddress.Color:=$00CECEFF;
  if Key=vk_return then
  begin
    ArtIP:=edipaddress.Text;
    edipaddress.Color:=clWindow;
  end;
end;

procedure Tmainform.edsubnetmaskKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edsubnetmask.Color:=$00CECEFF;
  if Key=vk_return then
  begin
    ArtSubnetmask:=edsubnetmask.text;
    edsubnetmask.Color:=clWindow;
  end;
end;

procedure Tmainform.edremoteipaddressKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edremoteipaddress.Color:=$00CECEFF;
  if Key=vk_return then
  begin
    ArtBroadcastIP:=edremoteipaddress.Text;
    edremoteipaddress.Color:=clWindow;
  end;
end;

end.
