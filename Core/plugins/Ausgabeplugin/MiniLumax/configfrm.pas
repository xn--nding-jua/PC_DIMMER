unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, pngimage, CHHighResTimer;

type
  TLumax_Point = record
    Ch1:DWORD;
    Ch2:DWORD;
    Ch3:DWORD;
    Ch4:DWORD;
    Ch5:DWORD;
    Ch6:DWORD;
    Ch7:DWORD;
    Ch8:DWORD;
    TTL:DWORD;
  end;

  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Label4: TLabel;
    Label1: TLabel;
    Image1: TImage;
    Button4: TButton;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Button2: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Timer1: TTimer;
    Label8: TLabel;
    Bevel1: TBevel;
    DMXTimer: TCHHighResTimer;
    procedure ConfigOKClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    issending:boolean;
    shutdown:boolean;
    DeviceCount, LumaxHandle:integer;
    DmxOutput, DmxInput, DMXInputLastValue: array[0..512] of Byte;
    ConnectedTo:string[9];
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    procedure SearchForDevices;
    procedure InitDevice(Seriennummer: string);
    procedure SendDmx;
    procedure ReadDmx;
    procedure CloseDevice;
    procedure Startup;
  end;

var
  Config: TConfig;

function Lumax_GetApiVersion:integer; stdcall external 'lumax.dll';   // Liefert die Versionsnummer der DLL zurück.
function Lumax_GetPhysicalDevices:integer ; stdcall external 'lumax.dll'; // Liefert als Ergebnis die Anzahl aller angeschlossenen Minilumax-Ausgabekarten zurück. Sofern keine Karte angeschlossen ist, wird 0 zurückgeliefert.
function Lumax_OpenDevice(PhysicalDevice:integer; Channel:integer):integer ; stdcall external 'lumax.dll'; // Öffnet das angegebene Gerät für die weitere Nutzung. Eine möglicherweise von vorheriger Nutzung noch laufende Laserausgabe wird angehalten, DMX512-Sender und -Empfänger werden abgeschaltet.
{
  PhysicalDevice = Nummer der zu öffnenden Ausgabekarte. Wenn die Funktion Lumax_GetPhysicalDevices als Ergebnis z.B. 3 zurückgeliefert hat, so können als mögliche Parameter für PhysicalDevice die Werte 1, 2 oder 3 übergeben werden. Alle angeschlossenen Karten werden anhand ihrer alphanumerischen Seriennummer aufsteigend sortiert. Karte Nummer 1 ist also immer die alphabetisch erste Karte.
  Channel = Immer auf 0 setzen.
}

function Lumax_CloseDevice(Handle:integer):integer ; stdcall external 'lumax.dll'; // Schließt das Gerät, so dass andere Programme darauf zugreifen können.

function Lumax_GetDeviceInfo(PhysicalDevice, Info_ID:integer; InBuffer:Pointer; InLength:integer; OutBuffer:Pointer; OutLength:integer):integer; stdcall external 'lumax.dll'; // Liefert Informationen zum angeschlossenen Gerät.
{
  PhysicalDevice	= Nummer der Ausgabekarte, die abgefragt werden soll. Es handelt sich nicht um das Handle, wie es von Lumax_OpenDevice zurückgeliefert wird, sondern um die laufende Nummer der Ausgabekarte. Wenn die Funktion Lumax_GetPhysicalDevices als Ergebnis z.B. 3 zurückgeliefert hat, so können als mögliche Parameter für PhysicalDevice die Werte 1, 2 oder 3 übergeben werden.
  Info_ID	= Art der Information, die abgefragt werden soll. Zulässige Werte siehe nachfolgende Tabelle.
  InBuffer	= Zeiger auf einen Puffer, in dem Daten stehen, die an die Funktion übergeben werden sollen.
  InLength	= Größe (in Bytes) des Puffers, auf den InBuffer zeigt.
  OutBuffer	= Zeiger auf einen Puffer, in dem die Funktion die zurückzuliefernden Daten ablegen kann.
  OutLength	= Größe (in Bytes) des Puffers, auf den InBuffer zeigt.

  Info_ID	Funktion
  1	Seriennummer der Karte abfragen.
  In dem Puffer, auf den OutBuffer zeigt, wird die alphanumerische Seriennummer (8 Zeichen plus Null-Byte) zurückgeliefert. Die Größe OutLength des Puffers muss also mindestens 9 Byte betragen. Es handelt sich um dieselbe Seriennummer, wie sie auch im Minilumax-Testprogramm in der rechten oberen Ecke angezeigt wird. Die Parameter InBuffer und InLength sind ungenutzt und sollten auf 0 gesetzt werden.
}

function Lumax_SendFrame(Handle:integer; Points:Pointer; NumOfPoints:integer; ScanSpeed:integer; UpdateMode:integer; TimeToWait:Pointer):integer ; stdcall external 'lumax.dll';
{
  Points = Pointer of TLumax_Point
  TimeToWait = Pointer of Integer

  Handle	Handle zur eindeutigen Identifizierung des Geräts
  Points	Zeiger auf einen Speicherbereich, in dem nacheinander alle Punkte des Frames hinterlegt sind. Die einzelnen Punkte haben den Datentyp TLumax_Point (siehe unten).
  NumOfPoints	Gibt die Anzahl der Punkte des Frames an.
  ScanSpeed	Gibt die Ausgabegeschwindigkeit (PPS, points per second) an. Gültig sind Werte zwischen 250 und 70000 PPS. Diese Ausgabegeschwindigkeit kommt erst zur Anwendung, wenn die Ausgabe dieses Frames startet. Die Geschwindigkeit eines möglicherweise aktuell noch laufenden Frames wird nicht geändert.
  UpdateMode	Immer auf 0 setzen.
  TimeToWait	Immer auf 0 setzen.
}

function Lumax_WaitForBuffer(Handle:integer; Timeout:integer; {@}TimeToWait:integer; {@}BufferChanged:integer):integer ; stdcall external 'lumax.dll';
{
  Handle	Handle zur eindeutigen Identifizierung des Geräts
  Timeout	Wenn als Timeout 0 angegeben wird, so wird lediglich der aktuelle Status abgefragt; die Funktion kehrt sofort zurück. Die Zeit bis zum Ende des Frames wird im Parameter TimeToWait zurückgeliefert, in BufferChanged steht, ob auf den zuletzt gesendeten Puffer bereits umgeschaltet wurde. Wenn bereits umgeschaltet wurde, also die Laserausgabe dieses Frames begonnen hat, dann ist dieser Wert logisch 1 und es kann mit der Übertragung des nächsten Frames begonnen werden.
  TimeToWait	Zeiger auf eine int-Variable, in der die Zeit (Millisekunden) bis zum Frameende zurückgeliefert wird (siehe Timeout).
  BufferChanged	Zeiger auf eine int-Variable, in der zurückgeliefert wird, ob bereits auf den nächsten Frame umgeschaltet wurde (=1) oder nicht (=0) (siehe Timeout).
}

function Lumax_StopFrame(Handle:integer):integer ; stdcall external 'lumax.dll'; // Hält die Laserausgabe an. Alle Farbkanäle werden auf den Wert 0 gesetzt. X- und Y-Achse werden auf die Bildmitte positioniert. Alle TTL-Ausgänge werden abgeschaltet.

function Lumax_SetTTL(Handle:integer; TTL:integer):integer ; stdcall external 'lumax.dll'; //
{
  Handle	Handle zur eindeutigen Identifizierung des Geräts
  TTL	Ein 32-Bit-Wert, dessen unterste 8 Bit auf den TTL-Ausgangspins ausgegeben werden.
}

function Lumax_SetDmxMode(Handle:integer; NumOfTxChannels:integer; NumOfRxChannels:integer):integer ; stdcall external 'lumax.dll'; //
{
  Handle	Handle zur eindeutigen Identifizierung des Geräts
  NumOfTxChannels	Anzahl der zu übertragenden DMX512-Nutzkanäle. Für einen kompletten DMX-Frame mit 1 Startbyte und 512 Nutzbytes muss der Wert also 512 sein. Der Wert 0 schaltet den DMX-Sender aus.
  NumOfRxChannels	Anzahl der maximal zu empfangenen DMX512-Nutzkanäle. Da laut DMX512-Spezifikation eine Länge von 512 Byte plus 1 Startbyte erlaubt ist, sollte der Wert auf 512 gesetzt werden, um den Empfänger zu aktivieren. Der Wert 0 schaltet den DMX-Empfänger aus.
}

function Lumax_SendDmx(Handle:integer; DmxBuffer:Pointer; Length:integer):integer ; stdcall external 'lumax.dll'; //
{
  DmxBuffer = Pointer of Byte

  Handle	Handle zur eindeutigen Identifizierung des Geräts
  DmxBuffer	Zeiger auf einen Speicherbereich, in dem die zu sendenden DMX-Daten liegen. Jeder DMX-Kanal belegt 1 Byte. Achtung: Das DMX-Startbyte wird an der ersten Stelle des Puffers erwartet (es sollte üblicherweise den Wert 0 haben), anschließend folgen die DMX-Nutzbytes.
  Length	Gibt die Anzahl der Bytes an, die in den Puffer der Ausgabekarte kopiert werden sollen, inklusive DMX-Startbyte. Für einen kompletten DMX-Frame mit 1 Startbyte und 512 Nutzbytes muss der Wert also 513 sein. Achtung: diese Angabe ist unabhängig von der tatsächlich ausgegebenen Länge der DMX-Frames; diese wird mit Lumax_SetDmxMode gesetzt.
}

function Lumax_ReceiveDmx(Handle:integer; DmxBuffer:Pointer; Length:integer):integer ; stdcall external 'lumax.dll'; //
{
  DmxBuffer = Pointer of Byte

  Handle	Handle zur eindeutigen Identifizierung des Geräts
  DmxBuffer	Zeiger auf einen Speicherbereich, in dem der empfangene DMX-Eingangspuffer abgelegt werden soll. Jeder DMX-Kanal belegt 1 Byte. Achtung: Das DMX-Startbyte wird an der ersten Stelle des Puffers abgelegt (es sollte üblicherweise den Wert 0 haben), anschließend folgen die DMX-Nutzbytes. Der Speicherbereich muss groß genug sein, um die mit Length angegebene Anzahl Bytes aufzunehmen.
  Length	Gibt die Anzahl der Bytes an, die in den angegebenen Speicherbereich kopiert werden sollen, inklusive DMX-Startbyte. Für einen kompletten DMX-Frame mit 1 Startbyte und 512 Nutzbytes muss der Wert also 513 sein.
}





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

procedure TConfig.ConfigOKClick(Sender: TObject);
begin
  close;
end;

procedure TConfig.SearchForDevices;
var
  i:integer;
  ResultBuffer:array[0..8] of char;
begin
  DeviceCount:=Lumax_GetPhysicalDevices;

  combobox1.Clear;

  for i:=0 to DeviceCount-1 do
  begin
    Lumax_GetDeviceInfo(i, 1, nil, 0, @ResultBuffer, 9);
    combobox1.Items.Add(ResultBuffer);
  end;
end;

procedure TConfig.InitDevice(Seriennummer: string);
var
  i,DeviceToConnect:integer;
  LReg:TRegistry;
begin
  // Verbundene Geräte suchen
  DeviceToConnect:=0;
  DeviceCount:=Lumax_GetPhysicalDevices;

  for i:=0 to combobox1.items.count-1 do
  begin
    if Seriennummer=combobox1.items[i] then
    begin
      DeviceToConnect:=i+1;
    end;
  end;

  if (DeviceCount>0) and (DeviceToConnect>0) then
  begin
    LumaxHandle:=Lumax_OpenDevice(DeviceToConnect,0);  // Mit erstem verfügbaren Gerät verbinden
    if LumaxHandle<>0 then
    begin
      // Verbindung hergestellt
      ConnectedTo:=combobox1.Items[DeviceToConnect];
      Lumax_SetDmxMode(LumaxHandle, 512, 512);
      DMXTimer.Enabled:=true;
    end else
    begin
      ConnectedTo:='---------';
      DMXTimer.Enabled:=false;
    end;
  end else
  begin
    ConnectedTo:='---------';
    DMXTimer.Enabled:=false;
  end;

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
          LReg.WriteString('Last Device',ConnectedTo);
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.SendDmx;
begin
  if LumaxHandle<>0 then
    Lumax_SendDmx(LumaxHandle, @DmxOutput, 513);
end;

procedure TConfig.ReadDmx;
var
  i:integer;
begin
  if LumaxHandle<>0 then
  begin
    Lumax_ReceiveDmx(LumaxHandle, @DmxInput, 513);

    for i:=1 to 512 do
    begin
      if config.shutdown then exit;
      if DmxInput[i]<>DmxInputLastValue[i] then
      begin
        DmxInputLastValue[i]:=DmxInput[i];
//        if usedatainevent then
          RefreshDLLEvent(i,DmxInput[i])
//        else
//          RefreshDLLValues(i+Channeloffset+1,DmxInput[i],DmxInput[i],0,0);
      end;
    end;
  end;
end;

procedure TConfig.CloseDevice;
begin
  LumaxHandle:=0;
  DMXTimer.Enabled:=false;
  Lumax_CloseDevice(LumaxHandle);
  ConnectedTo:='---------';
end;

procedure TConfig.Button4Click(Sender: TObject);
begin
  if (combobox1.itemindex>-1) and (combobox1.itemindex<combobox1.Items.Count) then
    InitDevice(combobox1.Items[combobox1.itemindex]);
end;

procedure TConfig.Button1Click(Sender: TObject);
begin
  CloseDevice;
end;

procedure TConfig.Button2Click(Sender: TObject);
begin
  SearchForDevices;
end;

procedure TConfig.Timer1Timer(Sender: TObject);
begin
  label5.caption:=ConnectedTo;
  if label5.Caption='---------' then
    label5.Font.Color:=clRed
  else
    label5.Font.Color:=clGreen;
  label8.caption:=inttostr(DeviceCount);
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  Timer1.Enabled:=true;
end;

procedure TConfig.FormHide(Sender: TObject);
begin
  Timer1.Enabled:=false;
end;

procedure TConfig.DMXTimerTimer(Sender: TObject);
begin
  SendDMX;
  ReadDMX;
end;

procedure Tconfig.startup;
var
  LReg:TRegistry;
  tempstr:string;
begin
  ConnectedTo:='---------';

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
          if LReg.ValueExists('Last Device') then
          begin
            ConnectedTo:=LReg.ReadString('Last Device');
          end;
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  tempstr:=inttostr(Lumax_GetApiVersion);
  insert('.',tempstr,2);
  insert('.',tempstr,4);
  Label7.caption:=tempstr;

  SearchForDevices;
  InitDevice(ConnectedTo);
end;

end.

