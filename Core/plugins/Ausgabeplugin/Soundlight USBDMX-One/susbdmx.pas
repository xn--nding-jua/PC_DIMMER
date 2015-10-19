unit susbdmx;

interface

function susbdmx_open(InterfaceNumber: SmallInt; var handle: Integer): Boolean stdcall; external 'susbdmx.dll';
function susbdmx_close(handle: Integer): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_tx(handle: Integer; universe: Byte; numslots: SmallInt; var buffer: Byte;
                    config: Byte; time, time_break, time_mab: Single; var ptimestamp: SmallInt;
                    var pstatus: Byte): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_rx(handle: Integer; universe: Byte; slots_set: SmallInt; var buffer: Byte;
                    timeout: Single; timeout_rx: Single; var pslots_get: Byte; var ptimestamp: SmallInt;
                    var pstatus: Byte): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_version(): SmallInt; stdcall; external 'susbdmx.dll';
function susbdmx_device_id(handle: Integer; var typid: SmallInt): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_device_version(handle: Integer; var pversion: SmallInt): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_serial_get(handle: Integer; serialno: WideString; size: SmallInt): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_id_led_set(handle: Integer; id: Byte): Boolean; stdcall; external 'susbdmx.dll';
function susbdmx_id_led_get(handle: Integer; var id: Byte): Boolean; stdcall; external 'susbdmx.dll';

implementation

end.

