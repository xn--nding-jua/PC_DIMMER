//
// (c) 2008 by Markus Siwek
//
//////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __DMX4ALLDEFS_H_
#define __DMX4ALLDEFS_H_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

typedef struct structVersionInfoStruct
{
	char		InterfaceInfo[500];
	DWORD		HW_Version;
	DWORD		NrOfDmxData;
	BOOL		SignalOutput;
	BYTE		MergeMode;
	WORD		MergeStart;
	WORD		MergeStop;
} VERSION_INFO;

#define	USB_PORT	256

typedef bool (__stdcall *DLL_SETUNIVERSE)(int);
typedef bool (__stdcall *DLL_OPENPORT)(int);
typedef bool (__stdcall *DLL_CLOSEPORT)();
typedef bool (__stdcall *DLL_CHECKPORT)(int);
typedef bool (__stdcall *DLL_FINDINTERFACE)(int);
typedef bool (__stdcall *DLL_SETDMXCH)(int, BYTE);
typedef bool (__stdcall *DLL_SETDMX)(int, int, BYTE*);
typedef bool (__stdcall *DLL_GETDMX)(int, int, BYTE*);
typedef bool (__stdcall *DLL_GETCOMPARAM)(int*,DWORD*);
typedef bool (__stdcall *DLL_SETCOMPARAM)(UINT);
typedef bool (__stdcall *DLL_SETMINCHANNELS)(int);
typedef bool (__stdcall *DLL_GETNROFCHANNELS)(int*);
typedef bool (__stdcall *DLL_SETPINOUT)(bool);
typedef bool (__stdcall *DLL_RUNLIGHTSCENE)(int);
typedef bool (__stdcall *DLL_GETLIGHTSCENE)(int*);
typedef bool (__stdcall *DLL_GETINDMX)(int,int,BYTE*);
typedef bool (__stdcall *DLL_SETMERGE)(bool,int,int,int);
typedef bool (__stdcall *DLL_WRITEMEMDATA)(WORD , BYTE* );
typedef bool (__stdcall *DLL_UPDATEFIRMWARE)();
typedef bool (__stdcall *DLL_GETINFO)(VERSION_INFO*);
typedef bool (__stdcall *DLL_GETPRODUCTID)(int*);
typedef bool (__stdcall *DLL_READEEPROM)(UINT,UINT*,BYTE*);
typedef bool (__stdcall *DLL_SETPINOUT)(bool);
typedef bool (__stdcall *DLL_SETBLACKOUT)(bool);
typedef bool (__stdcall *DLL_GETBLACKOUT)(bool*);
typedef bool (__stdcall *DLL_SETLCDBACKLIGHT)(bool);
typedef bool (__stdcall *DLL_SETNROFLCDLINES)(int);
typedef bool (__stdcall *DLL_REBOOTINTERFACE)();
typedef bool (__stdcall *DLL_SETUP)(char* ,int);

typedef bool (__stdcall *DLL_CREATEINTERFACELIST)(DWORD*);
typedef bool (__stdcall *DLL_DELETEINTERFACELIST)();
typedef bool (__stdcall *DLL_GETINTERFACEDETAIL)(DWORD,DWORD*,char*,int);

#endif // __DMX4ALLDEFS_H_
