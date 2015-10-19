program FileSearchDemo;

uses
  Forms,
  DemoMain in 'DemoMain.pas' {Form1},
  Searches in 'Searches.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TFileSearch Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
