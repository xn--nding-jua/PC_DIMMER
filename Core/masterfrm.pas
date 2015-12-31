unit masterfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, messagesystem, ExtCtrls, bass, Registry,
  gnugettext;

type
  Tmasterform = class(TForm)
    dimmermaster: TTrackBar;
    flashmaster: TTrackBar;
    speedmaster: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Volumeslider: TTrackBar;
    Label7: TLabel;
    Button4: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    FogSlider: TTrackBar;
    Button5: TButton;
    procedure dimmermasterChange(Sender: TObject);
    procedure flashmasterChange(Sender: TObject);
    procedure speedmasterChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure VolumesliderChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Button5Click(Sender: TObject);
    procedure FogSliderChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  masterform: Tmasterform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tmasterform.dimmermasterChange(Sender: TObject);
var
	i:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

	for i:=0 to length(mainform.devices)-1 do
  begin
  	geraetesteuerung.set_channel(mainform.devices[i].ID,'dimmer',geraetesteuerung.get_channel(mainform.devices[i].ID,'dimmer'),geraetesteuerung.get_channel(mainform.devices[i].ID,'dimmer'),0);
  	geraetesteuerung.set_channel(mainform.devices[i].ID,'r',geraetesteuerung.get_channel(mainform.devices[i].ID,'r'),geraetesteuerung.get_channel(mainform.devices[i].ID,'r'),0);
  	geraetesteuerung.set_channel(mainform.devices[i].ID,'g',geraetesteuerung.get_channel(mainform.devices[i].ID,'g'),geraetesteuerung.get_channel(mainform.devices[i].ID,'g'),0);
  	geraetesteuerung.set_channel(mainform.devices[i].ID,'b',geraetesteuerung.get_channel(mainform.devices[i].ID,'b'),geraetesteuerung.get_channel(mainform.devices[i].ID,'b'),0);
  end;
  Timer1Timer(Sender);
  mainform.SendMSG(MSG_GRANDMASTER, 255-dimmermaster.Position, 0);
end;

procedure Tmasterform.flashmasterChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  mainform.SendMSG(MSG_Flashmaster,255-Flashmaster.Position,0);
  Timer1Timer(Sender);
  mainform.SendMSG(MSG_FLASHMASTER, 255-Flashmaster.Position, 0);
end;

procedure Tmasterform.speedmasterChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  mainform.SendMSG(MSG_Speedmaster,512-Speedmaster.Position,0);
  Timer1Timer(Sender);
  mainform.SendMSG(MSG_SPEEDMASTER, 512-Speedmaster.Position, 0);
end;

procedure Tmasterform.Timer1Timer(Sender: TObject);
begin
  label4.caption:=inttostr(round((255-dimmermaster.Position)/255*100))+'%';
  label5.caption:=inttostr(round((255-Flashmaster.Position)/255*100))+'%';
  if speedmaster.position=256 then
    label6.caption:='±0'
  else
    label6.caption:=inttostr(256-speedmaster.Position);
  label7.caption:=inttostr(round(BASS_GetVolume()*100))+'%';
  label9.caption:=inttostr(round((255-fogslider.position)/2.55))+'%';

  volumeslider.position:=100-round(BASS_GetVolume()*100);
end;

procedure Tmasterform.FormShow(Sender: TObject);
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
  			LReg.WriteBool('Showing Master',true);

        if not LReg.KeyExists('Master') then
	        LReg.CreateKey('Master');
	      if LReg.OpenKey('Master',true) then
	      begin
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+masterform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              masterform.Left:=LReg.ReadInteger('PosX')
            else
              masterform.Left:=0;
          end else
            masterform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+masterform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              masterform.Top:=LReg.ReadInteger('PosY')
            else
              masterform.Top:=0;
          end else
            masterform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Timer1.enabled:=true;
end;

procedure Tmasterform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not mainform.shutdown then
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
					LReg.WriteBool('Showing Master',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;

  Timer1.enabled:=false;
  mainform.SaveWindowPositions('master');
end;

procedure Tmasterform.Label4Click(Sender: TObject);
begin
  dimmermaster.position:=0;
end;

procedure Tmasterform.Label5Click(Sender: TObject);
begin
  flashmaster.position:=0;
end;

procedure Tmasterform.Label6Click(Sender: TObject);
begin
  speedmaster.position:=256;
end;

procedure Tmasterform.Button1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  dimmermaster.position:=0;
end;

procedure Tmasterform.Button2Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  flashmaster.position:=0;
end;

procedure Tmasterform.Button3Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  speedmaster.position:=256;
end;

procedure Tmasterform.VolumesliderChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Bass_SetVolume(1-volumeslider.position/100);
  mainform.SendMSG(MSG_SYSTEMVOLUME, 100-volumeslider.Position, 0);
end;

procedure Tmasterform.Button4Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  volumeslider.position:=0;
end;

procedure Tmasterform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tmasterform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tmasterform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tmasterform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

procedure Tmasterform.Button5Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  fogslider.position:=255;
end;

procedure Tmasterform.FogSliderChange(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.devices[i].hasFog then
    begin
      geraetesteuerung.set_channel(mainform.devices[i].ID, 'FOG', 255-fogslider.position, 255-fogslider.position, 0, 0);
    end;
  end;
end;

end.
