unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Edit2: TEdit;
    Timer2: TTimer;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure input_number(var pos:integer; var s:string);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ConfigOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
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
    Channelvalue:array[0..511] of byte;
    OutDmx:array[0..511] of byte;
    InDmx:array[0..511] of byte;
  end;

var
  Config: TConfig;

function Okdmx31Write(Port: Integer; Universe: Byte; Buffer: Pointer):integer ; stdcall; external 'okdmx31.dll';
function Okdmx31Read(Port: Integer; Universe: Byte; Buffer: Pointer):integer ; stdcall; external 'okdmx31.dll';

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

procedure TConfig.Timer1Timer(Sender: TObject);
var
  lpt:integer;
begin
  lpt:=888;
  case Combobox1.ItemIndex of
    1: lpt:=888;
    2: lpt:=632;
  end;

  Okdmx31Write(lpt, Combobox2.ItemIndex, @OutDmx);
end;

procedure TConfig.Timer2Timer(Sender: TObject);
var
  lpt,i:integer;
begin
  if Checkbox1.Checked then
  begin

    lpt:=888;
    case Combobox1.ItemIndex of
      1: lpt:=888;
      2: lpt:=632;
    end;

    Okdmx31Read(lpt, Combobox2.ItemIndex, @InDmx);

    for i:=0 to 511 do
    begin
      if InDmx[i]<>Channelvalue[i] then
      begin
        issending:=true;
        RefreshDLLValues(i+1, InDmx[i], InDmx[i], 0);
      end;
    end;
  end;
end;

procedure TConfig.ConfigOKClick(Sender: TObject);
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
	        LReg.WriteInteger('LPT Port',Combobox1.ItemIndex);
	        LReg.WriteInteger('Universe',Combobox2.ItemIndex);
	        LReg.WriteInteger('Outputinterval',strtoint(edit1.Text));
	        LReg.WriteBool('Enable DMX-In',Checkbox1.Checked);
	        LReg.WriteInteger('Inputinterval',strtoint(edit2.Text));
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
          if not LReg.ValueExists('LPT Port') then
	          LReg.WriteInteger('LPT Port',0);
          Combobox1.ItemIndex:=LReg.ReadInteger('LPT Port');

          if not LReg.ValueExists('Universe') then
	          LReg.WriteInteger('Universe',0);
          Combobox2.ItemIndex:=LReg.ReadInteger('Universe');

          if not LReg.ValueExists('Outputinterval') then
	          LReg.WriteInteger('Outputinterval',50);
          Edit1.Text:=inttostr(LReg.ReadInteger('Outputinterval'));

          if not LReg.ValueExists('Enable DMX-In') then
	          LReg.WriteBool('Enable DMX-In',false);
          Checkbox1.Checked:=LReg.ReadBool('Enable DMX-In');

          if not LReg.ValueExists('Inputinterval') then
  	        LReg.WriteInteger('Inputinterval',50);
          Edit2.Text:=inttostr(LReg.ReadInteger('Inputinterval'));
        end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TConfig.Edit1Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=Edit1.text;
  i:=Edit1.selstart;
  input_number(i,s);
  Edit1.text:=s;
  Edit1.selstart:=i;
  Timer1.Interval:=strtoint(Edit1.Text);
end;

procedure TConfig.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=Edit2.text;
  i:=Edit2.selstart;
  input_number(i,s);
  Edit2.text:=s;
  Edit2.selstart:=i;
  Timer2.Interval:=strtoint(Edit2.Text);
end;

procedure TConfig.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin
          delete(s,i,1);
          dec(pos);
        end
      else
        inc(i);
    end;
end;

end.
