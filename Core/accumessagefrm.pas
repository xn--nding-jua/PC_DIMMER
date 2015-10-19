unit accumessagefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, gnugettext;

type
  Taccumessageform = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    percent: TLabel;
    Shape2: TShape;
    Shape1: TShape;
    caption: TLabel;
    description: TLabel;
    ICON: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  accumessageform: Taccumessageform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Taccumessageform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Taccumessageform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Taccumessageform.CreateParams(var Params:TCreateParams);
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

end.
