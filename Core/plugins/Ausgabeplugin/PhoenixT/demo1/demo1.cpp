/*
 * DEMO1.CPP - Demo code on how to use the pusbdmx.dll with load-time 
 * dynamic linking. If the dll is not present this demo will not start.
 * Link you code against pusbdmx.lib.
 *
 * This file is provided as is to allow an easy start with the
 * pusbdmx driver and dll.
 *
 * In case of trouble please contact driver@lighting-solutions.de or
 * call +49/40/600877-51.
 */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

/* the pusbdmx include file with all function definitions */
#include "pusbdmx.h"

int main(int argc, char* argv[])
{
	HANDLE h[32];			/* array of handles to interfaces */
	HANDLE htmp;			/* temorary handle to interface */
	USHORT num_interfaces;	/* count number of interfaces found */
	UCHAR  buffer[0x201];	/* buffer for one dmx512 frame incl. startcode */
	USHORT slots;			/* number of slots received */
	USHORT timestamp;		/* timestamp [ms] returned from pusbdmx_tx and rx */
	UCHAR  status;			/* status information from pusbdmx_tx and rx */
	WCHAR  product[128];	/* array for the interfaces product name */
	USHORT i;			    /* counter for loops */

	/**********************************************************************
	 * following is for checking the DLL
	 */
	
	/* verify PUSBDMX dll version */
	if (!PUSBDMX_DLL_VERSION_CHECK())
	{
		// the pusbdmx.dll found is to old
		printf("PUSBDMX.DLL version does not match, giving up!\n");
		printf("found %i, expected %i\n", pusbdmx_version(), PUSBDMX_DLL_VERSION);
		return 1;
	}

	printf("Using PUSBDMX.DLL version 0x%x\n\n", pusbdmx_version());

	/**********************************************************************
	 * following is for establishing connection to all interfaces present
	 * in this special case, only RodinT interfaces are opend
	 */

    /* open interfaces present */
	num_interfaces = 0;
	for (i=0; num_interfaces < sizeof(h) / sizeof(*h)
				&& pusbdmx_open(i, &htmp); ++i)	/* open all interfaces present */
	{
		/* is the interface found a Phoenix-T */
		if (pusbdmx_is_phoenixt(htmp))
		{	/* yes: save the handle */
			h[num_interfaces] = htmp;
			num_interfaces++;
		}
		else
		{	/* no: ignore this interface */
			pusbdmx_close(htmp);
		}
	}

	if (num_interfaces == 0)
	{
		printf("no pusbdmx-interface available, giving up!\n");
		return 1;
	}

	/* identify all interface */
	printf("Found %i interfaces:\n", num_interfaces);
	for (i=0; i<num_interfaces; ++i)
	{
		/* read product string from interface */
		if (!pusbdmx_product_get(h[i], product, sizeof(product)))
		{
			printf("ERROR: reading product string failed, giving up!\n");
			return 1;
		}
		/* print information */
		printf("  %2i: %ws\n", i, product);
	}

	/* make all interfaces blink according to there number 
	 * this will allow the user to identify which interface
	 * outputs which universe */
	for (i=0; i<num_interfaces; ++i)
		/* let the blue led blink <i> times */
		pusbdmx_id_led_set(h[i], (UCHAR)i+1);

	/**********************************************************************
	 * following is for sending and receiving DMX data
	 */

	/* send a frame on all interfaces */
	for (i=0; i<num_interfaces; ++i)
	{
		/* prepare the dmx frame to be send */
		/* set the startcode, which is always 0 */
		buffer[0] = 0;
		/* copy the dmx data into the buffer*/
		/*memcpy(&buffer[1], dmx_data, sizeof(buffer)-1);*/

		if (!pusbdmx_tx(h[i],						/* handle to the interface */
						0,							/* universe addressed (0 is the DMX-output on all RodinTs */
						513,						/* number of slots to be transmitted, incl. startcode */
						buffer,						/* buffer with dmx data (buffer[0] is the startcode */
						PUSBDMX_BULK_CONFIG_BLOCK,	/* configuration for this frame, see pusbdmx.h for details */
						(float)0.1,					/* parameter for configuration, see pusbdmx.h for details */
						(float)200e-6,				/* length of break [s]. If 0, no break is generated */
						(float)20e-6,				/* length of mark-after-break [s], If 0, no MaB is generated */
						&timestamp,					/* timestamp of the frame [ms] */
						&status))					/* status information */
			printf("pusbdmx_tx(): error!\n");
		/* check transaction status, see pusbdmx.h for details */
		if (!PUSBDMX_BULK_STATUS_IS_OK(status))
			printf("ERROR: pusbdmx_tx(): status = 0x%02x\n", status);
	}

	/* receive a frame on the first interface */
	if (!pusbdmx_rx(h[0],		/* handle to the interface */
					1,			/* universe addressed (1 is the DMX-input on all RodinTs */
					513,		/* number of slots to receive, incl. startcode */
					buffer,		/* buffer for the received data */
					(float)0.1,	/* timeout to receive the total frame [s] */
					(float)1e-3,/* timeout to receive the next slot [s] */
					&slots,		/* number of slots received */
					&timestamp,	/* timestamp of the frame */
					&status))	/* status information */
		printf("pusbdmx_rx(): error!\n");
	/* check transaction status, see pusbdmx.h for details */
	if (!PUSBDMX_BULK_STATUS_IS_OK(status))
	{
		if (status == PUSBDMX_BULK_STATUS_TIMEOUT)
			printf("INFO: pusbdmx_rx() timed out, no frame received\n");
		else
			printf("ERROR: pusbdmx_rx(): status = 0x%02x\n", status);
	}
	else
	{
		/* check if the startcode is 0 */
		if (buffer[0] == 0)
		{	/* yes: the frame is valid */
			/* use the received data buffer[1..end] */
		}
	}

	/**********************************************************************
	 * following is for closing connection to all interfaces
	 */
	for (i=0; i<num_interfaces; ++i)
		pusbdmx_close(h[i]);

	printf("demo code finished\n");

	getchar();
	return 0;
}
