/*
 * Windows interface library for the Monacor interface
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
#define DLL_ERR f, "monacor.c: "

typedef int (__stdcall *TGetMaxChannels)(void);
typedef char (__stdcall *TOutDMX)(unsigned char, unsigned char);
typedef char *(__stdcall *TGetDMXInterface)(void);

static TGetMaxChannels GetMaxChannels = 0;
static TOutDMX OutDMX = 0;
static TGetDMXInterface GetDMXInterface = 0;
static HANDLE thread = 0;
static int run = 0;
static unsigned char ValeurDMX[512];
static int MaxChannels = 120;
static int debug = 0;



/*
 *  main loop
 */
static int __stdcall thread_proc(void *lpParameter)
{
	debug = 1;
 	printk ((DLL_ERR "thread_proc: enter\r\n"));
	debug = 0;
	while (run) {
		unsigned char i; 
		for (i = 0; i < MaxChannels; i++) {
			OutDMX(i, ValeurDMX[(int)i]);
		}	
		Sleep(30);
	}
	debug = 1;
 	printk ((DLL_ERR "thread_proc: exit\r\n"));
	debug = 0;
	return 0;
}

int MonacorOpen()
{
	HINSTANCE lib = 0;
	debug = 1;
	if (!OutDMX && !access("DMX120.dll", 0)) {
		lib = LoadLibrary("DMX120.dll");
		MaxChannels = 120;
	} else if (!OutDMX && !access("DMX60.dll", 0)) {
		lib = LoadLibrary("DMX60.dll");
		MaxChannels = 64;
	}
	{
		if (lib) {
			OutDMX = (TOutDMX) GetProcAddress((HMODULE)lib, "OutDMX");
			GetMaxChannels = (TGetMaxChannels) GetProcAddress((HMODULE)lib, "GetMaxChannels");
			GetDMXInterface = (TGetDMXInterface) GetProcAddress((HMODULE)lib, "GetDMXInterface");
		 	printk ((DLL_ERR "MonacorOpen: DMX120.dll loadded\r\n"));

		}
	}
	if (OutDMX) {
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
	return OutDMX ? 0 : -1;
}

void MonacorSend(unsigned char *buf) 
{
	if (!OutDMX) return;
	memcpy(ValeurDMX, buf, 512);
}

void MonacorClose()
{
	if (!OutDMX) return;
	if (thread) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
}
