program Codecompiler;

uses
  Forms,
  mainform in 'mainform.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER DMX512 Interface Compiler';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
