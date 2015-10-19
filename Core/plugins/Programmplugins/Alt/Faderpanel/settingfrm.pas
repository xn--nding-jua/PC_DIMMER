unit settingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, ColorGrd, JvFullColorSpaces,
  ComCtrls, Registry, messagesystem, Mask, JvExMask, JvSpin, pngimage, ScktComp,
  Grids, Buttons, PngBitBtn, Menus, CHLabel;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackSendMessage = procedure(MSG:Byte; Data1, Data2: Variant);stdcall;

  TSettings = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    ScrollBar1: TScrollBar;
    CHLabel1: TCHLabel;
    Panel2: TPanel;
    CHLabel2: TCHLabel;
    ProgressBar2: TProgressBar;
    ScrollBar2: TScrollBar;
    Panel3: TPanel;
    CHLabel3: TCHLabel;
    ProgressBar3: TProgressBar;
    ScrollBar3: TScrollBar;
    Panel4: TPanel;
    CHLabel4: TCHLabel;
    ProgressBar4: TProgressBar;
    ScrollBar4: TScrollBar;
    Panel5: TPanel;
    CHLabel5: TCHLabel;
    ProgressBar5: TProgressBar;
    ScrollBar5: TScrollBar;
    Panel6: TPanel;
    CHLabel6: TCHLabel;
    ProgressBar6: TProgressBar;
    ScrollBar6: TScrollBar;
    Panel7: TPanel;
    CHLabel7: TCHLabel;
    ProgressBar7: TProgressBar;
    ScrollBar7: TScrollBar;
    Panel8: TPanel;
    CHLabel8: TCHLabel;
    ProgressBar8: TProgressBar;
    ScrollBar8: TScrollBar;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    Label3: TLabel;
    Button4: TButton;
    Label4: TLabel;
    Button5: TButton;
    Label5: TLabel;
    Button6: TButton;
    Label6: TLabel;
    Button7: TButton;
    Label7: TLabel;
    Button8: TButton;
    Label8: TLabel;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    RefreshTimer: TTimer;
    Bevel1: TBevel;
    startchannel: TScrollBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Refresh(i: integer);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure startchannelScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    scrolling:integer;
  public
    { Public-Deklarationen }
    shutdown:boolean;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    SendMsg:TCallbackSendMessage;
    channelvalue:array[1..8192] of integer;
    channelnames:array[1..8192] of string;
    channelchecked:array[1..8192] of boolean;
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
  i:integer;
begin
  RefreshTimer.Enabled:=true;

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

  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.FormHide(Sender: TObject);
var
	LReg:TRegistry;
begin
  RefreshTimer.Enabled:=false;

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
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
  end;
end;


procedure TSettings.FormCreate(Sender: TObject);
//var
//	LReg:TRegistry;
begin
{
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
}
  startchannel.position:=1;
end;

procedure TSettings.RefreshTimerTimer(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 8 do
  begin
    if channelvalue[startchannel.position+i-1]<>TProgressBar(FindComponent('ProgressBar'+inttostr(i))).Position then
    begin
      Refresh(i);
    end;
  end;
end;

procedure TSettings.Button10Click(Sender: TObject);
var
  i:integer;
begin
  if startchannel.position+8<=8185 then
    startchannel.position:=startchannel.position+8
  else
    startchannel.position:=8185;

  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button9Click(Sender: TObject);
var
  i:integer;
begin
  if startchannel.position-8>=1 then
    startchannel.position:=startchannel.position-8
  else
    startchannel.position:=1;

  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Refresh(i: integer);
begin
  TProgressBar(FindComponent('ProgressBar'+inttostr(i))).Position:=channelvalue[startchannel.position-1+i];
  if (scrolling<>i) then
    TScrollbar(FindComponent('ScrollBar'+inttostr(i))).Position:=255-channelvalue[startchannel.position-1+i];
  TCHLabel(FindComponent('CHLabel'+inttostr(i))).Caption:=channelnames[startchannel.position-1+i];
  TButton(FindComponent('Button'+inttostr(i))).Caption:=inttostr(startchannel.position-1+i);
  TLabel(FindComponent('Label'+inttostr(i))).Caption:=inttostr(round(channelvalue[startchannel.position-1+i]/255*100))+'%';
  TLabel(FindComponent('Label'+inttostr(i))).Alignment:=taCenter;
  TCheckBox(FindComponent('CheckBox'+inttostr(i))).Caption:=inttostr(startchannel.position-1+i);
  TCheckBox(FindComponent('CheckBox'+inttostr(i))).Checked:=channelchecked[startchannel.position-1+i];
end;

procedure TSettings.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  i,j:integer;
begin
  for i:=1 to 8 do
  begin
    if (Sender=TScrollBar(FindComponent('ScrollBar'+inttostr(i)))) then
    begin
      Scrolling:=i;
      RefreshDLLValues(startchannel.position+i-1, 255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position, 255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position, 0, 0);
      Scrolling:=0;

      for j:=1 to 8192 do
      begin
        if channelchecked[j] and (j<>startchannel.position+i-1) then
          RefreshDLLValues(j, 255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position, 255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position, 0, 0);
      end;

      break;
    end;
  end;
end;

procedure TSettings.Button11Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=1;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button12Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=9;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button13Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=17;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button14Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=25;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button15Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=33;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button16Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=41;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button17Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=49;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button18Click(Sender: TObject);
var
  i:integer;
begin
  startchannel.position:=57;
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  for i:=1 to 8 do
  begin
    if (Sender=TButton(FindComponent('Button'+inttostr(i)))) then
    begin
      RefreshDLLValues(startchannel.position+i-1, 255, 255, 0, 0);

      for j:=1 to 8192 do
      begin
        if channelchecked[j] and (j<>startchannel.position+i-1) then
          RefreshDLLValues(j, 255, 255, 0, 0);
      end;

      break;
    end;
  end;
end;

procedure TSettings.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  for i:=1 to 8 do
  begin
    if (Sender=TButton(FindComponent('Button'+inttostr(i)))) then
    begin
      RefreshDLLValues(startchannel.position+i-1, 0, 0, 0, 0);

      for j:=1 to 8192 do
      begin
        if channelchecked[j] and (j<>startchannel.position+i-1) then
          RefreshDLLValues(j, 0, 0, 0, 0);
      end;

      break;
    end;
  end;
end;

procedure TSettings.startchannelScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  i:integer;
begin
  for i:=1 to 8 do Refresh(i);
end;

procedure TSettings.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=1 to 8 do
  begin
    if (Sender=TCheckBox(FindComponent('CheckBox'+inttostr(i)))) then
    begin
      channelchecked[startchannel.position+i-1]:=TCheckBox(FindComponent('CheckBox'+inttostr(i))).Checked;
      break;
    end;
  end;
end;

procedure TSettings.CheckBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  if (Button=mbRight) then
  begin
    for j:=1 to 8192 do
    begin
      channelchecked[j]:=false;
    end;

    for i:=1 to 8 do
    begin
      Refresh(i);
    end;
  end;
end;

end.
