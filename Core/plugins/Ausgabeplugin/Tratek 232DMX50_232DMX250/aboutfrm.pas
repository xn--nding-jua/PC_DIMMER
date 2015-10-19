unit aboutfrm;

interface

uses
  Windows, Controls, StdCtrls, ExtCtrls, Classes, Forms;

type
  TAbout = class(TForm)
    Label4: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
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
