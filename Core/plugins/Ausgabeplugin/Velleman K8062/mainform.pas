unit mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CHHighResTimer;

type
  TForm1 = class(TForm)
    DMXTimer: TCHHighResTimer;
    procedure FormDestroy(Sender: TObject);
    procedure DMXTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    DMXOutBuffer:array of byte;
    MaxChan:integer;
    procedure ChannelCountChange;
    procedure Startup;
  end;

var
  Form1: TForm1;

procedure StartDevice; stdcall; external 'K8062d.dll';
procedure SetData(Channel: Longint ; Data: Longint); stdcall; external 'K8062d.dll';
procedure SetChannelCount(Count: Longint); stdcall; external 'K8062d.dll';
procedure StopDevice; stdcall; external 'K8062d.dll';

implementation

{$R *.dfm}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DMXTimer.Enabled:=false;
  StopDevice;
end;

procedure TForm1.DMXTimerTimer(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to MaxChan do
    SetData(i, DMXOutBuffer[i-1]);
end;

procedure TForm1.ChannelCountChange;
begin
  SetChannelCount(length(DMXOutBuffer));
  MaxChan:=length(DMXOutBuffer);
end;

procedure Tform1.startup;
begin
  MaxChan:=8;
  setlength(DMXOutBuffer, 8);
  StartDevice;
  SetChannelCount(8);
  DMXTimer.Enabled:=true;
end;

end.
