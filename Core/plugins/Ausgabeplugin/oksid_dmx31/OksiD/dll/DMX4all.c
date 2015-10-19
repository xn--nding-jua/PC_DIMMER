/*
 * Windows interface library for the DMX4all interface
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

//#define printk(aa) if (debug) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
#define printk(aa) 
#define DLL_ERR f, "DMX4all.c: "

static unsigned char ValeurDMX[512];
static unsigned char LDMX[512];
static int debug = 1;
static HANDLE hCom = 0;
static int run = 0;
static HANDLE thread = 0;

static void Send(int c, unsigned char d)
{
	char b[20];
	DWORD nb;
	_snprintf(b, 19, "C%03dL%03d", c ,d);
	printk ((DLL_ERR "Send: %s\n", b));
	WriteFile(hCom, b, 8, &nb, NULL); 
	
}

static int OpenPort(char *pcCommPort)
{
   DCB dcb;
   BOOL fSuccess;

   hCom = CreateFile( pcCommPort,
                    GENERIC_READ | GENERIC_WRITE,
                    0,    // must be opened with exclusive-access
                    NULL, // no security attributes
                    OPEN_EXISTING, // must use OPEN_EXISTING
                    0,    // not overlapped I/O
                    NULL  // hTemplate must be NULL for comm devices
                    );

   if (hCom == INVALID_HANDLE_VALUE) 
   {
       // Handle the error.
       printk ((DLL_ERR "CreateFile failed with error %d.\n", GetLastError()));
       return (1);
   }

   // Build on the current configuration, and skip setting the size
   // of the input and output buffers with SetupComm.

   fSuccess = GetCommState(hCom, &dcb);

   if (!fSuccess) 
   {
      // Handle the error.
      printk ((DLL_ERR "GetCommState failed with error %d.\n", GetLastError()));
      return (2);
   }

   // Fill in DCB: 38400 bps, 8 data bits, no parity, and 1 stop bit.

   dcb.BaudRate = CBR_38400;     // set the baud rate
   dcb.ByteSize = 8;             // data size, xmit, and rcv
   dcb.Parity = NOPARITY;        // no parity bit
   dcb.StopBits = ONESTOPBIT;    // one stop bit

   fSuccess = SetCommState(hCom, &dcb);

   if (!fSuccess) 
   {
      // Handle the error.
      printk ((DLL_ERR "SetCommState failed with error %d.\n", GetLastError()));
      return (3);
   }

   return 0;
}

/*
 *  main loop
 */
static int __stdcall thread_proc(void *lpParameter)
{
	int nb;
	
 	printk ((DLL_ERR "thread_proc: enter\r\n"));

	WriteFile(hCom, "N511S2", 6, &nb, NULL); 

	printk ((DLL_ERR "write n go\r\n"));

	while (run) {
		unsigned char i; 
		for (i = 0; i < 512; i++) {			
			unsigned char v = ValeurDMX[i];
			if (v != LDMX[i]) {
				Send(i, v);
				LDMX[i] = v;
			}
		}
		Sleep(20);
	}
	CloseHandle(hCom);
	hCom = 0;

 	printk ((DLL_ERR "thread_proc: exit\r\n"));
	
	return 0;
}

int DMX4allOpen()
{
	
	if (!hCom && !access("dmx4all.com1", 0)) {
		OpenPort("COM1");	
	} else if (!hCom && !access("dmx4all.com2", 0)) {
		OpenPort("COM2");
	} else if (!hCom && !access("dmx4all.com3", 0)) {
		OpenPort("COM3");
	}

	if (hCom) {
		int i;
		run = 1;
		for (i = 0; i < 512; i++) {
			ValeurDMX[i] = LDMX[i] = 0;
		}
		{ 
			int threadid = 0;
			thread = CreateThread(NULL, 0, thread_proc, NULL, 0, &threadid); 
		}	
	}
	
	return hCom ? 0 : -1;
}

void DMX4allSend(unsigned char *buf) 
{
	if (!run) return;
	memcpy(ValeurDMX, buf, 512);
}

void DMX4allClose()
{
	if (!run) return;
	if (thread) {
		run = 0;
		WaitForSingleObjectEx(thread, 3000, FALSE);
		thread = 0;	
	}
}
