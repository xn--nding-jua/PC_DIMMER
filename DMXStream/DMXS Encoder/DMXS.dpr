program DMXS;

uses
  Forms,
  dmxsencfrm in 'dmxsencfrm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DMX-Stream-Encoder';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
