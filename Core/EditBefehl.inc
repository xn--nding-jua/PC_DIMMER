  AktuellerBefehl.Typ:=Befehlposition[Combobox2.Itemindex].GUID;

  setlength(AktuellerBefehl.ArgInteger, Befehlposition[Combobox2.Itemindex].IntegerArgCount);
  setlength(AktuellerBefehl.ArgString, Befehlposition[Combobox2.Itemindex].StringArgCount);
  setlength(AktuellerBefehl.ArgGUID, Befehlposition[Combobox2.Itemindex].GUIDArgCount);

  nousersetting:=true;

  if midisettings then
  begin
    OnValue.Value:=(AktuellerBefehl.OnValue div 2);
    SwitchValue.Value:=(AktuellerBefehl.SwitchValue div 2);
    InvertSwitchValue.checked:=(AktuellerBefehl.InvertSwitchValue);
    OffValue.Value:=(AktuellerBefehl.OffValue div 2);
    ScaleValue.checked:=AktuellerBefehl.ScaleValue;
  end else
  begin
    OnValue.Value:=AktuellerBefehl.OnValue;
    SwitchValue.Value:=AktuellerBefehl.SwitchValue;
    InvertSwitchValue.Checked:=AktuellerBefehl.InvertSwitchValue;
    OffValue.Value:=AktuellerBefehl.OffValue;
    ScaleValue.checked:=AktuellerBefehl.ScaleValue;
  end;

  effektlist.Visible:=false;
  grouplist.visible:=false;
  devicelist.visible:=false;

  Optionen1Box.Visible:=false;
  Arg1Combobox.visible:=false;
  Arg1Edit.Visible:=true;

  Optionen2Box.Visible:=false;
  Arg2Combobox.visible:=false;
  Arg2Edit.Visible:=true;

  Optionen3Box.Visible:=false;
  Arg3Combobox.visible:=false;
  Arg3Edit.Visible:=true;

  ZeitBox.Visible:=false;

  if length(AktuellerBefehl.ArgGUID)>0 then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0], mainform.devices[i].ID) then
      begin
        devicelist.itemindex:=i;
        break;
      end;
    end;
    for i:=0 to length(mainform.devicegroups)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0], mainform.devicegroups[i].ID) then
      begin
        grouplist.itemindex:=i;
        break;
      end;
    end;
    for i:=0 to length(mainform.Effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0], mainform.Effektsequenzereffekte[i].ID) then
      begin
        effektlist.itemindex:=i;
        break;
      end;
    end;
  end;

  // Audioeffektplayer
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[0].GUID) then
  begin // Start/stop
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[1].GUID) then
  begin // Start
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[2].GUID) then
  begin // Stop
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[3].GUID) then
  begin // Springe zu Position
    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[4].GUID) then
  begin // Repeat ein/aus
    nousersetting:=false;
  end; // Aufnahme ein/aus
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[5].GUID) then
  begin
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[6].GUID) then
  begin // Effekte ein/aus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[7].GUID) then
  begin // Vorherige Audiodatei
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[8].GUID) then
  begin // Nächste Audiodatei
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[9].GUID) then
  begin // Springe zu Audiodatei
    Optionen1Box.Visible:=true;
    Arg1Edit.Visible:=false;
    Arg1Combobox.Visible:=true;
    Arg1Combobox.items.clear;
    for i:=0 to length(mainform.Effektaudio_record)-1 do
      Arg1Combobox.items.add(ExtractFilename(mainform.Effektaudio_record[i].audiodatei));
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Label.Caption:=_('Audiodatei:');
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[0].Steuerung[10].GUID) then
  begin // Springe zu Audiodatei
    Optionen1Box.Visible:=true;
    Arg1Edit.Visible:=false;
    Arg1Combobox.Visible:=true;
    Arg1Combobox.items.clear;
    for i:=0 to length(mainform.Effektaudio_record)-1 do
      Arg1Combobox.items.add(ExtractFilename(mainform.Effektaudio_record[i].audiodatei));
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Label.Caption:=_('Audiodatei:');
    nousersetting:=false;
  end;

//  if not nousersetting then
  // Szenen
  if ManualEditingOfCombobox2 then
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[1].Steuerung[0].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[1].Steuerung[1].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[1].Steuerung[2].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[1].Steuerung[3].GUID) then
  begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=AktuellerBefehl.ArgGUID[0];
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;

    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then
      begin
        szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
        setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
        exit;
      end;
      SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

      case SzenenData^.NodeType of
        0..4,6..11:
        begin
          AktuellerBefehl.ArgGUID[0]:=SzenenData^.ID;
        end;
        5:
        begin
        // Kompositionsszene
          cancel:=false;
          for i:=0 to length(mainform.Kompositionsszenen)-1 do
            if IsEqualGUID(mainform.Kompositionsszenen[i].ID,SzenenData^.ID) then
              for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
              begin
                if (IsEqualGUID(mainform.Kompositionsszenen[i].IDs[j],AktuellerBefehl.ID)) and (GUIDtoString(AktuellerBefehl.ID)<>'{00000000-0000-0000-0000-000000000000}') then
                begin
                  MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                  cancel:=true;
                end;
              end;
          if not cancel then
          begin
            ShowMessage(_('Bitte stellen Sie sicher, dass die Kombinationsszene die Sie gerade hinzufügen möchten nicht den gerade zu bearbeitenden Befehl aufruft.')+#10+_('Ringaufrufe können nicht vollständig erkannt werden und führen zum Absturz.'));
            AktuellerBefehl.ArgGUID[0]:=SzenenData^.ID;
          end;
        end;
      end;
    end;
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
    nousersetting:=false;
  end;

//  if not nousersetting then
  if ManualEditingOfCombobox2 then
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[1].Steuerung[4].GUID) then
  begin // Szenenzeit festlegen
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=AktuellerBefehl.ArgGUID[0];
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;

    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
    begin
      if (szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0) then
      begin
        szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
        setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
        exit;
      end;
      
      SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.FocusedNode);

      case SzenenData^.NodeType of
        0..4,6..11:
        begin
          AktuellerBefehl.ArgGUID[0]:=SzenenData^.ID;
        end;
        5:
        begin
        // Kompositionsszene
          cancel:=false;
          for i:=0 to length(mainform.Kompositionsszenen)-1 do
            if IsEqualGUID(mainform.Kompositionsszenen[i].ID,SzenenData^.ID) then
              for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
              begin
                if (IsEqualGUID(mainform.Kompositionsszenen[i].IDs[j],AktuellerBefehl.ID)) and (GUIDtoString(AktuellerBefehl.ID)<>'{00000000-0000-0000-0000-000000000000}') then
                begin
                  MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                  cancel:=true;
                end;
              end;
          if not cancel then
          begin
            ShowMessage(_('Bitte stellen Sie sicher, dass die Kombinationsszene die Sie gerade hinzufügen möchten nicht den gerade zu bearbeitenden Befehl aufruft.')+#10+_('Ringaufrufe können nicht vollständig erkannt werden und führen zum Absturz.'));
            AktuellerBefehl.ArgGUID[0]:=SzenenData^.ID;
          end;
        end;
      end;
    end;
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);

    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);
    nousersetting:=false;
  end;

  // Beattool
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[0].GUID) then
  begin // Sync-Button
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[1].GUID) then
  begin // BPM-Wert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('BPM-Wert [Wert in BPM]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[2].GUID) then
  begin // BPM-Wert abfragen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[3].GUID) then
  begin // Beat auslösen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[4].GUID) then
  begin // Beatquelle setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Beatquelle:');
    Arg1Combobox.Clear;
    for i:=0 to beatform.Temposourcebox.items.count-1 do
      Arg1Combobox.items.add(beatform.Temposourcebox.items[i]);
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[5].GUID) then
  begin // Temposlider setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Temposlider [Wert 1...599]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[2].Steuerung[6].GUID) then
  begin // Temposlider auf Eingangswert
    nousersetting:=false;
  end;

  // Master / MIDI / Programm
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[0].GUID) then
  begin // Grandmaster auf Eingang
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[1].GUID) then
  begin // Grandmaster setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Wert [0..100]');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[2].GUID) then
  begin // Grandmaster abfragen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[3].GUID) then
  begin // Flashmaster auf Eingang
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[4].GUID) then
  begin // Flashmaster setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Wert [0..100]');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[5].GUID) then
  begin // Flashmaster auf abfragen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[6].GUID) then
  begin // Speedmaster auf Eingang
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[7].GUID) then
  begin // Speedmaster setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Wert [-100..0..100]');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[8].GUID) then
  begin // Speedmaster abfragen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[9].GUID) then
  begin // Audiomaster auf Eingang
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[10].GUID) then
  begin // Audiomaster setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Wert [0..100]');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[11].GUID) then
  begin // Audiomaster abfragen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[12].GUID) then
  begin // Audio-Mute ein/aus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[13].GUID) then
  begin // MIDI-Befehl senden
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Optionen3Box.Visible:=true;
    Arg1Label.Caption:=_('Message-Typ (144=Noten):');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Label.Caption:=_('Data1 (Ton):');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    Arg3Label.Caption:=_('Data2 (Volume)');
    Arg3Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[2]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[14].GUID) then
  begin // Eingangswert als MIDI-Befehl
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Optionen3Box.Visible:=true;
    Arg1Label.Caption:='MSG (-1=Input):';
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Label.Caption:='Data1 (-1=Input):';
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    Arg3Label.Caption:='Data2 (-1=Input)';
    Arg3Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[2]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[15].GUID) then
  begin // Kanalsetzmodus wechseln
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[16].GUID) then
  begin // PC_DIMMER Programmfunktion
    Optionen1Box.Visible:=true;
    Arg1Edit.visible:=false;
    Arg1Combobox.items.clear;
    for i:=0 to length(mainform.programmfunktionen)-1 do
      Arg1Combobox.items.add(mainform.programmfunktionen[i]);
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Label.caption:=_('Programmfunktion:');
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[17].GUID) then
  begin // Externes Programm starten
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Programmaufruf:');
    Arg1Edit.visible:=true;
    Arg1Edit.text:=AktuellerBefehl.ArgString[0];
    Arg1Combobox.visible:=false;

    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Parameter:');
    Arg2Edit.visible:=true;
    Arg2Edit.text:=AktuellerBefehl.ArgString[1];
    Arg2Combobox.visible:=false;

    Optionen3Box.Visible:=true;
    Arg3Label.caption:=_('Startmodus:');
    Arg3Edit.visible:=false;
    Arg3Combobox.visible:=true;
    Arg3Combobox.items.clear;
    Arg3Combobox.items.add('Normal');
    Arg3Combobox.items.add('Minimiert');
    Arg3Combobox.items.add('Maximiert');
    Arg3Combobox.items.add('Versteckt');
    Arg3Combobox.itemindex:=AktuellerBefehl.ArgInteger[2];
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[18].GUID) then
  begin // Freeze-Mode
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[19].GUID) then
  begin // Stoppe alle Effekte
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[20].GUID) then
  begin // Partymodul-Preset wählen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:='Presetnummer:';
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[21].GUID) then
  begin // Partymodul-Preset Zufallsmodus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[22].GUID) then
  begin // Blackout ein/aus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[23].GUID) then
  begin // Ambilight ein
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[24].GUID) then
  begin // Ambilight aus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[25].GUID) then
  begin // Zeitsteuerung ein
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[26].GUID) then
  begin // Zeitsteuerung aus
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[27].GUID) then
  begin // Alle Audioeffekte stoppen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[28].GUID) then
  begin // Datei öffnen
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Datei öffnen:');
    Arg1Edit.visible:=true;
    Arg1Edit.text:=AktuellerBefehl.ArgString[0];
    Arg1Combobox.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[3].Steuerung[29].GUID) then
  begin // Benutzer wechseln
    nousersetting:=false;
  end;

  // Einzelkanaländerung
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[0].GUID) then
  begin // Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[1].GUID) then
  begin // Fester Wert schalten
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[2].GUID) then
  begin // Abgefragter Wert schalten
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[3].GUID) then
  begin // Wert dimmen
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[4].GUID) then
  begin // Abgefragten Wert dimmen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[5].GUID) then
  begin // Kanalwert +
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg2Label.Caption:=_('Inkrement:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[6].GUID) then
  begin // Kanalwert -
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg2Label.Caption:=_('Dekrement:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[7].GUID) then
  begin // Kanalminimum setzen Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[8].GUID) then
  begin // Kanalmaximum setzen Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[9].GUID) then
  begin // Kanalminimum setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[10].GUID) then
  begin // Kanalmaximum setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[4].Steuerung[11].GUID) then
  begin // Kanalwert setzen (Modusabhängig)
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Kanal:');
    Arg2Label.Caption:=_('Wert [-1, 0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;

  // Geräte / Gruppen
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[0].GUID) then
  begin // Aktuell selektierte Geräte auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[1].GUID) then
  begin // Aktuell selektierte Geräte auf Wert
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[2].GUID) then
  begin // Bühnenansichtgerät auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[3].GUID) then
  begin // Bühnenansichtgerät auf Wert
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[4].GUID) then
  begin // Bestimmtes Gerät auf Eingangswert
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[5].GUID) then
  begin // Bestimmte Gerätegruppe auf Eingangswert
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[6].GUID) then
  begin // Bestimmtes Gerät auf Wert schalten
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[7].GUID) then
  begin // Bestimmte Gerätegruppe auf Wert schalten
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[8].GUID) then
  begin // Bestimmtes Gerät auf Wert dimmen
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    FillTimeBox(AktuellerBefehl.ArgInteger[2]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[9].GUID) then
  begin // Bestimmte Gerätegruppe auf Wert dimmen
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    Optionen2Box.visible:=true;
    Arg2Label.caption:=_('Wert [0..255]');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    FillTimeBox(AktuellerBefehl.ArgInteger[2]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[10].GUID) then
  begin // Selektierte Geräte +
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Inkrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[11].GUID) then
  begin // Selektierte Geräte -
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Dekrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[12].GUID) then
  begin // Bühnenansichtgerät +
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Inkrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[13].GUID) then
  begin // Bühnenansichtgerät -
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Dekrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[14].GUID) then
  begin // Bestimmtes Gerät +
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Inkrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[15].GUID) then
  begin // Bestimmtes Gerät -
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Dekrement:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[16].GUID) then
  begin // Selektierte Geräte setzen (Modusabhängig)
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Wert [-1, 0..255]:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[17].GUID) then
  begin // Bühnenansichtgerät setzen (Modusabhängig)
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Wert [-1, 0..255]:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[18].GUID) then
  begin // Bestimmte Geräte setzen (Modusabhängig)
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Wert [-1, 0..255]:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[19].GUID) then
  begin // Bestimmte Gerätegruppe setzen (Modusabhängig)
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Optionen2Box.Visible:=true;
    Arg2Label.caption:=_('Wert [-1, 0..255]:');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[20].GUID) then
  begin // Kanaltyp auf Null (Teil-Blackout)
    Optionen1Box.Visible:=true;
    Arg1Label.caption:=_('Kanal:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;

    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[21].GUID) then
  begin // Aktuell selektierte Geräte 16-Bit PAN/TILT
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.caption:=_('Art:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.items[0]:='16-Bit PAN';
    Arg1Combobox.items[1]:='16-Bit TILT';
    Arg1Combobox.items[2]:='16-Bit PAN';
    Arg1Combobox.items[3]:='16-Bit TILT';
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Arg2Label.caption:=_('Änderungsfaktor (x/1000stel):');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[22].GUID) then
  begin // Bühnenansichtgerät 16-Bit PAN/TILT
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.caption:=_('Art:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.items[0]:='16-Bit PAN';
    Arg1Combobox.items[1]:='16-Bit TILT';
    Arg1Combobox.items[2]:='16-Bit PAN';
    Arg1Combobox.items[3]:='16-Bit TILT';
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Arg2Label.caption:=_('Änderungsfaktor (x/1000stel):');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[5].Steuerung[23].GUID) then
  begin // Bestimmtes Gerät 16-Bit PAN/TILT
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.caption:=_('Art:');
    Arg1Combobox.Items.clear;
    for i:=0 to length(mainform.DeviceChannelNames)-1 do
      Arg1Combobox.items.add(mainform.DeviceChannelNames[i]);
    Arg1Combobox.items[0]:='16-Bit PAN';
    Arg1Combobox.items[1]:='16-Bit TILT';
    Arg1Combobox.items[2]:='16-Bit PAN';
    Arg1Combobox.items[3]:='16-Bit TILT';
    Arg1Combobox.itemindex:=AktuellerBefehl.ArgInteger[0];
    Arg1Combobox.visible:=true;
    Arg1Edit.visible:=false;
    Arg2Label.caption:=_('Änderungsfaktor (x/1000stel):');
    Arg2Edit.text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;

  // Geräte-/Gruppensetup
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[0].GUID) then
  begin // Selektiere nur dieses Gerät
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[1].GUID) then
  begin // Geräteselektion ein/aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[2].GUID) then
  begin // Selektierung ein
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[3].GUID) then
  begin // Selektierung aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[4].GUID) then
  begin // Selektiere nur diese Gruppe
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[5].GUID) then
  begin // Gruppenselektion ein/aus
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[6].GUID) then
  begin // Gruppenselektion ein
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[7].GUID) then
  begin // Gruppenselektion aus
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[8].GUID) then
  begin // Keine Selektion aus
    grouplist.visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[9].GUID) then
  begin // Kalibrierung setzen
    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kalibrierung:');
    Arg1Combobox.Visible:=true;
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add(_('Deaktiviert'));
    for i:=1 to 16 do
    begin
      if (devicelist.itemindex>-1) and (devicelist.itemindex<length(mainform.devices)) and (mainform.devices[devicelist.itemindex].scannercalibrations[i].name<>'') then
        Arg1Combobox.Items.Add(mainform.devices[devicelist.itemindex].scannercalibrations[i].name)
      else
        Arg1Combobox.Items.Add(_('Kalibrierung ')+inttostr(i));
    end;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[10].GUID) then
  begin // Kalibrierung setzen (Gruppe)
    grouplist.visible:=true;
//    devicelist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Kalibrierung:');
    Arg1Combobox.Visible:=true;
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add(_('Deaktiviert'));
    for i:=1 to 16 do
    begin
      Arg1Combobox.Items.Add(_('Kalibrierung ')+inttostr(i));
    end;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[11].GUID) then
  begin // Invert PAN ein/aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[12].GUID) then
  begin // Invert PAN ein
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[13].GUID) then
  begin // Invert PAN aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[14].GUID) then
  begin // Invert TILT ein/aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[15].GUID) then
  begin // Invert TILT ein
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[16].GUID) then
  begin // Invert TILT aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[17].GUID) then
  begin // Autoszenen ein/aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[18].GUID) then
  begin // Autoszenen ein
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[19].GUID) then
  begin // Autoszenen aus
    devicelist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[20].GUID) then
  begin // Gruppe aktiviert/deaktiviert
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[21].GUID) then
  begin // Gruppe aktiviert
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[22].GUID) then
  begin // Gruppe deaktiviert
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[23].GUID) then
  begin // Gruppe Fanning-Modus auf Eingangswert
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[24].GUID) then
  begin // Gruppe Fanning-Master auf Eingangswert
    grouplist.visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[25].GUID) then
  begin // Gruppe Fanning-Modus setzen
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Fanning-Modus');
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add(_('Aus'));
    Arg1Combobox.Items.Add(_('Gleichmäßig nach Links und Rechs'));
    Arg1Combobox.Items.Add(_('Nur nach Rechts'));
    Arg1Combobox.Items.Add(_('Nur nach Links'));
    Arg1Combobox.Items.Add(_('Sinus nach Links und Rechts'));
    Arg1Combobox.Items.Add(_('Tangens'));
    Arg1Combobox.Items.Add(_('Tangens 2'));
    Arg1Combobox.Items.Add(_('Von Außen nach Innen'));
    Arg1Combobox.ItemIndex:=AktuellerBefehl.ArgInteger[0]-1;
    Arg1Combobox.Visible:=true;
    Arg1Edit.Visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[6].Steuerung[26].GUID) then
  begin // Gruppe Fanning-Master setzen
    grouplist.visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;

  // Cueliste
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[0].GUID) then
  begin // Start
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[1].GUID) then
  begin // Stop
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[2].GUID) then
  begin // Abspielen und nächstes selektieren
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[3].GUID) then
  begin // Vorheriges Objekt abspielen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[4].GUID) then
  begin // Nächstes Objekt abspielen
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[5].GUID) then
  begin // Vorherige Bank
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[6].GUID) then
  begin // Nächste Bank
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[7].Steuerung[9].GUID) then
  begin // An den Anfang springen
    nousersetting:=false;
  end;

  // Videoscreen
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[0].GUID) or // Play
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[1].GUID) or // Play von Beginn
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[2].GUID) or // Pause
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[3].GUID) then // Stop
  begin
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Videoscreen Nr.');
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add('1');
    Arg1Combobox.Items.Add('2');
    Arg1Combobox.Items.Add('3');
    Arg1Combobox.Items.Add('4');
    Arg1Combobox.ItemIndex:=AktuellerBefehl.ArgInteger[0]-1;
    Arg1Combobox.Visible:=true;
    Arg1Edit.Visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[8].Steuerung[4].GUID) then
  begin // Springe zu Position
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Videoscreen Nr.');
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add('1');
    Arg1Combobox.Items.Add('2');
    Arg1Combobox.Items.Add('3');
    Arg1Combobox.Items.Add('4');
    Arg1Combobox.ItemIndex:=AktuellerBefehl.ArgInteger[0]-1;
    Arg1Combobox.Visible:=true;
    Arg1Edit.Visible:=false;

    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);
    nousersetting:=false;
  end;

  // Effekte
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[0].GUID) then
  begin // Start/Stop
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[1].GUID) then
  begin // Start
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[2].GUID) then
  begin // Stop
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[3].GUID) then
  begin // Flash
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[4].GUID) then
  begin // Nächster Schritt
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[5].GUID) then
  begin // Bestimmten Schritt starten
    effektlist.Visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Combobox.Visible:=true;
    Arg1Combobox.Clear;

    for i:=0 to length(mainform.effektsequenzereffekte)-1 do
    begin
      if IsEqualGUID(AktuellerBefehl.ArgGUID[0], mainform.effektsequenzereffekte[i].ID) then
      begin
        for j:=0 to length(mainform.effektsequenzereffekte[i].Effektschritte)-1 do
        begin
          Arg1Combobox.Items.Add(mainform.effektsequenzereffekte[i].Effektschritte[j].Name);
        end;
        break;
      end;
    end;

    Arg1Combobox.ItemIndex:=AktuellerBefehl.ArgInteger[0]-1;
    Arg1Label.Caption:=_('Schritt:');
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[6].GUID) then
  begin // Intensität setzen
    effektlist.Visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Intensität [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[7].GUID) then
  begin // Intensität auf Eingangswert
    effektlist.Visible:=true;
    Optionen1Box.Visible:=false;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[8].GUID) then
  begin // Beschleunigung setzen
    effektlist.Visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Beschleunigung [0..128..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[9].GUID) then
  begin // Wiederholung ein/aus
    effektlist.Visible:=true;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[10].GUID) then
  begin // Modus setzen
    effektlist.Visible:=true;
    Optionen1Box.Visible:=true;
    Arg1Combobox.Visible:=true;
    Arg1Combobox.Clear;
    Arg1Combobox.Items.Add(_('Aufwärts'));
    Arg1Combobox.Items.Add(_('Abwärts'));
    Arg1Combobox.Items.Add(_('Pendeln'));
    Arg1Combobox.Items.Add(_('Zufällig'));
    Arg1Combobox.ItemIndex:=AktuellerBefehl.ArgInteger[0]-1;
    Arg1Label.Caption:=_('Modus:');
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[9].Steuerung[11].GUID) then
  begin // Alle Effekte stoppen
    // keine Einstellungen anzeigen
    nousersetting:=false;
  end;

  // Submaster
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[0].GUID) then
  begin // Auf Eingangswert schalten
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=false;
    Arg1Label.Caption:=_('Fader:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[1].GUID) then
  begin // Auf festen Wert schalten
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Fader:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[2].GUID) then
  begin // Auf festen Wert flashen
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Fader:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[3].GUID) then
  begin // Auf abgefragten Wert schalten
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=false;
    Arg1Label.Caption:=_('Fader:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[4].GUID) then
  begin // Faderwert +
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Fader:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[5].GUID) then
  begin // Faderwert -
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Fader:');
    Arg2Label.Caption:=_('Wert [0..255]:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[6].GUID) then
  begin // Vorherige Bank
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[7].GUID) then
  begin // Nächste Bank
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[10].Steuerung[8].GUID) then
  begin // Bestimmte Bank
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Bank:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    nousersetting:=false;
  end;

  // Kontrollpanel
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[11].Steuerung[0].GUID) then
  begin // Button schalten
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Zeile:');
    Arg2Label.Caption:=_('Spalte:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[11].Steuerung[1].GUID) then
  begin // Button ein/aus
    Optionen1Box.Visible:=true;
    Optionen2Box.Visible:=true;
    Arg1Label.Caption:=_('Zeile:');
    Arg2Label.Caption:=_('Spalte:');
    Arg1Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[0]);
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);
    nousersetting:=false;
  end;

  // Joysticksteuerung
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[0].GUID) then
  begin // Positionierung absolut/relativ
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Button:');
    Arg1Combobox.Items.Clear;
    for i:=0 to joysticksetupform.listbox1.items.count-1 do
      Arg1Combobox.items.add(joysticksetupform.listbox1.items[i]);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[1].GUID) then
  begin // Positionierung absolut
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Button:');
    Arg1Combobox.Items.Clear;
    for i:=0 to joysticksetupform.listbox1.items.count-1 do
      Arg1Combobox.items.add(joysticksetupform.listbox1.items[i]);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[2].GUID) then
  begin // Positionierung relativ
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Button:');
    Arg1Combobox.Items.Clear;
    for i:=0 to joysticksetupform.listbox1.items.count-1 do
      Arg1Combobox.items.add(joysticksetupform.listbox1.items[i]);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[12].Steuerung[3].GUID) then
  begin // Position zentrieren
//    Optionen1Box.Visible:=true;
//    Arg1Label.Caption:='Button:';
//    Arg1Combobox.Items.Clear;
//    for i:=0 to joysticksetupform.listbox1.items.count-1 do
//      Arg1Combobox.items.add(joysticksetupform.listbox1.items[i]);
//    Arg1Edit.visible:=false;
//    Arg1Combobox.visible:=true;
//    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;
    nousersetting:=false;
  end;
  // NodeControl
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[0].GUID) then
  begin // Knotenset abrufen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[1].GUID) then
  begin // Knotenposition X auf Wert setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Knoten:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    Optionen3Box.Visible:=true;
    Arg3Label.Caption:=_('X-Position (Pixel):');
    Arg3Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[2]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[2].GUID) then
  begin // Knotenposition Y auf Wert setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Knoten:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    Optionen3Box.Visible:=true;
    Arg3Label.Caption:=_('Y-Position (Pixel):');
    Arg3Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[2]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[3].GUID) then
  begin // Knotenausdehnung auf Wert setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Ausdehnung [0..254000]:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[4].GUID) then
  begin // Knotenkontrast auf Wert setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Kontrast [0..50]:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[5].GUID) then
  begin // Knotenblendzeit auf Wert setzen
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    FillTimeBox(AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[6].GUID) then
  begin // Knotenposition X auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Knoten:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[7].GUID) then
  begin // Knotenposition Y auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Knoten:');
    Arg2Edit.Text:=inttostr(AktuellerBefehl.ArgInteger[1]);

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[8].GUID) then
  begin // Knotenausdehnung auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[13].Steuerung[9].GUID) then
  begin // Knotenkontrast auf Eingangswert
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Knotenset:');
    Arg1Combobox.Items.Clear;
    for i:=0 to length(mainform.nodecontrolsets)-1 do
      Arg1Combobox.items.add(mainform.nodecontrolsets[i].Name);
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0]-1;

    nousersetting:=false;
  end;
  // CD-Player
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[0].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[1].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[2].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[3].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[4].GUID) then
  begin // Play, Pause, Stop, Zurück, Vorwärts
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[5].GUID) then
  begin // Springe zu Titel Nr
    Optionen1Box.Visible:=true;
    Arg1Label.Caption:=_('Laufwerk:');
    Arg1Combobox.Items.Clear;
    if mainform.CDPlayerDrives<>nil then
      Arg1Combobox.Items:=mainform.CDPlayerDrives;
    Arg1Edit.visible:=false;
    Arg1Combobox.visible:=true;
    if AktuellerBefehl.ArgInteger[0]<Arg1Combobox.items.count then
      Arg1Combobox.Itemindex:=AktuellerBefehl.ArgInteger[0];
    Optionen2Box.Visible:=true;
    Arg2Label.Caption:=_('Titel:');
    Arg2Combobox.Items.Clear;
    if mainform.CDPlayerTracks<>nil then
      Arg2Combobox.Items:=mainform.CDPlayerTracks;
    Arg2Edit.visible:=false;
    Arg2Combobox.visible:=true;
    if AktuellerBefehl.ArgInteger[1]<Arg2Combobox.items.count then
      Arg2Combobox.Itemindex:=AktuellerBefehl.ArgInteger[1];
    nousersetting:=false;
  end;
  if IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[6].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[7].GUID) or
    IsEqualGUID(AktuellerBefehl.Typ,mainform.Befehlssystem[14].Steuerung[8].GUID) then
  begin // Repeat, Random, Eject
    nousersetting:=false;
  end;

