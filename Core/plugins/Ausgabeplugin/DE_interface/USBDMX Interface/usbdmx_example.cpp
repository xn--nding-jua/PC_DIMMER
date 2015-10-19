#include <stdio.h>
#include <windows.h>

// types for library functions
typedef unsigned char TDMXArray[512];
typedef char TSERIAL[16];
typedef TSERIAL TSERIALLIST[32];
typedef void (STDCALL* THOSTDEVICECHANGEPROC) (void);

// define library functions
typedef void (STDCALL* TGetAllConnectedInterfaces) (TSERIALLIST* SerialList);
TGetAllConnectedInterfaces GetAllConnectedInterfaces;
typedef void (STDCALL* TGetAllOpenedInterfaces) (TSERIALLIST* SerialList);
TGetAllOpenedInterfaces GetAllOpenedInterfaces;
typedef DWORD (STDCALL* TSetInterfaceMode) (TSERIAL Serial, unsigned char Mode);
TSetInterfaceMode SetInterfaceMode;
typedef DWORD (STDCALL* TOpenLink) (TSERIAL Serial, TDMXArray *DMXOutArray, TDMXArray *DMXInArray);
TOpenLink OpenLink;
typedef DWORD (STDCALL* TCloseLink) (TSERIAL Serial);
TCloseLink CloseLink;
typedef DWORD (STDCALL* TCloseAllLinks) (void);
TCloseAllLinks CloseAllLinks;
typedef DWORD (STDCALL* TRegisterInterfaceChangeNotification) (THOSTDEVICECHANGEPROC Proc);
TRegisterInterfaceChangeNotification RegisterInterfaceChangeNotification;
typedef DWORD (STDCALL* TUnregisterInterfaceChangeNotification) (void);
TUnregisterInterfaceChangeNotification UnregisterInterfaceChangeNotification;
typedef DWORD (STDCALL* TRegisterInputChangeNotification) (THOSTDEVICECHANGEPROC Proc);
TRegisterInputChangeNotification RegisterInputChangeNotification;
typedef DWORD (STDCALL* TUnregisterInputChangeNotification) (void);
TUnregisterInputChangeNotification UnregisterInputChangeNotification;

void InterfaceChange(void) {
  printf("Interface configuration has changed\n");
}

void InputChange(void) {
  printf("Input has changed\n");
}

int main(int argc, char *argv[])
{

  HINSTANCE dll_handle = LoadLibrary("usbdmx.dll");

  // Get library function addresses
  GetAllConnectedInterfaces = (TGetAllConnectedInterfaces)GetProcAddress(dll_handle, "GetAllConnectedInterfaces");
  GetAllOpenedInterfaces = (TGetAllOpenedInterfaces)GetProcAddress(dll_handle, "GetAllOpenedInterfaces");
  SetInterfaceMode = (TSetInterfaceMode)GetProcAddress(dll_handle, "SetInterfaceMode");
  OpenLink = (TOpenLink)GetProcAddress(dll_handle, "OpenLink");
  CloseLink = (TCloseLink)GetProcAddress(dll_handle, "CloseLink");
  CloseAllLinks = (TCloseAllLinks)GetProcAddress(dll_handle, "CloseAllLinks");
  RegisterInterfaceChangeNotification = (TRegisterInterfaceChangeNotification)GetProcAddress(dll_handle, "RegisterInterfaceChangeNotification");
  UnregisterInterfaceChangeNotification = (TUnregisterInterfaceChangeNotification)GetProcAddress(dll_handle, "UnregisterInterfaceChangeNotification");
  RegisterInputChangeNotification = (TRegisterInputChangeNotification)GetProcAddress(dll_handle, "RegisterInputChangeNotification");
  UnregisterInputChangeNotification = (TUnregisterInputChangeNotification)GetProcAddress(dll_handle, "UnregisterInputChangeNotification");

  // "InterfaceList" is filled by "GetAllConnectedInterfaces" or "GetAllOpenedInterfaces"
  // It contains the serials of up to 32 connected interfaces. A serial (16 characters) is
  // an array of char with a fixed length of 16, it is not a null terminated string (there is no null-termination)
  TSERIALLIST InterfaceList;

  // "DMX_Out" "DMX_In" are the DMX data buffers
  TDMXArray DMX_Out, DMX_In;

  // You can (optional) register a parameterless function which will be called when an interface is connected/disconnected
  RegisterInterfaceChangeNotification(&InterfaceChange);

  // You can (optional) register a parameterless function which will be called if at least one interface is configurated in input mode and some input channels have changed
  RegisterInputChangeNotification(&InputChange);

  // Here you get the list of all connected interfaces. If the value (serial) of "0000000000000000" occurs in the list then there are no more interfaces connected
  GetAllConnectedInterfaces(&InterfaceList);

  // With this function you open a link to the specified interface. Also you have to turn over the pointer to your DMX buffers.
  // The first pointer points to the DMX out buffer (PC -> Interface), the second to the DMX in buffer (Interface -> PC)
  // If you don't use either DMX output or DMX input you can set the corresponding pointer to zero.
  // (In this example simply the first interface of the list returned from "GetAllConnectedInterfaces" is opened without testing if there is connected any interface to the PC)
  OpenLink(InterfaceList[0], &DMX_Out, &DMX_In);

  // If you would call "GetAllOpenedInterfaces" here you'd get a list that contains only one valid serial: InterfaceList[0]

  // Now you can set the mode of the specified interface (a link must be opened).
  // The following modes are allowed:
  // 0: Do nothing - Standby
  // 1: DMX In -> DMX Out
  // 2: PC Out -> DMX Out
  // 3: DMX In + PC Out -> DMX Out
  // 4: DMX In -> PC In
  // 5: DMX In -> DMX Out & DMX In -> PC In
  // 6: PC Out -> DMX Out & DMX In -> PC In
  // 7: DMX In + PC Out -> DMX Out & DMX In -> PC In
  // If you want simply write to the DMX output use mode 2, if you want also read the DMX input use mode 6
  SetInterfaceMode(InterfaceList[0], 6);

  // Your main programm loop
  while (getc(stdin) != 'e') {

    // Now you can write to your DMX out buffer. The dll detects any change and the new values are transmitted to the interface
    DMX_Out[0] = 1;
    DMX_Out[1] = 2;
    DMX_Out[2] = 3;
    DMX_Out[3] = 4;
    //... and so on ...

    // Or you can read from the DMX input. If you have registered a function with "RegisterInputChangeNotification" it will be called everytime a channel changes it's value.
    // Every time the function is called up to 32 channels may have changed their value. Please hold the registered function as short as possible (< 1ms execution time)
    unsigned char tmp;
    tmp = DMX_In[0];
    tmp = DMX_In[1];
    tmp = DMX_In[2];
    tmp = DMX_In[3];
    //... and so on ...

    Sleep(10);
  }

  // At the end of the programm you should clean up a little
  CloseLink(InterfaceList[0]);
  UnregisterInputChangeNotification;
  UnregisterInterfaceChangeNotification;

  FreeLibrary(dll_handle);
  return 0;
}
