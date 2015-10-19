unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;
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

procedure Tmainform.FormCreate(Sender: TObject);
begin
  // Activate Outputplugin
  issending:=false;
  memo1.Lines.Add(GetModulePath);
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  Randomize;
  SetDLLValues(1, Random(256), Random(256), 5000, 0);
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  Randomize;
  SetDLLValueEvent(1, Random(256));
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  Randomize;
  SetDLLNames(1, PChar('Neuer Name: '+inttostr(Random(1024))));
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  ShowMessage('Wert von Kanal 1 im Hauptprogramm: '+inttostr(GetDLLValue(1)));
end;

procedure Tmainform.Button5Click(Sender: TObject);
begin
  Randomize;
  SendMSG(14, 1, Random(256));
end;

end.
