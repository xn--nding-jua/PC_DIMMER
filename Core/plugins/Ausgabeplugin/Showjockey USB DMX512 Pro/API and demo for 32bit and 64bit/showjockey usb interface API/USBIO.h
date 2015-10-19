extern "C" {
		__declspec(dllexport) BOOL _stdcall USBIO_GetDllVersion(PCHAR strVersion); 
		__declspec(dllexport) DWORD _stdcall USBIO_GetDeviceCount(PCHAR pVID_PID);
		__declspec(dllexport) HANDLE _stdcall USBIO_OpenDevice(DWORD dwDeviceNum, PCHAR pVID_PID);  // Input <Future Use>
		__declspec(dllexport) USHORT  _stdcall USBIO_SendDmx(HANDLE hDrive, PUCHAR txBuffer, USHORT txLen);
		__declspec(dllexport) DWORD  _stdcall USBIO_RecvDmx(HANDLE hDrive, unsigned char * pBuffer);
		__declspec(dllexport) BOOL _stdcall USBIO_CloseDevice(HANDLE hDriver);
		__declspec(dllexport) USHORT  _stdcall USBIO_GetDeviceType(HANDLE hDrive);
}