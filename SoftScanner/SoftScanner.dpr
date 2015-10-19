program SoftScanner;

uses
  Forms,
  main in 'main.pas' {Mainform},
  AdSetupDlg in 'AdSetupDlg.pas' {AdSetupFrm},
  settingfrm in 'settingfrm.pas' {Settingform},
  messagefrm in 'messagefrm.pas' {messageform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PC_DIMMER SoftScanner';
  Application.CreateForm(TMainform, Mainform);
//  Application.CreateForm(Tmessageform, messageform);
//  Application.CreateForm(TSettingform, Settingform);
  Application.Run;
end.
