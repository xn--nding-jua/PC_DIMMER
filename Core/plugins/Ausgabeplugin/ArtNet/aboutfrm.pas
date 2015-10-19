unit aboutfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Taboutform = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  aboutform: Taboutform;

implementation

{$R *.dfm}

Function GetFileVersionBuild(Const FileName: String): String;
  Var i, W: LongWord;
    P: Pointer;
    FI: PVSFixedFileInfo;
    version,zusatz,text,text2:string;
  Begin
    version := 'NoVersionInfo';
    i := GetFileVersionInfoSize(PChar(FileName), W);
    If i = 0 Then Exit;
    GetMem(P, i);
    Try
      If not GetFileVersionInfo(PChar(FileName), W, i, P)
        or not VerQueryValue(P, '\', Pointer(FI), W) Then Exit;
      version := IntToStr(FI^.dwFileVersionMS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionMS and $FFFF)
        + '.' + IntToStr(FI^.dwFileVersionLS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionLS and $FFFF);
      If FI^.dwFileFlags and VS_FF_DEBUG        <> 0 Then zusatz := ' Debug';
      If FI^.dwFileFlags and VS_FF_PRERELEASE   <> 0 Then zusatz := ' Beta';
      If FI^.dwFileFlags and VS_FF_PRIVATEBUILD <> 0 Then zusatz := ' Private';
      If FI^.dwFileFlags and VS_FF_SPECIALBUILD <> 0 Then zusatz := ' Special';
    Finally
      FreeMem(P);
    End;

    text:=version; //4.0.0.0
    text2:=copy(text,0,pos('.',text)); // 4.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)); // 4.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)-1); // 4.0.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0

    result:='Version '+text2+' Build '+text+' '+zusatz;
End;

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure Taboutform.FormShow(Sender: TObject);
begin
  label5.Caption:=GetFileVersionBuild(GetModulePath);
end;

end.
