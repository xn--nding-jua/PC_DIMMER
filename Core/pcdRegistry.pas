unit pcdRegistry;

interface

uses
  Registry, Controls;

type
  TPCDRegistry = class(TRegistry)
  public
    function OpenRegKey(AKey: string): boolean;
    function ReadWriteBool(AName: string; ADefault: boolean): boolean;
    function ReadWriteInt(AName: string; ADefault: integer): integer;
    function ReadWriteStr(AName: string; ADefault: string): string;
    procedure WriteBoolEx(AKey: string; AName: string; AValue: boolean);
    procedure WriteIntEx(AKey: string; AName: string; AValue: integer);
    procedure WriteStrEx(AKey: string; AName: string; AValue: string);
    function ReadWriteBoolEx(AKey: string; AName: string; ADefault: boolean): boolean;
    function ReadWriteIntEx(AKey: string; AName: string; ADefault: integer): integer;
    function ReadWriteStrEx(AKey: string; AName: string; ADefault: string): string;

    procedure SaveWnd(AWindow: TControl);
    procedure LoadWnd(AWindow: TControl; ADefWidth: integer; ADefHeight: integer);
    procedure SaveWndPos(AWindow: TControl);
    procedure LoadWndPos(AWindow: TControl);
    procedure SaveWndEx(AName: string; AWindow: TControl);
    procedure LoadWndEx(AName: string; AWindow: TControl; ADefWidth: integer; ADefHeight: integer);
    procedure SaveWndPosEx(AName: string; AWindow: TControl);
    procedure LoadWndPosEx(AName: string; AWindow: TControl);
  end;

  function OpenRegistry(AKey: string): TPCDRegistry;
  procedure LoadRegWnd(AName: string; AWindow: TControl; ADefWidth: integer; ADefHeight: integer);

implementation

uses
  Windows, Forms;

function OpenRegistry(AKey: string): TPCDRegistry;
var
  FReg: TPCDRegistry;
begin
  OpenRegistry := nil;
  FReg := TPCDRegistry.Create;
  if FReg.OpenRegKey(AKey) then
    OpenRegistry := FReg;
end;

function TPCDRegistry.OpenRegKey(AKey: string): boolean;
begin
  OpenRegKey := false;
  RootKey := HKEY_CURRENT_USER;

  if not OpenKey('Software', True) then
  begin
    CloseKey;
    Exit;
  end;

  if not KeyExists('PHOENIXstudios') then
    CreateKey('PHOENIXstudios');
  if not OpenKey('PHOENIXstudios',true) then
  begin
    CloseKey;
    Exit;
  end;

  if not KeyExists('PC_DIMMER') then
    CreateKey('PC_DIMMER');
  if not OpenKey('PC_DIMMER',true) then
  begin
    CloseKey;
    Exit;
  end;

  if AKey = '' then
  begin
    OpenRegKey := true;
    Exit;
  end;

  if not KeyExists(AKey) then
    CreateKey(AKey);
  if not OpenKey(AKey,true) then
  begin
    CloseKey;
    Exit;
  end;

  OpenRegKey := true;
end;

function TPCDRegistry.ReadWriteBool(AName: string; ADefault: boolean): boolean;
begin
  if not ValueExists(AName) then
    WriteBool(AName,ADefault);

  ReadWriteBool := ReadBool(AName);
end;

function TPCDRegistry.ReadWriteInt(AName: string; ADefault: integer): integer;
begin
  if not ValueExists(AName) then
    WriteInteger(AName,ADefault);

  ReadWriteInt := ReadInteger(AName);
end;

function TPCDRegistry.ReadWriteStr(AName: string; ADefault: string): string;
begin
  if not ValueExists(AName) then
    WriteString(AName,ADefault);

  ReadWriteStr := ReadString(AName);
end;

procedure TPCDRegistry.WriteBoolEx(AKey: string; AName: string; AValue: boolean);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  WriteBool(AName, AValue);
  CloseKey;
end;

procedure TPCDRegistry.WriteIntEx(AKey: string; AName: string; AValue: integer);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  WriteInteger(AName, AValue);
  CloseKey;
end;

procedure TPCDRegistry.WriteStrEx(AKey: string; AName: string; AValue: string);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  WriteString(AName, AValue);
  CloseKey;
end;

function TPCDRegistry.ReadWriteBoolEx(AKey: string; AName:string; ADefault: boolean): boolean;
var
  LOpened: boolean;
begin
  ReadWriteBoolEx := ADefault;
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  if not ValueExists(AName) then
    WriteBool(AName, ADefault);

  ReadWriteBoolEx := ReadBool(AName);
  CloseKey;
end;

function TPCDRegistry.ReadWriteIntEx(AKey: string; AName: string; ADefault: integer): integer;
var
  LOpened: boolean;
begin
  ReadWriteIntEx := ADefault;
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  if not ValueExists(AName) then
    WriteInteger(AName, ADefault);

  ReadWriteIntEx := ReadInteger(AName);
  CloseKey;
end;

function TPCDRegistry.ReadWriteStrEx(AKey: string; AName: string; ADefault: string): string;
var
  LOpened: boolean;
begin
  ReadWriteStrEx := ADefault;
  LOpened := OpenRegKey(AKey);
  if not LOpened then
    Exit;

  if not ValueExists(AName) then
    WriteString(AName, ADefault);

  ReadWriteStrEx := ReadString(AName);
  CloseKey;
end;

procedure TPCDRegistry.SaveWnd(AWindow: TControl);
begin
  WriteInteger('PosX', AWindow.Left);
  WriteInteger('PosY', AWindow.Top);
  WriteInteger('Width', AWindow.ClientWidth);
  WriteInteger('Height', AWindow.ClientHeight);
end;

procedure TPCDRegistry.LoadWnd(AWindow: TControl; ADefWidth: integer; ADefHeight: integer);
begin
  if ValueExists('Width') then
    AWindow.ClientWidth := ReadInteger('Width')
  else
    AWindow.ClientWidth := ADefWidth;

  if ValueExists('Height') then
    AWindow.ClientHeight := ReadInteger('Height')
  else
    AWindow.ClientHeight := ADefHeight;

  if ValueExists('PosX') then
  begin
    if (not(ReadInteger('PosX')+AWindow.Width < screen.DesktopLeft)) and (not(ReadInteger('PosX') > screen.DesktopWidth + screen.DesktopLeft)) then
      AWindow.Left := ReadInteger('PosX')
    else
      AWindow.Left := screen.DesktopLeft;
  end else
    AWindow.Left := screen.DesktopLeft;

  if ValueExists('PosY') then
  begin
    if (not(ReadInteger('PosY') < screen.DesktopTop)) and (not(ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
      AWindow.Top := ReadInteger('PosY')
    else
      AWindow.Top := screen.DesktopTop;
  end else
    AWindow.Top := screen.DesktopTop;
end;

procedure TPCDRegistry.SaveWndPos(AWindow: TControl);
begin
  WriteInteger('PosX', AWindow.Left);
  WriteInteger('PosY', AWindow.Top);
end;

procedure TPCDRegistry.LoadWndPos(AWindow: TControl);
begin
  if ValueExists('PosX') then
  begin
    if (not(ReadInteger('PosX')+AWindow.Width < screen.DesktopLeft)) and (not(ReadInteger('PosX') > screen.DesktopWidth + screen.DesktopLeft)) then
      AWindow.Left := ReadInteger('PosX')
    else
      AWindow.Left := screen.DesktopLeft;
  end else
    AWindow.Left := screen.DesktopLeft;

  if ValueExists('PosY') then
  begin
    if (not(ReadInteger('PosY') < screen.DesktopTop)) and (not(ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
      AWindow.Top := ReadInteger('PosY')
    else
      AWindow.Top := screen.DesktopTop;
  end else
    AWindow.Top := screen.DesktopTop;
end;

procedure TPCDRegistry.SaveWndEx(AName: string; AWindow: TControl);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AName);
  if not LOpened then
    Exit;

  WriteInteger('PosX', AWindow.Left);
  WriteInteger('PosY', AWindow.Top);
  WriteInteger('Width', AWindow.ClientWidth);
  WriteInteger('Height', AWindow.ClientHeight);
  CloseKey;
end;

procedure TPCDRegistry.LoadWndEx(AName: string; AWindow: TControl; ADefWidth: integer; ADefHeight: integer);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AName);
  if not LOpened then
    Exit;

  if ValueExists('Width') then
    AWindow.ClientWidth := ReadInteger('Width')
  else
    AWindow.ClientWidth := ADefWidth;

  if ValueExists('Height') then
    AWindow.ClientHeight := ReadInteger('Height')
  else
    AWindow.ClientHeight := ADefHeight;

  if ValueExists('PosX') then
  begin
    if (not(ReadInteger('PosX')+AWindow.Width < screen.DesktopLeft)) and (not(ReadInteger('PosX') > screen.DesktopWidth + screen.DesktopLeft)) then
      AWindow.Left := ReadInteger('PosX')
    else
      AWindow.Left := screen.DesktopLeft;
  end else
    AWindow.Left := screen.DesktopLeft;

  if ValueExists('PosY') then
  begin
    if (not(ReadInteger('PosY') < screen.DesktopTop)) and (not(ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
      AWindow.Top := ReadInteger('PosY')
    else
      AWindow.Top := screen.DesktopTop;
  end else
    AWindow.Top := screen.DesktopTop;

  CloseKey;
end;

procedure TPCDRegistry.SaveWndPosEx(AName: string; AWindow: TControl);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AName);
  if not LOpened then
    Exit;

  WriteInteger('PosX', AWindow.Left);
  WriteInteger('PosY', AWindow.Top);
  CloseKey;
end;

procedure TPCDRegistry.LoadWndPosEx(AName: string; AWindow: TControl);
var
  LOpened: boolean;
begin
  LOpened := OpenRegKey(AName);
  if not LOpened then
    Exit;

  if ValueExists('PosX') then
  begin
    if (not(ReadInteger('PosX')+AWindow.Width < screen.DesktopLeft)) and (not(ReadInteger('PosX') > screen.DesktopWidth + screen.DesktopLeft)) then
      AWindow.Left := ReadInteger('PosX')
    else
      AWindow.Left := screen.DesktopLeft;
  end else
    AWindow.Left := screen.DesktopLeft;

  if ValueExists('PosY') then
  begin
    if (not(ReadInteger('PosY') < screen.DesktopTop)) and (not(ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
      AWindow.Top := ReadInteger('PosY')
    else
      AWindow.Top := screen.DesktopTop;
  end else
    AWindow.Top := screen.DesktopTop;

  CloseKey;
end;

procedure LoadRegWnd(AName: string; AWindow: TControl; ADefWidth: integer; ADefHeight: integer);
var
  LReg: TPCDRegistry;
begin
  LReg := TPCDRegistry.Create;
  LReg.LoadWndEx(AName, AWindow, ADefWidth, ADefHeight);
  Lreg.Free;
end;

end.
