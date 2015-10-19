unit dmxsdecfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan;

type
  TDMXarray = record
    Channel:Word;
    Value:Byte;
  end;
  TFrame = record
    Framerate:byte;
	  IsKeyframe:boolean;
  	UsesCRC16:boolean;
	  CRC16:Word;
    CRCok:boolean;
  	Channelcount:Word;
    LastKeyframe:Word;
    KeyframeInterval:Word;
    DMXarray:array of TDMXarray;
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
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    titlelbl: TLabel;
    projectnamelbl: TLabel;
    descriptionlbl: TLabel;
    yearlbl: TLabel;
    commentlbl: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    frameratelbl: TLabel;
    keyframeintervallbl: TLabel;
    maxchanlbl: TLabel;
    crclbl: TLabel;
    OpenFileBtn: TButton;
    Label14: TLabel;
    sourceedit: TEdit;
    DecodeFrameBtn: TButton;
    CloseBtn: TButton;
    XPManifest1: TXPManifest;
    decodetimer: TTimer;
    Label10: TLabel;
    iskeyframelbl: TLabel;
    Label11: TLabel;
    reservedlbl: TLabel;
    CheckBox1: TCheckBox;
    Label12: TLabel;
    crcoklbl: TLabel;
    GroupBox3: TGroupBox;
    ListBox1: TListBox;
    Timer1: TTimer;
    datenratelbl: TLabel;
    procedure OpenFileBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure DecodeFrameBtnClick(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure decodetimerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    LastPosition:Int64;
    procedure ByteCrc(data:byte;var crc:word);
    function CalcCRC16:Word;
    function ReadFrameOutOfStream(var LastValidFrame:Int64):boolean;
    procedure RefreshFrameInfo;
    procedure ReadID;
  public
    { Public-Deklarationen }
    IDTag:TIDTag;
  	Frame:TFrame;
    DMXarray:array[0..8191] of byte;
    FileStream:TFileStream;
    procedure OpenStream;
    procedure CloseStream;
    procedure DecodeFrame;
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
  len:=length(Frame.DMXarray)-1;
  for i:=0 to len do
  begin
//    bytecrc(ord(Frame.DMXarray[i].Channel),result);
    bytecrc(ord(Frame.DMXarray[i].Value),result);
  end;
end;

procedure TForm1.OpenFileBtnClick(Sender: TObject);
begin
  OpenStream;
end;

procedure TForm1.CloseBtnClick(Sender: TObject);
begin
  CloseStream;
end;

function TForm1.ReadFrameOutOfStream(var LastValidFrame:Int64):boolean;
var
  i:integer;
  SearchByte:byte;
  FoundValidFrame, IsLastFrame:boolean;
  NextFrameA, NextFrameB, NextFrameC:byte;
begin
  if FileStream.Position>=(FileStream.Size-3) then
  begin
    result:=false;
    exit;
  end;

  FoundValidFrame:=false;
  IsLastFrame:=false;

  // nach nächstem, gültigen Frame suchen
  repeat
    FileStream.Read(SearchByte, sizeof(SearchByte)); 			// nächstmögliches Byte auslesen
    if SearchByte=255 then 										// prüfen, ob gelesenes Byte = 255
    begin
  	  // Startbyte gefunden, Testen ob nächstes Byte laut Spezifikation = 111xxxxx = SSSFFKPP
  	  FileStream.Read(SearchByte, sizeof(SearchByte));
  	  if ((SearchByte AND 224)=224) and ((SearchByte AND 24)<>24) and ((SearchByte AND 3)<>3) then	// sind erste drei Bits des Bytes gesetzt und die verbotenen und reservierten Bits frei?
  	  begin
	      // Scheint ein gültiger Frame zu sein
    		if (SearchByte AND 8)=8 then
	      begin
          Frame.Framerate:=1;
          decodetimer.Interval:=100;
    		end else if (SearchByte AND 16)=16 then
    		begin
          Frame.Framerate:=2;
          decodetimer.Interval:=200;
    		end else
    		begin
          Frame.Framerate:=0;
          decodetimer.Interval:=20;
        end;
        Frame.IsKeyframe:=(SearchByte AND 4)=4;
    		Frame.UsesCRC16:=(SearchByte AND 1)=1;

	      FileStream.Read(SearchByte, sizeof(SearchByte));		// MSB von ChannelCount
	  	  Frame.Channelcount:=SearchByte shl 8;
  	    FileStream.Read(SearchByte, sizeof(SearchByte));		// LSB von ChannelCount
	  	  Frame.Channelcount:=Frame.Channelcount + SearchByte;	// Channelcount zusammensetzen
        if Frame.UsesCRC16 then
		    begin
  	      FileStream.Read(SearchByte, sizeof(SearchByte));		// MSB von CRC16
	  	    Frame.CRC16:=SearchByte shl 8;
	        FileStream.Read(SearchByte, sizeof(SearchByte));		// LSB von CRC16
		      Frame.CRC16:=Frame.CRC16 + SearchByte;
        end;

    		// Prüfen, ob es wirklich ein gültiger Frame ist
        if Frame.IsKeyframe then
      	begin
          Frame.KeyframeInterval:=Frame.LastKeyframe;
          Frame.LastKeyframe:=0;

        	FileStream.Position:=FileStream.Position+Frame.Channelcount;	  // Channelcount-Bytes nach vorne springen, um nächsten Header zu suchen
          FileStream.Read(NextFrameA, sizeof(NextFrameA)); 			          // nächstmögliches Byte auslesen
      		FileStream.Read(NextFrameB, sizeof(NextFrameB)); 			          // nächstmögliches Byte auslesen
      		FileStream.Read(NextFrameC, sizeof(NextFrameC)); 			          // nächstmögliches Byte auslesen
          // Wieder zurück zur alten Position springen
          FileStream.Position:=FileStream.Position-Frame.Channelcount-3;
        end else
      	begin
          inc(Frame.LastKeyframe);

        	FileStream.Position:=FileStream.Position+Frame.Channelcount*3;	// 3*Channelcount-Bytes nach vorne springen, um nächsten Header zu suchen
          FileStream.Read(NextFrameA, sizeof(NextFrameA)); 			          // nächstmögliches Byte auslesen
      		FileStream.Read(NextFrameB, sizeof(NextFrameB)); 			          // nächstmögliches Byte auslesen
      		FileStream.Read(NextFrameC, sizeof(NextFrameC)); 			          // nächstmögliches Byte auslesen
          // Wieder zurück zur alten Position springen
          FileStream.Position:=FileStream.Position-Frame.Channelcount*3-3;
    		end;

        if ((NextFrameA=255) and ((NextFrameB AND 224)=224) and ((NextFrameB AND 24)<>24) and ((NextFrameB AND 3)<>3)) then
    	  begin
          FoundValidFrame:=true;
          if Frame.UsesCRC16 then
            LastValidFrame:=FileStream.Position-6
          else
            LastValidFrame:=FileStream.Position-4;
          IsLastFrame:=false;
        end;
        if ((char(NextFrameA)='T') and (char(NextFrameB)='A') and (char(NextFrameC)='G')) then
    	  begin
          FoundValidFrame:=true;
          if Frame.UsesCRC16 then
            LastValidFrame:=FileStream.Position-6
          else
            LastValidFrame:=FileStream.Position-4;
          IsLastFrame:=true;
        end;

        if FoundValidFrame then
        begin
          setlength(Frame.DMXarray, Frame.Channelcount);

          if Frame.IsKeyframe then
          begin
            // DMX-Keyframe-Daten auslesen
            for i:=0 to Frame.Channelcount-1 do
            begin
              Frame.DMXarray[i].Channel:=i+1;
              FileStream.Read(Frame.DMXarray[i].Value, sizeof(Frame.DMXarray[i].Value));
            end;
          end else
          begin
            // DMX-Daten auslesen
            for i:=0 to Frame.Channelcount-1 do
            begin
              FileStream.Read(SearchByte, sizeof(SearchByte));
              Frame.DMXarray[i].Channel:=SearchByte shl 8;
              FileStream.Read(SearchByte, sizeof(SearchByte));
              Frame.DMXarray[i].Channel:=Frame.DMXarray[i].Channel + SearchByte;
              FileStream.Read(Frame.DMXarray[i].Value, sizeof(Frame.DMXarray[i].Value));
            end;
          end;
        end;

        // CRC berechnen
        if Frame.UsesCRC16 then
          Frame.CRCok:=(CalcCRC16=Frame.CRC16);

        // Ende auch ohne "TAG" erkennen
        if (FileStream.Position+4)>=FileStream.Size then
          IsLastFrame:=true;
      end else
  	  begin
        // falsches Byte nach Startbyte
  	    FoundValidFrame:=false;
	    end;
    end else
  	begin
  	  // Byte war kein Startbyte
	    FoundValidFrame:=false;
  	end;
  until (FoundValidFrame=true) or (FileStream.Position>=FileStream.Size);

  result:=not IsLastFrame;
end;

procedure TForm1.ReadID;
var
  StoreFilePosition:Int64;
  NextFrameA, NextFrameB, NextFrameC:byte;
begin
  StoreFilePosition:=FileStream.Position;
  FileStream.Position:=FileStream.Size-128;

  FileStream.Read(NextFrameA, sizeof(NextFrameA)); 			          // nächstmögliches Byte auslesen
	FileStream.Read(NextFrameB, sizeof(NextFrameB)); 			          // nächstmögliches Byte auslesen
	FileStream.Read(NextFrameC, sizeof(NextFrameC)); 			          // nächstmögliches Byte auslesen
  if ((char(NextFrameA)='T') and (char(NextFrameB)='A') and (char(NextFrameC)='G')) then
  begin
    FileStream.Position:=FileStream.Size-128;
    FileStream.Read(IDTag, sizeof(IDTag));
  end else
  begin
    IDTag.Titel:='<kein TAG gefunden>';
    IDTag.Projectname:='';
    IDTag.Description:='';
    IDTag.Year:='';
    IDTag.Comment:='';
    IDTag.Reserved:=' ';
  end;

  FileStream.Position:=StoreFilePosition;
end;

procedure TForm1.DecodeFrameBtnClick(Sender: TObject);
begin
  DecodeFrame;
end;

procedure TForm1.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  decodetimer.Enabled:=not decodetimer.Enabled;
end;

procedure TForm1.RefreshFrameInfo;
var
  i:integer;
begin
  // Infos zum Frame anzeigen
  case Frame.Framerate of
    0: frameratelbl.Caption:='50 Hz (20ms)';
    1: frameratelbl.Caption:='10 Hz (100ms)';
    2: frameratelbl.Caption:='5 Hz (200ms)';
  end;
  keyframeintervallbl.Caption:=inttostr(Frame.KeyframeInterval);
  maxchanlbl.Caption:=inttostr(Frame.Channelcount);
  if Frame.UsesCRC16 then
  begin
    crclbl.Caption:='16Bit CRC: '+inttostr(Frame.CRC16);
    if Frame.CRCok then
      crcoklbl.Caption:='Gültig'
    else
      crcoklbl.Caption:='Fehler';
  end else
  begin
    crclbl.Caption:='kein CRC';
    crcoklbl.Caption:='kein CRC';
  end;
  if Frame.IsKeyframe then
    iskeyframelbl.Caption:='Ja'
  else
    iskeyframelbl.Caption:='Nein';

  listbox1.Items.Clear;
  for i:=0 to 11 do
  begin
    listbox1.Items.Add('Kanal '+inttostr(i+1)+' @ '+inttostr(DMXarray[i]))
  end;
end;

procedure TForm1.decodetimerTimer(Sender: TObject);
begin
  DecodeFrame;
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

procedure TForm1.OpenStream;
begin
  FileStream:=TFileStream.Create('c:\Demo.dmxs', fmOpenRead);
  Timer1.Enabled:=true;
  decodeframebtn.Enabled:=true;
  checkbox1.Enabled:=true;
  CloseBtn.Enabled:=true;
  OpenFileBtn.Enabled:=false;

  // ID-Tag auslesen
  ReadID;

  // ID-Tag anzeigen
  titlelbl.Caption:=IDTag.Titel;
  projectnamelbl.Caption:=IDTag.Projectname;
  descriptionlbl.Caption:=IDTag.Description;
  yearlbl.Caption:=IDTag.Year;
  commentlbl.Caption:=IDTag.Comment;
  reservedlbl.Caption:=IDTag.Reserved;
end;

procedure TForm1.CloseStream;
begin
  decodetimer.Enabled:=false;
  Timer1.Enabled:=false;
  checkbox1.Checked:=false;
  CloseBtn.Enabled:=false;
  OpenFileBtn.Enabled:=true;

  FileStream.Free;

  decodeframebtn.Enabled:=false;
  checkbox1.Enabled:=false;
end;

procedure TForm1.DecodeFrame;
var
  LastValidFrame:Int64;
  i:integer;
begin
  if not ReadFrameOutOfStream(LastValidFrame) then
  begin
    decodetimer.Enabled:=false;
    checkbox1.Checked:=false;
    showmessage('End of file reached');
    FileStream.Position:=0;
  end;

  for i:=0 to length(Frame.DMXarray)-1 do
  begin
    DMXarray[Frame.DMXarray[i].Channel-1]:=Frame.Dmxarray[i].Value;
  end;
  RefreshFrameInfo;
end;

end.
