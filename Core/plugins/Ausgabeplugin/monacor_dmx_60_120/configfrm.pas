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
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox1: TGroupBox;
    Timer1: TCHHighResTimer;
    Timer2: TTimer;
    Label7: TLabel;
    Label8: TLabel;
    Image1: TImage;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    issending:boolean;
    shutdown:boolean;
    Channelvalue:array[0..511] of byte;
    dmxout60:array[0..63] of byte;  //Array mit 64 Elementen der Daten
    dmxout120:array[0..119] of byte;  //Array mit 120 Elementen der Daten
    dmxoutok:boolean;
  end;

var
  Config: TConfig;

implementation

{$R *.dfm}

function OutDMX60(a,b: byte): boolean; stdcall external 'DMX60.dll' name 'OutDMX';
function OutDMX120(a,b: byte): boolean; stdcall external 'DMX120.dll' name 'OutDMX';

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
  LReg.Free;
end;

procedure TConfig.RadioButton2Click(Sender: TObject);
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
	        LReg.WriteInteger('DMX Interfacetyp',2);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
begin
  dmxoutok:=false;

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
          if not LReg.ValueExists('DMX Interfacetyp') then
            LReg.WriteInteger('DMX Interfacetyp',1);
	        case LReg.ReadInteger('DMX Interfacetyp') of
            1: RadioButton1.Checked:=true;
            2: RadioButton2.Checked:=true;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.Timer1Timer(Sender: TObject);
var
  i:byte;
begin
  if Radiobutton1.Checked then
  begin
    try
      for i:=0 to 63 do
        dmxoutok:=OutDMX60(i,dmxout60[i]); // hier wird die DLL aufgerufen und damit das Datenarray ausgegeben
                            // i= Kanalnummer und dmxout[i]= Ausgabewert des entsprechenden DMX-Kanals
                            // Achtung : Die DLL wartet so lange mit dem Ausgeben der DMX-Werte, bis
                            // Kanal 64 (i=63) übergeben wurde !!!!!
    except
    end;
  end;
  if Radiobutton2.Checked then
  begin
    try
      for i:=0 to 119 do
        dmxoutok:=OutDMX120(i,dmxout120[i]); // hier wird die DLL aufgerufen und damit das Datenarray ausgegeben
                            // i= Kanalnummer und dmxout[i]= Ausgabewert des entsprechenden DMX-Kanals
                            // Achtung : Die DLL wartet so lange mit dem Ausgeben der DMX-Werte, bis
                            // Kanal 120 (i=119) übergeben wurde !!!!!
    except
    end;
  end;
end;

procedure TConfig.Timer2Timer(Sender: TObject);
begin
  if dmxoutok then
    label8.caption:='OK!'
  else
    label8.caption:='Nicht verbunden!';
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  Timer2.enabled:=true;
  Timer2Timer(Sender);
end;

procedure TConfig.FormHide(Sender: TObject);
begin
  Timer2.enabled:=false;
end;

end.
