unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, JCLSYSINFO,
  messagesystem;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Image1: TImage;
    Button1: TButton;
    GroupBox2: TGroupBox;
    AcceptBeatImpulse: TCheckBox;
    SendChannelnames: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DeletePC_DIMMERHandle();
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure WMCopyData(var Message: TWMCopyData); message WM_CopyData;
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallback;
    issending:boolean;
    DMXCONTROL_HWND:HWND;
    address,startvalue,endvalue,fadetime:integer;
    SendMSG:TCallbackSendMessage;
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

procedure TConfig.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
begin
  label5.caption:=inttostr(config.Handle);

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
        LReg.WriteInteger('PC_DIMMER Handle',config.Handle);
        if LReg.ValueExists('DMXControl Handle') then
        begin
          DMXCONTROL_HWND:=LReg.ReadInteger('DMXControl Handle');
          if DMXCONTROL_HWND > 0 then
          begin
            Timer1.Enabled:=false;
            label7.Caption:=inttostr(DMXCONTROL_HWND);
          end else
          begin
            Timer1.Enabled:=true;
            label7.Caption:='Nicht gefunden. Suche läuft...';
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TConfig.Button1Click(Sender: TObject);
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
        if LReg.ValueExists('DMXControl Handle') then
        begin
          DMXCONTROL_HWND:=LReg.ReadInteger('DMXControl Handle');
          if DMXCONTROL_HWND > 0 then
          begin
            Timer1.Enabled:=false;
            label7.Caption:=inttostr(DMXCONTROL_HWND);
          end else
          begin
            Timer1.Enabled:=true;
            label7.Caption:='Nicht gefunden. Suche läuft...';
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TConfig.WMCopyData(var Message: TWMCopyData);
var
	sText : array[0..99] of Char;
  daten:array[0..3] of integer;
begin
  if Message.Msg=74 then
  begin
    case Message.CopyDataStruct.dwData of
    1:
    begin
    	StrLCopy(sText, Message.CopyDataStruct.lpData, Message.CopyDataStruct.cbData);
      move(Message.CopyDataStruct.lpData^,daten,Message.CopyDataStruct.cbData);
      issending:=true;
      RefreshDLLValues(daten[0],daten[1],daten[2],daten[3]);
    end;
    2:
    begin
    	StrLCopy(sText, Message.CopyDataStruct.lpData, Message.CopyDataStruct.cbData);
      SendMSG(MSG_FLASHMASTER,strtoint(sText),0);
    end;
    3:
    begin
    	StrLCopy(sText, Message.CopyDataStruct.lpData, Message.CopyDataStruct.cbData);
      if AcceptBeatImpulse.Checked then
      begin
        if sText='1' then
          SendMSG(MSG_BEATIMPULSE,True,0)
        else
          SendMSG(MSG_BEATIMPULSE,False,0);
      end;
    end;
  end;
  end;
end;

procedure TConfig.DeletePC_DIMMERHandle();
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
        LReg.WriteInteger('PC_DIMMER Handle',0);
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure TConfig.Timer1Timer(Sender: TObject);
begin
  Button1Click(nil);
end;

end.
