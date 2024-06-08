unit addfunctionfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, JvGradient, gnugettext;

type
  Taddfunctionform = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    OKBtn: TButton;
    CancelBtn: TButton;
    Shape2: TShape;
    Memo1: TMemo;
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    procedure ListboxChanged;
  public
    { Public-Deklarationen }
  end;

var
  addfunctionform: Taddfunctionform;

implementation

uses PCDIMMER;

{$R *.dfm}

procedure Taddfunctionform.ListboxChanged;
begin
  case Listbox1.ItemIndex of
    0:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// {Kanal}, {Startwert}, {Endwert} und {Zeit} durch ganze Zahlen ersetzen'));
      Memo1.Lines.Add(_('// {Zeit} in Millisekunden angeben'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('set_absolutchannel({Kanal}, {Startwert}, {Endwert}, {Zeit});'));
    end;
    1:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// GeräteID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add(_('// Gerätekanal als Text angeben (''DIMMER'',''PAN'',''TILT'', usw.)'));
      Memo1.Lines.Add(_('// {Startwert}, {Endwert} und {Zeit} durch ganze Zahlen ersetzen'));
      Memo1.Lines.Add(_('// Zeit in Millisekunden angeben'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('set_channel({GeräteID}, {Gerätekanal}, {Startwert}, {Endwert}, {Zeit});'));
    end;
    2:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// GruppenID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add(_('// Gerätekanal als Text angeben (''DIMMER'',''PAN'',''TILT'', usw.)'));
      Memo1.Lines.Add(_('// {Startwert}, {Endwert} und {Zeit} durch ganze Zahlen ersetzen'));
      Memo1.Lines.Add(_('// Zeit in Millisekunden angeben'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('set_groupchannel({GruppenID}, {Gerätekanal}, {Startwert}, {Endwert}, {Zeit});'));
    end;
    3:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Rückgabe ist ein Zahlenwert des Kanalwertes'));
      Memo1.Lines.Add(_('// {Kanal} durch ganze Zahlen ersetzen'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('get_absolutchannel({Kanal}):integer;'));
    end;
    4:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// GeräteID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add(_('// Gerätekanal als Text angeben (''DIMMER'',''PAN'',''TILT'', usw.)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('get_channel(GeräteID, Gerätekanal):integer;'));
    end;
    5:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// {Kanalwert} durch ganze Zahlen ersetzen'));
      Memo1.Lines.Add(_('// Es wird je nach Einstellungen ein Text in %-, Komma- oder Byte-Anzeige zurückgegeben'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('levelstr({Kanalwert}):string;'));
    end;
    6:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// SzenenID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('startscene(SzenenID);'));
    end;
    7:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// SzenenID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('stopscene(SzenenID);'));
    end;
    8:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// SzenenID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('startstopscene(SzenenID);'));
    end;
    9:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// EffektID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('starteffect(EffektID);'));
    end;
    10:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// EffektID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('stopeffect(EffektID);'));
    end;
    11:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// EffektID als ID in einfachen Anführungszeichen angeben (ID bekommt man in den jeweiligen Programmfenstern)'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('startstopeffect(EffektID);'));
    end;
    12: ;// Frei
    13:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// blendet eine Eingabebox für Werte ein'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('{IntegerVariable}:=StrToInt(InputBox(''Überschrift'',''Hinweistext'',inttostr(123)));'));
    end;
    14:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Zeigt eine Nachricht an'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add('ShowMessage(''Text'');');
    end;
    15:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Wandelt Ganzzahlen in Text'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add('{text}:=inttostr({zahl});');
    end;
    16:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Wandelt Text in Ganzzahlen um'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('{zahl}:=strtoint(''TEXT'');'));
    end;
    17:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Wandelt die aktuelle Uhrzeit / Datum in Text um'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add('ShowMessage(DateToStr(now));');
      Memo1.Lines.Add('ShowMessage(TimeToStr(now));');
    end;
    18:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Erlaubt Bedingungsabläufe zu erstellen'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('if {Bedingung} then'));
      Memo1.Lines.Add('begin');
      Memo1.Lines.Add(_('  {machwas};'));
      Memo1.Lines.Add('end else');
      Memo1.Lines.Add('begin');
      Memo1.Lines.Add(_('  {machwasanderes};'));
      Memo1.Lines.Add('end;');
    end;
    19:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Erlaubt Bedingungsabläufe zu erstellen'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add('case {IntegerVariable} of');
      Memo1.Lines.Add(_('  0: ; // wenn Wert = 0'));
      Memo1.Lines.Add(_('  1..2: ; // wenn Wert zwischen 1 und 2'));
      Memo1.Lines.Add(_('  3,5: ; // wenn Wert 3 oder 5'));
      Memo1.Lines.Add(_('  4: ; // wenn Wert =4'));
      Memo1.Lines.Add('end;');
    end;
    20:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Erstellt eine Abfrage mit Bedingung'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add(_('if messagedlg(''Möchten Sie hier auf "Nein" drücken? ;-)'',mtConfirmation,'));
      Memo1.Lines.Add('  [mbYes,mbNo],0)=mrYes then');
      Memo1.Lines.Add('  begin');
      Memo1.Lines.Add(_('    ShowMessage(''Es wurde "Ja" gedrückt'');'));
      Memo1.Lines.Add('  end else');
      Memo1.Lines.Add('  begin');
      Memo1.Lines.Add(_('    ShowMessage(''Es wurde "Nein" gedrückt'');'));
      Memo1.Lines.Add('  end;');
    end;

    22:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Variablen setzen und abfragen'));
      Memo1.Lines.Add('');
      Memo1.Lines.Add('set_globalvar(1, ''Test'');');
      Memo1.Lines.Add('set_var(2, 5.1); // Funktioniert lediglich außerhalb dieses Editors!');
      Memo1.Lines.Add('ShowMessage(get_globalvar(1)+'' = ''+inttostr(get_var(2)));');
    end;
    23:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// Kontrollpanel Buttonfarbe abfragen'));
      Memo1.Lines.Add('//var Color:TColor;');
      Memo1.Lines.Add('//var Text:String;');
      Memo1.Lines.Add('Color:=get_panelbuttoncolor(1,1);');
      Memo1.Lines.Add('set_panelbuttoncolor(1,1, Color);');
      Memo1.Lines.Add('Text:=get_panelbuttontext(1,1);');
      Memo1.Lines.Add('set_panelbuttontext(1,1, Text);');
    end;
    24:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// MIDI Nachricht senden'));
      Memo1.Lines.Add('sendmidi(64, 64, 127);');
      Memo1.Lines.Add('ShowMessage(get_lastmidi()); // returns MSG, Data1, Data2');
    end;
    25:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// DataIn Nachricht senden'));
      Memo1.Lines.Add('senddatain(1, 255);');
      Memo1.Lines.Add('ShowMessage(get_lastdatain()); //returns MSB, LSB of Channel, Value');
    end;
    26:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// PC_DIMMER Nachricht senden'));
      Memo1.Lines.Add('// Translate PC_DIMMER to english');
      Memo1.Lines.Add('sendmessage(MSG_SETLANGUAGE, 0, 0);');
      Memo1.Lines.Add('// Kanal 5 auf 241 setzen');
      Memo1.Lines.Add('sendmessage(MSG_ACTUALCHANNELVALUE, 5, 241);');
    end;
    27:
    begin
      Memo1.Clear;
      Memo1.Lines.Add(_('// MQTT Nachricht senden'));
      Memo1.Lines.Add('sendmqtt(''Testtopic'',''Testpayload'');');
    end;
  end;
  Memo1.SelectAll;
  Memo1.CopyToClipboard;
  Memo1.SelLength:=0;
end;

procedure Taddfunctionform.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListboxChanged;
end;

procedure Taddfunctionform.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ListboxChanged;
end;

procedure Taddfunctionform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ListboxChanged;
end;

procedure Taddfunctionform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ListboxChanged;
end;

procedure Taddfunctionform.ListBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
    ListboxChanged;
end;

procedure Taddfunctionform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Taddfunctionform.CreateParams(var Params:TCreateParams);
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
