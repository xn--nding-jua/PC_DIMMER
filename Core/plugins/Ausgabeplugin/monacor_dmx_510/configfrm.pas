unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, pngimage;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Timer1: TCHHighResTimer;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Timer2: TTimer;
    Image1: TImage;
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    issending:boolean;
    shutdown:boolean;
//    dmxout:array[0..509] of byte; // für alle 510 DMX-Kanäle
    dmxout:array of byte; // für alle 510 DMX-Kanäle
    dmxoutputok:boolean;
  end;

var
  Config: TConfig;

implementation

{$R *.dfm}

function GetDMXInterface: pchar; stdcall; external 'DMX510.dll';
function SetLevel(a: array of byte): boolean; stdcall; external 'DMX510.dll';
function GetMaxChannels: integer; external 'DMX510.dll';

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

procedure TConfig.RadioButton1Click(Sender: TObject);
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
	        LReg.WriteInteger('DMX Interfacetyp',1);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TConfig.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
begin
  SetLength(dmxout,510);
  dmxoutputok:=false;

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
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.Timer1Timer(Sender: TObject);
begin
  dmxoutputok:=SetLevel(dmxout);
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  Timer2.enabled:=true;
  Timer2Timer(Sender);
end;

procedure TConfig.Timer2Timer(Sender: TObject);
begin
  label11.caption:=GetDMXInterface;
  label8.caption:=inttostr(GetMaxChannels);

  if dmxoutputok then
    label9.caption:='OK'
  else
    label9.caption:='Fehler bei Datenübertragung!';
end;

procedure TConfig.FormHide(Sender: TObject);
begin
  Timer2.enabled:=false;
end;

end.
