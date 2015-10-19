unit dmxsencfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, XPMan, Registry;

type
  THeader = record
    Framesync:byte;
    Header:byte;
    Channelcount:Word;
  end;
  TDMXarray = record
    Channel:Word;
    Value:Byte;
  end;
  TIDtag = record
    Header:array[0..2] of char;
    Titel:array[0..29] of char;
    Projectname:array[0..29] of char;
    Description:array[0..29] of char;
    Year:array[0..3] of char;
    Comment:array[0..29] of char;
    Reserved:char;
  end;

  TForm1 = class(TForm)
    encodertimer: TTimer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    frameratebox: TComboBox;
    usecrcbox: TCheckBox;
    Label9: TLabel;
    keyframeedit: TEdit;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    encodedframeslbl: TLabel;
    channelsperframelbl: TLabel;
    XPManifest1: TXPManifest;
    GroupBox4: TGroupBox;
    filenameedit: TEdit;
    RecordBtn: TButton;
    PauseBtn: TButton;
    StopBtn: TButton;
    Label12: TLabel;
    maxchanedit: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    encodedkeyframeslbl: TLabel;
    Label15: TLabel;
    channelsperkeyframelbl: TLabel;
    GroupBox5: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    ScrollBar9: TScrollBar;
    Label24: TLabel;
    Timer1: TTimer;
    Label25: TLabel;
    datenratelbl: TLabel;
    procedure RecordBtnClick(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure encodertimerTimer(Sender: TObject);
    procedure framerateboxSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure keyframeeditChange(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure ScrollBar6Change(Sender: TObject);
    procedure ScrollBar7Change(Sender: TObject);
    procedure ScrollBar8Change(Sender: TObject);
    procedure ScrollBar9Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure maxchaneditChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    DMXSHeader:THeader;
    CRC:Word;
    DMXSIDtag:TIDtag;
    DMXarray:array of TDMXarray;
    DMXkeyarray:array of byte;
    FileStream:TFileStream;
    LastPosition:Int64;

    encodedframes, encodedkeyframes:Cardinal;
    MeanValue:Word;
    MeanValueArray:array[0..19] of Word;
    MeanValuePointer:Byte;
    MaxChan:integer;
    KeyFrameInterval:integer;
    framecounter:Integer;
    channelsperframe,channelsperkeyframe:Cardinal;
    procedure ByteCrc(data:byte;var crc:word);
    function CalcCRC16:Word;
    function CalcCRC16key:Word;
  public
    { Public-Deklarationen }
    procedure SetChannel(Channel: integer; Value: Byte);
    procedure StartEncode;
    procedure StopEncode;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ByteCrc(data:byte;var crc:word);
var
  i:byte;
begin
  for i:=0 to 7 do
  begin
    if ((data and $01) xor (crc and $0001)<>0) then
    begin
      crc:=crc shr 1;
      crc:= crc xor $A001;
    end else
    begin
      crc:=crc shr 1;
    end;
    data:=data shr 1;
  end;
end;

function TForm1.CalcCRC16:Word;
var
  len,i:integer;
begin
  result:=0;
  len:=length(DMXarray)-1;
  for i:=0 to len do
  begin
//    bytecrc(ord(DMXarray[i].Channel),result);
    bytecrc(ord(DMXarray[i].Value),result);
  end;
end;

function TForm1.CalcCRC16key:Word;
var
  len,i:integer;
begin
  result:=0;
  len:=length(DMXkeyarray)-1;
  for i:=0 to len do
  begin
//    bytecrc(ord(DMXarray[i].Channel),result);
    bytecrc(ord(DMXkeyarray[i]),result);
  end;
end;

{
function Crc16(const Buffer: PByte; const BufSize: Int64;
  const Polynom: WORD=$1021; const Seed: WORD=0): Word;
var
  i,j: Integer;
begin
  Result := Seed;

  for i:=0 to BufSize-1 do
  begin
    Result := Result xor (Buffer[i] shl 8);

    for j:=0 to 7 do begin
      if (Result and $8000) <> 0 then
        Result := (Result shl 1) xor Polynom
      else Result := Result shl 1;
    end;
  end;

  Result := Result and $FFFF;
end;
}

procedure TForm1.RecordBtnClick(Sender: TObject);
begin
  StartEncode;
end;

procedure TForm1.PauseBtnClick(Sender: TObject);
begin
  encodertimer.Enabled:=not encodertimer.Enabled;
end;

procedure TForm1.StopBtnClick(Sender: TObject);
begin
  StopEncode;
end;

procedure TForm1.encodertimerTimer(Sender: TObject);
var
  IsKeyframe:boolean;
  i:integer;
  WordVar:Word;
begin
  IsKeyframe:=false;

  DMXSHeader.Framesync:=255;
  DMXSHeader.Header:=0;
  DMXSHeader.Header:=DMXSHeader.Header OR 224;
  case frameratebox.ItemIndex of
    0: DMXSHeader.Header:=DMXSHeader.Header;
    1: DMXSHeader.Header:=DMXSHeader.Header OR 8;
    2: DMXSHeader.Header:=DMXSHeader.Header OR 16;
    3: DMXSHeader.Header:=DMXSHeader.Header OR 24;
  end;
  if usecrcbox.Checked then
    DMXSHeader.Header:=DMXSHeader.Header OR 1; // benutze CRC16
  if (framecounter>=KeyframeInterval) then
  begin
    IsKeyframe:=true;
    DMXSHeader.Header:=DMXSHeader.Header OR 4; // es ist ein Keyframe
    framecounter:=0;
    DMXSHeader.Channelcount:=length(DMXkeyarray);
  end else
  begin
    DMXSHeader.Channelcount:=length(DMXarray);
  end;
  FileStream.WriteBuffer(DMXSHeader.Framesync, sizeof(DMXSHeader.Framesync));
  FileStream.WriteBuffer(DMXSHeader.Header, sizeof(DMXSHeader.Header));
  WordVar:=swap(DMXSHeader.Channelcount);
  FileStream.WriteBuffer(WordVar, sizeof(WordVar));

  // DMX-Daten schreiben
  if IsKeyframe then
  begin
    if usecrcbox.Checked then
    begin
      CRC:=CalcCRC16key; // hier CRC berechnen
      WordVar:=swap(CRC);
      FileStream.WriteBuffer(WordVar, sizeof(WordVar));
    end;

    inc(encodedkeyframes);

    for i:=0 to length(DMXkeyarray)-1 do
      FileStream.WriteBuffer(DMXkeyarray[i], sizeof(DMXkeyarray[i]));
    channelsperkeyframe:=length(DMXkeyarray);
  end else
  begin
    if usecrcbox.Checked then
    begin
      CRC:=CalcCRC16; // hier CRC berechnen
      WordVar:=swap(CRC);
      FileStream.WriteBuffer(WordVar, sizeof(WordVar));
    end;

    inc(encodedframes);
    inc(framecounter);

    for i:=0 to length(DMXarray)-1 do
    begin
      WordVar:=swap(DMXarray[i].Channel);
      FileStream.WriteBuffer(WordVar, sizeof(WordVar));
      FileStream.WriteBuffer(DMXarray[i].Value, sizeof(DMXarray[i].Value));
    end;
    channelsperframe:=length(DMXarray);
  end;
  setlength(DMXarray, 0);

  encodedframeslbl.Caption:=inttostr(encodedframes);

  // Mittelwert der Kanäle pro Frames anzeigen
  MeanValueArray[MeanValuePointer]:=channelsperframe;
  inc(MeanValuePointer);
  if MeanValuePointer>19 then
    MeanValuePointer:=0;
  MeanValue:=0;
  for i:=0 to 19 do
    MeanValue:=MeanValue+MeanValueArray[i];
  MeanValue:=MeanValue div 20;
  channelsperframelbl.Caption:=inttostr(MeanValue);

  encodedkeyframeslbl.Caption:=inttostr(encodedkeyframes);
  channelsperkeyframelbl.Caption:=inttostr(channelsperkeyframe);
end;

procedure TForm1.framerateboxSelect(Sender: TObject);
begin
  case frameratebox.ItemIndex of
    0: encodertimer.Interval:=20;
    1: encodertimer.Interval:=100;
    2: encodertimer.Interval:=200;
  end;
end;

procedure TForm1.SetChannel(Channel: integer; Value: Byte);
var
  i:integer;
  done:boolean;
begin
  done:=false;

  // Prüfen, ob Daten bereits vorhanden
  for i:=0 to length(DMXarray)-1 do
  begin
    if Channel=DMXarray[i].Channel then
    begin
      DMXarray[i].Value:=Value;
      done:=true;
      break;
    end;
  end;

  // Kanal noch nicht in aktuellem Array -> anlegen
  if not done then
  begin
    setlength(DMXarray, length(DMXarray)+1);
    DMXarray[length(DMXarray)-1].Channel:=Channel;
    DMXarray[length(DMXarray)-1].Value:=Value;
  end;

  // Daten für Keyframe zusammenstellen
  if (Channel<=MaxChan) and (Channel>0) then
  begin
    if Channel>length(DMXkeyarray) then
      setlength(DMXkeyarray, Channel);
    DMXkeyarray[Channel-1]:=Value;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\Software\PHOENIXstudios\DMXS Encoder', False) then
      begin
        case ReadInteger('Framerate') of
          0: frameratebox.ItemIndex:=0;
          1: frameratebox.ItemIndex:=1;
          2: frameratebox.ItemIndex:=2;
        end;
        keyframeedit.text:=inttostr(ReadInteger('Keyframeinterval'));
        maxchanedit.text:=inttostr(ReadInteger('MaxChan'));
        usecrcbox.Enabled:=ReadBool('UseCRC16');
        CloseKey;
      end;
    finally
      Free;
    end;
end;

procedure TForm1.keyframeeditChange(Sender: TObject);
begin
  KeyframeInterval:=strtoint(keyframeedit.Text);
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  SetChannel(1, 255-scrollbar1.Position);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  SetChannel(2, 255-scrollbar2.Position);
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  SetChannel(3, 255-scrollbar3.Position);
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
  SetChannel(4, 255-scrollbar4.Position);
end;

procedure TForm1.ScrollBar5Change(Sender: TObject);
begin
  SetChannel(5, 255-scrollbar5.Position);
end;

procedure TForm1.ScrollBar6Change(Sender: TObject);
begin
  SetChannel(6, 255-scrollbar6.Position);
end;

procedure TForm1.ScrollBar7Change(Sender: TObject);
begin
  SetChannel(7, 255-scrollbar7.Position);
end;

procedure TForm1.ScrollBar8Change(Sender: TObject);
begin
  SetChannel(8, 255-scrollbar8.Position);
end;

procedure TForm1.ScrollBar9Change(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to strtoint(maxchanedit.text) do
    SetChannel(i, scrollbar9.Position);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  BytesPerSecond:Cardinal;
begin
  BytesPerSecond:=FileStream.Position-LastPosition;

  if BytesPerSecond<1023 then
    datenratelbl.caption:=inttostr(BytesPerSecond)+' Byte/s'
  else
    datenratelbl.caption:=inttostr(round(BytesPerSecond / 1023))+' kB/s';

  LastPosition:=FileStream.Position;
end;

procedure TForm1.maxchaneditChange(Sender: TObject);
begin
  label24.caption:='Kanäle 1-'+maxchanedit.Text;
end;

procedure TForm1.StartEncode;
begin
  MaxChan:=strtoint(maxchanedit.Text);
  MaxChanEdit.Enabled:=false;
  KeyframeInterval:=strtoint(keyframeedit.Text);
  framecounter:=KeyframeInterval+1;

  Timer1.enabled:=true;

  encodedframes:=0;
  channelsperframe:=0;
  encodedkeyframes:=0;
  channelsperkeyframe:=0;

  setlength(DMXkeyarray,0);
  setlength(DMXarray,0);

  FileStream := TFileStream.Create(filenameedit.text, fmCreate);
  encodertimer.Enabled:=true;
  RecordBtn.Enabled:=not encodertimer.Enabled;
  PauseBtn.Enabled:=encodertimer.Enabled;
  StopBtn.Enabled:=encodertimer.Enabled;
end;

procedure TForm1.StopEncode;
var
  text:string;
begin
  encodertimer.Enabled:=false;
  Timer1.enabled:=false;

  RecordBtn.Enabled:=not encodertimer.Enabled;
  PauseBtn.Enabled:=encodertimer.Enabled;
  StopBtn.Enabled:=encodertimer.Enabled;
  MaxChanEdit.Enabled:=not encodertimer.Enabled;

  // IDtag schreiben
  text:=edit1.text;
  CopyMemory(@DMXSIDtag.Header[0], @text[1], length(text));
  text:=edit2.text;
  CopyMemory(@DMXSIDtag.Titel[0], @text[1], length(text));
  text:=edit3.text;
  CopyMemory(@DMXSIDtag.Projectname[0], @text[1], length(text));
  text:=edit4.text;
  CopyMemory(@DMXSIDtag.Description[0], @text[1], length(text));
  text:=edit5.text;
  CopyMemory(@DMXSIDtag.Year[0], @text[1], length(text));
  text:=edit6.text;
  CopyMemory(@DMXSIDtag.Comment[0], @text[1], length(text));
  text:=edit7.text;
  CopyMemory(@DMXSIDtag.Reserved, @text[1], length(text));
  FileStream.WriteBuffer(DMXSIDtag, sizeof(DMXSIDtag));
  FileStream.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\Software\PHOENIXstudios\DMXS Encoder', False) then
      begin
        case frameratebox.ItemIndex of
          0: WriteInteger('Framerate',0);
          1: WriteInteger('Framerate',1);
          2: WriteInteger('Framerate',2);
        end;
        WriteInteger('Keyframeinterval', strtoint(keyframeedit.text));
        WriteInteger('MaxChan', strtoint(maxchanedit.text));
        WriteBool('UseCRC16',usecrcbox.Enabled);
        CloseKey;
      end;
    finally
      Free;
    end;
end;

end.
