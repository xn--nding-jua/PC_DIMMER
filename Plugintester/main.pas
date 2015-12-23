unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, XPMan, messagesystem;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    XPManifest1: TXPManifest;
    Button2: TButton;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    btnDLLSenddata: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox4: TGroupBox;
    btnDLLActivate: TButton;
    btnDLLDeactivate: TButton;
    btnDLLIdentify: TButton;
    btnDLLGetVersion: TButton;
    btnDLLGetName: TButton;
    btnDLLAbout: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Button1: TButton;
    btnDLLConfigure: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Button5: TButton;
    Memo1: TMemo;
    Button6: TButton;
    GroupBox5: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    ScrollBar9: TScrollBar;
    ScrollBar10: TScrollBar;
    ScrollBar11: TScrollBar;
    ScrollBar12: TScrollBar;
    ScrollBar13: TScrollBar;
    ScrollBar14: TScrollBar;
    ScrollBar15: TScrollBar;
    ScrollBar16: TScrollBar;
    ScrollBar17: TScrollBar;
    ScrollBar18: TScrollBar;
    ScrollBar19: TScrollBar;
    ScrollBar20: TScrollBar;
    ScrollBar21: TScrollBar;
    ScrollBar22: TScrollBar;
    ScrollBar23: TScrollBar;
    ScrollBar24: TScrollBar;
    fulluniverseslider: TScrollBar;
    procedure btnDLLActivateClick(Sender: TObject);
    procedure btnDLLConfigureClick(Sender: TObject);
    procedure btnDLLSenddataClick(Sender: TObject);
    procedure btnDLLDeactivateClick(Sender: TObject);
    procedure btnDLLIdentifyClick(Sender: TObject);
    procedure btnDLLGetVersionClick(Sender: TObject);
    procedure btnDLLGetNameClick(Sender: TObject);
    procedure btnDLLAboutClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure fulluniversesliderChange(Sender: TObject);
  private
    { Private-Deklarationen }
    DLL:THandle;

    // Dynamisches Linken der DLL-Funktionen
    DLLCreate:procedure(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
    DLLStart:procedure;stdcall;
    DLLDestroy:function:boolean;stdcall;
    DLLIdentify:function:PChar;stdcall;
    DLLGetVersion:function:PChar;stdcall;
    DLLGetName:function:PChar;stdcall;
    DLLConfigure:procedure;stdcall;
    DLLShow:procedure;stdcall;
    DLLAbout:procedure;stdcall;
    DLLSendData:procedure(address, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
    DLLIsSending:function:boolean;stdcall;
    DLLSendMessage:procedure(MSG:Byte; Data1, Data2:Variant);stdcall;
  public
    { Public-Deklarationen }
  end;


{
// Statisches Linken der DLL-Funktionen (Programm kann dann aber ohne die DLL nicht starten!)
procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;export;external 'plugin.dll';
procedure DLLDestroy;stdcall;export;external 'plugin.dll';
function DLLIdentify:PChar;stdcall;export;external 'plugin.dll';
function DLLGetVersion:PChar;export;external 'plugin.dll';
function DLLGetName:PChar;export;external 'plugin.dll';
procedure DLLConfigure;stdcall;export;external 'plugin.dll';
procedure DLLShow;stdcall;export;external 'plugin.dll';
procedure DLLAbout;stdcall;export;external 'plugin.dll';
procedure DLLSendData(address, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;export;external 'plugin.dll';
function DLLIsSending:boolean;stdcall;export;external 'plugin.dll';
procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;export;external 'plugin.dll';
}
procedure CallbackGetDLLValues(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
procedure CallbackGetDLLValueEvent(address,endvalue:integer);stdcall;
procedure CallbackGetDLLNames(address:integer; channelname:PChar);stdcall;
function CallbackSetDLLValue(address:integer):integer;stdcall;
procedure CallbackSendMessage(MSG: Byte; Data1, Data2:Variant);stdcall;

var
  Form1: TForm1;

implementation

{$R *.dfm}

// Ab hier die Callback-Funktionen, um Daten von der DLL zum Hauptprogramm zu senden
//////////////////////////////////////////////////////////////////////////////

procedure CallbackGetDLLValues(address,startvalue,endvalue,fadetime,delay:integer);
begin
  form1.memo1.Lines.Clear;
  form1.memo1.Lines.Add('CallbackSetDLLValues');
  form1.memo1.Lines.Add('Adresse: '+inttostr(address));
  form1.memo1.Lines.Add('Startwert: '+inttostr(startvalue)+', Endwert: '+inttostr(endvalue));
  form1.memo1.Lines.Add('Fadetime: '+inttostr(fadetime)+'ms, Delay: '+inttostr(delay)+'ms');
end;

procedure CallbackGetDLLValueEvent(address,endvalue:integer);
begin
  form1.memo1.Lines.Clear;
  form1.memo1.Lines.Add('CallbackGetDLLValueEvent');
  form1.memo1.Lines.Add('Adresse: '+inttostr(address));
  form1.memo1.Lines.Add('Wert: '+inttostr(endvalue));
end;

procedure CallbackGetDLLNames(address:integer; channelname:PChar);
begin
  form1.memo1.Lines.Clear;
  form1.memo1.Lines.Add('CallbackGetDLLNames');
  form1.memo1.Lines.Add('Adresse: '+inttostr(address));
  form1.memo1.Lines.Add('Kanalname: '+channelname);
end;

function CallbackSetDLLValue(address:integer):integer;
begin
  form1.memo1.Lines.Clear;
  form1.memo1.Lines.Add('CallbackSetDLLValue');
  form1.memo1.Lines.Add('Adresse: '+inttostr(address));
  form1.memo1.Lines.Add('Sende Zufallswert zurück...');

  Randomize;
	result:=Random(256);
end;

procedure CallbackSendMessage(MSG: Byte; Data1, Data2:Variant);
begin
  form1.memo1.Lines.Clear;
  form1.memo1.Lines.Add('CallbackSendMessage');
  form1.memo1.Lines.Add('MSG: '+inttostr(MSG)+' = '+GetMSGName(MSG));
  form1.memo1.Lines.Add('Datentyp von Data1 und Data2 ist Nachrichtenabhängig. Inhalt wird hier nicht angezeigt...');
end;

//////////////////////////////////////////////////////////////////////////////

procedure TForm1.btnDLLActivateClick(Sender: TObject);
begin
	DLLCreate(@CallbackGetDLLValues,@CallbackGetDLLValueEvent,@CallbackGetDLLNames,@CallbackSetDLLValue,@CallbackSendMessage);
  if Assigned(DLLStart) then
    DLLStart;
end;

procedure TForm1.btnDLLConfigureClick(Sender: TObject);
begin
	try
    DLLConfigure;
  except
    ShowMessage('Fehler: Konnte Konfigurationsfunktion nicht ausführen.'+#13#10#13#10+'Das Plugin muss vermutlich zunächst durch "DLLCreate" und "DLLStart" aktiviert werden, oder es ist ein Programmplugin!');
  end;
end;

procedure TForm1.btnDLLSendDataClick(Sender: TObject);
var
	channelname:String[255];
begin
	channelname:=edit5.Text+#0;
	DLLSendData(strtoint(edit1.Text),strtoint(edit2.Text),strtoint(edit3.Text),strtoint(edit4.Text),@channelname);
end;

procedure TForm1.btnDLLDeactivateClick(Sender: TObject);
begin
	DLLDestroy;
end;

procedure TForm1.btnDLLIdentifyClick(Sender: TObject);
begin
	ShowMessage(DLLIdentify);
end;

procedure TForm1.btnDLLGetVersionClick(Sender: TObject);
begin
	ShowMessage(DLLGetVersion);
end;

procedure TForm1.btnDLLGetNameClick(Sender: TObject);
begin
	ShowMessage(DLLGetName);
end;

procedure TForm1.btnDLLAboutClick(Sender: TObject);
begin
  try
  	DLLAbout;
  except
    ShowMessage('Die About-Funktion ist bei diesem Plugin nicht verfügbar!');
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if DLLIsSending then
    ShowMessage('True')
  else
    ShowMessage('False');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
	DLLSendMessage(strtoint(edit6.Text),strtoint(edit7.Text),strtoint(edit8.Text));
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DLL<>0 then
  begin
    try
      DLLDestroy;
    except
    end;
    FreeLibrary(DLL);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  OpenDialog1.InitialDir:=ExtractFilePath(paramstr(0));
  
  if OpenDialog1.Execute then
  begin
    DLL:=LoadLibrary(PChar(OpenDialog1.Filename));

    DLLCreate:=GetProcAddress(DLL,'DLLCreate');
    if not Assigned(DLLCreate) then
      DLLCreate:=GetProcAddress(DLL,'DLLActivate');
    DLLStart:=GetProcAddress(DLL,'DLLStart');
    DLLDestroy:=GetProcAddress(DLL,'DLLDestroy');
    if not Assigned(DLLDestroy) then
      DLLDestroy:=GetProcAddress(DLL,'DLLDeactivate');
    DLLIdentify:=GetProcAddress(DLL,'DLLIdentify');
    DLLGetVersion:=GetProcAddress(DLL,'DLLGetVersion');
    DLLGetName:=GetProcAddress(DLL,'DLLGetName');
    DLLConfigure:=GetProcAddress(DLL,'DLLConfigure');
    DLLShow:=GetProcAddress(DLL,'DLLShow');
    DLLAbout:=GetProcAddress(DLL,'DLLAbout');
    DLLSendData:=GetProcAddress(DLL,'DLLSendData');
    DLLIsSending:=GetProcAddress(DLL,'DLLIsSending');
    DLLSendMessage:=GetProcAddress(DLL,'DLLSendMessage');

    groupbox4.visible:=true;
    groupbox3.visible:=true;
    groupbox2.visible:=true;
    groupbox1.visible:=true;
    groupbox5.visible:=true;
    fulluniverseslider.visible:=true;
    button5.Visible:=true;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  FreeLibrary(DLL);
  DLL:=0;
  
  groupbox4.visible:=false;
  groupbox3.visible:=false;
  groupbox2.visible:=false;
  groupbox1.visible:=false;
  groupbox5.visible:=false;
  fulluniverseslider.visible:=false;
  button5.Visible:=false;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
	try
    DLLShow;
  except
    ShowMessage('Fehler: Konnte Pluginfenster nicht anzeigen.'+#13#10#13#10+'Das Plugin muss vermutlich zunächst durch "DLLCreate" und "DLLStart" aktiviert werden, oder es ist ein Ausgabeplugin!');
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if paramcount=2 then
  begin
    DLL:=LoadLibrary(PChar(ExtractFilePath(paramstr(0))+paramstr(2)));

    DLLCreate:=GetProcAddress(DLL,'DLLCreate');
    if not Assigned(DLLCreate) then
      DLLCreate:=GetProcAddress(DLL,'DLLActivate');
    DLLStart:=GetProcAddress(DLL,'DLLStart');
    DLLDestroy:=GetProcAddress(DLL,'DLLDestroy');
    if not Assigned(DLLDestroy) then
      DLLDestroy:=GetProcAddress(DLL,'DLLDeactivate');
    DLLIdentify:=GetProcAddress(DLL,'DLLIdentify');
    DLLGetVersion:=GetProcAddress(DLL,'DLLGetVersion');
    DLLGetName:=GetProcAddress(DLL,'DLLGetName');
    DLLConfigure:=GetProcAddress(DLL,'DLLConfigure');
    DLLShow:=GetProcAddress(DLL,'DLLShow');
    DLLAbout:=GetProcAddress(DLL,'DLLAbout');
    DLLSendData:=GetProcAddress(DLL,'DLLSendData');
    DLLIsSending:=GetProcAddress(DLL,'DLLIsSending');
    DLLSendMessage:=GetProcAddress(DLL,'DLLSendMessage');

  	DLLCreate(@CallbackGetDLLValues,@CallbackGetDLLValueEvent,@CallbackGetDLLNames,@CallbackSetDLLValue,@CallbackSendMessage);
    if Assigned(DLLStart) then
      DLLStart;
    if DLLIdentify='Output' then
    begin
      DLLConfigure;
    end else if DLLIdentify='Input' then
    begin
      DLLShow;
    end;

    groupbox4.visible:=true;
    groupbox3.visible:=true;
    groupbox2.visible:=true;
    groupbox1.visible:=true;
    groupbox5.visible:=true;
    fulluniverseslider.visible:=true;
    button5.Visible:=true;
  end else if paramcount=1 then
  begin
    DLL:=LoadLibrary(PChar(paramstr(1)));

    DLLCreate:=GetProcAddress(DLL,'DLLCreate');
    if not Assigned(DLLCreate) then
      DLLCreate:=GetProcAddress(DLL,'DLLActivate');
    DLLStart:=GetProcAddress(DLL,'DLLStart');
    DLLDestroy:=GetProcAddress(DLL,'DLLDestroy');
    if not Assigned(DLLDestroy) then
      DLLDestroy:=GetProcAddress(DLL,'DLLDeactivate');
    DLLIdentify:=GetProcAddress(DLL,'DLLIdentify');
    DLLGetVersion:=GetProcAddress(DLL,'DLLGetVersion');
    DLLGetName:=GetProcAddress(DLL,'DLLGetName');
    DLLConfigure:=GetProcAddress(DLL,'DLLConfigure');
    DLLShow:=GetProcAddress(DLL,'DLLShow');
    DLLAbout:=GetProcAddress(DLL,'DLLAbout');
    DLLSendData:=GetProcAddress(DLL,'DLLSendData');
    DLLIsSending:=GetProcAddress(DLL,'DLLIsSending');
    DLLSendMessage:=GetProcAddress(DLL,'DLLSendMessage');

  	DLLCreate(@CallbackGetDLLValues,@CallbackGetDLLValueEvent,@CallbackGetDLLNames,@CallbackSetDLLValue,@CallbackSendMessage);
    if Assigned(DLLStart) then
      DLLStart;
    if DLLIdentify='Output' then
    begin
      DLLConfigure;
    end else if DLLIdentify='Input' then
    begin
      DLLShow;
    end;

    groupbox4.visible:=true;
    groupbox3.visible:=true;
    groupbox2.visible:=true;
    groupbox1.visible:=true;
    groupbox5.visible:=true;
    fulluniverseslider.visible:=true;
    button5.Visible:=true;
  end;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 24 do
  begin
    if Sender=TScrollbar(FindComponent('ScrollBar'+inttostr(i))) then
    begin
      DLLSendMessage(14, i, 255-TScrollbar(FindComponent('ScrollBar'+inttostr(i))).position);
      break;
    end;
  end;
end;

procedure TForm1.fulluniversesliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 512 do
  begin
    DLLSendMessage(14, i, fulluniverseslider.position);
  end;
end;

end.
