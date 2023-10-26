  Text_PCD_Function:='';
  Text_Function:='';
  Text_Value:='';
  Value:=-1;

  // Audioeffektplayer
  Text_PCD_Function:=_('AEP');
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[0].GUID) then
  begin // Start/stop
    if audioeffektplayerform.PlayEffektaudio.Enabled then
  	  Text_Function:=_('Start')
    else
  	  Text_Function:=_('Stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[1].GUID) then
  begin // Start
    Text_Function:=_('Start');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[2].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[3].GUID) then
  begin // Springe zu Position
    Text_Function:=_('Position');
  	Text_Value:=mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[0]);
    Value:=Befehlssystem[0].Steuerung[3].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[4].GUID) then
  begin // Repeat ein/aus
    if audioeffektplayerform.Repeataktiviert.Checked then
	  Text_Function:=_('Repeat aus')
	else
	  Text_Function:=_('Repeat ein');
    exit;
  end; // Aufnahme ein/aus
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[5].GUID) then
  begin
    if audioeffektplayerform.recordbtn_on.Visible then
  	  Text_Function:=_('Record ein')
    else
  	  Text_Function:=_('Record aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[6].GUID) then
  begin // Effekte ein/aus
    if audioeffektplayerform.effekteein.Checked then
	  Text_Function:=_('Effekte aus')
	else
	  Text_Function:=_('Effekte ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[7].GUID) then
  begin // Vorherige Audiodatei
    Text_Function:=_('|< Vorherige');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[8].GUID) then
  begin // Nächste Audiodatei
    Text_Function:=_('Nächste >|');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[9].GUID) then
  begin // Springe zu Audiodatei
    Text_Function:=_('zu Datei');
    if (AktuellerBefehl.ArgInteger[0]>=0) and (AktuellerBefehl.ArgInteger[0]<audioeffektplayerform.audioeffektfilenamebox.Items.Count) then
	  Text_Value:=audioeffektplayerform.audioeffektfilenamebox.Items[AktuellerBefehl.ArgInteger[0]];
    Value:=Befehlssystem[0].Steuerung[9].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[0].Steuerung[10].GUID) then
  begin // Springe zu Audiodatei
    Text_Function:=_('zu Datei');
    if (AktuellerBefehl.ArgInteger[0]>=0) and (AktuellerBefehl.ArgInteger[0]<audioeffektplayerform.audioeffektfilenamebox.Items.Count) then
	  Text_Value:=audioeffektplayerform.audioeffektfilenamebox.Items[AktuellerBefehl.ArgInteger[0]];
    Value:=Befehlssystem[0].Steuerung[10].CurrentValue;
    exit;
  end;
  
  // Szenen
  Text_PCD_Function:=_('Szenen');
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[1].Steuerung[0].GUID) then
  begin // Start
    Text_Function:=_('Start');
  	Text_Value:=GetSceneInfo2(AktuellerBefehl.ArgGUID[0], 'name');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[1].Steuerung[1].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
  	Text_Value:=GetSceneInfo2(AktuellerBefehl.ArgGUID[0], 'name');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[1].Steuerung[2].GUID) then
  begin // Start/Stop
    if IsSceneActive(AktuellerBefehl.ArgGUID[0]) then
  	  Text_Function:=_('Stop')
    else
  	  Text_Function:=_('Start');
  	Text_Value:=GetSceneInfo2(AktuellerBefehl.ArgGUID[0], 'name');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[1].Steuerung[3].GUID)then
  begin // Flash
    Text_Function:=_('Flash');
  	Text_Value:=GetSceneInfo2(AktuellerBefehl.ArgGUID[0], 'name');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[1].Steuerung[4].GUID) then
  begin // Szenenzeit festlegen
    Text_Function:=_('Szenenzeit');
  	Text_Value:=GetSceneInfo2(AktuellerBefehl.ArgGUID[0], 'name');
    exit;
  end;

  // Beattool
  Text_PCD_Function:=_('Beattool');
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[0].GUID) then
  begin // Sync-Button
    Text_Function:=_('Sync-Button');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[1].GUID) then
  begin // BPM-Wert
    Text_Function:=_('BPM setzen');
	  Text_Value:=inttostr(AktuellerBefehl.ArgInteger[0]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[2].GUID) then
  begin // BPM-Wert abfragen
    Text_Function:=_('BPM abfragen');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[3].GUID) then
  begin // Beat auslösen
    Text_Function:=_('BPM');
	  Text_Value:=_('Beat auslösen');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[4].GUID) then
  begin // Beatquelle setzen
    Text_Function:=_('Beatquelle');
	  Text_Value:=beatform.Temposourcebox.Items[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[5].GUID) then
  begin // Temposlider setzen
    Text_Function:=_('Temposlider');
	  Text_Value:=inttostr(round((59999-beatform.temposlider.position)/100))+'BPM';
    Value:=round(((59999-beatform.temposlider.position)/59999)*maxres);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[2].Steuerung[6].GUID) then
  begin // Temposlider auf Eingangswert
    Text_Function:=_('Temposlider');
	  Text_Value:=inttostr(round((59999-beatform.temposlider.position)/100))+'BPM';
    Value:=round(((59999-beatform.temposlider.position)/59999)*maxres);
    exit;
  end;

  // Master / MIDI
  Text_PCD_Function:=_('Master/MIDI/Programm');
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[0].GUID) then
  begin // Grandmaster auf Eingang
    Text_Function:=_('Grandmaster');
    Value:=maxres-masterform.dimmerMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[1].GUID) then
  begin // Grandmaster setzen
    Text_Function:=_('Grandmaster');
  	Text_Value:=mainform.levelstr(round(((100-AktuellerBefehl.ArgInteger[0])/100)*255));
    Value:=maxres-masterform.dimmerMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[2].GUID) then
  begin // Grandmaster abfragen
    Text_Function:=_('Grandmaster');
  	Text_Value:=_('abfragen');
    Value:=maxres-masterform.dimmerMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[3].GUID) then
  begin // Flashmaster auf Eingang
    Text_Function:=_('Flashmaster');
    Value:=maxres-masterform.flashMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[4].GUID) then
  begin // Flashmaster setzen
    Text_Function:=_('Flashmaster');
	  Text_Value:=mainform.levelstr(round(((100-AktuellerBefehl.ArgInteger[0])/100)*255));
    Value:=maxres-masterform.flashMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[5].GUID) then
  begin // Flashmaster auf abfragen
    Text_Function:=_('Flashmaster');
  	Text_Value:=_('abfragen');
    Value:=maxres-masterform.flashMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[6].GUID) then
  begin // Speedmaster auf Eingang
    Text_Function:=_('Speedmaster');
    Value:=maxres-masterform.speedMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[7].GUID) then
  begin // Speedmaster setzen
    Text_Function:=_('Speedmaster');
	  Text_Value:=mainform.levelstr(round(((100-AktuellerBefehl.ArgInteger[0])/100)*255));
    Value:=maxres-masterform.speedMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[8].GUID) then
  begin // Speedmaster abfragen
    Text_Function:=_('Speedmaster');
	  Text_Value:=_('abfragen');
    Value:=maxres-masterform.speedMaster.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[9].GUID) then
  begin // Audiomaster auf Eingang
    Text_Function:=_('Audiomaster');
    Value:=maxres-masterform.volumeSlider.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[10].GUID) then
  begin // Audiomaster setzen
    Text_Function:=_('Audiomaster');
	  Text_Value:=mainform.levelstr(round(((100-AktuellerBefehl.ArgInteger[0])/100)*255));
    Value:=maxres-masterform.volumeSlider.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[11].GUID) then
  begin // Audiomaster abfragen
    Text_Function:=_('Audiomaster');
	  Text_Value:=_('abfragen');
    Value:=maxres-masterform.volumeSlider.Position;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[12].GUID) then
  begin // Audio-Mute ein/aus
    Text_Function:=_('Audio Mute');
    if Bass_GetVolume=0 then
  	  Text_Value:=_('aus')
    else
  	  Text_Value:=_('ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[13].GUID) then
  begin // MIDI-Befehl senden
    Text_Function:=_('MIDI-Befehl');
	  Text_Value:=_('senden');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[14].GUID) then
  begin // Eingangswert als MIDI-Befehl
    Text_Function:=_('MIDI-Wert');
	  Text_Value:=_('senden');
    Value:=Befehlssystem[3].Steuerung[14].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[15].GUID) then
  begin // Kanalsetzmodus wechseln
    Text_Function:=_('Kanalsetzmodus');
    case Kanalsetzmodus of
  	  0: Text_Value:=_('1 Einschalten');
  	  1: Text_Value:=_('2 Ausschalten');
  	  2: Text_Value:=_('3 Einblenden');
  	  3: Text_Value:=_('4 Ausblenden');
  	  4: Text_Value:=_('5 Flashen');
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[16].GUID) then
  begin // PC_DIMMER Programmfunktion
    Text_Function:=_('PCD-Funktion');
    case AktuellerBefehl.ArgInteger[0] of
  	  0: Text_Value:=_('Neu...'); // Neues Projekt...
  	  1: Text_Value:=_('Öffnen...'); // Projekt öffnen...
  	  2: Text_Value:=_('Speichern'); // Projekt speichern
  	  3: Text_Value:=_('Schnellspeichern'); // Projekt schnellspeichern
  	  4: Text_Value:=_('Speichern unter...'); // Projekt speichern unter...
  	  5: Text_Value:=_('Projektverwaltung'); // Projektverwaltung
  	  6: Text_Value:=_('Kanalnamen drucken'); // Kanalnamen ausdrucken
  	  7: Text_Value:=_('Beenden...'); // PC_DIMMER beenden...
  	  8: Text_Value:=_('Sperren...'); // PC_DIMMER sperren...
  	  9: Text_Value:=_('Kommandozeile'); // Fokus auf Kommandozeile
  	  10: Text_Value:=_('Entsperren...'); //
  {
  	  21: Kontrollpanel1Click(nil); // Kontrollpanel
  	  22: Effektsequenzer1Click(nil); // Effektsequenzer
  	  23: TBItem17Click(nil); // Synchrone Scannerbewegung
  	  24: TBItem25Click(nil); // Zeitgesteuerte Ereignisse
  	  25: Szenenverwaltung1Click(nil); // Szenenverwaltung
  	  26: Figureneditor1Click(nil); // Figureneditor
  	  27: TBItem20Click(nil); // Geräteeditor
  	  28: TBItem13Click(nil); // Audioeffektplayer
  	  29: Leistungssteuerung1Click(nil); // Leistungssteuerung
  	  30: Gertesteuerung2Click(nil); // Gerätesteuerung
  	  31: Bühnenansicht1Click(nil); // Bühnenansicht
  	  32: Submaster1Click(nil); // Submaster
  	  33: Joysticksteuerung1Click(nil); // Joysticksteuerung
  	  34: ResetWindowPositionsClick(nil); // Fensterpositionen resetten
  }
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[17].GUID) then
  begin // Externes Programm starten
    Text_Function:=_('Programm starten:');
    Text_Value:=AktuellerBefehl.ArgString[0];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[18].GUID) then
  begin // Freeze-Modus toggeln
    Text_Function:=_('Freeze-Mode');

    if IsFreezeMode then
    begin
  	  Text_Value:=_('aus');
    end else
    begin
  	  Text_Value:=_('ein');
    end;
  
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[19].GUID) then
  begin // Stoppe alle Effekte
    Text_Function:=_('Alle Effekte');
	  Text_Value:=_('stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[20].GUID) then
  begin // Partymodul-Preset wählen
    Text_Function:=_('Partymodul');
    if pmmform.presetbox.Items.Count>0 then
    begin
  	  if (AktuellerBefehl.ArgInteger[0]-1)<pmmform.presetbox.Items.Count then
  	  begin
        Text_Value:=pmmform.presetbox.Items[AktuellerBefehl.ArgInteger[0]-1];
  	  end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[21].GUID) then
  begin // Partymodul-Preset Zufallsmodus
    Text_Function:=_('Partymodul');
    Text_Value:=_('Zufallsmodus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[22].GUID) then
  begin // Blackout ein/aus
    Text_Function:=_('Blackout');
    Text_Value:=_('ein/aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[23].GUID) then
  begin // Ambilight ein
    Text_Function:=_('Ambilight');
    Text_Value:=_('ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[24].GUID) then
  begin // Ambilight aus
    Text_Function:=_('Ambilight');
    Text_Value:=_('aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[25].GUID) then
  begin // Zeitsteuerung ein
    Text_Function:=_('Zeitsteuerung');
    Text_Value:=_('ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[26].GUID) then
  begin // Zeitsteuerung aus
    Text_Function:=_('Zeitsteuerung');
    Text_Value:=_('aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[27].GUID) then
  begin // Alle Audioeffekte stoppen
    Text_Function:=_('Audioeffekte');
    Text_Value:=_('aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[28].GUID) then
  begin // Datei öffnen
    Text_Function:=_('Öffne');
    Text_Value:=AktuellerBefehl.ArgString[0];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[3].Steuerung[29].GUID) then
  begin // Benutzer wechseln
    Text_Function:=_('Benutzer');
    Text_Value:=_('wechseln');
    exit;
  end;

  // Einzelkanaländerung
  Text_PCD_Function:=_('Einzelkanal');
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[0].GUID) then
  begin // Eingangswert
    if AktuellerBefehl.ArgInteger[0]>0 then
    begin
      Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0])+' @';
      Text_Value:=_('Flash');
      Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[1].GUID) then
  begin // Fester Wert schalten
    if AktuellerBefehl.ArgInteger[0]>0 then
  	begin
      Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0])+' @';
	    Text_Value:=mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
      Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
	  end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[2].GUID) then
  begin // Abgefragter Wert schalten
    if AktuellerBefehl.ArgInteger[0]>0 then
  	begin
      Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0])+' @';
	    Text_Value:=_('abfragen');
      Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
	  end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[3].GUID) then
  begin // Wert dimmen
    if AktuellerBefehl.ArgInteger[0]>0 then
    begin
      Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0])+' DIM';
      Text_Value:=mainform.levelstr(AktuellerBefehl.ArgInteger[1])+' in '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[2]);
      Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[4].GUID) then
  begin // Abgefragten Wert dimmen
    if AktuellerBefehl.ArgInteger[0]>0 then
    begin
      Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0])+' DIM';
      Text_Value:=_('abfragen');
      Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[5].GUID) then
  begin // Kanalwert +
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:='+ '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[6].GUID) then
  begin // Kanalwert -
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:='- '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[7].GUID) then
  begin // Kanalminimum setzen Eingangswert
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:=_('Minimum');
    Value:=maxres-channel_minvalue[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[8].GUID) then
  begin // Kanalmaximum setzen Eingangswert
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:=_('Maximum');
    Value:=maxres-channel_maxvalue[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[9].GUID) then
  begin // Kanalminimum setzen
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:=_('Min')+': '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=maxres-channel_minvalue[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[10].GUID) then
  begin // Kanalmaximum setzen
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);
    Text_Value:=_('Max')+': '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=maxres-channel_maxvalue[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,Befehlssystem[4].Steuerung[11].GUID) then
  begin // Kanalwert setzen (Modusabhängig)
    Text_Function:=_('Ch ')+inttostr(AktuellerBefehl.ArgInteger[0]);

    case Kanalsetzmodus of
  	  0: Text_Value:='@ '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einschalten
  	  1: Text_Value:=mainform.levelstr(0); // Ausschalten
  	  2: Text_Value:='DIM '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einblenden
  	  3: Text_Value:='DIM '+mainform.levelstr(0); // Ausblenden
  	  4: Text_Value:='Flash '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // FLASH
    end;
    Value:=maxres-data.ch[AktuellerBefehl.ArgInteger[0]];
    exit;
  end;
  
  // Geräte / Gruppen
  Text_PCD_Function:=_('Geräte/Gruppen');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[0].GUID) then
  begin // Aktuell selektierte Geräte auf Eingangswert
    Text_Function:=_('Sel. Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+_('Wert');
    Value:=Befehlssystem[5].Steuerung[0].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[1].GUID) then
  begin // Aktuell selektierte Geräte auf Wert
    Text_Function:=_('Sel. Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[2].GUID) then
  begin // Bühnenansichtgerät auf Eingangswert
    Text_Function:=_('Bühnenansichtgerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+_('Wert');
    Value:=Befehlssystem[5].Steuerung[2].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[3].GUID) then
  begin // Bühnenansichtgerät auf Wert
    Text_Function:=_('Bühnenansichtgerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[4].GUID) then
  begin // Bestimmtes Gerät auf Eingangswert
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;//_('Gerätegruppe');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+_('Wert');
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[5].GUID) then
  begin // Bestimmte Gerätegruppe auf Eingangswert
    Text_Function:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;//_('Gerätegruppe');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+_('Wert');
    Value:=geraetesteuerung.get_group(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[6].GUID) then
  begin // Bestimmtes Gerät auf Wert schalten
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;//_('Gerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[7].GUID) then
  begin // Bestimmte Gerätegruppe auf Wert schalten
    Text_Function:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;//_('Gerätegruppe');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=geraetesteuerung.get_group(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[8].GUID) then
  begin // Bestimmtes Gerät auf Wert dimmen
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;//_('Gerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1])+' in '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[2]);
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[9].GUID) then
  begin // Bestimmte Gerätegruppe auf Wert dimmen
    Text_Function:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;//_('Gerätegruppe');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1])+' in '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[2]);
    Value:=geraetesteuerung.get_group(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[10].GUID) then
  begin // Selektierte Geräte +
    Text_Function:=_('Sel. Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' + '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[11].GUID) then
  begin // Selektierte Geräte -
    Text_Function:=_('Selektierte Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' - '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[12].GUID) then
  begin // Bühnenansichtgerät +
    Text_Function:=_('Bühnenansichtgerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' + '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[13].GUID) then
  begin // Bühnenansichtgerät -
    Text_Function:=_('Bühnenansichtgerät');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' - '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[14].GUID) then
  begin // Bestimmtes Gerät +
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;//_('Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' + '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[15].GUID) then
  begin // Bestimmtes Gerät -
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;//_('Geräte');
    Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' - '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[16].GUID) then
  begin // Selektierte Geräte setzen (Modusabhängig)
    Text_Function:=_('Sel. Geräte');
  
  	case Kanalsetzmodus of
  	  0: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einschalten
  	  1: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(0); // Ausschalten
  	  2: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einblenden
  	  3: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(0); // Ausblenden
  	  4: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' '+_('flash'); // Flash
  	end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[17].GUID) then
  begin // Bühnenansichtgerät setzen (Modusabhängig)
    Text_Function:=_('Bühnenansichtgerät');
  
  	case Kanalsetzmodus of
  	  0: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einschalten
  	  1: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(0); // Ausschalten
  	  2: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einblenden
  	  3: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(0); // Ausblenden
  	  4: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' '+_('flash'); // Flash
  	end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[18].GUID) then
  begin // Bestimmte Geräte setzen (Modusabhängig)
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
  
  	case Kanalsetzmodus of
  	  0: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einschalten
  	  1: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(0); // Ausschalten
  	  2: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einblenden
  	  3: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(0); // Ausblenden
  	  4: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' '+_('flash'); // Flash
  	end;
    Value:=geraetesteuerung.get_channel(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[19].GUID) then
  begin // Bestimmte Gerätegruppe setzen (Modusabhängig)
    Text_Function:=mainform.Devices[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;

  	case Kanalsetzmodus of
  	  0: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einschalten
  	  1: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(0); // Ausschalten
  	  2: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]); // Einblenden
  	  3: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'>'+mainform.levelstr(0); // Ausblenden
  	  4: Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+' '+_('flash'); // Flash
  	end;
    Value:=geraetesteuerung.get_group(AktuellerBefehl.ArgGUID[0],DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[20].GUID) then
  begin // Alle Kanaltypen auf Null setzen (Teil-Blackout)
    Text_Function:=_('Teilblackout');
  	Text_Value:=DeviceChannelNames[AktuellerBefehl.ArgInteger[0]]+'@'+mainform.levelstr(0)+' in '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[21].GUID) then
  begin // Aktuell selektierte Geräte 16-Bit PAN/TILT
    Text_Function:=_('Sel. Geräte');
  	Text_Value:='PAN/TILT';
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[22].GUID) then
  begin // Bühnenansichtgerät 16-Bit PAN/TILT
    Text_Function:=_('Bühnenansichtgerät');
  	Text_Value:='PAN/TILT';
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[23].GUID) then
  begin // Bestimmtes Gerät 16-Bit PAN/TILT
    Text_Function:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
  	Text_Value:='PAN/TILT';
    exit;
  end;
  
  // Geräte-/Gruppensetup
  Text_PCD_Function:=_('Gerätefunktionen');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[0].GUID) then
  begin // Selektiere nur dieses Gerät
    Text_Function:=_('Selektiere nur');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[1].GUID) then
  begin // Geräteselektion ein/aus
    Text_Function:=_('Selektion')+' '+_('ein/aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[2].GUID) then
  begin // Selektierung ein
    Text_Function:=_('Selektion')+' +';
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[3].GUID) then
  begin // Selektierung aus
    Text_Function:=_('Selektion')+' -';
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[4].GUID) then
  begin // Selektiere nur diese Gruppe
    Text_Function:=_('Selektiere nur');
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[5].GUID) then
  begin // Gruppenselektion ein/aus
    Text_Function:=_('Selektion')+' '+_('ein/aus');
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[6].GUID) then
  begin // Gruppenselektion ein
    Text_Function:=_('Selektion')+' +';
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[7].GUID) then
  begin // Gruppenselektion aus
    Text_Function:=_('Selektion')+' -';
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[8].GUID) then
  begin // Selektion aus
    Text_Function:=_('Selektion');
  	Text_Value:=_('aus');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[9].GUID) then
  begin // Kalibrierung setzen
    Text_Function:=_('Kalibrierung')+'@'+inttostr(AktuellerBefehl.ArgInteger[0]);
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[10].GUID) then
  begin // Kalibrierung setzen (Gruppe)
    Text_Function:=_('Kalibrierung')+'@'+inttostr(AktuellerBefehl.ArgInteger[0]);
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[11].GUID) then
  begin // Invert PAN ein/aus
    Text_Function:=_('Inv. PAN ein/aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[12].GUID) then
  begin // Invert PAN ein
    Text_Function:=_('Inv. PAN ein');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[13].GUID) then
  begin // Invert PAN aus
    Text_Function:=_('Inv. PAN aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[14].GUID) then
  begin // Invert TILT ein/aus
    Text_Function:=_('Inv. TILT ein/aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[15].GUID) then
  begin // Invert TILT ein
    Text_Function:=_('Inv. TILT ein');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[16].GUID) then
  begin // Invert TILT aus
    Text_Function:=_('Inv. TILT aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[17].GUID) then
  begin // Autoszenen ein/aus
    Text_Function:=_('Autoszene ein/aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[18].GUID) then
  begin // Autoszenen ein
    Text_Function:=_('Autoszene ein');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[19].GUID) then
  begin // Autoszenen aus
    Text_Function:=_('Autoszene aus');
  	Text_Value:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[20].GUID) then
  begin // Gruppe aktiviert/deaktiviert
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;

	if mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Active then
      Text_Function:=_('Gruppe aus')
	else
      Text_Function:=_('Gruppe ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[21].GUID) then
  begin // Gruppe aktiviert
    Text_Function:=_('Gruppe ein');
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[22].GUID) then
  begin // Gruppe deaktiviert
    Text_Function:=_('Gruppe aus');
  	Text_Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].Name;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[23].GUID) then
  begin // Gruppe Fanning-Modus
    Text_Function:=_('Gruppe Fanning-Modus');

    case mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].FanMode of
        0: Text_Value:=_('Aus');
        1: Text_Value:=_('Gleichmäßig nach Links und Rechs');
        2: Text_Value:=_('Nur nach Rechts');
        3: Text_Value:=_('Nur nach Links');
        4: Text_Value:=_('Sinus nach Links und Rechts');
        5: Text_Value:=_('Tangens');
        6: Text_Value:=_('Tangens 2');
        7: Text_Value:=_('Von Außen nach Innen');
    end;
    Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].FanMode;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[24].GUID) then
  begin // Gruppe Fanning-Master
    Text_Function:=_('Gruppe Fanning-Master');
    Value:=Befehlssystem[6].Steuerung[24].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[25].GUID) then
  begin // Gruppe Fanning-Modus
    Text_Function:=_('Gruppe Fanning-Modus');

    case mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].FanMode of
        0: Text_Value:=_('Aus');
        1: Text_Value:=_('Gleichmäßig nach Links und Rechs');
        2: Text_Value:=_('Nur nach Rechts');
        3: Text_Value:=_('Nur nach Links');
        4: Text_Value:=_('Sinus nach Links und Rechts');
        5: Text_Value:=_('Tangens');
        6: Text_Value:=_('Tangens 2');
        7: Text_Value:=_('Von Außen nach Innen');
    end;
    Value:=mainform.DeviceGroups[geraetesteuerung.GetGroupPositionInGroupArray(AktuellerBefehl.ArgGUID[0])].FanMode;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[26].GUID) then
  begin // Gruppe Fanning-Master
    Text_Function:=_('Gruppe Fanning-Master');
    Value:=Befehlssystem[6].Steuerung[26].CurrentValue;
    exit;
  end;

  // Cueliste
  Text_PCD_Function:=_('Cuelist');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[0].GUID) then
  begin // Start
    Text_Function:=_('Start');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[1].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[2].GUID) then
  begin // Abspielen und nächstes Selektieren
    Text_Function:=_('Step');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[3].GUID) then
  begin // Vorheriges Objekt abspielen 
    Text_Function:=_('Cue -');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[4].GUID) then
  begin // Nächstes Objekt abspielen
    Text_Function:=_('Cue +');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[5].GUID) then
  begin // Vorherige Bank
    Text_Function:=_('Bank -');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[6].GUID) then
  begin // Nächste Bank
    Text_Function:=_('Bank +');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[7].GUID) then
  begin // Record-Button
    Text_Function:=_('Aufzeichnen');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[8].GUID) then
  begin // Crossfader verstellen
    Text_Function:=_('Crossfader');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[9].GUID) then
  begin // An den Anfang springen
    Text_Function:=_('Zum Anfang');
    exit;
  end;
  
  // Videoscreen
  Text_PCD_Function:=_('Videoscreen');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[0].GUID) then
  begin // Play
    Text_Function:=_('Play');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[1].GUID) then
  begin // Play von Beginn
    Text_Function:=_('Start von vorne');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[2].GUID) then
  begin // Pause
    Text_Function:=_('Pause');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[3].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[4].GUID) then
  begin // Springe zu Position
    Text_Function:=_('Zu Position');
	Text_Value:=mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  
  // Effekte
  Text_PCD_Function:=_('Effekte');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[0].GUID) then
  begin // Start/Stop
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Value:=effektsequenzereffekte[j].Name;
        if AktuellerEffekt[j].Aktiv then
          Text_Function:=_('Stop')
        else
          Text_Function:=_('Start');
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[1].GUID) then
  begin // Start
    Text_Function:=_('Start');
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[2].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[3].GUID) then
  begin // Flash
    Text_Function:=_('Flash');
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[4].GUID) then
  begin // Nächster Schritt
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Function:=_('Schritt +');
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
      end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[5].GUID) then
  begin // Bestimmten Schritt starten
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) and (AktuellerBefehl.ArgInteger[0]<length(effektsequenzereffekte[j].Effektschritte)) then
      begin
        Text_Function:=_('Schritt')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[6].GUID) then
  begin // Intensität setzen
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Function:=_('Intensität')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[7].GUID) then
  begin // Intensität auf Eingangswert setzen
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Function:=_('Intensität')+'@'+_('Wert');
        Text_Value:=effektsequenzereffekte[j].Name;
        Value:=Befehlssystem[9].Steuerung[7].CurrentValue;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[8].GUID) then
  begin // Beschleunigung setzen
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Function:=_('Speed')+' '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[9].GUID) then
  begin // Wiederholung ein/aus
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Value:=effektsequenzereffekte[j].Name;
        if effektsequenzereffekte[j].Repeating then
          Text_Function:=_('Wiederholung')+' '+_('aus')
        else
          Text_Function:=_('Wiederholung')+' '+_('ein');
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[10].GUID) then
  begin // Modus setzen
    for j:=0 to length(effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0],effektsequenzereffekte[j].ID) then
      begin
        Text_Function:=_('Modus')+' @ '+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=effektsequenzereffekte[j].Name;
        break;
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[11].GUID) then
  begin // Alle Effekte stoppen
    Text_Function:=_('Alle Effekte');
  	Text_Value:=_('stoppen');
    exit;
  end;

  // Submaster
  Text_PCD_Function:=_('Submaster');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[0].GUID) then
  begin // Auf Eingangswert schalten
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+'@'+_('Wert');
    Value:=Befehlssystem[10].Steuerung[0].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[1].GUID) then
  begin // Auf festen Wert schalten
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+'@'+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[2].GUID) then
  begin // Auf festen Wert flashen
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+' flash '+mainform.levelstr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[3].GUID) then
  begin // Auf abgefragten Wert schalten
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+'@?';
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[4].GUID) then
  begin // Faderwert +
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+' +';
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[5].GUID) then
  begin // Faderwert -
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<17) then
      Text_Function:=_('Submaster')+' '+inttostr(AktuellerBefehl.ArgInteger[0])+' -';
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[6].GUID) then
  begin // Vorherige Bank
    Text_Function:=_('Bank -');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[7].GUID) then
  begin // Nächste Bank
    Text_Function:=_('Bank +');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[8].GUID) then
  begin // Bestimmte Bank
    if (AktuellerBefehl.ArgInteger[0]>0) and (AktuellerBefehl.ArgInteger[0]<submasterform.BankSelect.Items.Count+1) then
    begin
	    Text_Function:=_('Bank')+' @ '+inttostr(AktuellerBefehl.ArgInteger[0]);
    end;
    exit;
  end;

  // Kontrollpanel
  Text_PCD_Function:=_('Kontrollpanel');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[11].Steuerung[0].GUID) then
  begin // Button schalten
  	Text_Function:=_('Button schalten');
	  Text_Value:=inttostr(AktuellerBefehl.ArgInteger[1])+'x'+inttostr(AktuellerBefehl.ArgInteger[0]);
    if kontrollpanel.IsButtonActive(AktuellerBefehl.ArgInteger[0]-1, AktuellerBefehl.ArgInteger[1]-1) then
      Value:=255
    else
      Value:=0;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[11].Steuerung[1].GUID) then
  begin // Button ein/aus
	  Text_Function:=_('Button ein/aus');
	  Text_Value:=inttostr(AktuellerBefehl.ArgInteger[1])+'x'+inttostr(AktuellerBefehl.ArgInteger[0]);
    if kontrollpanel.IsButtonActive(AktuellerBefehl.ArgInteger[0]-1, AktuellerBefehl.ArgInteger[1]-1) then
      Value:=255
    else
      Value:=0;
    exit;
  end;

  // Joysticksteuerung
  Text_PCD_Function:=_('Joystick');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[0].GUID) then
  begin // Positionierung absolut/relativ
    if joystickevents[AktuellerBefehl.ArgInteger[0]].positionrelativ then
	    Text_Function:=_('Position absolut')
  	else
	    Text_Function:=_('Position relativ');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[1].GUID) then
  begin // Positionierung absolut
    joystickevents[AktuellerBefehl.ArgInteger[0]].positionrelativ:=false;
    Text_Function:=_('Position absolut');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[2].GUID) then
  begin // Positionierung relativ
  	Text_Function:=_('Position relativ');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[3].GUID) then
  begin // Position zentrieren
    Text_Function:=_('Position zentrieren');
    exit;
  end;

  // NodeControl
  Text_PCD_Function:=_('Nodecontrol');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[0].GUID) then
  begin // Knotenset abrufen
    Text_Function:=_('KnotenSet')+' @ '+inttostr(AktuellerBefehl.ArgInteger[0]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[1].GUID) then
  begin // Knotenposition X auf Wert setzen
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      if (AktuellerBefehl.ArgInteger[1]<length(mainform.NodeControlSets[AktuellerBefehl.ArgInteger[0]].NodeControlNodes)) then
      begin
        Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=_('X @ ')+inttostr(AktuellerBefehl.ArgInteger[1]);
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[2].GUID) then
  begin // Knotenposition Y auf Wert setzen
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
      begin
      if (AktuellerBefehl.ArgInteger[1]<length(mainform.NodeControlSets[AktuellerBefehl.ArgInteger[0]].NodeControlNodes)) then
      begin
        Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=_('Y @ ')+inttostr(AktuellerBefehl.ArgInteger[1]);
      end;
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[3].GUID) then
  begin // Knotenausdehnung auf Wert setzen
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
  	  Text_Value:=_('Ausdehnung @ ')+inttostr(AktuellerBefehl.ArgInteger[1]);
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[4].GUID) then
  begin // Knotenkontrast auf Wert setzen
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
	    Text_Value:=_('Kontrast @ ')+inttostr(AktuellerBefehl.ArgInteger[1]);
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[5].GUID) then
  begin // Knotenfadezeit auf Wert setzen
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
	    Text_Value:=_('Fadetime @ ')+mainform.MillisecondsToTimeShort(AktuellerBefehl.ArgInteger[1]);
    end;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[6].GUID) then
  begin // Knotenposition X auf Eingangswert
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      if (AktuellerBefehl.ArgInteger[1]<length(mainform.NodeControlSets[AktuellerBefehl.ArgInteger[0]].NodeControlNodes)) then
      begin
        Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=_('X @ Wert');
      end;
    end;
    Value:=Befehlssystem[13].Steuerung[6].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[7].GUID) then
  begin // Knotenposition Y auf Eingangswert
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      if (AktuellerBefehl.ArgInteger[1]<length(mainform.NodeControlSets[AktuellerBefehl.ArgInteger[0]].NodeControlNodes)) then
      begin
        Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
        Text_Value:=_('Y @ Wert');
      end;
    end;
    Value:=Befehlssystem[13].Steuerung[7].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[8].GUID) then
  begin // Knotenausdehnung auf Eingangswert
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
  	  Text_Value:=_('Ausdehnung @ Wert');
    end;
    Value:=Befehlssystem[13].Steuerung[8].CurrentValue;
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[9].GUID) then
  begin // Knotenkontrast auf Eingangswert
    if (AktuellerBefehl.ArgInteger[0]<length(mainform.NodeControlSets)) then
    begin
      Text_Function:=_('KnotenSet')+' '+inttostr(AktuellerBefehl.ArgInteger[0]);
	    Text_Value:=_('Kontrast @ Wert');
    end;
    Value:=Befehlssystem[13].Steuerung[9].CurrentValue;
    exit;
  end;

  // CD-Player
  Text_PCD_Function:=_('CD-Player');
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[0].GUID) then
  begin // Play
    Text_Function:=_('Play');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[1].GUID) then
  begin // Pause
    Text_Function:=_('Pause');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[2].GUID) then
  begin // Stop
    Text_Function:=_('Stop');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[3].GUID) then
  begin // Prev
    Text_Function:=_('|< Titel');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[4].GUID) then
  begin // Next
    Text_Function:=_('Titel >|');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[5].GUID) then
  begin // Play specific Title
    Text_Function:=_('Play Titel ')+inttostr(AktuellerBefehl.ArgInteger[1]);
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[6].GUID) then
  begin // Repeat
    if cdplayerform.audioplayer_alsschleife.Checked then
  	  Text_Function:=_('Repeat aus')
	  else
	    Text_Function:=_('Repeat ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[7].GUID) then
  begin // Random
    if cdplayerform.shuffle.Checked then
  	  Text_Function:=_('Zufall aus')
	  else
	    Text_Function:=_('Zufall ein');
    exit;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[8].GUID) then
  begin // Open tray
    Text_Function:=_('Eject');
    exit;
  end;

  Text_PCD_Function:='';
  Text_Function:='';
  Text_Value:='';
  Value:=-1;
