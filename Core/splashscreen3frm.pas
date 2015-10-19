unit splashscreen3frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, gnugettext, UbuntuProgress,
  pngimage, JvExControls, JvGradient;

type
  Tsplashscreen3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ProgressBar1: TUbuntuProgress;
    Image1: TImage;
    JvGradient1: TJvGradient;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  splashscreen3: Tsplashscreen3;

implementation

{$R *.dfm}

procedure Tsplashscreen3.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
