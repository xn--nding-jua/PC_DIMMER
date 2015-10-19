program LibraryTester;

uses
  Forms,
  testprogramm in 'testprogramm.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ArtNET Library Testprogramm';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
