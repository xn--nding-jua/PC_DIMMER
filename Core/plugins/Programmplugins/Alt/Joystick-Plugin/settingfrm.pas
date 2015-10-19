unit settingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, XPMan, ColorGrd, JvFullColorSpaces,
  JvFullColorCtrls, JvProgressBar, JvComponent, JvBaseDlg, ComCtrls,
  JvSimScope, FlightJoyStick, Registry, VistaAltFixUnit;

const
	chan=512;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;

  TSettings = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    XPManifest1: TXPManifest;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label8: TLabel;
    Bevel1: TBevel;
    joystickcontrol: TFlightJoyStick;
    xtimer: TTimer;
    ytimer: TTimer;
    ztimer: TTimer;
    VistaAltFix1: TVistaAltFix;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure joystickcontrolXYChange(Sender: TObject;
      JoyStickInfo: TJoyStickInfo);
    procedure joystickcontrolZChange(Sender: TObject;
      JoyStickInfo: TJoyStickInfo);
    procedure xtimerTimer(Sender: TObject);
    procedure ytimerTimer(Sender: TObject);
    procedure ztimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
	  channelvalue:array[1..chan] of integer;
  	channelnames:array[1..chan] of string;
    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    shutdown:boolean;
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

procedure TSettings.Button1Click(Sender: TObject);
begin
  Settings.Hide;
end;

procedure TSettings.Edit1Change(Sender: TObject);
begin
	edit2.Text:=inttostr(strtoint(edit1.text)+1);
	edit3.Text:=inttostr(strtoint(edit1.text)+2);
end;

procedure TSettings.joystickcontrolXYChange(Sender: TObject;
  JoyStickInfo: TJoyStickInfo);
begin
	Application.ProcessMessages;
  label5.Caption:='X: '+inttostr(round(100*JoyStickInfo.X_Axis));
  label6.Caption:='Y: '+inttostr(round(100*JoyStickInfo.Y_Axis));

	if (100*JoyStickInfo.X_Axis<-1) or (100*JoyStickInfo.X_Axis>1) then
  begin
    if 100*JoyStickInfo.X_Axis<0 then
    begin
	    xtimer.Interval:=abs(round(1000*(1+JoyStickInfo.X_Axis)));
      if xtimer.Interval=0 then xtimer.Interval:=1;
    end else
    begin
	    xtimer.Interval:=abs(round(1000*(1-JoyStickInfo.X_Axis)));
      if xtimer.Interval=0 then xtimer.Interval:=1;
    end;
    if not xtimer.Enabled then
    	xtimer.Enabled:=true;
  end else
  	xtimer.Enabled:=false;

	if (100*JoyStickInfo.Y_Axis<-1) or (100*JoyStickInfo.Y_Axis>1) then
  begin
    if 100*JoyStickInfo.Y_Axis<0 then
    begin
	    ytimer.Interval:=abs(round(1000*(1+JoyStickInfo.Y_Axis)));
      if ytimer.Interval=0 then ytimer.Interval:=1;
    end else
    begin
	    ytimer.Interval:=abs(round(1000*(1-JoyStickInfo.Y_Axis)));
      if ytimer.Interval=0 then ytimer.Interval:=1;
    end;
    if not ytimer.Enabled then
    	ytimer.Enabled:=true;
  end else
  	ytimer.Enabled:=false;
end;

procedure TSettings.joystickcontrolZChange(Sender: TObject;
  JoyStickInfo: TJoyStickInfo);
begin
	Application.ProcessMessages;
  label7.Caption:='Z: '+inttostr(round(100*JoyStickInfo.Z_Axis));

	if (100*JoyStickInfo.Z_Axis<-1) or (100*JoyStickInfo.Z_Axis>1) then
  begin
    if 100*JoyStickInfo.Z_Axis<0 then
    begin
	    ztimer.Interval:=abs(round(1000*(1+JoyStickInfo.Z_Axis)));
      if ztimer.Interval=0 then ztimer.Interval:=1;
    end else
    begin
	    ztimer.Interval:=abs(round(1000*(1-JoyStickInfo.Z_Axis)));
      if ztimer.Interval=0 then ztimer.Interval:=1;
    end;
    if not ztimer.Enabled then
    	ztimer.Enabled:=true;
  end else
  	ztimer.Enabled:=false;
end;

procedure TSettings.xtimerTimer(Sender: TObject);
begin
	if joystickcontrol.X_Axis<0 then
  begin
    if channelvalue[strtoint(edit1.text)]>1 then
	  	channelvalue[strtoint(edit1.text)]:=channelvalue[strtoint(edit1.text)]-2
    else
    	xtimer.Enabled:=false;
  end else
  begin
    if channelvalue[strtoint(edit1.text)]<254 then
	  	channelvalue[strtoint(edit1.text)]:=channelvalue[strtoint(edit1.text)]+2
    else
    	xtimer.Enabled:=false;
  end;
  RefreshDLLValues(strtoint(edit1.text),channelvalue[strtoint(edit1.text)],channelvalue[strtoint(edit1.text)],0);
end;

procedure TSettings.ytimerTimer(Sender: TObject);
begin
	if joystickcontrol.Y_Axis<0 then
  begin
    if channelvalue[strtoint(edit2.text)]>1 then
		  channelvalue[strtoint(edit2.text)]:=channelvalue[strtoint(edit2.text)]-2
    else
    	ytimer.Enabled:=false;
  end else
  begin
    if channelvalue[strtoint(edit2.text)]<254 then
		  channelvalue[strtoint(edit2.text)]:=channelvalue[strtoint(edit2.text)]+2
    else
	    ytimer.Enabled:=false;
  end;
  RefreshDLLValues(strtoint(edit2.text),channelvalue[strtoint(edit2.text)],channelvalue[strtoint(edit2.text)],0);
end;

procedure TSettings.ztimerTimer(Sender: TObject);
begin
	if joystickcontrol.Z_Axis<0 then
  begin
    if channelvalue[strtoint(edit3.text)]>1 then
		  channelvalue[strtoint(edit3.text)]:=channelvalue[strtoint(edit3.text)]-2
    else
    	ztimer.Enabled:=false;
  end else
  begin
    if channelvalue[strtoint(edit3.text)]<254 then
		  channelvalue[strtoint(edit3.text)]:=channelvalue[strtoint(edit3.text)]+2
    else
    	ztimer.Enabled:=false;
  end;
  RefreshDLLValues(strtoint(edit3.text),channelvalue[strtoint(edit3.text)],channelvalue[strtoint(edit3.text)],0);
end;

procedure TSettings.FormShow(Sender: TObject);
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
                LReg.WriteBool('Showing Plugin',true);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
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
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
  end;
end;

end.
