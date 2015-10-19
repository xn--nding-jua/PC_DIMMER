unit InternetUpdate;

{ v.1.9 }

{ (c) 2004, 2005 by tp-soft.de }
{ Autor ist Tom Peiffer }
{           webmaster@tp-soft.de }



{ Lizenz: }
{ frei für nicht kommerzielle Zwecke. Bei Erwerb des Produktes Rema darf die Komponente auch }
{ kommerziell eingesetzt werden. }
{ Die Komponente allein (ohne Rema) kann unter http://www.tp-soft.de erworben werden }
{ Nähere Details bitte auf der Webseite entnehmen }



{ Komponente zur einfachen Online Überprüfung, ob eine neue Version des Programms verfügbar ist }
{ Nach Prüfung und eventueller Abfrage kann der Download automatisch gestartet werden, in einem }
{ eigenen Thread wodurch die eigene Anwendung nicht eingefroren wird. }
{ Die ganze Komponente ist Eventgesteuert. Es können Standardevents genutzt werden (OnText) oder }
{ für jedes Ereignis eine eigene Routine geschrieben werden (alle anderen Ereignisse) }

{ Die Komponente arbeitet ideal zusammen mit dem Softwarepaket REMA. Mehr hierzu unter http://www.tp-net.lu }
{ wodurch die Komponente noch viel einfacher zu handhaben ist, da die nötigen Informationen zur neuen }
{ Version automatisch über Rema aktualisiert werden }

{ v.1.9 Release 0 Build 0 (19.12.2006)                                         }
{ ------------------------------------                                         }
{  - Fixed own-functions by Christian Nöding                                   }
{    (19.12.2006)                                                              }
{                                                                              }
{ v.1.8 Release 0 Build 0 (20.11.2005)                                         }
{ ------------------------------------                                         }
{  - Download funktioniert nun auch über einen anderen Port als 80             }
{    (17.11.2005)                                                              }
{                                                                              }
{ v.1.7 Release 0 Build 0 (16.11.2005)                                         }
{ ------------------------------------                                         }
{  - Bugfix: Username und Passwortübermittelung war fehlerhaft in Verbindung   }
{    mit Rema bzw. versionmore.php (16.11.2005)                                }
{                                                                              }
{ v.1.6 Release 0 Build 0 (16.11.2005)                                         }
{ ------------------------------------                                         }
{  - Kompatibilität zu älteren Delphi Version ab 4 eingeführt (16.11.2005)     }
{                                                                              }
{ v.1.5 Release 0 Build 0 (03.08.2005)                                         }
{ ------------------------------------                                         }
{  - UpdateForm binär gespeichert, um Kompaitibilität zu Delphi 4 zu gewähren  }
{    (03.08.2005)                                                              }
{                                                                              }
{ v.1.4 Release 0 Build 0 (02.06.2005)                                         }
{ ------------------------------------                                         }
{  - Demo Programm (02.06.2005)                                                }
{                                                                              }
{ v.1.3 Release 0 Build 0 (30.05.2005)                                         }
{ ------------------------------------                                         }
{  - Hilfedatei (30.05.2005)                                                   }
{                                                                              }
{ v.1.2 Release 0 Build 0 (08.05.2005)                                         }
{ ------------------------------------                                         }
{  - Einbinden eines übersichtlichen Formulars mit sämtlichen Neuerungen       }
{    (08.05.2005)                                                              }
{                                                                              }
{ v.1.1 Release 0 Build 0 (27.10.2004)                                         }
{ ------------------------------------                                         }
{  - URLEncode bei ProjectCode mit Sonderzeichen (in Verbindung mit Rema)      }
{    (27.10.2004)                                                              }
{  - Ping klappt jetzt auch als Nicht-Administrator (27.10.2004)               }
{  - Beschreibung zu jedem Whatsnew Eintrag (27.10.2004)                       }
{  - Aktuelle Version über PHP Skript mit übermittelbar (in Verbindung mit     }
{    Rema) (27.10.2004)                                                        }
{                                                                              }
{ v.1.0 Release 0 Build 0 (04.10.2004)                                         }
{ ------------------------------------                                         }
{  - Erste Veröffentlichung                                                    }


interface

{$IFDEF VER170}
      {$DEFINE COMPILER9}
      {$DEFINE DELPHI9}
      {$DEFINE DELPHICOMPILER9}
      {$DEFINE RTL170_UP}
    {$ENDIF}

    {$IFDEF VER160}
      {$DEFINE COMPILER8}
      {$DEFINE DELPHI8}
      {$DEFINE DELPHICOMPILER8} 
      {$DEFINE RTL160_UP}
    {$ENDIF} 

    {$IFDEF VER150} 
      {$DEFINE COMPILER7}
      {$IFDEF BCB}
        {$DEFINE BCB7}
      {$ELSE} 
        {$DEFINE DELPHI7}
        {$DEFINE DELPHICOMPILER7}
      {$ENDIF}
      {$DEFINE RTL150_UP}
    {$ENDIF} 

    {$IFDEF VER140} 
      {$DEFINE COMPILER6}
      {$IFDEF BCB} 
        {$DEFINE BCB6} 
      {$ELSE} 
        {$DEFINE DELPHI6} 
        {$DEFINE DELPHICOMPILER6} 
      {$ENDIF} 
      {$DEFINE RTL140_UP} 
    {$ENDIF}

    {$IFDEF VER130} 
      {$DEFINE COMPILER5} 
      {$IFDEF BCB} 
        {$DEFINE BCB5} 
      {$ELSE} 
        {$DEFINE DELPHI5} 
        {$DEFINE DELPHICOMPILER5}
      {$ENDIF} 
      {$DEFINE RTL130_UP}
    {$ENDIF}

    {$IFDEF VER125} 
      {$DEFINE COMPILER4} 
      {$DEFINE BCB4} 
      {$DEFINE BCB} 
      {$DEFINE RTL125_UP}
    {$ENDIF} 

    {$IFDEF VER120} 
      {$DEFINE COMPILER4} 
      {$DEFINE DELPHI4} 
      {$DEFINE DELPHICOMPILER4} 
      {$DEFINE RTL120_UP} 
    {$ENDIF} 

    {$IFDEF VER110} 
      {$DEFINE COMPILER35} 
      {$DEFINE BCB3} 
      {$DEFINE RTL110_UP} 
    {$ENDIF} 

    {$IFDEF VER100} 
      {$DEFINE COMPILER3} 
      {$DEFINE DELPHI3} 
      {$DEFINE DELPHICOMPILER3}
      {$DEFINE RTL100_UP} 
    {$ENDIF} 

    {$IFDEF VER93} 
      {$DEFINE COMPILER2} 
      {$DEFINE BCB1} 
      {$DEFINE BCB} 
      {$DEFINE RTL93_UP}
    {$ENDIF} 

    {$IFDEF VER90} 
      {$DEFINE COMPILER2}
      {$DEFINE DELPHI2}
      {$DEFINE DELPHICOMPILER2} 
      {$DEFINE RTL90_UP} 
    {$ENDIF} 

    {$IFDEF VER80} 
      {$DEFINE COMPILER1} 
      {$DEFINE DELPHI1}
      {$DEFINE DELPHICOMPILER1} 
      {$DEFINE RTL80_UP} 
    {$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileInfo, ExtCtrls, Wininet;

type
  TSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TSunW = packed record
    s_w1, s_w2: word;
  end;

  PIPAddr = ^TIPAddr;
  TIPAddr = record
    case integer of
      0: (S_un_b: TSunB);
      1: (S_un_w: TSunW);
      2: (S_addr: longword);
  end;

 IPAddr = TIPAddr;

 function IcmpCreateFile : THandle; stdcall; external 'icmp.dll';
 function IcmpCloseHandle (icmpHandle : THandle) : boolean;
            stdcall; external 'icmp.dll'
 function IcmpSendEcho
   (IcmpHandle : THandle; DestinationAddress : IPAddr;
    RequestData : Pointer; RequestSize : Smallint;
    RequestOptions : pointer;
    ReplyBuffer : Pointer;
    ReplySize : DWORD;
    Timeout : DWORD) : DWORD; stdcall; external 'icmp.dll';

 type
  TInternetUpdate = class ;

  TIUVersionInfo = class (TPersistent)
  private
     FMajor : word ;
     FMinor : word ;
     FRelease : word ;
     FBuild : word ;
    FText: string;
    procedure SetText(const Value: string);
  public
     property Text : string  read FText write SetText;
  published
     property Major : word read FMajor write FMajor ;
     property Minor : word read FMinor write FMinor ;
     property Release : word read FRelease write FRelease ;
     property Build : word read FBuild write FBuild ;
  end ;

  TDownloadInfo = class
  private
    FUsername: string;
    FURL: string;
    FPassword: string;
    FWhatsNew: TStringList;
    FDescription: TStringList;

    procedure SetPassword(const Value: string);
    procedure SetURL(const Value: string);
    procedure SetUsername(const Value: string);
    procedure SetWhatsNew(const Value: TStringList);
    procedure SetDescription(const Value: TStringList);
    property Password : string  read FPassword write SetPassword;
    property URL : string  read FURL write SetURL;
     property Username : string  read FUsername write SetUsername;
  public
     property FileURL: string read FURL write FURL;
     property WhatsNew : TStringList  read FWhatsNew write SetWhatsNew;
     property Description : TStringList  read FDescription write SetDescription;
     constructor Create ;
  end ;

   TOnUpdateFound = procedure (Sender : TObject ;
                         LocalVersion : TIUVersionInfo ;
                         RemoteVersion : TIUVersionInfo ;
                         Info : TDownloadInfo ;
                         var DownloadNow : boolean ;
                         var DestinationFilename : string)
              of object ;
  TOnDownloadProgress = procedure (Sender: TObject;
                                   TotalSize,
                                   Readed: Integer)
                        of object ;
  TOnDownloadComplete = procedure (Sender: TObject;
                                   SetupEXE : string)
                        of object ;
  TOnText = procedure (Sender : TObject ;
                       MessageText : string ;
                       ProcessID : integer )
            of object;



  TPingThread = class(TThread)
  private
    FHost: string;
    FEventNr : integer ;
    FAOwner: TInternetUpdate;
    AlreadyReached : boolean ;
    LV, RV : string ;
    FTotalSize, FReaded : integer ;
//    FSender : TObject ;
    FDoDownload : boolean ;
    FDestination : string ;
    FFileName : string ;

    FResult: Boolean;
    FFileSize: Integer;
    FToFile: Boolean;

    BytesToRead, BytesReaded: DWord;

    FUseCache: Boolean;
    FBinaryData: Boolean;
    FURL: String;
    FReferer: String;
    FPostQuery: String;
    FUserName: String;
    FAcceptTypes: String;
    FAgent: String;
    FPassword: String;

    procedure PingReply ;
    procedure SetHost(const Value: string);
    procedure SetAOwner(const Value: TInternetUpdate);
    function ZF(n: integer): string;
    function TempDir: string;
    function URLToFilename(URL: string): string;
    procedure DownloadFileFromURL (SourceURL : string ;
                                   Destination : string ;
                                   Username : string ;
                                   Password : string;
                                   ProgressID : integer ) ;
    procedure EventSynch;
    procedure SetEventNr(const Value: integer);
    procedure TranslateStringToTInAddr(AIP: string; var AInAddr);
{
    function Fetch(var AInput: string;
                      const ADelim: string = ' ';
                      const ADelete: Boolean = true) : string;
}
    function Ping(InetAddress: string): boolean;
    function EncodeUrl(url: string): string;


  protected
    procedure Execute; override;
  public
    constructor Create ;
    property EventNr : integer  read FEventNr write SetEventNr;
    property Host : string  read FHost write SetHost;
    property AOwner : TInternetUpdate  read FAOwner write SetAOwner;
    function UpdateAvailable : boolean ;
  end;




  TInternetUpdate = class(TComponent)
  private
    StopSearch : boolean ;
    Downloaded : boolean ;
    NewProzent, OldProzent : integer ;
    FMessageText: string;
    FURL: string;
    FileInfo : TFileInfo ;
    PingThread : TPingThread ;
    FTimeOut: integer;
    FOnDone: TNotiFyEvent;
    FOnContactingHost: TNotifyEvent;
    FOnNoUpdate: TNotifyEvent;
    FOnHostNotFound: TNotifyEvent;
    FOnStart: TNotifyEvent;
    FOnHostContacted: TNotifyEvent;
    FLocalVersion: TIUVersionInfo;
    FAutoLocalVersion: boolean;
    FOnUpdateFound : TOnUpdateFound;
    FRemoteVersion: TIUVersionInfo;
    FUsername: string;
    FPassword: string;
    FRemoteFilename: string;
    FDownload: TDownloadInfo;
    FOnDownloadComplete: TOnDownLoadComplete;
    FOnDownloadProgress: TOnDownloadProgress;
    FOnDownloadStart: TNotifyEvent;
    FOnDownloadError: TNotifyEvent;
    FRunning: boolean;
    FSleep: integer;
    FDefaultEvents : boolean ;
    FProjectCode: string;
    FOnText: TOnText;
    UpdateTimer : TTimer ;
    IdleTimer : TTimer ;
    FEventNr: integer;
    FcsDownloadComplete: integer;
    FcsDownloadStart: integer;
    FcsHostContacted: integer;
    FcsStart: integer;
    FcsDownloadProgress: integer;
    FcsHostNotFound: integer;
    FcsText: integer;
    FcsUpdateFound: integer;
    FcsDownloadError: integer;
    FcsContactingHost: integer;
    FcsDone: integer;
    FcsNoUpdate: integer;
    FCloseBeforeRun: boolean;
    TempDir : string ;
    FPingHost: string;
    procedure OnUpdateTimer (Sender : TObject) ;
    procedure OnIdleTimer (Sender : TObject) ;


    procedure SetURL(const Value: string);
    procedure ThreadDone(Sender: TObject);
    procedure SetTimeOut(const Value: integer);
    procedure SetOnContactingHost(const Value: TNotifyEvent);
    procedure SetOnDone(const Value: TNotiFyEvent);
    procedure SetOnHostContacted(const Value: TNotifyEvent);
    procedure SetOnHostNotFound(const Value: TNotifyEvent);
    procedure SetOnNoUpdate(const Value: TNotifyEvent);
    procedure SetOnStart(const Value: TNotifyEvent);
    procedure SeTIUVersionInfo(const Value: TIUVersionInfo);
    procedure SetAutoLocalVersion(const Value: boolean);
    procedure SetOnUpdateFound(const Value: TOnUpdateFound);
    procedure SetRemoteVersion(const Value: TIUVersionInfo);
    procedure SetPassword(const Value: string);
    procedure SetUsername(const Value: string);
    procedure SetDownload(const Value: TDownloadInfo);
    procedure SetRemoteFilename(const Value: string);
    procedure SetOnDownloadComplete(const Value: TOnDownLoadComplete);
    procedure SetOnDownloadProgress(const Value: TOnDownloadProgress);
    procedure SetOnDownloadStart(const Value: TNotifyEvent);
    procedure SetOnDownloadError(const Value: TNotifyEvent);
    procedure SetRunning(const Value: boolean);
    procedure SetSleep(const Value: integer);
    procedure SetProjectCode(const Value: string);
    function GetURL: string;
    procedure SetOnText(const Value: TOnText);

    procedure Default_OnDone (Sender: TObject) ;
    procedure Default_OnStart (Sender : TObject) ;
    procedure Default_ContactingHost (Sender : TObject) ;
    procedure Default_HostContacted (Sender : TObject) ;
    procedure Default_HostNotFound (Sender : TObject) ;
    procedure Default_UpdateFound (Sender : TObject ;
                         LocalVersion : TIUVersionInfo ;
                         RemoteVersion : TIUVersionInfo ;
                         Info : TDownloadInfo ;
                         var DownloadNow : boolean ;
                         var DestinationFilename : string)  ;
    procedure Default_NoUpdate (Sender : TObject) ;
    procedure Default_DownloadStart (Sender : TObject) ;
    procedure Default_DownloadProgress (Sender: TObject;
                                   TotalSize,
                                   Readed: Integer) ;
    procedure Default_DownloadComplete (Sender: TObject;
                                   SetupEXE : string) ;
    procedure Default_DownloadError (Sender : TObject) ;
    procedure SetMessageText(const Value: string);
    procedure SetcsContactingHost(const Value: integer);
    procedure SetcsDone(const Value: integer);
    procedure SetcsDownloadComplete(const Value: integer);
    procedure SetcsDownloadError(const Value: integer);
    procedure SetcsDownloadProgress(const Value: integer);
    procedure SetcsDownloadStart(const Value: integer);
    procedure SetcsHostContacted(const Value: integer);
    procedure SetcsHostNotFound(const Value: integer);
    procedure SetcsNoUpdate(const Value: integer);
    procedure SetcsStart(const Value: integer);
    procedure SetcsText(const Value: integer);
    procedure SetcsUpdateFound(const Value: integer);
    procedure SetCloseBeforeRun(const Value: boolean);
    procedure SetPingHost(const Value: string);
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    property MessageText : string read FMessageText write SetMessageText ;
    constructor Create (AOwner : TComponent) ; override ;
    property RemoteVersion : TIUVersionInfo   read FRemoteVersion write SetRemoteVersion;
    property Download : TDownloadInfo  read FDownload write SetDownload;
    property RemoteFilename : string  read FRemoteFilename write SetRemoteFilename;
    property Running : boolean  read FRunning write SetRunning;
    property Sleep : integer  read FSleep write SetSleep;
    property EventNr : integer read FEventNr ;
    property csContactingHost : integer  read FcsContactingHost write SetcsContactingHost;
    property csDone : integer  read FcsDone write SetcsDone;
    property csDownloadComplete : integer  read FcsDownloadComplete write SetcsDownloadComplete;
    property csDownloadError : integer  read FcsDownloadError write SetcsDownloadError;
    property csDownloadProgress : integer  read FcsDownloadProgress write SetcsDownloadProgress;
    property csDownloadStart : integer  read FcsDownloadStart write SetcsDownloadStart;
    property csHostContacted : integer  read FcsHostContacted write SetcsHostContacted;
    property csHostNotFound : integer  read FcsHostNotFound write SetcsHostNotFound;
    property csNoUpdate : integer  read FcsNoUpdate write SetcsNoUpdate;
    property csStart : integer  read FcsStart write SetcsStart;
    property csUpdateFound : integer  read FcsUpdateFound write SetcsUpdateFound;
    property csText : integer  read FcsText write SetcsText;
    procedure Execute ;
    function SLtoStr(SL: TStringList; Prefix, Suffix : string): string;
    function ShowWhatsNew (Sender : TInternetUpdate): boolean;
  published
    { Published-Deklarationen }
    property URL : string  read GetURL write SetURL;
    property PingHost : string  read FPingHost write SetPingHost;
    property TimeOut : integer  read FTimeOut write SetTimeOut;
    property LocalVersion : TIUVersionInfo  read FLocalVersion write SeTIUVersionInfo;
    property AutoLocalVersion : boolean  read FAutoLocalVersion write SetAutoLocalVersion;
    property Username : string  read FUsername write SetUsername;
    property Password : string  read FPassword write SetPassword;
    property DefaultEvents : boolean read FDefaultEvents write FDefaultEvents ;
    property ProjectCode : string  read FProjectCode write SetProjectCode;
    property CloseBeforeRun : boolean  read FCloseBeforeRun write SetCloseBeforeRun;

    property OnContactingHost : TNotifyEvent read FOnContactingHost write SetOnContactingHost;
    property OnHostContacted : TNotifyEvent read FOnHostContacted write SetOnHostContacted;
    property OnHostNotFound: TNotifyEvent   read FOnHostNotFound write SetOnHostNotFound;
    property OnUpdateFound : TOnUpdateFound read FOnUpdateFound write SetOnUpdateFound ;
    property OnNoUpdate : TNotifyEvent   read FOnNoUpdate write SetOnNoUpdate;
    property OnDone : TNotiFyEvent  read FOnDone write SetOnDone;
    property OnStart : TNotifyEvent  read FOnStart write SetOnStart;
    property OnDownloadStart : TNotifyEvent  read FOnDownloadStart write SetOnDownloadStart;
    property OnDownloadProgress : TOnDownloadProgress  read FOnDownloadProgress write SetOnDownloadProgress;
    property OnDownloadComplete : TOnDownLoadComplete  read FOnDownloadComplete write SetOnDownloadComplete;
    property OnDownloadError : TNotifyEvent  read FOnDownloadError write SetOnDownloadError;
    property OnText : TOnText read FOnText write SetOnText ;
  end;

procedure Register;

implementation
{$WARNINGS OFF}
uses urlmon, inifiles, shellapi, filectrl, WinSock
{$WARNINGS ON}
     {$IFDEF DELPHI3} ,UpdateFoundFormD4 {$ENDIF}
     {$IFDEF DELPHI4} ,UpdateFoundFormD4 {$ENDIF}
     {$IFDEF DELPHI5} ,UpdateFoundFormD4 {$ENDIF}
     {$IFDEF DELPHI6} ,UpdateFoundForm {$ENDIF}
     {$IFDEF DELPHI7} ,UpdateFoundForm {$ENDIF}
     {$IFDEF DELPHI8} ,UpdateFoundForm {$ENDIF}
     {$IFDEF DELPHI9} ,UpdateFoundForm {$ENDIF}
     ;

procedure Register;
begin
  RegisterComponents('Internet', [TInternetUpdate]);
end;

{ TInternetUpdate }

constructor TInternetUpdate.Create(AOwner: TComponent);
begin
      inherited Create (AOwner) ;
      FTimeOut := 5000 ;
      FileInfo := TFileInfo.create (Self) ;
      FLocalVersion := TIUVersionInfo.Create ;
      FRemoteVersion := TIUVersionInfo.Create ;
      FAutoLocalVersion := true ;
      FUsername := '' ;
      FPassword := '' ;
      FDownload := TDownLoadInfo.create ;
      FRunning := false ;
      FSleep := 200 ;
      FDefaultEvents := true ;
      FCloseBeforeRun := true ;
      FPingHost := 'www.google.de' ;
      UpdateTimer := TTimer.create (Self) ;
      UpdateTimer.enabled := false ;
      UpdateTimer.Interval := 1000 ;
      UpdateTimer.OnTimer := OnUpdateTimer ;
      IdleTimer := TTimer.create (Self) ;
      IdleTimer.enabled := false ;
      IdleTimer.OnTimer := OnIdleTimer ;
      IdleTimer.Interval := 2000 ;
      csContactingHost := 1 ;
      csDone := 2 ;
      csDownloadComplete := 3 ;
      csDownloadError := 4 ;
      csDownloadProgress := 5 ;
      csDownloadStart := 6 ;
      csHostContacted := 7 ;
      csHostNotFound := 8 ;
      csNoUpdate := 9 ;
      csStart := 10 ;
      csUpdateFound := 11 ;
      csText := 12 ;
end;

procedure TInternetUpdate.Execute;
begin
     if FAutoLocalVersion then begin
        FileInfo.Filename := application.exename ;
        LocalVersion.Major := FileInfo.Version.Major ;
        LocalVersion.Minor := FileInfo.Version.Minor ;
        LocalVersion.Release := FileInfo.Version.Release ;
        LocalVersion.Build := FileInfo.Version.Build ;
     end ;

     FRunning := true ;
     with TPingThread.Create  do begin
          AOwner :=  Self as TInternetUpdate ;
          if not DirectoryExists(ExtractFilePath(paramstr(0))+'Downloads') then
            CreateDir(ExtractFilePath(paramstr(0))+'Downloads');
          (AOwner as TInternetUpdate).TempDir := ExtractFilePath(paramstr(0))+'Downloads\';//TempDir ;
          //PingThread := TPingThread.Create ;
          Priority := tpLowest ;
          EventNr := csStart ;
          Host := Self.PingHost ;
          OnTerminate := ThreadDone ;
     end ;
end;

procedure TInternetUpdate.SetAutoLocalVersion(const Value: boolean);
begin
  FAutoLocalVersion := Value;
end;



procedure TInternetUpdate.SeTIUVersionInfo(const Value: TIUVersionInfo);
begin
  FLocalVersion := Value;
end;

procedure TInternetUpdate.SetOnContactingHost(const Value: TNotifyEvent);
begin
  FOnContactingHost := Value;
end;

procedure TInternetUpdate.SetOnDone(const Value: TNotiFyEvent);
begin
  FOnDone := Value;
end;

procedure TInternetUpdate.SetOnHostContacted(const Value: TNotifyEvent);
begin
  FOnHostContacted := Value;
end;

procedure TInternetUpdate.SetOnHostNotFound(const Value: TNotifyEvent);
begin
  FOnHostNotFound := Value;
end;

procedure TInternetUpdate.SetOnNoUpdate(const Value: TNotifyEvent);
begin
  FOnNoUpdate := Value;
end;

procedure TInternetUpdate.SetOnStart(const Value: TNotifyEvent);
begin
  FOnStart := Value;
end;

procedure TInternetUpdate.SetTimeOut(const Value: integer);
begin
  FTimeOut := Value;
end;

procedure TInternetUpdate.SetURL(const Value: string);
var
 Dummy : string ;
begin
  FURL := Value;
  Dummy := uppercase (FURL) ;
  if copy (Dummy,1,7) <> 'HTTP://'
  then FURL := 'http://' + FURL ;
  FURL := trim (FURL) ;
end;


procedure TInternetUpdate.ThreadDone(Sender: TObject);
begin
     PingThread.free ;
     FRunning := false ;
     if DefaultEvents
     then Default_OnDone (Self)
     else if assigned (OnDone) then OnDone (Self) ;
end;

procedure TInternetUpdate.SetOnUpdateFound(const Value: TOnUpdateFound);
begin
  FOnUpdateFound := Value;
end;

procedure TInternetUpdate.SetRemoteVersion(const Value: TIUVersionInfo);
begin
  FRemoteVersion := Value;
end;

procedure TInternetUpdate.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TInternetUpdate.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

procedure TInternetUpdate.SetRemoteFilename(const Value: string);
begin
  FRemoteFilename := Value;
end;

procedure TInternetUpdate.SetDownload(const Value: TDownloadInfo);
begin
  FDownload := Value;
end;

procedure TInternetUpdate.SetOnDownloadComplete(
  const Value: TOnDownLoadComplete);
begin
  FOnDownloadComplete := Value;
end;

procedure TInternetUpdate.SetOnDownloadProgress(
  const Value: TOnDownloadProgress);
begin
  FOnDownloadProgress := Value;
end;

procedure TInternetUpdate.SetOnDownloadStart(const Value: TNotifyEvent);
begin
  FOnDownloadStart := Value;
end;

procedure TInternetUpdate.SetOnDownloadError(const Value: TNotifyEvent);
begin
  FOnDownloadError := Value;
end;

procedure TInternetUpdate.SetRunning(const Value: boolean);
begin
  FRunning := Value;
end;


procedure TInternetUpdate.SetSleep(const Value: integer);
begin
  FSleep := Value;
end;

function TInternetUpdate.SLtoStr(SL: TStringList; Prefix, Suffix : string): string;
var
 i : integer ;
begin
     Result := '' ;
     for i := 0 to SL.count-1 do begin
        Result := Result + Prefix + SL[i] + Suffix ;
        if i < SL.count-1
        then Result := Result + #10#13 ;
     end ;
end;

procedure TInternetUpdate.SetProjectCode(const Value: string);
begin
  FProjectCode := uppercase (Value) ;
end;

function TInternetUpdate.GetURL: string;
begin
     Result := FURL ;
end;

procedure TInternetUpdate.SetOnText(const Value: TOnText);
begin
  FOnText := Value;
end;



procedure TInternetUpdate.Default_OnDone(Sender: TObject);
begin
     IdleTimer.enabled := true ;
end;

procedure TInternetUpdate.Default_OnStart(Sender: TObject);
begin
     MessageText := _('Es wird nach einem Programmupdate gesucht...');
end;

procedure TInternetUpdate.Default_ContactingHost(Sender: TObject);
begin
     MessageText := _('Internetanbindung wird geprüft...');
end;

procedure TInternetUpdate.Default_DownloadComplete(Sender: TObject;
  SetupEXE: string);
//var
// Msg : string ;
begin
     MessageText := _('Download abgeschlossen...');

{
     if CloseBeforeRun
     then Msg := 'Der Download ist beendet. Soll die laufende Anwendung jetzt beendet werden und die Updateroutine jetzt starten?'
     else Msg := 'Der Download ist beendet. Soll das Update jetzt gestartet werden?' ;

     if MessageDlg(msg, mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
        shellexecute (application.handle,'open',PChar(SetupEXE),'',PChar(ExtractFilePath(SetupEXE)),SW_SHOWNORMAL) ;
        if CloseBeforeRun
        then application.MainForm.Close ;
     end ;
}
end;

procedure TInternetUpdate.Default_DownloadError(Sender: TObject);
begin
     MessageText := _('Ein Fehler ist aufgetreten...');
end;

procedure TInternetUpdate.Default_DownloadProgress(Sender: TObject;
  TotalSize, Readed: Integer);
begin
     NewProzent := round (Readed/TotalSize*100) ;
     if NewProzent <> OldProzent
     then MessageText := format(_('Updatedownload zu %d%% abgeschlossen...'),[NewProzent]) ;
     OldProzent := NewProzent ;
end;

procedure TInternetUpdate.Default_DownloadStart(Sender: TObject);
begin
     Downloaded := false ;
     StopSearch := false ;
     OldProzent := -1 ;
     MessageText := _('Download wird gestartet...');
end;

procedure TInternetUpdate.Default_HostContacted(Sender: TObject);
begin
     MessageText := _('Mit Updateserver verbunden...');
end;

procedure TInternetUpdate.Default_HostNotFound(Sender: TObject);
begin
     MessageText := _('Updateserver nicht gefunden...');
end;

procedure TInternetUpdate.Default_NoUpdate(Sender: TObject);
begin
     MessageText := _('Keine neue Version verfügbar...');
end;

procedure TInternetUpdate.Default_UpdateFound(Sender: TObject;
  LocalVersion, RemoteVersion: TIUVersionInfo;
  Info : TDownloadInfo ;
  var DownloadNow: boolean; var DestinationFilename: string);
var
 DownloadConfirmed : boolean ;
begin
     Messagetext := _('Update gefunden...');

     DownloadConfirmed := ShowWhatsNew (Self) ;

     if DownloadConfirmed then begin
          if not (DirectoryExists (TempDir))
          then MkDir (TempDir) ;
          DestinationFileName := TempDir + ExtractFilename (DestinationFilename) ;
          DownloadNow := true ;
     end else begin
          MessageText := _('Update abgebrochen...');
          DownloadNow := false ;
     end ;
end;

procedure TInternetUpdate.SetMessageText(const Value: string);
begin
  FMessageText := Value;
  if assigned (OnText) then OnText (Self,FMessageText,EventNr) ;
end;

procedure TInternetUpdate.OnIdleTimer(Sender: TObject);
begin
      MessageText := '' ;
      IdleTimer.enabled := false ;
      UpdateTimer.Interval := 1800000 ;  { = 30 Minuten }
      {if US.CheckForUpdates and  not (StopSearch) and not (Downloaded)
      then UpdateTimer.enabled := true ;}
end;

procedure TInternetUpdate.OnUpdateTimer(Sender: TObject);
begin
     //
end;

procedure TInternetUpdate.SetcsContactingHost(const Value: integer);
begin
  FcsContactingHost := Value;
end;

procedure TInternetUpdate.SetcsDone(const Value: integer);
begin
  FcsDone := Value;
end;

procedure TInternetUpdate.SetcsDownloadComplete(const Value: integer);
begin
  FcsDownloadComplete := Value;
end;

procedure TInternetUpdate.SetcsDownloadError(const Value: integer);
begin
  FcsDownloadError := Value;
end;

procedure TInternetUpdate.SetcsDownloadProgress(const Value: integer);
begin
  FcsDownloadProgress := Value;
end;

procedure TInternetUpdate.SetcsDownloadStart(const Value: integer);
begin
  FcsDownloadStart := Value;
end;

procedure TInternetUpdate.SetcsHostContacted(const Value: integer);
begin
  FcsHostContacted := Value;
end;

procedure TInternetUpdate.SetcsHostNotFound(const Value: integer);
begin
  FcsHostNotFound := Value;
end;

procedure TInternetUpdate.SetcsNoUpdate(const Value: integer);
begin
  FcsNoUpdate := Value;
end;

procedure TInternetUpdate.SetcsStart(const Value: integer);
begin
  FcsStart := Value;
end;

procedure TInternetUpdate.SetcsText(const Value: integer);
begin
  FcsText := Value;
end;

procedure TInternetUpdate.SetcsUpdateFound(const Value: integer);
begin
  FcsUpdateFound := Value;
end;

procedure TInternetUpdate.SetCloseBeforeRun(const Value: boolean);
begin
  FCloseBeforeRun := Value;
end;

procedure TInternetUpdate.SetPingHost(const Value: string);
begin
  FPingHost := Value;
end;

function TInternetUpdate.ShowWhatsNew (Sender : TInternetUpdate): boolean;
begin
     with TfrmInternetUpdateFound.Create(nil) do begin
        Result := Execute (Self) ;
        free ;
     end ;
end;

{ TPingThread }

constructor TPingThread.Create;
begin
     inherited Create (false) ;
     FEventNr := 0 ;
end;


procedure TPingThread.Execute;
begin
         EventNr := AOwner.csContactingHost ;
         if Ping (Host)
         then PingReply
         else EventNr := AOwner.csHostNotFound ;
end;

{
function TPingThread.Fetch(var AInput: string;
                      const ADelim: string = ' ';
                      const ADelete: Boolean = true) : string;
var
  iPos: Integer;
begin
  if ADelim = #0 then begin
    // AnsiPos does not work with #0
    iPos := Pos(ADelim, AInput);
  end else begin
    iPos := Pos(ADelim, AInput);
  end;
  if iPos = 0 then begin
    Result := AInput;
    if ADelete then begin
      AInput := '';
    end;
  end else begin
    result := Copy(AInput, 1, iPos - 1);
    if ADelete then begin
      Delete(AInput, 1, iPos + Length(ADelim) - 1);
    end;
  end;
end;
}

function TPingThread.Ping(InetAddress : string) : boolean;
var
 Handle : THandle;
 InAddr : IPAddr;
 DW : DWORD;
 rep : array[1..128] of byte;
begin
  try
      result := false;
      Handle := IcmpCreateFile;
      if Handle = INVALID_HANDLE_VALUE then
       Exit;
      TranslateStringToTInAddr(InetAddress, InAddr);
      DW := IcmpSendEcho(Handle, InAddr, nil, 0, nil, @rep, 128, 1000);
      Result := (DW <> 0);
      IcmpCloseHandle(Handle);
  except
      Result := false ;
  end ;
end;

procedure TPingThread.TranslateStringToTInAddr(AIP: string; var AInAddr);
var
  phe: PHostEnt;
  pac: PChar;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  try
    phe := GetHostByName(PChar(AIP));
    if Assigned(phe) then
    begin
      pac := phe^.h_addr_list^;
      if Assigned(pac) then
      begin
        with TIPAddr(AInAddr).S_un_b do begin
          s_b1 := Byte(pac[0]);
          s_b2 := Byte(pac[1]);
          s_b3 := Byte(pac[2]);
          s_b4 := Byte(pac[3]);
        end;
      end
      else
      begin
        // raise Exception.Create('Error getting IP from HostName');
      end;
    end
    else
    begin
      // raise Exception.Create('Error getting HostName');
    end;
  except
    FillChar(AInAddr, SizeOf(AInAddr), #0);
  end;
  WSACleanup;
end;

function TPingThread.EncodeUrl(url : string) : string;
var
 i : integer ;
begin
      Result := '';
      For i := 1 to Length(URL) do
      If URL[i] in ['=','.',':','0'..'9', 'A'..'Z', '[', ']', '_', 'a'..'z','/','&','?']
      Then Result := Result + URL[i]
      Else Result := Result + '%' + IntToHex(Ord(URL[i]), 2);
end;

procedure TPingThread.PingReply ;
begin
     Sleep (AOwner.Sleep) ;
     EventNr := AOwner.csHostContacted ;
     AlreadyReached := true ;
     Sleep (AOwner.Sleep) ;
     if UpdateAvailable then begin
        Sleep (AOwner.Sleep) ;
        if Assigned (AOwner.OnUpdateFound) or AOwner.DefaultEvents then begin
           FDoDownload := false ;
           FDestination := TempDir + URLToFilename (AOwner.Download.URL) ;
           EventNr := AOwner.csUpdateFound ;
           if FDoDownload then begin
              DownloadFileFromURL (AOwner.Download.URL,
                                FDestination,
                                AOwner.Username,
                                AOwner.Password,
                                //AOwner.Download.Username,
                                //AOwner.Download.Password,
                                AOwner.csDownloadProgress) ;
           end ;
        end ;
     end else begin
          EventNr := AOwner.csNoUpdate ;
     end ;
end;

procedure TPingThread.DownloadFileFromURL (SourceURL : string ;
                                           Destination : string ;
                                           Username : string ;
                                           Password : string ;
                                           ProgressID : integer) ;
var
  hSession, hConnect, hRequest: hInternet;
  HostName, FileName: String;
  Port : integer ;
  f: File;
  Buf: Pointer;
  dwBufLen, dwIndex: DWord;
  Data: Array[0..$400] of Char;
  TempStr: String;
  RequestMethod: PChar;
  InternetFlag: DWord;
  AcceptType: LPStr;
  IsPHPFile : boolean ;
  p : integer ;

//  SL : TStringList ;

  procedure ParseURL(URL: String; var HostName, FileName: String ; var Port : integer);

    procedure ReplaceChar(c1, c2: Char; var St: String);
    var
      p: Integer;
    begin
      while True do
       begin
        p := Pos(c1, St);
        if p = 0 then Break
        else St[p] := c2;
       end;
    end;

  var
    i: Integer;
  begin
    if Pos('http://', LowerCase(URL)) <> 0 then
      System.Delete(URL, 1, 7);

    i := Pos('/', URL);
    HostName := Copy(URL, 1, i);
    FileName := Copy(URL, i, Length(URL) - i + 1);

    if (Length(HostName) > 0) and (HostName[Length(HostName)] = '/') then
      SetLength(HostName, Length(HostName) - 1);

    p := pos (':',Hostname)  ;
    if p <> 0 then begin
       Port := StrToIntDef (copy(Hostname,p+1,length(Hostname)) ,INTERNET_DEFAULT_HTTP_PORT) ;
       Hostname := copy (Hostname,1,p-1) ;
    end else begin
       Port := INTERNET_DEFAULT_HTTP_PORT ;
    end ;
  end;

 procedure CloseHandles;
 begin
   InternetCloseHandle(hRequest);
   InternetCloseHandle(hConnect);
   InternetCloseHandle(hSession);
 end;

begin
     if length (SourceURL) >= 4 then begin
        IsPHPFile := copy (uppercase(SourceURL),length(SourceURL)-3,4) = '.PHP' ;
     end else begin
        IsPHPFile := false ;
     end ;

     if IsPHPFile
     then SourceURL := SourceURL + EncodeURL(Format('?ProjectCode=%s&Major=%d&Minor=%d&Release=%d&Build=%d',
                   [AOwner.ProjectCode,
                    AOwner.LocalVersion.Major,
                    AOwner.LocalVersion.Minor,
                    AOwner.LocalVersion.Release,
                    AOwner.LocalVersion.Build]))  ;

     if ProgressID > 0
     then EventNr := AOwner.csDownloadStart ;
     FFileName := Destination ;


     FAcceptTypes := '*/*' ;
     FAgent := 'Internet Update Delphi 4 HTTPGet' ;
     FBinaryData := true ;
     FUseCache := false ;
     FURL := SourceURL ;
     FFileName :=  Destination ;
     FUsername := Username ;
     FPassword := Password ;
     FPostQuery := '' ;
     FReferer := '' ;
     FToFile := true ;

     { Eigentlicher Download }
     FResult := false ;
     try
        ParseURL(FURL, HostName, FileName,Port);

        p := pos ('?PROJECTCODE',uppercase(FURL)) ;
        IsPHPFile := (Uppercase (ExtractFileExt (Filename)) = '.PHP') or (p <> 0) ;

        if FAgent <> '' then
         hSession := InternetOpen(PChar(FAgent),
           INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
        else
         hSession := InternetOpen(nil,
           INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

        hConnect := InternetConnect(hSession, PChar(HostName),
          Port, PChar(FUserName), PChar(FPassword), INTERNET_SERVICE_HTTP, 0, 0);

        if FPostQuery = '' then RequestMethod := 'GET'
        else RequestMethod := 'POST';

        if FUseCache then InternetFlag := 0
        else InternetFlag := INTERNET_FLAG_RELOAD;

        AcceptType := PChar('Accept: ' + FAcceptTypes);
        hRequest := HttpOpenRequest(hConnect, RequestMethod, PChar(FileName), 'HTTP/1.0',
                    PChar(FReferer), @AcceptType, InternetFlag, 0);

        if FPostQuery = '' then
         HttpSendRequest(hRequest, nil, 0, nil, 0)
        else
         HttpSendRequest(hRequest, 'Content-Type: application/x-www-form-urlencoded', 47,
                         PChar(FPostQuery), Length(FPostQuery));

        if Terminated then
         begin
          CloseHandles;
          FResult := False;
          Exit;
         end;

        dwIndex  := 0;
        dwBufLen := 1024;
        GetMem(Buf, dwBufLen);

        FResult := HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_LENGTH,
                                  Buf, dwBufLen, dwIndex);
        if IsPHPFile then FResult := true ; {Tom}

        if Terminated then
         begin
          FreeMem(Buf);
          CloseHandles;
          FResult := False;
          Exit;
         end;

        if FResult or not FBinaryData then
         begin
          if FResult then
            if not(IsPHPFile) then FFileSize := StrToInt(StrPas(Buf)) ;  {Tom}

          BytesReaded := 0;

          if FToFile then
           begin
            AssignFile(f, FFileName);
            Rewrite(f, 1);
           end ;

          while True do
           begin
            if Terminated then
             begin
              if FToFile then CloseFile(f);
              FreeMem(Buf);
              CloseHandles;

              FResult := False;
              Exit;
             end;

            if not InternetReadFile(hRequest, @Data, SizeOf(Data), BytesToRead) then Break
            else
             if BytesToRead = 0 then Break
             else
              begin
               if FToFile then begin
                BlockWrite(f, Data, BytesToRead) ;
               end else begin
                TempStr := Data;
                SetLength(TempStr, BytesToRead);
               end;

               inc(BytesReaded, BytesToRead);
               FTotalSize := FFileSize ;
               FReaded := BytesReaded ;
               EventNr := ProgressID ; //csDownloadProgress ;
              end;
           end;

          if FToFile then
            if IsPHPFile
            then FResult := true
            else FResult := FFileSize = Integer(BytesReaded) {Tom}
          else
           begin
            FResult := BytesReaded <> 0;
           end;

          if FToFile then CloseFile(f);
         end;

        FreeMem(Buf);

        CloseHandles;
     except
     end;

     if ProgressID > 0
     then if FResult
          then EventNr := AOwner.csDownloadComplete
          else EventNr := AOwner.csDownloadError ;


end ;

function TPingThread.URLToFilename (URL : string) : string ;
var
 p : integer ;
begin
     while pos ('/',URL) > 0 do begin
        p := pos ('/',URL) ;
        Delete (URL,p,1) ;
        Insert ('\',URL,p) ;
     end ;
     Result := ExtractFileName (URL) ;
end ;

procedure TPingThread.SetAOwner(const Value: TInternetUpdate);
begin
  FAOwner := Value;
end;

procedure TPingThread.SetHost(const Value: string);
begin
  FHost := Value;
end;

function TPingThread.ZF (n : integer) : string ;
begin
   result := inttostr(n) ;
   while length(Result)<10 do Result := '0' + result ;
end ;

function TPingThread.TempDir : string ;
var
   pcTempDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem( pcTempDirectory, dwSDSize ); // allocate memory for the string
   try
      if Windows.GetTempPath( dwSDSize,pcTempDirectory ) <> 0
      then begin
                Result := pcTempDirectory;
                if Result[length(Result)] <> '\'
                then Result := Result + '\' ;
           end
      else begin
                Result := '' ;
           end ;
   finally
      FreeMem( pcTempDirectory ); // now free the memory allocated for the string
   end;
end;

function TPingThread.UpdateAvailable: boolean;
var
 ini : TiniFile ;
 ininame : string ;
 WN, WV : TStringList ;
 NMax, N, i : integer ;
 KeyName : string ;
 KeyValue : string ;
begin
     { if AOwner.AutoLocalVersion then begin
        AOwner.FileInfo.Filename := application.exename ;
           AOwner.LocalVersion.Major := AOwner.FileInfo.Version.Major ;
           AOwner.LocalVersion.Minor := AOwner.FileInfo.Version.Minor ;
           AOwner.LocalVersion.Release := AOwner.FileInfo.Version.Release ;
           AOwner.LocalVersion.Build := AOwner.FileInfo.Version.Build ;
     end ; }

     with AOwner.LocalVersion do begin
       LV := zf(Major) + zf(Minor) + zf(Release) + zf(Build) ;
       Text := format ('%d.%d.%d.%d',[Major,Minor,Release,Build]) ;
     end ;

     { Remote }
     iniName := TempDir+'iu_VersionInfo.inf' ;
     DownloadFileFromURL (AOwner.URL,iniName,AOwner.Username,AOwner.Password,0) ;
     RV := zf(0) + zf(0) + zf(0) + zf(0) ;
     ini := Tinifile.Create (iniName) ;
     with AOwner.RemoteVersion do begin
        Major := ini.ReadInteger ('VERSION','Major',0) ;
        Minor := ini.ReadInteger ('VERSION','Minor',0) ;
        Release := ini.ReadInteger ('VERSION','Release',0) ;
        Build := ini.ReadInteger ('VERSION','Build',0) ;
        Text := format ('%d.%d.%d.%d',[Major,Minor,Release,Build]) ;
        RV := zf(Major) + zf(Minor) + zf(Release) + zf(Build) ;
     end ;
     AOwner.Download.URL := ini.ReadString ('SETUP','URL','') ;
     AOwner.Download.Username := ini.ReadString ('SETUP','Username','') ;
     AOwner.Download.Password := ini.ReadString ('SETUP','Password','') ;

     { WhatsNew }
        WN := TStringList.create ;
        WV := TStringList.create ;
        ini.ReadSectionValues ('WHATS NEW',WV) ;
        ini.ReadSection('WHATS NEW',WN);
        AOwner.Download.WhatsNew.Clear ;
        AOwner.Download.Description.Clear ;
        NMax := 0 ;
        for i := 0 to WN.count-1 do begin
           KeyName := uppercase (WN[i]) ;
           N := StrToInt (copy (Keyname,2,length(Keyname)-1)) ;
           if N > NMax then NMax := N ;
        end ;
        for i := 0 to NMax do begin
           AOwner.Download.WhatsNew.Add ('') ;
           AOwner.Download.Description.Add ('') ;
        end ;
        NMax := 0 ;
        for i := 0 to WN.count-1 do begin
            KeyName := uppercase (WN[i]) ;
            N := StrToInt (copy (Keyname,2,length(Keyname)-1)) ;
            if N > NMax then NMax := N ;
            KeyValue := WV.Values[KeyName] ;
            if copy (Keyname,1,1) = 'L'
            then AOwner.Download.WhatsNew[N] := KeyValue ;
            if copy (Keyname,1,1) = 'D'
            then AOwner.Download.Description[N] := KeyValue ;
        end ;
        with AOwner.Download.WhatsNew do
           while count-1 > NMax do Delete (count-1) ;
        with AOwner.Download.Description do
           while count-1 > NMax do Delete (count-1) ;

     ini.Free ;


     if fileexists (iniName)
     then DeleteFile (iniName) ;


     if RV > LV
     then Result := true
     else Result := false ;
end;

procedure TPingThread.EventSynch ;
begin
     { if EventNr = csText
     then if Assigned (AOwner.OnText)
          then AOwner.OnText (AOwner,AOwner.MessageText) ; }

     if EventNr = AOwner.csDownloadStart then
          begin
     	 			AOwner.Default_DownloadStart(Aowner);
            if Assigned (AOwner.OnDownloadStart) then
              AOwner.OnDownloadStart (AOwner);
          end;

     if FEventNr = AOwner.csDownloadProgress then
          begin
          	AOwner.Default_DownloadProgress(Aowner,FTotalSize,FReaded);
          	if assigned (AOwner.OnDownloadProgress) then
            	AOwner.OnDownloadProgress (AOwner,FTotalSize,FReaded);
          end;

     if FEventNr = AOwner.csStart then
          begin
          	AOwner.Default_OnStart(Aowner);
          	if assigned (AOwner.OnStart) then
            	AOwner.OnStart (AOwner);
          end;

     if FEventNr = AOwner.csContactingHost then
          begin
          	AOwner.Default_ContactingHost(Aowner);
          	if Assigned (AOwner.OnContactingHost) then
            	AOwner.OnContactingHost (AOwner);
          end;

     if FEventNr = AOwner.csHostNotFound then
     			begin
          	AOwner.Default_HostNotFound(Aowner);
          	if Assigned (AOwner.OnHostNotFound) then
            	AOwner.OnHostNotFound (AOwner);
          end;

     if FEventNr = AOwner.csHostContacted then
     			begin
          	AOwner.Default_HostContacted(Aowner);
          	if assigned (AOwner.OnHostContacted) then
            	AOwner.OnHostContacted (Aowner);
          end;

     if FEventNr = AOwner.csUpdateFound then
          begin
          	if assigned (AOwner.OnUpdateFound) then
     					AOwner.OnUpdateFound (AOwner,AOwner.LocalVersion,AOwner.RemoteVersion,AOwner.Download,FDoDownload,FDestination);
          	AOwner.Default_UpdateFound(AOwner,AOwner.LocalVersion,AOwner.RemoteVersion,AOwner.Download,FDoDownload,FDestination);
     			end;

     if FEventNr = AOwner.csNoUpdate then
     			begin
          	AOwner.Default_NoUpdate(Aowner);
          	if Assigned (AOwner.OnNoUpdate) then
            	AOwner.OnNoUpdate (AOwner);
          end;

     if FEventNr = AOwner.csDownloadComplete then
     begin
        if FileExists (FFilename) then
        begin
              AOwner.Default_DownloadComplete(Aowner,FFileName);
              if assigned (AOwner.OnDownloadComplete) then
              	AOwner.OnDownloadComplete (AOwner,FFilename);
        end else
        begin
           EventNr := AOwner.csDownloadError ;
        end;
     end;

     if FEventNr = AOwner.csDownloadError then
          begin
          	AOwner.Default_DownloadError(Aowner);
          	if assigned (AOwner.OnDownloadError) then
            	AOwner.OnDownloadError (AOwner);
          end;
end;


procedure TPingThread.SetEventNr(const Value: integer);
begin
  AOwner.FEventNr := Value ;
  FEventNr := Value;
  Synchronize (EventSynch) ;
  //EventSynch ;
end;


{ TIUVersionInfo }

procedure TIUVersionInfo.SetText(const Value: string);
begin
  FText := Value;
end;

{ TDownloadInfo }

constructor TDownloadInfo.Create;
begin
     FWhatsNew := TStringList.create ;
     FDescription := TStringList.Create ;
end;

procedure TDownloadInfo.SetDescription(const Value: TStringList);
begin
    FDescription.assign (Value) ;
end;

procedure TDownloadInfo.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TDownloadInfo.SetURL(const Value: string);
begin
      FURL := Value;
end;

procedure TDownloadInfo.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

procedure TDownloadInfo.SetWhatsNew(const Value: TStringList);
begin
  FWhatsNew.assign (Value) ;
end;

end.
