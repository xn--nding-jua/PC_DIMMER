unit presskey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, gnugettext;

type
  Tpresskeyfrm = class(TForm)
    Label1: TLabel;
    Animate1: TAnimate;
    Shape1: TShape;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  presskeyfrm: Tpresskeyfrm;

implementation

{$R *.dfm}

procedure Tpresskeyfrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  presskeyfrm.ModalResult:=mrOK;
end;

procedure Tpresskeyfrm.FormShow(Sender: TObject);
begin
  animate1.StopFrame:=14;
  animate1.Active:=true;
end;

procedure Tpresskeyfrm.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
