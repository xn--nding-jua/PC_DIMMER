unit FileInfo;

{ ------------------------------------------------------------------------- }
{                                                                           }
{ (c) by Tom Peiffer                                                        }
{ Version 1.2                                                               }
{ Get various information from any file, most interesting are :             }
{  - Version (if it exists, if not this property returns nonsense           }
{  - Size                                                                   }
{  - Creation, LastWrite and LastAcces Date                                 }
{                                                                           }
{ KNOW BUG... PLEASE READ AND GIVE ADVICE IF POSSIBLE                       }
{ If you drop the component on a NEW project (new, not a loaded), and you   }
{ indicate a VALID filename to the filename property, every information     }
{ about that file s shown correctly in the object inspector. BUT, if you    }
{ launch the program from inside Delphi, you get an EXCEPTION.              }
{ But, very curiosely, after SAVING the project and relaunching the         }
{ program from inside Delphi, you DON'T get an exception anymore. Also      }
{ all informations are accessible during runtime....                        }
{  --- I'd really like to know why this exception appears if the project is }
{      not saved...                                                         }
{      If you find the reason, please contact me at                         }
{                                                                           }
{      -->   tom@tp-net.lu   <---                                           }
{                                                                           }
{ V1.3                                                                      }
{ - DOS83 name

  v 1.4   1.4.2000
    - Added Version.TextShort   which gives a version as 1.1.20.321
                                and not as 1.1 Release 20 Build 321


                                                                            }
{ ------------------------------------------------------------------------- }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  PFixedFileInfo = ^TFixedFileInfo;
  TFixedFileInfo = record
     dwSignature       : DWORD;
     dwStrucVersion    : DWORD;
     wFileVersionMS    : WORD;  // Minor Version
     wFileVersionLS    : WORD;  // Major Version
     wProductVersionMS : WORD;  // Build Number
     wProductVersionLS : WORD;  // Release Version
     dwFileFlagsMask   : DWORD;
     dwFileFlags       : DWORD;
     dwFileOS          : DWORD;
     dwFileType        : DWORD;
     dwFileSubtype     : DWORD;
     dwFileDateMS      : DWORD;
     dwFileDateLS      : DWORD;
  end; // TFixedFileInfo

  TVersion = class (TPersistent)
               private
                 FMajor : word ;
                 FMinor : word ;
                 FRelease : word ;
                 FBuild : word ;
                 FText : string ;
                 fTextShort: String;
               published
                 property Major : word read FMajor write FMajor ;
                 property Minor : word read FMinor write FMinor ;
                 property Release : word read FRelease write FRelease ;
                 property Build : word read FBuild write FBuild ;
                 property Text : string read FText write FText ;
                 property TextShort: String read fTextShort write fTextShort;
             end ;

  TTimeStamp = class (TPersistent)
                 private
                   FCreation, FLastWrite, FLastAccess : TDateTime ;
                 published
                   property Creation : TDateTime read FCreation write FCreation ;
                   property LastWrite : TDateTime read FLastWrite write FLastWrite ;
                   property LastAccess : TDateTime read FLastAccess write FLastAccess ;
               end ;

  TFileInfo = class(TComponent)
  private
    { Private-Deklarationen }
    FFilename : string ;
    FVersion : TVersion ;
    FShort, FPath, FDrive : string ;
    FExtension, FWithoutExtension : string ;
    FTimeStamp : TTimeStamp ;
    FSize : integer ;
    FDOS83: string;
    function GetVersion : TVersion ;
    function GetTimeStamp : TTimeStamp ;
    function GetPath : string ;
    function GetDrive : string ;
    function GetSize : integer ;
    function GetShort : string ;
    function GetExtension : string ;
    function GetWithoutExtension : string ;
    function GetDOS83 : string ;
    procedure SetFilename (FN : string) ;
    function FileVersionInfo (filename : string) : TFixedFileInfo ;
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create (AOwner : TComponent) ; override ;
    destructor Destroy ; override ;
  published
    { Published-Deklarationen }
    property Version : TVersion read FVersion write FVersion ;
    property Filename : string read FFileName write SetFilename ;
    property Short : string read FShort write FShort ;
    property WithoutExtension : string read FWithoutExtension
                                 write FWithoutExtension ;
    property Extension : string read FExtension write FExtension ;
    property Size : integer read FSize write FSize ;
    property Path : string read FPath write FPath ;
    property Drive : string read FDrive write FDrive ;
    property TimeStamp : TTimeStamp read FTimeStamp write FTimeStamp ;
    property DOS83 : string read FDOS83 write FDOS83 ;
  end;

procedure Register;

implementation

procedure TFileInfo.SetFilename (FN : string) ;
begin
     FFilename := FN ;
     GetVersion ;
     GetShort ;
     GetWithoutExtension ;
     GetExtension ;
     GetSize ;
     GetPath ;
     GetDrive ;
     GetTimeStamp ;
     GetDOS83 ;
end ;

constructor TFileInfo.Create (AOwner : TComponent) ;
begin
     inherited create (AOwner) ;
     FVersion := TVersion.Create ;
     FTimeStamp := TTimeStamp.Create ;
     FFilename := '' ;
end ;

destructor TFileInfo.Destroy ;
begin
     FVersion.Free ;
     inherited Destroy ;
end ;

function TFileInfo.FileVersionInfo (filename : string) : TFixedFileInfo ;
var
  dwHandle, dwVersionSize : DWORD;
  strSubBlock             : String;
  pTemp                   : Pointer;
  pData                   : Pointer;
begin
   strSubBlock := '\';

   // get version information values
   dwVersionSize := GetFileVersionInfoSize( PChar( filename ), // pointer to filename string
                                            dwHandle );        // pointer to variable to receive zero

   // if GetFileVersionInfoSize is successful
   if dwVersionSize <> 0 then
   begin
      GetMem( pTemp, dwVersionSize );
      try
         if GetFileVersionInfo( PChar( FileName ),             // pointer to filename string
                                dwHandle,                      // ignored
                                dwVersionSize,                 // size of buffer
                                pTemp ) then                   // pointer to buffer to receive file-version info.

            if VerQueryValue( pTemp,                           // pBlock     - address of buffer for version resource
                              PChar( strSubBlock ),            // lpSubBlock - address of value to retrieve
                              pData,                           // lplpBuffer - address of buffer for version pointer
                              dwVersionSize ) then             // puLen      - address of version-value length buffer
               Result := PFixedFileInfo( pData )^;

      finally
         FreeMem( pTemp );
      end; // try
   end; // if dwVersionSize
end;

function TFileInfo.GetVersion : TVersion ;
var
 V : TFixedFileInfo ;
begin
     if FileExists (FFileName)
     then begin
               V := FileVersionInfo (FFileName) ;

               FVersion.FMajor := V.wFileVersionLS ;
               FVersion.FMinor := V.wFileVersionMS ;
               FVersion.FRelease := V.wProductVersionLS ;
               FVersion.FBuild := V.wProductVersionMS ;
               FVersion.FText := IntToStr (V.wFileVersionLS) + '.' +
                               IntToStr (V.wFileVersionMS) + ' Release ' +
                               IntToStr (V.wProductVersionLS) + ' Build ' +
                               IntToStr (V.wProductVersionMS) ;
               FVersion.FTextShort := IntToStr (V.wFileVersionLS) + '.' +
                               IntToStr (V.wFileVersionMS) + '.' +
                               IntToStr (V.wProductVersionLS) + '.' +
                               IntToStr (V.wProductVersionMS) ;
               Result := FVersion ;
          end
     else begin
               FVersion.FMajor := 0 ;
               FVersion.FMinor := 0 ;
               FVersion.FRelease := 0 ;
               FVersion.FBuild := 0 ;
               FVersion.FText := '' ;
               Result := FVersion ;
          end ;
end ;

function TFileInfo.GetPath : string ;
begin
     if FileExists (FFileName)
     then begin
               Result := ExtractFilePath (FFileName) ;
               if Result[length(Result)] <> '\'
               then Result := Result + '\' ;
          end
     else Result := '' ;
     FPath := Result ;
end ;

function TFileInfo.GetShort : string ;
begin
     if FileExists (FFileName)
     then Result := ExtractFileName (FFileName)
     else Result := '' ;
     FShort := Result ;
end ;

function TFileInfo.GetExtension : string ;
begin
     if FileExists (FFileName)
     then Result := ExtractFileExt (FFileName)
     else Result := '' ;
     FExtension := Result ;
end ;

function TFileInfo.GetWithoutExtension : string ;
begin
     if FileExists (FFileName)
     then begin
               result := copy(FShort,1,
                              length(FShort)-
                              Length(FExtension)) ;
          end
     else Result := '' ;
     FWithoutExtension := Result ;
end ;

function TFileInfo.GetDrive : string ;
var
 p : integer ;
begin
     if FileExists (FFileName)
     then begin
               if FFileName[2] = ':'
               then Result := copy(FFilename,1,1) + ':\' ;
               if copy(FFileName,1,2) = '\\'
               then begin
                         p := 3 ;
                         while FFileName[p] <> '\'
                         do p := p + 1 ;
                         Result := copy (FFileName,1,p) ;
                    end ;
          end
     else Result := '' ;
     FDrive := Result ;
end ;

function TFileInfo.GetTimeStamp : TTimeStamp ;
var
 LFT : TFileTime ;
 ST : TSystemTime ;
 DirEntry : TSearchRec ;
 OK : boolean ;
begin
     if FindFirst (FFileName,faAnyFile,DirEntry) = 0
     then begin
               { ftCreationTime }
{$WARNINGS OFF}
               FileTimeToLocalFileTime (DirEntry.FindData.ftCreationTime,LFT) ;
{$WARNINGS ON}
               OK := FileTimeToSystemTime (LFT,ST) ;
               if OK
               then FTimeStamp.Creation := SystemTimeToDateTime (ST)
               else FTimeStamp.Creation := 0 ;

               { frLastWriteTime }
{$WARNINGS OFF}
               FileTimeToLocalFileTime (DirEntry.FindData.ftLastWriteTime,LFT) ;
{$WARNINGS ON}
               OK := FileTimeToSystemTime (LFT,ST) ;
               if OK
               then FTimeStamp.LastWrite := SystemTimeToDateTime (ST)
               else FTimeStamp.LastWrite := 0 ;

               { ftLastAccessTime }
{$WARNINGS OFF}
               FileTimeToLocalFileTime (DirEntry.FindData.ftLastAccessTime,LFT) ;
{$WARNINGS ON}
               OK := FileTimeToSystemTime (LFT,ST) ;
               if OK
               then FTimeStamp.LastAccess := SystemTimeToDateTime (ST)
               else FTimeStamp.LastAccess := 0 ;
          end
     else begin
               FTimeStamp.Creation := 0 ;
               FTimeStamp.LastWrite := 0 ;
               FTimeStamp.LastAccess := 0 ;
               beep ;
          end ;
     FindClose (DirEntry) ;
     Result := FTimeStamp ;
end ;

function TFileInfo.GetSize : integer ;
var
 DirEntry : TSearchRec ;
begin
     if FindFirst (FFileName,faAnyFile,DirEntry) = 0
     then begin
               Result := DirEntry.Size ;
          end
     else Result := 0 ;
     FindClose (DirEntry) ;
     FSize := Result ;
end ;

procedure Register;
begin
  RegisterComponents('MyStuff', [TFileInfo]);
end;

function TFileInfo.GetDOS83: string;
var
 DirEntry : TSearchRec ;
begin
     FDOS83 := '' ;
     if FindFirst (FFileName,faAnyFile,DirEntry) = 0
     then begin
{$WARNINGS OFF}
               FDOS83 := DirEntry.FindData.cAlternateFileName ;
{$WARNINGS ON}
               if FDOS83 = ''
               then FDOS83 := uppercase(extractfilename (FFilename)) ;
          end
     else Result := '' ;
     FindClose (DirEntry) ;
     Result := FDOS83 ;
end;

end.
