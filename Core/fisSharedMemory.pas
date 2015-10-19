{******************************************************************************}
{                                                                              }
{ Ur-Autor...                                                                  }
{ Purpose   : Allows a process to share (named) memory with other processes    }
{             and instances                                                    }
{ Status    : Freeware                                                         }
{ Version   : 1.00, 20th June 2000                                             }
{ Copyright : First Internet Software House 2000                               }
{ Contact   : http://www.fishouse.com (email: support@fishouse.com)            }
{                                                                              }
{ ---------------------------------------------------------------------------- }
{ Modified a little bit by Silhwan Hyun                                        ]
{ ---------------------------------------------------------------------------- }
{                                                                              }
{ Edit to Version B.3.1 by omata (Thorsten) - http://www.delphipraxis.net      }
{                                                                              }
{******************************************************************************}
unit fisSharedMemory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TfisSharedMemory = class(TComponent)
  private
    { Private declarations }
    FShareName: string;
    FMsgOut : boolean;
    FSize: integer;
    FTargetApplication: string;
    FTargetWindow : HWND;
    FSendingDataMsg : hwnd;
    FRequestingDataMsg : hwnd;
    FHandle, FMutex: THandle;
    FReadOnly: boolean;
    FTimeout: integer;
  protected
   { Protected declarations }
    procedure SetName(const aValue: TComponentName );override;
    procedure SetTargetApplication(Value : string);
  public
   { Public declarations }
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
    function MapMemory: pointer;
    function UnMapMemory(aMapPtr: pointer):boolean;
    function CreateMemory: boolean;
    function CloseMemory: boolean;
    function OpenMemory: boolean;
    function RequestOwnership: boolean;
    function ReleaseOwnership: boolean;
    procedure InformDataReady(Param : longint; Size : integer);
    procedure RequestData(Param: Integer);
    property Handle: THandle
      read FHandle;
    property Mutex: THandle
      read FMutex;

    property RequestingDataMsg: hWND
      read FRequestingDataMsg;
    property SendingDataMsg: hWND
      read FSendingDataMsg;
  published
   { Published declarations }
    property ReadOnly: boolean
      read FReadOnly write FReadOnly default false;
    property ShareName: String
      read FShareName write FShareName;
    property TargetApplication: string
      read FTargetApplication write SetTargetApplication;
    property Size: integer
      read FSize write FSize;
    property MsgOutOnErr: boolean
      read FMsgOut write FMsgOut;
    property Timeout: integer read FTimeout
      write FTimeout default -1;
  end;

  const
    MUTEX_NAME = '_SMMutex';

procedure Register;

implementation

const
  Msg1 = 'The target application is not active on your system.' +
            chr(10) + 'The notification message has not been sent.';
  Msg2 = 'The target application is not specified.' +
            chr(10) + 'The notification message has not been sent.';

procedure TfisSharedMemory.SetName(const aValue: TComponentName );
var lChange: boolean;
begin
  lChange :=     (csDesigning in ComponentState)
             and ((Name = FShareName) or (Length(FShareName) = 0));
  inherited;
  if lChange then
    FShareName := Name;
end;

procedure TfisSharedMemory.SetTargetApplication(Value : string);
begin
  FTargetApplication := trim(Value);
  if FTargetApplication <> '' then
    FTargetWindow := FindWindow('TApplication', PChar(FTargetApplication));
end;


//---------------------------------------------------------------------------
function TfisSharedMemory.MapMemory: pointer;
var lMapping: DWord;
begin
  if FHandle = 0 then
    Result := nil
  else begin
    if FReadOnly then
      lMapping := FILE_MAP_READ
    else
      lMapping := FILE_MAP_WRITE;
    Result := MapViewOfFile(FHandle, lMapping, 0, 0, FSize);
    if Result = nil then
      ReleaseMutex(FMutex);
  end;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.UnMapMemory(aMapPtr: pointer): boolean;
begin
  if FHandle = 0 then
    result := false
  else begin
    UnmapViewOfFile(aMapPtr);
    result := true;
  end;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.CreateMemory: boolean;
var lMutexName: string;
begin
  Result := true;
  if FHandle <> 0 then
    CreateMemory := false;
  FHandle := CreateFileMapping(
    THANDLE($FFFFFFFF), nil, PAGE_READWRITE, 0, FSize, pchar(FShareName)
  );
  if FHandle = 0 then begin
    CloseMemory;
    Result := false;
  end;
  lMutexName := FShareName + MUTEX_NAME;
  FMutex := CreateMutex(nil, false, pchar(lMutexName));
  if FMutex = 0 then begin
    CloseMemory;
    Result := false;
  end;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.CloseMemory: boolean;
begin
  if FHandle <> 0 then begin
    CloseHandle(FHandle);
    FHandle := 0;
  end;
  if FMutex <> 0 then begin
    CloseHandle(FMutex);
    FMutex := 0;
  end;
  Result := true;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.OpenMemory: boolean;
var lMutexName: string;
begin
  Result := false;
  if FHandle = 0 then begin
    FHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, true, pchar(FShareName));
    if FHandle <> 0 then begin
      lMutexName := FShareName + MUTEX_NAME;
      FMutex := OpenMutex(MUTEX_ALL_ACCESS, true, pchar(lMutexName));
      if FMutex <> 0 then
        Result := true
      else
        CloseMemory;
    end;
  end;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.RequestOwnership: boolean;
var lTimeout: DWord;
begin
  Result := false;
  if FHandle <> 0 then begin
    if FTimeout < 0 then
      lTimeout := INFINITE
    else
      lTimeout := FTimeout;
    Result := WaitForSingleObject(FMutex, lTimeout) = WAIT_OBJECT_0;
  end;
end;
//---------------------------------------------------------------------------
function TfisSharedMemory.ReleaseOwnership: boolean;
begin
  Result := false;
  if FHandle <> 0 then
    Result := ReleaseMutex(FMutex);
end;

procedure TfisSharedMemory.InformDataReady(Param : longint; Size : integer);
begin
  if FMutex = 0 then
    exit;

  //  NOTIFICATION MESSAGE
  // Windows calls to send a notification message to target application
  // warning the application something is ready for reading in memory
  // Get application handle  = Application.title of searched main window
  if (FTargetWindow = 0) and (FTargetApplication <> '') then
    FTargetWindow := FindWindow('TApplication', PChar(FTargetApplication));

  if FTargetWindow <> 0 then begin
    if IsWIndow(FTargetWindow) then
      PostMessage(FTargetWindow, FSendingDataMsg, Param, Size)
    else if FMsgOut then
      Application.MessageBox(PChar(Msg1), 'Warning...', MB_OK);
  end
  else if FMsgOut then
    Application.MessageBox(PChar(Msg2), 'Warning...', MB_OK);
end;

procedure TfisSharedMemory.RequestData(Param: Integer);
begin
  if FMutex = 0 then
    exit;

  if (FTargetWindow = 0) and (FTargetApplication <> '') then
    FTargetWindow := FindWindow('TApplication', PChar(FTargetApplication));

  if FTargetWindow <> 0 then begin
    if IsWIndow(FTargetWindow) then
      PostMessage(FTargetWindow, FRequestingDataMsg, Application.Handle, Param)
    else if FMsgOut then
      Application.MessageBox(PChar(Msg1), 'Warning...', MB_OK);
  end else if FMsgOut then
    Application.MessageBox(PChar(Msg2), 'Warning...', MB_OK);
end;

//---------------------------------------------------------------------------
constructor TfisSharedMemory.Create(AOwner: TComponent);
begin
  inherited;
  FShareName := '';
  FTargetApplication := '';
  FTargetWindow := 0;
  FMsgOut := false;
  FTimeout := -1;
  FSize := 0;
  FReadOnly := false;
  FHandle := 0;
  FMutex := 0;

  FSendingDataMsg := registerWindowMessage('WM_SendingData');
  FRequestingDataMsg := registerWindowMessage('WM_RequestingData');
end;
//---------------------------------------------------------------------------
destructor TfisSharedMemory.Destroy;
begin
  CloseMemory;
  inherited;
end;
//---------------------------------------------------------------------------
procedure Register;
begin
  RegisterComponents('FISH', [TfisSharedMemory]);
end;
//---------------------------------------------------------------------------
end.
