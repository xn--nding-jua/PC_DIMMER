unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, Mask, JvExMask,
  JvSpin;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TOutputArray = array[0..511] of byte;

  TConfig = class(TForm)
    Label1: TLabel;
    ConfigOK: TButton;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;   
    Label2: TLabel;
    intervaledit: TJvSpinEdit;
    Label3: TLabel;
    DMXTimer: TCHHighResTimer;
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
    procedure intervaleditChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    DMXOutArray:TOutputArray;
    procedure StartOutput;
  end;

var
  Config: TConfig;

function OpenDmx:integer; stdcall external 'OpenDmx.dll';
function CloseDmx:integer; stdcall external 'OpenDmx.dll';
function SetStartCode(lngStartCode:integer):integer; stdcall external 'OpenDmx.dll';
function SetDmxRate(lngDmxRate:integer):integer; stdcall external 'OpenDmx.dll';
function UpdateDmx(lngPointerToDmxArray:Pointer):integer; stdcall external 'OpenDmx.dll';

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

procedure TConfig.Button2Click(Sender: TObject);
begin
  DMXTimer.Enabled:=false;
  CloseDmx;
end;

procedure TConfig.FormDestroy(Sender: TObject);
var
  LReg:TRegistry;
begin
  CloseDmx;

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
          LReg.WriteInteger('Refreshrate',round(intervaledit.value));
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.Button1Click(Sender: TObject);
begin
  OpenDmx;
  SetStartCode(0);
  SetDmxRate(44);
  UpdateDmx(@DMXOutArray);
  DMXTimer.Enabled:=true;
end;

procedure TConfig.DMXTimerTimer(Sender: TObject);
begin
  UpdateDmx(@DMXOutArray);
end;

procedure TConfig.intervaleditChange(Sender: TObject);
begin
  DMXTimer.Interval:=round(intervaledit.Value);
end;

procedure TConfig.StartOutput;
var
  LReg:TRegistry;
begin
	shutdown:=false;
	issending:=false;

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
	        if not LReg.ValueExists('Refreshrate') then
	          LReg.WriteInteger('Refreshrate',150);
	        intervaledit.value:=LReg.ReadInteger('Refreshrate');
          DMXTimer.Interval:=round(intervaledit.value);
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  OpenDmx;
  SetStartCode(0);
  SetDmxRate(44);
  UpdateDmx(@DMXOutArray);
  DMXTimer.Enabled:=true;
end;

end.
