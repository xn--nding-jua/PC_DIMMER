{******************************************************************************}
{                                                                              }
{ Version 2.1 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version 2.2-2.3 by omata (Thorsten)                                  }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassDynamicU;

interface

uses Windows, Classes, BassTypenU;

type
  TBassDll = class
  private
    { BASS-Routinen }
    _BASS_SetConfig:TBASS_SetConfig;
    _BASS_GetConfig:TBASS_GetConfig;
    _BASS_GetVersion:TBASS_GetVersion;
    _BASS_GetDeviceDescription:TBASS_GetDeviceDescription;
    _BASS_ErrorGetCode:TBASS_ErrorGetCode;
    _BASS_Init:TBASS_Init;
    _BASS_SetDevice:TBASS_SetDevice;
    _BASS_GetDevice:TBASS_GetDevice;
    _BASS_Free:TBASS_Free;
    _BASS_GetDSoundObject:TBASS_GetDSoundObject;
    _BASS_GetInfo:TBASS_GetInfo;
    _BASS_Update:TBASS_Update;
    _BASS_GetCPU:TBASS_GetCPU;
    _BASS_Start:TBASS_Start;
    _BASS_Stop:TBASS_Stop;
    _BASS_Pause:TBASS_Pause;
    _BASS_SetVolume:TBASS_SetVolume;
    _BASS_GetVolume:TBASS_GetVolume;

    _BASS_Set3DFactors:TBASS_Set3DFactors;
    _BASS_Get3DFactors:TBASS_Get3DFactors;
    _BASS_Set3DPosition:TBASS_Set3DPosition;
    _BASS_Get3DPosition:TBASS_Get3DPosition;
    _BASS_Apply3D:TBASS_Apply3D;
    _BASS_SetEAXParameters:TBASS_SetEAXParameters;
    _BASS_GetEAXParameters:TBASS_GetEAXParameters;

    _BASS_MusicLoad:TBASS_MusicLoad;
    _BASS_MusicFree:TBASS_MusicFree;
    _BASS_MusicGetName:TBASS_MusicGetName;
    _BASS_MusicGetLength:TBASS_MusicGetLength;
    _BASS_MusicSetAttribute:TBASS_MusicSetAttribute;
    _BASS_MusicGetAttribute:TBASS_MusicGetAttribute;
    _BASS_MusicPreBuf:TBASS_MusicPreBuf;
    _BASS_MusicPlay:TBASS_MusicPlay;
    _BASS_MusicPlayEx:TBASS_MusicPlayEx;
    _BASS_MusicSetAmplify:TBASS_MusicSetAmplify;
    _BASS_MusicSetPanSep:TBASS_MusicSetPanSep;
    _BASS_MusicSetPositionScaler:TBASS_MusicSetPositionScaler;
    _BASS_MusicSetVolume:TBASS_MusicSetVolume;
    _BASS_MusicGetVolume:TBASS_MusicGetVolume;

    _BASS_SampleLoad:TBASS_SampleLoad;
    _BASS_SampleCreate:TBASS_SampleCreate;
    _BASS_SampleCreateDone:TBASS_SampleCreateDone;
    _BASS_SampleFree:TBASS_SampleFree;
    _BASS_SampleGetInfo:TBASS_SampleGetInfo;
    _BASS_SampleSetInfo:TBASS_SampleSetInfo;
    _BASS_SampleGetChannel:TBASS_SampleGetChannel;
    _BASS_SampleStop:TBASS_SampleStop;
    _BASS_SamplePlay:TBASS_SamplePlay;
    _BASS_SamplePlayEx:TBASS_SamplePlayEx;
    _BASS_SamplePlay3D:TBASS_SamplePlay3D;
    _BASS_SamplePlay3DEx:TBASS_SamplePlay3DEx;

    _BASS_StreamCreate:TBASS_StreamCreate;
    _BASS_StreamCreateFile:TBASS_StreamCreateFile;
    _BASS_StreamCreateURL:TBASS_StreamCreateURL;
    _BASS_StreamCreateFileUser:TBASS_StreamCreateFileUser;
    _BASS_StreamFree:TBASS_StreamFree;
    _BASS_StreamGetTags:TBASS_StreamGetTags;
    _BASS_StreamGetFilePosition:TBASS_StreamGetFilePosition;
    _BASS_StreamPreBuf:TBASS_StreamPreBuf;
    _BASS_StreamPlay:TBASS_StreamPlay;

    _BASS_RecordGetDeviceDescription:TBASS_RecordGetDeviceDescription;
    _BASS_RecordInit:TBASS_RecordInit;
    _BASS_RecordSetDevice:TBASS_RecordSetDevice;
    _BASS_RecordGetDevice:TBASS_RecordGetDevice;
    _BASS_RecordFree:TBASS_RecordFree;
    _BASS_RecordGetInfo:TBASS_RecordGetInfo;
    _BASS_RecordGetInputName:TBASS_RecordGetInputName;
    _BASS_RecordSetInput:TBASS_RecordSetInput;
    _BASS_RecordGetInput:TBASS_RecordGetInput;
    _BASS_RecordStart:TBASS_RecordStart;

    _BASS_ChannelBytes2Seconds:TBASS_ChannelBytes2Seconds;
    _BASS_ChannelSeconds2Bytes:TBASS_ChannelSeconds2Bytes;
    _BASS_ChannelGetDevice:TBASS_ChannelGetDevice;
    _BASS_ChannelIsActive:TBASS_ChannelIsActive;
    _BASS_ChannelGetInfo:TBASS_ChannelGetInfo;
    _BASS_ChannelSetFlags:TBASS_ChannelSetFlags;
    _BASS_ChannelPreBuf:TBASS_ChannelPreBuf;
    _BASS_ChannelPlay:TBASS_ChannelPlay;
    _BASS_ChannelStop:TBASS_ChannelStop;
    _BASS_ChannelPause:TBASS_ChannelPause;
    _BASS_ChannelSetAttributes:TBASS_ChannelSetAttributes;
    _BASS_ChannelGetAttributes:TBASS_ChannelGetAttributes;
    _BASS_ChannelSlideAttributes:TBASS_ChannelSlideAttributes;
    _BASS_ChannelIsSliding:TBASS_ChannelIsSliding;
    _BASS_ChannelSet3DAttributes:TBASS_ChannelSet3DAttributes;
    _BASS_ChannelGet3DAttributes:TBASS_ChannelGet3DAttributes;
    _BASS_ChannelSet3DPosition:TBASS_ChannelSet3DPosition;
    _BASS_ChannelGet3DPosition:TBASS_ChannelGet3DPosition;
    _BASS_ChannelSetPosition:TBASS_ChannelSetPosition;
    _BASS_ChannelGetPosition:TBASS_ChannelGetPosition;
    _BASS_ChannelGetLevel:TBASS_ChannelGetLevel;
    _BASS_ChannelGetData:TBASS_ChannelGetData;
    _BASS_ChannelSetSync:TBASS_ChannelSetSync;
    _BASS_ChannelRemoveSync:TBASS_ChannelRemoveSync;
    _BASS_ChannelSetDSP:TBASS_ChannelSetDSP;
    _BASS_ChannelRemoveDSP:TBASS_ChannelRemoveDSP;
    _BASS_ChannelSetEAXMix:TBASS_ChannelSetEAXMix;
    _BASS_ChannelGetEAXMix:TBASS_ChannelGetEAXMix;
    _BASS_ChannelSetLink:TBASS_ChannelSetLink;
    _BASS_ChannelRemoveLink:TBASS_ChannelRemoveLink;
    _BASS_ChannelSetFX:TBASS_ChannelSetFX;
    _BASS_ChannelRemoveFX:TBASS_ChannelRemoveFX;
    _BASS_ChannelResume:TBASS_ChannelResume;
    _BASS_ChannelGetLength:TBASS_ChannelGetLength;

    _BASS_FXSetParameters:TBASS_FXSetParameters;
    _BASS_FXGetParameters:TBASS_FXGetParameters;

    { BASS_FX-Routinen }
    _BASS_FX_GetVersion:TBASS_FX_GetVersion;
    _BASS_FX_Free:TBASS_FX_Free;
    _BASS_FX_ErrorGetCode:TBASS_FX_ErrorGetCode;
    _BASS_FX_DSP_Set:TBASS_FX_DSP_Set;
    _BASS_FX_DSP_Remove:TBASS_FX_DSP_Remove;
    _BASS_FX_DSP_SetParameters:TBASS_FX_DSP_SetParameters;
    _BASS_FX_DSP_GetParameters:TBASS_FX_DSP_GetParameters;
    _BASS_FX_DSP_Reset:TBASS_FX_DSP_Reset;
    _BASS_FX_TempoCreate:TBASS_FX_TempoCreate;
    _BASS_FX_TempoSet:TBASS_FX_TempoSet;
    _BASS_FX_TempoGet:TBASS_FX_TempoGet;
    _BASS_FX_TempoGetRateRatio:TBASS_FX_TempoGetRateRatio;
    _BASS_FX_TempoGetApproxSeconds:TBASS_FX_TempoGetApproxSeconds;
    _BASS_FX_TempoGetApproxPercents:TBASS_FX_TempoGetApproxPercents;
    _BASS_FX_TempoGetResampledHandle:TBASS_FX_TempoGetResampledHandle;
    _BASS_FX_TempoStopAndFlush:TBASS_FX_TempoStopAndFlush;
    _BASS_FX_TempoFree:TBASS_FX_TempoFree;
    _BASS_FX_ReverseCreate:TBASS_FX_ReverseCreate;
    _BASS_FX_ReverseGetReversedHandle:TBASS_FX_ReverseGetReversedHandle;
    _BASS_FX_ReverseSetPosition:TBASS_FX_ReverseSetPosition;
    _BASS_FX_ReverseFree:TBASS_FX_ReverseFree;
    _BASS_FX_BPM_DecodeGet:TBASS_FX_BPM_DecodeGet;
    _BASS_FX_BPM_CallbackSet:TBASS_FX_BPM_CallbackSet;
    _BASS_FX_BPM_CallbackReset:TBASS_FX_BPM_CallbackReset;
    _BASS_FX_BPM_X2:TBASS_FX_BPM_X2;
    _BASS_FX_BPM_Frequency2BPM:TBASS_FX_BPM_Frequency2BPM;
    _BASS_FX_BPM_2Frequency:TBASS_FX_BPM_2Frequency;
    _BASS_FX_BPM_Percents2BPM:TBASS_FX_BPM_Percents2BPM;
    _BASS_FX_BPM_2Percents:TBASS_FX_BPM_2Percents;
    _BASS_FX_BPM_Free:TBASS_FX_BPM_Free;

    function LoadBassDll:boolean;
    function LoadBassFxDll:boolean;
  public
    constructor create; reintroduce;
    destructor destroy; override;
    { BASS-Routinen }
    property BASS_SetConfig:TBASS_SetConfig
      read _BASS_SetConfig;
    property BASS_GetConfig:TBASS_GetConfig
      read _BASS_GetConfig;
    property BASS_GetVersion:TBASS_GetVersion
      read _BASS_GetVersion;
    property BASS_GetDeviceDescription:TBASS_GetDeviceDescription
      read _BASS_GetDeviceDescription;
    property BASS_ErrorGetCode:TBASS_ErrorGetCode
      read _BASS_ErrorGetCode;
    property BASS_Init:TBASS_Init
      read _BASS_Init;
    property BASS_SetDevice:TBASS_SetDevice
      read _BASS_SetDevice;
    property BASS_GetDevice:TBASS_GetDevice
      read _BASS_GetDevice;
    property BASS_Free:TBASS_Free
      read _BASS_Free;
    property BASS_GetDSoundObject:TBASS_GetDSoundObject
      read _BASS_GetDSoundObject;
    property BASS_GetInfo:TBASS_GetInfo
      read _BASS_GetInfo;
    property BASS_Update:TBASS_Update
      read _BASS_Update;
    property BASS_GetCPU:TBASS_GetCPU
      read _BASS_GetCPU;
    property BASS_Start:TBASS_Start
      read _BASS_Start;
    property BASS_Stop:TBASS_Stop
      read _BASS_Stop;
    property BASS_Pause:TBASS_Pause
      read _BASS_Pause;
    property BASS_SetVolume:TBASS_SetVolume
      read _BASS_SetVolume;
    property BASS_GetVolume:TBASS_GetVolume
      read _BASS_GetVolume;

    property BASS_Set3DFactors:TBASS_Set3DFactors
      read _BASS_Set3DFactors;
    property BASS_Get3DFactors:TBASS_Get3DFactors
      read _BASS_Get3DFactors;
    property BASS_Set3DPosition:TBASS_Set3DPosition
      read _BASS_Set3DPosition;
    property BASS_Get3DPosition:TBASS_Get3DPosition
      read _BASS_Get3DPosition;
    property BASS_Apply3D:TBASS_Apply3D
      read _BASS_Apply3D;
    property BASS_SetEAXParameters:TBASS_SetEAXParameters
      read _BASS_SetEAXParameters;
    property BASS_GetEAXParameters:TBASS_GetEAXParameters
      read _BASS_GetEAXParameters;

    property BASS_MusicLoad:TBASS_MusicLoad
      read _BASS_MusicLoad;
    property BASS_MusicFree:TBASS_MusicFree
      read _BASS_MusicFree;
    property BASS_MusicGetName:TBASS_MusicGetName
      read _BASS_MusicGetName;
    property BASS_MusicGetLength:TBASS_MusicGetLength
      read _BASS_MusicGetLength;
    property BASS_MusicSetAttribute:TBASS_MusicSetAttribute
      read _BASS_MusicSetAttribute;
    property BASS_MusicGetAttribute:TBASS_MusicGetAttribute
      read _BASS_MusicGetAttribute;
    property BASS_MusicPreBuf:TBASS_MusicPreBuf
      read _BASS_MusicPreBuf;
    property BASS_MusicPlay:TBASS_MusicPlay
      read _BASS_MusicPlay;
    property BASS_MusicPlayEx:TBASS_MusicPlayEx
      read _BASS_MusicPlayEx;
    property BASS_MusicSetAmplify:TBASS_MusicSetAmplify
      read _BASS_MusicSetAmplify;
    property BASS_MusicSetPanSep:TBASS_MusicSetPanSep
      read _BASS_MusicSetPanSep;
    property BASS_MusicSetPositionScaler:TBASS_MusicSetPositionScaler
      read _BASS_MusicSetPositionScaler;
    property BASS_MusicSetVolume:TBASS_MusicSetVolume
      read _BASS_MusicSetVolume;
    property BASS_MusicGetVolume:TBASS_MusicGetVolume
      read _BASS_MusicGetVolume;

    property BASS_SampleLoad:TBASS_SampleLoad
      read _BASS_SampleLoad;
    property BASS_SampleCreate:TBASS_SampleCreate
      read _BASS_SampleCreate;
    property BASS_SampleCreateDone:TBASS_SampleCreateDone
      read _BASS_SampleCreateDone;
    property BASS_SampleFree:TBASS_SampleFree
      read _BASS_SampleFree;
    property BASS_SampleGetInfo:TBASS_SampleGetInfo
      read _BASS_SampleGetInfo;
    property BASS_SampleSetInfo:TBASS_SampleSetInfo
      read _BASS_SampleSetInfo;
    property BASS_SampleGetChannel:TBASS_SampleGetChannel
      read _BASS_SampleGetChannel;
    property BASS_SampleStop:TBASS_SampleStop
      read _BASS_SampleStop;
    property BASS_SamplePlay:TBASS_SamplePlay
      read _BASS_SamplePlay;
    property BASS_SamplePlayEx:TBASS_SamplePlayEx
      read _BASS_SamplePlayEx;
    property BASS_SamplePlay3D:TBASS_SamplePlay3D
      read _BASS_SamplePlay3D;
    property BASS_SamplePlay3DEx:TBASS_SamplePlay3DEx
      read _BASS_SamplePlay3DEx;

    property BASS_StreamCreate:TBASS_StreamCreate
      read _BASS_StreamCreate;
    property BASS_StreamCreateFile:TBASS_StreamCreateFile
      read _BASS_StreamCreateFile;
    property BASS_StreamCreateURL:TBASS_StreamCreateURL
      read _BASS_StreamCreateURL;
    property BASS_StreamCreateFileUser:TBASS_StreamCreateFileUser
      read _BASS_StreamCreateFileUser;
    property BASS_StreamFree:TBASS_StreamFree
      read _BASS_StreamFree;
    property BASS_StreamGetTags:TBASS_StreamGetTags
      read _BASS_StreamGetTags;
    property BASS_StreamGetFilePosition:TBASS_StreamGetFilePosition
      read _BASS_StreamGetFilePosition;
    property BASS_StreamPreBuf:TBASS_StreamPreBuf
      read _BASS_StreamPreBuf;
    property BASS_StreamPlay:TBASS_StreamPlay
      read _BASS_StreamPlay;

    property BASS_RecordGetDeviceDescription:TBASS_RecordGetDeviceDescription
      read _BASS_RecordGetDeviceDescription;
    property BASS_RecordInit:TBASS_RecordInit
      read _BASS_RecordInit;
    property BASS_RecordSetDevice:TBASS_RecordSetDevice
      read _BASS_RecordSetDevice;
    property BASS_RecordGetDevice:TBASS_RecordGetDevice
      read _BASS_RecordGetDevice;
    property BASS_RecordFree:TBASS_RecordFree
      read _BASS_RecordFree;
    property BASS_RecordGetInfo:TBASS_RecordGetInfo
      read _BASS_RecordGetInfo;
    property BASS_RecordGetInputName:TBASS_RecordGetInputName
      read _BASS_RecordGetInputName;
    property BASS_RecordSetInput:TBASS_RecordSetInput
      read _BASS_RecordSetInput;
    property BASS_RecordGetInput:TBASS_RecordGetInput
      read _BASS_RecordGetInput;
    property BASS_RecordStart:TBASS_RecordStart
      read _BASS_RecordStart;

    property BASS_ChannelBytes2Seconds:TBASS_ChannelBytes2Seconds
      read _BASS_ChannelBytes2Seconds;
    property BASS_ChannelSeconds2Bytes:TBASS_ChannelSeconds2Bytes
      read _BASS_ChannelSeconds2Bytes;
    property BASS_ChannelGetDevice:TBASS_ChannelGetDevice
      read _BASS_ChannelGetDevice;
    property BASS_ChannelIsActive:TBASS_ChannelIsActive
      read _BASS_ChannelIsActive;
    property BASS_ChannelGetInfo:TBASS_ChannelGetInfo
      read _BASS_ChannelGetInfo;
    property BASS_ChannelSetFlags:TBASS_ChannelSetFlags
      read _BASS_ChannelSetFlags;
    property BASS_ChannelPreBuf:TBASS_ChannelPreBuf
      read _BASS_ChannelPreBuf;
    property BASS_ChannelPlay:TBASS_ChannelPlay
      read _BASS_ChannelPlay;
    property BASS_ChannelStop:TBASS_ChannelStop
      read _BASS_ChannelStop;
    property BASS_ChannelPause:TBASS_ChannelPause
      read _BASS_ChannelPause;
    property BASS_ChannelSetAttributes:TBASS_ChannelSetAttributes
      read _BASS_ChannelSetAttributes;
    property BASS_ChannelGetAttributes:TBASS_ChannelGetAttributes
      read _BASS_ChannelGetAttributes;
    property BASS_ChannelSlideAttributes:TBASS_ChannelSlideAttributes
      read _BASS_ChannelSlideAttributes;
    property BASS_ChannelIsSliding:TBASS_ChannelIsSliding
      read _BASS_ChannelIsSliding;
    property BASS_ChannelSet3DAttributes:TBASS_ChannelSet3DAttributes
      read _BASS_ChannelSet3DAttributes;
    property BASS_ChannelGet3DAttributes:TBASS_ChannelGet3DAttributes
      read _BASS_ChannelGet3DAttributes;
    property BASS_ChannelSet3DPosition:TBASS_ChannelSet3DPosition
      read _BASS_ChannelSet3DPosition;
    property BASS_ChannelGet3DPosition:TBASS_ChannelGet3DPosition
      read _BASS_ChannelGet3DPosition;
    property BASS_ChannelSetPosition:TBASS_ChannelSetPosition
      read _BASS_ChannelSetPosition;
    property BASS_ChannelGetPosition:TBASS_ChannelGetPosition
      read _BASS_ChannelGetPosition;
    property BASS_ChannelGetLevel:TBASS_ChannelGetLevel
      read _BASS_ChannelGetLevel;
    property BASS_ChannelGetData:TBASS_ChannelGetData
      read _BASS_ChannelGetData;
    property BASS_ChannelSetSync:TBASS_ChannelSetSync
      read _BASS_ChannelSetSync;
    property BASS_ChannelRemoveSync:TBASS_ChannelRemoveSync
      read _BASS_ChannelRemoveSync;
    property BASS_ChannelSetDSP:TBASS_ChannelSetDSP
      read _BASS_ChannelSetDSP;
    property BASS_ChannelRemoveDSP:TBASS_ChannelRemoveDSP
      read _BASS_ChannelRemoveDSP;
    property BASS_ChannelSetEAXMix:TBASS_ChannelSetEAXMix
      read _BASS_ChannelSetEAXMix;
    property BASS_ChannelGetEAXMix:TBASS_ChannelGetEAXMix
      read _BASS_ChannelGetEAXMix;
    property BASS_ChannelSetLink:TBASS_ChannelSetLink
      read _BASS_ChannelSetLink;
    property BASS_ChannelRemoveLink:TBASS_ChannelRemoveLink
      read _BASS_ChannelRemoveLink;
    property BASS_ChannelSetFX:TBASS_ChannelSetFX
      read _BASS_ChannelSetFX;
    property BASS_ChannelRemoveFX:TBASS_ChannelRemoveFX
      read _BASS_ChannelRemoveFX;
    property BASS_ChannelResume:TBASS_ChannelResume
      read _BASS_ChannelResume;
    property BASS_ChannelGetLength:TBASS_ChannelGetLength
      read _BASS_ChannelGetLength;

    property BASS_FXSetParameters:TBASS_FXSetParameters
      read _BASS_FXSetParameters;
    property BASS_FXGetParameters:TBASS_FXGetParameters
      read _BASS_FXGetParameters;

    { BASS_FX-Routinen }
    property BASS_FX_GetVersion:TBASS_FX_GetVersion
      read _BASS_FX_GetVersion;
    property BASS_FX_Free:TBASS_FX_Free
      read _BASS_FX_Free;
    property BASS_FX_ErrorGetCode:TBASS_FX_ErrorGetCode
      read _BASS_FX_ErrorGetCode;
    property BASS_FX_DSP_Set:TBASS_FX_DSP_Set
      read _BASS_FX_DSP_Set;
    property BASS_FX_DSP_Remove:TBASS_FX_DSP_Remove
      read _BASS_FX_DSP_Remove;
    property BASS_FX_DSP_SetParameters:TBASS_FX_DSP_SetParameters
      read _BASS_FX_DSP_SetParameters;
    property BASS_FX_DSP_GetParameters:TBASS_FX_DSP_GetParameters
      read _BASS_FX_DSP_GetParameters;
    property BASS_FX_DSP_Reset:TBASS_FX_DSP_Reset
      read _BASS_FX_DSP_Reset;
    property BASS_FX_TempoCreate:TBASS_FX_TempoCreate
      read _BASS_FX_TempoCreate;
    property BASS_FX_TempoSet:TBASS_FX_TempoSet
      read _BASS_FX_TempoSet;
    property BASS_FX_TempoGet:TBASS_FX_TempoGet
      read _BASS_FX_TempoGet;
    property BASS_FX_TempoGetRateRatio:TBASS_FX_TempoGetRateRatio
      read _BASS_FX_TempoGetRateRatio;
    property BASS_FX_TempoGetApproxSeconds:TBASS_FX_TempoGetApproxSeconds
      read _BASS_FX_TempoGetApproxSeconds;
    property BASS_FX_TempoGetApproxPercents:TBASS_FX_TempoGetApproxPercents
      read _BASS_FX_TempoGetApproxPercents;
    property BASS_FX_TempoGetResampledHandle:TBASS_FX_TempoGetResampledHandle
      read _BASS_FX_TempoGetResampledHandle;
    property BASS_FX_TempoStopAndFlush:TBASS_FX_TempoStopAndFlush
      read _BASS_FX_TempoStopAndFlush;
    property BASS_FX_TempoFree:TBASS_FX_TempoFree
      read _BASS_FX_TempoFree;
    property BASS_FX_ReverseCreate:TBASS_FX_ReverseCreate
      read _BASS_FX_ReverseCreate;
    property BASS_FX_ReverseGetReversedHandle:TBASS_FX_ReverseGetReversedHandle
      read _BASS_FX_ReverseGetReversedHandle;
    property BASS_FX_ReverseSetPosition:TBASS_FX_ReverseSetPosition
      read _BASS_FX_ReverseSetPosition;
    property BASS_FX_ReverseFree:TBASS_FX_ReverseFree
      read _BASS_FX_ReverseFree;
    property BASS_FX_BPM_DecodeGet:TBASS_FX_BPM_DecodeGet
      read _BASS_FX_BPM_DecodeGet;
    property BASS_FX_BPM_CallbackSet:TBASS_FX_BPM_CallbackSet
      read _BASS_FX_BPM_CallbackSet;
    property BASS_FX_BPM_CallbackReset:TBASS_FX_BPM_CallbackReset
      read _BASS_FX_BPM_CallbackReset;
    property BASS_FX_BPM_X2:TBASS_FX_BPM_X2
      read _BASS_FX_BPM_X2;
    property BASS_FX_BPM_Frequency2BPM:TBASS_FX_BPM_Frequency2BPM
      read _BASS_FX_BPM_Frequency2BPM;
    property BASS_FX_BPM_2Frequency:TBASS_FX_BPM_2Frequency
      read _BASS_FX_BPM_2Frequency;
    property BASS_FX_BPM_Percents2BPM:TBASS_FX_BPM_Percents2BPM
      read _BASS_FX_BPM_Percents2BPM;
    property BASS_FX_BPM_2Percents:TBASS_FX_BPM_2Percents
      read _BASS_FX_BPM_2Percents;
    property BASS_FX_BPM_Free:TBASS_FX_BPM_Free
      read _BASS_FX_BPM_Free;
  end;

function BASS_SPEAKER_N(n: DWORD): DWORD;
function BASS_SetEAXPreset(BassDll:TBassDll; env: Integer): BOOL;

{
  This function is defined in the implementation part of this unit.
  It is not part of BASS.DLL but an extra function which makes it easier
  to set the predefined EAX environments.
  env    : a EAX_ENVIRONMENT_xxx constant
}

implementation

uses SysUtils;

{ TBassDll }

const
  BASS_FILENAME = 'bass.dll';
  BASSFX_FILENAME = 'bass_fx.dll';

constructor TBassDll.create;
begin
  if LoadBassDll then
    if LoadBassFxDll then ;
end;

destructor TBassDll.destroy;
begin
  BASS_RecordFree;
  BASS_Stop;
  BASS_Free;
  inherited;
end;

function BASS_SPEAKER_N(n: DWORD): DWORD;
begin
  Result := n shl 24;
end;

function BASS_SetEAXPreset(BassDll:TBassDll; env: Integer): BOOL;
begin
  case (env) of
    EAX_ENVIRONMENT_GENERIC:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_GENERIC, 0.5, 1.493, 0.5
      );
    EAX_ENVIRONMENT_PADDEDCELL:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_PADDEDCELL, 0.25, 0.1, 0
      );
    EAX_ENVIRONMENT_ROOM:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_ROOM, 0.417, 0.4, 0.666
      );
    EAX_ENVIRONMENT_BATHROOM:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_BATHROOM, 0.653, 1.499, 0.166
      );
    EAX_ENVIRONMENT_LIVINGROOM:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_LIVINGROOM, 0.208, 0.478, 0
      );
    EAX_ENVIRONMENT_STONEROOM:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_STONEROOM, 0.5, 2.309, 0.888
      );
    EAX_ENVIRONMENT_AUDITORIUM:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_AUDITORIUM, 0.403, 4.279, 0.5
      );
    EAX_ENVIRONMENT_CONCERTHALL:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_CONCERTHALL, 0.5, 3.961, 0.5
      );
    EAX_ENVIRONMENT_CAVE:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_CAVE, 0.5, 2.886, 1.304
      );
    EAX_ENVIRONMENT_ARENA:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_ARENA, 0.361, 7.284, 0.332
      );
    EAX_ENVIRONMENT_HANGAR:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_HANGAR, 0.5, 10.0, 0.3
      );
    EAX_ENVIRONMENT_CARPETEDHALLWAY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_CARPETEDHALLWAY, 0.153, 0.259, 2.0
      );
    EAX_ENVIRONMENT_HALLWAY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_HALLWAY, 0.361, 1.493, 0
      );
    EAX_ENVIRONMENT_STONECORRIDOR:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_STONECORRIDOR, 0.444, 2.697, 0.638
      );
    EAX_ENVIRONMENT_ALLEY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_ALLEY, 0.25, 1.752, 0.776
      );
    EAX_ENVIRONMENT_FOREST:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_FOREST, 0.111, 3.145, 0.472
      );
    EAX_ENVIRONMENT_CITY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_CITY, 0.111, 2.767, 0.224
      );
    EAX_ENVIRONMENT_MOUNTAINS:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_MOUNTAINS, 0.194, 7.841, 0.472
      );
    EAX_ENVIRONMENT_QUARRY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_QUARRY, 1, 1.499, 0.5
      );
    EAX_ENVIRONMENT_PLAIN:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_PLAIN, 0.097, 2.767, 0.224
      );
    EAX_ENVIRONMENT_PARKINGLOT:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_PARKINGLOT, 0.208, 1.652, 1.5
      );
    EAX_ENVIRONMENT_SEWERPIPE:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_SEWERPIPE, 0.652, 2.886, 0.25
      );
    EAX_ENVIRONMENT_UNDERWATER:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_UNDERWATER, 1, 1.499, 0
      );
    EAX_ENVIRONMENT_DRUGGED:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_DRUGGED, 0.875, 8.392, 1.388
      );
    EAX_ENVIRONMENT_DIZZY:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_DIZZY, 0.139, 17.234, 0.666
      );
    EAX_ENVIRONMENT_PSYCHOTIC:
      Result := BassDll.BASS_SetEAXParameters(
        EAX_ENVIRONMENT_PSYCHOTIC, 0.486, 7.563, 0.806
      );
    else
      Result := FALSE;
  end;
end;

function TBassDll.LoadBassDll:boolean;
var handle:Cardinal;
begin
  handle:=LoadLibrary(BASS_FILENAME);
  if handle <> 0 then begin
    _BASS_SetConfig := GetProcAddress(
      handle, 'BASS_SetConfig'
    );
    _BASS_GetConfig := GetProcAddress(
      handle, 'BASS_GetConfig'
    );
    _BASS_GetVersion := GetProcAddress(
      handle, 'BASS_GetVersion'
    );
    _BASS_GetDeviceDescription := GetProcAddress(
      handle, 'BASS_GetDeviceDescription'
    );
    _BASS_ErrorGetCode := GetProcAddress(
      handle, 'BASS_ErrorGetCode'
    );
    _BASS_Init := GetProcAddress(
      handle, 'BASS_Init'
    );
    _BASS_SetDevice := GetProcAddress(
      handle, 'BASS_SetDevice'
    );
    _BASS_GetDevice := GetProcAddress(
      handle, 'BASS_GetDevice'
    );
    _BASS_Free := GetProcAddress(
      handle, 'BASS_Free'
    );
    _BASS_GetDSoundObject := GetProcAddress(
      handle, 'BASS_GetDSoundObject'
    );
    _BASS_GetInfo := GetProcAddress(
      handle, 'BASS_GetInfo'
    );
    _BASS_Update := GetProcAddress(
      handle, 'BASS_Update'
    );
    _BASS_GetCPU := GetProcAddress(
      handle, 'BASS_GetCPU'
    );
    _BASS_Start := GetProcAddress(
      handle, 'BASS_Start'
    );
    _BASS_Stop := GetProcAddress(
      handle, 'BASS_Stop'
    );
    _BASS_Pause := GetProcAddress(
      handle, 'BASS_Pause'
    );
    _BASS_SetVolume := GetProcAddress(
      handle, 'BASS_SetVolume'
    );
    _BASS_GetVolume := GetProcAddress(
      handle, 'BASS_GetVolume'
    );

    _BASS_Set3DFactors := GetProcAddress(
      handle, 'BASS_Set3DFactors'
    );
    _BASS_Get3DFactors := GetProcAddress(
      handle, 'BASS_Get3DFactors'
    );
    _BASS_Set3DPosition := GetProcAddress(
      handle, 'BASS_Set3DPosition'
    );
    _BASS_Get3DPosition := GetProcAddress(
      handle, 'BASS_Get3DPosition'
    );
    _BASS_Apply3D := GetProcAddress(
      handle, 'BASS_Apply3D'
    );
    _BASS_SetEAXParameters := GetProcAddress(
      handle, 'BASS_SetEAXParameters'
    );
    _BASS_GetEAXParameters := GetProcAddress(
      handle, 'BASS_GetEAXParameters'
    );

    _BASS_MusicLoad := GetProcAddress(
      handle, 'BASS_MusicLoad'
    );
    _BASS_MusicFree := GetProcAddress(
      handle, 'BASS_MusicFree'
    );
    _BASS_MusicGetName := GetProcAddress(
      handle, 'BASS_MusicGetName'
    );
    _BASS_MusicGetLength := GetProcAddress(
      handle, 'BASS_MusicGetLength'
    );
    _BASS_MusicSetAttribute := GetProcAddress(
      handle, 'BASS_MusicSetAttribute'
    );
    _BASS_MusicGetAttribute := GetProcAddress(
      handle, 'BASS_MusicGetAttribute'
    );
    _BASS_MusicPreBuf := GetProcAddress(
      handle, 'BASS_MusicPreBuf'
    );
    _BASS_MusicPlay := GetProcAddress(
      handle, 'BASS_MusicPlay'
    );
    _BASS_MusicPlayEx := GetProcAddress(
      handle, 'BASS_MusicPlayEx'
    );
    _BASS_MusicSetAmplify := GetProcAddress(
      handle, 'BASS_MusicSetAmplify'
    );
    _BASS_MusicSetPanSep := GetProcAddress(
      handle, 'BASS_MusicSetPanSep'
    );
    _BASS_MusicSetPositionScaler := GetProcAddress(
      handle, 'BASS_MusicSetPositionScaler'
    );
    _BASS_MusicSetVolume := GetProcAddress(
      handle, 'BASS_MusicSetVolume'
    );
    _BASS_MusicGetVolume := GetProcAddress(
      handle, 'BASS_MusicGetVolume'
    );

    _BASS_SampleLoad := GetProcAddress(
      handle, 'BASS_SampleLoad'
    );
    _BASS_SampleCreate := GetProcAddress(
      handle, 'BASS_SampleCreate'
    );
    _BASS_SampleCreateDone := GetProcAddress(
      handle, 'BASS_SampleCreateDone'
    );
    _BASS_SampleFree := GetProcAddress(
      handle, 'BASS_SampleFree'
    );
    _BASS_SampleGetInfo := GetProcAddress(
      handle, 'BASS_SampleGetInfo'
    );
    _BASS_SampleSetInfo := GetProcAddress(
      handle, 'BASS_SampleSetInfo'
    );
    _BASS_SampleGetChannel := GetProcAddress(
      handle, 'BASS_SampleGetChannel'
    );
    _BASS_SampleStop := GetProcAddress(
      handle, 'BASS_SampleStop'
    );
    _BASS_SamplePlay := GetProcAddress(
      handle, 'BASS_SamplePlay'
    );
    _BASS_SamplePlayEx := GetProcAddress(
      handle, 'BASS_SamplePlayEx'
    );
    _BASS_SamplePlay3D := GetProcAddress(
      handle, 'BASS_SamplePlay3D'
    );
    _BASS_SamplePlay3DEx := GetProcAddress(
      handle, 'BASS_SamplePlay3DEx'
    );

    _BASS_StreamCreate := GetProcAddress(
      handle, 'BASS_StreamCreate'
    );
    _BASS_StreamCreateFile := GetProcAddress(
      handle, 'BASS_StreamCreateFile'
    );
    _BASS_StreamCreateURL := GetProcAddress(
      handle, 'BASS_StreamCreateURL'
    );
    _BASS_StreamCreateFileUser := GetProcAddress(
      handle, 'BASS_StreamCreateFileUser'
    );
    _BASS_StreamFree := GetProcAddress(
      handle, 'BASS_StreamFree'
    );
    _BASS_StreamGetTags := GetProcAddress(
      handle, 'BASS_StreamGetTags'
    );
    _BASS_StreamGetFilePosition := GetProcAddress(
      handle, 'BASS_StreamGetFilePosition'
    );
    _BASS_StreamPreBuf := GetProcAddress(
      handle, 'BASS_StreamPreBuf'
    );
    _BASS_StreamPlay := GetProcAddress(
      handle, 'BASS_StreamPlay'
    );

    _BASS_RecordGetDeviceDescription := GetProcAddress(
      handle, 'BASS_RecordGetDeviceDescription'
    );
    _BASS_RecordInit := GetProcAddress(
      handle, 'BASS_RecordInit'
    );
    _BASS_RecordSetDevice := GetProcAddress(
      handle, 'BASS_RecordSetDevice'
    );
    _BASS_RecordGetDevice := GetProcAddress(
      handle, 'BASS_RecordGetDevice'
    );
    _BASS_RecordFree := GetProcAddress(
      handle, 'BASS_RecordFree'
    );
    _BASS_RecordGetInfo := GetProcAddress(
      handle, 'BASS_RecordGetInfo'
    );
    _BASS_RecordGetInputName := GetProcAddress(
      handle, 'BASS_RecordGetInputName'
    );
    _BASS_RecordSetInput := GetProcAddress(
      handle, 'BASS_RecordSetInput'
    );
    _BASS_RecordGetInput := GetProcAddress(
      handle, 'BASS_RecordGetInput'
    );
    _BASS_RecordStart := GetProcAddress(
      handle, 'BASS_RecordStart'
    );

    _BASS_ChannelBytes2Seconds := GetProcAddress(
      handle, 'BASS_ChannelBytes2Seconds'
    );
    _BASS_ChannelSeconds2Bytes := GetProcAddress(
      handle, 'BASS_ChannelSeconds2Bytes'
    );
    _BASS_ChannelGetDevice := GetProcAddress(
      handle, 'BASS_ChannelGetDevice'
    );
    _BASS_ChannelIsActive := GetProcAddress(
      handle, 'BASS_ChannelIsActive'
    );
    _BASS_ChannelGetInfo := GetProcAddress(
      handle, 'BASS_ChannelGetInfo'
    );
    _BASS_ChannelSetFlags := GetProcAddress(
      handle, 'BASS_ChannelSetFlags'
    );
    _BASS_ChannelPreBuf := GetProcAddress(
      handle, 'BASS_ChannelPreBuf'
    );
    _BASS_ChannelPlay := GetProcAddress(
      handle, 'BASS_ChannelPlay'
    );
    _BASS_ChannelStop := GetProcAddress(
      handle, 'BASS_ChannelStop'
    );
    _BASS_ChannelPause := GetProcAddress(
      handle, 'BASS_ChannelPause'
    );
    _BASS_ChannelSetAttributes := GetProcAddress(
      handle, 'BASS_ChannelSetAttributes'
    );
    _BASS_ChannelGetAttributes := GetProcAddress(
      handle, 'BASS_ChannelGetAttributes'
    );
    _BASS_ChannelSlideAttributes := GetProcAddress(
      handle, 'BASS_ChannelSlideAttributes'
    );
    _BASS_ChannelIsSliding := GetProcAddress(
      handle, 'BASS_ChannelIsSliding'
    );
    _BASS_ChannelSet3DAttributes := GetProcAddress(
      handle, 'BASS_ChannelSet3DAttributes'
    );
    _BASS_ChannelGet3DAttributes := GetProcAddress(
      handle, 'BASS_ChannelGet3DAttributes'
    );
    _BASS_ChannelSet3DPosition := GetProcAddress(
      handle, 'BASS_ChannelSet3DPosition'
    );
    _BASS_ChannelGet3DPosition := GetProcAddress(
      handle, 'BASS_ChannelGet3DPosition'
    );
    _BASS_ChannelSetPosition := GetProcAddress(
      handle, 'BASS_ChannelSetPosition'
    );
    _BASS_ChannelGetPosition := GetProcAddress(
      handle, 'BASS_ChannelGetPosition'
    );
    _BASS_ChannelGetLevel := GetProcAddress(
      handle, 'BASS_ChannelGetLevel'
    );
    _BASS_ChannelGetData := GetProcAddress(
      handle, 'BASS_ChannelGetData'
    );
    _BASS_ChannelSetSync := GetProcAddress(
      handle, 'BASS_ChannelSetSync'
    );
    _BASS_ChannelRemoveSync := GetProcAddress(
      handle, 'BASS_ChannelRemoveSync'
    );
    _BASS_ChannelSetDSP := GetProcAddress(
      handle, 'BASS_ChannelSetDSP'
    );
    _BASS_ChannelRemoveDSP := GetProcAddress(
      handle, 'BASS_ChannelRemoveDSP'
    );
    _BASS_ChannelSetEAXMix := GetProcAddress(
      handle, 'BASS_ChannelSetEAXMix'
    );
    _BASS_ChannelGetEAXMix := GetProcAddress(
      handle, 'BASS_ChannelGetEAXMix'
    );
    _BASS_ChannelSetLink := GetProcAddress(
      handle, 'BASS_ChannelSetLink'
    );
    _BASS_ChannelRemoveLink := GetProcAddress(
      handle, 'BASS_ChannelRemoveLink'
    );
    _BASS_ChannelSetFX := GetProcAddress(
      handle, 'BASS_ChannelSetFX'
    );
    _BASS_ChannelRemoveFX := GetProcAddress(
      handle, 'BASS_ChannelRemoveFX'
    );
    _BASS_ChannelResume := GetProcAddress(
      handle, 'BASS_ChannelResume'
    );
    _BASS_ChannelGetLength := GetProcAddress(
      handle, 'BASS_ChannelGetLength'
    );

    _BASS_FXSetParameters := GetProcAddress(
      handle, 'BASS_FXSetParameters'
    );
    _BASS_FXGetParameters := GetProcAddress(
      handle, 'BASS_FXGetParameters'
    );
  end;
  Result:=(handle <> 0);
end;

function TBassDll.LoadBassFxDll: boolean;
var handle:Cardinal;
begin
  handle:=LoadLibrary(BASSFX_FILENAME);
  if handle <> 0 then begin
    _BASS_FX_GetVersion := GetProcAddress(
      handle, 'BASS_FX_GetVersion'
    );
    _BASS_FX_Free := GetProcAddress(
      handle, 'BASS_FX_Free'
    );
    _BASS_FX_ErrorGetCode := GetProcAddress(
      handle, 'BASS_FX_ErrorGetCode'
    );
    _BASS_FX_DSP_Set := GetProcAddress(
      handle, 'BASS_FX_DSP_Set'
    );
    _BASS_FX_DSP_Remove := GetProcAddress(
      handle, 'BASS_FX_DSP_Remove'
    );
    _BASS_FX_DSP_SetParameters := GetProcAddress(
      handle, 'BASS_FX_DSP_SetParameters'
    );
    _BASS_FX_DSP_GetParameters := GetProcAddress(
      handle, 'BASS_FX_DSP_GetParameters'
    );
    _BASS_FX_DSP_Reset := GetProcAddress(
      handle, 'BASS_FX_DSP_Reset'
    );
    _BASS_FX_TempoCreate := GetProcAddress(
      handle, 'BASS_FX_TempoCreate'
    );
    _BASS_FX_TempoSet := GetProcAddress(
      handle, 'BASS_FX_TempoSet'
    );
    _BASS_FX_TempoGet := GetProcAddress(
      handle, 'BASS_FX_TempoGet'
    );
    _BASS_FX_TempoGetRateRatio := GetProcAddress(
      handle, 'BASS_FX_TempoGetRateRatio'
    );
    _BASS_FX_TempoGetApproxSeconds := GetProcAddress(
      handle, 'BASS_FX_TempoGetApproxSeconds'
    );
    _BASS_FX_TempoGetApproxPercents := GetProcAddress(
      handle, 'BASS_FX_TempoGetApproxPercents'
    );
    _BASS_FX_TempoGetResampledHandle := GetProcAddress(
      handle, 'BASS_FX_TempoGetResampledHandle'
    );
    _BASS_FX_TempoStopAndFlush := GetProcAddress(
      handle, 'BASS_FX_TempoStopAndFlush'
    );
    _BASS_FX_TempoFree := GetProcAddress(
      handle, 'BASS_FX_TempoFree'
    );
    _BASS_FX_ReverseCreate := GetProcAddress(
      handle, 'BASS_FX_ReverseCreate'
    );
    _BASS_FX_ReverseGetReversedHandle := GetProcAddress(
      handle, 'BASS_FX_ReverseGetReversedHandle'
    );
    _BASS_FX_ReverseSetPosition := GetProcAddress(
      handle, 'BASS_FX_ReverseSetPosition'
    );
    _BASS_FX_ReverseFree := GetProcAddress(
      handle, 'BASS_FX_ReverseFree'
    );
    _BASS_FX_BPM_DecodeGet := GetProcAddress(
      handle, 'BASS_FX_BPM_DecodeGet'
    );
    _BASS_FX_BPM_CallbackSet := GetProcAddress(
      handle, 'BASS_FX_BPM_CallbackSet'
    );
    _BASS_FX_BPM_CallbackReset := GetProcAddress(
      handle, 'BASS_FX_BPM_CallbackReset'
    );
    _BASS_FX_BPM_X2 := GetProcAddress(
      handle, 'BASS_FX_BPM_X2'
    );
    _BASS_FX_BPM_Frequency2BPM := GetProcAddress(
      handle, 'BASS_FX_BPM_Frequency2BPM'
    );
    _BASS_FX_BPM_2Frequency := GetProcAddress(
      handle, 'BASS_FX_BPM_2Frequency'
    );
    _BASS_FX_BPM_Percents2BPM := GetProcAddress(
      handle, 'BASS_FX_BPM_Percents2BPM'
    );
    _BASS_FX_BPM_2Percents := GetProcAddress(
      handle, 'BASS_FX_BPM_2Percents'
    );
    _BASS_FX_BPM_Free := GetProcAddress(
      handle, 'BASS_FX_BPM_Free'
    );
  end;
  Result:=(handle <> 0);
end;

end.
