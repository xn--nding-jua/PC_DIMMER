library DMXRecorder;

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Graphics,
  main in 'main.pas' {mainform},
  messagesystem in 'messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  // DLLActivate is called during mainprogram startup or pluginreset

  // Create Mainform
  mainform:=Tmainform.Create(Application);

  // connect plugin-procedures with mainprogram-procedures by given pointers
  @mainform.SetDLLValues:=CallbackSetDLLValues; // Lets you set value and fadeintime of a single channel
  @mainform.SetDLLEvent:=CallbackSetDLLValueEvent;
  @mainform.SetDLLNames:=CallbackSetDLLNames; // Lets you set a name of a single channel
  @mainform.GetDLLValue:=CallbackGetDLLValue; // Causes the PC_DIMMER to send the current value of this channel
  @mainform.SendMSG:=CallbackSendMessage; // Sends a predefined message (see messagesystem.pas for more informations)
end;

procedure DLLStart;stdcall;
begin
end;

function DLLDestroy:boolean;stdcall;
begin
	if mainform.showing then
    mainform.close;

  @mainform.SetDLLValues:=nil;
  @mainform.SetDLLEvent:=nil;
  @mainform.SetDLLNames:=nil;
  @mainform.GetDLLValue:=nil;
  @mainform.SendMSG:=nil;

  mainform.Release;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('DMX-Recorder');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.0');
end;

procedure DLLShow;stdcall;
begin
  mainform.Show;
end;

procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  if mainform.RadioButton4.Checked then
  begin
    if (channel>0) and (channel<=512) then
    begin
      mainform.DMXValues[channel][1]:=startvalue;
      mainform.DMXValues[channel][2]:=endvalue;
      mainform.DMXValues[channel][3]:=FadeTime;
    end;
  end;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  // called on every MSG-Event
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if RadioButton3.Checked then
      begin
        if (Integer(Data1)>0) and (Integer(Data1)<=512) then
        begin
          DMXValues[Integer(Data1)][1]:=Integer(Data2);
          DMXValues[Integer(Data1)][2]:=Integer(Data2);
          DMXValues[Integer(Data1)][3]:=0;
        end;
      end;
    end;
  end;
end;

exports
  DLLCreate,
  DLLStart,
  DLLDestroy,
  DLLIdentify,
  DLLGetVersion,
  DLLGetName,
  DLLShow,
  DLLSendData,
  DLLSendMessage;
begin
end.
