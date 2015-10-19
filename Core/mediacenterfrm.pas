unit mediacenterfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvGradient, Mask,
  JvExMask, JvSpin, gnugettext;

type
  Tmediacenterform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Shape2: TShape;
    Shape1: TShape;
    CancelBtn: TButton;
    OKBtn: TButton;
    befehlcombobox: TComboBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Data1Edit: TJvSpinEdit;
    GroupBox2: TGroupBox;
    Data2Edit: TJvSpinEdit;
    ZeitBox: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    hEdit: TEdit;
    minEdit: TEdit;
    sEdit: TEdit;
    msEdit: TEdit;
    GroupBox3: TGroupBox;
    filenameedit: TEdit;
    data1label: TLabel;
    data2label: TLabel;
    data1checkbox: TCheckBox;
    Label2: TLabel;
    nameedit: TEdit;
    Label4: TLabel;
    descriptionedit: TEdit;
    Label8: TLabel;
    videoindeviceslistbox: TListBox;
    Bevel1: TBevel;
    Label9: TLabel;
    videopositionlabel: TLabel;
    Button2: TButton;
    Label10: TLabel;
    videolengthlabel: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    addressedit: TEdit;
    portedit: TJvSpinEdit;
    Button1: TButton;
    mediacentertimecodelbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure befehlcomboboxSelect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  mediacenterform: Tmediacenterform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Tmediacenterform.FormShow(Sender: TObject);
var
  t,h,min,s,ms:integer;
begin
  case mainform.aktuellemediacenterszene.Befehl of
    0: befehlcombobox.ItemIndex:=0; // Videodatei laden
    1: befehlcombobox.ItemIndex:=1; // Video starten
    2: befehlcombobox.ItemIndex:=2; // Video pausieren
    3: befehlcombobox.ItemIndex:=3; // Video stoppen
    4: befehlcombobox.ItemIndex:=4; // Videolautstärke setzen
    5: befehlcombobox.ItemIndex:=5; // Video stummschalten (ein/aus)
    6: befehlcombobox.ItemIndex:=6; // Seitenverhältnis beibehalten (ein/aus)
    7: befehlcombobox.ItemIndex:=7; // Videoposition setzen
//    9: ; // Inputdevices suchen
    10..11: befehlcombobox.ItemIndex:=8; // Live-Videoeingang starten
    12: befehlcombobox.ItemIndex:=9; // Videofenster anzeigen (ein/aus)
    13: befehlcombobox.ItemIndex:=10; // Videofenster anzeigen (ein/aus)

    20: befehlcombobox.ItemIndex:=12; // Bild aus Datei laden
    21: befehlcombobox.ItemIndex:=13; // Bild anzeigen (ein/aus)

    40: befehlcombobox.ItemIndex:=15; // Powerpoint Datei anzeigen
    41: befehlcombobox.ItemIndex:=16; // Powerpoint Folie weiterschalten
    42: befehlcombobox.ItemIndex:=17; // Powerpoint Folie zurückschalten
    43: befehlcombobox.ItemIndex:=18; // Powerpoint zu bestimmter Folie
    44: befehlcombobox.ItemIndex:=19; // // Powerpoint beenden

    60: befehlcombobox.ItemIndex:=21; // MediaCenter anzeigen/verbergen
    61: befehlcombobox.ItemIndex:=22; // Datei/Programm starten

    80: befehlcombobox.ItemIndex:=24; // Audiodatei laden
    81: befehlcombobox.ItemIndex:=25; // Audio play
    82: befehlcombobox.ItemIndex:=26; // Audio pause
    83: befehlcombobox.ItemIndex:=27; // Audio stop
    84: befehlcombobox.ItemIndex:=28; // Position
    85: befehlcombobox.ItemIndex:=29; // Lautstärke
  end;

  nameedit.Text:=mainform.aktuellemediacenterszene.name;
  descriptionedit.Text:=mainform.aktuellemediacenterszene.Beschreibung;
  addressedit.Text:=mainform.aktuellemediacenterszene.Adresse;
  portedit.Value:=mainform.aktuellemediacenterszene.port;

  data1edit.Value:=mainform.aktuellemediacenterszene.Data1;
  if mainform.aktuellemediacenterszene.Data1=0 then
    data1checkbox.State:=cbUnchecked
  else if mainform.aktuellemediacenterszene.Data1=127 then
    data1checkbox.State:=cbGrayed
  else if mainform.aktuellemediacenterszene.Data1=255 then
    data1checkbox.State:=cbChecked;

  t:=mainform.aktuellemediacenterszene.Data1;
  h:=t div 3600000; t:=t mod 3600000;
  min:=t div 60000; t:=t mod 60000;
  s:=t div 1000; t:=t mod 1000;
  ms:=t;

  data2edit.Value:=mainform.aktuellemediacenterszene.Data2;

  hEdit.Text:=inttostr(h);
  minEdit.Text:=inttostr(min);
  sEdit.Text:=inttostr(s);
  msEdit.Text:=inttostr(ms);

  filenameedit.Text:=mainform.aktuellemediacenterszene.Text;

  befehlcomboboxSelect(nil);
end;

procedure Tmediacenterform.OKBtnClick(Sender: TObject);
begin
  mainform.aktuellemediacenterszene.name:=nameedit.Text;
  mainform.aktuellemediacenterszene.Beschreibung:=descriptionedit.Text;
  mainform.aktuellemediacenterszene.Adresse:=addressedit.Text;
  mainform.aktuellemediacenterszene.Port:=Round(portedit.value);

  case befehlcombobox.itemindex of
    0: mainform.aktuellemediacenterszene.Befehl:=0;
    1: mainform.aktuellemediacenterszene.Befehl:=1;
    2: mainform.aktuellemediacenterszene.Befehl:=2;
    3: mainform.aktuellemediacenterszene.Befehl:=3;
    4: mainform.aktuellemediacenterszene.Befehl:=4;
    5: mainform.aktuellemediacenterszene.Befehl:=5;
    6: mainform.aktuellemediacenterszene.Befehl:=6;
    7: mainform.aktuellemediacenterszene.Befehl:=7;
    8:
    begin
      if filenameedit.Text='' then
        mainform.aktuellemediacenterszene.Befehl:=10
      else
        mainform.aktuellemediacenterszene.Befehl:=11;
    end;
    9: mainform.aktuellemediacenterszene.Befehl:=12;
    10: mainform.aktuellemediacenterszene.Befehl:=13;
//    11: mainform.aktuellemediacenterszene.Befehl:=;
    12: mainform.aktuellemediacenterszene.Befehl:=20;
    13: mainform.aktuellemediacenterszene.Befehl:=21;
//    14: mainform.aktuellemediacenterszene.Befehl:=;
    15: mainform.aktuellemediacenterszene.Befehl:=40;
    16: mainform.aktuellemediacenterszene.Befehl:=41;
    17: mainform.aktuellemediacenterszene.Befehl:=42;
    18: mainform.aktuellemediacenterszene.Befehl:=43;
    19: mainform.aktuellemediacenterszene.Befehl:=44;
//    20: mainform.aktuellemediacenterszene.Befehl:=;
    21: mainform.aktuellemediacenterszene.Befehl:=60;
    22: mainform.aktuellemediacenterszene.Befehl:=61;
//    23: mainform.aktuellemediacenterszene.Befehl:=;
    24: mainform.aktuellemediacenterszene.Befehl:=80;
    25: mainform.aktuellemediacenterszene.Befehl:=81;
    26: mainform.aktuellemediacenterszene.Befehl:=82;
    27: mainform.aktuellemediacenterszene.Befehl:=83;
    28: mainform.aktuellemediacenterszene.Befehl:=84;
    29: mainform.aktuellemediacenterszene.Befehl:=85;
  end;

  if GroupBox1.Visible then
  begin
    if data1checkbox.Visible then
    begin
      if data1checkbox.State=cbUnchecked then mainform.aktuellemediacenterszene.Data1:=0;
      if data1checkbox.State=cbGrayed then mainform.aktuellemediacenterszene.Data1:=127;
      if data1checkbox.State=cbChecked then mainform.aktuellemediacenterszene.Data1:=255;
    end else
    begin
      mainform.aktuellemediacenterszene.Data1:=round(data1edit.Value);
    end;
  end else
  begin
    mainform.aktuellemediacenterszene.Data1:=strtoint(msEdit.text)+strtoint(sEdit.text)*1000+strtoint(minEdit.text)*60000+strtoint(hEdit.text)*3600000;
  end;

  mainform.aktuellemediacenterszene.Data2:=round(data2edit.Value);
  mainform.aktuellemediacenterszene.Text:=filenameedit.Text;
end;

procedure Tmediacenterform.befehlcomboboxSelect(Sender: TObject);
begin
{
Videodatei laden
Video starten
Video pausieren
Video stoppen
Videolautstärke setzen
Video stummschalten (ein/aus)
Seitenverhältnis beibehalten (ein/aus)
Videoposition setzen
Live-Videoeingang starten
Videofenster anzeigen (ein/aus)
-
Bild aus Datei laden
Bild anzeigen (ein/aus)
-
Powerpoint Datei anzeigen
Powerpoint Folie weiterschalten
Powerpoint Folie zurückschalten
Powerpoint beenden
-
MediaCenter anzeigen
MediaCenter ausblenden
Datei/Programm starten
MediaCenter in den Vordergrund bringen
}
  GroupBox1.Visible:=false;
  GroupBox2.Visible:=false;
  ZeitBox.Visible:=false;
  GroupBox3.Visible:=false;
  data1edit.Visible:=false;
  data1checkbox.Visible:=false;

  data1label.Caption:='Data 1:';
  data2label.Caption:='Data 2:';

  case befehlcombobox.itemindex of
    0: begin GroupBox3.Visible:=true; end;
    1: begin end;
    2: begin end;
    3: begin end;
    4: begin GroupBox1.Visible:=true; data1edit.Visible:=true; data1label.Caption:=_('Lautstärke:'); end;
    5: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
    6: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
    7: begin ZeitBox.Visible:=true; end;
    8: begin GroupBox1.Visible:=true; data1edit.Visible:=true; data1label.Caption:=_('Videoeingang:'); GroupBox3.Visible:=true; end;
    9: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
    10: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
//    11: begin end;
    12: begin GroupBox3.Visible:=true; end;
    13: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
//    14: begin end;
    15: begin GroupBox3.Visible:=true; end;
    16: begin end;
    17: begin end;
    18: begin GroupBox1.Visible:=true; data1edit.Visible:=true; data1label.Caption:=_('Foliennummer:'); end;
    19: begin end;
//    20: begin end;
    21: begin GroupBox1.Visible:=true; data1checkbox.Visible:=true; end;
    22: begin GroupBox3.Visible:=true; end;
//    23: begin end;
    24: begin GroupBox3.visible:=true; end;
    25: begin end;
    26: begin end;
    27: begin end;
    28: begin ZeitBox.Visible:=true; end;
    29: begin GroupBox1.Visible:=true; data1edit.Visible:=true; data1label.Caption:=_('Lautstärke [%]:'); end;
  end;
end;

procedure Tmediacenterform.Button2Click(Sender: TObject);
var
  MediaCenterCommand:TMediaCenterCommand;
  timeout:integer;
begin
  if not ((mainform.MediaCenterSocket.Address=addressedit.text) and (mainform.MediaCenterSocket.Port=round(portedit.value)) and (mainform.MediaCenterSocket.Socket.Connected)) then
  begin
    if mainform.MediaCenterSocket.Socket.Connected then
      mainform.MediaCenterSocket.Active:=false;
    mainform.MediaCenterSocket.Address:=addressedit.text;
    mainform.MediaCenterSocket.Port:=round(portedit.value);
    mainform.MediaCenterSocket.Active:=true;

    timeout:=0;
    repeat
      Application.ProcessMessages;
      sleep(100);
      timeout:=timeout+1;
    until (mainform.MediaCenterSocket.Socket.Connected) or (timeout>=30);
  end;

  if mainform.MediaCenterSocket.Socket.Connected then
  begin
    MediaCenterCommand.Befehl:=8;
    MediaCenterCommand.Data1:=0;
    MediaCenterCommand.Data2:=0;
    MediaCenterCommand.Text:='';
    mainform.MediaCenterSocket.Socket.SendBuf(MediaCenterCommand, sizeof(MediaCenterCommand));

    MediaCenterCommand.Befehl:=9;
    MediaCenterCommand.Data1:=0;
    MediaCenterCommand.Data2:=0;
    MediaCenterCommand.Text:='';
    mainform.MediaCenterSocket.Socket.SendBuf(MediaCenterCommand, sizeof(MediaCenterCommand));
  end else
  begin
    ShowMessage(_('Es konnte keine Verbindung zum MediaCenter Server hergestellt werden. Bitte kontrollieren Sie ihre Angaben in den Feldern "Adresse" und "Port".'));
  end;
end;

procedure Tmediacenterform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tmediacenterform.Button1Click(Sender: TObject);
var
  MediaCenterCommand:TMediaCenterCommand;
  timeout:integer;
begin
  OKBtnClick(nil);

  if not ((mainform.MediaCenterSocket.Address=addressedit.text) and (mainform.MediaCenterSocket.Port=round(portedit.value)) and (mainform.MediaCenterSocket.Socket.Connected)) then
  begin
    if mainform.MediaCenterSocket.Socket.Connected then
      mainform.MediaCenterSocket.Active:=false;
    mainform.MediaCenterSocket.Address:=addressedit.text;
    mainform.MediaCenterSocket.Port:=round(portedit.value);
    mainform.MediaCenterSocket.Active:=true;

    timeout:=0;
    repeat
      Application.ProcessMessages;
      sleep(100);
      timeout:=timeout+1;
    until (mainform.MediaCenterSocket.Socket.Connected) or (timeout>=30);
  end;

  if mainform.MediaCenterSocket.Socket.Connected then
  begin
    MediaCenterCommand.Befehl:=mainform.AktuelleMediaCenterSzene.Befehl;
    MediaCenterCommand.Data1:=mainform.AktuelleMediaCenterSzene.Data1;
    MediaCenterCommand.Data2:=mainform.AktuelleMediaCenterSzene.Data2;
    MediaCenterCommand.Text:=mainform.AktuelleMediaCenterSzene.Text;
    mainform.MediaCenterSocket.Socket.SendBuf(MediaCenterCommand, sizeof(MediaCenterCommand));
  end else
  begin
    ShowMessage(_('Es konnte keine Verbindung zum MediaCenter Server hergestellt werden. Bitte kontrollieren Sie ihre Angaben in den Feldern "Adresse" und "Port".'));
  end;
end;

procedure Tmediacenterform.CreateParams(var Params:TCreateParams);
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

end.
