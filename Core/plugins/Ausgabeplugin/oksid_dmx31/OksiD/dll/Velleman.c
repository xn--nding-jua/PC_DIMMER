/*
 * Windows interface library for the Velleman interface
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
 *     http://www.monacor.com/global_img/DMX_DLL3.zip
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
#define DLL_ERR f, "Velleman.c: "

typedef void (__stdcall *TStartDevice)(void);
typedef void (__stdcall *TSetData)(long Channel, long Data);
typedef void (__stdcall *TSetChannelCount)(long Count);
typedef void (__stdcall *TStopDevice)(void);

static TStartDevice StartDevice = 0;
static TSetData SetData = 0;
static TSetChannelCount SetChannelCount = 0;
static TStopDevice StopDevice = 0;

static int debug = 0;


int VellemanOpen()
{
	HINSTANCE lib = 0;
	debug = 1;
	{
		lib = LoadLibrary("K8062D.dll");
		if (lib && !access("K8062D.dll", 0)) {
			StartDevice = (TStartDevice) GetProcAddress((HMODULE)lib, "StartDevice");
			SetData = (TSetData) GetProcAddress((HMODULE)lib, "SetData");
			SetChannelCount = (TSetChannelCount) GetProcAddress((HMODULE)lib, "SetChannelCount");
			StopDevice = (TStopDevice) GetProcAddress((HMODULE)lib, "StopDevice");
		}
		printk ((DLL_ERR "Loaded K8062D %p %p\r\n", lib, StartDevice));
	}

	if (StartDevice) {
		StartDevice();
		SetChannelCount(512);
	}
	debug = 0;
	return StartDevice ? 0 : -1;
}

void VellemanSend(unsigned char *buf) 
{
	int i;
	if (!StartDevice) return;
	for (i = 0; i < 512; i++) {
		SetData(i+1, buf[i]);	
	}	
}

void VellemanClose()
{
	if (!StartDevice) return;
	StopDevice();
}
