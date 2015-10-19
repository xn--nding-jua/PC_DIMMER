unit gpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gnugettext, ExtCtrls;

type
  Tgnulicense = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Shape4: TShape;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
  public
    { Public declarations }
    i:integer;
  end;

var
  gnulicense: Tgnulicense;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tgnulicense.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  i:=-1;
end;

procedure Tgnulicense.CreateParams(var Params:TCreateParams);
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
