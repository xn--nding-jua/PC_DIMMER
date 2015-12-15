program MediacenterServer;

uses
  Forms,
  mainfrm in 'mainfrm.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER MediaCenter Server';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
