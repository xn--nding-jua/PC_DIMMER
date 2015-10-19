unit DMX4ALL_Defines;

//************************************************************************
//*                     DMX4ALL Interfaces (c) DMX4ALL                   *
//*                                                                      *
//*                     Header-Übersetzung für Delphi:                   *
//*                   Christian Nöding (www.pcdimmer.de)                 *
//************************************************************************

interface

uses windows, classes, dialogs, sysutils;

Const
  DLLName='DMX4ALL.dll';

type
  TVERSION_INFO = packed record
  	InterfaceInfo:array[0..499] of char;
  	HW_Version:DWORD;
  	NrOfDmxData:DWORD;
  	SignalOutput:boolean;
  	MergeMode:byte;
  	MergeStart:word;
  	MergeStop:word;
  end;

  PData = Array of Byte;

{
        // Liefert die DMX-Werte die auf DMX-OUT ausgegeben werden
        // FirstChannel = 0...511    erster zu lesender Kanal
        // NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
        // pData		= BYTE-Array der größe NrOfBytes
        Dmx4allGetDmx

        // Liefert die DMX-Werte vom DMX-IN
        // Get the dmx levels from the DMX-IN
        // FirstChannel = 0...511    erster zu lesender Kanal
        // NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
        // pData		= BYTE-Array der größe NrOfBytes
        Dmx4allGetInDmx
}

function Dmx4allSetUniverse(Universe:integer):boolean; StdCall; External Dllname name '__SetUniverse';
function Dmx4allOpenPort(Port:integer):boolean; StdCall; External Dllname name '__OpenPort';
function Dmx4allClosePort:boolean; StdCall; External Dllname name '__ClosePort';
function Dmx4allFindInterface(MaxPort:integer):boolean; StdCall; External Dllname name '__FindInterface';
function Dmx4allCheckPort(Port:integer):boolean; StdCall; External Dllname name '__CheckPort';
function Dmx4allSetMinChannels(Channels:Integer):boolean; StdCall; External Dllname name '__SetMinChannels';
function Dmx4allGetNrOfChannelsOut(NrOfChannelsOut:Pointer):boolean; StdCall; External Dllname name '__GetNrOfChannelsOut';
function Dmx4allGetNrOfChannelsIn(NrOfChannelsIn:Pointer):boolean; StdCall; External Dllname name '__GetNrOfChannelsIn';
function Dmx4allSetDmx(FirstChannel:integer; NrOfBytes:integer; DMXData:Pointer):boolean; StdCall; External Dllname name '__SetDmx';
function Dmx4allGetDmx(FirstChannel:integer; NrOfBytes:integer; DMXData:Pointer):boolean; StdCall; External Dllname name '__GetDmx';
function Dmx4allSetDmxCh(Kanal: integer; Data:Byte):boolean; StdCall; External Dllname name '__SetDmxCh';
function Dmx4allGetComParameters(pPort:Pointer; pBaudrate:Pointer):boolean; StdCall; External Dllname name '__GetComParameters';
function Dmx4allSetComParameters(Baudrate: Word):boolean; StdCall; External Dllname name '__SetComParameters';
function Dmx4allSetPinout(Modus:boolean):boolean; StdCall; External Dllname name '__SetPinout';
function Dmx4allRunLightScene:boolean; StdCall; External Dllname name '__RunLightScene';
function Dmx4allGetInDmx(FirstChannel:integer; NrOfBytes:integer; DMXData:Pointer):boolean; StdCall; External Dllname name '__GetInDmx';
function Dmx4allSetMerge(Enabled:boolean; ChannelStart:integer; ChannelStop:integer; MergeMode:integer):boolean; StdCall; External Dllname name '__SetMerge';
// WriteMemoryState // ??? Keine Infos in API-Beschreibungs-PDF
// UpdateFirmware // ??? Keine Infos in API-Beschreibungs-PDF
function Dmx4allGetInfo(pVersionInfo:Pointer):boolean; StdCall; External Dllname name '__GetInfo';
function Dmx4allGetProductID(pProdID:Pointer):boolean; StdCall; External Dllname name '__GetProductID';
function Dmx4allSetBlackOut(Blackout:boolean):boolean; StdCall; External Dllname name '__SetBlackOut';
function Dmx4allGetBlackOut:boolean; StdCall; External Dllname name '__GetBlackOut';
function Dmx4allSetNrOfLcdLines(numLines:integer):boolean; StdCall; External Dllname name '__SetNrOfLcdLines';
function Dmx4allRebootInterface:boolean; StdCall; External Dllname name '__RebootInterface';
// Setup // ??? Keine Infos in API-Beschreibungs-PDF
// ReadEEPROM // ??? Keine Infos in API-Beschreibungs-PDF
function Dmx4allCreateInterfaceList(numDevs:Pointer):boolean; StdCall; External Dllname name '__CreateInterfaceList';
function Dmx4allDeleteInterfaceList:boolean; StdCall; External Dllname name '__DeleteInterfaceList';
function Dmx4allGetInterfaceDetail(Index:DWORD; PortIndex:Pointer; pDescription:PChar; Length:Integer):boolean; StdCall; External Dllname name '__GetInterfaceDetail';
function Dmx4allLastError(ErrorCode:Pointer):boolean; StdCall; External Dllname name '__LastError';

implementation

end.
