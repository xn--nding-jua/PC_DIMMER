library LiLan;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  SysUtils,
  mainfrm in 'mainfrm.pas' {Main},
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TMainform, Mainform);
  @mainform.SetDLLValues:=CallbackSetDLLValues; // Lets you set value and fadeintime of a single channel
  @mainform.SetDLLValueEvent:=CallbackSetDLLValueEvent; // Lets you set values in the DataIn Window
  @mainform.SetDLLNames:=CallbackSetDLLNames; // Lets you set a name of a single channel
  @mainform.GetDLLValue:=CallbackGetDLLValue; // Causes the PC_DIMMER to send the current value of this channel
  @mainform.SendMSG:=CallbackSendMessage; // Sends a predefined message (see messagesystem.pas for more informations)

  mainform.RestoreAllSettings;
end;

procedure DLLStart;stdcall;
begin
  mainform.udp.Active:=true;
  mainform.SendTimer.Enabled:=true;
  mainform.Timer1.Enabled:=true;
end;

function DLLDestroy:boolean;stdcall;
begin
  try
    mainform.SendTimer.Enabled:=false;
    mainform.Timer1.Enabled:=false;
    mainform.udp.Active:=false;

    Application.ProcessMessages;
    sleep(150);

    @mainform.SetDLLValues:=nil;
    @mainform.SetDLLValueEvent:=nil;
    @mainform.SetDLLNames:=nil;
    @mainform.GetDLLValue:=nil;
    @mainform.SendMSG:=nil;

	  mainform.Release;
  except
  end;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Light@Night LiLAN Plugin');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.0');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.ShowModal;
end;

procedure DLLAbout;stdcall;
var
  dllForm: TForm;
begin
  dllForm :=TAbout.Create(Application);
  try
    dllForm.ShowModal;
  finally
    dllForm.Release;
  end;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

function DLLIsSending:boolean;stdcall;
begin
  // preserves a feedback, if the current plugin is sending data
	result:=mainform.issending;
  mainform.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  // called on every MSG-Event
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if (Integer(Data1)>=1) and (Integer(Data1)<=127) then
      begin
        DMXValues[Integer(Data1)]:=Integer(Data2);
        mainform.NewDMXValuesForSending:=true;
      end else if (Integer(Data1)>=128) and (Integer(Data1)<=207) then
      begin
        QBusValues[Integer(Data1)-127]:=round((Integer(Data2)/255)*32);
        mainform.NewQBusValuesForSending:=true;
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
  DLLAbout,
  DLLConfigure,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
