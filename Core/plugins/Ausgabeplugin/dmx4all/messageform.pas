unit messageform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UbuntuProgress;

type
  Tmessagefrm = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  messagefrm: Tmessagefrm;

implementation

{$R *.dfm}

end.
