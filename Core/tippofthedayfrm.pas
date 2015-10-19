unit tippofthedayfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvGradient, JvExControls, JvAnimatedImage, JvGIFCtrl,
  ExtCtrls, gnugettext;

type
  Ttippoftheday = class(TForm)
    Panel1: TPanel;
    JvGIFAnimator1: TJvGIFAnimator;
    JvGradient2: TJvGradient;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    Label3: TLabel;
    Button2: TButton;
    Button4: TButton;
    Shape4: TShape;
    Shape1: TShape;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    tipptext: array of String;
    aktuellertipp:integer;
  end;

var
  tippoftheday: Ttippoftheday;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Ttippoftheday.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.showtipofday:=Checkbox1.checked;
end;

procedure Ttippoftheday.FormShow(Sender: TObject);
begin
  Checkbox1.checked:=mainform.showtipofday;

  Randomize;
  aktuellertipp:=random(length(tipptext));
  label3.Caption:=inttostr(aktuellertipp+1)+'/'+inttostr(length(tipptext));
  memo1.Text:=tipptext[aktuellertipp];
end;

procedure Ttippoftheday.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  setlength(tipptext,0);
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Über die Projektverwaltung (STRG+B) können Sie Dateien einfach mit der Maus in das Projekt einbinden.')+#13#10#13#10+_('Ziehen Sie dazu einfach eine Datei auf das Fenster und die Datei wird automatisch mit in die Projektdatei gespeichert.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Über die Kombinationsszenen können auf leichte Weise komplexe Abläufe zeitgleich gestartet werden.')+#13#10#13#10+_('Über einen Befehl kann dann die Kombination schnell wieder beendet werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Mit dem Audioeffektplayer können im Aufnahmemodus Änderungen im Kontrollpanel, sowie vielen weiteren Plugins und Optionen direkt in die jeweilige Spur aufgezeichnet werden.')+#13#10#13#10+_('Dies erleichtert die Licht-Synchronisation zur Musik erheblich.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Im Audioeffektplayer kann über die Repeat-Funktion ein Endlosablauf erzeugt werden, welcher mit nur einem Klick, bzw. über einen Befehl aktiviert und deaktiviert werden kann.')+#13#10#13#10+_('Diese Funktion ist z.B. bei Live-Anwendungen sehr Hilfreich, wenn Einmärsche oder andere Fortlaufende Dinge beleuchtet werden müssen.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Über die PC_DIMMER-Pluginschnittstelle können auf einfache Weise grundlegende Programmfunktionen gesteuert, sowie Kanal-, MIDI- und Steuerfunktionen verwendet werden.')+#13#10#13#10+_('Die Funktionsvielfalt des PC_DIMMERs kann so weiter gesteigert werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Das Kontrollpanel kann mit über 500 Schaltflächen jegliche Funktionen, Szenen und Befehle des PC_DIMMERs ausführen.')+#13#10#13#10+_('Nutzen Sie Farben und Grafiken, um die gewünschten Optionen schnell zu finden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('MIDI-Keyboards können sehr leicht mit Szenen und Funktionen belegt werden.')+#13#10#13#10+_('Nutzen Sie dafür das MIDI-Setup unter Einstellungen->MIDI Einstellungen...')+#13#10#13#10+_('MIDI Ereignisse können zudem auch in den einzelnen Plugins verarbeitet werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Über die Softpatch-Funktion können sämtliche Kanäle des PC_DIMMERs mit einzelnen Spezialfunktionen versehen werden.')+#13#10#13#10+_('Verwenden Sie die Funktion "DataIn" unter Hauptmenü->Einstellungen->DataIn Einstellungen, um die Entsprechenden Optionen einzusehen.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Mit dem Geräteeditor können eigene Oberflächen für Geräteeinstellungen erstellt und bearbeitet werden, welche über die grafische Bühnenansicht aufgerufen werden können.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Jedem Gerätekanal kann eine eigene Dimmkurve und ein eigener Dimmverlauf zugeordnet werden. Somit können zum Beispiel LED-Lampen dem normalen Glühlampenverhalten angenähert werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Mit Automatikszenen können Geräte automatisch auf eine Farbe gesetzt werden. Dies funktioniert auch bei Geräten ohne eigene RGB-Mischung (z.B. Geräten mit Farbrad)');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Jeder Kanal kann über die DataIn-Funktion mit Spezialfunktionen belegt werden. So kann z.B. Kanal 7 als Submaster für alle Dimmerkanäle fungieren, oder Kanal 20 als Fader für alle "Rot"-Kanäle einer Gerätegruppe dienen.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Effekte bieten eine gute Möglichkeit, komplexe Abläufe zu erstellen. Durch Verschachtelung von Effekten kann ein abwechselndes Programm kreiert werden. Mit Befehlen kann zudem der Ablauf leicht beeinflusst werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Bewegungsszenen können nicht nur für Scanner verwendet, sondern auch für statische Lichter benutzt werden. Die Offsetfunktion erlaubt ein Schnelles erstellen interessanter Lauflichter.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Der Videoscreen kann in Verbindung mit dem Audioeffektplayer und entsprechenden Befehlen eine große Erleichterung beim Programmieren einer Lichtshow auf bereits vorhandene Choreografien sein.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Mit gruppierten Geräten ist das Verwenden von Fanning möglich. Fanning ist ein zeitlich versetztes Ausführen von gleichen Funktionen. So können z.B. 8 Geräte gruppiert, ein Gerät als ')+_('Master ausgewählt und eine Delay-Zeit definiert werden. Spricht man nun die Gruppe aus den einzelnen Teilen des PC_DIMMERs an '+'(z.B. Submaster) werden alle 8 Geräte zeitlich versetzt die gleiche Aktion ausführen. Dynamisches Licht ist somit sehr einfach zu erstellen');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Das Faderpanel ermöglicht auch einfache Gruppierungen. Halten Sie entweder STRG-, Shift-, oder ALT-Taste gedrückt, während Sie auf einen Kanalfader klicken. Es können bis zu 3 Gruppen gebildet werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Der PC_DIMMER lässt sich auch Fernsteuern. Das Programm PC_DIMMER_CMD.EXE aus dem Installationsordner ermöglich das Senden von Kommandos per Netzwerk. Es können Kanalwerte geändert und Szenen gestartet/gestoppt werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Lauflichter können mit dem Effektsequenzer und dem dort aufrufbaren Lauflichtassistenten sehr einfach erstellt werden. Einige Lauflichter sind bereits voreingestellt und können auf beliebige Geräte angewendet werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Selektieren Sie Geräte in der grafischen Bühnenansicht mit gedrückter Shift-Taste und ziehen sie mit Hilfe der Maus einen Rahmen. Mit Hilfe des Gruppeneditors können so sehr schnell und einfach Gerätegruppen erstellt werden.');
  setlength(tipptext,length(tipptext)+1);
  tipptext[length(tipptext)-1]:=_('Sie können die Ansicht des PC_DIMMERs zwischen einer Vollbildansicht und einer Darstellung am oberen Bildschirmrand umstellen. Verwenden Sie den Button "Minimieren ein/aus" aus dem Tab "Home" oder "Sonstiges"');
end;

procedure Ttippoftheday.Button3Click(Sender: TObject);
begin
  if aktuellertipp<length(tipptext)-1 then
    aktuellertipp:=aktuellertipp+1
  else
    aktuellertipp:=0;

  label3.Caption:=inttostr(aktuellertipp+1)+'/'+inttostr(length(tipptext));
  memo1.Text:=tipptext[aktuellertipp];
end;

procedure Ttippoftheday.Button2Click(Sender: TObject);
begin
  Randomize;
  aktuellertipp:=random(length(tipptext));
  label3.Caption:=inttostr(aktuellertipp+1)+'/'+inttostr(length(tipptext));
  memo1.Text:=tipptext[aktuellertipp];
end;

procedure Ttippoftheday.Button4Click(Sender: TObject);
begin
  if aktuellertipp>0 then
    aktuellertipp:=aktuellertipp-1
  else
    aktuellertipp:=length(tipptext)-1;

  label3.Caption:=inttostr(aktuellertipp+1)+'/'+inttostr(length(tipptext));
  memo1.Text:=tipptext[aktuellertipp];
end;

procedure Ttippoftheday.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrOK;
end;

procedure Ttippoftheday.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

procedure Ttippoftheday.Button1Click(Sender: TObject);
begin
  close;
end;

end.
