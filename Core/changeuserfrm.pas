unit changeuserfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxGDIPlusClasses, JvExControls, JvGradient,
  gnugettext;

type
  Tchangeuserform = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image2: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Button1: TButton;
    Button2: TButton;
    Edit1: TComboBox;
    Label3: TLabel;
    currentuserlbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  changeuserform: Tchangeuserform;

implementation

{$R *.dfm}

procedure Tchangeuserform.FormShow(Sender: TObject);
begin
  edit1.SetFocus;
end;

procedure Tchangeuserform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tchangeuserform.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
    ModalResult:=mrOK
  else if Key=vk_escape then
    ModalResult:=mrCancel;
end;

end.
