/*
 * Windows interface library for the oksid interface
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
#define DLL_ERR f, "Oksid.c: "

static HANDLE thread = INVALID_HANDLE_VALUE;
static int run = 0;
static unsigned char ValeurDMX[4][512];
static int debug = 1;



/*
 *  main loop
 */
static int __stdcall thread_proc(void *lpParameter)
{
	debug = 1;
 	printk ((DLL_ERR "thread_proc: enter\r\n"));
	debug = 0;
	while (run) {
		Okdmx31Write(OKDMX31_PORT1, OKDMX31_UNIVERSE1, ValeurDMX[0]);
		Okdmx31Write(OKDMX31_PORT1, OKDMX31_UNIVERSE2, ValeurDMX[1]);
		Okdmx31Write(OKDMX31_PORT1, OKDMX31_UNIVERSE3, ValeurDMX[2]);
		Okdmx31Read(OKDMX31_PORT1, OKDMX31_UNIVERSE1, ValeurDMX[3]);
		Sleep(10);
	}
	debug = 1;
 	printk ((DLL_ERR "thread_proc: exit\r\n"));
	debug = 0;
	return 0;
}

int OkdmxOpen()
{
	if (!Okdmx31Read(OKDMX31_PORT1, OKDMX31_UNIVERSE1, ValeurDMX[3])) {
		int i;
		run = 1;
		for (i = 0; i < 512; i++) {
			ValeurDMX[0][i] = 0;
			ValeurDMX[1][i] = 0;
			ValeurDMX[2][i] = 0;
		}
		
		{ 
			int threadid = 0;
			thread = CreateThread(NULL, 0, thread_proc, NULL, 0, &threadid); 
		}	
	}
	return thread != INVALID_HANDLE_VALUE ? 0 : -1;
}

void OkdmxSend1(unsigned char *buf) 
{
	if (thread == INVALID_HANDLE_VALUE) return;
	memcpy(ValeurDMX[0], buf, 512);
}

void OkdmxSend2(unsigned char *buf) 
{
	if (thread == INVALID_HANDLE_VALUE) return;
	memcpy(ValeurDMX[1], buf, 512);
}

void OkdmxSend3(unsigned char *buf) 
{
	if (thread == INVALID_HANDLE_VALUE) return;
	memcpy(ValeurDMX[2], buf, 512);
}

void OkdmxRead1(unsigned char *buf) 
{
	if (thread == INVALID_HANDLE_VALUE) return;
	memcpy(buf, ValeurDMX[3], 512);
}

void OkdmxClose()
{
	if (thread != INVALID_HANDLE_VALUE) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
}
