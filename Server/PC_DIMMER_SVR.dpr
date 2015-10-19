program PC_DIMMER_SVR;

uses
  Forms,
  pcdimmerserver in 'pcdimmerserver.pas' {PCDimmer_Server},
  DXPlayFm in 'DXPlayFm.pas' {DelphiXDXPlayForm},
  messagesystem in '..\PC_DIMMER2008 Source\messagesystem.pas',
  aboutfrm in 'aboutfrm.pas' {aboutform},
  startupfrm in 'startupfrm.pas' {startupform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER Netzwerk-Server';
  Application.CreateForm(TPCDimmer_Server, PCDimmer_Server);
  Application.CreateForm(Taboutform, aboutform);
  Application.CreateForm(TDelphiXDXPlayForm, DelphiXDXPlayForm);
  Application.Run;
end.
