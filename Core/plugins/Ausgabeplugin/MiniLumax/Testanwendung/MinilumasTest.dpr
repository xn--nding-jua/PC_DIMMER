program MinilumasTest;

uses
  Forms,
  configfrm in '..\configfrm.pas' {Config};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TConfig, Config);
  Application.Run;
end.
