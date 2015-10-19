unit ownmessagefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, gnugettext,
  dxGDIPlusClasses;

type
  Townmessageform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    ICON: TImage;
    captionlbl: TLabel;
    descriptionlbl: TLabel;
    Panel2: TPanel;
    meldung: TMemo;
    Panel3: TPanel;
    OKbtn: TButton;
    CancelBtn: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKbtnClick(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    NonModal:boolean;
  end;

var
  ownmessageform: Townmessageform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Townmessageform.FormShow(Sender: TObject);
begin
  Shape2.Width:=ownmessageform.Width;
end;

procedure Townmessageform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Townmessageform.OKbtnClick(Sender: TObject);
begin
  if ownmessageform.NonModal then
  begin
    NonModal:=false;
    close;
  end;
end;

procedure Townmessageform.CreateParams(var Params:TCreateParams);
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
