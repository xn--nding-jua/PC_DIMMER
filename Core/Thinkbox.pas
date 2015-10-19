unit Thinkbox;

interface

uses
  SysUtils, WinTypes, WinProcs, Forms, Classes, Controls, ExtCtrls,
  ComCtrls;

type
  TThinking_box = class(TForm)
    think_msg : TPanel;
    barpanel: TPanel;
    bar: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
  end;

var
  thinkbox_active : boolean;
  Thinking_box    : TThinking_box;

procedure CenterWindow(Wnd: HWnd);
procedure thinking(parent:TForm; mssage:Pchar);
procedure thinking_bar(parent:TForm; mssage:Pchar);
procedure stopped_thinking;

implementation

{$R *.DFM}

var
  fsize        : TSize;

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
begin
  GetWindowRect(Wnd, Rect);
  SetWindowPos(Wnd, 0,
    (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
    (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 2,
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

constructor TThinking_box.Create(AOwner:TComponent);
var style    : Longint;
    oldfont  : Hfont;
    screenDC : hDC;
begin
  inherited create(AOwner);
// this stops a redraw by saving background bitmap - speedy for tiny windows
  style := GetClassLong(handle,GCL_STYLE);
  style := style or CS_SAVEBITS;
  SetClassLong(handle,GCL_STYLE,style);
// Use fixed pitch system font so we can calculate width/height quickly from size
  screenDC:=GetDC(0);
  oldfont:=SelectObject(screenDC,think_msg.Font.Handle);
  GetTextExtentPoint32(screenDC,'8',1,fsize); // all letters are this size
  SelectObject(screenDC,oldfont);
  ReleaseDC(0,screenDC);
end;

procedure thinking(parent:TForm; mssage:Pchar);
var BoxPos,BoxOff : TPoint;
    w,h,l         : integer;
begin
  l := StrLen(mssage);
  w:=(l*fsize.cx)+12; h:=(fsize.cy)+6;
  if parent<>nil then with Parent.ClientRect do begin
    BoxOff.x := (right-left - w) div 2;
    BoxOff.y := (bottom-top - h) div 2;
  end
  else begin
    BoxOff.x := (Screen.width - w) div 2;
    BoxOff.y := (Screen.height - h) div 2;
  end;
  Thinking_box.barpanel.visible := false;
  if parent<>nil then BoxPos := Parent.ClientToScreen(Point(0,0))
  else BoxPos := Point(0,0);
  Thinking_box.SetBounds(BoxPos.x + BoxOff.x,BoxPos.y + BoxOff.y,w,h);
  Thinking_box.think_msg.Caption := mssage;
  ShowWindow(Thinking_box.handle,SW_SHOWNOACTIVATE);
  BringWindowToTop(Thinking_box.handle);
  Thinking_box.Visible := true;
  Thinking_box.repaint;
  thinkbox_active := true;
end;

procedure thinking_bar(parent:TForm; mssage:Pchar);
var BoxPos,BoxOff : TPoint;
    w,h,l         : integer;
begin
  l := StrLen(mssage);
  w:=(l*fsize.cx)+12; h:=(fsize.cy)+6+24; //24 for bar panel
  if parent<>nil then with Parent.ClientRect do begin
    BoxOff.x := (right-left - w) div 2;
    BoxOff.y := (bottom-top - h) div 2;
  end
  else begin
    BoxOff.x := (Screen.width - w) div 2;
    BoxOff.y := (Screen.height - h) div 2;
  end;
  Thinking_box.barpanel.visible := false;
  Thinking_box.barpanel.height  := 24;
  Thinking_box.bar.Width := w-16;
  Thinking_box.bar.left  := 8;
  if parent<>nil then BoxPos := Parent.ClientToScreen(Point(0,0))
  else BoxPos := Point(0,0);
  Thinking_box.SetBounds(BoxPos.x + BoxOff.x,BoxPos.y + BoxOff.y,w,h);
  Thinking_box.think_msg.Caption := mssage;
  Thinking_box.barpanel.visible := true;
  ShowWindow(Thinking_box.handle,SW_SHOWNOACTIVATE);
  BringWindowToTop(Thinking_box.handle);
  Thinking_box.Visible := true;
  Thinking_box.repaint;
  thinkbox_active := true;
end;

procedure stopped_thinking;
begin
  ShowWindow(Thinking_box.handle,SW_HIDE);
  Thinking_box.barpanel.visible := false;
  thinkbox_active := false;
end;

initialization
  Thinking_box := TThinking_box.Create(nil);
finalization
  Thinking_box.Free;
end.
