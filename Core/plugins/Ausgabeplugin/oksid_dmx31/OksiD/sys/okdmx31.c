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

#include "okdmx31.h"

#define D0 0x1
#define D1 0x2
#define D2 0x4
#define D3 0x8
#define D4 0x10
#define D5 0x20
#define D6 0x40
#define D7 0x80

#define IN3 0x8
#define IN4 0x10
#define IN5 0x20
#define IN6 0x40
#define IN7 0x80

#define CBLK D2
#define RBLK D1
#define WBLK D0
#define RWBLK D1|D0
#define STAT D2|D0
#define BUSY 0x0F

#define NBRETRY 1000

#define STATUS_DMX_ERROR STATUS_NOT_SUPPORTED


static UCHAR read_status(PUCHAR port)
{
	return (READ_PORT_UCHAR(port + 1) ^ 0x80) & 0xf8;
}

static VOID write_data(PUCHAR port, UCHAR data)
{
	WRITE_PORT_UCHAR(port, data);
}

static NTSTATUS okddmx_reset_chips(PUCHAR port)
{
	SHORT i;
	
	write_data(port, D6|D5);
	
	for (i = NBRETRY; i > 0; i--) {
		if (!(read_status(port) & IN3)) break;
	}
	if (!i) {
  		printk ((KERN_ERR "okddmx_reset_chips: "
			"device does not respond\n"));
		return STATUS_DMX_ERROR;
	}
	
  	printk ((KERN_ERR "okddmx_reset_chips: pre-reset (%d)\n", i));

	write_data(port, D7|D4|D3);
	
	for (i = NBRETRY; i > 0; i--) {
		if (read_status(port) & IN3) break;
	}
	if (!i) {
  		printk ((KERN_ERR "okddmx_reset_chips: "
			"device does not respond to command (%d)\n", i));
		return STATUS_DMX_ERROR;
	}
	
  	printk ((KERN_ERR "okddmx_reset_chips: successful reset (%d)\n", i));
  
	return STATUS_SUCCESS;
}

static VOID udelay(LONG tm)
{
	LARGE_INTEGER ti;
	KTIMER timer;
	
	ti.QuadPart = -tm * 10;
	
	KeInitializeTimer(&timer);
	KeSetTimer(&timer, ti, NULL);
	KeWaitForSingleObject(&timer, Executive, KernelMode, FALSE, &ti);
}

static NTSTATUS okddmx_command(PUCHAR port, UCHAR chip, PUCHAR in, 
	 PUCHAR out, SHORT len)
{
	SHORT i, n;
	UCHAR cmd = 0;
	UCHAR busy = 1;

  	chip = (chip & 0x3) << 5;

	if (in) cmd = 0x2; 
	if (out) cmd |= 0x1;
	if (!cmd) return STATUS_SUCCESS;
	
	if (len == 2) cmd = STAT;

	if (!(read_status(port) & IN3)) okddmx_reset_chips(port);
	if (!(read_status(port) & IN3)) return STATUS_DMX_ERROR;

	while (busy < 200) {
  		write_data(port, D7|chip|cmd);
		for (i = NBRETRY; i > 0; i--) {
			if (!(read_status(port) & IN3)) break;
		}
		if (!i) {
  			printk ((KERN_ERR "okddmx_command: "
				"device does not respond to command\n"));
			return STATUS_DMX_ERROR;
		} else {
			break;
		}

  		write_data(port, D4);
		for (i = NBRETRY; i > 0; i--) {
			if ((read_status(port) & IN3)) break;
		}
		if (!i) {
  			printk ((KERN_ERR "okddmx_command: "
				"device does not respond to busy\n"));
			return STATUS_DMX_ERROR;
		}
		busy++;
		if (busy >= 200) {
  			printk ((KERN_ERR "okddmx_command: "
				"device is too busy\n"));
			return STATUS_DMX_ERROR;
		}
		udelay(10);
	}

	for (n = 0; n < len; n++) {
		UCHAR d = 0;
		UCHAR id = 0;
		
		if (out) d = out[n];
		
  		write_data(port, D4|((d >> 4) & 0x0f));
		
		for (i = NBRETRY; i > 0; i--) {
			id = read_status(port);
			if (id & IN3) break;
		}
		if (!i) {
  			printk ((KERN_ERR "okddmx_command: "
				"device does not respond to data 0\n"));
			return STATUS_DMX_ERROR;
		}
		
		if (!in && (((id >> 4) & 0x0F) != (d >> 4))) {
 			printk ((KERN_ERR "okddmx_command: "
                        	"(%d-%d) data 0 mismatch %x %x\n", chip,
				n, d >> 4, 
				((id >> 4) & 0x0F)));
		}
		
		if (in) in[n] = id & 0xF0;
		
  		write_data(port, (d & 0x0f));
		
		for (i = NBRETRY; i > 0; i--) {
			id = read_status(port);
			if (!(id & IN3)) break;
		}
		
		if (!i) {
  			printk ((KERN_ERR "okddmx_command: "
				"device does not respond to data 1\n"));
			return STATUS_DMX_ERROR;
		}
		
		if (!in && (((id >> 4) & 0x0F) != (d & 0x0f))) {
 			printk ((KERN_ERR "okddmx_command: "
                        	"(%d-%d) data 1 mismatch %x %x\n", chip,
				n, d & 0x0f, 
				((id >> 4) & 0x0F)));
		}
		
		if (in) {
			in[n] |= (id >> 4) & 0x0F;
		}

	}

	write_data(port, D4);
	
	for (i = NBRETRY; i > 0; i--) {
		if (read_status(port) & IN3) break;
	}
	
	if (!i) {
  		printk ((KERN_ERR "okddmx_command: "
			"device does not respond to EOC (%d)\n", i));
		return STATUS_DMX_ERROR;
	}
  	return STATUS_SUCCESS;
}

static NTSTATUS okddmx_rw_block(PUCHAR port, UCHAR chip, PUCHAR in, PUCHAR out)
{
	return okddmx_command(port, chip, in, out, 32);
}

static NTSTATUS okddmx_get_status(PUCHAR port, UCHAR chip, PUCHAR status)
{
	return okddmx_command(port, chip, status, NULL, 2);
}

static NTSTATUS okddmx_set_current_block(PUCHAR port, UCHAR chip, UCHAR block)
{
	SHORT i, in = 0;
	
  	chip = (chip & 0x3) << 5;
  	block &= 0xf;

	if (!(read_status(port) & IN3)) okddmx_reset_chips(port);
	if (!(read_status(port) & IN3)) return STATUS_DMX_ERROR;

  	write_data(port, D7|chip|CBLK);
	
	for (i = NBRETRY; i > 0; i--) {
		if (!(read_status(port) & IN3)) break;
	}
	
	if (!i) {
  		printk ((KERN_ERR "okddmx_set_current_block: "
			"device does not respond to command\n"));
		return STATUS_DMX_ERROR;
	}

  	write_data(port, D4|block);

	for (i = NBRETRY; i > 0; i--) {
		in = read_status(port);
		if (in & IN3) break;
	}

	if (!i) {
  		printk ((KERN_ERR "okddmx_set_current_block: "
			"device does not respond to data\n"));
		return STATUS_DMX_ERROR;
	}
	
	if (((in >> 4) & 0x0F) != block) {
 		printk ((KERN_ERR "okddmx_set_current_block: "
                        "data mismatch %x %x\n", block, ((in >> 4) & 0x0F)));
	}
	
  	return STATUS_SUCCESS;
}

NTSTATUS 
DriverEntry(
	IN PDRIVER_OBJECT  DriverObject,
	IN PUNICODE_STRING registryPath)
{
	NTSTATUS status;
	UNICODE_STRING DeviceName;
	UNICODE_STRING DosDeviceName;
	PDEVICE_OBJECT DeviceObject;
	
	RtlInitUnicodeString(&DeviceName, DEVICE_NAME_U);
	RtlInitUnicodeString(&DosDeviceName, DOS_DEVICE_NAME_U);
	
	status = IoCreateDevice(DriverObject,
				0,
				&DeviceName,
				FILE_DEVICE_UNKNOWN,
				0,
				FALSE,
				&DeviceObject);
	
	if (!NT_SUCCESS(status)) return status;

	status = IoCreateSymbolicLink(&DosDeviceName, &DeviceName);
	
	if (!NT_SUCCESS(status)) return status;
	
	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = 
					OkdDispatchDeviceControl;
 	DriverObject->MajorFunction[IRP_MJ_CREATE] = OkdDispatchCreate;
	DriverObject->DriverUnload = OkdDriverUnload;
	
	return STATUS_SUCCESS;	
}

NTSTATUS OkdDispatchCreate(
	IN PDEVICE_OBJECT DeviceObject,
	IN PIRP pIrp)
{
    pIrp->IoStatus.Information = 0;
    pIrp->IoStatus.Status = STATUS_SUCCESS;
    IoCompleteRequest(pIrp, IO_NO_INCREMENT);

    return STATUS_SUCCESS;
}


NTSTATUS
OkdDispatchDeviceControl(
	IN PDEVICE_OBJECT DeviceObject,
	IN PIRP pIrp)
{
	NTSTATUS status;
	PIO_STACK_LOCATION IrpStack;
	PDMX_IO_DATA IoData;
	
	IrpStack = IoGetCurrentIrpStackLocation(pIrp);
	
	IoData = (PDMX_IO_DATA)pIrp->AssociatedIrp.SystemBuffer;
	
	switch (IrpStack->Parameters.DeviceIoControl.IoControlCode) {
	case IOCTL_WRITE_DMX:
		if (IrpStack->Parameters.DeviceIoControl.OutputBufferLength <
				sizeof(DMX_IO_DATA))
		{
			status = STATUS_BUFFER_TOO_SMALL;
			break;
		}
		
		pIrp->IoStatus.Information = sizeof(DMX_IO_DATA);
		
		status = okddmx_set_current_block(IoData->port, 
						IoData->universe,
						IoData->block);
		
		if (!NT_SUCCESS(status)) break;
			
		status = okddmx_rw_block(IoData->port,
					IoData->universe,
					NULL,
					IoData->data);
		break;
		
	case IOCTL_READ_DMX:
		if (IrpStack->Parameters.DeviceIoControl.InputBufferLength <
				sizeof(DMX_IO_DATA))
		{
			status = STATUS_BUFFER_TOO_SMALL;
			break;
		}
		
		pIrp->IoStatus.Information = sizeof(DMX_IO_DATA);
		
		status = okddmx_set_current_block(IoData->port, 
						IoData->universe,
						IoData->block);
		
		if (!NT_SUCCESS(status)) break;
			
		status = okddmx_rw_block(IoData->port,
					IoData->universe,
					IoData->data,
					NULL);
		break;
		
	case IOCTL_GET_STATUS_DMX:
		if (IrpStack->Parameters.DeviceIoControl.InputBufferLength <
				sizeof(DMX_IO_DATA))
		{
			status = STATUS_BUFFER_TOO_SMALL;
			break;
		}
		
		pIrp->IoStatus.Information = sizeof(DMX_IO_DATA);
		
		status = okddmx_get_status(IoData->port,
					IoData->universe,
					IoData->data);
		break;
		
	default:
		status = STATUS_NOT_SUPPORTED;	
	}
	
	pIrp->IoStatus.Status = status;
	
	IoCompleteRequest(pIrp, IO_NO_INCREMENT); 
	
	return status;
}

VOID OkdDriverUnload(IN PDRIVER_OBJECT DriverObject)
{
	UNICODE_STRING DosDeviceName;
	
	RtlInitUnicodeString(&DosDeviceName, DOS_DEVICE_NAME_U);
	IoDeleteSymbolicLink(&DosDeviceName);
	IoDeleteDevice(DriverObject->DeviceObject);
}


