/*
 * USBDMX.H -- include file for Peperoni-Light's USBDMX.DLL
 *   to communicate with the Rodin1, Rodin2, USBDMX X-Switch 
 *   and USBDMX21 usb to dmx512 interfaces.
 *
 * Copyright (C) 2004-2006 by Jan Menzel
 * All rights reserved 
 */

#ifndef USBDMX_H
#define USBDMX_H

// define the dll space this file is used in
#ifdef USBDMX_DLL_EXPORT
#define USBDMX_TYPE __declspec(dllexport) __stdcall
#else
#define USBDMX_TYPE __declspec(dllimport) __stdcall
#endif

/*
 * DLL version
 */
static USHORT USBDMX_DLL_VERSION = 0x0403;

/*
 * MACRO to verify dll version
 */
#define USBDMX_DLL_VERSION_CHECK() (usbdmx_version() >= USBDMX_DLL_VERSION)

/* *************************************
 * functions defined in the usbdmx.dll *
 ***************************************/

/*
 *   usbdmx_version(): returns the version number (16bit, 4 digits BCD)
 * Current version is USBDMX_DLL_VERSION. Use the Macro 
 * USBDMX_DLL_VERSION_CHECK() compare dll's and header files version.
 */
USHORT	USBDMX_TYPE	usbdmx_version();

/*
 *   usbdmx_open(): open device number <device>, where 0 is the first
 * and unlimit devices are supported. The function returnes 
 * STATUS_INVALID_HANDLE_VALUE if <device> is not supported. Use the
 * returned handle to access the device later on. One device can be
 * opened an unlimited number of times.
 */
BOOL	USBDMX_TYPE	usbdmx_open(USHORT device, PHANDLE h);

/*
 *   usbdmx_close(): close the device identified by the given handle.
 */
BOOL	USBDMX_TYPE usbdmx_close(HANDLE h);

/*
 *   usbdmx_is_XXX(): identify the device identified by the given handle.
 * Each function returns TRUE if the device matches.
 */
BOOL	USBDMX_TYPE	usbdmx_is_xswitch(HANDLE h);
BOOL	USBDMX_TYPE	usbdmx_is_rodin1(HANDLE h);
BOOL	USBDMX_TYPE	usbdmx_is_rodin2(HANDLE h);
BOOL	USBDMX_TYPE	usbdmx_is_rodint(HANDLE h);
BOOL	USBDMX_TYPE	usbdmx_is_usbdmx21(HANDLE h);
BOOL	USBDMX_TYPE	usbdmx_is_powerlinenode(HANDLE h);

/*
 *   usbdmx_product_get(): read the product string from the device.
 * size specifies the maximum size of the buffer pointed to by <string> 
 * (unit bytes).
 */
BOOL	USBDMX_TYPE	usbdmx_product_get(HANDLE h, PWCHAR string, USHORT size);

/*
 *   usbdmx_device_version(): Read the the device version of a device.
 * the device version is one of the values within the USBs configuration
 * descriptor (BcdDevice). pversion is only valid if the function returns
 * TRUE.
 */
BOOL	USBDMX_TYPE	usbdmx_device_version(HANDLE h, PUSHORT pversion);

/*
 *   USBDMX_TX(): transmitt a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
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
BOOL	USBDMX_TYPE usbdmx_tx(IN HANDLE h, IN UCHAR universe, IN USHORT slots, 
							  IN PUCHAR buffer, IN UCHAR config, IN FLOAT time, 
							  IN FLOAT time_break, IN FLOAT time_mab, 
							  OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);
/*
 * values of config (to be ored together)
 */
#define USBDMX_BULK_CONFIG_DELAY	(0x01)	// delay frame by time
#define USBDMX_BULK_CONFIG_BLOCK	(0x02)	// block while frame is not transmitting (timeout given by time)
#define USBDMX_BULK_CONFIG_RX		(0x04)	// switch to RX after having transmitted this frame
#define USBDMX_BULK_CONFIG_NORETX	(0x08)	// do not retransmit this frame
#define USBDMX_BULK_CONFIG_TXIRQ	(0x40)	// send data with two stop bits, default is 3
#define USBDMX_BULK_CONFIG_FORCETX	(0x80)	// force transmittion, overdrive input signals

/*
 *   USBDMX_RX(): receive a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
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
BOOL	USBDMX_TYPE usbdmx_rx(IN HANDLE h, IN UCHAR universe, IN USHORT slots_set, 
							  IN PUCHAR buffer, IN FLOAT timeout, IN FLOAT timeout_rx,
							  OUT PUSHORT pslots_get, OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);

/*
 * values of *pstatus
 */
#define USBDMX_BULK_STATUS_OK					(0x00)
#define USBDMX_BULK_STATUS_TIMEOUT				(0x01)	// request timed out	
#define USBDMX_BULK_STATUS_TX_START_FAILED		(0x02)	// delayed start failed
#define USBDMX_BULK_STATUS_UNIVERSE_WRONG		(0x03)	// wrong universe addressed\tabularnewline
#define USBDMX_BULK_STATUS_RX_LENGTH_DECODER	(0x08)	// length decoded has updated slots_set
#define USBDMX_BULK_STATUS_RX_OLD_FRAME			(0x10)	// old frame not read
#define USBDMX_BULK_STATUS_RX_TIMEOUT			(0x20)	// receiver finished with timeout (ored with others)
#define USBDMX_BULK_STATUS_RX_NO_BREAK			(0x40)	// frame without break received (ored with others)
#define USBDMX_BULK_STATUS_RX_FRAMEERROR		(0x80)	// frame finished with frame error (ored with others)

/*
 * macro to check, it the return status is ok
 */
#define USBDMX_BULK_STATUS_IS_OK(s) (s == USBDMX_BULK_STATUS_OK)

/*
 *   usbdmx_tx_XXX(): Write or read the interfaces transmitter buffer.
 * usbdmx_tx2_XXX() addresses the buffer of the second transmitter, which
 * is only valid for usbdmx21 devices. The XXX_blocking() functions return
 * if the current frame has been transmitted compleately. They operate
 * the interface synronices with the transmitter. All other functions
 * operate asynchronously, they return immediately.
 */
BOOL	USBDMX_TYPE	usbdmx_tx_set(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx_set_blocking(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx2_set(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx2_set_blocking(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx_get(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx_get_blocking(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx2_get(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_tx2_get_blocking(HANDLE h, PUCHAR buf, USHORT size);

/*
 *   usbdmx_rx_XXX(): Write or read the interfaces receiver buffer.
 * The XXX_blocking() functions return if the current frame has been 
 * transmitted compleately. They operate the interface synronices with 
 * the transmitter. All other functions operate asynchronously, they 
 * return immediately.
 */
BOOL	USBDMX_TYPE	usbdmx_rx_set(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_rx_set_blocking(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_rx_get(HANDLE h, PUCHAR buf, USHORT size);
BOOL	USBDMX_TYPE	usbdmx_rx_get_blocking(HANDLE h, PUCHAR buf, USHORT size);

/*
 *   usbdmx_[rx|tx]_frames(): return a 32bit frame counter from the device.
 * Each device counts the transmitted/received frames. The framecounter
 * can overflow.
 */
BOOL	USBDMX_TYPE	usbdmx_tx_frames(HANDLE h, PDWORD pframes);
BOOL	USBDMX_TYPE	usbdmx_rx_frames(HANDLE h, PDWORD pframes);

/*
 *   usbdmx_[rx|tx]_startcode_[set|get](): read/set the startcode of the
 * transmitter/receiver. The receiver only accepts frames with the 
 * given startcode, all other are ignored. According to DMX512A 
 * specification the startcode should be 0.
 */
BOOL	USBDMX_TYPE	usbdmx_tx_startcode_set(HANDLE h, UCHAR startcode);
BOOL	USBDMX_TYPE	usbdmx_tx_startcode_get(HANDLE h, PUCHAR pstartcode);
BOOL	USBDMX_TYPE	usbdmx_rx_startcode_set(HANDLE h, UCHAR startcode);
BOOL	USBDMX_TYPE	usbdmx_rx_startcode_get(HANDLE h, PUCHAR pstartcode);

/*
 *   usbdmx_tx_slots_[set|get](): read/set the number of slots transmitted
 * per frame. Numbers above 512 or below 24 are not allowed.
 */
BOOL	USBDMX_TYPE	usbdmx_tx_slots_set(HANDLE h, USHORT slots);
BOOL	USBDMX_TYPE	usbdmx_tx_slots_get(HANDLE h, PUSHORT pslots);

/*
 *   usbdmx_rx_slots_get(): read the number of slots received within the
 * last frames.
 */
BOOL	USBDMX_TYPE	usbdmx_rx_slots_get(HANDLE h, PUSHORT pslots);

/*
 *   usbdmx_tx_timing_XXX(): read/set the timing values of the transmitter.
 * each value is returned/set in seconds.
 */
BOOL	USBDMX_TYPE	usbdmx_tx_timing_set(HANDLE h, FLOAT time_break, FLOAT time_mab, FLOAT time_inter_frame);
BOOL	USBDMX_TYPE	usbdmx_tx_timing_get(HANDLE h, PFLOAT ptime_break, PFLOAT ptime_mab, PFLOAT ptime_inter_frame);

/*
 *   usbdmx_id_led_XXX(): get/set the "id-led", the way the TX-led is handled:
 * special value: see below
 * other:         the blue led blinks the given number of times and then pauses
 */
BOOL	USBDMX_TYPE	usbdmx_id_led_set(HANDLE h, UCHAR id);
BOOL	USBDMX_TYPE	usbdmx_id_led_get(HANDLE h, PUCHAR id);

/*
 * special values of id
 */
#define USBDMX_ID_LED_USB		(0xff)	// display the USB status: blink with 2Hz on USB transactions
#define USBDMX_ID_LED_USB_RX	(0xfe)	// display USB and receiver status. the LED blinks red if not valid dmx signal in received

/*
 * usbdmx_runlengthencoder_set - configure build in run-length encoder
 *
 * match_value - value to match on received data to trigger the encoder
 * match_mask  - mask to apply to received data before comparing with match_value
 * pos_lsb     - lsb position of length to extract
 * pos_msb     - msb position of length to extract, -1 if not used
 * offset      - offset value to addt to extracted length
 */
BOOL	USBDMX_TYPE usbdmx_runlengthencoder_set(IN HANDLE h, IN UINT match_value, IN UINT match_mask, IN USHORT pos_lsb, IN USHORT pos_msb, IN INT offset);

/*
 * usbdmx_runlengthencoder_get - read configuration of build in run-length encoder
 *
 * match_value - value to match on received data to trigger the encoder
 * match_mask  - mask to apply to received data before comparing with match_value
 * pos_lsb     - lsb position of length to extract
 * pos_msb     - msb position of length to extract, -1 if not used
 * offset      - offset value to addt to extracted length
 */
BOOL	USBDMX_TYPE usbdmx_runlengthencoder_get(IN HANDLE h, OUT PUINT pmatch_value, OUT PUINT pmatch_mask, OUT PUSHORT ppos_lsb, OUT PUSHORT ppos_msb, OUT PINT poffset);

/******************************************************************************
 * High-Level functions facilitating the above
 */

/*
 * USBDMX_DMXTX - send dmx data
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
 *			universe	- addressed universe
 *			slots		- number of bytes to transmitt without startcode, as well as sizeof(buffer)
 *			buffer		- data to be transmitted without startcode,  !!! sizeof(buffer) >= slots !!!
 * RETURN:	== 0		- data transmitted
 *			!= 0		- data not transmitted
 */
int USBDMX_TYPE usbdmx_dmxtx(HANDLE h, UCHAR universe, USHORT slots, const void *buffer);

/*
 * USBDMX_DMXRX - receive dmx data with startcode 0
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
 *			universe	- addressed universe
 *			buffersize	- size of buffer
 *			buffer		- received data without startcode
 * RETURN:	== 0		- no data received, or data with non-DMX startcode
 *			>  0		- amount of received data
 *			<  0		- reception error
 */
int USBDMX_TYPE usbdmx_dmxrx(HANDLE h, UCHAR universe, USHORT buffersize, void *buffer);
// return values for dmxrx and tx
enum {
	USBDMX_DMX_INPUT		= -1,	// input parameter wrong
	USBDMX_DMX_TX			= -10,	// transmission failed
	USBDMX_DMX_UNIVERSE		= -11,	// universe number wrong
	USBDMX_DMX_RX			= -20,	// reception failed
	USBDMX_DMX_RX_NOBREAK	= -23,	// reception failed with no break
};


/*
 * USBDMX_RDM - exchange rdm data
 *
 * INPUTs:	h				- handle to the device, returned by usbdmx_open()
 *			universe		- addressed universe
 *			txlen			- number of bytes to transmitt
 *			txbuffer		- data to be transmitted,  !!! sizeof(buffer) >= txlen !!!
 *							  START code, Sub START Code and Message Length are inserted befor,
 *							  Checksum is appended behind the data.
 *          rxsize          - size of receive buffer (set to 0 if not data is to be received)
 *          rxbuffer        - receive buffer
 *                            Checksum is validated and stipped
 *                            START code, Sub START code and length are validated and stipped
 * RETURN:	> 0				- length of received data without START codes, length and Checksum
 *                            (can be larger than rxsize if rxsize was to small)
 *			< 0				- handling/reception error
 */
int USBDMX_TYPE usbdmx_rdm(HANDLE h, UCHAR universe, UCHAR txlen, const void *txbuffer, UCHAR rxsize, void *rxbuffer);

/*
 * USBDMX_RDMDISCOVERY - exchange rdm discovery data (handle special response without break)
 *
 * INPUTs:	h				- handle to the device, returned by usbdmx_open()
 *			universe		- addressed universe
 *			txlen			- number of bytes to transmitt
 *			txbuffer		- data to be transmitted,  !!! sizeof(buffer) >= txlen !!!
 *							  START code, Sub START Code and Message Length are inserted befor,
 *							  Checksum is appended behind the data.
 *          rxsize          - size of receive buffer
 *          rxbuffer        - receive buffer, contains received UIDs
 * RETURN:	> 0				- length of UIDs (can be larger than rxsize if rxsize was to small to fit all uids)
 *			< 0				- handling/reception error
 */
int USBDMX_TYPE usbdmx_rdmdiscovery(HANDLE h, UCHAR universe, UCHAR txlen, const void *txbuffer, UCHAR rxsize, void *rxbuffer);

// return values for rdm() and rdmdiscovery():
enum {
	USBDMX_RDM_INPUT			= -1,	// input parameter wrong
	USBDMX_RDM_TX				= -10,	// transmission failed
	USBDMX_RDM_UNIVERSE			= -11,	// universe number wrong
	USBDMX_RDM_RX				= -20,	// reception failed
	USBDMX_RDM_RX_TIMEOUT		= -21,	// reception failed with timed out
	USBDMX_RDM_RX_FRAMEERROR	= -22,	// reception failed with frame error
	USBDMX_RDM_RX_NOBREAK		= -23,	// reception failed with no break
	USBDMX_RDM_RX_LENGTH		= -24,	// reception failed with length error (received less data than expected)
	USBDMX_RDM_RX_STARTCODE		= -25,	// wrong startcode received
	USBDMX_RDM_RX_SUBSTARTCODE	= -26,	// wrong sub-startcode received
	USBDMX_RDM_RX_CHECKSUM		= -27,	// reception failed with checksum error
	USBDMX_RDM_COLLISION		= -30	// collision detected
};

#endif // USBDMX_H
