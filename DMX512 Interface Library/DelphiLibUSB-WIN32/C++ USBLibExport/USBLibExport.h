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

// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the USBLIBEXPORT_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// USBLIBEXPORT_API functions as being imported from a DLL, wheras this DLL sees symbols
// defined with this macro as being exported.
#ifdef USBLIBEXPORT_EXPORTS
#define USBLIBEXPORT_API __declspec(dllexport)
#else
#define USBLIBEXPORT_API __declspec(dllimport)
#endif

#include "usb.h"


#ifdef __cplusplus
	extern "C" {
#endif


USBLIBEXPORT_API usb_dev_handle* __stdcall libusb_open(struct usb_device *dev);

USBLIBEXPORT_API int __stdcall libusb_close(usb_dev_handle *dev);

USBLIBEXPORT_API int __stdcall libusb_get_string(usb_dev_handle *dev, int index, int langid, char *buf, size_t buflen);
USBLIBEXPORT_API int __stdcall libusb_get_string_simple(usb_dev_handle *dev, int index, char *buf, size_t buflen);

  /* descriptors.c */
USBLIBEXPORT_API int __stdcall libusb_get_descriptor_by_endpoint(usb_dev_handle *udev, int ep, unsigned char type, unsigned char index, void *buf, int size);
USBLIBEXPORT_API int __stdcall libusb_get_descriptor(usb_dev_handle *udev, unsigned char type, unsigned char index, void *buf, int size);

  /* <arch>.c */
USBLIBEXPORT_API int __stdcall libusb_bulk_write(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);
USBLIBEXPORT_API int __stdcall libusb_bulk_read(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);
USBLIBEXPORT_API int __stdcall libusb_interrupt_write(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);
USBLIBEXPORT_API int __stdcall libusb_interrupt_read(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);
USBLIBEXPORT_API int __stdcall libusb_control_msg(usb_dev_handle *dev, int requesttype, int request, int value, int index, char *bytes, int size, int timeout);
USBLIBEXPORT_API int __stdcall libusb_set_configuration(usb_dev_handle *dev, int configuration);
USBLIBEXPORT_API int __stdcall libusb_claim_interface(usb_dev_handle *dev, int interface);
USBLIBEXPORT_API int __stdcall libusb_release_interface(usb_dev_handle *dev, int interface);
USBLIBEXPORT_API int __stdcall libusb_set_altinterface(usb_dev_handle *dev, int alternate);
USBLIBEXPORT_API int __stdcall libusb_resetep(usb_dev_handle *dev, unsigned int ep);
USBLIBEXPORT_API int __stdcall libusb_clear_halt(usb_dev_handle *dev, unsigned int ep);
USBLIBEXPORT_API int __stdcall libusb_reset(usb_dev_handle *dev);

USBLIBEXPORT_API char* __stdcall libusb_strerror(void);

USBLIBEXPORT_API void __stdcall libusb_init(void);
USBLIBEXPORT_API void __stdcall libusb_set_debug(int level);
USBLIBEXPORT_API int __stdcall libusb_find_busses(void);
USBLIBEXPORT_API int __stdcall libusb_find_devices(void);
USBLIBEXPORT_API struct usb_device* __stdcall libusb_device(usb_dev_handle *dev);
USBLIBEXPORT_API struct usb_bus* __stdcall libusb_get_busses(void);

/* Windows specific functions */
const struct usb_version *usb_get_version(void);


#ifdef __cplusplus
	}
#endif
