unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CHHighResTimer, Mask, JvExMask, JvSpin, Registry,
  LibUSB;

const
  cmd_SetSingleChannel=1;
  cmd_SetChannelRange=2;
  cmd_StartBootloader=50;
  err_BadChannel=1;
  err_BadValue=2;
  USBDEV_SHARED_VENDOR=5824;//0x16C0
  USBDEV_SHARED_PRODUCT=1500;//0x05DC
  USBDEV_SHARED_VENDOR_B=1003;//0x03EB  // This is for china-copy of uDMX called D512
  USBDEV_SHARED_PRODUCT_B=34952;//0x8888 // This is for china-copy of uDMX called D512

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = procedure(address:integer);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; ARG:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    uDMXTimer: TCHHighResTimer;
    Label3: TLabel;
    Label4: TLabel;
    maxchansedit: TJvSpinEdit;
    refreshtimeedit: TJvSpinEdit;
    Button1: TButton;
    Label5: TLabel;
    statuslabel: TLabel;
    procedure uDMXTimerTimer(Sender: TObject);
    procedure maxchanseditChange(Sender: TObject);
    procedure refreshtimeeditChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SucheUDMXDevice;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    uDMXDevice_Pointer:pusb_device;
    uDMXDevice_Handle:pusb_dev_handle;
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;
    sendvalues:boolean;
    Channelvalues:array[1..512] of Byte;
    maxchans:integer;
    refreshtime:integer;
    procedure Startup;
  end;

var
  mainform: Tmainform;

implementation

//function ChannelSet(Channel, Value:integer):boolean; stdcall external 'uDMX.dll';
//function ChannelsSet(ChanCount, StartChan:integer; PointerToValueArray:Pointer):boolean; stdcall external 'uDMX.dll';
//procedure Configure; stdcall external 'uDMX.dll';

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

procedure Tmainform.uDMXTimerTimer(Sender: TObject);
begin
  if sendvalues then
  begin
    sendvalues:=false;
//    ChannelsSet(maxchans, 1, @Channelvalue);
    if Assigned(uDMXDevice_Handle) then
      usb_control_msg(uDMXDevice_Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetChannelRange, maxchans, 0, Channelvalues, maxchans, 5000);
  end;
end;

procedure Tmainform.maxchanseditChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  maxchans:=round(maxchansedit.value);

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
	        LReg.WriteInteger('MaxChanCount',maxchans);
	      end;
 			end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.refreshtimeeditChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  refreshtime:=round(refreshtimeedit.value);
  uDMXTimer.Interval:=refreshtime;

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
	        LReg.WriteInteger('RefreshTime',refreshtime);
	      end;
 			end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  SucheUDMXDevice;
end;

procedure Tmainform.SucheUDMXDevice;
var
  bus: pusb_bus;
  dev:pusb_device;
  udev:pusb_dev_handle;
  ret: integer;
  description, vendor:array[0..255] of char;
  vendorok, deviceok:boolean;
begin
//  if Assigned(udev) then
//    usb_close(udev);
  statuslabel.Caption:='Nicht verbunden...';
  statuslabel.Font.Color:=clRed;

  usb_find_busses; // Finds all USB busses on system
  usb_find_devices; // Find all devices on all USB devices
  bus := usb_get_busses; // Return the list of USB busses found

  vendorok:=false;
  deviceok:=false;

  if Assigned(bus) then
  begin
    dev := bus^.devices;

    if Assigned(dev) then
    begin
      udev := usb_open(dev);
      if Assigned(udev) then
      begin
        if (dev^.descriptor.iProduct > 0) then
        begin
          ret := usb_get_string_simple(udev, dev^.descriptor.iProduct, description, sizeof(description));
          if (ret > 0) then
          begin
            if String(description)='uDMX' then deviceok:=true;
          end;
        end;

        if dev^.descriptor.iManufacturer > 0 then
        begin
          ret := usb_get_string_simple(udev, dev^.descriptor.iManufacturer, vendor, sizeof(vendor));
          if (ret > 0) then
          begin
            if String(vendor)='www.anyma.ch' then vendorok:=true;
          end;
        end;

        if (vendorok and deviceok) and ((dev^.descriptor.idVendor=USBDEV_SHARED_VENDOR) and (dev^.descriptor.idProduct=USBDEV_SHARED_PRODUCT)) then
        begin
          uDMXDevice_Pointer:=dev;
          uDMXDevice_Handle:=udev;
          statuslabel.Caption:='Verbunden mit original uDMX...';
          statuslabel.Font.Color:=clGreen;
        end else if ((dev^.descriptor.idVendor=USBDEV_SHARED_VENDOR) and (dev^.descriptor.idProduct=USBDEV_SHARED_PRODUCT)) or
          ((dev^.descriptor.idVendor=USBDEV_SHARED_VENDOR_B) and (dev^.descriptor.idProduct=USBDEV_SHARED_PRODUCT_B)) then
    		begin
          // VID und PID passen, obwohl Name und Vendor-String nicht passen
          // Alternative VID und PID des China-Klons passen
          uDMXDevice_Pointer:=dev;
          uDMXDevice_Handle:=udev;
          statuslabel.Caption:='Verbunden mit uDMX-kompatiblem Interface...';
          statuslabel.Font.Color:=clGreen;
    		end;
      end;
    end;
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  SucheUDMXDevice;
end;

procedure Tmainform.startup;
var
  LReg:TRegistry;
begin
  issending:=false;
  maxchans:=256;
  refreshtime:=50;

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
	        if not LReg.ValueExists('MaxChanCount') then
	          LReg.WriteInteger('MaxChanCount',256);
	        maxchans:=LReg.ReadInteger('MaxChanCount');
          maxchansedit.Value:=maxchans;
	        if not LReg.ValueExists('RefreshTime') then
	          LReg.WriteInteger('RefreshTime',50);
	        refreshtime:=LReg.ReadInteger('RefreshTime');
          refreshtimeedit.Value:=refreshtime;
          uDMXTimer.Interval:=refreshtime;
	      end;
 			end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;

  usb_init;
  SucheUDMXDevice;
end;

end.
