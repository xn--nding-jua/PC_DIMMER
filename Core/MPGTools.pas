{******************************************************************************}
{                                                                              }
{ MPEG AUDIO TOOLS                                                             }
{ (c)1998, 1999 Copyright by Predrag Supurovic                                 }
{ http://www.dv.co.yu/mpgscript/mpeghdr.htm.                                   }
{                                                                              }
{------------------------------------------------------------------------------}
{                                                                              }
{ Edit to Version 2.4 by omata (Thorsten) - http://www.delphipraxis.net        }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit MPGTools;
{

MPEG AUDIO TOOLS
(c)1998, 1999 Copyright by Predrag Supurovic

This library gives you tools for manipulating MPEG AUDIO files
(*.mpa;*.mp2;*.mp3). It allows very easy reading and writing of MPEG
data (TAG and HEADER).

Supported formats are MPEG Versions 1, 2 and 2.5, Layer I, II and III.
MPEG TAGs are also supported (ID3v1.1).

Compiled and tested with Delphi 1 and Delphi 3. Received reports
that it sucessfully compiles with Delphi 4.

If you are interested in MPEG file structure take a look at
http://www.dv.co.yu/mpgscript/mpeghdr.htm.


Copyright notice:

All rights reserved by the Author. This source code is freeware if you
use it to produce freeware applications. You are free to use or
distribute it as long as it is done in original form. You are not
allowed to distribute changed source. You must give credits to author in
your source and executable code produced based on MPGTools, including
specifying WEB address http://www.dv.co.yu/mgscript/mpgtools.htm.

If you want to use this code in shareware or commercial application you
are entitled to register it. Registration fee is 30 USD per diferent
application project. Registered users are free to use code without need
to explicitly give credits to the author (but it is recommended). 
Registered users may not sell this source code unchanged or changed. 
Registration affects all previous versions of MPGTools.  This means if 
you use any version of MPGTools in your shareware or commercial 
application you must pay for registration.

Users from countries that invaded Yugoslavia or provided direct military 
or diplomatic support, teritory or air space for this puropose are 
required to pay 100 USD for humanitarian aid (does not matter if it is 
useed as freeware or commercial). That money should be sent to author 
who will transfer it to yugoslav humanitarian organizations. People who 
can prove they already sent aid to yugoslav victims o NATO agression are
free of this obligation.

Send us basic info about your application which uses MPGTools (name,
http/ftp url, archive length, short description) because we may put that
info and link on MPGTools homepage.

Freeware licence does not apply to sysops of SETNet - they are required
to pay 15 USD for using or distributing this source by any mean.

You are wellcome to send comments and suggestions to the Author.  You 
are also wellcome to support Author by donations of literature, tools, 
software or money but it is not reqired.

If you use this code please let us know.


Contact info:

mailto: mpgtools@dv.co.yu

Support is available only through email address writen above.  No other 
contact methods are allowed. Remember this *is* freeware project, 
therefore I cannot dedicate too much time and efforts to it. I will do 
my best to respond to any mail regarding this subject.

Updated info, new versions, supporting documentation and demo
applications in source code are available at
http://www.dv.co.yu/mpgscript/mpgtools.htm.


Author:
Predrag Supurovic
Dimitrija Tucovica 44/84
31000 Uzice
YUGOSLAVIA

Author's personal homepage: http://www.dv.co.yu/broker/


Beta test

Many thanks to Jean Nicolle, who voluntarily betatests this code and 
comes with good and valuable ideas almost every day.


Versions:

  1.8 (November 12, 1999.)
  - This source is no longer freeware for commercial use (shareware and
    commercial applications). It remains freeware for use in freeware
    applications.
  - In one of previous releases I announced that TMPEGAudio class is
    finished and that there is nothing left to improve. Well, I was wrong.
    This time new ideas came, and also I received few very valuable
    suggestions from users.
  - IMPORTANT ISSUE! Limited support to VBR (Variable BitRate) MP3 files
    proposed by Xing included. Library recognizes if file is VBR, and
    also tries to calculate duration, which may not be precise due to
    nature of this type of files). Many thanks to Eric from Xing Tech
    support who has been great help.
  - One notice: some time ago I had demand to expand FileName property to
    support long strings. I declined since it was complicated to implement.
    Recently, I did some tests and it seems to me that Windows reports error
    if you try to copy file with name longer than about 70 characters
    including path. MAX_PATH global agrees with this value. It seems, FileName
    property 255 characters long is more than sufficient.
  - In meanwhile I got new info about MPEG header specs. There were some
    wrong informations I had before about rarely used formats. Now it is more
    accurate.
  - Due to my efforts to make this library as much user friendly as possible I
    even added some predefined dialogs. Later I realized that including Dialogs
    unit in uses clausule enlarged compiled exe file a lot. It does not affect
    Windows applications that already use dialogs, but there are some users
    (including me) who use this library for developing DOS prompt applications
    and do not require such things like windows dialogs. They noticed monstruous
    enragement of their applications. I think I found a solution. There is
    special compiler directive $DEFINE UseDialogs. If UseDialogs is defined,
    compiler will include everything necessary for using dialogs. If it is not
    defined, Dialogs will be excluded from comilation an therefore executable
    will be significantly shorter. By default this directive is defined and you
    may find it as first thing in interface section of this unit. 
  - Import and export to PLS files added. PLS files are second format
    supported by WinAmp, and, as I understood it is also widely used.
  - mctComplexMacro type added. It allows you to define a macro as a string
    containing other macros. May be very powerful. This does not work in
    Delphi 1.
  - TMPEGAudio.SearchExactFileName property added (only for 32bit Delphi).
  - TMPEGAudio.SearchDrives property added (only for 32bit Delphi);
  - TMPEGAudio.FileNameShort property added. Returns DOS8+3 formated file name.
    Works only in 32bit Delphi.
  - Two new macros added (%ExtractedArtist% and %ExtractedTitle%). They are
    important for those who use tagless MPEG files. They usually store artist
    and title info in filename. These macros will try to extract that data. Global
    variable FileNameDataDelimiter is used as delimiter between artist and
    title. By default, this delimiter is '-' and it is supposed that file
    naming scheme is like Artist - Title.mp3 which is mostly the case.
  - TMacroDefinition class added. It allows easy adding new macros
    and assigning default values and functions that should be called
    to get value to replace macro. It also allows changing default
    values and functions for built in macros.
  - TMPEGAudio.FGetMPEGValue method removed. It was used internaly and it's
    of no use since now we have TMacroDefinition class.
  - TMPEGAudio.IsTagged readonly property added. It returns true if valid
    TAG exists in MPEG audio file.
  - TMPEGAudio.FFileDateTime property changed to be a method.
    This way I avoided redundancy.
  - TMPEGAudioList.ExportToWinAmpList and
    TMPEGAudioList.ExportToMPEGDataFile methods parameter syntax
    changed. SelectedOnly parameter added. It allows exporting only
    selected items.
  - Added support for Windows Regional settings. It now affects formatting
    of data when converted to string (TMPEGAudio.Textilize method).
  - %FileTime% macro default length changed to eleven characters
  - %FileDateTimeForSort% macro added. It shows file date and time
    formated suitable for sorting (yyyymmddhhmmss).
  - %DurationForm% macro changed not to show leading zeros for hours.
    Leading zero may be added by formatting (i.e. %DF,R,%,0)
  - %FilePathName% macro added. It concatenates file path and name so they may
    be formated as single item.
  - %GuessedArtistTitle% macro added. It tries to read values from TAG, filename
    and UnknownArtist/UnknownTitle properties in that order.
  - Lots of work has been done to intercept error conditions and make them
    easy available to application. This is much better now.
  - TMPEGAudio.OnReadError property added. This event will be trigered when
    error occures while reading MPEG audio file. By default it is set to
    MPEGFileLoadError function also provided in this unit. You can always
    change TMPEGAudio.OnReadError to point to some your function.
  - ShowMPEGAudioReadError property added to TMPEGAudioList. TMPEGAudioList
    uses internal TMPEGaudio object you cannot affect, but you will probably
    need to change their onReadError property. Thats what is
    TMPEGAudioList.ShowMPEGAudioReadError for. It's value will be assigned to
    OnReadError property of each internal TMPEGAudio object created. Default
    value is pointer to MPEGFileLoadError function provided in this unit.
  - AutoLoad property added. It affects behaviour of FileName.
    property. If True, it will cause FileName to behave like it did in
    previous versions. If False, data will not be loaded automatically.
    It is true by default.
  - LoadData method added. When called, it loads data, and returns error
    value (see OnLoadError)
  - TMPEGAudioList.UnknownArtist and TMPEGAudioList.UnknownTitle
    properties added.
  - TMPEGAudioList.MPEGAudioUnknownArtist and
    TMPEGAudioList.MPEGAudioUnknownTitle properties added.
  - WinAmp Genre codes added
  - Lots of monor changes has been made. I lost track to lost of them. I
    tried and I think I suceded not to change function interface except
    where it had to be done. You will probably notice one or two functions
    using different parameters, but all those changes are minor (actually,
    one function surfed total change, and that is because it was totaly
    unusable with previous definition).

  1.7. (5. October 1998.)

  - Another MPEG recognizing bugfixes. I must notice that all
    bugfixes deal with trashed MPEG files (it means, files
    containing non MPEG data at the begining). I test unit on
    MPEG files I created and they are all correct, but it seems
    on the Internet you may find everything. Thus, you, users of
    this unit are very important for bugfixing. As much MPEGs you
    try with this code, sooner we will find all posiible bugs.

  - Jean Nicolle showed up as an excellent beta tester. Not just
    he is very good in detecting bugs, he also makes very
    valuable suggestions. Therefore, I am appointing him as the
    first official MPGTools betatester.

  - FileDetectionPrecision property added to both TMPEGAudio and
    TMPEGAudioList class. It limits how many bytes of file will
    be searched for MPEG frame headers. That means you now may
    not allow object to search whole file attempting to find out
    if it is MPEG audio. I do not reccomended to use this, but
    it's here. It may be useful.

  - Behaviour of TMPEGAudio.Textilize method changed. NOW IT DOES NOT
    affect contents of TMPEGAudio.Macro and TMPEGAudio.Text properties.
    I found out that it was not suitable approach.

    TMPEGAudio.Textilize method may be called very often for other
    reasons (i.e. sorting utility) which should not affect contents
    of these two properties. Everything else regarding TMPEGAudio.Macro
    and TMPEGAudio.Text stays the same: whenever you change
    TMPEGAudio.Macro or any of writeable properties contents of the
    TMPEGAudio.Text will be updated automatically.

  - Bug in TMPEGAudio.Textilize fixed: when I changed Textilize not to
    alter contents of Macro and Text properties, I left Textilize read
    contents of Macro instead of string passed as parameter.

  - TMPEGAudio.FReadData, TagTMPEGAudio.WriteTag and
    TMPEGAudio.RemoveTag methods are changed. Now they are functions
    and returned result is error code.

  - Added types: TListSortCompare and TListSortCompareFunc.
    Added properties: SortMethod, UserSortCompareFunc property and
    SortMacro. Added methods: InternalSortCompareFunc,
    DoUserSortCompareFunc and DoSort. Now, user may specify if
    he wants list not to be sorted, to be sorted internaly (sort key
    specified in SortMacro) or externaly, by user defined function.

  - Added property: TMPEGAudioList.SortDirection, and few
    methods changed to support it. Now, user may set sort direction
    regardless of SortMethod used and there is no need for user
    functions for ascending and descending order.

  - I've detected bug with TMPEGAudioList sorting, but cannot fix it yet.
    To reporoduce The Bug, run MPGLIST demo, load some files to the list,
    set sort method to Internal, and enter '%aaa%' in the edit box. Click
    on sort button several times. You will notice that it sorts items
    erratically. It seems problem is in QuickSort function (which I took
    from source of TList object). Point is that %aaa% is not existing macro.
    Therefore, Textilize function does not convert it but returns same
    string. That is normal. Thus, TMPEGAudioList.InternalSortCompareFunc
    always compares same string regardless if items are different or not.
    It will always return zero result of comparation. That is also ok,
    and it means that QuickSort will think list is already sorted.
    But, there is a problem. For some reason QuickSort behaves
    unpredictable in such situation. It works well when it has to
    sort already sorted list. I assume, that, algorithm presumes if
    all items are equal there is no need to take care if their order
    will be corupted. I have to find a way to check if list is already
    sorted properly, and break Quicksort before it makes mess. I must
    admit I am not familiar with Quick Sort algorithm.

  - Help wanted. I received report that when compiling unit with
    Delphi 4 it shows warning that TMPEGAudioList.Create constructor
    should be overriden. I do not receive such warning in Delphi 3
    (I do not have Delphi 4). When I tried to override it, Delphi
    reported method is static and cannot be overriden. If anyone can
    provide solution I would appreciate it.


  1.6 (8. Sept. 1998)

  - I must apology to those who asked help about using this unit and I
    point them to "short example provided in documentation". I
    overseeked that I added that example after I published version 1.5
    and that it was not available until now.

  - TMPEGAudio now inherits TObject instead of TComponent.

  - Fixed bug not recognizing MPEG file properly reported by Jean
    Nicolle. It showed up that I had a bug but also that method used for
    validation was not good enough. Not just it was not able to
    recognize each MPEG file as such, but often recognized files which
    surely were not MPEG as MPEG. Now it checks for two frame headers
    in a row, which significantly reduces false recognitions. Any
    suggestions about improvements are welcome.

  - Added FirstValidFrameHeaderPosition property as result of previous
    bugfix.

  - Added Macro and Text property as replacement for Textilize method.
    Textilize method is still there and will not be removed. These two
    properties just may speed things up if you do not often change
    macros or MPEG data. This resulted with some small but numbered
    changes in property and method definitions, but nothing changed in
    syntax and functionality.

  - Few macro tag items changed and added to support new properties and
    structure changes.

  - TMPEGData.FileName field changed due to suggestion of Torben
    Weibert. Now it is string 255 chars long. Request was to make this
    field very long string, but I could not manage to do that without
    loosing compatibility with Delphi 1. I hope filepaths longer than
    255 characters are rare. If anyone needs it longer, and does not
    care about TMPEGData record length, he may simply change definition
    for this field.

  - Dealing with files not containing TAG changed a bit. If MPEG file
    does not contain TAG then TMPEGAudio.Data.Title field will be filled
    with MPEG filename (without path). This is same behaviour as
    WinAmp's.

  - Data structure of TMPEGData changed to version 1.2.

    o Padding field added so we can now calculate frame size.

    o SampleRate field type changed to LongInt to make it more
      compatible with other languages and compiler versions. Real type
      was very bad choice. WARNING! Now this field contains integer
      value of sampling rate in Hz not in kHz like previous versions.

    o FrameLength added. It stores framesize in bytes.

    o Version field now contains index to MPEG Version, not exact
      version number. This is done to support MPEG Version 2.5 which now
      has index of 3. Apropriate constants definition provided.

  - Finally I found out how to make TMPEGData record size independent of
    compiler version. Problem was not just with real type. I founded
    that Integer type length also changes. In Delphi 1 it is 2 bytes,
    but in Delphi 3 it is 4 bytes long. Since I needed two byte values
    in few fields, i replaced Integer type with word and everything is
    now ok. I am suspicious about LongInt (currently it is 4 bytes
    long). Anyone with Delphi 4, let me know is it still 4 bytes long?
    Funniest bug is TDateTime type. I am used to it since Borland Pascal
    where it was 8 bytes long record. In Delphi they changed it to real.
    Yes I was aware of that, but... Well, now I use LongInt instead.
    Note that TMPEGAudio.FileDateTime property still returns value as
    TDateTime. Conversion is done internaly. Remember that
    TMPEGAudio.FileDateTime and TMPEGAudio.Data.FileDateTime are not
    same type any more. If you need to read or write to
    TMPEGAudio.Data.FileDateTime directly, use FileDatetoDateTime() and
    DateTimetoFileDate() conversion functions provided with Delphi.

  - MPEG_VERSION* constants added due to support MPEG Version 2.5 files.

  - MPEG_VERSIONS constant array added to describe MPEG Version

  - MPEG_SAMPLE_RATES adjusted to support MPEG Audio Version 2.5 files

  - MPEG_BIT_RATES adjusted to support MPEG Audio Version 2.5 files

  - Added support for reading MPEG Audio files of Version 2.5. I have
    not tested it since I do not have any MPEG file of this version.

  - TMPEGAudio class is polished. It may be assumed finished. I think
    there will be no major changes in it.

  - This unit version presents TMPEGAudioList class. It should free you
    of using TList and dealing with pointers and typecasting. It is
    descendent of TList class and uses TMPEGAudio as base data structure.
    It is not well documented yet, but I am sure you will understand it
    by looking at class definition. Do not use it. It is here just to
    show you the basic idea. I cannot guarantee it will not be changed.
    Feel free to share your ideas about it with me. If you notice bad
    coding practice I used, do not hestitate to say it.

  - TMPEGAudioList.AddFromMPEGFile method is adjusted to recognize all
    three TMPEGData versions. It will return values according to the
    newest structure definition.

  - I have opened MPGTools support mail list. Anyone who wants
    membership may send me a mail. It is one way list for now. You will
    receive only news about updates I send. If you like, I can make all
    members receive messages other members sent to the list.

  - Together with this unit version I am publishing soruces of two
    simple applications TAG Editor and MPEG List to demonstrate how to
    use it.

  - Few typo's corrected. I am also sure I made few new typo's.


  1.5 (23. August 1998)

  - The first public version released
}


interface

{$DEFINE UseDialogs}

uses SysUtils, WinTypes, WinProcs, Classes, Messages, Controls,
     {$IFDEF UseDialogs}Dialogs, {$ENDIF}INIFiles;

const
  UnitVersion = '1.8';   { current version of this unit }

  MaxStyles = 125;        { number of supported Genre codes.
                           If code is greater it will be assumed unknown }

  { MPEG version indexes }
  MPEG_VERSION_UNKNOWN = 0; { Unknown     }
  MPEG_VERSION_1 = 1;       { Version 1   }
  MPEG_VERSION_2 = 2;       { Version 2   }
  MPEG_VERSION_25 = 3;      { Version 2.5 }

  { Description of MPEG version index }
  MPEG_VERSIONS : array[0..3] of string = ('Unknown', '1.0', '2.0', '2.5');

  { Channel mode (number of channels) in MPEG file }
  MPEG_MD_STEREO = 0;            { Stereo }
  MPEG_MD_JOINT_STEREO = 1;      { Stereo }
  MPEG_MD_DUAL_CHANNEL = 2;      { Stereo }
  MPEG_MD_MONO = 3;              { Mono   }

  { Description of number of channels }
  MPEG_MODES : array[0..3] of string = ('Stereo', 'Joint-Stereo',
                                        'Dual-Channel', 'Single-Channel');

  { Description of layer value }
  MPEG_LAYERS : array[0..3] of string = ('Unknown', 'I', 'II', 'III');

  {
    Sampling rates table.
    You can read mpeg sampling frequency as
    MPEG_SAMPLE_RATES[mpeg_version_index][samplerate_index]
  }
  MPEG_SAMPLE_RATES : array[1..3] of array[0..3] of word =
     { Version 1   }
    ((44100, 48000, 32000, 0),
     { Version 2   }
     (22050, 24000, 16000, 0),
     { Version 2.5 }
     (11025, 12000, 8000, 0));

  {
    Predefined bitrate table.
    Right bitrate is MPEG_BIT_RATES[mpeg_version_index][layer][bitrate_index]
  }
  MPEG_BIT_RATES : array[1..3] of array[1..3] of array[0..15] of word =
       { Version 1, Layer I     }
     (((0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,0),
       { Version 1, Layer II    }
       (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,0),
       { Version 1, Layer III   }
       (0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320,0)),
       { Version 2, Layer I     }
      ((0,32,48, 56, 64, 80, 96,112,128,144,160,176,192,224,256,0),
       { Version 2, Layer II    }
       (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0),
       { Version 2, Layer III   }
       (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0)),
       { Version 2.5, Layer I   }
      ((0,32,48, 56, 64, 80, 96,112,128,144,160,176,192,224,256,0),
       { Version 2.5, Layer II  }
       (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0),
       { Version 2.5, Layer III }
       (0, 8,16,24, 32, 40, 48, 56, 64, 80, 96, 112,128,144,160,0)));

  { Types of MPEG AUDIO DATAFILE }
  MPEG_DF_CUSTOM = 0;
  MPEG_DF_CATALOGUE = 1;
  MPEG_DF_ORDER_FORM = 2;

  { Description of MPEG AUDIO DATAFILE type }
  MPEG_DATAFILE_TYPES : array[0..2] of string = ('Custom','Catalogue',
                                                 'Order form');

  { Sign for MPEG Audio Datafile. This is used in MPEG Audio Datafile
    header to identify file as such. First eight bytes (i.e #9'MP3DATA')
    are file id, and rest two bytes are version and subversion numbers.
    Do not change it. }
{$J+}
  MPEG_DATAFILE_SIGN : string[9] = 'MP3DATA'+#01+#02;
{$J-}

  { File types that unit can recognize and read }
  FT_ERROR = -1;                 { Specified file does not exist,
                                   or error openning file }
  FT_UNKNOWN = 0;                { Unknown file type }
  FT_WINAMP_PLAYLIST = 1;        { WinAmp playlist (*.m3u) }
  FT_MPEG_DATAFILE = 2;          { MPEG Audio Datafile (*.m3d) }
  FT_MPEG_AUDIO = 3;             { MPEG Audio (*.mp*) }
  FT_PLS_PLAYLIST = 4;           { PLS Playlist (*.pls) }

  { Global variable containing delimiter used to separate artist from title
    in file name }
  FILENAMEDATADELIMITER : char = '-';

  { Xing VBR header flags }
  XH_FRAMES_FLAG = 1;
  XH_BYTES_FLAG = 2;
  XH_TOC_FLAG = 4;
  XH_VBR_SCALE_FLAG = 8;

var
  { Descriptions of Genre codes. Unit fills this array on initialization. }
  MusicStyle : array[0..MaxStyles] of string;

type

  { Xing VBR Header data structure }
  TXHeadData = record
    flags : Integer;     { from Xing header data }
    frames : Integer;    { total bit stream frames from Xing header data }
    bytes : Integer;     { total bit stream bytes from Xing header data }
    vbrscale : Integer; { encoded vbr scale from Xing header data }
  end;

  String3 = string[3];
  String4 = string[4];
  String30 = string[30];
  String20 = string[20];
  String79 = string[79];
  String255 = string[255];

  { MEGAUDIODATAFILE v1.1 header for Catalogue record definition. Same
    header counts for v1.2 header. Do not use this type definition
    directly. Use TMPEGDataCatalogue instead. }
  TMPEGDataCatalogue1v1 = packed record
    Title : string[30];              { Catalogue title }
    Publisher : string[30];          { Catalogue publisher name }
    City : String[30];               { Publisher's contact info }
    ZIP : String[10];
    Country : String[20];
    Address : String[30];
    Phone: String[15];
    Fax: string[15];
    Email: string[30];
    WWWURL: string[30];
  end;

  { Old header for Catalogue record used in MPEGAUDIODATAFILE v1.0
    definition.  Obsolete. Used internaly to make unit able to read old
    file version.  However, unit will never create old version file. }
   TMPEGDataCatalogue1v0 = record
    Title : string[30];
    Publisher : string[30];
    City : String[30];
    ZIP : String[10];
    Country : String[20];
    Address : String[30];
    Phone: String[15];
    Fax: string[15];
    Email: string[30];
    WWWURL: string[30];
  end;

  { Always use this type for header variable declaration. If structure
    changes in future, this type will point to the newest version. }
  TMPEGDataCatalogue = TMPEGDataCatalogue1v1;

  { MPEGAUDIODATAFILE v1.1 header for Order form record definition. Same
    definition counts for v1.2 header. Do not use this type directly.
    Use TMPEGDataOrder instead.}
  TMPEGDataOrder1v1 = packed record
    CustomerID : string[15];
    Name : string[30];
    City : String[30];
    ZIP : String[10];
    Country : String[20];
    Address : String[30];
    Phone: String[15];
    Fax: string[15];
    Email: string[30];
  end;

  { Always use this type for header variable declaration. If structure
    changes in future, this type will point to the newest version. }
  TMPEGDataOrder = TMPEGDataOrder1v1;

  { Definition for structure of MPEG AUDIO DATA records. Do not use it
    directly. Use TMPEGDATA type instead. }
  TMPEGData1v2 = packed record
    Header : String3;        { Should contain "TAG" if header is correct }
    Title : String30;        { Song title  }
    Artist : String30;       { Artist name }
    Album : String30;        { Album  }
    Year : String4;          { Year }
    Comment : String30;      { Comment }
    Genre : Byte;            { Genre code }
    Track : byte;            { Track number on Album }
    Duration : word;         { Song duration }
    FileLength : LongInt;    { File length }
    Version : byte;          { MPEG audio version index (1 - Version 1,
                               2 - Version 2,  3 - Version 2.5,
                               0 - unknown }
    Layer : byte;            { Layer (1, 2, 3, 0 - unknown) }
    SampleRate : LongInt;    { Sampling rate in Hz}
    BitRate : LongInt;       { Bit Rate }
    BPM : word;              { bits per minute - for future use }
    Mode : byte;             { Number of channels (0 - Stereo,
                               1 - Joint-Stereo, 2 - Dual-channel,
                               3 - Single-Channel) }
    Copyright : Boolean;     { Copyrighted? }
    Original : Boolean;      { Original? }
    ErrorProtection : boolean; { Error protected? }
    Padding : Boolean;       { If frame is padded }
    FrameLength : Word;      { total frame size including CRC }
    CRC : word;              { 16 bit File CRC (without TAG).
                               Not implemented yet. }
    FileName : String255;    { MPEG audio file name }
    FileDateTime : LongInt;  { File last modification date and time in
                               DOS internal format }
    FileAttr : Word;         { File attributes }
    VolumeLabel : string20;  { Disk label }
    Selected : word;         { If this field's value is greater than
                               zero then file is selected. Value
                               determines order of selection. }
    Reserved : array[1..45] of byte; { for future use }
  end;

  { Definition for structure of old MPEG AUDIO DATA v1.1 records.
    Obsolete.  Used internaly to allow reading files of older MPEG AUDIO
    DATAFILE version. }
  TMPEGData1v1 = packed record
    Header : String3;
    Title : String30;
    Artist : String30;
    Album : String30;
    Year : String4;
    Comment : String30;
    Genre : Byte;
    Track : byte;
    Duration : word;
    FileLength : LongInt;
    Version : byte;
    Layer : byte;
    SampleRate : real;
    BitRate : LongInt;
    BPM : word;
    Mode : byte;
    Copyright : Boolean;
    Original : Boolean;
    ErrorProtection : boolean;
    CRC : word;
    FileName : String79;
    FileDateTime : TDateTime;
    FileAttr : Integer;
    VolumeLabel : string20;
    Selected : word;
    Reserved : array[1..48] of byte;
  end;

  { Old MPEG DATA record definition used in MPEGDATAFILE v1.0. Obsolete.
    Used internaly to allow reading of older MPEG AUDIO DATAFILE
    version. }
  TMPEGData1v0 = record
    Header : String[3];
    Title : String[30];
    Artist : String[30];
    Album : String[30];
    Year : String[4];
    Comment : String[30];
    Genre : Byte;
    Track : Byte;
    Duration : Word;
    FileLength : LongInt;
    Version : byte;
    Layer : byte;
    SampleRate : real;
    BitRate : LongInt;
    BPM : word;
    Mode : byte;
    Copyright : Boolean;
    Original : Boolean;
    ErrorProtection : boolean;
    CRC : word;
    FileName : string[79];
    ListName : string[79];
    FileDateTime : TDateTime;
    FileAttr : Integer;
    VolumeLabel : string[20];
    Reserved : array[1..50] of byte;
  end;

  { Current definition for MPEG AUDIO DATA structure. This type will
    point to newest record definition in case of future changes.

    MPEG AUDIO DATA is basic structure. It consists of data read from
    MPEG TAG and MPEG HEADER of MPEG AUDIO FILE. }
  PMPEGData = ^TMPEGData;
  TMPEGData = TMPEGData1v2;

  (*

    MPEG AUDIO CLASS definition.

    This object contains data about single MPEG AUDIO FILE and methods
    for reading, manipulating and writing them back to file. It is based
    on TObject class which means it is not supposed to be used as
    component. Create this object runtime.

    Here is an short example:

    use MPEGTools;
    var
      MPEGFile : TMPEGAudio;

    begin
      { create object }
      MPEGFile := TMPEGAudio.Create;
      { load data for mp3 song }
      MPEGFile.FileName := 'mysong.mp3';

      { read data }
      TitleEditBox.Text := MPEGFile.Title;
      ArtistTextBox.Text := MPEGFile.Artist;

      { change TAG data }
      MPEGFile.Title := TitleEditBox.Text;
      MPEGFile.Artist := ArtistEditBox.Text;

      { write changes to file }
      MPEGFile.WriteTag;

      { free }
      MPEGFile.Free;
    end;

    Heart of TMPEGAudio object is Data property which is actual record
    structure of TMPEGData. It is declared public which means you
    have full read and write access to it. That is not reccomended.
    Prefer using published properties. Data property is public because
    you may need easier access to whole record while dealing with lists,
    especially if you need writing such records in a file, like MPEG
    AUDIO DATAFILE is.

    To easy for you access and dealing with lists there is a function
    DataPtr which returns pointer to object's Data property.

    Public properties are mostly based on Data record but with some
    exceptions. You will find some properties read only for simple
    reason that you actually may not change all data read from MPEG
    file. We will not describe all properties but those which need
    attention.

    IsValid returns true if MPEG file is recognized as such. This is
    done by checking some fields values. Should be reliable.

    FileName has special function. When reading its value you will
    actually get value of TMPEGAudio.Data.FileName field. But, when you
    try to set value of this property, it will set
    TMPEGAudio.Data.FileName field but also read data from specified
    filename into Data record. Use this to actually read MPEG file.
    FileName will not automatically read data from MPEG file if AutoLoad
    property is False. You will have to use LoadData method to load data
    manually. Oposite to FileName, LoadData returns error value, so use
    it if you need to know if error occured right after loading file.

    Macro string may contain macros (you will find out about macros
    below) in string form explained before. Use this to convert
    macros if you do not need it to be changed often. Each time you
    change contents of this property it will automatically update
    contents of Text property. This should be used if you need to
    occasionally get converted macro but not to change macros. Actual
    conversion will be done for the first time you set macro string,
    and you may read it from Text property several times. This may
    speed up your application if you use it instead of calling
    Textilize method each time.

    Text property is updated whenever change occure in Macro property
    or other writable object properties, this field will be updated
    with converted contents of Macro property. Text property will be
    changed only when real change occures, and class takes care of
    that. You just have to read value when you need it.

    You also have some method functions available.

    IsValidStr takes two strings as parameters, and returns one of them
    depending of Boolean value of IsValid property. Use it when you need
    to display 'Yes' or 'No' or something similar based on this
    property.

    Similar functions are CopyrightStr, OriginalStr and
    ErrorProtectionStr. They are based on Copyright, Original and
    ErrorProtection properties respectively.

    GenreStr returns string description of Genre property. It is more
    appropriate for displaying than Genre number code.

    DurationTime is based on Duration property and returns value of
    TDateTime type. Since Duration is measured in seconds, we provided
    DurationTime function to easy you displaying values in minutes and
    seconds. We did not make it return string value since time format
    may differ from application to application. You may use Delphi's
    FormatDateTime function to get string value from DurationTime.

    ModeStr returns string description of MPEG channel mode (Mode
    property). It returns one of four values ('Stereo'/'Joint
    Stereo'/'Dual Channel'/'Single Channel'). If you need just
    'Mono'/'Stereo' identification you are on your own. Hint: only
    'Single Channel' mode is Mono.

    WriteTag function writes data from object to TAG of MPEG file.

    RemoveTag removes tag information form MPEG file. You will notice
    that by '[no tag]' value in properties which belongs to TAG and
    Header property will have value 'BAD' (which does not mean that MPEG
    file is BAD, but just that TAG is missing. If you want to check if
    MPEG file is correct, use IsValid property)

    Textilize is most powerful function in this object. You are provided
    with complex macro structure you can use to convert MPEG data values
    to strings. All you have to do is to call Textilize function and
    give it a string paameter containing macros. It will return string
    value with macros converted to actual MPEG data. You should also
    take a look of Macro and Text properties.

    Here are some macro examples:

    '%Author,T% %Title,T% %DurationForm,T%'
    '%Author%%Title%%DurationForm%'
    'Author: %A,T% * Title: %T,T% * Duration: %DF,T%'

    Use them in TAGEDitor demo application (Macro definition box) to see
    how it works.

  *)

type
  TOnReadError = function (const MPEGData : TMPEGData) : word;
  { function called when error occures while reading MPEG data from file.
    This function should show error to user and ask for Retry, Cancel,
    Ignore. User choice should be returned as function value (mrRetry,
    mrCancel, mrIgnore }

  TMPEGAudio = class (TObject)
    private
      FData : TMPEGData;
        { TMPEGData structure. Use it if you need direct access to whole
          record. Otherwise, use class properties to read and write
          specific fields }
      FFileDetectionPrecision : Integer;
      FUnknownArtist : string30;
      FUnknownTitle : string30;
      FAutoLoad : Boolean;
        { if true data will be automatically loaded by FSetFileName }
      FOnReadError : TOnReadError;
        { Read error event }
      FFirstValidFrameHeaderPosition : LongInt;
      FMacro : string;
        { This field contains macro definition }
      FText : string;
        { this field contains converted macros }
      FSearchDrives : byte;
      function FFileDateTime : TDateTime;
        { File date time in TDateTime type. Converted
          value of data.FileDateTime }
      procedure FSetMacro (MacroStr : string);
        { this method sets FMacro field and recalculates FText }
      procedure FSetFileName (inStr : string);
      function FGetFileName : string;
      {$IFNDEF VER80}
      function FGetFileNameShort : string;
      {$ENDIF}
      function FGetSearchExactFileName : string;
      function FGetIsValid : Boolean;
      function fGetIsTagged : Boolean;
      function FReadData : Integer;
        { Read data from file specified in FileName. If error happens,
          and onReadError is not nil it will call onReadError
          to see what to do. If onReadError returns mrRetry it will again
          try to load data from file. Return value is 0 if no error, mcCancel
          or mrIgnore if onReadError returns one of these values, and -1 if error occures but
          onReadError is nil but error occured (this will allow application to handle error
          conditions). Generally, any return value different than 0
          should be considered as an error condition. mrCancel means your
          application should abort whole process where error occured, and
          mrIgnore that your application should skip only file which caused an
          error and continue process. }
      procedure FSetArtist (inString : string30);
      function FGetArtist : string30;
      procedure FSetTitle (inString : string30);
      function FGetTitle : string30;
      procedure FSetAlbum (inString : string30);
      procedure FSetYear (inString : string4);
      procedure FSetComment (inString : string30);
      procedure FSetVolumeLabel (inString : string20);
      procedure FSetGenre (inByte : byte);
      procedure FSetTrack (inByte : byte);
      procedure FSetSelected (inWord : word);

    public
      constructor Create; { create object }
      procedure ResetData; { resets Data field to zero values }
      property FileDetectionPrecision : Integer
        read FFileDetectionPrecision
        write FFileDetectionPrecision;
        { When attempting to recognize MPEG audio file, object will
          search through file trying to find two valid frame headers
          in a row. If file is correct, they will be found very fast,
          but if file is not MPEG then it will be searched up to it's
          end, and that may take a time. Setting this field to value
          greater than zero, you may specify number of bytes that
          should be searched. If object does not find proper headers
          in speified number of bytes, it will assume file invalid.
          If this property is zero, file will be searched from the
          first to the last byte. We do not reccomend you to use this,
          but if you need you may. }
      property AutoLoad : Boolean read FAutoLoad write FAutoLoad;
        { If set to true setting FileName property will automatically
          load data from file. It is True by Default. If it is False you have to
          use LoadData method to actualy load data from file. }
      property IsValid: Boolean read FGetIsValid;
        { True if MPEG audio file is correct }
      function IsValidStr (const IsValidTrue, IsValidFalse : string) : string;
        { Returns input value according to Original field value. }
      property FirstValidFrameHeaderPosition : LongInt
               read FFirstValidFrameHeaderPosition;
        { Contains file position (in bytes) of the first valid frame
          header found. That means, data before this byte is not
          recognized as valid MPEG audio. It may be considered trashed
          or some other header data (WAV envelope, ID3v2 TAG or
          something like that). If value is equal or greater than
          FileLength then valid header is not found. But in that case,
          IsValid should return False anyway. }

      property isTagged : Boolean read fGetIsTagged;
      { return true if mpeg audio file contains valid TAG }

      property Header : String3 read FData.Header;
     { contents of TAG header }

      property Title : String30
               read FGetTitle
               write FSetTitle;
      { song Title }
      property UnknownTitle : string30
               read FUnknownTitle
               write FUnknownTitle;
     { Value that should be returned if Title field in tag is empty.
       By default it is empty string. }
      property Artist : String30
               read FGetArtist
               write FSetArtist;
         { Artist name }
      property UnknownArtist : string30 read FUnknownArtist write FUnknownArtist;
         { Value that should be returned if Artist Name field in tag is empty.
           By default it is empty string. }
      property Album : String30 read FData.Album write FSetAlbum;
         { Album  }
      property Year : String4 read FData.Year write FSetYear;
         { Year }
      property Comment : String30 read FData.Comment write FSetComment;
         { Comment }
      property Genre : Byte read FData.Genre write FSetGenre;
         { Genre code }
      function GenreStr : string;
         { Genre description }
      Property Track : byte read FData.Track write FSetTrack;
         { Track number on Album }
      property Duration : word read FData.Duration;
         { Song duration in seconds }
      function DurationTime : TDateTime;
         { Song duration time }
      property FileLength : LongInt read FData.FileLength;
         { File length }
      property Version : byte read FData.Version;
         { MPEG audio version index }
      function VersionStr : string;
          { MPEG audio version description }
      property Layer : byte read FData.Layer;
         { Layer (1 or 2. 0 - unknown) }
      function LayerStr : string;
         { Layer description }
      property SampleRate : LongInt read FData.SampleRate;
         { Sampling rate }
      property BitRate : LongInt read FData.BitRate;
         { Bit Rate }
      property FrameLength : Word read FData.FrameLength;
        { Total length of MPEG frame including CRC }
      property BPM : word read FData.BPM;
        { Bits per minute - for future use }
      property Mode : byte read FData.Mode;
        { Number of channels (0 - Stereo, 1 - Joint-Stereo,
          2 - Dual-channel, 3 - Single-Channel) }
      function ModeStr : string;
        { Channel mode description }
      property Copyright : Boolean read FData.Copyright;
        { Copyrighted? }
      function CopyrightStr (const CopyrightTrue,
                                   CopyrightFalse : string) : string;
        { Returns input value according to Copyright field value. }
      property Original : Boolean read FData.Original;
        { Original? }
      function OriginalStr (const OriginalTrue,
                                  OriginalFalse : string) : string;
        { Returns input value according to Original field value. }
      property ErrorProtection : boolean read FData.ErrorProtection;
        { Error protected? }
      function ErrorProtectionStr (const ErrorProtectionTrue,
                                         ErrorProtectionFalse : string)
                                         : string;
        { Returns input value according to ErrorProtection field value. }
      property Padding : Boolean read FData.Padding;
        { If frame size padded }
      property CRC : word read FData.CRC;
        { 16 bit File CRC (without TAG) }
      property FileName : string read FGetFileName write FSetFileName;
        { MPEG audio file name. When set it automatically reads all
          other data from file }
      {$IFNDEF VER80}
      property FileNameShort : string read FGetFileNameShort;
        { Return MPEG audio file name in DOS 8+3 format. Read only.
          File must exists.}
      {$ENDIF}
      {$IFNDEF VER80}
      property SearchDrives : byte read FSearchDrives write FSearchDrives;
        { Bitwise selection of drives that may be used for obtaining
          value of SearchExactFileName. See Drive indicator constants.
          Default value is DI_ALL_DRIVES. }
      {$ENDIF}
      property SearchExactFileName : string
        read FGetSearchExactFileName;
        { Try to find where field is based on volume label info. This
          is good when files are moving from disk to disk, and especially
          if they are on removable media like CD-ROM. If volume label
          cannot be found, result is the same as FileName property}
      property LoadData : Integer read FReadData;
        { Reading this method will load data from file and return eror value.
          You may use it in any moment, but if AutoLoad property is False
          you must call it after setting FileName property to actually
          load data from file. See FReadData for Return values. }
      property OnReadError : TOnReadError
               read FOnReadError
               write FOnReadError;
        { user definable function that will be called when error
          occures while reading MPEG file. OnReadError should
          show dialog box explaining error to user and asking him
          to choose what to do by clicking Cancel, Retry or Ignore button.
          Return values must be accordingly: mrCancel, mrRetry or mrIgnore }
      property FileDateTime : TDateTime read FFileDateTime;
        { File last modification date and time }
      property FileAttr : Word read FData.FileAttr;
        { File attributes }
      property VolumeLabel : string20
               read FData.VolumeLabel
               write FSetVolumeLabel;
        { Disk label }
      property Selected : word read FData.Selected write FSetSelected;
        { If this fields value is greater than zero then file is
          selected. Value determines order of selection. }
      function SelectedStr (const SelectedTrue,
                                  SelectedFalse : string) : string;
        { Returns input value according to Selected field value. }
      property Data : TMPEGData read FData write FData;
        { returns MPEG AUDIO DATA record }
      function DataPtr : PMPEGData;
        { Returns pointer to MPEG AUDIO DATA record }
      function WriteTag : Integer;
        { Write TAG to file. Returns -1 if file does not exists,
          zero if successful and IOResult code if not successful }
      function RemoveTag : Integer;
        { Remove TAG from file. Return result same as WriteTag }
      property Macro : string read FMacro write FSetMacro;
        { You can read defined macro string or set new one. Macro string
          may contain macros in string form explained before. Use this
          to convert macros if you do not need it to be changed often.
          Each time you change contents of this property it will
          automatically update contents of Text property. This should
          be used if you need to occasionally get converted macro but
          not to change macros. Actual conversion will be done for the
          first time you set macro string, and you may read it from
          TMPEGAudio.Text property several times. This may speed up
          your application if you use it instead of calling
          TMPEGAudio.Textilize method each time. }
      property Text : string read FText;
         { Whenever change occure in TMPEGAudio.Macro property or other
           writable object properties, this field will be updated with
           converted macros from Macro property. Text property will be
           changed only when real change occures, and class takes care
           of that. You just have to read value when you need it. }
      function Textilize (MacroStr : string) : string;
        { Replace macros with string values based on MPEG data. This
          forces macro conversion on each call. Avoid using it. Set
          Macro property instead and read Text property whenever you
          need converted data. }
  end; { class TMPEGAUDIO }


  { these are functions used to calculate macro values. You may use
    them directly if you want to gain more speed (macro parsing
    can be slow). Do not remember to trim results since they are zero
    padded}
  function GetMPEGFileName (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGFilePath (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGVolumeLabel (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGTitle (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGExtractedArtist (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGExtractedTitle (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGFileDate (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGFileDateTimeforSort (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGFileTime (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGArtist (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGAlbum (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGYear (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGComment (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGGenre (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGGenreNr (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGTrack (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGDuration (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGDurationComma (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGDurationMinutes (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGDurationMinutesComma (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGDurationForm (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLength (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLengthComma (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLengthKB (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLengthKBComma (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLengthMB (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGVersion (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLayer (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGLayerNr (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGSampleRate (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGSampleRateKHz (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGBitRate (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGErrorProt (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGErrorProtA (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGCopyright (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGCopyrightA (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGOriginal (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGOriginalA (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGMode (const MPEGAudio : TMPEGAudio) : string; far;
  function GetMPEGStereo (const MPEGAudio : TMPEGAudio) : string; far;
  function GetProgramVersion : string; far;
  function GetCurrentSystemDate : string; far;
  function GetCurrentSystemTime : string; far;

type
  { User defined function of TShowProgressFunc type may be used by unit
    to show progress of reading files. TagData is value of current MPEG
    DATA record.  Function may read any info from it. ListName is name
    of list. Counter shows current count of processed files, and
    MaxCount is number of files that will be processed. Form that
    displays progess should have Cancel button. Funtion should return
    False if user canceled progressing.

    We suggest you not to use this function to actually display progress
    form, but to change values of already openned form.

    Since this function will be usually called from loop, which may have
    large number of iterations, unit will release some time to let
    Windows process system messages. If it does not work correctly (if
    you cannot click Cancel button for instance), it is advisable for
    you to put Application.ProcessMessages call in your function.
  }
  TShowProgressFunc = function (const TagData : TMPEGAudio;
                                const ListName : string;
                                Counter : Integer;
                                MaxCount : Integer) : Boolean;

  { User defined function of TShowProgressError type may be used by unit
    to show error while processing. FileName is name of file which
    processing failed. This function will be called only when trying to
    load data from file. If file is Winamplist or MPEG DataFile it will
    be called only when error ocurrs openning that file, not files inside
    of it.

    Form should be modal and have Cancel, Retry, Ignore buttons. Function
    should return Modal result of form closing.
  }
  TShowProgressErrorFunc = function (const FileName : string) : Word;

  { User defined function of TShowExportProgressFunc will be used by
    unit to show export progress. It is similar to TShowProgrsFunc but
    with less input parameters.
  }
  TShowExportProgressFunc = function (const TagData : TMPEGAudio;
                                            Counter : Integer) : Boolean;


  { User defined function for comparing sorted items in list has input
    pointers to two compared items and returns 0 if items are equal,
    >0 if Item1 > Item2 or <0 if Item1 < Item2. Here are two types, one
    function, and the other object method. }
  TListSortCompare = function (Item1, Item2: Pointer): Integer of object;
  TListSortCompareFunc = function (Item1, Item2: Pointer): Integer;

  { User defined function for showin sort progress }
  TShowSortProgressFunc = procedure (currItem : Integer);

  { TSortMethod type defines sorting method used for TMPEGAudioList.
    smNone - list isnot sorted
    smInternal - list is sorted by internal rules (Artist+Title);
    smUser - List is sorted by user funtction assigned to
             UserSortCompareFunc property }

  TSortMethod = (smNone,smInternal,smUser);


  TSortDirection = (srtAscending, srtDescending);

  (*

  DEFINITION OF TMPEGAUDIO LIST CLASS

  Next issue to dealing with MPEG files is dealing with large number of
  MPEG files. This class should provide you simplified method to colect
  data about MPEG files and access them through list object. It
  inherites TObject class and expands it with specific methods and
  properies.

  TMPEGAudioList is not component. You should manually define variable
  of this type and create object by calling TMPEGAudioList.Create
  method.

  Main advantage is that you are free of allocating/releasing memory for
  MPEG record data and type casting. It uses TMPEGAudio class as basic
  data strucutre, thus allowing you to use all its properties and
  methods.

  You can add MPEG data in several ways:

    o by adding data from existing TMPEGAudio object (TMPEGAudioList.Add
      method),

    o by specifying MPEG filename (TMPEGAudioList.AddFile method),

    o by specifying WinAmp playlist (TMPEGAudioList.AddFromWinAmpList)

    o by specifying MPEG Datafile (TMPEGAudioList.AddFromMPEGDatafile)

  You can define custom functions which will be called on each iteration
  when importing or exporting data from several files or in case of
  reading error (ShowProgressFunc, ShowProgressErrorFunc and
  ShowExportProgressFunc properties).

  Also you can save data from list to file in WinAmp playlist
  (TMPEGAudioList.ExportToWinAmpList method), or MPEG Datafile
  (TMPEGAudioList.ExportToMPEGDatafile method).

  You can acces single items (MPEGAudio objects) through
  TMPEGAudioList.Items property. Current number of items can be obtained
  through TMPEGAudioList.Count method.

  If you need to determine type of some file, use
  TMPEGAudioList.GetfileType method. It can recognize MPEG Audio files,
  WinAmp playlists and MPEG datafiles. It may be useful when you alow
  browsing for all three file types a the same time.

  This is not finished class. For now, only basic methods are done, but
  I plan to do more especialy methods for sorting, dealing with
  duplicates and macros, selections etc... Your ideas are welcome.

  *)

  TMPEGAudioList = class (TList)
    private
      MPEGFile : TMPEGAudio;
      FShowProgressFunc : TShowProgressFunc;
      FShowProgressErrorFunc : TShowProgressErrorFunc;
      FShowMPEGAudioReadError : TOnReadError;
      FMPEGAudioUnknownArtist : string30;
      FMPEGAudioUnknownTitle : string30;
      FShowExportProgressFunc : TShowExportProgressFunc;
      FSortMethod : TSortMethod;
      FSortDirection : TSortDirection;
      FSortMacro : string;
      FUserSortCompareFunc : TListSortCompareFunc;
      FShowSortProgressFunc : TShowSortProgressFunc;
      FFileDetectionPrecision : Integer;
      function InternalSortCompareFunc (Item1, Item2: Pointer): Integer;
      function DoUserSortCompareFunc (Item1, Item2: Pointer): Integer;
      function FGetMPEGAudio(IndexNr : integer) : TMPEGAudio;
    public
      property ShowProgressFunc : TShowProgressFunc
               read FShowProgressFunc
               write FShowProgressFunc;
      property ShowProgressErrorFunc : TShowProgressErrorFunc
               read FShowProgressErrorFunc
               write FShowProgressErrorFunc;
      property ShowMPEGAudioReadError : TOnReadError
               read FShowMPEGAudioReadError
               write FShowMPEGAudioReadError;
      property MPEGAudioUnknownArtist : string30
               read FMPEGAudioUnknownArtist
               write FMPEGAudioUnknownArtist;
      property MPEGAudioUnknownTitle : string30
               read FMPEGAudioUnknownTitle
               write FMPEGAudioUnknownTitle;
      property ShowExportProgressFunc : TShowExportProgressFunc
               read FShowExportProgressFunc
               write FShowExportProgressFunc;
      property ShowSortProgressFunc : TShowSortProgressFunc
               read FShowSortProgressFunc
               write FShowSortProgressFunc;
      constructor Create;
      function Add (NewItem : TMPEGData) : Integer;
        { Add new item of TMPEGData type }
      function AddFromAnyFile (AnyFileName: string) : Integer;
        { Add informations from any type of file. It checks file
          type before loading and calls apropriate method. Returned
          value shows 0 if no error, -1 if file type is not recognized or
          error occured while reading file, -2 if user asked you to cancel
          operation }
      function AddFile (NewFileName : string) : Integer;
        { Add informations about single MPEG file. Return value is 0 if no
          error, -2 if user asked you to cancel whole operation and -1 for
          all other errors }
      function AddFromWinAmpList (PlayListName : string) : Integer;
        { Add informations from MPEG files listed in WinAmp list file.
          Return 0 if everything OK, -1 if error, and -2 if user
          canceled. }
      function ExportToWinAmpList (outfilename : string;
                                   ToAppend,
                                   RelativePath,
                                   ExportValid,
                                   SelectedOnly : Boolean) : Integer;
        { Export data to WinAmp type playlist. If ToAppend is true,
          append to existing file. If RelativePath, write file paths
          realtive to playlist path, If ExportValid then export data
          only for valid files. If SelectedOnly is true then only
          selected items will be exported. Return 0 if everything OK,
          -1 if error, and mrCancel if user canceled. }

      function AddFromPLSList (PlayListName : string) : Integer;
      function ExportToPLSList (outfilename : string;
                                ToAppend,
                                RelativePath,
                                ExportValid,
                                SelectedOnly : Boolean) : integer;

      function AddFromMPEGDatafile (DataFileName : string;
                                    var AppID : String;
                                    var HeaderStructType : byte;
                                    var HeaderStructLength : word;
                                    var HeaderStructPtr : pointer) : Integer;
        { Add informations from MPEG Audio Datafile to list. Reads
          Catalogues and Order Forms. Can recognize and load older file
          versions. Returns negative number if error reading file,
          mrNone if ok, and mrCancel if user cancels }

      function ExportToMPEGDataFile (outfilename : string;
                                     ToAppend,
                                     RelativePath,
                                     ExportValid,
                                     SelectedOnly : Boolean;
                                     AppID : string255;
                                     HeaderStructType : byte;
                                     HeaderStructLength : word;
                                     HeaderStructPtr : pointer) : Integer;
        { Export informations from list to MPEG Audio Datafile. If
          ToAppend is true, append to existing file. If RelativePath,
          write file paths relative to playlist path, If ExportValid
          then export data only for valid files. If SelectedOnly is true
          then only selected items will be exported. AppId is
          application id that should be stored to m3d header.
          HeaderStructType is type of header, HeaderStructLength is
          length of header in bytes and HeaderStructPtr is pointer to
          header data that should be stored to m3d file (Check m3d file
          structure document for details). Return 0 if everything OK,
          -1 if error, and mrCancel if user canceled. }

      procedure Clear; override;
        { Clear contents of the list }
      function Count : Integer;
        { Return number of items in the list }
      function SelectedCount : Integer;
        { Return number of selected items }
      procedure Delete (Index : Integer);
        { remove Item from the list by index }
      (* destructor Destroy; override;{ virtual; } *)
        { Destroy object }
      destructor destroy; override;
        { Free memory allocated by object }
      property FileDetectionPrecision : Integer
        read FFileDetectionPrecision
        write FFileDetectionPrecision;
        { When attempting to recognize MPEG audio file, object will
          search through file trying to find two valid frame headers
          in a row. If file is correct, they will be found very fast,
          but if file is not MPEG then it will be searched up to it's
          end, and that may take a time. Setting this field to value
          greater than zero, you may specify number of bytes that
          should be searched. If object does not find proper headers
          in speified number of bytes, it will assume file invalid.
          If this property is zero, file will be searched from the
          first to the last byte. We do not reccomend you to use this,
          but if you need you may. }
      function GetFileType (FileName : string) : Integer;
        { Find out type of FileName. Returns FT_UNKNOWN,
          FT_WINAMP_PLAYLIST, FT_MPEG_DATAFILE, FT_MPEG_AUDIO }
      procedure Insert (Index : Integer; NewItem : pointer);
        { Insert new item to the list. New itemmust be pointer
          to TMPEGAudio class type }
      property Items[IndexNr : integer] : TMPEGAudio read FGetMPEGAudio;
        { Indexed access to the Items of the list }
      property SortMethod : TSortMethod read FSortMethod write FSortMethod;
        { Method used for sorting. It may be:
           smNone     - do not sort even if sort method is called
           smUser     - sort by user function specified by
                        UserSortCompareFunc property
           smInternal - use Internal sort based on contents of
                        SortMacro property
        }
      property SortDirection : TSortDirection read FSortDirection write FSortDirection;
        { If true, sort in descending order }
      property UserSortCompareFunc : TListSortCompareFunc
               read FUserSortCompareFunc
               write FUserSortCompareFunc;
        { if SortMethod property is smUser, this property should point to
          user defined function of TListSortCompareFunc type which should
          be used to compare Items }
      property SortMacro : string read FSortMacro write FSortMacro;
        { string value used as sort macro. It is used when SortMethod
        property value is smInternal }
      procedure Sort (Compare: TListSortCompare);
        { method which actually sorts list. We do not recommend it's
        direct use. It's here just for compatibility purpose. Use
        SortMethod property and DoSort method }
      procedure DoSort;
        { methich which sorts list according to SortMethod settings }
      procedure Remove (ItemPtr : pointer);
        { Remove item from the list by pointer }
  end; { TMPEGAudioList class }


  { TMPEGReport class }

  { Definition for single Template record. This has been separated from class to allow saving templates
    in binary files as records }
  TTemplateData = record
      Name : string;              { template name }
      Ext : string;               { default extension for output documents.
                                    If you specify complete file name (with
                                    or without path) it will be used }
      IncludeHeader : Boolean;    { If header file or header style should be included in output file }
      FilterData : Boolean;       { if data should be filtered before generating output document. Not implemented yet. }
      FilterDataStyle : string;   { filter key. Not implemented yet }
      SortData : Boolean;         { if data should be sorted before creating output document }
      SortDataStyle : string;     { sort key }
      SortDescending : Boolean;   { if sort should be in descending order }
      GroupData : Boolean;        { if data grouping should be used }
      GroupDataStyle : string;    { group key }
      RunProgram : Boolean;       { if some application should be activated after generating document }
      HeaderFile : string;        { path and name of file that should be included at the top of output document }
      Footerfile : string;        { path and name of file that should be included at the bottom of output document }
      HeaderStyle : string;       { style for document header }
      GroupHeaderStyle : string;  { style for group header }
      BodyStyle : string;         { style for document body }
      GroupFooterStyle : string;  { style for group footer }
      FooterStyle : string;       { style for document footer }
      ProgramFile : string;       { path and executable name (see RunProgram }
      ProgramStyle : string;      { style for command parameters (see RunProgram) }
  end;

  TTemplate = class
    public
      Data : TTemplateData;
      constructor Create;
      procedure Reset;
  end;

  { ShowSortBeginProc will be called prior to start of sort process.
    ShowSortEndProc will be called after sort process is finished.
    TMPEGAudioList.ShowSortProgressFunc will be called to show sort progress.
    }
  TShowSortBeginProc = procedure (StartValue, MaxValue: Integer);
  TShowSortEndProc = procedure;

  { TMPEGReport Class - TO BE IMPLEMENTED }
  TMPEGReport = class (Tlist)
      fTemplate : TTemplate;
      fOutputFileName : string;
      fRecordNo,
      fGroupNo,
      fGroupRecordNo,
      fGroupRecordCount,
      fGroupCount,
      fArtistCount : LongInt;
      fGroupDurationSum,
      fDurationSum : LongInt;
      fGroupLengthSum,
      fLengthSum : Double;
      fMPEGAudioList : TMPEGAudioList;
      fOutput : TStringList;

      fShowSortBeginProc : TShowSortBeginProc;
      fShowSortEndProc : TShowSortEndProc;
      procedure fSetMPEGAudioList (NewMPEGAudioList : TMPEGAudioList);
      procedure fSetTemplate (NewTemplate : TTemplate);
    public
      constructor Create;
      destructor Destroy; override;
      property MPEGAudioList : TMPEGAudioList
        read fMPEGAudioList
        write fSetMPEGAudioList;
        { MPEGAudio list used for generated report }
      property Template : TTemplate
        read fTemplate
        write fSetTemplate;
        { template used to generate report }
      property OutputFileName : string
        read fOutputFileName
        write fOutputFileName;
        { name of output file }
      property RecordNo : LongInt
        read fRecordNo;
        { number of current record }
      property GroupNo : LongInt
        read fGroupNo;
        { number of current group }
      property GroupRecordNo : LongInt
        read fGroupRecordNo;
        { number of record in current group }
      property GroupRecordCount : LongInt
        read fGroupRecordCount;
        { number of records in current group }
      property GroupCount : LongInt
        read fGroupCount;
        { number of groups in whole report }
      property ArtistCount : LongInt
        read fArtistCount;
        { number of artists in whole record }
      property GroupDurationSum : LongInt
        read fGroupDurationSum;
        { duration of files in current group }
      property DurationSum : LongInt
        read fDurationSum;
        { duration of all files in report }
      property GroupLengthSum : Double
        read fGroupLengthSum;
        { length of files in current group }
      property LengthSum : Double
        read fLengthSum;
        { length of all files in report }
      property ShowSortBeginProc : TShowSortBeginProc
        read fShowSortBeginProc
        write fShowSortBeginProc ;
      property ShowSortEndProc : TShowSortEndProc
        read fShowSortEndProc
        write fShowSortEndProc ;
      property Output : TStringList
        read fOutput;
        { Output text will be stored in this property }
      procedure Reset;
        { reset object to initial state }
      procedure BeginReport;
        { begin generating report. This procedure counts and calculates
          initial values and creates header }

  end;


type
    (*
    Here is an explanation about whole mechanism as we provided with
    MPGScript application (you can get if from http://www.dv.co.yu/mpgscript/)
    to see how this thing can be powerfull in real application. Note,
    TMPEGAudioList supports more macros because it deals with lists of mpeg
    files. TMPEGAudio object supports all macros that are possible to read
    from single mpeg audio file. Other macros are supported in TMPEGAudioList
    object which deals with lists of files. Here, we will give you list of
    all tag items but only those in AUDIO FILE DATA, and some of SPECIAL
    CODES are supported by this object. Take a look to source of GetMPEGValue
    function.

    MACROS

    Tag item is single information that can be read, counted or
    calculated from mpeg audio file or filelist. You can use it to
    define exact contents and look for style properties of template
    definitions. General syntax for single tag item is

    %<tagid>[,<alignment>][,<length>][,<padchar>]%

    Tag item definition must begin and end with a percent sign (%). If
    you want percent sign to be showed in output list put two percent
    signs with no characters or space characters between them (look for
    special codes further in this document). Tag item cannot contain
    other TagItem.

    <tagid> defines which information you want to be shown in list,
    <alignment> defines how you would like information to be aligned,
    <length> is number of characters information should be aligned in,
    and <padchar> is character which should be used to pad empty space
    if information is shorter than reserved number of characters.
    Delimiter for item definition elements is comma (,) sign.

    Only <tagid> is required in item definition. Alignment, length and
    padchar may be omitted and in that case, default values will be
    used. Defaults for alignment and length depend of each tagid used,
    but padchar always defaults to space character (ASCII 32).

    TAG IDENTIFICATION

    Tag descriptions (tagid) may be divided in three groups: (1)
    informations that can be read from mpeg audio file or Winamp file
    list, (2) calculated or counted informations and (3) special codes.
    You can use short or long tagid.

    You can find complete of macros in separate file. It changes quite
    often and it is hard to maintan it here.

    If tag element is not recognized as any of defined tags it will not
    be replaced with any data but used as text. That allows you to align
    text due to your needs (i.e if you need title to be centered tag
    item would be:

    %This is title,C,70%


    ALIGNMENT

    Alignment may be defined for each tag. If not specified, default
    value depends from tag to tag, and you may see it in table above.
    Valid values for <alignment> are:

       L - left, no default length
       R - right, default length depends on tag
       C - centered, default length depends on tag
       T - trimmed, no default length

    LENGTH

    Item length defines number of characters to align data in. If
    information consists if more characters than specified length, it
    will be trimmed to specified length. If length is not specified
    default data length will be used execept for left alignment where
    actual data length will be used. If length is specified as zero,
    default length will be used regardless alignment. For Windows 3.xx
    version <length> cannot be greater than 255 characters.

    PADDING

    Padding character is character which will be used to fill space if
    information is shorter than specified length. If this element is not
    specified always defaults to <space> (ASCII 32). Specify exact
    character, not it's ASCII code.
    *)

 { this type determines which data type macro represents }
  TMacroDataType = (mctMPEGAudio,       { TMPEGAudio type must be passed }
                    mctNoExec,          { No function will be called even
                                          if assigned. This is used for macros
                                          handled internaly (newline, tab...)}
                    mctSpecial,         { No input parameters needed. Used
                                          mostly for system data, like current
                                          date and time }
                    mctMPEGReport,      { Data passed to function are
                                          calculated in report. Not implemented
                                          yet. }
                    mctComplexMacro);   { Data pased references other macros in
                                          string. This allows you to have single
                                          macro that conatins data of several
                                          other macros. Be careful. If you add
                                          macro in it's own definition, system will crash.
                                          This macro type does not work in Delphi 1.}

  TMacroDataSet = set of TMacroDataType;

  { this type contains definition for a single macro. Macros are organized
    in TMacroDefinition class based on TList }
  TMacro = class
    ShortName,                  { short name of macro }
    LongName : string;          { long name of macro }
    DefaultLength : Integer;    { default output string length }
    DefaultAlignment : char;    { default alignment of data }
    DefaultCapitalization : char; { default capitazlization of data }
    Description,                { description of macro (to be shown to users) }
    Cathegory : string;         { cathegory, group where macro belongs,
                                  for displaying purpose}
    MacroType : TMacroDataType; { type of data that should be passed to
                                  callback function }
    ValueProc : pointer;        { Pointer to callback function }
    CustomString : string;      { Custom string. For mctComplexMacro here should
                                  be complex macro definition }
  end;

  { These are definitions for macro resolving functions. }
  { TGetMPEGAudioValue function demands TMPEGAudio value as parameter
     and returns string value }
  TGetMPEGAudioValue = function (MPEGData : TMPEGAudio) : string;
  { TGetMPEGReportValue functions demands TMPEGReport value as parameter and
    returns string }
  TGetMPEGReportValue = function (MPEGReport : TMPEGReport) : string;

  { TGetSpecialt type function asks no parameters and returns string }
  TGetSpecialValue = function : string;

  { this is a list of all defined macros }
  TMacroDefinitions = class (Tlist)
    private
      FMacroDelimiterChar : char;
      function FGetMacroData (IndexNr : integer) : TMacro;
      function FCompareMacroItems (Item1, Item2: pointer): Integer;
    public
      constructor Create;
        { create object }
      destructor destroy; override;
        { free object }
      function Add (ShortName,
                    LongName : string;
                    DefaultLength : Integer;
                    DefaultAlignment : char;
                    DefaultCapitalization : char;
                    Description,
                    Cathegory : string;
                    MacroType : TMacroDataType;
                    ValueProc : pointer;
                    CustomString : string) : Integer;
        { add new macro to the list. It asks for parameters to simplify
          macro adding procedure (it is much nicer if you have to call method
          and pass macro definition as parameters than create TMacro, then
          set it and add it to the list. If someone needs it it's easy to add
          AddMAcro method which wil dmenat onlu TMacro value as parameter }
      function Find (MacroName : string) : Integer;
        { Find Macro by name. You can use short or long name of macro. Name
          should not contain macro delimiters }
      property MacroDelimiterChar : char
        read fMacroDelimiterChar
        write fMacroDelimiterChar;
        { Character used to define bound for macro items. By default it is '%' }
      property Items[IndexNr : integer] : TMacro
        read FGetMacroData;
        { Access Macro definitions through array }
      function GetValue (MacroItem : string;
                         MPEGAudio : TMPEGAudio;
                         MPEGReport : TMPEGReport) : string;
        { Resolve single macro item. MacroItem must be complete
          macro including macro delimiters and optional parameters.
          Other two parameters are data which may bee needed to
          resolve macro. These parameters are nil, macros depending
          on them will not be resolved. and they will be returned
          unchanged in result string. }
      function Textilize (MacroStr : string;
                          MPEGAudio : TMPEGAudio;
                          MPEGReport : TMPEGReport) : string;
        { resolve several macros in single string. It will separate each macro
          item and call GetValue method to resolve it }
      procedure Sort;
        { sort macro list based on Compare procedure }
  end; { TMacroDefinitions }

  { delimiter used in CreateMacroDescriptionFile function }
  TMacroListDelimiter = (Tabs, Spaces);

procedure CreateMacroDescriptionFile (outfilename : string; Delimiter : TMacroListDelimiter);
    { This procedure creates list of all macro definitions
      in text file OutFileName. Macros which are defined but resolving
      function is nil will be marked as unsupported. It is supposed to
      be used internaly. Delimiter may be Tabs or Spaces and defines output format.
      First is better for using in text files (comments in delphi source),
      second is better for importing in text processors.

      You may generate this list occasionaly to see if you missed to assign
      resolving function to some macro, or to check default values or toinclude
      in documentation or something like that. I use it to generate list of
      supported macros to include in help file. }

var
  { Global variable for macro definitions. It contains default macro
    definitions (see initialization section of this unit). Any
    application that uses MPGTools library will see this variable and
    will be able to use it to access macros. Of course you are free to add
    your own macros in this list, change defaults, or even to create other
    objects of TMacroDefinitions type. But I think this one will be in most
    cases sufficient. It is needed by other classes in this unit.
   }
  Macros : TMacroDefinitions;


{ public functions }

Function SecondsToTime (TimeSec : LongInt) : TDateTime;
  { Convert number of seconds to TDateTime value }

function GetGenreStr (Genre : Integer) : string;
  { Returns string description of Genre code }


const
  { drive indicators used for GetDriveName }
  DI_REMOVABLE = 1; { floppy }
  DI_FIXED = 2;     { hard }
  DI_REMOTE = 4;    { network }
  DI_CDROM = 8;     { cdrom }
  DI_RAMDISK = 16;   { ram disk }
  DI_ALL_DRIVES = DI_REMOVABLE + DI_FIXED + DI_REMOTE + DI_CDROM + DI_RAMDISK;
   { all drives }
  DI_ALL_BUT_FLOPPY = DI_FIXED + DI_REMOTE + DI_CDROM + DI_RAMDISK;
    { all drives except flopies }

{$IFNDEF VER80}
function GetDriveList : TStringlist;
 { Return list of drives found }

function GetDriveName (VolumeLabel : string; CheckDrives : byte) : string;
 { Returns drive name for volume label or empty string if drive
   with specified volume label is not found. Checkdrives is bitwise
   selection of drive types that should be checked. See drive indicators above. }
{$ENDIF}

{ TMPEGAUDIOLIST supporting functions (public) }

Procedure ResetCatalogHeader (var CatalogHeader : TMPEGDataCatalogue);
  { Reset contents of variable CatalogHeader }

Procedure ResetOrderFormHeader (var OrderFormHeader : TMPEGDataOrder);
  { Reset contents of variable OrderFormHeader }

function DecodeHeader (MPEGHeader : LongInt; var MPEGData : TMpegData) : Boolean;
  

implementation

{ local types definition }

type
  { Original structure of tag in MPEG AUDIO file. For internal use.
    You should use TMPEGDATA structure.}
  TMPEGTag = packed record
    Header : Array[1..3] of char;      { If tag exists this must be 'TAG' }
    Title : Array[1..30] of char;      { Title data (PChar) }
    Artist : Array[1..30] of char;     { Artist data (PChar) }
    Album : Array[1..30] of char;      { Album data (PChar) }
    Year : Array[1..4] of char;        { Date data }
    Comment : Array[1..30] of char;    { Comment data (PChar) }
    Genre : Byte;                      { Genre data }
  end;

  { Type for delimiters used in some string manipulating functions }
  Delimiter = Set Of Char;

const
  InterpunctionChars = [' ','.',',',';', ':', '<', '>',
                        '?', '/', '!', '(', ')'];


{************************************************************
 public functions
************************************************************}

{----------------------------------------------}
Function SecondsToTime (timesec : LongInt) : TDateTime;
 { convert LongInt number of seconds to TDateTime }
  var
    tmpHour : word;
    tmpMin : word;
    tmpSec : word;
  begin
    tmpHour := timesec DIV (60*60);
    tmpMin := (timesec - (tmpHour * 60 * 60)) DIV 60;
    tmpSec := timesec - (tmpHour * 60 * 60) - (tmpMin * 60);
    SecondsToTime := EncodeTime (tmpHour, tmpMin, tmpSec,0);
  end;

{----------------------------------------------}
function GetGenreStr (Genre : Integer) : string;
begin
  If Genre <= MaxStyles then
    Result := MusicStyle[Genre]
  else
    Result := 'Unknown';
end;

{$IFNDEF VER80}
{----------------------------------------------}
function GetDriveList : TStringlist;
var
  DriveStrings : array[0..4*26+2] of Char;
  StringPtr : Pchar;
begin
  GetLogicalDriveStrings (SizeOf (DriveStrings), DriveStrings);
  StringPtr := DriveStrings;
  Result := TStringList.Create;
  Result.Clear;
  while StringPtr <> nil do begin
    Result.Add (StringPtr);
    Inc (StringPtr, StrLen (StringPtr) + 1);
    if (Byte (StringPtr[0]) = 0) then StringPtr := nil;
  end;
end;

{----------------------------------------------}
function GetDriveName (VolumeLabel : string; CheckDrives : byte) : string;
var
  Drives : TStringList;
  i : Integer;
  VolName : array[0..255] of Char;
  SerialNumber : DWord;
  MaxCLength : Dword;
  FileSysFlag : DWord;
  FileSysName : array[0..255] of char;
  DriveType : Integer;
begin
  Result := '';
  Drives := GetDriveList;
  for i := Drives.Count-1 downto 0 do begin
    DriveType := GetDriveType (PChar (@Drives.strings[i][1]));
    if (DriveType <> DRIVE_UNKNOWN) and
       (DriveType <> DRIVE_NO_ROOT_DIR)
    then begin
      if ((1 Shl (DriveType - 2)) and CheckDrives) <> 0 then begin
        VolName := '';
        GetVolumeInformation (PChar (@Drives.strings[i][1]), VolName,
          255, @SerialNumber, MaxCLength, FileSysFlag, FileSysName, 255);
        if VolName = VolumeLabel then begin
          Result := Drives.Strings[i];
          Break;
        end; { if }
      end; { if }
    end; { if }
  end; { for }
end; { function }
{$ENDIF}



{----------------------------------------------}
function Extract4b (InVal : pointer) : Integer;
var
  vala : ^byte;
begin
  vala := InVal;
  Result := vala^ shl 8;
  Inc (vala);
  Result := Result shl 8;
  Result := Result or vala^;
  Inc (vala);
  Result := Result shl 8;
  Result := Result or vala^;
  Inc (vala);
  Result := Result shl 8;
  Result := Result or vala^;
end;

{************************************************************
 private functions
************************************************************}

{----------------------------------------------}
Procedure winProcessMessages;
{ Allow Windows to process other system messages }
var
  ProcMsg  :  TMsg;
begin
  while PeekMessage(ProcMsg, 0, 0, 0, PM_REMOVE) do begin
    if (ProcMsg.Message = WM_QUIT) then Exit;
    TranslateMessage(ProcMsg);
    DispatchMessage(ProcMsg);
  end; { while }
end; { winProcessMessages }


{----------------------------------------------}
Function PosFirst (InStr, SubStr : String; StartPos : Integer) : Integer;
  { find firs position of SubStr in InStr begining from
    StartPos character. Return zero if SubStr not found. }
var
  Position : Integer;

Begin
  Delete (InStr,1,StartPos-1);
  Position := Pos (SubStr, InStr);
  If Position = 0 then Posfirst := 0 else PosFirst := StartPos + Position - 1;
End; { PosFirst }

{----------------------------------------------}
Function IIFStr (inb : boolean; truestr, falsestr : String) : string;
  { Return TrueStr or FalseStr regarding of value of inB }
  begin
    If Inb then
      IIFStr := TrueStr
    else
      IIFStr := FalseStr;
  end; { function IIFStr }

{----------------------------------------------}
Function IIFLong (inb : boolean; truev, falsev : LongInt) : longint;
  { Return TrueV or FalseV regardin of value of inB }
  begin
    If Inb then
      IIFLong := Truev
    else
      IIFLong := Falsev;
  end; { function IIFLong }

{----------------------------------------------}
Function TrimRight (InStr : string) : string;
  { Delete #32's and #0's from the end of InStr }
var
  i, StrLen : Byte;
begin
  StrLen := Length (instr);
  If StrLen > 0 then begin
    i := Pos (#0, InStr);
    If i > 0 then begin
      Delete (InStr, i, StrLen);
      StrLen := Length (InStr);
    end;
    i := StrLen;
    While (i > 0) and (instr [i] in [' ',#0]) do i := i - 1;
    Delete (instr, i + 1, StrLen);
  end; {if}
  TrimRight := instr;
end; { TrimRight }

{----------------------------------------------}
Function TrimLeft (instr : string) : string;
  { Delete #32's from the begining of InStr }
Var    i, StrLen : Byte;
Begin
  i := 1;
  StrLen := Length (instr);
  If StrLen > 0 then begin
    While (i <= StrLen) and (instr [i] = ' ') do Inc (i);
    Delete (instr, 1, i - 1);
  end; {if}
  TrimLeft := instr;
end; { TrimLeft }

{----------------------------------------------}
Function Trim (instr : string) : string;
  { Delete #32's from the begining of InStr and #32's and #0's
     from the end of InStr }
begin
  Trim := TrimLeft (TrimRight (instr) );
end;

{----------------------------------------------}
Function WordCount (InStr : string; Delimiters : Delimiter) : byte;
  { Count words in InStr. Words are delimited by Delimiters }
var
  i, drum, StrLen : Byte;
begin
  i := 1;
  drum := 0;
  StrLen := Length (instr);
  If (StrLen = 0) or ( (StrLen < 2) and (StrLen > 0) and
     (instr [1] in delimiters) ) then
  begin
    WordCount := 0;
    Exit;
  end; {if}
  While i < StrLen do begin
    If instr [i] in delimiters then Inc (drum);
    Inc (i);
  end; {while}
  WordCount := drum + 1;
end; { WordCount }

{----------------------------------------------}
Function WordGet (InStr : String; Wordnr : Integer;
                  Delimiters : Delimiter) : String;
  { Get word number WordNr from InStr. Words are delimited by Delimiters }
var
  i, drum, wordstart, wordend : Byte;
begin
  i := 1;
  drum := 0;
  wordstart := 1;
  wordend := Length (instr);

  If (wordnr < 1) or (WordCount (instr, Delimiters) < wordnr) then begin
    WordGet := '';
    Exit;
  end;

  While (drum < wordnr) and (i <= wordend) do begin
    If instr [i] in delimiters then begin
      Inc (drum);
      If drum = wordnr - 1 then wordstart := i + 1;
      If drum = wordnr then wordend := i - wordstart;
    end; {if}
    Inc (i);
  end; {while}
  WordGet := Copy (instr, wordstart, wordend);
end; { WordGet }

{----------------------------------------------}
Function Replicate (Fill :Char; Count : Integer) : String;
var
  I : Integer;
begin
  Result := '';
  for I := 1 to Count do Result := Result + Fill;
end;


{----------------------------------------------}
Function IsNumber (instr : String) : Boolean;
  { Check if string contains all numbers }
const
  cifre : set of char = ['0'..'9','.'];
var
  bTemp : Boolean;
  F : Integer;
begin
  bTemp := True;
  If Length (instr) > 0 then begin
    For F := 1 to Length (instr) do begin
      bTemp := bTemp and (InStr[F] in cifre);
      if not bTemp then break;
    end; { for }
  end else bTemp := False; { for }
  IsNumber := bTemp;
end; { isNumber }

{----------------------------------------------}
Function Left (InStr : String; OutLen : Integer) : String;
  { Return OutLen characters from the beginning of InStr.
    If InStr is shorter than OutLen, return whole InStr }
begin
  Left := Copy (instr, 1, outlen);
end; { Left }

{----------------------------------------------}
Function Right (InStr : String; OutLen : Integer) : String;
  { Return OutLen characters from the end of InStr.
    If InStr is shorter than OutLen, return whole InStr }
var
  StrLen : Integer;
begin
  StrLen := Length (instr);
  Right := Copy (instr, StrLen - outlen + 1, outlen);
end; { Right }

{----------------------------------------------}
Function PadLeft (InStr : String; OutLen : Integer; Fill : Char) : String;
var
  temp : String;
begin
  {$IFDEF VER80}
    FillChar (Temp, OutLen + 1, Fill);
    Temp[0] := Chr (OutLen);
  {$ELSE}
    {SetLength (Temp, OutLen);}
    Temp := Replicate (Fill, OutLen);
  {$ENDIF}

  If Length (InStr) <= OutLen then
    Move (InStr [1], Temp [1], Length (InStr) )
  else
    Move (InStr [1], Temp [1], OutLen);
  PadLeft := Temp;
end; { PadLeft }

{----------------------------------------------}
Function PadRight (InStr : String; OutLen : Integer; Fill : Char) : String;
var
  temp : String;
  L : Integer;
begin
  {$IFDEF VER80}
     FillChar (Temp [1], OutLen+1, Fill);
     Temp[0] := Chr (OutLen);
  {$ELSE}
     { SetLength (Temp, OutLen); }
     Temp := Replicate (Fill, OutLen);
  {$ENDIF}
  L := Length (InStr);
  If L <= OutLen then
    Move (InStr [1], Temp [Succ (OutLen - L) ], L)
  else
    Move (InStr [1], Temp [1], OutLen);
  PadRight := Temp;
end; { PadRight }

{----------------------------------------------}
Function PadCenter (InStr : String; OutLen : Integer; Fill : Char) : String;
var
  temp : String;
  L : Integer;
begin
  If Length(InStr) > OutLen then InStr := Left(instr,OutLen);
  {$IFDEF VER80}
     FillChar (Temp [1], OutLen, Fill);
     Temp[0] := Chr (OutLen);
  {$ELSE}
     { SetLength (Temp, OutLen); }
     Temp := Replicate (Fill, OutLen);
  {$ENDIF}
  L := Length (InStr);
  If L <= OutLen then
    Move (InStr [1], Temp [ ( (OutLen - L) Div 2) + 1], L)
  else
    Temp := Copy (InStr, 1, L);
  PadCenter := temp;
end; { PadCenter }


{----------------------------------------------}
Function Capitalize (InStr : String; Delimiters : Delimiter) : String;
  { pocetno slovo svake reci u stringu konvertuje u veliko }

var
  F : byte;   { brojac }
Begin
  For F := 1 to Length (InStr) do begin
    If F = 1 then InStr[F] := UpCase(InStr[F])
    else if InStr[F-1] IN Delimiters then InStr[F] := UpCase (InStr[F]);
  end; {for}
  Capitalize := InStr;
End;

{----------------------------------------------}
Function CapitalFirst (InStr : String) : String;
  { pocetno slovo prve reci u stringu konvertuje u veliko }
Begin
  If Length (InStr) = 0 Then Exit;
  Instr[1] := UpCase (Instr [1]);
  CapitalFirst := InStr;
End;


{----------------------------------------------}
function GetVolumeLabel(Drive: Char): String;
 { Function returns volume label of a disk. Works in all Delphi versions }
var
  SearchString: String[7];
  {$IFDEF VER80}
  SR: TSearchRec;
  P: Byte;
  {$ELSE}
  Buffer : array[0..255] of char;
  a,b : DWORD;
  {$ENDIF}
begin
  {$IFDEF VER80}
  SearchString := Drive + ':\*.*';
  { find vol label }
  if FindFirst(SearchString, faVolumeID, SR) = 0 then begin
    P := Pos('.', SR.Name);
    Result := SR.Name;
    { if it has a dot... }
    if P > 0 then Delete (Result, P, 1);
  end else Result := '';
  {$ELSE}
  SearchString := Drive + ':\' + #0;
  If GetVolumeInformation(@SearchString[1],buffer,sizeof(buffer),nil,a,b,nil,0) then
    Result := buffer
  else Result := '';
  {$ENDIF}
end;

{ QuickSort, used in TMOPEGAudioList and TMacroDefinitions }
procedure QuickSort(SortList: PPointerList; L, R: Integer;
                    var SortCompareFunc : TListSortCompare;
                    SortDirection : Integer;
                    ShowSortProgressFunc : TShowSortProgressFunc);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := SortList^[(L + R) shr 1];
    repeat
      while (SortDirection * SortCompareFunc(SortList^[I], P) < 0) do Inc(I);
      while (SortDirection * SortCompareFunc(SortList^[J], P) > 0) do Dec(J);
      if I <= J then
      begin
        T := SortList^[I];
        SortList^[I] := SortList^[J];
        SortList^[J] := T;
        Inc(I);
        Dec(J);
      end;
    If @ShowSortProgressFunc <> nil then ShowSortProgressFunc (I);
    until I > J;
    if L < J then QuickSort(SortList, L, J, SortCompareFunc, SortDirection, ShowSortProgressFunc);
    L := I;
  until I >= R;
end; { QuickSort }


{----------------------------------------------}
function CalcFrameLength (Layer, SampleRate, BitRate : LongInt; Padding : Boolean) : Integer;
begin
  If SampleRate > 0 then
    if Layer = 1 then
      Result := Trunc (12 * BitRate * 1000 / SampleRate + (Integer (Padding)*4))
    else
      Result := Trunc (144 * BitRate * 1000 / SampleRate + Integer (Padding))
  else Result := 0;
end;

{----------------------------------------------}
function FrameHeaderValid (Data : TMPEGData) : Boolean;
begin
    Result := (Data.FileLength > 5) and (Data.Version > 0) and
              (Data.Layer > 0) and (Data.FileDateTime <> 0) and
              (Data.BitRate >= -1) and (Data.BitRate <> 0) and (Data.SampleRate > 0);
end;

{----------------------------------------------}
function DecodeHeader (MPEGHeader : LongInt; var MPEGData : TMpegData) : Boolean;
  { Decode MPEG Frame Header and store data to TMPEGData fields.
    Return True if header seems valid }
var
  BitrateIndex : byte;
  VersionIndex : byte;

begin
  MPEGData.Version := 0;
  MPEGData.Layer := 0;
  MPEGData.SampleRate := 0;
  MPEGData.Mode := 0;
  MPEGData.Copyright := False;
  MPEGData.Original := False;
  MPEGData.ErrorProtection := False;
  MPEGData.Padding := False;
  MPEGData.BitRate := 0;
  MPEGData.FrameLength := 0;

  If (MPEGHeader and $ffe00000) = $ffe00000 then begin
    VersionIndex := (MPEGHeader shr 19) and $3;
    case VersionIndex of
      0 : MPEGData.Version := MPEG_VERSION_25;      { Version 2.5 }
      1 : MPEGData.Version := MPEG_VERSION_UNKNOWN; { Unknown }
      2 : MPEGData.Version := MPEG_VERSION_2;       { Version 2 }
      3 : MPEGData.Version := MPEG_VERSION_1;       { Version 1 }
    end;
    { if Version is known, read other data }
    If MPEGData.Version <> MPEG_VERSION_UNKNOWN then begin
      MPEGData.Layer := 4 - ((MPEGHeader shr 17) and $3);
      If (MPEGData.Layer > 3) then MPEGData.Layer := 0;

      BitrateIndex := ((MPEGHeader shr 12) and $F);
      MPEGData.SampleRate := MPEG_SAMPLE_RATES[MPEGData.Version][((MPEGHeader shr 10) and $3)];
      MPEGData.ErrorProtection := ((MPEGHeader shr 16) and $1) = 1;
      MPEGData.Copyright := ((MPEGHeader shr 3) and $1) = 1;
      MPEGData.Original := ((MPEGHeader shr 2) and $1) = 1;
      MPEGData.Mode := ((MPEGHeader shr 6) and $3);
      MPEGData.Padding := ((MPEGHeader shr 9) and $1) = 1;
      MPEGData.BitRate := 0;
      if (MPEGData.Version >= 1) and (MPEGData.Version <= 3) then
        if (MPEGData.Layer >= 1) and (MPEGData.Layer <= 3) then
          if BitrateIndex <= 15 then
            MPEGData.BitRate := MPEG_BIT_RATES[MPEGData.Version][MPEGData.Layer][BitrateIndex];

      If MPEGData.BitRate = 0 then MPEGData.Duration := 0
      else MPEGData.Duration := (MPEGData.FileLength*8) div (longint(MPEGData.Bitrate)*1000);
      MPEGData.FrameLength := CalcFrameLength (MPEGData.Layer, MPEGData.SampleRate, MPEGData.BitRate, MPEGData.Padding);
    end;
    Result := FrameHeaderValid (MPEGData);
  end else Result := False;

end;


{************************************************************
default functions used for on error events
************************************************************}
{$IFDEF UseDialogs}
{ MPEGFileLoadEror is default for MPEGAudio.OnLoadError }
function MPEGFileLoadError (const MPEGData : TMPEGData) : word; far;
begin
  Result := MessageDlg ('Error openning file: ' + MPEGData.FileName,
                         mtError, [mbCancel, mbRetry, mbIgnore], 0);
end;

{ OnShowProgressError is default for MPEGAudio.List.ShowProgressErrorFunc }
function OnShowProgressError (const FileName : string) : Word; far;
begin
  Result := MessageDlg ('Error opening file: ' + FileName,
                         mtError, [mbCancel, mbRetry, mbIgnore], 0);
end;
{$ENDIF}


{ methods }

{************************************************************
TMPEGAUDIO methods
************************************************************}

{----------------------------------------------}
constructor TMPEGAUDIO.Create;
begin
  inherited Create;
  FMacro := '';
  FText := '';
  FFirstValidFrameHeaderPosition := 0;
  FFileDetectionPrecision := 0;
  {$IFDEF UseDialogs}
  FOnReadError := MPEGFileLoadError;
  {$ELSE}
  FOnReadError := nil;
  {$ENDIF}
  FAutoLoad := True;
  FUnknownArtist := 'Unknown Artist';
  FUnknownTitle := 'Unknown Title';
  FSearchDrives := DI_ALL_BUT_FLOPPY;
end;

{----------------------------------------------}
function TMPEGAUDIO.IsValidStr (const IsValidTrue, IsValidFalse : string) : string;
begin
  Result := IIFStr (IsValid, IsValidTrue, IsValidFalse);
end;

{----------------------------------------------}
function TMPEGAUDIO.DataPtr : PMpegData;
begin
  Result := @FData;
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetFileName (inStr : string);
begin
  FData.FileName := inStr;
  If AutoLoad then FReadData;
end;

{----------------------------------------------}
function TMPEGAUDIO.FGetFileName : string;
begin
  Result := Data.FileName;
end;

{$IFNDEF VER80}
{----------------------------------------------}
function TMPEGAUDIO.FGetFileNameShort : string;
var
  path : string;
  sp : array[0..MAX_PATH] of char;
  err : integer;
begin
  path := Data.FileName + #0;
  err := GetShortPathName (PChar (path), sp, MAX_PATH);
  if err <> 0 then
    Result := string (sp)
  else
    Result := 'Error converting long filename to short.';
end;
{$ENDIF}


{----------------------------------------------}
function TMPEGAUDIO.FGetSearchExactFileName : string;
{$IFNDEF VER80}
var
  DriveName : string;
{$ENDIF}
begin
  Result := ExpandFileName (Data.FileName);
  {$IFNDEF VER80}
  if not FileExists (Result) then begin
    DriveName := GetDriveName (Data.VolumeLabel, SearchDrives);
    If DriveName <> '' then
      Result := DriveName + Copy (Result, Pos (':\', Result)+2, Length (Result));
  end;
  {$ENDIF}
end;


{----------------------------------------------}
function TMPEGAUDIO.FGetIsValid : Boolean;
begin
  Result := FrameHeaderValid (Data);
end;

function TMPEGAUDIO.fGetIsTagged : Boolean;
begin
  Result := Data.Header = 'TAG';
end;

{----------------------------------------------}
function TMPEGAUDIO.FFileDateTime : TDateTime;
begin
  if data.FileDateTime <> 0 then begin
   try
     Result := FileDateToDateTime (data.FileDateTime)
   except
     Result := 0;
   end;
  end else Result := 0;
end;


{----------------------------------------------}
procedure TMPEGAUDIO.ResetData;
{ Empty MPEG data }
const
  Notag = '[notag]';
begin
  with FData do begin
    Header := 'BAD';
    FillChar (Title, SizeOf (Title), #0);
    Title := NoTag;
    FillChar (Artist, SizeOf (Artist), #0);
    Artist := NoTag;
    FillChar (Album, SizeOf (Album), #0);
    Album := NoTag;
    Year := '    ';
    FillChar (Comment, SizeOf (Comment), #0);
    Comment := NoTag;
    Genre := 255;
    Track := 0;
    Duration := 0;
    FileLength := 0;
    Version := 0;
    Layer := 0;
    SampleRate := 0;
    Mode := 0;
    Copyright := False;
    Original := False;
    ErrorProtection := False;
    Padding := False;
    FrameLength := 0;
    BitRate := 0;
    BPM := 0;
    CRC := 0;
    FillChar (FileName, SizeOf (FData.FileName), #0);
    FileDateTime := 0;
    FileAttr := 0;
    FillChar (VolumeLabel, SizeOf (VolumeLabel), #0);
    Selected := 0;
    FillChar (Reserved, SizeOf (FData.Reserved), #0);
    FText := Textilize (FMacro);
  end; { with }
end; { function }


{----------------------------------------------}
function TMPEGAUDIO.FReadData : Integer;
var
  f : file;
  tag : TMPEGTag;
  tempStr : string;

  mp3hdrread : array[1..4] of byte;
  mp3hdr : LongInt ABSOLUTE mp3hdrread;
  tempbyte : byte;
  tempLongInt : LongInt;
  Deviation : Integer;
  XingHeader : TXHeadData;
  XingData : array[1..116] of byte;
  XingDataP : ^byte;

begin
  tempStr := data.FileName;
  ResetData;
  FData.FileName := ExpandFileName (tempStr);

  repeat
    Result := -1;
    If FileExists (Data.Filename) then begin
      AssignFile (f, Data.Filename);

      FFirstValidFrameHeaderPosition := 0;
      FileMode := 0;
      try
        {$I-}
        Reset (f,1);
        {$I+}
        Result := IOResult;
        if (Result=0) and (FileSize(f) > 5) then begin
          FData.FileDateTime := FileAge (Data.fileName);
          {FFileDateTime := FileDatetoDatetime (Data.FileDateTime);}
          FData.FileAttr := SysUtils.FileGetAttr (Data.FileName);
          FData.VolumeLabel := GetVolumeLabel (Data.FileName[1]);
          FData.FileLength := FileSize (f);

          repeat
            { read MPEG heder from file }
            BlockRead (f, mp3hdrread,4);
            tempbyte := mp3hdrread[1];
            mp3hdrread[1] := mp3hdrread[4];
            mp3hdrread[4] := tempbyte;
            tempbyte := mp3hdrread[2];
            mp3hdrread[2] := mp3hdrread[3];
            mp3hdrread[3] := tempbyte;

            While (not DecodeHeader (mp3hdr, FData)) and (not Eof (f)) and
                  ((FilePos(f) <= FFileDetectionPrecision)
                  or (FFileDetectionPRecision = 0))
            do begin
              { if mpeg header is not at the begining of the file, search file
                to find proper frame sync. This block can be speed up by reading
                blocks of bytes instead reading single byte from file }
               mp3hdr := mp3hdr shl 8;
               BlockRead (f, tempbyte,1);
               mp3hdrread[1] := tempbyte;

              { On each 200 bytes read, release procesor to allow OS do something else too }
              If (FilePos (f) MOD 300) = 0 then winProcessMessages;
            end; { while }

            FFirstValidFrameHeaderPosition := FilePos (f)-4;
            tempLongInt := FileLength - FirstValidFrameHeaderPosition - FrameLength + (2 * Byte(ErrorProtection));

            If (not IsValid) or (TempLongInt <= 0) then begin
              ResetData;
              FData.FileName := ExpandFileName (tempStr);
              FData.FileDateTime := FileAge (Data.fileName);
              FData.FileAttr := SysUtils.FileGetAttr (FData.FileName);
              FData.FileLength := FileSize (f);
              FFirstValidFrameHeaderPosition := FData.FileLength + 1;
              Result := -1;
            end else begin
              { Ok, one header is found, but that is not good proof that file realy
                is MPEG Audio. But, if we look for the next header which must be
                FrameLength bytes after first one, we may be very sure file is
                valid. }
              Seek (f, FirstValidFrameHeaderPosition + FrameLength);
              BlockRead (f, mp3hdrread,4);
              tempbyte := mp3hdrread[1];
              mp3hdrread[1] := mp3hdrread[4];
              mp3hdrread[4] := tempbyte;
              tempbyte := mp3hdrread[2];
              mp3hdrread[2] := mp3hdrread[3];
              mp3hdrread[3] := tempbyte;

              If not DecodeHeader (mp3hdr, FData) then begin
                { well, next header is not valid. this is not MPEG audio file }
                ResetData;
                FData.FileName := ExpandFileName (tempStr);
                FData.FileDateTime := FileAge (FData.fileName);
                {FFileDateTime := FileDatetoDatetime (Data.FileDateTime);}
                FData.FileAttr := SysUtils.FileGetAttr (FData.FileName);
                FData.FileLength := FileSize (f);
                { set file position back to the second byt of header that
                  seemed valid tolet function read all bytes that were
                  skipped inatempt tofind second header }
                Seek (f, FirstValidFrameHeaderPosition + 1);
                Result := -1;
              end else begin
                { BINGO!!! This realy is MPEG audio file so we may proceed }
                Result := 0;

                { check for Xing Variable BitRate info }
                if (FData.Version = 1) then begin
                  if Fdata.Mode <> 3 then Deviation := 32 + 4
                  else Deviation := 17 + 4;
                end else begin
                  if Fdata.Mode <> 3 then Deviation := 17 + 4
                  else Deviation := 9 + 4;
                end;
                Seek (f, FirstValidFrameHeaderPosition + Deviation);
                BlockRead (f, mp3hdrread,4);

                if (mp3hdrread[1] = Ord('X')) and
                   (mp3hdrread[2] = Ord ('i')) and
                   (mp3hdrread[3] = Ord ('n')) and
                   (mp3hdrread[4] = Ord ('g'))
                then begin
                  Fdata.Bitrate := -1;
                  BlockRead (f, XingData,SizeOf (XingData));
                  XingDataP := @XingData;
                  XingHeader.Flags := Extract4b (XingDataP);
                  Inc (XingDataP,4);
                  if (XingHeader.Flags and XH_FRAMES_FLAG) > 0 then begin
                    XingHeader.frames := Extract4b (XingDataP);
                    Inc (XingDataP, 4);
                  end else XingHeader.frames := 0;
                  if (XingHeader.Flags and XH_BYTES_FLAG) > 0 then begin
                    XingHeader.bytes := Extract4b (XingDataP);
                    Inc (XingDataP, 4);
                  end else XingHeader.bytes := 0;
                  if (XingHeader.Flags and XH_TOC_FLAG) > 0 then
                    Inc (XingDataP, 100);
                  if (XingHeader.Flags and XH_VBR_SCALE_FLAG) >0 then begin
                    XingHeader.vbrscale := Extract4b (XingDataP);
                    {Inc (XingDataP, 4);}
                  end else XingHeader.vbrscale := 0;
                  fdata.Duration := Round ((1152 / fdata.samplerate) * xingHeader.frames);
                  fdata.FrameLength := fdata.fileLength DIV xingHeader.frames;
                end;

                { read TAG if it exists }
                if FData.FileLength > 128 then begin
                  Seek (f,FData.FileLength-128);
                  BlockRead(f, tag, 128);
                  if tag.header='TAG' then begin
                    FData.Header := TrimRight (Tag.Header);
                    FData.Title := TrimRight (Tag.Title);
                    FData.Artist := TrimRight (Tag.Artist);
                    FData.Album := TrimRight (Tag.Album);
                    FData.Year := Tag.Year;
                    FData.Comment := TrimRight (Tag.Comment);
                    FData.Genre := Tag.Genre;
                    FData.Track := Ord (Tag.Comment[30]);
                  end else FData.Title := ExtractFileName (FData.FileName); { if }
                end; { if }
              end; { if }
            end; { if }
          until IsValid or Eof (f) or ((FilePos(f) > FFileDetectionPrecision) and (FFileDetectionPrecision > 0));
          Close(f);
          FText := Textilize (FMacro);
        end; { if }
      except
        Result := -1;
      end;
    end else FData.Title := '[not found: ' + ExtractFileName (TempStr) + ']';
    If (@FonReadError <> nil) and (Result <> 0) then
      Result := FOnReadError (data);
  until Result <> mrRetry;
end; { FReadData }

{----------------------------------------------}
function TMPEGAUDIO.WriteTag : Integer;
var
  f : file;
  newtag : TMPEGTag;

begin
  Result := -1;
  If FileExists (filename) then begin
    FillChar (NewTag, SizeOf (NewTag), 0);
    NewTag.Header := 'TAG';
    Move (FData.Title[1], NewTag.Title, Length(FData.Title));
    Move (FData.Artist[1], NewTag.Artist, Length (FData.Artist));
    Move (FData.Album[1], NewTag.Album, Length (FData.Album));
    Move (FData.Year[1], NewTag.Year, Length (FData.Year));
    Move (FData.Comment[1], NewTag.Comment, Length (FData.Comment));
    NewTag.Genre := Data.Genre;
    NewTag.Comment[30] := Chr (Data.Track);

    RemoveTag;

    AssignFile (f, filename);

    FileMode := 2;
    {$I-}
    Reset (f,1);
    {$I+}
    Result := IOResult;
    if (Result = 0) then begin
       Seek (f,FileSize(F));
       BlockWrite(f, newtag, 128);
       Close(f);
    end;

    FReadData;
  end; { if }
end; { WriteTag }

{----------------------------------------------}
function TMPEGAUDIO.RemoveTag : Integer;
var
  f : file;
  tag : TMPEGTag;

begin
  Result := -1;
  If FileExists (filename) then begin
    AssignFile (f, filename);

    FileMode := 2;
    {$I-}
    Reset (f,1);
    {$I+}
    Result := IOResult;
    if (Result = 0) and (FileSize(F) > 128) then begin
       Seek (f,FileSize(F)-128);
       BlockRead(f, tag, 128);
       if tag.header='TAG' then begin
         Seek (f,FileSize(F)-128);
         Truncate (F);
       end;
       Close(f);
    end;

    FReadData;
  end; { if }
end; { RemoveTag }

{----------------------------------------------}
function TMPEGAUDIO.GenreStr : string;
begin
  If Genre <= MaxStyles then
    Result := MusicStyle[Genre]
  else
    Result := 'Unknown';
end;

{----------------------------------------------}
function TMPEGAUDIO.ModeStr : string;
begin
  Result := MPEG_MODES[Mode]
end;

{----------------------------------------------}
function TMPEGAUDIO.DurationTime : TDateTime;
begin
  Result := SecondsToTime (Duration)
end;

{----------------------------------------------}
function TMPEGAUDIO.VersionStr : string;
begin
  Result := MPEG_VERSIONS[Version]
end;

{----------------------------------------------}
function TMPEGAUDIO.LayerStr : string;
begin
  { If (Layer > 3) then Data.Layer := 0; }
  Result := MPEG_LAYERS[Layer]
end;

{----------------------------------------------}
function TMPEGAUDIO.CopyrightStr (const CopyrightTrue, CopyrightFalse : string) : string;
begin
  Result := IIFStr (Copyright, CopyrightTrue, CopyrightFalse);
end;

{----------------------------------------------}
function TMPEGAUDIO.OriginalStr (const OriginalTrue, OriginalFalse : string) : string;
begin
  Result := IIFStr (Original, OriginalTrue, OriginalFalse);
end;

{----------------------------------------------}
function TMPEGAUDIO.ErrorProtectionStr (const ErrorProtectionTrue, ErrorProtectionFalse : string) : string;
begin
  Result := IIFStr (ErrorProtection, ErrorProtectionTrue, ErrorProtectionFalse);
end;

{----------------------------------------------}
function TMPEGAUDIO.SelectedStr (const SelectedTrue, SelectedFalse : string) : string;
begin
  Result := IIFStr (Selected > 0, SelectedTrue, SelectedFalse);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetMacro (MacroStr : string);
begin
  FMacro := (MacroStr);
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
function TMPEGAUDIO.Textilize (MacroStr : string) : string;
begin
  Result := Macros.Textilize (MacroStr, self, nil);
end;


{----------------------------------------------}
procedure TMPEGAUDIO.FSetArtist (inString : string30);
begin
  Fdata.Artist := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
function TMPEGAUDIO.FGetArtist : string30;
begin
  if not IsTagged and (FUnknownArtist <> '') then
    Result := FUnknownArtist
  else Result := Data.Artist;
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetTitle (inString : string30);
begin
  Fdata.Title := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
function TMPEGAUDIO.FGetTitle : string30;
begin
  if not IsTagged and (FUnknownTitle <> '') then
    Result := FUnknownTitle
  else Result := FData.Title;
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetAlbum (inString : string30);
begin
  Fdata.Album := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetYear (inString : string4);
begin
  Fdata.Year := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetComment (inString : string30);
begin
  Fdata.Comment := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetVolumeLabel (inString : string20);
begin
  Fdata.VolumeLabel := inString;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetGenre (inByte : byte);
begin
  Fdata.Genre := inByte;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetTrack (inByte : byte);
begin
  Fdata.Track := inByte;
  FText := Textilize (FMacro);
end;

{----------------------------------------------}
procedure TMPEGAUDIO.FSetSelected (inWord : word);
begin
  Fdata.Selected := inWord;
  FText := Textilize (FMacro);
end;


{************************************************************
TMPEGAUDIOLIST supporting functions (public)
************************************************************}

{----------------------------------------------}
Procedure ResetCatalogHeader (var CatalogHeader : TMPEGDataCatalogue);
  { reset contents of variable CatalogHeader }
  begin
    with CatalogHeader do begin
    FillChar (Title, SizeOf (Title), #0);
    FillChar (Publisher, SizeOf (Publisher), #0);
    FillChar (City, SizeOf (City), #0);
    FillChar (ZIP, SizeOf (ZIP), #0);
    FillChar (Country, SizeOf (Country), #0);
    FillChar (Address, SizeOf (Address), #0);
    FillChar (Phone, SizeOf (Phone), #0);
    FillChar (Fax, SizeOf (Fax), #0);
    FillChar (Email, SizeOf (Email), #0);
    FillChar (WWWURL, SizeOf (WWWURL), #0);
    end; { with }
  end; { function }


{----------------------------------------------}
Procedure ResetOrderFormHeader (var OrderFormHeader : TMPEGDataOrder);
  { reset contents of variable OrderFormHeader }
  begin
    with OrderFormHeader do begin
    FillChar (CustomerID, SizeOf (customerID), #0);
    FillChar (Name, SizeOf (Name), #0);
    FillChar (City, SizeOf (City), #0);
    FillChar (ZIP, SizeOf (ZIP), #0);
    FillChar (Country, SizeOf (Country), #0);
    FillChar (Address, SizeOf (Address), #0);
    FillChar (Phone, SizeOf (Phone), #0);
    FillChar (Fax, SizeOf (Fax), #0);
    FillChar (Email, SizeOf (Email), #0);
    end; { with }
  end; { function }



{************************************************************
TMPEGAUDIOLIST methods
************************************************************}

{----------------------------------------------}
constructor TMPEGAudioList.Create;
begin
  inherited Create;
  ShowProgressfunc := nil;
  {$IFDEF UseDialogs}
  ShowProgressErrorFunc := OnShowProgressError;
  {$ELSE}
  ShowProgressErrorFunc := nil;
  {$ENDIF}
  ShowExportProgressFunc := nil;
  UserSortCompareFunc := nil;
  SortDirection := srtAscending;
  FShowSortProgressFunc := nil;
  {$IFDEF UseDialogs}
  FShowMPEGAudioReadError := MPEGFileLoadError;
  {$ELSE}
  FShowMPEGAudioReadError := nil;
  {$ENDIF}
  FMPEGAudioUnknownArtist := '';
  FMPEGAudioUnknownTitle := '';
end;

{----------------------------------------------}
function TMPEGAudioList.Count : Integer;
begin
  Result := inherited Count;
end;

{----------------------------------------------}
function TMPEGAudioList.SelectedCount : Integer;
var
  i : Integer;

begin
  Result := 0;
  for i := 0 to Count - 1 do
   if Items[i].Selected <> 0 then Result := Result + 1;
end;

{----------------------------------------------}
function TMPEGAudioList.Add (NewItem : TMPEGData) : Integer;
begin
  MPEGFile := TMPEGAudio.Create;
  MPEGFile.FileDetectionPrecision := FFileDetectionPrecision;
  MPEGFile.onReadError := FShowMPEGAudioReadError;
  MPEGFile.UnknownArtist := FMPEGAudioUnknownArtist;
  MPEGFile.UnknownTitle := FMPEGAudioUnknownTitle;
  MPEGFile.Data := NewItem;
  Result := inherited Add (MPEGFile);
end;

{----------------------------------------------}
procedure TMPEGAudioList.Insert (Index : Integer; NewItem : pointer);
begin
  MPEGFile := TMPEGAudio.Create;
  MPEGFile.FileDetectionPrecision := FFileDetectionPrecision;
  MPEGFile.onReadError := FShowMPEGAudioReadError;
  MPEGFile.UnknownArtist := FMPEGAudioUnknownArtist;
  MPEGFile.UnknownTitle := FMPEGAudioUnknownTitle;
  MPEGFile.Data := TMPEGData (NewItem^);
  inherited Insert (Index, MPEGFile);
end;

{----------------------------------------------}
function TMPEGAudioList.AddFile (NewFileName : string) : Integer;
begin
  MPEGFile := TMPEGAudio.Create;
  MPEGFile.FileDetectionPrecision := FFileDetectionPrecision;
  MPEGFile.onReadError := FShowMPEGAudioReadError;
  MPEGFile.UnknownArtist := FMPEGAudioUnknownArtist;
  MPEGFile.UnknownTitle := FMPEGAudioUnknownTitle;
  MPEGFile.AutoLoad:= False;
  MPEGFile.FileName := NewFileName;
  Result := MPEGFile.LoadData;
  if Result = 0 then begin
    Result := inherited Add (MPEGFile);
    If (@FShowProgressFunc <> nil) then begin
      if not FShowProgressFunc (MPEGFile, MPEGFile.FileName, 1, 1) then
          Result := -2;
      end;
  end else
    if Result = mrCancel then Result := -2
    else Result := -1;
end;

{----------------------------------------------}
function TMPEGAudioList.AddFromAnyFile (AnyFileName: string) : Integer;
var
  AppID : String;
  HeaderStructType : byte;
  HeaderStructLength : word;
  HeaderStructPtr : pointer;

begin
  Result := GetFileType (AnyFileName);
  Case Result of
    FT_MPEG_AUDIO      : Result := AddFile (AnyFileName);
    FT_WINAMP_PLAYLIST : Result := AddFromWinAmpList (AnyFileName);
    FT_MPEG_DATAFILE   : Result := AddFromMPEGDatafile (AnyFileName,
                                   AppID, HeaderStructType,
                                   HeaderStructLength,
                                   HeaderStructPtr);
    FT_PLS_PLAYLIST    : Result := AddFromPLSList (AnyFileName);
    else Result := -1;
  end; { case }
end;


{----------------------------------------------}
function TMPEGAudioList.AddFromWinAmpList (PlayListName : string) : Integer;
var
  i : Integer;
  WinAmpList : TStringList;
  {Index : Integer;}

begin
  { Load WinAmp playlist }
  WinAmpList := TStringList.Create;
  PlayListName := ExpandFileName (PlayListName);

  {Result := -1;}

  { open Winamp playlist file }
  repeat
    Result := 0;
    try
      { try to open file }
      WinAmpList.LoadFromFile (PlayListName);

    except
      if (@FShowProgressErrorFunc <> nil) then
        Result := FShowProgressErrorFunc (PlayListName)
      else Result := -1;
    end; {try}
  until Result <> mrRetry ;

  { Adjust Result to show errors as negative integers }
  if Result > 0 then
    if Result = mrCancel then Result := -2
    else Result := -1;

  { if playlist file has been read ok then we should process it }
  if Result = 0 then begin
    for i := 0 to WinAmpList.Count-1 do begin
      {Result := 0;}

      if WinAmpList.Strings[i][2] = ':' then
        { if item is full path then use it as is }
        WinAmpList.Strings[i] := WinAmpList.Strings[i]
      else
        if WinAmpList.Strings[i][1] = '\' then
          { if item path starts with \ then add Playlist drive }
          WinAmpList.Strings[i] := Copy (PlayListName,1,2) + WinAmpList.Strings[i]
        else
          { in other cases assume that item contains relative path to PlayList path }
            WinAmpList.Strings[i] := ExtractFilePAth (PlayListName) + WinAmpList.Strings[i];

      Result := AddFile (WinAmpList.Strings[i]);
      if Result > -1 then begin
        { if no error }
        If (@FShowProgressFunc <> nil) then begin
          if not FShowProgressFunc (Items[Result], PlayListName, i+1, WinAmpList.Count) then
            Result := -2;
        end;
        if (Result = -2) then
          Break; { if users asks cancel in FShowProgressFunc}
      end else
        if (Result = -2) then
          Break; { break for loop if user asked to cancel process on Error}

      { On each 30 iterations, release processor to allow OS do something
        else too }
      if (i MOD 30) = 0 then winProcessMessages;
    end; { for }
  end; { if Result = 0 }
  WinAmpList.Free;
end;

{----------------------------------------------}
function TMPEGAudioList.ExportToWinAmpList (outfilename : string;
                                            ToAppend,
                                            RelativePath,
                                            ExportValid,
                                            SelectedOnly : Boolean) : integer;
var
  F : Integer;
  outfile : TextFile;
  outstr : string;

begin
  Result := 0;
  If Count > 0 then begin
    {Result := -1;}
    OutFileName := ExpandFileName (OutFileName);
    System.Assign (OutFile, OutFileName);
    FileMode := 2;
    try
      If ToAppend and FileExists (OutfileName) then
        Append (OutFile)
      else Rewrite (outFile);

      Result := 0;
      For F := 0 to Count-1 do begin
        if not SelectedOnly or (SelectedOnly and (Items[F].Selected <> 0)) then
        begin
          If F div 10 = 0 then winProcessMessages;
          outstr := items[f].SearchExactFilename;
          If not ExportValid or (ExportValid and items[f].IsValid) then begin
            If RelativePath and
               (UpperCase (Copy (OutStr, 1, Length(ExtractFilePath (OutfileName)))) =
                UpperCase (ExtractFilePath (OutFileName)))
            then OutStr := Copy (OutStr, Length(ExtractFilePath (OutFileName)) + 1, Length (OutStr));
            If (@FShowExportProgressFunc <> nil) and not FShowExportProgressFunc (items[F], F+1) then begin
              Result := -2;
              Break;
            end;
            WriteLn (OutFile, OutStr);
          end; { if }
        end; { if selected }
      end; { for }
      Flush (OutFile);
      CloseFile (OutFile);
    except
      Result := -1;
    end;
  end; { if }
end; { Function }


{----------------------------------------------}
function TMPEGAudioList.AddFromPLSList (PlayListName : string) : Integer;
var
  i, count : Integer;
  PLSList : TINIFile;
  tempstr : string;

begin
  { Load playlist }
  PLSList := TINIFile.Create (PlayListName);
  count := 0;

  { read data }
  repeat
    Result := 0;
    try
      count := PLSList.ReadInteger ('playlist', 'NumberOfEntries', 0);

    except
      if (@FShowProgressErrorFunc <> nil) then
        Result := FShowProgressErrorFunc (PlayListName)
      else Result := -1;
    end; {try}
  until Result <> mrRetry ;

  { Adjust Result to show errors as negative integers }
  if Result > 0 then
    if Result = mrCancel then Result := -2
    else Result := -1;

  { if playlist file has been read ok then we should process it }
  if Result = 0 then begin
    for i := 0 to count do begin
      tempstr := PLSList.ReadString ('playlist', 'File'+IntToStr(i), '');
      if tempstr <> '' then begin
        if tempstr[2] <> ':' then
          if tempstr[1] = '\' then
            { if item path starts with \ then add Playlist drive }
            tempstr := Copy (PlayListName,1,2) + tempstr
          else
            { in other cases assume that item contains relative path to PlayList path }
              tempstr := ExtractFilePAth (PlayListName) + tempstr;

        Result := AddFile (tempstr);
        if Result > -1 then begin
          { if no error }
          If (@FShowProgressFunc <> nil) then begin
            if not FShowProgressFunc (Items[Result], PlayListName, i+1, count) then
              Result := -2;
          end;
          if (Result = -2) then
            Break; { if users asks cancel in FShowProgressFunc}
        end else
          if (Result = -2) then
            Break; { break for loop if user asked to cancel process on Error}

        { On each 30 iterations, release processor to allow OS do something
          else too }
        if (i MOD 30) = 0 then winProcessMessages;
      end; { if }
    end; { for }
  end; { if Result = 0 }
  PLSList.Free;
end;


{----------------------------------------------}
function TMPEGAudioList.ExportToPLSList (outfilename : string;
                                            ToAppend,
                                            RelativePath,
                                            ExportValid,
                                            SelectedOnly : Boolean) : integer;
var
  F : Integer;
  outfile : TINIFile;
  outstr : string;
  startcount : Integer;

begin
  Result := 0;
  If Count > 0 then begin
    OutFileName := ExpandFileName (OutFileName);
    outfile := TINIFile.Create (OutFileName);

    try
      if Toappend then
        startcount := outfile.ReadInteger ('playlist', 'NumberOfEntries', 0) + 1
      else begin
        StartCount := 1;
        outfile.EraseSection ('playlist');
      end;

      Result := 0;
      For F := 0 to Count-1 do begin
        if not SelectedOnly or (SelectedOnly and (Items[F].Selected <> 0)) then
        begin
          If F div 10 = 0 then winProcessMessages;
          outstr := items[f].SearchExactFilename;
          If not ExportValid or (ExportValid and items[f].IsValid) then begin
            If RelativePath and
               (UpperCase (Copy (OutStr, 1, Length(ExtractFilePath (OutfileName)))) =
                UpperCase (ExtractFilePath (OutFileName)))
            then OutStr := Copy (OutStr, Length(ExtractFilePath (OutFileName)) + 1, Length (OutStr));
            If (@FShowExportProgressFunc <> nil) and not FShowExportProgressFunc (items[F], F+1) then begin
              Result := -2;
              Break;
            end;
            outfile.WriteString ('playlist', 'file' + IntToStr(f+StartCount), OutStr);
          end; { if }
        end; { if selected }
      end; { for }
      outfile.WriteInteger ('playlist', 'NumberOfEntries', startcount + count - 1);
      OutFile.Free;
    except
      Result := -1;
    end;
  end; { if }
end; { Function }

{----------------------------------------------}
function TMPEGAudioList.AddFromMPEGDatafile (DataFileName : string;
                                               var AppID : String;
                                               var HeaderStructType : byte;
                                               var HeaderStructLength : word;
                                               var HeaderStructPtr : pointer) : Integer;

type
  hdrarray = array[1..255] of byte;

var
  f : file;
  tempstr : string[9];
  MPEGData1v0 : TMPEGData1v0;
  MPEGData1v1 : TMPEGData1v1;
  MPEGFile : TMPEGAudio;
  Counter : Integer;
  tmpHeaderLength : byte;
  HeaderData : ^byte; {hdrArray;}
  AppIDData : string[255];
  AppIDDataLen : byte;
  fver : word;
  RealTotalNum : Real;
  TotalNum : Integer;
  HeaderLengthSum : Integer;

begin
  Counter := 0;
  Result := 0;

  try
    AssignFile (f, DataFileName);
    FileMode := 0;
    {$I-}
    Reset (f,1);
    {$I+}
    BlockRead (f, tempstr, SizeOf (tempstr));

    if Copy (TempStr, 1, 7) = 'MP3DATA' then begin

      fver := Ord (tempstr[8])*256 + ord (tempstr[9]);

      BlockRead (f, AppIDDataLen, 1);

      BlockRead (f, AppIDData[1], AppIDDataLen);
      { $IFDEF VER80}
      appIDData[0] := chr (AppIDDataLen);
      { $ELSE}

      AppID := AppIdData;

      BlockRead (f, HeaderStructType, 1);

      { file header is different in version 1.0 }
      If fver = $0100 then begin
        BlockRead (f, tmpHeaderLength, 1);
        HeaderStructLength := tmpHeaderLength;
      end else BlockRead (f, HeaderStructLength, 2);

      GetMem (HeaderData, HeaderStructLength);

      BlockRead (f, HeaderData^, HeaderStructLength);

      HeaderStructPtr := HeaderData;

      { calculate total length of whole header }
      HeaderLengthSum := SizeOf (TempStr)  { 'MP3DATA...'}
                         + 1               { appIDDataLenByte }
                         + AppIDDataLen    { Application custom data }
                         + 1;              { HeaderStructType byte }
      if fver = $0100 then
         { for version 1.0 HeaderStructLength is defined as one byte }
         HeaderLengthSum := HeaderLengthSum + 1
      else
         { newer versions use two bytes for same information }
         HeaderLengthSum := HeaderLengthSum + 2;

      { finaly, count in length of header }
      HeaderLengthSum := HeaderLengthSum + HeaderStructLength;


      { calculate number of records in file }
      case fver of
        $0100 : RealTotalNum := (FileSize (f) - HeaderLengthSum) / SizeOf (TMPEGData1v0);
        $0101 : RealTotalNum := (FileSize (f) - HeaderLengthSum) / SizeOf (TMPEGData1v1);
        else RealTotalNum := (FileSize (f) - HeaderLengthSum) / SizeOf (TMPEGData);
      end; { case }

      { Check if calculated number of records is integer number.
        If not, then there is problem with record length (different
        compilers may interpred TMPEGData type differently). This is
        possible only with m3d versions prior to 1.2 }
      if RealTotalNum = Trunc (RealTotalNum) then begin
        TotalNum := Trunc (RealTotalNum);

        MPEGFile := TMpegAudio.Create;
        MPEGFile.FileDetectionPrecision := FFileDetectionPrecision;
        MPEGFile.onReadError := FShowMPEGAudioReadError;
        MPEGFile.UnknownArtist := FMPEGAudioUnknownArtist;
        MPEGFile.UnknownTitle := FMPEGAudioUnknownTitle;

        while not EOF (f) do begin
          Counter := Counter + 1;
          MPEGFile.ResetData;

          case fver of
            $0100 : begin
                      { if older structure type, convert to new structure }
                      BlockRead (f, MPEGData1v0, SizeOf (TMPEGData1v0));
                      MPEGFile.FData.Header := MPEGData1v0.Header;
                      MPEGFile.FData.Title := MPEGData1v0.Title;
                      MPEGFile.FData.Artist := MPEGData1v0.Artist;
                      MPEGFile.FData.Album := MPEGData1v0.Album;
                      MPEGFile.FData.Year := MPEGData1v0.Year;
                      MPEGFile.FData.Comment := MPEGData1v0.Comment;
                      MPEGFile.FData.Genre := MPEGData1v0.Genre;
                      MPEGFile.FData.Track := MPEGData1v0.Track;
                      MPEGFile.FData.Duration := MPEGData1v0.Duration;
                      MPEGFile.FData.FileLength := MPEGData1v0.FileLength;
                      MPEGFile.FData.Version := MPEGData1v0.Version;
                      MPEGFile.FData.Layer := MPEGData1v0.Layer;
                      MPEGFile.FData.SampleRate := Round (MPEGData1v0.SampleRate * 1000);
                      MPEGFile.FData.BitRate := MPEGData1v0.BitRate;
                      MPEGFile.FData.BPM := MPEGData1v0.BPM;
                      MPEGFile.FData.Mode := MPEGData1v0.Mode;
                      MPEGFile.FData.Copyright := MPEGData1v0.Copyright;
                      MPEGFile.FData.Original := MPEGData1v0.Original;
                      MPEGFile.FData.ErrorProtection := MPEGData1v0.ErrorProtection;
                      MPEGFile.FData.CRC := MPEGData1v0.CRC;
                      MPEGFile.FData.FileName := MPEGData1v0.FileName;
                      MPEGFile.FData.FileDateTime := DateTimeToFileDate (MPEGData1v0.FileDateTime);
                      {MPEGFile.FFileDateTime := MPEGData1v0.FileDateTime;}
                      MPEGFile.FData.FileAttr := MPEGData1v0.FileAttr;
                      MPEGFile.FData.VolumeLabel :=  MPEGData1v0.VolumeLabel;
                    end;
            $0101 : begin
                      { if older structure type, convert to new structure }
                      BlockRead (f, MPEGData1v1, SizeOf (TMPEGData1v1));
                      MPEGFile.FData.Header := MPEGData1v1.Header;
                      MPEGFile.FData.Title := MPEGData1v1.Title;
                      MPEGFile.FData.Artist := MPEGData1v1.Artist;
                      MPEGFile.FData.Album := MPEGData1v1.Album;
                      MPEGFile.FData.Year := MPEGData1v1.Year;
                      MPEGFile.FData.Comment := MPEGData1v1.Comment;
                      MPEGFile.FData.Genre := MPEGData1v1.Genre;
                      MPEGFile.FData.Track := MPEGData1v1.Track;
                      MPEGFile.FData.Duration := MPEGData1v1.Duration;
                      MPEGFile.FData.FileLength := MPEGData1v1.FileLength;
                      MPEGFile.FData.Version := MPEGData1v1.Version;
                      MPEGFile.FData.Layer := MPEGData1v1.Layer;
                      MPEGFile.FData.SampleRate := Round (MPEGData1v1.SampleRate * 1000);
                      MPEGFile.FData.BitRate := MPEGData1v1.BitRate;
                      MPEGFile.FData.BPM := MPEGData1v1.BPM;
                      MPEGFile.FData.Mode := MPEGData1v1.Mode;
                      MPEGFile.FData.Copyright := MPEGData1v1.Copyright;
                      MPEGFile.FData.Original := MPEGData1v1.Original;
                      MPEGFile.FData.ErrorProtection := MPEGData1v1.ErrorProtection;
                      MPEGFile.FData.CRC := MPEGData1v1.CRC;
                      MPEGFile.FData.FileName := MPEGData1v1.FileName;
                      MPEGFile.FData.FileDateTime := DateTimeToFileDate (MPEGData1v1.FileDateTime);
                      {MPEGFile.FFileDateTime := MPEGData1v1.FileDateTime;}
                      MPEGFile.FData.FileAttr := MPEGData1v1.FileAttr;
                      MPEGFile.FData.VolumeLabel :=  MPEGData1v1.VolumeLabel;
                    end;
            $0102 : begin
                      BlockRead (f, MPEGFile.FData, SizeOf (TMPEGData));
                    end;
            else begin
              Result := -1; { MPEG Datafile version not recognized }
              Break;
            end;
          end; { case }

          Add (MPEGFile.Data);
          If (@FShowProgressFunc <> nil) then begin
            if not FShowProgressFunc (MPEGFile, DataFileName, Counter+1, TotalNum) then
            begin
              Result := -2; { aborted by user }
              Break;
            end; { if }
          end; { if }

          { On each 30 iterations, release procesor to allow OS do
            something else too }
          If (Counter MOD 30) = 0 then winProcessMessages;

        end; { while }
        MPEGFile.Free;
      end else Result := -3; { calculated number of records is not integer value }
    end else Result := -1; { file is not mPEGDatafile) }
    Close (f);
    { ucitano sve iz MP3DataFile }
  except
    Result := -1; {error reading file }
  end;
end;

{----------------------------------------------}
function TMPEGAudioList.ExportToMPEGDataFile (outfilename : string;
                            ToAppend, RelativePath,
                            ExportValid,
                            SelectedOnly : Boolean;
                            AppID : string255;
                            HeaderStructType : byte;
                            HeaderStructLength : word;
                            HeaderStructPtr : pointer) : Integer;


var
  F : Integer;
  outfile : file;
  OutStr : string;
  WriteResult : Integer;
  tempInt : Integer;
  StructPtr : ^byte;

begin
  Result := -1;
  { Force MPEGAUDIODATAFILE version to 1.2, since this function exports
    only to that file version (newest). }
  MPEG_DATAFILE_SIGN[8] := #1;
  MPEG_DATAFILE_SIGN[9] := #2;

  { set header structure length }
  If HeaderStructType = MPEG_DF_CATALOGUE then HeaderStructLength := SizeOf (TMPEGDataCatalogue)
  else if HeaderStructType = MPEG_DF_ORDER_FORM then HeaderStructLength := SizeOf (TMPEGDataOrder);

  If Count > 0 then begin
    OutFileName := ExpandFileName (OutFileName);

    try
      System.Assign (OutFile, OutFileName);
      FileMode := 2;
      If ToAppend and FileExists (OutFileName) then begin
        Reset (OutFile,1);
        Seek (OutFile, FileSize (OutFile));
      end else begin
        Rewrite (outFile,1);
        BlockWrite (OutFile, MPEG_DATAFILE_SIGN, SizeOf (MPEG_DATAFILE_SIGN), WriteResult);
        BlockWrite (OutFile, AppID, Length (AppID)+1, WriteResult);
        BlockWrite (OutFile, HeaderStructType, 1, WriteResult);
        BlockWrite (OutFile, HeaderStructLength, 2, WriteResult);
        StructPtr := HeaderStructPtr;
        BlockWrite (OutFile, StructPtr^, HeaderStructLength, WriteResult)
      end;

      For F := 0 to Count-1 do begin
        if not SelectedOnly or (SelectedOnly and (Items[F].Selected <> 0)) then
        begin
          If F div 10 = 0 then winProcessMessages;
          FillChar (OutStr, SizeOf (outStr), #0);
          OutStr := Items[F].FileName;
          If not ExportValid or (ExportValid and Items[f].IsValid) then begin
            If RelativePath and
               (UpperCase (Copy (OutStr, 1, Length(ExtractFilePath (OutfileName)))) =
                UpperCase (ExtractFilePath (OutFileName)))
            then OutStr := Copy (OutStr, Length(ExtractFilePath (OutFileName)) + 1, Length (OutStr));
            Items[F].FData.FileName := OutStr;

            tempInt := Length (OutStr);

            Items[F].FData.FileName := PadLeft (Items[F].FileName, SizeOf (Items[F].FData.FileName)-1, #0);
            Items[F].FData.FileName := Copy (Items[F].FileName, 1, tempInt);

            If (@FShowExportProgressFunc <> nil) then
              If Not ShowExportProgressFunc (Items[F], F+1) then begin
                Result := mrCancel;
                Break;
              end; { if }

            BlockWrite (OutFile, Items[F].FData, SizeOf (Items[F].FData), WriteResult);

            If WriteResult <> SizeOf (Items[F].FData) then begin
              Result := -1;
              Break;
            end;
          end; { if }
        end; { if selected }
      end; { for }
      CloseFile (OutFile);
    except
      Result := -1;
    end;
  end; { if }
end; { function }


{----------------------------------------------}
function TMPEGAudioList.FGetMPEGAudio(IndexNr : integer) : TMPEGAudio;
begin
  Result := TMPEGAudio (inherited Items[IndexNr]);
end;


{----------------------------------------------}
procedure TMPEGAudioList.Clear;
var f : Integer;
begin
  for F := 0 to Count-1 do begin
    MPEGFile := inherited Items[F];
    MPEGFile.Free;
    MPEGFile := nil;
  end;
  inherited Clear;
end;

{----------------------------------------------}
procedure TMPEGAudioList.Delete (Index : Integer);
begin
  MPEGFile := inherited Items[Index];
  MPEGFile.Free;
  MPEGFile := nil;
  inherited Delete(Index);
end;

{----------------------------------------------}
procedure TMPEGAudioList.Remove (ItemPtr : pointer);
begin
  MPEGFile := ItemPtr;
  MPEGFile.Free;
  MPEGFile := nil;
  inherited Remove (ItemPtr);
end;

{----------------------------------------------}
function TMPEGAudioList.GetFileType (filename : string) : Integer;
var
  f : file;
  fsize : Longint;
  tempstr : string[10];
  mp3hdrread : array[1..4] of byte;
  mp3hdr : LongInt ABSOLUTE mp3hdrread;
  tempbyte : byte;
  Data : TMPEGData;
  FirstValidFrame : Word;
  tempLongInt : LongInt;

begin
  Result := FT_ERROR;

  if FileExists (filename) then begin
    AssignFile (f, filename);

    FileMode := 0;
    try
      Reset (f,1);

      Result := FT_UNKNOWN;
      fsize:= FileSize (f);
      If Fsize > SizeOf (TempStr) then begin
         BlockRead (f, tempstr, SizeOf (tempstr));
         If UpperCase (Copy (tempstr,1,7)) = 'MP3DATA' then
            Result := FT_MPEG_DATAFILE;
      end;
      If (Result = FT_UNKNOWN) and (fsize > 4) then begin
        Seek (f, 0);
        repeat
          { check for MPEG Audio }
          { read MPEG heder from file }
          BlockRead (f, mp3hdrread,4);
          tempbyte := mp3hdrread[1];
          mp3hdrread[1] := mp3hdrread[4];
          mp3hdrread[4] := tempbyte;
          tempbyte := mp3hdrread[2];
          mp3hdrread[2] := mp3hdrread[3];
          mp3hdrread[3] := tempbyte;

          Data.FileLength := FileSize (f);

          While (not DecodeHeader (mp3hdr, Data)) and (not Eof (f)) and
                ((FilePos(f) <= FFileDetectionPrecision)
                or (FFileDetectionPrecision = 0))
          do begin
             { if mpeg header is not at the begining of the file, search file
                to find proper frame sync. This block can be speed up by reading
                blocks of bytes instead reading single byte from file }
              mp3hdr := mp3hdr shl 8;
              BlockRead (f, tempbyte,1);
              mp3hdrread[1] := tempbyte;

              { On each 300 iterations, release procesor to allow OS do
                something else too }
              If (FilePos (f) MOD 300) = 0 then winProcessMessages;
          end; { while }

          FirstValidFrame := FilePos (f)-4;
          tempLongInt := Data.FileLength - FirstValidFrame - Data.FrameLength + (2 * Byte(Data.ErrorProtection));

          If FrameHeaderValid (Data) and (TempLongInt > 0) then begin
            { Ok, one header is found, but that is not good proof that file realy
              is MPEG Audio. But, if we look for the next header which must be
              FrameLength bytes after first one, we may be very sure file is
              valid. }
            Seek (f, FirstValidFrame + Data.FrameLength);
            BlockRead (f, mp3hdrread,4);
            tempbyte := mp3hdrread[1];
            mp3hdrread[1] := mp3hdrread[4];
            mp3hdrread[4] := tempbyte;
            tempbyte := mp3hdrread[2];
            mp3hdrread[2] := mp3hdrread[3];
            mp3hdrread[3] := tempbyte;

            If DecodeHeader (mp3hdr, Data) then
              Result := FT_MPEG_AUDIO
            else Seek (f, FirstValidFrame + 1);
          end;
        until DecodeHeader (mp3hdr, Data) or Eof (f) or
              ((FilePos(f) > FFileDetectionPrecision) and
              (FFileDetectionPRecision > 0));
      end;{ of MPEG Audio Check }
    except
      Result := FT_ERROR;
    end;

    If (Result = FT_UNKNOWN) then
      if (UpperCase (ExtractFileExt (filename)) = '.M3U') then
        Result := FT_WINAMP_PLAYLIST
      else if (UpperCase (ExtractFileExt (filename)) = '.PLS') then
        Result := FT_PLS_PLAYLIST;

    Close (f);
  end; { if }
end; { function GetFileType }

{----------------------------------------------}
destructor TMPEGAudioList.destroy;
var f : Integer;
begin
  for F := 0 to Count-1 do begin
    MPEGFile := inherited Items[F];
    if MPEGFile <> nil then begin
      MPEGFile.Free;
      MPEGFile := nil;
    end;
  end;
  Inherited;
end;

(*{----------------------------------------------}
destructor TMPEGAudioList.Destroy;
var f : Integer;
begin
  {for F := 0 to Count-1 do begin
    MPEGFile := Items[F];
    MPEGFile.Destroy;
    MPEGFile := nil;
  end;}
  Inherited Destroy;
end;
*)


{----------------------------------------------}
function TMPEGAudioList.InternalSortCompareFunc (Item1, Item2: Pointer): Integer;
  { Internal function for comparing sorted items in list has input
    pointers to two compared items and returns 0 if items are equal,
    1 if Item1 > Item2 or -1 if Item1 < Item 2. It uses FSortMacro
    to calculate actual string values that should be compared. }
var
  MPEG1, MPEG2 : TMPEGAudio;
  Macro1, Macro2 : string;
begin
  MPEG1 := Item1;
  MPEG2 := Item2;
  Macro1 := MPEG1.Textilize (FSortMacro);
  Macro2 := MPEG2.Textilize (FSortMacro);

  If Macro1 > Macro2 then Result := 1
  else If Macro1 < Macro2 then Result := -1
       else Result := 0;
end;

{----------------------------------------------}
function TMPEGAudioList.DoUserSortCompareFunc (Item1, Item2: Pointer): Integer;
{ this is envelope to UserSortCompareFunc to assure type compatibility }
begin
  Result := UserSortCompareFunc (Item1, Item2);
end;

{----------------------------------------------}
procedure TMPEGAudioList.Sort (Compare : TListSortCompare);
begin
 if (List <> nil) and (Count > 0) and (@Compare <> nil) then
   if SortDirection = srtAscending then
     QuickSort(List, 0, Count - 1, Compare, 1, FShowSortProgressFunc)
   else
    QuickSort(List, 0, Count - 1, Compare, -1, FShowSortProgressFunc);
end;

{----------------------------------------------}
procedure TMPEGAudioList.DoSort;
var
 CompFunc : TListSortCompare;
begin
  CompFunc := nil;
  If SortMethod <> smNone then begin
    If (SortMethod = smUser) and (@FUserSortCompareFunc <> nil) then
      CompFunc := DoUserSortCompareFunc
    else
      if (Pos('%', SortMacro) <> 0) then
        CompFunc := InternalSortCompareFunc;

   Sort(CompFunc);
  end; { if }
end;

{************************************************************
 TTemplate methods
************************************************************}

constructor TTemplate.Create;
begin
  inherited Create;
end;

procedure TTemplate.Reset;
begin
  with Data do begin
    Name := '';
    Ext := '';
    IncludeHeader := False;
    FilterData := False;
    FilterDataStyle := '';
    SortData := False;
    SortDataStyle := '';
    SortDescending := False;
    GroupData := False;
    GroupDataStyle := '';
    RunProgram := False;
    HeaderFile := '';
    Footerfile := '';
    HeaderStyle := '';
    GroupHeaderStyle := '';
    BodyStyle := '';
    GroupFooterStyle := '';
    FooterStyle := '';
    ProgramFile := '';
    ProgramStyle := '';
  end;
end;


{************************************************************
 TMPEGReport methods
************************************************************}

constructor TMPEGReport.Create;
begin
  inherited Create;
  fOutput := TStringList.Create;
  Reset;
end;

destructor TMPEGReport.Destroy;
begin
  fOutput.Free;
  inherited;
end;

procedure TMPEGReport.Reset;
begin
  fTemplate := nil;
  fOutputFileName := '';
  fRecordNo := 0;
  fGroupNo := 0;
  fGroupRecordNo := 0;
  fGroupRecordCount := 0;
  fGroupCount := 0;
  fArtistCount := 0;
  fGroupDurationSum := 0;
  fDurationSum := 0;
  fGroupLengthSum := 0;
  fLengthSum := 0;
  fMPEGAudioList := nil;
  fShowSortBeginProc := nil;
  fShowSortEndProc := nil;
  fOutput.Clear;
end;


procedure TMPEGReport.fSetMPEGAudioList (NewMPEGAudioList : TMPEGAudioList);
begin
  fMPEGAudioList := NewMPEGAudioList;
  if fMPEGAudioList = nil then Reset;
end;

procedure TMPEGReport.fSetTemplate (NewTemplate : TTemplate);
begin
  fTemplate := NewTemplate;
end;

procedure TMPEGReport.BeginReport;
var
  CountList : TStringList;
  f : Integer;
  TempStr : string;
begin

  CountList := TStringList.Create;
  Reset;

  { count number of artists and calculate total duration and total length }
  CountList.Clear;
  for f := 0 to fMPEGAudioList.Count-1 do begin
    if CountList.IndexOf (UpperCAse (fMPEGAudioList.Items[F].Artist)) < 0 then
      CountList.Add (UpperCase (fMPEGAudioList.Items[F].Artist));
    fDurationSum := fDurationSum + LongInt (fMPEGAudioList.Items[F].Duration);
    fLengthSum := fLengthSum + LongInt (fMPEGAudioList.Items[F].FileLength);
  end; { for }
  fArtistCount := CountList.Count;

  { sort list used for report }
  fMPEGAudioList.SortMacro := fTemplate.Data.SortDataStyle;
  if fTemplate.Data.SortDescending then
    fMPEGAudioList.SortDirection := srtDescending
  else fMPEGAudioList.SortDirection := srtAscending;
  if fTemplate.Data.SortData and (fTemplate.Data.SortDataStyle <> '') then begin
    fMPEGAudioList.SortMethod := smInternal;
    if @fShowSortBeginProc <> nil then ShowSortBeginProc (0, fMPEGAudioList.Count);
    fMPEGAudioList.DoSort;
    if @fShowSortEndProc <> nil then ShowSortEndProc;
  end else fMPEGAudioList.SortMethod := smNone;

  { count number of groups that will show in report }
  CountList.Clear;
  For F := 0 to fMPEGAudioList.Count-1 do begin
    TempStr := fMPEGAudioList.Items[F].Textilize (fTemplate.Data.GroupDataStyle);
    if CountList.IndexOf (TempStr) < 0 then
      CountList.Add (TempStr);
  end; { for }
  fGroupCount := CountList.Count;

  CountList.Free;
end;



{************************************************************
TMACRODEFINITIONS methods
************************************************************}

{----------------------------------------------}
constructor TMacroDefinitions.Create;
begin
  inherited Create;
  MacroDelimiterChar := '%';
end;

{----------------------------------------------}
destructor TMacroDefinitions.destroy;
var
  i : Integer;
begin
  for i := Count-1 downto 0 do
    Items[i].Free;
  inherited;
end;

{----------------------------------------------}
function TMacroDefinitions.FGetMacroData (IndexNr : Integer) : TMacro;
begin
  Result := inherited Items[IndexNr];
end;

{----------------------------------------------}
function TMacroDefinitions.Add (ShortName,
                                LongName : string;
                                DefaultLength : Integer;
                                DefaultAlignment : char;
                                DefaultCapitalization : char;
                                Description,
                                Cathegory : string;
                                MacroType : TMacroDataType;
                                ValueProc : pointer;
                                CustomString : string) : Integer;

var
  MacroData : TMacro;
begin
  MacroData := TMacro.Create;
  MacroData.ShortName := ShortName;
  MacroData.LongName := LongName;
  MacroData.DefaultLength := DefaultLength;
  MacroData.DefaultAlignment := DefaultAlignment;
  MacroData.DefaultCapitalization := DefaultCapitalization;
  MacroData.Description := Description;
  MacroData.Cathegory := Cathegory;
  MacroData.MacroType := MacroType;
  MacroData.ValueProc := ValueProc;
  MacroData.CustomString := CustomString;
  Result := inherited Add (MacroData);
end;

{----------------------------------------------}
function TMacroDefinitions.Find (MacroName : string) : Integer;
var
  i : Integer;
begin
  MacroName := UpperCase (MacroName);
  Result := -1;
  for i := 0 to Count-1 do begin
    if (UpperCase (Items[i].LongName) = MacroName) or
       (UpperCase (Items[i].ShortName) = MacroName) then Result := i;
  end;
end;

{----------------------------------------------}
function GetMacroValue (MacroItem : string;
                        Macros : TMacroDefinitions;
                        MPEGAudio : TMPEGAudio;
                        MPEGReport : TMPEGReport
                                     ) : string;
var
  MPEGAudioFunc : TGetMPEGAudioValue;
  MPEGReportFunc : TGetMPEGReportValue;
  SpecialFunc : TGetSpecialValue;
  MacroIndex : Integer;
  ItemName : string;
  ItemAlignment : char;
  ItemLength : Integer;
  ItemPadChar : char;
  ItemCapitalizeChar : char;
  tempstr : string;
  DefaultLength : integer;
  DefaultAlignment : char;
  DefaultCapitalization : char;

begin
  { skini znak '%' s pocetka i kraja stringa }
  MacroItem := Copy (MacroItem, 2, Length (MacroItem)-2);

  { procitaj ime polja }
  ItemName := UpperCase (Trim (WordGet (MacroItem, 1, [','])));

  { ako je Item prazan string, tj. bila su dva znaka % uzastopno treba
    ih zameniti jednim znakom & }
  If ItemName = '' then Result := Macros.MacroDelimiterChar
  else begin
    DefaultAlignment := 'L';
    DefaultCapitalization := 'N';
    { ako je item broj, to znaci da treba staviti ascii znak s tim kodom }
    If IsNumber (ItemName) then begin
      ItemName := Chr (StrToIntDef (ItemName, 1));
      If ItemName = #0 then ItemName := #1;
      DefaultLength := 1;
    end else
    { ako je item NewLine, treba ubaciti kod za novi red }
    if (ItemName = 'NEWLINE') or (ItemName = 'NL') then begin
      ItemName := Chr (13) + Chr (10) + '';
      DefaultLength := 2;
    end else
    { ako je item #, treba ga ignorisati, jer je to kod za SoftNewLine }
    if (ItemName = 'SOFTNEWLINE') or (ItemName = '#') then begin
      ItemName := '';
      DefaultLength := 0;
    end else
    { ako je item TAB ubaciti tabulator }
    if (ItemName = 'TAB') or (ItemName = 'TB') then begin
      ItemName := #9;
      DefaultLength := 1;
    end else begin
      With Macros do begin
        MacroIndex := Find (ItemName);
        if (MacroIndex > -1) and
           not ((Items[MacroIndex].MacroType = mctMPEGAudio) and (MPEGAudio = nil)) and
           not ((Items[MacroIndex].MacroType = mctMPEGReport) and (MPEGREport = nil))
        then begin
          if (Items[MacroIndex].ValueProc <> nil) or
             {$IFNDEF VER80}(Items[MacroIndex].MacroType = mctComplexMacro) or{$ENDIF}
             (Items[MacroIndex].MacroType = mctNoExec)
          then begin
            DefaultLength := Items[MacroIndex].DefaultLength;
            DefaultAlignment := Items[MacroIndex].DefaultAlignment;
            DefaultCapitalization := Items[MacroIndex].DefaultCapitalization;
            case Items[MacroIndex].MacroType of
              mctMPEGAudio :
                begin
                  MPEGAudioFunc := TGetMPEGAudioValue (Items[MacroIndex].ValueProc);
                  ItemName := Trim (MPEGAudioFunc (MPEGAudio));
                end;
              mctMPEGReport :
                begin
                  MPEGReportFunc := TGetMPEGReportValue (Items[MacroIndex].ValueProc);
                  ItemName := Trim (MPEGReportFunc (MPEGReport));
                end;
              mctSpecial :
                begin
                  SpecialFunc := TGetSpecialValue (Items[MacroIndex].ValueProc);
                  ItemName := Trim (SpecialFunc);
                end;
              mctNoExec :
                begin
                  ItemName := ItemName + 'is NoExec Item!';
                  DefaultLength := Length (ItemName);
                end;
              {$IFNDEF VER80}
              mctComplexMacro :
                begin
                  ItemName := Textilize (Items[MacroIndex].CustomString,
                              MPEGAudio, MPEGReport);
                end;
              {$ENDIF}
            else
              ItemName := MacroDelimiterChar + MacroItem + MacroDelimiterChar;
              MacroItem := '';
              DefaultLength := -1;
              DefaultAlignment := 'T';
              DefaultCapitalization := 'N';
            end; { case }
          end else begin
            ItemName := ItemName + ' association error!!! ';
            DefaultLength := Length (ItemName);
          end;
        end else begin
          ItemName := MacroDelimiterChar + MacroItem + MacroDelimiterChar;
          MacroItem := '';
          DefaultLength := -1;
          DefaultAlignment := 'T';
          DefaultCapitalization := 'N';
        end; { If MacroIndex... }
      end; { with }
    end; { if ItemName.. }

    { procitaj duzinu polja }
    TempStr := Trim (WordGet (MacroItem, 3, [',']));
    ItemLength := StrToIntDef (TempStr,-1);

    { procitaj nacin poravnanja polja }
    TempStr := UpperCase (Trim (WordGet (MacroItem, 2, [','])))+' ';
    If TempStr[1] IN ['L','R','C','T'] then
      ItemAlignment := TempStr[1]
    else begin
      ItemAlignment := DefaultAlignment;
      ItemLength := 0;
    end;

    { procitaj znak za popunjavanje }
    TempStr := Trim (WordGet (MacroItem, 4, [',']))+' ';
    ItemPadChar := TempStr[1];

    { procitaj znak za kapitalizaciju }
    TempStr := UpperCase (Trim (WordGet (MacroItem, 5, [','])))+' ';
    If TempStr[1] IN ['U','L','C','F','N'] then
      ItemCapitalizeChar := TempStr[1]
    else
      ItemCapitalizeChar := DefaultCapitalization;

    { izvrsi odgovarajucu kapitalizaciju polja }
    case ItemCapitalizeChar of
      {uppercase}    'U' : ItemName := UpperCase (ItemName);
      {lowercase}    'L' : ItemName := LowerCase (ItemName);
      {capitalize}   'C' : ItemName := Capitalize (ItemName, InterpunctionChars);
      {capitalfirst} 'F' : ItemName := CapitalFirst (ItemName);
                    else ItemName := ItemName;
    end; { case }

    { ako se stavlja polje stvarne duzine, onda se izbegava bilo kakvo formatirnje }
    If ItemLength < 0 then Result := ItemName
    else begin { u suprotnom mora se formatirati sadrzaj pre stavljanja u izlaznu datoteku }

      { ako je duzina polja 0 to znaci da se koristi default duzina polja }
      if ItemLength = 0 then ItemLength := DefaultLength;
      {$IFDEF VER80}
        if ItemLength > 255 then ItemLength := 255;
      {$ENDIF}

      Case ItemAlignment of
        { levo poravnanje }
        'L' : ItemName := PadLeft (ItemName, ItemLength, ItemPadChar);
        { desno poravnanje }
        'R' : ItemName := PadRight (ItemName, ItemLength, ItemPadChar);
        { centrirano }
        'C' :ItemName := PadCenter (ItemName, ItemLength, ItemPadChar);
        { trimovano }
        'T' :ItemName := ItemName;
      end; { case }
      Result := ItemName;
    end; { if }
  end; { if }
end; { function }

{----------------------------------------------}
function TMacroDefinitions.GetValue (MacroItem : string;
                                     MPEGAudio : TMPEGAudio;
                                     MPEGReport : TMPEGReport
                                     ) : string;
begin
  Result := GetMacroValue (MacroItem, Self, MPEGAudio, MPEGReport)
end;


{----------------------------------------------}
function TMacroDefinitions.Textilize (MacroStr : string;
                                      MPEGAudio : TMPEGAudio;
                                      MPEGReport : TMPEGReport) : string;
var
  nextpart : integer;
  InStrLen : integer;
  ItemPos : Integer;
  ItemLast : integer;
  ItemStr : string;
  ItemOut : string;
  OutStr : string;
begin
  outStr := '';
  nextpart := 1;
  InStrLen := Length (MacroStr);

  while nextpart <= InStrLen do begin
    itemPos := PosFirst (MacroStr, MacroDelimiterChar, nextpart);
    If (ItemPos - nextpart) > 0 then
      Outstr := OutStr + Copy (MacroStr,nextpart, ItemPos-NextPart);
    If ItemPos <> 0 then begin
      itemLast := PosFirst (MacroStr, MacroDelimiterChar, ItemPos+1);
      If ItemLast <> 0 then begin
        ItemStr := Copy (MacroStr, ItemPos+1, ItemLast-ItemPos-1);
        nextpart := ItemLast+1;
        ItemOut := GetMacroValue (MacroDelimiterChar+ItemStr+MacroDelimiterChar, Self, MPEGAudio, MPEGReport);
        If Length (ItemOut) > 0 then OutStr := OutStr + ItemOut;
      end else begin
        OutStr := OutStr + '<<<ERROR!!! No end of item definition!>>>';
        nextPart := InStrLen+1;
      end; { if }
    end else begin
      OutStr := OutStr + Copy (MacroStr, nextpart, InStrLen);
      nextPart := InStrLen+1;
    end;
  end; { while }
  Result := outstr;
end;

{----------------------------------------------}
function TMacroDefinitions.FCompareMacroItems (Item1, Item2: pointer): Integer;
var
  M1, M2 : TMacro;
begin
  M1 := Item1;
  M2 := Item2;
  If (M1.Cathegory + M1.LongName) > (M2.Cathegory + M2.LongName) then
    Result := 1
  else
    If (M1.Cathegory + M1.LongName) < (M2.Cathegory + M2.LongName) then
      Result := -1
    else Result := 0;
end;


{----------------------------------------------}
procedure TMacroDefinitions.Sort;
var
  Compare : TListSortCompare;
begin
 Compare := FCompareMacroItems;
 if (List <> nil) and (Count > 0) then
    QuickSort(List, 0, Count - 1, Compare, 1, nil)
end;


{************************************************************
TMacroDefinitions supporting functions (public)
************************************************************}

procedure CreateMacroDescriptionFile (outfilename : string; Delimiter : TMacroListDelimiter);
const
  Tab = #9;
var
  i : Integer;
  outfile : Text;
  LastCathegory : string;
begin
  Macros.Sort;

  Assign (OutFile, OutFileName);
  FileMode := 2;

  Rewrite (outfile);

  WriteLn (outfile);
  WriteLn (outfile, 'MPGTools macros');
  WriteLn (outfile);

  LastCathegory := ' ';
  For i := 0 to Macros.Count-1 do begin
    With Macros.Items[i] do begin
      if Cathegory <> LastCathegory then begin
        WriteLn (outfile,'');
        WriteLn (outfile, Cathegory);
        WriteLn (outfile,'');
        if Delimiter = Tabs then begin
          WriteLn (outfile,'Tag'+Tab+'Tag'+Tab+'Def'+Tab+'Def'+Tab+'Def');
          WriteLn (outfile,'Short'+Tab+'Long'+Tab+'Len'+Tab+'Algn'+Tab+'Caps'+Tab+'Description');
          WriteLn (outfile,'----------------------------------------------------------'+
                           '---------------------------------------------------------');
        end else begin
          WriteLn (outfile,'Tag     Tag                           Def Def  Def');
          WriteLn (outfile,'Short   Long                          Len Algn Caps Description');
          WriteLn (outfile,'----------------------------------------------------------'+
                           '---------------------------------------------------------');
        end;
        LastCathegory := Cathegory;
      end;

      if Delimiter = Tabs then
        WriteLn (outfile,
                 Trim (Macros.MacroDelimiterChar+ShortName+Macros.MacroDelimiterChar), Tab,
                 Trim (Macros.MacroDelimiterChar+LongName+Macros.MacroDelimiterChar), Tab,
                 InttoStr (DefaultLength), Tab,
                 Trim (DefaultAlignment), Tab,
                 Trim (DefaultCapitalization), Tab,
                 IIFStr ((MacroType <> mctNoExec) and (MacroType <> mctComplexMacro) and (ValueProc = nil),'*', ''),
                 Trim (Description)
                 )
      else
        WriteLn (outfile,
           PadLeft (Macros.MacroDelimiterChar+ShortName+Macros.MacroDelimiterChar,8,' '),
           PadLeft (Macros.MacroDelimiterChar+LongName+Macros.MacroDelimiterChar,28, ' '),
           PadRight (InttoStr (DefaultLength) ,5, ' '),
           PadRight (DefaultAlignment,3, ' '), '  ',
           PadRight (DefaultCapitalization,3, ' '), '   ',
           IIFStr ((MacroType <> mctNoExec) and (MacroType <> mctComplexMacro) and (ValueProc = nil),'*', ''),
           Description
           );
    end; { with }
  end; { for }
  WriteLn (outfile,'----------------------------------------------------------'+
                   '---------------------------------------------------------');
  WriteLn (outfile);
  WriteLn (outfile,'Note: macros marked with ''*'' are not yet implemented.');
  WriteLn (outfile);
  CloseFile (OutFile);
end;

{************************************************************
TMacroDefinitions supporting functions (private)
************************************************************}

function GetMPEGFileName (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := ExtractFileName (MPEGAudio.FileName);
end;

{$IFNDEF VER80}
function GetMPEGFileNameShort (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := ExtractFileName (MPEGAudio.FileNameShort);
end;
{$ENDIF}

function GetMPEGFilePath (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := ExtractFilePath (MPEGAudio.FileName);
end;

function GetMPEGVolumeLabel (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := ExtractFileName (MPEGAudio.VolumeLabel);
end;

function GetMPEGTitle (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.Title;
end;

function GetMPEGExtractedArtist (const MPEGAudio : TMPEGAudio) : string;
var
  DelimiterPos : Integer;
begin
  Result := ExtractFileName (MPEGAudio.FileName);
  DelimiterPos := Pos (FileNameDataDelimiter, Result);
  If DelimiterPos > 0 then
    Result := Trim (Copy (Result, 1, DelimiterPos - 1))
  else Result := '';
end;

function GetMPEGGuessedArtist (const MPEGAudio : TMPEGAudio) : string;
begin
  if MPEGAudio.isTagged then
    Result := MPEGAudio.Artist
  else begin
    Result := GetMPEGExtractedArtist (MPEGAudio);
    if Result = '' then Result := MPEGAudio.UnknownArtist;
  end;
end;


function GetMPEGExtractedTitle (const MPEGAudio : TMPEGAudio) : string;
var
  DelimiterPos : Integer;
begin
  Result := ExtractFileName (MPEGAudio.FileName);
  DelimiterPos := Pos (FileNameDataDelimiter, Result);
  if DelimiterPos > 0 then
    Result := Trim (Copy (Result, DelimiterPos + 1, Length (Result)))
  else Result := '';
  for DelimiterPos := Length (Result) downto 1 do
    if Result[DelimiterPos] = '.' then begin
      Result := Copy (Result, 1, DelimiterPos - 1);
      Break;
    end;
end;

function GetMPEGGuessedTitle (const MPEGAudio : TMPEGAudio) : string;
begin
  if MPEGAudio.isTagged then
    Result := MPEGAudio.Title
  else begin
    Result := GetMPEGExtractedTitle (MPEGAudio);
    if Result = '' then Result := MPEGAudio.UnknownTitle;
  end;
end;

function GetMPEGFileDate (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := DateToStr (MPEGAudio.FileDateTime);
end;

function GetMPEGFileDateTimeforSort (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := FormatDateTime ('yyyymmddhhnnss', MPEGAudio.FileDateTime);
end;

function GetMPEGFileTime (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := TimeToStr (MPEGAudio.FileDateTime);
end;

function GetMPEGArtist (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.Artist;
end;

function GetMPEGAlbum (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.Album;
end;

function GetMPEGYear (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.Year;
end;

function GetMPEGComment (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.Comment;
end;

function GetMPEGGenre (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.GenreStr;
end;

function GetMPEGGenreNr (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.Genre)
end;

function GetMPEGTrack (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.Track)
end;

function GetMPEGDuration (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.Duration)
end;

function GetMPEGDurationComma (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.0n', [MPEGAudio.Duration/1]);
end;

function GetMPEGDurationMinutes (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.1n', [MPEGAudio.Duration/60])
end;

function GetMPEGDurationMinutesComma (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.1n', [MPEGAudio.Duration/60]);
end;

function GetMPEGDurationForm (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := FormatDateTime ('n' + TimeSeparator + 'ss', SecondsToTime (MPEGAudio.Duration));
end;

function GetMPEGLength (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.FileLength);
end;

function GetMPEGLengthComma (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.0n', [MPEGAudio.FileLength/1]);
end;

function GetMPEGLengthKB (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.FileLength DIV 1024);
end;

function GetMPEGLengthKBComma (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.0n', [MPEGAudio.FileLength / 1024]);
end;

function GetMPEGLengthMB (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%20.1f', [MPEGAudio.FileLength / (1024*1024)]);
  If Result [Length(Result)] = DecimalSeparator then Result := Result + '0';
end;

function GetMPEGVersion (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEG_VERSIONS [MPEGAudio.Version];
end;

function GetMPEGLayer (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.LayerStr;
end;

function GetMPEGLayerNr (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.Layer);
end;

function GetMPEGSampleRate (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IntToStr (MPEGAudio.SampleRate);
end;

function GetMPEGSampleRateKHz (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := Format ('%4.1f', [MPEGAudio.SampleRate/1000]);
  If Result [Length(Result)] = DecimalSeparator then Result := Result + '0';
end;

function GetMPEGBitRate (const MPEGAudio : TMPEGAudio) : string;
begin
  if MPEGAudio.BitRate <> -1 then
    Result := IntToStr (MPEGAudio.BitRate)
  else Result := 'VBR';
end;

function GetMPEGErrorProt (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.ErrorProtectionStr ('Yes','No');
end;

function GetMPEGErrorProtA (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.ErrorProtectionStr ('*',' ');
end;

function GetMPEGCopyright (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.CopyrightStr ('Yes','No');
end;

function GetMPEGCopyrightA (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.CopyrightStr ('*',' ');
end;

function GetMPEGOriginal (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.OriginalStr ('Yes','No');
end;

function GetMPEGOriginalA (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.OriginalStr ('*',' ');
end;

function GetMPEGMode (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := MPEGAudio.ModeStr;
end;

function GetMPEGStereo (const MPEGAudio : TMPEGAudio) : string;
begin
  Result := IIFStr (MPEGAudio.Mode <> 3,'Stereo','Mono');
end;

function GetProgramVersion : string;
begin
  Result := 'MPGTools ' + UnitVersion;
end;

function GetCurrentSystemDate : string;
begin
  Result := DateToStr (Now);
end;

function GetCurrentSystemTime : string;
begin
  Result := TimeToStr (Now);
end;

initialization
begin
  Macros := TMacroDefinitions.Create;
  With Macros do begin
    { mctMPEG Audio }
    Add ('FN','FileName',40,'L','N',
         'Mpeg audio file name', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGFileName, '');
    {$IFNDEF VER80}
    Add ('FNS','FileNameShort',40,'L','N',
         'Mpeg audio file name short (8+3)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGFileNameShort, '');
    {$ENDIF}
    Add ('FP','FilePath',40,'L','N',
         'MPEG audio file path (without file name)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGFilePath, '');
    Add ('VL','VolumeLabel',11,'L','N',
         'Volume label', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGVolumeLabel, '');
    Add ('T','Title',30,'L','N',
         'Title', 'Mpeg audio file', mctMPEGAudio, @GetMPEGTitle, '');
    Add ('ET','ExtractedTitle',30,'L','N',
         'Title extracted from file name', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGExtractedTitle, '');
    Add ('GT','GuessedTitle',30,'L','N',
         'Title guessed from TAG or from file name', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGGuessedTitle, '');
    Add ('FD','FileDate',10,'L','N',
         'Date of last file change', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGFileDate, '');
    Add ('FDTFS','FileDateTimeForSort',14,'L','N',
          'File Date time formated for sorting (yyyymmddhhmmss).',
          'Mpeg audio file', mctMPEGAudio, @GetMPEGFileDateTimeForSort, '');
    Add ('FT','FileTime',11,'L','N',
         'Time of last file change', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGFileTime, '');
    Add ('A','Artist',30,'L','N','Artist', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGArtist, '');
    Add ('EA','ExtractedArtist',30,'L','N',
         'Artist extracted from file name', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGExtractedArtist, '');
    Add ('GA','GuessedArtist',30,'L','N',
         'Artist guessed from TAG or from file name', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGGuessedArtist, '');
    Add ('ALB','Album',35,'L','N','Album', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGAlbum, '');
    Add ('Y','Year',4,'L','N','Year', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGYear, '');
    Add ('CMNT','Comment',30,'L','N','Comment', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGComment, '');
    Add ('G','Genre',25,'L','N','Genre description', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGGenre, '');
    Add ('GNR','GenreNr',3,'R','N','Genre code', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGGenreNr, '');
    Add ('TR','Track',3,'R','N','Album track number', 'Mpeg audio file',
         mctMPEGAudio, @GetMPEGTrack, '');
    Add ('D','Duration',8,'R','N','Duration (seconds)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGDuration, '');
    Add ('DC','DurationComma',10,'R','N',
         'Duration, thousands comma delimited (seconds)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGDurationComma, '');
    Add ('DM','DurationMinutes',7,'R','N',
         'Duration (minutes)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGDurationMinutes, '');
    Add ('DMC','DurationMinutesComma',9,'R','N',
         'Duration, thousands comma delimited (minutes)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGDurationMinutesComma, '');
    Add ('DF','DurationForm',8,'R','N',
         'Duration (formated as MM:SS)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGDurationForm, '');
    Add ('L','Length',12,'R','N','File length in bytes', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGLength, '');
    Add ('LC','LengthComma',15,'R','N',
         'File length in bytes, thousands comma delimited', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGLengthComma, '');
    Add ('LK','LengthKB',9,'R','N','File length in kilobytes',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGLengthKB, '');
    Add ('LKC','LengthKBComma',11,'R','N',
         'File length in kilobytes, thousands comma delimited',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGLengthKBComma, '');
    Add ('LM','LengthMB',9,'R','N',
         'File length in megabytes (one decimal place)', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGLengthMB, '');
    Add ('V','Version',3,'L','N', 'MPEG Audio version.', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGVersion, '');
    Add ('LY','Layer',3,'L','N',
         'MPEG Audio Layer Type (I, II, III or else for unknown)',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGLayer, '');
    Add ('LYN','LayerNr',1,'L','N',
         'MPEG Audio Layer Type (1, 2, 3 or else for unknown)',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGLayerNr, '');
    Add ('SR','SampleRate',5,'R','N','Sample rate', 'Mpeg audio file',
         mctMPEGAudio, @GetMPEGSampleRate, '');
    Add ('SRK','SampleRateKHz',4,'R','N',
         'Sample rate in kilobytes', 'Mpeg audio file',
         mctMPEGAudio, @GetMPEGSampleRateKHz, '');
    Add ('BR','BitRate',3,'R','N','BitRate in kilobytes', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGBitRate, '');
    Add ('EP','ErrorProt',3,'L','N','Error protection (''Yes''/''No'')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGErrorProt, '');
    Add ('EP*','ErrorProt*',1,'L','N','Error Protection (''*''/'' '')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGErrorProtA, '');
    Add ('C','Copyright',3,'L','N','Copyrighted (''Yes''/''No'')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGCopyright, '');
    Add ('C*','Copyright*',1,'L','N','Copyrighted (''*''/'' '')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGCopyrightA, '');
    Add ('O','Original',3,'L','N','Original (''Yes''/''No'')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGOriginal, '');
    Add ('O*','Original*',3,'L','N','Original (''*''/'' '')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGOriginalA, '');
    Add ('M','Mode',12,'L','N',
         'Channel mode (''Stereo''/''Joint-Stereo''/''Dual-Channel''/''Mono'')',
         'Mpeg audio file', mctMPEGAudio, @GetMPEGMode, '');
    Add ('S','Stereo',6,'L','N',
         'Stereo mode (''Stereo''/''Mono'')', 'Mpeg audio file',
          mctMPEGAudio, @GetMPEGStereo, '');

    { mctSpecial }
    Add ('PV','ProgramVersion',Length (GetProgramVersion),'L','N','Program version number',
         'System', mctSpecial, @GetProgramVersion, '');
    Add ('CD','CurrentDate',10,'R','N','Current system date',
         'System', mctSpecial, @GetCurrentSystemDate, '');
    Add ('CT','CurrentTime',8,'R','N','Current system time',
         'System', mctSpecial, @GetCurrentSystemDate, '');

    { mctNoExec }
    Add ('NL','NewLine',2,'L','N','New line (CRLF)', 'Special', mctNoExec, nil, '');
    Add ('#','SoftNewLine',2,'L','N','Soft Newline, not used in output document', 'Special', mctNoExec, nil, '');
    Add ('TB','Tab',1,'L','N','Tabulator', 'Special', mctNoExec, nil, '');
    Add ('nnn','nnn',1,'L','N','Character ASCII code (enter decimal value)', 'Special', mctNoExec, nil, '');
    Add ('','',1,'L','N','Percent sign (%)', 'Special', mctNoExec, nil, '');

    {$IFNDEF VER80}
    { mctComplexMacro }
    { do not use macros of this type in Delphi 1. It seems Delphi 1 cannot
    handle recursive calls within methods and crashes application when such
    macro is used. If you can help me find out reason for this crashes, I
    will be gratefull. This works correctly with Delphi 3 and 4. }
    Add ('FPN','FilePathName',80,'L','N','File path and name', 'Mpeg audio file',
          mctComplexMacro, nil, '%FP,T%%FN,T%');
    Add ('GAT','GuessedArtistTitle',80,'L','N',
         'Artist and title guessed from TAG or file name', 'Mpeg audio file',
          mctComplexMacro, nil, '%GA,T% - %GT,T%');
    {$ENDIF}

    { unfinished tags - they will be included in future }
    Add ('FPR','FilePathRelative',40,'L','N',
         'MPEG audio file path relative to output document (without file name)',
         'List data', mctMPEGReport, nil, '');
    Add ('N','No',6,'R','N','Order No of file in list',
         'List data', mctMPEGReport, nil, '');
    Add ('FC','FileCount',6,'R','N','Total number of files in list',
         'List data', mctMPEGReport, nil, '');
    Add ('FCC','FileCountComma',7,'R','N',
         'Total number of files in list, thousands comma separated',
         'List data', mctMPEGReport, nil, '');
    Add ('GN','GroupNo',6,'R','N','Order No of group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GFN','GroupFileNo',6,'R','N','Order No of file in group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GFC','GroupFileCount',6,'R','N',
         'Total number of files in group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GFCC','GroupFileCountComma',7,'R','N',
          'Total number of files in group, thousands comma separated',
         'Group Data', mctMPEGReport, nil, '');
    Add ('AC','ArtistCount',6,'R','N','Total number of artists in whole list', 'List data', mctMPEGReport, nil, '');
    Add ('GC','GroupCount',6,'R','N','Total number of groups in whole list', 'List data', mctMPEGReport, nil, '');
    Add ('GD','GroupDuration',8,'R','N','Total duration in seconds for group', 'Group Data', mctMPEGReport, nil, '');
    Add ('GDC','GroupDurationComma',10,'R','N','Total duration in seconds for group, thousands comma separated',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GDM','GroupDurationMinutes',7,'R','N','Total duration in minutes for group', 'Group Data', mctMPEGReport, nil, '');
    Add ('GDMC','GroupDurationMinutesComma',9,'R','N','Total duration in minutes for group, thousands comma separated',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GDF','GroupDurationForm',8,'R','N','Total duration for group, formated as HH:MM:SS',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GL','GroupLength',12,'R','N','Total length in bytes for group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GLC','GroupLengthComma',15,'R','N','Total length in bytes for group, thousands comma separated',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GLK','GroupLengthKB',9,'R','N','Total length in KB for group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GLK','GroupLengthKBComma',11,'R','N','Total length in KB for group, thousands comma separated',
         'Group Data', mctMPEGReport, nil, '');
    Add ('GLM','GroupLengthMB',9,'R','N','Total length in MB for group',
         'Group Data', mctMPEGReport, nil, '');
    Add ('DS','DurationSum',8,'R','N','Total duration in seconds for whole list',
         'List data', mctMPEGReport, nil, '');
    Add ('DSC','DurationSumComma',10,'R','N','Total duration in seconds for whole list,thousands comma separated',
         'List data', mctMPEGReport, nil, '');
    Add ('DSM','DurationSumMinutes',7,'R','N','Total duration in minutes for whole list',
         'List data', mctMPEGReport, nil, '');
    Add ('DSMC','DurationSumMinutesComma',9,'R','N','Total duration in minutes for whole list, thousands comma separated',
         'List data', mctMPEGReport, nil, '');
    Add ('DSF','DurationSumForm',8,'R','N','Total duration for whole list formated as HH:MM:SS',
         'List data', mctMPEGReport, nil, '');
    Add ('LS','LengthSum',12,'R','N','Total length in bytes for all files in list',
         'List data', mctMPEGReport, nil, '');
    Add ('LSC','LengthSumComma',15,'R','N',
               'Total length in bytes for all files in list, thousands comma separated',
               'List data', mctMPEGReport, nil, '');
    Add ('LKS','LengthKBSum',9,'R','N','Total length in KB for all files in list',
         'List data', mctMPEGReport, nil, '');
    Add ('LKSC','LengthKBSumComma',11,'R','N','Total length in KB for all files in list, thousands comma separated',
         'List data', mctMPEGReport, nil, '');
    Add ('LMS','LengthMBSum',9,'R','N','Total length in MB for all files in list',
         'List data', mctMPEGReport, nil, '');
    Add ('OD','OutputDoc',40,'L','N','Output document file name',
         'Output document', mctMPEGReport, nil, '');
    Add ('OP','OutputPath',40,'L','N','Output document path (without filename)',
         'Output document', mctMPEGReport, nil, '');
    Add ('TN','TemplateName',40,'L','N','Template name',
         'Output document', mctMPEGReport, nil, '');
  end; { with }

  { initializing MusicStyle array contents. Its done this way since it
    is much easier to mantain the list }
  MusicStyle[0] := 'Blues';
  MusicStyle[1] := 'Classic Rock';
  MusicStyle[2] := 'Country';
  MusicStyle[3] := 'Dance';
  MusicStyle[4] := 'Disco';
  MusicStyle[5] := 'Funk';
  MusicStyle[6] := 'Grunge';
  MusicStyle[7] := 'Hip-Hop';
  MusicStyle[8] := 'Jazz';
  MusicStyle[9] := 'Metal';
  MusicStyle[10] := 'New Age';
  MusicStyle[11] := 'Oldies';
  MusicStyle[12] := 'Other';
  MusicStyle[13] := 'Pop';
  MusicStyle[14] := 'R&B';
  MusicStyle[15] := 'Rap';
  MusicStyle[16] := 'Reggae';
  MusicStyle[17] := 'Rock';
  MusicStyle[18] := 'Techno';
  MusicStyle[19] := 'Industrial';
  MusicStyle[20] := 'Alternative';
  MusicStyle[21] := 'Ska';
  MusicStyle[22] := 'Death Metal';
  MusicStyle[23] := 'Pranks';
  MusicStyle[24] := 'Soundtrack';
  MusicStyle[25] := 'Euro-Techno';
  MusicStyle[26] := 'Ambient';
  MusicStyle[27] := 'Trip-Hop';
  MusicStyle[28] := 'Vocal';
  MusicStyle[29] := 'Jazz+Funk';
  MusicStyle[30] := 'Fusion';
  MusicStyle[31] := 'Trance';
  MusicStyle[32] := 'Classical';
  MusicStyle[33] := 'Instrumental';
  MusicStyle[34] := 'Acid';
  MusicStyle[35] := 'House';
  MusicStyle[36] := 'Game';
  MusicStyle[37] := 'Sound Clip';
  MusicStyle[38] := 'Gospel';
  MusicStyle[39] := 'Noise';
  MusicStyle[40] := 'AlternRock';
  MusicStyle[41] := 'Bass';
  MusicStyle[42] := 'Soul';
  MusicStyle[43] := 'Punk';
  MusicStyle[44] := 'Space';
  MusicStyle[45] := 'Meditative';
  MusicStyle[46] := 'Instrumental Pop';
  MusicStyle[47] := 'Instrumental Rock';
  MusicStyle[48] := 'Ethnic';
  MusicStyle[49] := 'Gothic';
  MusicStyle[50] := 'Darkwave';
  MusicStyle[51] := 'Techno-Industrial';
  MusicStyle[52] := 'Electronic';
  MusicStyle[53] := 'Pop-Folk';
  MusicStyle[54] := 'Eurodance';
  MusicStyle[55] := 'Dream';
  MusicStyle[56] := 'Southern Rock';
  MusicStyle[57] := 'Comedy';
  MusicStyle[58] := 'Cult';
  MusicStyle[59] := 'Gangsta';
  MusicStyle[60] := 'Top 40';
  MusicStyle[61] := 'Christian Rap';
  MusicStyle[62] := 'Pop/Funk';
  MusicStyle[63] := 'Jungle';
  MusicStyle[64] := 'Native American';
  MusicStyle[65] := 'Cabaret';
  MusicStyle[66] := 'New Wave';
  MusicStyle[67] := 'Psychadelic';
  MusicStyle[68] := 'Rave';
  MusicStyle[69] := 'Showtunes';
  MusicStyle[70] := 'Trailer';
  MusicStyle[71] := 'Lo-Fi';
  MusicStyle[72] := 'Tribal';
  MusicStyle[73] := 'Acid Punk';
  MusicStyle[74] := 'Acid Jazz';
  MusicStyle[75] := 'Polka';
  MusicStyle[76] := 'Retro';
  MusicStyle[77] := 'Musical';
  MusicStyle[78] := 'Rock & Roll';
  MusicStyle[79] := 'Hard Rock';

  { WinAmp Genre Codes }
  MusicStyle[80] := 'Folk';
  MusicStyle[81] := 'Folk-Rock';
  MusicStyle[82] := 'National Folk';
  MusicStyle[83] := 'Swing';
  MusicStyle[84] := 'Fast Fusion';
  MusicStyle[85] := 'Bebob';
  MusicStyle[86] := 'Latin';
  MusicStyle[87] := 'Revival';
  MusicStyle[88] := 'Celtic';
  MusicStyle[89] := 'Bluegrass';
  MusicStyle[90] := 'Avantgarde';
  MusicStyle[91] := 'Gothic Rock';
  MusicStyle[92] := 'Progessive Rock';
  MusicStyle[93] := 'Psychedelic Rock';
  MusicStyle[94] := 'Symphonic Rock';
  MusicStyle[95] := 'Slow Rock';
  MusicStyle[96] := 'Big Band';
  MusicStyle[97] := 'Chorus';
  MusicStyle[98] := 'Easy Listening';
  MusicStyle[99] := 'Acoustic';
  MusicStyle[100]:= 'Humour';
  MusicStyle[101]:= 'Speech';
  MusicStyle[102]:= 'Chanson';
  MusicStyle[103]:= 'Opera';
  MusicStyle[104]:= 'Chamber Music';
  MusicStyle[105]:= 'Sonata';
  MusicStyle[106]:= 'Symphony';
  MusicStyle[107]:= 'Booty Bass';
  MusicStyle[108]:= 'Primus';
  MusicStyle[109]:= 'Porn Groove';
  MusicStyle[110]:= 'Satire';
  MusicStyle[111]:= 'Slow Jam';
  MusicStyle[112]:= 'Club';
  MusicStyle[113]:= 'Tango';
  MusicStyle[114]:= 'Samba';
  MusicStyle[115]:= 'Folklore';
  MusicStyle[116]:= 'Ballad';
  MusicStyle[117]:= 'Power Ballad';
  MusicStyle[118]:= 'Rhythmic Soul';
  MusicStyle[119]:= 'Freestyle';
  MusicStyle[120]:= 'Duet';
  MusicStyle[121]:= 'Punk Rock';
  MusicStyle[122]:= 'Drum Solo';
  MusicStyle[123]:= 'A capella';
  MusicStyle[124]:= 'Euro-House';
  MusicStyle[125]:= 'Dance Hall';

end;

finalization
Macros.free;

end.
