/*
 * DEMO1.CPP - Demo code on how to use the usbdmx.dll with load-time 
 * dynamic linking. If the dll is not present this demo will not start.
 * Link you code against usbdmx.lib.
 *
 * This file is provided as is to allow an easy start with the
 * usbdmx driver and dll.
 *
 * In case of trouble please contact driver@lighting-solutions.de or
 * call +49/40/600877-51.
 */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>

/* the usbdmx include file with all function definitions */
#include "usbdmx.h"

int main(int argc, char* argv[])
{
	HANDLE h;				/* handle to one interface */
	UCHAR  buffer[0x200];	/* buffer with one dmx512 frame without startcode */
	UCHAR  bufnew[0x201];	/* buffer for one dmx512 frame incl. startcode */
	USHORT version;			/* version number in BCD */
	DWORD  frames;			/* number of frames transmitted/received */
	USHORT slots;			/* number of received slots */
	USHORT timestamp;		/* timestamp [ms] returned from usbdmx_tx and rx */
	UCHAR  status;			/* status information from usbdmx_tx and rx */
	int    ret;				/* return value */

	/* verify USBDMX dll version */
	if (!USBDMX_DLL_VERSION_CHECK())
	{
		printf("USBDMX.DLL version does not match, giving up!\n");
		printf("found %i, expected %i\n", usbdmx_version(), USBDMX_DLL_VERSION);
		return 1;
	}

	printf("Using USBDMX.DLL version 0x%x\n\n", usbdmx_version());

    /* open the first devices (number 0) */
	if (!usbdmx_open(0, &h))
	{
		printf("no usbdmx-interface available, giving up!\n");
		return 1;
	}

	/* identify the interface */
	printf("The interface found is a ");

	if (usbdmx_is_xswitch(h))
		printf("X-Switch");
	else if (usbdmx_is_rodin1(h))
		printf("Rodin1");
	else if (usbdmx_is_rodin2(h))
		printf("Rodin2");
	else if (usbdmx_is_rodint(h))
		printf("RodinT");
	else if (usbdmx_is_usbdmx21(h))
		printf("USBDMX21");

	usbdmx_device_version(h, &version);
	printf(" Version: 0x%02x\n", version);
	putchar('\n');

	/* read some data from the interface */
	if (usbdmx_rx_frames(h, &frames))
		printf("The interface received %d frame%s\n", frames, frames==1?"":"s");
	if (usbdmx_tx_frames(h, &frames))
		printf("The interface transmitted %d frame%s\n", frames, frames==1?"":"s");

	/***************************************************************
	 * old - deprecated - functions to access the dmx data buffers */

	/* read the receiver data */
	/* RodinT: this call accesses the receiver side */
	if (!usbdmx_rx_get(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx_rx_get() failed!\n");
	
	/* write the received data back to the transmitter */
	/* RodinT: this call accesses the transmitter side */
	if (!usbdmx_tx_set(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx_tx_set() failed!\n");

	/* read the receiver data after having received a frame */
	/* RodinT: this call accesses the receiver side */
	if (!usbdmx_rx_get_blocking(h, buffer, sizeof(buffer)))
		fprintf(stderr, "INFO: usbdmx_rx_get_blocking() failed, not connected to active transmitter?\n");
	
	/* write the received data to the transmitter, and send the data with the next frame */
	/* RodinT: this call accesses the transmitter side */
	if (!usbdmx_tx_set_blocking(h, buffer, sizeof(buffer)))
		fprintf(stderr, "ERROR: usbdmx_tx_set_blocking() failed!\n");

	/*************************************************************
	 * new - prefered - functions to access the dmx data buffers */

	/* send a frame */
	if (!usbdmx_tx( h,							/* handle to the interface */
					0,							/* universe addressed 
												   on Rodin1/2: only 0 is supported
												   on RodinT: 0 transmitter side, 1 receiver side */
					513,						/* number of slots to be transmitted, incl. startcode */
					bufnew,						/* buffer with dmx data (bufnew[0] is the startcode */
					USBDMX_BULK_CONFIG_BLOCK,	/* configuration for this frame, see usbdmx.h for details */
					100e-3f,						/* parameter for configuration [s], see usbdmx.h for details, 
					                               in this case: block 100ms with respect to previous frame */
					200e-6f,						/* length of break [s]. If 0, no break is generated */
					20e-6f,						/* length of mark-after-break [s], If 0, no MaB is generated */
					&timestamp,					/* timestamp of the frame [ms] */
					&status))					/* status information */
		printf("usbdmx_tx(): error!\n");
	/* check transaction status, see usbdmx.h for details */
	if (!USBDMX_BULK_STATUS_IS_OK(status))
		printf("ERROR: usbdmx_tx(): status = 0x%02x\n", status);

	/* receive a frame */
	if (!usbdmx_rx(	h,			/* handle to the interface */
					0,			/* universe addressed 
								   on Rodin1/2: only 0 is supported
								   on RodinT: 0 transmitter side, 1 receiver side */
					513,		/* number of slots to receive, incl. startcode */
					bufnew,		/* buffer for the received data */
					0.1f,		/* timeout to receive the total frame [s] */
					1e-3f,		/* timeout to receive the next slot [s] */
					&slots,		/* number of slots received */
					&timestamp,	/* timestamp of the frame */
					&status))	/* status information */
		printf("usbdmx_rx(): error!\n");
	/* check transaction status, see usbdmx.h for details */
	if (!USBDMX_BULK_STATUS_IS_OK(status))
	{
		if (status == USBDMX_BULK_STATUS_TIMEOUT)
			printf("INFO: usbdmx_rx() timed out, no frame received\n");
		else
			printf("ERROR: usbdmx_rx(): status = 0x%02x\n", status);
	}

	/*************************************************************
	 * DMX512 specific input and output functions                */

	/* send a frame in DMX512 format, startcode 0x00 is added internally, data is send once the interface is ready */
	ret = usbdmx_dmxtx(	h,			/* handle to the interface - received from usbdmx_open() */
						0,			/* universe addressed 
									   on Rodin1/2: only 0 is supported
									   on RodinT: 0 transmitter side, 1 receiver side */
						512,		/* number of slots to transmit, without startcode, standard supports 24 to 512 */
						buffer);	/* buffer with data to send */
	if (ret >= 0)
		printf("INFO: Transmission successful\n");
	else
	{
		switch (ret)
		{
		case USBDMX_DMX_INPUT:		printf("ERROR: Parameter error\n");			break; /* input parameter wrong */
		case USBDMX_DMX_TX:			printf("ERROR: Transmission failed\n");		break; /* transmission failed */
		case USBDMX_DMX_UNIVERSE:	printf("ERROR: Universe Number wrong\n");	break; /* universe number wrong */
		}
	}


	/* receive a frame */
	ret = usbdmx_dmxrx(	h,			/* handle to the interface - received from usbdmx_open() */
						0,			/* universe addressed 
									   on Rodin1/2: only 0 is supported
									   on RodinT: 0 transmitter side, 1 receiver side */
						512,		/* number of slots to receive, without startcode, always expect 512 */
						buffer);	/* buffer for the received data */
	if (ret > 0)
		printf("INFO: received %d slots\n", ret);
	else if (ret == 0)
		printf("INFO: no data received, not connected to active transmitter?\n");
	else
	{
		switch (ret)
		{
		case USBDMX_DMX_INPUT:		printf("ERROR: Parameter error\n");					break; /* input parameter wrong */
		case USBDMX_DMX_UNIVERSE:	printf("ERROR: Universe Number wrong\n");			break; /* universe number wrong */
		case USBDMX_DMX_RX:			printf("ERROR: Reception failed\n");				break; /* reception failed */
		case USBDMX_DMX_RX_NOBREAK:	printf("ERROR: Reception ok, but break missing\n");	break; /* reception failed with no break, according to stardard ignore this frame */
		}
	}

	/* close the interface */
	usbdmx_close(h);

	printf("demo code finished\n");

	getchar();
	return 0;
}
