unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CHHighResTimer, Mask, JvExMask, JvSpin, Registry,
  dxGDIPlusClasses, jpeg;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tstime = record
    year:Word;
    Month:Word;
    DayOfWeek:Word;
    Date:Word;
    Hour:Word;
    Min:Word;
    Sec:Word;
    Milliseconds:Word;
  end;

  Tinterface = record
    Active:boolean;
    Serial:integer;
    Version:integer;
    Universe1:byte;
    XLR2Setup:byte;
    Universe2:byte;
    ErrorOnDMXOut1:boolean;
    ErrorOnDMXOut2:boolean;
    ErrorOnDMXIn:boolean;
  end;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Label1: TLabel;
    RefreshTimer: TCHHighResTimer;
    ErrorResetTimer: TTimer;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    if1_xlr2use: TComboBox;
    if2_xlr2use: TComboBox;
    if3_xlr2use: TComboBox;
    if4_xlr2use: TComboBox;
    if5_xlr2use: TComboBox;
    if6_xlr2use: TComboBox;
    if7_xlr2use: TComboBox;
    if8_xlr2use: TComboBox;
    if9_xlr2use: TComboBox;
    if10_xlr2use: TComboBox;
    Label22: TLabel;
    if1_uni1: TComboBox;
    Label23: TLabel;
    if1_uni2: TComboBox;
    if2_uni1: TComboBox;
    if2_uni2: TComboBox;
    if3_uni1: TComboBox;
    if3_uni2: TComboBox;
    if4_uni1: TComboBox;
    if5_uni1: TComboBox;
    if6_uni1: TComboBox;
    if4_uni2: TComboBox;
    if5_uni2: TComboBox;
    if6_uni2: TComboBox;
    if7_uni1: TComboBox;
    if8_uni1: TComboBox;
    if9_uni1: TComboBox;
    if7_uni2: TComboBox;
    if8_uni2: TComboBox;
    if9_uni2: TComboBox;
    if10_uni1: TComboBox;
    if10_uni2: TComboBox;
    if1_reinitbtn: TButton;
    if1_stopbtn: TButton;
    if2_reinitbtn: TButton;
    if2_stopbtn: TButton;
    if3_reinitbtn: TButton;
    if3_stopbtn: TButton;
    if4_reinitbtn: TButton;
    if4_stopbtn: TButton;
    if5_reinitbtn: TButton;
    if5_stopbtn: TButton;
    if6_reinitbtn: TButton;
    if6_stopbtn: TButton;
    if7_reinitbtn: TButton;
    if7_stopbtn: TButton;
    if8_reinitbtn: TButton;
    if8_stopbtn: TButton;
    if9_reinitbtn: TButton;
    if9_stopbtn: TButton;
    if10_reinitbtn: TButton;
    if10_stopbtn: TButton;
    Label4: TLabel;
    if1_statuslbl: TLabel;
    if2_statuslbl: TLabel;
    if3_statuslbl: TLabel;
    if4_statuslbl: TLabel;
    if5_statuslbl: TLabel;
    if6_statuslbl: TLabel;
    if7_statuslbl: TLabel;
    if8_statuslbl: TLabel;
    if9_statuslbl: TLabel;
    if10_statuslbl: TLabel;
    Label2: TLabel;
    if1_snlbl: TLabel;
    if2_snlbl: TLabel;
    if3_snlbl: TLabel;
    if4_snlbl: TLabel;
    if5_snlbl: TLabel;
    if6_snlbl: TLabel;
    if7_snlbl: TLabel;
    if8_snlbl: TLabel;
    if9_snlbl: TLabel;
    if10_snlbl: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Image1: TImage;
    Shape3: TShape;
    Label3: TLabel;
    Shape4: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure RefreshTimerTimer(Sender: TObject);
    procedure if1_reinitbtnClick(Sender: TObject);
    procedure if1_stopbtnClick(Sender: TObject);
    procedure if1_uni1Select(Sender: TObject);
    procedure if1_xlr2useSelect(Sender: TObject);
    procedure if1_uni2Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ErrorResetTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;

    interface_return: integer;
    dmxinarray:array[1..10] of array[0..511] of char;
    dmxincomparearray:array[1..10] of array[0..511] of char;
    dmxoutarray:array[1..16] of array[0..511] of char;

    Interfaces:array[1..10] of Tinterface;
    SavedInterfaces:array of Tinterface;

    procedure CloseConnection(InterfaceNummer: Byte);
    procedure Reconnect(InterfaceNummer: Byte);
    procedure SaveProfiles;
    procedure LoadProfiles;
    procedure Startup;
  end;

var
  mainform: Tmainform;

implementation

const
  // Commands
  DHC_OPEN       =  1;
  DHC_CLOSE			 =	2;
  DHC_DMXOUTOFF	 =	3;
  DHC_DMXOUT		 =	4;
  DHC_PORTREAD	 =	5;
  DHC_PORTCONFIG =  6;
  DHC_VERSION		 =  7;
  DHC_DMXIN			 =	8;
  DHC_INIT			 =	9;
  DHC_EXIT			 = 10;
  DHC_DMXSCODE	 = 11;
  DHC_DMX2ENABLE = 12;
  DHC_DMX2OUT		 = 13;
  DHC_SERIAL		 = 14;
  DHC_TRANSPORT  = 15;

  DHC_WRITEMEMORY= 21;
  DHC_READMEMORY = 22;
  DHC_SIZEMEMORY = 23;

  DHC_SIUDI0     = 0;
  DHC_SIUDI1     = 100;
  DHC_SIUDI2     = 200;
  DHC_SIUDI3     = 300;
  DHC_SIUDI4     = 400;
  DHC_SIUDI5     = 500;
  DHC_SIUDI6     = 600;
  DHC_SIUDI7     = 700;
  DHC_SIUDI8     = 800;
  DHC_SIUDI9     = 900;

  // Returns
  DHE_OK         = 1; // No Errors
  DHE_NOTHINGTODO= 2;
  DHE_ERROR_COMMAND= -1;
  DHE_ERROR_NOTOPEN= -2;
  DHE_ERROR_ALREADYOPEN= -3;


function DasUsbCommand(Command, Param: integer; Bloc: PChar): integer; cdecl; external 'DasHard2006.dll';

{$R *.dfm}

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure Tmainform.RefreshTimerTimer(Sender: TObject);
var
  CurIF,i:integer;
begin
  for CurIF:=1 to 10 do
  if Interfaces[CurIF].Active then
  begin
    // DMX512 an XLR1 Senden
    if not Interfaces[CurIF].ErrorOnDMXOut1 then
    begin
      interface_return:=DasUsbCommand(DHC_DMXOUT+(100*(CurIF-1)), 512, dmxoutarray[Interfaces[CurIF].Universe1+1]);
      Interfaces[CurIF].ErrorOnDMXOut1:=interface_return<>DHE_OK;
      if Interfaces[CurIF].ErrorOnDMXOut1 then
      begin
        // Fehler bei Übertragung
        TLabel(FindComponent('if'+inttostr(CurIF)+'_statuslbl')).Caption:='Fehler bei XLR1 DMX-Out';
//        interface_return:=DasUsbCommand(DHC_CLOSE+(100*(CurIF-1)), 0, nil);
      end;
    end;

    // Auf Wunsch auch zweites Universe ausgeben
    if not Interfaces[CurIF].ErrorOnDMXOut2 then
    begin
      if Interfaces[CurIF].XLR2Setup=1 then
      begin
        interface_return:=DasUsbCommand(DHC_DMX2ENABLE+(100*(CurIF-1)), 1, nil); // IN->OUT
        interface_return:=DasUsbCommand(DHC_DMX2OUT+(100*(CurIF-1)), 512, dmxoutarray[Interfaces[CurIF].Universe2+1]); // auf zweitem Output ausgeben
        Interfaces[CurIF].ErrorOnDMXOut2:=interface_return<>DHE_OK;
        if Interfaces[CurIF].ErrorOnDMXOut2 then
        begin
          // Fehler bei Übertragung
          TLabel(FindComponent('if'+inttostr(CurIF)+'_statuslbl')).Caption:='Fehler bei XLR2 DMX-Out';
//          interface_return:=DasUsbCommand(DHC_CLOSE+(100*(CurIF-1)), 0, nil);
        end;
      end;
    end;

    // DMX512 Empfangen
    if not Interfaces[CurIF].ErrorOnDMXIn then
    begin
      if Interfaces[CurIF].XLR2Setup=0 then
      begin
        interface_return:=DasUsbCommand(DHC_DMX2ENABLE+(100*(CurIF-1)), 0, nil); // OUT->IN
        interface_return:=DasUsbCommand(DHC_DMXIN+(100*(CurIF-1)), 512, dmxinarray[CurIF]);
        Interfaces[CurIF].ErrorOnDMXIn:=interface_return<>DHE_OK;
        if Interfaces[CurIF].ErrorOnDMXIn then
        begin
          // Fehler bei Übertragung
//          TLabel(FindComponent('if'+inttostr(CurIF)+'_statuslbl')).Caption:='Fehler bei XLR2 DMX-In';
//          interface_return:=DasUsbCommand(DHC_CLOSE+(100*(CurIF-1)), 0, nil);
        end;
      end;
    end;
    // --------------------------------------------------------------------------

    // Auf veränderte Kanäle prüfen
    for i:=0 to 511 do
    begin
      if dmxinarray[CurIF][i]<>dmxincomparearray[CurIF][i] then
      begin
        dmxincomparearray[CurIF][i]:=dmxinarray[CurIF][i];
        SetDLLValueEvent(i+1+(Interfaces[CurIF].Universe2*512), Integer(dmxinarray[CurIF][i]))
      end;
    end;
  end;
end;

procedure Tmainform.CloseConnection(InterfaceNummer: Byte);
begin
  Interfaces[InterfaceNummer].ErrorOnDMXOut1:=false;
  Interfaces[InterfaceNummer].ErrorOnDMXOut2:=false;
  Interfaces[InterfaceNummer].ErrorOnDMXIn:=false;

  // Interface stoppen
  interface_return:=DasUsbCommand(DHC_CLOSE+(100*(InterfaceNummer-1)), 0, nil);
  interface_return:=DasUsbCommand(DHC_EXIT+(100*(InterfaceNummer-1)), 0, nil);

  Interfaces[InterfaceNummer].Active:=false;
  Interfaces[InterfaceNummer].Serial:=-1;
  Interfaces[InterfaceNummer].Version:=-1;

  TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_statuslbl')).Caption:='...';
  TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_snlbl')).Caption:='...';
end;

procedure Tmainform.Reconnect(InterfaceNummer: Byte);
var
  i:integer;
  done:boolean;
begin
  Interfaces[InterfaceNummer].ErrorOnDMXOut1:=false;
  Interfaces[InterfaceNummer].ErrorOnDMXOut2:=false;
  Interfaces[InterfaceNummer].ErrorOnDMXIn:=false;

  // Interface stoppen
  if Interfaces[InterfaceNummer].Active then
  begin
    interface_return:=DasUsbCommand(DHC_CLOSE+(100*(InterfaceNummer-1)), 0, nil);
    interface_return:=DasUsbCommand(DHC_EXIT+(100*(InterfaceNummer-1)), 0, nil);
    Interfaces[InterfaceNummer].Active:=false;
  end;

  // Interface neu verbinden
  interface_return:=DasUsbCommand(DHC_INIT+(100*(InterfaceNummer-1)), 0, nil);
  if interface_return>=DHE_OK then
  begin
    // Interface korrekt initialisiert
    interface_return:=DasUsbCommand(DHC_OPEN+(100*(InterfaceNummer-1)), 0, nil);

    if interface_return>=DHE_OK then
    begin
      // Interface korrekt geöffnet
      interface_return:=DasUsbCommand(DHC_DMXOUTOFF+(100*(InterfaceNummer-1)), 0, nil);
      Interfaces[InterfaceNummer].Active:=true;

      // Serial und Version auslesen
      interface_return:=DasUsbCommand(DHC_SERIAL+(100*(InterfaceNummer-1)), 0, nil);
      if interface_return>=DHE_OK then
        Interfaces[InterfaceNummer].Serial:=interface_return
      else
        Interfaces[InterfaceNummer].Serial:=-1;

      interface_return:=DasUsbCommand(DHC_VERSION+(100*(InterfaceNummer-1)), 0, nil);
      if interface_return>=DHE_OK then
        Interfaces[InterfaceNummer].Version:=interface_return
      else
        Interfaces[InterfaceNummer].Version:=-1;

      // Gespeicherte Interfacedaten laden
      done:=false;
      for i:=0 to length(SavedInterfaces)-1 do
      begin
        if SavedInterfaces[i].Serial=Interfaces[InterfaceNummer].Serial then
        begin
          // Gespeicherte Daten gefunden
          Interfaces[InterfaceNummer]:=SavedInterfaces[i];
          done:=true;
          break;
        end;
      end;
      if not done then
      begin
        // Neue Daten erstellen
        setlength(SavedInterfaces, length(SavedInterfaces)+1);
        Interfaces[InterfaceNummer].Universe1:=0;
        Interfaces[InterfaceNummer].XLR2Setup:=0;
        Interfaces[InterfaceNummer].Universe2:=0;
        SavedInterfaces[length(SavedInterfaces)-1]:=Interfaces[InterfaceNummer];
      end;
      TComboBox(FindComponent('if'+inttostr(InterfaceNummer)+'_uni1')).ItemIndex:=Interfaces[InterfaceNummer].Universe1;
      TComboBox(FindComponent('if'+inttostr(InterfaceNummer)+'_xlr2use')).ItemIndex:=Interfaces[InterfaceNummer].XLR2Setup;
      TComboBox(FindComponent('if'+inttostr(InterfaceNummer)+'_uni2')).ItemIndex:=Interfaces[InterfaceNummer].Universe2;

      TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_statuslbl')).Caption:='Interface verbunden';
      TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_snlbl')).Caption:=inttostr(Interfaces[InterfaceNummer].Serial);
    end else
    begin
      TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_statuslbl')).Caption:='Kein Interface gefunden!';
      TLabel(FindComponent('if'+inttostr(InterfaceNummer)+'_snlbl')).Caption:='...';
    end;
  end;
end;

procedure Tmainform.if1_reinitbtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 10 do
  begin
    if Sender=TButton(FindComponent('if'+inttostr(i)+'_reinitbtn')) then
    begin
      Reconnect(i);
      break;
    end;
  end;
end;

procedure Tmainform.if1_stopbtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 10 do
  begin
    if Sender=TButton(FindComponent('if'+inttostr(i)+'_stopbtn')) then
    begin
      CloseConnection(i);
      break;
    end;
  end;
end;

procedure Tmainform.if1_uni1Select(Sender: TObject);
var
  i,j:integer;
  done:boolean;
begin
  for i:=1 to 10 do
  begin
    if Sender=TComboBox(FindComponent('if'+inttostr(i)+'_uni1')) then
    begin
      // zunächst aktuelles IF-Array aktualisieren
      Interfaces[i].Universe1:=TComboBox(FindComponent('if'+inttostr(i)+'_uni1')).ItemIndex;

      // nun gespeichertes Profil aktualisieren
      done:=false;
      for j:=0 to length(SavedInterfaces)-1 do
      begin
        if SavedInterfaces[j].Serial=Interfaces[i].Serial then
        begin
          // Gespeicherte Daten gefunden
          SavedInterfaces[j]:=Interfaces[i];
          done:=true;
          break;
        end;
      end;
      if not done then
      begin
        // Neue Daten erstellen
        setlength(SavedInterfaces, length(SavedInterfaces)+1);
        SavedInterfaces[length(SavedInterfaces)-1]:=Interfaces[i];
      end;
      break;
    end;
  end;
end;

procedure Tmainform.if1_xlr2useSelect(Sender: TObject);
var
  i,j:integer;
  done:boolean;
begin
  for i:=1 to 10 do
  begin
    if Sender=TComboBox(FindComponent('if'+inttostr(i)+'_xlr2use')) then
    begin
      // zunächst aktuelles IF-Array aktualisieren
      Interfaces[i].XLR2Setup:=TComboBox(FindComponent('if'+inttostr(i)+'_xlr2use')).ItemIndex;

      // nun gespeichertes Profil aktualisieren
      done:=false;
      for j:=0 to length(SavedInterfaces)-1 do
      begin
        if SavedInterfaces[j].Serial=Interfaces[i].Serial then
        begin
          // Gespeicherte Daten gefunden
          SavedInterfaces[j]:=Interfaces[i];
          done:=true;
          break;
        end;
      end;
      if not done then
      begin
        // Neue Daten erstellen
        setlength(SavedInterfaces, length(SavedInterfaces)+1);
        SavedInterfaces[length(SavedInterfaces)-1]:=Interfaces[i];
      end;
      break;
    end;
  end;
end;

procedure Tmainform.if1_uni2Select(Sender: TObject);
var
  i,j:integer;
  done:boolean;
begin
  for i:=1 to 10 do
  begin
    if Sender=TComboBox(FindComponent('if'+inttostr(i)+'_uni2')) then
    begin
      // zunächst aktuelles IF-Array aktualisieren
      Interfaces[i].Universe2:=TComboBox(FindComponent('if'+inttostr(i)+'_uni2')).ItemIndex;

      // nun gespeichertes Profil aktualisieren
      done:=false;
      for j:=0 to length(SavedInterfaces)-1 do
      begin
        if SavedInterfaces[j].Serial=Interfaces[i].Serial then
        begin
          // Gespeicherte Daten gefunden
          SavedInterfaces[j]:=Interfaces[i];
          done:=true;
          break;
        end;
      end;
      if not done then
      begin
        // Neue Daten erstellen
        setlength(SavedInterfaces, length(SavedInterfaces)+1);
        SavedInterfaces[length(SavedInterfaces)-1]:=Interfaces[i];
      end;
      break;
    end;
  end;
end;

procedure Tmainform.SaveProfiles;
var
  LReg:TRegistry;
  i:integer;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          LReg.WriteBool('AutoSearch', Checkbox1.Checked);
          LReg.WriteBool('AutoReset', Checkbox2.Checked);

          LReg.WriteInteger('Interfacedatalength', length(SavedInterfaces));
          for i:=0 to length(SavedInterfaces)-1 do
            LReg.WriteBinaryData('Interface '+inttostr(i), SavedInterfaces[i], sizeof(SavedInterfaces[i]));
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.LoadProfiles;
var
  LReg:TRegistry;
  count,i:integer;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          if LReg.ValueExists('AutoSearch') then
            Checkbox1.Checked:=LReg.ReadBool('AutoSearch');

          if LReg.ValueExists('AutoReset') then
            Checkbox2.Checked:=LReg.ReadBool('AutoReset');

          if LReg.ValueExists('Interfacedatalength') then
          begin
            count:=LReg.ReadInteger('Interfacedatalength');
            setlength(SavedInterfaces, count);
            for i:=0 to length(SavedInterfaces)-1 do
              LReg.ReadBinaryData('Interface '+inttostr(i), SavedInterfaces[i], sizeof(SavedInterfaces[i]));
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveProfiles;
end;

procedure Tmainform.ErrorResetTimerTimer(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 10 do
  begin
    // Neue Interfaces suchen
    if Checkbox1.Checked and (not Interfaces[i].Active) then
    begin
      // Interface ist noch nicht verbunden -> vielleicht jetzt?
      Reconnect(i);
    end;

    // Fehlerhafte Interfaces (z.B. nach Entfernen) neu suchen
    if Checkbox2.Checked and (Interfaces[i].ErrorOnDMXOut1 or Interfaces[i].ErrorOnDMXOut1) then
    begin
      Reconnect(i);
    end;

    // Bisherige Fehler resetten
    Interfaces[i].ErrorOnDMXOut1:=false;
    Interfaces[i].ErrorOnDMXOut2:=false;
    Interfaces[i].ErrorOnDMXIn:=false;
  end;
end;


procedure Tmainform.Startup;
var
  i:integer;
begin
  // Activate Outputplugin
  issending:=false;

  LoadProfiles;

  for i:=1 to 10 do
    Reconnect(i);
end;

end.
