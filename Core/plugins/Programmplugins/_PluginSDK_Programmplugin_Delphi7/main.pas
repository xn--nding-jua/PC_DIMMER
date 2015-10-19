unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Menus, Buttons, messagesystem;

const
  chan=512;
	maxzeile=24;
	maxspalte=24;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

type
  Tpluginscene = record
    ID: TGUID;
    Name: string;
  end;

  Tmainform = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Button4: TButton;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    GroupBox3: TGroupBox;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox4: TGroupBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button5: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    GroupBox5: TGroupBox;
    Edit5: TEdit;
    Button6: TButton;
    CheckBox1: TCheckBox;
    TrackBar5: TTrackBar;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Button7: TButton;
    Shape1: TShape;
    Shape2: TShape;
    GroupBox6: TGroupBox;
    NewPluginScene: TButton;
    ListBox1: TListBox;
    DeletePluginScene: TButton;
    RenamePluginScene: TButton;
    Label18: TLabel;
    Button8: TButton;
    Button9: TButton;
    GroupBox7: TGroupBox;
    Button10: TButton;
    Edit6: TEdit;
    Label19: TLabel;
    Edit7: TEdit;
    Label20: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label22: TLabel;
    Edit10: TEdit;
    Label23: TLabel;
    Edit11: TEdit;
    Label24: TLabel;
    Edit12: TEdit;
    Label25: TLabel;
    Label21: TLabel;
    Label26: TLabel;
    Edit13: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure NewPluginSceneClick(Sender: TObject);
    procedure RefreshListbox;
    procedure DeletePluginSceneClick(Sender: TObject);
    procedure RenamePluginSceneClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    PluginSzenen: array of Tpluginscene;

		MSGFROMMAINPROGRAM:boolean;
    channelvalue:array[1..chan] of integer;
    channelnames:array[1..chan] of string;
    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
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
  ShowMessage('PluginSDK Programmplugin: FormCreate');
  label4.Caption:=GetModulePath;
end;

procedure Tmainform.FormHide(Sender: TObject);
begin
  ShowMessage('PluginSDK Programmplugin: FormHide');
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
begin
  ShowMessage('PluginSDK Programmplugin: FormDestroy');
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  ShowMessage('PluginSDK Programmplugin: FormShow');
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  SendMSG(MSG_STARTSCENE,Edit1.Text,0);
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  SendMSG(MSG_STOPSCENE,Edit1.Text,0);
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  SendMSG(MSG_BEATIMPULSE,true,0);
end;

procedure Tmainform.TrackBar1Change(Sender: TObject);
begin
  SendMSG(MSG_SYSTEMSPEED, Trackbar1.Position, 0);
end;

procedure Tmainform.Button6Click(Sender: TObject);
begin
  SendMSG(MSG_ADDLOGFILEENTRY,edit5.text,0);
end;

procedure Tmainform.Button5Click(Sender: TObject);
var
  midiarray:Variant;
begin
  midiarray:=VarArrayCreate([0,2], varInteger);
  midiarray[0]:=strtoint(edit2.text);
  midiarray[1]:=strtoint(edit3.text);
  midiarray[2]:=strtoint(edit4.text);
  SendMSG(MSG_MIDIIN,midiarray,0);
end;

procedure Tmainform.Button7Click(Sender: TObject);
var
  midiarray:Variant;
begin
  midiarray:=VarArrayCreate([0,2], varInteger);
  midiarray[0]:=strtoint(edit2.text);
  midiarray[1]:=strtoint(edit3.text);
  midiarray[2]:=strtoint(edit4.text);
  SendMSG(MSG_MIDIOUT,midiarray,0);
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SendMSG(MSG_SYSTEMMUTE,checkbox1.checked,0);
end;

procedure Tmainform.TrackBar2Change(Sender: TObject);
begin
  SendMSG(MSG_GRANDMASTER,Trackbar2.position,0);
end;

procedure Tmainform.TrackBar3Change(Sender: TObject);
begin
  SendMSG(MSG_FLASHMASTER,Trackbar3.position,0);
end;

procedure Tmainform.TrackBar4Change(Sender: TObject);
begin
  SendMSG(MSG_SPEEDMASTER,Trackbar4.position,0);
end;

procedure Tmainform.TrackBar5Change(Sender: TObject);
begin
  SendMSG(MSG_SYSTEMVOLUME,Trackbar5.position,0);
end;

procedure Tmainform.NewPluginSceneClick(Sender: TObject);
begin
  setlength(PluginSzenen, length(PluginSzenen)+1);
  CreateGUID(PluginSzenen[length(PluginSzenen)-1].ID);
  PluginSzenen[length(PluginSzenen)-1].Name:='Pluginszene - Zufallswert: '+inttostr(Random(60000));
  SendMSG(MSG_CREATEPLUGINSCENE, GUIDToString(Pluginszenen[length(pluginszenen)-1].ID), PluginSzenen[length(PluginSzenen)-1].Name);
  RefreshListbox;
end;

procedure Tmainform.RefreshListbox;
var
  i:integer;
begin
  Listbox1.items.clear;
  for i:=0 to length(PluginSzenen)-1 do
    Listbox1.items.add(PluginSzenen[i].Name);
end;

procedure Tmainform.DeletePluginSceneClick(Sender: TObject);
var
  i:integer;
begin
  if Listbox1.ItemIndex>-1 then
  begin
    SendMSG(MSG_REMOVEPLUGINSCENE, GUIDToString(Pluginszenen[Listbox1.ItemIndex].ID), 0);
    for i:=Listbox1.ItemIndex to length(Pluginszenen)-2 do
    begin
      Pluginszenen[i].ID:=Pluginszenen[i+1].ID;
      Pluginszenen[i].Name:=Pluginszenen[i+1].Name;
    end;
    setlength(pluginszenen, length(pluginszenen)-1);
  end;
  RefreshListbox;
end;

procedure Tmainform.RenamePluginSceneClick(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
  begin
    Pluginszenen[Listbox1.ItemIndex].Name:='Pluginszene - Zufallswert: '+inttostr(Random(60000));
    SendMSG(MSG_REFRESHPLUGINSCENE, GUIDToString(Pluginszenen[Listbox1.ItemIndex].ID), Pluginszenen[Listbox1.ItemIndex].Name);
  end;
  RefreshListbox;
end;

procedure Tmainform.Button8Click(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
  begin
    Pluginszenen[Listbox1.ItemIndex].Name:='Pluginszene - Zufallswert: '+inttostr(Random(60000));
    SendMSG(MSG_OPENLIBRARY, GUIDToString(Pluginszenen[Listbox1.ItemIndex].ID), 0);
  end;
  RefreshListbox;
end;

procedure Tmainform.Button9Click(Sender: TObject);
begin
  SendMSG(MSG_OPENLIBRARY, '{00000000-0000-0000-0000-000000000000}', 0);
end;

procedure Tmainform.Button10Click(Sender: TObject);
var
  Submasterarray:Variant;
  Data2: byte;
begin
   Submasterarray:=VarArrayCreate([0, 6], varVariant);

   Submasterarray[0]:=edit6.text;
   Submasterarray[1]:=edit7.text;
   Submasterarray[2]:=edit8.text;
   Submasterarray[3]:=edit9.text;
   Submasterarray[4]:=edit10.text;
   Submasterarray[5]:=edit11.text;
   Submasterarray[6]:=edit12.text;

   Data2:=strtoint(edit13.Text);

   SendMSG(MSG_STARTCOMMAND, Submasterarray, Data2);
end;

end.


