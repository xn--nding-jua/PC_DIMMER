{******************************************************************************}
{                                                                              }
{ Ur-Autor...                                                                  }
{ Winamp i/o plugin header adaption for Delphi by Snake (snakers@gmx.net)      }
{ (Based on the mini-SDK from Justin Frankel/Nullsoft Inc.)                    }
{                                                                              }
{ Added types and functions for DSP & Visualization Plug-in                    }
{      by Silhwan Hyun{ Silhwan Hyun hsh@chollian.net (Version 1.0)            }
{                                                                              }
{ ---------------------------------------------------------------------------- }
{                                                                              }
{ Edit to Version B.3.1 by omata (Thorsten) - http://www.delphipraxis.net      }
{                                                                              }
{******************************************************************************}
unit ioplug;

{$MINENUMSIZE 4}
{$ALIGN ON}

interface

uses Windows, Forms, SysUtils;

type
  TData = array[1..10] of byte;

  TIn_Module = record
    version : integer;        // module type (IN_VER)
    description : PChar;      // description of module, with version string

    hMainWindow : HWND;	      // winamp's main window (filled in by winamp)
    hDllInstance : HINST;     // DLL instance handle (Also filled in by winamp)

    FileExtensions : PChar;   // "mp3\0Layer 3 MPEG\0mp2\0Layer 2 MPEG\0mpg\0Layer 1
                              // MPEG\0" May be altered from Config, so the user can
                              // select what they want

    is_seekable : integer;    // is this stream seekable?
    UsesOutputPlug : integer; // does this plug-in use the output plug-ins?
                              // (musn't ever change, ever :)

    config : procedure(hwndParent : HWND); cdecl;  // configuration dialog
    About : procedure(hwndParent : HWND); cdecl;   // about dialog

    Init : procedure; cdecl;  // called at program init
    Quit : procedure; cdecl;  // called at program quit

    GetFileInfo : procedure(_file : PChar; title : PChar;
                            var length_in_ms : integer); cdecl;
               // if file == NULL, current playing is used
    InfoBox : function(_file : PChar; hwndParent : HWND ) : integer; cdecl;

    IsOurFile : function(fn : PChar) : integer; cdecl;
               // called before extension checks, to allow detection of mms:
               //, etc

    // playback stuff

    Play : function(fn : PChar) : integer; cdecl;
               // return zero on success, -1 on file-not-found,
               // some other value on other (stopping winamp) error
    Pause : procedure; cdecl;              // pause stream
    UnPause : procedure; cdecl;            // unpause stream
    IsPaused : function : integer; cdecl;  // ispaused? return 1 if paused, 0 if not
    Stop : procedure; cdecl;               // stop (unload) stream

    // time stuff

    GetLength : function : integer; cdecl; // get length in ms
    GetOutputTime : function : integer; cdecl;
               // returns current output time in ms.
               // (usually returns outMod->GetOutputTime()
    SetOutputTime : procedure(time_in_ms : integer); cdecl;
               // seeks to point in stream (in ms).
               // Usually you signal your thread to seek,
               // which seeks and calls outMod->Flush()..

    // volume stuff

    SetVolume : procedure(volume : integer); cdecl;
               // from 0 to 255.. usually just call outMod->SetVolume
    SetPan : procedure(pan : integer); cdecl;
               // from -127 to 127.. usually just call outMod->SetPan

    // in-window builtin vis stuff

    SAVSAInit : procedure(maxlatency_in_ms : integer; srate : integer); cdecl;
               // call once in Play(). maxlatency_in_ms should be the value
               // returned from outMod->Open()
    SAVSADeInit : procedure; cdecl;
               // call in Stop()

    // simple vis supplying mode
    SAAddPCMData : procedure(PCMData : pointer; nch : integer; bps : integer;
                             timestamp : integer); cdecl;
               // sets the spec data directly from PCM data
               // quick and easy way to get vis working :)
               // needs at least 576 samples :)

    // advanced vis supplying mode, only use if you're cool. Use SAAddPCMData
    // for most stuff.
    SAGetMode : function : integer; cdecl;
               // gets csa (the current type (4=ws,2=osc,1=spec))
               // use when calling SAAdd()
    SAAdd : procedure(data : pointer; timestamp : integer; csa : integer); cdecl;
               // sets the spec data, filled in by winamp

    // vis stuff (plug-in)
    // simple vis supplying mode
    VSAAddPCMData : procedure(PCMData : pointer; nch : integer; bps : integer;
                              timestamp : integer); cdecl;
              // sets the vis data directly from PCM data
              // quick and easy way to get vis working :)
              // needs at least 576 samples :)

    // advanced vis supplying mode, only use if you're cool. Use VSAAddPCMData
    // for most stuff.
    VSAGetMode : function(var specNch : integer; var waveNch : integer) : integer; cdecl;
              // use to figure out what to give to VSAAdd
    VSAAdd : procedure(data : pointer; timestamp : integer); cdecl;
              // filled in by winamp, called by plug-in


    // call this in Play() to tell the vis plug-ins the current output params.
    // VSASetInfo : procedure(nch : integer; srate : integer); cdecl;
    VSASetInfo : procedure(srate : integer; nch : integer); cdecl;

    // dsp plug-in processing:
    // (filled in by winamp, called by input plug)

    // returns 1 if active (which means that the number of samples returned by
    // dsp_dosamples could be greater than went in.. Use it to estimate if you'll
    // have enough room in the output buffer

    dsp_isactive : function : integer; cdecl;

    // returns number of samples to output. This can be as much as twice numsamples.
    // be sure to allocate enough buffer for samples, then.

    dsp_dosamples : function(samples : pointer; numsamples, bps, nch,
                             srate : integer) : integer; cdecl;

    // eq stuff

    EQSet : procedure(on : integer; data : TData; preamp : integer); cdecl;
              // 0-64 each, 31 is +0, 0 is +12, 63 is -12. Do nothing to ignore.

    // info setting (filled in by winamp)
    SetInfo : procedure(bitrate, srate, stereo, synched : integer); cdecl;
              // if -1, changes ignored? :)

    outMod : pointer; // filled in by winamp, optionally used :)
  end;

  TOut_Module = record
    version : integer;      // module version (OUT_VER)
    description : PChar;    // description of module, with version string
    id : integer;           // module id. each input module gets its own.
                            // non-nullsoft modules should be >= 65536.

    hMainWindow : HWND;     // winamp's main window (filled in by winamp)
    hDllInstance : HINST;   // DLL instance handle (filled in by winamp)

    Config : procedure(hwndParent : hwnd); cdecl; // configuration dialog
    About : procedure(hwndParent : hwnd); cdecl;  // about dialog

    Init : procedure; cdecl;	// called when loaded
    Quit : procedure; cdecl;	// called when unloaded

    // following functions and procedures are called by input plug-in
    // you do not need to use these directly.
    Open : function(samplerate, numchannels, bitspersamp, bufferlenms,
                    prebufferms : integer):integer;cdecl;
                // returns >=0 on success, <0 on failure
                // NOTENOTENOTE: bufferlenms and prebufferms are ignored in most
                // if not all output plug-ins.
                //    ... so don't expect the max latency returned to be what you asked for.
                // returns max latency in ms (0 for diskwriters, etc)
                // bufferlenms and prebufferms must be in ms. 0 to use defaults.
                // prebufferms must be <= bufferlenms

    Close : procedure; cdecl;   // close the ol' output device.

    Write : function(buf : pointer; len : integer) : integer; cdecl;
                // 0 on success. Len == bytes to write (<= 8192 always).
                // buf is straight audio data.
                // 1 returns not able to write (yet). Non-blocking, always.

    CanWrite : function : integer; cdecl;
                // returns number of bytes possible to write at a given time.
                // Never will decrease unless you call Write (or Close, heh)

    IsPlaying : function : integer; cdecl;
                // non0 if output is still going or if data in buffers waiting to be
                // written (i.e. closing while IsPlaying() returns 1 would truncate the song

    Pause : function(pause : integer) : integer; cdecl;
                // returns previous pause state

    SetVolume : procedure(volume : integer); cdecl; // volume is 0-255
    SetPan : procedure(pan : integer); cdecl;       // pan is -128 to 128

    Flush : procedure(t : integer); cdecl;
                // flushes buffers and restarts output at time t (in ms)
                // (used for seeking)

    GetOutputTime : function : integer; cdecl;  // returns played time in MS
    GetWrittenTime : function : integer; cdecl;
               // returns time written in MS (used for synching up vis stuff)
  end;

//---------------------------------------------------------------------------------------------------------

type
  PWinampDSPModule = ^TWinampDSPModule;
  TWinampDSPModule = record
    description : pchar;     // description
    hwndParent : HWND;       // parent window (filled in by calling app)
    hDllInstance : HINST;    // instance handle to this DLL (filled in by calling app)
    Config : procedure(Module : PWinampDSPModule); cdecl;    // configuration dialog (if needed)
    Init : function(Module : PWinampDSPModule) : integer; cdecl;  // 0 on success, creates window, etc (if needed)

    // modify waveform samples: returns number of samples to actually write
    // (typically numsamples, but no more than twice numsamples, and no less than half numsamples)
    // numsamples should always be at least 128. should, but I'm not sure
    ModifySamples : function(Module : PWinampDSPModule;
                             samples : pointer;
                             numsamples,
                             bps,
                             nch,
                             srate : integer) : integer; cdecl;
    Quit : procedure(Module : PWinampDSPModule); cdecl;
    UserData : procedure; cdecl;      // user data, optional
  end;

  PWinampDSPHeader = ^TWinampDSPHeader;
  TWinampDSPHeader = record
    version : integer;    // DSP_HDRVER
    description : pchar;  // description of library
    getModule : function(Index : Cardinal) : PWinampDSPModule; cdecl;  // module retrieval function
  end;

  PWinampVisModule = ^TwinampVisModule;
  TWinampVisModule = record
    description  : pchar;     // description of module
    hwndParent   : HWND;      // parent window (filled in by calling app)
    hDllInstance : HINST;     // instance handle to this DLL (filled in by calling app)
    sRate        : Cardinal;  // sample rate (filled in by calling app)
    nCh          : Cardinal;  // number of channels (filled in...)
    latencyMs    : Cardinal;  // latency from call of RenderFrame to actual drawing\
                              // (calling app looks at this value when getting data)
    delayMs      : Cardinal;  // delay between calls in ms

    // the data is filled in according to the respective Nch entry

    spectrumNch  : Cardinal;
    waveformNch  : Cardinal;
    spectrumData : array [1 .. 2,1 .. 576] of byte;
    waveformData : array [1 .. 2,1 .. 576] of byte;
    Config       : procedure(Module : PWinampVisModule); cdecl;   // configuration dialog
    Init         : function (Module : PWinampVisModule) : integer; cdecl;   // 0 on success, creates window, etc
    Render       : function (Module : PWinampVisModule) : integer; cdecl;   // returns 0 if successful, 1 if vis should end
    Quit         : procedure(Module : PWinampVisModule); cdecl;   // call when done

    userData     : procedure; cdecl;  // user data, optional
  end;

  PWinampVisHeader = ^TWinampVisHeader;
  TWinampVisHeader = record
    version       : integer;
    description   : pchar;  // description of library
    getModule     : function (Index : Cardinal) : PWinampVisModule; cdecl;
  end;

//---------------------------------------------------------------------------------------------------------

var
  getInModule : function : pointer; stdcall;
  getOutModule : function : pointer; stdcall;
  getDSPHeader : function : pointer; stdcall;
  getVisHeader : function : pointer; stdcall;

function InitInputDLL(DLL: string): Boolean;
function InitOutputDLL(DLL: string): Boolean;
function InitDSPDLL(DLL: string): Boolean;
function InitVisDLL(DLL: string): Boolean;

procedure CloseInputDLL;
procedure CloseOutputDLL;
procedure CloseDSPDLL;
procedure CloseVisDLL;

function GetDSPDLLHandle : THandle;
function GetVisDLLHandle : THandle;
function GetLoadedDSPDLL : string;
function GetLoadedVisDLL : string;

//---------------------------------------------------------------------------------------------------------

implementation

var
  InputDLLHandle  : THandle = 0;
  OutputDLLHandle : THandle = 0;
  DSPDLLHandle : THandle = 0;
  VisDLLHandle : THandle = 0;

  LoadedDSPDLL : string = '';
  LoadedVisDLL : string = '';


function InitInputDLL(DLL : string) : Boolean;
begin
  Result := False;
  getInModule := nil;
  if InputDLLHandle <> 0 then
    CloseInputDLL;
  InputDLLHandle := LoadLibrary(PChar(DLL));
  if (InputDLLHandle = 0) then
    exit;
  getInModule := GetProcAddress(InputDLLHandle, 'winampGetInModule2');
  if @getInModule <> nil then
    Result := true;
end;

function InitOutputDLL(DLL : string) : Boolean;
begin
  Result := False;
  getOutModule := nil;
  if OutputDLLHandle <> 0 then
    CloseOutputDLL;
  OutputDLLHandle := LoadLibrary(PChar(DLL));
  if (OutputDLLHandle = 0) then
    exit;
  getOutModule := GetProcAddress(OutputDLLHandle, 'winampGetOutModule');
  if @getOutModule <> nil then
    Result := true;
end;

function InitDSPDLL(DLL : string) : Boolean;
begin
  Result := False;
  getDSPHeader := nil;

  if DSPDLLHandle <> 0 then
    CloseDSPDLL;
  DSPDLLHandle := LoadLibrary(PChar(DLL));
  if (DSPDLLHandle = 0) then
    exit;

  getDSPHeader := GetProcAddress(DSPDLLHandle, 'winampDSPGetHeader2');
  if @getDSPHeader <> nil then begin
    LoadedDSPDLL := DLL;
    Result := true;
  end
  else begin   // Unload if not a valid DSP module
    FreeLibrary(DSPDLLHandle);
    DSPDLLHandle := 0;
  end;
end;

function InitVisDLL(DLL : string) : Boolean;
begin
  Result := False;
  getVisHeader := nil;

  if VisDLLHandle <> 0 then
    CloseVisDLL;

  VisDLLHandle := LoadLibrary(pchar(DLL));
  if (VisDLLHandle = 0) then begin
    Application.MessageBox(pchar(SysErrorMessage(GetLastError)), 'Confirm', MB_OK or MB_ICONINFORMATION);
    exit;
  end;

  getVisHeader := GetProcAddress(VisDLLHandle, 'winampVisGetHeader');
  if @getVisHeader <> nil then begin
    LoadedVisDLL := DLL;
    Result := true;
  end
  else begin   // Unload if not a valid Vis module
    FreeLibrary(VisDLLHandle);
    VisDLLHandle := 0;
  end;
end;

procedure CloseInputDLL;
begin
  getInModule := nil;
  if inputDLLHandle <> 0 then begin
    FreeLibrary(InputDLLHandle);
    InputDLLHandle := 0;
  end;
end;

procedure CloseOutputDLL;
begin
  getOutModule := nil;
  if outputDLLHandle <> 0 then begin
    FreeLibrary(outputDLLHandle);
    outputDLLHandle := 0;
  end;
end;

procedure CloseDSPDLL;
begin
  getDSPHeader := nil;
  if DSPDLLHandle <> 0 then begin
    FreeLibrary(DSPDLLHandle);
    DSPDLLHandle := 0;
    LoadedDSPDLL := '';
  end;
end;

procedure CloseVisDLL;
begin
  getVisHeader := nil;
  if VisDLLHandle <> 0 then begin
    FreeLibrary(VisDLLHandle);
    VisDLLHandle := 0;
    LoadedVisDLL := '';
  end;
end;

function GetDSPDLLHandle : THandle;
begin
  result := DSPDLLHandle;
end;

function GetVisDLLHandle : THandle;
begin
  result := VisDLLHandle;
end;

function GetLoadedDSPDLL : string;
begin
  result := LoadedDSPDLL;
end;

function GetLoadedVisDLL : string;
begin
  result := LoadedVisDLL;
end;

initialization
begin
  getInModule := nil;
  getOutModule := nil;
  getDSPHeader := nil;
  getVisHeader := nil;
end

finalization
begin
  CloseInputDLL;
  CloseOutputDLL;
  CloseDSPDLL;
  CloseVisDLL;
end

end.
