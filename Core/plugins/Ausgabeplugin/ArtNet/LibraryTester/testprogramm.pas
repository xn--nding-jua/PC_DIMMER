unit testprogramm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, ExtCtrls;

type
  // Array- und Pointertyp für Übergabe von DMX-Werten 
  TDMXArray = array of byte;
  PDMXArray = ^TDMXArray;

  Tmainform = class(TForm)
    btnActivate: TButton;
    btnDeactivate: TButton;
    btnSendUniverse: TButton;
    btnShowConfig: TButton;
    Label1: TLabel;
    XPManifest1: TXPManifest;
    btnLoadLibrary: TButton;
    btnFreeLibrary: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cbReceive00: TCheckBox;
    btnShowAbout: TButton;
    btnSetChannel: TButton;
    btnSendUniverseRAW: TButton;
    btnPollingRequest: TButton;
    procedure btnActivateClick(Sender: TObject);
    procedure btnDeactivateClick(Sender: TObject);
    procedure btnSendUniverseClick(Sender: TObject);
    procedure btnShowConfigClick(Sender: TObject);
    procedure btnLoadLibraryClick(Sender: TObject);
    procedure btnFreeLibraryClick(Sender: TObject);
    procedure cbReceive00MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnShowAboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSetChannelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSendUniverseRAWClick(Sender: TObject);
    procedure btnPollingRequestClick(Sender: TObject);
  private
    { Private-Deklarationen }
    DLL:THandle;
    ArtNET_Activate:procedure(ReceiveDMXUniverse, ReceiveSingleValue:Pointer); stdcall;
    ArtNET_Deactivate:procedure; stdcall;
    ArtNET_SendPollingRequest:procedure(IPAddress: String); stdcall;
    ArtNET_SetChannel:procedure(ArtNETSubNet:integer; ArtNetUniverse:integer; Channel:integer; Value:integer);stdcall;
    ArtNET_SendDMXUniverse:procedure(ArtNETSubNet:integer; ArtNetUniverse:integer; Buffer: PDMXArray; Length:integer); stdcall;
    ArtNET_SendDMXUniverse_RAW:procedure(ArtNETSubNet:integer; ArtNetUniverse:integer; Buffer: PDMXArray; Length:integer); stdcall;
    ArtNET_ShowConfig:procedure; stdcall;
    ArtNET_ShowAbout:procedure; stdcall;
    ArtNET_SetReceiveUniverseOnOff:procedure(ArtNETSubNet:integer; ArtNetUniverse:integer; Enabled: boolean);stdcall;
    TestUniverse:TDMXArray;
  public
    { Public-Deklarationen }
  end;

// Prototyp der Callbackfunktion
procedure ReceiveDMXUniverse(ArtNETSubNet:integer; ArtNETUniverse:integer; Buffer: PDMXArray; Length:integer);stdcall;
procedure ReceiveSingleValue(ArtNETSubNet:integer; ArtNETUniverse:integer; Channel:integer; Value:integer);stdcall;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

// Callbackfunktion zum Empfangen von DMX-Universen über ArtNET
procedure ReceiveDMXUniverse(ArtNETSubNet:integer; ArtNETUniverse:integer; Buffer: PDMXArray; Length:integer);stdcall;
begin
  // DMX-Universen empfangen. In diesem Falle nur eine kleine Info anzeigen.
  // Werte der einzelnen Kanäle kann man mit Buffer^[Channel] abrufen, wobei
  // Channel zwischen 0 und Length-1 (in der Regel 511) liegt.
  mainform.Label1.Caption:='Zuletzt empfangenes Paket:'+#13#10+
                           'Uhrzeit: '+TimeToStr(now)+#13#10+
                           'Kanalanzahl: '+inttostr(Length)+#13#10+
                           'Subnet: '+inttostr(ArtNETSubNet)+#13#10+
                           'Universe: '+inttostr(ArtNETUniverse);
end;

// Callbackfunktion zum Empfang von veränderten Werten
procedure ReceiveSingleValue(ArtNETSubNet:integer; ArtNETUniverse:integer; Channel:integer; Value:integer);stdcall;
begin
  //
end;

procedure Tmainform.btnActivateClick(Sender: TObject);
begin
  // DLL initialisieren und Pointer der Callback-Funktion übergeben
  ArtNET_Activate(@ReceiveDMXUniverse, @ReceiveSingleValue);

  // GUI-Buttons sperren/entsperren
  btnActivate.Enabled:=false;
  btnDeactivate.Enabled:=true;
  btnPollingRequest.Enabled:=true;
  btnSetChannel.Enabled:=true;
  btnSendUniverse.Enabled:=true;
  btnSendUniverseRAW.Enabled:=true;
  btnShowConfig.Enabled:=true;
  btnShowAbout.Enabled:=true;
  btnFreeLibrary.Enabled:=false;
  cbReceive00.Enabled:=true;
end;

procedure Tmainform.btnDeactivateClick(Sender: TObject);
begin
  // DLL-Sitzung beenden
  ArtNET_Deactivate;

  // GUI-Buttons sperren/entsperren
  btnActivate.Enabled:=true;
  btnDeactivate.Enabled:=false;
  btnPollingRequest.Enabled:=false;
  btnSetChannel.Enabled:=false;
  btnSendUniverse.Enabled:=false;
  btnSendUniverseRAW.Enabled:=false;
  btnShowConfig.Enabled:=false;
  btnShowAbout.Enabled:=false;
  btnFreeLibrary.Enabled:=true;
  cbReceive00.Enabled:=false;
end;

procedure Tmainform.btnSendUniverseClick(Sender: TObject);
var
  i:integer;
begin
  // Testuniverse mit Zufallswerten zusammenstellen
  for i:=0 to 511 do
    TestUniverse[i]:=Random(256);

  // Testuniverse als Pointer der DLL übergeben und als Subnet 0, Universe 0 senden
  // Diese Senden-Funktion verwendet die Einstellungen des Config-Dialogs. Ist dort
  // das Senden nach Spezifikation eingestellt (Standard), dann wird der Parameter
  // ArtNet-Subnet ignoriert. Man hat dann lediglich Zugriff auf die vier Universes
  // (ArtNetUniverse=0..3, deren Routing man im Config-Dialog einstellen kann.
  // Ist das Senden aller Universes aktiviert, kann man zwar mit dem Parameter
  // ArtNet-Subnet Werte in die Arrays schreiben, es wird aber nur das Subnet gesendet
  // welches im Config-Dialog ausgewählt wurde.
  ArtNET_SendDMXUniverse(0, 0, @TestUniverse, 512);
end;

procedure Tmainform.btnSendUniverseRAWClick(Sender: TObject);
var
  i:integer;
begin
  // Testuniverse mit Zufallswerten zusammenstellen
  for i:=0 to 511 do
    TestUniverse[i]:=Random(256);

  // Testuniverse als Pointer der DLL übergeben und als Subnet 0, Universe 0 senden
  // Diese RAW-Funktion ignoriert alle Einstellungen des Config-Dialoges und sendet
  // entsprechend der übergebenen ArtNetSubnet und ArtNetUniverse-Parameter
  //
  // Achtung: wenn man im Config-Dialog "Kontinuierliches Senden" aktiviert hat
  // werden ggfs. die hier übertragenen Werte wieder von der herkömmlichen Senden-
  // Routine überschrieben
  ArtNET_SendDMXUniverse_RAW(0, 0, @TestUniverse, 512);
end;

procedure Tmainform.btnShowConfigClick(Sender: TObject);
begin
  // Konfigurationsbildschirm anzeigen
  ArtNET_ShowConfig;
end;

procedure Tmainform.btnLoadLibraryClick(Sender: TObject);
begin
  if FileExists(ExtractFilePath(paramstr(0))+'\ArtNETlib.dll') then
  begin
    // DLL laden
    DLL:=LoadLibrary(PChar(ExtractFilePath(paramstr(0))+'\ArtNETlib.dll'));

    // Funktionen zuweisen
    ArtNET_Activate:=GetProcAddress(DLL, 'ArtNET_Activate');
    ArtNET_Deactivate:=GetProcAddress(DLL, 'ArtNET_Deactivate');
    ArtNET_SendPollingRequest:=GetProcAddress(DLL, 'ArtNET_SendPollingRequest');
    ArtNET_SetChannel:=GetProcAddress(DLL, 'ArtNET_SetChannel');
    ArtNET_SendDMXUniverse:=GetProcAddress(DLL, 'ArtNET_SendDMXUniverse');
    ArtNET_SendDMXUniverse_RAW:=GetProcAddress(DLL, 'ArtNET_SendDMXUniverse_RAW');
    ArtNET_ShowConfig:=GetProcAddress(DLL, 'ArtNET_ShowConfig');
    ArtNET_ShowAbout:=GetProcAddress(DLL, 'ArtNET_ShowAbout');
    ArtNET_SetReceiveUniverseOnOff:=GetProcAddress(DLL,'ArtNET_SetReceiveUniverseOnOff');

    // GUI-Buttons sperren/entsperren
    btnLoadLibrary.enabled:=false;
    btnFreeLibrary.Enabled:=true;
    btnActivate.Enabled:=true;
  end else
  begin
    ShowMessage('Die DLL "ArtNETlib.dll" wurde nicht gefunden...');
  end;
end;

procedure Tmainform.btnFreeLibraryClick(Sender: TObject);
begin
  // DLL-Verbindung auflösen
  FreeLibrary(DLL);

  // GUI-Buttons sperren/entsperren
  btnLoadLibrary.enabled:=true;
  btnFreeLibrary.Enabled:=false;
  btnActivate.Enabled:=false;
end;

procedure Tmainform.cbReceive00MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Den Empfang einzelner Universen ein- oder ausschalten
  ArtNET_SetReceiveUniverseOnOff(0, 0, cbReceive00.checked);
end;

procedure Tmainform.btnShowAboutClick(Sender: TObject);
begin
  // Infobildschirm mit Versions- und Kontaktdaten anzeigen
  ArtNET_ShowAbout;
end;

procedure Tmainform.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Sicherstellen, dass die DLL beim Beenden auch wirklich beendet wurde...
  if btnDeactivate.Enabled then
  begin
    ShowMessage('Bitte deaktivieren Sie zunächst die DLL...');
    CanClose:=false;
  end;
end;

procedure Tmainform.btnSetChannelClick(Sender: TObject);
begin
  ArtNET_SetChannel(0, 0, 1, Random(256));
  ArtNET_SetChannel(0, 0, 2, Random(256));
  ArtNET_SetChannel(0, 0, 3, Random(256));
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  Randomize;
  btnLoadLibraryClick(nil);
  btnActivateClick(nil);
  setlength(TestUniverse, 512);
end;

procedure Tmainform.btnPollingRequestClick(Sender: TObject);
begin
  ArtNET_SendPollingRequest('255.255.255.255');
end;

end.
