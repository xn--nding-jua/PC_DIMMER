/*
 * Windows interface library for the OksidmxUsb interface
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
#include <setupapi.h>
#include <basetyps.h>
#include <initguid.h>


DEFINE_GUID(GUID_CLASS_OKSID_GEN_INT, 
0x93fe956f, 0x8cdd, 0x4f10, 0x86, 0x3c, 0x95, 0x9d, 0x41, 0xb8, 0xbb, 0xda);

#define printk(aa) if (debug) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
//#define printk(aa) 
#define DLL_ERR f, "OkdmxUsbIn.c: "

typedef struct _USB_DEVICE_DESCRIPTOR {
  UCHAR  bLength ;
  UCHAR  bDescriptorType ;
  USHORT  bcdUSB ;
  UCHAR  bDeviceClass ;
  UCHAR  bDeviceSubClass ;
  UCHAR  bDeviceProtocol ;
  UCHAR  bMaxPacketSize0 ;
  USHORT  idVendor ;
  USHORT  idProduct ;
  USHORT  bcdDevice ;
  UCHAR  iManufacturer ;
  UCHAR  iProduct ;
  UCHAR  iSerialNumber ;
  UCHAR  bNumConfigurations ;
} USB_DEVICE_DESCRIPTOR, *PUSB_DEVICE_DESCRIPTOR ;

static HANDLE thread = INVALID_HANDLE_VALUE;
static int run = 0;
static unsigned char DMXBuffer[592];
static int debug = 1;
static HANDLE io = INVALID_HANDLE_VALUE;
static char DeviceName[256] = "";

static HANDLE OpenOneDevice (HDEVINFO HardwareDeviceInfo,
	PSP_INTERFACE_DEVICE_DATA DeviceInfoData,
	char *devName)
{
	PSP_INTERFACE_DEVICE_DETAIL_DATA functionClassDeviceData = NULL;
	ULONG predictedLength = 0;
	ULONG requiredLength = 0;
	HANDLE hOut = INVALID_HANDLE_VALUE;

    //
    // allocate a function class device data structure to receive the
    // goods about this particular device.
    //
	SetupDiGetInterfaceDeviceDetail (
            HardwareDeviceInfo,
            DeviceInfoData,
            NULL, // probing so no output buffer yet
            0, // probing so output buffer length of zero
            &requiredLength,
            NULL); // not interested in the specific dev-node


	predictedLength = requiredLength;
  

	functionClassDeviceData = (PSP_INTERFACE_DEVICE_DETAIL_DATA) malloc (predictedLength);
	functionClassDeviceData->cbSize = sizeof (SP_INTERFACE_DEVICE_DETAIL_DATA);

    //
    // Retrieve the information from Plug and Play.
    //
	if (! SetupDiGetInterfaceDeviceDetail (
               HardwareDeviceInfo,
               DeviceInfoData,
               functionClassDeviceData,
               predictedLength,
               &requiredLength,
               NULL)) 
	{
		free( functionClassDeviceData );
		return INVALID_HANDLE_VALUE;
	}

	strcpy( devName,functionClassDeviceData->DevicePath) ;
	printk(( DLL_ERR "Attempting to open %s\n", devName ));

	hOut = CreateFile (
                  functionClassDeviceData->DevicePath,
                  GENERIC_READ | GENERIC_WRITE,
                  FILE_SHARE_READ | FILE_SHARE_WRITE,
                  NULL, // no SECURITY_ATTRIBUTES structure
                  OPEN_EXISTING, // No special create flags
                  0, // No special attributes
                  NULL); // No template file

	if (INVALID_HANDLE_VALUE == hOut) {
		printk((DLL_ERR "FAILED to open %s\n", devName ));
	}
	free( functionClassDeviceData );
	return hOut;
}


static HANDLE OpenUsbDevice(LPGUID pGuid, char *outNameBuf)
{
	ULONG NumberDevices;
	HANDLE hOut = INVALID_HANDLE_VALUE;
	HDEVINFO                 hardwareDeviceInfo;
	SP_INTERFACE_DEVICE_DATA deviceInfoData;
	ULONG                    i;
	BOOLEAN                  done;
	PUSB_DEVICE_DESCRIPTOR   usbDeviceInst;
	PUSB_DEVICE_DESCRIPTOR	*UsbDevices = &usbDeviceInst;

	*UsbDevices = NULL;
	NumberDevices = 0;

   //
   // Open a handle to the plug and play dev node.
   // SetupDiGetClassDevs() returns a device information set that contains info on all 
   // installed devices of a specified class.
   //
	hardwareDeviceInfo = SetupDiGetClassDevs (
                           pGuid,
                           NULL, // Define no enumerator (global)
                           NULL, // Define no
                           (DIGCF_PRESENT | // Only Devices present
                            DIGCF_INTERFACEDEVICE)); // Function class devices.

   //
   // Take a wild guess at the number of devices we have;
   // Be prepared to realloc and retry if there are more than we guessed
   //
	NumberDevices = 4;
	done = FALSE;
	deviceInfoData.cbSize = sizeof (SP_INTERFACE_DEVICE_DATA);

	i=0;
	while (!done) {
		NumberDevices *= 2;

		if (*UsbDevices) {
			*UsbDevices = (PUSB_DEVICE_DESCRIPTOR) realloc (*UsbDevices, 
				(NumberDevices * sizeof (USB_DEVICE_DESCRIPTOR)));
		} else {
			*UsbDevices = (PUSB_DEVICE_DESCRIPTOR) malloc (
				NumberDevices * sizeof (USB_DEVICE_DESCRIPTOR));
		}

		usbDeviceInst = *UsbDevices + i;

		for (; i < NumberDevices; i++) {

         // SetupDiEnumDeviceInterfaces() returns information about device interfaces 
         // exposed by one or more devices. Each call returns information about one interface;
         // the routine can be called repeatedly to get information about several interfaces
         // exposed by one or more devices.

			if (SetupDiEnumDeviceInterfaces (hardwareDeviceInfo,
                                        0, // We don't care about specific PDOs
					pGuid,
                                        i,
                                        &deviceInfoData)) 
			{

				hOut = OpenOneDevice (hardwareDeviceInfo, 
					&deviceInfoData, outNameBuf);
				if ( hOut != INVALID_HANDLE_VALUE ) {
					done = TRUE;
					break;
				}
			} else {
				if (ERROR_NO_MORE_ITEMS == GetLastError()) {
					done = TRUE;
					break;
				}
			}
		}
	}

	NumberDevices = i;

   // SetupDiDestroyDeviceInfoList() destroys a device information set 
   // and frees all associated memory.

	SetupDiDestroyDeviceInfoList (hardwareDeviceInfo);
	free ( *UsbDevices );
	return hOut;
}


static HANDLE OkdmxUsbOpenPipe(char *name)
{
	HANDLE h = INVALID_HANDLE_VALUE;

	h =  OpenUsbDevice( (LPGUID) &GUID_CLASS_OKSID_GEN_INT, DeviceName );
	if (h !=  INVALID_HANDLE_VALUE){
		CloseHandle(h);
		h = INVALID_HANDLE_VALUE;
	} else {
		printk((DLL_ERR "Failed to GetUsbDeviceFileName\n", GetLastError()));
		return  INVALID_HANDLE_VALUE; 
	}
	strcat (DeviceName, "\\");			
	strcat (DeviceName, name);
	h = CreateFile(DeviceName,
		GENERIC_WRITE | GENERIC_READ,
		FILE_SHARE_WRITE | FILE_SHARE_READ,
		NULL,
		OPEN_EXISTING,
		FILE_FLAG_OVERLAPPED,
		NULL);	
	return h;
}


/*
 *  OkdmxUsb main loop
 */
static DWORD WINAPI thread_proc(LPVOID lpParameter)
{	
	int i;
	unsigned char buf[592];
	for (i = 0; i < 592; i++) buf[i] = 0;
	do {
		
		for (i = 0; i < 592 && run; i += 592) {
			OVERLAPPED gOverLapped;
			int s;
			int nbw = 0;
			gOverLapped.Offset     = 0; 
			gOverLapped.OffsetHigh = 0; 
			gOverLapped.hEvent     = CreateEvent(NULL, TRUE, FALSE, NULL);
			s = ReadFile(io, buf + i, 592, &nbw, &gOverLapped);
			if (!s  && GetLastError() == ERROR_IO_PENDING) {
				if (WaitForSingleObject(
					gOverLapped.hEvent, 1000) ==
					WAIT_TIMEOUT) 
				{
					printk((DLL_ERR "Cancel read !\n"));
					CancelIo(io);
				}
				GetOverlappedResult(io, &gOverLapped, &nbw, FALSE);
			}
			printk((DLL_ERR "read (%d) %d data=%d id=%d\n", i, nbw, buf[i+1], buf[i]));
		}
		for (i=0; i < 592; i += 8) {
			printk((DLL_ERR "GOT pid=%d\n", buf[i]));
			if (buf[i] < 73) {
				int n;
				n = buf[i] * 7;
				DMXBuffer[n++] = buf[i + 1];
				DMXBuffer[n++] = buf[i + 2];
				DMXBuffer[n++] = buf[i + 3];
				DMXBuffer[n++] = buf[i + 4];
				DMXBuffer[n++] = buf[i + 5];
				DMXBuffer[n++] = buf[i + 6];
				DMXBuffer[n++] = buf[i + 7];
			} else if (buf[i] == 73) {
				DMXBuffer[511] = buf[i + 1];
			}
		}
	} while (run);

	CloseHandle(io);
	thread = INVALID_HANDLE_VALUE;
	return 0;
}

int OkdmxUsbInOpen()
{
	int i;
	int j;
	
	for (i = 0, j = 0; i < 512; i++) {
		if (!(i % 7)) {
			DMXBuffer[j + i] = j;
			j++;
		}
		DMXBuffer[j + i] = 0;
	}

	io = OkdmxUsbOpenPipe("PIPE01");
	
	printk((DLL_ERR "open pinp %p\n", io));

	if (io != INVALID_HANDLE_VALUE) {
		int threadid = 0;
		run = 1;
		thread = CreateThread(NULL, 0, thread_proc, NULL, 0, &threadid); 
	}
	
	return thread != INVALID_HANDLE_VALUE ? 0 : -1;
}

void OkdmxUsbInRead(unsigned char *buf) 
{
	int i;
	int j;
	if (thread == INVALID_HANDLE_VALUE) return;
	memcpy(buf, DMXBuffer, 512);
	//printk((DLL_ERR "OkdmxUsbInRead %d\n", buf[0]));
}

void OkdmxUsbInClose()
{
	if (thread != INVALID_HANDLE_VALUE) {
		run = 0;
		WaitForSingleObjectEx(thread, 1000, FALSE);
		thread = 0;	
	}
	return;
}
