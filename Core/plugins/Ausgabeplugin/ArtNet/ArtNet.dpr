library ArtNet;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  SysUtils,
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas',
  mainfrm in 'mainfrm.pas' {mainform};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  mainform:=Tmainform.create(Application);
  @mainform.SetDLLValues:=CallbackSetDLLValues; // Lets you set value and fadeintime of a single channel
  @mainform.SetDLLValueEvent:=CallbackSetDLLValueEvent; // Lets you set values in the DataIn Window
  @mainform.SetDLLNames:=CallbackSetDLLNames; // Lets you set a name of a single channel
  @mainform.GetDLLValue:=CallbackGetDLLValue; // Causes the PC_DIMMER to send the current value of this channel
  @mainform.SendMSG:=CallbackSendMessage; // Sends a predefined message (see messagesystem.pas for more informations)
end;

procedure DLLStart;stdcall;
begin
  mainform.cbArtNETSubnetSelect(nil);
end;

function DLLDestroy:boolean;stdcall;
begin
  try
    @mainform.SetDLLValues:=nil;
    @mainform.SetDLLValueEvent:=nil;
    @mainform.SetDLLNames:=nil;
    @mainform.GetDLLValue:=nil;
    @mainform.SendMSG:=nil;

	  mainform.release;
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
  Result := PChar('Art-Net Transceiver');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.1');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.ShowModal;
end;

procedure DLLAbout;stdcall;
begin
  aboutform :=TAboutform.Create(nil);
  aboutform.ShowModal;
  aboutform.release;
end;

procedure DLLSenddata(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=mainform.issending;
  mainform.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
var
  Subnet, Universe, Channel:integer;
begin
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if mainform.cbAllowAllUniverses.Checked then
      begin
        // maximal 16 Universes verfügbar
        if Integer(Data1)<=8192 then
        begin
          // SubNet auslesen (Aufteilung der Universes nur innerhalb eines SubNets)
          Subnet:=mainform.cbArtNETSubnet.ItemIndex;
          // aber Aufteilung auf alle 16 Universes (insgesamt 8192 Kanäle)
          Universe:=trunc((Integer(Data1)-1)/512);
          Channel:=(Integer(Data1)-1)-(Universe*512);

          mainform.DMXOutUniverse[Subnet][Universe][Channel]:=Integer(Data2);
        end;
      end else
      begin
        // maximal 4 Universes verfügbar
        if Integer(Data1)<=2048 then
        begin
          Universe:=trunc((Integer(Data1)-1)/512); // Universe 0-3
          Channel:=(Integer(Data1)-1)-(Universe*512); // Kanal 0-511

          mainform.DMXOutUniverseSpec[Universe][Channel]:=Integer(Data2);
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
  DLLAbout,
  DLLConfigure,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
