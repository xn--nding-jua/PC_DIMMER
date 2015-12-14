program Welcome;

uses
  Forms,
  welcomefrm in 'welcomefrm.pas' {welcomeform};

//{$R *.res}
{$R MANIFEST.RES}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER';
  Application.CreateForm(Twelcomeform, welcomeform);
  Application.Run;
end.
