/*
 * Windows interface library for OksiD DMX->USB
 * 
 *                     Copyright (c) 2003-2006, Jean-Marc Lienher
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
 * Reference:
 *	http://support.microsoft.com:80/support/kb/articles/Q153/5/86.asp
 */

#ifndef OKDMX31_H
#define OKDMX31_H

#include <windows.h>

#define OKDMX31_API

#ifdef __cplusplus
extern "C" {
#endif

#define OKSID_OPEN 1
#define OKSID_CLOSE 2
#define OKSID_DMXOUTOFF 3	
#define OKSID_DMXOUT 4
#define OKSID_DMXIN 8
#define OKSID_OK 1
#define OKSID_ERROR_COMMAND -1
#define OKSID_NOTHING 2
#define OKSID_CONTROLLER1 0
#define OKSID_CONTROLLER2 100
#define OKSID_CONTROLLER3 200
#define OKSID_CONTROLLER4 300


OKDMX31_API int __stdcall OksidCommand(
	int command, 
	int parameter, 
	unsigned char *buffer);

#ifdef __cplusplus
};
#endif

#endif