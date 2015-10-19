program testprogramm;

uses
  Forms,
  Dialogs,
  main in 'main.pas' {Form1},
  messagesystem in 'messagesystem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER Plugintester';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
