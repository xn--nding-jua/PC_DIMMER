unit mainfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, winsock, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdGlobal, Mask, JvExMask, JvSpin, JvExControls, JvComCtrls,
  ExtCtrls, XPMan, SVATimer, CHHighResTimer, Registry;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tmainform = class(TForm)
    udp: TIdUDPClient;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ipaddressedit: TJvIPAddress;
    udpport1edit: TJvSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    Label4: TLabel;
    Timer1: TTimer;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    AllLightsOffBtn: TButton;
    LightsOnBtn: TButton;
    LightsOffBtn: TButton;
    Label6: TLabel;
    hiaddressedit: TJvSpinEdit;
    lowaddressedit: TJvSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    RequestStatusinfosBtn: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox5: TGroupBox;
    Label5: TLabel;
    ReadKeysBtn: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    udpport2edit: TJvSpinEdit;
    Label15: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    GroupBox6: TGroupBox;
    SetDMX512StartvaluesBtn: TButton;
    JvSpinEdit1: TJvSpinEdit;
    JvSpinEdit2: TJvSpinEdit;
    JvSpinEdit3: TJvSpinEdit;
    JvSpinEdit4: TJvSpinEdit;
    JvSpinEdit5: TJvSpinEdit;
    JvSpinEdit6: TJvSpinEdit;
    JvSpinEdit7: TJvSpinEdit;
    JvSpinEdit8: TJvSpinEdit;
    JvSpinEdit9: TJvSpinEdit;
    JvSpinEdit10: TJvSpinEdit;
    JvSpinEdit11: TJvSpinEdit;
    JvSpinEdit12: TJvSpinEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    XPManifest1: TXPManifest;
    GroupBox8: TGroupBox;
    Label44: TLabel;
    LastDMX512ChannelEdit: TJvSpinEdit;
    Label45: TLabel;
    TxIntervalEdit: TJvSpinEdit;
    Label46: TLabel;
    SendDMXCheckbox: TCheckBox;
    SendQBusCheckbox: TCheckBox;
    Label47: TLabel;
    LastQBusChannelEdit: TJvSpinEdit;
    ReadTastenCheckbox: TCheckBox;
    SendTimer: TCHHighResTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure AllLightsOffBtnClick(Sender: TObject);
    procedure LightsOnBtnClick(Sender: TObject);
    procedure LightsOffBtnClick(Sender: TObject);
    procedure RequestStatusinfosBtnClick(Sender: TObject);
    procedure ReadKeysBtnClick(Sender: TObject);
    procedure SetDMX512StartvaluesBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure TxIntervalEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    procedure SendCommand(s:string; Port: Word);
    procedure ProcessAnswer(s: string);
    function BitSet(AValue: Byte; ABitCnt: Byte): Boolean;
  public
    { Public-Deklarationen }
    DMXValues:array[1..127] of byte;
    QBusValues:array[1..80] of byte;
    TastenValues:array[1..8] of boolean;
    NewDMXValuesForSending:boolean;
    NewQBusValuesForSending:boolean;

    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;

    procedure SaveAllSettings;
    procedure RestoreAllSettings;

    procedure SendDMXValues;
    procedure SendQBusValues;
    procedure ReadTaster;
  end;

var
  mainform: Tmainform;

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

procedure Tmainform.SendCommand(s:string; Port:Word);
begin
  if Port=1 then
  begin
    if Radiobutton1.Checked then
    begin
      udp.BroadcastEnabled:=false;
      udp.Send(ipaddressedit.text, round(udpport1edit.value), s);
    end else if Radiobutton2.Checked then
    begin
      udp.BroadcastEnabled:=true;
      udp.Broadcast(s, round(udpport1edit.value));
    end;
  end else
  begin
    if Radiobutton1.Checked then
    begin
      udp.BroadcastEnabled:=false;
      udp.Send(ipaddressedit.text, round(udpport2edit.value), s);
    end else if Radiobutton2.Checked then
    begin
      udp.BroadcastEnabled:=true;
      udp.Broadcast(s, round(udpport2edit.value));
    end;
  end;

  ProcessAnswer(udp.ReceiveString(100));
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
begin
  timer1.Enabled:=false;
  Shape1.Brush.Color:=clBlack;
  label4.caption:='...';
end;

procedure Tmainform.ProcessAnswer(s: string);
begin
  if (length(s)=2) and (s[1]=char(33)) then
  begin
    if mainform.Showing then
    begin
      Shape1.Brush.Color:=clLime;
      label4.caption:='ACK';
      Timer1.Enabled:=true;
    end;
    SendTimer.Interval:=round(TxIntervalEdit.Value); // alles OK -> DMX-Sendeintervall wieder zurücksetzen
  end;
  if (length(s)>2) and (s[1]=char(33)) then
  begin
    if mainform.Showing then
    begin
      Shape1.Brush.Color:=clLime;
      label4.caption:='ACK+Data ('+inttostr(length(s)-2)+' Bytes)';
      Timer1.Enabled:=true;

      if (length(s)=12) and (s[2]=char(15)) then
      begin
        // Statusinformationen empfangen
        label9.caption:='Typ: '+inttostr(byte(s[3]));
        label10.caption:='Version: '+inttostr(byte(s[4]))+'.'+inttostr(byte(s[5]));
        label11.caption:='Tasten: '+inttostr(byte(s[6]));

        label17.caption:='Kanal 1: '+inttostr(byte(s[7]));
        label18.caption:='Kanal 2: '+inttostr(byte(s[8]));
        label19.caption:='Kanal 3: '+inttostr(byte(s[9]));
        label20.caption:='Kanal 4: '+inttostr(byte(s[10]));
        label21.caption:='Kanal 5: '+inttostr(byte(s[11]));
        label22.caption:='Kanal 6: '+inttostr(byte(s[12]));
        label23.caption:='Kanal 7: '+inttostr(byte(s[13]));
        label24.caption:='Kanal 8: '+inttostr(byte(s[14]));
        label25.caption:='Kanal 9: '+inttostr(byte(s[15]));
        label26.caption:='Kanal 10: '+inttostr(byte(s[16]));
        label27.caption:='Kanal 11: '+inttostr(byte(s[17]));
        label28.caption:='Kanal 12: '+inttostr(byte(s[18]));
      end;
    end;

    if (length(s)=3) and (s[2]=char(63)) then
    begin
      // Tasteninformationen empfangen
      if mainform.Showing then
      begin
        label5.caption:='Tasteninput: '+inttostr(byte(s[3]));

        Checkbox1.checked:=BitSet(byte(s[3]), 1);
        Checkbox2.checked:=BitSet(byte(s[3]), 2);
        Checkbox3.checked:=BitSet(byte(s[3]), 4);
        Checkbox4.checked:=BitSet(byte(s[3]), 8);
        Checkbox5.checked:=BitSet(byte(s[3]), 16);
        Checkbox6.checked:=BitSet(byte(s[3]), 32);
        Checkbox7.checked:=BitSet(byte(s[3]), 64);
        Checkbox8.checked:=BitSet(byte(s[3]), 128);
      end;

      if BitSet(byte(s[3]), 1)<>TastenValues[1] then begin if BitSet(byte(s[3]), 1) then SetDLLValueEvent(1, 255) else SetDLLValueEvent(1, 0); end;
      if BitSet(byte(s[3]), 2)<>TastenValues[2] then begin if BitSet(byte(s[3]), 2) then SetDLLValueEvent(2, 255) else SetDLLValueEvent(2, 0); end;
      if BitSet(byte(s[3]), 4)<>TastenValues[3] then begin if BitSet(byte(s[3]), 4) then SetDLLValueEvent(3, 255) else SetDLLValueEvent(3, 0); end;
      if BitSet(byte(s[3]), 8)<>TastenValues[4] then begin if BitSet(byte(s[3]), 8) then SetDLLValueEvent(4, 255) else SetDLLValueEvent(4, 0); end;
      if BitSet(byte(s[3]), 16)<>TastenValues[5] then begin if BitSet(byte(s[3]), 16) then SetDLLValueEvent(5, 255) else SetDLLValueEvent(5, 0); end;
      if BitSet(byte(s[3]), 32)<>TastenValues[6] then begin if BitSet(byte(s[3]), 32) then SetDLLValueEvent(6, 255) else SetDLLValueEvent(6, 0); end;
      if BitSet(byte(s[3]), 64)<>TastenValues[7] then begin if BitSet(byte(s[3]), 64) then SetDLLValueEvent(7, 255) else SetDLLValueEvent(7, 0); end;
      if BitSet(byte(s[3]), 128)<>TastenValues[8] then begin if BitSet(byte(s[3]), 128) then SetDLLValueEvent(8, 255) else SetDLLValueEvent(8, 0); end;

      TastenValues[1]:=BitSet(byte(s[3]), 1);
      TastenValues[2]:=BitSet(byte(s[3]), 2);
      TastenValues[3]:=BitSet(byte(s[3]), 4);
      TastenValues[4]:=BitSet(byte(s[3]), 8);
      TastenValues[5]:=BitSet(byte(s[3]), 16);
      TastenValues[6]:=BitSet(byte(s[3]), 32);
      TastenValues[7]:=BitSet(byte(s[3]), 64);
      TastenValues[8]:=BitSet(byte(s[3]), 128);
    end;

    if mainform.Showing then
    begin
      if (length(s)=18) and (s[2]=char(245)) then
      begin
        // IP und MAC empfangen
        label12.caption:='IP: '+inttostr(byte(s[3]))+'.'+inttostr(byte(s[4]))+'.'+inttostr(byte(s[5]))+'.'+inttostr(byte(s[6]));
        label13.caption:='Netmask: '+inttostr(byte(s[7]))+'.'+inttostr(byte(s[8]))+'.'+inttostr(byte(s[9]))+'.'+inttostr(byte(s[10]));
        label14.caption:='MAC: '+inttohex(byte(s[11]), 2)+' '+inttohex(byte(s[12]), 2)+' '+inttohex(byte(s[13]), 2)+' '+inttohex(byte(s[14]), 2)+' '+inttohex(byte(s[15]), 2)+' '+inttohex(byte(s[16]), 2);
      end;
    end;
  end;
  if (length(s)=2) and (s[1]=char(63)) and (s[2]=char(0)) then
  begin
    if mainform.Showing then
    begin
      Shape1.Brush.Color:=clRed;
      label4.caption:='NACK';
      Timer1.Enabled:=true;
    end;
    SendTimer.Interval:=1000; // DMX-Sender im Fehlerfall auf 1s stellen, damit Programm nicht blockiert
  end;
  if (length(s)=2) and (s[1]=char(35)) then
  begin
    if mainform.Showing then
    begin
      Shape1.Brush.Color:=clYellow;
      label4.caption:='ACK+Tasten';
      Timer1.Enabled:=true;

      label5.caption:='Tasteninput: '+inttostr(byte(s[2]));

      Checkbox1.checked:=BitSet(byte(s[2]), 1);
      Checkbox2.checked:=BitSet(byte(s[2]), 2);
      Checkbox3.checked:=BitSet(byte(s[2]), 4);
      Checkbox4.checked:=BitSet(byte(s[2]), 8);
      Checkbox5.checked:=BitSet(byte(s[2]), 16);
      Checkbox6.checked:=BitSet(byte(s[2]), 32);
      Checkbox7.checked:=BitSet(byte(s[2]), 64);
      Checkbox8.checked:=BitSet(byte(s[2]), 128);
    end;

    if BitSet(byte(s[2]), 1)<>TastenValues[1] then begin if BitSet(byte(s[2]), 1) then SetDLLValueEvent(1, 255) else SetDLLValueEvent(1, 0); end;
    if BitSet(byte(s[2]), 2)<>TastenValues[2] then begin if BitSet(byte(s[2]), 2) then SetDLLValueEvent(2, 255) else SetDLLValueEvent(2, 0); end;
    if BitSet(byte(s[2]), 4)<>TastenValues[3] then begin if BitSet(byte(s[2]), 4) then SetDLLValueEvent(3, 255) else SetDLLValueEvent(3, 0); end;
    if BitSet(byte(s[2]), 8)<>TastenValues[4] then begin if BitSet(byte(s[2]), 8) then SetDLLValueEvent(4, 255) else SetDLLValueEvent(4, 0); end;
    if BitSet(byte(s[2]), 16)<>TastenValues[5] then begin if BitSet(byte(s[2]), 16) then SetDLLValueEvent(5, 255) else SetDLLValueEvent(5, 0); end;
    if BitSet(byte(s[2]), 32)<>TastenValues[6] then begin if BitSet(byte(s[2]), 32) then SetDLLValueEvent(6, 255) else SetDLLValueEvent(6, 0); end;
    if BitSet(byte(s[2]), 64)<>TastenValues[7] then begin if BitSet(byte(s[2]), 64) then SetDLLValueEvent(7, 255) else SetDLLValueEvent(7, 0); end;
    if BitSet(byte(s[2]), 128)<>TastenValues[8] then begin if BitSet(byte(s[2]), 128) then SetDLLValueEvent(8, 255) else SetDLLValueEvent(8, 0); end;

    TastenValues[1]:=BitSet(byte(s[2]), 1);
    TastenValues[2]:=BitSet(byte(s[2]), 2);
    TastenValues[3]:=BitSet(byte(s[2]), 4);
    TastenValues[4]:=BitSet(byte(s[2]), 8);
    TastenValues[5]:=BitSet(byte(s[2]), 16);
    TastenValues[6]:=BitSet(byte(s[2]), 32);
    TastenValues[7]:=BitSet(byte(s[2]), 64);
    TastenValues[8]:=BitSet(byte(s[2]), 128);
  end;

  if mainform.Showing then
    memo1.Text:=s;
end;

procedure Tmainform.AllLightsOffBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 1);
  s[1]:=char(0);

  SendCommand(s, 2);
end;

procedure Tmainform.LightsOnBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 3);
  s[1]:=char(2);
  s[2]:=char(round(hiaddressedit.value));
  s[3]:=char(round(lowaddressedit.value));

  SendCommand(s, 2);
end;

procedure Tmainform.LightsOffBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 3);
  s[1]:=char(3);
  s[2]:=char(round(hiaddressedit.value));
  s[3]:=char(round(lowaddressedit.value));

  SendCommand(s, 2);
end;

procedure Tmainform.RequestStatusinfosBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 1);
  s[1]:=char(15);
  SendCommand(s, 2);

  setlength(s, 1);
  s[1]:=char(245);
  SendCommand(s, 1);
end;

procedure Tmainform.ReadKeysBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 1);
  s[1]:=char(63);

  SendCommand(s, 2);
end;

function Tmainform.BitSet(AValue: Byte; ABitCnt: Byte): Boolean;
begin
  result := ((AValue AND ABitCnt) = ABitCnt);
end;

procedure Tmainform.SetDMX512StartvaluesBtnClick(Sender: TObject);
var
  s:string;
begin
  setlength(s, 13);
  s[1]:=char(34);
  s[2]:=char(round(JvSpinEdit1.Value));
  s[3]:=char(round(JvSpinEdit2.Value));
  s[4]:=char(round(JvSpinEdit3.Value));
  s[5]:=char(round(JvSpinEdit4.Value));
  s[6]:=char(round(JvSpinEdit5.Value));
  s[7]:=char(round(JvSpinEdit6.Value));
  s[8]:=char(round(JvSpinEdit7.Value));
  s[9]:=char(round(JvSpinEdit8.Value));
  s[10]:=char(round(JvSpinEdit9.Value));
  s[11]:=char(round(JvSpinEdit10.Value));
  s[12]:=char(round(JvSpinEdit11.Value));
  s[13]:=char(round(JvSpinEdit12.Value));

  SendCommand(s, 2);
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  issending:=false;
end;

procedure Tmainform.SendTimerTimer(Sender: TObject);
begin
  if NewDMXValuesForSending then
  begin
    NewDMXValuesForSending:=false;
    SendDMXValues;
  end;

  if NewQBusValuesForSending then
  begin
    NewQBusValuesForSending:=false;
    SendQBusValues;
  end;

  ReadTaster;
end;

procedure Tmainform.TxIntervalEditChange(Sender: TObject);
begin
  SendTimer.Interval:=round(TxIntervalEdit.Value);
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  RequestStatusinfosBtnClick(nil);
  ReadKeysBtnClick(nil);
end;

procedure Tmainform.SendDMXValues;
var
  s:string;
  i:integer;
begin
  if SendDMXCheckbox.checked then
  begin
    setlength(s, round(LastDMX512ChannelEdit.Value)+2);
    s[1]:=char(33);
    s[2]:=char(round(LastDMX512ChannelEdit.value));

    for i:=1 to round(LastDMX512ChannelEdit.value) do
      s[i+2]:=char(DMXValues[i]);

    SendCommand(s, 2);
  end;
end;

procedure Tmainform.SendQBusValues;
var
  s:string;
  i:integer;
begin
  if SendQBusCheckbox.Checked then
  begin
    setlength(s, round(LastQBusChannelEdit.Value)+2);

    s[1]:=char(17);
    s[2]:=char(round(LastQBusChannelEdit.value));
    for i:=1 to round(LastQBusChannelEdit.value) do
    begin
      s[i+2]:=char(QBusValues[i]);
    end;
    SendCommand(s, 2);
  end;
end;

procedure Tmainform.ReadTaster;
var
  s:string;
begin
  if ReadTastenCheckbox.checked then
  begin
    setlength(s, 1);
    s[1]:=char(63);
    SendCommand(s, 2);
  end;
end;

procedure Tmainform.SaveAllSettings;
var
  LReg: TRegistry;
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
          LReg.WriteString('IPAddress', ipaddressedit.Text);
          LReg.WriteInteger('UDPPort1', round(udpport1edit.Value));
          LReg.WriteInteger('UDPPort2', round(udpport2edit.Value));
          LReg.WriteBool('Broadcast', Radiobutton2.Checked);

          LReg.WriteInteger('LastDMX512Channel', round(lastdmx512channeledit.value));
          LReg.WriteInteger('LastQBusChannel', round(lastqbuschanneledit.value));
          LReg.WriteInteger('Interval', round(txintervaledit.value));
          LReg.WriteBool('SendDMX512', SendDMXCheckbox.Checked);
          LReg.WriteBool('SendQBus', SendQBusCheckbox.Checked);
          LReg.WriteBool('ReadTaster', ReadTastenCheckbox.Checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.RestoreAllSettings;
var
  LReg: TRegistry;
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
          if LReg.ValueExists('IPAddress') then
            ipaddressedit.Text:=LReg.ReadString('IPAddress');
          if LReg.ValueExists('UDPPort1') then
            udpport1edit.Value:=LReg.ReadInteger('UDPPort1');
          if LReg.ValueExists('UDPPort2') then
            udpport2edit.Value:=LReg.ReadInteger('UDPPort2');
          if LReg.ValueExists('Broadcast') then
            Radiobutton2.Checked:=LReg.ReadBool('Broadcast');

          if LReg.ValueExists('LastDMX512Channel') then
            lastdmx512channeledit.value:=LReg.ReadInteger('LastDMX512Channel');
          if LReg.ValueExists('LastQBusChannel') then
            lastqbuschanneledit.value:=LReg.ReadInteger('LastQBusChannel');
          if LReg.ValueExists('Interval') then
            txintervaledit.value:=LReg.ReadInteger('Interval');
          if LReg.ValueExists('SendDMX512') then
            SendDMXCheckbox.Checked:=LReg.ReadBool('SendDMX512');
          if LReg.ValueExists('SendQBus') then
            SendQBusCheckbox.Checked:=LReg.ReadBool('SendQBus');
          if LReg.ValueExists('ReadTaster') then
            ReadTastenCheckbox.Checked:=LReg.ReadBool('ReadTaster');
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveAllSettings;
end;

end.
