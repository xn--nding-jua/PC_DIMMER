unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, pngimage;

const
DHC_OPEN                =   1;   // COMMAND
DHC_CLOSE               = 	2;   // COMMAND
DHC_DMXOUTOFF           = 	3;   // COMMAND
DHC_DMXOUT              = 	4;   // COMMAND
DHC_PORTREAD            = 	5;   // COMMAND
DHC_PORTCONFIG          = 	6;   // COMMAND
DHC_VERSION             = 	7;   // COMMAND
DHC_RESET               = 	11;  // COMMAND
DHC_DEBUG_OPEN          = 	12;  // COMMAND
DHC_DEBUG_CLOSE         = 	13;  // COMMAND
DHC_WRITEMEMORY         = 	21;  // COMMAND
DHC_READMEMORY          = 	22;  // COMMAND
DHC_SIZEMEMORY          = 	23;  // COMMAND
DHC_TRANSPORT           = 	30;  // COMMAND
DHP_TRANSPORT_MODEALW   = 	1;   // PARAM
DHP_TRANSPORT_MODEALW32 =	  2;   // PARAM
DHP_TRANSPORT_MODEOPT   = 	3;   // PARAM (DEFAULT)
DHP_TRANSPORT_MODEOPT32 = 	4;   // PARAM
DHC_SERIALNREAD         = 	47;  // COMMAND
DHC_SERIALNWRITE        = 	48;  // COMMAND
DHE_OK                  = 	1;   // RETURN NO ERROR
DHE_NOTHINGTODO         = 	2;   // RETURN NO ERROR
DHE_ERROR_COMMAND       =	  -1;  // RETURN ERROR
DHE_ERROR_NOTOPEN       =	  -2;  // RETURN ERROR
DHE_DMXOUT_PACKREAD     =	  -1100;  // RETURN ERROR

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Label1: TLabel;
    DMXValueRefreshTimer: TCHHighResTimer;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    procedure DMXValueRefreshTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    issending:boolean;
    shutdown:boolean;
    OutDmx:array[0..511] of byte;
    procedure Startup;
  end;

var
  Config: TConfig;

function OksidCommand(Command, Parameter: Integer; Buffer: Pointer):Integer; stdcall; external 'DasHard.dll';
//function DasHardCommand(Command, Parameter: Integer; Buffer: Pointer):Integer; stdcall; external 'DasHard.dll';

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

procedure TConfig.DMXValueRefreshTimerTimer(Sender: TObject);
begin
  OksidCommand(DHC_DMXOUT, 512, @OutDmx);
end;

procedure TConfig.FormDestroy(Sender: TObject);
begin
  OksidCommand(DHC_CLOSE, 0, nil);
//  OksidCommand(DHC_DEBUG_CLOSE, 0, nil);
end;

procedure Tconfig.Startup;
var
  value:integer;
begin
  value:=OksidCommand(DHC_OPEN, 0, nil);

  if value<0 then label3.Caption:='Verbindungsfehler...' else
  if value=DHE_OK then label3.Caption:='Interface OK' else
  if value=DHE_NOTHINGTODO then label3.Caption:='Kein Interface gefunden...' else
  if value=3 then label3.Caption:='USBDMX1 gefunden...' else
  if value=11 then label3.Caption:='USBDMX2 gefunden...' else
    label3.Caption:='Unbekanntes Interface gefunden...';

  OksidCommand(DHC_DMXOUTOFF, 0, nil);

//  OksidCommand(DHC_DEBUG_OPEN, 0, nil);
end;

end.
