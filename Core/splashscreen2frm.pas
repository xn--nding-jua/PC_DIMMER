unit splashscreen2frm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExControls, JvAnimatedImage, JvGIFCtrl, StdCtrls,
  pngimage, IAeverProgressBar, JvSpecialProgress,
  gnugettext;

type
  Tsplashscreen2 = class(TForm)
    Image1: TImage;
    progressbar1: TJvSpecialProgress;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  splashscreen2: Tsplashscreen2;

implementation

{$R *.dfm}

procedure Tsplashscreen2.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
