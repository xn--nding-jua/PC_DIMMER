program PC_DIMMER;

{%File 'Typdefinitionen.inc'}
{%File 'GlobaleKonstanten.inc'}
{%File 'Channels_Commandsystem.inc'}
{%File 'EditBefehl.inc'}
{%File 'GetBefehlState.inc'}

uses
  VCLFixPack,
  Forms,
  Windows,
  Dialogs,
  Controls,
  Tokentools,
  PCDIMMER in 'pcdimmer.pas' {MainForm},
  splashscreen in 'splashscreen.pas' {splash},
  Action in 'Action.pas' {ActionDlg},
  About in 'About.pas' {AboutBox},
  insscene in 'insscene.pas' {insscenedlg},
  gpl in 'gpl.pas' {gnulicense},
  protocol in 'protocol.pas' {protocolbox},
  presskey in 'presskey.pas' {presskeyfrm},
  Optionen in 'Optionen.pas' {OptionenBox},
  blenddownfrm in 'blenddownfrm.pas' {blenddown},
  progressscreen in 'progressscreen.pas' {inprogress},
  skripttimer_edit in 'skripttimer_edit.pas' {skripttimer_editform},
  projektverwaltungfrm in 'projektverwaltungfrm.pas' {projektverwaltung},
  messagesystem in 'messagesystem.pas',
  druckenfrm in 'druckenfrm.pas' {drucken},
  editmidievent in 'editmidievent.pas' {editmidieventfrm},
  midievent in 'midievent.pas' {midieventfrm},
  figureneditor in 'figureneditor.pas' {figureneditorform},
  bewegungsszeneneditor in 'bewegungsszeneneditor.pas' {bewegungsszeneneditorform},
  szenenverwaltung in 'szenenverwaltung.pas' {szenenverwaltungform},
  kontrollpanelform in 'kontrollpanelform.pas' {kontrollpanel},
  editskript in 'editskript.pas' {editskriptfrm},
  audioszeneeditorform in 'audioszeneeditorform.pas' {audioszeneneditor},
  befehleditorform2 in 'befehleditorform2.pas' {befehlseditor2},
  kompositionsszeneeditorform in 'kompositionsszeneeditorform.pas' {kompositionsszeneeditor},
  effektsequenzerfrm in 'effektsequenzerfrm.pas' {effektsequenzer},
  Tastenabfragefrm in 'Tastenabfragefrm.pas' {Tastenabfrage},
  geraetesteuerungfrm in 'geraetesteuerungfrm.pas' {geraetesteuerung},
  exceptionfrm in 'exceptionfrm.pas' {exceptionform},
  buehnenansicht in 'buehnenansicht.pas' {grafischebuehnenansicht},
  adddevicefrm in 'adddevicefrm.pas' {adddevice},
  submasterfrm in 'submasterfrm.pas' {submasterform},
  geraeteremovedfrm in 'geraeteremovedfrm.pas' {askforremovingform},
  joystickfrm in 'joystickfrm.pas' {joystickform},
  joysticksetupfrm in 'joysticksetupfrm.pas' {joysticksetupform},
  preseteditorform in 'preseteditorform.pas' {preseteditor},
  datainevent in 'datainevent.pas' {dataineventfrm},
  editdatainevent in 'editdatainevent.pas' {editdataineventfrm},
  tippofthedayfrm in 'tippofthedayfrm.pas' {tippoftheday},
  ddfwindowfrm in 'ddfwindowfrm.pas' {DDFWindow},
  devicescenefrm in 'devicescenefrm.pas' {devicesceneform},
  dimmcurvefrm in 'dimmcurvefrm.pas' {dimmcurveform},
  picturechangefrm in 'picturechangefrm.pas' {picturechangeform},
  autoszenefrm in 'autoszenefrm.pas' {autoszeneform},
  colormanagerfrm in 'colormanagerfrm.pas' {colormanagerform},
  ddfeditorfrm in 'ddfeditorfrm.pas' {ddfeditorform},
  compileerrorfrm in 'compileerrorfrm.pas' {compileerrorform},
  ownmessagefrm in 'ownmessagefrm.pas' {ownmessageform},
  accumessagefrm in 'accumessagefrm.pas' {accumessageform},
  audioeffektplayerfrm in 'audioeffektplayerfrm.pas' {audioeffektplayerform},
  scannersynchronisationfrm in 'scannersynchronisationfrm.pas' {scannersynchronisationform},
  timecodeplayerfrm in 'timecodeplayerfrm.pas' {timecodeplayerform},
  schedulerfrm in 'schedulerfrm.pas' {schedulerform},
  videoscreenfrm in 'videoscreenfrm.pas' {videoscreenform},
  videoscreensynchronisierenfrm in 'videoscreensynchronisierenfrm.pas' {videoscreensynchronisierenform},
  layerbezeichnungenfrm in 'layerbezeichnungenfrm.pas' {layerbezeichnungenform},
  kanaluebersichtfrm in 'kanaluebersichtfrm.pas' {kanaluebersichtform},
  codeeditorfrm in 'codeeditorfrm.pas' {codeeditorform},
  recoveryfrm in 'recoveryfrm.pas' {recoveryform},
  beatfrm in 'beatfrm.pas' {beatform},
  addfunctionfrm in 'addfunctionfrm.pas' {addfunctionform},
  clockfrm in 'clockfrm.pas' {clockform},
  DimmerKernelQueue in 'DimmerKernelQueue.pas' {DimmerkernelQueueForm},
  ProgressScreenSmallFrm in 'ProgressScreenSmallFrm.pas' {ProgressScreenSmall},
  textbuchfrm in 'textbuchfrm.pas' {textbuchform},
  scenenotfoundfrm in 'scenenotfoundfrm.pas' {scenenotfoundform},
  devicechannelselectionfrm in 'devicechannelselectionfrm.pas' {devicechannelselectionform},
  cuelistfrm in 'cuelistfrm.pas' {cuelistform},
  masterfrm in 'masterfrm.pas' {masterform},
  cdplayerfrm in 'cdplayerfrm.pas' {cdplayerform},
  reordergroupfrm in 'reordergroupfrm.pas' {groupeditorform},
  adddevicetogroupfrm in 'adddevicetogroupfrm.pas' {adddevicetogroupform},
  gnugettext in 'gnugettext.pas',
  MidiOut in 'MidiOut.pas',
  MidiIn in 'MidiIn.pas',
  USBViewMain in 'USBViewMain.pas' {USBViewForm},
  splashscreen2frm in 'splashscreen2frm.pas' {splashscreen2},
  dxf_previewfrm in 'dxf_previewfrm.pas' {dxf_previewform},
  firststepsfrm in 'firststepsfrm.pas' {firststepsform},
  Delphmcb in 'Delphmcb.pas',
  winlircfrm in 'winlircfrm.pas' {winlircform},
  mediacenterfrm in 'mediacenterfrm.pas' {mediacenterform},
  sidebarselectfrm in 'sidebarselectfrm.pas' {sidebarselectform},
  devicepowerfrm in 'devicepowerfrm.pas' {devicepowerform},
  leistungssteuerungfrm2 in 'leistungssteuerungfrm2.pas' {leistungssteuerungform2},
  audioeffektplayerstretchfrm in 'audioeffektplayerstretchfrm.pas' {audioeffektplayerstretchform},
  lauflichtassistentfrm in 'lauflichtassistentfrm.pas' {lauflichtassistentform},
  matrixeditorfrm in 'matrixeditorfrm.pas' {matrixeditorform},
  lockedfrm in 'lockedfrm.pas' {lockedform},
  devicelistfrm in 'devicelistfrm.pas' {devicelistform},
  faderpanelfrm in 'faderpanelfrm.pas' {faderpanelform},
  devicepicturechangefrm in 'devicepicturechangefrm.pas' {devicepicturechangeform},
  lauflichtassistentownpatternfrm in 'lauflichtassistentownpatternfrm.pas' {lauflichtassistentownpatternform},
  sidebarfrm in 'sidebarfrm.pas' {sidebarform},
  ambilight in 'ambilight.pas' {ambilightform},
  pmm in 'pmm.pas' {pmmform},
  touchscreenfrm in 'touchscreenfrm.pas' {touchscreenform},
  ddfeditorassistant in 'ddfeditorassistant.pas' {ddfeditorassistantform},
  dynguifrm in 'dynguifrm.pas' {dynguiform},
  audiomanagerfrm in 'audiomanagerfrm.pas' {audiomanagerform},
  presetsceneeditorform in 'presetsceneeditorform.pas' {presetsceneeditor},
  addcolorandgobotoeffectfrm in 'addcolorandgobotoeffectfrm.pas' {addcolorandgobotoeffectform},
  pcdMEVP in 'pcdMEVP.pas',
  pcdHTTPServer in 'pcdHTTPServer.pas',
  pcdRegistry in 'pcdRegistry.pas',
  pcdUtils in 'pcdUtils.pas',
  nodecontrolfrm in 'nodecontrolfrm.pas' {nodecontrolform},
  opensourcefrm in 'opensourcefrm.pas' {opensourceform},
  D7GesturesHeader in 'D7GesturesHeader.pas',
  usermgmtfrm in 'usermgmtfrm.pas' {usermgmtform},
  changeuserfrm in 'changeuserfrm.pas' {changeuserform},
  xtouchcontrolfrm in 'xtouchcontrolfrm.pas' {xtouchcontrolform},
  elgatostreamdeckfrm in 'elgatostreamdeckfrm.pas' {elgatostreamdeckform};

const
  sPC_DIMMERMutex = 'PC_DIMMER';

{$R *.RES}
{$R 'resources.RES'}
//{$R MANIFEST.RES}

type
  TFixedHintWindow = class(THintWindow)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

procedure TFixedHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0;
end;

function AlreadyStarted: Boolean;
begin
  CreateMutex(nil, False, sPC_DIMMERMutex);
  Result := GetLastError = ERROR_ALREADY_EXISTS;
end;

var
  showtext:boolean;
begin
{
  // Ggfs. nur eine Instanz des PC_DIMMERs zulassen
  if AlreadyStarted then
  begin
    if messagedlg(_('Der PC_DIMMER wurde bereits gestartet. Soll eine weitere Instanz des Programmes gestartet werden?'),mtConfirmation,
      [mbYes,mbNo],0)=mrNo then
        Exit;
  end;
}
  showtext:=true;

  Application.Initialize;
  HintWindowClass := TFixedHintWindow; // Hint-Klasse überschreiben, da sonst bei HintShow Fenster in den Hintergrund gehen, da Parent von Desktop
  Application.Title := 'PC_DIMMER';
  Application.HelpFile := 'pc_dimmer.pdf';

{
  // PC_DIMMER kommt nun ohne Admin-Rechte aus :)
  if not IsUserAnAdmin then
  begin
    ShowMessage(_('Sie versuchen den PC_DIMMER ohne Administrator-Rechte zu starten.'+#10#13+'Dieses Programm nutzt jedoch Funktionen, welche diese Rechte voraussetzen.'+#13#10#13#10+'Bitte führen Sie das Programm als Administrator aus.'));
  end else
}
  begin
    Application.CreateForm(Tmainform, mainform);
    if showtext then mainform.SplashAddText(_('Erstelle Projektverwaltung')); mainform.RefreshSplashText;
    Application.CreateForm(Tprojektverwaltung, projektverwaltung);
    if showtext then mainform.SplashAddText(_('Erstelle Beattool')); mainform.RefreshSplashText;
    Application.CreateForm(Tbeatform, beatform);
    if showtext then mainform.SplashAddText(_('Erstelle Progressscreen')); mainform.SplashProgress(1, 30, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tinprogress, inprogress);
    if showtext then mainform.SplashAddText(_('Erstelle Kontrollpanel')); mainform.RefreshSplashText;
    Application.CreateForm(Tkontrollpanel, kontrollpanel);
    if showtext then mainform.SplashAddText(_('Erstelle Effektsequenzer')); mainform.RefreshSplashText;
    Application.CreateForm(Teffektsequenzer, effektsequenzer);
    if showtext then mainform.SplashAddText(_('Erstelle Gerätesteuerung')); mainform.RefreshSplashText;
    Application.CreateForm(Tgeraetesteuerung, geraetesteuerung);
    if showtext then mainform.SplashAddText(_('Erstelle Bühnenansicht')); mainform.RefreshSplashText;
    Application.CreateForm(Tgrafischebuehnenansicht, grafischebuehnenansicht);
    if showtext then mainform.SplashAddText(_('Erstelle Submaster')); mainform.RefreshSplashText;
    Application.CreateForm(Tsubmasterform, submasterform);
    if showtext then mainform.SplashAddText(_('Erstelle Joystickkontrolle')); mainform.SplashProgress(1, 32, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tjoystickform, joystickform);
    Application.CreateForm(Tjoysticksetupform, joysticksetupform);
    if showtext then mainform.SplashAddText(_('Erstelle Zeitplaner')); mainform.RefreshSplashText;
    Application.CreateForm(Tschedulerform, schedulerform);
    if showtext then mainform.SplashAddText(_('Erstelle Midi-Einstellungen')); mainform.RefreshSplashText;
    Application.CreateForm(Teditmidieventfrm, editmidieventfrm);
    Application.CreateForm(Tmidieventfrm, midieventfrm);
    if showtext then mainform.SplashAddText(_('Erstelle Figureneditor')); mainform.SplashProgress(1, 33, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tfigureneditorform, figureneditorform);
    if showtext then mainform.SplashAddText(_('Erstelle Bewegungsszeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tbewegungsszeneneditorform, bewegungsszeneneditorform);
    Application.CreateForm(Taskforremovingform, askforremovingform);
    if showtext then mainform.SplashAddText(_('Erstelle Projektassistent')); mainform.RefreshSplashText;
    Application.CreateForm(Tfirststepsform, firststepsform);
    if showtext then mainform.SplashAddText(_('Erstelle Tastenabfrage')); mainform.RefreshSplashText;
    Application.CreateForm(TTastenabfrage, Tastenabfrage);
    if showtext then mainform.SplashAddText(_('Erstelle Skripteditor')); mainform.SplashProgress(1, 34, 100); mainform.RefreshSplashText;
    Application.CreateForm(Teditskriptfrm, editskriptfrm);
    if showtext then mainform.SplashAddText(_('Erstelle Audioszeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Taudioszeneneditor, audioszeneneditor);
    if showtext then mainform.SplashAddText(_('Erstelle Skriptablauf')); mainform.RefreshSplashText;
    Application.CreateForm(TActionDlg, ActionDlg);
    if showtext then mainform.SplashAddText(_('Erstelle Szeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tinsscenedlg, insscenedlg);
    if showtext then mainform.SplashAddText(_('Erstelle erweiterte Einstellungen')); mainform.SplashProgress(1, 35, 100); mainform.RefreshSplashText;
    Application.CreateForm(TOptionenBox, OptionenBox);
    if showtext then mainform.SplashAddText(_('Erstelle Preseteditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tpreseteditor, preseteditor);
    if showtext then mainform.SplashAddText(_('Erstelle DataIn Editor')); mainform.RefreshSplashText;
    Application.CreateForm(Tdataineventfrm, dataineventfrm);
    Application.CreateForm(Teditdataineventfrm, editdataineventfrm);
    if showtext then mainform.SplashAddText(_('Erstelle Geräteeditor')); mainform.SplashProgress(1, 36, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tddfeditorform, ddfeditorform);
    if showtext then mainform.SplashAddText(_('Erstelle Compilerfenster')); mainform.RefreshSplashText;
    Application.CreateForm(Tcompileerrorform, compileerrorform);
    if showtext then mainform.SplashAddText(_('Erstelle Geräteszeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tdevicesceneform, devicesceneform);
    if showtext then mainform.SplashAddText(_('Erstelle Dimmkurveneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tdimmcurveform, dimmcurveform);
    if showtext then mainform.SplashAddText(_('Erstelle Geräteleistung')); mainform.SplashProgress(1, 37, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tdevicepowerform, devicepowerform);
    if showtext then mainform.SplashAddText(_('Erstelle Gerätebildauswahl')); mainform.RefreshSplashText;
    Application.CreateForm(Tdevicepicturechangeform, devicepicturechangeform);
    if showtext then mainform.SplashAddText(_('Erstelle Autoszeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tautoszeneform, autoszeneform);
    if showtext then mainform.SplashAddText(_('Erstelle Farbauswahl')); mainform.RefreshSplashText;
    Application.CreateForm(Tcolormanagerform, colormanagerform);
    if showtext then mainform.SplashAddText(_('Erstelle MediaCenter Szeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tmediacenterform, mediacenterform);
    if showtext then mainform.SplashAddText(_('Erstelle Hinweisfenster')); mainform.SplashProgress(1, 38, 100); mainform.RefreshSplashText;
    Application.CreateForm(Townmessageform, ownmessageform);
    if showtext then mainform.SplashAddText(_('Erstelle Akkumeldung')); mainform.RefreshSplashText;
    Application.CreateForm(Taccumessageform, accumessageform);
    if showtext then mainform.SplashAddText(_('Erstelle Scannersynchronisation')); mainform.RefreshSplashText;
    Application.CreateForm(Tscannersynchronisationform, scannersynchronisationform);
    if showtext then mainform.SplashAddText(_('Erstelle Timecodeplayer')); mainform.RefreshSplashText;
    Application.CreateForm(Ttimecodeplayerform, timecodeplayerform);
    if showtext then mainform.SplashAddText(_('Erstelle Videoscreen')); mainform.RefreshSplashText;
    Application.CreateForm(Tvideoscreensynchronisierenform, videoscreensynchronisierenform);
    if showtext then mainform.SplashAddText(_('Erstelle Layerbezeichnung')); mainform.SplashProgress(1, 39, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tlayerbezeichnungenform, layerbezeichnungenform);
    if showtext then mainform.SplashAddText(_('Erstelle Kanalübersicht')); mainform.RefreshSplashText;
    Application.CreateForm(Tkanaluebersichtform, kanaluebersichtform);
    if showtext then mainform.SplashAddText(_('Erstelle Codeeditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tcodeeditorform, codeeditorform);
    if showtext then mainform.SplashAddText(_('Erstelle Funktionsauswahl')); mainform.RefreshSplashText;
    Application.CreateForm(Taddfunctionform, addfunctionform);
    if showtext then mainform.SplashAddText(_('Erstelle Uhr')); mainform.SplashProgress(1, 40, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tclockform, clockform);
    if showtext then mainform.SplashAddText(_('Erstelle Fortschrittsanzeige')); mainform.RefreshSplashText;
    Application.CreateForm(TProgressScreenSmall, ProgressScreenSmall);
    if showtext then mainform.SplashAddText(_('Erstelle Textbuch')); mainform.RefreshSplashText;
    Application.CreateForm(Ttextbuchform, textbuchform);
    if showtext then mainform.SplashAddText(_('Erstelle Szenenhinweis')); mainform.RefreshSplashText;
    Application.CreateForm(Tscenenotfoundform, scenenotfoundform);
    if showtext then mainform.SplashAddText(_('Erstelle Gerätekanalauswahl')); mainform.RefreshSplashText;
    Application.CreateForm(Tdevicechannelselectionform, devicechannelselectionform);
    if showtext then mainform.SplashAddText(_('Erstelle Cueliste')); mainform.RefreshSplashText;
    Application.CreateForm(Tcuelistform, cuelistform);
    if showtext then mainform.SplashAddText(_('Erstelle Master')); mainform.SplashProgress(1, 41, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tmasterform, masterform);
    if showtext then mainform.SplashAddText(_('Erstelle DDF-Fenster')); mainform.RefreshSplashText;
    Application.CreateForm(TDDFWindow, DDFWindowDeviceScene);
    if showtext then mainform.SplashAddText(_('Erstelle Audioeffektplayer')); mainform.RefreshSplashText;
    Application.CreateForm(Taudioeffektplayerform, audioeffektplayerform);
    if showtext then mainform.SplashAddText(_('Erstelle Gruppeneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tgroupeditorform, groupeditorform);
    Application.CreateForm(Tadddevicetogroupform, adddevicetogroupform);
    if showtext then mainform.SplashAddText(_('Erstelle WinLIRC Receiver')); mainform.RefreshSplashText;
    Application.CreateForm(Twinlircform, winlircform);
    if showtext then mainform.SplashAddText(_('Erstelle Sidebar')); mainform.SplashProgress(1, 42, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tsidebarform, sidebarform);
    Application.CreateForm(Tsidebarselectform, sidebarselectform);
    Application.CreateForm(Tleistungssteuerungform2, leistungssteuerungform2);
    if showtext then mainform.SplashAddText(_('Erstelle Zeitkorrekturfenster')); mainform.RefreshSplashText;
    Application.CreateForm(Taudioeffektplayerstretchform, audioeffektplayerstretchform);
    if showtext then mainform.SplashAddText(_('Erstelle Lauflichtassistent')); mainform.RefreshSplashText;
    Application.CreateForm(Tlauflichtassistentform, lauflichtassistentform);
    Application.CreateForm(Tmatrixeditorform, matrixeditorform);
    Application.CreateForm(Tlauflichtassistentownpatternform, lauflichtassistentownpatternform);
    if showtext then mainform.SplashAddText(_('Erstelle Locking')); mainform.RefreshSplashText;
    Application.CreateForm(Tlockedform, lockedform);
    if showtext then mainform.SplashAddText(_('Erstelle Devicelist')); mainform.SplashProgress(1, 43, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tdevicelistform, devicelistform);
    if showtext then mainform.SplashAddText(_('Erstelle Faderpanel')); mainform.RefreshSplashText;
    Application.CreateForm(Tfaderpanelform, faderpanelform);
    if showtext then mainform.SplashAddText(_('Erstelle Bilderauswahl')); mainform.RefreshSplashText;
    Application.CreateForm(Tpicturechangeform, picturechangeform);
    if showtext then mainform.SplashAddText(_('Erstelle Ambilight')); mainform.RefreshSplashText;
    Application.CreateForm(Tambilightform, ambilightform);
    if showtext then mainform.SplashAddText(_('Erstelle PartyMuckenModul')); mainform.SplashProgress(1, 44, 100); mainform.RefreshSplashText;
    Application.CreateForm(Tpmmform, pmmform);
    if showtext then mainform.SplashAddText(_('Erstelle Touchscreen')); mainform.RefreshSplashText;
    Application.CreateForm(Ttouchscreenform, touchscreenform);
    if showtext then mainform.SplashAddText(_('Erstelle DDFEditor-Assistenten')); mainform.RefreshSplashText;
    Application.CreateForm(Tddfeditorassistantform, ddfeditorassistantform);
    if showtext then mainform.SplashAddText(_('Erstelle dynamische Oberfläche')); mainform.RefreshSplashText;
    Application.CreateForm(Tdynguiform, dynguiform);
    if showtext then mainform.SplashAddText(_('Erstelle Audiomanager')); mainform.RefreshSplashText;
    Application.CreateForm(Taudiomanagerform, audiomanagerform);
    if showtext then mainform.SplashAddText(_('Erstelle Preset-Szeneneditor')); mainform.RefreshSplashText;
    Application.CreateForm(Tpresetsceneeditor, presetsceneeditor);
    if showtext then mainform.SplashAddText(_('Erstelle Knotensteuerung')); mainform.RefreshSplashText;
    Application.CreateForm(Tnodecontrolform, nodecontrolform);
    if showtext then mainform.SplashAddText(_('Erstelle OpenSource-Form')); mainform.RefreshSplashText;
    Application.CreateForm(Topensourceform, opensourceform);
    if showtext then mainform.SplashAddText(_('Erstelle Benutzerverwaltung-Form')); mainform.RefreshSplashText;
    Application.CreateForm(Tusermgmtform, usermgmtform);
    Application.CreateForm(Tchangeuserform, changeuserform);
    if showtext then mainform.SplashAddText(_('Erstelle XTouchControl-Form')); mainform.RefreshSplashText;
    Application.CreateForm(Txtouchcontrolform, xtouchcontrolform);
    if showtext then mainform.SplashAddText(_('Erstelle ElgatoStreamDeck-Form')); mainform.RefreshSplashText;
    Application.CreateForm(Telgatostreamdeckform, elgatostreamdeckform);

    // bitte neue Fenster im "OnClose"-Event des Hauptfensters zunächst schließen (wenn nötig) und dann "free"en!

    Application.Run;
  end;

end.
