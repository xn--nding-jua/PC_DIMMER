unit windowmanagerform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  Twindowmanagerfrm = class(TForm)
    PaintBox1: TPaintBox;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  windowmanagerfrm: Twindowmanagerfrm;

implementation

{$R *.dfm}

end.
