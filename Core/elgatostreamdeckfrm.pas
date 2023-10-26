{
  HID communication using input and output reports
  Details zum Protokoll: https://gist.github.com/cliffrowley/d18a9c4569537b195f2b1eb6c68469e0
  https://github.com/muesli/streamdeck/blob/master/streamdeck.go
  https://github.com/abcminiuser/python-elgato-streamdeck/blob/e487aff4071daa50b0303b6ce65363ec2128f7cc/src/StreamDeck/DeviceManager.py

  StreamDeck Orig, PID 0060, CmdSet v1, BMP, 72x72 Pixel, Header 16 Byte, Image Pagesize 7819 Byte, FeatureReportSize 17 Byte
  StreamDeck Mini, PID 0063, CmdSet v1, BMP, 80x80 Pixel, Header 16 Byte, Image Pagesize 1024 Byte, FeatureReportSize 17 Byte
  StreamDeck V2,   PID 006D, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
  StreamDeck MK2,  PID 0080, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
  StreamDeck XL,   PID 006C, CmdSet v2, JPG, 96x96 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte

  Firmware Revision 1:
    ReadFirmwareCmd $04
    ResetCmd $0B63
    SetBrightnessCmd $0555AAD101xx

  Firmware Revision 2:
    ReadFirmwareCmd $05
    ResetCmd $0302
    SetBrightnessCmd $0308xx


  StreamDeck MK.2: JPG, 72x72 pixel, 8-byte header, Report-Length: 1024 bytes
    - Image is transmitted in chunks of 1024 bytes
    - header is added as prefix to JPEG payload
    - structure: 8 byte header + 1016 byte payload
    Set Key image:
      00 = static 02 (identifier)
      01 = static 07 (cmd to set image)
      02 = hex-value of button-id
      03 = 0x00 = not the last message, 0x01 = last message
      04 / 05 = 16-bit little-endian value of length: f803 -> 0x03f8 = 1016
      06 / 07 = 16-bit little-endian value of the zero-based iteration, if the image is split

  StreamDeck Original: BMP, 72x72 pixel, 16-byte header, Report-Length: 8191 bytes
    Reset Key Stream: TX 8191 bytes: $02000000...
    Reset: TX 17bytes: $0B63000000...
    Brightness: TX 17bytes: $0555AAD101XX000000... with XX = Percent 00..FF
    Set Key image:
      00 = static 02 (identifier)
      01 = static 01 (cmd to set image)
      02 = PageID + 1
      03 = 0x00
      04 = 0x00 = not the last message, 0x01 = last message
      05 = hex-value of button-id + 1
      06..15 = 0x00

  StreamDeck Mini: BMP, 80x80 pixel, 16-byte header, Report-Length: 1024 bytes
    Reset Key Stream: TX 1024 bytes: $02000000...
    Reset: TX 17bytes: $0B63000000...
    Brightness: TX 17bytes: $0555AAD101XX000000... with XX = Percent 00..FF
    Set Key image:
      00 = static 02 (identifier)
      01 = static 01 (cmd to set image)
      02 = PageID + 1
      03 = 0x00
      04 = 0x00 = not the last message, 0x01 = last message
      05 = hex-value of button-id + 1
      06..15 = 0x00
}

unit elgatostreamdeckfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponentBase, JvHidControllerClass, Hid, jpeg,
  ExtCtrls, gnugettext, Mask, JvExMask, JvSpin, pcdutils, GR32, pngimage,
  befehleditorform2, Buttons, PngBitBtn;

type
  TReportA = packed record
    Header: array [0..15] of byte;
    Data: array [0..8174] of byte;
  end;
  TReportB = packed record
    Header: array [0..15] of byte;
    Data: array [0..1007] of byte;
  end;
  TReportC = packed record
    Header: array [0..7] of byte;
    Data: array [0..1015] of byte;
  end;
  Telgatostreamdeckform = class(TForm)
    devicelistbox: TListBox;
    Label1: TLabel;
    brightnessbar: TScrollBar;
    Label3: TLabel;
    PaintBox1: TPaintBox;
    ElgatoStreamDeckTimer: TTimer;
    GroupBox1: TGroupBox;
    Button1: TButton;
    btnlabel: TLabel;
    btntype: TComboBox;
    Label4: TLabel;
    panelbtnx: TJvSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    panelbtny: TJvSpinEdit;
    deviceorgroupid: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    datainchannel: TJvSpinEdit;
    selectmodecheckbox: TCheckBox;
    Label9: TLabel;
    useholdcheckbox: TCheckBox;
    Label2: TLabel;
    incrementedit: TJvSpinEdit;
    editbtn: TPngBitBtn;
    ElgatoStreamDeckDisplayTimer: TTimer;
    Panel1: TPanel;
    procedure brightnessbarChange(Sender: TObject);
    procedure ElgatoStreamDeckTimerTimer(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure panelbtnxChange(Sender: TObject);
    procedure panelbtnyChange(Sender: TObject);
    procedure datainchannelChange(Sender: TObject);
    procedure deviceorgroupidChange(Sender: TObject);
    procedure btntypeChange(Sender: TObject);
    procedure selectmodecheckboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure devicelistboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure devicelistboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editbtnClick(Sender: TObject);
    procedure useholdcheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure useholdcheckboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure incrementeditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ElgatoStreamDeckDisplayTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    SelectedDevice, SelectedButton:integer;
    pngobject:TPNGObject;
    _Buffer: TBitmap32;
    procedure SetKeyBitmap(DeviceIndex: integer; ButtonIndex:byte; Bitmap: TBitmap32);
  public
    { Public-Deklarationen }
    TotalPayloadBuffer: array of array of array of byte; // Devices, Buttons, Data
    TotalPayloadBuffer_ReadyToSend: array of array of boolean;
    procedure MSGNew;
    procedure MSGOpen;
    procedure SetBrightness(Serial: string; Percent: byte);
    procedure ResetStreamDeck(Serial: string);
  end;

var
  elgatostreamdeckform: Telgatostreamdeckform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure RotateBitmap(Bmp: TBitmap; Rads: Single; AdjustSize: Boolean;
  BkColor: TColor = clNone);
var
  C: Single;
  S: Single;
  XForm: tagXFORM;
  Tmp: TBitmap;
begin
  C := Cos(Rads);
  S := Sin(Rads);
  XForm.eM11 := C;
  XForm.eM12 := S;
  XForm.eM21 := -S;
  XForm.eM22 := C;
  Tmp := TBitmap.Create;
  try
    Tmp.TransparentColor := Bmp.TransparentColor;
    Tmp.TransparentMode := Bmp.TransparentMode;
    Tmp.Transparent := Bmp.Transparent;
    Tmp.Canvas.Brush.Color := BkColor;
    if AdjustSize then
    begin
      Tmp.Width := Round(Bmp.Width * Abs(C) + Bmp.Height * Abs(S));
      Tmp.Height := Round(Bmp.Width * Abs(S) + Bmp.Height * Abs(C));
      XForm.eDx := (Tmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      XForm.eDy := (Tmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end
    else
    begin
      Tmp.Width := Bmp.Width;
      Tmp.Height := Bmp.Height;
      XForm.eDx := (Bmp.Width - Bmp.Width * C + Bmp.Height * S) / 2;
      XForm.eDy := (Bmp.Height - Bmp.Width * S - Bmp.Height * C) / 2;
    end;
    SetGraphicsMode(Tmp.Canvas.Handle, GM_ADVANCED);
    SetWorldTransform(Tmp.Canvas.Handle, XForm);
    BitBlt(Tmp.Canvas.Handle, 0, 0, Tmp.Width, Tmp.Height, Bmp.Canvas.Handle,
      0, 0, SRCCOPY);
    Bmp.Assign(Tmp);
  finally
    Tmp.Free;
  end;
end;

procedure Telgatostreamdeckform.MSGNew;
begin
  mainform.HidCtlDeviceChange(nil);
end;

procedure Telgatostreamdeckform.MSGOpen;
begin
  //
end;

procedure Telgatostreamdeckform.SetKeyBitmap(DeviceIndex: integer; ButtonIndex:byte; Bitmap: TBitmap32);
var
  bmp:TBitMap;
  JPEGImage:TJPEGImage;
  Stream: TMemoryStream;
  PID:Word;
begin
  PID:=mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Attributes.ProductID;

  bmp:=TBitmap.Create;
  if (PID=$0060) then
  begin
    // StreamDeck Original
    // BMP and flip horizontally
    Bitmap.FlipHorz(Bitmap);

    // convert the BMP to byte-array
    try
      //Bitmap.PixelFormat:=pf24bit;
      bmp.Assign(Bitmap); // convert Bitmap32 to Bitmap

      Stream:=TMemoryStream.Create;
      bmp.SaveToStream(Stream);

      if DeviceIndex>=length(TotalPayloadBuffer) then
        setlength(TotalPayloadBuffer, DeviceIndex+1);
      if DeviceIndex>=length(TotalPayloadBuffer_ReadyToSend) then
        setlength(TotalPayloadBuffer_ReadyToSend, DeviceIndex+1);

      if ButtonIndex>=length(TotalPayloadBuffer[DeviceIndex]) then
        setlength(TotalPayloadBuffer[DeviceIndex], ButtonIndex+1);
      if ButtonIndex>=length(TotalPayloadBuffer_ReadyToSend[DeviceIndex]) then
        setlength(TotalPayloadBuffer_ReadyToSend[DeviceIndex], ButtonIndex+1);

      setlength(TotalPayloadBuffer[DeviceIndex][ButtonIndex], Stream.Size);
      Stream.Position:=0;
      Stream.Read(TotalPayloadBuffer[DeviceIndex][ButtonIndex][0], Stream.Size);

      // set ReadyToSend-flag for HelperThread
      TotalPayloadBuffer_ReadyToSend[DeviceIndex][ButtonIndex]:=true;
    finally
      bmp.Free;
    end;
    Stream.Free;
  end else if (PID=$0063) then
  begin
    // StreamDeck Mini
    // BMP and rotate counterclockwise
    Bitmap.Rotate270(Bitmap);

    // convert the BMP to byte-array
    try
      //Bitmap.PixelFormat:=pf24bit;
      bmp.Assign(Bitmap); // convert Bitmap32 to Bitmap

      Stream:=TMemoryStream.Create;
      bmp.SaveToStream(Stream);

      if DeviceIndex>=length(TotalPayloadBuffer) then
        setlength(TotalPayloadBuffer, DeviceIndex+1);
      if DeviceIndex>=length(TotalPayloadBuffer_ReadyToSend) then
        setlength(TotalPayloadBuffer_ReadyToSend, DeviceIndex+1);

      if ButtonIndex>=length(TotalPayloadBuffer[DeviceIndex]) then
        setlength(TotalPayloadBuffer[DeviceIndex], ButtonIndex+1);
      if ButtonIndex>=length(TotalPayloadBuffer_ReadyToSend[DeviceIndex]) then
        setlength(TotalPayloadBuffer_ReadyToSend[DeviceIndex], ButtonIndex+1);

      setlength(TotalPayloadBuffer[DeviceIndex][ButtonIndex], Stream.Size);
      Stream.Position:=0;
      Stream.Read(TotalPayloadBuffer[DeviceIndex][ButtonIndex][0], Stream.Size);

      // set ReadyToSend-flag for HelperThread
      TotalPayloadBuffer_ReadyToSend[DeviceIndex][ButtonIndex]:=true;
    finally
      bmp.Free;
    end;
    Stream.Free;
  end else
  begin
    // All other StreamDecks, JPG, flip horizontally and vertically
    Bitmap.FlipHorz(Bitmap);
    Bitmap.FlipVert(Bitmap);

    // convert the JPEG to byte-array
    JPEGImage:=TJPEGImage.Create;
    try
      JPEGImage.Performance:=jpBestSpeed;//jpBestQuality;
      JPEGImage.ProgressiveEncoding:=false;
      JPEGImage.ProgressiveDisplay:=false;
      //Bitmap.PixelFormat:=pf24bit;
      bmp.Assign(Bitmap); // convert Bitmap32 to Bitmap
      JPEGImage.Assign(bmp); // convert Bitmap to JPEG
      JPEGImage.CompressionQuality:=100;
      JPEGImage.Compress;

      Stream:=TMemoryStream.Create;
      JPEGImage.SaveToStream(Stream);

      if DeviceIndex>=length(TotalPayloadBuffer) then
        setlength(TotalPayloadBuffer, DeviceIndex+1);
      if DeviceIndex>=length(TotalPayloadBuffer_ReadyToSend) then
        setlength(TotalPayloadBuffer_ReadyToSend, DeviceIndex+1);

      if ButtonIndex>=length(TotalPayloadBuffer[DeviceIndex]) then
        setlength(TotalPayloadBuffer[DeviceIndex], ButtonIndex+1);
      if ButtonIndex>=length(TotalPayloadBuffer_ReadyToSend[DeviceIndex]) then
        setlength(TotalPayloadBuffer_ReadyToSend[DeviceIndex], ButtonIndex+1);

      setlength(TotalPayloadBuffer[DeviceIndex][ButtonIndex], Stream.Size);
      Stream.Position:=0;
      Stream.Read(TotalPayloadBuffer[DeviceIndex][ButtonIndex][0], Stream.Size);

      // set ReadyToSend-flag for HelperThread
      TotalPayloadBuffer_ReadyToSend[DeviceIndex][ButtonIndex]:=true;
    finally
      JPEGImage.Free;
      bmp.Free;
    end;
    Stream.Free;
  end;
end;

procedure Telgatostreamdeckform.SetBrightness(Serial: string; Percent: byte);
var
  i, DeviceIndex:integer;
  TxBuffer_Rev1: array[0..16] of byte;
  TxBuffer_Rev2: array[0..31] of byte;
  PID:Word;
begin
  DeviceIndex:=-1;
  for i:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    if mainform.ElgatoStreamDeckArray[i].Serial=Serial then
    begin
      DeviceIndex:=i;
      break;
    end;
  end;

  if DeviceIndex>-1 then
  begin
    PID:=mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Attributes.ProductID;

    {
      StreamDeck Orig, PID 0060, CmdSet v1, BMP, 72x72 Pixel, Header 16 Byte, Image Pagesize 7819 Byte, FeatureReportSize 17 Byte
      StreamDeck Mini, PID 0063, CmdSet v1, BMP, 80x80 Pixel, Header 16 Byte, Image Pagesize 1024 Byte, FeatureReportSize 17 Byte
      StreamDeck V2,   PID 006D, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
      StreamDeck MK2,  PID 0080, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
      StreamDeck XL,   PID 006C, CmdSet v2, JPG, 96x96 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte

      Firmware Revision 1
        ReadFirmwareCmd $04
        ResetCmd $0B63
        SetBrightnessCmd $0555AAD101

      Firmware Revision 2
        ReadFirmwareCmd $05
        ResetCmd $0302
        SetBrightnessCmd $0308
    }

    if (PID=$0060) or (PID=$0063) then
    begin
      // StreamDeck Original or Mini -> Firmware Rev1
      TxBuffer_Rev1[0]:=$05;
      TxBuffer_Rev1[1]:=$55;
      TxBuffer_Rev1[2]:=$AA;
      TxBuffer_Rev1[3]:=$D1;
      TxBuffer_Rev1[4]:=$01;
      TxBuffer_Rev1[5]:=Percent;
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.SetFeature(TxBuffer_Rev1, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.FeatureReportByteLength);
    end else if (PID=$006C) or (PID=$006D) or (PID=$0080) then
    begin
      // StreamDeck XL or V2 or MK2 -> Firmware Rev2
      TxBuffer_Rev2[0]:=$03;
      TxBuffer_Rev2[1]:=$08;
      TxBuffer_Rev2[2]:=Percent;
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.SetFeature(TxBuffer_Rev2, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.FeatureReportByteLength);
    end;
  end;
end;

procedure Telgatostreamdeckform.ResetStreamDeck(Serial: string);
var
  i, DeviceIndex:integer;
  TxBuffer_Rev1: array[0..16] of byte;
  TxBuffer_Rev2: array[0..31] of byte;
  PID:Word;
begin
  DeviceIndex:=-1;
  for i:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    if mainform.ElgatoStreamDeckArray[i].Serial=Serial then
    begin
      DeviceIndex:=i;
      break;
    end;
  end;

  if DeviceIndex>-1 then
  begin
    PID:=mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Attributes.ProductID;
    
    {
      StreamDeck Orig, PID 0060, CmdSet v1, BMP, 72x72 Pixel, Header 16 Byte, Image Pagesize 7819 Byte, FeatureReportSize 17 Byte
      StreamDeck Mini, PID 0063, CmdSet v1, BMP, 80x80 Pixel, Header 16 Byte, Image Pagesize 1024 Byte, FeatureReportSize 17 Byte
      StreamDeck V2,   PID 006D, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
      StreamDeck MK2,  PID 0080, CmdSet v2, JPG, 72x72 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte
      StreamDeck XL,   PID 006C, CmdSet v2, JPG, 96x96 Pixel, Header 8 Byte, Image Pagesize 1024 Byte, FeatureReportSize 32 Byte

      Firmware Revision 1
        ReadFirmwareCmd $04
        ResetCmd $0B63
        SetBrightnessCmd $0555AAD101

      Firmware Revision 2
        ReadFirmwareCmd $05
        ResetCmd $0302
        SetBrightnessCmd $0308
    }

    if (PID=$0060) or (PID=$0063) then
    begin
      // StreamDeck Original or Mini -> Firmware Rev1
      TxBuffer_Rev1[0]:=$0B;
      TxBuffer_Rev1[1]:=$63;
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.SetFeature(TxBuffer_Rev1, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.FeatureReportByteLength);
    end else if (PID=$006C) or (PID=$006D) or (PID=$0080) then
    begin
      // StreamDeck XL or V2 or MK2 -> Firmware Rev2
      TxBuffer_Rev2[0]:=$03;
      TxBuffer_Rev2[1]:=$03;
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.SetFeature(TxBuffer_Rev2, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.FeatureReportByteLength);
    end;
  end;
end;

procedure Telgatostreamdeckform.brightnessbarChange(Sender: TObject);
begin
  if devicelistbox.ItemIndex>-1 then
  begin
    SetBrightness(mainform.ElgatoStreamSerials[devicelistbox.ItemIndex], brightnessbar.Position);
    if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
      mainform.ElgatoStreamDeckArray[SelectedDevice].Brightness:=brightnessbar.Position;
  end;
end;

function InvertColor(const Color: TColor): TColor;
begin
    result := TColor(Windows.RGB(255 - GetRValue(Color),
                                 255 - GetGValue(Color),
                                 255 - GetBValue(Color)));
end;

procedure Telgatostreamdeckform.ElgatoStreamDeckTimerTimer(
  Sender: TObject);
var
  dev, btn:integer;
  CurrentButtonMode:byte;
begin
  // send values to DataIn or Befehl
  for dev:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  for btn:=0 to mainform.ElgatoStreamDeckArray[dev].ButtonCount-1 do
  begin
    if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Pressed and mainform.ElgatoStreamDeckArray[dev].Buttons[btn].UseHoldToChange then
    begin
      if (mainform.ElgatoStreamDeckArray[dev].UseAutoModeOnLastButton) then
      begin
        CurrentButtonMode:=mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode;
      end else
      begin
        CurrentButtonMode:=mainform.ElgatoStreamDeckArray[dev].Buttons[btn].ButtonType;
      end;

      if (CurrentButtonMode=3) or (CurrentButtonMode=4) then
      begin
        mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue:=mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue+mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Increment;
      end;

      if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue>255 then
        mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue:=255
      else if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue<0 then
        mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue:=0;

      case CurrentButtonMode of
        3: // DataIn
        begin
          mainform.ExecuteDataInEvent(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DataInChannel, mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue);
        end;
        4: // Befehl
        begin
          mainform.StartBefehl(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Befehl.ID, mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue);
        end;
      end;
    end;
  end;
end;

procedure Telgatostreamdeckform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, dev, DeviceIndex:integer;
begin
  if (devicelistbox.ItemIndex>-1) and (devicelistbox.ItemIndex<length(mainform.ElgatoStreamSerials)) then
  begin
    DeviceIndex:=-1;
    for dev:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
    begin
      if mainform.ElgatoStreamDeckArray[dev].Serial=mainform.ElgatoStreamSerials[devicelistbox.ItemIndex] then
      begin
        DeviceIndex:=dev;
        break;
      end;
    end;

    if DeviceIndex>-1 then
    begin
      SelectedDevice:=DeviceIndex;
      if (mainform.ElgatoStreamDeckArray[DeviceIndex].ButtonCount=6) then
      begin
        SelectedButton:=trunc(X/80)+trunc(Y/80)*3;
      end else if (mainform.ElgatoStreamDeckArray[DeviceIndex].ButtonCount=15) then
      begin
        SelectedButton:=trunc(X/72)+trunc(Y/72)*5;
      end else if (mainform.ElgatoStreamDeckArray[DeviceIndex].ButtonCount=32) then
      begin
        SelectedButton:=trunc(X/96)+trunc(Y/96)*8;
      end;
    end;

    brightnessbar.Position:=mainform.ElgatoStreamDeckArray[DeviceIndex].Brightness;
    selectmodecheckbox.Checked:=mainform.ElgatoStreamDeckArray[DeviceIndex].UseAutoModeOnLastButton;

    btnlabel.Caption:=_('Funktion Button ')+inttostr(SelectedButton+1);
    btntype.ItemIndex:=mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].ButtonType;
    if mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelX<1 then
      mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelX:=1;
    if mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelY<1 then
      mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelY:=1;
    panelbtnx.Value:=mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelX;
    panelbtny.Value:=mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].KontrollpanelY;
    if mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].DataInChannel<1 then
      mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].DataInChannel:=1;
    datainchannel.Value:=mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].DataInChannel;
    useholdcheckbox.Checked:=mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].UseHoldToChange;
    incrementedit.Value:=abs(mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].Increment);
    deviceorgroupid.Items.Clear;
    for i:=0 to length(mainform.Devices)-1 do
    begin
      deviceorgroupid.Items.Add(mainform.Devices[i].Name+' '+mainform.Devices[i].Beschreibung);
      if IsEqualGUID(mainform.Devices[i].ID, mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].DeviceOrGroupID) then
      begin
        deviceorgroupid.ItemIndex:=i;
      end;
    end;
    for i:=0 to length(mainform.DeviceGroups)-1 do
    begin
      deviceorgroupid.Items.Add(_('Gruppe')+': '+mainform.DeviceGroups[i].Name+' '+mainform.DeviceGroups[i].Beschreibung);
      if IsEqualGUID(mainform.DeviceGroups[i].ID, mainform.ElgatoStreamDeckArray[DeviceIndex].Buttons[SelectedButton].DeviceOrGroupID) then
      begin
        deviceorgroupid.ItemIndex:=i;
      end;
    end;
  end;
end;

procedure Telgatostreamdeckform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Telgatostreamdeckform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  pngobject:=TPNGObject.Create;
  _Buffer:=TBitmap32.Create;
end;

procedure Telgatostreamdeckform.panelbtnxChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].KontrollpanelX:=round(panelbtnx.value);
end;

procedure Telgatostreamdeckform.panelbtnyChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].KontrollpanelY:=round(panelbtny.value);
end;

procedure Telgatostreamdeckform.datainchannelChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].DataInChannel:=round(datainchannel.value);
end;

procedure Telgatostreamdeckform.deviceorgroupidChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
  begin
    if (deviceorgroupid.Items.Count=(length(mainform.Devices)+length(mainform.DeviceGroups))) and (deviceorgroupid.ItemIndex<length(mainform.Devices)) then
    begin
      // we have a device
      if deviceorgroupid.ItemIndex<length(mainform.Devices) then
        mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].DeviceOrGroupID:=mainform.Devices[deviceorgroupid.ItemIndex].ID;
    end else
    begin
      // we have a group
      if (deviceorgroupid.ItemIndex-length(mainform.Devices))<length(mainform.DeviceGroups) then
        mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].DeviceOrGroupID:=mainform.DeviceGroups[deviceorgroupid.ItemIndex-length(mainform.Devices)].ID;
    end;
  end;
end;

procedure Telgatostreamdeckform.btntypeChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].ButtonType:=btntype.ItemIndex;
end;

procedure Telgatostreamdeckform.selectmodecheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
  begin
    mainform.ElgatoStreamDeckArray[SelectedDevice].UseAutoModeOnLastButton:=selectmodecheckbox.Checked;
    mainform.ElgatoStreamDeckArray[SelectedDevice].CurrentButtonMode:=1; // start in Kontrollboxmode
  end;
end;

procedure Telgatostreamdeckform.devicelistboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
  begin
    brightnessbar.Position:=mainform.ElgatoStreamDeckArray[SelectedDevice].Brightness;
    selectmodecheckbox.Checked:=mainform.ElgatoStreamDeckArray[SelectedDevice].UseAutoModeOnLastButton;
  end;
end;

procedure Telgatostreamdeckform.devicelistboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
  begin
    brightnessbar.Position:=mainform.ElgatoStreamDeckArray[SelectedDevice].Brightness;
    selectmodecheckbox.Checked:=mainform.ElgatoStreamDeckArray[SelectedDevice].UseAutoModeOnLastButton;
  end;
end;

procedure Telgatostreamdeckform.editbtnClick(Sender: TObject);
var
  i:integer;
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
  begin
    setlength(befehlseditor_array2,length(befehlseditor_array2)+1);
    befehlseditor_array2[length(befehlseditor_array2)-1]:=Tbefehlseditor2.Create(self);
    befehlseditor_array2[length(befehlseditor_array2)-1].CheckBox1.Visible:=false;
    befehlseditor_array2[length(befehlseditor_array2)-1].ShowInputValueToo:=true;

    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ID:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ID;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Typ;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Name;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Beschreibung;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.OnValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.SwitchValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.InvertSwitchValue:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.InvertSwitchValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.OffValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ScaleValue;
    befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.RunOnProjectLoad:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.RunOnProjectLoad;

    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger,length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgInteger));
    for i:=0 to length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgInteger)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[i]:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgInteger[i];
    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString,length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgString));
    for i:=0 to length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgString)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[i]:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgString[i];
    setlength(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID,length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgGUID));
    for i:=0 to length(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgGUID)-1 do
      befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[i]:=mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgGUID[i];

    befehlseditor_array2[length(befehlseditor_array2)-1].ShowModal;

    if befehlseditor_array2[length(befehlseditor_array2)-1].ModalResult=mrOK then
    begin
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Typ:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Typ;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Name:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Name;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.Beschreibung:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.Beschreibung;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.OnValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OnValue;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.SwitchValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.SwitchValue;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.InvertSwitchValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.InvertSwitchValue;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.OffValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.OffValue;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ScaleValue:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ScaleValue;
      mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.RunOnProjectLoad:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.RunOnProjectLoad;
      setlength(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgInteger,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger)-1 do
        mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgInteger[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgInteger[i];
      setlength(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgString,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString)-1 do
        mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgString[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgString[i];
      setlength(mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgGUID,length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID));
      for i:=0 to length(befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID)-1 do
        mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Befehl.ArgGUID[i]:=befehlseditor_array2[length(befehlseditor_array2)-1].AktuellerBefehl.ArgGUID[i];
    end;

    befehlseditor_array2[length(befehlseditor_array2)-1].Free;
    setlength(befehlseditor_array2,length(befehlseditor_array2)-1);
  end;
end;

procedure Telgatostreamdeckform.useholdcheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].UseHoldToChange:=useholdcheckbox.Checked;
end;

procedure Telgatostreamdeckform.useholdcheckboxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].UseHoldToChange:=useholdcheckbox.Checked;
end;

procedure Telgatostreamdeckform.incrementeditChange(Sender: TObject);
begin
  if SelectedDevice<length(mainform.ElgatoStreamDeckArray) then
    mainform.ElgatoStreamDeckArray[SelectedDevice].Buttons[SelectedButton].Increment:=round(incrementedit.value);
end;

procedure Telgatostreamdeckform.FormDestroy(Sender: TObject);
begin
  _Buffer.Free;
end;

procedure Telgatostreamdeckform.ElgatoStreamDeckDisplayTimerTimer(
  Sender: TObject);
var
  dev, dev_check, btn, x, y, DeviceIndex, i, l, k:integer;
  ButtonPixels:byte;
  topval,leftval:integer;
  rect:TRect;
  Dimmerwert:integer;
  DrawEmptyButton:boolean;
  CurrentButtonMode:byte;
  Text_PCD_Function, Text_Function, Text_Value:string;
  Value:integer;
begin
  // display values on buttons
  for dev:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    // check, if this device is connected
    for dev_check:=0 to length(mainform.ElgatoStreamSerials)-1 do
    begin
      if (mainform.ElgatoStreamSerials[dev_check]=mainform.ElgatoStreamDeckArray[dev].Serial) then
      begin
        // this device is connected
        
        if mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode=0 then
          mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode:=1;

        if (mainform.ElgatoStreamDeckArray[dev].ButtonCount=32) then
        begin
          // StreamDeck XL
          ButtonPixels:=96;
        end else if (mainform.ElgatoStreamDeckArray[dev].ButtonCount=15) then
        begin
          // StreamDeck Standard
          ButtonPixels:=72;
        end else
        begin
          // StreamDeck Mini
          ButtonPixels:=80;
        end;
        _Buffer.Width:=ButtonPixels;
        _Buffer.Height:=ButtonPixels;

        for btn:=0 to mainform.ElgatoStreamDeckArray[dev].ButtonCount-1 do
        begin
          DrawEmptyButton:=false;

          if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Pressed then
            _Buffer.Canvas.Brush.Color:=clRed
          else
            _Buffer.Canvas.Brush.Color:=clNavy;

          if (mainform.ElgatoStreamDeckArray[dev].UseAutoModeOnLastButton) and (btn<mainform.ElgatoStreamDeckArray[dev].ButtonCount-1) then
            CurrentButtonMode:=mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode
          else
            CurrentButtonMode:=mainform.ElgatoStreamDeckArray[dev].Buttons[btn].ButtonType;

          // check if we want to use Mode-switcher on last button -> if yes, show current mode on this button
          if (mainform.ElgatoStreamDeckArray[dev].UseAutoModeOnLastButton) and (btn=mainform.ElgatoStreamDeckArray[dev].ButtonCount-1) then
          begin
            // show AutoMode-Button and current AutoMode
            _Buffer.Canvas.Brush.Color:=clMaroon;
            _Buffer.Canvas.Brush.Style:=bsSolid;
            _Buffer.Canvas.Pen.Color:=clBlack;
            _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

            _Buffer.Canvas.Font.Color:=clWhite;
            _Buffer.Canvas.TextOut(1,0,TimeToStr(now));
            case mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode of
              1:
              begin
                _Buffer.Canvas.TextOut(1,18,'  > '+_('Panels')+' <');
                _Buffer.Canvas.TextOut(1,30,'  '+_('Selektion')+'');
                _Buffer.Canvas.TextOut(1,42,'  '+_('Data-In')+'');
                _Buffer.Canvas.TextOut(1,54,'  '+_('Befehle')+'');
              end;
              2:
              begin
                _Buffer.Canvas.TextOut(1,18,'  '+_('Panels')+'');
                _Buffer.Canvas.TextOut(1,30,'  > '+_('Selektion')+' <');
                _Buffer.Canvas.TextOut(1,42,'  '+_('Data-In')+'');
                _Buffer.Canvas.TextOut(1,54,'  '+_('Befehle')+'');
              end;
              3:
              begin
                _Buffer.Canvas.TextOut(1,18,'  '+_('Panels')+'');
                _Buffer.Canvas.TextOut(1,30,'  '+_('Selektion')+'');
                _Buffer.Canvas.TextOut(1,42,'  > '+_('Data-In')+' <');
                _Buffer.Canvas.TextOut(1,54,'  '+_('Befehle')+'');
              end;
              4:
              begin
                _Buffer.Canvas.TextOut(1,18,'  '+_('Panels')+'');
                _Buffer.Canvas.TextOut(1,30,'  '+_('Selektion')+'');
                _Buffer.Canvas.TextOut(1,42,'  '+_('Data-In')+'');
                _Buffer.Canvas.TextOut(1,54,'  > '+_('Befehle')+' <');
              end;
            end;
            _Buffer.Canvas.Brush.Color:=clNavy;
          end else
          begin
            case CurrentButtonMode of
              0: // unused
              begin
                DrawEmptyButton:=true;
              end;
              1: // 1=Kontrollpanel
              begin
                _Buffer.Canvas.Brush.Style:=bsSolid;
                if ((mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1)>-1) and ((mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1)<length(mainform.kontrollpanelbuttons)) then
                begin
                  if ((mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1)>-1) and ((mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1)<length(mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1])) then
                  begin
                    // draw colored button
                    _Buffer.Canvas.Brush.Color:=mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Color;
                    if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Pressed then
                      _Buffer.Canvas.Brush.Color:=clNavy;

                    _Buffer.Canvas.Pen.Color:=_Buffer.Canvas.Brush.Color;
                    _Buffer.Canvas.Rectangle(0,24,ButtonPixels,ButtonPixels);

                    // first 24 pixels leave white to make the text crisp
                    if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Pressed then
                      _Buffer.Canvas.Brush.Color:=clWhite
                    else
                      _Buffer.Canvas.Brush.Color:=clNavy;
                    _Buffer.Canvas.Pen.Color:=_Buffer.Canvas.Brush.Color;
                    _Buffer.Canvas.Rectangle(0,0,ButtonPixels,25);

                    // Bild zeichnen
                    rect.Top:=20;
                    rect.Left:=12;
                    rect.right:=12+48;
                    rect.Bottom:=20+48;
                    try
                      if Assigned(mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].PNG) and (mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Picture<>'') then
                      begin
                        pngobject.Assign(mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].PNG);
                        SmoothResize(pngobject, 48, 48);
                        pngobject.Draw(_Buffer.Canvas, rect);
                      end;
                    except
                    end;

                    if mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Active then
                    begin
                      _Buffer.Canvas.Font.Color:=InvertColor(_Buffer.Canvas.Brush.Color);
                      _Buffer.Canvas.Font.Style:=[fsBold];
                      _Buffer.Canvas.TextOut(1,0,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Name);
                      _Buffer.Canvas.TextOut(1,12,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].TypName);
                      _Buffer.Canvas.TextOut(1,24,'');
                      _Buffer.Canvas.Font.Style:=[];

                      _Buffer.Canvas.Brush.Color:=clRed;
                      _Buffer.Canvas.Pen.Color:=clBlack;
                      _Buffer.Canvas.Rectangle(0, ButtonPixels-10, ButtonPixels, ButtonPixels);
                    end else
                    begin
                      _Buffer.Canvas.Font.Color:=InvertColor(_Buffer.Canvas.Brush.Color);
                      _Buffer.Canvas.TextOut(1,0,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Name);
                      _Buffer.Canvas.TextOut(1,12,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].TypName);
                      _Buffer.Canvas.TextOut(1,24,'');
                    end;
                  end else
                  begin
                    DrawEmptyButton:=true;
                  end;
                end else
                begin
                  DrawEmptyButton:=true;
                end;
              end;
              2: // 2=DeviceOrGroupSelection
              begin
                DeviceIndex:=geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DeviceOrGroupID);
                if DeviceIndex>-1 then
                begin
                  // its a device
                  _Buffer.Canvas.Brush.Style:=bsSolid;
                  _Buffer.Canvas.Pen.Color:=clBlack;
                  _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                  // Bild zeichnen
                  rect.Top:=16;
                  rect.Left:=12;
                  rect.right:=12+48;
                  rect.Bottom:=16+48;
                  try
                    pngobject.Assign(mainform.devicepictures96.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[DeviceIndex].bildadresse)].PngImage);
                    SmoothResize(pngobject, 48, 48);
                    pngobject.Draw(_Buffer.Canvas, rect);
                  except
                  end;

                  _Buffer.Canvas.Font.Color:=clWhite;
                  _Buffer.Canvas.TextOut(1,0,mainform.devices[DeviceIndex].Name);
                  _Buffer.Canvas.TextOut(1,12,'Ch '+inttostr(mainform.devices[DeviceIndex].Startaddress));

                  if mainform.Devices[DeviceIndex].hasDimmer then
                  begin
                    Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
                    // Umrandung zeichnen
                    _Buffer.Canvas.Brush.Color:=ClMedGray;
                    _Buffer.Canvas.Pen.Style:=psSolid;
                    _Buffer.Canvas.Pen.Color:=clBlack;
                    _Buffer.Canvas.Rectangle(0, ButtonPixels-10, ButtonPixels, ButtonPixels);

                    // Hintergrund zeichnen
                    _Buffer.Canvas.Pen.Color:=clSilver;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-9);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-9);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-8);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-8);
                    _Buffer.Canvas.Pen.Color:=clMedGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-7);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-7);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-6);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-6);
                    _Buffer.Canvas.Pen.Color:=clGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-5);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-5);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-4);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-4);
                    _Buffer.Canvas.Pen.Color:=clGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-3);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-3);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-2);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-2);
                    _Buffer.Canvas.Pen.Color:=clMedGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-1);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-1);
                    // Füllung zeichnen
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,128);//$00FFFFFF;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-9);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-9);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-8);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-8);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,192);//$00A4FFA4;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-7);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-7);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-6);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-6);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,255);//$0000FF00;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-5);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-5);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-4);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-4);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,96);//$0000B000;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-3);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-3);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-2);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-2);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,64);//$00008000;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-1);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-1);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels);

                    // Wert in Prozent anzeigen
                    _Buffer.Canvas.Brush.Style:=bsClear;
                    _Buffer.Canvas.Pen.Style:=psClear;
                    _Buffer.Canvas.Font.Color:=clWhite;
                    _Buffer.Canvas.TextOut(1, ButtonPixels-12-10, mainform.levelstr(Dimmerwert));
                    _Buffer.Canvas.Pen.Style:=psSolid;
                  end;

                  // Farbball anzeigen
                  _Buffer.Canvas.Brush.Style:=bsSolid;
                  _Buffer.Canvas.Pen.Style:=psSolid;
                  _Buffer.Canvas.Pen.Color:=clBlack;

                  _Buffer.Canvas.Brush.Color:=geraetesteuerung.get_color(mainform.devices[DeviceIndex].ID);

                  if mainform.devices[DeviceIndex].hasPANTILT then
                  begin
                      Topval:=round((ButtonPixels*(geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID, 'TILT')/255))-(ButtonPixels/3.2/2));
                      Leftval:=round(ButtonPixels-(ButtonPixels*((255-geraetesteuerung.get_channel(mainform.devices[DeviceIndex].ID, 'PAN'))/255))+(ButtonPixels/3.2/2));
                      _Buffer.Canvas.Ellipse(Leftval-round(ButtonPixels/3.2), Topval, Leftval, Topval+round(ButtonPixels/3.2));
                  end else
                  begin
                      _Buffer.Canvas.Ellipse(ButtonPixels-round(ButtonPixels/3.4), ButtonPixels-round(ButtonPixels/3.4)-5, ButtonPixels, ButtonPixels-5);
                  end;
                end else
                begin
                  DeviceIndex:=geraetesteuerung.GetGroupPositionInGroupArray(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DeviceOrGroupID);
                  if DeviceIndex>-1 then
                  begin
                    // its a group
                    _Buffer.Canvas.Brush.Style:=bsSolid;
                    _Buffer.Canvas.Pen.Color:=clBlack;
                    _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                    _Buffer.Canvas.Font.Color:=clWhite;
                    _Buffer.Canvas.TextOut(1,0,mainform.DeviceGroups[DeviceIndex].Name);
                    _Buffer.Canvas.TextOut(1,12,_('Gruppe'));


                    Dimmerwert:=geraetesteuerung.get_group(mainform.DeviceGroups[DeviceIndex].ID, 'DIMMER');

                    // Umrandung zeichnen
                    _Buffer.Canvas.Brush.Color:=ClMedGray;
                    _Buffer.Canvas.Pen.Style:=psSolid;
                    _Buffer.Canvas.Pen.Color:=clBlack;
                    _Buffer.Canvas.Rectangle(0, ButtonPixels-10, ButtonPixels, ButtonPixels);

                    // Hintergrund zeichnen
                    _Buffer.Canvas.Pen.Color:=clSilver;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-9);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-9);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-8);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-8);
                    _Buffer.Canvas.Pen.Color:=clMedGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-7);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-7);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-6);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-6);
                    _Buffer.Canvas.Pen.Color:=clGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-5);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-5);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-4);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-4);
                    _Buffer.Canvas.Pen.Color:=clGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-3);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-3);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-2);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-2);
                    _Buffer.Canvas.Pen.Color:=clMedGray;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-1);
                    _Buffer.Canvas.LineTo(ButtonPixels, ButtonPixels-1);
                    // Füllung zeichnen
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,128);//$00FFFFFF;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-9);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-9);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-8);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-8);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,192);//$00A4FFA4;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-7);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-7);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-6);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-6);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,255);//$0000FF00;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-5);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-5);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-4);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-4);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,96);//$0000B000;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-3);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-3);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-2);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-2);
                    _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,64);//$00008000;
                    _Buffer.Canvas.MoveTo(0, ButtonPixels-1);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels-1);
                    _Buffer.Canvas.MoveTo(0, ButtonPixels);
                    _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), ButtonPixels);

                    // Wert in Prozent anzeigen
                    _Buffer.Canvas.Brush.Style:=bsClear;
                    _Buffer.Canvas.Pen.Style:=psClear;
                    _Buffer.Canvas.Font.Color:=clWhite;
                    _Buffer.Canvas.TextOut(1, ButtonPixels-12-10, mainform.levelstr(Dimmerwert));
                    _Buffer.Canvas.Pen.Style:=psSolid;
                  end else
                  begin
                    DrawEmptyButton:=true;
                  end;
                end;
              end;
              3: // 3=DataIn
              begin
                _Buffer.Canvas.Brush.Style:=bsSolid;
                _Buffer.Canvas.Pen.Color:=clBlack;
                _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                _Buffer.Canvas.Font.Color:=clWhite;

                Dimmerwert:=mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue;
                // Umrandung zeichnen
                _Buffer.Canvas.Brush.Color:=ClMedGray;
                _Buffer.Canvas.Pen.Style:=psSolid;
                _Buffer.Canvas.Pen.Color:=clBlack;
                _Buffer.Canvas.Rectangle(0, 0, ButtonPixels, 10);

                // Hintergrund zeichnen
                _Buffer.Canvas.Pen.Color:=clSilver;
                _Buffer.Canvas.MoveTo(0, 1);
                _Buffer.Canvas.LineTo(ButtonPixels, 1);
                _Buffer.Canvas.MoveTo(0, 2);
                _Buffer.Canvas.LineTo(ButtonPixels, 2);
                _Buffer.Canvas.Pen.Color:=clMedGray;
                _Buffer.Canvas.MoveTo(0, 3);
                _Buffer.Canvas.LineTo(ButtonPixels, 3);
                _Buffer.Canvas.MoveTo(0, 4);
                _Buffer.Canvas.LineTo(ButtonPixels, 4);
                _Buffer.Canvas.Pen.Color:=clGray;
                _Buffer.Canvas.MoveTo(0, 5);
                _Buffer.Canvas.LineTo(ButtonPixels, 5);
                _Buffer.Canvas.MoveTo(0, 6);
                _Buffer.Canvas.LineTo(ButtonPixels, 6);
                _Buffer.Canvas.Pen.Color:=clGray;
                _Buffer.Canvas.MoveTo(0, 7);
                _Buffer.Canvas.LineTo(ButtonPixels, 7);
                _Buffer.Canvas.MoveTo(0, 8);
                _Buffer.Canvas.LineTo(ButtonPixels, 8);
                _Buffer.Canvas.Pen.Color:=clMedGray;
                _Buffer.Canvas.MoveTo(0, 9);
                _Buffer.Canvas.LineTo(ButtonPixels, 9);
                // Füllung zeichnen
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,128);//$00FFFFFF;
                _Buffer.Canvas.MoveTo(0, 1);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 1);
                _Buffer.Canvas.MoveTo(0, 2);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 2);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,192);//$00A4FFA4;
                _Buffer.Canvas.MoveTo(0, 3);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 3);
                _Buffer.Canvas.MoveTo(0, 4);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 4);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,255);//$0000FF00;
                _Buffer.Canvas.MoveTo(0, 5);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 5);
                _Buffer.Canvas.MoveTo(0, 6);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 6);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,96);//$0000B000;
                _Buffer.Canvas.MoveTo(0, 7);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 7);
                _Buffer.Canvas.MoveTo(0, 8);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 8);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,64);//$00008000;
                _Buffer.Canvas.MoveTo(0, 9);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 9);
                _Buffer.Canvas.MoveTo(0, 10);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 10);

                // Wert in Prozent anzeigen
                _Buffer.Canvas.Brush.Style:=bsClear;
                _Buffer.Canvas.Pen.Style:=psClear;
                _Buffer.Canvas.Font.Color:=clWhite;
                _Buffer.Canvas.TextOut(1,12,'DataIn '+inttostr(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DataInChannel)+'@'+mainform.levelstr(Dimmerwert));
                _Buffer.Canvas.Pen.Style:=psSolid;

                if length(mainform.DataInEventArray)>0 then
                for i:=0 to length(mainform.DataInEventArray)-1 do
                begin
                  if (mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DataInChannel=mainform.DataInEventArray[i].channel) then
                  begin
                    // we found one element. PC_DIMMER supports connections to multiple DataIn-channels, but we have limited space in display
                    // so just display first connection
                    mainform.GetBefehlState(mainform.DataInEventArray[i].Befehl, Text_PCD_Function, Text_Function, Text_Value, Value);
                    _Buffer.Canvas.TextOut(1,24,Text_PCD_Function);
                    _Buffer.Canvas.TextOut(1,36,Text_Function);
                    _Buffer.Canvas.TextOut(1,48,Text_Value);

                    break;
                  end;
                end;
              end;
              4: // 4=Befehl
              begin
                _Buffer.Canvas.Brush.Style:=bsSolid;
                _Buffer.Canvas.Pen.Color:=clBlack;
                _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                _Buffer.Canvas.Font.Color:=clWhite;

                Dimmerwert:=mainform.ElgatoStreamDeckArray[dev].Buttons[btn].CurrentValue;
                // Umrandung zeichnen
                _Buffer.Canvas.Brush.Color:=ClMedGray;
                _Buffer.Canvas.Pen.Style:=psSolid;
                _Buffer.Canvas.Pen.Color:=clBlack;
                _Buffer.Canvas.Rectangle(0, 0, ButtonPixels, 10);

                // Hintergrund zeichnen
                _Buffer.Canvas.Pen.Color:=clSilver;
                _Buffer.Canvas.MoveTo(0, 1);
                _Buffer.Canvas.LineTo(ButtonPixels, 1);
                _Buffer.Canvas.MoveTo(0, 2);
                _Buffer.Canvas.LineTo(ButtonPixels, 2);
                _Buffer.Canvas.Pen.Color:=clMedGray;
                _Buffer.Canvas.MoveTo(0, 3);
                _Buffer.Canvas.LineTo(ButtonPixels, 3);
                _Buffer.Canvas.MoveTo(0, 4);
                _Buffer.Canvas.LineTo(ButtonPixels, 4);
                _Buffer.Canvas.Pen.Color:=clGray;
                _Buffer.Canvas.MoveTo(0, 5);
                _Buffer.Canvas.LineTo(ButtonPixels, 5);
                _Buffer.Canvas.MoveTo(0, 6);
                _Buffer.Canvas.LineTo(ButtonPixels, 6);
                _Buffer.Canvas.Pen.Color:=clGray;
                _Buffer.Canvas.MoveTo(0, 7);
                _Buffer.Canvas.LineTo(ButtonPixels, 7);
                _Buffer.Canvas.MoveTo(0, 8);
                _Buffer.Canvas.LineTo(ButtonPixels, 8);
                _Buffer.Canvas.Pen.Color:=clMedGray;
                _Buffer.Canvas.MoveTo(0, 9);
                _Buffer.Canvas.LineTo(ButtonPixels, 9);
                // Füllung zeichnen
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,128);//$00FFFFFF;
                _Buffer.Canvas.MoveTo(0, 1);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 1);
                _Buffer.Canvas.MoveTo(0, 2);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 2);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,192);//$00A4FFA4;
                _Buffer.Canvas.MoveTo(0, 3);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 3);
                _Buffer.Canvas.MoveTo(0, 4);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 4);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,255);//$0000FF00;
                _Buffer.Canvas.MoveTo(0, 5);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 5);
                _Buffer.Canvas.MoveTo(0, 6);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 6);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,96);//$0000B000;
                _Buffer.Canvas.MoveTo(0, 7);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 7);
                _Buffer.Canvas.MoveTo(0, 8);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 8);
                _Buffer.Canvas.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,64);//$00008000;
                _Buffer.Canvas.MoveTo(0, 9);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 9);
                _Buffer.Canvas.MoveTo(0, 10);
                _Buffer.Canvas.LineTo(round((ButtonPixels)*(Dimmerwert/255)), 10);

                // Wert in Prozent anzeigen
                _Buffer.Canvas.Brush.Style:=bsClear;
                _Buffer.Canvas.Pen.Style:=psClear;
                _Buffer.Canvas.Font.Color:=clWhite;
                _Buffer.Canvas.TextOut(1,12,_('Befehl')+' @ '+mainform.levelstr(Dimmerwert));
                _Buffer.Canvas.Pen.Style:=psSolid;

                mainform.GetBefehlState(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Befehl, Text_PCD_Function, Text_Function, Text_Value, Value);
                _Buffer.Canvas.TextOut(1,24,Text_PCD_Function);
                _Buffer.Canvas.TextOut(1,36,Text_Function);
                _Buffer.Canvas.TextOut(1,48,Text_Value);
              end;
            end;
          end;

          if DrawEmptyButton then
          begin
            _Buffer.Canvas.Brush.Style:=bsSolid;
            _Buffer.Canvas.Pen.Color:=clBlack;
            _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

            _Buffer.Canvas.Font.Color:=clWhite;
            _Buffer.Canvas.TextOut(1,0,TimeToStr(now));
            _Buffer.Canvas.TextOut(1,12,'Button '+inttostr(btn+1));
            _Buffer.Canvas.TextOut(1,24,'');
            _Buffer.Canvas.TextOut(1,36,_('- Frei -'));
          end;

          if elgatostreamdeckform.Showing and (devicelistbox.ItemIndex>-1) and (devicelistbox.ItemIndex<length(mainform.ElgatoStreamSerials)) and (mainform.ElgatoStreamDeckArray[dev].Serial=mainform.ElgatoStreamSerials[devicelistbox.ItemIndex]) then
          begin
            // preview on computerdisplay
            X:=0;
            Y:=0;
            if mainform.ElgatoStreamDeckArray[dev].ButtonCount=6 then
            begin
              X:=btn-trunc(btn/3)*3;
              Y:=trunc(btn/3);
            end else if mainform.ElgatoStreamDeckArray[dev].ButtonCount=15 then
            begin
              X:=btn-trunc(btn/5)*5;
              Y:=trunc(btn/5);
            end else if mainform.ElgatoStreamDeckArray[dev].ButtonCount=32 then
            begin
              X:=btn-trunc(btn/8)*8;
              Y:=trunc(btn/8);
            end;
            BitBlt(Paintbox1.Canvas.Handle, ButtonPixels*X, ButtonPixels*Y, ButtonPixels, ButtonPixels, _Buffer.Canvas.Handle, 0, 0, SrcCopy);
          end;

          // neuen schwarzen Rahmen über Button drüberlegen
          _Buffer.Canvas.Brush.Style:=bsClear;
          _Buffer.Canvas.Pen.Color:=clBlack;
          _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);
          _Buffer.Canvas.Brush.Style:=bsSolid;

          // send image to device
          //RotateBitmap(_Buffer, 3.141, false, 0);
          SetKeyBitmap(dev, btn, _Buffer);
        end;

        break;
      end;
    end;
  end;
end;

end.
