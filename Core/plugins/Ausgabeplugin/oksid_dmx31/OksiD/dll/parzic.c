/*
 * Windows interface library for the PARZIC interface
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
 *     http://www.prozic.com/dmx/commande%20interface.php
 *     http://www.prozic.com/dmx/ProZic%20DMX%20Setup.exe
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
#define DLL_ERR f, "parzic.c: "

typedef void (__stdcall *TOut)(int, int);
typedef int (__stdcall *TInp)(int);

static TOut Out = 0;
static TInp Inp = 0;
static HANDLE thread = 0;
static int run = 0;
static int comptetrame = 0;
static int n = 511;
static unsigned char ValeurDMX[512];
static int BaseAddress = 0x378;
static int debug = 0;

static int envoibyte(unsigned char valeur)
{
	int a;
	int timecount;

	timecount = 0;
	a = 0;

	Sleep(0);

	while (a == 0) {
		a = Inp(BaseAddress + 1) & 0x40;
		timecount++;
		if (timecount == 100) {
			a = 0x40;
			timecount = 0;
			printk ((DLL_ERR "envoibyte: -2\r\n"));
			//return -2;
		}
	}

	Out(BaseAddress, valeur);
	
	Out(BaseAddress + 2, 0x14);

	timecount = 0;
	a = 0x40;
	while (a == 0x40) {
		a = Inp(BaseAddress + 1) & 0x40;
		timecount++;
		if (timecount == 100) {
			a = 0;
			timecount = 0;
			printk ((DLL_ERR "envoibyte: -3\r\n"));
			//return -3;
		}
	}


	timecount = 0;
	a = 0;
	while (a == 0) {
		a = Inp(BaseAddress + 1) & 0x80;
		timecount++;
		if (timecount == 100) {
			a = 0x80;
			timecount = 0;
			printk ((DLL_ERR "envoibyte: -4\r\n"));
			//return -4;
		}
	}

	Out(BaseAddress + 2, 0x15);

	a = 0x80;
	timecount = 0;
	while ( a == 0x80) {
		a = Inp(BaseAddress + 1) & 0x80;
		timecount++;
		if (timecount == 100) {
			a = 0x0;
			timecount = 0;
			printk ((DLL_ERR "envoibyte: -5\r\n"));
			//return -5;
		}
	} 	
	return 0;
}

static int envoitrame()
{
	int timecount;
	int a;
	int canal = 0;
	int err;
	int tx;

	tx = timeGetTime();

	Out(BaseAddress + 2, 0x14);
	canal = n;
	if (n > 255) {
		Out(BaseAddress, 0x1);
		canal = n - 256;
	} else {
		Out(BaseAddress, 0x0);
	}
	Out(BaseAddress + 2, 0x15);
	timecount = 0;
	a = 0x80;
	while (a == 0x80) {
		a = Inp(BaseAddress + 1) & 0x80;
		timecount++;
		if (timecount == 100) {
			a = 0;
			timecount = 0;
			printk ((DLL_ERR "envoitrame: -1\r\n"));
			//return -1;
		}
	}
	err = envoibyte ((unsigned char)canal);
	if (err) {
		printk ((DLL_ERR "envoitrame: %d CANAL (%d)\r\n", err, canal));
		return err;
	}
	err = envoibyte (0);
	if (err) {
		printk ((DLL_ERR "envoitrame: %d STARTCODE 0\r\n", err));
		return err;
	}
	
	for (canal = 0; canal < n; canal++) {
		err = envoibyte(ValeurDMX[canal]);
		if ((canal % 32) == 0) Sleep(0);
		if (err) {
			printk ((DLL_ERR "envoitrame: %d (canal %d, value %d)\r\n", err, canal, ValeurDMX[canal]));
			return err;
		}
	}
	printk ((DLL_ERR "TX: %d\r\n",  timeGetTime() - tx));
	return 0;
}

static int init()
{
	comptetrame++;
	if (comptetrame > 32000) comptetrame = 0;
	Out(BaseAddress + 2, 0x10);
	return envoitrame();
}

/*
 *  main loop
 */
static int __stdcall thread_proc(void *lpParameter)
{
	int err;
	debug = 1;
 	printk ((DLL_ERR "thread_proc: enter\r\n"));
	debug = 0;
	while (run) {
		debug = 1;
		err = init();
		if (err) {
			debug = 1;
			printk ((DLL_ERR "thread_proc: %d (comptetrame %d)\r\n", err, comptetrame));	
			debug = 0;
		}
		Sleep(10);
	}
	debug = 1;
 	printk ((DLL_ERR "thread_proc: exit\r\n"));
	debug = 0;
	return 0;
}

int ParzicOpen()
{

	debug = 1;
	if (!Inp && !access("Inpout32.dll", 0)) {
		HINSTANCE lib;
		lib = LoadLibrary("Inpout32.dll");
		if (lib) {
			Inp = (TInp) GetProcAddress((HMODULE)lib, "Inp32");
			Out = (TOut) GetProcAddress((HMODULE)lib, "Out32");
		 	printk ((DLL_ERR "ParzicOpen: %p %p Inpout32.dll loadded\r\n", Inp, Out));

		}
	}
	if (Inp) {
		int i;
		run = 1;
		for (i = 0; i < 512; i++) {
			ValeurDMX[i] = 0;
		}
		
		if (!init()) { 
			int threadid = 0;
			thread = CreateThread(NULL, 0, thread_proc, NULL, 0, &threadid); 
		} else {
			Inp = 0;
			Out = 0;
		 	printk ((DLL_ERR "ParzicOpen: Interface not found\r\n"));
		}	
	}
	debug = 0;
	return Inp ? 0 : -1;
}

void ParzicSend(unsigned char *buf) 
{
	if (!Inp) return;
	memcpy(ValeurDMX, buf, 512);
}

void ParzicClose()
{
	if (!Inp) return;
	if (thread) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
}
