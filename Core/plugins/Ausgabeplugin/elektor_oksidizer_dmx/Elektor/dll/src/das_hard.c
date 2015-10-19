/*
 * Windows interface library for OksiD DMX->USB 
 * 
 *                     Copyright (c) 2005-2006, Jean-Marc Lienher
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
 *     http://www.nicolaudie.com/big/slmini.exe
 *     http://nicolaudie.com/big/sun_2002.exe
 *
 * Changes :
 *	
 *
 */

#include <windows.h>
#include <winbase.h>
#include "resource.h"
#include "okdmx31.h"
#include <stdio.h>
#include <process.h>
#include <string.h>
#include <io.h>
#include <stdlib.h>

typedef int (*DASHARDCOMMAND)(int, int, unsigned char*);

//#define printk(aa) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
#define printk(aa) 
#define DLL_ERR f, "das_hard.c: "

int OkdmxUsbOpen();
void OkdmxUsbSend(unsigned char *buf);
void OkdmxUsbClose();

static unsigned char dabuffer[512];
static int have_okdmxusb = 0;

OKDMX31_API int __stdcall OksidCommand(
	int command, 
	int parameter, 
	unsigned char *buffer)
{
	int e = OKSID_OK;
	int i;
	static int loadded = 0; 
	
	if (!loadded) {	
		loadded = 1;
		have_okdmxusb = !OkdmxUsbOpen();
	}
	switch (command) {
	case 500 + 30:
	case 600 + 30:
	case 700 + 30:
	case 800 + 30:
		e = parameter;
		break;
	case 800 + OKSID_CLOSE:
	case 600 + OKSID_CLOSE:
	case 700 + OKSID_CLOSE:
		e = OKSID_OK;
		break;
	case 500 + OKSID_CLOSE:
	case OKSID_CLOSE:
		e = OKSID_OK;
		break;
	case OKSID_OPEN:
		/* Open the interface */
		e = 2;
		printk ((DLL_ERR "data: %s\r\n", buffer));
		break;
	case OKSID_CONTROLLER2 + OKSID_OPEN:
	case OKSID_CONTROLLER3 + OKSID_OPEN:
		e = 2;
		break;
	case OKSID_CONTROLLER4 + OKSID_OPEN:
		e = 21;
		break;
	case 500 + OKSID_OPEN:
	case 600 + OKSID_OPEN:
	case 700 + OKSID_OPEN:
		e = 254;
		break;
	case 800 + OKSID_OPEN:
		if (parameter == 253) {
			e = 253;
		} else {
			e = -1;
		}
		break;
	case OKSID_DMXOUTOFF:
		for (i = 0; i < 512; i++) dabuffer[i] = 0;
		parameter = 512;
		buffer = dabuffer;
	case 500 + OKSID_DMXOUT:
	case OKSID_DMXOUT:
		/* write the universe */
		e = 512;
		if (parameter >= 512 && buffer) {
			if (have_okdmxusb) {
				OkdmxUsbSend(buffer);
			} 
		}
		break;
	case OKSID_CONTROLLER2 + OKSID_DMXOUTOFF:
		for (i = 0; i < 512; i++) dabuffer[i] = 0;
		parameter = 512;
		buffer = dabuffer;
	case 600 + OKSID_DMXOUT:	
	case OKSID_CONTROLLER2 + OKSID_DMXOUT:
		e = 512;
		if (!parameter >= 512) {	
			e = 512;	
		}
		Sleep(0);
		break;
	case OKSID_CONTROLLER3 + OKSID_DMXOUTOFF:
		for (i = 0; i < 512; i++) dabuffer[i] = 0;
		parameter = 512;
		buffer = dabuffer;
	case 700 + OKSID_DMXOUT:	
	case OKSID_CONTROLLER3 + OKSID_DMXOUT:
		e = 512;
		if (!parameter >= 512) {	
			e = 512;	
		}
		Sleep(0);
		break;
	case 800 + OKSID_DMXIN:
	case OKSID_CONTROLLER4 + OKSID_DMXIN:
		e = 0;
		/* read input universe */
		if (parameter >= 515 && buffer) 
		{
			buffer[0] = 1;
			buffer[1] = 2;
			buffer[2] = 0;
		}
		break;
	}
	printk ((DLL_ERR "%d = My(%d, %d, %p)\r\n", e, command, parameter, buffer));
	return e;
}

OKDMX31_API int DasHardCommand(
	int command, 
	int parameter, 
	unsigned char *buffer)
{
	return OksidCommand(command, parameter, buffer);
}

void CloseDMX()
{
		printk ((DLL_ERR "CLOSE!!!\r\n"));

		/* stop interface */

		if (have_okdmxusb) OkdmxUsbClose();

}

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call) {
	case DLL_PROCESS_ATTACH:
		break;
	case DLL_PROCESS_DETACH:
		CloseDMX();
		break;
	}
	return TRUE;
}