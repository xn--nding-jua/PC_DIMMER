program MediacenterServer;

uses
  Forms,
  mainfrm in 'mainfrm.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER2010 Mediacenter Server';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
