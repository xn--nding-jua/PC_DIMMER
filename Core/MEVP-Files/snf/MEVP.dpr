library MEVP;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  main in 'main.pas' {Main};

{$R *.res}

{
    DasMevStart : function(sController:PChar; sPassWrd:PChar):integer;cdecl;
    DasMevCommand : function(iType:integer; iParam:integer):integer;cdecl;
    DasMevWriteDmx : function(iUniverse:integer; DmxArray:Pointer):integer;cdecl;
    DasMevGetFixtureParam : function(iIndex:integer; iDmxAddress:Pointer; iDmxUniverse:Pointer; iNbChannels:Pointer; sName:PChar; fPosX, fPosY, fPosZ, fRotX, fRotY, fRotZ:Pointer):integer;cdecl;
    DasMevGetVersion : function : integer;cdecl;
}

function DasMevStart(sController:PChar; sPassWrd:PChar):integer;cdecl;
begin
  ShowMessage('Controller: '+sController+#13#10+'Kennwort: '+sPassWrd);
end;

function DasMevCommand(iType:integer; iParam:integer):integer;cdecl;
begin
end;

function DasMevWriteDmx(iUniverse:integer; DmxArray:Pointer):integer;cdecl;
begin
end;

function DasMevGetFixtureParam(iIndex:integer; iDmxAddress:Pointer; iDmxUniverse:Pointer; iNbChannels:Pointer; sName:PChar; fPosX, fPosY, fPosZ, fRotX, fRotY, fRotZ:Pointer):integer;cdecl;
begin
end;

function DasMevGetVersion:integer;cdecl;
begin
end;

exports
  DasMevStart,
  DasMevCommand,
  DasMevWriteDmx,
  DasMevGetFixtureParam,
  DasMevGetVersion;

begin
end.
