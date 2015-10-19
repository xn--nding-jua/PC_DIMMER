library PC_DIMMER_SDK_Programmplugin;

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
  Result := PChar('PluginSDK');
end;

function DLLGetVersion:PChar;stdcall;
begin
  // Just for information
  Result := PChar('v1.0');
end;

procedure DLLShow;stdcall;
begin
  // DLLShow is called by clicking on the menu-item defined by DLLGetName-Function
  mainform.Show;
end;

// Data PC_DIMMER -> Plugin
procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  // all incoming data will be stored in an array within the main.pas
  mainform.channelvalue[channel]:=endvalue;
  mainform.channelnames[channel]:=copy(channelname,2,length(channelname));
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
var
  i,j:integer;
begin
  // called on every MSG-Event
  with mainform do
  case MSG of
    MSG_NEW:
    begin
      mainform.label6.caption:='MSG_NEW, '+string(Data1);
    end;
    MSG_OPEN:
    begin
      mainform.label6.caption:='MSG_OPEN, '+string(Data1);
    end;
    MSG_SAVE:
    begin
      mainform.label6.caption:='MSG_SAVE, '+string(Data1);
    end;
    MSG_AUDIOEFFECTPLAYERTIMECODE:
    begin
      mainform.label17.Caption:=inttostr(Data1);
    end;
    MSG_STARTPLUGINSCENE:
    begin
      for i:=0 to length(mainform.pluginszenen)-1 do
      begin
        If IsEqualGUID(StringToGUID(string(Data1)), mainform.pluginszenen[i].ID) then
        begin
          mainform.Listbox1.ItemIndex:=i;
          mainform.Label18.Caption:='"'+mainform.pluginszenen[i].name+'" aus Hauptprogramm gestartet...';
          break;
        end;
      end;
    end;
    MSG_EDITPLUGINSCENE:
    begin
      for i:=0 to length(mainform.pluginszenen)-1 do
      begin
        If IsEqualGUID(StringToGUID(string(Data1)), mainform.pluginszenen[i].ID) then
        begin
          mainform.Listbox1.ItemIndex:=i;
          mainform.Label18.Caption:='"'+mainform.pluginszenen[i].name+'" aus Hauptprogramm editiert...';
          ShowMessage('"'+mainform.pluginszenen[i].name+'" aus Hauptprogramm editiert...');
          break;
        end;
      end;
    end;
    MSG_STOPPLUGINSCENE:
    begin
      for i:=0 to length(mainform.pluginszenen)-1 do
      begin
        If IsEqualGUID(StringToGUID(string(Data1)), mainform.pluginszenen[i].ID) then
        begin
          mainform.Listbox1.ItemIndex:=-1;
          mainform.Label18.Caption:='"'+mainform.pluginszenen[i].name+'" aus Hauptprogramm gestoppt...';
          break;
        end;
      end;
    end;
    MSG_REFRESHPLUGINSCENE:
    begin
      for i:=0 to length(mainform.pluginszenen)-1 do
      begin
        If IsEqualGUID(StringToGUID(string(Data1)), mainform.pluginszenen[i].ID) then
        begin
          mainform.Pluginszenen[i].Name:=String(Data2);
          mainform.RefreshListbox;
          break;
        end;
      end;
    end;
    MSG_REMOVEPLUGINSCENE:
    begin
      for i:=0 to length(mainform.pluginszenen)-1 do
      begin
        If IsEqualGUID(StringToGUID(string(Data1)), mainform.pluginszenen[i].ID) then
        begin
          for j:=i to length(mainform.Pluginszenen)-2 do
          begin
            mainform.Pluginszenen[j].ID:=mainform.Pluginszenen[j+1].ID;
            mainform.Pluginszenen[j].Name:=mainform.Pluginszenen[j+1].Name;
          end;
          setlength(mainform.pluginszenen, length(mainform.pluginszenen)-1);
          mainform.RefreshListbox;
          break;
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
