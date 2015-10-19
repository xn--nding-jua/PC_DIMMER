unit protocol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gnugettext, ExtCtrls;

type
  Tprotocolbox = class(TForm)
    OK: TButton;
    debuglistbox: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    procedure debuglistboxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private declarations }
  public
    { Public declarations }
    errorsoccured:boolean;
  end;

var
  protocolbox: Tprotocolbox;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tprotocolbox.debuglistboxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListbox) do
  begin
    Canvas.Font.Color := Integer(Items.Objects[index]);
    Canvas.TextRect(Rect, Rect.Left+2, Rect.Top, Items[Index]);
  end;
end;

procedure Tprotocolbox.FormShow(Sender: TObject);
begin
	if errorsoccured then
  	ShowMessage(_('Es sind Fehler aufgetreten. Bitte kontrollieren Sie das Protokoll.'));
end;

procedure Tprotocolbox.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tprotocolbox.CreateParams(var Params:TCreateParams);
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
