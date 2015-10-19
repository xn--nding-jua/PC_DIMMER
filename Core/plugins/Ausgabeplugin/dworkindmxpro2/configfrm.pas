unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, CHHighResTimer;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    comport: TCommPortDriver;
    portchange: TComboBox;
    Label2: TLabel;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Button1: TButton;
    Label6: TLabel;
    Label3: TLabel;
    statuslabel: TLabel;
    SendTimer: TCHHighResTimer;
    procedure Button1Click(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    ConnectionProblem:boolean;
  public
    { Public-Deklarationen }
    ChannelValues:array[1..512] of Byte;
    ChannelChanged:array[1..512] of boolean;

    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    rs232frame:array of array[0..3] of Byte;
    rs232frame_locked:boolean;
    procedure Startup;
  end;

var
  Config: TConfig;

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

procedure TConfig.Button1Click(Sender: TObject);
var
  rs232frame_new:array[0..2] of Byte;
begin
// im Puffer alles auf 0 setzen
  FillChar(rs232frame_new, SizeOf(rs232frame_new), 0);

// Befehl schreiben
  rs232frame_new[0]:=84;

// Adresse in Byte 2 schreiben
  rs232frame_new[1]:=255;

// Endwert im Byte 3 schreiben
  rs232frame_new[2]:=0;

  if config.comport.Connected then
    config.comport.SendData(@rs232frame_new,3);
end;

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  if portchange.Items.Count=0 then exit;

  portchange.ItemIndex:=0;

  for i:=0 to portchange.items.count-1 do
  begin
    temp:=copy(portchange.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        if (i>=0) and (i<portchange.items.count) then
          portchange.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        if (i>=0) and (i<portchange.items.count) then
          portchange.ItemIndex:=i;
        break;
      end;
    end;
  end;
  portchangeSelect(nil);
end;

procedure TConfig.portchangeSelect(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if portchange.Items.Count > 0 then
  begin                
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    if config.comport.Connected then
      Config.comport.Disconnect;
    case comportnumber of
      1: comport.port:=pnCOM1;   2: comport.port:=pnCOM2;
      3: comport.port:=pnCOM3;   4: comport.port:=pnCOM4;
      5: comport.port:=pnCOM5;   6: comport.port:=pnCOM6;
      7: comport.port:=pnCOM7;   8: comport.port:=pnCOM8;
      9: comport.port:=pnCOM9;   10: comport.port:=pnCOM10;
      11: comport.port:=pnCOM11;   12: comport.port:=pnCOM12;
      13: comport.port:=pnCOM13;   14: comport.port:=pnCOM14;
      15: comport.port:=pnCOM15;   16: comport.port:=pnCOM16;
    end;
    if portchange.ItemIndex>-1 then
      comport.Connect;

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
            LReg.WriteInteger('COMPort',comportnumber);
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;

  if comport.Connected then
  begin
    statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
    statuslabel.Font.Color:=clGreen;
  end else
  begin
    statuslabel.Caption:='Nicht verbunden...';
    statuslabel.Font.Color:=clRed;
  end;
end;

procedure TConfig.SendTimerTimer(Sender: TObject);
var
  b:integer;
  rs232frame_new:array[0..2] of Byte;
  i:integer;
  Data1,Data2:integer;
begin
  for i:=1 to 512 do
  begin
    if ChannelChanged[i] then
    begin
      ChannelChanged[i]:=false;
      Data1:=i;
      Data2:=ChannelValues[i];

      FillChar(rs232frame_new, SizeOf(rs232frame_new), 0);
      b:=0;
      b:=b or $4C;                                {erste byte = Befehl}
      if Data1 >256 then
        b:=b or $1;                               {9. Bit setzen}
      rs232frame_new[0]:=b;                       {erste Byte in Puffer schreiben}
      b:=Data1;
      b:=b-1;
      if b>=256 then
        b:=b-256;
      rs232frame_new[1]:=b;                       {zweite Byte in Puffer schreiben}
      rs232frame_new[2]:=Data2;                   {dritte Byte in Puffer schreiben}

      if comport.Connected then
      begin
        connectionproblem:=(comport.SendData(@rs232frame_new,3)<>3);
        if connectionproblem then
        begin
          statuslabel.Caption:='Verbindungsproblem!';
          statuslabel.Font.Color:=clRed;
          SendTimer.Interval:=2000;
        end else
        begin
          statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
          statuslabel.Font.Color:=clGreen;
          SendTimer.Interval:=50;
        end;
      end;
    end;
  end;
end;

procedure Tconfig.Startup;
var
  LReg:TRegistry;
  serialport, i:integer;
begin
	shutdown:=false;
	issending:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  serialport:=2;

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
	        if not LReg.ValueExists('COMPort') then
	          LReg.WriteInteger('COMPort',2);
	        serialport:=LReg.ReadInteger('COMPort');
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  try
    if comport.Connected then
	  	comport.Disconnect;
  except
  end;

  // COM-Ports von 1 bis 16 abklappern
  portchange.Clear;
  for i:=1 to 16 do
  begin
    portchange.Items.Add('COM'+inttostr(i));
  end;
  if serialport>0 then
    ActivateCOMPort(serialport);

  if portchange.Items.Count > 0 then
  begin
    portchangeSelect(nil);
    portchange.Visible:=true;
  end else
    portchange.Visible:=false;
end;

end.
