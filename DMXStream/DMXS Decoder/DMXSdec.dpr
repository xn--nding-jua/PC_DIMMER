library DMXSdec;

uses
  SysUtils,
  Forms,
  dmxsdecfrm in 'dmxsdecfrm.pas' {Form1};

{$R *.res}

procedure OpenStream(FileName:PChar); stdcall;
begin
  dmxsdecfrm.Form1.sourceedit.Text:=FileName;
  dmxsdecfrm.Form1.OpenStream;
end;

procedure CloseStream; stdcall;
begin
  dmxsdecfrm.Form1.CloseStream;
end;

procedure GoToPosition(Position: Int64); stdcall;
begin
  dmxsdecfrm.Form1.FileStream.Position:=Position;
end;

procedure ReadNextFrame; stdcall;
begin
  dmxsdecfrm.Form1.DecodeFrame;
end;

function GetDMXData:Pointer; stdcall;
begin
  result:=@dmxsdecfrm.Form1.DMXarray;
end;

function GetFrameData:Pointer; stdcall;
begin
  result:=@dmxsdecfrm.Form1.Frame;
end;

function GetIDData:Pointer; stdcall;
begin
  result:=@dmxsdecfrm.Form1.IDTag;
end;

procedure InitDecoder; stdcall;
begin
  dmxsdecfrm.Form1:=dmxsdecfrm.TForm1.Create(dmxsdecfrm.Form1);
end;

procedure ShowDecoder; stdcall;
begin
  dmxsdecfrm.Form1.Show; 
end;

procedure CloseDecoder; stdcall;
begin
  dmxsdecfrm.Form1.Release;
end;

exports
  OpenStream,
  CloseStream,
  GoToPosition,
  ReadNextFrame,
  GetDMXData,
  GetFrameData,
  GetIDData,
  InitDecoder,
  ShowDecoder,
  CloseDecoder;

begin
end.
