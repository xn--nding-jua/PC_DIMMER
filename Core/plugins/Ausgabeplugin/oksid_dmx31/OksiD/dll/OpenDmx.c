/*
 * Windows interface library for the OPenDMX interface
 * 
 *                     Copyright (c) 2005, O'ksi'D
 *                        All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 *       Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 * 
 *       Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 * 
 *       Neither the name of O'ksi'D nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 * 
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * References :
 *     http://www.enttec.com/dmx_usb/ftdi_driver.zip
 *     http://www.enttec.com/dmx_usb/vc_dll_example.zip
 *     
 *
 * Changes :
 *	
 *
 */

#include <Winsock2.h>
#include <mmsystem.h>
#include <time.h>
#include <windows.h>
#include "okdmx31.h"
#include "resource.h"
#include <stdio.h>
#include <process.h>
#include <string.h>
#include <io.h>
#include <stdlib.h>

#define WINAPI __stdcall
//#define printk(aa) if (debug) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
#define printk(aa) 
#define DLL_ERR f, "OpenDmx.c: "

#define FT_BITS_8	(UCHAR) 8
#define FT_STOP_BITS_2	(UCHAR) 2
#define FT_PARITY_NONE	(UCHAR) 0
#define FT_FLOW_NONE    0x0000
#define FT_PURGE_RX     1
#define FT_PURGE_TX     2

#define FT_HANDLE void*
#define FT_STATUS unsigned int
#define FTD2XX_API typedef
#define WINAPI __stdcall

FTD2XX_API
FT_STATUS (WINAPI *TFT_Open)(
	int deviceNumber,
	FT_HANDLE *pHandle
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_ResetDevice)(
    FT_HANDLE ftHandle
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_SetDivisor)(
    FT_HANDLE ftHandle,
	USHORT Divisor
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_SetDataCharacteristics)(
    FT_HANDLE ftHandle,
	UCHAR WordLength,
	UCHAR StopBits,
	UCHAR Parity
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_SetFlowControl)(
    FT_HANDLE ftHandle,
    USHORT FlowControl,
    UCHAR XonChar,
    UCHAR XoffChar
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_ClrRts)(
    FT_HANDLE ftHandle
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_Purge)(
    FT_HANDLE ftHandle,
	ULONG Mask
	);

FTD2XX_API
FT_STATUS (WINAPI *TFT_Close)(
    FT_HANDLE ftHandle
    );

FTD2XX_API
FT_STATUS (WINAPI *TFT_SetBreakOn)(
    FT_HANDLE ftHandle
    );

FTD2XX_API
FT_STATUS (WINAPI *TFT_SetBreakOff)(
    FT_HANDLE ftHandle
    );

FTD2XX_API 
FT_STATUS (WINAPI *TFT_Write)(
    FT_HANDLE ftHandle,
    LPVOID lpBuffer,
    DWORD nBufferSize,
    LPDWORD lpBytesWritten
    );


static TFT_Open FT_Open = 0;
static TFT_ResetDevice FT_ResetDevice;
static TFT_SetDivisor FT_SetDivisor;
static TFT_SetDataCharacteristics FT_SetDataCharacteristics;
static TFT_SetFlowControl FT_SetFlowControl;
static TFT_ClrRts FT_ClrRts ;
static TFT_Purge FT_Purge;
static TFT_Close FT_Close;
static TFT_SetBreakOn FT_SetBreakOn;
static TFT_SetBreakOff FT_SetBreakOff;
static TFT_Write FT_Write;

static HANDLE thread = 0;
static int run = 0;
static unsigned char ValeurDMX[512];
static int debug = 0;

static void reset_opendmx(FT_HANDLE ftHandle)
{
	FT_STATUS ftStatus;
	ftStatus = FT_ResetDevice(ftHandle);
	ftStatus = FT_SetDivisor(ftHandle,12);
	ftStatus = FT_SetDataCharacteristics(ftHandle,FT_BITS_8,FT_STOP_BITS_2,FT_PARITY_NONE);
	ftStatus = FT_SetFlowControl(ftHandle, FT_FLOW_NONE, 0, 0 );
	FT_ClrRts(ftHandle);
	FT_Purge(ftHandle,FT_PURGE_TX | FT_PURGE_RX);
	Sleep(1000L);
}


/*
 *  Open DMX main loop
 */
static DWORD WINAPI thread_proc(LPVOID lpParameter)
{
	FT_HANDLE ftHandle = 0;
	FT_STATUS ftStatus;
	ULONG bytesWritten;

	ftStatus = FT_Open(0, &ftHandle);

	if (ftStatus != 0) {
		thread = 0;
		printk ((DLL_ERR "thread_proc ftStatus %d\r\n", ftStatus));

		return -1;
	}

	reset_opendmx(ftHandle);
	
	do {
		FT_SetBreakOn(ftHandle);
		FT_SetBreakOff(ftHandle);
		FT_Write(ftHandle, "\0", 1, &bytesWritten);
		FT_Write(ftHandle, ValeurDMX, 512, &bytesWritten);
		Sleep(30);
		printk ((DLL_ERR "thread_proc %d\r\n", bytesWritten));
		if (bytesWritten != 512) reset_opendmx(ftHandle);

	} while (run);

	FT_Close(ftHandle);
	thread = 0;
	return 0;
}

int OpenDmxOpen()
{
	HINSTANCE lib = 0;
	debug = 1;
	{
		lib = LoadLibrary("FTD2XX.dll");
		if (lib && !access("FTD2XX.dll", 0)) {
			FT_Open = (TFT_Open) GetProcAddress((HMODULE)lib, "FT_Open");
			FT_ResetDevice = (TFT_ResetDevice) GetProcAddress((HMODULE)lib, "FT_ResetDevice");
			FT_SetDivisor = (TFT_SetDivisor) GetProcAddress((HMODULE)lib, "FT_SetDivisor");
			FT_SetDataCharacteristics = (TFT_SetDataCharacteristics) GetProcAddress((HMODULE)lib, "FT_SetDataCharacteristics");
			FT_SetFlowControl = (TFT_SetFlowControl) GetProcAddress((HMODULE)lib, "FT_SetFlowControl");
			FT_ClrRts = (TFT_ClrRts) GetProcAddress((HMODULE)lib, "FT_ClrRts");
			FT_Purge = (TFT_Purge) GetProcAddress((HMODULE)lib, "FT_Purge");
			FT_Close = (TFT_Close) GetProcAddress((HMODULE)lib, "FT_Close");
			FT_SetBreakOn = (TFT_SetBreakOn) GetProcAddress((HMODULE)lib, "FT_SetBreakOn");
			FT_SetBreakOff = (TFT_SetBreakOff) GetProcAddress((HMODULE)lib, "FT_SetBreakOff");
			FT_Write = (TFT_Write) GetProcAddress((HMODULE)lib, "FT_Write");
		}
		printk ((DLL_ERR "Loaded FTD2XX %p %p\r\n", lib, FT_Open));
	}

	if (FT_Open) {
		int i;
		run = 1;
		for (i = 0; i < 512; i++) {
			ValeurDMX[i] = 0;
		}
		
		{ 
			int threadid = 0;
			thread = CreateThread(NULL, 0, thread_proc, NULL, 0, &threadid); 
		}	
	}
	debug = 0;
	return FT_Open ? 0 : -1;
}

void OpenDmxSend(unsigned char *buf) 
{
	if (!FT_Open) return;
	memcpy(ValeurDMX, buf, 512);
}

void OpenDmxClose()
{
	if (!FT_Open) return;
	if (thread) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
}
