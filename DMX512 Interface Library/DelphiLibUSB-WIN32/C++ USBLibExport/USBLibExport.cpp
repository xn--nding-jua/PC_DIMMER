/* LIBUSB-WIN32, Generic Windows USB Library
 * Copyright (c) 2002-2004 Stephan Meyer <ste_meyer@web.de>
 * Copyright (c) 2000-2004 Johannes Erdfelt <johannes@erdfelt.com>
 *
 * LIBUSB-WIN32 translation
 * Copyright (c) 2004 Yvo Nelemans <ynlmns@xs4all.nl>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

// USBLibExport.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "USBLibExport.h"
#include "usb.h"


BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
    }
    return TRUE;
}


 
USBLIBEXPORT_API usb_dev_handle* __stdcall libusb_open(struct usb_device *dev) {
  return( usb_open(dev) );
}

USBLIBEXPORT_API int __stdcall libusb_close(usb_dev_handle *dev) {
  return( usb_close(dev) );
}

USBLIBEXPORT_API int __stdcall libusb_get_string(usb_dev_handle *dev, int index, int langid, char *buf, size_t buflen) {
  return( usb_get_string(dev, index, langid, buf, buflen) );
}

USBLIBEXPORT_API int __stdcall libusb_get_string_simple(usb_dev_handle *dev, int index, char *buf, size_t buflen) {
  return( usb_get_string_simple(dev, index, buf, buflen) );
}


/* descriptors.c */
USBLIBEXPORT_API int __stdcall libusb_get_descriptor_by_endpoint(usb_dev_handle *udev, int ep, unsigned char type, unsigned char index, void *buf, int size) {
  return( usb_get_descriptor_by_endpoint(udev, ep, type, index, buf, size) );
}

USBLIBEXPORT_API int __stdcall libusb_get_descriptor(usb_dev_handle *udev, unsigned char type, unsigned char index, void *buf, int size) {
  return( usb_get_descriptor(udev, type, index, buf, size) );
}


  /* <arch>.c */
USBLIBEXPORT_API int __stdcall libusb_bulk_write(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout) {
  return( usb_bulk_write(dev, ep, bytes, size, timeout) );
}

USBLIBEXPORT_API int __stdcall libusb_bulk_read(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout) {
  return( usb_bulk_read(dev, ep, bytes, size, timeout) );
}

USBLIBEXPORT_API int __stdcall libusb_interrupt_write(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout) {
  return( usb_interrupt_write(dev, ep, bytes, size, timeout) );
}

USBLIBEXPORT_API int __stdcall libusb_interrupt_read(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout) {
  return( usb_interrupt_read(dev, ep, bytes, size, timeout) );
}

USBLIBEXPORT_API int __stdcall libusb_control_msg(usb_dev_handle *dev, int requesttype, int request, int value, int index, char *bytes, int size, int timeout) {
  return( usb_control_msg(dev, requesttype, request, value, index, bytes, size, timeout) );
}

USBLIBEXPORT_API int __stdcall libusb_set_configuration(usb_dev_handle *dev, int configuration) {
  return( usb_set_configuration(dev, configuration) );
}

USBLIBEXPORT_API int __stdcall libusb_claim_interface(usb_dev_handle *dev, int interface) {
  return( usb_claim_interface(dev, interface) );
}

USBLIBEXPORT_API int __stdcall libusb_release_interface(usb_dev_handle *dev, int interface) {
  return( usb_release_interface(dev, interface) );
}

USBLIBEXPORT_API int __stdcall libusb_set_altinterface(usb_dev_handle *dev, int alternate) {
  return( usb_set_altinterface(dev, alternate) );
}

USBLIBEXPORT_API int __stdcall libusb_resetep(usb_dev_handle *dev, unsigned int ep) {
  return( usb_resetep(dev, ep) );
}

USBLIBEXPORT_API int __stdcall libusb_clear_halt(usb_dev_handle *dev, unsigned int ep) {
  return( usb_clear_halt(dev, ep) );
}

USBLIBEXPORT_API int __stdcall libusb_reset(usb_dev_handle *dev) {
  return( usb_reset(dev) );
}


USBLIBEXPORT_API char* __stdcall libusb_strerror(void) {
  return( usb_strerror() );
}


USBLIBEXPORT_API void __stdcall libusb_init(void) {
  usb_init();
}

USBLIBEXPORT_API void __stdcall libusb_set_debug(int level) {
  usb_set_debug(level);
}

USBLIBEXPORT_API int __stdcall libusb_find_busses(void) {
  return( usb_find_busses() );
}

USBLIBEXPORT_API int __stdcall libusb_find_devices(void) {
  return( usb_find_devices() );
}

USBLIBEXPORT_API struct usb_device* __stdcall libusb_device(usb_dev_handle *dev) {
  return( usb_device(dev) );
}

USBLIBEXPORT_API struct usb_bus* __stdcall libusb_get_busses(void) {
  return( usb_get_busses() );
}

