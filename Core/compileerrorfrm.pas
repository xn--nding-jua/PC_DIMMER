unit compileerrorfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, gnugettext;

type
  Tcompileerrorform = class(TForm)
    ListBox1: TListBox;
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  compileerrorform: Tcompileerrorform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tcompileerrorform.Button1Click(Sender: TObject);
begin
  compileerrorform.close;
end;

procedure Tcompileerrorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tcompileerrorform.CreateParams(var Params:TCreateParams);
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
