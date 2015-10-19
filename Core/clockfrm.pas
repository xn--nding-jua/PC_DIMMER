unit clockfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, PLNClock, Registry, Menus, gnugettext, StdCtrls;

type
  Tclockform = class(TForm)
    clock: TPLNClock;
    PopupMenu1: TPopupMenu;
    ransparenteinaus1: TMenuItem;
    Rahmeneinaus1: TMenuItem;
    Sekundenflieendnormal1: TMenuItem;
    Uhrschlieen1: TMenuItem;
    N1: TMenuItem;
    Digitaluhreinaus1: TMenuItem;
    timelbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure clockMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Rahmeneinaus1Click(Sender: TObject);
    procedure ransparenteinaus1Click(Sender: TObject);
    procedure Sekundenflieendnormal1Click(Sender: TObject);
    procedure Uhrschlieen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure clockChangeSec(Sender: TObject; nHour, nMin, nSec: Integer);
    procedure FormResize(Sender: TObject);
    procedure Digitaluhreinaus1Click(Sender: TObject);
    procedure CHLed1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  clockform: Tclockform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tclockform.FormShow(Sender: TObject);
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
  			LReg.WriteBool('Showing Uhrzeitanzeige',true);

        if not LReg.KeyExists('Uhrzeitanzeige') then
	        LReg.CreateKey('Uhrzeitanzeige');
	      if LReg.OpenKey('Uhrzeitanzeige',true) then
	      begin
            if LReg.ValueExists('Clock SecJump') then
              clock.SecJump:=LReg.ReadBool('Clock SecJump');

            if LReg.ValueExists('Show Digital') then
              timelbl.visible:=LReg.ReadBool('Show Digital');

            if LReg.ValueExists('Width') then
              clockform.ClientWidth:=LReg.ReadInteger('Width')
            else
              clockform.ClientWidth:=340;
            if LReg.ValueExists('Height') then
              clockform.ClientHeight:=LReg.ReadInteger('Height')
            else
              clockform.ClientHeight:=350;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+clockform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              clockform.Left:=LReg.ReadInteger('PosX')
            else
              clockform.Left:=0;
          end else
            clockform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+clockform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              clockform.Top:=LReg.ReadInteger('PosY')
            else
              clockform.Top:=0;
          end else
            clockform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  FormResize(Sender);
end;

procedure Tclockform.FormHide(Sender: TObject);
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
					LReg.WriteBool('Showing Uhrzeitanzeige',false);
					LReg.WriteBool('Clock SecJump',clock.SecJump);
					LReg.WriteBool('Show Digital',timelbl.visible);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('uhrzeitanzeige');
end;

procedure Tclockform.clockMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft,ssShift]) then
  begin
    clock.SecJump:=not clock.SecJump;
  end;
  
  if (Shift=[ssCtrl,ssLeft]) then
  begin
    if clockform.BorderStyle=bsNone then
    begin
      mainform.SaveWindowPositions('uhrzeitanzeige');
      clockform.BorderStyle:=bsSizeable;
    end else
    begin
      mainform.SaveWindowPositions('uhrzeitanzeige');
      clockform.BorderStyle:=bsNone;
    end;
  end;

  if (Shift=[ssAlt,ssLeft]) then
  begin
    clockform.TransparentColor:=not clockform.TransparentColor;
    if clockform.TransparentColor then
    begin
      clockform.Color:=clFuchsia;
      clockform.clock.Color:=clFuchsia;
    end else
    begin
      clockform.Color:=clBtnFace;
      clockform.clock.Color:=clBtnFace;
    end;
  end;

  if Shift=[ssLeft] then
  begin
    ReleaseCapture;
    clockform.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure Tclockform.Rahmeneinaus1Click(Sender: TObject);
begin
  if clockform.BorderStyle=bsNone then
  begin
    mainform.SaveWindowPositions('uhrzeitanzeige');
    clockform.BorderStyle:=bsSizeable;
  end else
  begin
    mainform.SaveWindowPositions('uhrzeitanzeige');
    clockform.BorderStyle:=bsNone;
  end;
end;

procedure Tclockform.ransparenteinaus1Click(Sender: TObject);
begin
  clockform.TransparentColor:=not clockform.TransparentColor;
  if clockform.TransparentColor then
  begin
    clockform.Color:=clFuchsia;
    clockform.clock.Color:=clFuchsia;
  end else
  begin
    clockform.Color:=clBtnFace;
    clockform.clock.Color:=clBtnFace;
  end;
end;

procedure Tclockform.Sekundenflieendnormal1Click(Sender: TObject);
begin
  clock.SecJump:=not clock.SecJump;
end;

procedure Tclockform.Uhrschlieen1Click(Sender: TObject);
begin
  close;
end;

procedure Tclockform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tclockform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tclockform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;


procedure Tclockform.CreateParams(var Params:TCreateParams);
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

procedure Tclockform.clockChangeSec(Sender: TObject; nHour, nMin,
  nSec: Integer);
begin
  timelbl.caption:=timetostr(now);
end;

procedure Tclockform.FormResize(Sender: TObject);
begin
  clockform.ClientWidth:=clockform.ClientHeight;

  timelbl.height:=round((clockform.ClientHeight/347)*62);
  timelbl.width:=round((clockform.ClientWidth/340)*208);

  timelbl.font.size:=round((clockform.clientwidth/340)*40);

  timelbl.Left:=(clockform.ClientWidth div 2) - (timelbl.Width div 2);
  timelbl.Top:=(clockform.ClientHeight div 2) + 46;
end;

procedure Tclockform.Digitaluhreinaus1Click(Sender: TObject);
begin
  timelbl.Visible:=not timelbl.visible;
end;

procedure Tclockform.CHLed1Click(Sender: TObject);
begin
  timelbl.Visible:=not timelbl.visible;
end;

end.
