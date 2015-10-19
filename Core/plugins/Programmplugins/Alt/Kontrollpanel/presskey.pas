unit presskey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  Tpresskeyfrm = class(TForm)
    Label1: TLabel;
    Animate1: TAnimate;
    Shape1: TShape;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
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
  animate1.StopFrame:=13;
  animate1.Active:=true;
end;

end.
