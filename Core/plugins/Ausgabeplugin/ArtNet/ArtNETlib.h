/*++

Copyright (c) 2005-2009 Chris Noeding

Module Name:

    ArtNetlib.h

Abstract:

    Library for sending and receiving ArtNet
    with own applications

Revision History:

	Date		Name		Info
	=====================================================================
    	06.10.2009    	Chris Noeding   Created.
	
--*/


#ifndef ARTNETLIB_H
#define ARTNETLIB_H

#include <windows.h>

#define ARTNET_API

#ifdef __cplusplus
extern "C" {
#endif

// types for library functions
typedef unsigned char TDMXArray[512];

// CallBacks Definitionen
typedef void (__stdcall cbReceiveDMXUniverse) (int ArtNETSubNet, int ArtNETUniverse, TDMXArray *Buffer, int Length) ;
typedef void (__stdcall cbReceiveSingleValue) (int ArtNETSubNet, int ArtNETUniverse, int Channel, int Value) ;

// Globale Pointers to Functions
cbReceiveDMXUniverse * pReceiveDMXUniverse  = NULL ;
cbReceiveSingleValue * pReceiveSingleValue  = NULL ;


ARTNET_API  void __stdcall ArtNET_Activate(
	cbReceiveDMXUniverse * CallbackReceiveDMXUniverse,
	cbReceiveSingleValue * CallbackReceiveSingleValue);

ARTNET_API  void __stdcall ArtNET_Deactivate(
	);

ARTNET_API  int __stdcall ArtNET_SetChannel(
	int ArtNETSubNet,
	int ArtNetUniverse,
	int Channel,
	int Value);

ARTNET_API  void __stdcall ArtNET_SendDMXUniverse(
	char *Address,
	int ArtNETSubNet,
	int ArtNetUniverse,
	TDMXArray Buffer,
	int Length);

ARTNET_API  void __stdcall ArtNET_ShowConfig(
	);

ARTNET_API  void __stdcall ArtNET_ShowAbout(
	);

ARTNET_API  void __stdcall ArtNET_SetReceiveUniverseOnOff(
	int ArtNETSubNet,
	int ArtNetUniverse,
	bool Enabled);

#ifdef __cplusplus
};
#endif

#endif