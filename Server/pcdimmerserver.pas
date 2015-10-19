unit pcdimmerserver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, antTaskbarIcon, Menus, ImgList, Sockets, ScktComp,
  ExtCtrls, XPMan, PowerButton, Registry, WinSock, ComCtrls, DXPlay,
  CHHighResTimer, messagesystem, pngimage, gnugettext, TB2Item, TB2Dock,
  TB2Toolbar, PngImageList, PowerButton1;

const
  builtdate = 'Version 5.0.1 build on 23.09.2010';
  chan = 8192;

type
// Thread für Animation deklarieren
  TAnimationEvent = procedure () of object;
  TAnimationThread = class(TThread)
  private
    DimmerKernelTimer: TCHHighResTimer;
  protected
    procedure Execute; override;
  public
    constructor create;
    procedure TimerEvent(Sender: TObject);
  end;

  TDLLSenddata = procedure(address, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
  TDLLSendMessage = procedure(MSG:Byte; Data1, Data2:Variant);stdcall;
  TDLLIsSending = function:boolean;stdcall;

  TReceive = record
    address,startvalue,endvalue,fadetime:integer;
  end;

  TPCDimmer_Server = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    portselect: TEdit;
    systray: TantTaskbarIcon;
    PopupMenu1: TPopupMenu;
    Beenden1: TMenuItem;
    Einstellungen1: TMenuItem;
    Button2: TButton;
    XPManifest1: TXPManifest;
    powerbtncheck: TCheckBox;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Label6: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Edit3: TEdit;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    PowerButton1: TPowerButton;
    CheckBox2: TCheckBox;
    Label20: TLabel;
    ipadresselabel: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    pluginlist: TComboBox;
    Button5: TButton;
    Button6: TButton;
    fadezeit_label: TLabel;
    Button4: TButton;
    DXPlay1: TDXPlay;
    Label1: TLabel;
    Timer1: TTimer;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    TBSubmenuItem1: TTBSubmenuItem;
    TBItem1: TTBItem;
    PngImageList1: TPngImageList;
    TBSubmenuItem3: TTBSubmenuItem;
    TBSubmenuItem2: TTBSubmenuItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    ImageList1: TImageList;
    TBItem4: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSubmenuItem4: TTBSubmenuItem;
    TBItem5: TTBItem;
    TBItem6: TTBItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure systrayClick(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure powerbtncheckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure infobtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure pluginlistChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DXPlay1Message(Sender: TObject; From: TDXPlayPlayer;
      Data: Pointer; DataSize: Integer);
    procedure DXPlay1AddPlayer(Sender: TObject; Player: TDXPlayPlayer);
    procedure DXPlay1DeletePlayer(Sender: TObject; Player: TDXPlayPlayer);
    procedure Timer1Timer(Sender: TObject);
    procedure TBItem2Click(Sender: TObject);
    procedure TBItem3Click(Sender: TObject);
    procedure TBItem6Click(Sender: TObject);
  private
    { Private-Deklarationen }
    _closing:boolean;
    port:string;
    lockpowerbtn:boolean;
    startup:boolean;
    lastusedoutputplugin:string;
    lastusedoutputpluginnumber:integer;
//    receive : TReceive;
    workingdirectory:string;
    firststart:boolean;
    procedure Senddata(address, startvalue, endvalue, fadetime:integer;name:PChar);
    function IPAdress:string;
  public
    { Public-Deklarationen }
    // Globale Animationstimerdeklaration
    channelvalue:array[1..chan] of integer;
    channelvalue_temp:array[1..chan] of integer;

    channel_startvalue:array[1..chan] of Byte;
    channel_endvalue:array[1..chan] of integer;
    channel_fadetime:array[1..chan] of integer;
    channel_dimmactive:array[1..chan] of boolean;
    channel_steps:array[1..chan] of byte;
    channel_increase:array[1..chan] of integer;
    channel_value:array[1..chan] of byte;
    lastchan:integer;
  end;

	procedure CallbackGetDLLValues(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  procedure CallbackGetDLLValueEvent(address,endvalue:integer);stdcall;
	procedure CallbackGetDLLNames(address:integer; channelname:PChar);stdcall;
	procedure CallbackPluginFirstStart(address:integer);stdcall;
	procedure CallbackMessage(MSG:Byte; Data1, Data2: Variant);stdcall;

var
  PCDimmer_Server: TPCDimmer_Server;
// Output-Plugin deklarationen
  OutputDLL: THandle;
  DLLSenddata:TDLLSenddata;
  DLLSendMessage:TDLLSendMessage;
  pc_dimmer_plugins : array[0..63] of string[255];
  ProcCall: procedure;
  ProcCall2: procedure(Callback0,Callback1,Callback2,Callback3,Callback4:Pointer);stdcall;

implementation

uses aboutfrm, startupfrm;

{$R *.dfm}

procedure TPCDimmer_Server.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
  i:integer;
  SR: TSearchRec;
  FuncCall: function : PChar;
begin
  TranslateComponent(Self);
  lastchan:=8192;

  _closing:=false;
  workingdirectory:=ExtractFilePath(paramstr(0));

//  Application.CreateForm(Tstartupform, startupform);
  startupform:=Tstartupform.Create(startupform);
  startupform.Show;
  startupform.Label2.caption:=builtdate;
  startupform.refresh;

  for i := 1 to ParamCount do begin
    if (ParamStr(i)='-minimized') or (ParamStr(i)='/minimized') then
    begin
      Application.ShowMainForm:=False;
    end;
    if (ParamStr(i)='/?') or (ParamStr(i)='-?') then
    begin
      ShowMessage(_('Mit der Option "-minimized" wird der Server minimiert gestartet.'));
    end;
  end;

  startupform.Label3.caption:=_('Lese Registryeinträge...');
  startupform.refresh;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER Server') then
        LReg.CreateKey('PC_DIMMER Server');
      if LReg.OpenKey('PC_DIMMER Server',true) then
      begin
        if not LReg.ValueExists('Port-Address') then
          LReg.WriteString('Port-Address','6500');
        port:=LReg.ReadString('Port-Address');

        if not LReg.ValueExists('Deactivate powerbutton') then
          LReg.WriteBool('Deactivate powerbutton',True);
        lockpowerbtn:=LReg.ReadBool('Deactivate powerbutton');

        if not LReg.ValueExists('Start with Windows') then
          LReg.WriteBool('Start with Windows',False);
        startup:=LReg.ReadBool('Start with Windows');

        if not LReg.ValueExists('Last used Plugin') then
          LReg.WriteString('Last used Plugin','');
        lastusedoutputplugin:=LReg.ReadString('Last used Plugin');
      end;
    end;
  end;
  LReg.CloseKey;

// DLLs suchen und Output-DLLs rausfiltern
  i:=1;
  pc_dimmer_plugins[0]:='0';
  if (FindFirst(workingdirectory+'\plugins\*.dll',faAnyFile-faDirectory,SR)=0) then
  begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
      begin
        OutputDLL:=LoadLibrary(PChar(workingdirectory+'\plugins\'+SR.Name));
        FuncCall := GetProcAddress(OutputDLL,'DLLIdentify');
        if Assigned(FuncCall) then
        begin
          if FuncCall=StrPas('Output') then
          begin
            pc_dimmer_plugins[i]:=SR.Name;
            FuncCall := GetProcAddress(OutputDLL,'DLLGetName');

            startupform.Label3.caption:=StrPas(FuncCall);
            startupform.refresh;

            pluginlist.Items.Add(StrPas(FuncCall));
            inc(i);
          end;
        end;
        FreeLibrary(OutputDLL);
      end;
    until FindNext(SR)<>0;
    FindClose(SR);
    pc_dimmer_plugins[0]:=inttostr(i);
  end;
  OutputDLL:=0;

// Letztes genutztes Plugin rausfinden und aktivieren
  for i:=1 to strtoint(pc_dimmer_plugins[0])-1 do
    if pc_dimmer_plugins[i]=lastusedoutputplugin then
    begin
      lastusedoutputpluginnumber:=i;
      OutputDLL:=LoadLibrary(PChar(workingdirectory+'\plugins\'+pc_dimmer_plugins[i]));
      ProcCall2 := GetProcAddress(OutputDLL,'DLLActivate');
      ProcCall2(@CallbackGetDLLValues,@CallbackGetDLLValueEvent,@CallbackGetDLLNames,@CallbackPluginFirstStart,@CallbackMessage);
      //FuncCall := GetProcAddress(OutputDLL,'DLLGetName');
      //pluginlist.Text:=StrPas(FuncCall);

      startupform.Label3.caption:=_('Aktiviere: ')+pluginlist.Items[i-1];
      startupform.refresh;

      pluginlist.ItemIndex:=i-1;
      @DLLSenddata := GetProcAddress(OutputDLL,'DLLSendData');
      @DLLSendmessage := GetProcAddress(OutputDLL,'DLLSendMessage');
    end;


  portselect.Text:=port;
  firststart:=true;

  ipadresselabel.Caption:=ipadress;
  powerbtncheck.Checked:=lockpowerbtn;
  powerbutton1.PowerOffEnable:=not lockpowerbtn;
  checkbox2.Checked:=startup;
end;

procedure TPCDimmer_Server.Button1Click(Sender: TObject);
begin
  pcdimmer_server.Hide;
end;

procedure TPCDimmer_Server.systrayClick(Sender: TObject);
begin
  pcdimmer_server.Show;
  pcdimmer_server.WindowState:=wsNormal;
end;

procedure TPCDimmer_Server.Einstellungen1Click(Sender: TObject);
begin
  pcdimmer_server.Show;
end;

procedure TPCDimmer_Server.Button2Click(Sender: TObject);
begin
if messagedlg(_('Soll der neue Port gesetzt werden (aktive Verbindungen werden getrennt)?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin

    label5.Caption:=_('Server wird beendet...');
    label5.Font.Color:=clBlack;
    PCDimmer_Server.Refresh;

    if dxplay1.Opened then
      DXplay1.Close;

    label5.Caption:=_('Server wird gestartet...');
    label5.Font.Color:=clBlack;
    PCDimmer_Server.Refresh;

  {
    serversocket.Active:=false;
    serversocket.Port:=strtoint(portselect.Text);
    serversocket.Active:=true;
  }
    DXPlay1.TCPIPSetting.Enabled:=false;
    DXPlay1.Async:=false;
    DXPlay1.TCPIPSetting.Port:=strtoint(portselect.text);
    DXPlay1.TCPIPSetting.Enabled:=true;
    dxplay1.ProviderName := dxplay1.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}')); // TCP/IP als Provider
  //  DXPlay1.ProviderName := DXPlay1.Providers[3]; // TCP/IP als Provider
    DXPlay1.Open2(true, 'PC_DIMMER Server', 'Server');

    ipadresselabel.Caption:=ipadress;

    if DXplay1.Opened then
    begin
      Label5.Caption:=_('Warte auf Clients...');
      Label1.Caption:='';
      systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
      Label5.Font.Color:=$000080FF;
      Label10.Caption:='';
    end else
    begin
      Label5.Caption:=_('Server nicht gestartet...');
      Label1.Caption:='';
      Label5.Font.Color:=clRed;
    end;

    port:=portselect.text;
  end;
end;

procedure TPCDimmer_Server.Senddata(address, startvalue, endvalue, fadetime:integer;name:PChar);
begin
    // Animation für aktuellen Kanal aktualisieren
    channel_steps[address] := Abs(startvalue - endvalue);

    if (fadetime>0) then
    begin
      // Fadetime>0
      if (channel_steps[address]>0) then
      begin
        channel_startvalue[address] := startvalue;
        channel_value[address] := startvalue;
        channel_endvalue[address] := endvalue;
        channel_fadetime[address] := fadetime;
        channel_increase[address] := 0;
        channel_dimmactive[address] := True;
        // Animationstimer wurde gestartet und aktuelle Werte werden per SendMSG an Plugins übergeben
      end;
    end else
    begin
      // Fadetime=0
      channel_dimmactive[address] := false;
      channel_value[address] := endvalue;

      // Aktuellen Kanalwert auch per Nachrichtensystem zustellen
      if OutputDLL <> 0 then
        DLLSendMessage(MSG_ACTUALCHANNELVALUE,address,channel_value[address]);
    end;

  if OutputDLL <> 0 then
    DLLSenddata(address,startvalue,endvalue,fadetime,name);
end;

procedure TPCDimmer_Server.powerbtncheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if powerbtncheck.Checked then
    powerbutton1.PowerOffEnable:=false
  else
    powerbutton1.PowerOffEnable:=true;
  lockpowerbtn:=powerbtncheck.Checked;
end;

procedure TPCDimmer_Server.infobtnClick(Sender: TObject);
begin
  aboutform.label17.Caption:=builtdate;
  aboutform.showmodal;
end;

procedure TPCDimmer_Server.FormShow(Sender: TObject);
var Owner : HWnd;
begin
  Owner:=GetWindow(Handle,GW_OWNER);
  ShowWindow(Owner,SW_HIDE);

  if firststart then
  begin
    Timer1.Enabled:=true;
  end;

  ipadresselabel.Caption:=ipadress;
  TAnimationThread.create;
end;

procedure TPCDimmer_Server.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var LReg: TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey := HKEY_CURRENT_USER;

  if LReg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
    if checkbox2.Checked then
    begin
      LReg.WriteString('PC_DIMMER Netzwerk-Server','"'+ParamStr(0)+'" -minimized');
      LReg.CloseKey;
    end else
    begin
      LReg.DeleteValue('PC_DIMMER Netzwerk-Server');
    end;
  LReg.Free;
  startup:=checkbox2.Checked;
end;

procedure TPCDimmer_Server.Button3Click(Sender: TObject);
var LReg: TRegistry;
begin
if messagedlg(_('Möchten Sie die Einstellungen zurücksetzen (mögliche Verbindungen werden getrennt)?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    port:='6500';
    lockpowerbtn:=true;
    startup:=false;
    portselect.Text:=port;
{
    dxplay1.Open2(true,'PC_DIMMER','SERVER');
      DXplay1.Close;
    dxplay1.TCPIPSetting.Port:=strtoint(portselect.Text);
    dxplay1.TCPIPSetting.Enabled:=true;
    dxplay1.Open2(true,'PC_DIMMER','SERVER');
}
    ipadresselabel.Caption:=ipadress;
    powerbtncheck.Checked:=lockpowerbtn;
    powerbutton1.PowerOffEnable:=not lockpowerbtn;
    checkbox2.Checked:=startup;
    LReg := TRegistry.Create;
    LReg.RootKey := HKEY_CURRENT_USER;
    if LReg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
      LReg.DeleteValue('PC_DIMMER Netzwerk-Server');
    LReg.Free;
  end;

end;

function TPCDimmer_Server.IPAdress:string;
const
  sTxtIP  = '%d.%d.%d.%d';
var
    rSockVer   : Word;
    aWSAData   : TWSAData;
    szHostName : array[0..255] of Char;
    pHE        : PHostEnt;
begin
  Result:='';
  // WinSock Version 1.1 initialisieren
  rSockVer:=MakeWord(1, 1);
  WSAStartup(rSockVer, aWSAData );
  try
    FillChar(szHostName, SizeOf(szHostName), #0);
    GetHostName(szHostName, SizeOf(szHostName));
    pHE:=GetHostByName(szHostName);
    if (pHE<>nil) then with pHE^ do
      Result:=Format(sTxtIP,
                [Byte(h_addr^[0]), Byte(h_addr^[1]),
                 Byte(h_addr^[2]), Byte(h_addr^[3])]);
  finally
    WSACleanup;
  end;
end;

procedure TPCDimmer_Server.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  LReg:TRegistry;
begin
  if DXplay1.Opened then
    DXplay1.Close;
  DXPlay1.TCPIPSetting.Enabled:=false;

  _closing:=true;
// Output-Plugin deaktivieren
  ProcCall := GetProcAddress(OutputDLL,'DLLDeactivate');
  if Assigned(ProcCall) then ProcCall;
  FreeLibrary(OutputDLL);

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER Server') then
        LReg.CreateKey('PC_DIMMER Server');
      if LReg.OpenKey('PC_DIMMER Server',true) then
      begin
        LReg.WriteString('Port-Address',port);
        LReg.WriteBool('Deactivate powerbutton',lockpowerbtn);
        LReg.WriteBool('Start with Windows',startup);
        LReg.WriteString('Last IP-Address',ipadress);
        LReg.WriteString('Last used Plugin',lastusedoutputplugin);
        LReg.WriteString('Last used directory',workingdirectory);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  startupform.Hide;
  startupform.Free;
end;

procedure TPCDimmer_Server.Button5Click(Sender: TObject);
begin
  if OutputDLL <> 0 then
  begin
    try
      ProcCall := GetProcAddress(OutputDLL,'DLLConfigure');
      if Assigned(ProcCall) then ProcCall else ShowMessage(_('Fehlerhafte DLL!'));
    except
      ShowMessage(_('Fehlerhafte DLL!'));
    end;
  end
  else
    ShowMessage(_('Kein Plugin geladen...'));
end;

procedure TPCDimmer_Server.Button6Click(Sender: TObject);
begin
  if OutputDLL <> 0 then
  begin
    try
      ProcCall := GetProcAddress(OutputDLL,'DLLAbout');
      if Assigned(ProcCall) then ProcCall else ShowMessage('Fehlerhafte DLL!');
    except
      ShowMessage(_('Fehlerhafte DLL!'));
    end;
  end
  else
    ShowMessage(_('Kein Plugin geladen...'));
end;

procedure TPCDimmer_Server.pluginlistChange(Sender: TObject);
begin
  if OutputDLL<>0 then
  begin
    ProcCall := GetProcAddress(OutputDLL,'DLLDeactivate');
    ProcCall;
  end;
  FreeLibrary(OutputDLL);
  OutputDLL := LoadLibrary(PChar(workingdirectory+'\plugins\'+pc_dimmer_plugins[pluginlist.Itemindex+1]));
  ProcCall2 := GetProcAddress(OutputDLL,'DLLActivate');
  if Assigned(ProcCall2) then ProcCall2(@CallbackGetDLLValues,@CallbackGetDLLValueEvent,@CallbackGetDLLNames,@CallbackPluginFirstStart,@CallbackMessage) else ShowMessage('Fehlerhafte DLL!');

  @DLLSenddata := GetProcAddress(OutputDLL,'DLLSendData');
  @DLLSendmessage := GetProcAddress(OutputDLL,'DLLSendMessage');

  lastusedoutputpluginnumber:=pluginlist.ItemIndex-1;
  lastusedoutputplugin:=pc_dimmer_plugins[pluginlist.itemindex+1];
end;

procedure CallbackGetDLLNames(address:integer; channelname:PChar);stdcall;
begin
	//
end;

procedure CallbackGetDLLValueEvent(address,endvalue:integer);stdcall;
begin
  //
end;

procedure CallbackGetDLLValues(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
begin
  //
end;

procedure CallbackPluginFirstStart(address:integer);stdcall;
begin
	//
end;

procedure CallbackMessage(MSG:Byte; Data1, Data2: Variant);stdcall;
begin
	//
end;
procedure TPCDimmer_Server.Button4Click(Sender: TObject);
begin
  startupform.Show;
  startupform.Label2.caption:=builtdate;
  startupform.Label3.Caption:=_('Beende DirectPlay-Netzwerkserver...');
  startupform.Refresh;
  PCDimmer_Server.hide;
	close;
end;

procedure TPCDimmer_Server.DXPlay1Message(Sender: TObject;
  From: TDXPlayPlayer; Data: Pointer; DataSize: Integer);
type
  TDXChatMessage = record
    address:word;
    startvalue:byte;
    endvalue:byte;
    fadetime:LongWord;
    Len: Word;
    Name: Array[0..0] of Char;
  end;
var
  name:string;
  t,h,min,s,ms:integer;
begin
  SetLength(name,TDXChatMessage(Data^).Len);
  StrLCopy(pChar(name),TDXChatMessage(Data^).Name,TDXChatMessage(Data^).Len);

//  TDXChatMessage(Data^).address;
//  TDXChatMessage(Data^).startvalue;
//  TDXChatMessage(Data^).endvalue;
//  TDXChatMessage(Data^).fadetime;
//  name

  Senddata(TDXChatMessage(Data^).address,TDXChatMessage(Data^).startvalue,TDXChatMessage(Data^).endvalue,TDXChatMessage(Data^).fadetime,PChar(copy(name,1,length(name))));

  Edit1.Text:=inttostr(TDXChatMessage(Data^).address);
	Edit4.Text:=inttostr(round(TDXChatMessage(Data^).startvalue/255*100))+'%';
  Edit3.Text:=inttostr(round(TDXChatMessage(Data^).endvalue/255*100))+'%';
  Edit2.Text:=inttostr(TDXChatMessage(Data^).fadetime)+' ms';
  edit1.Hint:=name;

  t:=TDXChatMessage(Data^).fadetime;
  h:=t div 3600000;
  t:=t mod 3600000;
  min:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;
  fadezeit_label.Caption:=_('Fadezeit: ')+inttostr(h)+'h '+inttostr(min)+'min '+inttostr(s)+'s '+inttostr(ms)+'ms';
end;

procedure TPCDimmer_Server.DXPlay1AddPlayer(Sender: TObject;
  Player: TDXPlayPlayer);
var
  i:integer;
  text:string;
begin
  if not (dxplay1.Players.Count>1) then exit;

  Label5.Caption:=_('Verbunden mit Netzwerk "')+DXPlay1.SessionName+'"';
  Label1.Caption:=DXPlay1.ProviderName;
  systray.hint:=_('PC_DIMMER Netzwerk-Server : Verbunden');
  Label5.Font.Color:=clGreen;
  text:='';
  for i:=1 to dxplay1.Players.Count-1 do
    text:=text+dxplay1.Players.Players[i].Name+'  ';
  Label10.Caption:=text;
end;

procedure TPCDimmer_Server.DXPlay1DeletePlayer(Sender: TObject;
  Player: TDXPlayPlayer);
begin
  if DXplay1.Opened then
  begin
    Label5.Caption:=_('Warte auf Clients...');
    Label1.Caption:='';
    systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
    Label5.Font.Color:=$000080FF;
    Label10.Caption:='';
  end else
  begin
    Label5.Caption:=_('Server nicht gestartet...');
    Label1.Caption:='';
    Label5.Font.Color:=clRed;
  end;
end;

//-------------------------------------------------

constructor TAnimationThread.Create;
begin
  inherited create(false);
  Priority := tpHigher;
  FreeOnTerminate := true;

  DimmerKernelTimer:=TCHHighResTimer.Create(DimmerKernelTimer);
  DimmerKernelTimer.Interval:=1;
  DimmerKernelTimer.OnTimer:=TimerEvent;

  DimmerKernelTimer.Enabled:=true;
end;

procedure TAnimationThread.Execute;
begin
//  inherited;

  while not PCDimmer_Server._closing do
  begin
    sleep(1);
  end;

  DimmerKernelTimer.Enabled:=false;

  Terminate;
end;

procedure TAnimationThread.TimerEvent(Sender: TObject);
var
  i:integer;
begin
  with PCDimmer_Server do
  begin
  for i:=1 to lastchan do
  begin
    if channel_dimmactive[i] then
    begin
      channel_increase[i]:=channel_increase[i]+1;
      if channel_steps[i]>0 then

      if channel_increase[i] >= Round(channel_fadetime[i] / channel_steps[i]) then
      begin
        channel_increase[i]:=0;
        if channel_startvalue[i]<channel_endvalue[i] then
        begin
          // Nach oben Dimmen
          channel_value[i]:=channel_value[i]+1;
        end else
        begin
          // Nach unten Dimmen
          channel_value[i]:=channel_value[i]-1;
        end;

        //SendMSG(MSG_ACTUALCHANNELVALUE,i,channel_value[i]);
        if OutputDLL <> 0 then
          DLLSendmessage(MSG_ACTUALCHANNELVALUE, i, channel_value[i]);
      end;

      if channel_value[i]=channel_endvalue[i] Then
        channel_dimmactive[i]:=false;
    end;
  end;
  end; // end von with mainform
end;

//-------------------------------------------------

procedure TPCDimmer_Server.Timer1Timer(Sender: TObject);
begin
  if firststart then
  begin
    firststart:=false;
    startupform.BringToFront;
    startupform.Label3.Caption:=_('Starte Netzwerkserver...');
    startupform.Refresh;

    Timer1.Enabled:=false;
  //  dxplay1.Open;
    DXPlay1.Async:=true;
    DXPlay1.TCPIPSetting.Port:=strtoint(port);
    DXPlay1.TCPIPSetting.Enabled:=true;
    dxplay1.ProviderName := dxplay1.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}')); // TCP/IP als Provider
  //  DXPlay1.ProviderName := DXPlay1.Providers[3]; // TCP/IP als Provider

    DXPlay1.Open2(true, 'PC_DIMMER Server', 'Server');

    if DXplay1.Opened then
    begin
      Label5.Caption:=_('Warte auf Clients...');
      Label1.Caption:='';
      systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
      Label5.Font.Color:=$000080FF;
      Label10.Caption:='';
    end else
    begin
      Label5.Caption:=_('Server nicht gestartet...');
      Label1.Caption:='';
      Label5.Font.Color:=clRed;
    end;

    startupform.hide;
  end;
end;

procedure TPCDimmer_Server.TBItem2Click(Sender: TObject);
begin
  UseLanguage('de');
  ReTranslateComponent(self);
  ReTranslateComponent(aboutform);
  ReTranslateComponent(startupform);

  if DXplay1.Opened then
  begin
    Label5.Caption:=_('Warte auf Clients...');
    Label1.Caption:='';
    systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
    Label5.Font.Color:=$000080FF;
    Label10.Caption:='';
  end else
  begin
    Label5.Caption:=_('Server nicht gestartet...');
    Label1.Caption:='';
    Label5.Font.Color:=clRed;
  end;
  ipadresselabel.Caption:=ipadress;
end;

procedure TPCDimmer_Server.TBItem3Click(Sender: TObject);
begin
  UseLanguage('en');
  ReTranslateComponent(self);
  ReTranslateComponent(aboutform);
  ReTranslateComponent(startupform);

  if DXplay1.Opened then
  begin
    Label5.Caption:=_('Warte auf Clients...');
    Label1.Caption:='';
    systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
    Label5.Font.Color:=$000080FF;
    Label10.Caption:='';
  end else
  begin
    Label5.Caption:=_('Server nicht gestartet...');
    Label1.Caption:='';
    Label5.Font.Color:=clRed;
  end;
  ipadresselabel.Caption:=ipadress;
end;

procedure TPCDimmer_Server.TBItem6Click(Sender: TObject);
begin
  UseLanguage('fr');
  ReTranslateComponent(self);
  ReTranslateComponent(aboutform);
  ReTranslateComponent(startupform);

  if DXplay1.Opened then
  begin
    Label5.Caption:=_('Warte auf Clients...');
    Label1.Caption:='';
    systray.hint:=_('PC_DIMMER Netzwerk-Server : Getrennt');
    Label5.Font.Color:=$000080FF;
    Label10.Caption:='';
  end else
  begin
    Label5.Caption:=_('Server nicht gestartet...');
    Label1.Caption:='';
    Label5.Font.Color:=clRed;
  end;
  ipadresselabel.Caption:=ipadress;
end;

end.
