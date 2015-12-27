unit faderpanelfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, StdCtrls, ExtCtrls, GR32, gnugettext, Registry,
  Menus, ddfwindowfrm;

type
  Tfaderpanelform = class(TForm)
    ScrollBar1: TScrollBar;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    PopupMenu1: TPopupMenu;
    NurKanlemitGertenanzeigen1: TMenuItem;
    Rahmeneinaus1: TMenuItem;
    N1: TMenuItem;
    Paneluntenandocken1: TMenuItem;
    Breite1: TMenuItem;
    N8Fader1: TMenuItem;
    N16Fader1: TMenuItem;
    N24Fader1: TMenuItem;
    N32Fader1: TMenuItem;
    N4Fader1: TMenuItem;
    N2: TMenuItem;
    Panelautomatischausblenden1: TMenuItem;
    Kstchenimmervoll1: TMenuItem;
    Faderpanelschlieen1: TMenuItem;
    FaderpanelhideTimer: TTimer;
    Gertefensteranzeigen1: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NurKanlemitGertenanzeigen1Click(Sender: TObject);
    procedure Rahmeneinaus1Click(Sender: TObject);
    procedure Paneluntenandocken1Click(Sender: TObject);
    procedure N8Fader1Click(Sender: TObject);
    procedure N16Fader1Click(Sender: TObject);
    procedure N24Fader1Click(Sender: TObject);
    procedure N32Fader1Click(Sender: TObject);
    procedure N4Fader1Click(Sender: TObject);
    procedure Panelautomatischausblenden1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Faderpanelschlieen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Kstchenimmervoll1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FaderpanelhideTimerTimer(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Gertefensteranzeigen1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    _Buffer: TBitmap32;
    faderchannel:array of Word;
    oldvalues:array of byte;
    mousex,mousey,mouseoverfader,maxfaders:integer;
    abletomove:boolean;
    GedrehteSchrift:HGDIOBJ;
    dorefresh:boolean;
    faderpaneltimerbyte:byte;
    scrolltoright, scrolltoleft:boolean;
    lastmousex, lastmousey:integer;

    timer:byte;
  public
    { Public-Deklarationen }
    blendoutdevicelesschannel:boolean;
    faderselected,faderselectedalt,faderselectedshift:array of boolean;
    procedure SaveToRegistry;
  end;

var
  faderpanelform: Tfaderpanelform;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tfaderpanelform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  timer:=0;

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
  			LReg.WriteBool('Showing Faderpanel',true);

        if not LReg.KeyExists('Faderpanel') then
	        LReg.CreateKey('Faderpanel');
	      if LReg.OpenKey('Faderpanel',true) then
	      begin
          if LReg.ValueExists('Blendout Free Channels') then
            NurKanlemitGertenanzeigen1.Checked:=LReg.ReadBool('Blendout Free Channels');
          blendoutdevicelesschannel:=NurKanlemitGertenanzeigen1.Checked;

          if LReg.ValueExists('Autohide') then
          begin
            Panelautomatischausblenden1.Checked:=LReg.ReadBool('Autohide');
          end;
          if LReg.ValueExists('Show Rectangles Full') then
          begin
            Kstchenimmervoll1.Checked:=LReg.ReadBool('Show Rectangles Full');
          end;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+faderpanelform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              faderpanelform.Left:=LReg.ReadInteger('PosX')
            else
              faderpanelform.Left:=0;
          end else
            faderpanelform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+faderpanelform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              faderpanelform.Top:=LReg.ReadInteger('PosY')
            else
              faderpanelform.Top:=0;
          end else
            faderpanelform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

//  faderpanelform.Left:=0;
//  faderpanelform.Top:=mainform.Top+mainform.Height;
//  faderpanelform.Width:=screen.Width;
  maxfaders:=round(paintbox1.Width/40);
  setlength(faderchannel, maxfaders);
  setlength(oldvalues, maxfaders);
  setlength(faderselected, mainform.lastchan);
  setlength(faderselectedalt, mainform.lastchan);
  setlength(faderselectedshift, mainform.lastchan);
  faderpanelform.ScrollBar1.Max:=mainform.lastchan-maxfaders+1;
  timer1.enabled:=true;
  dorefresh:=true;
end;

procedure Tfaderpanelform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  timer1.enabled:=false;

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
					LReg.WriteBool('Showing Faderpanel',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('faderpanel');
end;

procedure Tfaderpanelform.Timer1Timer(Sender: TObject);
var
  i,j,k:integer;
  device_name,device_channame:string;
  device_color:TColor;
  nodevice:boolean;
  devicecounter:integer;
  devicetoggle:boolean;
  samedevice:boolean;

  device_value:byte;
  rectangleheight:byte;
  kanaltyp:string;
  R,G,B:byte;
  offset:integer;
  levelvalue:string;
  label Back;
begin
  if scrolltoleft and (Scrollbar1.Position>Scrollbar1.Min) then
    Scrollbar1.Position:=Scrollbar1.Position-1;
  if scrolltoright and (Scrollbar1.Position<Scrollbar1.Max) then
    Scrollbar1.Position:=Scrollbar1.Position+1;

  offset:=0;
  samedevice:=false;
  devicecounter:=-1;
  devicetoggle:=false;

  for i:=1 to maxfaders do
  begin
    if (oldvalues[i-1]<>(mainform.channel_value[scrollbar1.position+i-1+offset])) then
    begin
      dorefresh:=true;
      break;
    end;
  end;

  if dorefresh then
  begin
    dorefresh:=false;
    _Buffer.Canvas.Brush.Color := $00A6A6A6;
    _Buffer.Canvas.Pen.Style:=psClear;
    _Buffer.Canvas.FillRect(_Buffer.ClipRect);
    _Buffer.Canvas.Brush.Color := clblack;

    for i:=1 to maxfaders do
    begin
      oldvalues[i-1]:=mainform.channel_value[scrollbar1.position+i-1+offset];

      Back:

      // Kanaleigenschaften finden
      device_channame:='';
      device_name:='';
      kanaltyp:='';
      device_color:=clBlack;
      nodevice:=true;
      rectangleheight:=255;

      for j:=0 to length(mainform.devices)-1 do
      begin
        if ((scrollbar1.position+i-1+offset)>=mainform.devices[j].Startaddress) and ((scrollbar1.position+i-1+offset)<=(mainform.devices[j].Startaddress+mainform.devices[j].MaxChan-1)) then
        begin
          samedevice:=(devicecounter=j);
          if not samedevice then
          begin
            // neues Gerät
            devicecounter:=j;
            devicetoggle:=not devicetoggle;
          end;
        
          // Kanal liegt innerhalb des Geräts
          device_name:=mainform.Devices[j].Name;
          kanaltyp:=mainform.Devices[j].kanaltyp[((scrollbar1.position+i-1+offset)-mainform.devices[j].Startaddress)];
          device_channame:=mainform.Devices[j].kanalname[((scrollbar1.position+i-1+offset)-mainform.devices[j].Startaddress)];

          if (mainform.Devices[j].hasRGB) and (lowercase(kanaltyp)='r') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'r');
            device_color:=RGB2TColor(rectangleheight,0,0);
            r:=255;
            g:=0;
            b:=0;
          end else if (mainform.Devices[j].hasRGB) and (lowercase(kanaltyp)='g') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'g');
            device_color:=RGB2TColor(0,rectangleheight,0);
            r:=0;
            g:=255;
            b:=0;
          end else if (mainform.Devices[j].hasRGB) and (lowercase(kanaltyp)='b') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'b');
            device_color:=RGB2TColor(0,0,rectangleheight);
            r:=0;
            g:=0;
            b:=255;
          end else if (mainform.Devices[j].hasCMY) and (lowercase(kanaltyp)='c') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'c');
            device_color:=RGB2TColor(255-rectangleheight,255,255);
            r:=0;
            g:=255;
            b:=255;
          end else if (mainform.Devices[j].hasCMY) and (lowercase(kanaltyp)='m') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'m');
            device_color:=RGB2TColor(255,255-rectangleheight,255);
            r:=255;
            g:=0;
            b:=255;
          end else if (mainform.Devices[j].hasCMY) and (lowercase(kanaltyp)='y') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'y');
            device_color:=RGB2TColor(255,255,255-rectangleheight);
            r:=255;
            g:=255;
            b:=0;
          end else if (mainform.Devices[j].hasRGB) and (mainform.devices[j].hasAmber) and (lowercase(kanaltyp)='a') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'a');
            device_color:=RGB2TColor(round(mainform.Devices[j].AmberRatioR*rectangleheight/255),round(mainform.Devices[j].AmberRatioG*rectangleheight/255),0);
            r:=mainform.Devices[j].AmberRatioR;
            g:=mainform.Devices[j].AmberRatioG;
            b:=0;
          end else if (not mainform.Devices[j].hasRGB) and (mainform.devices[j].hasAmber) and (lowercase(kanaltyp)='a') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'a');
            device_color:=RGB2TColor(round(mainform.Devices[j].AmberRatioR*rectangleheight/255),round(mainform.Devices[j].AmberRatioG*rectangleheight/255),0);
            r:=255;
            g:=191;
            b:=0;
          end else if (mainform.devices[j].hasWhite) and (lowercase(kanaltyp)='w') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'w');
            device_color:=RGB2TColor(rectangleheight,rectangleheight,rectangleheight);
            r:=255;
            g:=255;
            b:=255;
          end else if (mainform.devices[j].hasUV) and (lowercase(kanaltyp)='uv') then
          begin
            rectangleheight:=geraetesteuerung.get_channel(mainform.Devices[j].ID,'uv');
            device_color:=RGB2TColor(rectangleheight div 2,0,rectangleheight div 2);
            r:=128;
            g:=0;
            b:=128;
          end else if mainform.Devices[j].hasColor and (lowercase(kanaltyp)='color1') then
          begin
            rectangleheight:=255;
            for k:=0 to length(mainform.devices[j].colorlevels)-1 do
            begin
              if (mainform.devices[j].colorlevels[k]<=geraetesteuerung.get_channel(mainform.devices[j].ID, 'color1')) and
                (mainform.devices[j].colorendlevels[k]>=geraetesteuerung.get_channel(mainform.devices[j].ID, 'color1')) then
              begin
                device_color:=mainform.devices[j].colors[k];
                TColor2RGB(device_color, r,g,b);
                break;
              end;
            end;
          end else if mainform.Devices[j].hasColor and (lowercase(kanaltyp)='color2') then
          begin
            rectangleheight:=255;
            for k:=0 to length(mainform.devices[j].colorlevels2)-1 do
            begin
              if (mainform.devices[j].colorlevels2[k]<=geraetesteuerung.get_channel(mainform.devices[j].ID, 'color2')) and
                (mainform.devices[j].colorendlevels2[k]>=geraetesteuerung.get_channel(mainform.devices[j].ID, 'color2')) then
              begin
                device_color:=mainform.devices[j].colors2[k];
                TColor2RGB(device_color, r,g,b);
                break;
              end;
            end;
          end else if mainform.Devices[j].hasDimmer and (lowercase(kanaltyp)='dimmer') then
          begin
            TColor2RGB(mainform.Devices[j].color,r,g,b);
            device_value:=geraetesteuerung.get_channel(mainform.devices[j].ID,'dimmer');
            rectangleheight:=device_value;
            device_color:=RGB2TColor(round(r*device_value/255),round(g*device_value/255),round(b*device_value/255));
          end else
          begin
            rectangleheight:=mainform.channel_value[(scrollbar1.position+i-1+offset)];
            device_color:=RGB2TColor(mainform.channel_value[(scrollbar1.position+i-1+offset)],mainform.channel_value[(scrollbar1.position+i-1+offset)],mainform.channel_value[(scrollbar1.position+i-1+offset)]);
            TColor2RGB($00A6A6A6, r,g,b);
          end;

          nodevice:=false;
          break;
        end;
      end;
      if nodevice then
      begin
        if blendoutdevicelesschannel and ((scrollbar1.position+i-1+offset)<(scrollbar1.Max+maxfaders)) then
        begin
          offset:=offset+1;
          goto Back;
        end else
        begin
          TColor2RGB(clYellow,r,g,b);
          rectangleheight:=mainform.channel_value[(scrollbar1.position+i-1)];
          device_color:=RGB2TColor(round(r*(mainform.channel_value[(scrollbar1.position+i-1)]/255)),round(g*(mainform.channel_value[(scrollbar1.position+i-1)]/255)),round(b*(mainform.channel_value[(scrollbar1.position+i-1)]/255)));
        end;
      end;

      if (scrollbar1.position+i-1+offset)>mainform.lastchan then
      begin
        _Buffer.Canvas.Brush.Color:=clBtnFace;
        _Buffer.Canvas.Rectangle(40*(i-1)+5,24,40*i+5,45);
      end else
      begin
        if Kstchenimmervoll1.Checked then
          rectangleheight:=255;
        _Buffer.Canvas.Brush.Color:=device_color;
        _Buffer.Canvas.Rectangle(40*(i-1)+5,round(45-21*(rectangleheight/255)),40*i+5,45);

        // Linie zeichnen
        _Buffer.Canvas.Pen.Color:=RGB2TColor(r,g,b);
        _Buffer.Canvas.Pen.Style:=psSolid;
        _Buffer.Canvas.MoveTo(40*(i-1)+5, 44);
        _Buffer.Canvas.LineTo(40*i+4, 44);
        _Buffer.Canvas.MoveTo(40*(i-1)+5, 45);
        _Buffer.Canvas.LineTo(40*i+4, 45);
      end;

      // Schrift einstellen
      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Size:=8;

      // Kanalwert zeichnen
      TColor2RGB(device_color,r,g,b);
      _Buffer.Canvas.Font.Style:=[fsBold];
      if (g<127) and (r<225) and (rectangleheight>100) then
        _Buffer.Canvas.Font.Color:=clWhite
      else
        _Buffer.Canvas.Font.Color:=clBlack;
      levelvalue:=mainform.levelstr(mainform.channel_value[(scrollbar1.position+i-1+offset)]);

      _Buffer.Canvas.Brush.Style:=bsClear;
      if length(levelvalue)<2 then
        _Buffer.Canvas.TextOut(40*(i-1)+5+17, 27, levelvalue)
      else if length(levelvalue)<3 then
        _Buffer.Canvas.TextOut(40*(i-1)+5+14, 27, levelvalue)
      else if length(levelvalue)<4 then
        _Buffer.Canvas.TextOut(40*(i-1)+5+11, 27, levelvalue)
      else if length(levelvalue)<5 then
        _Buffer.Canvas.TextOut(40*(i-1)+5+8, 27, levelvalue)
      else if length(levelvalue)<6 then
        _Buffer.Canvas.TextOut(40*(i-1)+5+5, 27, levelvalue)
      else
        _Buffer.Canvas.TextOut(40*(i-1)+5+2, 27, levelvalue);
      _Buffer.Canvas.Brush.Style:=bsSolid;
      _Buffer.Canvas.Font.Color:=clBlack;
      _Buffer.CAnvas.Font.Style:=[];
      _Buffer.Canvas.Font.Size:=7;
      _Buffer.Canvas.Brush.Color:=$00A6A6A6;
      _Buffer.Canvas.Pen.Style:=psClear;

      if (scrollbar1.position+i-1+offset)>mainform.lastchan then
      begin
        _Buffer.Canvas.TextOut(40*(i-1)+5, 0, _('n/a'));
        _Buffer.Canvas.TextOut(40*(i-1)+5, 10, '');
        if faderpanelform.ClientWidth>100 then
          _Buffer.Canvas.Draw(40*(i-1)+8,54,image2.Picture.Graphic);
      end else
      begin
        if faderpanelform.ClientWidth>100 then
        begin
          _Buffer.Canvas.Draw(40*(i-1)+8,54,image1.Picture.Graphic);
          _Buffer.Canvas.Draw(40*(i-1)+8+9,54+round((187-25)*((255-mainform.channel_value[(scrollbar1.position+i-1+offset)])/255)),image3.Picture.Graphic);
        end;
      
        // Kanalnummer zeichnen
        _Buffer.Canvas.Brush.Style:=bsClear;
        if faderselected[scrollbar1.position+i-1+offset-1] then
        begin
          _Buffer.Canvas.Font.Color:=clRed;
        end else
        begin
          _Buffer.Canvas.Font.Color:=clBlack;
        end;

        _Buffer.Canvas.TextOut(40*(i-1)+5, 0, 'Ch '+inttostr(scrollbar1.position+i-1+offset));


        // Gerätenamen zeichnen
        if faderselectedalt[scrollbar1.position+i-1+offset-1] then
        begin
          _Buffer.Canvas.Font.Color:=clGreen;
        end else
        begin
          _Buffer.Canvas.Font.Color:=clBlack;
        end;

        if (not samedevice) and (not nodevice) then
        begin
          _Buffer.Canvas.Brush.Style:=bsSolid;
          if devicetoggle then
            _Buffer.Canvas.Brush.Color:=$00FFBFBF
          else
            _Buffer.Canvas.Brush.Color:=$00FFFFFF;
          _Buffer.Canvas.Rectangle(40*(i-1)+5, 10, 40*(i+mainform.Devices[devicecounter].MaxChan-1)+5, 23);
          _Buffer.Canvas.Brush.Style:=bsClear;
          _Buffer.Canvas.TextOut(40*(i-1)+5, 10, device_name);
        end else if nodevice then
        begin
          _Buffer.Canvas.Brush.Style:=bsSolid;
          _Buffer.Canvas.Brush.Color:=$00A6A6A6;
          _Buffer.Canvas.Rectangle(40*(i-1)+5, 10, 40*i+5, 23);
          _Buffer.Canvas.TextOut(40*(i-1)+5, 10, device_name);
        end;

        // Kanalnamen zeichnen
        // Text um 90° gedreht anzeigen
        if faderpanelform.ClientHeight>100 then
        begin
          if faderselectedshift[scrollbar1.position+i-1+offset-1] then
          begin
            _Buffer.Canvas.Font.Color:=clBlue;
          end else
          begin
            _Buffer.Canvas.Font.Color:=$00303030;
          end;
          SelectObject(_Buffer.Canvas.Handle, GedrehteSchrift);
          _Buffer.Canvas.TextOut(40*(i-1), _Buffer.Height-5, device_channame); // Beschreibung
        end;
      
        faderchannel[i-1]:=(scrollbar1.position+i-1+offset);
      end;
    end;

    _Buffer.Canvas.Pen.Style:=psSolid;

    // Topline zeichnen
    _Buffer.Canvas.Pen.Color:=clBlack;
    _Buffer.Canvas.MoveTo(0, 0);
    _Buffer.Canvas.LineTo(_Buffer.Width, 0);

    // "X" zeichnen
    _Buffer.Canvas.MoveTo(_Buffer.Width-8, 0);
    _Buffer.Canvas.LineTo(_Buffer.Width, 8);
    _Buffer.Canvas.MoveTo(_Buffer.Width, 0);
    _Buffer.Canvas.LineTo(_Buffer.Width-8, 8);

    // "O" zeichnen
    //  _Buffer.Canvas.MoveTo(_Buffer.Width-8, 0);
    //  _Buffer.Canvas.Ellipse(_Buffer.Width-16, 0,_Buffer.Width-8, 8);

    BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
  end;
end;

procedure Tfaderpanelform.CreateParams(var Params:TCreateParams);
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

procedure Tfaderpanelform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  GedrehteSchrift:=CreateFont(10, 4, 900, 0, fw_normal, 0, 0, 0, 1, 0, $10, 2, 4, PChar('Arial'));
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Tfaderpanelform.FormResize(Sender: TObject);
begin
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
  maxfaders:=round(paintbox1.Width/40);
  setlength(faderchannel, maxfaders);
  setlength(oldvalues, maxfaders);
  setlength(faderselected, mainform.lastchan);
  setlength(faderselectedalt, mainform.lastchan);
  setlength(faderselectedshift, mainform.lastchan);
  faderpanelform.ScrollBar1.Max:=mainform.lastchan-maxfaders+1;
  dorefresh:=true;
end;

procedure Tfaderpanelform.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  mousex:=x;
  mousey:=y;
  mouseoverfader:=trunc((x/(maxfaders*40))*maxfaders);

  abletomove:=(y<=24);
end;

procedure Tfaderpanelform.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  value,i,fadergroup:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  lastmousex:=x;
  lastmousey:=y;

  faderpanelform.ClientHeight:=260;
  faderpaneltimerbyte:=0;
  FaderpanelhideTimer.Enabled:=true;

  if (Shift=[ssLeft]) then
  begin
    if (y>50) then
    begin
      // Fader bewegen
      value:=y+11-74;
      if value<0 then value:=0;
      if value>167 then value:=167;
      value:=round(value/167*255);
      // mainform.SendData(scrollbar1.position+mouseoverfader,-1,value,0,0);
      mainform.SendData(faderchannel[mouseoverfader],-1,value,0,0);

      fadergroup:=0;
      for i:=0 to length(faderselected)-1 do
      begin
        if faderselected[i] and (i=(faderchannel[mouseoverfader]-1)) then fadergroup:=1;
        if faderselectedalt[i] and (i=(faderchannel[mouseoverfader]-1)) then fadergroup:=fadergroup+2;
        if faderselectedshift[i] and (i=(faderchannel[mouseoverfader]-1)) then fadergroup:=fadergroup+4;
      end;

      for i:=0 to length(faderselected)-1 do
      begin
        if faderselected[i] and (fadergroup and 1 = 1) then
          mainform.SendData(i+1,-1,value,0,0);

        if faderselectedalt[i] and (fadergroup and 2 = 2) then
          mainform.SendData(i+1,-1,value,0,0);

        if faderselectedshift[i] and (fadergroup and 4 = 4) then
          mainform.SendData(i+1,-1,value,0,0);
      end;
    end else if (y<=24) and abletomove then
    begin
      // Fenster verschieben
      faderpanelform.Align:=alNone;
      ReleaseCapture;
      faderpanelform.Perform(WM_SYSCOMMAND, $F012, 0);
    end;
  end else
  begin
    if (Shift=[ssShift]) then
    begin
      if (X>0) and (X<40) then
      begin
        // linker Rand
        scrolltoright:=false;
        scrolltoleft:=true;
      end else if (X>(Paintbox1.Width-40)) and (X<Paintbox1.Width) then
      begin
        // rechter Rand
        scrolltoright:=true;
        scrolltoleft:=false;
      end else
      begin
        scrolltoright:=false;
        scrolltoleft:=false;
      end;
    end else
    begin
      scrolltoright:=false;
      scrolltoleft:=false;
    end;
  end;

  dorefresh:=true;
end;

procedure Tfaderpanelform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, ddfwindowposition, j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if Shift=[ssCtrl] then faderselected[faderchannel[mouseoverfader]-1]:=not faderselected[faderchannel[mouseoverfader]-1];
  if Shift=[ssAlt] then faderselectedalt[faderchannel[mouseoverfader]-1]:=not faderselectedalt[faderchannel[mouseoverfader]-1];
  if Shift=[ssShift] then faderselectedshift[faderchannel[mouseoverfader]-1]:=not faderselectedshift[faderchannel[mouseoverfader]-1];
  if (x>=(paintbox1.Width-8)) and (y<=8) then close;

  // Gerätefenster öffnen
  if Shift=[ssAlt, ssCtrl] then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if (faderchannel[mouseoverfader]>=mainform.devices[i].Startaddress) and (faderchannel[mouseoverfader]<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
      begin
        ddfwindowposition:=-1;

        for j:=0 to length(ddfwindows)-1 do
        begin
          if IsEqualGUID(ddfwindows[j].thisddfwindowDeviceID,mainform.Devices[i].ID) then
            ddfwindowposition:=j;
        end;

        if ddfwindowposition=-1 then
        for j:=0 to length(ddfwindows)-1 do
        begin
          if ddfwindows[j].readyfordelete then
            ddfwindowposition:=j;
        end;

        if ddfwindowposition=-1 then
        begin
          setlength(ddfwindows,length(ddfwindows)+1);
          ddfwindows[length(ddfwindows)-1]:=TDDFWindow.Create(self);
          ddfwindowposition:=length(ddfwindows)-1;
        end;
        ddfwindows[ddfwindowposition].readyfordelete:=false;
        ddfwindows[ddfwindowposition].thisddfwindowDeviceID:=mainform.Devices[i].ID;
        ddfwindows[ddfwindowposition].Top:=faderpanelform.Top+paintbox1.Top+y+(faderpanelform.height-faderpanelform.ClientHeight)-ddfwindows[ddfwindowposition].Height;
        ddfwindows[ddfwindowposition].Left:=faderpanelform.Left+paintbox1.Left+x+(faderpanelform.Width-faderpanelform.ClientWidth);
        ddfwindows[ddfwindowposition].loadDDF(mainform.Devices[i].ID);
      end;
    end;
  end;
end;

procedure Tfaderpanelform.NurKanlemitGertenanzeigen1Click(Sender: TObject);
begin
  blendoutdevicelesschannel:=NurKanlemitGertenanzeigen1.Checked;
  SaveToRegistry;
end;

procedure Tfaderpanelform.Rahmeneinaus1Click(Sender: TObject);
begin
  if faderpanelform.BorderStyle=bsNone then
  begin
    faderpanelform.BorderStyle:=bsSizeToolWin;
  end else
  begin
    faderpanelform.BorderStyle:=bsNone;
  end;
end;

procedure Tfaderpanelform.Paneluntenandocken1Click(Sender: TObject);
begin
  if faderpanelform.Align=alNone then
  begin
//    faderpanelform.BorderStyle:=bsNone;
    faderpanelform.Align:=alBottom;
  end else
  begin
    faderpanelform.Align:=alNone;
//    faderpanelform.BorderStyle:=bsSizeToolWin;
  end;
end;

procedure Tfaderpanelform.N4Fader1Click(Sender: TObject);
begin
  faderpanelform.Align:=alNone;
  faderpanelform.Width:=41*4;
end;

procedure Tfaderpanelform.N8Fader1Click(Sender: TObject);
begin
  faderpanelform.Align:=alNone;
  faderpanelform.Width:=41*8;
end;

procedure Tfaderpanelform.N16Fader1Click(Sender: TObject);
begin
  faderpanelform.Align:=alNone;
  faderpanelform.Width:=41*16;
end;

procedure Tfaderpanelform.N24Fader1Click(Sender: TObject);
begin
  faderpanelform.Align:=alNone;
  faderpanelform.Width:=40*24;
end;

procedure Tfaderpanelform.N32Fader1Click(Sender: TObject);
begin
  faderpanelform.Align:=alNone;
  faderpanelform.Width:=40*32;
end;

procedure Tfaderpanelform.Panelautomatischausblenden1Click(
  Sender: TObject);
begin
  SaveToRegistry;
end;

procedure Tfaderpanelform.ScrollBar1Change(Sender: TObject);
begin
  timer:=0;
  dorefresh:=true;
end;

procedure Tfaderpanelform.Faderpanelschlieen1Click(Sender: TObject);
begin
  close;
end;

procedure Tfaderpanelform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  timer1.enabled:=false;
end;

procedure Tfaderpanelform.SaveToRegistry;
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
        if not LReg.KeyExists('Faderpanel') then
	        LReg.CreateKey('Faderpanel');
	      if LReg.OpenKey('Faderpanel',true) then
	      begin
          LReg.WriteBool('Blendout Free Channels',NurKanlemitGertenanzeigen1.Checked);
          LReg.WriteBool('Autohide',Panelautomatischausblenden1.Checked);
          LReg.WriteBool('Show Rectangles Full',Kstchenimmervoll1.Checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tfaderpanelform.Kstchenimmervoll1Click(Sender: TObject);
begin
  SaveToRegistry;
end;

procedure Tfaderpanelform.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=true;//(NewHeight=faderpanelform.Height);
end;

procedure Tfaderpanelform.FaderpanelhideTimerTimer(Sender: TObject);
begin
  FaderpanelhideTimer.Enabled:=(Panelautomatischausblenden1.Checked) and (not scrolltoleft) and (not scrolltoright);

  if faderpaneltimerbyte>=4 then
  begin
    FaderpanelhideTimer.Enabled:=false;
    faderpanelform.ClientHeight:=64;
    faderpaneltimerbyte:=0;
  end;

  faderpaneltimerbyte:=faderpaneltimerbyte+1;
end;

procedure Tfaderpanelform.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
{
  if (mouseoverfader<length(faderchannel)) then
  begin
    if mainform.channel_value[faderchannel[mouseoverfader]]<=250 then
      mainform.SendData(faderchannel[mouseoverfader],-1,mainform.channel_value[faderchannel[mouseoverfader]]+5,0,0)
    else
      mainform.SendData(faderchannel[mouseoverfader],-1,255,0,0);
  end;
}
end;

procedure Tfaderpanelform.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
{
  if (mouseoverfader<length(faderchannel)) then
  begin
    if mainform.channel_value[faderchannel[mouseoverfader]]>=5 then
      mainform.SendData(faderchannel[mouseoverfader],-1,mainform.channel_value[faderchannel[mouseoverfader]]-5,0,0)
    else
      mainform.SendData(faderchannel[mouseoverfader],-1,0,0,0);
  end;
}
end;

procedure Tfaderpanelform.PaintBox1Paint(Sender: TObject);
begin
  dorefresh:=true;
end;

procedure Tfaderpanelform.Gertefensteranzeigen1Click(Sender: TObject);
var
  i,j,ddfwindowposition:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if (faderchannel[mouseoverfader]>=mainform.devices[i].Startaddress) and (faderchannel[mouseoverfader]<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
    begin
      ddfwindowposition:=-1;

      for j:=0 to length(ddfwindows)-1 do
      begin
        if IsEqualGUID(ddfwindows[j].thisddfwindowDeviceID,mainform.Devices[i].ID) then
          ddfwindowposition:=j;
      end;

      if ddfwindowposition=-1 then
      for j:=0 to length(ddfwindows)-1 do
      begin
        if ddfwindows[j].readyfordelete then
          ddfwindowposition:=j;
      end;

      if ddfwindowposition=-1 then
      begin
        setlength(ddfwindows,length(ddfwindows)+1);
        ddfwindows[length(ddfwindows)-1]:=TDDFWindow.Create(self);
        ddfwindowposition:=length(ddfwindows)-1;
      end;
      ddfwindows[ddfwindowposition].readyfordelete:=false;
      ddfwindows[ddfwindowposition].thisddfwindowDeviceID:=mainform.Devices[i].ID;
      ddfwindows[ddfwindowposition].Top:=faderpanelform.Top+paintbox1.Top+lastmousey+(faderpanelform.height-faderpanelform.ClientHeight)-ddfwindows[ddfwindowposition].Height;
      ddfwindows[ddfwindowposition].Left:=faderpanelform.Left+paintbox1.Left+lastmousex+(faderpanelform.Width-faderpanelform.ClientWidth);
      ddfwindows[ddfwindowposition].loadDDF(mainform.Devices[i].ID);
    end;
  end;
end;

end.
