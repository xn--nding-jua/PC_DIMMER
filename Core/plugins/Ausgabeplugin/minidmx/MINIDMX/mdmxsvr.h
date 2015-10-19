//===========================================================================
// mdmxsvr.h
// Copyright (C) 2003,2004 Mathias Dzionsko (madz@gmx.de)
//---------------------------------------------------------------------------
// Änderungen:
// 06.11.2003 - v0.1.0.0
//     Erste Testversion
// 22.03.2004 - v1.0.0.0
//     Korrektur von EXPORT_TYPE, einige Kommentare hinzugefügt
//===========================================================================
#ifndef mdmxsvr_h
#define mdmxsvr_h
//---------------------------------------------------------------------------
#ifdef __DLL__ // Wird gerade die DLL erstellt?
#define EXPORT_TYPE __stdcall __declspec(dllexport)
#else
#define EXPORT_TYPE __stdcall __declspec(dllimport)
#endif
//===========================================================================
// Konstanten

// Parameter für MDMX_OpenSerialDevice
#define MDMX_256CH                  0
#define MDMX_512CH                  1

// Rückgabewerte
#define MDMX_OK                     0
#define MDMX_ERROR_SERIALPORT       1
#define MDMX_ERROR_DEVICENOTFOUND   2
#define MDMX_ERROR_CREATETHREAD     3
#define MDMX_ERROR_PARAMOUTOFRANGE  4
//===========================================================================
// Funktion: MDMX_OpenSerialDevice
// Parameter:
//   portname:
//     Name der seriellen Schnittstelle (z.B. "COM1")
//   serialmode:
//     MDMX_256CH - 256 Kanäle senden (schneller)
//     MDMX_512CH - 512 Kanäle senden
// Rückgabewerte:
//   MDMX_OK - Funktion erfolgreich
//   MDMX_ERROR_SERIALPORT - Schnittstelle kann nicht geöffnet werden
//   MDMX_ERROR_DEVICENOTFOUND - MiniDMX-Dongle nicht gefunden
//   MDMX_ERROR_CREATETHREAD - Thread kann nicht gestartet werden

extern "C" int EXPORT_TYPE MDMX_OpenSerialDevice(const char *portname,
    int serialmode);
//---------------------------------------------------------------------------
// Funktion: MDMX_SetChannel
// Parameter:
//   channel: 0-511 (DMX-Kanalnr. 1 bis 512)
//   value: 0-255
// Rückgabewerte:
//   MDMX_OK - Funktion erfolgreich
//   MDMX_ERROR_PARAMOUTOFRANGE - Parameter außerhalb des zulässigen Bereichs

extern "C" int EXPORT_TYPE MDMX_SetChannel(int channel, int value);
//---------------------------------------------------------------------------
// Funktion: MDMX_GetDMXTransmissions
// Parameter:
//   keine
// Rückgabewerte:
//   Anzahl erfolgreicher DMX-Sendungen seit dem letzten Aufruf oder seit
//   MDMX_OpenSerialDevice

extern "C" int EXPORT_TYPE MDMX_GetDMXTransmissions(void);
//---------------------------------------------------------------------------
// Funktion: MDMX_Close
// Parameter:
//   keine
// Rückgabewerte:
//   keine

extern "C" void EXPORT_TYPE MDMX_Close(void);
//===========================================================================
#endif
//===========================================================================

