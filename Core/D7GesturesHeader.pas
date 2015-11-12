Unit D7GesturesHeader; // Windows 7/8 Multi-touch/Gesture header for Delphi 7
//    mostly from: http://www.delphipraxis.net/1063138-post1.html
//    fev/2013 Omar Reis


interface
uses Windows, Classes;

const
  SM_DIGITIZER = 94;
  //GetSystemMetrics(SM_DIGITIZER) is nonzero if the current operating system is Windows 7 or Windows Server 2008 R2
  //and Tablet PC Input service is started. Otherwise, 0. The return value is a bitmask that specifies the type of digitizer input supported by the device.

  //gesture flags
  GF_Begin             = $00000001;
  GF_Inertia           = $00000002;
  GF_End               = $00000004;

  //gesture configs
  GC_ALLGESTURES       = $00000001;
  GC_ZOOM              = $00000001;
  GC_PAN               = $00000001;
  GC_PAN_WITH_SINGLE_FINGER_VERTICALLY   = $00000002;
  GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = $00000004;
  GC_PAN_WITH_GUTTER   = $00000008;
  GC_PAN_WITH_INERTIA  = $00000010;
  GC_ROTATE            = $00000001;
  GC_TWOFINGERTAP      = $00000001;
  GC_PRESSANDTAP       = $00000001;
  GC_ROLLOVER          = GC_PRESSANDTAP;
  //gesture messages
  WM_GESTURENOTIFY = $011A;
  WM_GESTURE = $0119;
  WM_TOUCH = $0240;
  WM_TABLET_DEFBASE = $02C0;
  WM_TABLET_FLICK = WM_TABLET_DEFBASE + 11;

  // Gesture IDs
  GID_BEGIN        = 1;
  GID_END          = 2;
  GID_ZOOM         = 3;
  GID_PAN          = 4;
  GID_ROTATE       = 5;
  GID_TWOFINGERTAP = 6;
  GID_PRESSANDTAP  = 7;
  GID_ROLLOVER     = 7;

type
  TGestureNotifyStruct = record
    cbSize: UINT;         // size, in bytes, of this structure
    dwFlags: DWORD;       // unused
    hwndTarget: HWND;     // handle to window targeted by the gesture
    ptsLocation: TSmallPoint; // starting location
    dwInstanceID: DWORD;  // internally used
  end ;
  PGestureNotifyStruct = ^TGestureNotifyStruct;

  TWMGestureNotify = packed record
    Msg: Cardinal;
    Unused: WPARAM;
    NotifyStruct: PGestureNotifyStruct;
    Result: Integer;
  end ;
  HTOUCHINPUT = THandle;

type
  PTOUCHINPUT = ^TOUCHINPUT;
  TOUCHINPUT = record
    x: Integer;
    y: Integer;
    hSource: THandle;
    dwID: DWORD;
    dwFlags: DWORD;
    dwMask: DWORD;
    dwTime: DWORD;
    dwExtraInfo: LongInt;
    cxContact: DWORD;
    cyContact: DWORD;
  end ;
  TTouchInput = TOUCHINPUT;

  TGestureConfig   = Record
                       dwID         : DWORD;       // gesture ID
                       dwWant       : DWORD;       // settings related to gesture ID that are to be turned on
                       dwBlock      : DWORD;       // settings related to gesture ID that are to be turned off
                     end;
   PGestureConfig   = ^TGestureConfig;
   TConfigs         = Array of TGestureConfig;
   //
   TGestureInfo     = Record
                        cbSize       : Longword;
                        dwFlags      : DWord;
                        dwID         : DWord;
                        hwndTarget   : Hwnd;
                        ptsLocation  : TSmallPoint;
                        dwInstanceID : DWord;
                        dwSequenceID : DWord;
                        ullArguments : Int64;
                        cbExtraArgs  : UInt;
                      end;

  PGestureInfo     = ^TGestureInfo;
  THGESTUREINFO    =  type LongInt;// LongWord

  TGestureState    = (gsNone,gsBegin,gsWork,gsEnd);

  TGestureSav      = Record
                       Cnt          : Integer;
                       State        : TGestureState;
                       ullArguments : Int64;
                     end;


type //user32.dll fns available only in Win7+
  //have to load these dynamicaly, so your sw can run on xp and Vista
  TCloseTouchInputHandleFunc  = function (hTouchInput: HTOUCHINPUT): BOOL; stdcall;
  TPhysicalToLogicalPointFunc = function (hWnd: HWND; var lpPoint: TPoint): BOOL; stdcall;
  TGetTouchInputInfoFunc      = function (hTouchInput: HTOUCHINPUT; cInputs: UINT; pInputs: PTOUCHINPUT; cbSize: Integer): BOOL; stdcall ;
  TRegisterTouchWindowFunc    = function (hwnd: HWND; ulFlags: Cardinal): BOOL; stdcall;
  TUnregisterTouchWindowFunc  = function (hwnd: HWND): BOOL; stdcall;
  TGetGestureInfoFunc         = function (hGestureInfo : THGESTUREINFO; Var pGestureInfo:TGestureInfo): BOOL; stdcall;
  TCloseGestureInfoHandleFunc = Function (hGestureInfo : THGESTUREINFO): BOOL; stdcall;
  TSetGestureConfigFunc       = Function (hWnd:HWND; dwReserved:DWORD; cIDs: UINT; pGestureConfig: PGESTURECONFIG; cbSize:UINT): BOOL; stdcall;


var //user32 fn addresses
  CloseTouchInputHandleFn  : TCloseTouchInputHandleFunc  = nil;
  PhysicalToLogicalPointFn : TPhysicalToLogicalPointFunc = nil;
  GetTouchInputInfoFn      : TGetTouchInputInfoFunc      = nil;
  RegisterTouchWindowFn    : TRegisterTouchWindowFunc    = nil;
  UnregisterTouchWindowFn  : TUnregisterTouchWindowFunc  = nil;
  GetGestureInfoFn         : TGetGestureInfoFunc         = nil;
  CloseGestureInfoHandleFn : TCloseGestureInfoHandleFunc = nil;
  SetGestureConfigFn       : TSetGestureConfigFunc       = nil;

  bTouchGestureAPIPresent  : Boolean=false;   //true if functions present in user32.dll
  bMultiTouchHardware      : Boolean=false;  //true if multitouch hardware present

Procedure LoadTouchGestureAPI;  //load gestures function from user32.dll dynamicaly
procedure EnableAllGestures(aHandle:THandle); //..including one finger pan and rotation
Function Int64AngleToDegree(Arg : int64) : Single;
Function GID_ROTATE_ANGLE_FROM_ARGUMENT( Arg: int64): Single;   //convert Arg angle to radians
function LODWORD(i64:int64):DWORD;

implementation //--------------------------------

function LODWORD(i64:int64):DWORD;
begin
   Result := i64 and $ffffffff;
end;

Function GID_ROTATE_ANGLE_FROM_ARGUMENT( Arg: int64): Single;   //convert Arg angle to radians
begin
  Result := (( (Arg / 65535.0) * 4.0 * 3.14159265) - 2.0 * 3.14159265);
end;

Function Int64AngleToDegree(Arg : int64) : Single;
begin
  Result := gID_Rotate_Angle_From_Argument(Arg) * 180 / pi;
end;

Procedure LoadTouchGestureAPI;
var Handle:THandle; sm:Integer;
begin
  Handle := LoadLibrary('user32.dll');
  try   // dynamicaly load Gesture function addresses, if fns available
    CloseTouchInputHandleFn   := GetProcAddress(Handle, 'CloseTouchInputHandle');
    PhysicalToLogicalPointFn  := GetProcAddress(Handle, 'PhysicalToLogicalPoint');
    GetTouchInputInfoFn       := GetProcAddress(Handle, 'GetTouchInputInfo');
    RegisterTouchWindowFn     := GetProcAddress(Handle, 'RegisterTouchWindow');
    UnregisterTouchWindowFn   := GetProcAddress(Handle, 'UnregisterTouchWindow');
    GetGestureInfoFn          := GetProcAddress(Handle, 'GetGestureInfo');
    CloseGestureInfoHandleFn  := GetProcAddress(Handle, 'CloseGestureInfoHandle');
    SetGestureConfigFn        := GetProcAddress(Handle, 'SetGestureConfig');

    bTouchGestureAPIPresent   := Assigned(GetTouchInputInfoFn);

  finally
    FreeLibrary(Handle);
  end;

  // Test for multi - touch hw
  bMultiTouchHardware := false;
  sm := GetSystemMetrics(SM_DIGITIZER);
  if (sm and $40 <> 0) then
    bMultiTouchHardware := true;  // digitizer is multitouch 
end;

procedure EnableAllGestures(aHandle:THandle); //..including one finger pan and rotation
var gestureConfig:TGestureConfig;
begin
  if bTouchGestureAPIPresent then
    begin
      gestureConfig.dwID := 0;
      gestureConfig.dwBlock := 0;
      gestureConfig.dwWant := GC_ALLGESTURES;     //enable all gesture types
      //gestureConfig.dwWant :=
      SetGestureConfigFn(aHandle, 0, 1, @gestureConfig, sizeof(gestureConfig));
    end;
end;

end.
