unit messagesystem;

{
The PC_DIMMER messagesystem lets you interact with the mainprogram. You can
set, record, receive and control values with the predefined messages.

Use the pointer of the callbackfunction "CallbackSendMessage" to send the
messages like this:

  // in your program:
  TCallbackSendMessage = procedure(MSG: Byte; ARG:Variant);stdcall;
  SendMSG:TCallbackSendMessage;

  // in the DLLActivate-prodecure of the DPR-file:
  @YOURPROGRAM.SendMSG:=CallbackSendMessage;

  // back in your program:
  SendMSG(MSG_ADDLOGFILEENTRY,'The messagesystem is working well! :)'); // Adds a new entry into the debug-log
}

interface

const
  // ID=String einer TGUID (z.B.: '{E627400F-BB66-40DB-B6C0-7F5FD78DE36D}')

	// PC_DIMMER Messagesystem: MSG, Data1, Data2
	MSG_RECORDSCENE=0; // Data1=Booleanarray
	MSG_AUDIOEFFECTPLAYERRECORD=1; // Data1=Boolean
	MSG_SYSTEMVOLUME=2; // Data1=Byte
	MSG_SYSTEMMUTE=3; // Data1=Boolean
	MSG_JUMPTOCHANNEL=4; // Data1=Integer
	MSG_GRANDMASTER=5; // Data1=Byte
	MSG_FLASHMASTER=6; // Data1=Byte
	MSG_ADDLOGFILEENTRY=7; // Data1=String
	MSG_EFFECTSPLAY=8; // Data1=Boolean
  MSG_SYSTEMSPEED=9; // Data1=Integer (BPM)
  MSG_NEW=10; // Data1=String (Projektverzeichnis)
  MSG_OPEN=11; // Data1=String (Projektverzeichnis)
  MSG_SAVE=12; // Data1=String (Projektverzeichnis)
  MSG_BEATIMPULSE=13; // Data1=Boolean
  MSG_ACTUALCHANNELVALUE=14; // Data1=Integer, Data2=Integer
  MSG_MIDIIN=15; // Data1=array[0..2] of byte
  {
    Data[0]=MIDI_Message
    Data[1]=MIDI_Data1
    Data[2]=MIDI_Data2
  }
  MSG_STARTSCENE=16; // Data1=ID
  MSG_STOPSCENE=17; // Data1=ID
  MSG_SPEEDMASTER=18; // Data1=Byte
  MSG_AUDIOEFFECTPLAYERTIMECODE=19; // Data1=Cardinal (in ms)
  MSG_AUDIOEFFECTPLAYEREVENT=20; // Data1=Byte  (0=Play, 1=Pause, 2=Stop)
  MSG_MIDIOUT=21; // Data1=array[0..2] of byte
  {
    Data[0]=MIDI_Message
    Data[1]=MIDI_Data1
    Data[2]=MIDI_Data2
  }
  MSG_SETLANGUAGE=22; // Data1=Languagecode 0=English, 1=French, 3=German
  MSG_OPENLIBRARY=23; // Data1=Szenen-ID (um zu bearbeitende Szene in Bibliothek zu selektieren)
  MSG_LIBRARYVALUE=24; // Data1=Szenenname, Data2=Szenen-ID
  MSG_CREATEPLUGINSCENE=25; // Data1=ID, Data2=Name
  MSG_REFRESHPLUGINSCENE=26; // Data1=ID, Data2=Name
  MSG_REMOVEPLUGINSCENE=27; // Data1=ID
  MSG_STARTPLUGINSCENE=28; // Data1=ID, Data2=Fadetime (Optional)
  MSG_STOPPLUGINSCENE=29; // Data1=ID
  MSG_EDITPLUGINSCENE=30; // Data1=ID
  MSG_REGISTERPLUGINCOMMAND=31; // Data1=ID, Data2=Name
  MSG_STARTPLUGINCOMMAND=32; // Data1=ID, Data2=Wert zwischen 0 und 255
  MSG_SETCOLOR=33; // Data1=ID, Data2=array[0..2] of byte (=R,G,B)
  {
    Data[0]=R
    Data[1]=G
    Data[2]=B
  }
  MSG_SETDIMMER=34; // Data1=ID, Data2=byte
  MSG_SETSTROBE=35; // Data1=ID, Data2=byte
  MSG_SETSHUTTER=36; // Data1=ID, Data2=byte (0=off, 255=on)
  MSG_SETGOBOROT1=37; // Data1=ID, Data2=byte
  MSG_SETGOBOROT2=38; // Data1=ID, Data2=byte
  MSG_SETPRISMA=39; // Data1=ID, Data2=byte (0=Single, 255=Triple)
  MSG_SETPRISMAROT=40; // Data1=ID, Data2=byte
  MSG_SETIRIS=41; // Data1=ID, Data2=byte
  MSG_STARTCOMMAND=42; // Data1=array[0..6] of string[38], Data2=byte (Sollwert 0..255)
  {
    Data[0]=ID des aufzurufenden Befehls
    Data[1]=Integer-Wert 1 als String
    Data[2]=Integer-Wert 2 als String
    Data[3]=String-Wert 1
    Data[4]=String-Wert 2
    Data[5]=GUID 1 als String
    Data[6]=GUID 2 als String
  }
  MSG_STARTEFFECT=43; // Data1=ID
  MSG_STOPEFFECT=44; // Data1=ID
  MSG_SELECTDEVICE=45; // Data1=ID, Data2<128 -> Deselect, Data2=128 -> Toggle, Data2>128 -> Select
  MSG_SELECTEDDEVICESSETCHANNEL=46; // Data1=Channel, Data2=byte

implementation

function GetMSGName(MSG: Byte):string;
var
  text:string;
begin
  case MSG of
    0: text:='MSG_RECORDSCENE';//0; Data1';//Booleanarray
    1: text:='MSG_AUDIOEFFECTPLAYERRECORD';//1; Data1';//Boolean
    2: text:='MSG_SYSTEMVOLUME';//2; Data1';//Byte
    3: text:='MSG_SYSTEMMUTE';//3; Data1';//Boolean
    4: text:='MSG_JUMPTOCHANNEL';//4; Data1';//Integer
    5: text:='MSG_GRANDMASTER';//5; Data1';//Byte
    6: text:='MSG_FLASHMASTER';//6; Data1';//Byte
    7: text:='MSG_ADDLOGFILEENTRY';//7; Data1';//String
    8: text:='MSG_EFFECTSPLAY';//8; Data1';//Boolean
    9: text:='MSG_SYSTEMSPEED';//9; Data1';//Integer (BPM)
    10: text:='MSG_NEW';//10; Data1';//String (Projektverzeichnis)
    11: text:='MSG_OPEN';//11; Data1';//String (Projektverzeichnis)
    12: text:='MSG_SAVE';//12; Data1';//String (Projektverzeichnis)
    13: text:='MSG_BEATIMPULSE';//13; Data1';//Boolean
    14: text:='MSG_ACTUALCHANNELVALUE';//14; Data1';//Integer, Data2';//Integer
    15: text:='MSG_MIDIIN';//15; Data1';//array[0..2] of byte
    16: text:='MSG_STARTSCENE';//16; Data1';//ID
    17: text:='MSG_STOPSCENE';//17; Data1';//ID
    18: text:='MSG_SPEEDMASTER';//18; Data1';//Byte
    19: text:='MSG_AUDIOEFFECTPLAYERTIMECODE';//19; Data1';//Cardinal (in ms)
    20: text:='MSG_AUDIOEFFECTPLAYEREVENT';//20; Data1';//Byte  (0';//Play, 1';//Pause, 2';//Stop)
    21: text:='MSG_MIDIOUT';//21; Data1';//array[0..2] of byte
    22: text:='MSG_SETLANGUAGE';//22; Data1';//Languagecode 0';//English, 1';//French, 3';//German
    23: text:='MSG_OPENLIBRARY';//23; Data1';//Szenen-ID (um zu bearbeitende Szene in Bibliothek zu selektieren)
    24: text:='MSG_LIBRARYVALUE';//24; Data1';//Szenenname, Data2';//Szenen-ID
    25: text:='MSG_CREATEPLUGINSCENE';//25; Data1';//ID, Data2';//Name
    26: text:='MSG_REFRESHPLUGINSCENE';//26; Data1';//ID, Data2';//Name
    27: text:='MSG_REMOVEPLUGINSCENE';//27; Data1';//ID
    28: text:='MSG_STARTPLUGINSCENE';//28; Data1';//ID, Data2';//Fadetime (Optional)
    29: text:='MSG_STOPPLUGINSCENE';//29; Data1';//ID
    30: text:='MSG_EDITPLUGINSCENE';//30; Data1';//ID
    31: text:='MSG_REGISTERPLUGINCOMMAND';//31; Data1';//ID, Data2';//Name
    32: text:='MSG_STARTPLUGINCOMMAND';//32; Data1';//ID, Data2';//Wert zwischen 0 und 255
    33: text:='MSG_SETCOLOR';//33; Data1';//ID, Data2';//array[0..2] of byte (';//R,G,B)
    34: text:='MSG_SETDIMMER';//34; Data1';//ID, Data2';//byte
    35: text:='MSG_SETSTROBE';//35; Data1';//ID, Data2';//byte
    36: text:='MSG_SETSHUTTER';//36; Data1';//ID, Data2';//byte (0';//off, 255';//on)
    37: text:='MSG_SETGOBOROT1';//37; Data1';//ID, Data2';//byte
    38: text:='MSG_SETGOBOROT2';//38; Data1';//ID, Data2';//byte
    39: text:='MSG_SETPRISMA';//39; Data1';//ID, Data2';//byte (0';//Single, 255';//Triple)
    40: text:='MSG_SETPRISMAROT';//40; Data1';//ID, Data2';//byte
    41: text:='MSG_SETIRIS';//41; Data1';//ID, Data2';//byte
    42: text:='MSG_STARTCOMMAND';//42; Data1';//array[0..6] of string[38], Data2';//byte (Sollwert 0..255)
    43: text:='MSG_STARTEFFECT';//43; Data1';//ID
    44: text:='MSG_STOPEFFECT';//44; Data1';//ID
    45: text:='MSG_SELECTDEVICE';//45; // Data1=ID, Data2<128 -> Deselect, Data2=128 -> Toggle, Data2>128 -> Select
    46: text:='MSG_SELECTEDDEVICESSETCHANNEL';//46; Data1=Channel, Data2=byte
    else
      text:='Befehl nicht gefunden...';
  end;

  result:=text;
end;

end.
