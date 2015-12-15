unit settingfrm;

interface
{$INCLUDE DelphiXcfg.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, ColorGrd, JvFullColorSpaces,
  ComCtrls, Registry, DXPlay, messagesystem, Mask, JvExMask, JvSpin,
  pngimage, gnugettext;
  
type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;

  TSettings = class(TForm)
    Label1: TLabel;
    DXPlay1: TDXPlay;
    JvSpinEdit1: TJvSpinEdit;
    Image1: TImage;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DXPlay1SessionLost(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DXPlay1DeletePlayer(Sender: TObject; Player: TDXPlayPlayer);
    procedure DXPlay1AddPlayer(Sender: TObject; Player: TDXPlayPlayer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    startaddress:integer;
    shutdown:boolean;
    procedure CheckConnection;
  end;

var
  Settings: TSettings;

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

procedure TSettings.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  JvSpinEdit1.Value:=startaddress;

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
          LReg.WriteBool('Showing Plugin',true);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TSettings.FormHide(Sender: TObject);
var
	LReg:TRegistry;
begin
  if not shutdown then
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
	          LReg.WriteBool('Showing Plugin',false);
            LReg.WriteInteger('Startaddress',startaddress);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure TSettings.JvSpinEdit1Change(Sender: TObject);
var
	LReg:TRegistry;
begin
  startaddress:=JvSpinEdit1.AsInteger;

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
          LReg.WriteInteger('Startaddress',startaddress);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TSettings.FormCreate(Sender: TObject);
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
          if not LReg.ValueExists('Startaddress') then
            LReg.WriteInteger('Startaddress',1);
          startaddress:=LReg.ReadInteger('Startaddress');
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TSettings.Button2Click(Sender: TObject);
begin
  settings.close;
end;

procedure TSettings.Button3Click(Sender: TObject);
begin
  if DXPlay1.Opened then
    DXPlay1.Close;

  CheckConnection;
end;

procedure TSettings.Button4Click(Sender: TObject);
begin
  if DXPlay1.Opened then
    DXPlay1.Close;

  DXPlay1.Async := false;
  DXPlay1.ModemSetting.Enabled := false;
  DXPlay1.TCPIPSetting.Enabled := false;
  DXPlay1.ProviderName := DXPlay1.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}'));
  DXPlay1.TCPIPSetting.HostName := '127.0.0.1';
  DXPlay1.TCPIPSetting.Port := 6500;
  DXPlay1.TCPIPSetting.Enabled := true;
  DXPlay1.Open2(false, 'DSS200-SoftScanner', 'PC_DIMMER2010');

  CheckConnection;
end;

procedure TSettings.DXPlay1SessionLost(Sender: TObject);
begin
  DXPlay1.Close;

  CheckConnection;
end;

procedure TSettings.Button1Click(Sender: TObject);
begin
  if DXPlay1.Opened then
    DXPlay1.Close;
    
  DXPlay1.Open;

  CheckConnection;
end;

procedure TSettings.CheckConnection;
begin
  if DXPlay1.Opened then
  begin
    label5.caption:=_('Verbindung hergestellt');
    label5.Font.Color:=clGreen;
  end else
  begin
    label5.caption:=_('Nicht verbunden...');
    label5.Font.Color:=clRed;
  end;
end;

procedure TSettings.DXPlay1DeletePlayer(Sender: TObject;
  Player: TDXPlayPlayer);
begin
  CheckConnection;
end;

procedure TSettings.DXPlay1AddPlayer(Sender: TObject;
  Player: TDXPlayPlayer);
begin
  CheckConnection;
end;

end.
