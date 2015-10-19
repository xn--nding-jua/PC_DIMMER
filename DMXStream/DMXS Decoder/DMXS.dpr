program DMXS;

uses
  Forms,
  dmxsdecfrm in 'dmxsdecfrm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DMX-Stream-Decoder';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
