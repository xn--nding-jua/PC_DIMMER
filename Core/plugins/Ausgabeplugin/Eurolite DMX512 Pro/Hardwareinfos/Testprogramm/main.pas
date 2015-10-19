unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPort, CPDrv, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    comport: TCommPortDriver;
    Button7: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    ComPort1: TComPort;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure comportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    OK, first:boolean;
    DLL:THandle;

    // Dynamisches Linken der DLL-Funktionen
    InitMCP2200:procedure(VendorID:Word; ProductID:Word);stdcall;
    IsConnected:function:boolean;stdcall;
    ConfigureMCP2200:function(IOMap: Byte; BaudRateParam: Cardinal; RxLEDMode:Word; TxLEDMode:Word; FLOW, ULOAD, SSPND: boolean):boolean;stdcall;

    SetPin:function(Pin: Word):boolean;stdcall;
    ClearPin:function(Pin: Word):boolean;stdcall;
    ReadPinValue:function(Pin: Word):Smallint;stdcall;
    ReadPin:function(Pin: Word; returnvalue: Pointer):boolean;stdcall;
    WritePort:function(portValue: Word):boolean;stdcall;
    ReadPort:function(returnvalue: Pointer):boolean;stdcall;
    ReadPortValue:function:Smallint;stdcall;
    SelectDevice:function(uiDeviceNo: Word):Smallint;stdcall;
    GetSelectedDevice:function:Smallint;stdcall;
    GetNoOfDevices:function:Smallint;stdcall;
    GetDeviceInfo:procedure(uiDeviceNo: Word; strOutput:PChar);stdcall;
    GetSelectedDeviceInfo:procedure(strOutput: PChar);stdcall;
    ReadEEPROM:function(uiEEPAddress: Word):Smallint;stdcall;
    WriteEEPROM:function(uiEEPAddress: Word):Smallint;stdcall;

    fnRxLED:function(mode: Word):boolean;stdcall;
    fnTxLED:function(mode: Word):boolean;stdcall;
    fnHardwareFlowControl:function(onOff: Word):boolean;stdcall;
    fnULoad:function(onOff: Word):boolean;stdcall;
    fnSuspend:function(onOff: Word):boolean;stdcall;
    fnSetBaudRate:function(BaudRateParam: Cardinal):boolean;stdcall;
    ConfigureIO:function(IOMap: Byte):boolean;stdcall;
    ConfigureIoDefaultOutput:function(ucIoMap: Byte; ucDefValue: Byte):boolean;stdcall;
  end;

var
  Form1: TForm1;

const
  IF_VID        = 1240;   // 0x04D8
  IF_PID        = 64099;  // 0xFA63
  IF_BAUD       = 128000;

  IF_OFF        = 0;
  IF_ON         = 1;
  IF_TOGGLE     = 3;
  IF_BLINKSLOW  = 4;
  IF_BLINKFAST  = 5;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DLL:=LoadLibrary(PChar(ExtractFilePath(paramstr(0))+'SimpleIO-UM.dll'));

  InitMCP2200:=GetProcAddress(DLL,'InitMCP2200');
  IsConnected:=GetProcAddress(DLL,'IsConnected');
  ConfigureMCP2200:=GetProcAddress(DLL,'ConfigureMCP2200');

  SetPin:=GetProcAddress(DLL,'SetPin');
  ClearPin:=GetProcAddress(DLL,'ClearPin');
  ReadPinValue:=GetProcAddress(DLL,'ReadPinValue');
  ReadPin:=GetProcAddress(DLL,'ReadPin');
  WritePort:=GetProcAddress(DLL,'WritePort');
  ReadPort:=GetProcAddress(DLL,'ReadPort');
  ReadPortValue:=GetProcAddress(DLL,'ReadPortValue');
  SelectDevice:=GetProcAddress(DLL,'SelectDevice');
  GetSelectedDevice:=GetProcAddress(DLL,'GetSelectedDevice');
  GetNoOfDevices:=GetProcAddress(DLL,'GetNoOfDevices');
  GetDeviceInfo:=GetProcAddress(DLL,'GetDeviceInfo');
  GetSelectedDeviceInfo:=GetProcAddress(DLL,'GetSelectedDeviceInfo');
  ReadEEPROM:=GetProcAddress(DLL,'ReadEEPROM');
  WriteEEPROM:=GetProcAddress(DLL,'WriteEEPROM');

  fnRxLED:=GetProcAddress(DLL,'fnRxLED');
  fnTxLED:=GetProcAddress(DLL,'fnTxLED');
  fnHardwareFlowControl:=GetProcAddress(DLL,'fnHardwareFlowControl');
  fnULoad:=GetProcAddress(DLL,'fnULoad');
  fnSuspend:=GetProcAddress(DLL,'fnSuspend');
  fnSetBaudRate:=GetProcAddress(DLL,'fnSetBaudRate');
  ConfigureIO:=GetProcAddress(DLL,'ConfigureIO');
  ConfigureIoDefaultOutput:=GetProcAddress(DLL,'ConfigureIoDefaultOutput');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FreeLibrary(DLL);
  DLL:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  InitMCP2200(IF_VID, IF_PID);
  if fnSetBaudRate(IF_BAUD) then
    showmessage('Baudrate OK');

  if IsConnected then
    showmessage('Eurolite connected...');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
//  comport.Connect;
  comport1.Open;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
//  comport.Disconnect;
  OK:=false;
  comport1.Close;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  rs232frame_new:array[0..512+5] of byte;
  i, j:integer;
  maxchan:word;
  text:string;
begin
{
001 byte    Start of message delimiter, hex 7E.
001 byte    Label to identify type of message. => 6
001 byte    Data length LSB. Valid range for data length is 513
001 byte    Data length MSB.
512 byte    Data bytes.
001 byte    End of message delimiter, hex E7.

Package to port: 1-20Hz
}
{
  maxchan:=512;

  for i:=1 to 10 do
  begin
    if comport.Connected then
    begin
      label1.Caption:='Sending '+inttostr(i)+'/10';
      label1.Refresh;

      rs232frame_new[0]:=126;           // "Start of message delimiter, hex 7E.
      rs232frame_new[1]:=6;             // Label to identify type of message. => 6
      rs232frame_new[2]:=maxchan;       // Data length LSB. Valid range for data length is 513
      rs232frame_new[3]:=maxchan shr 8; // Data length MSB.

      for j:=4 to 515 do
        rs232frame_new[j]:=random(256);

      rs232frame_new[516]:=231;          // End of message delimiter, hex E7.
      comport.SendData(@rs232frame_new, 517);

      text:='';
      for j:=0 to 6 do
        text:=text+inttohex(rs232frame_new[j],2)+' ';
      text:=text+inttohex(rs232frame_new[516],2);
      listbox1.Items.Add(text);
      listbox1.Refresh;

      sleep(100);
    end;
  end;

  label1.Caption:=TimeToStr(Now);
}
  first:=true;
  OK:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
end;

procedure TForm1.comportReceiveData(Sender: TObject; DataPtr: Pointer;
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
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  rs232frame_0:array[0..531] of byte;
  rs232frame_1:array[0..13] of byte;
  rs232frame_2:array[0..517] of byte;
  j:integer;
begin
    rs232frame_0[0]:=126;   // "Start of message delimiter, hex 7E.
    rs232frame_0[1]:=6;     // Label to identify type of message. => 6
    rs232frame_0[2]:=1;     // Data length LSB. Valid range for data length is 513
    rs232frame_0[3]:=2;     // Data length MSB.
    rs232frame_0[4]:=0;     // Startbyte
    rs232frame_0[5]:=255;   // Startbyte
    for j:=6 to 13 do
      rs232frame_0[j]:=0;
    rs232frame_0[0+14]:=126;   // "Start of message delimiter, hex 7E.
    rs232frame_0[1+14]:=6;     // Label to identify type of message. => 6
    rs232frame_0[2+14]:=1;     // Data length LSB. Valid range for data length is 513
    rs232frame_0[3+14]:=2;     // Data length MSB.
    for j:=4 to 516 do
      rs232frame_0[j+14]:=0;
    rs232frame_0[517+14]:=135; // End of message delimiter, hex E7.



    rs232frame_1[0]:=Byte(StrToInt('$'+'7E'));   // "Start of message delimiter, hex 7E.
    rs232frame_1[1]:=Byte(StrToInt('$'+'06'));     // Label to identify type of message. => 6
    rs232frame_1[2]:=Byte(StrToInt('$'+'01'));     // Data length LSB. Valid range for data length is 513
    rs232frame_1[3]:=Byte(StrToInt('$'+'02'));     // Data length MSB.
    rs232frame_1[4]:=Byte(StrToInt('$'+'00'));     // Startbyte
    rs232frame_1[5]:=Byte(StrToInt('$'+'FF'));   // Startbyte
    for j:=6 to 13 do
      rs232frame_1[j]:=0;


    rs232frame_2[0]:=Byte(StrToInt('$'+'7E'));   // "Start of message delimiter, hex 7E.
    rs232frame_2[1]:=Byte(StrToInt('$'+'06'));     // Label to identify type of message. => 6
    rs232frame_2[2]:=Byte(StrToInt('$'+'01'));     // Data length LSB. Valid range for data length is 513
    rs232frame_2[3]:=Byte(StrToInt('$'+'02'));     // Data length MSB.
    for j:=4 to 516 do
      rs232frame_2[j]:=Byte(StrToInt('$'+'00'));
    rs232frame_2[517]:=Byte(StrToInt('$'+'E7')); // End of message delimiter, hex E7.

  if OK then
  begin
{
    if first then
    begin
      first:=false;
      comport.SendData(@rs232frame_1, 14);
    end;
    comport.SendData(@rs232frame_2, 518);
}
{
    if first then
    begin
      first:=false;
      comport.SendData(@rs232frame_0, 532);
    end else
    begin
      comport.SendData(@rs232frame_2, 518);
    end;
}

{
    if first then
    begin
      first:=false;
      comport1.Write(rs232frame_1, 14);
    end;
}
    comport1.Write(rs232frame_2, 518);

{
    if first then
    begin
      first:=false;
      comport1.Write(rs232frame_0, 532);
    end else
    begin
      comport1.Write(rs232frame_2, 518);
    end;
}
  end;
end;

end.
