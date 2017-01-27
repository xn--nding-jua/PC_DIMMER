library VUMeter;



{$R 'plugin_icon.res' 'plugin_icon.rc'}

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Graphics,
  main in 'main.pas' {mainform},
  messagesystem in 'messagesystem.pas',
  aboutfrm in 'aboutfrm.pas' {About};

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
  // DLLDeactivate is called during mainprogram shutdown or pluginreset

	if mainform.showing then
    mainform.close;

  @mainform.SetDLLValues:=nil;
  @mainform.SetDLLEvent:=nil;
  @mainform.SetDLLNames:=nil;
  @mainform.GetDLLValue:=nil;
  @mainform.SendMSG:=nil;

//  mainform.release;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  // Input or Output
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  // Name showed in the "Plugins"-Mainmenu
  Result := PChar('VU-Meter');
end;

function DLLGetVersion:PChar;stdcall;
begin
  // Just for information
  Result := PChar('v1.0');
end;

function DLLGetResourceData(const ResName: PChar; Buffer: Pointer; var Length: Integer):boolean;stdcall;
var
  S: TResourceStream;
  L: Integer;
begin
  Result := False;
  if (Buffer = nil) or (Length <= 0) then Exit;
  try
    S := TResourceStream.Create(HInstance, UpperCase(ResName), RT_RCDATA);
    try
      L := S.Size;
      if Length < L then Exit;
      S.ReadBuffer(Buffer^, L);
      Length := L;
      Result := True;
    finally
      S.Free;
    end;
  except
  end;
end;

function DLLGetResourceSize(const ResName: PChar): Integer; stdcall;
var
  S: TResourceStream;
begin
  Result := 0;
  try
    S := TResourceStream.Create(HInstance, UpperCase(ResName), RT_RCDATA);
    try
      Result := S.Size;
    finally
      S.Free;
    end;
  except
  end;
end;

procedure DLLShow;stdcall;
begin
  // DLLShow is called by clicking on the menu-item defined by DLLGetName-Function
  mainform.Show;
end;

procedure DLLAbout;stdcall;
begin
  about := tabout.Create(nil);
  about.ShowModal;
  about.release;
end;

// Data PC_DIMMER -> Plugin
procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
var
  i, data, version:integer;
  Stream: TStream;
  filename:string;
begin
  // called on every MSG-Event
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if Integer(Data1)=round(inputchannel.value) then
        ProcessValue(Integer(Data2));
    end;
    MSG_NEW:
    begin
      lampcount.value:=8;
      setlength(vumeter, 8);
      inputchannel.Value:=401;
      for i:=0 to length(vumeter)-1 do
      begin
        vumeter[i].Channel:=i+1;
        vumeter[i].Value:=0;
        vumeter[i].UseAsRGB:=false;
      end;
      vumeter[0].Color:=clLime;
      vumeter[1].Color:=clLime;
      vumeter[2].Color:=clLime;
      vumeter[3].Color:=clLime;
      vumeter[4].Color:=clYellow;
      vumeter[5].Color:=clYellow;
      vumeter[6].Color:=clYellow;
      vumeter[7].Color:=clRed;
      ProcessValue(0);
    end;
    MSG_OPEN:
    begin
      filename:=ExtractFileName(GetModulePath2);
      filename:='Plugin_'+copy(filename, 0, length(filename)-4)+'.dat';
      
      if FileExists(string(Data1)+filename) then
      begin
        Stream:= TFileStream.Create(string(Data1)+filename, fmOpenRead);
        Stream.ReadBuffer(version, SizeOf(version));
        Stream.ReadBuffer(data, SizeOf(data));
        setlength(vumeter, data);
        for i:=0 to length(vumeter)-1 do
        begin
          Stream.ReadBuffer(vumeter[i].Channel, sizeof(vumeter[i].Channel));
          Stream.ReadBuffer(vumeter[i].Color, sizeof(vumeter[i].Color));
          if version>0 then
            Stream.ReadBuffer(vumeter[i].UseAsRGB, sizeof(vumeter[i].UseAsRGB));
        end;
        Stream.ReadBuffer(data, sizeof(data));
        inputchannel.value:=data;
        Stream.ReadBuffer(data, sizeof(data));
        usevumeter.Checked:=(data=1);
        Stream.Free;
      end;
      lampcount.Value:=length(vumeter);
      ProcessValue(0);
    end;
    MSG_SAVE:
    begin
      filename:=ExtractFileName(GetModulePath2);
      filename:='Plugin_'+copy(filename, 0, length(filename)-4)+'.dat';

      version:=1;
      Stream:= TFileStream.Create(string(Data1)+filename, fmCreate);
      data:=length(vumeter);
      Stream.WriteBuffer(version, sizeof(version));
      Stream.WriteBuffer(data, sizeof(data));
      for i:=0 to length(vumeter)-1 do
      begin
        Stream.WriteBuffer(vumeter[i].Channel, sizeof(vumeter[i].Channel));
        Stream.WriteBuffer(vumeter[i].Color, sizeof(vumeter[i].Color));
        Stream.WriteBuffer(vumeter[i].UseAsRGB, sizeof(vumeter[i].UseAsRGB));
      end;
      data:=round(inputchannel.value);
      Stream.WriteBuffer(data, sizeof(data));
      if usevumeter.checked then
        data:=1
      else
        data:=0;
      Stream.WriteBuffer(data, sizeof(data));
      Stream.Free;
    end;
  end;
end;

exports
  DLLCreate,
  DLLStart,
  DLLDestroy,
  DLLIdentify,
  DLLGetVersion,
  DLLGetResourceData,
  DLLGetResourceSize,
  DLLGetName,
  DLLShow,
  DLLAbout,
  DLLSendData,
  DLLSendMessage;
begin
end.
