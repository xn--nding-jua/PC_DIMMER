unit BlockCiphers;

{
  Copyright (c) 1998-1999 Dave Shapiro, Professional Software, Inc.
  (daves@cfxc.com) Use and modify freely. Keep this header, please.

                    BlockCiphers class hierarchy:


                             TBlockCipher
                              (abstract)
                                  |
                                  |
                          T64BitBlockCipher
                              (abstract)
                                  |
                --------------------------------------
               |                                      |
             TDESCipher                         TBlowfishCipher


  How it works: TBlockCipher introduces functionality for transforming blocks
  of plaintext into blocks of ciphertext. Specifically, the abstract methods
  EncryptBlock and DecryptBlock are declared for descendants to fill out.
  EncryptStream and DecryptStream are methods completed by TBlockCipher for
  encrypting and decrypting TStreams.

  It's not typesafe: Making this stuff into a single hierarchy requires some
  unsafe typing. First, a block cipher can use any size block. DES and Blowfish
  use 64-bit blocks, but there are many ciphers that use 128-bit blocks. As
  such, EncryptBlock and DecryptBlock take an untyped parameter, and it is left
  to the user of the class to ensure that they're passing the right size block.

  If the user is not sure what the block size is, they should call the virtual
  class method BlockSize.

  There is a similar type-safety problem with the constructor. Some ciphers
  take a 64-bit value as their key. Some take a range in length. At any rate,
  I thought it would be important (or at least cool) to have a virtual
  constructor in this hierarchy. Again, this means sacrificing type safety. In
  the constructor, you pass the key as an untyped const, and the length of
  the key in bytes. The class trusts that the user is sending consistent
  information. TBlockCipher introduces two virtual class methods, MinKeyLength
  and MaxKeyLength for querying key-length information.

  You may be interested in ensuring that this code is correct. There are many
  test vector suites out there. I've tested all ciphers against a lot of stuff;
  it's all correct. If you do choose to verify this stuff on your own, you
  should be aware of endian problems. Intels are little-endian machines, and
  most other stuff is big-endian. Most test suites assume a big-endian
  architecture. At any rate, you can spend all afternoon swapping bytes, trying
  to get things so they agree exactly with others' results. I've done it. It's
  not fun. (Take a peek at the stuff in the '$DEFINE UseTestVectors' part, in
  the Main unit.) The end results are that these ciphers agree with 'official'
  results up to byte-ordering. (Remember that byte-ordering issues occur at
  all points of the encryption, so don't expect to just swap the resulting
  ciphertext bytes and get exactly what the 'official' test vectors say.)
  Chances are, these ciphers aren't compatible across machines, or even with
  other implementations, without some tweaking, which causes a slight
  performance degredation.
}

(*$J-*)

(*$IFDEF VER80*)
  (*$DEFINE PreDelphi4*)
  (*$DEFINE PreDelphi3*)
(*$ENDIF*)
(*$IFDEF VER90*)
  (*$DEFINE PreDelphi4*)
  (*$DEFINE PreDelphi3*)
(*$ENDIF*)
(*$IFDEF VER100*)
  (*$DEFINE PreDelphi4*)
(*$ENDIF*)

interface

uses SysUtils, Classes;

type
  PDWORD = ^DWORD;
  DWORD = (*$IFDEF PreDelphi4*) Longint (*$ELSE*) Longword (*$ENDIF*) ;
  (*$IFDEF PreDelphi4*)
    PInt64 = ^Int64;
    Int64 = Comp;
  (*$ENDIF*)
  TDoubleDWORD = packed record
    L, R: DWORD;
  end;
  TFourByte = packed record
    B1, B2, B3, B4: Byte;
  end;  

  TBlockCipher = class(TObject)
  private
  public
    constructor Create(const Key; const Length: Integer); virtual;
    class function CiphertextLength(const PlaintextLength: Longint): Longint;
                   virtual;
    procedure EncryptStream(const Plaintext, Ciphertext: TStream); virtual;
    procedure DecryptStream(const Ciphertext, Plaintext: TStream); virtual;
    procedure EncryptBlock(var Plaintext); virtual; abstract;
    procedure DecryptBlock(var Ciphertext); virtual; abstract;
    class function MinKeyLength: Integer; virtual; abstract;
    class function MaxKeyLength: Integer; virtual;
    class function BlockSize: Integer; virtual; abstract;
  end;

  TBlockCipherClass = class of TBlockCipher;

  T64BitBlockCipher = class(TBlockCipher)
  public
    function EncryptedBlock(const Plaintext: Int64): Int64; virtual; abstract;
    function DecryptedBlock(const Ciphertext: Int64): Int64; virtual; abstract;
    function EncryptedString(const Plaintext: string): string; virtual;
    function DecryptedString(const Ciphertext: string): string; virtual;
    class function BlockSize: Integer; override;
  end;

  T64BitBlockCipherClass = class of T64BitBlockCipher;

  {
   TDESCipher: Implements the Data Encryption Standard block cipher.

   Current performance figures, for a Pentium II, 400 MHz, 128 MB SDRAM:
   4.2 megabytes/sec encryption/decryption rate.

   Many, many thanks to Bob Lee for lots of help optimizing this thing.
  }

  TDESKeyScheduleRange = 0..15;
  TSixBitArray = array [0..7] of DWORD;
  TDESKeySchedule = array [TDESKeyScheduleRange] of TSixBitArray;

  TDESCipher = class(T64BitBlockCipher)
  private
    FKeySchedule: TDESKeySchedule;
    procedure CreateKeySchedule(const Key: Int64);
  protected
  public
    constructor Create(const Key; const Length: Integer); override;
    destructor Destroy; override;
    procedure EncryptBlock(var Plaintext); override;
    procedure DecryptBlock(var Ciphertext); override;
    function EncryptedBlock(const Plaintext: Int64): Int64; override;
    function DecryptedBlock(const Ciphertext: Int64): Int64; override;
    class function MinKeyLength: Integer; override;
  end;

  {
   TDESCipher: Implements Bruce Schneier's Blowfish block cipher.

   Current performance figures, for a Pentium II, 400 MHz, 128 MB SDRAM:
   6.5 megabytes/sec encryption/decryption rate.
  }

  TBlowfishSBox = array [Byte] of DWORD;
  TBlowfishPArray = array [0..17] of DWORD;

  TBlowfishCipher = class(T64BitBlockCipher)
  private
    FSBox1, FSBox2, FSBox3, FSBox4: TBlowfishSBox;
    FPArray: TBlowfishPArray;
    procedure GenerateSubkeys(const Key; const Length: Integer);
  public
    constructor Create(const Key; const Length: Integer); override;
    destructor Destroy; override;
    procedure EncryptBlock(var Plaintext); override;
    procedure DecryptBlock(var Ciphertext); override;
    function EncryptedBlock(const Plaintext: Int64): Int64; override;
    function DecryptedBlock(const Ciphertext: Int64): Int64; override;
    class function MinKeyLength: Integer; override;
    class function MaxKeyLength: Integer; override;
  end;

{
procedure SwapInt64(var N: Int64);
procedure ReverseInt64(var N: Int64);
}

implementation

{
procedure ReverseInt64(var N: Int64);
var
  A: array [1..8] of Byte absolute N;
  T: Byte;
begin
  T := A[1]; A[1] := A[8]; A[8] := T;
  T := A[2]; A[2] := A[7]; A[7] := T;
  T := A[3]; A[3] := A[6]; A[6] := T;
  T := A[4]; A[4] := A[5]; A[5] := T;
end;

procedure SwapInt64(var N: Int64);
var
  D: TDoubleDWORD absolute N;
  T: DWORD;
begin
  T := D.L;
  D.L := D.R;
  D.R := T;
end;
}


//------------------------------- TBlockCipher ---------------------------------


constructor TBlockCipher.Create(const Key; const Length: Integer);
begin
  inherited Create;
  if Length < MinKeyLength then begin
    raise Exception.CreateFmt('Key must be at least %d bytes long.',
                              [MinKeyLength]);
  end;
end;

const
  BlocksPerBuf = 512;

procedure TBlockCipher.EncryptStream(const Plaintext, Ciphertext: TStream);
var
  Count: Longint;
  ThisBlockSize, BufSize, I, N: Integer;
  Buf: Pointer;
  P: ^Byte;
  LastBuf: Boolean;
begin
  P := nil; // Suppresses superfluous compiler warning.
  Count := 0; // Ditto.
  ThisBlockSize := BlockSize;
  BufSize := ThisBlockSize * BlocksPerBuf;
  GetMem(Buf, BufSize);
  while True do begin
    Count := Plaintext.Read(Buf^, BufSize);
    P := Buf;
    LastBuf := Count < BufSize;
    if LastBuf then N := Count div ThisBlockSize else N := BlocksPerBuf;
    for I := 1 to N do begin
      EncryptBlock(P^);
      Inc(P, ThisBlockSize);
    end;
    if LastBuf then Break;
    Ciphertext.Write(Buf^, Count);
  end;
  // We're at the end of the data in a not-completely-full-buffer (or, in the
  // case of Plaintext.Size mod BufSize = 0, at the beginning of an empty
  // buffer, which is just a special case of the former). Now we use the last
  // byte of the current block to give the number of extra padding bytes.
  // This will be a number from 1..ThisBlockSize. Specifically, if the
  // Plaintext length is an exact multiple of ThisBlockSize, the number of
  // extra padding bytes will be ThisBlockSize, i.e. the entire final block
  // is junk. In any other case, the last block has at least some ciphertext.
  Inc(P, ThisBlockSize - 1);
  P^ := Byte(ThisBlockSize - Count mod ThisBlockSize);
  Inc(Count, P^);
  Dec(P, ThisBlockSize - 1);
  EncryptBlock(P^);
  Ciphertext.Write(Buf^, Count);
  FreeMem(Buf);
end;

procedure TBlockCipher.DecryptStream(const Ciphertext, Plaintext: TStream);
var
  Count: Longint;
  ThisBlockSize, BufSize, I, J: Integer;
  Buf: Pointer;
  P: ^Byte;
begin
  ThisBlockSize := BlockSize;
  Count := Ciphertext.Size - Ciphertext.Position;
  if (Count = 0) or (Count mod ThisBlockSize <> 0) then
  begin
    raise Exception.CreateFmt('Ciphertext length is not a multiple of %d.',
                              [ThisBlockSize]);
  end;
  BufSize := ThisBlockSize * BlocksPerBuf;
  GetMem(Buf, BufSize);
  for I := 1 to Count div BufSize do begin
    Ciphertext.Read(Buf^, BufSize);
    P := Buf;
    for J := 1 to BlocksPerBuf do begin
      DecryptBlock(P^);
      Inc(P, ThisBlockSize);
    end;
    Plaintext.Write(Buf^, BufSize);
  end;
  Count := Count mod BufSize;
  Ciphertext.Read(Buf^, Count);
  P := Buf;
  for J := 1 to Count div ThisBlockSize do begin
    DecryptBlock(P^);
    Inc(P, ThisBlockSize);
  end;
  Dec(P);
  Plaintext.Write(Buf^, Count - P^);
  FreeMem(Buf);
end;

class function TBlockCipher.CiphertextLength(const PlaintextLength: Longint):
                                            Longint;
begin
  Result := Succ(PlaintextLength div BlockSize) * BlockSize;
end;

class function TBlockCipher.MaxKeyLength: Integer;
begin
  Result := MinKeyLength;
end;


//---------------------------- T64BitBlockCipher -------------------------------


function T64BitBlockCipher.EncryptedString(const Plaintext: string): string;
var
  PS, PD: PInt64;
  Source: Int64;
  I: Integer;
  NumBlocks: Longint;
  NumPadBytes: Byte;
begin
  NumBlocks := Length(Plaintext) div SizeOf(Int64);
  NumPadBytes := SizeOf(Int64) - Length(Plaintext) mod SizeOf(Int64);
  SetLength(Result, Succ(NumBlocks) * SizeOf(Int64));
  PS := Pointer(Plaintext);
  PD := Pointer(Result);
  for I := 1 to NumBlocks do begin
    PD^ := EncryptedBlock(PS^);
    Inc(PS);
    Inc(PD);
  end;
  {
   Fill in the number of padding bytes. Just write the whole block, and then
   overwrite the beginning bytes with Source.
  }
  FillChar(Source, SizeOf(Source), NumPadBytes);
  {
   What if PS points to the end of the string? Won't dereferencing it cause
   a memory problem? Not really. For one, the string will always have a
   trailing null, so there's always one byte, which avoids an AV. Also,
   since PS^ is passed as an untyped var, the compiler will just pass the
   address without dereferencing.
  }
  Move(PS^, Source, SizeOf(Int64) - NumPadBytes);
  PD^ := EncryptedBlock(Source);
end;

function T64BitBlockCipher.DecryptedString(const Ciphertext: string): string;
var
  Dest: Int64;
  PS, PD: PInt64;
  I: Integer;
  NumCiphertextBytes: Longint;
  NumPadBytes: Byte;
begin
  NumCiphertextBytes := Length(Ciphertext);
  if (NumCiphertextBytes = 0) or
     (NumCiphertextBytes mod SizeOf(Int64) <> 0) then
  begin
    raise Exception.CreateFmt('Ciphertext is not a multiple of %d bytes.',
                              [SizeOf(Int64)]);
  end;
  { Decrypt last block first. This tells us how many padding bytes there are. }
  PS := Pointer(Ciphertext);
  Inc(PS, Pred(NumCiphertextBytes div SizeOf(Int64)));
  Dest := DecryptedBlock(PS^);
  NumPadBytes := TFourByte(TDoubleDWORD(Dest).R).B4;
  SetLength(Result, NumCiphertextBytes - NumPadBytes);
  { From the last block, move only the non-padding bytes to the end of Result. }
  Move(Dest, Result[NumCiphertextBytes - SizeOf(Int64) + 1],
       SizeOf(Int64) - NumPadBytes);
  PS := Pointer(Ciphertext);
  PD := Pointer(Result);
  for I := 1 to Length(Result) div SizeOf(Int64) do begin
    PD^ := DecryptedBlock(PS^);
    Inc(PS);
    Inc(PD);
  end;
end;

class function T64BitBlockCipher.BlockSize: Integer;
begin
  Result := SizeOf(Int64);
end;


//-------------------------------- TDESCipher ----------------------------------


const
  LowSixBits = $3f;
  LowTwoBits = $03;

function CircularSHL28(const X: DWORD; const Amount: Byte): DWORD;
{
  Pre: Amount < BitsInX.
  Post: Result is an unsigned circular left shift of X by Amount bytes.
}
const
  BitLength = 28;
  { The high nibble needs to be cleared. }
  Mask = not (Pred(1 shl (SizeOf(X) - BitLength)) shl BitLength);
begin
  Result := X shl Amount and Mask or X shr (BitLength - Amount);
end;

type
  TPBox = array [Byte] of DWORD;

const
  PBox1: TPBox = (
    $00000000, $00004000, $40000000, $40004000, $00000010, $00004010,
    $40000010, $40004010, $00080000, $00084000, $40080000, $40084000,
    $00080010, $00084010, $40080010, $40084010, $00000002, $00004002,
    $40000002, $40004002, $00000012, $00004012, $40000012, $40004012,
    $00080002, $00084002, $40080002, $40084002, $00080012, $00084012,
    $40080012, $40084012, $00000200, $00004200, $40000200, $40004200,
    $00000210, $00004210, $40000210, $40004210, $00080200, $00084200,
    $40080200, $40084200, $00080210, $00084210, $40080210, $40084210,
    $00000202, $00004202, $40000202, $40004202, $00000212, $00004212,
    $40000212, $40004212, $00080202, $00084202, $40080202, $40084202,
    $00080212, $00084212, $40080212, $40084212, $00008000, $0000C000,
    $40008000, $4000C000, $00008010, $0000C010, $40008010, $4000C010,
    $00088000, $0008C000, $40088000, $4008C000, $00088010, $0008C010,
    $40088010, $4008C010, $00008002, $0000C002, $40008002, $4000C002,
    $00008012, $0000C012, $40008012, $4000C012, $00088002, $0008C002,
    $40088002, $4008C002, $00088012, $0008C012, $40088012, $4008C012,
    $00008200, $0000C200, $40008200, $4000C200, $00008210, $0000C210,
    $40008210, $4000C210, $00088200, $0008C200, $40088200, $4008C200,
    $00088210, $0008C210, $40088210, $4008C210, $00008202, $0000C202,
    $40008202, $4000C202, $00008212, $0000C212, $40008212, $4000C212,
    $00088202, $0008C202, $40088202, $4008C202, $00088212, $0008C212,
    $40088212, $4008C212, $00800000, $00804000, $40800000, $40804000,
    $00800010, $00804010, $40800010, $40804010, $00880000, $00884000,
    $40880000, $40884000, $00880010, $00884010, $40880010, $40884010,
    $00800002, $00804002, $40800002, $40804002, $00800012, $00804012,
    $40800012, $40804012, $00880002, $00884002, $40880002, $40884002,
    $00880012, $00884012, $40880012, $40884012, $00800200, $00804200,
    $40800200, $40804200, $00800210, $00804210, $40800210, $40804210,
    $00880200, $00884200, $40880200, $40884200, $00880210, $00884210,
    $40880210, $40884210, $00800202, $00804202, $40800202, $40804202,
    $00800212, $00804212, $40800212, $40804212, $00880202, $00884202,
    $40880202, $40884202, $00880212, $00884212, $40880212, $40884212,
    $00808000, $0080C000, $40808000, $4080C000, $00808010, $0080C010,
    $40808010, $4080C010, $00888000, $0088C000, $40888000, $4088C000,
    $00888010, $0088C010, $40888010, $4088C010, $00808002, $0080C002,
    $40808002, $4080C002, $00808012, $0080C012, $40808012, $4080C012,
    $00888002, $0088C002, $40888002, $4088C002, $00888012, $0088C012,
    $40888012, $4088C012, $00808200, $0080C200, $40808200, $4080C200,
    $00808210, $0080C210, $40808210, $4080C210, $00888200, $0088C200,
    $40888200, $4088C200, $00888210, $0088C210, $40888210, $4088C210,
    $00808202, $0080C202, $40808202, $4080C202, $00808212, $0080C212,
    $40808212, $4080C212, $00888202, $0088C202, $40888202, $4088C202,
    $00888212, $0088C212, $40888212, $4088C212
  );

  PBox2: TPBox = (
   $00000000, $80000000, $00400000, $80400000, $00001000, $80001000, $00401000, $80401000,
   $00000040, $80000040, $00400040, $80400040, $00001040, $80001040, $00401040, $80401040,
   $04000000, $84000000, $04400000, $84400000, $04001000, $84001000, $04401000, $84401000,
   $04000040, $84000040, $04400040, $84400040, $04001040, $84001040, $04401040, $84401040,
   $00000004, $80000004, $00400004, $80400004, $00001004, $80001004, $00401004, $80401004,
   $00000044, $80000044, $00400044, $80400044, $00001044, $80001044, $00401044, $80401044,
   $04000004, $84000004, $04400004, $84400004, $04001004, $84001004, $04401004, $84401004,
   $04000044, $84000044, $04400044, $84400044, $04001044, $84001044, $04401044, $84401044,
   $00010000, $80010000, $00410000, $80410000, $00011000, $80011000, $00411000, $80411000,
   $00010040, $80010040, $00410040, $80410040, $00011040, $80011040, $00411040, $80411040,
   $04010000, $84010000, $04410000, $84410000, $04011000, $84011000, $04411000, $84411000,
   $04010040, $84010040, $04410040, $84410040, $04011040, $84011040, $04411040, $84411040,
   $00010004, $80010004, $00410004, $80410004, $00011004, $80011004, $00411004, $80411004,
   $00010044, $80010044, $00410044, $80410044, $00011044, $80011044, $00411044, $80411044,
   $04010004, $84010004, $04410004, $84410004, $04011004, $84011004, $04411004, $84411004,
   $04010044, $84010044, $04410044, $84410044, $04011044, $84011044, $04411044, $84411044,
   $00000100, $80000100, $00400100, $80400100, $00001100, $80001100, $00401100, $80401100,
   $00000140, $80000140, $00400140, $80400140, $00001140, $80001140, $00401140, $80401140,
   $04000100, $84000100, $04400100, $84400100, $04001100, $84001100, $04401100, $84401100,
   $04000140, $84000140, $04400140, $84400140, $04001140, $84001140, $04401140, $84401140,
   $00000104, $80000104, $00400104, $80400104, $00001104, $80001104, $00401104, $80401104,
   $00000144, $80000144, $00400144, $80400144, $00001144, $80001144, $00401144, $80401144,
   $04000104, $84000104, $04400104, $84400104, $04001104, $84001104, $04401104, $84401104,
   $04000144, $84000144, $04400144, $84400144, $04001144, $84001144, $04401144, $84401144,
   $00010100, $80010100, $00410100, $80410100, $00011100, $80011100, $00411100, $80411100,
   $00010140, $80010140, $00410140, $80410140, $00011140, $80011140, $00411140, $80411140,
   $04010100, $84010100, $04410100, $84410100, $04011100, $84011100, $04411100, $84411100,
   $04010140, $84010140, $04410140, $84410140, $04011140, $84011140, $04411140, $84411140,
   $00010104, $80010104, $00410104, $80410104, $00011104, $80011104, $00411104, $80411104,
   $00010144, $80010144, $00410144, $80410144, $00011144, $80011144, $00411144, $80411144,
   $04010104, $84010104, $04410104, $84410104, $04011104, $84011104, $04411104, $84411104,
   $04010144, $84010144, $04410144, $84410144, $04011144, $84011144, $04411144, $84411144
  );

  PBox3: TPBox = (
   $00000000, $00002000, $00200000, $00202000, $00000008, $00002008, $00200008, $00202008,
   $10000000, $10002000, $10200000, $10202000, $10000008, $10002008, $10200008, $10202008,
   $20000000, $20002000, $20200000, $20202000, $20000008, $20002008, $20200008, $20202008,
   $30000000, $30002000, $30200000, $30202000, $30000008, $30002008, $30200008, $30202008,
   $00000080, $00002080, $00200080, $00202080, $00000088, $00002088, $00200088, $00202088,
   $10000080, $10002080, $10200080, $10202080, $10000088, $10002088, $10200088, $10202088,
   $20000080, $20002080, $20200080, $20202080, $20000088, $20002088, $20200088, $20202088,
   $30000080, $30002080, $30200080, $30202080, $30000088, $30002088, $30200088, $30202088,
   $00040000, $00042000, $00240000, $00242000, $00040008, $00042008, $00240008, $00242008,
   $10040000, $10042000, $10240000, $10242000, $10040008, $10042008, $10240008, $10242008,
   $20040000, $20042000, $20240000, $20242000, $20040008, $20042008, $20240008, $20242008,
   $30040000, $30042000, $30240000, $30242000, $30040008, $30042008, $30240008, $30242008,
   $00040080, $00042080, $00240080, $00242080, $00040088, $00042088, $00240088, $00242088,
   $10040080, $10042080, $10240080, $10242080, $10040088, $10042088, $10240088, $10242088,
   $20040080, $20042080, $20240080, $20242080, $20040088, $20042088, $20240088, $20242088,
   $30040080, $30042080, $30240080, $30242080, $30040088, $30042088, $30240088, $30242088,
   $01000000, $01002000, $01200000, $01202000, $01000008, $01002008, $01200008, $01202008,
   $11000000, $11002000, $11200000, $11202000, $11000008, $11002008, $11200008, $11202008,
   $21000000, $21002000, $21200000, $21202000, $21000008, $21002008, $21200008, $21202008,
   $31000000, $31002000, $31200000, $31202000, $31000008, $31002008, $31200008, $31202008,
   $01000080, $01002080, $01200080, $01202080, $01000088, $01002088, $01200088, $01202088,
   $11000080, $11002080, $11200080, $11202080, $11000088, $11002088, $11200088, $11202088,
   $21000080, $21002080, $21200080, $21202080, $21000088, $21002088, $21200088, $21202088,
   $31000080, $31002080, $31200080, $31202080, $31000088, $31002088, $31200088, $31202088,
   $01040000, $01042000, $01240000, $01242000, $01040008, $01042008, $01240008, $01242008,
   $11040000, $11042000, $11240000, $11242000, $11040008, $11042008, $11240008, $11242008,
   $21040000, $21042000, $21240000, $21242000, $21040008, $21042008, $21240008, $21242008,
   $31040000, $31042000, $31240000, $31242000, $31040008, $31042008, $31240008, $31242008,
   $01040080, $01042080, $01240080, $01242080, $01040088, $01042088, $01240088, $01242088,
   $11040080, $11042080, $11240080, $11242080, $11040088, $11042088, $11240088, $11242088,
   $21040080, $21042080, $21240080, $21242080, $21040088, $21042088, $21240088, $21242088,
   $31040080, $31042080, $31240080, $31242080, $31040088, $31042088, $31240088, $31242088
  );

  PBox4: TPBox = (
   $00000000, $00000800, $00020000, $00020800, $00000020, $00000820, $00020020, $00020820,
   $08000000, $08000800, $08020000, $08020800, $08000020, $08000820, $08020020, $08020820,
   $02000000, $02000800, $02020000, $02020800, $02000020, $02000820, $02020020, $02020820,
   $0A000000, $0A000800, $0A020000, $0A020800, $0A000020, $0A000820, $0A020020, $0A020820,
   $00000400, $00000C00, $00020400, $00020C00, $00000420, $00000C20, $00020420, $00020C20,
   $08000400, $08000C00, $08020400, $08020C00, $08000420, $08000C20, $08020420, $08020C20,
   $02000400, $02000C00, $02020400, $02020C00, $02000420, $02000C20, $02020420, $02020C20,
   $0A000400, $0A000C00, $0A020400, $0A020C00, $0A000420, $0A000C20, $0A020420, $0A020C20,
   $00100000, $00100800, $00120000, $00120800, $00100020, $00100820, $00120020, $00120820,
   $08100000, $08100800, $08120000, $08120800, $08100020, $08100820, $08120020, $08120820,
   $02100000, $02100800, $02120000, $02120800, $02100020, $02100820, $02120020, $02120820,
   $0A100000, $0A100800, $0A120000, $0A120800, $0A100020, $0A100820, $0A120020, $0A120820,
   $00100400, $00100C00, $00120400, $00120C00, $00100420, $00100C20, $00120420, $00120C20,
   $08100400, $08100C00, $08120400, $08120C00, $08100420, $08100C20, $08120420, $08120C20,
   $02100400, $02100C00, $02120400, $02120C00, $02100420, $02100C20, $02120420, $02120C20,
   $0A100400, $0A100C00, $0A120400, $0A120C00, $0A100420, $0A100C20, $0A120420, $0A120C20,
   $00000001, $00000801, $00020001, $00020801, $00000021, $00000821, $00020021, $00020821,
   $08000001, $08000801, $08020001, $08020801, $08000021, $08000821, $08020021, $08020821,
   $02000001, $02000801, $02020001, $02020801, $02000021, $02000821, $02020021, $02020821,
   $0A000001, $0A000801, $0A020001, $0A020801, $0A000021, $0A000821, $0A020021, $0A020821,
   $00000401, $00000C01, $00020401, $00020C01, $00000421, $00000C21, $00020421, $00020C21,
   $08000401, $08000C01, $08020401, $08020C01, $08000421, $08000C21, $08020421, $08020C21,
   $02000401, $02000C01, $02020401, $02020C01, $02000421, $02000C21, $02020421, $02020C21,
   $0A000401, $0A000C01, $0A020401, $0A020C01, $0A000421, $0A000C21, $0A020421, $0A020C21,
   $00100001, $00100801, $00120001, $00120801, $00100021, $00100821, $00120021, $00120821,
   $08100001, $08100801, $08120001, $08120801, $08100021, $08100821, $08120021, $08120821,
   $02100001, $02100801, $02120001, $02120801, $02100021, $02100821, $02120021, $02120821,
   $0A100001, $0A100801, $0A120001, $0A120801, $0A100021, $0A100821, $0A120021, $0A120821,
   $00100401, $00100C01, $00120401, $00120C01, $00100421, $00100C21, $00120421, $00120C21,
   $08100401, $08100C01, $08120401, $08120C01, $08100421, $08100C21, $08120421, $08120C21,
   $02100401, $02100C01, $02120401, $02120C01, $02100421, $02100C21, $02120421, $02120C21,
   $0A100401, $0A100C01, $0A120401, $0A120C01, $0A100421, $0A100C21, $0A120421, $0A120C21
  );
  
type
  TSBox = array [0..63] of Integer;

const
  SBox1: TSBox = (
    224,   0,  64, 240, 208, 112,  16,  64,  32, 224, 240,  32, 176, 208, 128,  16,
     48, 160, 160,  96,  96, 192, 192, 176,  80, 144, 144,  80,   0,  48, 112, 128,
     64, 240,  16, 192, 224, 128, 128,  32, 208,  64,  96, 144,  32,  16, 176, 112,
    240,  80, 192, 176, 144,  48, 112, 224,  48, 160, 160,   0,  80,  96,   0, 208
  );

  SBox2: TSBox = (
    15,  3,  1, 13,  8,  4, 14,  7,  6, 15, 11,  2,  3,  8,  4, 14,
     9, 12,  7,  0,  2,  1, 13, 10, 12,  6,  0,  9,  5, 11, 10,  5,
     0, 13, 14,  8,  7, 10, 11,  1, 10,  3,  4, 15, 13,  4,  1,  2,
     5, 11,  8,  6, 12,  7,  6, 12,  9,  0,  3,  5,  2, 14, 15,  9
  );

  SBox3: TSBox = (
    160, 208,   0, 112, 144,   0, 224, 144,  96,  48,  48,  64,  240,  96,  80, 160,
     16,  32, 208, 128, 192,  80, 112, 224, 176, 192,  64, 176,   32, 240, 128,  16,
    208,  16,  96, 160,  64, 208, 144,   0, 128,  96, 240, 144,   48, 128,   0, 112,
    176,  64,  16, 240,  32, 224, 192,  48,  80, 176, 160,  80, 224,   32, 112, 192
  );

  SBox4: TSBox = (
     7, 13, 13,  8, 14, 11,  3,  5,  0,  6,  6, 15,  9,  0, 10,  3,
     1,  4,  2,  7,  8,  2,  5, 12, 11,  1, 12, 10,  4, 14, 15,  9,
    10,  3,  6, 15,  9,  0,  0,  6, 12, 10, 11,  1,  7, 13, 13,  8,
    15,  9,  1,  4,  3,  5, 14, 11,  5, 12,  2,  7,  8,  2,  4, 14
  );

  SBox5: TSBox = (
     32, 224, 192, 176,  64,  32,  16, 192, 112,  64, 160, 112, 176, 208,  96,  16,
    128,  80,  80,   0,  48, 240, 240, 160, 208,  48,   0, 144, 224, 128, 144,  96,
     64, 176,  32, 128,  16, 192, 176, 112, 160,  16, 208, 224, 112,  32, 128, 208,
    240,  96, 144, 240, 192,   0,  80, 144,  96, 160,  48,  64,   0,  80, 224,  48
  );

  SBox6: TSBox = (
    12, 10,  1, 15, 10,  4, 15,  2,  9,  7,  2, 12,  6,  9,  8,  5,
     0,  6, 13,  1,  3, 13,  4, 14, 14,  0,  7, 11,  5,  3, 11,  8,
     9,  4, 14,  3, 15,  2,  5, 12,  2,  9,  8,  5, 12, 15,  3, 10,
     7, 11,  0, 14,  4,  1, 10,  7,  1,  6, 13,  0, 11,  8,  6, 13
  );

  SBox7: TSBox = (
     64, 208, 176,   0,  32, 176, 224, 112, 240,  64,   0, 144, 128,  16, 208, 160,
     48, 224, 192,  48, 144,  80, 112, 192,  80,  32, 160, 240,  96, 128,  16,  96,
     16,  96,  64, 176, 176, 208, 208, 128, 192,  16,  48,  64, 112, 160, 224, 112,
    160, 144, 240,  80,  96,   0, 128, 240,   0, 224,  80,  32, 144,  48,  32, 192
  );

  SBox8: TSBox = (
    13,  1,  2, 15,  8, 13,  4,  8,  6, 10, 15,  3, 11,  7,  1,  4,
    10, 12,  9,  5,  3,  6, 14, 11,  5,  0,  0, 14, 12,  9,  7,  2,
     7,  2, 11,  1,  4, 14,  1,  7,  9,  4, 12, 10, 14,  8,  2, 13,
     0, 15,  6, 12, 10,  9, 13,  0, 15,  3,  3,  5,  5,  6,  8, 11
  );

function ExpandedSubstitutedAndPermutedDWORD(const D: DWORD;
                                             const K: TSixBitArray): DWORD;
var
  X, Y: DWORD;
begin
  { First row takes bits 32, and bits 1 - 5. }
  X := K[0] xor (D shl 5 and $20 or D shr 27 and $1F);
  { Next row takes bits 4 - 9. }
  Y := K[1] xor D shr 23 and LowSixBits;
  Result := PBox1(.SBox1[X] or SBox2[Y].);

  { Next row takes bits 8 - 13. }
  X := K[2] xor D shr 19 and LowSixBits;
  { Next row takes bits 12 - 17. }
  Y := K[3] xor D shr 15 and LowSixBits;
  Result := Result or PBox2(.SBox3[X] or SBox4[Y].);

  { Next row takes bits 16 - 21. }
  X := K[4] xor D shr 11 and LowSixBits;
  { Bits 20 - 25. }
  Y := K[5] xor D shr 7 and LowSixBits;
  Result := Result or PBox3(.SBox5[X] or SBox6[Y].);

  { Bits 24 - 29. }
  X := K[6] xor D shr 3 and LowSixBits;
  {              Bits 28 - 32,        bit 1. }
  Y := K[7] xor (D shl 1 and $3e or D shr 31 and $3f);
  Result := Result or PBox4(.SBox7[X] or SBox8[Y].);
end;

function BitSelection(const Block: Int64; const A; const ASize: Integer): DWORD;
var
  I: Integer;
  ShiftAmount: Integer;
  H, L: DWORD;
  PA: ^Integer;
begin
  Result := 0;
  PA := Addr(A);
  H := TDoubleDWORD(Block).R;
  L := TDoubleDWORD(Block).L;
  for I := Pred(ASize) downto 0 do begin
    ShiftAmount := PA^;
    if ShiftAmount > 31 then
      Result := Result or H shr (ShiftAmount - 32) and 1 shl I
    else begin
      Result := Result or L shr ShiftAmount and 1 shl I;
    end;
    Inc(PA);
  end;
end;

function PC2(const C, D: DWORD): Int64;
const
  MapL: array [0..31] of Byte = (
   24, 27, 20,  6, 14, 10,  3, 22,
    0, 17,  7, 12,  8, 23, 11,  5,
   16, 26,  1,  9, 19, 25,  4, 15,
   26, 15,  8,  1, 21, 12, 20,  2
  );
  MapH: array [0..15] of Byte = (
   24, 16,  9,  5, 18,  7, 22, 13,
    0, 25, 23, 27,  4, 17, 11, 14
  );
var
  I: Integer;
  ResultHL: TDoubleDWORD absolute Result;
begin
  {
   C and D are 28-bit halves. Thus if bit needed is more than 28, we
   need to go to the high DWORD, namely C. Fortunately, all bits
   greater than 28 occur between Map[1] and Map[24] inclusive, so we can
   optimize this by breaking up the loops.
  }
  Result := 0;
  { First fill in the high 16 bits, which are the low 16 bits of KeyHL.H. }
  for I := High(MapH) downto Low(MapH) do begin
    ResultHL.R := ResultHL.R or C shr MapH[I] and 1 shl I;
  end;
  { Now fill in the next 8 bits, which are the high 8 bits of KeyHL.L. }
  for I := High(MapL) downto High(MapL) - 7 do begin
    ResultHL.L := ResultHL.L or C shr MapL[I] and 1 shl I;
  end;
  { Finally fill in the low 24 bits, which are the low 24 bits of KeyHL.L. }
  for I := High(MapL) - 8 downto Low(MapL) do begin
    ResultHL.L := ResultHL.L or D shr MapL[I] and 1 shl I;
  end;
end;


constructor TDESCipher.Create(const Key; const Length: Integer);
begin
  inherited;
  CreateKeySchedule(Int64(Key));
end;

destructor TDESCipher.Destroy;
begin
  inherited;
end;

procedure TDESCipher.CreateKeySchedule(const Key: Int64);
type
  THalfArray = array [0..27] of Integer;
const
  V: array [TDESKeyScheduleRange] of Byte = (
    1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1
  );
  PC1C: THalfArray = (
     7, 15, 23, 31, 39, 47, 55,
    63,  6, 14, 22, 30, 38, 46,
    54, 62,  5, 13, 21, 29, 37,
    45, 53, 61,  4, 12, 20, 28
  );
  PC1D: THalfArray = (
     1,  9, 17, 25, 33, 41, 49,
    57,  2, 10, 18, 26, 34, 42,
    50, 58,  3, 11, 19, 27, 35,
    43, 51, 59, 36, 44, 52, 60
  );
var
  C, D: DWORD;
  I, J: Integer;
  {
   I could just use a TDoubleDWORD, but doing this caused an internal error
   C3677 in D2. Using an absolute, ironically, caused this to go away.
   (Normally absolutes create tons of internal errors.)
  }
  K1: Int64;
  K: TDoubleDWORD absolute K1;
begin
  C := BitSelection(Key, PC1C, High(PC1C) - Low(PC1C) + 1);
  D := BitSelection(Key, PC1D, High(PC1D) - Low(PC1D) + 1);
  J := High(V);
  for I := Low(V) to High(V) do begin
    C := CircularSHL28(C, V[I]);
    D := CircularSHL28(D, V[I]);
    { Select 48 bits from the concatenation of C and D. (C is the high DWORD.) }
    K1 := PC2(C, D);
    { Pre-calc the six-bit chunks and store them. }
    FKeySchedule[J][0] := K.R shr 10 and LowSixBits;
    FKeySchedule[J][1] := K.R shr  4 and LowSixBits;
    FKeySchedule[J][2] := K.R shl  2 and LowSixBits or
                          K.L shr 30 and LowTwoBits;
    FKeySchedule[J][3] := K.L shr 24 and LowSixBits;
    FKeySchedule[J][4] := K.L shr 18 and LowSixBits;
    FKeySchedule[J][5] := K.L shr 12 and LowSixBits;
    FKeySchedule[J][6] := K.L shr  6 and LowSixBits;
    FKeySchedule[J][7] := K.L        and LowSixBits;
    Dec(J);
  end;
end;

type
  TInitialPermutation = array [Byte] of DWORD;
const
  IP: TInitialPermutation = (
   $00000000, $00000080, $00000008, $00000088, $00008000, $00008080, $00008008, $00008088,
   $00000800, $00000880, $00000808, $00000888, $00008800, $00008880, $00008808, $00008888,
   $00800000, $00800080, $00800008, $00800088, $00808000, $00808080, $00808008, $00808088,
   $00800800, $00800880, $00800808, $00800888, $00808800, $00808880, $00808808, $00808888,
   $00080000, $00080080, $00080008, $00080088, $00088000, $00088080, $00088008, $00088088,
   $00080800, $00080880, $00080808, $00080888, $00088800, $00088880, $00088808, $00088888,
   $00880000, $00880080, $00880008, $00880088, $00888000, $00888080, $00888008, $00888088,
   $00880800, $00880880, $00880808, $00880888, $00888800, $00888880, $00888808, $00888888,
   $80000000, $80000080, $80000008, $80000088, $80008000, $80008080, $80008008, $80008088,
   $80000800, $80000880, $80000808, $80000888, $80008800, $80008880, $80008808, $80008888,
   $80800000, $80800080, $80800008, $80800088, $80808000, $80808080, $80808008, $80808088,
   $80800800, $80800880, $80800808, $80800888, $80808800, $80808880, $80808808, $80808888,
   $80080000, $80080080, $80080008, $80080088, $80088000, $80088080, $80088008, $80088088,
   $80080800, $80080880, $80080808, $80080888, $80088800, $80088880, $80088808, $80088888,
   $80880000, $80880080, $80880008, $80880088, $80888000, $80888080, $80888008, $80888088,
   $80880800, $80880880, $80880808, $80880888, $80888800, $80888880, $80888808, $80888888,
   $08000000, $08000080, $08000008, $08000088, $08008000, $08008080, $08008008, $08008088,
   $08000800, $08000880, $08000808, $08000888, $08008800, $08008880, $08008808, $08008888,
   $08800000, $08800080, $08800008, $08800088, $08808000, $08808080, $08808008, $08808088,
   $08800800, $08800880, $08800808, $08800888, $08808800, $08808880, $08808808, $08808888,
   $08080000, $08080080, $08080008, $08080088, $08088000, $08088080, $08088008, $08088088,
   $08080800, $08080880, $08080808, $08080888, $08088800, $08088880, $08088808, $08088888,
   $08880000, $08880080, $08880008, $08880088, $08888000, $08888080, $08888008, $08888088,
   $08880800, $08880880, $08880808, $08880888, $08888800, $08888880, $08888808, $08888888,
   $88000000, $88000080, $88000008, $88000088, $88008000, $88008080, $88008008, $88008088,
   $88000800, $88000880, $88000808, $88000888, $88008800, $88008880, $88008808, $88008888,
   $88800000, $88800080, $88800008, $88800088, $88808000, $88808080, $88808008, $88808088,
   $88800800, $88800880, $88800808, $88800888, $88808800, $88808880, $88808808, $88808888,
   $88080000, $88080080, $88080008, $88080088, $88088000, $88088080, $88088008, $88088088,
   $88080800, $88080880, $88080808, $88080888, $88088800, $88088880, $88088808, $88088888,
   $88880000, $88880080, $88880008, $88880088, $88888000, $88888080, $88888008, $88888088,
   $88880800, $88880880, $88880808, $88880888, $88888800, $88888880, $88888808, $88888888
  );

  IPInv: TInitialPermutation = (
   $00000000, $02000000, $00020000, $02020000, $00000200, $02000200, $00020200, $02020200,
   $00000002, $02000002, $00020002, $02020002, $00000202, $02000202, $00020202, $02020202,
   $01000000, $03000000, $01020000, $03020000, $01000200, $03000200, $01020200, $03020200,
   $01000002, $03000002, $01020002, $03020002, $01000202, $03000202, $01020202, $03020202,
   $00010000, $02010000, $00030000, $02030000, $00010200, $02010200, $00030200, $02030200,
   $00010002, $02010002, $00030002, $02030002, $00010202, $02010202, $00030202, $02030202,
   $01010000, $03010000, $01030000, $03030000, $01010200, $03010200, $01030200, $03030200,
   $01010002, $03010002, $01030002, $03030002, $01010202, $03010202, $01030202, $03030202,
   $00000100, $02000100, $00020100, $02020100, $00000300, $02000300, $00020300, $02020300,
   $00000102, $02000102, $00020102, $02020102, $00000302, $02000302, $00020302, $02020302,
   $01000100, $03000100, $01020100, $03020100, $01000300, $03000300, $01020300, $03020300,
   $01000102, $03000102, $01020102, $03020102, $01000302, $03000302, $01020302, $03020302,
   $00010100, $02010100, $00030100, $02030100, $00010300, $02010300, $00030300, $02030300,
   $00010102, $02010102, $00030102, $02030102, $00010302, $02010302, $00030302, $02030302,
   $01010100, $03010100, $01030100, $03030100, $01010300, $03010300, $01030300, $03030300,
   $01010102, $03010102, $01030102, $03030102, $01010302, $03010302, $01030302, $03030302,
   $00000001, $02000001, $00020001, $02020001, $00000201, $02000201, $00020201, $02020201,
   $00000003, $02000003, $00020003, $02020003, $00000203, $02000203, $00020203, $02020203,
   $01000001, $03000001, $01020001, $03020001, $01000201, $03000201, $01020201, $03020201,
   $01000003, $03000003, $01020003, $03020003, $01000203, $03000203, $01020203, $03020203,
   $00010001, $02010001, $00030001, $02030001, $00010201, $02010201, $00030201, $02030201,
   $00010003, $02010003, $00030003, $02030003, $00010203, $02010203, $00030203, $02030203,
   $01010001, $03010001, $01030001, $03030001, $01010201, $03010201, $01030201, $03030201,
   $01010003, $03010003, $01030003, $03030003, $01010203, $03010203, $01030203, $03030203,
   $00000101, $02000101, $00020101, $02020101, $00000301, $02000301, $00020301, $02020301,
   $00000103, $02000103, $00020103, $02020103, $00000303, $02000303, $00020303, $02020303,
   $01000101, $03000101, $01020101, $03020101, $01000301, $03000301, $01020301, $03020301,
   $01000103, $03000103, $01020103, $03020103, $01000303, $03000303, $01020303, $03020303,
   $00010101, $02010101, $00030101, $02030101, $00010301, $02010301, $00030301, $02030301,
   $00010103, $02010103, $00030103, $02030103, $00010303, $02010303, $00030303, $02030303,
   $01010101, $03010101, $01030101, $03030101, $01010301, $03010301, $01030301, $03030301,
   $01010103, $03010103, $01030103, $03030103, $01010303, $03010303, $01030303, $03030303
  );

function TDESCipher.EncryptedBlock(const Plaintext: Int64): Int64;
var
  H, L, R, DH, DL: DWORD;
begin
  L := TDoubleDWORD(Plaintext).L;
  H := TDoubleDWORD(Plaintext).R;
  DL := L and $55555555 or H and $55555555 shl 1;
  DH := H and $AAAAAAAA or L and $AAAAAAAA shr 1;
  L :=    IP[DL shr 24        ] shr 3
       or IP[DL shr 16 and $FF] shr 2
       or IP[DL shr  8 and $FF] shr 1
       or IP[DL        and $FF];
  R :=    IP[DH shr 24        ] shr 3
       or IP[DH shr 16 and $FF] shr 2
       or IP[DH shr  8 and $FF] shr 1
       or IP[DH        and $FF];

  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[15]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[14]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[13]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[12]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[11]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[10]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 9]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 8]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 7]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 6]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 5]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 4]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 3]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 2]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 1]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 0]);

  { Exchange final blocks L16, R16. }
  { Run 'em through the inverse of IP and put 'em back without swapping. }
  DL := L and $0F0F0F0F or R and $0F0F0F0F shl 4;
  DH := R and $F0F0F0F0 or L and $F0F0F0F0 shr 4;
  TDoubleDWORD(Result).R :=    IPInv[DL shr 24        ] shl 6
                            or IPInv[DL shr 16 and $FF] shl 4
                            or IPInv[DL shr  8 and $FF] shl 2
                            or IPInv[DL and        $FF];
  TDoubleDWORD(Result).L :=    IPInv[DH shr 24        ] shl 6
                            or IPInv[DH shr 16 and $FF] shl 4
                            or IPInv[DH shr  8 and $FF] shl 2
                            or IPInv[DH        and $FF];
end; { EncryptedBlock }

procedure TDESCipher.EncryptBlock(var Plaintext);
var
  H, L, R, DH, DL: DWORD;
begin
  L := TDoubleDWORD(Plaintext).L;
  H := TDoubleDWORD(Plaintext).R;
  DL := L and $55555555 or H and $55555555 shl 1;
  DH := H and $AAAAAAAA or L and $AAAAAAAA shr 1;
  L :=    IP[DL shr 24        ] shr 3
       or IP[DL shr 16 and $FF] shr 2
       or IP[DL shr  8 and $FF] shr 1
       or IP[DL        and $FF];
  R :=    IP[DH shr 24        ] shr 3
       or IP[DH shr 16 and $FF] shr 2
       or IP[DH shr  8 and $FF] shr 1
       or IP[DH        and $FF];

  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[15]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[14]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[13]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[12]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[11]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[10]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 9]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 8]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 7]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 6]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 5]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 4]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 3]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 2]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 1]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 0]);

  { Exchange final blocks L16, R16. }
  { Run 'em through the inverse of IP and put 'em back without swapping. }
  DL := L and $0F0F0F0F or R and $0F0F0F0F shl 4;
  DH := R and $F0F0F0F0 or L and $F0F0F0F0 shr 4;
  TDoubleDWORD(Plaintext).R :=     IPInv[DL shr 24        ] shl 6
                            or IPInv[DL shr 16 and $FF] shl 4
                            or IPInv[DL shr  8 and $FF] shl 2
                            or IPInv[DL and        $FF];
  TDoubleDWORD(Plaintext).L :=     IPInv[DH shr 24        ] shl 6
                            or IPInv[DH shr 16 and $FF] shl 4
                            or IPInv[DH shr  8 and $FF] shl 2
                            or IPInv[DH        and $FF];
end; { EncryptBlock }

function TDESCipher.DecryptedBlock(const Ciphertext: Int64): Int64;
{ See comments for EncryptedBlock. }
var
  H, L, R, DH, DL: DWORD;
begin
  L := TDoubleDWORD(Ciphertext).L;
  H := TDoubleDWORD(Ciphertext).R;
  DL := L and $55555555 or H and $55555555 shl 1;
  DH := H and $AAAAAAAA or L and $AAAAAAAA shr 1;
  L :=    IP[DL shr 24        ] shr 3
       or IP[DL shr 16 and $FF] shr 2
       or IP[DL shr  8 and $FF] shr 1
       or IP[DL        and $FF];
  R :=    IP[DH shr 24        ] shr 3
       or IP[DH shr 16 and $FF] shr 2
       or IP[DH shr  8 and $FF] shr 1
       or IP[DH        and $FF];

  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 0]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 1]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 2]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 3]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 4]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 5]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 6]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 7]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 8]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 9]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[10]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[11]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[12]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[13]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[14]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[15]);

  DL := L and $0F0F0F0F or R and $0F0F0F0F shl 4;
  DH := R and $F0F0F0F0 or L and $F0F0F0F0 shr 4;
  TDoubleDWORD(Result).R :=    IPInv[DL shr 24        ] shl 6
                            or IPInv[DL shr 16 and $FF] shl 4
                            or IPInv[DL shr  8 and $FF] shl 2
                            or IPInv[DL and        $FF];
  TDoubleDWORD(Result).L :=    IPInv[DH shr 24        ] shl 6
                            or IPInv[DH shr 16 and $FF] shl 4
                            or IPInv[DH shr  8 and $FF] shl 2
                            or IPInv[DH        and $FF];
end; { DecryptedBlock }

procedure TDESCipher.DecryptBlock(var Ciphertext);
var
  H, L, R, DH, DL: DWORD;
begin
  L := TDoubleDWORD(Ciphertext).L;
  H := TDoubleDWORD(Ciphertext).R;
  DL := L and $55555555 or H and $55555555 shl 1;
  DH := H and $AAAAAAAA or L and $AAAAAAAA shr 1;
  L :=    IP[DL shr 24        ] shr 3
       or IP[DL shr 16 and $FF] shr 2
       or IP[DL shr  8 and $FF] shr 1
       or IP[DL        and $FF];
  R :=    IP[DH shr 24        ] shr 3
       or IP[DH shr 16 and $FF] shr 2
       or IP[DH shr  8 and $FF] shr 1
       or IP[DH        and $FF];

  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 0]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 1]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 2]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 3]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 4]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 5]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 6]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 7]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[ 8]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[ 9]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[10]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[11]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[12]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[13]);
  L := L xor ExpandedSubstitutedAndPermutedDWORD(R, FKeySchedule[14]);
  R := R xor ExpandedSubstitutedAndPermutedDWORD(L, FKeySchedule[15]);

  DL := L and $0F0F0F0F or R and $0F0F0F0F shl 4;
  DH := R and $F0F0F0F0 or L and $F0F0F0F0 shr 4;
  TDoubleDWORD(Ciphertext).R :=    IPInv[DL shr 24        ] shl 6
                                or IPInv[DL shr 16 and $FF] shl 4
                                or IPInv[DL shr  8 and $FF] shl 2
                                or IPInv[DL and        $FF];
  TDoubleDWORD(Ciphertext).L :=    IPInv[DH shr 24        ] shl 6
                                or IPInv[DH shr 16 and $FF] shl 4
                                or IPInv[DH shr  8 and $FF] shl 2
                                or IPInv[DH        and $FF];
end; { DecryptBlock }

class function TDESCipher.MinKeyLength: Integer;
begin
  Result := 8;
end;


//----------------------------- TBlowfishCipher --------------------------------


const
  InitialSBox1: TBlowfishSBox = (
    $d1310ba6, $98dfb5ac, $2ffd72db, $d01adfb7, $b8e1afed, $6a267e96,
    $ba7c9045, $f12c7f99, $24a19947, $b3916cf7, $0801f2e2, $858efc16,
    $636920d8, $71574e69, $a458fea3, $f4933d7e, $0d95748f, $728eb658,
    $718bcd58, $82154aee, $7b54a41d, $c25a59b5, $9c30d539, $2af26013,
    $c5d1b023, $286085f0, $ca417918, $b8db38ef, $8e79dcb0, $603a180e,
    $6c9e0e8b, $b01e8a3e, $d71577c1, $bd314b27, $78af2fda, $55605c60,
    $e65525f3, $aa55ab94, $57489862, $63e81440, $55ca396a, $2aab10b6,
    $b4cc5c34, $1141e8ce, $a15486af, $7c72e993, $b3ee1411, $636fbc2a,
    $2ba9c55d, $741831f6, $ce5c3e16, $9b87931e, $afd6ba33, $6c24cf5c,
    $7a325381, $28958677, $3b8f4898, $6b4bb9af, $c4bfe81b, $66282193,
    $61d809cc, $fb21a991, $487cac60, $5dec8032, $ef845d5d, $e98575b1,
    $dc262302, $eb651b88, $23893e81, $d396acc5, $0f6d6ff3, $83f44239,
    $2e0b4482, $a4842004, $69c8f04a, $9e1f9b5e, $21c66842, $f6e96c9a,
    $670c9c61, $abd388f0, $6a51a0d2, $d8542f68, $960fa728, $ab5133a3,
    $6eef0b6c, $137a3be4, $ba3bf050, $7efb2a98, $a1f1651d, $39af0176,
    $66ca593e, $82430e88, $8cee8619, $456f9fb4, $7d84a5c3, $3b8b5ebe,
    $e06f75d8, $85c12073, $401a449f, $56c16aa6, $4ed3aa62, $363f7706,
    $1bfedf72, $429b023d, $37d0d724, $d00a1248, $db0fead3, $49f1c09b,
    $075372c9, $80991b7b, $25d479d8, $f6e8def7, $e3fe501a, $b6794c3b,
    $976ce0bd, $04c006ba, $c1a94fb6, $409f60c4, $5e5c9ec2, $196a2463,
    $68fb6faf, $3e6c53b5, $1339b2eb, $3b52ec6f, $6dfc511f, $9b30952c,
    $cc814544, $af5ebd09, $bee3d004, $de334afd, $660f2807, $192e4bb3,
    $c0cba857, $45c8740f, $d20b5f39, $b9d3fbdb, $5579c0bd, $1a60320a,
    $d6a100c6, $402c7279, $679f25fe, $fb1fa3cc, $8ea5e9f8, $db3222f8,
    $3c7516df, $fd616b15, $2f501ec8, $ad0552ab, $323db5fa, $fd238760,
    $53317b48, $3e00df82, $9e5c57bb, $ca6f8ca0, $1a87562e, $df1769db,
    $d542a8f6, $287effc3, $ac6732c6, $8c4f5573, $695b27b0, $bbca58c8,
    $e1ffa35d, $b8f011a0, $10fa3d98, $fd2183b8, $4afcb56c, $2dd1d35b,
    $9a53e479, $b6f84565, $d28e49bc, $4bfb9790, $e1ddf2da, $a4cb7e33,
    $62fb1341, $cee4c6e8, $ef20cada, $36774c01, $d07e9efe, $2bf11fb4,
    $95dbda4d, $ae909198, $eaad8e71, $6b93d5a0, $d08ed1d0, $afc725e0,
    $8e3c5b2f, $8e7594b7, $8ff6e2fb, $f2122b64, $8888b812, $900df01c,
    $4fad5ea0, $688fc31c, $d1cff191, $b3a8c1ad, $2f2f2218, $be0e1777,
    $ea752dfe, $8b021fa1, $e5a0cc0f, $b56f74e8, $18acf3d6, $ce89e299,
    $b4a84fe0, $fd13e0b7, $7cc43b81, $d2ada8d9, $165fa266, $80957705,
    $93cc7314, $211a1477, $e6ad2065, $77b5fa86, $c75442f5, $fb9d35cf,
    $ebcdaf0c, $7b3e89a0, $d6411bd3, $ae1e7e49, $00250e2d, $2071b35e,
    $226800bb, $57b8e0af, $2464369b, $f009b91e, $5563911d, $59dfa6aa,
    $78c14389, $d95a537f, $207d5ba2, $02e5b9c5, $83260376, $6295cfa9,
    $11c81968, $4e734a41, $b3472dca, $7b14a94a, $1b510052, $9a532915,
    $d60f573f, $bc9bc6e4, $2b60a476, $81e67400, $08ba6fb5, $571be91f,
    $f296ec6b, $2a0dd915, $b6636521, $e7b9f9b6, $ff34052e, $c5855664,
    $53b02d5d, $a99f8fa1, $08ba4799, $6e85076a
  );

  InitialSBox2: TBlowfishSBox = (
    $4b7a70e9, $b5b32944, $db75092e, $c4192623, $ad6ea6b0, $49a7df7d,
    $9cee60b8, $8fedb266, $ecaa8c71, $699a17ff, $5664526c, $c2b19ee1,
    $193602a5, $75094c29, $a0591340, $e4183a3e, $3f54989a, $5b429d65,
    $6b8fe4d6, $99f73fd6, $a1d29c07, $efe830f5, $4d2d38e6, $f0255dc1,
    $4cdd2086, $8470eb26, $6382e9c6, $021ecc5e, $09686b3f, $3ebaefc9,
    $3c971814, $6b6a70a1, $687f3584, $52a0e286, $b79c5305, $aa500737,
    $3e07841c, $7fdeae5c, $8e7d44ec, $5716f2b8, $b03ada37, $f0500c0d,
    $f01c1f04, $0200b3ff, $ae0cf51a, $3cb574b2, $25837a58, $dc0921bd,
    $d19113f9, $7ca92ff6, $94324773, $22f54701, $3ae5e581, $37c2dadc,
    $c8b57634, $9af3dda7, $a9446146, $0fd0030e, $ecc8c73e, $a4751e41,
    $e238cd99, $3bea0e2f, $3280bba1, $183eb331, $4e548b38, $4f6db908,
    $6f420d03, $f60a04bf, $2cb81290, $24977c79, $5679b072, $bcaf89af,
    $de9a771f, $d9930810, $b38bae12, $dccf3f2e, $5512721f, $2e6b7124,
    $501adde6, $9f84cd87, $7a584718, $7408da17, $bc9f9abc, $e94b7d8c,
    $ec7aec3a, $db851dfa, $63094366, $c464c3d2, $ef1c1847, $3215d908,
    $dd433b37, $24c2ba16, $12a14d43, $2a65c451, $50940002, $133ae4dd,
    $71dff89e, $10314e55, $81ac77d6, $5f11199b, $043556f1, $d7a3c76b,
    $3c11183b, $5924a509, $f28fe6ed, $97f1fbfa, $9ebabf2c, $1e153c6e,
    $86e34570, $eae96fb1, $860e5e0a, $5a3e2ab3, $771fe71c, $4e3d06fa,
    $2965dcb9, $99e71d0f, $803e89d6, $5266c825, $2e4cc978, $9c10b36a,
    $c6150eba, $94e2ea78, $a5fc3c53, $1e0a2df4, $f2f74ea7, $361d2b3d,
    $1939260f, $19c27960, $5223a708, $f71312b6, $ebadfe6e, $eac31f66,
    $e3bc4595, $a67bc883, $b17f37d1, $018cff28, $c332ddef, $be6c5aa5,
    $65582185, $68ab9802, $eecea50f, $db2f953b, $2aef7dad, $5b6e2f84,
    $1521b628, $29076170, $ecdd4775, $619f1510, $13cca830, $eb61bd96,
    $0334fe1e, $aa0363cf, $b5735c90, $4c70a239, $d59e9e0b, $cbaade14,
    $eecc86bc, $60622ca7, $9cab5cab, $b2f3846e, $648b1eaf, $19bdf0ca,
    $a02369b9, $655abb50, $40685a32, $3c2ab4b3, $319ee9d5, $c021b8f7,
    $9b540b19, $875fa099, $95f7997e, $623d7da8, $f837889a, $97e32d77,
    $11ed935f, $16681281, $0e358829, $c7e61fd6, $96dedfa1, $7858ba99,
    $57f584a5, $1b227263, $9b83c3ff, $1ac24696, $cdb30aeb, $532e3054,
    $8fd948e4, $6dbc3128, $58ebf2ef, $34c6ffea, $fe28ed61, $ee7c3c73,
    $5d4a14d9, $e864b7e3, $42105d14, $203e13e0, $45eee2b6, $a3aaabea,
    $db6c4f15, $facb4fd0, $c742f442, $ef6abbb5, $654f3b1d, $41cd2105,
    $d81e799e, $86854dc7, $e44b476a, $3d816250, $cf62a1f2, $5b8d2646,
    $fc8883a0, $c1c7b6a3, $7f1524c3, $69cb7492, $47848a0b, $5692b285,
    $095bbf00, $ad19489d, $1462b174, $23820e00, $58428d2a, $0c55f5ea,
    $1dadf43e, $233f7061, $3372f092, $8d937e41, $d65fecf1, $6c223bdb,
    $7cde3759, $cbee7460, $4085f2a7, $ce77326e, $a6078084, $19f8509e,
    $e8efd855, $61d99735, $a969a7aa, $c50c06c2, $5a04abfc, $800bcadc,
    $9e447a2e, $c3453484, $fdd56705, $0e1e9ec9, $db73dbd3, $105588cd,
    $675fda79, $e3674340, $c5c43465, $713e38d8, $3d28f89e, $f16dff20,
    $153e21e7, $8fb03d4a, $e6e39f2b, $db83adf7
  );

  InitialSBox3: TBlowfishSBox = (
    $e93d5a68, $948140f7, $f64c261c, $94692934, $411520f7, $7602d4f7,
    $bcf46b2e, $d4a20068, $d4082471, $3320f46a, $43b7d4b7, $500061af,
    $1e39f62e, $97244546, $14214f74, $bf8b8840, $4d95fc1d, $96b591af,
    $70f4ddd3, $66a02f45, $bfbc09ec, $03bd9785, $7fac6dd0, $31cb8504,
    $96eb27b3, $55fd3941, $da2547e6, $abca0a9a, $28507825, $530429f4,
    $0a2c86da, $e9b66dfb, $68dc1462, $d7486900, $680ec0a4, $27a18dee,
    $4f3ffea2, $e887ad8c, $b58ce006, $7af4d6b6, $aace1e7c, $d3375fec,
    $ce78a399, $406b2a42, $20fe9e35, $d9f385b9, $ee39d7ab, $3b124e8b,
    $1dc9faf7, $4b6d1856, $26a36631, $eae397b2, $3a6efa74, $dd5b4332,
    $6841e7f7, $ca7820fb, $fb0af54e, $d8feb397, $454056ac, $ba489527,
    $55533a3a, $20838d87, $fe6ba9b7, $d096954b, $55a867bc, $a1159a58,
    $cca92963, $99e1db33, $a62a4a56, $3f3125f9, $5ef47e1c, $9029317c,
    $fdf8e802, $04272f70, $80bb155c, $05282ce3, $95c11548, $e4c66d22,
    $48c1133f, $c70f86dc, $07f9c9ee, $41041f0f, $404779a4, $5d886e17,
    $325f51eb, $d59bc0d1, $f2bcc18f, $41113564, $257b7834, $602a9c60,
    $dff8e8a3, $1f636c1b, $0e12b4c2, $02e1329e, $af664fd1, $cad18115,
    $6b2395e0, $333e92e1, $3b240b62, $eebeb922, $85b2a20e, $e6ba0d99,
    $de720c8c, $2da2f728, $d0127845, $95b794fd, $647d0862, $e7ccf5f0,
    $5449a36f, $877d48fa, $c39dfd27, $f33e8d1e, $0a476341, $992eff74,
    $3a6f6eab, $f4f8fd37, $a812dc60, $a1ebddf8, $991be14c, $db6e6b0d,
    $c67b5510, $6d672c37, $2765d43b, $dcd0e804, $f1290dc7, $cc00ffa3,
    $b5390f92, $690fed0b, $667b9ffb, $cedb7d9c, $a091cf0b, $d9155ea3,
    $bb132f88, $515bad24, $7b9479bf, $763bd6eb, $37392eb3, $cc115979,
    $8026e297, $f42e312d, $6842ada7, $c66a2b3b, $12754ccc, $782ef11c,
    $6a124237, $b79251e7, $06a1bbe6, $4bfb6350, $1a6b1018, $11caedfa,
    $3d25bdd8, $e2e1c3c9, $44421659, $0a121386, $d90cec6e, $d5abea2a,
    $64af674e, $da86a85f, $bebfe988, $64e4c3fe, $9dbc8057, $f0f7c086,
    $60787bf8, $6003604d, $d1fd8346, $f6381fb0, $7745ae04, $d736fccc,
    $83426b33, $f01eab71, $b0804187, $3c005e5f, $77a057be, $bde8ae24,
    $55464299, $bf582e61, $4e58f48f, $f2ddfda2, $f474ef38, $8789bdc2,
    $5366f9c3, $c8b38e74, $b475f255, $46fcd9b9, $7aeb2661, $8b1ddf84,
    $846a0e79, $915f95e2, $466e598e, $20b45770, $8cd55591, $c902de4c,
    $b90bace1, $bb8205d0, $11a86248, $7574a99e, $b77f19b6, $e0a9dc09,
    $662d09a1, $c4324633, $e85a1f02, $09f0be8c, $4a99a025, $1d6efe10,
    $1ab93d1d, $0ba5a4df, $a186f20f, $2868f169, $dcb7da83, $573906fe,
    $a1e2ce9b, $4fcd7f52, $50115e01, $a70683fa, $a002b5c4, $0de6d027,
    $9af88c27, $773f8641, $c3604c06, $61a806b5, $f0177a28, $c0f586e0,
    $006058aa, $30dc7d62, $11e69ed7, $2338ea63, $53c2dd94, $c2c21634,
    $bbcbee56, $90bcb6de, $ebfc7da1, $ce591d76, $6f05e409, $4b7c0188,
    $39720a3d, $7c927c24, $86e3725f, $724d9db9, $1ac15bb4, $d39eb8fc,
    $ed545578, $08fca5b5, $d83d7cd3, $4dad0fc4, $1e50ef5e, $b161e6f8,
    $a28514d9, $6c51133c, $6fd5c7e7, $56e14ec4, $362abfce, $ddc6c837,
    $d79a3234, $92638212, $670efa8e, $406000e0
  );

  InitialSBox4: TBlowfishSBox = (
    $3a39ce37, $d3faf5cf, $abc27737, $5ac52d1b, $5cb0679e, $4fa33742,
    $d3822740, $99bc9bbe, $d5118e9d, $bf0f7315, $d62d1c7e, $c700c47b,
    $b78c1b6b, $21a19045, $b26eb1be, $6a366eb4, $5748ab2f, $bc946e79,
    $c6a376d2, $6549c2c8, $530ff8ee, $468dde7d, $d5730a1d, $4cd04dc6,
    $2939bbdb, $a9ba4650, $ac9526e8, $be5ee304, $a1fad5f0, $6a2d519a,
    $63ef8ce2, $9a86ee22, $c089c2b8, $43242ef6, $a51e03aa, $9cf2d0a4,
    $83c061ba, $9be96a4d, $8fe51550, $ba645bd6, $2826a2f9, $a73a3ae1,
    $4ba99586, $ef5562e9, $c72fefd3, $f752f7da, $3f046f69, $77fa0a59,
    $80e4a915, $87b08601, $9b09e6ad, $3b3ee593, $e990fd5a, $9e34d797,
    $2cf0b7d9, $022b8b51, $96d5ac3a, $017da67d, $d1cf3ed6, $7c7d2d28,
    $1f9f25cf, $adf2b89b, $5ad6b472, $5a88f54c, $e029ac71, $e019a5e6,
    $47b0acfd, $ed93fa9b, $e8d3c48d, $283b57cc, $f8d56629, $79132e28,
    $785f0191, $ed756055, $f7960e44, $e3d35e8c, $15056dd4, $88f46dba,
    $03a16125, $0564f0bd, $c3eb9e15, $3c9057a2, $97271aec, $a93a072a,
    $1b3f6d9b, $1e6321f5, $f59c66fb, $26dcf319, $7533d928, $b155fdf5,
    $03563482, $8aba3cbb, $28517711, $c20ad9f8, $abcc5167, $ccad925f,
    $4de81751, $3830dc8e, $379d5862, $9320f991, $ea7a90c2, $fb3e7bce,
    $5121ce64, $774fbe32, $a8b6e37e, $c3293d46, $48de5369, $6413e680,
    $a2ae0810, $dd6db224, $69852dfd, $09072166, $b39a460a, $6445c0dd,
    $586cdecf, $1c20c8ae, $5bbef7dd, $1b588d40, $ccd2017f, $6bb4e3bb,
    $dda26a7e, $3a59ff45, $3e350a44, $bcb4cdd5, $72eacea8, $fa6484bb,
    $8d6612ae, $bf3c6f47, $d29be463, $542f5d9e, $aec2771b, $f64e6370,
    $740e0d8d, $e75b1357, $f8721671, $af537d5d, $4040cb08, $4eb4e2cc,
    $34d2466a, $0115af84, $e1b00428, $95983a1d, $06b89fb4, $ce6ea048,
    $6f3f3b82, $3520ab82, $011a1d4b, $277227f8, $611560b1, $e7933fdc,
    $bb3a792b, $344525bd, $a08839e1, $51ce794b, $2f32c9b7, $a01fbac9,
    $e01cc87e, $bcc7d1f6, $cf0111c3, $a1e8aac7, $1a908749, $d44fbd9a,
    $d0dadecb, $d50ada38, $0339c32a, $c6913667, $8df9317c, $e0b12b4f,
    $f79e59b7, $43f5bb3a, $f2d519ff, $27d9459c, $bf97222c, $15e6fc2a,
    $0f91fc71, $9b941525, $fae59361, $ceb69ceb, $c2a86459, $12baa8d1,
    $b6c1075e, $e3056a0c, $10d25065, $cb03a442, $e0ec6e0e, $1698db3b,
    $4c98a0be, $3278e964, $9f1f9532, $e0d392df, $d3a0342b, $8971f21e,
    $1b0a7441, $4ba3348c, $c5be7120, $c37632d8, $df359f8d, $9b992f2e,
    $e60b6f47, $0fe3f11d, $e54cda54, $1edad891, $ce6279cf, $cd3e7e6f,
    $1618b166, $fd2c1d05, $848fd2c5, $f6fb2299, $f523f357, $a6327623,
    $93a83531, $56cccd02, $acf08162, $5a75ebb5, $6e163697, $88d273cc,
    $de966292, $81b949d0, $4c50901b, $71c65614, $e6c6c7bd, $327a140a,
    $45e1d006, $c3f27b9a, $c9aa53fd, $62a80f00, $bb25bfe2, $35bdd2f6,
    $71126905, $b2040222, $b6cbcf7c, $cd769c2b, $53113ec0, $1640e3d3,
    $38abbd60, $2547adf0, $ba38209c, $f746ce76, $77afa1c5, $20756060,
    $85cbfe4e, $8ae88dd8, $7aaaf9b0, $4cf9aa7e, $1948c25c, $02fb8a8c,
    $01c36ae4, $d6ebe1f9, $90d4f869, $a65cdea0, $3f09252d, $c208e69f,
    $b74e6132, $ce77e25b, $578fdfe3, $3ac372e6
  );

  InitialPArray: TBlowfishPArray = (
    $243f6a88, $85a308d3, $13198a2e, $03707344, $a4093822, $299f31d0,
    $082efa98, $ec4e6c89, $452821e6, $38d01377, $be5466cf, $34e90c6c,
    $c0ac29b7, $c97c50dd, $3f84d5b5, $b5470917, $9216d5d9, $8979fb1b
  );

constructor TBlowfishCipher.Create(const Key; const Length: Integer);
begin
  inherited;
  GenerateSubkeys(Key, Length);
end;

destructor TBlowfishCipher.Destroy;
begin
  inherited;
end;

procedure TBlowfishCipher.GenerateSubkeys(const Key; const Length: Integer);
var
  PKey: ^Byte;
  I, J, K: Integer;
  P: Int64;
  Data: DWORD;
begin
  FSBox1 := InitialSBox1;
  FSBox2 := InitialSBox2;
  FSBox3 := InitialSBox3;
  FSBox4 := InitialSBox4;
  J := 0;
  PKey := Addr(Key);
  for I := Low(FPArray) to High(FPArray) do begin
    Data := 0;
    for K := 1 to 4 do begin
      Data := Data shl 8 or PKey^;
      J := Succ(J) mod Length;
      if J = 0 then PKey := Addr(Key) else Inc(PKey);
    end;
    FPArray[I] := InitialPArray[I] xor Data;
  end;
  P := 0;
  I := Low(FPArray);
  while I <= High(FPArray) do begin
    P := EncryptedBlock(P);
    FPArray[I] := TDoubleDWORD(P).L;
    Inc(I);
    FPArray[I] := TDoubleDWORD(P).R;
    Inc(I);
  end;
  J := Low(FSBox1);
  while J <= High(FSBox1) do begin
    P := EncryptedBlock(P);
    FSBox1[J] := TDoubleDWORD(P).L;
    Inc(J);
    FSBox1[J] := TDoubleDWORD(P).R;
    Inc(J);
  end;
  J := Low(FSBox2);
  while J <= High(FSBox2) do begin
    P := EncryptedBlock(P);
    FSBox2[J] := TDoubleDWORD(P).L;
    Inc(J);
    FSBox2[J] := TDoubleDWORD(P).R;
    Inc(J);
  end;
  J := Low(FSBox3);
  while J <= High(FSBox3) do begin
    P := EncryptedBlock(P);
    FSBox3[J] := TDoubleDWORD(P).L;
    Inc(J);
    FSBox3[J] := TDoubleDWORD(P).R;
    Inc(J);
  end;
  J := Low(FSBox4);
  while J <= High(FSBox4) do begin
    P := EncryptedBlock(P);
    FSBox4[J] := TDoubleDWORD(P).L;
    Inc(J);
    FSBox4[J] := TDoubleDWORD(P).R;
    Inc(J);
  end;
end;

function TBlowfishCipher.EncryptedBlock(const Plaintext: Int64): Int64;
var
  L, R: DWORD;
begin
  L := TDoubleDWORD(Plaintext).L;
  R := TDoubleDWORD(Plaintext).R;
  L := L xor FPArray[0];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[1];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[2];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[3];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[4];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[5];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[6];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[7];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[8];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[9];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[10];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[11];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[12];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[13];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[14];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[15];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  TDoubleDWORD(Result).L := R xor FPArray[17];
  TDoubleDWORD(Result).R := L xor FPArray[16];
end;

function TBlowfishCipher.DecryptedBlock(const Ciphertext: Int64): Int64;
var
  L, R: DWORD;
begin
  L := TDoubleDWORD(Ciphertext).L;
  R := TDoubleDWORD(Ciphertext).R;
  L := L xor FPArray[17];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[16];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[15];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[14];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[13];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[12];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[11];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[10];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[9];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[8];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[7];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[6];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[5];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[4];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[3];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[2];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  TDoubleDWORD(Result).L := R xor FPArray[0];
  TDoubleDWORD(Result).R := L xor FPArray[1];
end;

procedure TBlowfishCipher.EncryptBlock(var Plaintext);
var
  L, R: DWORD;
begin
  L := TDoubleDWORD(Plaintext).L;
  R := TDoubleDWORD(Plaintext).R;
  L := L xor FPArray[0];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[1];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[2];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[3];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[4];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[5];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[6];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[7];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[8];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[9];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[10];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[11];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[12];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[13];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[14];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[15];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  TDoubleDWORD(Plaintext).L := R xor FPArray[17];
  TDoubleDWORD(Plaintext).R := L xor FPArray[16];
end;

procedure TBlowfishCipher.DecryptBlock(var Ciphertext);
var
  L, R: DWORD;
begin
  L := TDoubleDWORD(Ciphertext).L;
  R := TDoubleDWORD(Ciphertext).R;
  L := L xor FPArray[17];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[16];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[15];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[14];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[13];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[12];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[11];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[10];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[9];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[8];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[7];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[6];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[5];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[4];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  L := L xor FPArray[3];
  with TFourByte(L) do begin
    R := R xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  R := R xor FPArray[2];
  with TFourByte(R) do begin
    L := L xor (FSBox1[B4] + FSBox2[B3] xor FSBox3[B2] + FSBox4[B1]);
  end;
  TDoubleDWORD(Ciphertext).L := R xor FPArray[0];
  TDoubleDWORD(Ciphertext).R := L xor FPArray[1];
end;

class function TBlowfishCipher.MinKeyLength: Integer;
begin
  Result := 8;
end;

class function TBlowfishCipher.MaxKeyLength: Integer;
begin
  Result := 56; 
end;

end.
