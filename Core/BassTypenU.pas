{******************************************************************************}
{                                                                              }
{ Version 2.0-2.4 by omata (Thorsten) - http://www.delphipraxis.net            }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassTypenU;

interface

uses Windows, SysUtils, Types;

type
  DWORD = cardinal;
  BOOL = LongBool;
  FLOAT = Single;
  QWORD = {$ifdef USE_64_ASM} Comp; {$else} int64; {$endif}  // 64-bit

  TBassVolume = 0..100;
  TBassProzent = 0..100;
  TBassBalance = -100..100;
  TBassTempo = -30..30;
  TBassPitch = -30..30;
  TBassDryMix = -2000..2000;
  TBassWetMix = -2000..2000;
  TBassFeedback = -1000..1000;
  TBassRate = 0..100;
  TBassRange = 0..100;
  TBassFreq = 0..10000;
  TBassPlayerModus  =
    (moNone, moSamples, moMusik,  moStream);
  TBassPlayerStatus =
    (sndStopped, sndPlaying, sndStalled, sndPaused, sndNotLoaded);
  TBassSongStatusInfo =
    (SongTimeUp, SongTimeDown, SongTimeLength);

  TBassSongInfo = record
                    asSecString:string;
                    asMilliSecString:string;
                    asSecInteger:integer;
                    asMilliSecInteger:integer;
                  end;

  TBassFFTData = array[0..512] of Single;
  TBassFFTDataLong = array[0..2048] of float;
  TBassWaveDataDWORD = array[0..2048] of DWORD;
  TBassWaveDataSMALLINT = array[0..2048] of smallint;
  TBassWaveDataLong = array[0..8192] of smallint;
  TBassFFT = record
    case byte of
      1: ();
  end;

const
  BassDLLPlayerFileFilter =
    'All supporded Filetypes|'+
    '*.WAV;*.MP3;*.MP2;*.MP1;*.OGG;'+
    '*.MO3;*.IT;*.XM;*.S3M;*.MTM;*.MOD;*.UMX'+
    '|All Files (*.*)|*.*';

  MaxPeak = 32768;

{
  BASS 2.1 Multimedia Library, (c) 1999-2005 Ian Luck.
  Please report bugs/suggestions/etc... to bass@un4seen.com

  See the BASS.CHM file for more complete documentation

  Edit by omata (Thorsten) - http://www.delphipraxis.net
}
const
  // Use these to test for error from functions that return a DWORD or QWORD
  DW_ERROR = Cardinal(-1); // -1 (DWORD)
  QW_ERROR = Int64(-1);    // -1 (QWORD)

  // Error codes returned by BASS_GetErrorCode()
  BASS_OK                 = 0;    // all is OK
  BASS_ERROR_MEM          = 1;    // memory error
  BASS_ERROR_FILEOPEN     = 2;    // can't open the file
  BASS_ERROR_DRIVER       = 3;    // can't find a free sound driver
  BASS_ERROR_BUFLOST      = 4;    // the sample buffer was lost - please report this!
  BASS_ERROR_HANDLE       = 5;    // invalid handle
  BASS_ERROR_FORMAT       = 6;    // unsupported sample format
  BASS_ERROR_POSITION     = 7;    // invalid playback position
  BASS_ERROR_INIT         = 8;    // BASS_Init has not been successfully called
  BASS_ERROR_START        = 9;    // BASS_Start has not been successfully called
  BASS_ERROR_ALREADY      = 14;   // already initialized/paused/whatever
  BASS_ERROR_NOPAUSE      = 16;   // not paused
  BASS_ERROR_NOCHAN       = 18;   // can't get a free channel
  BASS_ERROR_ILLTYPE      = 19;   // an illegal type was specified
  BASS_ERROR_ILLPARAM     = 20;   // an illegal parameter was specified
  BASS_ERROR_NO3D         = 21;   // no 3D support
  BASS_ERROR_NOEAX        = 22;   // no EAX support
  BASS_ERROR_DEVICE       = 23;   // illegal device number
  BASS_ERROR_NOPLAY       = 24;   // not playing
  BASS_ERROR_FREQ         = 25;   // illegal sample rate
  BASS_ERROR_NOTFILE      = 27;   // the stream is not a file stream
  BASS_ERROR_NOHW         = 29;   // no hardware voices available
  BASS_ERROR_EMPTY        = 31;   // the MOD music has no sequence data
  BASS_ERROR_NONET        = 32;   // no internet connection could be opened
  BASS_ERROR_CREATE       = 33;   // couldn't create the file
  BASS_ERROR_NOFX         = 34;   // effects are not enabled
  BASS_ERROR_PLAYING      = 35;   // the channel is playing
  BASS_ERROR_NOTAVAIL     = 37;   // requested data is not available
  BASS_ERROR_DECODE       = 38;   // the channel is a "decoding channel"
  BASS_ERROR_DX           = 39;   // a sufficient DirectX version is not installed
  BASS_ERROR_TIMEOUT      = 40;   // connection timedout
  BASS_ERROR_FILEFORM     = 41;   // unsupported file format
  BASS_ERROR_SPEAKER      = 42;   // unavailable speaker
  BASS_ERROR_UNKNOWN      = -1;   // some other mystery error

  // Initialization flags
  BASS_DEVICE_8BITS       = 1;    // use 8 bit resolution, else 16 bit
  BASS_DEVICE_MONO        = 2;    // use mono, else stereo
  BASS_DEVICE_3D          = 4;    // enable 3D functionality
  {
    If the BASS_DEVICE_3D flag is not specified when
    initilizing BASS, then the 3D flags (BASS_SAMPLE_3D
    and BASS_MUSIC_3D) are ignored when loading/creating
    a sample/stream/music.
  }
  BASS_DEVICE_LATENCY     = 256;  // calculate device latency (BASS_INFO struct)
  BASS_DEVICE_SPEAKERS    = 2048; // force enabling of speaker assignment

  // DirectSound interfaces (for use with BASS_GetDSoundObject)
  BASS_OBJECT_DS          = 1;   // IDirectSound
  BASS_OBJECT_DS3DL       = 2;   // IDirectSound3DListener

  // BASS_INFO flags (from DSOUND.H)
  DSCAPS_CONTINUOUSRATE   = $00000010;
  { supports all sample rates between min/maxrate }
  DSCAPS_EMULDRIVER       = $00000020;
  { device does NOT have hardware DirectSound support }
  DSCAPS_CERTIFIED        = $00000040;
  { device driver has been certified by Microsoft }
  {
    The following flags tell what type of samples are
    supported by HARDWARE mixing, all these formats are
    supported by SOFTWARE mixing
  }
  DSCAPS_SECONDARYMONO    = $00000100;     // mono
  DSCAPS_SECONDARYSTEREO  = $00000200;     // stereo
  DSCAPS_SECONDARY8BIT    = $00000400;     // 8 bit
  DSCAPS_SECONDARY16BIT   = $00000800;     // 16 bit

  // BASS_RECORDINFO flags (from DSOUND.H)
  DSCCAPS_EMULDRIVER = DSCAPS_EMULDRIVER;
  { device does NOT have hardware DirectSound recording support }
  DSCCAPS_CERTIFIED = DSCAPS_CERTIFIED;
  { device driver has been certified by Microsoft }

  // defines for formats field of BASS_RECORDINFO (from MMSYSTEM.H)
  WAVE_FORMAT_1M08       = $00000001;      // 11.025 kHz, Mono,   8-bit
  WAVE_FORMAT_1S08       = $00000002;      // 11.025 kHz, Stereo, 8-bit
  WAVE_FORMAT_1M16       = $00000004;      // 11.025 kHz, Mono,   16-bit
  WAVE_FORMAT_1S16       = $00000008;      // 11.025 kHz, Stereo, 16-bit
  WAVE_FORMAT_2M08       = $00000010;      // 22.05  kHz, Mono,   8-bit
  WAVE_FORMAT_2S08       = $00000020;      // 22.05  kHz, Stereo, 8-bit
  WAVE_FORMAT_2M16       = $00000040;      // 22.05  kHz, Mono,   16-bit
  WAVE_FORMAT_2S16       = $00000080;      // 22.05  kHz, Stereo, 16-bit
  WAVE_FORMAT_4M08       = $00000100;      // 44.1   kHz, Mono,   8-bit
  WAVE_FORMAT_4S08       = $00000200;      // 44.1   kHz, Stereo, 8-bit
  WAVE_FORMAT_4M16       = $00000400;      // 44.1   kHz, Mono,   16-bit
  WAVE_FORMAT_4S16       = $00000800;      // 44.1   kHz, Stereo, 16-bit

  // Sample info flags
  BASS_SAMPLE_8BITS       = 1;   // 8 bit
  BASS_SAMPLE_FLOAT       = 256; // 32-bit floating-point
  BASS_SAMPLE_MONO        = 2;   // mono, else stereo
  BASS_SAMPLE_LOOP        = 4;   // looped
  BASS_SAMPLE_3D          = 8;   // 3D functionality enabled
  BASS_SAMPLE_SOFTWARE    = 16;  // it's NOT using hardware mixing
  BASS_SAMPLE_MUTEMAX     = 32;  // muted at max distance (3D only)
  BASS_SAMPLE_VAM         = 64;  // uses the DX7 voice allocation & management
  BASS_SAMPLE_FX          = 128; // old implementation of DX8 effects are enabled
  BASS_SAMPLE_OVER_VOL    = $10000; // override lowest volume
  BASS_SAMPLE_OVER_POS    = $20000; // override longest playing
  BASS_SAMPLE_OVER_DIST   = $30000; // override furthest from listener (3D only)

  BASS_MP3_SETPOS         = $20000; // enable pin-point seeking on the MP3/MP2/MP1

  BASS_STREAM_PRESCAN     = $20000;
  BASS_STREAM_AUTOFREE	  = $40000; // automatically free the stream when it stop/ends
  BASS_STREAM_RESTRATE	  = $80000; // restrict the download rate of internet file streams
  BASS_STREAM_BLOCK       = $100000;// download/play internet file stream in small blocks
  BASS_STREAM_DECODE      = $200000;// don't play the stream, only decode (BASS_ChannelGetData)
  BASS_STREAM_META        = $400000;// request metadata from a Shoutcast stream
  BASS_STREAM_STATUS      = $800000;// give server status info (HTTP/ICY tags) in DOWNLOADPROC

  BASS_MUSIC_FLOAT        = BASS_SAMPLE_FLOAT; // 32-bit floating-point
  BASS_MUSIC_MONO         = BASS_SAMPLE_MONO; // force mono mixing (less CPU usage)
  BASS_MUSIC_LOOP         = BASS_SAMPLE_LOOP; // loop music
  BASS_MUSIC_3D           = BASS_SAMPLE_3D; // enable 3D functionality
  BASS_MUSIC_FX           = BASS_SAMPLE_FX; // enable old implementation of DX8 effects
  BASS_MUSIC_AUTOFREE     = BASS_STREAM_AUTOFREE; // automatically free the music when it stop/ends
  BASS_MUSIC_DECODE       = BASS_STREAM_DECODE; // don't play the music, only decode (BASS_ChannelGetData)
  BASS_MUSIC_RAMP         = $200;  // normal ramping
  BASS_MUSIC_RAMPS        = $400;  // sensitive ramping
  BASS_MUSIC_SURROUND     = $800;  // surround sound
  BASS_MUSIC_SURROUND2    = $1000; // surround sound (mode 2)
  BASS_MUSIC_FT2MOD       = $2000; // play .MOD as FastTracker 2 does
  BASS_MUSIC_PT1MOD       = $4000; // play .MOD as ProTracker 1 does
  BASS_MUSIC_CALCLEN      = $8000; // calculate playback length
  BASS_MUSIC_NONINTER     = $10000; // non-interpolated mixing
  BASS_MUSIC_POSRESET     = $20000; // stop all notes when moving position
  BASS_MUSIC_POSRESETEX   = $400000; // stop all notes and reset bmp/etc when moving position
  BASS_MUSIC_STOPBACK     = $80000; // stop the music on a backwards jump effect
  BASS_MUSIC_NOSAMPLE     = $100000; // don't load the samples

  // Speaker assignment flags
  BASS_SPEAKER_FRONT      = $1000000;  // front speakers
  BASS_SPEAKER_REAR       = $2000000;  // rear/side speakers
  BASS_SPEAKER_CENLFE     = $3000000;  // center & LFE speakers (5.1)
  BASS_SPEAKER_REAR2      = $4000000;  // rear center speakers (7.1)
  BASS_SPEAKER_LEFT       = $10000000; // modifier: left
  BASS_SPEAKER_RIGHT      = $20000000; // modifier: right
  BASS_SPEAKER_FRONTLEFT  = BASS_SPEAKER_FRONT or BASS_SPEAKER_LEFT;
  BASS_SPEAKER_FRONTRIGHT = BASS_SPEAKER_FRONT or BASS_SPEAKER_RIGHT;
  BASS_SPEAKER_REARLEFT   = BASS_SPEAKER_REAR or BASS_SPEAKER_LEFT;
  BASS_SPEAKER_REARRIGHT  = BASS_SPEAKER_REAR or BASS_SPEAKER_RIGHT;
  BASS_SPEAKER_CENTER     = BASS_SPEAKER_CENLFE or BASS_SPEAKER_LEFT;
  BASS_SPEAKER_LFE        = BASS_SPEAKER_CENLFE or BASS_SPEAKER_RIGHT;
  BASS_SPEAKER_REAR2LEFT  = BASS_SPEAKER_REAR2 or BASS_SPEAKER_LEFT;
  BASS_SPEAKER_REAR2RIGHT = BASS_SPEAKER_REAR2 or BASS_SPEAKER_RIGHT;

  BASS_UNICODE            = $80000000;

  BASS_RECORD_PAUSE       = $8000; // start recording paused

  // DX7 voice allocation flags
  BASS_VAM_HARDWARE       = 1;
  {
    Play the sample in hardware. If no hardware voices are available then
    the "play" call will fail
  }
  BASS_VAM_SOFTWARE       = 2;
  {
    Play the sample in software (ie. non-accelerated). No other VAM flags
    may be used together with this flag.
  }

  // DX7 voice management flags
  {
    These flags enable hardware resource stealing... if the hardware has no
    available voices, a currently playing buffer will be stopped to make room
    for the new buffer. NOTE: only samples loaded/created with the
    BASS_SAMPLE_VAM flag are considered for termination by the DX7 voice
    management.
  }
  BASS_VAM_TERM_TIME      = 4;
  {
    If there are no free hardware voices, the buffer to be terminated will be
    the one with the least time left to play.
  }
  BASS_VAM_TERM_DIST      = 8;
  {
    If there are no free hardware voices, the buffer to be terminated will be
    one that was loaded/created with the BASS_SAMPLE_MUTEMAX flag and is
    beyond
    it's max distance. If there are no buffers that match this criteria, then
    the "play" call will fail.
  }
  BASS_VAM_TERM_PRIO      = 16;
  {
    If there are no free hardware voices, the buffer to be terminated will be
    the one with the lowest priority.
  }

  // BASS_CHANNELINFO types
  BASS_CTYPE_SAMPLE       = 1;
  BASS_CTYPE_RECORD       = 2;
  BASS_CTYPE_STREAM       = $10000;
  BASS_CTYPE_STREAM_WAV   = $10001;
  BASS_CTYPE_STREAM_OGG   = $10002;
  BASS_CTYPE_STREAM_MP1   = $10003;
  BASS_CTYPE_STREAM_MP2   = $10004;
  BASS_CTYPE_STREAM_MP3   = $10005;
  BASS_CTYPE_MUSIC_MOD    = $20000;
  BASS_CTYPE_MUSIC_MTM    = $20001;
  BASS_CTYPE_MUSIC_S3M    = $20002;
  BASS_CTYPE_MUSIC_XM     = $20003;
  BASS_CTYPE_MUSIC_IT     = $20004;
  BASS_CTYPE_MUSIC_MO3    = $00100; // mo3 flag

  // 3D channel modes
  BASS_3DMODE_NORMAL      = 0;
  { normal 3D processing }
  BASS_3DMODE_RELATIVE    = 1;
  {
    The channel's 3D position (position/velocity/
    orientation) are relative to the listener. When the
    listener's position/velocity/orientation is changed
    with BASS_Set3DPosition, the channel's position
    relative to the listener does not change.
  }
  BASS_3DMODE_OFF         = 2;
  {
    Turn off 3D processing on the channel, the sound will
    be played in the center.
  }

  // EAX environments, use with BASS_SetEAXParameters
  EAX_ENVIRONMENT_OFF               = -1;
  EAX_ENVIRONMENT_GENERIC           = 0;
  EAX_ENVIRONMENT_PADDEDCELL        = 1;
  EAX_ENVIRONMENT_ROOM              = 2;
  EAX_ENVIRONMENT_BATHROOM          = 3;
  EAX_ENVIRONMENT_LIVINGROOM        = 4;
  EAX_ENVIRONMENT_STONEROOM         = 5;
  EAX_ENVIRONMENT_AUDITORIUM        = 6;
  EAX_ENVIRONMENT_CONCERTHALL       = 7;
  EAX_ENVIRONMENT_CAVE              = 8;
  EAX_ENVIRONMENT_ARENA             = 9;
  EAX_ENVIRONMENT_HANGAR            = 10;
  EAX_ENVIRONMENT_CARPETEDHALLWAY   = 11;
  EAX_ENVIRONMENT_HALLWAY           = 12;
  EAX_ENVIRONMENT_STONECORRIDOR     = 13;
  EAX_ENVIRONMENT_ALLEY             = 14;
  EAX_ENVIRONMENT_FOREST            = 15;
  EAX_ENVIRONMENT_CITY              = 16;
  EAX_ENVIRONMENT_MOUNTAINS         = 17;
  EAX_ENVIRONMENT_QUARRY            = 18;
  EAX_ENVIRONMENT_PLAIN             = 19;
  EAX_ENVIRONMENT_PARKINGLOT        = 20;
  EAX_ENVIRONMENT_SEWERPIPE         = 21;
  EAX_ENVIRONMENT_UNDERWATER        = 22;
  EAX_ENVIRONMENT_DRUGGED           = 23;
  EAX_ENVIRONMENT_DIZZY             = 24;
  EAX_ENVIRONMENT_PSYCHOTIC         = 25;
  // total number of environments
  EAX_ENVIRONMENT_COUNT             = 26;

  // software 3D mixing algorithm modes (used with BASS_Set3DAlgorithm)
  BASS_3DALG_DEFAULT                = 0;
  {
    default algorithm (currently translates to BASS_3DALG_OFF)
  }
  BASS_3DALG_OFF                    = 1;
  {
    Uses normal left and right panning. The vertical axis is ignored except
    for scaling of volume due to distance. Doppler shift and volume scaling
    are still applied, but the 3D filtering is not performed. This is the
    most CPU efficient software implementation, but provides no virtual 3D
    audio effect. Head Related Transfer Function processing will not be done.
    Since only normal stereo panning is used, a channel using this algorithm
    may be accelerated by a 2D hardware voice if no free 3D hardware voices
    are available.
  }
  BASS_3DALG_FULL                   = 2;
  {
    This algorithm gives the highest quality 3D audio effect, but uses more
    CPU. Requires Windows 98 2nd Edition or Windows 2000 that uses WDM
    drivers, if this mode is not available then BASS_3DALG_OFF will be used
    instead.
  }
  BASS_3DALG_LIGHT                  = 3;
  {
    This algorithm gives a good 3D audio effect, and uses less CPU than the
    FULL mode. Requires Windows 98 2nd Edition or Windows 2000 that uses WDM
    drivers, if this mode is not available then BASS_3DALG_OFF will be used
    instead.
  }

  {
    Sync types (with BASS_ChannelSetSync() "param" and
    SYNCPROC "data" definitions) & flags.
  }
  BASS_SYNC_POS                     = 0;
  BASS_SYNC_MUSICPOS                = 0;
  {
    Sync when a music or stream reaches a position.
    if HMUSIC...
    param: LOWORD=order (0=first, -1=all) HIWORD=row (0=first, -1=all)
    data : LOWORD=order HIWORD=row
    if HSTREAM...
    param: position in bytes
    data : not used
  }
  BASS_SYNC_MUSICINST               = 1;
  {
    Sync when an instrument (sample for the non-instrument
    based formats) is played in a music (not including
    retrigs).
    param: LOWORD=instrument (1=first) HIWORD=note (0=c0...119=b9, -1=all)
    data : LOWORD=note HIWORD=volume (0-64)
  }
  BASS_SYNC_END                     = 2;
  {
    Sync when a music or file stream reaches the end.
    param: not used
    data : not used
  }
  BASS_SYNC_MUSICFX                 = 3;
  {
    Sync when the "sync" effect (XM/MTM/MOD: E8x/Wxx, IT/S3M: S2x) is used.
    param: 0:data=pos, 1:data="x" value
    data : param=0: LOWORD=order HIWORD=row, param=1: "x" value
  }
  BASS_SYNC_META                    = 4;
  {
    Sync when metadata is received in a Shoutcast stream.
    param: not used
    data : pointer to the metadata
  }
  BASS_SYNC_SLIDE                   = 5;
  {
    Sync when an attribute slide is completed.
    param: not used
    data : the type of slide completed (one of the BASS_SLIDE_xxx values)
  }
  BASS_SYNC_STALL                   = 6;
  {
    Sync when playback has stalled.
    param: not used
    data : 0=stalled, 1=resumed
  }
  BASS_SYNC_DOWNLOAD                = 7;
  {
    Sync when downloading of an internet (or "buffered" user file) stream has ended.
    param: not used
    data : not used
  }
  BASS_SYNC_FREE                    = 8;
  {
    Sync when a channel is freed.
    param: not used
    data : not used
  }
  BASS_SYNC_MESSAGE                 = $20000000;
  { FLAG: post a Windows message (instead of callback)
    When using a window message "callback", the message to post is given in the "proc"
    parameter of BASS_ChannelSetSync, and is posted to the window specified in the BASS_Init
    call. The message parameters are: WPARAM = data, LPARAM = user.
  }
  BASS_SYNC_MIXTIME                 = $40000000;
  { FLAG: sync at mixtime, else at playtime }
  BASS_SYNC_ONETIME                 = $80000000;
  { FLAG: sync only once, else continuously }

  // BASS_ChannelIsActive return values
  BASS_ACTIVE_STOPPED = 0;
  BASS_ACTIVE_PLAYING = 1;
  BASS_ACTIVE_STALLED = 2;
  BASS_ACTIVE_PAUSED  = 3;

  // BASS_ChannelIsSliding return flags
  BASS_SLIDE_FREQ     = 1;
  BASS_SLIDE_VOL      = 2;
  BASS_SLIDE_PAN      = 4;

  // BASS_ChannelGetData flags
  BASS_DATA_AVAILABLE = 0;        // query how much data is buffered
  BASS_DATA_FFT512   = $80000000; // 512 sample FFT
  BASS_DATA_FFT1024  = $80000001; // 1024 FFT
  BASS_DATA_FFT2048  = $80000002; // 2048 FFT
  BASS_DATA_FFT4096  = $80000003; // 4096 FFT
  BASS_DATA_FFT_INDIVIDUAL = $10; // FFT flag: FFT for each channel, else all combined
  BASS_DATA_FFT_NOWINDOW = $20;   // FFT flag: no Hanning window

  BASS_DATA_WAVE_512  = 512;
  BASS_DATA_WAVE_1024 = 1024;
  BASS_DATA_WAVE_2048 = 2048;
  BASS_DATA_WAVE_4096 = 4096;

  // BASS_StreamGetTags flags : what's returned
  BASS_TAG_ID3   = 0; // ID3v1 tags : 128 byte block
  BASS_TAG_ID3V2 = 1; // ID3v2 tags : variable length block
  BASS_TAG_OGG   = 2; // OGG comments : array of null-terminated strings
  BASS_TAG_HTTP  = 3; // HTTP headers : array of null-terminated strings
  BASS_TAG_ICY   = 4; // ICY headers : array of null-terminated strings
  BASS_TAG_META  = 5; // ICY metadata : null-terminated string

  BASS_FX_CHORUS      = 0;      // GUID_DSFX_STANDARD_CHORUS
  BASS_FX_COMPRESSOR  = 1;      // GUID_DSFX_STANDARD_COMPRESSOR
  BASS_FX_DISTORTION  = 2;      // GUID_DSFX_STANDARD_DISTORTION
  BASS_FX_ECHO        = 3;      // GUID_DSFX_STANDARD_ECHO
  BASS_FX_FLANGER     = 4;      // GUID_DSFX_STANDARD_FLANGER
  BASS_FX_GARGLE      = 5;      // GUID_DSFX_STANDARD_GARGLE
  BASS_FX_I3DL2REVERB = 6;      // GUID_DSFX_STANDARD_I3DL2REVERB
  BASS_FX_PARAMEQ     = 7;      // GUID_DSFX_STANDARD_PARAMEQ
  BASS_FX_REVERB      = 8;      // GUID_DSFX_WAVES_REVERB

  BASS_FX_PHASE_NEG_180 = 0;
  BASS_FX_PHASE_NEG_90  = 1;
  BASS_FX_PHASE_ZERO    = 2;
  BASS_FX_PHASE_90      = 3;
  BASS_FX_PHASE_180     = 4;

  // BASS_RecordSetInput flags
  BASS_INPUT_OFF    = $10000;
  BASS_INPUT_ON     = $20000;
  BASS_INPUT_LEVEL  = $40000;

  BASS_INPUT_TYPE_MASK    = $ff000000;
  BASS_INPUT_TYPE_UNDEF   = $00000000;
  BASS_INPUT_TYPE_DIGITAL = $01000000;
  BASS_INPUT_TYPE_LINE    = $02000000;
  BASS_INPUT_TYPE_MIC     = $03000000;
  BASS_INPUT_TYPE_SYNTH   = $04000000;
  BASS_INPUT_TYPE_CD      = $05000000;
  BASS_INPUT_TYPE_PHONE   = $06000000;
  BASS_INPUT_TYPE_SPEAKER = $07000000;
  BASS_INPUT_TYPE_WAVE    = $08000000;
  BASS_INPUT_TYPE_AUX     = $09000000;
  BASS_INPUT_TYPE_ANALOG  = $0a000000;

  // BASS_SetNetConfig flags
  BASS_NET_TIMEOUT  = 0;
  BASS_NET_BUFFER   = 1;

  // BASS_StreamGetFilePosition modes
  BASS_FILEPOS_DECODE     = 0;
  BASS_FILEPOS_DOWNLOAD   = 1;
  BASS_FILEPOS_END        = 2;
  BASS_FILEPOS_START      = 3;

  // STREAMFILEPROC actions
  BASS_FILE_CLOSE   = 0;
  BASS_FILE_READ    = 1;
  BASS_FILE_QUERY   = 2;
  BASS_FILE_LEN     = 3;
  BASS_FILE_SEEK    = 4;

  BASS_STREAMPROC_END = $80000000; // end of user stream flag

  // BASS_MusicSet/GetAttribute options
  BASS_MUSIC_ATTRIB_AMPLIFY    = 0;
  BASS_MUSIC_ATTRIB_PANSEP     = 1;
  BASS_MUSIC_ATTRIB_PSCALER    = 2;
  BASS_MUSIC_ATTRIB_BPM        = 3;
  BASS_MUSIC_ATTRIB_SPEED      = 4;
  BASS_MUSIC_ATTRIB_VOL_GLOBAL = 5;
  BASS_MUSIC_ATTRIB_VOL_CHAN   = $100; // + channel #
  BASS_MUSIC_ATTRIB_VOL_INST   = $200; // + instrument #

  // BASS_Set/GetConfig options
  BASS_CONFIG_BUFFER        = 0;
  BASS_CONFIG_UPDATEPERIOD  = 1;
  BASS_CONFIG_MAXVOL        = 3;
  BASS_CONFIG_GVOL_SAMPLE   = 4;
  BASS_CONFIG_GVOL_STREAM   = 5;
  BASS_CONFIG_GVOL_MUSIC    = 6;
  BASS_CONFIG_CURVE_VOL     = 7;
  BASS_CONFIG_CURVE_PAN     = 8;
  BASS_CONFIG_FLOATDSP      = 9;
  BASS_CONFIG_3DALGORITHM   = 10;
  BASS_CONFIG_NET_TIMEOUT   = 11;
  BASS_CONFIG_NET_BUFFER    = 12;
  BASS_CONFIG_PAUSE_NOPLAY  = 13;
  BASS_CONFIG_NET_NOPROXY   = 14;

type
  HMUSIC = DWORD;       // MOD music handle
  HSAMPLE = DWORD;      // sample handle
  HCHANNEL = DWORD;     // playing sample's channel handle
  HSTREAM = DWORD;      // sample stream handle
  HRECORD = DWORD;      // recording handle
  HSYNC = DWORD;        // synchronizer handle
  HDSP = DWORD;         // DSP handle
  HFX = DWORD;          // DX8 effect handle

  BASS_INFO = record
    size: DWORD;        // size of this struct (set this before calling the function)
    flags: DWORD;       // device capabilities (DSCAPS_xxx flags)
    hwsize: DWORD;      // size of total device hardware memory
    hwfree: DWORD;      // size of free device hardware memory
    freesam: DWORD;     // number of free sample slots in the hardware
    free3d: DWORD;      // number of free 3D sample slots in the hardware
    minrate: DWORD;     // min sample rate supported by the hardware
    maxrate: DWORD;     // max sample rate supported by the hardware
    eax: BOOL;          // device supports EAX? (always FALSE if BASS_DEVICE_3D was not used)
    minbuf: DWORD;      // recommended minimum buffer length in ms (requires BASS_DEVICE_LATENCY)
    dsver: DWORD;       // DirectSound version
    latency: DWORD;     // delay (in ms) before start of playback (requires BASS_DEVICE_LATENCY)
    initflags: DWORD;   // "flags" parameter of BASS_Init call
    speakers: DWORD;    // number of speakers available
	  driver: PChar;      // driver
  end;

  BASS_RECORDINFO = record
    size: DWORD;        // size of this struct (set this before calling the function)
    flags: DWORD;       // device capabilities (DSCCAPS_xxx flags)
    formats: DWORD;     // supported standard formats (WAVE_FORMAT_xxx flags)
    inputs: DWORD;      // number of inputs
    singlein: BOOL;     // only 1 input can be set at a time
  	driver: PChar;      // driver
  end;

  BASS_CHANNELINFO = record
    freq: DWORD;        // default playback rate
    chans: DWORD;       // channels
    flags: DWORD;       // BASS_SAMPLE/STREAM/MUSIC/SPEAKER flags
    ctype: DWORD;       // type of channel
    origres: DWORD;     // original resolution
  end;

  // Sample info structure
  BASS_SAMPLE = record
    freq: DWORD;        // default playback rate
    volume: DWORD;      // default volume (0-100)
    pan: Integer;       // default pan (-100=left, 0=middle, 100=right)
    flags: DWORD;       // BASS_SAMPLE_xxx flags
    length: DWORD;      // length (in samples, not bytes)
    max: DWORD;         // maximum simultaneous playbacks
  	origres: DWORD;     // original resolution
    {
      The following are the sample's default 3D attributes
      (if the sample is 3D, BASS_SAMPLE_3D is in flags)
      see BASS_ChannelSet3DAttributes
    }
    mode3d: DWORD;      // BASS_3DMODE_xxx mode
    mindist: FLOAT;     // minimum distance
    maxdist: FLOAT;     // maximum distance
    iangle: DWORD;      // angle of inside projection cone
    oangle: DWORD;      // angle of outside projection cone
    outvol: DWORD;      // delta-volume outside the projection cone
    {
      The following are the defaults used if the sample uses the DirectX 7
      voice allocation/management features.
    }
    vam: DWORD;         // voice allocation/management flags (BASS_VAM_xxx)
    priority: DWORD;    // priority (0=lowest, $ffffffff=highest)
  end;

  // 3D vector (for 3D positions/velocities/orientations)
  BASS_3DVECTOR = record
    x: FLOAT;           // +=right, -=left
    y: FLOAT;           // +=up, -=down
    z: FLOAT;           // +=front, -=behind
  end;

  BASS_FXCHORUS = record
    fWetDryMix: FLOAT;
    fDepth: FLOAT;
    fFeedback: FLOAT;
    fFrequency: FLOAT;
    lWaveform: DWORD;   // 0=triangle, 1=sine
    fDelay: FLOAT;
    lPhase: DWORD;      // BASS_FX_PHASE_xxx
  end;

  BASS_FXCOMPRESSOR = record
    fGain: FLOAT;
    fAttack: FLOAT;
    fRelease: FLOAT;
    fThreshold: FLOAT;
    fRatio: FLOAT;
    fPredelay: FLOAT;
  end;

  BASS_FXDISTORTION = record
    fGain: FLOAT;
    fEdge: FLOAT;
    fPostEQCenterFrequency: FLOAT;
    fPostEQBandwidth: FLOAT;
    fPreLowpassCutoff: FLOAT;
  end;

  BASS_FXECHO = record
    fWetDryMix: FLOAT;
    fFeedback: FLOAT;
    fLeftDelay: FLOAT;
    fRightDelay: FLOAT;
    lPanDelay: BOOL;
  end;

  BASS_FXFLANGER = record
    fWetDryMix: FLOAT;
    fDepth: FLOAT;
    fFeedback: FLOAT;
    fFrequency: FLOAT;
    lWaveform: DWORD;   // 0=triangle, 1=sine
    fDelay: FLOAT;
    lPhase: DWORD;      // BASS_FX_PHASE_xxx
  end;

  BASS_FXGARGLE = record
    dwRateHz: DWORD;               // Rate of modulation in hz
    dwWaveShape: DWORD;            // 0=triangle, 1=square
  end;

  BASS_FXI3DL2REVERB = record
    lRoom: Longint;                // [-10000, 0]      default: -1000 mB
    lRoomHF: Longint;              // [-10000, 0]      default: 0 mB
    flRoomRolloffFactor: FLOAT;    // [0.0, 10.0]      default: 0.0
    flDecayTime: FLOAT;            // [0.1, 20.0]      default: 1.49s
    flDecayHFRatio: FLOAT;         // [0.1, 2.0]       default: 0.83
    lReflections: Longint;         // [-10000, 1000]   default: -2602 mB
    flReflectionsDelay: FLOAT;     // [0.0, 0.3]       default: 0.007 s
    lReverb: Longint;              // [-10000, 2000]   default: 200 mB
    flReverbDelay: FLOAT;          // [0.0, 0.1]       default: 0.011 s
    flDiffusion: FLOAT;            // [0.0, 100.0]     default: 100.0 %
    flDensity: FLOAT;              // [0.0, 100.0]     default: 100.0 %
    flHFReference: FLOAT;          // [20.0, 20000.0]  default: 5000.0 Hz
  end;

  BASS_FXPARAMEQ = record
    fCenter: FLOAT;
    fBandwidth: FLOAT;
    fGain: FLOAT;
  end;

  BASS_FXREVERB = record
    fInGain: FLOAT;                // [-96.0,0.0]            default: 0.0 dB
    fReverbMix: FLOAT;             // [-96.0,0.0]            default: 0.0 db
    fReverbTime: FLOAT;            // [0.001,3000.0]         default: 1000.0 ms
    fHighFreqRTRatio: FLOAT;       // [0.001,0.999]          default: 0.001
  end;

  // callback function types
  STREAMPROC = function(handle: HSTREAM; buffer: Pointer; length: DWORD; user: DWORD): DWORD; stdcall;
  {
    User stream callback function. NOTE: A stream function should obviously be as
    quick as possible, other streams (and MOD musics) can't be mixed until
    it's finished.
    handle : The stream that needs writing
    buffer : Buffer to write the samples in
    length : Number of bytes to write
    user   : The 'user' parameter value given when calling BASS_StreamCreate
    RETURN : Number of bytes written. Set the BASS_STREAMPROC_END flag to end
             the stream.
  }

  STREAMFILEPROC = function(action, param1, param2, user: DWORD): DWORD; stdcall;
  {
    User file stream callback function.
    action : The action to perform, one of BASS_FILE_xxx values.
    param1 : Depends on "action"
    param2 : Depends on "action"
    user   : The 'user' parameter value given when calling BASS_StreamCreate
    RETURN : Depends on "action"
  }

  DOWNLOADPROC = procedure(buffer: Pointer; length: DWORD; user: DWORD); stdcall;
  {
    Internet stream download callback function.
    buffer : Buffer containing the downloaded data... NULL=end of download
    length : Number of bytes in the buffer
    user   : The 'user' parameter value given when calling BASS_StreamCreateURL
  }

  SYNCPROC = procedure(handle: HSYNC; channel, data: DWORD; user: DWORD); stdcall;
  {
    Sync callback function. NOTE: a sync callback function should be very
    quick as other syncs cannot be processed until it has finished. If the
    sync is a "mixtime" sync, then other streams and MOD musics can not be
    mixed until it's finished either.
    handle : The sync that has occured
    channel: Channel that the sync occured in
    data   : Additional data associated with the sync's occurance
    user   : The 'user' parameter given when calling BASS_ChannelSetSync
  }

  DSPPROC = procedure(handle: HDSP; channel: DWORD; buffer: Pointer; length: DWORD; user: DWORD); stdcall;
  {
    DSP callback function. NOTE: A DSP function should obviously be as quick
    as possible... other DSP functions, streams and MOD musics can not be
    processed until it's finished.
    handle : The DSP handle
    channel: Channel that the DSP is being applied to
    buffer : Buffer to apply the DSP to
    length : Number of bytes in the buffer
    user   : The 'user' parameter given when calling BASS_ChannelSetDSP
  }

  RECORDPROC = function(handle: HRECORD; buffer: Pointer; length: DWORD; user: DWORD): BOOL; stdcall;
  {
    Recording callback function.
    handle : The recording handle
    buffer : Buffer containing the recorded sample data
    length : Number of bytes
    user   : The 'user' parameter value given when calling BASS_RecordStart
    RETURN : TRUE = continue recording, FALSE = stop
  }

   TBASS_SetConfig = function(option, value: DWORD): DWORD; stdcall;
   TBASS_GetConfig = function(option: DWORD): DWORD; stdcall;
   TBASS_GetVersion = function: DWORD; stdcall;
   TBASS_GetDeviceDescription = function(device: DWORD): PChar; stdcall;
   TBASS_ErrorGetCode = function: DWORD; stdcall;
   TBASS_Init = function(device: Integer; freq, flags: DWORD; win: HWND; clsid: PGUID): BOOL; stdcall;
   TBASS_SetDevice = function(device: DWORD): BOOL; stdcall;
   TBASS_GetDevice = function: DWORD; stdcall;
   TBASS_Free = function: BOOL; stdcall;
   TBASS_GetDSoundObject = function(obj: DWORD): Pointer; stdcall;
   TBASS_GetInfo = function(var info:    BASS_INFO): BOOL; stdcall;
   TBASS_Update = function: BOOL; stdcall;
   TBASS_GetCPU = function: FLOAT; stdcall;
   TBASS_Start = function: BOOL; stdcall;
   TBASS_Stop = function: BOOL; stdcall;
   TBASS_Pause = function: BOOL; stdcall;
   TBASS_SetVolume = function(volume: DWORD): BOOL; stdcall;
   TBASS_GetVolume = function: Integer; stdcall;

   TBASS_Set3DFactors = function(distf, rollf, doppf: FLOAT): BOOL; stdcall;
   TBASS_Get3DFactors = function(var distf, rollf, doppf: FLOAT): BOOL; stdcall;
   TBASS_Set3DPosition = function(var pos, vel, front, top:    BASS_3DVECTOR): BOOL; stdcall;
   TBASS_Get3DPosition = function(var pos, vel, front, top:    BASS_3DVECTOR): BOOL; stdcall;
   TBASS_Apply3D = procedure; stdcall;
   TBASS_SetEAXParameters = function(env: Integer; vol, decay, damp: FLOAT): BOOL; stdcall;
   TBASS_GetEAXParameters = function(var env: DWORD; var vol, decay, damp: FLOAT): BOOL; stdcall;

   TBASS_MusicLoad = function(mem: BOOL; f: Pointer; offset, length, flags, freq: DWORD): HMUSIC; stdcall;
   TBASS_MusicFree = procedure(handle: HMUSIC); stdcall;
   TBASS_MusicGetName = function(handle: HMUSIC): PChar; stdcall;
   TBASS_MusicGetLength = function(handle: HMUSIC; playlen: BOOL): DWORD; stdcall;
   TBASS_MusicSetAttribute = function(handle: HMUSIC; attrib,value: DWORD): DWORD; stdcall;
   TBASS_MusicGetAttribute = function(handle: HMUSIC; attrib: DWORD): DWORD; stdcall;
   TBASS_MusicPreBuf = function (handle: HMUSIC): BOOL; stdcall;
   TBASS_MusicPlay = function (handle: HMUSIC): BOOL; stdcall;
   TBASS_MusicPlayEx = function (handle: HMUSIC; pos: DWORD; flags: Integer; reset: BOOL): BOOL; stdcall;
   TBASS_MusicSetAmplify = function (handle: HMUSIC; amp: DWORD): BOOL; stdcall;
   TBASS_MusicSetPanSep = function (handle: HMUSIC; pan: DWORD): BOOL; stdcall;
   TBASS_MusicSetPositionScaler = function (handle: HMUSIC; scale: DWORD): BOOL; stdcall;
   TBASS_MusicSetVolume = function (handle: HMUSIC; chanins,volume: DWORD): BOOL; stdcall;
   TBASS_MusicGetVolume = function (handle: HMUSIC; chanins: DWORD): Integer; stdcall;

   TBASS_SampleLoad = function(mem: BOOL; f: Pointer; offset, length, max, flags: DWORD): HSAMPLE; stdcall;
   TBASS_SampleCreate = function(length, freq, max, flags: DWORD): Pointer; stdcall;
   TBASS_SampleCreateDone = function: HSAMPLE; stdcall;
   TBASS_SampleFree = procedure(handle: HSAMPLE); stdcall;
   TBASS_SampleGetInfo = function(handle: HSAMPLE; var info:    BASS_SAMPLE): BOOL; stdcall;
   TBASS_SampleSetInfo = function(handle: HSAMPLE; var info:    BASS_SAMPLE): BOOL; stdcall;
   TBASS_SampleGetChannel = function(handle: HSAMPLE; onlynew: BOOL): HCHANNEL; stdcall;
   TBASS_SampleStop = function(handle: HSAMPLE): BOOL; stdcall;
   TBASS_SamplePlay = function (handle: HSAMPLE): HCHANNEL; stdcall;
   TBASS_SamplePlayEx = function (handle: HSAMPLE; start: DWORD; freq, volume, pan: Integer; loop: BOOL): HCHANNEL; stdcall;
   TBASS_SamplePlay3D = function (handle: HSAMPLE; var pos, orient, vel: BASS_3DVECTOR): HCHANNEL; stdcall;
   TBASS_SamplePlay3DEx = function (handle: HSAMPLE; var pos, orient, vel: BASS_3DVECTOR; start: DWORD; freq, volume: Integer; loop: BOOL): HCHANNEL; stdcall;

   TBASS_StreamCreate = function(freq, chans, flags: DWORD; proc: Pointer; user: DWORD): HSTREAM; stdcall;
   TBASS_StreamCreateFile = function(mem: BOOL; f: Pointer; offset, length, flags: DWORD): HSTREAM; stdcall;
   TBASS_StreamCreateURL = function(URL:PChar; offset:DWORD; flags:DWORD; proc:DOWNLOADPROC; user:DWORD):HSTREAM; stdcall;
   TBASS_StreamCreateFileUser = function(buffered: BOOL; flags: DWORD; proc:STREAMFILEPROC; user:DWORD): HSTREAM; stdcall;
   TBASS_StreamFree = procedure(handle: HSTREAM); stdcall;
//   TBASS_StreamGetLength = function(handle: HSTREAM): QWORD; stdcall;
   TBASS_StreamGetTags = function(handle: HSTREAM; tags : DWORD): PChar; stdcall;
   TBASS_StreamGetFilePosition = function(handle:HSTREAM; mode:DWORD) : DWORD;stdcall;
   TBASS_StreamPreBuf = function (handle: HMUSIC): BOOL; stdcall;
   TBASS_StreamPlay = function (handle: HSTREAM; flush: BOOL; flags: DWORD): BOOL; stdcall;

   TBASS_RecordGetDeviceDescription = function(devnum: DWORD):PChar;stdcall;
   TBASS_RecordInit = function(device: Integer):BOOL;stdcall;
   TBASS_RecordSetDevice = function(device: DWORD): BOOL; stdcall;
   TBASS_RecordGetDevice = function: DWORD; stdcall;
   TBASS_RecordFree = function:BOOL;stdcall;
   TBASS_RecordGetInfo = function(var info:   BASS_RECORDINFO):BOOL;stdcall;
   TBASS_RecordGetInputName = function(input:DWORD):PChar;stdcall;
   TBASS_RecordSetInput = function(input:DWORD; setting:DWORD):BOOL;stdcall;
   TBASS_RecordGetInput = function(input:DWORD):DWORD;stdcall;
   TBASS_RecordStart= function(freq,chans,flags:DWORD; proc:RECORDPROC; user:DWORD):HRECORD;stdcall;

   TBASS_ChannelBytes2Seconds = function(handle: DWORD; pos: QWORD): FLOAT; stdcall;
   TBASS_ChannelSeconds2Bytes = function(handle: DWORD; pos: FLOAT): QWORD; stdcall;
   TBASS_ChannelGetDevice = function(handle: DWORD): DWORD; stdcall;
   TBASS_ChannelIsActive = function(handle: DWORD): DWORD; stdcall;
   TBASS_ChannelGetInfo = function(handle: DWORD; var info:   BASS_CHANNELINFO):BOOL;stdcall;
   TBASS_ChannelSetFlags = function(handle, flags: DWORD): BOOL; stdcall;
   TBASS_ChannelPreBuf = function(handle: DWORD): BOOL; stdcall;
   TBASS_ChannelPlay = function(handle: DWORD; restart: BOOL): BOOL; stdcall;
   TBASS_ChannelStop = function(handle: DWORD): BOOL; stdcall;
   TBASS_ChannelPause = function(handle: DWORD): BOOL; stdcall;
   TBASS_ChannelSetAttributes = function(handle: DWORD; freq, volume, pan: Integer): BOOL; stdcall;
   TBASS_ChannelGetAttributes = function(handle: DWORD; var freq, volume: DWORD; var pan: Integer): BOOL; stdcall;
   TBASS_ChannelSlideAttributes = function(handle: DWORD; freq, volume, pan: Integer; time: DWORD): BOOL; stdcall;
   TBASS_ChannelIsSliding = function(handle: DWORD): DWORD; stdcall;
   TBASS_ChannelSet3DAttributes = function(handle: DWORD; mode: Integer; min, max: FLOAT; iangle, oangle, outvol: Integer): BOOL; stdcall;
   TBASS_ChannelGet3DAttributes = function(handle: DWORD; var mode: DWORD; var min, max: FLOAT; var iangle, oangle, outvol: DWORD): BOOL; stdcall;
   TBASS_ChannelSet3DPosition = function(handle: DWORD; var pos, orient, vel:    BASS_3DVECTOR): BOOL; stdcall;
   TBASS_ChannelGet3DPosition = function(handle: DWORD; var pos, orient, vel:    BASS_3DVECTOR): BOOL; stdcall;
   TBASS_ChannelSetPosition = function(handle: DWORD; pos: QWORD): BOOL; stdcall;
   TBASS_ChannelGetPosition = function(handle: DWORD): QWORD; stdcall;
   TBASS_ChannelGetLevel = function(handle: DWORD): DWORD; stdcall;
   TBASS_ChannelGetData = function(handle: DWORD; buffer: Pointer; length: DWORD): DWORD; stdcall;
   TBASS_ChannelSetSync = function(handle: DWORD; stype: DWORD; param: QWORD; proc: SYNCPROC; user: DWORD): HSYNC; stdcall;
   TBASS_ChannelRemoveSync = function(handle: DWORD; sync: HSYNC): BOOL; stdcall;
   TBASS_ChannelSetDSP = function(handle: DWORD; proc: DSPPROC; user: DWORD; priority: Integer): HDSP; stdcall;
   TBASS_ChannelRemoveDSP = function(handle: DWORD; dsp: HDSP): BOOL; stdcall;
   TBASS_ChannelSetEAXMix = function(handle: DWORD; mix: FLOAT): BOOL; stdcall;
   TBASS_ChannelGetEAXMix = function(handle: DWORD; var mix: FLOAT): BOOL; stdcall;
   TBASS_ChannelSetLink = function(handle, chan: DWORD): BOOL; stdcall;
   TBASS_ChannelRemoveLink = function(handle, chan: DWORD): BOOL; stdcall;
   TBASS_ChannelSetFX = function(handle, etype: DWORD; priority: Integer): HFX; stdcall;
   TBASS_ChannelRemoveFX = function(handle: DWORD; fx: HFX): BOOL; stdcall;
   TBASS_ChannelResume = function (handle: DWORD): BOOL; stdcall;
   TBASS_ChannelGetLength = function(handle: DWORD): QWORD; stdcall;

   TBASS_FXSetParameters = function(handle: HFX; par: Pointer): BOOL; stdcall;
   TBASS_FXGetParameters = function(handle: HFX; par: Pointer): BOOL; stdcall;

//------------------------------------------------------------------------------

{
  BASS_FX.DLL 2.0 Multimedia Library, header file date 12.03.03
  Requires BASS 2.0 - available from www.un4seen.com
  -----------------------------
  Please report bugs/suggestions/etc... to wtgdana@aol.com
  -----------------------------

  The contents of this header file were built upon an original header file
  furnished with BassFx.dll from http://www.un4seen.com/music

  Original copyrights
    Copyright (c) 2002-2003 JOBnik! [Arthur Aminov, ISRAEL]
    Copyright (c) 2002 Roger Johansson. w1dg3r@yahoo.com

  Edit by omata (Thorsten) - http://www.delphipraxis.net
}

{$ifdef VER90}
  {$define USE_64_ASM}
{$endif VER90}
{$ifdef VER100}
  {$define USE_64_ASM}
{$endif VER100}
{$ifdef VER110}
  {$define USE_64_ASM}
{$endif VER110}

type
  EBassFx = class(Exception);

const
  // Error codes returned by BASS_FX_ErrorGetCode()
  BASS_FX_OK			        = 0;	// All is OK
  BASS_FX_ERROR_MALLOC		= 1;	// Memory allocation error
  BASS_FX_ERROR_FREED		  = 2;	// BASS_FX was freed
  BASS_FX_ERROR_BPMINUSE	= 3;	// BPM detection is in use
  BASS_FX_ERROR_BPMX2		  = 4;	// BPM has been already mult by 2
  BASS_FX_ERROR_HANDLE		= 5;	// Invalid handle
  BASS_FX_ERROR_FREQ		  = 6;	// Illegal sample rate
  BASS_FX_ERROR_NODECODE	= 7;	// Not a decoding channel
  BASS_FX_ERROR_FORMAT		= 8;	// File format is not supported
  BASS_FX_ERROR_STEREO		= 9;	// Only for stereo
  BASS_FX_ERROR_MODLEN		= 10;	// Music loaded without BASS_MUSIC_CALCLEN flag
  BASS_FX_ERROR_BASS20		= 11;	// at least BASS 2.0

type
  TBASS_FX_GetVersion = function: DWORD; stdcall;
  {
    Retrieve the version number of BASS_FX that is loaded.
    RETURN : The BASS_FX version (LOWORD.HIWORD)
  }

  TBASS_FX_Free = procedure; stdcall;
  {
    Free all resources used BASS_FX, including: DSP, TEMPO, REVERSE & BPM.
    [Once this function called, you won't be able to set any FX!]
  }

  TBASS_FX_ErrorGetCode = function: DWORD; stdcall;
  {
    Get the BASS_FX_ERROR_xxx error code. Use this function to get the
    reason for an error.
  }

{===============================================================================
	D S P (Digital Signal Processing)
===============================================================================}

// DSP effects
const
  BASS_FX_DSPFX_SWAP		= 0;	// Swap channels: left<=>right : for STEREO Only!
  BASS_FX_DSPFX_ROTATE		= 1;	// A channels volume ping-pong : for STEREO Only!
  BASS_FX_DSPFX_ECHO		= 2;	// Echo
  BASS_FX_DSPFX_FLANGER		= 3;	// Flanger
  BASS_FX_DSPFX_VOLUME		= 4;	// Volume Amplifier : L/R for STEREO, L for MONO
  BASS_FX_DSPFX_PEAKEQ		= 5;	// Peaking Equalizer
  BASS_FX_DSPFX_REVERB		= 6;	// Reverb
  BASS_FX_DSPFX_LPF		    = 7;	// Low Pass Filter
  BASS_FX_DSPFX_S2M		    = 8;	// Stereo 2 Mono : for STEREO Only!
  BASS_FX_DSPFX_DAMP		= 9;	// Dynamic Amplification
  BASS_FX_DSPFX_AUTOWAH		= 10;	// Auto WAH
  BASS_FX_DSPFX_ECHO2		= 11;	// Echo 2
  BASS_FX_DSPFX_PHASER		= 12;	// Phaser
  BASS_FX_DSPFX_ECHO3		= 13;	// Echo 3
  BASS_FX_DSPFX_CHORUS		= 14;	// Chorus
  BASS_FX_DSPFX_APF	    	= 15;	// All Pass Filter
  BASS_FX_DSPFX_COMPRESSOR	= 16;	// Compressor
  BASS_FX_DSPFX_DISTORTION	= 17;	// Distortion

type
  // Flanger
  BASS_FX_DSPFLANGER = record
    fWetDry : FLOAT;		// [0.........1]
    fSpeed : FLOAT;			// [0.........n]
  end;

  // Echo
  BASS_FX_DSPECHO = record
    fLevel : FLOAT;	   		// [0.........1]
    lDelay : Integer;			// [1200..30000]
  end;

  // Reverb
  BASS_FX_DSPREVERB = record
    fbLevel : FLOAT;	  		// [0.........1]
    lbDelay : Integer;			// [1200..10000]
  end;

  // Volume
  BASS_FX_DSPVOLUME = record // L/R for STEREO, L for MONO for both channels
    fLeft : FLOAT;			// [0....1....n]
    fRight : FLOAT;			// [0....1....n]
  end;

  // Peaking Equalizer
  BASS_FX_DSPPEAKEQ = record
    lBand : Integer;	 	// [0..n] more bands => more memory & cpu usage
    lFreq : DWORD;			// current sample rate of a stream/music
    fBandwidth : FLOAT;	// in octaves [0..4] - Q is not in use
    fQ : FLOAT;         // the EE kinda definition [0..1] - Bandwidth is not in use
    fCenter : FLOAT;		// eg. 1000Hz
    fGain : FLOAT;			// in dB. eg. [-10..0..+10]
  end;

  // Low Pass Filter
  BASS_FX_DSPLPF = record
    lFreq : DWORD;			    // current samplerate of stream/music
    fResonance : FLOAT;			// [2..........10]
    fCutOffFreq : FLOAT;		// [200Hz..5000Hz]
  end;

  // Cutter
  BASS_FX_DSPCUT = record
    lCutsPerBeat : Integer;		// [0..n] number of cuts per beat
    fBPM : FLOAT;			  // [1..n]
    lFreq : DWORD;			// current samplerate of a stream/music
  end;

  // Flanger v2.0!
  BASS_FX_DSPFLANGER2 = record
    fDelay : FLOAT;		       	// [1.1..3.1] in ms.
    lFreq : DWORD;         		// current samplerate of a stream/music
    fBPM : FLOAT;  	  	    	// [1......n]
    fWetDry : FLOAT;       		// [0.....10]
  end;

  // Dynamic Amplification
  BASS_FX_DSPDAMP = Record
    lTarget : Integer;	// target level			e.g: [30000]
    lQuiet : Integer; 	// quiet level			e.g: [  800]
    fRate : FLOAT;			// amp adjustment rate		e.g: [ 0.02]
    fGain : FLOAT;			// amplification level
    lDelay : Integer;		// delay before increasing level
  end;

  // Auto WAH
  BASS_FX_DSPAUTOWAH = record
    dDryMix : FLOAT;		// dry (unaffected) signal mix         [-2.....2]
    dWetMix : FLOAT;		// wet (affected) signal mix           [-2.....2]
    dFeedback : FLOAT;	// feedback                            [-1.....1]
    dRate : FLOAT;			// rate of sweep in cycles per second  [0<...<10]
    dRange : FLOAT;			// sweep range in octaves              [0<...<10]
    dFreq : FLOAT;			// base frequency of sweep Hz          [0<..1000]
  end;

  // Echo 2.0!
  BASS_FX_DSPECHO2 = record
    dDryMix : FLOAT;		// dry (unaffected) signal mix         [-2.....2]
    dWetMix : FLOAT;		// wet (affected) signal mix           [-2.....2]
    dFeedback : FLOAT;	// feedback                            [-1.....1]
    dDelay : FLOAT;			// delay sec                           [0<.....6]
  end;

  // Phaser
  BASS_FX_DSPPHASER = Record
    fDryMix : FLOAT;			// dry (unaffected) signal mix         	    [-2......2]
    fWetMix : FLOAT;			// wet (affected) signal mix           	    [-2......2]
    fFeedback : FLOAT;			// feedback                            	    [-1......1]
    fRate : FLOAT;			// rate of sweep in cycles per second  	    [0<....<10]
    fRange : FLOAT;			// sweep range in octaves              	    [0<....<10]
    fFreq : FLOAT;			// base frequency of sweep             	    [0<...1000]
  end;

  // Echo 2.1!
  BASS_FX_DSPECHO21 = record
    dDryMix : FLOAT;	 	// dry (unaffected) signal mix         [-2.....2]
    dWetMix : FLOAT;	 	// wet (affected) signal mix           [-2.....2]
    dDelay : FLOAT;			// delay sec                           [0<.....6]
  end;

  TBASS_FX_DSP_Set = function(handle: DWORD; dsp_fx: Integer; priority: Integer): BOOL; stdcall;
  {
    Set any chosen DSP FX to any Handle.
    handle   : stream/music/wma/cd
    dsp_fx   : FX you wish to use
    priority : The priority of the new DSP, which determines it's position in the DSP chain
         DSPs with higher priority are called before those with lower.
    RETURN   : TRUE if created (0=error!)
  }

  TBASS_FX_DSP_Remove = function(handle: DWORD; dsp_fx: Integer): BOOL; stdcall;
  {
    Remove chosen DSP FX.
    handle : stream/music/wma/cd
    dsp_fx : FX you wish to remove
    RETURN : TRUE if removed (0=error!)
  }

  TBASS_FX_DSP_SetParameters = function(handle: DWORD; dsp_fx: Integer; par: Pointer): BOOL; stdcall;
  {
    Set the parameters of a DSP effect.
    handle : stream/music/wma/cd
    dsp_fx : FX you wish to set parameters to
    par    : Pointer to the parameter type
  }

  TBASS_FX_DSP_GetParameters = function(handle: DWORD; DSP_FX: Integer; par: Pointer): BOOL; stdcall;
  {
    Set the parameters of a DSP effect.
    handle : stream/music/wma/cd
    dsp_fx : FX you wish to get parameters to
    par    : Pointer to the parameter type
  }

  TBASS_FX_DSP_Reset = function(handle: DWORD; dsp_fx: Integer): BOOL; stdcall;
  {
    Call this function before changing position to avoid *clicks*
    handle : stream/music/wma/cd
    dsp_fx : FX you wish to reset parameters of
    RETURN : TRUE if ok (0=error!)
  }

{===============================================================================
	TEMPO / PITCH SCALING / SAMPLERATE
===============================================================================}

// tempo flags
const
  BASS_FX_TEMPO_QUICKSEEK = 512;     // If you use quicker tempo change algorithm (gain speed, lose quality)

type
  TBASS_FX_TempoCreate = function(chan, flags: DWORD): DWORD; stdcall;
  {
    Creates a Resampling stream from a decoding channel.
    chan   : a Handle returned by:
              BASS_StreamCreateFile     : flags = BASS_STREAM_DECODE ...
        BASS_MusicLoad            : flags = BASS_MUSIC_DECODE ...
        BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
              BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
    flags  : BASS_SAMPLE_xxx / BASS_SPEAKER_xxx / BASS_FX_TEMPO_QUICKSEEK
    RETURN : the resampled handle (0=error!)
  }

  TBASS_FX_TempoSet = function(chan: HSTREAM; tempo, samplerate, pitch: FLOAT): BOOL; stdcall;
  {
    Set new values to tempo/rate/pitch to change its speed.
    chan       : tempo stream (or source channel) handle
    tempo      : in Percents  [-95%..0..+5000%]			(-100 = leave current)
    samplerate : in Hz, but calculates by the same % as tempo	(   0 = leave current)
    pitch      : in Semitones [-60....0....+60]			(-100 = leave current)
    RETURN     : TRUE if ok (0=error!)
  }

  TBASS_FX_TempoGet = function(chan: DWORD; var tempo: FLOAT; var samplerate: DWORD; var pitch: FLOAT): BOOL; stdcall;
  {
    Get tempo/rate/pitch values.
          chan       : stream/music/wma/cd
          tempo      : current tempo         (NULL if not in use)
          samplerate : current samplerate    (NULL if not in use)
          pitch      : current pitch         (NULL if not in use)
    RETURN     : TRUE if ok (0=error!)
  }

  TBASS_FX_TempoGetRateRatio = function (chan: HSTREAM): FLOAT; stdcall;
  {
    Get the ratio of the resulting rate and source rate (the resampling ratio).
    chan   : tempo stream (or source channel) handle
    RETURN : the ratio (0=error!)
  }

  TBASS_FX_TempoGetApproxSeconds = function(chan: DWORD; sec: FLOAT): FLOAT; stdcall;
  {
    Get the approximate seconds from given seconds after changing Tempo or Rate.
          chan   : stream/music/wma/cd
          sec    : seconds to convert
    RETURN : new calculated length in seconds (-1=error!)
  }

  TBASS_FX_TempoGetApproxPercents = function(chan: DWORD): FLOAT; stdcall;
  {
    Get the approximate percents of changed Tempo/Rate after changing Tempo or Rate.
          chan   : stream/music/wma/cd
    RETURN : the percents (-1=error!)
  }

  TBASS_FX_TempoGetResampledHandle = function(chan: DWORD): DWORD; stdcall;
  {
    Get the resampled handle from a decoding handle.
          chan   : stream/music/wma/cd
    RETURN : the resampled handle (0=error!)
  }

  TBASS_FX_TempoStopAndFlush = function(chan: DWORD): BOOL; stdcall;
  {
    Stop a stream and clear it's buffer.
          chan   : stream/music/wma/cd
    RETURN : TRUE if ok (0=error!)
  }

  TBASS_FX_TempoFree = procedure(chan: DWORD); stdcall;
  {
    Free all the resources used by a given handle.
          chan : stream/music/wma/cd
  }

{===============================================================================
	R E V E R S E
===============================================================================}

// NOTE: Reverse will NOT work with MOD formats!

  TBASS_FX_ReverseCreate = function(chan: DWORD; dec_block: FLOAT; decode: BOOL; flags: DWORD): DWORD; stdcall;
  {
    Creates a Reversed stream from a decoding channel.
    chan      : a Handle returned by:
                         BASS_StreamCreateFile     : flags = BASS_STREAM_DECODE
                         BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
                         BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
             * For better MP3/2/1 Reverse playback use: BASS_MP3_SETPOS flag
    dec_block : decode in # of seconds blocks...
          larger blocks = less seeking overhead but larger spikes.
    decode	  : allow (TRUE/FALSE) the reversed stream to be created as a decoding channel.
    flags	  : BASS_SAMPLE_xxx / BASS_SPEAKER_xxx
    RETURN    : The reversed handle (0=error!)
  }

  TBASS_FX_ReverseGetReversedHandle = function(chan: DWORD): DWORD; stdcall;
  {
    Get the reversed handle from a decoding channel.
    chan   : stream handle
    RETURN : The reversed handle (0=error!)
  }

  TBASS_FX_ReverseSetPosition = function(chan: DWORD; pos: QWORD): BOOL; stdcall;
  {
    Change the playing position of a decoding channel.
    chan   : stream handle
    pos    : the position (in bytes)
    RETURN : TRUE if ok (0=error!)
  }

  TBASS_FX_ReverseFree = procedure(chan: DWORD); stdcall;
  {
    Free all resources used by a given handle.
    chan : stream handle
  }


{===============================================================================
	B P M (Beats Per Minute)
===============================================================================}

// bpm flags
const
  BASS_FX_BPM_BKGRND = 1;   // If in use, then you can do other processing while detecting
  BASS_FX_BPM_MULT2 = 2;    // If in use, then will auto multiple bpm by 2 (if BPM < MinBPM*2)

//-----------
// Option - 1 - Get BPM from a Decoded Channel
//-----------

type
  BPMPROCESSPROC = procedure(chan: DWORD; percent: FLOAT); stdcall;
  {
    Get the detection process in percents of a channel.
    chan    : channel that the BASS_FX_BPM_GetDecode is being applied to
    percent : the process in percents [0%..100%]
  }

  TBASS_FX_BPM_DecodeGet = function(chan: DWORD; StartSec, EndSec: FLOAT; MinMaxBPM, flags: DWORD; proc: BPMPROCESSPROC): FLOAT; stdcall;
  {
    Get the original BPM of a decoding channel with original frequency
    chan      : a Handle returned by:
        BASS_StreamCreateFile     : flags = BASS_STREAM_DECODE ...
        BASS_MusicLoad            : flags = BASS_MUSIC_DECODE Or BASS_MUSIC_CALCLEN ...
                BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
        BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
    StartSec  : start detecting position in seconds
    EndSec    : end detecting position in seconds - 0 = full length
    MinMaxBPM : set min & max bpm, e.g: MAKELONG(LOWORD.HIWORD), LO=Min, HI=Max. 0 = defaults 45/230
    flags	  : BASS_FX_BPM_xxx
    proc      : user defined function to receive the process in percents, use NULL if not in use
    RETURN    : the original BPM value (-1=error!)
  }

//-----------
// Option - 2 - Auto Get BPM by Period of time in seconds.
//-----------

  BPMPROC = procedure(handle: DWORD; bpm: FLOAT); stdcall;
  {
    Get the BPM after period of time in seconds.
    handle : handle that the BASS_FX_BPM_CallbackSet is being applied to
    bpm    : the new original bpm value
  }

  TBASS_FX_BPM_CallbackSet = function(handle: DWORD; proc: BPMPROC; period: FLOAT; MinMaxBPM, flags: DWORD): BOOL; stdcall;
  {
    Enable getting BPM value by period of time in seconds.
    handle    : stream/music/wma/cd
    proc      : user defined function to receive the bpm value
    period	  : detection period in seconds
    MinMaxBPM : set min & max bpm, e.g: MAKELONG(LOWORD.HIWORD), LO=Min, HI=Max. 0 = defaults 45/230
    flags     : only BASS_FX_BPM_MULT2 flag is used
  }

  TBASS_FX_BPM_CallbackReset = function(handle: DWORD): BOOL; stdcall;
  {
    Reset the buffers. Call this function after changing position.
    handle : stream/music/wma/cd
  }

{-------------------------------------------------------
   Functions to use with Both options.
	NOTE: These functions will not detect the BPM,
              they will just calculate the detected
              original BPM value of a given handle.
-------------------------------------------------------}

  TBASS_FX_BPM_X2 = function(handle: DWORD): FLOAT; stdcall;
  {
    Multiple the original BPM value by 2 (may be called only once).
    handle : stream/music/wma/cd/decoding channel
    RETURN : New BPM value * 2 (-1=error!)
  }

  TBASS_FX_BPM_Frequency2BPM = function(handle: DWORD; freq: DWORD): FLOAT; stdcall;
  {
    Convert Frequency to BPM value.
    handle : stream/music/wma/cd/decoding channel
    freq   : frequency (e.g 44100).
    RETURN : New BPM value for that handle (-1=error!)
  }

  TBASS_FX_BPM_2Frequency = function(handle: DWORD; bpm: FLOAT): DWORD; stdcall;
  {
    Convert BPM value to Frequency.
    handle : stream/music/wma/cd/decoding channel
    bpm    : a bpm value (e.g 140.32).
    RETURN : New Frequency for that handle (-1=error!)
  }

  TBASS_FX_BPM_Percents2BPM = function(handle: DWORD; per: FLOAT): FLOAT; stdcall;
  {
    Convert Percents to BPM value.
    handle : stream/music/wma/cd/decoding channel
    per    : percent
    RETURN : New BPM value for that handle (-1=error!)
  }

  TBASS_FX_BPM_2Percents = function(handle: DWORD; bpm: FLOAT): FLOAT; stdcall;
  {
    Convert BPM to Percents.
    handle : stream/music/wma/cd/decoding channel
    bpm    : a bpm value
    RETURN : New Percents for that handle (-1=error!)
  }

  TBASS_FX_BPM_Free = procedure(chan: DWORD); stdcall;
  {
    Free all resources used by a given handle.
    chan : stream/music/wma/cd/decoding channel
  }

  TBassSamplerate = Cardinal;
  
const
  BASS_FX_FREESOURCE = $10000;	// Free the source handle as well?
  BASSSAMPLERATEMINP: float = 0.7;      // decrease rate for min 30%
  BASSSAMPLERATEMAXP: float = 1.3;      // increase rate for max 30%

implementation

end.
