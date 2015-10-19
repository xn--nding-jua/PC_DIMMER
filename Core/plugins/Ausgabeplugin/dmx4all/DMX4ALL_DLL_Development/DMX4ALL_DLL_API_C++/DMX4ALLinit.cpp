//
// (c) 2008 by DMX4ALL, Markus Siwek
//
//////////////////////////////////////////////////////////////////////////////////////////////////

// These are system header files
#include <Afx.h>

// These are the DMX4ALL header files
#include "DMX4ALLinit.h"
#include "DMX4ALLdefs.h"

HINSTANCE				hDMX4ALL_dll = NULL;

DLL_SETUNIVERSE			pfSetUniverse;
DLL_OPENPORT			pfOpenPort;
DLL_CLOSEPORT			pfClosePort;
DLL_CHECKPORT			pfCheckPort;
DLL_FINDINTERFACE		pfFindInterface;
DLL_SETMINCHANNELS		pfSetMinChannels;
DLL_GETNROFCHANNELS		pfGetNrOfChannelsOut;
DLL_GETNROFCHANNELS		pfGetNrOfChannelsIn;
DLL_SETDMX				pfSetDmx;
DLL_GETDMX				pfGetDmx;
DLL_SETDMXCH			pfSetDmxCh;
DLL_GETCOMPARAM			pfGetComParameters;
DLL_SETCOMPARAM			pfSetComParameters;
DLL_SETPINOUT			pfSetPinout;
DLL_RUNLIGHTSCENE		pfRunLightScene;
DLL_GETINDMX			pfGetInDmx;
DLL_SETMERGE			pfSetMerge;
DLL_WRITEMEMDATA		pfWriteMemoryData;
DLL_UPDATEFIRMWARE		pfUpdateFirmware;
DLL_GETINFO				pfGetInfo;
DLL_GETPRODUCTID		pfGetProductID;
DLL_SETBLACKOUT			pfSetBlackOut;
DLL_GETBLACKOUT			pfGetBlackOut;
DLL_SETNROFLCDLINES		pfSetNrOfLcdLines;
DLL_SETPINOUT			pfSetFadeBetweenScenes;
DLL_SETPINOUT			pfSetLcdBacklight;
DLL_REBOOTINTERFACE		pfRebootInterface;
DLL_SETUP				pfSetup;
DLL_READEEPROM			pfReadEEPROM;

DLL_CREATEINTERFACELIST	pfCreateInterfaceList;
DLL_DELETEINTERFACELIST	pfDeleteInterfaceList;
DLL_GETINTERFACEDETAIL	pfGetInterfaceDetail;

bool Dmx4allDllOpen()
{
	hDMX4ALL_dll = LoadLibrary("DMX4ALL.dll");
	if (hDMX4ALL_dll)
	{
		pfSetUniverse			= (DLL_SETUNIVERSE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetUniverse");
		pfOpenPort				= (DLL_OPENPORT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__OpenPort");
		pfClosePort				= (DLL_CLOSEPORT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__ClosePort");
		pfFindInterface			= (DLL_FINDINTERFACE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__FindInterface");
		pfCheckPort				= (DLL_CHECKPORT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__CheckPort");
		pfSetMinChannels		= (DLL_SETMINCHANNELS)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetMinChannels");
		pfGetNrOfChannelsOut	= (DLL_GETNROFCHANNELS)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetNrOfChannelsOut");
		pfGetNrOfChannelsIn		= (DLL_GETNROFCHANNELS)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetNrOfChannelsIn");
		pfSetDmx				= (DLL_SETDMX)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetDmx");
		pfGetDmx				= (DLL_GETDMX)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetDmx");
		pfSetDmxCh				= (DLL_SETDMXCH)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetDmxCh");
		pfGetComParameters		= (DLL_GETCOMPARAM)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetComParameters");
		pfSetComParameters		= (DLL_SETCOMPARAM)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetComParameters");
		pfSetPinout				= (DLL_SETPINOUT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetPinout");
		pfRunLightScene			= (DLL_RUNLIGHTSCENE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__RunLightScene");
		pfGetInDmx				= (DLL_GETINDMX)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetInDmx");
		pfSetMerge				= (DLL_SETMERGE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetMerge");
		pfWriteMemoryData		= (DLL_WRITEMEMDATA)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__WriteMemoryData");
		pfUpdateFirmware		= (DLL_UPDATEFIRMWARE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__UpdateFirmware");
		pfGetInfo				= (DLL_GETINFO)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetInfo");
		pfGetProductID			= (DLL_GETPRODUCTID)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetProductID");
		pfSetBlackOut			= (DLL_SETBLACKOUT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetBlackOut");
		pfGetBlackOut			= (DLL_GETBLACKOUT)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetBlackOut");
		pfSetNrOfLcdLines		= (DLL_SETNROFLCDLINES)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__SetNrOfLcdLines");
		pfRebootInterface		= (DLL_REBOOTINTERFACE)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__RebootInterface");
		pfSetup					= (DLL_SETUP)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__Setup");
		pfReadEEPROM			= (DLL_READEEPROM)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__ReadEEPROM");

		pfCreateInterfaceList	= (DLL_CREATEINTERFACELIST)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__CreateInterfaceList");
		pfDeleteInterfaceList	= (DLL_DELETEINTERFACELIST)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__DeleteInterfaceList");
		pfGetInterfaceDetail	= (DLL_GETINTERFACEDETAIL)::GetProcAddress((HMODULE)hDMX4ALL_dll, "__GetInterfaceDetail");

		return true;
	}
	Dmx4allDllClose();
	return false;
}

bool Dmx4allSetUniverse(int Universe)
{
	if (hDMX4ALL_dll && pfSetUniverse)
		return (*pfSetUniverse)(Universe);
	return false;
}

bool Dmx4allDllClose()
{
	Dmx4allClosePort();
	if (hDMX4ALL_dll!=NULL)
		if(FreeLibrary(hDMX4ALL_dll) != 0)
			return true;
	return false;
}

bool Dmx4allOpenPort(int Port)
{
	if (hDMX4ALL_dll && pfOpenPort)
		return (*pfOpenPort)(Port);
	return false;
}

bool Dmx4allSetComPort(int Port)
{
	return Dmx4allOpenPort(Port);
}

bool Dmx4allClosePort()
{
	if (hDMX4ALL_dll && pfClosePort)
		return (*pfClosePort)();
	return false;
}

bool Dmx4allClearComPort()
{
	return Dmx4allClosePort();
}

bool Dmx4allCheckPort(int Port)
{
	if (hDMX4ALL_dll && pfCheckPort)
		return (*pfCheckPort)(Port);
	return false;
}

bool Dmx4allCheckComPort(int Port)
{
	return Dmx4allCheckPort(Port);
}

bool Dmx4allFindInterface(int MaxPort)
{
	if (hDMX4ALL_dll && pfFindInterface)
		return (*pfFindInterface)(MaxPort);
	return false;
}

bool Dmx4allCreateInterfaceList(DWORD* numDevs)
{
	if (hDMX4ALL_dll && pfCreateInterfaceList)
		return (*pfCreateInterfaceList)(numDevs);
	return false;
}

bool Dmx4allDeleteInterfaceList()
{
	if (hDMX4ALL_dll && pfDeleteInterfaceList)
		return (*pfDeleteInterfaceList)();
	return false;
}

bool Dmx4allGetInterfaceDetail(DWORD index, DWORD* PortIndex, char* pDescription,int Length)
{
	if (hDMX4ALL_dll && pfGetInterfaceDetail)
		return (*pfGetInterfaceDetail)(index,PortIndex,pDescription,Length);
	return false;
}

bool Dmx4allSetMinChannels(int Channels)
{
	if (hDMX4ALL_dll && pfSetMinChannels)
		return (*pfSetMinChannels)(Channels);
	return false;
}

bool Dmx4allGetNrOfChannelsOut(int* NrOfChannels)
{
	if (hDMX4ALL_dll && pfGetNrOfChannelsOut)
		return (*pfGetNrOfChannelsOut)(NrOfChannels);
	return false;
}

bool Dmx4allGetNrOfChannelsIn(int* NrOfChannels)
{
	if (hDMX4ALL_dll && pfGetNrOfChannelsIn)
		return (*pfGetNrOfChannelsIn)(NrOfChannels);
	return false;
}

bool Dmx4allSetDmx(int FirstChannel, int NrOfBytes, BYTE* pData)
{
	if (hDMX4ALL_dll && pfSetDmx)
		return (*pfSetDmx)(FirstChannel,NrOfBytes,pData);
	return false;
}

bool Dmx4allGetDmx(int FirstChannel, int NrOfBytes, BYTE* pData)
{
	if (hDMX4ALL_dll && pfGetDmx)
		return (*pfGetDmx)(FirstChannel,NrOfBytes,pData);
	return false;
}

bool Dmx4allSetDmxCh(int Kanal, BYTE Data)
{
	if (hDMX4ALL_dll && pfSetDmxCh)
		return (*pfSetDmxCh)(Kanal,Data);
	return false;
}

bool Dmx4allGetComParameters(int* pPort, DWORD* pBaudrate)
{
	if (hDMX4ALL_dll && pfGetComParameters)
		return (*pfGetComParameters)(pPort,pBaudrate);
	return false;
}

bool Dmx4allSetComParameters(UINT Baudrate)
{
	if (hDMX4ALL_dll && pfSetComParameters)
		return (*pfSetComParameters)(Baudrate);
	return false;
}

bool Dmx4allSetPinout(bool Pinout)
{
	if (hDMX4ALL_dll && pfSetPinout)
		return (*pfSetPinout)(Pinout);
	return false;
}

bool Dmx4allRunLightScene(int LightScene)
{
	if (hDMX4ALL_dll && pfRunLightScene)
		return (*pfRunLightScene)(LightScene);
	return false;
}

bool Dmx4allGetInDmx(int FirstChannel, int NrOfBytes, BYTE* pData)
{
	if (hDMX4ALL_dll && pfGetInDmx)
		return (*pfGetInDmx)(FirstChannel,NrOfBytes,pData);
	return false;
}

bool Dmx4allSetMerge(bool Enable,int ChannelStart,int ChannelStop,int MergeMode)
{
	if (hDMX4ALL_dll && pfSetMerge)
		return (*pfSetMerge)(Enable,ChannelStart,ChannelStop,MergeMode);
	return false;
}

bool Dmx4allWriteMemoryData(WORD NrOfBytes, BYTE* pData)
{
	if (hDMX4ALL_dll && pfWriteMemoryData)
		return (*pfWriteMemoryData)(NrOfBytes, pData);
	return false;
}

bool Dmx4allUpdateFirmware()
{
	if (hDMX4ALL_dll && pfUpdateFirmware)
		return (*pfUpdateFirmware)();
	return false;
}

bool Dmx4allGetInfo(VERSION_INFO* pVersionInfo)
{
	if (hDMX4ALL_dll && pfGetInfo)
		return (*pfGetInfo)(pVersionInfo);
	return false;
}

bool Dmx4allGetProductID(int* pProdID)
{
	if (hDMX4ALL_dll && pfGetProductID)
		return (*pfGetProductID)(pProdID);
	return false;
}

bool Dmx4allReadEEPROM(UINT NrOfBytes,UINT* BytesRead,BYTE* pData)
{
	if (hDMX4ALL_dll && pfReadEEPROM)
		return (*pfReadEEPROM)(NrOfBytes,BytesRead,pData);
	return false;
}

bool Dmx4allSetBlackOut(bool BlackOut)
{
	if (hDMX4ALL_dll && pfSetBlackOut)
		return (*pfSetBlackOut)(BlackOut);
	return false;
}

bool Dmx4allGetBlackOut(bool* BlackOut)
{
	if (hDMX4ALL_dll && pfGetBlackOut)
		return (*pfGetBlackOut)(BlackOut);
	return false;
}

bool Dmx4allRebootInterface()
{
	if (hDMX4ALL_dll && pfRebootInterface)
		return (*pfRebootInterface)();
	return false;
}

bool Dmx4allSetup(char* pCmd,int Length)
{
	if (hDMX4ALL_dll && pfSetup)
		return (*pfSetup)(pCmd,Length);
	return false;
}
