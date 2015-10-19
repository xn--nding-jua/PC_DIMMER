/*
 * DEMO2.CPP - Demo code on how to use the usbdmx.dll with run-time
 * dynamic linking. This demo can handle the situation where the dll
 * is not present. 
 * Link against usbdmx_dynamic.cpp which contains the code to load the
 * dll at run-time.
 *
 * This file is provided as is to allow an easy start with the
 * usbdmx driver and dll.
 *
 * In case of trouble please contact driver@lighting-solutions.de or
 * call +49/40/600877-51.
 */

/* windows default include files */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>

/* the usbdmx_dynamic.h include file contains all functions definitions
 * needed to operate usbdmx interfaces */
#include "usbdmx_dynamic.h"

int main(int argc, char* argv[])
{
	HANDLE h;				/* handle to one interface */
	UCHAR  buffer[0x200];	/* buffer with one dmx512 frame */
	UCHAR  bufnew[0x201];	/* buffer for one dmx512 frame incl. startcode */
	USHORT version;			/* version number in BCD */
	DWORD  frames;			/* number of frames transmitted/received */
	USHORT slots;			/* number of received slots */
	USHORT timestamp;		/* timestamp [ms] returned from usbdmx_tx and rx */
	UCHAR  status;			/* status information from usbdmx_tx and rx */
	struct usbdmx_functions *usbdmx;	/* library functions */

	/* load usbdmx.dll */
	usbdmx = usbdmx_init();
	if (!usbdmx)
	{
		printf("loading usbdmx.dll failed, giving up!\n");
		getchar();
		return 1;
	}

	/* verify USBDMX dll version */
	if (!USBDMX_DLL_VERSION_CHECK(usbdmx))
	{
		printf("USBDMX.DLL version does not match, giving up!\n");
		printf("found %i, expected %i\n", usbdmx->version(), USBDMX_DLL_VERSION);
		return 1;
	}

	printf("Using USBDMX.DLL version 0x%x\n\n", usbdmx->version());

    /* open the first devices (number 0) */
	if (!usbdmx->open(0, &h))
	{
		printf("no usbdmx-interface available, giving up!\n");
		getchar();
		return 1;
	}

	/* identify the interface */
	printf("The interface found is a ");

	if (usbdmx->is_xswitch(h))
		printf("X-Switch");
	else if (usbdmx->is_rodin1(h))
		printf("Rodin1");
	else if (usbdmx->is_rodin2(h))
		printf("Rodin2");
	else if (usbdmx->is_rodint(h))
		printf("RodinT");
	else if (usbdmx->is_usbdmx21(h))
		printf("USBDMX21");

	usbdmx->device_version(h, &version);
	printf(" Version: 0x%02x\n", version);
	putchar('\n');

	/* read some data from the interface */
	if (usbdmx->rx_frames(h, &frames))
		printf("The interface received %d frame%s\n", frames, frames==1?"":"s");
	if (usbdmx->tx_frames(h, &frames))
		printf("The interface transmitted %d frame%s\n", frames, frames==1?"":"s");

	/***************************************************************
	 * old - deprecated - functions to access the dmx data buffers */

	/* read the receiver data */
	/* RodinT: this call accesses the receiver side */
	if (!usbdmx->rx_get(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx->rx_get() failed!\n");
	
	/* write the received data to the transmitter */
	/* RodinT: this call accesses the transmitter side */
	if (!usbdmx->tx_set(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx->tx_set() failed!\n");

	/* read the receiver data after having received a frame */
	/* RodinT: this call accesses the receiver side */
	if (!usbdmx->rx_get_blocking(h, buffer, sizeof(buffer)))
		fprintf(stderr, "INFO: usbdmx->rx_get_blocking() failed, not connected to active transmitter?\n");
	
	/* write the received data to the transmitter, and send the data with the next frame */
	/* RodinT: this call accesses the transmitter side */
	if (!usbdmx->tx_set_blocking(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx->tx_set_blocking() failed!\n");

	/*************************************************************
	 * new - prefered - functions to access the dmx data buffers */

	/* send a frame */
	if (!usbdmx->tx(h,							/* handle to the interface */
					0,							/* universe addressed 
												   on Rodin1/2: only 0 is supported
												   on RodinT: 0 transmitter side, 1 receiver side */
					513,						/* number of slots to be transmitted, incl. startcode */
					bufnew,						/* buffer with dmx data (bufnew[0] is the startcode */
					USBDMX_BULK_CONFIG_BLOCK,	/* configuration for this frame, see usbdmx.h for details */
					100e-3,						/* parameter for configuration [s], see usbdmx.h for details, 
					                               in this case: block 100ms with respect to previous frame */
					200e-6,						/* length of break [s]. If 0, no break is generated */
					20e-6,						/* length of mark-after-break [s], If 0, no MaB is generated */
					&timestamp,					/* timestamp of the frame [ms] */
					&status))					/* status information */
		printf("usbdmx->tx(): error!\n");
	/* check transaction status, see usbdmx.h for details */
	if (!USBDMX_BULK_STATUS_IS_OK(status))
		printf("ERROR: usbdmx->tx(): status = 0x%02x\n", status);

	/* receive a frame */
	if (!usbdmx->rx(h,			/* handle to the interface */
					0,			/* universe addressed 
								   on Rodin1/2: only 0 is supported
								   on RodinT: 0 transmitter side, 1 receiver side */
					513,		/* number of slots to receive, incl. startcode */
					bufnew,		/* buffer for the received data */
					0.1,		/* timeout to receive the total frame [s] */
					1e-3,		/* timeout to receive the next slot [s] */
					&slots,		/* number of slots received */
					&timestamp,	/* timestamp of the frame */
					&status))	/* status information */
		printf("usbdmx->rx(): error!\n");
	/* check transaction status, see usbdmx.h for details */
	if (!USBDMX_BULK_STATUS_IS_OK(status))
	{
		if (status == USBDMX_BULK_STATUS_TIMEOUT)
			printf("INFO: usbdmx->rx() timed out, no frame received\n");
		else
			printf("ERROR: usbdmx->rx(): status = 0x%02x\n", status);
	}

	/* close the interface */
	usbdmx->close(h);

	/* release the dll */
	usbdmx_release();

	printf("demo code finished\n");

	getchar();
	return 0;
}
