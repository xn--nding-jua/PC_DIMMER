#include "pro_driver.h"


// old school globals
DMXUSBPROParamsType PRO_Params;
FT_HANDLE device_handle = NULL ;

#if SET_PORT_ASSIGNMENT_LABEL == 0
#error PRO MK2 LABELS NOT DEFINED
#endif

/* Function : FTDI_ClosePort
 * Author	: ENTTEC
 * Purpose  : Closes the Open DMX USB PRO Device Handle
 * Parameters: none
 **/
void FTDI_ClosePort()
{
	if (device_handle != NULL)
		FT_Close(device_handle);
}

/* Function : FTDI_ListDevices
 * Author	: ENTTEC
 * Purpose  : Returns the no. of PRO's conneced to the PC
 * Parameters: none
 **/
int FTDI_ListDevices()
{
	FT_STATUS ftStatus;
	DWORD numDevs=0;
	ftStatus = FT_ListDevices((PVOID)&numDevs,NULL,FT_LIST_NUMBER_ONLY);
	if(ftStatus == FT_OK) 
		return numDevs;
	return NO_RESPONSE; 
}

void FTDI_Reload()
{
	WORD wVID = 0x0403;
	WORD wPID = 0x6001;
	FT_STATUS ftStatus;

	printf ("\nReloading devices for use with drivers ");	
	ftStatus = FT_Reload(wVID,wPID);
	// Must wait a while for devices to be re-enumerated
	Sleep(3500);
	if(ftStatus != FT_OK)
	{
		printf("\nReloading Driver FAILED");
	}
	else
		printf("\nReloading Driver D2XX PASSED");
}

/* Function : FTDI_SendData
 * Author	: ENTTEC
 * Purpose  : Send Data (DMX or other packets) to the PRO
 * Parameters: Label, Pointer to Data Structure, Length of Data
 **/
int FTDI_SendData(int label, unsigned char *data, int length)
{
	unsigned char end_code = DMX_END_CODE;
	FT_STATUS res = 0;
	DWORD bytes_to_write = length;
	DWORD bytes_written = 0;
	HANDLE event = NULL;
	int size=0;
	// Form Packet Header
	unsigned char header[DMX_HEADER_LENGTH];
	header[0] = DMX_START_CODE;
	header[1] = label;
	header[2] = length & OFFSET;
	header[3] = length >> BYTE_LENGTH;
	// Write The Header
	res = FT_Write(	device_handle,(unsigned char *)header,DMX_HEADER_LENGTH,&bytes_written);
	if (bytes_written != DMX_HEADER_LENGTH) return  NO_RESPONSE;
	// Write The Data
	res = FT_Write(	device_handle,(unsigned char *)data,length,&bytes_written);
	if (bytes_written != length) return  NO_RESPONSE;
	// Write End Code
	res = FT_Write(	device_handle,(unsigned char *)&end_code,ONE_BYTE,&bytes_written);
	if (bytes_written != ONE_BYTE) return  NO_RESPONSE;
	if (res == FT_OK)
		return TRUE;
	else
		return FALSE; 
}

/* Function : FTDI_ReceiveData
 * Author	: ENTTEC
 * Purpose  : Receive Data (DMX or other packets) from the PRO
 * Parameters: Label, Pointer to Data Structure, Length of Data
 **/
int FTDI_ReceiveData(int label, unsigned char *data, unsigned int expected_length)
{

	FT_STATUS res = 0;
	DWORD length = 0;
	DWORD bytes_to_read = 1;
	DWORD bytes_read =0;
	unsigned char byte = 0;
	HANDLE event = NULL;
	char buffer[600];
	// Check for Start Code and matching Label
	while (byte != label)
	{
		while (byte != DMX_START_CODE)
		{
			res = FT_Read(device_handle,(unsigned char *)&byte,ONE_BYTE,&bytes_read);
			if(bytes_read== NO_RESPONSE) return  NO_RESPONSE;
		}
		res = FT_Read(device_handle,(unsigned char *)&byte,ONE_BYTE,&bytes_read);
		if (bytes_read== NO_RESPONSE) return  NO_RESPONSE;
	}
	// Read the rest of the Header Byte by Byte -- Get Length
	res = FT_Read(device_handle,(unsigned char *)&byte,ONE_BYTE,&bytes_read);
	if (bytes_read== NO_RESPONSE) return  NO_RESPONSE;
	length = byte;
	res = FT_Read(device_handle,(unsigned char *)&byte,ONE_BYTE,&bytes_read);
	if (res != FT_OK) return  NO_RESPONSE;
	length += ((uint32_t)byte)<<BYTE_LENGTH;	
	// Check Length is not greater than allowed
	if (length > 600)
	{
		printf("error: recieved length exceeds limit !");
		return  NO_RESPONSE;
	}
	// Read the actual Response Data
	res = FT_Read(device_handle,buffer,length,&bytes_read);
	if(bytes_read != length) return  NO_RESPONSE;
	// Check The End Code
	res = FT_Read(device_handle,(unsigned char *)&byte,ONE_BYTE,&bytes_read);
	if(bytes_read== NO_RESPONSE) return  NO_RESPONSE;
	if (byte != DMX_END_CODE) return  NO_RESPONSE;
	// Copy The Data read to the buffer passed
	memcpy(data,buffer,expected_length);
	return TRUE;
}

/* Function : FTDI_PurgeBuffer
 * Author	: ENTTEC
 * Purpose  : Clears the buffer used internally by the PRO
 * Parameters: none
 **/
void FTDI_PurgeBuffer()
{
	FT_Purge (device_handle,FT_PURGE_TX);
	FT_Purge (device_handle,FT_PURGE_RX);
}


/* Function : FTDI_OpenDevice
 * Author	: ENTTEC
 * Purpose  : Opens the PRO; Tests various parameters; outputs info
 * Parameters: device num (returned by the List Device fuc), Fw Version MSB, Fw Version LSB 
 **/
uint16_t FTDI_OpenDevice(int device_num)
{
	int ReadTimeout = 120;
	int WriteTimeout = 100;
	int VersionMSB =0;
	int VersionLSB =0;
	uint8_t temp[4];
	long version;
	uint8_t major_ver,minor_ver,build_ver;
	int recvd =0;
	unsigned char byte = 0;
	int size = 0;
	int res = 0;
	int tries =0;
	uint8_t latencyTimer;
	FT_STATUS ftStatus;
	int BreakTime;
	int MABTime;

	// Try at least 3 times 
	do  {
		printf("\n------ D2XX ------- Opening [Device %d] ------ Try %d",device_num,tries);
		ftStatus = FT_Open(device_num,&device_handle);
		Sleep(500);
		tries ++;
	} while ((ftStatus != FT_OK) && (tries < 3));

	if (ftStatus == FT_OK) 
	{
		// D2XX Driver Version
		ftStatus = FT_GetDriverVersion(device_handle,(LPDWORD)&version);
		if (ftStatus == FT_OK) 
		{
			major_ver = (uint8_t) version >> 16;
			minor_ver = (uint8_t) version >> 8;
			build_ver = (uint8_t) version & 0xFF;
			printf("\nD2XX Driver Version:: %02X.%02X.%02X ",major_ver,minor_ver,build_ver);
		}
		else
			printf("Unable to Get D2XX Driver Version") ;

		// Latency Timer
		ftStatus = FT_GetLatencyTimer (device_handle,(PUCHAR)&latencyTimer);
		if (ftStatus == FT_OK) 
			printf("\nLatency Timer:: %d ",latencyTimer);		
		else
			printf("\nUnable to Get Latency Timer") ;
		
		// These are important values that can be altered to suit your needs
		// Timeout in microseconds: Too high or too low value should not be used 
		FT_SetTimeouts(device_handle,ReadTimeout,WriteTimeout); 
		// Buffer size in bytes (multiple of 4096) 
		FT_SetUSBParameters(device_handle,RX_BUFFER_SIZE,TX_BUFFER_SIZE);
		// Good idea to purge the buffer on initialize
		FT_Purge (device_handle,FT_PURGE_RX);

		// Send Get Widget Params to get Device Info
		printf("Sending GET_WIDGET_PARAMS packet... ");
 		res = FTDI_SendData(GET_WIDGET_PARAMS,(unsigned char *)&size,2);
		if (res == NO_RESPONSE)
		{
			FT_Purge (device_handle,FT_PURGE_TX);
 			res = FTDI_SendData(GET_WIDGET_PARAMS,(unsigned char *)&size,2);
			if (res == NO_RESPONSE)
			{
				FTDI_ClosePort();
				return  NO_RESPONSE;
			}
		}
		else
			printf("\n PRO Connected Succesfully");
		// Receive Widget Response
		printf("\nWaiting for GET_WIDGET_PARAMS_REPLY packet... ");
		res=FTDI_ReceiveData(GET_WIDGET_PARAMS_REPLY,(unsigned char *)&PRO_Params,sizeof(DMXUSBPROParamsType));
		if (res == NO_RESPONSE)
		{
			res=FTDI_ReceiveData(GET_WIDGET_PARAMS_REPLY,(unsigned char *)&PRO_Params,sizeof(DMXUSBPROParamsType));
			if (res == NO_RESPONSE)
			{
				FTDI_ClosePort();
				return  NO_RESPONSE;
			}
		}
		else
			printf("\n GET WIDGET REPLY Received ... ");
		// Firmware  Version
		VersionMSB = PRO_Params.FirmwareMSB;
		VersionLSB = PRO_Params.FirmwareLSB;
		// Display All Info avialable
		res = FTDI_SendData(GET_WIDGET_SN,(unsigned char *)&size,2);
		res=FTDI_ReceiveData(GET_WIDGET_SN,(unsigned char *)&temp,4);
		printf("\n\n-----------::USB PRO Connected [Information Follows]::------------");
		printf("\n\t  FIRMWARE VERSION: %d.%d",VersionMSB,VersionLSB);
		BreakTime = (int) (PRO_Params.BreakTime * 10.67) + 100;
		printf("\n\t  BREAK TIME: %d micro sec ",BreakTime);
		MABTime = (int) (PRO_Params.MaBTime * 10.67);
		printf("\n\t  MAB TIME: %d micro sec",MABTime);
		printf("\n\t  SEND REFRESH RATE: %d packets/sec",PRO_Params.RefreshRate);
		printf("\n----------------------------------------------------------------\n\n");
		return TRUE;
	}		
	else // Can't open Device 
		return FALSE;
}


/* Function : init_promk2
 * Author	: ENTTEC
 * Purpose  : Activates the PRO MK2; Sets both Ports for DMX 
 * Parameters: none
 * Notes: use the Key in your API to activate the PRO MK2
 **/
void init_promk2()
{
	unsigned char* MyKey = APIKey;
	uint8_t PortSet[] = {1,1};
	BOOL res = 0;

	FTDI_PurgeBuffer();
	res = FTDI_SendData(SET_API_KEY_LABEL,MyKey,4);
	Sleep(200);
	printf("\nPRO Mk2 ... Activated ... ");

	// Enable Ports to DMX on both 
	res = FTDI_SendData(SET_PORT_ASSIGNMENT_LABEL,PortSet,2);
	Sleep(200);
	printf("\nPRO Mk2 ... Ready for DMX on both ports ... ");
}

/* Function : enable_midi
 * Author	: ENTTEC
 * Purpose  : Enables MIDI on Port2  
 * Parameters: none
 **/
void enable_midi()
{
	uint8_t PortSet[] = {1,2};
	BOOL res = 0;

	FTDI_PurgeBuffer();
	// Enable Ports to DMX on port1 and MIDI on Port2
	res = FTDI_SendData(SET_PORT_ASSIGNMENT_LABEL,PortSet,2);
	Sleep(200);
	printf("\nPRO Mk2 ... Ready for MIDI and DMX1 ... ");
}

/* Function : SendDMX
 * Author	: ENTTEC
 * Purpose  : Send DMX via the USB PRO  
 * Parameters: PortLabel: the label tells which port to send DMX on 
 * Note     : Use the keys in your API to send DMX to Port 2  	
 **/
void SendDMX(int PortLabel)
{
	unsigned char myDmx[513];
	int counter = 100;
	BOOL res =0; 
	if (device_handle != NULL)
	{
		// Looping to Send DMX data
		printf("\n Press Enter to Send DMX data :");
		_getch();
		for (int i = 0; i < counter ; i++)
		{
			// sets the channels to increasing value: 1=1, 2=2 etc ....
			memset(myDmx,i,sizeof(myDmx));

			// First byte has to be 0
			myDmx[0] = 0;

			// send the array here
			res = FTDI_SendData(PortLabel, myDmx, 513);
			if (res < 0)
			{
				printf("\nFAILED to send DMX ... exiting");
				FTDI_ClosePort();
				break;
			}
			printf("\nDMX Data from 0 to 10: ");
			for (int j = 0; j <= 8; j++)
				printf (" %d ",myDmx[j]);
			printf("Iteration: %d", i);
				
		}
	}
}

/* Function : ReceiveDMX
 * Author	: ENTTEC
 * Purpose  : Recieve DMX via the USB PRO  
 * Parameters: PortLabel: the label tells which port to receive DMX from 
 * Note     : Use the keys in your API to receive DMX from Port 2  	
 **/
void ReceiveDMX(int PortLabel)
{
	unsigned char myDmxIn[513];
	BOOL res =0; 
	if (device_handle != NULL)
	{
		// Looping to receiving DMX data
		printf("\nPress Enter to receive DMX data :");
		_getch();
		printf("\nSetting the widget to receive all DMX data ... ");
		unsigned char send_on_change_flag = 0;
		res = FTDI_SendData(RECEIVE_DMX_ON_CHANGE,&send_on_change_flag,1);
		if (res < 0)
		{
			printf("DMX Receive FAILED\n");
			FTDI_ClosePort();
			return;
		}
		memset(myDmxIn,0,513);
		/* Will receive 99 dmx packets from the PRO MK2
		** For real-time scenarios, read in a while loop in a separate thread 
		**/
		for (int i = 0; i < 99 ; i++)
		{
			res = FTDI_ReceiveData(PortLabel, myDmxIn, 513);
			if (res != TRUE)
				printf("\nerror: DMX Receive FAILED ...  \n");
			printf("\nDMX Data from 0 to 512: ");
			for (int j = 0; j <= 512; j++){
				printf (" %d ",myDmxIn[j]);
			}
			printf("Iteration: %d", i+1);
			Sleep(10);
		}
	}
}

/* Function : SendMIDI
 * Author	: ENTTEC
 * Purpose  : Send MIDI via the PRO MK2
 * Parameters: PortLabel: the label tells PRO MK2 to send MIDI
 *			 : channel, note & velocity for the MIDI to send
 * Note     : Use the SEND MIDI Label in your API to send MIDI	
 **/
void SendMIDI(int PortLabel, unsigned char channel, unsigned char note, unsigned char velocity)
{
	unsigned char MyData[3];
	int counter = 10;
	BOOL res =0; 
	if (device_handle != NULL)
	{
		// Looping to Send MIDI data
		printf("\n Press Enter to Send MIDI data :");
		_getch();
		for (int i = 0; i < counter ; i++)
		{
			MyData[0] = channel;
			MyData[1] = note;
			MyData[2] = velocity;

			// send the array here
			res = FTDI_SendData(PortLabel, MyData, 3);
			if (res < 0)
			{
				printf("\nFAILED to send MIDI ... exiting");
				FTDI_ClosePort();
				break;
			}
			printf("\nMIDI Data: ");
			for (int j = 0; j <= 2; j++)
				printf (" %d ",MyData[j]);
			printf("Iteration: %d", i);
			Sleep(500);				
		}
	}
}

/* Function : ReceiveMIDI
 * Author	: ENTTEC
 * Purpose  : Receive MIDI via the USB PRO  
 * Parameters: PortLabel: the label tells PRO MK2 to recieve MIDI
 * Note     : Use the Receive MIDI Label in your API to  recieve MIDI
 **/
void ReceiveMIDI(int PortLabel)
{
	unsigned char MyData[3];
	int counter = 20;
	BOOL res =0; 
	if (device_handle != NULL)
	{
		// Looping to receiving MIDI data
		printf("\nPress Enter to receive MIDI data :");
		_getch();
		for (int i = 0; i < counter ; i++)
		{
			memset(MyData,0,3);
			res = FTDI_ReceiveData(PortLabel, MyData, 3);
			if (res < 0)
			{
				printf("MIDI Receive FAILED ... exiting \n");
				FTDI_ClosePort();
				break;
			}
			printf("\nMIDI Data : ");
			for (int j = 0; j <= 2; j++){
				printf (" %02X ",MyData[j]);
			}
			printf("Iteration: %d", i);
		}
	}
}


// our good main function with everything to do the test
int main(int argc, char**argv)
{
	uint8_t Num_Devices =0;
	uint16_t device_connected =0;
	uint8_t hversion;
	int i=0;
	int device_num=0;
	BOOL res = 0;

	printf("\nEnttec Pro - C - Windows - Sample Test\n");
	printf("\nLooking for USB PRO's connected to PC ... ");
	
	// If you face problems identifying the PRO: Use this code to reload device drivers: takes a few secs
	// FTDI_Reload();

	// Just to make sure the Device is correct
	printf("\n Press Enter to Intialize Device :");
	_getch();
	Num_Devices = FTDI_ListDevices(); 
	// Number of Found Devices
	if (Num_Devices == 0)
	{
		printf("\n Looking for Devices  - 0 Found");
	}
	else
	{
		// If you want to open all; use for loop
		// we'll open the first one only
		 for (i=0;i<Num_Devices;i++)
		 {
			if (device_connected)
				break;
			device_num = i;
			device_connected = FTDI_OpenDevice(device_num);		
		 }

		//SendDMX(SEND_DMX_PORT1);
		ReceiveDMX(RECEIVE_DMX_PORT1);

		// Clear the buffer
		FTDI_PurgeBuffer();
		// Check if device is Pro Mk2 ?
		res = FTDI_SendData(HARDWARE_VERSION_LABEL,NULL,0);
		res = FTDI_ReceiveData(HARDWARE_VERSION_LABEL,(unsigned char *)&hversion,1);
		if (hversion == 2)
		{
			printf("\nPRO Mk2 found ... Sending Init Messages ...");
			init_promk2();

			// Send and Receive DMX on PORT2
			SendDMX(SEND_DMX_PORT2);
			ReceiveDMX(RECEIVE_DMX_PORT2);

			// Send and Recieve MIDI 
			enable_midi();
			SendMIDI(SEND_MIDI_PORT,10,20,0x12);
			ReceiveMIDI(RECEIVE_MIDI_PORT);
		}		

	}

	// Finish all done
	printf("\n Press Enter to Exit :");
	_getch();
	return 0;
}