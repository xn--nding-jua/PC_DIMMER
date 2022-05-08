{
  HID communication using input and output reports
  Details zum Protokoll: https://gist.github.com/cliffrowley/d18a9c4569537b195f2b1eb6c68469e0

  StreamDeck Software sends out JPEG-files for each button
  - Image is transmitted in chunks of 1024 bytes
  - header is added as prefix to JPEG payload

  - structure: 8 byte header + 1016 byte payload

  HEADER:
  00 01 02 03 04 05 06 07
  02 07 18 00 f8 03 00 00

  00 = static 02 (identifier)
  01 = static 07 (cmd to set image?)
  02 = hex-value of button-id
  03 = 0x00 = not the last message, 0x01 = last message
  04 / 05 = 16-bit little-endian value of length: f803 -> 0x03f8 = 1016
  06 / 07 = 16-bit little-endian value of the zero-based iteration, if the image is split
}

unit elgatostreamdeckfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponentBase, JvHidControllerClass, Hid, jpeg,
  ExtCtrls, gnugettext, Mask, JvExMask, JvSpin, pcdutils, GR32, pngimage;

type
  TReport = packed record
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
    Label2: TLabel;
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
    procedure brightnessbarChange(Sender: TObject);
    procedure ElgatoStreamDeckTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  private
    { Private-Deklarationen }
    SelectedDevice, SelectedButton:integer;
    pngobject:TPNGObject;
    function SetKeyBitmap(Serial: string; KeyIndex:byte; Bitmap: TBitmap):integer;
  public
    { Public-Deklarationen }
    procedure MSGNew;
    procedure MSGOpen;
    procedure SetBrightness(Serial: string; Percent: byte);
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

function Telgatostreamdeckform.SetKeyBitmap(Serial: string; KeyIndex:byte; Bitmap: TBitmap):integer;
var
  w:Word;
  i, DeviceIndex: integer;
  JPEGImage:TJPEGImage;
  Stream: TMemoryStream;
  TxBuffer, PayloadBuffer: array of byte;
  HidReport:TReport;
  WrittenPayloadBytes, RemainingPayloadBytes, PacketCounter:Cardinal;
  TotalBytesWritten, BytesWritten:DWORD;
begin
{
  HID communication using input and output reports
  Details zum Protokoll: https://gist.github.com/cliffrowley/d18a9c4569537b195f2b1eb6c68469e0

  StreamDeck Software sends out JPEG-files for each button
  - Image is transmitted in chunks of 1024 bytes
  - header is added as prefix to JPEG payload

  - structure: 8 byte header + 1016 byte payload

  HEADER:
  00 01 02 03 04 05 06 07
  02 07 18 00 f8 03 00 00

  00 = static 02 (identifier)
  01 = static 07 (cmd to set image?)
  02 = hex-value of button-id
  03 = 0x00 = not the last message, 0x01 = last message
  04 / 05 = 16-bit little-endian value of length: f803 -> 0x03f8 = 1016
  06 / 07 = 16-bit little-endian value of the zero-based iteration, if the image is split
}

  for i:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    if mainform.ElgatoStreamDeckArray[i].Serial=Serial then
    begin
      DeviceIndex:=i;
      break;
    end;
  end;

  // first convert the JPEG to byte-array
  JPEGImage:=TJPEGImage.Create;
  try
{
    JPEGImage.Performance:=jpBestSpeed;
    JPEGImage.ProgressiveEncoding:=true;
    JPEGImage.ProgressiveDisplay:=true;
}
    JPEGImage.Assign(Bitmap);
    JPEGImage.CompressionQuality:=100;
//    JPEGImage.Compress;

    Stream:=TMemoryStream.Create;
    JPEGImage.SaveToStream(Stream);

    setlength(PayloadBuffer, Stream.Size);
    Stream.Position:=0;
    Stream.Read(PayloadBuffer[0], Stream.Size);
  finally
    JPEGImage.Free;
  end;

  // now transmit the byte-array to Stream Deck Device
  WrittenPayloadBytes:=0;
  TotalBytesWritten:=0;
  RemainingPayloadBytes:=length(PayloadBuffer);
  PacketCounter:=0;

  setlength(TxBuffer, 8191);
  TxBuffer[0]:=$02; // identifier
  TxBuffer[1]:=$07; // cmd to set image
  TxBuffer[2]:=KeyIndex; // hex-value of button-id
  //TxBuffer[3]:=$00; // 0x00 = not the last message, 0x01 = last message
  //TxBuffer[4]:=$F8; // 16-bit little-endian value of length: f803 -> 0x03f8 = 1016
  //TxBuffer[5]:=$03;
  //TxBuffer[6]:=$00; // 16-bit little-endian value of the zero-based iteration, if the image is split
  //TxBuffer[7]:=$00;
  repeat
    if RemainingPayloadBytes>1016 then
    begin
      // not the last message
      TxBuffer[3]:=$00; // 0x00 = not the last message, 0x01 = last message
      TxBuffer[4]:=$F8; // 16-bit little-endian value of length: f803 -> 0x03f8 = 1016 bytes
      TxBuffer[5]:=$03;
      TxBuffer[6]:=PacketCounter AND 255;
      TxBuffer[7]:=(PacketCounter shr 8);

      // copy 1016 bytes of PayloadBuffer
      for w:=0 to 1015 do
      begin
        TxBuffer[8+w]:=PayloadBuffer[WrittenPayloadBytes+w];
      end;

      for w:=0 to 7 do
        HidReport.Header[w]:=TxBuffer[w];
      for w:=0 to 1015 do
        HidReport.Data[w]:=TxBuffer[8+w];
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.WriteFile(HidReport, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.OutputReportByteLength, BytesWritten);
      TotalBytesWritten:=TotalBytesWritten+BytesWritten;
      WrittenPayloadBytes:=WrittenPayloadBytes+1016;
      RemainingPayloadBytes:=RemainingPayloadBytes-1016;
      PacketCounter:=PacketCounter+1;
    end else
    begin
      // data fits into single message / last message
      TxBuffer[3]:=$01; // 0x00 = not the last message, 0x01 = last message
      TxBuffer[4]:=RemainingPayloadBytes AND 255; // 16-bit little-endian value of length: f803 -> 0x03f8 = 1016
      TxBuffer[5]:=(RemainingPayloadBytes shr 8);
      TxBuffer[6]:=PacketCounter AND 255;
      TxBuffer[7]:=(PacketCounter shr 8);

      // copy remaining bytes of PayloadBuffer
      for w:=0 to RemainingPayloadBytes-1 do
      begin
        TxBuffer[8+w]:=PayloadBuffer[WrittenPayloadBytes+w];
      end;
      // fill remaining bytes with zeros
      for w:=RemainingPayloadBytes to 1015 do
      begin
        TxBuffer[w]:=0;
      end;

      for w:=0 to 7 do
        HidReport.Header[w]:=TxBuffer[w];
      for w:=0 to 1015 do
        HidReport.Data[w]:=TxBuffer[8+w];
      mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.WriteFile(HidReport, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.OutputReportByteLength, BytesWritten);
      TotalBytesWritten:=TotalBytesWritten+BytesWritten;
      RemainingPayloadBytes:=0;
      PacketCounter:=PacketCounter+1;
    end;
  until RemainingPayloadBytes=0;

  Stream.Free;

  result:=TotalBytesWritten;
end;

procedure Telgatostreamdeckform.SetBrightness(Serial: string; Percent: byte);
var
  i, DeviceIndex:integer;
  TxBuffer: array[0..31] of byte;
begin
  for i:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    if mainform.ElgatoStreamDeckArray[i].Serial=Serial then
    begin
      DeviceIndex:=i;
      break;
    end;
  end;

  TxBuffer[0]:=$03;
  TxBuffer[1]:=$08;
  TxBuffer[2]:=Percent;
  mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.SetFeature(TxBuffer, mainform.ElgatoStreamDeckArray[DeviceIndex].HidDevice.Caps.FeatureReportByteLength);
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
  dev, btn, x, y, DeviceIndex, i, l, k:integer;
  _Buffer: TBitmap;
  ButtonPixels:byte;
  topval,leftval:integer;
  rect:TRect;
  Dimmerwert:integer;
  DrawEmptyButton:boolean;
  CurrentButtonMode:byte;
begin
  _Buffer:=TBitmap.Create;

  for dev:=0 to length(mainform.ElgatoStreamDeckArray)-1 do
  begin
    if mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode=0 then
      mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode:=1;

    if (mainform.ElgatoStreamDeckArray[dev].ButtonCount=32) then
    begin
      // large buttons
      ButtonPixels:=96;
    end else
    begin
      // small buttons
      ButtonPixels:=72;
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
        // show AutoMode-picture and current AutoMode
        _Buffer.Canvas.Brush.Style:=bsSolid;
        _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

        _Buffer.Canvas.Font.Color:=clWhite;
        _Buffer.Canvas.TextOut(0,0,TimeToStr(now));
        _Buffer.Canvas.TextOut(0,12,'MODUS:');
        case mainform.ElgatoStreamDeckArray[dev].CurrentButtonMode of
          1:
          begin
            _Buffer.Canvas.TextOut(0,24,'> '+_('Panels')+' <');
            _Buffer.Canvas.TextOut(0,36,''+_('Geräte')+'');
            _Buffer.Canvas.TextOut(0,48,''+_('Data-In')+'');
            _Buffer.Canvas.TextOut(0,60,''+_('')+'');
          end;
          2:
          begin
            _Buffer.Canvas.TextOut(0,24,''+_('Panels')+'');
            _Buffer.Canvas.TextOut(0,36,'> '+_('Geräte')+' <');
            _Buffer.Canvas.TextOut(0,48,''+_('Data-In')+'');
            _Buffer.Canvas.TextOut(0,60,''+_('')+'');
          end;
          3:
          begin
            _Buffer.Canvas.TextOut(0,24,''+_('Panels')+'');
            _Buffer.Canvas.TextOut(0,36,''+_('Geräte')+'');
            _Buffer.Canvas.TextOut(0,48,'> '+_('Data-In')+' <');
            _Buffer.Canvas.TextOut(0,60,''+_('')+'');
          end;
          4:
          begin
            _Buffer.Canvas.TextOut(0,24,''+_('Panels')+'');
            _Buffer.Canvas.TextOut(0,36,''+_('Geräte')+'');
            _Buffer.Canvas.TextOut(0,48,''+_('Data-In')+'');
            _Buffer.Canvas.TextOut(0,60,'> '+_('')+' <');
          end;
        end;
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
                _Buffer.Canvas.Brush.Color:=mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Color;
                if mainform.ElgatoStreamDeckArray[dev].Buttons[btn].Pressed then
                  _Buffer.Canvas.Brush.Color:=InvertColor(_Buffer.Canvas.Brush.Color);

                _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                // Bild zeichnen
                rect.Top:=16;
                rect.Left:=12;
                rect.right:=12+48;
                rect.Bottom:=16+48;
                pngobject.Assign(mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].PNG);
                SmoothResize(pngobject, 48, 48);
                pngobject.Draw(_Buffer.Canvas, rect);

                if mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Active then
                begin
                  _Buffer.Canvas.Font.Color:=InvertColor(_Buffer.Canvas.Brush.Color);
                  _Buffer.Canvas.Font.Style:=[fsBold];
                  _Buffer.Canvas.TextOut(0,0,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Name);
                  _Buffer.Canvas.TextOut(0,12,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].TypName);
                  _Buffer.Canvas.TextOut(0,24,'');
                  _Buffer.Canvas.Font.Style:=[];

                  _Buffer.Canvas.Brush.Color:=clRed;
                  _Buffer.Canvas.Rectangle(0, ButtonPixels-10, ButtonPixels, ButtonPixels);
                end else
                begin
                  _Buffer.Canvas.Font.Color:=InvertColor(_Buffer.Canvas.Brush.Color);
                  _Buffer.Canvas.TextOut(0,0,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].Name);
                  _Buffer.Canvas.TextOut(0,12,mainform.kontrollpanelbuttons[mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelY-1][mainform.ElgatoStreamDeckArray[dev].Buttons[btn].KontrollpanelX-1].TypName);
                  _Buffer.Canvas.TextOut(0,24,'');
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
              _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

              // Bild zeichnen
              rect.Top:=16;
              rect.Left:=12;
              rect.right:=12+48;
              rect.Bottom:=16+48;
              pngobject.Assign(mainform.devicepictures64.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[DeviceIndex].bildadresse)].PngImage);
              SmoothResize(pngobject, 48, 48);
              pngobject.Draw(_Buffer.Canvas, rect);

              _Buffer.Canvas.Font.Color:=clWhite;
              _Buffer.Canvas.TextOut(0,0,mainform.devices[DeviceIndex].Name);
              _Buffer.Canvas.TextOut(0,12,'Ch '+inttostr(mainform.devices[DeviceIndex].Startaddress));

              if mainform.Devices[DeviceIndex].hasDimmer then
              begin
                Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[DeviceIndex].ID);
                // Umrandung zeichnen
                _Buffer.Canvas.Brush.Color:=ClMedGray;
                _Buffer.Canvas.Pen.Style:=psSolid;
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
                _Buffer.Canvas.TextOut(0, ButtonPixels-12-10, mainform.levelstr(Dimmerwert));
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
                _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

                _Buffer.Canvas.Font.Color:=clWhite;
                _Buffer.Canvas.TextOut(0,0,mainform.DeviceGroups[DeviceIndex].Name);
                _Buffer.Canvas.TextOut(0,12,_('Gruppe'));


                Dimmerwert:=geraetesteuerung.get_group(mainform.DeviceGroups[DeviceIndex].ID, 'DIMMER');

                // Umrandung zeichnen
                _Buffer.Canvas.Brush.Color:=ClMedGray;
                _Buffer.Canvas.Pen.Style:=psSolid;
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
                _Buffer.Canvas.TextOut(0, ButtonPixels-12-10, mainform.levelstr(Dimmerwert));
              end else
              begin
                DrawEmptyButton:=true;
              end;
            end;
          end;
          3: // 3=DataIn
          begin
            _Buffer.Canvas.Brush.Style:=bsSolid;
            _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

            _Buffer.Canvas.Font.Color:=clWhite;
            _Buffer.Canvas.TextOut(0,0,'Data-In');
            _Buffer.Canvas.TextOut(0,12,'Ch '+inttostr(mainform.ElgatoStreamDeckArray[dev].Buttons[btn].DataInChannel));
          end;
        end;
      end;

      if DrawEmptyButton then
      begin
        _Buffer.Canvas.Brush.Style:=bsSolid;
        _Buffer.Canvas.Rectangle(0,0,ButtonPixels,ButtonPixels);

        _Buffer.Canvas.Font.Color:=clWhite;
        _Buffer.Canvas.TextOut(0,0,TimeToStr(now));
        _Buffer.Canvas.TextOut(0,12,'Button '+inttostr(btn+1));
        _Buffer.Canvas.TextOut(0,24,'');
        _Buffer.Canvas.TextOut(0,36,_('- Frei -'));
      end;

      if elgatostreamdeckform.Showing and (devicelistbox.ItemIndex>-1) and (devicelistbox.ItemIndex<length(mainform.ElgatoStreamSerials)) and (mainform.ElgatoStreamDeckArray[dev].Serial=mainform.ElgatoStreamSerials[devicelistbox.ItemIndex]) then
      begin
        // preview on computerdisplay
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

      // send image to device
      RotateBitmap(_Buffer, 3.141, false, 0);
      SetKeyBitmap(mainform.ElgatoStreamDeckArray[dev].Serial, btn, _Buffer);
    end;
  end;

  _Buffer.Free;
end;

procedure Telgatostreamdeckform.FormShow(Sender: TObject);
begin
  Paintbox1.Canvas.Brush.Style:=bsSolid;
  Paintbox1.Canvas.Brush.Color:=clBlack;
  Paintbox1.Canvas.Rectangle(0,0,Paintbox1.Width, Paintbox1.Height);
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
        SelectedButton:=trunc(X/72)+trunc(Y/72)*3;
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

    btnlabel.Caption:=_('Button ')+inttostr(SelectedButton+1);
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

end.
