//DMX4ALL C# Wrapper Class written by Hans Thielen, AIX-Events 2008
//DMX4ALL.dll and FTD2XX.dll needed!
//All rights reserved
//Contact: hans.thielen (at) aix-events.de

using System;
using System.Text;
using System.Runtime.InteropServices;

namespace DMX4ALL_Tester
{
    class DMXWrapper
    {
        // Prüft ob am angegebenen Port ein DMX4ALL-Interface gefunden wurde
        // Check if a DMX4ALL interface is connected to the port
        // Port = 1...255    COM
        // Port = 256        USB
        [DllImport("DMX4ALL.dll")]
        public static extern bool CheckPort(int port);

        // Schließt den verwendeten Port
        [DllImport("DMX4ALL.dll")]
        public static extern bool ClosePort();

        // Generiert eine Interfaceliste aller angeschlossenen DMX4ALL-Interfaces und gibt die Anzahl zurück
        // Generate the device list and return the number of found devices
        // numDevs = Pointer to a DWORD, returns the number of found devices
        [DllImport("DMX4ALL.dll")]
        public static extern bool CreateInterfaceList(ref int numDevs);

        // Sucht ein DMX4ALL-Interface am USB und an den COM Ports
        // Search a DMX4ALL interface at the USB and then at the COM ports
        // MaxPort = 0...255 (0-Search only USB)
        [DllImport("DMX4ALL.dll")]
        public static extern bool FindInterface(int maxPort);

        // Abfrage DMX BlackOut Status
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetBlackOut(ref bool blackOut);

        // Liefert den aktuell verwendeten Port und die Baudrate
        // Get the current parameters of the connection
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetComParameters(ref int pPort, ref int pBaudrate);

        // Liefert die DMX-Werte die auf DMX-OUT ausgegeben werden
        // FirstChannel = 0...511    erster zu lesender Kanal
        // NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
        // pData		= BYTE-Array der größe NrOfBytes
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetDmx(int FirstChannel, int NrOfBytes, [Out]byte[] pData);

        // Liefert die DMX-Werte vom DMX-IN
        // Get the dmx levels from the DMX-IN
        // FirstChannel = 0...511    erster zu lesender Kanal
        // NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
        // pData		= BYTE-Array der größe NrOfBytes
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetInDmx(int FirstChannel, int NrOfBytes, [Out]byte[] pData);

        //NO INFO!!!
        //GetInDmxCh

        public struct VERSION_INFO
        {
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 500)]
            public String InterfaceInfo;
            public uint HW_Version;
            public uint NrOfDmxData;
            public bool SignalOutput;
            public byte MergeMode;
            public ushort MergeStart;
            public ushort MergeStop;
        }
        // Liefert Informationen über das verwendete Interface
        // Get informations about the interface
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetInfo(ref VERSION_INFO pVersionInfo);

        // Liefert Interface-Informationen aus der Interfaceliste vom Interface an index
        // returns detailed informations of the interface in the device list found on index
        // index        = 0...numDevs
        // PortIndex    = Pointer to a DWORD, returns the port to open the interface
        // pDescription = Pointer to a char array, returns the description
        // Length       = the length of the char array
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetInterfaceDetail(int index, ref int PortIndex, StringBuilder description, int Length);
        

        // Gibt die aktuell ausgeführte Scene aus dem StandAlone-Speicher an
        // Get the actual executed scene
        // LightScene = 0...255 (0 -> STOP)
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetLightScene(ref int pLightScene);

        // Liest die Anzahl der DMX-IN Kanäle
        // Read the number of DMX-IN channels
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetNrOfChannelsIn(ref int NrOfChannels);


        // Liest die Anzahl der aktuellen DMX-OUT Kanäle
        // Read the actual number of DMX-OUT channels
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetNrOfChannelsOut(ref int NrOfChannels);

        // Liefert Informationen über das verwendete Interface
        // Get informations about the interface
        [DllImport("DMX4ALL.dll")]
        public static extern bool GetProductID(ref int pProdID);

        //NO INFO!!!
        //LastError

        // Wählt den zu verwendenden Port aus
        // Select the port to use
        // Port = 1...255			// COM1 ... COM255
        // Port = 256 or greater	// USB
        [DllImport("DMX4ALL.dll")]
        public static extern bool OpenPort(int Port);

        // Reboot the interface
        [DllImport("DMX4ALL.dll")]
        public static extern bool RebootInterface();

        // Ruft eine Scene aus dem StandAlone-Speicher auf
        // Run a scene of the stand alone memory
        // LightScene = 0...255 (0 -> STOP)
        [DllImport("DMX4ALL.dll")]
        public static extern bool RunLightScene(int LightScene);

        // DMX BlackOut EIN/AUS
        // DMX BlackOut on/off
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetBlackOut(bool BlackOut);

        // Stellt die Verbindung mit dem DMX4ALL-Interface auf die angegebene Baudrate um
        // Set the speed of the communication
        // Baudrate = 19200 oder 38400
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetComParameters(uint Baudrate);

        // Schreibt DMX-Werte auf die DMX-Kanäle ab FirstChannel
        // FirstChannel = 1...512    erster zu schreibender Kanal
        // NrOfBytes    = 1...255    Anzahl zu schreibende Kanäle
        // pData        = BYTE-Array der Größe NrOfBytes
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetDmx(int FirstChannel, int NrOfBytes, ref byte pData);

        // Schreibt einen DMX-Wert (Data) auf den DMX-Kanal
        // Kanal = 1...512
        // Data  = 0...255
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetDmxCh(int Kanal, byte Data);

        // Konfiguriert die Merge-Funktion des PC-Interfaces V4 / DMX-Player XL
        // Das DMX-Signal am DMX-IN wird im angegebenen Kanalbereich ausgegeben
        // Enable = true (aktiv) oder false (dekativiert)
        // ChannelStart = 0...511
        // ChannelStop  = 0...511 und ChannelStart<ChannelStop
        // MergeMode    = 0       Replace with DMX-IN
        // MergeMode    = 1       HTP
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetMerge(bool Enable, int ChannelStart, int ChannelStop, int MergeMode);

        // Setzt die Mindestanzahl der DMX-Ausgangskanäle und speicht diese im EERPOM
        // Channels = 1...511
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetMinChannels(int Channels);

        // Do Description
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetNrOfChannelsOut(int Channels);

        // Schaltet die Pinbelegung des DMX-Interfaces um
        // Switsch the DMX pinout of the interface
        // Pinout = false (intern. Belegung) oder true (Martin Belegung)
        [DllImport("DMX4ALL.dll")]
        public static extern bool SetPinout(bool Pinout);

        // Ruft einen Dialog zur Angabe des Update-Files auf und schreibt dieses in den FLASH-Speicher
        // Open a dialog to select the update-file and write it to the FLASH
        [DllImport("DMX4ALL.dll")]
        public static extern bool UpdateFirmware();

        // Speichert die übergebenen Daten in den StandAlone-Speicher des Interfaces
        // Write the data to the stand alone memory
        // NrOfBytes - Anzahl der zu schreibenden Bytes
        // pData     - Zeiger auf das BYTE-Array der Größe NrOfBytes
        [DllImport("DMX4ALL.dll")]
        public static extern bool WriteMemoryData(ushort NrOfBytes, ref byte pData);
    }
}
