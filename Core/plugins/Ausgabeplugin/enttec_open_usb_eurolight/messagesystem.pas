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
  MSG_STARTSCENE=16; // Data1=TGUID
  MSG_STOPSCENE=17; // Data1=TGUID
  MSG_SPEEDMASTER=18; // Data1=Byte
  MSG_AUDIOEFFECTPLAYERTIMECODE=19; // Data1=Cardinal (in ms)
  MSG_AUDIOEFFECTPLAYEREVENT=20; // Data1=Byte  (0=Play, 1=Pause, 2=Stop)
  MSG_MIDIOUT=21; // Data1=array[0..2] of byte
  MSG_SETLANGUAGE=22; // Data1=Languagecode 0=English, 1=French, 3=German
  MSG_OPENLIBRARY=23; // Data1=Szenen-ID (um zu bearbeitende Szene in Bibliothek zu selektieren)
  MSG_LIBRARYVALUE=24; // Data1=Szenenname, Data2=Szenen-ID
  MSG_CREATEPLUGINSCENE=25; // Data1=ID, Data2=Name
  MSG_REFRESHPLUGINSCENE=26; // Data1=ID, Data2=Name
  MSG_REMOVEPLUGINSCENE=27; // Data1=ID
  MSG_STARTPLUGINSCENE=28; // Data1=ID, Data2=Fadetime (Optional)
  MSG_STOPPLUGINSCENE=29; // Data1=ID
  MSG_EDITPLUGINSCENE=30; // Data1=ID

implementation

end.