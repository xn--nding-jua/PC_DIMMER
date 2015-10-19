//
// (c) 2008 by Markus Siwek
//
//////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __DMX4ALLINIT_H
#define __DMX4ALLINIT_H

#include "DMX4ALLdefs.h"

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

//--------------------------------------------------------------------------------
// Allgemeine Funktionen

// Öffnet die Datei DMX4ALL.DLL
// Open the file DMX4ALL.DLL
bool	Dmx4allDllOpen();

// Schließt die Datai DMX4ALL.DLL
// Close the file DMX4ALL.DLL
bool	Dmx4allDllClose();

//--------------------------------------------------------------------------------
// COM-Port Funktionen

// Wählt das zu verwendenden DMX-Universum aus
// Select the DMX universe to use
// Universe = 0...15
bool	Dmx4allSetUniverse(int Universe);

// Wählt den zu verwendenden Port aus
// Select the port to use
// Port = 1...255			// COM1 ... COM255
// Port = 256 or greater	// USB
bool	Dmx4allOpenPort(int Port);
bool	Dmx4allSetComPort(int Port);	// obsolete, should not be used

// Schließt den verwendeten Port
// Close the used port
bool	Dmx4allClosePort();
bool	Dmx4allClearComPort();			// obsolete, should not be used

// Prüft ob am angegebenen Port ein DMX4ALL-Interface gefunden wurde
// Check if a DMX4ALL interface is connected to the port
// Port = 1...255    COM
// Port = 256        USB
bool	Dmx4allCheckPort(int Port);
bool	Dmx4allCheckComPort(int Port);	// obsolete, should not be used

// Sucht ein DMX4ALL-Interface am USB und an den COM Ports
// Search a DMX4ALL interface at the USB and then at the COM ports
// MaxPort = 0...255 (0-Search only USB)
bool	Dmx4allFindInterface(int MaxPort = 255);

// Stellt die Verbindung mit dem DMX4ALL-Interface auf die angegebene Baudrate um
// Set the speed of the communication
// Baudrate = 19200 oder 38400
bool	Dmx4allSetComParameters(UINT Baudrate);

// Liefert den aktuell verwendeten Port und die Baudrate
// Get the current parameters of the connection
bool	Dmx4allGetComParameters(int* pPort, DWORD* pBaudrate);


// Generiert eine Interfaceliste aller angeschlossenen DMX4ALL-Interfaces und gibt die Anzahl zurück
// Generate the device list and return the number of found devices
// numDevs = Pointer to a DWORD, returns the number of found devices
bool	Dmx4allCreateInterfaceList(DWORD* numDevs);

// Löscht die Interfaceliste
// Delete the device list
bool	Dmx4allDeleteInterfaceList();

// Liefert Interface-Informationen aus der Interfaceliste vom Interface an index
// returns detailed informations of the interface in the device list found on index
// index        = 0...numDevs
// PortIndex    = Pointer to a DWORD, returns the port to open the interface
// pDescription = Pointer to a char array, returns the description
// Length       = the length of the char array
bool	Dmx4allGetInterfaceDetail(DWORD index, DWORD* PortIndex, char* pDescription,int Length);

//--------------------------------------------------------------------------------
// DMX4ALL-Interface Funktionen

// Schreibt einen DMX-Wert (Data) auf den DMX-Kanal
// Kanal = 1...512
// Data  = 0...255
bool	Dmx4allSetDmxCh(int Kanal, BYTE Data);

// Schreibt DMX-Werte auf die DMX-Kanäle ab FirstChannel
// FirstChannel = 1...512    erster zu schreibender Kanal
// NrOfBytes    = 1...255    Anzahl zu schreibende Kanäle
// pData        = BYTE-Array der Größe NrOfBytes
bool	Dmx4allSetDmx(int FirstChannel, int NrOfBytes, BYTE* pData);

// Liefert die DMX-Werte die auf DMX-OUT ausgegeben werden
// FirstChannel = 0...511    erster zu lesender Kanal
// NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
// pData		= BYTE-Array der größe NrOfBytes
bool	Dmx4allGetDmx(int FirstChannel, int NrOfBytes, BYTE* pData);

// Setzt die Mindestanzahl der DMX-Ausgangskanäle und speicht diese im EERPOM
// Channels = 1...511
bool	Dmx4allSetMinChannels(int Channels);

// Liest die Anzahl der aktuellen DMX-OUT Kanäle
// Read the actual number of DMX-OUT channels
bool	Dmx4allGetNrOfChannelsOut(int* NrOfChannels);

// Liest die Anzahl der DMX-IN Kanäle
// Read the number of DMX-IN channels
bool	Dmx4allGetNrOfChannelsIn(int* NrOfChannels);

// Schaltet die Pinbelegung des DMX-Interfaces um
// Switsch the DMX pinout of the interface
// Pinout = false (intern. Belegung) oder true (Martin Belegung)
bool	Dmx4allSetPinout(bool Pinout);

// Liefert die DMX-Werte vom DMX-IN
// Get the dmx levels from the DMX-IN
// FirstChannel = 0...511    erster zu lesender Kanal
// NrOfBytes	= 1...255    Anzahl der zu lesenden Kanäle
// pData		= BYTE-Array der größe NrOfBytes
bool	Dmx4allGetInDmx(int FirstChannel, int NrOfBytes, BYTE* pData);

// Konfiguriert die Merge-Funktion des PC-Interfaces V4 / DMX-Player XL
// Das DMX-Signal am DMX-IN wird im angegebenen Kanalbereich ausgegeben
// Enable = true (aktiv) oder false (dekativiert)
// ChannelStart = 0...511
// ChannelStop  = 0...511 und ChannelStart<ChannelStop
// MergeMode    = 0       Replace with DMX-IN
// MergeMode    = 1       HTP
bool	Dmx4allSetMerge(bool Enable,int ChannelStart,int ChannelStop,int MergeMode);

// Speichert die übergebenen Daten in den StandAlone-Speicher des Interfaces
// Write the data to the stand alone memory
// NrOfBytes - Anzahl der zu schreibenden Bytes
// pData     - Zeiger auf das BYTE-Array der Größe NrOfBytes
bool	Dmx4allWriteMemoryData(WORD NrOfBytes, BYTE* pData);

// Ruft eine Scene aus dem StandAlone-Speicher auf
// Run a scene of the stand alone memory
// LightScene = 0...255 (0 -> STOP)
bool	Dmx4allRunLightScene(int LightScene);

// Gibt die aktuell ausgeführte Scene aus dem StandAlone-Speicher an
// Get the actual executed scene
// LightScene = 0...255 (0 -> STOP)
bool	Dmx4allGetLightScene(int* pLightScene);

// Ruft einen Dialog zur Angabe des Update-Files auf und schreibt dieses in den FLASH-Speicher
// Open a dialog to select the update-file and write it to the FLASH
bool	Dmx4allUpdateFirmware();

// Liefert Informationen über das verwendete Interface
// Get informations about the interface
bool	Dmx4allGetInfo(VERSION_INFO* pVersionInfo);

// Liefert Informationen über das verwendete Interface
// Get informations about the interface
bool	Dmx4allGetProductID(int* pProdID);

// Read from EEPROM
bool	Dmx4allReadEEPROM(UINT NrOfBytes,UINT* BytesRead,BYTE* pData);

// DMX BlackOut EIN/AUS
// DMX BlackOut on/off
bool	Dmx4allSetBlackOut(bool BlackOut);

// Abfrage DMX BlackOut Status
// Request DMX BlackOut state
bool	Dmx4allGetBlackOut(bool* BlackOut);

// Reboot the interface
bool	Dmx4allRebootInterface();

// Send configuration command
bool	Dmx4allSetup(char* pCmd,int Length);


#endif
