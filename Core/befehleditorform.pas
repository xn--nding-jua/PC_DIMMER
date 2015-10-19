unit befehleditorform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gnugettext;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Tbefehlseditor = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Arg1Label: TLabel;
    Arg1Edit: TEdit;
    Arg2Label: TLabel;
    Arg2Edit: TEdit;
    Button1: TButton;
    Button2: TButton;
    ZeitBox: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    hEdit: TEdit;
    minEdit: TEdit;
    sEdit: TEdit;
    msEdit: TEdit;
    Optionen1Box: TGroupBox;
    Optionen2Box: TGroupBox;
    Label8: TLabel;
    Arg1Combobox: TComboBox;
    effektliste: TComboBox;
    Arg2bEdit: TEdit;
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure hEditChange(Sender: TObject);
    procedure Arg1EditChange(Sender: TObject);
    procedure Arg2EditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Arg1ComboboxChange(Sender: TObject);
    procedure effektlisteChange(Sender: TObject);
    procedure Arg2bEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    cancel:boolean;
    nousersetting:boolean;
  public
    { Public-Deklarationen }
    Argument1, Argument2: integer;
    Argument3:TGUID;
    Typ:Byte;
    ID:TGUID;
  end;

var
//  befehlseditor: Tbefehlseditor;
  befehlseditor_array: array of Tbefehlseditor;

implementation

uses PCDIMMER, szenenverwaltung;

{$R *.dfm}

procedure Tbefehlseditor.ComboBox2Change(Sender: TObject);
var
  i,j:integer;
  temp:byte;
  SzenenData:PTreeData;
begin
  nousersetting:=true;

  ZeitBox.Visible:=false;
  Optionen1Box.Visible:=false;
  Optionen2Box.Visible:=false;
  Arg1Combobox.Visible:=false;
  Arg2bEdit.visible:=false;
  Arg2Edit.Width:=169;
  Label8.Visible:=false;
  effektliste.Visible:=false;

  case Combobox1.ItemIndex of
    0: // Audioeffektplayer
    begin
      case Combobox2.ItemIndex of
        3: ZeitBox.Visible:=true; // Auf Position springen
        9:
        begin
          Optionen1Box.Visible:=true;
          Arg1Combobox.Visible:=true;
          Arg1Combobox.Clear;
          for i:=0 to length(mainform.Effektaudio_record)-1 do
            Arg1Combobox.Items.Add(ExtractFilename(mainform.Effektaudio_record[i].audiodatei));
          Arg1Label.Caption:=_('Audiodatei:');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
      end;
    end;
    1: // Szenen
    begin
      case Combobox2.ItemIndex of
        0: // Szene starten
        begin
          if (Sender=Combobox2) then
          begin
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=Argument3;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;
            if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
            begin
              if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
              SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

              case SzenenData^.NodeType of
                0:
                begin
                // Einfache Szene
                  Argument3:=SzenenData^.ID;
                end;
                1:
                begin
                // Geräteszene
                  Argument3:=SzenenData^.ID;
                end;
                2:
                begin
                // Audioszene
                  Argument3:=SzenenData^.ID;
                end;
                3:
                begin
                // Bewegungsszene
                  Argument3:=SzenenData^.ID;
                end;
                4:
                begin
                // Befehl
                  cancel:=false;
                  for i:=0 to length(befehlseditor_array)-1 do
                  begin
                    if IsEqualGUID(befehlseditor_array[i].ID,SzenenData^.ID) then
                    begin
                      MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                      cancel:=true;
                    end;
                  end;
                  if not cancel then
                  begin
                    Argument3:=SzenenData^.ID;
                  end;
                end;
                5:
                begin
                // Kompositionsszene
                  for i:=0 to length(mainform.Kompositionsszenen)-1 do
                    if IsEqualGUID(mainform.Kompositionsszenen[i].ID,SzenenData^.ID) then
                      for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
                      begin
                        if (IsEqualGUID(mainform.Kompositionsszenen[i].IDs[j],ID)) and (GUIDtoString(ID)<>'{00000000-0000-0000-0000-000000000000}') then
                        begin
                          MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                          cancel:=true;
                        end;
                      end;
                  if not cancel then
                  begin
                    ShowMessage(_('Bitte stellen Sie sicher, dass die Kombinationsszene die Sie gerade hinzufügen möchten nicht den gerade zu bearbeitenden Befehl aufruft.')+#10+_('Ringaufrufe können nicht vollständig erkannt werden und führen zum Absturz.'));
                    Argument3:=SzenenData^.ID;
                  end;
                end;
                6:
                begin
                // Preset
                  Argument3:=SzenenData^.ID;
                end;
                7:
                begin
                // Automatikszenen
                  Argument3:=SzenenData^.ID;
                end;
                8:
                begin
                  Argument3:=SzenenData^.ID;
                end;
                9:
                begin
                  Argument3:=SzenenData^.ID;
                end;
              end;
            end;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
          end;
        end;
        1: // Szene stoppen
        begin
          if (Sender=Combobox2) then
          begin
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;
            if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
            begin
              if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
              SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

              case SzenenData^.NodeType of
                0:
                begin
                // Einfache Szene
                  Argument3:=SzenenData^.ID;
                end;
                1:
                begin
                // Geräteszene
                  Argument3:=SzenenData^.ID;
                end;
                2:
                begin
                // Audioszene
                  Argument3:=SzenenData^.ID;
                end;
                3:
                begin
                // Bewegungsszene
                  Argument3:=SzenenData^.ID;
                end;
                4:
                begin
                // Befehl
                  ShowMessage(_('Befehle können derzeit noch nicht explizit gestoppt werden.'));
//                  Argument3:=mainform.Befehle2[szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Treeview1.Selected.Index].ID;
                end;
                5:
                begin
                // Kompositionsszene
                  Argument3:=SzenenData^.ID;
                end;
                7:
                begin
                // Autoszene
                  Argument3:=SzenenData^.ID;
                end;
                8:
                begin
                // Autoszene
                  Argument3:=SzenenData^.ID;
                end;
                9:
                begin
                // Autoszene
                  Argument3:=SzenenData^.ID;
                end;
              end;
            end;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
          end;
        end;
        2: // Szene starten/stoppen
        begin
          if (Sender=Combobox2) then
          begin
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=Argument3;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;
            if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
            begin
              if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
              SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

              case SzenenData^.NodeType of
                0:
                begin
                // Einfache Szene
                  Argument3:=SzenenData^.ID;
                end;
                1:
                begin
                // Geräteszene
                  Argument3:=SzenenData^.ID;
                end;
                2:
                begin
                // Audioszene
                  Argument3:=SzenenData^.ID;
                end;
                3:
                begin
                // Bewegungsszene
                  Argument3:=SzenenData^.ID;
                end;
                4:
                begin
                // Befehl
                  cancel:=false;
                  for i:=0 to length(befehlseditor_array)-1 do
                  begin
                    if IsEqualGUID(befehlseditor_array[i].ID,SzenenData^.ID) then
                    begin
                      MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                      cancel:=true;
                    end;
                  end;
                  if not cancel then
                  begin
                    Argument3:=SzenenData^.ID;
                  end;
                end;
                5:
                begin
                // Kompositionsszene
                  for i:=0 to length(mainform.Kompositionsszenen)-1 do
                    if IsEqualGUID(mainform.Kompositionsszenen[i].ID,SzenenData^.ID) then
                      for j:=0 to length(mainform.Kompositionsszenen[i].IDs)-1 do
                      begin
                        if (IsEqualGUID(mainform.Kompositionsszenen[i].IDs[j],ID)) and (GUIDtoString(ID)<>'{00000000-0000-0000-0000-000000000000}') then
                        begin
                          MessageDlg(_('Es wird gerade versucht einen sich selbst aufrufenden Befehl zu erstellen.')+#10+_('Da dies zu einer Endlosschleife führen würde, wird der Vorgang automatisch abgebrochen.'), mtError, [mbOk], 0);
                          cancel:=true;
                        end;
                      end;
                  if not cancel then
                  begin
                    ShowMessage(_('Bitte stellen Sie sicher, dass die Kombinationsszene die Sie gerade hinzufügen möchten nicht den gerade zu bearbeitenden Befehl aufruft.')+#10+_('Ringaufrufe können nicht vollständig erkannt werden und führen zum Absturz.'));
                    Argument3:=SzenenData^.ID;
                  end;
                end;
                6:
                begin
                // Presets
                  Argument3:=SzenenData^.ID;
                end;
                7:
                begin
                // Autoszenen
                  Argument3:=SzenenData^.ID;
                end;
                8:
                begin
                // Autoszenen
                  Argument3:=SzenenData^.ID;
                end;
                9:
                begin
                // Autoszenen
                  Argument3:=SzenenData^.ID;
                end;
              end;
            end;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
          end;
        end;
        3: // Szenenzeit festlegen
        begin
          if (Sender=Combobox2) then
          begin
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);

            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Positionselection:=Argument3;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].showmodal;
            if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ModalResult=mrOK then
            begin
              if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
              SzenenData:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

              case SzenenData^.NodeType of
                0:
                begin
                // Einfache Szene
                  Argument3:=SzenenData^.ID;
                end;
                1:
                begin
                // Geräteszene
                  Argument3:=SzenenData^.ID;
                end;
                2:
                begin
                // Audioszene
                  Argument3:=SzenenData^.ID;
                end;
                3:
                begin
                // Bewegungsszene
                  Argument3:=SzenenData^.ID;
                end;
                4:
                begin
                // Befehl
                  ShowMessage(_('Befehle besitzen keine Zeit, die verändert werden könnte.'));
                end;
                5:
                begin
                // Kompositionsszene
                  ShowMessage(_('Die Zeit einer Kombinationsszene kann nicht direkt geändert werden.')+#13#10+#13#10+_('Bitte ändern Sie die Zeiten der einzelnen Unterszenen.'));
                end;
                6:
                begin
                // Preset
                  ShowMessage(_('Presets besitzen keine Zeit, die verändert werden könnte.'));
                end;
                7:
                begin
                // Automatikszenen
                  Argument3:=SzenenData^.ID;
                end;
                8:
                begin
                // Automatikszenen
                  Argument3:=SzenenData^.ID;
                end;
                9:
                begin
                // Automatikszenen
                  ShowMessage(_('Effekte besitzen keine Zeit, die verändert werden könnte.'));
                end;
              end;
            end;
            szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
            setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
          end;

          ZeitBox.Visible:=true;
        end;
      end;
    end;
    2: // Beat-Tool
    begin
      case Combobox2.ItemIndex of
        1: // BPM-Wert
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('BPM-Wert [Wert in BPM]:');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        4: // Beatquelle setzen
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Beatquelle:');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add(_('Temposlider'));
          Arg1Combobox.Items.Add(_('Soundkarte'));
          Arg1Combobox.Items.Add(_('Plugin'));
          Arg1Combobox.Items.Add(_('Manuell'));
          Arg1Combobox.Items.Add(_('Audioplayer'));
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
      end;
    end;
    3: // Master
    begin
      case Combobox2.ItemIndex of
        0: // Grandmaster setzen
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Wert [0..100]');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        2: // Flashmaster setzen
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Wert [0..100]');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        5: // MIDI-Befehl senden
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Message-Typ (144=Noten):');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Label.Caption:=_('Data1 (Ton) und Data2 (Volume):');
          temp:=Argument2;
          Arg2Edit.Text:=inttostr(temp);
          Arg2Edit.Width:=81;
          temp:=Argument2 shr 8;
          Arg2bEdit.visible:=true;
          Arg2bEdit.Text:=inttostr(temp);
        end;
        6: // Videoscreen Play
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Videoscreen Nr.');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add('1');
          Arg1Combobox.Items.Add('2');
          Arg1Combobox.Items.Add('3');
          Arg1Combobox.Items.Add('4');
          Arg1Combobox.ItemIndex:=Argument1-1;
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        7: // Videoscreen Play von Beginn
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Videoscreen Nr.');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add('1');
          Arg1Combobox.Items.Add('2');
          Arg1Combobox.Items.Add('3');
          Arg1Combobox.Items.Add('4');
          Arg1Combobox.ItemIndex:=Argument1-1;
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        8: // Videoscreen Pause
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Videoscreen Nr.');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add('1');
          Arg1Combobox.Items.Add('2');
          Arg1Combobox.Items.Add('3');
          Arg1Combobox.Items.Add('4');
          Arg1Combobox.ItemIndex:=Argument1-1;
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        9: // Videoscreen Stop
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Videoscreen Nr.');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add('1');
          Arg1Combobox.Items.Add('2');
          Arg1Combobox.Items.Add('3');
          Arg1Combobox.Items.Add('4');
          Arg1Combobox.ItemIndex:=Argument1-1;
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        10: // Videoscreenposition
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Videoscreen Nr.');
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add('1');
          Arg1Combobox.Items.Add('2');
          Arg1Combobox.Items.Add('3');
          Arg1Combobox.Items.Add('4');
          Arg1Combobox.ItemIndex:=Argument1-1;
          Arg1Combobox.Visible:=true;
          Arg1Edit.Visible:=false;
          Arg1Edit.Text:=inttostr(Argument1);
          Optionen2Box.Visible:=true;
          Arg2Label.Caption:=_('Position [ms]');
          Arg2Edit.Text:=inttostr(Argument2);
        end;
      end;
    end;
    4: // Kanal
    begin
      case Combobox2.ItemIndex of
        0: // Auf festen Wert setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg2Label.Caption:=_('Wert [0..100]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
        1: // Auf abgefragten Wert schalten
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
        2: // Auf festen Wert dimmen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg2Label.Caption:=_('Wert [0..100]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
          Label8.caption:=_('Die Fadezeit wird in der Kanalübersicht angegeben.');
          Label8.Visible:=true;
        end;
        3: // Auf abgefragten Wert dimmen
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg1Edit.Text:=inttostr(Argument1);
          Label8.caption:=_('Die Fadezeit wird in der Kanalübersicht angegeben.');
          Label8.Visible:=true;
        end;
        4: // Kanalminimum setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg2Label.Caption:=_('Wert [0..255]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
        5: // Kanalmaximum setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Kanal:');
          Arg2Label.Caption:=_('Wert [0..255]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
      end;
    end;
    5: // Effekt
    begin
      case Combobox2.ItemIndex of
        0: // Start / Stop
        begin
          Optionen1Box.Visible:=false;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
        end;
        1: // Start
        begin
          Optionen1Box.Visible:=false;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
        end;
        2: // Stop
        begin
          Optionen1Box.Visible:=false;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
        end;
        3: // Nächster Schritt
        begin
          Optionen1Box.Visible:=false;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
        end;
        4: // Intensität setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
          Arg1Label.Caption:=_('Intensität [0..255]:');
          Arg2Label.Caption:=_('Wert [0..255]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
        5: // Beschleunigung setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
          Arg1Label.Caption:=_('Beschleunigung [0..128..255]:');
          Arg2Label.Caption:=_('Wert [0..255]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
          Arg2bEdit.Text:=inttostr(Argument2 shr 8);
        end;
        6: // Wiederholung ein/aus
        begin
          Optionen1Box.Visible:=false;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
        end;
        7: // Modus setzen
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=false;
          effektliste.Visible:=true;
          Arg1Combobox.Visible:=true;
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add(_('Aufwärts'));
          Arg1Combobox.Items.Add(_('Abwärts'));
          Arg1Combobox.Items.Add(_('Pendeln'));
          Arg1Combobox.Items.Add(_('Zufällig'));
          Arg1Label.Caption:=_('Modus:');
          Arg2Label.Caption:=_('Optionen:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
      end;
    end;
    6: // Submaster
    begin
      case Combobox2.ItemIndex of
        0: // Submaster auf festen Wert schalten
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Fader:');
          Arg2Label.Caption:=_('Wert [0..255]:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
        1: // Submaster auf abgefragten Wert schalten
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=false;
          Arg1Label.Caption:=_('Fader:');
          Arg1Edit.Text:=inttostr(Argument1);
        end;
      end;
    end;
    7: // Kontrollpanel
    begin
      case Combobox2.ItemIndex of
        0: // Button
        begin
          Optionen1Box.Visible:=true;
          Optionen2Box.Visible:=true;
          Arg1Label.Caption:=_('Zeile:');
          Arg2Label.Caption:=_('Spalte:');
          Arg1Edit.Text:=inttostr(Argument1);
          Arg2Edit.Text:=inttostr(Argument2);
        end;
      end;
    end;
    8: // Gerätesetup
    begin
      ZeitBox.Visible:=false;
      Optionen1Box.Visible:=false;
      Optionen2Box.Visible:=false;
      effektliste.Visible:=true;
      case Combobox2.ItemIndex of
        0:
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Kalibrierung:');
          Arg1Combobox.Visible:=true;
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add(_('Deaktiviert'));
          for i:=1 to 16 do
          begin
            if (effektliste.itemindex>-1) and (effektliste.itemindex<length(mainform.devices)) and (mainform.devices[effektliste.itemindex].scannercalibrations[i].name<>'') then
              Arg1Combobox.Items.Add(mainform.devices[effektliste.itemindex].scannercalibrations[i].name)
            else
              Arg1Combobox.Items.Add('Kalibrierung '+inttostr(i));
          end;
          Arg1Edit.Text:=inttostr(Argument1);
        end;
      end;
    end;
    9: // Gerätegruppensetup
    begin
      ZeitBox.Visible:=false;
      Optionen1Box.Visible:=false;
      Optionen2Box.Visible:=false;
      effektliste.Visible:=true;
      case Combobox2.ItemIndex of
        0:
        begin
          Optionen1Box.Visible:=true;
          Arg1Label.Caption:=_('Kalibrierung:');
          Arg1Combobox.Visible:=true;
          Arg1Combobox.Clear;
          Arg1Combobox.Items.Add(_('Deaktiviert'));
          for i:=1 to 16 do
            Arg1Combobox.Items.Add(_('Kalibrierung ')+inttostr(i));
          Arg1Edit.Text:=inttostr(Argument1);
        end;
      end;
    end;
  end;

  if Argument1<Arg1Combobox.Items.Count then
    Arg1Combobox.ItemIndex:=Argument1;

  nousersetting:=false;
end;

procedure Tbefehlseditor.ComboBox1Change(Sender: TObject);
var
  i:integer;
begin
  effektliste.Visible:=false;
  Optionen1Box.Visible:=false;
  Optionen2Box.Visible:=false;
  ZeitBox.Visible:=false;

  case Combobox1.ItemIndex of
  0: // Audioeffektplayer
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Start / Stop'));
      Combobox2.Items.Add(_('Start'));
      Combobox2.Items.Add(_('Stop'));
      Combobox2.Items.Add(_('Springe zu Position'));
      Combobox2.Items.Add(_('Repeat ein/aus'));
      Combobox2.Items.Add(_('Aufnahme ein/aus'));
      Combobox2.Items.Add(_('Effekte ein/aus'));
      Combobox2.Items.Add(_('Vorige Audiodatei'));
      Combobox2.Items.Add(_('Nächste Audiodatei'));
      Combobox2.Items.Add(_('Springe zu Audiodatei'));
      Combobox2.ItemIndex:=0;
    end;
  1: // Szenen
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Starten'));
      Combobox2.Items.Add(_('Stoppen'));
      Combobox2.Items.Add(_('Start/Stop'));
      Combobox2.Items.Add(_('Szenenzeit festlegen'));
    end;
  2: // Beat-Tool
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Sync-Button'));
      Combobox2.Items.Add(_('BPM-Wert setzen'));
      Combobox2.Items.Add(_('BPM-Wert abfragen'));
      Combobox2.Items.Add(_('Beat auslösen'));
      Combobox2.Items.Add(_('Beatquelle setzen'));
      Combobox2.ItemIndex:=0;
    end;
  3: // Master
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Grandmaster setzen'));
      Combobox2.Items.Add(_('Grandmaster abfragen'));
      Combobox2.Items.Add(_('Flashmaster setzen'));
      Combobox2.Items.Add(_('Flashmaster abfragen'));
      Combobox2.Items.Add(_('Audio-Mute ein/aus'));
      Combobox2.Items.Add(_('MIDI-Befehl senden'));
      Combobox2.Items.Add(_('Videoscreen Play'));
      Combobox2.Items.Add(_('Videoscreen Play von Beginn'));
      Combobox2.Items.Add(_('Videoscreen Pause'));
      Combobox2.Items.Add(_('Videoscreen Stop'));
      Combobox2.Items.Add(_('Videoscreen Springe zu Position'));
      Combobox2.ItemIndex:=0;
    end;
  4: // Kanal
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Auf festen Wert schalten'));
      Combobox2.Items.Add(_('Auf abgefragten Wert schalten'));
      Combobox2.Items.Add(_('Auf festen Wert dimmen'));
      Combobox2.Items.Add(_('Auf abgefragten Wert dimmen'));
      Combobox2.Items.Add(_('Kanalminimum setzen'));
      Combobox2.Items.Add(_('Kanalmaximum setzen'));
      Combobox2.ItemIndex:=0;
    end;
  5: // Effekte
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Start / Stop'));
      Combobox2.Items.Add(_('Start'));
      Combobox2.Items.Add(_('Stop'));
      Combobox2.Items.Add(_('Nächster Schritt'));
      Combobox2.Items.Add(_('Intensität setzen'));
      Combobox2.Items.Add(_('Beschleunigung setzen'));
      Combobox2.Items.Add(_('Wiederholung ein/aus'));
      Combobox2.Items.Add(_('Modus setzen'));
      Combobox2.ItemIndex:=0;
      effektliste.Clear;
      for i:=0 to length(mainform.effektsequenzereffekte)-1 do
        effektliste.Items.Add(mainform.effektsequenzereffekte[i].Name);
      effektliste.Visible:=true;

      for i:=0 to length(mainform.effektsequenzereffekte)-1 do
      begin
        if IsEqualGUID(Argument3,mainform.effektsequenzereffekte[i].ID) then
          effektliste.ItemIndex:=i;
      end;
    end;
  6: // Submaster
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Auf festen Wert schalten'));
      Combobox2.Items.Add(_('Auf abgefragten Wert schalten'));
      Combobox2.Items.Add(_('Vorige Bank'));
      Combobox2.Items.Add(_('Nächste Bank'));
      Combobox2.ItemIndex:=0;
    end;
  7: // Kontrollpanel
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Button schalten'));
      Combobox2.ItemIndex:=0;
    end;
  8: // Gerätesetup
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Kalibrierung setzen'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('Invert PAN ein/aus'));
      Combobox2.Items.Add(_('Invert PAN ein'));
      Combobox2.Items.Add(_('Invert PAN aus'));
      Combobox2.Items.Add(_('Invert TILT ein/aus'));
      Combobox2.Items.Add(_('Invert TILT ein'));
      Combobox2.Items.Add(_('Invert TILT aus'));
      Combobox2.Items.Add(_('Autoszenen ein/aus'));
      Combobox2.Items.Add(_('Autoszenen ein'));
      Combobox2.Items.Add(_('Autoszenen aus'));
      Combobox2.Items.Add(_('Selektierung ein/aus'));
      Combobox2.Items.Add(_('Selektierung ein'));
      Combobox2.Items.Add(_('Selektierung aus'));
      Combobox2.ItemIndex:=0;

      effektliste.Clear;
      for i:=0 to length(mainform.devices)-1 do
        effektliste.Items.Add(mainform.devices[i].Name);
      effektliste.Visible:=true;

      for i:=0 to length(mainform.devices)-1 do
        if IsEqualGUID(mainform.devices[i].ID,Argument3) then
          effektliste.ItemIndex:=i;
    end;
  9: // Gerätegruppensetup
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Kalibrierung setzen'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('- frei -'));
      Combobox2.Items.Add(_('Invert PAN ein/aus'));
      Combobox2.Items.Add(_('Invert PAN ein'));
      Combobox2.Items.Add(_('Invert PAN aus'));
      Combobox2.Items.Add(_('Invert TILT ein/aus'));
      Combobox2.Items.Add(_('Invert TILT ein'));
      Combobox2.Items.Add(_('Invert TILT aus'));
      Combobox2.Items.Add(_('Autoszenen ein/aus'));
      Combobox2.Items.Add(_('Autoszenen ein'));
      Combobox2.Items.Add(_('Autoszenen aus'));
      Combobox2.Items.Add(_('Selektierung ein/aus'));
      Combobox2.Items.Add(_('Selektierung ein'));
      Combobox2.Items.Add(_('Selektierung aus'));
      Combobox2.ItemIndex:=0;

      effektliste.Clear;
      for i:=0 to length(mainform.devicegroups)-1 do
        effektliste.Items.Add(mainform.devicegroups[i].Name);
      effektliste.Visible:=true;

      for i:=0 to length(mainform.devicegroups)-1 do
        if IsEqualGUID(mainform.devicegroups[i].ID,Argument3) then
          effektliste.ItemIndex:=i;
    end;
  10: // Cuelist
    begin
      Combobox2.Clear;
      Combobox2.Items.Add(_('Abspielen'));
      Combobox2.Items.Add(_('Stoppen'));
      Combobox2.Items.Add(_('Voriges abspielen'));
      Combobox2.Items.Add(_('Nächstes abspielen'));
      Combobox2.Items.Add(_('Vorige Bank'));
      Combobox2.Items.Add(_('Nächste Bank'));
    end;
  end;
  Combobox2Change(nil);
end;

procedure Tbefehlseditor.hEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  Argument1:=strtoint(msEdit.Text)+strtoint(sEdit.text)*1000+strtoint(minEdit.Text)*60*1000+strtoint(hEdit.Text)*60*60*1000;
  Arg1Edit.text:=inttostr(Argument1);
end;

procedure Tbefehlseditor.Arg1EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  Argument1:=strtoint(Arg1Edit.Text);
end;

procedure Tbefehlseditor.Arg2EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  if Arg2bEdit.visible then
  begin
    Argument2:=strtoint(Arg2bEdit.Text);
    Argument2:=Argument2 shl 8;
    Argument2:=Argument2 + strtoint(Arg2Edit.Text);
  end else
  begin
    Argument2:=strtoint(Arg2Edit.Text);
  end;
end;

procedure Tbefehlseditor.FormShow(Sender: TObject);
begin
  if Edit1.Text='' then
    Edit1.Text:=_('Neuer Befehl');

  ComboBox1.ItemIndex:=Typ div 20;
  Combobox1Change(Sender);

  ComboBox2.ItemIndex:=Typ mod 20;
  Combobox2Change(Sender);

  if Argument1<Arg1Combobox.Items.Count then
    Arg1Combobox.ItemIndex:=Argument1;
end;

procedure Tbefehlseditor.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tbefehlseditor.Arg1ComboboxChange(Sender: TObject);
begin
  Arg1Edit.text:=inttostr(Arg1Combobox.itemindex);
end;

procedure Tbefehlseditor.effektlisteChange(Sender: TObject);
begin
  case Combobox1.ItemIndex of
    5: Argument3:=mainform.effektsequenzereffekte[effektliste.itemindex].ID;
    8: Argument3:=mainform.devices[effektliste.itemindex].ID;
    9: Argument3:=mainform.devicegroups[effektliste.itemindex].ID;
  end;
end;

procedure Tbefehlseditor.Arg2bEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  Argument2:=strtoint(Arg2bEdit.Text);
  Argument2:=Argument2 shl 8;
  Argument2:=Argument2 + strtoint(Arg2Edit.Text);
end;

procedure Tbefehlseditor.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

end.
