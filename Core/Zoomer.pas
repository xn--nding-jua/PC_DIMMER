{$WARNINGS OFF}
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                        CAD window Zoombox VCL Object                      //
//                  ©John Biddiscombe, ©Dani Andres Izquierdo                //
//                                                                           //
//                             ©John Biddiscombe                             //
//                      Rutherford Appleton Laboratory, UK                   //
//                           j.biddiscombe@rl.ac.uk                          //
//                       DXF code release 3.0 - July 1997                    //
//                                                                           //
//                            Dani Andres Izquierdo                          //
//                           email : grandres@ctv.es                         //
//         Improvements + drag rectangle + Better Scroll bar Control         //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
// Usage :                                                                   //
//              Drag rectangle to zoom in on area                            //
//              Double click to recentre on spot                             //
//              Scroll bars to pan around                                    //
//              Buttons to zoom in/out                                       //
// Suggestion : Add Pop up menu with Zoom_Prev call to return to last view   //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

unit Zoomer;

interface
              
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, DXF_Utils;

const
  MIN_RECT           = 2;
  MAX_SCROLL         = 1000;
  SCROLL_OVERLAPPING = 12;

type
  params = record
    xscale,yscale   : double;
    xmin,xmax       : double;
    ymin,ymax       : double;
    xmid,ymid       : double;
  end;

type
  Zoom_panel = class(TCustomPanel)
  private
    { Private declarations }
    FOnPaint     : TNotifyEvent;
    FOnMouseDown : TMouseEvent;
    FOnMouseUp   : TMouseEvent;
    FOnMouseMove : TMouseMoveEvent;
    FOnZoomin    : TNotifyEvent;
    FOnZoomout   : TNotifyEvent;
    FOnZoomreset : TNotifyEvent;
    // visible things
    scrollpanel_ud  : TPanel;
    scrollpanel_lr  : TPanel;
    ScrollBar_ud    : TScrollBar;
    ScrollBar_lr    : TScrollBar;
    zoom_in_button  : TSpeedButton;
    zoom_out_button : TSpeedButton;
    zoomresetbutton : TSpeedButton;
    zoomlastbutton  : TSpeedButton;
    Coords          : TLabel;
    Zoomtext        : TLabel;
    // bookkeeping
    original_params : params;
    current_params  : params;
    previous_params : params;
    Zooming_in      : boolean;
    Zooming_out     : boolean;
    zoomtimer       : TTimer;
    // Zoom rectangle params
    zooming_rect    : boolean;
    Ini_Point       : TPoint;
    Old_Point       : TPoint;
    Old_PenStyle    : TPenStyle;
    Old_PenMode     : TPenMode;
    Old_PenWidth    : Integer;
    Old_PenColor    : TColor;
    Old_BrushStyle  : TBrushStyle;
  protected
    { Protected declarations }
    procedure ReSet_Parameters(xmn,xmx,ymn,ymx:Double);
    procedure Calc_Rect(var xmn,xmx,ymn,ymx:Double);
    procedure ReSet_ScrollParams;
    procedure save_canvas_stuff;
    procedure restore_canvas_stuff;
  public
    { Public declarations }
    ClientArea      : TPaintBox;
    initialized     : boolean;
    zoom_factor     : double;
    constructor Create(AOwner: TComponent);     override;
    procedure   Resize;                         override;
    procedure   WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure   Mouse_Down(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y: Integer);
    procedure   Mouse_Up  (Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
    procedure   Mouse_Move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure   DblClick(Sender:TObject);

    procedure   ScrollBars_Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure   ReCentre(mx,my:integer);
    procedure   Zoom(factor:double);
    procedure   Zoom_in_out(Sender:TObject);
    procedure   Zoom_last(Sender:TObject);
    procedure   Zoom_mousedown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
    procedure   Zoom_mouseup(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
    procedure   Zoom_timer_event(Sender:TObject);
    procedure   Zoom_Prev;

    procedure   set_parameters(xmn,xmx,ymn,ymx:double; xm,ym:integer);
    function    real_to_screen(P:Point3D; OCS:pMatrix) : TPoint;
    function    screen_to_real(P1:TPoint) : Point2D;
  published
    { Published declarations }
    property Align;
    property Alignment;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown : TMouseEvent     read FOnMouseDown write FOnMouseDown;
    property OnMouseUp   : TMouseEvent     read FOnMouseUp   write FOnMouseUp;
    property OnMouseMove : TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnPaint     : TNotifyEvent    read FOnPaint     write FOnPaint;
    property OnResize;
    property OnStartDrag;
    property OnZoomin    : TNotifyEvent    read FOnZoomin    write FOnZoomin;
    property OnZoomout   : TNotifyEvent    read FOnZoomout   write FOnZoomout;
    property OnZoomreset : TNotifyEvent    read FOnZoomreset write FOnZoomreset;
    property ZoomFactor  : double          read zoom_factor  write zoom_factor;
  end;

procedure Register;

implementation

{$R images.res}

procedure Register;
begin
  RegisterComponents('Custom', [Zoom_panel]);
end;
///////////////////////////////////////////////////////////////////////////////
// Create all the visible items
// Set the Owner and Parent properties so Delphi deletes them all for us.
///////////////////////////////////////////////////////////////////////////////
constructor Zoom_panel.Create(AOwner: TComponent);
var TempBitmap : TBitmap;
begin
  inherited;
  initialized := false;
  ControlStyle := ControlStyle - [csSetCaption];

  scrollpanel_ud            := TPanel.Create(Self);
  scrollpanel_ud.Visible    := True;
  scrollpanel_ud.Parent     := Self;
  scrollpanel_ud.Align      := AlRight;

  scrollpanel_lr            := TPanel.Create(Self);
  scrollpanel_lr.Visible    := True;
  scrollpanel_lr.Parent     := Self;
  scrollpanel_lr.Align      := AlBottom;

  ScrollBar_ud              := TScrollBar.Create(scrollpanel_ud);
  ScrollBar_ud.Visible      := True;
  ScrollBar_ud.Parent       := scrollpanel_ud;
  ScrollBar_ud.Kind         := sbVertical;
  ScrollBar_ud.Max          := Max_Scroll;
  ScrollBar_ud.Position     := round(Max_Scroll/2);
  ScrollBar_ud.LargeChange  := round(Max_Scroll-Max_Scroll/SCROLL_OVERLAPPING);
  ScrollBar_ud.OnScroll     := ScrollBars_Scroll;

  ScrollBar_lr              := TScrollBar.Create(scrollpanel_lr);
  ScrollBar_lr.Visible      := True;
  ScrollBar_lr.Parent       := scrollpanel_lr;
  ScrollBar_lr.Kind         := sbHorizontal;
  ScrollBar_lr.Max          := Max_Scroll;
  ScrollBar_lr.Position     := round(Max_Scroll/2);
  ScrollBar_lr.LargeChange  := round(Max_Scroll-Max_Scroll/SCROLL_OVERLAPPING);
  ScrollBar_lr.OnScroll     := ScrollBars_Scroll;

  TempBitmap                := TBitmap.Create;
  TempBitmap.LoadFromResourceName(HInstance,'Z_RESET');
  zoomresetbutton           := TSpeedButton.Create(scrollpanel_lr);
  zoomresetbutton.Parent    := scrollpanel_lr;
  zoomresetbutton.Glyph.Assign(TempBitmap);
  zoomresetbutton.Onclick   := Zoom_in_out;

  TempBitmap.LoadFromResourceName(HInstance,'Z_LAST');
  zoomlastbutton            := TSpeedButton.Create(scrollpanel_lr);
  zoomlastbutton.Parent     := scrollpanel_lr;
  zoomlastbutton.Glyph.Assign(TempBitmap);
  zoomlastbutton.Onclick    := Zoom_last;

  TempBitmap.LoadFromResourceName(HInstance,'Z_PLUS');
  zoom_in_button             := TSpeedButton.Create(scrollpanel_lr);
  zoom_in_button.Parent      := scrollpanel_lr;
  zoom_in_button.Glyph.Assign(TempBitmap);
  zoom_in_button.OnMouseDown := Zoom_mousedown;
  zoom_in_button.OnMouseUP   := Zoom_mouseup;

  TempBitmap.LoadFromResourceName(HInstance,'Z_MINUS');
  zoom_out_button             := TSpeedButton.Create(scrollpanel_lr);
  zoom_out_button.Parent      := scrollpanel_lr;
  zoom_out_button.Glyph.Assign(TempBitmap);
  zoom_out_button.OnMouseDown := Zoom_mousedown;
  zoom_out_button.OnMouseUP   := Zoom_mouseup;
  TempBitmap.Free;

  Zooming_in          := false;
  Zooming_out         := false;
  Zooming_Rect        := false;
  zoomtimer           := TTimer.Create(scrollpanel_lr);
  zoomtimer.OnTimer   := Zoom_timer_event;
  zoomtimer.Enabled   := false;
  zoomtimer.Interval  := 500;

  ClientArea                := TPaintbox.Create(Self);
  ClientArea.Cursor         := crCross;
  ClientArea.Visible        := True;
  ClientArea.Parent         := Self;
  ClientArea.Align          := AlClient;
  ClientArea.OnMouseMove    := Mouse_Move;
  ClientArea.OnMouseDown    := Mouse_Down;
  ClientArea.OnMouseUp      := Mouse_Up;
  ClientArea.OnDblClick     := DblClick;

  Coords                    := TLabel.Create(scrollpanel_lr);
  Coords.Font.Name          := 'FF_ARIAL';
  Coords.Parent             := scrollpanel_lr;
  Coords.Font.Color         := clNavy;
  Coords.Caption            := 'X= 0.000  Y= 0.000';

  Zoomtext                  := TLabel.Create(scrollpanel_lr);
  Zoomtext.Font.Name        := 'FF_ARIAL';
  Zoomtext.Parent           := scrollpanel_lr;
  Zoomtext.Font.Color       := clMaroon;
  Zoomtext.Caption          := '1 : 1';

  If Zoom_factor=0 then Zoom_factor := 1.25;
  resize;
end;
///////////////////////////////////////////////////////////////////////////////
// Adjust everything after a resize
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.Resize;
begin
  inherited;
  scrollpanel_lr.height     := GetSystemMetrics(SM_CYHSCROLL)*2;
  scrollpanel_ud.width      := GetSystemMetrics(SM_CXVSCROLL);
  scrollbar_lr.left         := 0;
  scrollbar_lr.top          := 0;
  scrollbar_lr.height       := scrollpanel_lr.height div 2;
  scrollbar_lr.width        := scrollpanel_lr.width - scrollpanel_ud.width*8;

  scrollpanel_lr.BevelInner := bvNone;
  scrollpanel_lr.BevelOuter := bvNone;

  scrollbar_ud.left         := 0;
  scrollbar_ud.top          := 0;
  scrollbar_ud.width        := scrollpanel_ud.width;
  scrollbar_ud.height       := scrollpanel_ud.height;

  zoom_out_button.left      := scrollbar_lr.width;
  zoom_out_button.Width     := scrollbar_ud.width*2;
  zoom_out_button.height    := scrollbar_lr.height*2;

  zoom_in_button.left       := scrollbar_lr.width + zoom_out_button.width;
  zoom_in_button.Width      := scrollbar_ud.width*2;
  zoom_in_button.height     := scrollbar_lr.height*2;

  zoomlastbutton.left       := scrollbar_lr.width + zoom_out_button.width*2;
  zoomlastbutton.width      := scrollbar_ud.width*2;
  zoomlastbutton.height     := scrollbar_lr.height*2;

  zoomresetbutton.left      := scrollbar_lr.width + zoom_out_button.width*3;
  zoomresetbutton.width     := scrollbar_ud.width*2;
  zoomresetbutton.height    := scrollbar_lr.height*2;

  zoomresetbutton.Top       := 0;
  zoom_in_button.Top        := 0;
  zoom_out_button.Top       := 0;

  Coords.Font.Height        := scrollbar_lr.Height-1;
  Coords.Left               := 8;
  Coords.Top                := scrollbar_lr.Height+1;

  Zoomtext.Font.Height      := scrollbar_lr.Height-1;
  Zoomtext.Left             := zoom_out_button.left - zoom_out_button.width*2;
  Zoomtext.Top              := scrollbar_lr.Height+1;
end;
///////////////////////////////////////////////////////////////////////////////
// Events we pass on to user
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.WMPaint(var Message: TWMPaint);
begin
  inherited;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

procedure Zoom_panel.Mouse_Down(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
// extra save/restore canvas stuff, because we may highlight objects
// whilst dragging the rectangle, and we want to preserve colours etc.
begin
  if Button=mbLeft then begin // Creating the Zooming Rectangle
    zooming_rect := True;
    Ini_Point    := Point(X,Y);
    Old_Point    := Ini_Point; // Load the actual Pos.
    save_canvas_stuff;
    // Draw first rectangle for XOr Mode Init
    ClientArea.canvas.pen.style   := psDashDotDot;
    ClientArea.canvas.pen.mode    := pmNotXor;
    ClientArea.canvas.pen.width   := 1;
    ClientArea.canvas.pen.color   := clRed;
    ClientArea.Canvas.Brush.Style := bsclear;
    ClientArea.Canvas.Rectangle(Ini_Point.X,Ini_Point.Y,Ini_Point.X,Ini_Point.Y);
    restore_canvas_stuff;
  end;
  if Assigned(FOnMouseDown) then FOnMouseDown(Sender,Button,Shift,X,Y);
end;

procedure Zoom_panel.Mouse_Up(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
var ul,lr   : TPoint;  // UpperLeft and LowerRight zooming rect
    uln,lrn : Point2D; // New window parameters
Begin
  if (button=mbleft) and Zooming_rect then begin
    Zooming_Rect := False;
    save_canvas_stuff;
    // Draw final rectangle for XOr Mode
    ClientArea.canvas.pen.style   := psDashDotDot;
    ClientArea.canvas.pen.mode    := pmNotXor;
    ClientArea.canvas.pen.width   := 1;
    ClientArea.canvas.pen.color   := clRed;
    ClientArea.Canvas.Brush.Style := bsclear;
    ClientArea.Canvas.Rectangle(Ini_Point.X,Ini_Point.Y,Old_Point.X,Old_Point.Y);
    restore_canvas_stuff;
    // Look if the rectangle is big enough...
    if (abs(Ini_Point.X-Old_Point.X) > MIN_RECT) and
       (abs(Ini_Point.Y-Old_Point.Y) > MIN_RECT) then {If Zoom is too small-> No_Zoom}
    begin
      // Look for the correct rectangle!!!!
      if (Ini_Point.X > Old_Point.X) then begin lr.x:=Ini_Point.X; ul.x:=Old_Point.X; end
      else begin lr.x:=Old_Point.X; ul.x:=Ini_Point.X; end;
      if (Ini_Point.Y > Old_Point.Y) then begin lr.Y:=Ini_Point.Y; ul.Y:=Old_Point.Y; end
      else begin lr.Y:=Old_Point.Y; ul.Y:=Ini_Point.Y; end;
      uln:=Screen_To_Real(ul);
      lrn:=Screen_To_Real(lr);
      ReSet_Parameters(uln.x, lrn.x, lrn.y, uln.y);
      ClientArea.Refresh;
    end;
  end;
  if Assigned(FOnMouseUp) then FOnMouseUp(Sender,Button,Shift,X,Y);
end;

procedure Zoom_panel.Mouse_Move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var s1,s2 : string;
    ul : Point2D;
begin
  if not initialized then exit;
  if Zooming_rect Then begin
    save_canvas_stuff;
    ClientArea.canvas.pen.style   := psDashDotDot;
    ClientArea.canvas.pen.mode    := pmNotXor;
    ClientArea.canvas.pen.width   := 1;
    ClientArea.canvas.pen.color   := clRed;
    ClientArea.Canvas.Brush.Style := bsclear;
    // Erase old rectangle
    ClientArea.canvas.rectangle(Ini_Point.X, Ini_Point.Y, Old_Point.X, Old_Point.y);
    // Draw New Rect
    ClientArea.canvas.rectangle(Ini_Point.X, Ini_Point.Y, X, Y);
    restore_canvas_stuff;
    // Update values
    Old_Point.X := X;
    Old_Point.y := y;
  end;
  // Update position label
  ul := screen_to_real(Point(x,y));
  s1 := FloatTostrF(ul.x,ffFixed,8,3);
  s2 := FloatTostrF(ul.y,ffFixed,8,3);
  Coords.Caption := 'X= '+s1+'   Y= '+s2;
  If Assigned(FOnMouseMove) then FOnMouseMove(Sender,Shift,X,Y);
end;

procedure Zoom_panel.Zoom_Prev;
 Begin
  Current_Params:=Previous_Params;
  Reset_ScrollParams;
  Refresh;
end;

procedure Zoom_panel.DblClick(Sender:TObject);
Begin
  recentre(Ini_Point.x,Ini_Point.Y);
  inherited DblClick;
End;
///////////////////////////////////////////////////////////////////////////////
// Scrolling and recentring
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.ScrollBars_Scroll(Sender:TObject; ScrollCode:TScrollCode; var ScrollPos:Integer);
var cx,cy,moved : Double;
begin
  if scrollpos<>(Sender as TScrollbar).position then with current_params do begin
    if sender=scrollbar_lr then begin
      cx   := xmid;
      moved := ScrollPos - scrollbar_lr.position;
      if (Abs(moved)=Scrollbar_lr.largeChange) then begin
        moved := (moved*(Original_Params.xmax - Original_Params.xmin))/ MAX_SCROLL;
        xmid := xmid + round((moved - (moved/SCROLL_OVERLAPPING)));
      end
      else Xmid:=xmid + moved;
      xmin := xmin - (cx-xmid);
      xmax := xmax - (cx-xmid);
    end;
    if sender=scrollbar_ud then begin
      cy   := ymid;
      moved := ScrollPos - scrollbar_ud.position;
      if (Abs(moved)=Scrollbar_ud.largeChange) then begin
        moved := -(moved*(Original_Params.ymax - Original_Params.ymin))/ MAX_SCROLL;
        ymid := ymid + round((moved - (moved/SCROLL_OVERLAPPING)));
      end
      else Ymid:=ymid - moved;
      ymin := ymin - (cy-ymid);
      ymax := ymax - (cy-ymid);
    end;
    Reset_ScrollParams;
    Refresh;
  end;
end;

procedure Zoom_panel.ReCentre(mx,my:integer); // screen coords (mouse)
var mid   : Point2D;
    xt,yt : double;
begin
  if not initialized then exit;
  mid := screen_to_real(Point(mx,my));
  Previous_Params := Current_Params;
  with current_params do begin
    xmid   := mid.x;
    ymid   := mid.y;
    xt     := (xmax-xmin)*xscale;
    yt     := (ymax-ymin)*yscale;
    xmax   := xmid + (xt/xscale)/2;
    xmin   := xmid - (xt/xscale)/2;
    ymax   := ymid + (yt/yscale)/2;
    ymin   := ymid - (yt/yscale)/2;
  end;
  Reset_ScrollParams;
  ClientArea.Refresh;
end;
///////////////////////////////////////////////////////////////////////////////
// Section dealing with Zooming in/out
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.Zoom(factor:double);
var xt,yt,t1,t2 : double;
begin
  if not initialized then exit;
  Previous_params := Current_params;
  with current_params do begin
    xmid   := (xmin+xmax) / 2;
    ymid   := (ymin+ymax) / 2;
    xt     := (xmax-xmin)*xscale;
    yt     := (ymax-ymin)*yscale;
    xscale := xscale / factor;
    yscale := yscale / factor;
    xmax   := xmid + (xt/xscale)/2;
    xmin   := xmid - (xt/xscale)/2;
    ymax   := ymid + (yt/yscale)/2;
    ymin   := ymid - (yt/yscale)/2;
    t1     := xscale/original_params.xscale;
    if t1<0.999 then begin
      t1 := 1;
      t2 := original_params.xscale/xscale;
    end else t2:=1;
    Zoomtext.Caption :=   FloatToStrF(t1, ffGeneral, 3 ,2 )+' : '
                        + FloatToStrF(t2, ffGeneral, 3 ,2 );
  end;
  Reset_ScrollParams;
  ClientArea.Refresh;
end;

procedure Zoom_panel.Zoom_in_out(Sender:TObject);
var temp : params;
begin
  if not initialized then exit;
  if Sender=zoom_out_button then begin
    zoom(zoom_factor);
    If Assigned(FOnZoomout) then FOnZoomout(self);
  end
  else if Sender=zoom_in_button then begin
    zoom(1/zoom_factor);
    If Assigned(FOnZoomin) then FOnZoomin(self);
  end
  else if Sender=zoomresetbutton then begin
    temp := Current_params;
    current_params := original_params;
    Zoom(1);
    Previous_params := temp;
    If Assigned(FOnZoomreset) then FOnZoomreset(self);
  end;
end;

procedure Zoom_panel.Zoom_last(Sender:TObject);
begin
  Zoom_prev;
end;

procedure Zoom_panel.Zoom_mousedown(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  if Sender=zoom_in_button then begin
    zooming_in := true; zooming_out := false;
    zoomtimer.enabled := true;
    zoomtimer.Interval := 500;   // initial pause of 0.5 seconds
    Zoom_in_out(zoom_in_button);
  end
  else if Sender=zoom_out_button then begin
    zooming_out := true; zooming_in := false;
    zoomtimer.enabled := true;
    zoomtimer.Interval := 500;   // initial pause of 0.5 seconds
    Zoom_in_out(zoom_out_button);
  end;
end;

procedure Zoom_panel.Zoom_mouseup(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
  zooming_in        := false;
  zooming_out       := false;
  zoomtimer.enabled := false;
end;

procedure Zoom_panel.Zoom_timer_event(Sender:TObject);
begin
  zoomtimer.Interval := 25;   // now go for speedy zooming
  if zooming_in then Zoom_in_out(zoom_in_button)
  else if zooming_out then Zoom_in_out(zoom_out_button);
end;
///////////////////////////////////////////////////////////////////////////////
// Initialization of window, scaling etc.
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.set_parameters(xmn,xmx,ymn,ymx:double; xm,ym:integer);
var tempx,tempy : integer;
begin
  with original_params do begin
    tempx := ClientArea.Width  -2*xm;
    tempy := ClientArea.Height -2*ym;
    if tempx<tempy then begin
      if (xmx-xmn)<>0 then xscale := tempx/(xmx-xmn)
      else xscale := 1;
      if (ymx-ymn)<>0 then yscale := tempx/(ymx-ymn)
      else yscale := 1;
    end else begin
      if (xmx-xmn)<>0 then xscale := tempy/(xmx-xmn)
      else xscale := 1;
      if (ymx-ymn)<>0 then yscale := tempy/(ymx-ymn)
      else yscale := 1;
    end;
    if xscale<yscale then yscale:=xscale else xscale:=yscale;
    xmid := (xmx+xmn)/2;
    ymid := (ymx+ymn)/2;
    xmin := xmid - (ClientArea.Width/2)/xscale;
    xmax := xmid + (ClientArea.Width/2)/xscale;
    ymin := ymid - (ClientArea.Height/2)/yscale;
    ymax := ymid + (ClientArea.Height/2)/yscale;
  end;
  current_params := original_params;
  initialized    := true;
end;

// Used when zooming by rectangle.
Procedure Zoom_panel.ReSet_Parameters(xmn, xmx, ymn, ymx:Double);
var tempx,tempy : integer;
    t1,t2       : double;
begin
  Previous_Params:=Current_Params;
  with current_params do begin
    tempx := ClientArea.Width;
    tempy := ClientArea.Height;
    if tempx<tempy then begin
      if (xmx-xmn)<>0 then xscale := tempx/(xmx-xmn)
      else xscale := 1;
      if (ymx-ymn)<>0 then yscale := tempx/(ymx-ymn)
      else yscale := 1;
    end else begin
      if (xmx-xmn)<>0 then xscale := tempy/(xmx-xmn)
      else xscale := 1;
      if (ymx-ymn)<>0 then yscale := tempy/(ymx-ymn)
      else yscale := 1;
    end;
      if xscale<yscale then yscale:=xscale else xscale:=yscale;
    xmid := (xmx+xmn) / 2;
    ymid := (ymx+ymn) / 2;
    xmin := xmid - (ClientArea.Width/2)/xscale;
    xmax := xmid + (ClientArea.Width/2)/xscale;
    ymin := ymid - (ClientArea.Height/2)/yscale;
    ymax := ymid + (ClientArea.Height/2)/yscale;
    t1     := xscale/original_params.xscale;
    if t1<0.999 then begin
      t1 := 1;
      t2 := original_params.xscale/xscale;
    end else t2:=1;
    Zoomtext.Caption :=   FloatToStrF(t1, ffGeneral, 3 ,2 )+' : '
                        + FloatToStrF(t2, ffGeneral, 3 ,2 );
  end;
  Reset_ScrollParams;
end;

Procedure Zoom_panel.Calc_Rect(Var xmn, xmx, ymn, ymx:Double); //!!! Not used yet
var tempx,tempy : Double;
    Xscale,YScale:Single;
begin
  tempx := ClientArea.Width;
  tempy := ClientArea.Height;
  if (xmx <> xmn) then xscale:= tempx/abs(xmx-xmn)
  else xscale :=1;
  if (ymx <>ymn) then yscale:= tempy/abs(ymx-ymn)
  else Yscale:=1;
  // look for the most similar value of ClientArea size
  if (xscale < yscale) then // Xscale is the good one
    if ymn > ymx Then ymx:=round(ymn-tempy/xscale)
    else ymx:=round(ymn+tempy/xscale)
  else
    if xmn > xmx then xmx:=round(xmn-tempx/yscale)
    else xmx:=round(xmn+tempx/yscale);
end;

procedure Zoom_panel.ReSet_ScrollParams;
begin
  with Current_Params do begin
    ScrollBar_lr.LargeChange:=round(
     Max_Scroll*(XMax-XMin)/(Original_Params.XMax-Original_Params.XMin));

    ScrollBar_lr.Position:=round(
     ((XMid-Original_params.Xmin)/(Original_Params.Xmax-Original_Params.XMin))* MAX_SCROLL );

    ScrollBar_ud.LargeChange:=round(
     Max_Scroll*(YMax-YMin)/(Original_Params.YMax-Original_Params.YMin));

    ScrollBar_ud.Position:=MAX_SCROLL-round(
    ((YMid-Original_params.Ymin)/(Original_Params.Ymax-Original_Params.YMin))* MAX_SCROLL );
  end;
end;
///////////////////////////////////////////////////////////////////////////////
// save/restore canvas properties
///////////////////////////////////////////////////////////////////////////////
procedure Zoom_panel.save_canvas_stuff;
begin
  Old_PenStyle   := ClientArea.Canvas.Pen.Style;
  Old_PenMode    := ClientArea.Canvas.Pen.Mode;
  Old_PenWidth   := ClientArea.Canvas.Pen.Width;
  Old_PenColor   := ClientArea.Canvas.Pen.Color;
  Old_BrushStyle := ClientArea.Canvas.Brush.Style;
end;

procedure Zoom_panel.restore_canvas_stuff;
begin
  ClientArea.Canvas.pen.mode    := Old_PenMode;
  ClientArea.Canvas.pen.style   := Old_PenStyle;
  ClientArea.Canvas.pen.Width   := Old_PenWidth;
  ClientArea.Canvas.Pen.Color   := Old_PenColor;
  ClientArea.Canvas.Brush.Style := Old_BrushStyle;
end;
///////////////////////////////////////////////////////////////////////////////
// Coordinate transformations
///////////////////////////////////////////////////////////////////////////////
function Zoom_panel.real_to_screen(P:Point3D; OCS:pMatrix) : TPoint;
var tc : Point3D;
begin
 try
  with current_params do begin
    if OCS=nil then begin
      result.x := round(( P.x - xmin )*xscale);
      result.y := round(( ymax - P.y )*yscale);
    end
    else begin
      tc := TransformPoint(OCS^,P);
      result.x := round(( tc.x - xmin )*xscale);
      result.y := round(( ymax - tc.y )*yscale);
    end;
  end;
  except
   On Exception Do Zoom_Prev;
 end;
end;

function Zoom_panel.screen_to_real(P1:TPoint) : Point2D;
begin
  with current_params do begin
    result.x := P1.x/xscale + xmin;
    result.y := ymax -P1.y/yscale;
  end;
end;
{$WARNINGS ON}
end.
