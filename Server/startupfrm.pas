unit startupfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, gnugettext;

type
  Tstartupform = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  startupform: Tstartupform;

implementation

{$R *.dfm}

procedure Tstartupform.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
end;

end.
