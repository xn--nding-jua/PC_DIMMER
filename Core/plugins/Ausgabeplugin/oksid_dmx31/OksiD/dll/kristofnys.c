/*
 * Windows interface library for the Kristofnys interface
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
 *     http://users.skynet.be/kristofnys/files/dongle/test64ch.zip
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
#define DLL_ERR f, "kristofnys.c: "

typedef void (__stdcall *TOut)(int, int);
typedef int (__stdcall *TInp)(int);

static TOut Out = 0;
static TInp Inp = 0;
static HANDLE thread = 0;
static int run = 0;
static unsigned char ValeurDMX[512];
static int BaseAddress = 0x378;
static int debug = 0;

static int gettimeofday(struct timeval *tp, void *tzp)
{
	DWORD tx;
	static int init = 0;
	static struct timeval tv;
	static DWORD lt;
	DWORD dt;
	if (!init) {
		SYSTEMTIME st;
		time_t ti;
		struct tm tk;
 
		GetLocalTime (&st);
		lt = timeGetTime();
		tk.tm_sec = st.wSecond;
		tk.tm_min = st.wMinute;
		tk.tm_hour = st.wHour;
		tk.tm_mday = st.wDay;
		tk.tm_mon = st.wMonth - 1;
		tk.tm_year = st.wYear - 1900;
		tk.tm_isdst = -1;
		ti = mktime (&tk);
		tv.tv_sec = ti;
		tv.tv_usec = 0;
		init = 1;
	}
	//timeBeginPeriod(1);
	tx = timeGetTime();
	//timeEndPeriod(1);
	
	dt = tx - lt;
	{
		DWORD t;
		t = dt / 1000;
		tp->tv_sec = tv.tv_sec + t;
		dt -= t * 1000;
	}
	tp->tv_usec = tv.tv_usec + dt * 1000;
	if (tp->tv_usec >= 1000000) {
		tp->tv_usec -= 1000000;
		tp->tv_sec += 1;	
	}	
	return 0;
}

static void usleep(int t)
{
	struct timeval tm, tva;

	gettimeofday(&tm, NULL);
	tm.tv_usec += t;
	if (tm.tv_usec >= 1000000) {
		tm.tv_usec -= 1000000;
		tm.tv_sec++;
	}
	do {
		Sleep(0);
		gettimeofday(&tva, NULL);
	} while (!(tm.tv_sec < tva.tv_sec || (tm.tv_sec == tva.tv_sec && tm.tv_usec <= tva.tv_usec)));
}

/*
 *  main loop
 */
static int __stdcall thread_proc(void *lpParameter)
{
	int i;
	debug = 1;
 	printk ((DLL_ERR "thread_proc: enter\r\n"));
	debug = 0;
	while (run) { 
		Out(BaseAddress + 2, 1);
		Sleep(29);
		Out(BaseAddress + 2, 3);
		Sleep(1);
		for (i = 0; i < 65; i++) { // 64 + 1 dummy
			Out(BaseAddress, ValeurDMX[i]);	
			Out(BaseAddress + 2, 2);
			usleep(100);
			Out(BaseAddress + 2, 3);
			usleep(100);
			
		}	 		
		
	}
	debug = 1;
 	printk ((DLL_ERR "thread_proc: exit\r\n"));
	debug = 0;
	return 0;
}

int KristofnysOpen()
{

	debug = 1;
	if (!Inp && !access("Kristofnys.dll", 0)) {
		HINSTANCE lib;
		lib = LoadLibrary("Kristofnys.dll");
		if (lib) {
			Inp = (TInp) GetProcAddress((HMODULE)lib, "Inp32");
			Out = (TOut) GetProcAddress((HMODULE)lib, "Out32");
		 	printk ((DLL_ERR "KristofnysOpen: %p %p Inpout32.dll loadded\r\n", Inp, Out));

		}
	}
	if (Inp) {
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
	return Inp ? 0 : -1;
}

void KristofnysSend(unsigned char *buf) 
{
	if (!Inp) return;
	memcpy(ValeurDMX, buf, 512);
}

void KristofnysClose()
{
	if (!Inp) return;
	if (thread) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
}
