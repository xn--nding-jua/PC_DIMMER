program Videoscreen;

uses
  Forms,
  videoscreenfrm in 'videoscreenfrm.pas' {videoscreenform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Videoscreen4Marten';
  Application.CreateForm(Tvideoscreenform, videoscreenform);
  Application.Run;
end.
