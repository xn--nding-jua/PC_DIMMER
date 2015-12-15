unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvComponentBase, HID,
  pngimage, JvHidControllerClass;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    JvHidDeviceController: TJvHidDeviceController;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    ScrollBar1: TScrollBar;
    Label6: TLabel;
    Button1: TButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JvHidDeviceControllerDeviceChange(Sender: TObject);
    procedure JvHidDeviceControllerArrival(HidDev: TJvHidDevice);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;

    Transmit : boolean;
    ValueArray : array [1..512] of Byte;  //brightness value
    DMXAdaptor: TJvHidDevice;
    DMXAdaptorReady : boolean;

    procedure SetTransceiver(Active: boolean);
    procedure SetChannel(Channel, Value: Word);
    procedure SetPaketSize(PaketSize: Word);
  end;

var
  mainform: Tmainform;
  HidHandle : THandle;
  Success: LongBool;
  Buffer  : array [0..253] of WideChar;
  Capabilities : HIDP_CAPS;
  OutputReport : Array [0..255] of Byte;
  BytesRead : Cardinal;
  address : WORD;
  data : BYTE;
  PacketCount : WORD;
  Addr : Byte;

const
  VendorID   = $04B4;
  ProductID  = $F23F;

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

procedure Tmainform.FormCreate(Sender: TObject);
begin
  // Activate Outputplugin
  issending:=false;
  PacketCount := 24;
  Addr := 0;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
begin
  if HidHandle <> INVALID_HANDLE_VALUE  then
  begin
    CloseHandle(HidHandle);
  end;
end;

procedure Tmainform.JvHidDeviceControllerDeviceChange(Sender: TObject);
begin
  // Free the device object if it has been unplugged
  if (Assigned(DMXAdaptor)) and not(DMXAdaptor.IsPluggedIn) then
      FreeAndNil(DMXAdaptor);

  // if no in use yet then search for one
  if not Assigned(DMXAdaptor) then
      JvHidDeviceController.CheckOutByID(DMXAdaptor, VendorID, ProductID);

  // update the controls on the form
  if Assigned(DMXAdaptor) then
  begin
    // Gerät verfügbar
    DMXAdaptorReady:=true;
  end else
  begin
    // Gerät nicht verfügbar
    DMXAdaptorReady:=false;
  end;
end;

procedure Tmainform.JvHidDeviceControllerArrival(HidDev: TJvHidDevice);
begin
  // if no in use yet then search for one
  if not Assigned(DMXAdaptor) then
      JvHidDeviceController.CheckOutByID(DMXAdaptor, VendorID, ProductID);

  // update the controls on the form
  if Assigned(DMXAdaptor) then
  begin
    // Gerät verfügbar
    DMXAdaptorReady:=true;
  end;
end;

procedure Tmainform.SetTransceiver(Active: boolean);
var
    Command : byte;
    Buf : array[0..3] of byte; //first byte is report number
    ToWrite, Written : Cardinal;
    str : String;
begin
  Transmit := Active;

  // setup command code
  if Transmit then
  begin
    Command := $4;  //enable DMX transmission
    str := ' -->Enable transmission';
  end
    else
  begin
    Command := $2; //disable DMX transmission
    str := ' -->Disable transmission';
  end;

  // send to device
  Buf[0] := 0;
  Buf[1] := Command;
  Buf[2] := 0;
  Buf[3] := 0;

  if Assigned(DMXAdaptor) then
  begin
    ToWrite := DMXAdaptor.Caps.OutputReportByteLength;
    DMXAdaptor.WriteFile(Buf, ToWrite, Written);
//    if debug then
//      Memo1.Lines.Add(IntToHex(Buf[1], 2) + IntToHex(Buf[2], 2) + IntToHex(Buf[3], 2) + str);
  end;

  if Transmit then
  begin
    // send to device
    Buf[0] := 0;
    Buf[1] := $10 or ((PacketCount - 1) div 256);
    Buf[2] := (PacketCount - 1) mod 256;
    Buf[3] := 0;

    if Assigned(DMXAdaptor) then
    begin
      ToWrite := DMXAdaptor.Caps.OutputReportByteLength;
      DMXAdaptor.WriteFile(Buf, ToWrite, Written);
    end;
//    if debug then
//      Memo1.Lines.Add(IntToHex(Buf[1], 2) + IntToHex(Buf[2], 2) + IntToHex(Buf[3], 2) + ' -->Send packet length');
  end;
end;

procedure Tmainform.SetChannel(Channel, Value: Word);    //OnChange()
var
  Val : BYTE;
  Adr : WORD;

  Buf : array[0..3] of byte; //first byte is report number
  ToWrite, Written : Cardinal;
  Command : byte;
begin
  Val := Value;
  Adr := Channel-1;
  ValueArray[Adr + 1] := Val;
  data := Val;
  address := Adr;

  if Transmit then
  begin
    Command := $8;  //send data
    Buf[0] := 0;
    Buf[1] := Command or (address div 256);
    Buf[2] := address mod 256;
    Buf[3] := data;
    if Assigned(DMXAdaptor) then
    begin
      ToWrite := DMXAdaptor.Caps.OutputReportByteLength;
      DMXAdaptor.WriteFile(Buf, ToWrite, Written);
    end;
//    if debug then
//      Memo1.Lines.Add(IntToHex(Buf[1], 2) + IntToHex(Buf[2], 2) + IntToHex(Buf[3], 2) + ' -->Send data') ;
   end;
end;

procedure Tmainform.SetPaketSize(PaketSize: Word);  //Packet count
var
  Buf : array[0..3] of byte;    //buffer for output
  ToWrite, Written : Cardinal;  //
begin
  PacketCount := PaketSize;

  // setup command code
  if Transmit then
  begin
    if (PacketCount < 24) then
    PacketCount := 24;

    // send to device
    Buf[0] := 0;
    Buf[1] := $10 or ((PacketCount - 1) div 256);
    Buf[2] := (PacketCount - 1) mod 256;
    Buf[3] := 0;

    if Assigned(DMXAdaptor) then
    begin
      ToWrite := DMXAdaptor.Caps.OutputReportByteLength;
      DMXAdaptor.WriteFile(Buf, ToWrite, Written);
    end;
//    if debug then
//      Memo1.Lines.Add(IntToHex(Buf[1], 2) + IntToHex(Buf[2], 2) + IntToHex(Buf[3], 2) + ' -->Change packet length');
  end;
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
begin
  if Transmit then
  begin
    label3.Font.Color:=clGreen;
    label3.Caption:='Ausgabe aktiviert';
  end else
  begin
    label3.Font.Color:=clRed;
    label3.Caption:='Ausgabe deaktiviert';
  end;

  if Assigned(DMXAdaptor) then
  begin
    label4.Font.Color:=clGreen;
    label4.Caption:='DMX Interface angeschlossen';
  end else
  begin
    label4.Font.Color:=clRed;
    label4.Caption:='DMX Interface nicht verbunden';
  end;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  SetTransceiver(not Transmit);
end;

procedure Tmainform.ScrollBar1Change(Sender: TObject);
begin
  label6.caption:=inttostr(ScrollBar1.position);
  SetPaketSize(ScrollBar1.position);
end;

end.
