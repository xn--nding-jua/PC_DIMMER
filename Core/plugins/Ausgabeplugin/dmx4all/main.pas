unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, DMX4ALL_Defines, Mask, JvExMask,
  JvSpin, XPMan, Grids, CHHighResTimer, Registry;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = procedure(address:integer);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; ARG:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    Shape1: TShape;
    XPManifest1: TXPManifest;
    Button23: TButton;
    Button25: TButton;
    StringGrid1: TStringGrid;
    DMXTimer: TCHHighResTimer;
    GroupBox1: TGroupBox;
    Button16: TButton;
    Button17: TButton;
    Button15: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label6: TLabel;
    maxchansedit: TJvSpinEdit;
    refreshtimeedit: TJvSpinEdit;
    maxchangedchansedit: TJvSpinEdit;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    PaintBox1: TPaintBox;
    Label8: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label11: TLabel;
    Timer1: TTimer;
    interfaceinfo: TMemo;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure ConfigOKClick(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure maxchanseditChange(Sender: TObject);
    procedure refreshtimeeditChange(Sender: TObject);
    procedure maxchangedchanseditChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    numDevs:DWORD;
    maxchangedchans:integer;
    maxchans:integer;
    refreshtime, refreshtime_dmxout, refreshtime_dmxin:integer;
    lastport:integer;
    VersionInfo:TVERSION_INFO;

    function ErrorStr(ErrorCode: integer):string;
    function ProductStr(ProductID: integer):string;
    procedure RefreshInterfaceInfo;
  public
    { Public-Deklarationen }
    DMXOutArray, DMXInArray, DMXInOldArray: PData;
    DMXIn_Part1, DMXIn_Part2, DMXIn_Part3, DMXIn_Part4:PData;

    ChannelvaluesChanged:array of integer;
    ChangedChannels:integer;
    issending:boolean;

    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    procedure StartUp;
  end;

var
  mainform: Tmainform;

implementation

uses messageform;

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

function TMainform.ErrorStr(ErrorCode: integer):string;
begin
  case ErrorCode of
    0: result:='Es liegt kein Fehler vor';
    1: result:='COM-Port nicht verfügbar...';
    2: result:='Kein DMX4ALL-Interface gefunden...';
    3: result:='USB Verbindung konnte nicht geöffnet werden...';
    4: result:='Ungültiger Port...';
    10: result:='Übertragung fehlgeschlagen...';
  else
    result:='Unbekannter Fehler (Error '+inttostr(ErrorCode)+')...';
  end;
end;

function TMainform.ProductStr(ProductID: integer):string;
begin
  case ProductID of
    0: result:='Kein DMX4ALL-Interface gefunden!';
    2: result:='Mini-USB-DMX-Interface';
    3: result:='PC-DMX-Interface V3';
    4: result:='PC-DMX-Interface V4';
    5: result:='Easy-Light-Control';
    6: result:='USB-DMX STAGE-PROFI MK2';
    7: result:='LAN-DMX STAGE-PROFI';
    8: result:='DMX-Player S';
    9: result:='DMX-Player XL';
    10: result:='DMX-Player XS';
    11: result:='DMX-Player M';
    20: result:='DMX-IN STAGE-PROFI';
  else
    result:='Unbekanntes Interface (ID '+inttostr(ProductID)+')...';
  end;
end;

procedure Tmainform.Button15Click(Sender: TObject);
begin
  Dmx4allRebootInterface;
end;

procedure Tmainform.Button16Click(Sender: TObject);
begin
  Dmx4allSetBlackOut(true);
end;

procedure Tmainform.Button17Click(Sender: TObject);
begin
  Dmx4allSetBlackOut(false);
end;

procedure Tmainform.ConfigOKClick(Sender: TObject);
begin
  close;
end;

procedure Tmainform.Button23Click(Sender: TObject);
begin
  if StringGrid1.Row>0 then
  begin
    Dmx4allOpenPort(strtoint(StringGrid1.Cells[0,StringGrid1.Row]));
    DMXTimer.Enabled:=true;
    lastport:=strtoint(StringGrid1.Cells[0,StringGrid1.Row]);
  end;
end;

procedure Tmainform.Button25Click(Sender: TObject);
begin
  Dmx4allClosePort;
  DMXTimer.Enabled:=false;
  interfaceinfo.Lines.Clear;
  label11.Caption:='Nicht verbunden...';
end;

procedure Tmainform.FormShow(Sender: TObject);
var
  i:integer;
  PortIndex:DWORD;
  Desc:array[0..49] of char;
  Port:Integer;
  Baudrate:DWord;
begin
  if numDevs>0 then
  begin
    StringGrid1.RowCount:=numDevs+1;

    for i:=0 to numDevs-1 do
    begin
      Dmx4allGetInterfaceDetail(i, @PortIndex, Desc, 50);

      StringGrid1.Cells[0, i+1]:=inttostr(PortIndex);
      StringGrid1.Cells[1, i+1]:=Desc;
    end;
  end else
  begin
    // Keine Geräte angeschlossen
    StringGrid1.RowCount:=2;
    StringGrid1.Cells[0,1]:='';
    StringGrid1.Cells[1,1]:='';
  end;

{
  Dmx4allGetProductID(@ID);
  label3.caption:=ProductStr(ID);
  if ID=0 then
  begin
    label3.font.color:=clRed;
  end else
  begin
    label3.font.color:=clGreen;
  end;
}
{
  Dmx4allLastError(@ID);

//  if ID=6 then ID:=0;
  if ID=20 then ID:=0;

  label5.caption:=ErrorStr(ID);
  if ID=0 then
  begin
    label5.font.color:=clGreen;
  end else
  begin
    label5.font.color:=clRed;
  end;
}

  StringGrid1.Cells[0,0]:='Port';
  StringGrid1.Cells[1,0]:='Gefundene Interfaces';

  Dmx4allGetComParameters(@Port, @Baudrate);
  label11.caption:='Verbunden mit Port '+inttostr(port)+' mit '+inttostr(Baudrate)+' Baud';

  Timer1.enabled:=true;
end;

procedure Tmainform.DMXTimerTimer(Sender: TObject);
var
  i,chans:integer;
begin
  if Checkbox1.Checked then
  begin
    // Liefert die DMX-Werte vom DMX-IN
    // Get the dmx levels from the DMX-IN
    // FirstChannel = 0...511    erster zu lesender Kanal
    // NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
    // pData		= BYTE-Array der größe NrOfBytes
    Dmx4allGetInDmx(1+0*128, length(DMXIn_Part1), DMXIn_Part1);
    if refreshtime<25 then
    begin
      refreshtime:=25;
      refreshtimeedit.Value:=refreshtime;
    end;

    if RadioButton2.Checked or RadioButton3.Checked or RadioButton4.Checked then
    begin
      Dmx4allGetInDmx(1+1*128, length(DMXIn_Part2), DMXIn_Part2);
      if refreshtime<50 then
      begin
        refreshtime:=50;
        refreshtimeedit.Value:=refreshtime;
      end;
    end;
    if RadioButton3.Checked or RadioButton4.Checked then
    begin
      Dmx4allGetInDmx(1+2*128, length(DMXIn_Part3), DMXIn_Part3);
      if refreshtime<75 then
      begin
        refreshtime:=75;
        refreshtimeedit.Value:=refreshtime;
      end;
    end;
    if RadioButton4.Checked then
    begin
      Dmx4allGetInDmx(1+3*128, length(DMXIn_Part4), DMXIn_Part4);
      if refreshtime<100 then
      begin
        refreshtime:=100;
        refreshtimeedit.Value:=refreshtime;
      end;
    end;

    for i:=0 to 127 do
    begin
      DMXInArray[i+0*128]:=DMXIn_Part1[i];
      if RadioButton2.Checked or RadioButton3.Checked or RadioButton4.Checked then
        DMXInArray[i+1*128]:=DMXIn_Part2[i];
      if RadioButton3.Checked or RadioButton4.Checked then
        DMXInArray[i+2*128]:=DMXIn_Part3[i];
      if RadioButton4.Checked then
        DMXInArray[i+3*128]:=DMXIn_Part4[i];
    end;

    Chans:=128;
    if Radiobutton1.Checked then
      Chans:=128;
    if Radiobutton2.Checked then
      Chans:=256;
    if Radiobutton3.Checked then
      Chans:=384;
    if Radiobutton4.Checked then
      Chans:=512;

    for i:=0 to chans do
    begin
      if DMXInArray[i]<>DMXInOldArray[i] then
      begin
        SetDLLValueEvent(i+1, DMXInArray[i]);
        DMXInOldArray[i]:=DMXInArray[i];
      end;
    end;
  end else
  begin
    if ChangedChannels>=maxchangedchans then
    begin
      // Gesamtes Universe senden, da zuviele Werte in dieser Zeit verändert
      Dmx4allSetDmx(1, maxchans, DMXOutArray);
    end else
    begin
      // Einzelne Kanäle senden, da nur wenige Kanäle geändert wurden
      for i:=length(ChannelvaluesChanged)-1 downto 0 do
      begin
        Dmx4allSetDmxCh(ChannelvaluesChanged[i],DMXOutArray[ChannelvaluesChanged[i]-1]);
      end;
    end;
    setlength(ChannelvaluesChanged,0);
    ChangedChannels:=0;
  end;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
begin
  DMXTimer.Enabled:=false;
//  Dmx4allClosePort;
end;

procedure Tmainform.maxchanseditChange(Sender: TObject);
begin
  maxchans:=round(maxchansedit.value);
end;

procedure Tmainform.refreshtimeeditChange(Sender: TObject);
begin
  refreshtime:=round(refreshtimeedit.value);
  if checkbox1.Checked then
    refreshtime_dmxin:=refreshtime
  else
    refreshtime_dmxout:=refreshtime;
  DMXTimer.Interval:=refreshtime;
end;

procedure Tmainform.maxchangedchanseditChange(Sender: TObject);
begin
  maxchangedchans:=round(maxchangedchansedit.value);
end;

procedure Tmainform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  Timer1.enabled:=false;

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
          LReg.WriteInteger('MaxChangedChans',maxchangedchans);
          LReg.WriteInteger('RefreshTime',refreshtime_dmxout);
          LReg.WriteInteger('RefreshTime_DmxIn',refreshtime_dmxin);
          LReg.WriteInteger('MaxChans',maxchans);
          LReg.WriteInteger('LastOpenedPort',lastport);
          LReg.WriteBool('DMXInputEnabled',checkbox1.checked);

          if Radiobutton1.checked then
            LReg.WriteInteger('NrOfDMXINChans',128);
          if Radiobutton2.checked then
            LReg.WriteInteger('NrOfDMXINChans',256);
          if Radiobutton3.checked then
            LReg.WriteInteger('NrOfDMXINChans',384);
          if Radiobutton4.checked then
            LReg.WriteInteger('NrOfDMXINChans',512);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Checkbox1.Checked then
  begin
    refreshtime:=refreshtime_dmxin;
    refreshtimeedit.Value:=refreshtime;
  end else
  begin
    refreshtime:=refreshtime_dmxout;
    refreshtimeedit.Value:=refreshtime;
  end;
  DMXTimer.Interval:=round(refreshtimeedit.Value);

  maxchangedchansedit.enabled:=not Checkbox1.Checked;
  Label2.enabled:=not Checkbox1.Checked;
  maxchansedit.enabled:=not Checkbox1.Checked;
  Label7.enabled:=not Checkbox1.Checked;
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  Dmx4allSetComParameters(19200);
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  Dmx4allSetComParameters(38400);
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  Paintbox1.Canvas.Brush.Color:=clBlack;
  Paintbox1.Canvas.Pen.Color:=clBlue;
  Paintbox1.Canvas.Rectangle(0, 0, 512, Paintbox1.Height);
  for i:=0 to length(DMXInArray)-1 do
  begin
    Paintbox1.Canvas.MoveTo(i, Paintbox1.Height);
    Paintbox1.Canvas.LineTo(i, Paintbox1.Height-round(Paintbox1.Height*(DMXInArray[i]/255)));
  end;
end;

procedure Tmainform.RefreshInterfaceInfo;
var
  so:string;
begin
  interfaceinfo.Lines.Clear;
  if VersionInfo.SignalOutput then
    so:='Ja'
  else
    so:='Nein';

  interfaceinfo.Text:=VersionInfo.InterfaceInfo+#13#10+
                      'Hardware-Version: v'+inttostr(trunc(VersionInfo.HW_Version/100))+'.'+inttostr(round(frac(VersionInfo.HW_Version/100)*100))+#13#10+
                      'Anzahl an Dmx-Daten: '+inttostr(VersionInfo.NrOfDmxData)+#13#10+
                      'DMX512-Ausgang: '+so+#13#10+
                      'Merge-Mode: '+inttostr(VersionInfo.MergeMode)+#13#10+
                      'Merge-Start: '+inttostr(VersionInfo.MergeStart)+#13#10+
                      'Merge-Stop: '+inttostr(VersionInfo.MergeStop);
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  Dmx4allGetInfo(@VersionInfo);
  RefreshInterfaceInfo;
end;

procedure Tmainform.StartUp;
var
  LReg:TRegistry;
begin
  Application.CreateForm(Tmessagefrm, messagefrm);
  messagefrm.show;
  messagefrm.memo1.lines.add('DMX4ALL-Interfaces werden gesucht...');
  messagefrm.refresh;

  setlength(DMXOutArray, 512);
  setlength(DMXInArray, 512);
  setlength(DMXInOldArray, 512);

  setlength(DMXIn_Part1, 128);
  setlength(DMXIn_Part2, 128);
  setlength(DMXIn_Part3, 128);
  setlength(DMXIn_Part4, 128);

  issending:=false;
  maxchangedchans:=25;
  refreshtime:=50;
  refreshtime_dmxout:=50;
  refreshtime_dmxin:=50;
  maxchans:=256;

  // Nach Interfaces suchen
  Dmx4allCreateInterfaceList(@numDevs);

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
          if LReg.ValueExists('MaxChangedChans') then
          begin
            maxchangedchans:=LReg.ReadInteger('MaxChangedChans');
            maxchangedchansedit.Value:=maxchangedchans;
          end;

          if LReg.ValueExists('RefreshTime') then
          begin
            refreshtime_dmxout:=LReg.ReadInteger('RefreshTime');
            refreshtime:=refreshtime_dmxout;
            refreshtimeedit.Value:=refreshtime;
            DMXTimer.Interval:=refreshtime;
          end;

          if LReg.ValueExists('RefreshTime_DmxIn') then
          begin
            refreshtime_dmxin:=LReg.ReadInteger('RefreshTime_DmxIn');
          end;

          if LReg.ValueExists('MaxChans') then
          begin
            maxchans:=LReg.ReadInteger('MaxChans');
            maxchansedit.Value:=maxchans;
          end;

          if LReg.ValueExists('LastOpenedPort') then
          begin
            lastport:=LReg.ReadInteger('LastOpenedPort');
            try
              messagefrm.memo1.lines.add('Verbindung mit Interface wird hergestellt...');
              messagefrm.refresh;
              Dmx4allOpenPort(lastport);
              DMXTimer.Enabled:=true;
            except
            end;
          end;

          if LReg.ValueExists('DMXInputEnabled') then
          begin
            checkbox1.Checked:=LReg.ReadBool('DMXInputEnabled');
            CheckBox1MouseUp(checkbox1, mbLeft, [ssLeft], 0, 0);
          end;

          if LReg.ValueExists('NrOfDMXINChans') then
          begin
            Radiobutton1.checked:=LReg.ReadInteger('NrOfDMXINChans')=128;
            Radiobutton2.checked:=LReg.ReadInteger('NrOfDMXINChans')=256;
            Radiobutton3.checked:=LReg.ReadInteger('NrOfDMXINChans')=384;
            Radiobutton4.checked:=LReg.ReadInteger('NrOfDMXINChans')=512;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  messagefrm.hide;
  messagefrm.Free;
end;

end.
