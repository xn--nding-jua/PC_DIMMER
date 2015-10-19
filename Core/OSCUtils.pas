//////project name
//OSCUtils

//////description
//Utility library to encode/decode osc-packets
//inspired by original OSC reference implementation (OSC-Kit)
//and OSC.Net library as shipped with the TUIO-CSharp sample
//from http://reactable.iua.upf.edu/?software

//////licence
//GNU Lesser General Public License (LGPL)
//english: http://www.gnu.org/licenses/lgpl.html
//german: http://www.gnu.de/lgpl-ger.html

//////language/ide
//delphi

//////initial author
//joreg -> joreg@vvvv.org

//////instructions
////encoding a single message:
//first create a message: msg := TOSCMessage.Create(address)
//then call msg.AddAsString(typetag, value) to add any number of arguments
//with  msg.ToOSCString you get its osc-string representation
////encoding a bundle:
//first create a bundle: bundle := TOSCBundle.Create
//then add any number of packets (i.e. message, bundle) via bundle.Add(packet)
//with bundle.ToOSCString you get its osc-string representation

////decoding a string
//use TOSCPacket.Unpack(PByte(osc-string), Length(osc-string)) to create
//TOSCPackets of your osc-strings (those can be either bundles or single
//messages. if you want to decode several packets at once you can create
//a container bundle first and add the packets you create like this.
//then use msg := FPacket.MatchAddress(address) to find a message with the
//according address in your packet-structure.
//before you now can access the arguments and typetags of a message you have
//to call msg.Decode
//voila.


unit OSCUtils;

interface

uses Classes, Contnrs;

type
  TOSCPacket = class;
  TOSCMessage = class;

  TOSCPacket = class(TObject)
  private
  protected
    FBytes: PByte;
    function MakeOSCFloat(value: Single): String;
    function MakeOSCInt(value: Integer): String;
    function MakeOSCString(value: String): String;
    function MatchBrackets(pMessage, pAddress: PChar): Boolean;
    function MatchList(pMessage, pAddress: PChar): Boolean;
    function MatchPattern(pMessage, pAddress: PChar): Boolean;
  public
    constructor Create(Bytes: PByte);
    function MatchAddress(Address: String): TOSCMessage; virtual; abstract;
    function ToOSCString: string; virtual; abstract;
    procedure Unmatch; virtual; abstract;
    class function Unpack(Bytes: PByte; Count: Integer): TOSCPacket; overload;
    class function Unpack(Bytes: PByte; Offset, Count: Integer; TimeTag: Extended =
        0): TOSCPacket; overload; virtual;
    class function UnpackInt(Bytes: PByte; var Offset: Integer): Integer; static;
    class function UnpackFloat(Bytes: PByte; var Offset: Integer): Single; static;
    class function UnpackString(Bytes: PByte; var Offset: Integer): string; static;
  end;

  TOSCMessage = class(TOSCPacket)
  private
    FAddress: string;
    FArguments: TStringList;
    FIsDecoded: Boolean;
    FMatched: Boolean;
    FTimeTag: Extended;
    FTypeTagOffset: Integer;
    FTypeTags: string;
    function GetArgument(Index: Integer): string;
    function GetArgumentCount: Integer;
    function GetTypeTag(Index: Integer): string;
  public
    constructor Create(Address: string); overload;
    constructor Create(Bytes: PByte); overload;
    destructor Destroy; override;
    function AddAsString(TypeTag: Char; Value: String): HResult;
    procedure AddFloat(Value: Single);
    procedure AddInteger(Value: Integer);
    procedure AddString(Value: String);
    procedure Decode;
    function MatchAddress(Address: String): TOSCMessage; override;
    function ToOSCString: string; override;
    procedure Unmatch; override;
    class function Unpack(Bytes: PByte; PacketOffset, Count: Integer; TimeTag:
        Extended = 0): TOSCPacket; overload; override;
    property Address: string read FAddress write FAddress;
    property Argument[Index: Integer]: String read GetArgument;
    property ArgumentCount: Integer read GetArgumentCount;
    property IsDecoded: Boolean read FIsDecoded write FIsDecoded;
    property Matched: Boolean read FMatched write FMatched;
    property TimeTag: Extended read FTimeTag write FTimeTag;
    property TypeTag[Index: Integer]: String read GetTypeTag;
    property TypeTagOffset: Integer read FTypeTagOffset write FTypeTagOffset;
  end;

  TOSCBundle = class(TOSCPacket)
  private
    FPackets: TObjectList;
  public
    constructor Create(Bytes: PByte);
    destructor Destroy; override;
    procedure Add(const Packet: TOSCPacket);
    function MatchAddress(Address: String): TOSCMessage; override;
    function ToOSCString: string; override;
    procedure Unmatch; override;
    class function Unpack(Bytes: PByte; PacketOffset, Count: Integer; TimeTag:
        Extended = 0): TOSCPacket; overload; override;
  end;

  const
    OSC_OK = 0;
    OSC_UNRECOGNIZED_TYPETAG = 1;
    OSC_CONVERT_ERROR = 2;


implementation

uses
  SysUtils, WinSock, Math;


constructor TOSCMessage.Create(Address: string);
begin
  FAddress := Address;
  Create(nil);
end;

constructor TOSCMessage.Create(Bytes: PByte);
begin
  inherited;
  
  FTypeTags := ',';
  FArguments := TStringList.Create;
  FIsDecoded := false;
end;

destructor TOSCMessage.Destroy;
begin
  FArguments.Free;
  inherited;
end;

function TOSCMessage.AddAsString(TypeTag: Char; Value: String): HResult;
begin
  Result := OSC_OK;

  try
    if TypeTag = 'f' then
      FArguments.Add(MakeOSCFloat(StrToFloat(Value)))
    else if TypeTag = 'i' then
      FArguments.Add(MakeOSCInt(StrToInt(Value)))
    else if TypeTag = 's' then
      FArguments.Add(MakeOSCString(Value))
    else
      Result := OSC_UNRECOGNIZED_TYPETAG;
  except on EConvertError do
    Result := OSC_CONVERT_ERROR;
  end;

  if Result  = OSC_OK then
    FTypeTags := FTypeTags + TypeTag;
end;

procedure TOSCMessage.AddFloat(Value: Single);
begin
  FTypeTags := FTypeTags + 'f';
  FArguments.Add(MakeOSCFloat(Value));
end;

procedure TOSCMessage.AddInteger(Value: Integer);
begin
  FTypeTags := FTypeTags + 'i';
  FArguments.Add(MakeOSCInt(Value));
end;

procedure TOSCMessage.AddString(Value: String);
begin
  FTypeTags := FTypeTags + 's';
  FArguments.Add(MakeOSCString(Value));
end;

procedure TOSCMessage.Decode;
var
  i, offset: Integer;
begin
  if FIsDecoded then
    exit;

  offset := FTypeTagOffset;
  FTypeTags := UnpackString(FBytes, offset);

  for i := 1 to Length(FTypeTags) - 1 do
  begin
    if FTypeTags[i+1] = 's' then
      FArguments.Add(UnpackString(FBytes, offset))
    else if FTypeTags[i+1] = 'i' then
      FArguments.Add(IntToStr(UnpackInt(FBytes, offset)))
    else if FTypeTags[i+1] = 'f' then
      FArguments.Add(FloatToStr(UnpackFloat(FBytes, offset)));
  end;

  FIsDecoded := true;
end;

function TOSCMessage.GetArgument(Index: Integer): string;
begin
  Result := FArguments[Index];
end;

function TOSCMessage.GetArgumentCount: Integer;
begin
  Result := FArguments.Count;
end;

function TOSCMessage.GetTypeTag(Index: Integer): string;
begin
  // TODO -cMM: TOSCMessage.GetTypeTag default body inserted
  Result := FTypeTags[Index + 2];
end;

function TOSCMessage.MatchAddress(Address: String): TOSCMessage;
begin
  if not FMatched
  and MatchPattern(PChar(FAddress), PChar(Address)) then
  begin
    FMatched := true;
    Result := Self
  end
  else
    Result := nil;
end;

function TOSCMessage.ToOSCString: string;
var
  i: Integer;
begin
  Result := MakeOSCString(FAddress) + MakeOSCString(FTypeTags);

  for i := 0 to FArguments.Count - 1 do
    Result := Result + FArguments[i];
end;

procedure TOSCMessage.Unmatch;
begin
  FMatched := false;
end;

class function TOSCMessage.Unpack(Bytes: PByte; PacketOffset, Count: Integer;
    TimeTag: Extended = 0): TOSCPacket;
var
  address: String;
begin
  Result := TOSCMessage.Create(Bytes);
  //for now decode address only
  (Result as TOSCMessage).Address := UnpackString(Bytes, PacketOffset);
  (Result as TOSCMessage).TimeTag := TimeTag;

  //save offset for later decoding on demand
 (Result as TOSCMessage).TypeTagOffset := PacketOffset;
 (Result as TOSCMessage).IsDecoded := false;
end;

constructor TOSCBundle.Create(Bytes: PByte);
begin
  inherited;
  FPackets := TObjectList.Create;
  FPackets.OwnsObjects := true;
end;

destructor TOSCBundle.Destroy;
begin
  FPackets.Free;
  inherited;
end;

procedure TOSCBundle.Add(const Packet: TOSCPacket);
begin
  FPackets.Add(Packet);
end;

function TOSCBundle.MatchAddress(Address: String): TOSCMessage;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to FPackets.Count - 1 do
  begin
    Result := (FPackets[i] as TOSCPacket).MatchAddress(Address);
    if Assigned(Result) then
      break;
  end;
end;

function TOSCBundle.ToOSCString: string;
var
  timeTag: String;
  i: Integer;
  packet: String;
begin
  timeTag := #0#0#0#0#0#0#0#1; //immediately
  Result := MakeOSCString('#bundle') + timeTag;

  for i := 0 to FPackets.Count - 1 do
  begin
    packet := (FPackets[i] as TOSCPacket).ToOSCString;
    Result := Result + MakeOSCInt(Length(packet)) + packet;
  end;
end;

procedure TOSCBundle.Unmatch;
var
  i: Integer;
begin
  for i := 0 to FPackets.Count - 1 do
    (FPackets[i] as TOSCPacket).UnMatch;
end;

class function TOSCBundle.Unpack(Bytes: PByte; PacketOffset, Count: Integer;
    TimeTag: Extended = 0): TOSCPacket;
var
  packetLength: Integer;
  tt1, tt2: Cardinal;
begin
  Result := TOSCBundle.Create(Bytes);

  //advance the '#bundle' string
  UnpackString(Bytes, PacketOffset);

  //advance the timestamp
  tt1 := Cardinal(UnpackInt(Bytes, PacketOffset));
  tt2 := Cardinal(UnpackInt(Bytes, PacketOffset));

  TimeTag := tt1 + tt2 / power(2, 32);

  while PacketOffset < Count do
  begin
    packetLength := UnpackInt(Bytes, PacketOffset);
    (Result as TOSCBundle).Add(TOSCPacket.Unpack(Bytes, PacketOffset, packetLength, TimeTag));
    Inc(PacketOffset, packetLength);
  end;
end;

constructor TOSCPacket.Create(Bytes: PByte);
begin
  FBytes := Bytes;
end;

function TOSCPacket.MakeOSCFloat(value: Single): String;
var
  tmp: Byte;
  intg, i: Integer;
begin
  result := '';
  intg := Integer(Pointer(value));
  intg := htonl(intg);
  for i := 0 to 3 do
  begin
    tmp := intg and $ff;
    result := result + chr(tmp);
    intg := intg shr 8;
  end;
end;

function TOSCPacket.MakeOSCInt(value: Integer): String;
var
  tmp: Byte;
  i, val: Integer;
begin
  result := '';
  val := htonl(value);
  for i := 0 to 3 do
  begin
    tmp := val and $ff;
    result := result + chr(tmp);
    val := val shr 8;
  end;
end;

function TOSCPacket.MakeOSCString(value: String): String;
var i, ln: Integer;
begin
  result := value;

  ln := 4 - (length(value)) mod 4;
  for i := 0 to ln - 1 do
    result := result + #0;
end;

// we know that pattern[0] == '[' and test[0] != 0 */
function TOSCPacket.MatchBrackets(pMessage, pAddress: PChar): Boolean;
var
  negated: Boolean;
  p, p1, p2: PChar;
begin
  p := pMessage;
  Result := false;
  negated := false;

  Inc(pMessage);
  if pMessage^ = #0 then
  begin
    //LogWarningFMT('Unterminated [ in message: %s', [FInput[0]]);
    Dec(pMessage);
    exit;
  end;

  if pMessage^ = '!' then
  begin
    negated := true;
    Inc(p);
  end;

  Dec(pMessage);

  Result := negated;

  while p^ <> ']' do
  begin
    if p^ = #0 then
    begin
      //LogWarningFMT('Unterminated [ in message: %s', [FInput[0]]);
      exit;
    end;

    p1 := p + 1; // sizeOf(PChar);
    p2 := p1 + 1; //sizeOf(PChar);

    if (p1^ = '-')
    and (p2^ <> #0) then
      if (Ord(pAddress^) >= Ord(p^))
      and (Ord(pAddress^) <= Ord(p2^)) then
      begin
        Result := not negated;
        break;
      end;

    if p^ = pAddress^ then
    begin
      Result := not negated;
      break;
    end;

    Inc(p);
  end;

  if Result = false then
    exit;

  while p^ <> ']' do
  begin
    if p^ = #0 then
    begin
      //LogWarningFMT('Unterminated [ in message: %s', [FInput[0]]);
      exit;
    end;

    Inc(p);
  end;

  Inc(p);
  pMessage := p;
  Inc(pAddress);
  Result := MatchPattern(p, pAddress);
end;

function TOSCPacket.MatchList(pMessage, pAddress: PChar): Boolean;
var
  p, tp: PChar;
begin
  Result := false;

  p := pMessage;
  tp := pAddress;

  while p^ <> '}' do
  begin
    if p^ = #0 then
    begin
      //LogWarningFMT('Unterminated { in message: %s', [FInput[0]]);
      exit;
    end;

    Inc(p);
  end;

 (*
 for(restOfPattern = pattern; *restOfPattern != '}'; restOfPattern++) {
  if (*restOfPattern == 0) {
    OSCWarning("Unterminated { in pattern \".../%s/...\"", theWholePattern);
    return FALSE;
  }
}   *)

  Inc(p); // skip close curly brace
  Inc(pMessage); // skip open curly brace

  while true do
  begin
    if pMessage^ = ',' then
    begin
      if MatchPattern(p, tp) then
      begin
        Result := true;
        pMessage := p;
        pAddress := tp;
        exit;
      end
      else
      begin
        tp := pAddress;
        Inc(pMessage);
      end;
    end
    else if pMessage^ = '}' then
    begin
      Result := MatchPattern(p, tp);
      pMessage := p;
      pAddress := tp;
      exit;
    end
    else if pMessage^ = tp^ then
    begin
      Inc(pMessage);
      Inc(tp);
    end
    else
    begin
      tp := pAddress;
      while (pMessage^ <> ',')
        and (pMessage^ <> '}') do
          Inc(pMessage);

      if pMessage^ = ',' then
        Inc(pMessage);
    end;
  end;
end;

function TOSCPacket.MatchPattern(pMessage, pAddress: PChar): Boolean;
begin
  if (pMessage = nil)
  or (pMessage^ = #0) then
  begin
    Result := pAddress^ = #0;
    exit;
  end;

  if pAddress^ = #0 then
  begin
    if pMessage^ = '*' then
    begin
      Result := MatchPattern(pMessage + 1, pAddress);
      exit;
    end
    else
    begin
      Result := false;
      exit;
    end;
  end;

  case pMessage^ of
  #0 : Result := pAddress^ = #0;
  '?': Result := MatchPattern(pMessage + 1, pAddress + 1);
  '*':
  begin
      if MatchPattern(pMessage + 1, pAddress) then
        Result := true
      else
        Result := MatchPattern(pMessage, pAddress + 1);
  end;
  ']','}':
  begin
    //LogWarningFMT('Spurious %s in message: %s', [pMessage^, FInput[0]]);
    Result := false;
  end;
  '[': Result := MatchBrackets(pMessage, pAddress);
  '{': Result := MatchList(pMessage, pAddress);
  {'\\':
  begin
    if pMessage^ + 1 = #0 then
      Result := pAddress^ = #0
    else if pMessage^ + 1 = pAddress^
      Result := MatchPattern(pMessage + 2, pAddress + 1)
    else
      Result := false;
  end;   }
  else
  if pMessage^ = pAddress^ then
    Result := MatchPattern(pMessage + 1,pAddress + 1)
  else
    Result := false;
  end;
end;

class function TOSCPacket.Unpack(Bytes: PByte; Count: Integer): TOSCPacket;
begin
  Result := UnPack(Bytes, 0, Count);
end;

class function TOSCPacket.Unpack(Bytes: PByte; Offset, Count: Integer; TimeTag:
    Extended = 0): TOSCPacket;
var
  tmp: PByte;
begin
  tmp := Bytes;
  Inc(tmp, Offset);

  if Char(tmp^) = '#' then
    Result := TOSCBundle.UnPack(Bytes, Offset, Count)
  else
    Result := TOSCMessage.UnPack(Bytes, Offset, Count, TimeTag);
end;

class function TOSCPacket.UnpackInt(Bytes: PByte; var Offset: Integer): Integer;
var
  i, value: Integer;
  tmp: PByte;
begin
  value := 0;
  tmp := Bytes;
  Inc(tmp, Offset);

  for i := 0 to 3 do
  begin
    value := value + tmp^ shl (i * 8);
    Inc(tmp);
  end;

  Inc(Offset, 4);
  Result := ntohl(value);
end;

class function TOSCPacket.UnpackFloat(Bytes: PByte; var Offset: Integer):
    Single;
var
  i, value: Integer;
  tmp: PByte;
begin
  value := 0;
  tmp := Bytes;
  Inc(tmp, Offset);

  for i := 0 to 3 do
  begin
    value := value + tmp^ shl (i * 8);
    Inc(tmp);
  end;

  Inc(Offset, 4);

  value := ntohl(value);
  Result := Single(Pointer(value));
end;

class function TOSCPacket.UnpackString(Bytes: PByte; var Offset: Integer):
    string;
var
  tmp: PByte;
  off: Integer;
begin
  tmp := Bytes;
  Inc(tmp, Offset);

  Result := PChar(tmp);
  off := Length(PChar(tmp));
  off := off + (4 - off mod 4);
  Inc(Offset, off)
end;

end.
