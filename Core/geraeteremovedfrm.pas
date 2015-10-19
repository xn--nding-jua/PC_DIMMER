unit geraeteremovedfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, pngimage, JvExControls, JvGradient,
  gnugettext;

type
  Taskforremovingform = class(TForm)
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    devicenamelabel: TLabel;
    startadresselabel: TLabel;
    Button2: TButton;
    Label2: TLabel;
    devicedescription: TLabel;
    TreeView1: TTreeView;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  askforremovingform: Taskforremovingform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Taskforremovingform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Taskforremovingform.CreateParams(var Params:TCreateParams);
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
