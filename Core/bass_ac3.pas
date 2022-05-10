Unit BASS_AC3;

interface

{$IFDEF MSWINDOWS}
uses BASS, Windows;
{$ELSE}
uses BASS;
{$ENDIF}

const
  // BASS_Set/GetConfig options
  BASS_CONFIG_AC3_DYNRNG         = $10001;

  // Additional BASS_AC3_StreamCreateFile/User/URL flags
  BASS_AC3_DYNAMIC_RANGE = $800;	// enable dynamic range compression
  BASS_AC3_STEREO = $400000;	// downmatrix to stereo

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_AC3        = $11000;


const
{$IFDEF MSWINDOWS}
  bassac3dll = 'bass_ac3.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassac3dll = 'libbass_ac3.so';
{$ENDIF}
{$IFDEF MACOS}
  bassac3dll = 'libbass_ac3.dylib';
{$ENDIF}

function BASS_AC3_StreamCreateFile(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassac3dll;
function BASS_AC3_StreamCreateURL(URL:PChar; offset:DWORD; flags:DWORD; proc:DOWNLOADPROC; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassac3dll;
function BASS_AC3_StreamCreateFileUser(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassac3dll;

implementation

end.
