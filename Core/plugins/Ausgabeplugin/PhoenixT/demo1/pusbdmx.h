/*
 * USBDMX.H -- include file for Peperoni-Light's USBDMX.DLL
 *   to communicate with the Rodin1, Rodin2, USBDMX X-Switch 
 *   and USBDMX21 usb to dmx512 interfaces.
 *
 * Copyright (C) 2004-2012 by Jan Menzel
 * All rights reserved 
 */

#ifndef PUSBDMX_H
#define PUSBDMX_H

// define the dll space this file is used in
#ifdef PUSBDMX_DLL_EXPORT
#define PUSBDMX_TYPE __declspec(dllexport) __stdcall
#else
#define PUSBDMX_TYPE __declspec(dllimport) __stdcall
#endif

/*
 * DLL version
 */
static USHORT PUSBDMX_DLL_VERSION = 0x0402;

/*
 * MACRO to verify dll version
 */
#define PUSBDMX_DLL_VERSION_CHECK() (pusbdmx_version() >= PUSBDMX_DLL_VERSION)

/* *************************************
 * functions defined in the usbdmx.dll *
 ***************************************/

/*
 *   pusbdmx_version(): returns the version number (16bit, 4 digits BCD)
 * Current version is PUSBDMX_DLL_VERSION. Use the Macro 
 * PUSBDMX_DLL_VERSION_CHECK() compare dll's and header files version.
 */
USHORT	PUSBDMX_TYPE	pusbdmx_version();

/*
 *   pusbdmx_open(): open device number <device>, where 0 is the first
 * and unlimit devices are supported. The function returnes 
 * STATUS_INVALID_HANDLE_VALUE if <device> is not supported. Use the
 * returned handle to access the device later on. One device can be
 * opened an unlimited number of times.
 */
BOOL	PUSBDMX_TYPE	pusbdmx_open(USHORT device, PHANDLE h);

/*
 *   pusbdmx_close(): close the device identified by the given handle.
 */
BOOL	PUSBDMX_TYPE	pusbdmx_close(HANDLE h);

/*
 *   pusbdmx_is_XXX(): identify the device identified by the given handle.
 * Each function returns TRUE if the device matches.
 */
BOOL	PUSBDMX_TYPE	pusbdmx_is_phoenixt(HANDLE h);

/*
 *   pusbdmx_product_get(): read the product string from the device.
 * size specifies the maximum size of the buffer pointed to by <string> 
 * (unit bytes).
 */
BOOL	PUSBDMX_TYPE	pusbdmx_product_get(HANDLE h, PWCHAR string, USHORT size);

/*
 *   pusbdmx_device_version(): Read the the device version of a device.
 * the device version is one of the values within the USBs configuration
 * descriptor (BcdDevice). pversion is only valid if the function returns
 * TRUE.
 */
BOOL	PUSBDMX_TYPE	pusbdmx_device_version(HANDLE h, PUSHORT pversion);

/*
 *   PUSBDMX_TX(): transmitt a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by pusbdmx_open()
 *			universe	- addressed universe
 *			slots		- number of bytes to be transmitted, as well as sizeof(buffer)
 *						  for DMX512: buffer[0] == startcode, slots <= 513
 *			buffer		- data to be transmitted,  !!! sizeof(buffer) >= slots !!!
 *			config		- configuration of the transmitter, see below for possible values
 *			time		- time value in s, depending on config, either timeout or delay
 *			time_break	- break time in s (can be zero, to not transmitt a break)
 *			time_mab	- Mark-after-Break time (can be zero)
 * OUTPUTs:	ptimestamp	- timestamp of this frame in ms, does overrun
 *			pstatus		- status of this transmission, see below for possible values
 */
BOOL	PUSBDMX_TYPE	pusbdmx_tx(IN HANDLE h, IN UCHAR universe, IN USHORT slots, 
							       IN PUCHAR buffer, IN UCHAR config, IN FLOAT time, 
							       IN FLOAT time_break, IN FLOAT time_mab, 
							       OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);
/*
 * values of config (to be ored together)
 */
#define PUSBDMX_BULK_CONFIG_DELAY	(0x01)	// delay frame by time
#define PUSBDMX_BULK_CONFIG_BLOCK	(0x02)	// block while frame is not transmitting (timeout given by time)
#define PUSBDMX_BULK_CONFIG_RX		(0x04)	// switch to RX after having transmitted this frame
#define PUSBDMX_BULK_CONFIG_NORETX	(0x08)	// do not retransmit this frame

/*
 *   PUSBDMX_RX(): receive a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by pusbdmx_open()
 *			universe	- addressed universe
 *			slots_set	- number of bytes to receive, as well as sizeof(buffer)
 *						  for DMX512: buffer[0] == startcode, slots_set <= 513
 *			buffer		- data to be transmitted,  !!! sizeof(buffer) >= slots !!!
 *			timeout		- timeout for receiving the total frame in s,
 *			timeout_rx	- timeout between two slots used to detect premature end of frames
 * OUTPUTs:	pslots_get	- number of slots actually received, *pslots_get <= slots_set
 *          ptimestamp	- timestamp of this frame in ms, does overrun
 *			pstatus		- status of the reception, see below for possible values
 */
BOOL	PUSBDMX_TYPE	pusbdmx_rx(IN HANDLE h, IN UCHAR universe, IN USHORT slots_set, 
								   IN PUCHAR buffer, IN FLOAT timeout, IN FLOAT timeout_rx,
								   OUT PUSHORT pslots_get, OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);

/*
 * values of *pstatus
 */
#define PUSBDMX_BULK_STATUS_OK				(0x00)
#define PUSBDMX_BULK_STATUS_TIMEOUT			(0x01)	// request timed out	
#define PUSBDMX_BULK_STATUS_TX_START_FAILED	(0x02)	// delayed start failed
#define PUSBDMX_BULK_STATUS_UNIVERSE_WRONG	(0x03)	// wrong universe addressed\tabularnewline
#define PUSBDMX_BULK_STATUS_RX_OLD_FRAME	(0x10)	// old frame not read
#define PUSBDMX_BULK_STATUS_RX_TIMEOUT		(0x20)	// receiver finished with timeout (ored with others)
#define PUSBDMX_BULK_STATUS_RX_NO_BREAK		(0x40)	// frame without break received (ored with others)
#define PUSBDMX_BULK_STATUS_RX_FRAMEERROR	(0x80)	// frame finished with frame error (ored with others)

/*
 * macro to check, it the return status is ok
 */
#define PUSBDMX_BULK_STATUS_IS_OK(s) (s == PUSBDMX_BULK_STATUS_OK)

/*
 *   pusbdmx_id_led_XXX(): get/set the "id-led", the way the TX-led is handled:
 * special value: see below
 * other:         the blue led blinks the given number of times and then pauses
 */
BOOL	PUSBDMX_TYPE	pusbdmx_id_led_set(HANDLE h, UCHAR id);
BOOL	PUSBDMX_TYPE	pusbdmx_id_led_get(HANDLE h, PUCHAR id);

/*
 * special values of id
 */
#define PUSBDMX_ID_LED_USB		(0xff)	// display the USB status: blink with 2Hz on USB transactions
#define PUSBDMX_ID_LED_USB_RX	(0xfe)	// display USB and receiver status. the LED blinks red if not valid dmx signal in received

#endif // USBDMX_H
