unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, inifiles, NMUDP, NB30;

type
  TMainForm = class(TForm)
    OutViewImage: TImage;
    OutViewCL: TLabel;
    OutViewVL: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    UDPSoc: TNMUDP;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    NICSettings: TLabel;
    ArtProgIndicator: TLabel;
    NameSettings: TLabel;
    UniverseAddressSettings: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ArtNICBox: TComboBox;
    ArtNetworkBox: TComboBox;
    ArtCustomIP: TEdit;
    ArtCustomSubnetmask: TEdit;
    ArtSubnetBox: TComboBox;
    LEDP: TPanel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    IfCBox1: TComboBox;
    IfCBox2: TComboBox;
    IfCBox3: TComboBox;
    IfCBox4: TComboBox;
    IfBox1: TComboBox;
    IfBox2: TComboBox;
    IfBox3: TComboBox;
    IfBox4: TComboBox;
    Uni1OutBox: TComboBox;
    Uni2OutBox: TComboBox;
    Uni3OutBox: TComboBox;
    Uni4OutBox: TComboBox;
    Uni1InBox: TComboBox;
    Uni2InBox: TComboBox;
    Uni3InBox: TComboBox;
    Uni4InBox: TComboBox;
    MeI1: TLabel;
    MeI2: TLabel;
    MeI3: TLabel;
    MeI4: TLabel;
    InD1: TLabel;
    InD2: TLabel;
    InD3: TLabel;
    InD4: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    GroupBox4: TGroupBox;
    SHDMXBt: TButton;
    DMXOutBox: TComboBox;
    Label25: TLabel;
    Label26: TLabel;
    Image1: TImage;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IfBox1DropDown(Sender: TObject);
    procedure IfBox2DropDown(Sender: TObject);
    procedure IfBox3DropDown(Sender: TObject);
    procedure IfBox4DropDown(Sender: TObject);
    procedure IfBox1Change(Sender: TObject);
    procedure IfBox2Change(Sender: TObject);
    procedure IfBox3Change(Sender: TObject);
    procedure IfBox4Change(Sender: TObject);
    procedure IfCBox1Change(Sender: TObject);
    procedure IfCBox2Change(Sender: TObject);
    procedure IfCBox3Change(Sender: TObject);
    procedure IfCBox4Change(Sender: TObject);
    procedure SHDMXBtClick(Sender: TObject);
    procedure DMXOutBoxChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OutViewImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UDPSocDataReceived(Sender: TComponent; NumberBytes: Integer;
      FromIP: String; Port: Integer);
    procedure ArtNICBoxChange(Sender: TObject);
    procedure UniInOutBoxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ArtCustomIPEnter(Sender: TObject);
    procedure ArtCustomSubnetmaskEnter(Sender: TObject);
    procedure LoadState;
    procedure SaveState;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;
  PDMXArray = ^TDMXArray;
  TDMXArray = array[0..511] of byte;
  TSERIAL = array[0..15] of Char;
  TSERIALLIST = array[0..31] of TSERIAL;
  THOSTDEVICECHANGEPROC = procedure;
  TINPUTCHANGEPROC = procedure;

function GetAllConnectedInterfaces: TSERIALLIST; stdcall external 'usbdmx.dll';
function SetInterfaceMode(Serial: TSERIAL; Mode: byte): DWORD; stdcall external 'usbdmx.dll';
function OpenLink(Serial: TSERIAL; DMXOutArray: PDMXArray; DMXInArray: PDMXArray): DWORD; stdcall external 'usbdmx.dll';
function CloseLink(Serial: TSERIAL): DWORD; stdcall external 'usbdmx.dll';
function CloseAllLinks: DWORD; stdcall external 'usbdmx.dll';
function RegisterInterfaceChangeNotification(Proc: THOSTDEVICECHANGEPROC): DWORD; stdcall external 'usbdmx.dll';
function UnregisterInterfaceChangeNotification: DWORD; stdcall external 'usbdmx.dll';
function RegisterInputChangeNotification(Proc: TINPUTCHANGEPROC): DWORD; stdcall external 'usbdmx.dll';
function UnregisterInputChangeNotification: DWORD; stdcall external 'usbdmx.dll';

procedure ArtInit;
procedure ArtShutdown;
procedure InputChange;
procedure ArtPacketReceived(SourceIp: string; Buffer: array of char; Length: integer);
procedure DMXInputChanged(Port: byte; DMXBuf: array of byte; Length: integer);
procedure ArtSendOpPollReply(DestIp: string);

var
//--- Interface & IP Support Variables:
  MainForm: TMainForm;
  DMX_OutBuf1, DMX_OutBuf2, DMX_OutBuf3, DMX_OutBuf4: TDMXArray;
  DMX_InBuf1, DMX_InBuf2, DMX_InBuf3, DMX_InBuf4: TDMXArray;
  DMX_InBacBuf1, DMX_InBacBuf2, DMX_InBacBuf3, DMX_InBacBuf4: TDMXArray;
  DMX_OutEnable1, DMX_OutEnable2, DMX_OutEnable3, DMX_OutEnable4: boolean;
  DMX_InEnable1, DMX_InEnable2, DMX_InEnable3, DMX_InEnable4: boolean;
  SerialList: TSERIALLIST;
  USB_Serial1, USB_Serial2, USB_Serial3, USB_Serial4: string;
  DMX_Vis_Out: byte;
  DMX_Vis_Last: TDMXArray;
//--- Artnet Variables:
  ArtProtokollVersion: word = 14;
  ArtOEMCode: word = $0390;
  ArtDMXSequence: byte;
  ArtPollReply_OnChange: boolean;
  ArtPollReply_Broadcast: boolean;
  ArtLEDIndicator: byte; // 0 = Mute, 1 = Normal, 2 = Locate
  ArtLastAddressNetProg: boolean; //true = Last Address programmed from Network
  ArtIP: string;
  ArtBroadcastIP: string;
  ArtLastOpPollIP: string;
  ArtSubnetmask: string;
  ArtMAC: string;
  ArtSubnetSwitch: byte;
  ArtUniverseSwitchIn1: byte;
  ArtUniverseSwitchIn2: byte;
  ArtUniverseSwitchIn3: byte;
  ArtUniverseSwitchIn4: byte;
  ArtUniverseSwitchOut1: byte;
  ArtUniverseSwitchOut2: byte;
  ArtUniverseSwitchOut3: byte;
  ArtUniverseSwitchOut4: byte;
  ArtEnableIn1, ArtEnableIn2, ArtEnableIn3, ArtEnableIn4 : boolean;
  ArtMergeMode1, ArtMergeMode2, ArtMergeMode3, ArtMergeMode4 : byte; // 0=HTP, 1=LTP
  ArtMergeEnable1, ArtMergeEnable2, ArtMergeEnable3, ArtMergeEnable4 : byte; // 0=OFF, 1=ON
  ArtMergeIP1_A, ArtMergeIP2_A, ArtMergeIP3_A, ArtMergeIP4_A: dword;
  ArtMergeIP1_B, ArtMergeIP2_B, ArtMergeIP3_B, ArtMergeIP4_B: dword;
  ArtMergeBuf1_A, ArtMergeBuf2_A, ArtMergeBuf3_A, ArtMergeBuf4_A: array[0..511] of byte;
  ArtMergeBuf1_B, ArtMergeBuf2_B, ArtMergeBuf3_B, ArtMergeBuf4_B: array[0..511] of byte;
  ArtMergeBuf1_LTP_Bac, ArtMergeBuf2_LTP_Bac, ArtMergeBuf3_LTP_Bac, ArtMergeBuf4_LTP_Bac: array[0..511] of byte;
  ArtMergeLength1_A, ArtMergeLength2_A, ArtMergeLength3_A, ArtMergeLength4_A: word;
  ArtMergeLength1_B, ArtMergeLength2_B, ArtMergeLength3_B, ArtMergeLength4_B: word;
  ArtMergeCnt1_A, ArtMergeCnt2_A, ArtMergeCnt3_A, ArtMergeCnt4_A: byte;
  ArtMergeCnt1_B, ArtMergeCnt2_B, ArtMergeCnt3_B, ArtMergeCnt4_B: byte;
  ArtShortName: array[0..17] of char;
  ArtLongName: array[0..63] of char;
  ArtStatusCode: word;
  ArtPollReplyCounter: word;
  ArtInTimerCount: byte;
  ArtCustomIPBac: string;
  ArtCustomSubnetmaskBac: string;
  DMX_OutEnable1_bac, DMX_OutEnable2_bac, DMX_OutEnable3_bac, DMX_OutEnable4_bac: boolean;
  DMX_InEnable1_bac, DMX_InEnable2_bac, DMX_InEnable3_bac, DMX_InEnable4_bac: boolean;

implementation

{$R *.DFM}

//--- Interface & IP Support Implementation

function SerialToSerialstring(Serial: TSERIAL): string;
var i: byte;
begin
Result := '';
for i := 0 to 15 do Result := Result + Serial[i];
end;

function SerialstringToSerial(Serialstr: string): TSERIAL;
var i: byte;
    len: byte;
begin
len := length(Serialstr);
if len > 16 then len := 16;
for i := 0 to 15 do Result[i] := '0';
for i := 1 to len do Result[i + 15 - len] := Serialstr[i];
end;

function FindSerialInList(Serial: TSERIAL): boolean;
var i: byte;
    Res: boolean;
begin
Res := false;
for i := 0 to 31 do
 begin
  if SerialList[i] = '0000000000000000' then
   Break
  else
   begin
    if SerialList[i] = Serial then
     begin
      Res := true;
      Break;
     end;
   end;
 end;
Result := Res;
end;

procedure DeviceChange;
begin
SerialList := GetAllConnectedInterfaces;
if not FindSerialInList(SerialstringToSerial(MainForm.IfBox1.Items[MainForm.IfBox1.Itemindex])) then
 begin
  CloseLink(SerialstringToSerial(MainForm.IfBox1.Items[MainForm.IfBox1.Itemindex]));
  MainForm.IfCBox1.Itemindex := 0;
  MainForm.IfBox1.Itemindex := 0;
  MainForm.IfCBox1.Enabled := false;
 end;
if not FindSerialInList(SerialstringToSerial(MainForm.IfBox2.Items[MainForm.IfBox2.Itemindex])) then
 begin
  CloseLink(SerialstringToSerial(MainForm.IfBox2.Items[MainForm.IfBox2.Itemindex]));
  MainForm.IfCBox2.Itemindex := 0;
  MainForm.IfBox2.Itemindex := 0;
  MainForm.IfCBox2.Enabled := false;
 end;
if not FindSerialInList(SerialstringToSerial(MainForm.IfBox3.Items[MainForm.IfBox3.Itemindex])) then
 begin
  CloseLink(SerialstringToSerial(MainForm.IfBox3.Items[MainForm.IfBox3.Itemindex]));
  MainForm.IfCBox3.Itemindex := 0;
  MainForm.IfBox3.Itemindex := 0;
  MainForm.IfCBox3.Enabled := false;
 end;
if not FindSerialInList(SerialstringToSerial(MainForm.IfBox4.Items[MainForm.IfBox4.Itemindex])) then
 begin
  CloseLink(SerialstringToSerial(MainForm.IfBox4.Items[MainForm.IfBox4.Itemindex]));
  MainForm.IfCBox4.Itemindex := 0;
  MainForm.IfBox4.Itemindex := 0;
  MainForm.IfCBox4.Enabled := false;
 end;
end;

procedure TMainForm.IfBox1DropDown(Sender: TObject);
var i: byte;
begin
SerialList := GetAllConnectedInterfaces;
IfBox1.Items.Clear;
IfBox1.Items.Add('No Interface');
IfBox1.Itemindex := 0;
for i := 0 to 31 do
 begin
  if SerialList[i] = '0000000000000000' then
   Break
  else
   begin
    if not ((SerialList[i] = SerialstringToSerial(IfBox2.Items[IfBox2.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox3.Items[IfBox3.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox4.Items[IfBox4.Itemindex]))) then
          IfBox1.Items.Add(SerialToSerialstring(SerialList[i]));
   end;
 end;
end;

procedure TMainForm.IfBox2DropDown(Sender: TObject);
var i: byte;
begin
SerialList := GetAllConnectedInterfaces;
IfBox2.Items.Clear;
IfBox2.Items.Add('No Interface');
IfBox2.Itemindex := 0;
for i := 0 to 31 do
 begin
  if SerialList[i] = '0000000000000000' then
   Break
  else
   begin
    if not ((SerialList[i] = SerialstringToSerial(IfBox1.Items[IfBox1.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox3.Items[IfBox3.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox4.Items[IfBox4.Itemindex]))) then
          IfBox2.Items.Add(SerialToSerialstring(SerialList[i]));
   end;
 end;
end;

procedure TMainForm.IfBox3DropDown(Sender: TObject);
var i: byte;
begin
SerialList := GetAllConnectedInterfaces;
IfBox3.Items.Clear;
IfBox3.Items.Add('No Interface');
IfBox3.Itemindex := 0;
for i := 0 to 31 do
 begin
  if SerialList[i] = '0000000000000000' then
   Break
  else
   begin
    if not ((SerialList[i] = SerialstringToSerial(IfBox1.Items[IfBox1.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox2.Items[IfBox2.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox4.Items[IfBox4.Itemindex]))) then
          IfBox3.Items.Add(SerialToSerialstring(SerialList[i]));
   end;
 end;
end;

procedure TMainForm.IfBox4DropDown(Sender: TObject);
var i: byte;
begin
SerialList := GetAllConnectedInterfaces;
IfBox4.Items.Clear;
IfBox4.Items.Add('No Interface');
IfBox4.Itemindex := 0;
for i := 0 to 31 do
 begin
  if SerialList[i] = '0000000000000000' then
   Break
  else
   begin
    if not ((SerialList[i] = SerialstringToSerial(IfBox1.Items[IfBox1.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox2.Items[IfBox2.Itemindex]))
       or (SerialList[i] = SerialstringToSerial(IfBox3.Items[IfBox3.Itemindex]))) then
          IfBox4.Items.Add(SerialToSerialstring(SerialList[i]));
   end;
 end;
end;

procedure TMainForm.IfBox1Change(Sender: TObject);
begin
if USB_Serial1 <> IfBox1.Items[IfBox1.Itemindex] then
 begin
  if USB_Serial1 <> '0000000000000000' then CloseLink(SerialstringToSerial(USB_Serial1));
  DMX_OutEnable1 := false;
  DMX_InEnable1 := false;
  IfCBox1.Itemindex := 0;
  if IfBox1.ItemIndex = 0 then
    begin
     USB_Serial1 := '0000000000000000';
     IfCBox1.Enabled := false;
    end
   else
    begin
     OpenLink(SerialstringToSerial(IfBox1.Items[IfBox1.Itemindex]), @DMX_OutBuf1, @DMX_InBuf1);
     USB_Serial1 := IfBox1.Items[IfBox1.Itemindex];
     IfCBox1.Enabled := true;
    end;
 end;
end;

procedure TMainForm.IfBox2Change(Sender: TObject);
begin
if USB_Serial2 <> IfBox2.Items[IfBox2.Itemindex] then
 begin
  if USB_Serial2 <> '0000000000000000' then CloseLink(SerialstringToSerial(USB_Serial2));
  DMX_OutEnable2 := false;
  DMX_InEnable2 := false;
  IfCBox2.Itemindex := 0;
  if IfBox2.ItemIndex = 0 then
    begin
     USB_Serial2 := '0000000000000000';
     IfCBox2.Enabled := false;
    end
   else
    begin
     OpenLink(SerialstringToSerial(IfBox2.Items[IfBox2.Itemindex]), @DMX_OutBuf2, @DMX_InBuf2);
     USB_Serial2 := IfBox2.Items[IfBox2.Itemindex];
     IfCBox2.Enabled := true;
    end;
 end;
end;

procedure TMainForm.IfBox3Change(Sender: TObject);
begin
if USB_Serial3 <> IfBox3.Items[IfBox3.Itemindex] then
 begin
  if USB_Serial3 <> '0000000000000000' then CloseLink(SerialstringToSerial(USB_Serial3));
  DMX_OutEnable3 := false;
  DMX_InEnable3 := false;
  IfCBox3.Itemindex := 0;
  if IfBox3.ItemIndex = 0 then
    begin
     USB_Serial3 := '0000000000000000';
     IfCBox3.Enabled := false;
    end
   else
    begin
     OpenLink(SerialstringToSerial(IfBox3.Items[IfBox3.Itemindex]), @DMX_OutBuf3, @DMX_InBuf3);
     USB_Serial3 := IfBox3.Items[IfBox3.Itemindex];
     IfCBox3.Enabled := true;
    end;
 end;
end;

procedure TMainForm.IfBox4Change(Sender: TObject);
begin
if USB_Serial4 <> IfBox4.Items[IfBox4.Itemindex] then
 begin
  if USB_Serial4 <> '0000000000000000' then CloseLink(SerialstringToSerial(USB_Serial4));
  DMX_OutEnable4 := false;
  DMX_InEnable4 := false;
  IfCBox4.Itemindex := 0;
  if IfBox4.ItemIndex = 0 then
    begin
     USB_Serial4 := '0000000000000000';
     IfCBox4.Enabled := false;
    end
   else
    begin
     OpenLink(SerialstringToSerial(IfBox4.Items[IfBox4.Itemindex]), @DMX_OutBuf4, @DMX_InBuf4);
     USB_Serial4 := IfBox4.Items[IfBox4.Itemindex];
     IfCBox4.Enabled := true;
    end;
 end;
end;

procedure TMainForm.IfCBox1Change(Sender: TObject);
begin
SetInterfaceMode(SerialstringToSerial(USB_Serial1),IfCBox1.ItemIndex);
if (IfCBox1.ItemIndex = 2) or (IfCBox1.ItemIndex = 3) or (IfCBox1.ItemIndex = 6) or (IfCBox1.ItemIndex = 7) then
 DMX_OutEnable1 := true
else
 DMX_OutEnable1 := false;
if (IfCBox1.ItemIndex > 3) then
 DMX_InEnable1 := true
else
 DMX_InEnable1 := false;
end;

procedure TMainForm.IfCBox2Change(Sender: TObject);
begin
SetInterfaceMode(SerialstringToSerial(USB_Serial2),IfCBox2.ItemIndex);
if (IfCBox2.ItemIndex = 2) or (IfCBox2.ItemIndex = 3) or (IfCBox2.ItemIndex = 6) or (IfCBox2.ItemIndex = 7) then
 DMX_OutEnable2 := true
else
 DMX_OutEnable2 := false;
if (IfCBox2.ItemIndex > 3) then
 DMX_InEnable2 := true
else
 DMX_InEnable2 := false;
end;

procedure TMainForm.IfCBox3Change(Sender: TObject);
begin
SetInterfaceMode(SerialstringToSerial(USB_Serial3),IfCBox3.ItemIndex);
if (IfCBox3.ItemIndex = 2) or (IfCBox3.ItemIndex = 3) or (IfCBox3.ItemIndex = 6) or (IfCBox3.ItemIndex = 7) then
 DMX_OutEnable3 := true
else
 DMX_OutEnable3 := false;
if (IfCBox3.ItemIndex > 3) then
 DMX_InEnable3 := true
else
 DMX_InEnable3 := false;
end;

procedure TMainForm.IfCBox4Change(Sender: TObject);
begin
SetInterfaceMode(SerialstringToSerial(USB_Serial4),IfCBox4.ItemIndex);
if (IfCBox4.ItemIndex = 2) or (IfCBox4.ItemIndex = 3) or (IfCBox4.ItemIndex = 6) or (IfCBox4.ItemIndex = 7) then
 DMX_OutEnable4 := true
else
 DMX_OutEnable4 := false;
if (IfCBox4.ItemIndex > 3) then
 DMX_InEnable4 := true
else
 DMX_InEnable4 := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var i: word;
    ResStream:TResourceStream;
begin
for i := 0 to 511 do
 begin
  DMX_OutBuf1[i] := 0;
  DMX_OutBuf2[i] := 0;
  DMX_OutBuf3[i] := 0;
  DMX_OutBuf4[i] := 0;
  DMX_InBuf1[i] := 0;
  DMX_InBuf2[i] := 0;
  DMX_InBuf3[i] := 0;
  DMX_InBuf4[i] := 0;
  DMX_InBacBuf1[i] := 0;
  DMX_InBacBuf2[i] := 0;
  DMX_InBacBuf3[i] := 0;
  DMX_InBacBuf4[i] := 0;
  DMX_Vis_Last[i] := 0;
 end;
DMX_OutEnable1 := False;
DMX_OutEnable2 := False;
DMX_OutEnable3 := False;
DMX_OutEnable4 := False;
DMX_InEnable1 := False;
DMX_InEnable2 := False;
DMX_InEnable3 := False;
DMX_InEnable4 := False;
IfBox1.ItemIndex := 0;
IfBox2.ItemIndex := 0;
IfBox3.ItemIndex := 0;
IfBox4.ItemIndex := 0;
IfCBox1.ItemIndex := 0;
IfCBox2.ItemIndex := 0;
IfCBox3.ItemIndex := 0;
IfCBox4.ItemIndex := 0;
DMXOutBox.ItemIndex := 0;
DMX_Vis_Out := 0;

OutViewImage.Canvas.MoveTo(0,0);
OutViewImage.Canvas.Pen.Color := clwhite;
OutViewImage.Canvas.LineTo(0,1);

USB_Serial1 := '0000000000000000';
USB_Serial2 := '0000000000000000';
USB_Serial3 := '0000000000000000';
USB_Serial4 := '0000000000000000';
RegisterInterfaceChangeNotification(DeviceChange);
RegisterInputChangeNotification(InputChange);

ArtInit;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
ArtShutdown;
CloseAllLinks;
UnregisterInputChangeNotification;
UnregisterInterfaceChangeNotification;
end;

procedure TMainForm.SHDMXBtClick(Sender: TObject);
var i: word;
begin
if SHDMXBt.Caption = 'Show DMX Output' then
 begin
  DMX_Vis_Out := DMXOutBox.ItemIndex + 1;
  MainForm.Height := 542;
  DMXOutBox.Enabled := true;
  SHDMXBt.Caption := 'Hide DMX Output';
  while SHDMXBt.Caption = 'Hide DMX Output' do
   begin
    if DMX_Vis_Out = 1 then
     begin
      for i := 0 to 511 do
       if DMX_OutBuf1[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_OutBuf1[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_OutBuf1,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 2 then
     begin
      for i := 0 to 511 do
       if DMX_InBuf1[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_InBuf1[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_InBuf1,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 3 then
     begin
      for i := 0 to 511 do
       if DMX_OutBuf2[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_OutBuf2[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_OutBuf2,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 4 then
     begin
      for i := 0 to 511 do
       if DMX_InBuf2[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_InBuf2[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_InBuf2,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 5 then
     begin
      for i := 0 to 511 do
       if DMX_OutBuf3[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_OutBuf3[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_OutBuf3,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 6 then
     begin
      for i := 0 to 511 do
       if DMX_InBuf3[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_InBuf3[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_InBuf3,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 7 then
     begin
      for i := 0 to 511 do
       if DMX_OutBuf4[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_OutBuf4[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_OutBuf4,DMX_Vis_Last,512);
     end;
    if DMX_Vis_Out = 8 then
     begin
      for i := 0 to 511 do
       if DMX_InBuf4[i] <> DMX_Vis_Last[i] then
        begin
         MainForm.OutViewImage.Canvas.MoveTo(i,MainForm.OutViewImage.Height-1);
         MainForm.OutViewImage.Canvas.Pen.Color := clRed;
         MainForm.OutViewImage.Canvas.LineTo(i,MainForm.OutViewImage.Height - Round(DMX_InBuf4[i]*(MainForm.OutViewImage.Height-1)/255) - 1);
         MainForm.OutViewImage.Canvas.Pen.Color := clWhite;
         MainForm.OutViewImage.Canvas.LineTo(i,0);
        end;
      Move(DMX_InBuf4,DMX_Vis_Last,512);
     end;
    Sleep(10);
    Application.ProcessMessages;
   end;
 end
else
 begin
  DMX_Vis_Out := 0;
  OutViewCL.Caption := '0';
  MainForm.Height := 393;
  DMXOutBox.Enabled := false;
  SHDMXBt.Caption := 'Show DMX Output';
 end;
end;

procedure TMainForm.DMXOutBoxChange(Sender: TObject);
begin
DMX_Vis_Out := DMXOutBox.ItemIndex + 1;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if SHDMXBt.Caption = 'Hide DMX Output' then SHDMXBt.Click;
SaveState;
end;

procedure TMainForm.OutViewImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
OutViewCL.Caption := IntToStr(X+1);
case DMX_Vis_Out of
 1: OutViewVL.Caption := IntToStr(DMX_OutBuf1[X]);
 2: OutViewVL.Caption := IntToStr(DMX_InBuf1[X]);
 3: OutViewVL.Caption := IntToStr(DMX_OutBuf2[X]);
 4: OutViewVL.Caption := IntToStr(DMX_InBuf2[X]);
 5: OutViewVL.Caption := IntToStr(DMX_OutBuf3[X]);
 6: OutViewVL.Caption := IntToStr(DMX_InBuf3[X]);
 7: OutViewVL.Caption := IntToStr(DMX_OutBuf4[X]);
 8: OutViewVL.Caption := IntToStr(DMX_InBuf4[X]);
end;
end;

function GetMACAddresses: string;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;

  URetCode: PChar;
  RetCode: char;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
  TMPSTR: string;
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
      _SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[1]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[2]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[3]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[4]), 2) + ':' +
        IntToHex(Ord(Adapter.adapter_address[5]), 2);
      if _SystemID <> '00:00:00:00:00:00' then Result := Result + _SystemID + chr(10);
    end;
    Inc(i);
  until (I >= Ord(Lenum.Length));
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
end;

procedure SetNetwork(Ip: string; Subnetmask: string; MAC: string);
begin
MainForm.NICSettings.Caption := 'Your NIC with MAC Address ' + MAC + chr(10) + chr(13) +
                                'must have the following settings:' + chr(10) + chr(13) +
                                'IP Address:  ' + Ip + chr(10) + chr(13) +
                                'Subnet Mask: ' + Subnetmask;
end;

procedure DMXOutputSet(Port: byte; Buffer: array of byte; Length: integer);
var TempBuf: TDMXARRAY;
    i: word;
begin
if (Length < 1) or (Length > 512) then Exit;
for i := 0 to 511 do TempBuf[i] := 0;
if (Port = 0) and DMX_OutEnable1 then
 begin
  Move(Buffer, DMX_OutBuf1, Length);
  if Length < 512 then Move(TempBuf[Length], DMX_OutBuf1[Length], 512-Length);
 end;
if (Port = 1) and DMX_OutEnable2 then
 begin
  Move(Buffer, DMX_OutBuf2, Length);
  if Length < 512 then Move(TempBuf[Length], DMX_OutBuf2[Length], 512-Length);
 end;
if (Port = 2) and DMX_OutEnable3 then
 begin
  Move(Buffer, DMX_OutBuf3, Length);
  if Length < 512 then Move(TempBuf[Length], DMX_OutBuf3[Length], 512-Length);
 end;
if (Port = 3) and DMX_OutEnable4 then
 begin
  Move(Buffer, DMX_OutBuf4, Length);
  if Length < 512 then Move(TempBuf[Length], DMX_OutBuf4[Length], 512-Length);
 end;
end;

procedure InputChange;
begin
if DMX_InEnable1 and (not CompareMem(@DMX_InBuf1, @DMX_InBacBuf1, 512)) then
 begin
  DMXInputChanged(0, DMX_InBuf1, 512);
  Move(DMX_InBuf1, DMX_InBacBuf1, 512);
 end;
if DMX_InEnable2 and (not CompareMem(@DMX_InBuf2, @DMX_InBacBuf2, 512)) then
 begin
  DMXInputChanged(1, DMX_InBuf2, 512);
  Move(DMX_InBuf2, DMX_InBacBuf2, 512);
 end;
if DMX_InEnable3 and (not CompareMem(@DMX_InBuf3, @DMX_InBacBuf3, 512)) then
 begin
  DMXInputChanged(0, DMX_InBuf3, 512);
  Move(DMX_InBuf3, DMX_InBacBuf3, 512);
 end;
if DMX_InEnable4 and (not CompareMem(@DMX_InBuf4, @DMX_InBacBuf4, 512)) then
 begin
  DMXInputChanged(0, DMX_InBuf4, 512);
  Move(DMX_InBuf4, DMX_InBacBuf4, 512);
 end;
end;

procedure SendArtPacket(DestIp: string; Buffer: array of char; Length: integer);
begin
if (Length > 0) and (Length <= 1500) then
 begin
  MainForm.UDPSoc.RemoteHost := DestIp;
  MainForm.UDPSoc.SendBuffer(Buffer, Length);
 end;
end;

procedure TMainForm.UDPSocDataReceived(Sender: TComponent;
  NumberBytes: Integer; FromIP: String; Port: Integer);
var Buffer: array[0..1499] of char;
    Length: integer;
begin
if NumberBytes > 1500 then Length := 1500 else Length := NumberBytes;
if Length > 0 then
 begin
  UDPSoc.ReadBuffer(Buffer, Length);
  ArtPacketReceived(FromIP, Buffer, Length);
 end;
end;

//--- Artnet Driver Implementation
//--- Interfacesignals:
//--- Use procedure SetNetwork(Ip: string; Subnetmask: string; MAC: string);
//--- Implement procedure ArtInit;
//--- Implement procedure ArtShutdown;
//--- Implement procedure ArtPacketReceived(SourceIp: string; Buffer: array of char; Length: integer);
//--- Use procedure SendArtPacket(DestIp: string; Buffer: array of char; Length: integer);
//--- Implement procedure DMXInputChanged(Port: byte; Buffer: array of byte; Length: integer);
//--- Use procedure DMXOutputSet(Port: byte; Buffer: array of byte; Length: integer);
//--- DMX Port Status Signals: DMX_OutEnable1, DMX_OutEnable2, DMX_OutEnable3, DMX_OutEnable4, DMX_InEnable1, DMX_InEnable2, DMX_InEnable3, DMX_InEnable4: boolean;

function CheckIP(Ip: string): Boolean;
const
  Z = ['0'..'9', '.'];
var
  I, J, P: Integer;
  W: string;
begin
  Result := False;
  if (Length(Ip) > 15) or (Length(Ip) < 6) or (Ip[1] = '.') then Exit;
  I := 1;
  J := 0;
  P := 0;
  W := '';
  repeat
    if (Ip[I] in Z) and (J < 4) then
    begin
      if Ip[I] = '.' then
      begin
        Inc(P);
        J := 0;
        try
          StrToInt(Ip[I + 1]);
        except
          Exit;
        end;
        W := '';
      end
      else
      begin
        W := W + Ip[I];
        if (StrToInt(W) > 255) or (Length(W) > 3) then Exit;
        Inc(J);
      end;
    end
    else
      Exit;
    Inc(I);
  until I > Length(Ip);
  if P < 3 then Exit;
  Result := True;
end;

procedure UpdateArtAddressIndicator;
begin
if ArtLastAddressNetProg then MainForm.ArtProgIndicator.Caption := 'Art-Net addressing is overwritten by network'
else MainForm.ArtProgIndicator.Caption := 'Art-Net addressing is user controlled';
MainForm.UniverseAddressSettings.Caption := 'Subnet: ' + IntToHex(ArtSubnetSwitch,1) + chr(10) + chr(13) +
                                            'Port1 Out: ' + IntToHex(ArtUniverseSwitchOut1,1) + chr(9) + 'Port1 In : ' + IntToHex(ArtUniverseSwitchIn1,1) + chr(10) + chr(13) +
                                            'Port2 Out: ' + IntToHex(ArtUniverseSwitchOut2,1) + chr(9) + 'Port2 In : ' + IntToHex(ArtUniverseSwitchIn2,1) + chr(10) + chr(13) +
                                            'Port3 Out: ' + IntToHex(ArtUniverseSwitchOut3,1) + chr(9) + 'Port3 In : ' + IntToHex(ArtUniverseSwitchIn3,1) + chr(10) + chr(13) +
                                            'Port4 Out: ' + IntToHex(ArtUniverseSwitchOut4,1) + chr(9) + 'Port4 In : ' + IntToHex(ArtUniverseSwitchIn4,1);
end;

procedure UpdateArtNameIndicator;
begin
MainForm.NameSettings.Caption := 'Short Name: ' + ArtShortName + chr(10) + chr(13) +
                                 'Long Name: ' + ArtLongName;
end;

procedure UpdateArtMergeIndicator;
begin
if ArtMergeEnable1 = 0 then MainForm.MeI1.Caption := 'OFF'
else if ArtMergeMode1 = 0 then MainForm.MeI1.Caption := 'HTP' else MainForm.MeI1.Caption := 'LPT';
if ArtMergeEnable2 = 0 then MainForm.MeI2.Caption := 'OFF'
else if ArtMergeMode2 = 0 then MainForm.MeI2.Caption := 'HTP' else MainForm.MeI2.Caption := 'LPT';
if ArtMergeEnable3 = 0 then MainForm.MeI3.Caption := 'OFF'
else if ArtMergeMode3 = 0 then MainForm.MeI3.Caption := 'HTP' else MainForm.MeI3.Caption := 'LPT';
if ArtMergeEnable4 = 0 then MainForm.MeI4.Caption := 'OFF'
else if ArtMergeMode4 = 0 then MainForm.MeI4.Caption := 'HTP' else MainForm.MeI4.Caption := 'LPT';
end;

procedure UpdateArtInputIndicator;
begin
if ArtEnableIn1 then MainForm.InD1.Caption := 'ON ' else MainForm.InD1.Caption := 'OFF';
if ArtEnableIn2 then MainForm.InD2.Caption := 'ON ' else MainForm.InD2.Caption := 'OFF';
if ArtEnableIn3 then MainForm.InD3.Caption := 'ON ' else MainForm.InD3.Caption := 'OFF';
if ArtEnableIn4 then MainForm.InD4.Caption := 'ON ' else MainForm.InD4.Caption := 'OFF';
end;

procedure ArtInit;
var i: word;
begin
ArtDMXSequence := 0;
ArtPollReply_OnChange := false;
ArtPollReply_Broadcast := true;
ArtLastAddressNetProg := false;
UpdateArtAddressIndicator;
UpdateArtNameIndicator;
ArtLEDIndicator := 1;
ArtSubnetSwitch := 0;
ArtUniverseSwitchIn1 := 0;
ArtUniverseSwitchIn2 := 0;
ArtUniverseSwitchIn3 := 0;
ArtUniverseSwitchIn4 := 0;
ArtUniverseSwitchOut1 := 0;
ArtUniverseSwitchOut2 := 0;
ArtUniverseSwitchOut3 := 0;
ArtUniverseSwitchOut4 := 0;
ArtEnableIn1 := true;
ArtEnableIn2 := true;
ArtEnableIn3 := true;
ArtEnableIn4 := true;
UpdateArtInputIndicator;
ArtMergeEnable1 := 0;
ArtMergeEnable2 := 0;
ArtMergeEnable3 := 0;
ArtMergeEnable4 := 0;
ArtMergeMode1 := 0;
ArtMergeMode2 := 0;
ArtMergeMode3 := 0;
ArtMergeMode4 := 0;
ArtMergeIP1_A := 0;
ArtMergeIP2_A := 0;
ArtMergeIP3_A := 0;
ArtMergeIP4_A := 0;
ArtMergeIP1_B := 0;
ArtMergeIP2_B := 0;
ArtMergeIP3_B := 0;
ArtMergeIP4_B := 0;
for i := 0 to 511 do
 begin
  ArtMergeBuf1_A[i] := 0;
  ArtMergeBuf2_A[i] := 0;
  ArtMergeBuf3_A[i] := 0;
  ArtMergeBuf4_A[i] := 0;
  ArtMergeBuf1_B[i] := 0;
  ArtMergeBuf2_B[i] := 0;
  ArtMergeBuf3_B[i] := 0;
  ArtMergeBuf4_B[i] := 0;
  ArtMergeBuf1_LTP_Bac[i] := 0;
  ArtMergeBuf2_LTP_Bac[i] := 0;
  ArtMergeBuf3_LTP_Bac[i] := 0;
  ArtMergeBuf4_LTP_Bac[i] := 0;
 end;
ArtMergeCnt1_A := 0;
ArtMergeCnt2_A := 0;
ArtMergeCnt3_A := 0;
ArtMergeCnt4_A := 0;
ArtMergeCnt1_A := 0;
ArtMergeCnt2_B := 0;
ArtMergeCnt3_B := 0;
ArtMergeCnt4_B := 0;
ArtMergeLength1_A := 0;
ArtMergeLength2_A := 0;
ArtMergeLength3_A := 0;
ArtMergeLength4_A := 0;
ArtMergeLength1_A := 0;
ArtMergeLength2_B := 0;
ArtMergeLength3_B := 0;
ArtMergeLength4_B := 0;
UpdateArtMergeIndicator;
ArtInTimerCount := 0;
DMX_OutEnable1_bac := DMX_OutEnable1;
DMX_OutEnable2_bac := DMX_OutEnable2;
DMX_OutEnable3_bac := DMX_OutEnable3;
DMX_OutEnable4_bac := DMX_OutEnable4;
DMX_InEnable1_bac := DMX_InEnable1;
DMX_InEnable2_bac := DMX_InEnable2;
DMX_InEnable3_bac := DMX_InEnable3;
DMX_InEnable4_bac := DMX_InEnable4;
for i := 0 to 17 do ArtShortName[i] := chr(0);
for i := 0 to 63 do ArtLongName[i] := chr(0);
ArtShortName[0] := 'D';
ArtShortName[1] := 'E';
ArtShortName[2] := ' ';
ArtShortName[3] := 'S';
ArtShortName[4] := 'h';
ArtShortName[5] := 'o';
ArtShortName[6] := 'w';
ArtShortName[7] := 'G';
ArtShortName[8] := 'a';
ArtShortName[9] := 't';
ArtShortName[10] := 'e';
ArtLongName[0] := 'D';
ArtLongName[1] := 'i';
ArtLongName[2] := 'g';
ArtLongName[3] := 'i';
ArtLongName[4] := 't';
ArtLongName[5] := 'a';
ArtLongName[6] := 'l';
ArtLongName[7] := ' ';
ArtLongName[8] := 'E';
ArtLongName[9] := 'n';
ArtLongName[10] := 'l';
ArtLongName[11] := 'i';
ArtLongName[12] := 'g';
ArtLongName[13] := 'h';
ArtLongName[14] := 't';
ArtLongName[15] := 'e';
ArtLongName[16] := 'n';
ArtLongName[17] := 'm';
ArtLongName[18] := 'e';
ArtLongName[19] := 'n';
ArtLongName[20] := 't';
ArtLongName[21] := ' ';
ArtLongName[22] := 'S';
ArtLongName[23] := 'h';
ArtLongName[24] := 'o';
ArtLongName[25] := 'w';
ArtLongName[26] := 'G';
ArtLongName[27] := 'a';
ArtLongName[28] := 't';
ArtLongName[29] := 'e';
ArtStatusCode := $0001; //PowerUp OK
ArtPollReplyCounter := $0;
MainForm.ArtNICBox.Items.Text := GetMACAddresses;
ArtCustomIPBac := MainForm.ArtCustomIP.Text;
ArtCustomSubnetmaskBac := MainForm.ArtCustomSubnetmask.Text;
if MainForm.ArtNICBox.Items.Count > 0 then
 begin
  MainForm.ArtNICBox.ItemIndex := 0;
  MainForm.ArtNICBoxChange(nil);
 end;
MainForm.ArtSubnetBox.ItemIndex := 0;
MainForm.Uni1OutBox.ItemIndex := 0;
MainForm.Uni2OutBox.ItemIndex := 0;
MainForm.Uni3OutBox.ItemIndex := 0;
MainForm.Uni4OutBox.ItemIndex := 0;
MainForm.Uni1InBox.ItemIndex := 0;
MainForm.Uni2InBox.ItemIndex := 0;
MainForm.Uni3InBox.ItemIndex := 0;
MainForm.Uni4InBox.ItemIndex := 0;
if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP); //Power Up Reply
end;

procedure ArtShutdown;
begin
end;

function IpstringToDword(ipstr: string): dword;
var a,b,c,d, tmp: string;
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

procedure ArtSendOpPollReply(DestIp: string);
var Buffer: array[0..238] of char;
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
Buffer[19] := chr(ArtSubnetSwitch and $0F);
Buffer[20] := chr((ArtOEMCode shr 8) and $FF); //OEM Code
Buffer[21] := chr(ArtOEMCode and $FF);
Buffer[22] := chr($00); //UBEA Version
if ArtLastAddressNetProg then Buffer[23] := chr($20) else Buffer[23] := chr($10); //Status
case (ArtLEDIndicator) of
  0: Buffer[23] := chr(ord(Buffer[23]) or $80); //Mute
  1: Buffer[23] := chr(ord(Buffer[23]) or $C0); //Normal
  2: Buffer[23] := chr(ord(Buffer[23]) or $40); //Locate
end;
Buffer[24] := 'D'; //Esta Man
Buffer[25] := 'E';
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
Buffer[174] := chr($C0); //PortTypes
Buffer[175] := chr($C0);
Buffer[176] := chr($C0);
Buffer[177] := chr($C0);
if not ArtEnableIn1 then Buffer[178] := chr($08) else Buffer[178] := chr($00); //GoodInput
if DMX_InEnable1 then Buffer[178] := chr(ord(Buffer[178]) or $80);
if not ArtEnableIn2 then Buffer[179] := chr($08) else Buffer[179] := chr($00);
if DMX_InEnable2 then Buffer[179] := chr(ord(Buffer[179]) or $80);
if not ArtEnableIn3 then Buffer[180] := chr($08) else Buffer[180] := chr($00);
if DMX_InEnable3 then Buffer[180] := chr(ord(Buffer[180]) or $80);
if not ArtEnableIn4 then Buffer[181] := chr($08) else Buffer[181] := chr($00);
if DMX_InEnable4 then Buffer[181] := chr(ord(Buffer[181]) or $80);
if DMX_OutEnable1 then Buffer[182] := chr($80) else Buffer[182] := chr($00); //GoodOutput
if DMX_OutEnable2 then Buffer[183] := chr($80) else Buffer[183] := chr($00);
if DMX_OutEnable3 then Buffer[184] := chr($80) else Buffer[184] := chr($00);
if DMX_OutEnable4 then Buffer[185] := chr($80) else Buffer[185] := chr($00);
if ArtMergeEnable1 = 1 then Buffer[182] := chr(ord(Buffer[182]) or $08);
if ArtMergeMode1 = 1 then Buffer[182] := chr(ord(Buffer[182]) or $02);
if ArtMergeEnable2 = 1 then Buffer[183] := chr(ord(Buffer[183]) or $08);
if ArtMergeMode2 = 1 then Buffer[183] := chr(ord(Buffer[183]) or $02);
if ArtMergeEnable3 = 1 then Buffer[184] := chr(ord(Buffer[184]) or $08);
if ArtMergeMode3 = 1 then Buffer[184] := chr(ord(Buffer[184]) or $02);
if ArtMergeEnable4 = 1 then Buffer[185] := chr(ord(Buffer[185]) or $08);
if ArtMergeMode4 = 1 then Buffer[185] := chr(ord(Buffer[185]) or $02);
Buffer[186] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchIn1 and $0F)); //Swin
Buffer[187] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchIn2 and $0F));
Buffer[188] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchIn3 and $0F));
Buffer[189] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchIn4 and $0F));
Buffer[190] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchOut1 and $0F)); //Swout
Buffer[191] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchOut2 and $0F));
Buffer[192] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchOut3 and $0F));
Buffer[193] := chr(((ArtSubnetSwitch shl 4) and $0F) or (ArtUniverseSwitchOut4 and $0F));
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

procedure ArtOpPoll(SourceIp: string; Buffer: array of char; Length: integer);
begin
if Length < 14 then Exit;
if (Ord(Buffer[12]) and $02) = $02 then ArtPollReply_OnChange := true else ArtPollReply_OnChange := false;
if (Ord(Buffer[12]) and $01) = $01 then ArtPollReply_Broadcast := false else ArtPollReply_Broadcast := true;
ArtLastOpPollIP := SourceIp;
if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure Merge1(Buf_A: array of byte; Buf_B: array of byte; var Buf_Out: array of byte; Length_A: word; Length_B: word; Mode: byte; AB_Select: byte);
var i, len: word;
begin
if Length_A < Length_B then len := Length_A else len := Length_B; //Get min Length
if Mode = 0 then //HTP Mode
 begin
  for i := 0 to (len - 1) do
   if Buf_A[i] > Buf_B[i] then Buf_Out[i] := Buf_A[i] else Buf_Out[i] := Buf_B[i];
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end
else // LTP Mode
 begin
  for i := 0 to (len - 1) do
   begin
    if AB_Select = 0 then if Buf_A[i] <> ArtMergeBuf1_LTP_Bac[i] then Buf_Out[i] := Buf_A[i];
    if AB_Select = 1 then if Buf_B[i] <> ArtMergeBuf1_LTP_Bac[i] then Buf_Out[i] := Buf_B[i];
   end;
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end;
if Length_A > Length_B then len := Length_A else len := Length_B; //Get max Length
Move(Buf_Out, ArtMergeBuf1_LTP_Bac, len);
end;

procedure Merge2(Buf_A: array of byte; Buf_B: array of byte; var Buf_Out: array of byte; Length_A: word; Length_B: word; Mode: byte; AB_Select: byte);
var i, len: word;
begin
if Length_A < Length_B then len := Length_A else len := Length_B; //Get min Length
if Mode = 0 then //HTP Mode
 begin
  for i := 0 to (len - 1) do
   if Buf_A[i] > Buf_B[i] then Buf_Out[i] := Buf_A[i] else Buf_Out[i] := Buf_B[i];
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end
else // LTP Mode
 begin
  for i := 0 to (len - 1) do
   begin
    if AB_Select = 0 then if Buf_A[i] <> ArtMergeBuf2_LTP_Bac[i] then Buf_Out[i] := Buf_A[i];
    if AB_Select = 1 then if Buf_B[i] <> ArtMergeBuf2_LTP_Bac[i] then Buf_Out[i] := Buf_B[i];
   end;
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end;
if Length_A > Length_B then len := Length_A else len := Length_B; //Get max Length
Move(Buf_Out, ArtMergeBuf2_LTP_Bac, len);
end;

procedure Merge3(Buf_A: array of byte; Buf_B: array of byte; var Buf_Out: array of byte; Length_A: word; Length_B: word; Mode: byte; AB_Select: byte);
var i, len: word;
begin
if Length_A < Length_B then len := Length_A else len := Length_B; //Get min Length
if Mode = 0 then //HTP Mode
 begin
  for i := 0 to (len - 1) do
   if Buf_A[i] > Buf_B[i] then Buf_Out[i] := Buf_A[i] else Buf_Out[i] := Buf_B[i];
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end
else // LTP Mode
 begin
  for i := 0 to (len - 1) do
   begin
    if AB_Select = 0 then if Buf_A[i] <> ArtMergeBuf3_LTP_Bac[i] then Buf_Out[i] := Buf_A[i];
    if AB_Select = 1 then if Buf_B[i] <> ArtMergeBuf3_LTP_Bac[i] then Buf_Out[i] := Buf_B[i];
   end;
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end;
if Length_A > Length_B then len := Length_A else len := Length_B; //Get max Length
Move(Buf_Out, ArtMergeBuf3_LTP_Bac, len);
end;

procedure Merge4(Buf_A: array of byte; Buf_B: array of byte; var Buf_Out: array of byte; Length_A: word; Length_B: word; Mode: byte; AB_Select: byte);
var i, len: word;
begin
if Length_A < Length_B then len := Length_A else len := Length_B; //Get min Length
if Mode = 0 then //HTP Mode
 begin
  for i := 0 to (len - 1) do
   if Buf_A[i] > Buf_B[i] then Buf_Out[i] := Buf_A[i] else Buf_Out[i] := Buf_B[i];
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end
else // LTP Mode
 begin
  for i := 0 to (len - 1) do
   begin
    if AB_Select = 0 then if Buf_A[i] <> ArtMergeBuf4_LTP_Bac[i] then Buf_Out[i] := Buf_A[i];
    if AB_Select = 1 then if Buf_B[i] <> ArtMergeBuf4_LTP_Bac[i] then Buf_Out[i] := Buf_B[i];
   end;
  if len < Length_A then
   for i := len to (Length_A - 1) do Buf_Out[i] := Buf_A[i];
  if len < Length_B then
   for i := len to (Length_B - 1) do Buf_Out[i] := Buf_B[i];
 end;
if Length_A > Length_B then len := Length_A else len := Length_B; //Get max Length
Move(Buf_Out, ArtMergeBuf4_LTP_Bac, len);
end;

procedure ArtOpDmx(SourceIp: string; Buffer: array of char; Length: integer);
var outport: byte;
    dmxbuflength, i: word;
    DMXTmpBuf: TDMXArray;
    TempBuf: TDMXArray;
    ArtSourceIP: dword;
begin
if Length < 19 then Exit;
if ((ord(Buffer[14]) shr 4) and $0F) = (ArtSubnetSwitch and $0F) then
  begin
   outport := 0;
   if ((ord(Buffer[14]) and $0F) = (ArtUniverseSwitchOut1 and $0F)) and DMX_OutEnable1 then outport := outport or $01;
   if ((ord(Buffer[14]) and $0F) = (ArtUniverseSwitchOut2 and $0F)) and DMX_OutEnable2 then outport := outport or $02;
   if ((ord(Buffer[14]) and $0F) = (ArtUniverseSwitchOut3 and $0F)) and DMX_OutEnable3 then outport := outport or $04;
   if ((ord(Buffer[14]) and $0F) = (ArtUniverseSwitchOut4 and $0F)) and DMX_OutEnable4 then outport := outport or $08;
   if outport > 0 then
    begin
     dmxbuflength := ((ord(Buffer[16]) shl 8) and $FF00) or (ord(Buffer[17]) and $FF);
     if Length >= (dmxbuflength + 18) then
      begin
       ArtSourceIP := IpstringToDword(SourceIP);
       for i:= 0 to 511 do TempBuf[i] := 0;
       if (outport and $01) = $01 then
        begin
         if (ArtMergeIP1_A = 0) and (ArtMergeIP1_B <> ArtSourceIP) then
          begin
           ArtMergeIP1_A := ArtSourceIP;
           if (ArtMergeIP1_B <> 0) then
            begin
             ArtMergeEnable1 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP1_B = 0) and (ArtMergeIP1_A <> ArtSourceIP) then
          begin
           ArtMergeIP1_B := ArtSourceIP;
           if (ArtMergeIP1_A <> 0) then
            begin
             ArtMergeEnable1 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP1_A = ArtSourceIp) and (ArtMergeIP1_B = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf1_A, dmxbuflength);
           ArtMergeLength1_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf1_A[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(0, ArtMergeBuf1_A, dmxbuflength);
           ArtMergeCnt1_A := 0;
          end;
         if (ArtMergeIP1_B = ArtSourceIp) and (ArtMergeIP1_A = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf1_B, dmxbuflength);
           ArtMergeLength1_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf1_B[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(0, ArtMergeBuf1_B, dmxbuflength);
           ArtMergeCnt1_B := 0;
          end;
         if (ArtMergeIP1_A = ArtSourceIp) and (ArtMergeIP1_B <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf1_A, dmxbuflength);
           ArtMergeLength1_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf1_A[dmxbuflength], 512-dmxbuflength);
           Merge1(ArtMergeBuf1_A, ArtMergeBuf1_B, DMXTmpBuf, ArtMergeLength1_A, ArtMergeLength1_B, ArtMergeMode1, 0);
           if ArtMergeLength1_A > ArtMergeLength1_B then dmxbuflength := ArtMergeLength1_A else dmxbuflength := ArtMergeLength1_B;
           DMXOutputSet(0, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt1_A := 0;
          end;
         if (ArtMergeIP1_B = ArtSourceIp) and (ArtMergeIP1_A <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf1_B, dmxbuflength);
           ArtMergeLength1_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf1_B[dmxbuflength], 512-dmxbuflength);
           Merge1(ArtMergeBuf1_A, ArtMergeBuf1_B, DMXTmpBuf, ArtMergeLength1_A, ArtMergeLength1_B, ArtMergeMode1, 1);
           if ArtMergeLength1_A > ArtMergeLength1_B then dmxbuflength := ArtMergeLength1_A else dmxbuflength := ArtMergeLength1_B;
           DMXOutputSet(0, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt1_B := 0;
          end;
        end;
       if (outport and $02) = $02 then
        begin
         if (ArtMergeIP2_A = 0) and (ArtMergeIP2_B <> ArtSourceIP) then
          begin
           ArtMergeIP2_A := ArtSourceIP;
           if (ArtMergeIP2_B <> 0) then
            begin
             ArtMergeEnable2 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP2_B = 0) and (ArtMergeIP2_A <> ArtSourceIP) then
          begin
           ArtMergeIP2_B := ArtSourceIP;
           if (ArtMergeIP2_A <> 0) then
            begin
             ArtMergeEnable2 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP2_A = ArtSourceIp) and (ArtMergeIP2_B = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf2_A, dmxbuflength);
           ArtMergeLength2_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf2_A[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(1, ArtMergeBuf2_A, dmxbuflength);
           ArtMergeCnt2_A := 0;
          end;
         if (ArtMergeIP2_B = ArtSourceIp) and (ArtMergeIP2_A = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf2_B, dmxbuflength);
           ArtMergeLength2_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf2_B[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(1, ArtMergeBuf2_B, dmxbuflength);
           ArtMergeCnt2_B := 0;
          end;
         if (ArtMergeIP2_A = ArtSourceIp) and (ArtMergeIP2_B <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf2_A, dmxbuflength);
           ArtMergeLength2_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf2_A[dmxbuflength], 512-dmxbuflength);
           Merge2(ArtMergeBuf2_A, ArtMergeBuf2_B, DMXTmpBuf, ArtMergeLength2_A, ArtMergeLength2_B, ArtMergeMode2, 0);
           if ArtMergeLength2_A > ArtMergeLength2_B then dmxbuflength := ArtMergeLength2_A else dmxbuflength := ArtMergeLength2_B;
           DMXOutputSet(1, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt2_A := 0;
          end;
         if (ArtMergeIP2_B = ArtSourceIp) and (ArtMergeIP2_A <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf2_B, dmxbuflength);
           ArtMergeLength2_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf2_B[dmxbuflength], 512-dmxbuflength);
           Merge2(ArtMergeBuf2_A, ArtMergeBuf2_B, DMXTmpBuf, ArtMergeLength2_A, ArtMergeLength2_B, ArtMergeMode2, 1);
           if ArtMergeLength2_A > ArtMergeLength2_B then dmxbuflength := ArtMergeLength2_A else dmxbuflength := ArtMergeLength2_B;
           DMXOutputSet(1, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt2_B := 0;
          end;
        end;
       if (outport and $04) = $04 then
        begin
         if (ArtMergeIP3_A = 0) and (ArtMergeIP3_B <> ArtSourceIP) then
          begin
           ArtMergeIP3_A := ArtSourceIP;
           if (ArtMergeIP3_B <> 0) then
            begin
             ArtMergeEnable3 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP3_B = 0) and (ArtMergeIP3_A <> ArtSourceIP) then
          begin
           ArtMergeIP3_B := ArtSourceIP;
           if (ArtMergeIP3_A <> 0) then
            begin
             ArtMergeEnable3 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP3_A = ArtSourceIp) and (ArtMergeIP3_B = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf3_A, dmxbuflength);
           ArtMergeLength3_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf3_A[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(2, ArtMergeBuf3_A, dmxbuflength);
           ArtMergeCnt3_A := 0;
          end;
         if (ArtMergeIP3_B = ArtSourceIp) and (ArtMergeIP3_A = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf3_B, dmxbuflength);
           ArtMergeLength3_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf3_B[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(2, ArtMergeBuf3_B, dmxbuflength);
           ArtMergeCnt3_B := 0;
          end;
         if (ArtMergeIP3_A = ArtSourceIp) and (ArtMergeIP3_B <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf3_A, dmxbuflength);
           ArtMergeLength3_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf3_A[dmxbuflength], 512-dmxbuflength);
           Merge3(ArtMergeBuf3_A, ArtMergeBuf3_B, DMXTmpBuf, ArtMergeLength3_A, ArtMergeLength3_B, ArtMergeMode3, 0);
           if ArtMergeLength3_A > ArtMergeLength3_B then dmxbuflength := ArtMergeLength3_A else dmxbuflength := ArtMergeLength3_B;
           DMXOutputSet(2, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt3_A := 0;
          end;
         if (ArtMergeIP3_B = ArtSourceIp) and (ArtMergeIP3_A <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf3_B, dmxbuflength);
           ArtMergeLength3_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf3_B[dmxbuflength], 512-dmxbuflength);
           Merge3(ArtMergeBuf3_A, ArtMergeBuf3_B, DMXTmpBuf, ArtMergeLength3_A, ArtMergeLength3_B, ArtMergeMode3, 1);
           if ArtMergeLength3_A > ArtMergeLength3_B then dmxbuflength := ArtMergeLength3_A else dmxbuflength := ArtMergeLength3_B;
           DMXOutputSet(2, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt3_B := 0;
          end;
        end;
       if (outport and $08) = $08 then
        begin
         if (ArtMergeIP4_A = 0) and (ArtMergeIP4_B <> ArtSourceIP) then
          begin
           ArtMergeIP4_A := ArtSourceIP;
           if (ArtMergeIP4_B <> 0) then
            begin
             ArtMergeEnable4 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP4_B = 0) and (ArtMergeIP4_A <> ArtSourceIP) then
          begin
           ArtMergeIP4_B := ArtSourceIP;
           if (ArtMergeIP4_A <> 0) then
            begin
             ArtMergeEnable4 := 1;
             UpdateArtMergeIndicator;
             if ArtPollReply_OnChange then
              if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
            end;
          end;
         if (ArtMergeIP4_A = ArtSourceIp) and (ArtMergeIP4_B = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf4_A, dmxbuflength);
           ArtMergeLength4_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf4_A[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(3, ArtMergeBuf4_A, dmxbuflength);
           ArtMergeCnt4_A := 0;
          end;
         if (ArtMergeIP4_B = ArtSourceIp) and (ArtMergeIP4_A = 0) then
          begin
           Move(Buffer[18], ArtMergeBuf4_B, dmxbuflength);
           ArtMergeLength4_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf4_B[dmxbuflength], 512-dmxbuflength);
           DMXOutputSet(3, ArtMergeBuf4_B, dmxbuflength);
           ArtMergeCnt4_B := 0;
          end;
         if (ArtMergeIP4_A = ArtSourceIp) and (ArtMergeIP4_B <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf4_A, dmxbuflength);
           ArtMergeLength4_A := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf4_A[dmxbuflength], 512-dmxbuflength);
           Merge4(ArtMergeBuf4_A, ArtMergeBuf4_B, DMXTmpBuf, ArtMergeLength4_A, ArtMergeLength4_B, ArtMergeMode4, 0);
           if ArtMergeLength4_A > ArtMergeLength4_B then dmxbuflength := ArtMergeLength4_A else dmxbuflength := ArtMergeLength4_B;
           DMXOutputSet(3, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt4_A := 0;
          end;
         if (ArtMergeIP4_B = ArtSourceIp) and (ArtMergeIP4_A <> 0) then
          begin
           Move(Buffer[18], ArtMergeBuf4_B, dmxbuflength);
           ArtMergeLength4_B := dmxbuflength;
           if dmxbuflength < 512 then Move(TempBuf[dmxbuflength], ArtMergeBuf4_B[dmxbuflength], 512-dmxbuflength);
           Merge4(ArtMergeBuf4_A, ArtMergeBuf4_B, DMXTmpBuf, ArtMergeLength4_A, ArtMergeLength4_B, ArtMergeMode4, 1);
           if ArtMergeLength4_A > ArtMergeLength4_B then dmxbuflength := ArtMergeLength4_A else dmxbuflength := ArtMergeLength4_B;
           DMXOutputSet(3, DMXTmpBuf, dmxbuflength);
           ArtMergeCnt4_B := 0;
          end;
        end;
      end;
    end;
  end;
end;

procedure ArtOpAddress(SourceIp: string; Buffer: array of char; Length: integer);
var i: word;
    DMXBuf: TDMXArray;
begin
if Length < 107 then Exit;
if ord(Buffer[14]) <> 0 then for i := 0 to 17 do ArtShortName[i] := Buffer[14+i];
if ord(Buffer[32]) <> 0 then for i := 0 to 63 do ArtLongName[i] := Buffer[32+i];
UpdateArtNameIndicator;
if ord(Buffer[96]) = $00 then ArtUniverseSwitchIn1 := MainForm.Uni1InBox.ItemIndex;
if (ord(Buffer[96]) and $80) = $80 then ArtUniverseSwitchIn1 := ord(Buffer[96]) and $0F;
if ord(Buffer[97]) = $00 then ArtUniverseSwitchIn2 := MainForm.Uni2InBox.ItemIndex;
if (ord(Buffer[97]) and $80) = $80 then ArtUniverseSwitchIn2 := ord(Buffer[97]) and $0F;
if ord(Buffer[98]) = $00 then ArtUniverseSwitchIn3 := MainForm.Uni3InBox.ItemIndex;
if (ord(Buffer[98]) and $80) = $80 then ArtUniverseSwitchIn3 := ord(Buffer[98]) and $0F;
if ord(Buffer[99]) = $00 then ArtUniverseSwitchIn4 := MainForm.Uni4InBox.ItemIndex;
if (ord(Buffer[99]) and $80) = $80 then ArtUniverseSwitchIn4 := ord(Buffer[99]) and $0F;
if ord(Buffer[100]) = $00 then ArtUniverseSwitchOut1 := MainForm.Uni1OutBox.ItemIndex;
if (ord(Buffer[100]) and $80) = $80 then ArtUniverseSwitchOut1 := ord(Buffer[100]) and $0F;
if ord(Buffer[101]) = $00 then ArtUniverseSwitchOut2 := MainForm.Uni2OutBox.ItemIndex;
if (ord(Buffer[101]) and $80) = $80 then ArtUniverseSwitchOut2 := ord(Buffer[101]) and $0F;
if ord(Buffer[102]) = $00 then ArtUniverseSwitchOut3 := MainForm.Uni3OutBox.ItemIndex;
if (ord(Buffer[102]) and $80) = $80 then ArtUniverseSwitchOut3 := ord(Buffer[102]) and $0F;
if ord(Buffer[103]) = $00 then ArtUniverseSwitchOut4 := MainForm.Uni4OutBox.ItemIndex;
if (ord(Buffer[103]) and $80) = $80 then ArtUniverseSwitchOut4 := ord(Buffer[103]) and $0F;
if ord(Buffer[104]) = $00 then ArtSubnetSwitch := MainForm.ArtSubnetBox.ItemIndex;
if (ord(Buffer[104]) and $80) = $80 then ArtSubnetSwitch := ord(Buffer[104]) and $0F;
if (ArtUniverseSwitchIn1 = MainForm.Uni1InBox.ItemIndex) and (ArtUniverseSwitchIn2 = MainForm.Uni2InBox.ItemIndex) and (ArtUniverseSwitchIn3 = MainForm.Uni3InBox.ItemIndex) and (ArtUniverseSwitchIn4 = MainForm.Uni4InBox.ItemIndex) and (ArtUniverseSwitchOut1 = MainForm.Uni1OutBox.ItemIndex) and (ArtUniverseSwitchOut2 = MainForm.Uni2OutBox.ItemIndex) and (ArtUniverseSwitchOut3 = MainForm.Uni3OutBox.ItemIndex) and (ArtUniverseSwitchOut4 = MainForm.Uni4OutBox.ItemIndex) and (ArtSubnetSwitch = MainForm.ArtSubnetBox.ItemIndex) then
  ArtLastAddressNetProg := false
 else
  ArtLastAddressNetProg := true;
UpdateArtAddressIndicator;
if ord(Buffer[106]) = $01 then
 begin
  ArtMergeEnable1 := 0;
  ArtMergeEnable2 := 0;
  ArtMergeEnable3 := 0;
  ArtMergeEnable4 := 0;
  ArtMergeIP1_A := 0;
  ArtMergeIP1_B := 0;
  ArtMergeIP2_A := 0;
  ArtMergeIP2_B := 0;
  ArtMergeIP3_A := 0;
  ArtMergeIP3_B := 0;
  ArtMergeIP4_A := 0;
  ArtMergeIP4_B := 0;
 end;
if ord(Buffer[106]) = $02 then ArtLEDIndicator := 1;
if ord(Buffer[106]) = $03 then ArtLEDIndicator := 0;
if ord(Buffer[106]) = $04 then ArtLEDIndicator := 2;
if ord(Buffer[106]) = $10 then ArtMergeMode1 := 1;
if ord(Buffer[106]) = $11 then ArtMergeMode2 := 1;
if ord(Buffer[106]) = $12 then ArtMergeMode3 := 1;
if ord(Buffer[106]) = $13 then ArtMergeMode4 := 1;
if ord(Buffer[106]) = $50 then ArtMergeMode1 := 0;
if ord(Buffer[106]) = $51 then ArtMergeMode2 := 0;
if ord(Buffer[106]) = $52 then ArtMergeMode3 := 0;
if ord(Buffer[106]) = $53 then ArtMergeMode4 := 0;
UpdateArtMergeIndicator;
for i := 0 to 511 do DMXBuf[i] := 0;
if ord(Buffer[106]) = $90 then DMXOutputSet(0, DMXBuf, 512);
if ord(Buffer[106]) = $91 then DMXOutputSet(1, DMXBuf, 512);
if ord(Buffer[106]) = $92 then DMXOutputSet(2, DMXBuf, 512);
if ord(Buffer[106]) = $93 then DMXOutputSet(3, DMXBuf, 512);
if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure ArtOpInput(SourceIp: string; Buffer: array of char; Length: integer);
begin
if Length < 20 then Exit;
if ord(Buffer[15]) = 4 then
 begin
  if (ord(Buffer[16]) and $01) = $01 then ArtEnableIn1 := false else ArtEnableIn1 := true;
  if (ord(Buffer[17]) and $01) = $01 then ArtEnableIn2 := false else ArtEnableIn2 := true;
  if (ord(Buffer[18]) and $01) = $01 then ArtEnableIn3 := false else ArtEnableIn3 := true;
  if (ord(Buffer[19]) and $01) = $01 then ArtEnableIn4 := false else ArtEnableIn4 := true;
 end;
UpdateArtInputIndicator;
if ArtPollReply_OnChange then
 if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure ArtPacketReceived(SourceIp: string; Buffer: array of char; Length: integer);
var opcode: word;
begin
if (IpstringToDword(SourceIp) and IpstringToDword(ArtSubnetmask)) <> (IpstringToDword(ArtIP) and IpstringToDword(ArtSubnetmask)) then Exit;
if Length < 10 then Exit;
if not ((Buffer[0] = 'A') and (Buffer[1] = 'r') and (Buffer[2] = 't') and (Buffer[3] = '-') and (Buffer[4] = 'N') and (Buffer[5] = 'e') and (Buffer[6] = 't') and (Buffer[7] = chr(0))) then Exit;
opcode := (ord(Buffer[9]) shl 8) or ord(Buffer[8]);
case opcode of
  $2000: ArtOpPoll(SourceIp, Buffer, Length);
  $5000: ArtOpDmx(SourceIp, Buffer, Length);
  $6000: ArtOpAddress(SourceIp, Buffer, Length);
  $7000: ArtOpInput(SourceIp, Buffer, Length);
end;
end;

procedure DMXInputChanged(Port: byte; DMXBuf: array of byte; Length: integer);
var Buffer: array[0..529] of char;
    tmp, i: dword;
    tmpb: byte;
begin
if (Port = 0) and (not (DMX_InEnable1 and ArtEnableIn1)) then Exit;
if (Port = 1) and (not (DMX_InEnable2 and ArtEnableIn2)) then Exit;
if (Port = 2) and (not (DMX_InEnable3 and ArtEnableIn3)) then Exit;
if (Port = 3) and (not (DMX_InEnable4 and ArtEnableIn4)) then Exit;
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
Buffer[13] := chr(Port); //Physical
case (Port) of
  0: tmpb := ArtUniverseSwitchIn1;
  1: tmpb := ArtUniverseSwitchIn2;
  2: tmpb := ArtUniverseSwitchIn3;
  3: tmpb := ArtUniverseSwitchIn4;
end;
Buffer[14] := chr((ArtSubnetSwitch shl 4) or tmpb); //Universe
Buffer[15] := chr($00);
Buffer[16] := chr((Length shr 8) and $FF); //Length
Buffer[17] := chr(Length and $FF);
Move(DMXBuf, Buffer[18], Length); //Data
SendArtPacket(ArtBroadcastIP, Buffer, sizeof(Buffer));
end;

procedure TMainForm.ArtNICBoxChange(Sender: TObject);
var x,y,z : byte;
    tmp: integer;
    tmpd: dword;
    ArtIP1, ArtIP2, ArtIP3, ArtSubnetmask1, ArtSubnetmask2, ArtSubnetmask3 : string;
begin
if not CheckIP(ArtCustomIP.Text) then ArtCustomIP.Text := ArtCustomIPBac;
if not CheckIP(ArtCustomSubnetmask.Text) then ArtCustomSubnetmask.Text := ArtCustomSubnetmaskBac;
ArtMAC:= ArtNICBox.Items[ArtNICBox.ItemIndex];
if length(ArtMAC) <> 17 then Exit;
x := StrToInt('$' + Copy(ArtMAC, 10, 2));
x := x + (ArtOEMCode and $00FF);
y := StrToInt('$' + Copy(ArtMAC, 13, 2));
z := StrToInt('$' + Copy(ArtMAC, 16, 2));
ArtIP1 := '2.' + IntToStr(x) + '.' + IntToStr(y) + '.' + IntToStr(z);
ArtSubnetmask1 := '255.0.0.0';
ArtIP2 := '10.' + IntToStr(x) + '.' + IntToStr(y) + '.' + IntToStr(z);
ArtSubnetmask2 := '255.0.0.0';
ArtIP3 := ArtCustomIP.Text;
ArtSubnetmask3 := ArtCustomSubnetmask.Text;
tmp := ArtNetworkBox.ItemIndex;
if tmp < 0 then tmp := 0;
ArtNetworkBox.Items.Clear;
ArtNetworkBox.Items.Add('Primary Network (' + ArtIP1 + ', ' + ArtSubnetmask1 + ')');
ArtNetworkBox.Items.Add('Secondary Network (' + ArtIP2 + ', ' + ArtSubnetmask2 + ')');
ArtNetworkBox.Items.Add('Custom Network (' + ArtIP3 + ', ' + ArtSubnetmask3 + ')');
ArtNetworkBox.ItemIndex := tmp;
if tmp = 0 then begin ArtIP := ArtIP1; ArtSubnetmask := ArtSubnetmask1; end;
if tmp = 1 then begin ArtIP := ArtIP2; ArtSubnetmask := ArtSubnetmask2; end;
if tmp = 2 then begin ArtIP := ArtIP3; ArtSubnetmask := ArtSubnetmask3; end;
tmpd := (not IpstringToDword(ArtSubnetmask)) or (IpstringToDword(ArtSubnetmask) and IpstringToDword(ArtIP));
ArtBroadcastIP := IntToStr((tmpd shr 24) and $FF) + '.' + IntToStr((tmpd shr 16) and $FF) + '.' + IntToStr((tmpd shr 8) and $FF) + '.' + IntToStr(tmpd and $FF);
SetNetwork(ArtIP, ArtSubnetmask, ArtMAC);
if ArtPollReply_OnChange then
 if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure TMainForm.UniInOutBoxChange(Sender: TObject);
begin
ArtSubnetSwitch := ArtSubnetBox.ItemIndex;
ArtUniverseSwitchOut1 := Uni1OutBox.ItemIndex;
ArtUniverseSwitchOut2 := Uni2OutBox.ItemIndex;
ArtUniverseSwitchOut3 := Uni3OutBox.ItemIndex;
ArtUniverseSwitchOut4 := Uni4OutBox.ItemIndex;
ArtUniverseSwitchIn1 := Uni1InBox.ItemIndex;
ArtUniverseSwitchIn2 := Uni2InBox.ItemIndex;
ArtUniverseSwitchIn3 := Uni3InBox.ItemIndex;
ArtUniverseSwitchIn4 := Uni4InBox.ItemIndex;
ArtLastAddressNetProg := false;
UpdateArtAddressIndicator;
if ArtPollReply_OnChange then
 if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
if (ArtInTimerCount = 0) and DMX_InEnable1 and ArtEnableIn1 then DMXInputChanged(0, DMX_InBuf1, 512);
if (ArtInTimerCount = 1) and DMX_InEnable2 and ArtEnableIn2 then DMXInputChanged(1, DMX_InBuf2, 512);
if (ArtInTimerCount = 2) and DMX_InEnable3 and ArtEnableIn3 then DMXInputChanged(2, DMX_InBuf3, 512);
if (ArtInTimerCount = 3) and DMX_InEnable4 and ArtEnableIn4 then DMXInputChanged(3, DMX_InBuf4, 512);
inc(ArtInTimerCount);
case (ArtLEDIndicator) of
 0: LEDP.Color := clBtnFace;
 1: LEDP.Color := clLime;
 2: if (ArtInTimerCount mod 2) = 0 then LEDP.Color := clRed else LEDP.Color := clBtnFace;
end;
if ArtInTimerCount = 4 then ArtInTimerCount := 0;
if (DMX_OutEnable1 <> DMX_OutEnable1_bac) or (DMX_OutEnable2 <> DMX_OutEnable2_bac) or (DMX_OutEnable3 <> DMX_OutEnable3_bac) or (DMX_OutEnable4 <> DMX_OutEnable4_bac) or (DMX_InEnable1 <> DMX_InEnable1_bac) or (DMX_InEnable2 <> DMX_InEnable2_bac) or (DMX_InEnable3 <> DMX_InEnable3_bac) or (DMX_InEnable4 <> DMX_InEnable4_bac) then
 begin
  DMX_OutEnable1_bac := DMX_OutEnable1;
  DMX_OutEnable2_bac := DMX_OutEnable2;
  DMX_OutEnable3_bac := DMX_OutEnable3;
  DMX_OutEnable4_bac := DMX_OutEnable4;
  DMX_InEnable1_bac := DMX_InEnable1;
  DMX_InEnable2_bac := DMX_InEnable2;
  DMX_InEnable3_bac := DMX_InEnable3;
  DMX_InEnable4_bac := DMX_InEnable4;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
end;
if ArtMergeCnt1_A < 11 then inc(ArtMergeCnt1_A);
if ArtMergeCnt2_A < 11 then inc(ArtMergeCnt2_A);
if ArtMergeCnt3_A < 11 then inc(ArtMergeCnt3_A);
if ArtMergeCnt4_A < 11 then inc(ArtMergeCnt4_A);
if ArtMergeCnt1_B < 11 then inc(ArtMergeCnt1_B);
if ArtMergeCnt2_B < 11 then inc(ArtMergeCnt2_B);
if ArtMergeCnt3_B < 11 then inc(ArtMergeCnt3_B);
if ArtMergeCnt4_B < 11 then inc(ArtMergeCnt4_B);
if (ArtMergeCnt1_A > 10) and (ArtMergeEnable1 = 1) then
 begin
  ArtMergeIP1_A := 0;
  ArtMergeEnable1 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(0, ArtMergeBuf1_B, ArtMergeLength1_B);
 end;
if (ArtMergeCnt1_B > 10) and (ArtMergeEnable1 = 1) then
 begin
  ArtMergeIP1_B := 0;
  ArtMergeEnable1 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(0, ArtMergeBuf1_A, ArtMergeLength1_A);
 end;
if (ArtMergeCnt2_A > 10) and (ArtMergeEnable2 = 1) then
 begin
  ArtMergeIP2_A := 0;
  ArtMergeEnable2 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(1, ArtMergeBuf2_B, ArtMergeLength2_B);
 end;
if (ArtMergeCnt2_B > 10) and (ArtMergeEnable2 = 1) then
 begin
  ArtMergeIP2_B := 0;
  ArtMergeEnable2 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(1, ArtMergeBuf2_A, ArtMergeLength2_A);
 end;
if (ArtMergeCnt3_A > 10) and (ArtMergeEnable3 = 1) then
 begin
  ArtMergeIP3_A := 0;
  ArtMergeEnable3 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(2, ArtMergeBuf3_B, ArtMergeLength3_B);
 end;
if (ArtMergeCnt3_B > 10) and (ArtMergeEnable3 = 1) then
 begin
  ArtMergeIP3_B := 0;
  ArtMergeEnable3 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(2, ArtMergeBuf3_A, ArtMergeLength3_A);
 end;
if (ArtMergeCnt4_A > 10) and (ArtMergeEnable4 = 1) then
 begin
  ArtMergeIP4_A := 0;
  ArtMergeEnable4 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(3, ArtMergeBuf4_B, ArtMergeLength4_B);
 end;
if (ArtMergeCnt4_B > 10) and (ArtMergeEnable4 = 1) then
 begin
  ArtMergeIP4_B := 0;
  ArtMergeEnable4 := 0;
  UpdateArtMergeIndicator;
  if ArtPollReply_OnChange then
   if ArtPollReply_Broadcast then ArtSendOpPollReply(ArtBroadcastIP) else ArtSendOpPollReply(ArtLastOpPollIP);
  DMXOutputSet(3, ArtMergeBuf4_A, ArtMergeLength4_A);
 end;
end;

procedure TMainForm.ArtCustomIPEnter(Sender: TObject);
begin
ArtCustomIPBac := ArtCustomIP.Text;
end;

procedure TMainForm.ArtCustomSubnetmaskEnter(Sender: TObject);
begin
ArtCustomSubnetmaskBac := ArtCustomSubnetmask.Text;
end;

procedure TMainForm.LoadState;
var IniFile: TIniFile;
begin
if not FileExists(GetCurrentDir + '\showgate.ini') then exit;
IniFile := TIniFile.Create(GetCurrentDir + '\showgate.ini');
ArtNICBox.ItemIndex := IniFile.ReadInteger('ArtNet Control', 'NICIndex', ArtNICBox.ItemIndex);
ArtNICBoxChange(ArtNICBox);
ArtSubnetBox.ItemIndex := IniFile.ReadInteger('ArtNet Control', 'SubnetIndex', ArtSubnetBox.ItemIndex);
ArtNetworkBox.ItemIndex :=  IniFile.ReadInteger('ArtNet Control', 'NetworkIndex', ArtNetworkBox.ItemIndex);
ArtNICBoxChange(ArtNetworkBox);
ArtCustomIPEnter(ArtCustomIP);
ArtCustomIP.Text :=  IniFile.ReadString('ArtNet Control', 'CustomIP', ArtCustomIP.Text);
ArtNICBoxChange(ArtCustomIP);
ArtCustomSubnetmaskEnter(ArtCustomSubnetmask);
ArtCustomSubnetmask.Text :=  IniFile.ReadString('ArtNet Control', 'CustomSubnet', ArtCustomSubnetmask.Text);
ArtNICBoxChange(ArtCustomSubnetmask);
Uni1OutBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni1OutIndex', Uni1OutBox.ItemIndex);
Uni1InBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni1InIndex', Uni1InBox.ItemIndex);
Uni2OutBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni2OutIndex', Uni2OutBox.ItemIndex);
Uni2InBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni2InIndex', Uni2InBox.ItemIndex);
Uni3OutBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni3OutIndex', Uni3OutBox.ItemIndex);
Uni3InBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni3InIndex', Uni3InBox.ItemIndex);
Uni4OutBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni4OutIndex', Uni4OutBox.ItemIndex);
Uni4InBox.ItemIndex :=  IniFile.ReadInteger('Port Control', 'Uni4InIndex', Uni4InBox.ItemIndex);
UniInOutBoxChange(ArtSubnetBox);
IfBox1DropDown(IfBox1);
IfBox1.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If1SelIndex', IfBox1.ItemIndex);
IfBox1Change(IfBox1);
IfBox2DropDown(IfBox2);
IfBox2.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If2SelIndex', IfBox2.ItemIndex);
IfBox2Change(IfBox2);
IfBox3DropDown(IfBox3);
IfBox3.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If3SelIndex', IfBox3.ItemIndex);
IfBox3Change(IfBox3);
IfBox4DropDown(IfBox4);
IfBox4.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If4SelIndex', IfBox4.ItemIndex);
IfBox4Change(IfBox4);
if IfBox1.ItemIndex =  IniFile.ReadInteger('Port Control', 'If1SelIndex', IfBox1.ItemIndex) then
begin
 IfCBox1.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If1ModeIndex', IfCBox1.ItemIndex);
 IfCBox1Change(IfCBox1);
end;
if IfBox2.ItemIndex =  IniFile.ReadInteger('Port Control', 'If2SelIndex', IfBox2.ItemIndex) then
begin
 IfCBox2.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If2ModeIndex', IfCBox2.ItemIndex);
 IfCBox2Change(IfCBox2);
end;
if IfBox3.ItemIndex =  IniFile.ReadInteger('Port Control', 'If3SelIndex', IfBox3.ItemIndex) then
begin
 IfCBox3.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If3ModeIndex', IfCBox3.ItemIndex);
 IfCBox3Change(IfCBox3);
end;
if IfBox4.ItemIndex =  IniFile.ReadInteger('Port Control', 'If4SelIndex', IfBox4.ItemIndex) then
begin
 IfCBox4.ItemIndex :=  IniFile.ReadInteger('Port Control', 'If4ModeIndex', IfCBox4.ItemIndex);
 IfCBox4Change(IfCBox4);
end;
IniFile.Free;
end;

procedure TMainForm.SaveState;
var IniFile: TIniFile;
begin
IniFile := TIniFile.Create(GetCurrentDir + '\showgate.ini');
IniFile.WriteInteger('ArtNet Control', 'NICIndex', ArtNICBox.ItemIndex);
IniFile.WriteInteger('ArtNet Control', 'SubnetIndex', ArtSubnetBox.ItemIndex);
IniFile.WriteInteger('ArtNet Control', 'NetworkIndex', ArtNetworkBox.ItemIndex);
IniFile.WriteString('ArtNet Control', 'CustomIP', ArtCustomIP.Text);
IniFile.WriteString('ArtNet Control', 'CustomSubnet', ArtCustomSubnetmask.Text);
IniFile.WriteInteger('Port Control', 'Uni1OutIndex', Uni1OutBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni1InIndex', Uni1InBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni2OutIndex', Uni2OutBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni2InIndex', Uni2InBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni3OutIndex', Uni3OutBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni3InIndex', Uni3InBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni4OutIndex', Uni4OutBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'Uni4InIndex', Uni4InBox.ItemIndex);
IniFile.WriteInteger('Port Control', 'If1SelIndex', IfBox1.ItemIndex);
IniFile.WriteInteger('Port Control', 'If2SelIndex', IfBox2.ItemIndex);
IniFile.WriteInteger('Port Control', 'If3SelIndex', IfBox3.ItemIndex);
IniFile.WriteInteger('Port Control', 'If4SelIndex', IfBox4.ItemIndex);
IniFile.WriteInteger('Port Control', 'If1ModeIndex', IfCBox1.ItemIndex);
IniFile.WriteInteger('Port Control', 'If2ModeIndex', IfCBox2.ItemIndex);
IniFile.WriteInteger('Port Control', 'If3ModeIndex', IfCBox3.ItemIndex);
IniFile.WriteInteger('Port Control', 'If4ModeIndex', IfCBox4.ItemIndex);
IniFile.Free;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
ShowMessage('(c) 2006 Michael Dreschmann' + chr(10) +
            'info@digital-enlightenment.de' + chr(10) +
            'www.digital-enlightenment.de');
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
LoadState;
end;

end.
