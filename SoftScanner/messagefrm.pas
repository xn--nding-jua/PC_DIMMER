unit messagefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvGradient, pngimage, ExtCtrls;

type
  Tmessageform = class(TForm)
    ListBox1: TListBox;
  private
    { Private-Deklarationen }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public-Deklarationen }
  end;

var
  messageform: Tmessageform;

implementation

{$R *.dfm}

procedure TMessageform.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style:=Params.Style or WS_SIZEBOX;
end;

end.
