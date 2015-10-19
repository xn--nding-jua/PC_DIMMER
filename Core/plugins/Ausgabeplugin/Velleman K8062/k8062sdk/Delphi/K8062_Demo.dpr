program K8062_Demo;

uses
  Forms,
  K8062_1 in 'K8062_1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
