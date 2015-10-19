program DMX4ALL_Test;

uses
  Forms,
  DMX4ALL_Defines in 'DMX4ALL_Defines.pas',
  main in 'main.pas' {Mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainform, Mainform);
  Application.Run;
end.
