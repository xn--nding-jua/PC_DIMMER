/*
 * Windows NT kernel mode driver for OksiD DMX 3/1 interface
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
 *     http://www.osr.com/ntinsider/1996/custom-ioctl.htm
 *     http://www.logix4u.cjb.net/
 *     http://www.microsoft.com/whdc/ddk/winddk.mspx
 */

#ifndef OKDMX31_H
#define OKDMX31_H

#include <ntddk.h>

#define IOCTL_WRITE_DMX \
	CTL_CODE(32768, 2048, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_READ_DMX \
	CTL_CODE(32768, 2049, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_GET_STATUS_DMX \
	CTL_CODE(32768, 2050, METHOD_BUFFERED, FILE_ANY_ACCESS)

#define printk(a) DbgPrint a 

#define KERN_ERR "OKDMX31.SYS: "
#define DEVICE_NAME_U		L"\\Device\\OKDMX31"
#define DOS_DEVICE_NAME_U	L"\\DosDevices\\OkDmx31"

typedef struct _DMX_IO_DATA {
	PUCHAR port;
	UCHAR universe;
	UCHAR block;
	UCHAR data[32];
} DMX_IO_DATA, *PDMX_IO_DATA;

NTSTATUS 
DriverEntry(
	IN PDRIVER_OBJECT  DriverObject,
	IN PUNICODE_STRING registryPath);

NTSTATUS
OkdDispatchDeviceControl(
	IN PDEVICE_OBJECT DeviceObject,
	IN PIRP pIrp);

NTSTATUS OkdDispatchCreate(
	IN PDEVICE_OBJECT DeviceObject,
	IN PIRP pIrp);

VOID OkdDriverUnload(IN PDRIVER_OBJECT DriverObject);


#endif /* OKDMX31_H */
