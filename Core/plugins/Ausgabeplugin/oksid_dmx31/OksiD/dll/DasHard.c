/*
 * Windows interface library for OksiD DMX 3/1, Velleman and OpenDMX interfaces
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
 *     http://www.nicolaudie.com/big/slmini.exe
 *     http://nicolaudie.com/big/sun_2002.exe
 *
 * Changes :
 *	
 *
 */

#include <windows.h>
#include <winbase.h>
#include "okdmx31.h"
#include "resource.h"
#include <stdio.h>
#include <process.h>
#include <string.h>
#include <io.h>
#include <stdlib.h>

typedef int (*DASHARDCOMMAND)(int, int, unsigned char*);

#define printk(aa) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
//#define printk(aa) 
#define DLL_ERR f, "DasHard.c: "

/*
 *  Emulation of Sunlite's hardware interface
 */
OKDMX31_API int DasHardCommand(
	int command, 
	int parameter, 
	unsigned char *buffer)
{
	static int loadded = 0; 
	int e = 0;
	static DASHARDCOMMAND DasHardCommand_ = NULL;
	if (!loadded) {
		HINSTANCE lib;
		
		loadded = 1;

		/* Load and use the original Sunlite's functions */
		lib = LoadLibrary("DasHard_.dll");
		if (lib) DasHardCommand_ = (DASHARDCOMMAND) GetProcAddress((HMODULE)lib, "DasHardCommand");
	}

	if (DasHardCommand_) {
		if (buffer) {
			printk ((DLL_ERR "buffer before %c%c%c%c%c%c%c%c\r\n", buffer[0], buffer[1], buffer[2], buffer[3], buffer[4], buffer[5], buffer[6], buffer[7]));
		}
		e = DasHardCommand_(command, parameter, buffer);
		printk ((DLL_ERR "%d = DasHardCommand(%d, %d, %p) @ %d\r\n", e, command, parameter, buffer, timeGetTime()));
		if (buffer) {
			printk ((DLL_ERR "buffer after %c%c%c%c%c%c%c%c\r\n", buffer[0], buffer[1], buffer[2], buffer[3], buffer[4], buffer[5], buffer[6], buffer[7]));
		}

	}


	return e;
}

