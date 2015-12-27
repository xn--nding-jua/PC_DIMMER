unit kanaluebersichtfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GR32, ComCtrls, StdCtrls, Registry,
  Menus, ddfwindowfrm, gnugettext;

const
  {$I GlobaleKonstanten.inc} // maximale Kanalzahl für PC_DIMMER !Vorsicht! Bei Ändern des Wertes müssen einzelne Plugins und Forms ebenfalls verändert werden, da dort auch chan gesetzt wird! Auch die GUI muss angepasst werden

type
  Tkanaluebersichtform = class(TForm)
    PaintBox: TPaintBox;
    TrackBar1: TTrackBar;
    ScrollBar1: TScrollBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    WidthTrackbar: TTrackBar;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    Info1: TMenuItem;
    Label6: TLabel;
    Label7: TLabel;
    N1: TMenuItem;
    MinWertndern1: TMenuItem;
    MaxWertndern1: TMenuItem;
    DDFanzeigen1: TMenuItem;
    N2: TMenuItem;
    Kanalselektioneinaus1: TMenuItem;
    RefreshTimer: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure TrackBar1Change(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ScrollBar1Enter(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure PaintBoxDblClick(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WidthTrackbarChange(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure TrackBar1Enter(Sender: TObject);
    procedure TrackBar1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure MinWertndern1Click(Sender: TObject);
    procedure MaxWertndern1Click(Sender: TObject);
    procedure DDFanzeigen1Click(Sender: TObject);
    procedure Kanalselektioneinaus1Click(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

    _Buffer: TBitmap32;
    oldvalues:array[1..8192] of byte;
    dorefresh:boolean;
    ChannelWidth,ChannelHeight:integer;
    ErsteZeile:integer;
    AktuellerKanal:integer;
    SelektierteKanaele:array[1..chan] of boolean;
    MouseOverKanal:integer;

    ChannelValueOnClick:integer;
    lastposition:integer;
    TrackBarSelected:boolean;
    lastx,lasty:integer;
    mousey,scrollbarpositiononmousedown:integer;
    procedure MSGSave;
  end;

var
  kanaluebersichtform: Tkanaluebersichtform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tkanaluebersichtform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
  i:integer;
  chanselected:boolean;
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
  			LReg.WriteBool('Showing Kanaluebersicht',true);

        if not LReg.KeyExists('Kanaluebersicht') then
	        LReg.CreateKey('Kanaluebersicht');
	      if LReg.OpenKey('Kanaluebersicht',true) then
	      begin
          if LReg.ValueExists('Width') then
            kanaluebersichtform.ClientWidth:=LReg.ReadInteger('Width')
            else
              kanaluebersichtform.ClientWidth:=600;
          if LReg.ValueExists('Heigth') then
            kanaluebersichtform.ClientHeight:=LReg.ReadInteger('Heigth')
            else
              kanaluebersichtform.ClientHeight:=370;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+kanaluebersichtform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              kanaluebersichtform.Left:=LReg.ReadInteger('PosX')
            else
              kanaluebersichtform.Left:=0;
          end else
            kanaluebersichtform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+kanaluebersichtform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              kanaluebersichtform.Top:=LReg.ReadInteger('PosY')
            else
              kanaluebersichtform.Top:=0;
          end else
            kanaluebersichtform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Scrollbar1.Min:=0;
  if (mainform.lastchan div (paintbox.Width div ChannelWidth))-1>0 then
    Scrollbar1.Max:=(mainform.lastchan div (paintbox.Width div ChannelWidth))-1;
  RefreshTimer.Enabled:=true;

  Label1.caption:='';
  Label2.caption:='';
  Label3.caption:='';
  Label4.caption:='';
  Label6.caption:='';
  Label7.caption:='';

  chanselected:=false;
  for i:=1 to chan do
  begin
    if SelektierteKanaele[i] then
    begin
      chanselected:=true;
      break;
    end;
  end;
  if not chanselected then
    SelektierteKanaele[1]:=true;

  dorefresh:=true;
end;

procedure Tkanaluebersichtform.FormHide(Sender: TObject);
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
					LReg.WriteBool('Showing Kanaluebersicht',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;

  RefreshTimer.Enabled:=false;
  mainform.SaveWindowPositions('kanaluebersicht');
end;

procedure Tkanaluebersichtform.RefreshTimerTimer(Sender: TObject);
var
  i,x1,x2,y1,y2,channel,row,col,maxchan,channelperrow:integer;
  temptext:string;
  AddPoints:boolean;
begin
  for i:=1 to mainform.lastchan do
  if (oldvalues[i]<>(mainform.channel_value[i])) then
  begin
    dorefresh:=true;
    break;
  end;
  if not dorefresh then exit;

  Move(mainform.channel_value, oldvalues, sizeof(mainform.channel_value));
  dorefresh:=false;

  _Buffer.Canvas.Brush.Color := clGray;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);

  row:=0;
  col:=-1;
  channelperrow:=paintbox.Width div ChannelWidth;

  maxchan:=(ErsteZeile*(paintbox.Width div ChannelWidth))+(paintbox.Width div ChannelWidth)*(paintbox.Height div ChannelHeight);
  if maxchan>mainform.lastchan then
    maxchan:=mainform.lastchan;

  for channel:=(ErsteZeile*(paintbox.Width div ChannelWidth))+1 to maxchan do
  begin
    col:=col+1;

    if (ChannelWidth*col+ChannelWidth)>_Buffer.Width then
    begin
      row:=row+1;
      col:=0;
    end;

    // Kanalfenster
    x1:=ChannelWidth*col;
    y1:=ChannelHeight*row;
    x2:=x1+ChannelWidth+1;
    y2:=y1+ChannelHeight+1;

    _Buffer.FrameRectS(x1,y1,x2,y2,clBlack32); // Schwarzen Rahmen zeichnen
    _Buffer.FillRect(x1+1,y1+1,x2-1,y2-1,$FF919191);  // $00919191

    if (mainform.channel_minvalue[channel]>0) or (mainform.channel_maxvalue[channel]<maxres) then // Gelben Rahmen zeichnen
      _Buffer.FrameRectS(x1+1,y1+1,x2-1,y2-1,clYellow32);
    if channel=AktuellerKanal then // Roten Rahmen zeichnen
      _Buffer.FrameRectS(x1+1,y1+1,x2-1,y2-1,clRed32);
    if SelektierteKanaele[channel] then // Orangene Balken zeichnen
      _Buffer.FillRect(x1+2,y2-6,x2-2,y2-2,$00FF7F00);
    if channel=MouseOverKanal then // Blauen MouseOver Balken zeichnen
      _Buffer.FillRect(x1+2,y2-8,x2-2,y2-6,$000000FF);

    _Buffer.Font.Name:='Arial';
    _Buffer.Font.Size:=8;
    _Buffer.Font.Style:=[fsBold];
    _Buffer.Font.Color:=clWhite;

    _Buffer.Textout(x1+4,y1+3,inttostr(channel)); // Kanaladresse zeichnen
    _Buffer.FillRect(x1+30,y1+3,x1+33,y1+16,$FF6B6B6B); // Progressbaranzeige anzeigen
    _Buffer.FillRect(x1+30,trunc(y1+16-(13*mainform.channel_value[channel]/255)),x1+33,y1+16,clWhite32); // Progressbaranzeige anzeigen
    _Buffer.Textout(x1+35,y1+3,mainform.levelstr(mainform.channel_value[channel])); // Kanalwert zeichnen

    _Buffer.Font.Style:=[];

    for i:=0 to length(mainform.devices)-1 do
    begin
      if (channel>=mainform.devices[i].Startaddress) and (channel<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
      begin
        temptext:=mainform.devices[i].kanalname[channel-mainform.devices[i].Startaddress];
        AddPoints:=false;
        while (4+_Buffer.TextWidth(temptext)>ChannelWidth) do
        begin
          AddPoints:=true;
          temptext:=Copy(temptext,0,length(temptext)-1);
        end;
        if AddPoints then
        begin
          temptext:=Copy(temptext,0,length(temptext)-3);
          temptext:=temptext+'...';
        end;
        _Buffer.Textout(x1+4,y1+14,temptext); // Kanalnamen zeichnen

        if (channel=mainform.devices[i].Startaddress) and (channel=mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1) then // Kanal ist Startadresse eines Gerätes
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.FillRect(x1+4,y1+28,x2,y1+43,$00C6C6FF)
          else
            _Buffer.FillRect(x1+4,y1+28,x2-4,y1+43,$00D1D1D1);
          _Buffer.Font.Color:=clBlack;
//          _Buffer.Textout(x1+6,y1+29,mainform.devices[i].Name);
        end else if channel=mainform.devices[i].Startaddress then // Kanal ist Startadresse eines Gerätes
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.FillRect(x1+4,y1+28,x2,y1+43,$00C6C6FF)
          else
            _Buffer.FillRect(x1+4,y1+28,x2,y1+43,$00D1D1D1);
          _Buffer.Font.Color:=clBlack;
//          _Buffer.Textout(x1+6,y1+29,mainform.devices[i].Name);
        end else if channel=mainform.devices[i].Startaddress+mainform.devices[i].MaxChan-1 then // Kanal ist letzte Adresse eines Gerätes
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.FillRect(x1,y1+28,x2-4,y1+43,$00C6C6FF)
          else
            _Buffer.FillRect(x1,y1+28,x2-4,y1+43,$00D1D1D1);
        end else // Kanal ist Zwischen Start- und Endadresse eines Gerätes
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.FillRect(x1,y1+28,x2,y1+43,$00C6C6FF)
          else
            _Buffer.FillRect(x1,y1+28,x2,y1+43,$00D1D1D1);
        end;
      end;
    end;
  end;

  // Im Folgenden nur noch den Gerätenamen ausgeben (bei Mehrkanalgeräten über mehrere Felder)
  row:=0;
  col:=-1;
  for channel:=(ErsteZeile*(paintbox.Width div ChannelWidth))+1 to maxchan do
  begin
    col:=col+1;
    if (ChannelWidth*col+ChannelWidth)>_Buffer.Width then
    begin
      row:=row+1;
      col:=0;
    end;
    // Kanalfenster
    x1:=ChannelWidth*col;
    y1:=ChannelHeight*row;
//    x2:=x1+ChannelWidth+1;
//    y2:=y1+ChannelHeight+1;

    _Buffer.Font.Name:='Arial';
    _Buffer.Font.Size:=8;
    _Buffer.Font.Style:=[];
    _Buffer.Font.Color:=clBlack;

    for i:=0 to length(mainform.devices)-1 do
    begin
      if (channel=mainform.devices[i].Startaddress) then // Kanal ist Startadresse eines Gerätes
      begin
        temptext:=mainform.devices[i].Name;
        AddPoints:=false;
        while (6+_Buffer.TextWidth(temptext)>(mainform.devices[i].MaxChan*ChannelWidth)) or (x1+6+_Buffer.TextWidth(temptext)>channelperrow*ChannelWidth) do
        begin
          AddPoints:=true;
          temptext:=Copy(temptext,0,length(temptext)-1);
        end;
        if AddPoints then
        begin
          temptext:=Copy(temptext,0,length(temptext)-3);
          temptext:=temptext+'...';
        end;
        _Buffer.Textout(x1+6,y1+29,temptext);
      end;
    end;
  end;

  // und das ganze auch natürlich noch zeichnen
  BitBlt(PaintBox.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);

  // Uhrzeit und Datum rechts unten aktualisieren
  Label3.caption:=TimeToStr(now);
  Label4.caption:=DateToStr(now);
end;

procedure Tkanaluebersichtform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  ChannelWidth:=64;
  ChannelHeight:=51;
  AktuellerKanal:=1;
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox.Width;
  _Buffer.Height:= PaintBox.Height;
end;

procedure Tkanaluebersichtform.FormResize(Sender: TObject);
begin
  _Buffer.Width:= PaintBox.Width;
  _Buffer.Height:= PaintBox.Height;

  Scrollbar1.Min:=0;
  if (mainform.lastchan div (paintbox.Width div ChannelWidth))-1>0 then
    Scrollbar1.Max:=(mainform.lastchan div (paintbox.Width div ChannelWidth))-1;

  if (kanaluebersichtform.Width*kanaluebersichtform.Height)>480000 then
    RefreshTimer.Interval:=100 // >800x600
  else if (kanaluebersichtform.Width*kanaluebersichtform.Height)>307200 then
    RefreshTimer.Interval:=50 // >640x480
  else
    RefreshTimer.Interval:=25; // <640x480
  dorefresh:=true;
end;

procedure Tkanaluebersichtform.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewWidth<128 then
    Resize:=false;
  if NewHeight<128 then
    Resize:=false;
end;

procedure Tkanaluebersichtform.TrackBar1Change(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if (Sender=TrackBar1) and (TrackBarSelected) and (Trackbar1.Focused) then
    for i:=1 to mainform.lastchan do
      if SelektierteKanaele[i] then
        mainform.Senddata(i,Trackbar1.Position,Trackbar1.Position,0);
end;

procedure Tkanaluebersichtform.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  ErsteZeile:=Scrollbar1.position;
  dorefresh:=true;
end;

procedure Tkanaluebersichtform.ScrollBar1Enter(Sender: TObject);
begin
  Scrollbar1.Min:=0;
  if (mainform.lastchan div (paintbox.Width div ChannelWidth))-1>0 then
    Scrollbar1.Max:=(mainform.lastchan div (paintbox.Width div ChannelWidth))-1;
end;

procedure Tkanaluebersichtform.CreateParams(var Params:TCreateParams);
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

procedure Tkanaluebersichtform.MSGSave;
begin
//
end;

procedure Tkanaluebersichtform.PaintBoxDblClick(Sender: TObject);
var
  AlterWert,NeuerWert:integer;
begin
  AlterWert:=255-mainform.data.ch[AktuellerKanal];
  AlterWert:=round(AlterWert/255*100);
  NeuerWert:=StrToInt(InputBox(_('Kanalwert ändern'),_('Bitte geben Sie einen neuen Endwert an:'),inttostr(AlterWert)));
  if NeuerWert>100 then
    NeuerWert:=100;
  NeuerWert:=trunc(NeuerWert/100*255);
  mainform.Senddata(AktuellerKanal,255-mainform.channel_value[aktuellerkanal],255-neuerwert,1000);
end;

procedure Tkanaluebersichtform.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
  ddfwindowposition:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if Shift=[ssCtrl] then
  begin
    SelektierteKanaele[AktuellerKanal]:=not SelektierteKanaele[AktuellerKanal];
  end else if Shift=[ssShift] then
  begin
    for i:=1 to chan do
      SelektierteKanaele[i]:=false;
    if lastposition<AktuellerKanal then
    begin
      for i:=lastposition to AktuellerKanal do
        SelektierteKanaele[i]:=true;
    end else
    begin
      for i:=AktuellerKanal to lastposition do
        SelektierteKanaele[i]:=true;
    end;
  end else
  begin
    for i:=1 to chan do
      SelektierteKanaele[i]:=false;
    SelektierteKanaele[AktuellerKanal]:=true;
  end;

  if Shift=[ssAlt] then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if (AktuellerKanal>=mainform.devices[i].Startaddress) and (AktuellerKanal<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
      begin
        mainform.DeviceSelected[i]:=not mainform.DeviceSelected[i];
      end;
    end;
  end;

  if Shift=[ssAlt, ssCtrl] then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if (AktuellerKanal>=mainform.devices[i].Startaddress) and (AktuellerKanal<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
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
        ddfwindows[ddfwindowposition].Top:=kanaluebersichtform.Top+paintbox.Top+y+(kanaluebersichtform.height-kanaluebersichtform.ClientHeight);
        ddfwindows[ddfwindowposition].Left:=kanaluebersichtform.Left+paintbox.Left+x+(kanaluebersichtform.Width-kanaluebersichtform.ClientWidth);
        ddfwindows[ddfwindowposition].loadDDF(mainform.Devices[i].ID);
      end;
    end;
  end;

  Trackbar1.Position:=255-mainform.channel_value[AktuellerKanal];
  TrackBarSelected:=true;
  TrackBar1.SetFocus;
end;

procedure Tkanaluebersichtform.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if Shift=[ssCtrl] then
  begin
    Scrollbar1.Position:=Scrollbar1.Position-1;
    ErsteZeile:=Scrollbar1.position;
  end else if Shift=[] then
  begin
    if TrackBar1.Position-5<0 then
      TrackBar1.Position:=0
    else
      TrackBar1.Position:=TrackBar1.Position-5;
  end;
end;

procedure Tkanaluebersichtform.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if Shift=[ssCtrl] then
  begin
    Scrollbar1.Position:=Scrollbar1.Position+1;
    ErsteZeile:=Scrollbar1.position;
  end else if Shift=[] then
  begin
    if TrackBar1.Position+5>255 then
      TrackBar1.Position:=255
    else
      TrackBar1.Position:=TrackBar1.Position+5;
  end;
end;

procedure Tkanaluebersichtform.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i,row,col,channelperrow:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if (Shift=[ssLeft]) then
  begin
    ScrollBar1.Position:=round((mousey-y)/ChannelHeight+scrollbarpositiononmousedown);
    ErsteZeile:=Scrollbar1.position;
  end;

  lastx:=x;
  lasty:=y;

  if (Shift=[]) then
  begin
    col:=(x div ChannelWidth)+1;
    row:=(y div ChannelHeight)+ErsteZeile;
    channelperrow:=paintbox.Width div ChannelWidth;
    MouseOverKanal:=channelperrow*row+col;
  end;

  if (Shift=[ssLeft, ssCtrl, ssShift]) then
  begin
    if (MouseOverKanal>-1) and (MouseOverKanal<mainform.lastchan) then
      if ((ChannelValueOnClick+(mousey-y))>=0) and ((ChannelValueOnClick+(mousey-y))<=255) then
        mainform.channel_value[MouseOverKanal]:=ChannelValueOnClick+(mousey-y);
  end;
  
  Label1.Caption:='';
  Label2.Caption:='';
  Label6.Caption:=_('Min-Wert: ')+mainform.levelstr(mainform.channel_minvalue[MouseOverKanal]);
  Label7.Caption:=_('Max-Wert: ')+mainform.levelstr(mainform.channel_maxvalue[MouseOverKanal]);
  Label6.Alignment:=taRightJustify;
  Label7.Alignment:=taRightJustify;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if (MouseOverKanal>=mainform.devices[i].Startaddress) and (MouseOverKanal<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
    begin
      if length(Label1.Caption)>0 then
        Label1.Caption:=Label1.Caption+', '+mainform.devices[i].Name
      else
        Label1.Caption:=mainform.devices[i].Name;
      Label2.Caption:=mainform.devices[i].kanalname[MouseOverKanal-mainform.devices[i].Startaddress]+' | '+mainform.levelstr(mainform.channel_value[MouseOverKanal]);
    end;
  end;
  dorefresh:=true;
end;

procedure Tkanaluebersichtform.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  row,col,channelperrow:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  mousey:=y;
  scrollbarpositiononmousedown:=ScrollBar1.Position;

  TrackBarSelected:=false;
  lastposition:=AktuellerKanal;
  col:=(x div ChannelWidth)+1;
  row:=(y div ChannelHeight)+ErsteZeile;
  channelperrow:=paintbox.Width div ChannelWidth;
  AktuellerKanal:=channelperrow*row+col;

  ChannelValueOnClick:=mainform.channel_value[AktuellerKanal];
end;

procedure Tkanaluebersichtform.WidthTrackbarChange(Sender: TObject);
begin
  if WidthTrackbar.Position>0 then
    ChannelWidth:=WidthTrackbar.Position;
end;

procedure Tkanaluebersichtform.Info1Click(Sender: TObject);
begin
  ShowMessage(_('STRG+Klick'+#9#9+'Kanalauswahl ein/aus für Wertänderung per Mausrad/Slider'+#13#10+
  'Shift+Klick'+#9#9+'Kanalauswahl ab roter Markierung'+#13#10+
  'ALT+Klick'+#9#9+'Geräteauswahl'+#13#10+
  'STRG+Mausrad'+#9#9+'Kanalwertänderung'+#13#10+
  'STRG+ALT+Klick'+#9+'Gerätefenster'+#13#10+
  'STRG+SHIFT+Ziehen'+#9+'Kanalwert ändern'));
end;

procedure Tkanaluebersichtform.TrackBar1Enter(Sender: TObject);
begin
  TrackBarSelected:=true;
end;

procedure Tkanaluebersichtform.TrackBar1Exit(Sender: TObject);
begin
  TrackBarSelected:=false;
end;

procedure Tkanaluebersichtform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tkanaluebersichtform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tkanaluebersichtform.MinWertndern1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  mainform.channel_minvalue[MouseOverKanal]:=round(strtoint(InputBox(_('Minimum des Kanalwertes'),_('Bitte geben Sie den Minimumwert dieses Kanals an (Geräteunabhängig!) (0..100):'),inttostr(round(mainform.channel_minvalue[MouseOverKanal]/255*100))))/100*255);

//  if mainform.channel_minvalue[MouseOverKanal]<0 then
//    mainform.channel_minvalue[MouseOverKanal]:=0;
//  if mainform.channel_minvalue[MouseOverKanal]>maxres then
//    mainform.channel_minvalue[MouseOverKanal]:=maxres;
end;

procedure Tkanaluebersichtform.MaxWertndern1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  mainform.channel_maxvalue[MouseOverKanal]:=round(strtoint(InputBox(_('Maximum des Kanalwertes'),_('Bitte geben Sie den Maximumwert dieses Kanals an (Geräteunabhängig!) (0..100):'),inttostr(round(mainform.channel_maxvalue[MouseOverKanal]/255*100))))/100*255);

//  if mainform.channel_maxvalue[MouseOverKanal]<0 then
//    mainform.channel_maxvalue[MouseOverKanal]:=0;
//  if mainform.channel_maxvalue[MouseOverKanal]>maxres then
//    mainform.channel_maxvalue[MouseOverKanal]:=maxres;
end;

procedure Tkanaluebersichtform.DDFanzeigen1Click(Sender: TObject);
var
  i,j:integer;
  ddfwindowposition:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if (AktuellerKanal>=mainform.devices[i].Startaddress) and (AktuellerKanal<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
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
      ddfwindows[ddfwindowposition].Top:=kanaluebersichtform.Top+paintbox.Top+lasty+(kanaluebersichtform.height-kanaluebersichtform.ClientHeight);
      ddfwindows[ddfwindowposition].Left:=kanaluebersichtform.Left+paintbox.Left+lastx+(kanaluebersichtform.Width-kanaluebersichtform.ClientWidth);
      ddfwindows[ddfwindowposition].loadDDF(mainform.Devices[i].ID);

      break;
    end;
  end;
end;

procedure Tkanaluebersichtform.Kanalselektioneinaus1Click(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if (AktuellerKanal>=mainform.devices[i].Startaddress) and (AktuellerKanal<mainform.devices[i].Startaddress+mainform.devices[i].MaxChan) then
    begin
      mainform.DeviceSelected[i]:=not mainform.DeviceSelected[i];
    end;
  end;
end;

procedure Tkanaluebersichtform.PaintBoxPaint(Sender: TObject);
begin
  dorefresh:=true;
end;

end.
