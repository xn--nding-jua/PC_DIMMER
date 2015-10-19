unit aboutfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, gnugettext;

type
  Taboutform = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label17: TLabel;
    Shape1: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  aboutform: Taboutform;

implementation

{$R *.dfm}

procedure Taboutform.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
end;

end.
