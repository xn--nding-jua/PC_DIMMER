unit firststepsfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, JvGradient, Buttons,
  PngBitBtn, gnugettext, JvXPCore, JvXPButtons, dxGDIPlusClasses, Mask,
  JvExMask, JvSpin, JvColorBox, JvColorButton, ShellApi;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: byte; // 0=Vendor, 1=Type, 2=Device
    Caption:WideString;
    ID:TGUID;
  end;

  Tfirststepsform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Notebook1: TNotebook;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    PngBitBtn4: TPngBitBtn;
    PngBitBtn1: TPngBitBtn;
    GroupBox2: TGroupBox;
    PngBitBtn2: TPngBitBtn;
    PngBitBtn3: TPngBitBtn;
    PngBitBtn5: TPngBitBtn;
    GroupBox3: TGroupBox;
    PngBitBtn6: TPngBitBtn;
    PngBitBtn7: TPngBitBtn;
    PngBitBtn8: TPngBitBtn;
    PngBitBtn9: TPngBitBtn;
    PngBitBtn10: TPngBitBtn;
    PngBitBtn11: TPngBitBtn;
    Panel2: TPanel;
    Shape3: TShape;
    Memo1: TMemo;
    GroupBox4: TGroupBox;
    PngBitBtn12: TPngBitBtn;
    PngBitBtn13: TPngBitBtn;
    PngBitBtn14: TPngBitBtn;
    PngBitBtn15: TPngBitBtn;
    PngBitBtn16: TPngBitBtn;
    JvXPButton1: TJvXPButton;
    CheckBox1: TCheckBox;
    JvXPButton2: TJvXPButton;
    JvXPButton3: TJvXPButton;
    Label4: TLabel;
    Label5: TLabel;
    JvXPButton4: TJvXPButton;
    JvXPButton5: TJvXPButton;
    JvXPButton6: TJvXPButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    JvXPButton7: TJvXPButton;
    JvXPButton8: TJvXPButton;
    JvXPButton9: TJvXPButton;
    Label10: TLabel;
    JvXPButton10: TJvXPButton;
    Label11: TLabel;
    ComboBox1: TComboBox;
    JvXPButton13: TJvXPButton;
    GroupBox5: TGroupBox;
    dipswitcha: TImage;
    DIP1: TImage;
    DIP2: TImage;
    DIP3: TImage;
    DIP4: TImage;
    DIP5: TImage;
    DIP6: TImage;
    DIP7: TImage;
    DIP8: TImage;
    DIP9: TImage;
    DIP10: TImage;
    Label12: TLabel;
    DevStartaddressEdit: TJvSpinEdit;
    colorlbl: TLabel;
    buttonfarbe: TJvColorButton;
    DIPOFF: TImage;
    DIPON: TImage;
    GroupBox6: TGroupBox;
    Image2: TImage;
    JvXPButton11: TJvXPButton;
    GroupBox7: TGroupBox;
    Label15: TLabel;
    JvXPButton12: TJvXPButton;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    JvXPButton14: TJvXPButton;
    JvXPButton15: TJvXPButton;
    Label3: TLabel;
    JvXPButton16: TJvXPButton;
    Label23: TLabel;
    JvXPButton17: TJvXPButton;
    Label24: TLabel;
    JvXPButton18: TJvXPButton;
    JvXPButton19: TJvXPButton;
    Image3: TImage;
    Label25: TLabel;
    Label2: TLabel;
    JvXPButton20: TJvXPButton;
    Timer1: TTimer;
    JvXPButton21: TJvXPButton;
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
    procedure PngBitBtn3Click(Sender: TObject);
    procedure PngBitBtn4Click(Sender: TObject);
    procedure PngBitBtn5Click(Sender: TObject);
    procedure PngBitBtn6Click(Sender: TObject);
    procedure PngBitBtn7Click(Sender: TObject);
    procedure PngBitBtn8Click(Sender: TObject);
    procedure PngBitBtn9Click(Sender: TObject);
    procedure PngBitBtn10Click(Sender: TObject);
    procedure PngBitBtn11Click(Sender: TObject);
    procedure PngBitBtn4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PngBitBtn3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn10MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn15Click(Sender: TObject);
    procedure PngBitBtn12Click(Sender: TObject);
    procedure PngBitBtn13Click(Sender: TObject);
    procedure PngBitBtn14Click(Sender: TObject);
    procedure PngBitBtn12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn13MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn14MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn15MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PngBitBtn16Click(Sender: TObject);
    procedure PngBitBtn16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure JvXPButton2Click(Sender: TObject);
    procedure JvXPButton1Click(Sender: TObject);
    procedure JvXPButton3Click(Sender: TObject);
    procedure JvXPButton4Click(Sender: TObject);
    procedure JvXPButton6Click(Sender: TObject);
    procedure JvXPButton5Click(Sender: TObject);
    procedure JvXPButton9Click(Sender: TObject);
    procedure JvXPButton10Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure JvXPButton11Click(Sender: TObject);
    procedure JvXPButton12Click(Sender: TObject);
    procedure buttonfarbeChange(Sender: TObject);
    procedure DIP1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvXPButton13Click(Sender: TObject);
    procedure DevStartaddressEditChangeChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure JvXPButton18Click(Sender: TObject);
    procedure JvXPButton14Click(Sender: TObject);
    procedure JvXPButton15Click(Sender: TObject);
    procedure JvXPButton16Click(Sender: TObject);
    procedure JvXPButton17Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure JvXPButton20Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure JvXPButton21Click(Sender: TObject);
  private
    { Private-Deklarationen }
    dipstate:array[1..10] of boolean;
    DontUpdateDevStartaddressEdit:boolean;
  public
    { Public-Deklarationen }
  end;

var
  firststepsform: Tfirststepsform;

implementation

uses PCDIMMER, geraetesteuerungfrm, effektsequenzerfrm, cuelistfrm;

{$R *.dfm}

function BitSet(Value: Byte; BitCnt: Byte): Boolean;
begin
//  Result := (( Value AND Round ( power (2, BitCnt-1) )) = Round ( power (2, BitCnt-1) ));
//  result:=(Value AND (1 shl bitcnt )) = (1 shl bitcnt);
  result := ((Value AND bitcnt) = bitcnt);
end;

procedure Tfirststepsform.PngBitBtn1Click(Sender: TObject);
begin
  mainform.Gertesteuerung2Click(nil);
end;

procedure Tfirststepsform.PngBitBtn2Click(Sender: TObject);
begin
  mainform.Effektsequenzer1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn3Click(Sender: TObject);
begin
  mainform.Szenenverwaltung1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn4Click(Sender: TObject);
begin
  mainform.Optionen1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn5Click(Sender: TObject);
begin
  mainform.TBItem13Click(nil);
end;

procedure Tfirststepsform.PngBitBtn6Click(Sender: TObject);
begin
  mainform.TBItem29Click(nil);
end;

procedure Tfirststepsform.PngBitBtn7Click(Sender: TObject);
begin
  mainform.Bhnenansicht1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn8Click(Sender: TObject);
begin
  mainform.TBItem31Click(nil);
end;

procedure Tfirststepsform.PngBitBtn9Click(Sender: TObject);
begin
  mainform.TBItem25Click(nil);
end;

procedure Tfirststepsform.PngBitBtn10Click(Sender: TObject);
begin
  mainform.Submaster1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn11Click(Sender: TObject);
begin
  mainform.Kontrollpanel1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn4MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:=_('Zeigt die erweiterten Einstellungen an, in denen die jeweiligen DMX- oder andere Hardwareinterfaces eingerichtet werden können.'+#13#10#13#10+'Weiterhin sind Einstellungen das Programm betreffend möglich. Sämtliche Einstellungen (auch das Interface betreffend) sind Programmspezifisch und werden nicht im Projekt gespeichert.');
end;

procedure Tfirststepsform.PngBitBtn1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Mit dem Geräteeditor können Lichtgeräte (MovingHeads, Scanner, Farbwechsler, Pars, bzw. Dimmerkanäle und Switchpacks eingerichtet werden.'+#13#10#13#10+'Neben dem Hardwareinterface ist dies die zweite Grundeinstellung, die für das Projekt vorgenommen werden muss.');
end;

procedure Tfirststepsform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.showfirststeps:=not Checkbox1.Checked;
end;

procedure Tfirststepsform.PngBitBtn3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Die Szenenverwaltung erlaubt das Erstellen von Szenen jeglicher Art.'+#13#10#13#10+'Darunter sind Geräteszenen für statische Einstellungen, Bewegungsszenen für Bewegtscheinwerfer, Audioszenen für Toneffekte und noch vieles mehr.');
end;

procedure Tfirststepsform.PngBitBtn2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Effekte sind zeitlich aufeinanderfolgende Szenen.'+#13#10#13#10+'Dabei können jegliche Arten von Szenen verwendet werden, um effektvolle Beleuchtungs- und Toneffekte zu erzeugen.');
end;

procedure Tfirststepsform.PngBitBtn5MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Der Audioeffektplayer ist ein mächtiges Werkzeug, um Lichteffekte zeitlich genau auf ein Musikstück zu programmieren.'+#13#10#13#10+'Es können auch hier sämtliche Szenentypen auf die Millisekunde genau auf 8 Spuren unter die Audiodatei verteilt werden. Die Bedienung ist ähnlich den gängigen Videoschnittprogrammen.');
end;

procedure Tfirststepsform.PngBitBtn6MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Die Kanalübersicht bietet auf einen Blick sämtliche Kanalwerte aller Ausgangskanäle.'+#13#10#13#10+'Zudem werden die installierten Geräte und deren Aufteilung im DMX-Universum angezeigt. Es können mehrere Kanäle selektiert und deren Wert gleichzeitig verändert werden.'+#13#10#13#10+'Mit einem Rechtsklick auf einen Kanal kann zudem ein Minimal- bzw. Maximalwert eingerichtet werden, welcher auch mit dem Projekt gespeichert wird (z.B. für eine Lampenvorheizung).');
end;

procedure Tfirststepsform.PngBitBtn7MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Die grafische Bühnenansicht ermöglicht das Positionieren von installierten Geräten sofern diese in der Gerätesteuerung für die Bühnenansicht aktiviert sind.'+#13#10#13#10+'In der Bühnenansicht können Geräte leicht selektiert und diese Selektionen als Gerätegruppen zusammengefasst werden, um z.B. mehrere Geräte gleichen oder aber auch unterschiedlichen Typs in einer Szene gleichzeitig ändern zu können.');
end;

procedure Tfirststepsform.PngBitBtn8MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Das Beattool ist für alle ablaufenden Effekte von großer Bedeutung und sorgt für den programmweiten Takt.'+#13#10#13#10+'Es kann zwischen mehreren Taktquellen (Soundkarte, Timer, Manuell, etc.) ausgewählt werden.');
end;

procedure Tfirststepsform.PngBitBtn11MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Das Kontrollpanel ist hauptsächlich für die Live-Steuerung von Lichtshows konzipiert.'+#13#10#13#10+'Es können Szenen, Effekte und andere PC_DIMMER-Objekte auf einen Button gelegt werden, um die Lichtshow an bestimmten Stellen zu beeinflussen.'+#13#10#13#10+'Buttons können zudem mit Bildern versehen werden, um den Überblick nicht zu verlieren (z.B. Gobo-Wechsel, oder Shutter ZU)');
end;

procedure Tfirststepsform.PngBitBtn10MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Der Submaster erlaubt das zeitgleiche Ändern von mehreren Kanälen.'+#13#10#13#10+'Dabei kann bei Gerätegruppen zudem die Delayfunktion genutzt werden, um ein dynamisches Ändern von mehreren Kanälen zu erzeugen.'+#13#10#13#10+'Neben einem Delay kann für jeden Kanal prozentual auch eine Abschwächung eingegeben werden, sodass sogar szenische Darstellungen mit einem Submasterkanal möglich sind.');
end;

procedure Tfirststepsform.PngBitBtn9MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Mit der PC_DIMMER Zeitsteuerung können zu beliebigen Zeitpunkten und nach bestimmten Ryhtmen (täglich, wöchentlich, monatlich) bestimmte Ereignisse (Szenen, Effekte, etc.) abgerufen werden.'+#13#10#13#10+'Besonders für unbeaufsichtige Architekturbeleuchtungen ist diese Funktion sehr nützlich.');
end;

procedure Tfirststepsform.PngBitBtn15Click(Sender: TObject);
begin
  mainform.Joysticksteuerung1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn12Click(Sender: TObject);
begin
  mainform.MIDIEinstellungen1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn13Click(Sender: TObject);
begin
  mainform.DataInEinstellungenClick(nil);
end;

procedure Tfirststepsform.PngBitBtn14Click(Sender: TObject);
begin
  mainform.GlobaleTastenabfrage1Click(nil);
end;

procedure Tfirststepsform.PngBitBtn12MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Die MIDI-Steuerung erlaubt das Einstellen von Kanalwerten und Programmfunktionen durch ein externes MIDI-Gerät.'+#13#10#13#10+'Es können z.B. externe Faderpulte wie das BCF2000 oder Midi-Keyboards angeschlossen werden. Jede MIDI-Nachricht kann für ein bestimmtes Ereignis im Programm verwendet werden.');
end;

procedure Tfirststepsform.PngBitBtn13MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:=_('Die DataIn-Steuerung erlaubt das Setzen von Kanalwerten und Programmfunktionen durch externe Pulte über die Plugins.'+#13#10#13#10+'DMX-Interfaces mit DMX-In leiten in der Regel die DMX-In-Werte zur DataIn-Steuerung um, sodass über DMX-Wertänderungen entsprechende Funktionen ausführen können.'+#13#10#13#10+'Es kann über die Softpatch-Funktion auch jeder PC_DIMMER Kanal auf einen DataIn-Kanal umgeleitet werden, sodass man einen normalen PC_DIMMER Kanal mit Spezialfunktionen über die DataIn-Steuerung belegen kann.');
end;

procedure Tfirststepsform.PngBitBtn14MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Über die Tastatursteuerung können Tastenkombinationen spezielle Funktionen zugewiesen werden.'+#13#10#13#10+'Es sind eine Reihe an Standardbelegungen voreingestellt, die jederzeit verändert und erweitert werden können.');
end;

procedure Tfirststepsform.PngBitBtn15MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Mit einem Joystick oder Gamepad können Kanalwerte leicht verändert werden.'+#13#10#13#10+'Dabei können sämtliche Joysticks, die unter Windows registriert sind mit allen verfügbaren Knöpfen verwendet werden. Die Steuerung von Bewegtscheinwerfen wird hierdurch einiges leichter.'+#13#10#13#10+'Besonders beim Einleuchten von Scannern und MHs ist diese Funktion sehr hilfreich.');
end;

procedure Tfirststepsform.GroupBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Text:=_('Sie haben ein neues Projekt begonnen.'+#13#10#13#10+'Der Projektassistent soll Ihnen den Umgang mit dem Programm etwas erleichtern, indem er Grundfunktionen für die Projekterstellung übersichtlich zusammenfasst und zu jedem Punkt einen Hinweistext anzeigt.'+#13#10+'Führen Sie die Maus über eine Schaltfläche des Assistenten und die Beschreibung wird entsprechend angezeigt.'+#13#10#13#10+'Alle hier gezeigten Funktionen sind natürlich auch über die Toolleiste des Hauptprogrammes, oder über den Hauptmenüpunkt "Fenster" abrufbar.');
end;

procedure Tfirststepsform.FormShow(Sender: TObject);
begin
  Notebook1.PageIndex:=1;
  GroupBox1MouseMove(nil, [], 0, 0);
  CheckBox1.checked:=not mainform.showfirststeps;
  Panel1.visible:=true;
  firststepsform.BringToFront;
  Timer1.enabled:=true;
end;

procedure Tfirststepsform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tfirststepsform.PngBitBtn16Click(Sender: TObject);
begin
  mainform.SmallWindowRibbonBtnClick(nil);
  firststepsform.BringToFront;
end;

procedure Tfirststepsform.PngBitBtn16MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.text:=_('Schaltet das Hauptfenster des PC_DIMMERs zwischen einer Vollbild- und einer kleineren Ansicht hin und her.');
end;

procedure Tfirststepsform.JvXPButton2Click(Sender: TObject);
begin
  Notebook1.PageIndex:=0;
  Panel1.visible:=true;
end;

procedure Tfirststepsform.JvXPButton1Click(Sender: TObject);
begin
  Notebook1.PageIndex:=2;
  Panel1.visible:=false;
  firststepsform.BringToFront;
end;

procedure Tfirststepsform.JvXPButton3Click(Sender: TObject);
begin
  close;
end;

procedure Tfirststepsform.JvXPButton4Click(Sender: TObject);
begin
  mainform.Optionen1Click(nil);
end;

procedure Tfirststepsform.JvXPButton6Click(Sender: TObject);
begin
  Notebook1.PageIndex:=0;
  Panel1.visible:=true;
end;

procedure Tfirststepsform.JvXPButton5Click(Sender: TObject);
begin
  Notebook1.PageIndex:=Notebook1.PageIndex+1;
end;

procedure Tfirststepsform.JvXPButton9Click(Sender: TObject);
begin
  Notebook1.PageIndex:=Notebook1.PageIndex-1;
end;

procedure Tfirststepsform.JvXPButton10Click(Sender: TObject);
begin
  geraetesteuerung.Gerthinzufgen1Click(nil);
end;

procedure Tfirststepsform.ComboBox1DropDown(Sender: TObject);
var
  i:integer;
begin
  Combobox1.Items.clear;
  for i:=0 to length(mainform.devices)-1 do
  begin
    Combobox1.Items.Add(mainform.devices[i].Vendor+' '+mainform.devices[i].Name+' ('+_('Startadresse: ')+inttostr(mainform.devices[i].Startaddress)+')');
  end;
end;

procedure Tfirststepsform.JvXPButton11Click(Sender: TObject);
var
  filename:string;
begin
  geraetesteuerung.PngBitBtn1Click(nil);
  if FileExists(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[Combobox1.itemindex].Bildadresse) then
  begin
    filename:=ExtractFileName(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[Combobox1.itemindex].Bildadresse);
  end;

  if (Combobox1.itemindex>-1) and (Combobox1.itemindex<length(mainform.devices)) then
    if FileExists(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+filename) then
      Image2.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+filename);
end;

procedure Tfirststepsform.JvXPButton12Click(Sender: TObject);
begin
  geraetesteuerung.PngBitBtn3Click(nil);
end;

procedure Tfirststepsform.buttonfarbeChange(Sender: TObject);
begin
  if (Combobox1.itemindex>-1) and (Combobox1.itemindex<length(mainform.devices)) then
    mainform.Devices[Combobox1.itemindex].color:=buttonfarbe.Color;
end;

procedure Tfirststepsform.DIP1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  LSB,MSB:byte;
  temp:integer;
begin
  if (button=mbLeft) then
  begin
    for i:=1 to 10 do
    begin
      if Sender=Timage(FindComponent('DIP'+inttostr(i))) then
      begin
        if dipstate[i] then
        begin
          // ausschalten
          dipstate[i]:=false;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;
        end else
        begin
          // einschalten
          dipstate[i]:=true;
          Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture;
        end;
      end;
    end;

    LSB:=0;
    if dipstate[1] then LSB:=LSB or 1;
    if dipstate[2] then LSB:=LSB or 2;
    if dipstate[3] then LSB:=LSB or 4;
    if dipstate[4] then LSB:=LSB or 8;
    if dipstate[5] then LSB:=LSB or 16;
    if dipstate[6] then LSB:=LSB or 32;
    if dipstate[7] then LSB:=LSB or 64;
    if dipstate[8] then LSB:=LSB or 128;
    MSB:=0;
    if dipstate[9] then MSB:=MSB or 1;
    if dipstate[10] then MSB:=MSB or 2;
    temp:=MSB;
    temp:=temp shl 8;
    temp:=temp+LSB;

    if (temp > 0) then
      DevStartaddressEdit.Value:=temp;
  end;
end;

procedure Tfirststepsform.JvXPButton13Click(Sender: TObject);
begin
  geraetesteuerung.renamebtnClick(nil);
end;

procedure Tfirststepsform.DevStartaddressEditChangeChange(Sender: TObject);
var
  temp,startaddress:Byte;
  i:integer;
  key:word;
begin
  if DontUpdateDevStartaddressEdit then exit;

  startaddress:=round(DevStartaddressEdit.Value);
  temp:=startaddress;
  dipstate[1]:=BitSet(temp, 1);
  dipstate[2]:=BitSet(temp, 2);
  dipstate[3]:=BitSet(temp, 4);
  dipstate[4]:=BitSet(temp, 8);
  dipstate[5]:=BitSet(temp, 16);
  dipstate[6]:=BitSet(temp, 32);
  dipstate[7]:=BitSet(temp, 64);
  dipstate[8]:=BitSet(temp, 128);

  temp:=round(DevStartaddressEdit.Value) shr 8;
  dipstate[9]:=BitSet(temp, 1);
  dipstate[10]:=BitSet(temp, 2);

  for i:=1 to 10 do
    if dipstate[i] then
      Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPON.Picture
    else
      Timage(FindComponent('DIP'+inttostr(i))).Picture:=DIPOFF.Picture;

  geraetesteuerung.DevStartaddressEdit.Text:=inttostr(startaddress);
  key:=vk_return;
  geraetesteuerung.DevStartaddressEditKeyUp(geraetesteuerung.DevStartaddressEdit, key, []);
end;

procedure Tfirststepsform.ComboBox1Select(Sender: TObject);
var
  i,j,k:integer;
  Data:PTreeData;
  filename:string;
begin
  if (Combobox1.itemindex>-1) and (Combobox1.itemindex<length(mainform.devices)) then
  begin
    geraetesteuerung.VST.SelectAll(false);
    geraetesteuerung.VST.InvertSelection(false);
    
    for i:=0 to length(geraetesteuerung.VSTDeviceNodes)-1 do
    for j:=0 to length(geraetesteuerung.VSTDeviceNodes[i])-1 do
    for k:=0 to length(geraetesteuerung.VSTDeviceNodes[i][j])-1 do
    begin
      Data:=geraetesteuerung.VST.GetNodeData(geraetesteuerung.VSTDeviceNodes[i][j][k]);

      if IsEqualGUID(Data^.ID, mainform.devices[Combobox1.itemindex].ID) then
      begin
        geraetesteuerung.VST.Expanded[geraetesteuerung.VSTDeviceNodes[i][j][k].Parent.Parent]:=true;
        geraetesteuerung.VST.Expanded[geraetesteuerung.VSTDeviceNodes[i][j][k].Parent]:=true;
        geraetesteuerung.VST.Expanded[geraetesteuerung.VSTDeviceNodes[i][j][k]]:=true;
        geraetesteuerung.VST.Selected[geraetesteuerung.VSTDeviceNodes[i][j][k]]:=true;
        geraetesteuerung.VST.FocusedNode:=geraetesteuerung.VSTDeviceNodes[i][j][k];
      end;
    end;
    geraetesteuerung.TreeViewCheckbuttons([]);

    DontUpdateDevStartaddressEdit:=true;
    DevStartaddressEdit.Value:=mainform.devices[Combobox1.itemindex].Startaddress;
    DontUpdateDevStartaddressEdit:=false;

    buttonfarbe.Color:=mainform.devices[Combobox1.itemindex].color;
    if FileExists(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[Combobox1.itemindex].Bildadresse) then
    begin
      filename:=ExtractFileName(mainform.pcdimmerdirectory+'Devicepictures\'+mainform.devices[Combobox1.itemindex].Bildadresse);
    end;
    if FileExists(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+filename) then
      Image2.Picture.LoadFromFile(mainform.pcdimmerdirectory+'Devicepictures\64 x 64\'+filename);
    label15.caption:=inttostr(mainform.devices[Combobox1.itemindex].Power)+' W';

    label17.caption:=mainform.devices[Combobox1.itemindex].Vendor;
    label19.caption:=mainform.devices[Combobox1.itemindex].Beschreibung;
    label16.Caption:=inttostr(mainform.devices[Combobox1.itemindex].MaxChan);
    checkbox2.checked:=mainform.devices[Combobox1.itemindex].hasDimmer;
    checkbox3.checked:=mainform.devices[Combobox1.itemindex].hasRGB;
    checkbox4.checked:=mainform.devices[Combobox1.itemindex].hasPANTILT;
    checkbox5.checked:=mainform.devices[Combobox1.itemindex].hasColor;
  end;
  GroupBox5.visible:=(Combobox1.itemindex>-1) and (Combobox1.itemindex<length(mainform.devices));
  GroupBox6.visible:=GroupBox5.visible;
  GroupBox7.visible:=GroupBox5.visible;
end;

procedure Tfirststepsform.JvXPButton18Click(Sender: TObject);
begin
  close;
end;

procedure Tfirststepsform.JvXPButton14Click(Sender: TObject);
begin
  mainform.Szenenverwaltung1Click(nil);
end;

procedure Tfirststepsform.JvXPButton15Click(Sender: TObject);
begin
  effektsequenzer.show;
end;

procedure Tfirststepsform.JvXPButton16Click(Sender: TObject);
begin
  Mainform.Kontrollpanel1Click(nil);
end;

procedure Tfirststepsform.JvXPButton17Click(Sender: TObject);
begin
  Mainform.Bhnenansicht1Click(nil);
end;

procedure Tfirststepsform.CreateParams(var Params:TCreateParams);
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

procedure Tfirststepsform.JvXPButton20Click(Sender: TObject);
begin
  cuelistform.show;
end;

procedure Tfirststepsform.Timer1Timer(Sender: TObject);
begin
  Timer1.enabled:=false;
  firststepsform.BringToFront;
end;

procedure Tfirststepsform.JvXPButton21Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('http://www.pcdimmer.de/wiki/index.php/Kategorie:Handbuch'), nil, nil, SW_SHOW);
end;

end.
