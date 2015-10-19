program CDPlayer;

uses
  Forms,
  cdplayerfrm in 'cdplayerfrm.pas' {cdplayerform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CD-Player';
  Application.CreateForm(Tcdplayerform, cdplayerform);
  Application.Run;
end.
