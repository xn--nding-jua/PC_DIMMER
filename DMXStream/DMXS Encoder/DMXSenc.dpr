library DMXSenc;

uses
  SysUtils,
  Forms,
  dmxsencfrm in 'dmxsencfrm.pas' {Form1};

{$R *.res}

procedure StartRecording(FileName:PChar); stdcall;
begin
  dmxsencfrm.Form1.filenameedit.Text:=FileName;
  dmxsencfrm.Form1.StartEncode;
end;

function PauseRecording:boolean; stdcall;
begin
  dmxsencfrm.Form1.encodertimer.Enabled:=not dmxsencfrm.Form1.encodertimer.Enabled;
  result:=dmxsencfrm.Form1.encodertimer.Enabled;
end;

procedure StopRecording; stdcall;
begin
  dmxsencfrm.Form1.StopEncode;
end;

procedure SetChannel(Channel: Word; Value:Byte); stdcall;
begin
  dmxsencfrm.Form1.SetChannel(Channel, Value);
end;

procedure InitEncoder; stdcall;
begin
  dmxsencfrm.Form1:=dmxsencfrm.TForm1.Create(dmxsencfrm.Form1);
end;

procedure ShowEncoder; stdcall;
begin
  dmxsencfrm.Form1.Show;
end;

procedure CloseEncoder; stdcall;
begin
  dmxsencfrm.Form1.Release;
end;

exports
  StartRecording,
  PauseRecording,
  StopRecording,
  SetChannel,
  InitEncoder,
  ShowEncoder,
  CloseEncoder;

begin
end.
