unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, JvExMask, JvSpin, CHHighResTimer, Registry;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label2: TLabel;
    statuslabel: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    AddressEdit: TJvSpinEdit;
    Label1: TLabel;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    switchvalueedit: TJvSpinEdit;
    CHHighResTimer1: TCHHighResTimer;
    Label4: TLabel;
    startaddressedit: TJvSpinEdit;
    Button3: TButton;
    Label5: TLabel;
    intervaledit: TJvSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CHHighResTimer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure intervaleditChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
    DeviceHandle:integer;
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    shutdown:boolean;
    Channelvalue:array[1..10] of Integer;
    InputValue:array[1..7] of Integer;
    OldInputValue:array[1..7] of Integer;
    procedure Senddata(Channel, Value:integer);
    procedure Startup;
  end;

var
  Config: TConfig;

function OpenDevice(CardAddress: integer):integer; stdcall; external 'K8055d.dll';
procedure CloseDevice; stdcall; external 'K8055d.dll';
function ReadAnalogChannel(Channel: integer):integer; stdcall; external 'K8055d.dll';
procedure ReadAllAnalog(var Data1, Data2:integer); stdcall; external 'K8055d.dll';
procedure OutputAnalogChannel(Channel, Data:integer); stdcall; external 'K8055d.dll';
procedure OutputAllAnalog(Data1, Data2:integer); stdcall; external 'K8055d.dll';
procedure ClearAnalogChannel(Channel: integer); stdcall; external 'K8055d.dll';
procedure ClearAllAnalog; stdcall; external 'K8055d.dll';
procedure SetAnalogChannel(Channel: integer); stdcall; external 'K8055d.dll';
procedure SetAllAnalog; stdcall; external 'K8055d.dll';
procedure WriteAllDigital(Data: integer); stdcall; external 'K8055d.dll';
procedure ClearDigitalChannel(Channel: integer); stdcall; external 'K8055d.dll';
procedure ClearAllDigital(Data: integer); stdcall; external 'K8055d.dll';
procedure SetDigitalChannel(Channel: integer); stdcall; external 'K8055d.dll';
procedure SetAllDigital; stdcall; external 'K8055d.dll';
function ReadDigitalChannel(Channel:integer):boolean; stdcall; external 'K8055d.dll';
function ReadAllDigital:integer; stdcall; external 'K8055d.dll';
procedure ResetCounter(CounterNumber:integer); stdcall; external 'K8055d.dll';
function ReadCounter(CounterNumber:integer):integer; stdcall; external 'K8055d.dll';
function SetCounterDebounceTime(CounterNr, DebounceTime:integer):integer; stdcall; external 'K8055d.dll';

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
begin
  DeviceHandle:=OpenDevice(Round(AddressEdit.Value));

  case DeviceHandle of
    0..3:
    begin
      statuslabel.caption:='Verbunden mit Gerät '+inttostr(DeviceHandle);
      statuslabel.Font.Color:=clGreen;
    end;
    else
    begin
      statuslabel.caption:='Nicht verbunden...';
      statuslabel.Font.Color:=clRed;
    end;
  end;
end;

procedure TConfig.Button2Click(Sender: TObject);
begin
  CloseDevice;
  DeviceHandle:=-1;
  statuslabel.caption:='Nicht verbunden...';
  statuslabel.Font.Color:=clRed;
end;

procedure TConfig.Senddata(Channel, Value:integer);
begin
  if (DeviceHandle>=0) and (DeviceHandle<=3) then
  begin
    case Channel of
      1..8:
      begin
        // Digital Output
        if Value>switchvalueedit.value then
          SetDigitalChannel(Channel)
        else
          ClearDigitalChannel(Channel);
      end;
      9..10:
      begin
        // Analog Output
        OutputAnalogChannel(Channel-8, Value);
      end;
    end;
  end;
end;

procedure TConfig.CHHighResTimer1Timer(Sender: TObject);
var
  ADC1, ADC2 ,i:integer;
begin
  if (DeviceHandle>=0) and (DeviceHandle<=3) then
  begin
    for i:=1 to 5 do
    begin
      if ReadDigitalChannel(i) then
        InputValue[i]:=255
      else
        InputValue[i]:=0;
    end;

    ReadAllAnalog(ADC1, ADC2);

    InputValue[6]:=ADC1;
    InputValue[7]:=ADC2;

    for i:=1 to 7 do
    begin
      if InputValue[i]<>OldInputValue[i] then
      begin
        OldInputValue[i]:=InputValue[i];
        RefreshDLLEvent(Round(startaddressedit.value), InputValue[i]);
      end;
    end;
  end;
end;

procedure TConfig.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TConfig.intervaleditChange(Sender: TObject);
begin
  CHHighResTimer1.Interval:=Round(intervaledit.value);
end;

procedure TConfig.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
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
          LReg.WriteInteger('Last Address',Round(AddressEdit.Value));
          LReg.WriteInteger('Switchvalue',Round(switchvalueedit.Value));
          LReg.WriteInteger('Startaddress',Round(startaddressedit.Value));
          LReg.WriteInteger('Scaninterval',Round(intervaledit.Value));
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tconfig.Startup;
var
  LReg:TRegistry;
begin
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
	        if not LReg.ValueExists('Last Address') then
	          LReg.WriteInteger('Last Address',0);
          AddressEdit.Value:=LReg.ReadInteger('Last Address');
	        if not LReg.ValueExists('Switchvalue') then
	          LReg.WriteInteger('Switchvalue',127);
          switchvalueedit.Value:=LReg.ReadInteger('Switchvalue');
	        if not LReg.ValueExists('Startaddress') then
	          LReg.WriteInteger('Startaddress',1);
          startaddressedit.Value:=LReg.ReadInteger('Startaddress');
	        if not LReg.ValueExists('Scaninterval') then
	          LReg.WriteInteger('Scaninterval',50);
          intervaledit.Value:=LReg.ReadInteger('Scaninterval');
          CHHighResTimer1.Interval:=Round(intervaledit.value);
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Button1Click(nil);
end;

end.
