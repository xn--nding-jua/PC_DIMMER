unit ProgressScreenSmallFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, gnugettext, ExtCtrls, UbuntuProgress;

type
  TProgressScreenSmall = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Shape1: TShape;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ProgressScreenSmall: TProgressScreenSmall;

implementation

uses PCDIMMER, audiomanagerfrm;

{$R *.dfm}

function GetTaskbarHeight: integer;
var
  SysTray: Windows.HWND;
  Rect: TRect;
begin
  Result := -1;
  SysTray := FindWindow('Shell_TrayWnd', nil);
  if SysTray <> INVALID_HANDLE_VALUE then begin
    if GetWindowRect(SysTray, Rect) then begin
      Result := Screen.Height - Rect.Top;
    end;
  end;
end;

procedure TProgressScreenSmall.FormShow(Sender: TObject);
var
  movebyx:integer;
begin
  movebyx:=0;
{
  if audiomanagerform.showing then
    movebyx:=movebyx+audiomanagerform.ClientHeight;
}

  ProgressScreenSmall.Top:=Screen.MonitorFromWindow(mainform.Handle).Height-ProgressScreenSmall.Height-GetTaskbarHeight-movebyx;
  ProgressScreenSmall.Left:=Screen.MonitorFromWindow(mainform.Handle).Width-ProgressScreenSmall.Width;

  ProgressScreenSmall.Caption:=Label1.Caption;
  Timer1.Enabled:=false;
end;

procedure TProgressScreenSmall.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TProgressScreenSmall.Timer1Timer(Sender: TObject);
begin
  ProgressScreenSmall.Close;
end;

end.
