unit aboutfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TAbout = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    Image1: TImage;
    Shape1: TShape;
    Label6: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  About: TAbout;

implementation

{$R *.dfm}

end.
