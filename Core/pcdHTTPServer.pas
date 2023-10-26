unit pcdHTTPServer;

interface

uses
  SysUtils, Classes, Graphics, ExtCtrls, Controls, Windows,
  IdCustomHTTPServer, idContext;

type

  TPCDHTTPServer = class(TIdCustomHTTPServer)
  private
    FUsePassword: boolean;
    FPassword: string;
    FNewConnection: boolean;
    FServerActivePage, FServerLastActivePage: Word;
    FResetTimer: TTimer;

    procedure OnResetTimer(Sender: TObject);
    procedure DrawPage(AHTMLCode: TStringList; APage: integer);
    procedure DrawMainPage(AHTMLCode: TStringList);
    procedure DrawChannelOverview(AHTMLCode: TStringList);
    procedure DrawDevicesList(AHTMLCode: TStringList);
    procedure DrawTimersList(AHTMLCode: TStringList);
    procedure DrawControlpanel(AHTMLCode: TStringList);
    procedure DrawScenesList(AHTMLCode: TStringList);
    procedure DrawScene(AHTMLCode: TStringList; ANames: TStringList; ADescs: TStringList; AName: string; AType: string);
  public
    procedure SetActive(AValue: Boolean); override;
    procedure HTTPServerCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    property UsePassword : boolean read FUsePassword write FUsePassword default false;
    property Password : string read FPassword write FPassword;
  end;

  function WebColor(c: TColor): Integer;

implementation

uses
  pcdimmer, kontrollpanelform, messagesystem, geraetesteuerungfrm, buehnenansicht, gnugettext;

procedure TPCDHTTPServer.SetActive(AValue: Boolean);
begin
  FOnCommandGet := HTTPServerCommandGet;
  FNewConnection := true;

  if AValue then
    if not Assigned(FResetTimer) then begin
      FResetTimer := TTimer.Create(Self);
      FResetTimer.Interval := 600000;
      FResetTimer.Enabled := false;
      FResetTimer.OnTimer := OnResetTimer;
    end
  else
    if Assigned(FResetTimer) then begin
      FResetTimer.Enabled := false;
      FResetTimer.Free;
    end;

  try
    inherited SetActive(AValue);
  except
  end;
end;

procedure TPCDHTTPServer.OnResetTimer(Sender: TObject);
begin
  FNewConnection := true;
end;

procedure TPCDHTTPServer.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  i, LTemp1, LTemp2: integer;
  LParamName, LParamValue: string;
  LHTMLCode: TStringList;
  LHistoryBack: boolean;
begin
  LHTMLCode := TStringList.Create;
  LHistoryBack:=false;

  //restart reset timer
  FResetTimer.Enabled := false;
  FResetTimer.Enabled := true;

  // Bilddateien und andere Dateien dem Clienten auf Anfrage zusenden
  if pos('stageview', ARequestInfo.Document)<>0 then
  begin
    grafischebuehnenansicht.SaveStageviewToFile('jpg');
  end;

  if FileExists(mainForm.userdirectory+copy(ARequestInfo.Document,2,length(ARequestInfo.Document))) then
    AResponseInfo.ServeFile(AContext,mainForm.userdirectory+copy(ARequestInfo.Document,2,length(ARequestInfo.Document)))
  else if FileExists(mainForm.pcdimmerdirectory+copy(ARequestInfo.Document,2,length(ARequestInfo.Document))) then
    AResponseInfo.ServeFile(AContext,mainForm.pcdimmerdirectory+copy(ARequestInfo.Document,2,length(ARequestInfo.Document)))
  else if FileExists(copy(ARequestInfo.Document,2,length(ARequestInfo.Document))) then
    AResponseInfo.ServeFile(AContext,copy(ARequestInfo.Document,2,length(ARequestInfo.Document)))
  else if FileExists(ARequestInfo.Document) then
    AResponseInfo.ServeFile(AContext,ARequestInfo.Document);

  // Check returned password
  if UsePassword and FNewConnection and (ARequestInfo.Command='POST') then
  begin
    for i:=0 to ARequestInfo.Params.Count-1 do
      if copy(ARequestInfo.Params[i],0,pos('=',ARequestInfo.Params[i])-1)='password' then
        if lowercase(copy(ARequestInfo.Params[i],pos('=',ARequestInfo.Params[i])+1,length(ARequestInfo.Params[i])))=Password then
          FNewConnection:=false;
  end;

  // Ask for password
  if UsePassword and FNewConnection then
  begin
    LHTMLCode.Clear;
    LHTMLCode.Add('<html><head><meta http-equiv="Content-Language" content="de"><meta http-equiv="Content-Type" content="text/html; charset=windows-1252"><title>'+_('PC_DIMMER Webserver')+' :: '+_('Login')+'</title></head>');
    LHTMLCode.Add('<body>');// bgcolor="#CCCCCC" text="#333333" link="#666666" vlink="#666600" alink="#FFCCCC">');
    //////////////////////////
    // Passwortabfrage
    LHTMLCode.Add('<font face="Arial" size="2"><font style="font-size: 12pt">');
    LHTMLCode.Add('<p><b>PC_DIMMER Webserver :: Login</b></p><font style="font-size: 8pt">');
    LHTMLCode.Add('<font style="font-size: 10pt"><br><br><b>'+_('Willkommen zum PC_DIMMER Webserver')+
                  '</b><br><br>'+_('Bitte Passwort eingeben:')+'<br><br><form method="POST">'+
                  '<p><input type="password" name="password" size="20"><input type="submit" value="Login" name="okbtn"></form>');
    LHTMLCode.Add('</font>');
    //////////////////////////
    LHTMLCode.Add('<br><br><br><hr><br><font face="Arial" size="2"><font style="font-size: 10pt">'+
             '<center><img border="0" src="HTML/pcdimmerlogo.jpg"><br>'+
             'PC_DIMMER (c) 2004-2016 by Dr.-Ing. Christian Nöding</center></font>');
    LHTMLCode.Add('</body></html>');

    AResponseInfo.ContentText:=LHTMLCode.Text;
    LHTMLCode.Free;
    Exit;
  end;

  // Process command
  LParamValue := ARequestInfo.Params.Values['goto'];
  if not (LParamValue = '') then begin
    LHistoryBack := false;
    if lowercase(LParamValue) = 'main' then FServerActivePage:=0;
    if lowercase(LParamValue) = 'channels' then FServerActivePage:=1;
    if lowercase(LParamValue) = 'devices' then FServerActivePage:=2;
    if lowercase(LParamValue) = 'timer' then FServerActivePage:=3;
    if lowercase(LParamValue) = 'controlpanel' then FServerActivePage:=4;
    if lowercase(LParamValue) = 'scenes' then FServerActivePage:=5;
    if lowercase(LParamValue) = 'stageview' then FServerActivePage:=6;
  end;

  FServerLastActivePage := FServerActivePage;

  // Befehle ausführen
  for i:=0 to ARequestInfo.Params.Count-1 do
  begin
    LParamName := ARequestInfo.Params.Names[i];
    LParamValue := ARequestInfo.Params.ValueFromIndex[i];

    if (LParamName = 'chvalue') then begin
      LTemp1 := strtoint(ARequestInfo.Params.Values['ch']);
      LTemp2 := strtoint(ARequestInfo.Params.Values['time']);
      mainForm.senddata(LTemp1,mainForm.data.ch[LTemp1],255-strtoint(LParamValue),LTemp2*1000);
      LHistoryBack:=true;
    end else if LParamName = 'controlpanelbuttonstart' then begin
      LTemp1 := strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,pos('x',LParamValue)-(pos('Start ',LParamValue)+6))); // erste Zahl
      LTemp2 := strtoint(copy(LParamValue,pos('x',LParamValue)+1,length(LParamValue))); // letzte Zahl
      kontrollpanel.PaintBox1MouseMove(nil, [], trunc(kontrollpanel.btnwidth.Value*(LTemp2-1)+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*(LTemp1-1)+(kontrollpanel.btnheight.Value / 2)));
      kontrollpanel.PaintBox1MouseDown(nil, mbLeft, [ssLeft], trunc(kontrollpanel.btnwidth.Value*(LTemp2-1)+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*(LTemp1-1)+(kontrollpanel.btnheight.Value / 2)));
      kontrollpanel.PaintBox1MouseUp(nil, mbLeft, [], trunc(kontrollpanel.btnwidth.Value*(LTemp2-1)+(kontrollpanel.btnwidth.Value / 2)), trunc(kontrollpanel.btnheight.Value*(LTemp1-1)+(kontrollpanel.btnheight.Value / 2)));
      LHistoryBack:=true;
    end else if LParamName = 'controlpanelbuttonstop' then begin
      LTemp1 := strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,pos('x',LParamValue)-(pos('Stop ',LParamValue)+5))); // erste Zahl
      LTemp2 := strtoint(copy(LParamValue,pos('x',LParamValue)+1,length(LParamValue))); // letzte Zahl
      kontrollpanel.StopButton(LTemp2-1,LTemp1-1);
      LHistoryBack:=true;
    end else if LParamName = 'startsimplescene' then begin
      LTemp1 := strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.einfacheszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startdevicescene' then begin
      LTemp1 := strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.devicescenes[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startaudioscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.audioszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startmovingscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.bewegungsszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startcommand' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.befehle2[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startcombinationscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.kompositionsszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startpreset' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.devicepresets[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startautoscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.autoszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'starteffect' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.effektsequenzereffekte[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startmediascene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.mediacenterszenen[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startpresetscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.StartScene(mainForm.presetscenes[LTemp1].ID,false,false, -1);
      LHistoryBack:=true;
    end else if LParamName = 'startpluginscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Start ',LParamValue)+6,length(LParamValue)));
      mainForm.SendMSG(MSG_STARTPLUGINSCENE, GUIDToString(mainForm.pluginszenen[LTemp1].ID), -1);
      LHistoryBack:=true;
    end else if LParamName = 'stopsimplescene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.einfacheszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopdevicescene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.devicescenes[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopaudioscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.audioszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopmovingscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.bewegungsszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopcombinationscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.kompositionsszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopautoscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.autoszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopeffect' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.effektsequenzereffekte[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stopmediascene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.StopScene(mainForm.mediacenterszenen[LTemp1].ID);
      LHistoryBack:=true;
    end else if LParamName = 'stoppluginscene' then begin
      LTemp1:=strtoint(copy(LParamValue,pos('Stop ',LParamValue)+5,length(LParamValue)));
      mainForm.SendMSG(MSG_STOPPLUGINSCENE, GUIDToString(mainForm.pluginszenen[LTemp1].ID), 0);
      LHistoryBack:=true;
    end;
  end;

  if LHistoryBack then
    FServerActivePage := FServerLastActivePage;

//  if historyback then
//  begin
//    AResponseInfo.ContentText:='<html><head><meta http-equiv="Refresh" content="0; URL=javascript:history.back()"></head><body></body></html>';
    //    historyback:=false;
//  end else
  LHTMLCode.Clear;
  DrawPage(LHTMLCode, FServerActivePage);
  AResponseInfo.ContentText:=LHTMLCode.Text;
  LHTMLCode.Free;
end;

function WebColor(c: TColor): Integer;
begin
  Result := Swap(LoWord(c)) shl 8 or Lo(HiWord(c));
end;

procedure TPCDHTTPServer.DrawPage(AHTMLCode: TStringList; APage: integer);
var
  LHeader,LFooter:string;
begin
  LHeader := '<form method="POST"><p>'+
               '<input type="submit" value="Main" name="goto">&nbsp;'+
               '<input type="submit" value="Channels" name="goto">&nbsp;'+
               '<input type="submit" value="Devices" name="goto">&nbsp;'+
               '<input type="submit" value="Controlpanel" name="goto">&nbsp;'+
               '<input type="submit" value="Scenes" name="goto">&nbsp;'+
               '<input type="submit" value="Timer" name="goto">&nbsp;'+
               '<input type="submit" value="Stageview" name="goto"></p></form>';
  LFooter := '<br><br><br><hr><br><font face="Arial" size="2"><font style="font-size: 10pt">'+
             '<center><img border="0" src="HTML/pcdimmerlogo.jpg"><br>'+
             'PC_DIMMER (c) 2004-2016 by Dr.-Ing. Christian Nöding</center></font>';

  AHTMLCode.Clear;
  AHTMLCode.Add('<html><head><meta http-equiv="Content-Language" content="de"><meta http-equiv="Content-Type" content="text/html; charset=windows-1252"><title>'+_('PC_DIMMER Webserver')+'</title></head>');
  AHTMLCode.Add('<body>');// bgcolor="#CCCCCC" text="#333333" link="#666666" vlink="#666600" alink="#FFCCCC">');
  //////////////////////////
  AHTMLCode.Add('<font face="Arial" size="2"><font style="font-size: 12pt">');
  AHTMLCode.Add('<p><b>'+_('PC_DIMMER Webserver')+'</b></p><font style="font-size: 8pt">');
  AHTMLCode.Add(LHeader);
  case APage of
    0: DrawMainPage(AHTMLCode);
    1: DrawChannelOverview(AHTMLCode);
    2: DrawDevicesList(AHTMLCode);
    3: DrawTimersList(AHTMLCode);
    4: DrawControlpanel(AHTMLCode);
    5: DrawScenesList(AHTMLCode);
    6: begin
         grafischebuehnenansicht.SaveToBMP:=true;
         sleep(500);
         AHTMLCode.Add('<img border="0" src="stageview.jpg">');
       end
  end;
  AHTMLCode.Add(LFooter);
  AHTMLCode.Add('</body></html>');
end;

procedure TPCDHTTPServer.DrawMainPage(AHTMLCode: TStringList);
begin
  // Hauptseite erstellen
  AHTMLCode.Add('<font style="font-size: 10pt"><br><br><b>'+_('Willkommen zum PC_DIMMER Webserver')+
                '</b><br><br>'+_('Mit den obigen Tabs k&oumlnnen Sie einzelne Funktionen des PC_DIMMERs fernsteuern...'));
  AHTMLCode.Add('<br><br><br><br><br><b>'+_('Direkte Kanalwert&aumlnderung')+'</b><br><br>');
  AHTMLCode.Add('<form method="POST" action="SendChannelValue">');
  AHTMLCode.Add('	<table border="0" width="100%" id="table1" cellspacing="0" cellpadding="0">');
  AHTMLCode.Add('		<tr>');
  AHTMLCode.Add('			<td width="69"><font face="Arial" size="2">'+_('Kanal:')+'</font></td>');
  AHTMLCode.Add('			<td width="69"><font face="Arial" size="2">'+_('Fadezeit [s]:')+'</font></td>');
  AHTMLCode.Add('			<td><font face="Arial" size="2">'+_('Wert:')+'</font></td>');
  AHTMLCode.Add('		</tr>');
  AHTMLCode.Add('		<tr>');
  AHTMLCode.Add('			<td width="69"><font face="Arial">');
  AHTMLCode.Add('			<input type="text" name="ch" size="5" value="1"></font></td>');
  AHTMLCode.Add('			<td width="69"><font face="Arial">');
  AHTMLCode.Add('			<input type="text" name="time" size="5" value="0"></font></td>');
  AHTMLCode.Add('			<td><font face="Arial"><input type="submit" name="chvalue" value="0"><font size="2">');
  AHTMLCode.Add('			</font><input type="submit" name="chvalue" value="127"><font size="2">');
  AHTMLCode.Add('			</font><input type="submit" name="chvalue" value="255"></font></td>');
  AHTMLCode.Add('		</tr>');
  AHTMLCode.Add('	</table>');
  AHTMLCode.Add('</form></font>');
end;

procedure TPCDHTTPServer.DrawChannelOverview(AHTMLCode: TStringList);
var i: integer;
begin
  AHTMLCode.Add('<table border="1" width="100%" id="table1" cellspacing="0" cellpadding="0" bordercolorlight="#808080" bordercolordark="#808080" style="border-collapse: collapse" bgcolor="#CCCCCC">');
  AHTMLCode.Add('<tr>');
  for i:=1 to mainForm.lastchan do
  begin
    AHTMLCode.Add('<td><font style="font-size: 8pt"><b>'+_('Kanal ')+inttostr(i)+'</b><br>'+mainForm.data.names[i]+'<br>'+
                  inttostr(mainForm.channel_value[i])+' ('+inttostr(trunc(mainForm.channel_value[i]/255 * 100))+'%) </td></font>');
    if i mod 8 = 0 then
      AHTMLCode.Add('</tr><tr>');
    end;
    AHTMLCode.Add('</tr>');
    AHTMLCode.Add('</table>');
end;

procedure TPCDHTTPServer.DrawDevicesList(AHTMLCode: TStringList);
var
  i,j: integer;
  LImagePath: string;
begin
  AHTMLCode.Add('<table border="1" width="100%" id="table1" cellspacing="0" cellpadding="0" bordercolorlight="#808080" bordercolordark="#808080" style="border-collapse: collapse" bgcolor="#CCCCCC">');
  for i:=0 to length(mainForm.devices)-1 do
  begin
    AHTMLCode.Add('<tr>');
    LImagePath := 'Devicepictures\'+mainForm.devices[i].Bildadresse;
    AHTMLCode.Add('<td width="48"><center><img border="0" src="'+LImagePath+'" width="32" height="32"></center></td>');
    AHTMLCode.Add('<td><font style="font-size: 8pt"><b>'+mainForm.devices[i].Name+
                  ' ('+_('Startadresse: ')+inttostr(mainForm.devices[i].Startaddress)+') '+
                  '</b><br>'+mainForm.devices[i].Beschreibung+'<br>');
    for j:=0 to mainForm.devices[i].MaxChan-1 do
      AHTMLCode.Add('&nbsp;&nbsp;&nbsp;'+mainForm.devices[i].kanalname[j]+' @ '+
                    inttostr(geraetesteuerung.get_channel(mainForm.devices[i].ID,mainForm.devices[i].kanaltyp[j]))+
                    ' ('+inttostr(trunc(geraetesteuerung.get_channel(mainForm.devices[i].ID,mainForm.devices[i].kanaltyp[j])/255 *100))+'%)<br>');
    AHTMLCode.Add('</font></td>');
    AHTMLCode.Add('</tr>');
  end;
  AHTMLCode.Add('</table>');
end;

procedure TPCDHTTPServer.DrawTimersList(AHTMLCode: TStringList);
var
  i: integer;
  LTimerType: SmallInt;
  LTemp1_s,LTemp2_s,LTemp3_s: string;
begin
  if length(mainForm.AblaufTimer)=0 then
  begin
    AHTMLCode.Add('<font style="font-size: 10pt"><br><br><b>'+_('Keine geplanten Ereignisse.')+'</font>');
  end;

  AHTMLCode.Add('<table border="1" width="100%" id="table1" cellspacing="0" cellpadding="0" bordercolorlight="#808080" bordercolordark="#808080" style="border-collapse: collapse" bgcolor="#CCCCCC">');
  for i:=0 to length(mainForm.AblaufTimer)-1 do
  begin
    if mainForm.AblaufTimer[i].TimerTyp >= 200 then
      LTimerType := mainForm.AblaufTimer[i].TimerTyp-200
    else if mainForm.AblaufTimer[i].TimerTyp >= 100 then
      LTimerType := mainForm.AblaufTimer[i].TimerTyp-100
    else if mainForm.AblaufTimer[i].TimerTyp < 100 then
      LTimerType := mainForm.AblaufTimer[i].TimerTyp
    else
      LTimerType := -1;

    AHTMLCode.Add('<tr>');
    if mainForm.AblaufTimer[i].Aktiviert then
      LTemp1_s := _('Yes')
    else
      LTemp1_s := _('No');

    case mainForm.AblaufTimer[i].LoadTyp of
      0: LTemp2_s := _('Scene');
      1: LTemp2_s := _('Effect');
      2: LTemp2_s := _('Script');
    end;

    case LTimerType of
     -1: LTemp3_s := _('Unknown');
      0: LTemp3_s := _('Single');
      1: LTemp3_s := _('Daily');
      2: LTemp3_s := _('Weekly');
      3: LTemp3_s := _('Monthly');
      4: LTemp3_s := _('Annually');
    end;

    AHTMLCode.Add('<td><font style="font-size: 8pt">'+_('Event: ')+
                  '<b>'+mainForm.AblaufTimer[i].Name+'</b><br>'+_('Aktiv: ')+LTemp1_s+
                  '<br>'+_('Startdatum: ')+mainForm.AblaufTimer[i].Datum+'<br>'+_('Startzeit: ')+
                  mainForm.AblaufTimer[i].Uhrzeit+'<br>'+_('Timerart: ')+LTemp2_s+' ('+LTemp3_s+')<br>');
    AHTMLCode.Add('</font></td>');
    AHTMLCode.Add('</tr>');
  end;

  AHTMLCode.Add('</table>');
end;

procedure TPCDHTTPServer.DrawControlpanel(AHTMLCode: TStringList);
var
  i,j: integer;
begin
  AHTMLCode.Add('<table border="1" width="100%" id="table1" cellspacing="0" cellpadding="0" bordercolorlight="#808080" bordercolordark="#808080" style="border-collapse: collapse" bgcolor="#CCCCCC">');
  for i:=0 to mainForm.kontrollpanelrecord.zeilenanzahl do
  begin
    AHTMLCode.Add('<tr>');
    for j:=0 to mainForm.kontrollpanelrecord.spaltenanzahl do
    begin
      AHTMLCode.Add('<td bgcolor="#'+copy(IntToHex(WebColor(mainForm.kontrollpanelbuttons[i][j].Color),8),3,8)+'"><font face="Arial" size="2"><center><font style="font-size: 8pt"><b>'+mainForm.kontrollpanelbuttons[i][j].Name+'</b><br>'+mainForm.kontrollpanelbuttons[i][j].TypName+'<center><form method="POST"><input type="submit" value="Start '+inttostr(i+1)+'x'+inttostr(j+1)+'" name="controlpanelbuttonstart">&nbsp;<input type="submit" value="Stop '+inttostr(i+1)+'x'+inttostr(j+1)+'" name="controlpanelbuttonstop"></form></center></font></td>');
    end;
    AHTMLCode.Add('</tr>');
  end;
  AHTMLCode.Add('</table>');
end;

procedure TPCDHTTPServer.DrawScenesList(AHTMLCode: TStringList);
var
  i: integer;
  LNames,LDescs: TStringList;
begin
  LNames := TStringList.Create;
  LDescs := TStringList.Create;
  for i:=0 to length(mainform.EinfacheSzenen)-1 do
  begin
    LNames.Add(mainForm.EinfacheSzenen[i].Name);
    LDescs.Add(mainform.EinfacheSzenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Einfache Szenen'), 'simplescene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.DeviceScenes)-1 do
  begin
    LNames.Add(mainForm.DeviceScenes[i].Name);
    LDescs.Add(mainform.DeviceScenes[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Ger&aumlteszenen'), 'devicescene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Audioszenen)-1 do
  begin
    LNames.Add(mainForm.Audioszenen[i].Name);
    LDescs.Add(mainform.Audioszenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Audioszenen'), 'audioscene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Bewegungsszenen)-1 do
  begin
    LNames.Add(mainForm.Bewegungsszenen[i].Name);
    LDescs.Add(mainform.Bewegungsszenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Bewegungsszenen'), 'movingscene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Befehle2)-1 do
  begin
    LNames.Add(mainForm.Befehle2[i].Name);
    LDescs.Add(mainform.Befehle2[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Befehle'), 'command');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Kompositionsszenen)-1 do
  begin
    LNames.Add(mainForm.Kompositionsszenen[i].Name);
    LDescs.Add(mainform.Kompositionsszenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Kombinationsszenen'), 'combinationscene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.DevicePresets)-1 do
  begin
    LNames.Add(mainForm.DevicePresets[i].Name);
    LDescs.Add(mainform.DevicePresets[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Ger&aumlteszenen'), 'preset');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Autoszenen)-1 do
  begin
    LNames.Add(mainForm.Autoszenen[i].Name);
    LDescs.Add(mainform.Autoszenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Autoszenen'), 'autoscene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
  begin
    LNames.Add(mainForm.Effektsequenzereffekte[i].Name);
    LDescs.Add(mainform.Effektsequenzereffekte[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Effekte'), 'effect');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.mediacenterszenen)-1 do
  begin
    LNames.Add(mainForm.mediacenterszenen[i].Name);
    LDescs.Add(mainform.mediacenterszenen[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('MediaCenterSzenen'), 'mediascene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.presetscenes)-1 do
  begin
    LNames.Add(mainForm.presetscenes[i].Name);
    LDescs.Add(mainform.presetscenes[i].Beschreibung);
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Presetszenen'), 'presetscene');

  LNames.Clear; LDescs.Clear;
  for i:=0 to length(mainform.pluginszenen)-1 do
  begin
    LNames.Add(mainForm.pluginszenen[i].Name);
    LDescs.Add('');
  end;
  DrawScene(AHTMLCode, LNames, LDescs, _('Pluginszenen'), 'pluginscene');

  LNames.Free; LDescs.Free;
end;

procedure TPCDHTTPServer.DrawScene(AHTMLCode: TStringList; ANames: TStringList; ADescs: TStringList; AName: string; AType: string);
var
  i: integer;
begin
  AHTMLCode.Add('<table border="1" width="100%" id="table1" cellspacing="0" cellpadding="0" bordercolorlight="#808080" bordercolordark="#808080" style="border-collapse: collapse" bgcolor="#CCCCCC">');
  AHTMLCode.Add('<tr><td><font face="Arial" size="2"><font style="font-size: 12pt"><b>'+AName+'</b></td></tr>');
  for i := 0 to ANames.Count-1 do
  begin
    AHTMLCode.Add('<tr>'+
                 '<td bgcolor="#EAEAEA" width="150"><font face="Arial" size="2" style="font-size: 8pt"><center><form method="POST">'+
                 '<input type="submit" value="Start '+inttostr(i)+'" name="start'+AType+'">&nbsp;'+
                 '<input type="submit" value="Stop '+inttostr(i)+'" name="stop'+AType+'"></font></form></td>');
    AHTMLCode.Add('<td bgcolor="#EAEAEA"><font face="Arial" style="font-size: 8pt">');
    AHTMLCode.Add('<b>'+ANames[i]+'</b><br>'+ADescs[i]);
    AHTMLCode.Add('</font></td></tr>');
  end;
  AHTMLCode.Add('</table><br>');
end;

end.