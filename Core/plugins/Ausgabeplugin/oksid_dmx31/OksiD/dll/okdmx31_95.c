/*
 * Windows 95 driver for OksiD DMX 3/1 interface
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
 */

#include <windows.h>
#include <conio.h>
#include <stdio.h>

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

#define STATUS_DMX_ERROR -100
#define STATUS_SUCCESS 0


//#define printk(aa) {FILE *f; f = fopen("debug.txt", "ab");fprintf aa;fclose(f);}
#define printk(aa) 

#define NTSTATUS int
#define KERN_ERR f, "oksdmx31_95.c: "

static UCHAR read_status(PUCHAR port)
{
	return (UCHAR)((_inp((unsigned short)(port + 1)) ^ 0x80) & 0xf8);
}

static VOID write_data(PUCHAR port, UINT data)
{
	_outp((unsigned short) port, (int)data);
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
	tm = tm / 1000;
	if (tm < 1) tm = 1;
	Sleep(tm);
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

NTSTATUS okddmx_rw_block(PUCHAR port, UCHAR chip, PUCHAR in, PUCHAR out)
{
	return okddmx_command(port, chip, in, out, 32);
}

NTSTATUS okddmx_get_status(PUCHAR port, UCHAR chip, PUCHAR status)
{
	return okddmx_command(port, chip, status, NULL, 2);
}

NTSTATUS okddmx_set_current_block(PUCHAR port, UCHAR chip, UCHAR block)
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






