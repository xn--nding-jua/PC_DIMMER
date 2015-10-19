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

int ParzicOpen();
void ParzicSend(unsigned char *buf);
void ParzicClose();

int KristofnysOpen();
void KristofnysSend(unsigned char *buf);
void KristofnysClose();

int ManolatorOpen();
void ManolatorSend(unsigned char *buf);
void ManolatorClose();

int MonacorOpen();
void MonacorSend(unsigned char *buf);
void MonacorClose();

int DMX4allOpen();
void DMX4allSend(unsigned char *buf);
void DMX4allClose();

int VellemanOpen();
void VellemanSend(unsigned char *buf);
void VellemanClose();

int OpenDmxOpen();
void OpenDmxSend(unsigned char *buf);
void OpenDmxClose();

int OkdmxUsbOpen();
void OkdmxUsbSend(unsigned char *buf);
void OkdmxUsbClose();

int OkdmxUsbInOpen();
void OkdmxUsbInRead(unsigned char *buf);
void OkdmxUsbInClose();

int OkdmxOpen();
void OkdmxSend1(unsigned char *buf);
void OkdmxSend2(unsigned char *buf);
void OkdmxSend3(unsigned char *buf);
void OkdmxRead1(unsigned char *buf);
void OkdmxClose();

int DasOpen();
void DasSend(unsigned char *buf);
void DasClose();

static unsigned char dabuffer[512];
static int have_parzic = 0;
static int have_kristofnys = 0;
static int have_manolator = 0;
static int have_monacor = 0;
static int have_velleman = 0;
static int have_opendmx = 0;
static int have_dmx4all = 0;
static int have_okdmxusb = 0;
static int have_okdmxusbin = 0;
static int have_okdmx = 0;
static int have_das = 0;

/*
 *  Emulation of Sunlite's hardware interface
 */
OKDMX31_API int __stdcall OksidCommand(
	int command, 
	int parameter, 
	unsigned char *buffer)
{
	int e = OKSID_OK;
	int i;
	static int loadded = 0; 
	static DASHARDCOMMAND DasHardCommand_ = NULL;
	
	if (!loadded) {
		HINSTANCE lib;		
		loadded = 1;

		have_parzic = !ParzicOpen();
		have_kristofnys = !KristofnysOpen();
		have_manolator = !ManolatorOpen();
		have_monacor = !MonacorOpen();
		have_velleman = !VellemanOpen();
		have_opendmx = !OpenDmxOpen();
		have_dmx4all = !DMX4allOpen();
		//have_okdmxusbin = !OkdmxUsbInOpen();
		if (!have_okdmxusbin) have_okdmxusb = !OkdmxUsbOpen();
		have_okdmx = !OkdmxOpen();	
		have_das = !DasOpen();	

	}

	if (DasHardCommand_) {
		e = DasHardCommand_(command, parameter, buffer);
		printk ((DLL_ERR "%d = DasHardCommand(%d, %d, %p)\r\n", e, command, parameter, buffer));
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
			if (have_parzic) {
				ParzicSend(buffer);
			} else if (have_okdmxusb) {
				OkdmxUsbSend(buffer);
			} else if (have_das) {
				DasSend(buffer);
			} else if (have_okdmx) {
				OkdmxSend1(buffer);
			} else if (have_kristofnys) {
				KristofnysSend(buffer);
			} else if (have_manolator) {
				ManolatorSend(buffer);
			} else if (have_monacor) {
				MonacorSend(buffer);
			} else if (have_opendmx) {
				OpenDmxSend(buffer);
			} else if (have_velleman) {
				VellemanSend(buffer);
			} else if (have_dmx4all) {
				DMX4allSend(buffer);
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
			if (have_okdmx)	OkdmxSend2(buffer);
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
			if (have_okdmx)	OkdmxSend3(buffer);
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
			if (have_okdmx) OkdmxRead1(buffer + 3);
			if (have_okdmxusbin) OkdmxUsbInRead(buffer + 3);
			buffer[0] = 1;
			buffer[1] = 2;
			buffer[2] = 0;
		}
		break;
	}
	printk ((DLL_ERR "%d = My(%d, %d, %p)\r\n", e, command, parameter, buffer));
	return e;
}

void CloseDMX()
{
		printk ((DLL_ERR "CLOSE!!!\r\n"));

		/* stop interface */
		if (have_velleman) VellemanClose();

		if (have_parzic) ParzicClose();

		if (have_kristofnys) KristofnysClose();

		if (have_manolator) ManolatorClose();

		if (have_monacor) MonacorClose();

		if (have_dmx4all) DMX4allClose();
		
		if (have_opendmx) OpenDmxClose();

		if (have_okdmxusbin) OkdmxUsbInClose();

		if (have_okdmxusb) OkdmxUsbClose();

		if (have_okdmx) OkdmxClose();

		if (have_das) DasClose();
}

