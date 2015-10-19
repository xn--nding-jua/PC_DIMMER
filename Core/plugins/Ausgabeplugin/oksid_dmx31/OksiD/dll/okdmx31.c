/*
 * Windows interface library for OksiD DMX 3/1 interface
 * 
 *                     Copyright (c) 2003, O'ksi'D
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
 *     http://www.logix4u.cjb.net/ (driver installation and starting)
 *
 * Changes :
 *	9.5.2004 : fixed bug in Okdmx31Read(), problem with caching.
 *
 */

#include "windows.h"
#include "okdmx31.h"
#include "resource.h"

extern int okddmx_rw_block(PUCHAR port, UCHAR chip, PUCHAR in, PUCHAR out);
extern int okddmx_get_status(PUCHAR port, UCHAR chip, PUCHAR status);
extern int okddmx_set_current_block(PUCHAR port, UCHAR chip, UCHAR block);
extern void CloseDMX();

#define IOCTL_WRITE_DMX ((32768 << 16) | (2048 << 2))
#define IOCTL_READ_DMX ((32768 << 16) | (2049 << 2))
#define IOCTL_GET_STATUS_DMX ((32768 << 16) | (2050 << 2))

typedef struct _DMX_IO_DATA {
	PUCHAR port;
	UCHAR universe;
	UCHAR block;
	UCHAR data[32];
} DMX_IO_DATA, *PDMX_IO_DATA;

typedef int (*dmx_io_func)(PDMX_IO_DATA);

static unsigned int porti1 = 0;
static unsigned int porti2 = 0;
static unsigned int last_porti = 0;
static unsigned int porto1 = 0;
static unsigned int porto2 = 0;
static unsigned int last_porto = 0;
static DMX_IO_DATA dmxo1[3][16];
static DMX_IO_DATA dmxo2[3][16];
static PDMX_IO_DATA dmxo = NULL;
static DMX_IO_DATA dmxi1[16];
static DMX_IO_DATA dmxi2[16];
static DMX_IO_DATA *dmxi = NULL;
static HANDLE hdriver = INVALID_HANDLE_VALUE;
static HINSTANCE hmodule = NULL;
static DWORD platform = VER_PLATFORM_WIN32_WINDOWS;

static int dmx_write_95(PDMX_IO_DATA buf);
static int dmx_write_nt(PDMX_IO_DATA buf);
static int dmx_read_95(PDMX_IO_DATA buf);
static int dmx_read_nt(PDMX_IO_DATA buf);
static int dmx_status_95(PDMX_IO_DATA buf);
static int dmx_status_nt(PDMX_IO_DATA buf);

static dmx_io_func dmx_write = dmx_write_95;
static dmx_io_func dmx_read = dmx_read_95;
static dmx_io_func dmx_status = dmx_status_95;

static int start_driver(void);
static void install_driver(void);

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{

	OSVERSIONINFO o;

	o.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);

	GetVersionEx(&o);

	platform = o.dwPlatformId;
	hmodule = hModule;

	switch (ul_reason_for_call) {
	case DLL_PROCESS_ATTACH:
		if (platform == VER_PLATFORM_WIN32_NT) {
			dmx_write = dmx_write_nt;
			dmx_read = dmx_read_nt;	
			dmx_status = dmx_status_nt;

			hdriver = CreateFile(
				"\\\\.\\OkDmx31", 
				GENERIC_READ | GENERIC_WRITE, 
				0, 
				NULL,
				OPEN_EXISTING, 
				FILE_ATTRIBUTE_NORMAL, 
				NULL);
			
			if (hdriver == INVALID_HANDLE_VALUE) {
				if (start_driver()) {
					install_driver();
					start_driver();
				}

				hdriver = CreateFile(
					"\\\\.\\OkDmx31", 
					GENERIC_READ | GENERIC_WRITE, 
					0, 
					NULL,
					OPEN_EXISTING, 
					FILE_ATTRIBUTE_NORMAL, 
					NULL);
			}
		}

		break;

	case DLL_PROCESS_DETACH:
		if (platform == VER_PLATFORM_WIN32_NT) {
			CloseHandle(hdriver);
			hdriver = INVALID_HANDLE_VALUE;
		}
		CloseDMX();
		break;
	}

	return TRUE;
}



OKDMX31_API int __stdcall Okdmx31Read(
	unsigned int port, 
	unsigned char universe, 
	unsigned char *bytes_512_buffer)
{
	DMX_IO_DATA buf;
	unsigned int change;
	int i;


	
	buf.port = (PUCHAR)port;
	buf.universe = universe;

	if (port < 0x278) return -1;
	if (universe != 0) return -2;
	if (!bytes_512_buffer) return -3;	

	i = dmx_status(&buf);
	if (i) return i;

	change = buf.data[0] | (buf.data[1] << 8);

	if (port == porti1) {
		dmxi = dmxi1;
	} else if (port == porti2) {
		dmxi = dmxi2;
	} else if (porti1 == last_porti) {
		porti2 = port;
		dmxi = dmxi2;
		change = 0xFFFF;
	} else {
		porti1 = port;
		dmxi = dmxi1;
		change = 0xFFFF;
	}
	
	last_porti = port;

	for (i = 0; i < 16; i++) {		
		int ii;
		int max;
		unsigned char *data;
		data = dmxi[i].data;

		if (change & (0x1 << i)) {

			dmxi[i].block = i;
			dmxi[i].port = (PUCHAR)port;
			dmxi[i].universe = universe;

			if (dmx_read(dmxi + i)) return -5;
		}
								
		max = (i + 1) * 32;
		for (ii = i * 32; ii < max; ii++) {
			bytes_512_buffer[ii] = *(data++);
		}
	}

	return 0;
}

OKDMX31_API int __stdcall Okdmx31Write(
	unsigned int port, 
	unsigned char universe, 
	const unsigned char *bytes_512_buffer)
{
	unsigned int change = 0;
	int i;

	if (port < 0x278) return -1;
	if (universe > 2) return -2;
	if (!bytes_512_buffer) return -3;	

	if (port == porto1) {
		dmxo = dmxo1[universe];
	} else if (port == porto2) {
		dmxo = dmxo2[universe];
	} else if (porto1 == last_porto) {
		porto2 = port;
		dmxo = dmxo2[universe];
		change = 0xFFFF;
	} else {
		porto1 = port;
		dmxo = dmxo1[universe];
		change = 0xFFFF;
	}
	
	last_porto = port;

	for (i = 0; i < 16; i++) {
		int ii;
		int max;
		unsigned char *data;
		int diff = 0;

		max = (i + 1) * 32;
		
		data = dmxo[i].data;

		for (ii = i * 32; ii < max; ii++) {
			if (*(data) != bytes_512_buffer[ii]) {
				diff = 1;
				*(data) = bytes_512_buffer[ii];
			}
			data++;
		}
		
		if (diff) {
			change |= (0x1 << i);
		}
	}

	for (i = 0; i < 16; i++) {
		if (change & (0x1 << i)) {
			dmxo[i].block = i;
			dmxo[i].port = (PUCHAR)port;
			dmxo[i].universe = universe;

			if (dmx_write(dmxo + i)) return -4;
		}
	}

	return 0;
}


int dmx_write_95(PDMX_IO_DATA IoData)
{
	if (okddmx_set_current_block(IoData->port, 
				IoData->universe,
				IoData->block))
	{
		return -1;
	}
	
	return okddmx_rw_block(IoData->port,
				IoData->universe,
				NULL,
				IoData->data);
}

int dmx_read_95(PDMX_IO_DATA IoData)
{
	if (okddmx_set_current_block(IoData->port, 
				IoData->universe,
				IoData->block))
	{
		return -1;
	}

	return okddmx_rw_block(IoData->port,
				IoData->universe,
				IoData->data,
				NULL);
}

int dmx_status_95(PDMX_IO_DATA buf)
{
	return okddmx_get_status(buf->port, buf->universe, buf->data);
}

int dmx_write_nt(PDMX_IO_DATA buf)
{
	DWORD ret_len;

	if (hdriver == INVALID_HANDLE_VALUE) return -1;

	if (!DeviceIoControl(hdriver,
		IOCTL_WRITE_DMX,
		buf,
		sizeof(DMX_IO_DATA),
		buf,
		sizeof(DMX_IO_DATA),
		&ret_len,
		NULL))
	{
	
		return -1;
	}
		
	return 0;
}

int dmx_read_nt(PDMX_IO_DATA buf)
{
	DWORD ret_len;

	if (hdriver == INVALID_HANDLE_VALUE) return -1;

	if (!DeviceIoControl(hdriver,
		IOCTL_READ_DMX,
		buf,
		sizeof(DMX_IO_DATA),
		buf,
		sizeof(DMX_IO_DATA),
		&ret_len,
		NULL))
	{
		return -1;
	}

	if (ret_len != sizeof(DMX_IO_DATA)) return -1;
		
	return 0;
}

int dmx_status_nt(PDMX_IO_DATA buf)
{
	DWORD ret_len;

	if (hdriver == INVALID_HANDLE_VALUE) return -41;

	if (!DeviceIoControl(hdriver,
		IOCTL_GET_STATUS_DMX,
		buf,
		sizeof(DMX_IO_DATA),
		buf,
		sizeof(DMX_IO_DATA),
		&ret_len,
		NULL))
	{
		return -42;
	}

	if (ret_len != sizeof(DMX_IO_DATA)) return -43;
		
	return 0;
}


int start_driver()
{
	SC_HANDLE manager;
	SC_HANDLE service;
	SERVICE_STATUS ServiceStatus;

	manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
	if (!manager) return -1;

	service = OpenService(manager, "okdmx31", GENERIC_EXECUTE);

	if (!service) {
		CloseServiceHandle(manager);
		return -1;
	}

	ControlService(service, SERVICE_CONTROL_STOP, &ServiceStatus);

	if (!StartService(service, 0, NULL)) {
		CloseServiceHandle(service);
		CloseServiceHandle(manager); 
		return -1;	
	}

	CloseServiceHandle(service);
	CloseServiceHandle(manager);	
		
	return 0;
}

void install_driver()
{
	char path[MAX_PATH];
	SC_HANDLE manager;
	SC_HANDLE service;
	HRSRC resource;
	HGLOBAL	global;
	void *data;
	HANDLE target;
	DWORD BytesWritten;

	GetSystemDirectory(path , sizeof(path));

	resource = FindResource(hmodule, MAKEINTRESOURCE(IDR_BIN1), "BIN");
	
	if (!resource) return;

	global = LoadResource(hmodule, resource);
	
	if (!global) return;

	data = 	LockResource(global);
	
	if (!data) return;

	strcat(path,"\\Drivers\\okdmx31.sys");

	target = CreateFile(path, 
			GENERIC_WRITE,
			0,
			NULL,
			CREATE_ALWAYS,
			0,
			NULL);

	if (!target) return;

	WriteFile(target,
			data,
			SizeofResource(hmodule,resource),
			&BytesWritten,
			NULL);

	CloseHandle(target);
	
	manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
	
	if (!manager) return;

	service = CreateService(manager,
			"okdmx31",
			"OksiD DMX 3/1 interface",
			SERVICE_ALL_ACCESS,
			SERVICE_KERNEL_DRIVER,
			SERVICE_DEMAND_START,
			SERVICE_ERROR_NORMAL,
			"System32\\Drivers\\okdmx31.sys",
			NULL,
			NULL,
			NULL,
			NULL,
			NULL);

	if (service) CloseServiceHandle(service);

	CloseServiceHandle(manager);

}