unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CHHighResTimer, jpeg, Mask, JvExMask, JvSpin,
  Registry, pngimage;

const
  USBDMX_DLL_VERSION=0402;
  USBDMX_BULK_CONFIG_DELAY=01;	// delay frame by time
  USBDMX_BULK_CONFIG_BLOCK=02;	// block while frame is not transmitting (timeout given by time)
  USBDMX_BULK_CONFIG_RX=04;	// switch to RX after having transmitted this frame
  USBDMX_BULK_CONFIG_NORETX=08;	// do not retransmit this frame
  USBDMX_BULK_CONFIG_TXIRQ=64;	//40 send data using transmitter IRQ instead of timer

  USBDMX_BULK_STATUS_OK=00;
  USBDMX_BULK_STATUS_TIMEOUT=01;	// request timed out
  USBDMX_BULK_STATUS_TX_START_FAILED=02;	// delayed start failed
  USBDMX_BULK_STATUS_UNIVERSE_WRONG=03;	// wrong universe addressed\tabularnewline
  USBDMX_BULK_STATUS_RX_OLD_FRAME=16;	//10 old frame not read
  USBDMX_BULK_STATUS_RX_TIMEOUT=32;	//20 receiver finished with timeout (ored with others)
  USBDMX_BULK_STATUS_RX_NO_BREAK=64;	//40 frame without break received (ored with others)
  USBDMX_BULK_STATUS_RX_FRAMEERROR=128;	//80 frame finished with frame error (ored with others)

  USBDMX_ID_LED_USB=255;	// display the USB status: blink with 2Hz on USB transactions
  USBDMX_ID_LED_USB_RX=254;	// display USB and receiver status. the LED blinks red if not valid dmx signal in received

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tdevice = record
    h: Integer;
    TypeOfInterface:integer;
    Connected:boolean;
    Name:string;
    OutputBuffer: array[0..512] of byte; // 512 Bytes inkl. Startcode
    OutputDataChanged:boolean;
    OutputChannelOffset:Integer;
    InputBuffer: array[0..512] of byte; // 512 Bytes inkl. Startcode
    InputBufferOld: array[0..512] of byte; // 512 Bytes inkl. Startcode
    InputChannelOffset:Integer;
    Version: Word;
    Frames: Word;
    Slots: Word;
    TimeStamp: Word;
    Status: Byte;
  end;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label3: TLabel;
    dllversionlbl: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    DMXTimer: TCHHighResTimer;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    dmxoutoffsetedit: TJvSpinEdit;
    datainoffsetedit: TJvSpinEdit;
    DMXInTimer: TCHHighResTimer;
    Label7: TLabel;
    dmxoutintervaledit: TJvSpinEdit;
    Label8: TLabel;
    dmxinintervaledit: TJvSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    breaktimeedit: TJvSpinEdit;
    Label12: TLabel;
    mabtimeedit: TJvSpinEdit;
    blocktimeedit: TJvSpinEdit;
    Label13: TLabel;
    Label1: TLabel;
    procedure DMXTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dmxoutoffseteditChange(Sender: TObject);
    procedure datainoffseteditChange(Sender: TObject);
    procedure DMXInTimerTimer(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dmxoutintervaleditChange(Sender: TObject);
    procedure dmxinintervaleditChange(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure SearchForInterfaces;
    function HexToVersion(HexValue: Word):string;
    procedure SaveSettings;
    procedure LoadSettings;
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;

    device:array[0..31] of Tdevice;

    procedure Startup;
  end;

var
  mainform: Tmainform;

{
/*
 *   usbdmx_version(): returns the version number (16bit, 4 digits BCD)
 * Current version is USBDMX_DLL_VERSION. Use the Macro
 * USBDMX_DLL_VERSION_CHECK() compare dll's and header files version.
 */
USHORT	USBDMX_TYPE	usbdmx_version();
}
function pusbdmx_version: Word; stdcall external 'pusbdmx.dll' name '?pusbdmx_version@@YGGXZ';

{
/*
 *   usbdmx_open(): open device number <device>, where 0 is the first
 * and unlimit devices are supported. The function returnes 
 * STATUS_INVALID_HANDLE_VALUE if <device> is not supported. Use the
 * returned handle to access the device later on. One device can be
 * opened an unlimited number of times.
 */
BOOL	USBDMX_TYPE	usbdmx_open(USHORT device, PHANDLE h);
}
function pusbdmx_open(device: Word; h: Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_open@@YGHGPAPAX@Z';
{

/*
 *   usbdmx_close(): close the device identified by the given handle.
 */
BOOL	USBDMX_TYPE usbdmx_close(HANDLE h);
}
function pusbdmx_close(h: Integer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_close@@YGHPAX@Z';
{
/*
 *   pusbdmx_is_XXX(): identify the device identified by the given handle.
 * Each function returns TRUE if the device matches.
 */
BOOL	PUSBDMX_TYPE	pusbdmx_is_phoenixt(HANDLE h);
}
function pusbdmx_is_phoenixt(h: Integer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_is_phoenixt@@YGHPAX@Z';
{


/*
 *   usbdmx_product_get(): read the product string from the device.
 * size specifies the maximum size of the buffer pointed to by <string> 
 * (unit bytes).
 */
BOOL	USBDMX_TYPE	usbdmx_product_get(HANDLE h, PWCHAR string, USHORT size);
}
function pusbdmx_product_get(h: Integer; s: PChar; Size: Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_product_get@@YGHPAXPAGG@Z';
{


/*
 *   usbdmx_device_id(): read the device id of the device
 */
BOOL	USBDMX_TYPE	usbdmx_device_id(HANDLE h, PUSHORT pid);
}
function pusbdmx_device_id(h: Integer; pid: Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_device_id@@YGHPAXPAG@Z';
{


/*
 *   usbdmx_device_version(): Read the the device version of a device.
 * the device version is one of the values within the USBs configuration
 * descriptor (BcdDevice). pversion is only valid if the function returns
 * TRUE.
 */
BOOL	USBDMX_TYPE	usbdmx_device_version(HANDLE h, PUSHORT pversion);
}
function pusbdmx_device_version(h: Integer; Version: Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_device_version@@YGHPAXPAG@Z';
{


/*
 *   USBDMX_TX(): transmitt a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
 *			universe	- addressed universe
 *			slots		- number of bytes to be transmitted, as well as sizeof(buffer)
 *						  for DMX512: buffer[0] == startcode, slots <= 513
 *			buffer		- data to be transmitted,  !!! sizeof(buffer) >= slots !!!
 *			config		- configuration of the transmitter, see below for possible values
 *			time		- time value in s, depending on config, either timeout or delay
 *			time_break	- break time in s (can be zero, to not transmitt a break)
 *			time_mab	- Mark-after-Break time (can be zero)
 * OUTPUTs:	ptimestamp	- timestamp of this frame in ms, does overrun
 *			pstatus		- status of this transmission, see below for possible values
 */
BOOL	USBDMX_TYPE usbdmx_tx(IN HANDLE h, IN UCHAR universe, IN USHORT slots, 
							  IN PUCHAR buffer, IN UCHAR config, IN FLOAT time,
							  IN FLOAT time_break, IN FLOAT time_mab, 
							  OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);
}
function pusbdmx_tx(h: Integer; Universe: Byte; Slots: Word; Buffer:Pointer; Config: Byte; Time: Single; Time_Break: Single; Time_Mab: Single; TimeStamps:Pointer; Status:Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_tx@@YGHPAXEGPAEEMMMPAG1@Z';
{

/*
 * values of config (to be ored together)
 */
#define USBDMX_BULK_CONFIG_DELAY	(0x01)	// delay frame by time
#define USBDMX_BULK_CONFIG_BLOCK	(0x02)	// block while frame is not transmitting (timeout given by time)
#define USBDMX_BULK_CONFIG_RX		(0x04)	// switch to RX after having transmitted this frame
#define USBDMX_BULK_CONFIG_NORETX	(0x08)	// do not retransmit this frame
#define USBDMX_BULK_CONFIG_TXIRQ	(0x40)	// send data using transmitter IRQ instead of timer

/*
 *   USBDMX_RX(): receive a frame using the new protocol on bulk endpoints
 *
 * INPUTs:	h			- handle to the device, returned by usbdmx_open()
 *			universe	- addressed universe
 *			slots_set	- number of bytes to receive, as well as sizeof(buffer)
 *						  for DMX512: buffer[0] == startcode, slots_set <= 513
 *			buffer		- data to be transmitted,  !!! sizeof(buffer) >= slots !!!
 *			timeout		- timeout for receiving the total frame in s,
 *			timeout_rx	- timeout between two slots used to detect premature end of frames
 * OUTPUTs:	pslots_get	- number of slots actually received, *pslots_get <= slots_set
 *          ptimestamp	- timestamp of this frame in ms, does overrun
 *			pstatus		- status of the reception, see below for possible values
 */
BOOL	USBDMX_TYPE usbdmx_rx(IN HANDLE h, IN UCHAR universe, IN USHORT slots_set,
							  IN PUCHAR buffer, IN FLOAT timeout, IN FLOAT timeout_rx,
							  OUT PUSHORT pslots_get, OUT PUSHORT ptimestamp, OUT PUCHAR pstatus);
}
function pusbdmx_rx(h: Integer; Universe: Byte; Slots_Set: Word; Buffer: Pointer; Timeout: Single; Timeout_RX: Single; Slots_Get: Pointer; Timestamps: Pointer; Status: Pointer): boolean; stdcall external 'pusbdmx.dll' name '?pusbdmx_rx@@YGHPAXEGPAEMMPAG21@Z';
{


/*
 * values of *pstatus
 */
#define USBDMX_BULK_STATUS_OK				(0x00)
#define USBDMX_BULK_STATUS_TIMEOUT			(0x01)	// request timed out	
#define USBDMX_BULK_STATUS_TX_START_FAILED	(0x02)	// delayed start failed
#define USBDMX_BULK_STATUS_UNIVERSE_WRONG	(0x03)	// wrong universe addressed\tabularnewline
#define USBDMX_BULK_STATUS_RX_OLD_FRAME		(0x10)	// old frame not read
#define USBDMX_BULK_STATUS_RX_TIMEOUT		(0x20)	// receiver finished with timeout (ored with others)
#define USBDMX_BULK_STATUS_RX_NO_BREAK		(0x40)	// frame without break received (ored with others)
#define USBDMX_BULK_STATUS_RX_FRAMEERROR	(0x80)	// frame finished with frame error (ored with others)

/*
 * macro to check, it the return status is ok
 */
#define USBDMX_BULK_STATUS_IS_OK(s) (s == USBDMX_BULK_STATUS_OK)
{


/*
 *   usbdmx_id_led_XXX(): get/set the "id-led", the way the TX-led is handled:
 * special value: see below
 * other:         the blue led blinks the given number of times and then pauses
 */
BOOL	USBDMX_TYPE	usbdmx_id_led_set(HANDLE h, UCHAR id);
BOOL	USBDMX_TYPE	usbdmx_id_led_get(HANDLE h, PUCHAR id);
}
function pusbdmx_id_led_set(h: Integer; ID: Byte): boolean; stdcall external 'pusbdmx.dll'  name '?pusbdmx_id_led_set@@YGHPAXE@Z';
function pusbdmx_id_led_get(h: Integer; ID: Pointer): boolean; stdcall external 'pusbdmx.dll'  name '?pusbdmx_id_led_get@@YGHPAXPAE@Z';
{


/*
 * special values of id
 */
#define USBDMX_ID_LED_USB		(0xff)	// display the USB status: blink with 2Hz on USB transactions
#define USBDMX_ID_LED_USB_RX	(0xfe)	// display USB and receiver status. the LED blinks red if not valid dmx signal in received
}

implementation

{$R *.dfm}

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure Tmainform.DMXTimerTimer(Sender: TObject);
var
  i:integer;
begin
{
  /* send a frame */
  if (!usbdmx_tx( h,							/* handle to the interface */
          0,							/* universe addressed
                           on Rodin1/2: only 0 is supported
                           on RodinT: 0 transmitter side, 1 receiver side */
          513,						/* number of slots to be transmitted, incl. startcode */
          bufnew,						/* buffer with dmx data (bufnew[0] is the startcode */
          USBDMX_BULK_CONFIG_BLOCK,	/* configuration for this frame, see usbdmx.h for details */
          100e-3,						/* parameter for configuration [s], see usbdmx.h for details,
                                         in this case: block 100ms with respect to previous frame */
          200e-6,						/* length of break [s]. If 0, no break is generated */
          20e-6,						/* length of mark-after-break [s], If 0, no MaB is generated */
          &timestamp,					/* timestamp of the frame [ms] */
          &status))					/* status information */
    printf("usbdmx_tx(): error!\n");
  /* check transaction status, see usbdmx.h for details */
  if (!USBDMX_BULK_STATUS_IS_OK(status))
    printf("ERROR: usbdmx_tx(): status = 0x%02x\n", status);
}

  for i:=0 to 31 do
  begin
    // DMX-OUT
    if device[i].Connected then
    begin
      if device[i].OutputDataChanged then
      begin
        device[i].OutputDataChanged:=false;
                                                                                        //0.001  0.000200   0.000020
        pusbdmx_tx(device[i].h, 0, 513, @device[i].OutputBuffer, USBDMX_BULK_CONFIG_BLOCK, (blocktimeedit.Value/1000), (breaktimeedit.Value/1000000), (mabtimeedit.Value/1000000), @device[i].timestamp, @device[i].status);

        if device[i].status<>USBDMX_BULK_STATUS_OK then
        begin
//          listbox2.itemindex:=listbox2.Items.Add('ERROR: IF'+inttostr(i)+' data not transceived. Status='+inttostr(device[i].Status));
        end;
      end;
    end;
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
var
  i:integer;
begin
  dllversionlbl.caption:=HexToVersion(pusbdmx_version);//IntToHex(usbdmx_version,4)[1]+'.'+IntToHex(usbdmx_version,4)[2]+'.'+IntToHex(usbdmx_version,4)[3]+'.'+IntToHex(usbdmx_version,4)[4];

  //usbdmx_version -> 1027 ^= 0403 (HEX)
  // somit im Folgenden: usbdmx_version -> IntToHex (0403) -> StrToInt (403)
  // xxxx                                        0403
  if StrToInt(inttohex(pusbdmx_version,4))<>USBDMX_DLL_VERSION then
  begin
    ShowMessage('Die Datei "pusbdmx.dll" des PeperoniLights-Treibers liegt nicht in der ursprünglichen Version vor.'+#10#13#10#13+'Derzeitige Version: '+{IntToHex(usbdmx_version,4)[1]+'.'+IntToHex(usbdmx_version,4)[2]+'.'+IntToHex(usbdmx_version,4)[3]+'.'+IntToHex(usbdmx_version,4)[4]}HexToVersion(pusbdmx_version)+#10#13+'Erwartete Version: 0.'+IntToStr(USBDMX_DLL_VERSION)[1]+'.'+IntToStr(USBDMX_DLL_VERSION)[2]+'.'+IntToStr(USBDMX_DLL_VERSION)[3]);
  end;

  Listbox1.Items.Clear;

  for i:=0 to 31 do
  if device[i].Connected then
  begin
    Listbox1.Items.Add(device[i].Name+', Version: '+HexToVersion(device[i].version));
  end;
end;

procedure Tmainform.SearchForInterfaces;
var
  devicenumber:byte;
  AtLeastOneInterface:boolean;
begin
  AtLeastOneInterface:=false;
  for devicenumber:=0 to 31 do
  begin
    if not pusbdmx_open(devicenumber, @device[devicenumber].h) then
    begin
      device[devicenumber].Name:='Kein Interface gefunden!';
      device[devicenumber].TypeOfInterface:=-1;
      device[devicenumber].Connected:=false;
    end else
    begin
      AtLeastOneInterface:=true;

      device[devicenumber].Connected:=true;
      device[devicenumber].OutputChannelOffset:=1;
      device[devicenumber].InputChannelOffset:=0;

      if pusbdmx_is_phoenixt(device[devicenumber].h) then
      begin
        device[devicenumber].Name:='PhoenixT';
        device[devicenumber].TypeOfInterface:=1;
      end;

      pusbdmx_device_version(device[devicenumber].h, @device[devicenumber].version);
    end;
  end;

  DMXTimer.Enabled:=AtLeastOneInterface;
end;

procedure Tmainform.Button1Click(Sender: TObject);
var
  i:integer;
begin
  Listbox1.Items.Clear;

  SearchForInterfaces;

  for i:=0 to 31 do
  if device[i].Connected then
  begin
    Listbox1.Items.Add(device[i].Name+', Version: '+HexToVersion(device[i].version));
  end;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 31 do
  begin
    if device[i].Connected then
      pusbdmx_close(device[i].h);
  end;

  SaveSettings;
end;

procedure Tmainform.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex>-1 then
  begin
    dmxoutoffsetedit.Value:=device[ListBox1.ItemIndex].OutputChannelOffset;
    datainoffsetedit.Value:=device[ListBox1.ItemIndex].InputChannelOffset;
  end;
end;

procedure Tmainform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ListBox1.ItemIndex>-1 then
  begin
    dmxoutoffsetedit.Value:=device[ListBox1.ItemIndex].OutputChannelOffset;
    datainoffsetedit.Value:=device[ListBox1.ItemIndex].InputChannelOffset;
  end;
end;

procedure Tmainform.dmxoutoffseteditChange(Sender: TObject);
begin
  if ListBox1.ItemIndex>-1 then
    device[ListBox1.ItemIndex].OutputChannelOffset:=round(dmxoutoffsetedit.Value);
end;

procedure Tmainform.datainoffseteditChange(Sender: TObject);
begin
  if ListBox1.ItemIndex>-1 then
    device[ListBox1.ItemIndex].InputChannelOffset:=round(datainoffsetedit.Value);
end;

function Tmainform.HexToVersion(HexValue: Word):string;
begin
  result:=IntToHex(HexValue,4)[1]+'.'+IntToHex(HexValue,4)[2]+'.'+IntToHex(HexValue,4)[3]+'.'+IntToHex(HexValue,4)[4];
end;

procedure Tmainform.DMXInTimerTimer(Sender: TObject);
var
  i,j:integer;
begin
{
	/* receive a frame */
	if (!usbdmx_rx(	h,			/* handle to the interface */
					0,			/* universe addressed 
								   on Rodin1/2: only 0 is supported
								   on RodinT: 0 transmitter side, 1 receiver side */
					513,		/* number of slots to receive, incl. startcode */
					bufnew,		/* buffer for the received data */
					0.1,		/* timeout to receive the total frame [s] */
					1e-3,		/* timeout to receive the next slot [s] */
					&slots,		/* number of slots received */
					&timestamp,	/* timestamp of the frame */
					&status))	/* status information */
		printf("usbdmx_rx(): error!\n");
	/* check transaction status, see usbdmx.h for details */
	if (!USBDMX_BULK_STATUS_IS_OK(status))
	(
		if (status == USBDMX_BULK_STATUS_TIMEOUT)
			printf("INFO: usbdmx_rx() timed out, no frame received\n");
		else
			printf("ERROR: usbdmx_rx(): status = 0x%02x\n", status);
   )
}
  for i:=0 to 31 do
  begin
    // DMX-IN
    if Checkbox1.Checked and device[i].Connected then
    begin                                                    
      pusbdmx_rx(device[i].h, 0, 513, @device[i].InputBuffer, 0.02, 0.001, @device[i].Slots, @device[i].Timestamp, @device[i].Status);

      for j:=1 to 512 do
      begin
        if device[i].InputBuffer[j]<>device[i].InputBufferOld[j] then
        begin
          SetDLLValueEvent(j+device[i].InputChannelOffset,device[i].InputBuffer[j]);
          device[i].InputBufferOld[j]:=device[i].InputBuffer[j];
        end;
      end;
    end;
  end;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DMXInTimer.Enabled:=Checkbox1.Checked;
end;

procedure Tmainform.CheckBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DMXInTimer.Enabled:=Checkbox1.Checked;
end;

procedure Tmainform.dmxoutintervaleditChange(Sender: TObject);
begin
  DMXTimer.Interval:=round(dmxoutintervaledit.Value);
end;

procedure Tmainform.dmxinintervaleditChange(Sender: TObject);
begin
  DMXInTimer.Interval:=round(dmxinintervaledit.Value);
end;

procedure Tmainform.SaveSettings;
var
  LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          LReg.WriteInteger('DMX-Out Interval', round(dmxoutintervaledit.Value));
          LReg.WriteInteger('DMX-In Interval', round(dmxinintervaledit.Value));
          LReg.WriteInteger('Blockierzeit', round(blocktimeedit.Value));
          LReg.WriteInteger('Breaktime', round(breaktimeedit.Value));
          LReg.WriteInteger('MaB-Zeit', round(mabtimeedit.Value));
          LReg.WriteBool('DMX-In Enabled', CheckBox1.Checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.LoadSettings;
var
  LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
          if LReg.ValueExists('DMX-Out Interval') then
          begin
            dmxoutintervaledit.Value:=LReg.ReadInteger('DMX-Out Interval');
            DMXTimer.Interval:=round(dmxoutintervaledit.Value);
          end;

          if LReg.ValueExists('DMX-In Interval') then
          begin
            dmxinintervaledit.Value:=LReg.ReadInteger('DMX-In Interval');
            DMXInTimer.Interval:=round(dmxinintervaledit.Value);
          end;

          if LReg.ValueExists('Blockierzeit') then
          begin
            blocktimeedit.Value:=LReg.ReadInteger('Blockierzeit');
          end;

          if LReg.ValueExists('Breaktime') then
          begin
            breaktimeedit.Value:=LReg.ReadInteger('Breaktime');
          end;

          if LReg.ValueExists('MaB-Zeit') then
          begin
            mabtimeedit.Value:=LReg.ReadInteger('MaB-Zeit');
          end;

          if LReg.ValueExists('DMX-In Enabled') then
          begin
            CheckBox1.Checked:=LReg.ReadBool('DMX-In Enabled');
            DMXInTimer.Enabled:=Checkbox1.Checked;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.startup;
begin
  issending:=false;

  SearchForInterfaces;

  DMXInTimer.Enabled:=Checkbox1.Checked;

  LoadSettings;
end;

end.
