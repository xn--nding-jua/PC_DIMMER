program pc_dimmer_diagnose;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER Setup-/Diagnoseprogramm';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
