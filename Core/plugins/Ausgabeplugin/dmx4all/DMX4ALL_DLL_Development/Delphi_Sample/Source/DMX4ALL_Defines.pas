unit DMX4ALL_Defines;

//************************************************************************
//*                     DMX4ALL Interfaces (c) DMX4ALL                   *
//*                   Übersetzung C<>Delphi FreeStylers(R) GmbH 2007     *
//*                           by Thomas Franke                           *
//*                  www.seelightbox.de  www.freestylers.tv              *
//*                         www.lbos.seelightbox.de                      *
//*               BUG-Report bitte an: t.franke@freestylers.tv           *
//************************************************************************

interface

uses windows,classes,dialogs,sysutils;

Const DLLName='DMX4All.dll';

Type TVersionInfoStruct = record
      InfoText : PChar;
      HW_Version: DWord;
      DLL_Verison:DWord;
      NrOfDMXData:DWord;
      SignalOutput:boolean;
      MergeMode:Byte;
      MergeStart:Word;
      MergeStop:Word;
end;

Type TInterfaceConfig = record
      StructSize : DWord;
      HW_Version : DWord;
      SW_Version : DWord;
      Baudrate   : DWord;
      SignalOutput: Boolean;
      NrOfMinDMXChannels : Word;
      FadeBetweenScenes : Boolean;
      MergeMode : Byte;
      MergeStart : Word;
      MergeStop : Word;
      NrOfLCDLines : byte;
      Backlight : Boolean;
end;

Type PData = array [0..511] of Byte;
Type PaData = Array of Byte;


VAR  Interface_Config : TinterfaceConfig;
     Version_Info     : TVersionInfoStruct;
     Show_MSGDLG      : Boolean = true;
     Save_Log         : Boolean = true;
     LogFile          : String;
     DMX_Data         : PaData;

Const USB_PORT=256;
      Default_Logfile = 'C:\DMX4ALL_Interface.log';

//API Funktionen
//COM-Port Funktionen
// Wählt den zu verwendenden COM-Port aus
// Select the COM port to use
Function DMX4ALLSetComPort(Port:Integer):Boolean;

// Schließt den verwendeten COM-Port
// Close the used COM port
Function DMX4ALLClearComPort:boolean;

// Prüft ob am angegebenen COM-Port ein DMX4ALL-Interface gefunden wurde
// Check if a DMX4ALL interface is connected to the port
// Port = 1...255
Function DMX4ALLCheckComPort(Port:Integer):boolean;

// Sucht ein DMX4ALL-Interface am USB und an den COM Ports
// Search a DMX4ALL interface at the USB and then at the COM ports
// MaxPort = 0...255 (0-Search only USB)
Function DMX4ALLFindInterface(Max_Port:Integer):boolean;

// Stellt die Verbindung mit dem DMX4ALL-Interface auf die angegebene Baudrate um
// Set the speed of the communication
// Baudrate = 19200 oder 38400
Function DMX4ALLSetComParameters(Baudrate:Cardinal):Boolean;

// Liefert den aktuell verwendeten COM-Port und die Baudrate
Function DMX4ALLGetComParameters(Var Port:integer; Var Baudrate:DWORD):Boolean;

//Interface Funktionen
// Schreibt einen DMX-Wert (Data) auf den DMX-Kanal
// Kanal = 1...512
// Data  = 0...255
Function DMX4ALLSetDMXCh(Kanal:Integer; Data:Byte):Boolean;

// Schreibt DMX-Werte auf die DMX-Kanäle ab FirstChannel
// FirstChannel = 1...512    erster zu schreibender Kanal
// NrOfBytes    = 1...255    Anzahl zu schreibende Kanäle
// pData        = BYTE-Array der Größe NrOfBytes
Function DMX4ALLSetDmx(FirstChannel,NrOfBytes:Integer;Data:PAdata):Boolean;

// Liefert die DMX-Werte die auf DMX-OUT ausgegeben werden
// FirstChannel = 0...511    erster zu lesender Kanal
// NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
// pData		= BYTE-Array der größe NrOfBytes
Function DMX4ALLGetDmx(FirstChannel,NrOfBytes:integer; Var Data:PAdata):Boolean;

// Setzt die Mindestanzahl der DMX-Ausgangskanäle und speicht diese im EERPOM
// Channels = 1...511
Function DMX4ALLSetMinChannels(Channels:Integer):Boolean;

// Liest die Anzahl der DMX-Kanäle von DMX-OUT
Function DMX4ALLGetNrOfChannelsOut(VAR NrOfChannelsOut:Integer):Boolean;

// Schaltet die Pinbelegung des DMX-Interfaces um
// Switsch the DMX pinout of the interface
// Pinout = false (intern. Belegung) oder true (Martin Belegung)
Function DMX4ALLSetPinOut(Pinout:Boolean):Boolean;

// Liefert die DMX-Werte vom DMX-IN
// Get the dmx levels from the DMX-IN
// FirstChannel = 0...511    erster zu lesender Kanal
// NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
// pData		= BYTE-Array der größe NrOfBytes
Function DMX4ALLGetInDMX(FirstChannel,NrOfBytes:Integer; VAR Data:PaData):Boolean;

// Konfiguriert die Merge-Funktion des PC-Interfaces V4
// Das DMX-Signal am DMX-IN wird im angegebenen Kanalbereich ausgegeben
// Enable = true (aktiv) oder false (dekativiert)
// ChannelStart = 0...511
// ChannelStop  = 0...511 und ChannelStart<ChannelStop
Function DMX4ALLSetMerge(Enable:Boolean;ChannelStart,ChannelStop:integer):Boolean;

// Speichert die übergebenen Daten in den StandAlone-Speicher des Interfaces
// Write the data to the stand alone memory
// NrOfBytes - Anzahl der zu schreibenden Bytes
// pData     - Zeiger auf das BYTE-Array der Größe NrOfBytes
Function DMX4ALLWriteMemoryData(NrOfBytes:Word; VAR Data:PaData):Boolean;

// Ruft eine Scene aus dem StandAlone-Speicher auf
// Run a scene of the stand alone memory
// LightScene = 0...255 (0 -> STOP)
Function DMX4ALLRunLightScene(LightScene:Integer):Boolean;

// Gibt die aktuell ausgeführte Scene aus dem StandAlone-Speicher an
// Get the actual executed scene
// LightScene = 0...255 (0 -> STOP)
Function DMX4ALLGetLightScene(Var LightScene:Integer):Boolean;

// Ruft einen Dialog zur Angabe des Update-Files auf und schreibt dieses in den FLASH-Speicher
// Open a dialog to select the update-file and write it to the FLASH
Function DMX4ALLUpdateFirmware:Boolean;

// Liefert Informationen über das verwendete Interface
// Get informations about the interface
Function DMX4ALLGetInfo:Boolean;

// Liefert Informationen über das verwendete Interface
// Get informations about the interface
Function DMX4ALLGetProductInfo(Var ProdID:integer; var ProdDescription:PChar):Boolean;

// Liefert die aktuelle Konfiguration des Interfaces
// Get the current configuration of the interface
Function DMX4ALLGetInterfaceConfig:Boolean;

// DMX BlackOut EIN/AUS
// DMX BlackOut on/off
Function DMX4ALLSetBlackOut(Blackout:Boolean):Boolean;

// LCD Hintergrundbeleuchtung EIN/AUS
// LCD backlight on/off
Function DMX4ALLSetLcdBacklight(LcdBacklight:Boolean):Boolean;

// LCD number of lines 1/2/4
Function DMX4ALLSetNrOfLcdLines(LcdLines:integer):Boolean;

// Fade zwischen Scenen EIN/AUS
// Fade between scenes on/off
Function DMX4ALLSetFadeBetweenScenes(FadeBetweenScenes:Boolean):Boolean;

// Setzt den Merge-Mode
// Set the merge mode
Function DMX4ALLSetMergeMode(MergeMode:Integer):Boolean;

// Startet die Firmware neu
// Start the firmware
Function DMX4ALLRebootInterface:Boolean;

Function LastError:Integer; StdCall; External Dllname;

//Gibt die entsprechende Fehlermeldung aus
Procedure ErrorMess;

Implementation

Function __SetComPort(Port:integer):boolean; StdCall; External DLLname;
Function __ClearComPort:Boolean; StdCall; External Dllname;
Function __CheckComPort(Port:integer):Boolean; StdCall; External DLLname;
Function __FindInterface(MaxPort:integer):Boolean; StdCall; External DllName;
Function __SetDmxCh(Channel:Integer;Value:Byte):Boolean; StdCall; External DllName;
Function __SetDmx(StartCh,NrOfCh:integer;Values:PAdata):boolean; StdCall; External DLLname;
Function __GetDmx(StartCh,NrOfCh:integer; VAR Values:PAData):Boolean; StdCall; External Dllname;
Function __GetComParameters(Var Port:integer; Var Baudrate:Cardinal):Boolean; StdCall; External Dllname;
Function __SetComParameters(Port:integer):Boolean; StdCall; External DLLname;
Function __SetMinChannels(Value:integer): Boolean; StdCall; External DllName;
Function __GetNrOfChannelsOut(Var Value:integer): Boolean; StdCall; External Dllname;
Function __SetPinout(PinOUT:Boolean):boolean; StdCall; External Dllname;
Function __RunLightScene(Nr:integer):Boolean; StdCall; External Dllname;
Function __GetLightScene(Var Nr:Integer):Boolean; StdCall; External DllName;
Function __GetInDmx(StartCh,NrOfCh:integer;Var Values:PaData):Boolean; StdCall; External Dllname;
Function __SetMerge(Enable:Boolean;StartCh,StopCh:integer):Boolean; StdCall; External Dllname;
Function __WriteMemoryData(NrOfBytes:Word; Var ByteArr:PaData):Boolean; StdCall; External DllName;
Function __UpdateFirmware:Boolean; StdCall; External Dllname;
Function __GetInfo(Var Version_info:TVERSIONInfoStruct):boolean; StdCall; External Dllname;
Function __GetProductInfo(Var ID:integer; var Text:PChar):Boolean; StdCall; External Dllname;
Function __GetInterfaceConfig(Var Config:TInterfaceConfig):Boolean; StdCall; External Dllname;
Function __SetInOut(INout:boolean):Boolean; StdCall; External Dllname;
Function __SetBlackOut (Blackout:boolean):Boolean; StdCall; External Dllname;
Function __SetLcdBacklight (ONoff:Boolean):Boolean; StdCall; External Dllname;
Function __SetNrOfLcdLines (Nr:integer):Boolean; StdCall; External Dllname;
Function __SetFadeBetweenScenes (OnOff:Boolean):Boolean; StdCall; External Dllname;
Function __SetMergeMode (Mode:Integer):Boolean; StdCall; External Dllname;
Function __RebootInterface:Boolean; StdCall; External Dllname;


Procedure ErrorMess;
VAR Error:Integer;
    Log:TStringlist;
    Mess:String;
begin
  Error:=LastError;
  Case Error of
   1: Mess:='COM-Port not available Error Code 1';
   2: Mess:='Could not found DMX4ALL Interface! Error Code 2';
   3: Mess:='USB Connection failed! Error Code 3';
   4: Mess:='Invalid Com-Port! Error Code 4';
   10: Mess:='Transfer failed! Error Code 10';
    else
     Mess:='Unknow error - '+inttostr(Error);
  End;
 if Show_MSGDLG then MessageDlg(Mess,mtWarning,[mbOK],0);
 if Save_Log then
  begin
   Log:=TStringlist.Create;
    try
    if LogFile='' then LogFile:=Default_Logfile;
     if FileExists(Logfile) then
      Log.LoadFromFile(Logfile);
      Log.Add(TimetoStr(now)+': '+Mess);
      log.SaveToFile(LogFile);
     finally
      Log.free;
      end;
     end;
end;



Function DMX4ALLSetComPORT(Port:integer):Boolean;
begin
 Result:= __SetComPort(Port);
end;

Function DMX4ALLClearComPort:Boolean;
Begin
 Result:= __ClearComPort;
End;

Function DMX4ALLCheckComPort(Port:integer):Boolean;
begin
 Result:= __CheckComPort(Port);
end;

Function DMX4ALLFindInterface(Max_Port:integer):Boolean;
begin
 Result:= __FindInterface(Max_Port);
end;

Function DMX4ALLSetMinChannels(Channels:Integer):Boolean;
begin
 Result:= __SetMinChannels(Channels);
end;

Function DMX4ALLGetNrOfChannelsOut(VAR NrOfChannelsOut:Integer):Boolean;
begin
 Result:= __GetNrOfChannelsOut(NrOfChannelsOut);
end;

Function DMX4ALLSetDmx(FirstChannel,NrOfBytes:Integer; Data:PAdata):Boolean;
Begin
 Result:= __SetDMX(FirstChannel,NrOfBytes,Data);
End;

Function DMX4ALLGetDmx(FirstChannel,NrOfBytes:integer; Var Data:PaData):Boolean;
Begin
 Result:= __GetDMX(FirstChannel,NrOfBytes,Data);
End;

Function DMX4ALLSetDMXCh(Kanal:Integer; Data:Byte):Boolean;
Begin
 Result:=__SetDMXCh(Kanal,Data);
End;

Function DMX4ALLGetComParameters(Var Port:integer; Var Baudrate:DWORD):Boolean;
Begin
 Result:= __GetComParameters(Port,Baudrate);
End;

Function DMX4ALLSetComParameters(Baudrate:Cardinal):Boolean;
Begin
 Result:= __SetComParameters(Baudrate);
End;


Function DMX4ALLSetPinOut(Pinout:Boolean):Boolean;
Begin
 Result:= __SetPinOUT(PinOut);
End;

Function DMX4ALLRunLightScene(LightScene:Integer):Boolean;
Begin
 Result:= __RunLightScene(LightScene);
End;

Function DMX4ALLGetInDMX(FirstChannel,NrOfBytes:Integer; VAR Data:PaData):Boolean;
Begin
 Result:=__GetInDMX(FirstChannel,NrOfBytes,Data);
End;

Function DMX4ALLSetMerge(Enable:Boolean;ChannelStart,ChannelStop:integer):Boolean;
Begin
 Result:=__SetMerge(Enable,ChannelStart,ChannelStop);
End;

Function DMX4ALLWriteMemoryData(NrOfBytes:Word; VAR Data:PaData):Boolean;
Begin
 Result:=__WriteMemoryData(NrOfBytes,Data);
End;

Function DMX4ALLUpdateFirmware:Boolean;
Begin
 Result:=__UpdateFirmware;
End;

Function DMX4ALLGetInfo:Boolean;
var pC: PChar;
     i: integer;
     C: array[0..999] of char;
Begin
  for i:=0 to 999 do c[i]:=#0;
  c:='MeinInfoText';
  pC:=@c[0];

  Version_Info.InfoText:=pC;
  Version_Info.HW_Version:=0;
  Version_Info.DLL_Verison:=0;
  Version_Info.NrOfDMXData:=0;
  Version_Info.SignalOutput:=false;
  Version_Info.MergeMode:=0;
  Version_Info.MergeStart:=0;
  Version_Info.MergeStop:=0;
 Result:=__GetInfo(Version_Info);
End;

Function DMX4ALLGetProductInfo(Var ProdID:integer; var ProdDescription: PChar):Boolean;
Begin
 result:= __GetProductInfo(ProdID, ProdDescription);
End;

Function DMX4ALLGetInterfaceConfig:Boolean;
Begin
 Result:=__GetInterfaceConfig(Interface_Config);
End;

Function DMX4ALLSetBlackOut(Blackout:Boolean):Boolean;
Begin
 Result:=__Setblackout(Blackout);
End;

Function DMX4ALLSetNrOfLcdLines(LcdLines:integer):Boolean;
Begin
  Result:=__SetNrOfLcdLines(LcdLines);
End;

Function DMX4ALLSetLcdBacklight(LcdBacklight:Boolean):Boolean;
Begin
 Result:=__SetLCDBacklight(LcdBacklight);
End;

Function DMX4ALLSetFadeBetweenScenes(FadeBetweenScenes:Boolean):Boolean;
Begin
 Result:=__SetFadeBetweenScenes(FadeBetweenScenes);
End;

Function DMX4ALLSetMergeMode(MergeMode:Integer):Boolean;
Begin
 Result:=__SetMergeMode(MergeMode);
End;

Function DMX4ALLGetLightScene(Var LightScene:Integer):Boolean;
Begin
 Result:=__GetLightScene(LightScene);
End;


Function DMX4ALLRebootInterface:Boolean;
Begin
 Result:=__RebootInterface;
End;

end.
