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
var
  LReg:TRegistry;
begin
  // DLLDeactivate is called during mainprogram shutdown or pluginreset

  LReg:=TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  LReg.OpenKey('Software', True);
  LReg.OpenKey('PHOENIXstudios', True);
  LReg.OpenKey('PC_DIMMER', True);
  LReg.OpenKey(ExtractFileName(mainform.GetModulePath2), True);
  LReg.WriteBool('Showing Plugin', mainform.Showing);
  LReg.CloseKey;
  LReg.Free;

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
  i, j, data, version:integer;
  Stream: TStream;
  filename:string;
  ValueChanged:boolean;
begin
  // called on every MSG-Event
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      ValueChanged:=false;
      for i:=0 to length(vuarray)-1 do
      begin
        if Integer(Data1)=round(vuarray[i].inputchannel) then
        begin
          vuarray[i].InputValue:=Integer(Data2);
          ValueChanged:=true;
        end;
      end;
      if ValueChanged then
        ProcessValue;
    end;
    MSG_NEW:
    begin
      setlength(VUArray, 1);
      VUArray[0].InputChannel:=401;
      setlength(VUArray[0].vumeter, 8);

      lampcount.value:=8;
      inputchannel.Value:=401;
      for i:=0 to length(VUArray[0].vumeter)-1 do
      begin
        VUArray[0].vumeter[i].Channel:=i+1;
        VUArray[0].vumeter[i].Value:=0;
        VUArray[0].vumeter[i].UseAsRGB:=false;
      end;
      VUArray[0].vumeter[0].Color:=clLime;
      VUArray[0].vumeter[1].Color:=clLime;
      VUArray[0].vumeter[2].Color:=clLime;
      VUArray[0].vumeter[3].Color:=clLime;
      VUArray[0].vumeter[4].Color:=clYellow;
      VUArray[0].vumeter[5].Color:=clYellow;
      VUArray[0].vumeter[6].Color:=clYellow;
      VUArray[0].vumeter[7].Color:=clRed;
      ProcessValue;
    end;
    MSG_OPEN:
    begin
      filename:=ExtractFileName(GetModulePath2);
      filename:='Plugin_'+copy(filename, 0, length(filename)-4)+'.dat';

      if FileExists(string(Data1)+filename) then
      begin
        Stream:= TFileStream.Create(string(Data1)+filename, fmOpenRead);
        Stream.ReadBuffer(version, SizeOf(version));
        if version>=2 then
          Stream.ReadBuffer(data, SizeOf(data))
        else
          data:=1;
        setlength(vuarray, data);
        for i:=0 to length(vuarray)-1 do
        begin
          Stream.ReadBuffer(data, SizeOf(data));
          setlength(vuarray[i].vumeter, data);
          for j:=0 to length(vuarray[i].vumeter)-1 do
          begin
            Stream.ReadBuffer(vuarray[i].vumeter[j].Channel, sizeof(vuarray[i].vumeter[j].Channel));
            Stream.ReadBuffer(vuarray[i].vumeter[j].Color, sizeof(vuarray[i].vumeter[j].Color));
            if version>0 then
              Stream.ReadBuffer(vuarray[i].vumeter[j].UseAsRGB, sizeof(vuarray[i].vumeter[j].UseAsRGB));
          end;
          Stream.ReadBuffer(data, sizeof(data));
          vuarray[i].InputChannel:=data;
          Stream.ReadBuffer(data, sizeof(data));
          vuarray[i].IsActive:=(data=1);
        end;
        Stream.Free;
      end;
      usevumeter.Checked:=vuarray[0].IsActive;
      inputchannel.value:=vuarray[0].InputChannel;
      lampcount.Value:=length(vuarray[0].vumeter);
      ProcessValue;
    end;
    MSG_SAVE:
    begin
      filename:=ExtractFileName(GetModulePath2);
      filename:='Plugin_'+copy(filename, 0, length(filename)-4)+'.dat';

      Stream:= TFileStream.Create(string(Data1)+filename, fmCreate);
      version:=2;
      Stream.WriteBuffer(version, sizeof(version));
      data:=length(VUArray);
      Stream.WriteBuffer(data, sizeof(data));
      for i:=0 to length(VUarray)-1 do
      begin
        data:=length(vuarray[i].vumeter);
        Stream.WriteBuffer(data, sizeof(data));
        for j:=0 to length(vuarray[i].vumeter)-1 do
        begin
          Stream.WriteBuffer(vuarray[i].vumeter[j].Channel, sizeof(vuarray[i].vumeter[j].Channel));
          Stream.WriteBuffer(vuarray[i].vumeter[j].Color, sizeof(vuarray[i].vumeter[j].Color));
          Stream.WriteBuffer(vuarray[i].vumeter[j].UseAsRGB, sizeof(vuarray[i].vumeter[j].UseAsRGB));
        end;
        data:=round(vuarray[i].InputChannel);
        Stream.WriteBuffer(data, sizeof(data));
        if vuarray[i].IsActive then
          data:=1
        else
          data:=0;
        Stream.WriteBuffer(data, sizeof(data));
      end;

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
