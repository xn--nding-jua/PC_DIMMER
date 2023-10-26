unit pcdUtils;

interface

uses
  Graphics, Classes, GR32, PNGImage;

function WebColor(AColor: TColor): Integer;
function RGB2TColor(const AR, AG, AB: Byte): Integer;
function BitSet(AValue: Byte; ABitCnt: Byte): Boolean;
function Format(AFmt: string; AParams: array of const): string;

procedure TColor2RGB(const AColor: TColor; var AR, AG, AB: Byte);
function GetWindowsLanguage: string;
function GetWindowsVersion: string;
procedure GetWindowsVersionInfo(var WindowsMajorVersion: byte; var WindowsMinorVersion: byte; var WindowsBuildNumber: byte);
function CalcSunrise(Longitude, Latitude: double): double;
function CalcSunset(Longitude, Latitude: double): double;
function IsSummertime(ADate:TDateTime): boolean;
function Wochentag(ADate: TDateTime): string;

function GetHue(AR, AG, AB: byte): Word;
function GetLuminance(AR, AG, AB: byte): Word;
function GetSaturation(AR, AG, AB: byte): Word;
procedure SetHue(var AR, AG, AB: byte; AHue: Word);
procedure SetLuminance(var AR, AG, AB: byte; ALuminance: Word);
procedure SetSaturation(var AR, AG, AB: byte; ASaturation: Word);
procedure MaximizeSaturation(var AR, AG, AB: byte; AMaximumSaturation: Word = 400);

function IntToThreadPriority(AInt: integer): TThreadPriority;
function ThreadPriorityToInt(APriority: TThreadPriority): integer;

function PNGToBitmap32(DstBitmap: TBitmap32; Png: TPngObject): Boolean;
procedure SmoothResize(apng:tpngobject; NuWidth,NuHeight:integer);

function GetColor2(Min, Max, Index: integer; MinColor, MaxColor:TColor; Brightness: Byte):TColor;
function GetColor3(Min, Mean, Max, Index: integer; MinColor, MeanColor, MaxColor:TColor; Brightness: Byte):TColor;

implementation

uses
  Windows, SysUtils, DateUtils, Math, gnugettext, GraphUtil;

procedure TColor2RGB(const AColor: TColor; var AR, AG, AB: Byte);
begin
  // convert hexa-decimal values to RGB
  AR := AColor and $FF;
  AG := (AColor shr 8) and $FF;
  AB := (AColor shr 16) and $FF;
end;

function GetWindowsLanguage: string;
var
  LLangCode: string;
  LCountryName: array[0..4] of char;
  LLanguageName: array[0..4] of char;
  LWorks: boolean;
begin
  // The return value of GetLocaleInfo is compared with 3 = 2 characters and a zero
  LWorks := 3 = GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SISO639LANGNAME, LLanguageName, SizeOf(LLanguageName));
  LWorks := LWorks and (3 = GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SISO3166CTRYNAME, LCountryName,
    SizeOf(LCountryName)));
  if LWorks then begin
    // Windows 98, Me, NT4, 2000, XP, Vista and newer
    LLangCode := PChar(@LLanguageName[0]);
    if lowercase(LLangCode)='no' then LLangCode:='nb';
//    LangCode:=LangCode + '_' + PChar(@CountryName[0]);
  end else begin
    LLangCode := 'C';
  end;
  Result := UpperCase(LLangCode);
end;

function GetWindowsVersion(): string;
var
  OsVinfo: TOSVERSIONINFO;
  tempstring:string;
begin
  ZeroMemory(@OsVinfo, SizeOf(OsVinfo));
  OsVinfo.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

  if GetVersionEx(OsVinfo) then
  begin
    // WINDOWS9x
    if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
    begin
      if (OsVinfo.dwMajorVersion < 4) then
        tempstring:='Windows 3.11';

      if (OsVinfo.dwMajorVersion = 4) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='Windows95';
          1: tempstring:='Windows98/98SE';
          10: tempstring:='Windows98/98SE';
          90: tempstring:='WindowsME';
        else
          tempstring:='Windows9x '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;
    end;

    // WINDOWSNT
    if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
    begin
      if (OsVinfo.dwMajorVersion < 4) then
      begin
        tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
      end;

      if (OsVinfo.dwMajorVersion = 4) then
      begin
        tempstring:='WindowsNT4';
      end;

      if (OsVinfo.dwMajorVersion = 5) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='Windows2000';
          1: tempstring:='WindowsXP';
          2: tempstring:='WindowsXP 64Bit';
        else
          tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;

      if (OsVinfo.dwMajorVersion = 6) then
      begin
        case (OsVinfo.dwMinorVersion) of
          0: tempstring:='WindowsVista';
          1: tempstring:='Windows 7';
          2: tempstring:='Windows 8';
          3: tempstring:='Windows 8.1';
        else
          tempstring:='WindowsNT '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)
        end;
      end;

  	  // MajorVersion = 7, 8 and 9 will not be released

      if (OsVinfo.dwMajorVersion = 10) then
      begin
		    // Windows 10 and 11 will have MajorVersion = 10 and MinorVersion = 0
        tempstring:='Windows 10/11';
      end;

      if (OsVinfo.dwMajorVersion >=11) then
      begin
		    // Windows 1x will have MajorVersion = 1x and MinorVersion = x
        tempstring:='Windows '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion) + ' Build '+inttostr(OsVInfo.dwBuildNumber)
      end;
    end;
  end;
  Result:=tempstring;//+' '+inttostr(OsVinfo.dwMajorVersion)+'.'+inttostr(OsVinfo.dwMinorVersion)+'.'+inttostr(OsVinfo.dwBuildNumber);
end;

procedure GetWindowsVersionInfo(var WindowsMajorVersion: byte; var WindowsMinorVersion: byte; var WindowsBuildNumber: byte);
var
  OsVinfo: TOSVERSIONINFO;
begin
  ZeroMemory(@OsVinfo, SizeOf(OsVinfo));
  OsVinfo.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

  if GetVersionEx(OsVinfo) then
  begin
    WindowsMajorVersion:=OsVinfo.dwMajorVersion;
    WindowsMinorVersion:=OsVinfo.dwMinorVersion;
    WindowsBuildNumber:=OsVinfo.dwBuildNumber;
  end;
end;

function CalcSunrise(Longitude, Latitude: double):double;
var
  sunrise:double;
  hoehe:double;
  tag:integer;
begin
  HOEHE:=-0.0145;
  TAG:=DayOfTheYear(Now);

  sunrise:=((12-(12*ARCCOS((SIN(HOEHE) - SIN(PI*LONGITUDE/180)*SIN(0.4095*SIN(0.016906*(TAG-80.086)))) / (COS(PI*LONGITUDE/180)*COS(0.4095*SIN(0.016906*(TAG-80.086)))))/PI))-(-0.171*SIN(0.0337 * TAG + 0.465) - 0.1299*SIN(0.01787 * TAG - 0.168)))-LATITUDE/15+1;

  if IsSummertime(Now) then
    sunrise:=sunrise+1;

  result:=sunrise;
end;

function CalcSunset(Longitude, Latitude: double):double;
var
  sunset:double;
  hoehe:double;
  tag:integer;
begin
  HOEHE:=-0.0145;
  TAG:=DayOfTheYear(Now);

  sunset:=((12+(12*ARCCOS((SIN(HOEHE) - SIN(PI*LONGITUDE/180)*SIN(0.4095*SIN(0.016906*(TAG-80.086)))) / (COS(PI*LONGITUDE/180)*COS(0.4095*SIN(0.016906*(TAG-80.086)))))/PI))-(-0.171*SIN(0.0337 * TAG + 0.465) - 0.1299*SIN(0.01787 * TAG - 0.168)))-LATITUDE/15+1;

  if IsSummertime(Now) then
    sunset:=sunset+1;

  result:=sunset;
end;

function IsSummertime(ADate:TDateTime):boolean;
var AYear,
    AMonth,
    ADay : word;
    Beginn,
    Ende : TDateTime;
begin
  try
    ADate := trunc(ADate);
    DecodeDate(ADate, AYear, AMonth, ADay);
    if AYear < 1980 then
      { Keine Sommerzeit vor 1980 }
      Result := False
    else begin
      { Beginn der Sommerzeit: }
      Beginn := EncodeDate(AYear, 3, 31);
      while DayOfWeek(Beginn) <> 1 do
        Beginn := Beginn-1;
      { Ende der Sommerzeit: }
      if AYear <= 1995 then
        { bis 1995: letzter So im September }
        Ende := EncodeDate(AYear, 9, 30)
      else
        { ab 1996: letzter So im Oktober }
        Ende := EncodeDate(AYear, 10, 31);
      while DayOfWeek(Ende) <> 1 do
        Ende := Ende - 1;
      Result := (ADate>=Beginn) and (ADate<Ende);
    end;
  except
    Result := False;
  end;
end; {IsSummertime}

function Wochentag(ADate: TDateTime): string;
var
  LText: string;
begin
  case DayOfTheWeek(ADate) of
    1: LText:=_('Mo');
    2: LText:=_('Di');
    3: LText:=_('Mi');
    4: LText:=_('Do');
    5: LText:=_('Fr');
    6: LText:=_('Sa');
    7: LText:=_('So');
  end;

  Result := LText;
end;

function GetHue(AR, AG, AB: byte): Word;
var
  LH, LS, LL: Word;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  Result := LH;
end;

function GetLuminance(AR, AG, AB: byte): Word;
var
  LH, LS, LL: Word;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  Result := LL;
end;

function GetSaturation(AR, AG, AB: byte): Word;
var
  LH, LS, LL: Word;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  Result := LS;
end;

procedure SetHue(var AR, AG, AB: byte; AHue: Word);
var
  LH, LS, LL: Word;
  LEndColor: TColor;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  LEndColor := ColorHLSToRGB(AHue, LL, LS);
  TColor2RGB(LEndColor, AR, AG, AB);
end;

procedure SetLuminance(var AR, AG, AB: byte; ALuminance: Word);
var
  LH, LS, LL: Word;
  LEndColor: TColor;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  LEndColor := ColorHLSToRGB(LH, ALuminance, LS);
  TColor2RGB(LEndColor, AR, AG, AB);
end;

procedure SetSaturation(var AR, AG, AB: byte; ASaturation: Word);
var
  LH, LS, LL: Word;
  LEndColor: TColor;
begin
  ColorRGBToHLS(RGB(AR, AG, AB), LH, LL, LS);
  LEndColor := ColorHLSToRGB(LH, LL, ASaturation);
  TColor2RGB(LEndColor, AR, AG, AB);
end;

procedure MaximizeSaturation(var AR, AG, AB: byte; AMaximumSaturation: Word = 400);
var
  LR, LG, LB: Byte;
  LH, LS, LL: Word;
  LMaximumFound: boolean;
  LSaturationFactor:Single;
  LEndColor: TColor;
begin
  LR := AR;
  LG := AG;
  LB := AB;

  // Für Sättigungskorrektur entsprechend HSL-Werte erzeugen
  ColorRGBToHLS(RGB(LR, lG, LB), LH, LL, LS);

  // Sättigung automatisch maximieren
  LMaximumFound := false;
  LSaturationFactor := 1.0;
  repeat
    TColor2RGB(ColorHLSToRGB(LH, LL, round(LS*LSaturationFactor)), LR, LG, LB);

    LSaturationFactor := LSaturationFactor + 0.01;
    TColor2RGB(ColorHLSToRGB(LH, LL, round(LS*LSaturationFactor)), LR, LG, LB);

    if (LR = 255) or (LG = 255) or (LB = 255) or (LSaturationFactor>(AMaximumSaturation / 100)) then
    begin
      LSaturationFactor := LSaturationFactor-0.01;
      LMaximumFound := true;
    end;
  until (LMaximumFound = true);
  LS := round(LS*LSaturationFactor);

  LEndColor := ColorHLSToRGB(LH, LL, LS);
  TColor2RGB(LEndColor, AR, AG, AB);
end;

function WebColor(AColor: TColor): Integer;
begin
  Result := Swap(LoWord(AColor)) shl 8 or Lo(HiWord(AColor));
end;

function RGB2TColor(const AR, AG, AB: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := AR + AG shl 8 + AB shl 16;
end;

function BitSet(AValue: Byte; ABitCnt: Byte): Boolean;
begin
//  Result := (( Value AND Round ( power (2, BitCnt-1) )) = Round ( power (2, BitCnt-1) ));
//  result:=(Value AND (1 shl bitcnt )) = (1 shl bitcnt);
  result := ((AValue AND ABitCnt) = ABitCnt);
end;

// Funktionen für Projektdateiinformationen
function Format(AFmt: string; AParams: array of const): string;
var
  pdw1, pdw2: PDWORD;
  i: integer;
  pc: PCHAR;
begin
  pdw1 := nil;
  if length(AParams) > 0 then
    GetMem(pdw1, length(AParams) * sizeof(Pointer));
  pdw2 := pdw1;
  for i := 0 to high(AParams) do
  begin
    pdw2^ := DWORD(PDWORD(@AParams[i])^);
    inc(pdw2);
  end;
  GetMem(pc, 1024 - 1);
  try
    SetString(Result, pc, wvsprintf(pc, PCHAR(AFmt), PCHAR(pdw1)));
  except
    Result := '';
  end;
  if (pdw1 <> nil) then
    FreeMem(pdw1);
  if (pc <> nil) then
    FreeMem(pc);
end;

function IntToThreadPriority(AInt: integer): TThreadPriority;
begin
  Result := tpIdle;
  case AInt of
    0: Result := tpIdle;
    1: Result := tpLowest;
    2: Result := tpLower;
    3: Result := tpNormal;
    4: Result := tpHigher;
    5: Result := tpHighest;
    6: Result := tpTimeCritical;
  end;
end;

function ThreadPriorityToInt(APriority: TThreadPriority): integer;
begin
  if APriority = tpIdle then
    Result := 0
  else if APriority = tpLowest then
    Result := 1
  else if APriority = tpLower then
    Result := 2
  else if APriority = tpNormal then
    Result := 3
  else if APriority = tpHigher then
    Result := 4
  else if APriority = tpHighest then
    Result := 5
  else if APriority = tpTimeCritical then
    Result := 6
  else
    Result := 0;
end;

// Result is TRUE has Pngimage a Alphachannel.
function PNGToBitmap32(DstBitmap: TBitmap32; Png: TPngObject): Boolean;
var
  TransparentColor: TColor32;
  PixelPtr: PColor32;
  AlphaPtr: PByte;
  X, Y: Integer;
begin
  Result := False;

  DstBitmap.Assign(PNG);
  DstBitmap.ResetAlpha;

  case PNG.TransparencyMode of
    ptmPartial:
      begin
        if (PNG.Header.ColorType = COLOR_GRAYSCALEALPHA) or
           (PNG.Header.ColorType = COLOR_RGBALPHA) then
        begin
          PixelPtr := PColor32(@DstBitmap.Bits[0]);
          for Y := 0 to DstBitmap.Height - 1 do
          begin
            AlphaPtr := PByte(PNG.AlphaScanline[Y]);
            for X := 0 to DstBitmap.Width - 1 do
            begin
              PixelPtr^ := (PixelPtr^ and $00FFFFFF) or (TColor32(AlphaPtr^) shl 24);
              Inc(PixelPtr);
              Inc(AlphaPtr);
            end;
          end;
        end;
        Result := True;
      end;
    ptmBit:
      begin
        TransparentColor := Color32(PNG.TransparentColor);
        PixelPtr := PColor32(@DstBitmap.Bits[0]);
        for X := 0 to (DstBitmap.Height - 1) * (DstBitmap.Width - 1) do
        begin
          if PixelPtr^ = TransparentColor then
            PixelPtr^ := PixelPtr^ and $00FFFFFF;
          Inc(PixelPtr);
        end;
        Result := True;
      end;
    ptmNone: Result := False;
  end;
end;

procedure SmoothResize(apng:tpngobject; NuWidth,NuHeight:integer);
var
  xscale, yscale         : Single;
  sfrom_y, sfrom_x       : Single;
  ifrom_y, ifrom_x       : Integer;
  to_y, to_x             : Integer;
  weight_x, weight_y     : array[0..1] of Single;
  weight                 : Single;
  new_red, new_green     : Integer;
  new_blue, new_alpha    : Integer;
  new_colortype          : Integer;
  total_red, total_green : Single;
  total_blue, total_alpha: Single;
  IsAlpha                : Boolean;
  ix, iy                 : Integer;
  bTmp : TPNGObject;
  sli, slo : pRGBLine;
  ali, alo: pbytearray;
begin
  new_alpha:=0;
  if not (apng.Header.ColorType in [COLOR_RGBALPHA, COLOR_RGB]) then
    raise Exception.Create('Only COLOR_RGBALPHA and COLOR_RGB formats' +
    ' are supported');
  IsAlpha := apng.Header.ColorType in [COLOR_RGBALPHA];
  if IsAlpha then new_colortype := COLOR_RGBALPHA else
    new_colortype := COLOR_RGB;
  bTmp := Tpngobject.CreateBlank(new_colortype, 8, NuWidth, NuHeight);
  xscale := bTmp.Width / (apng.Width-1);
  yscale := bTmp.Height / (apng.Height-1);
  for to_y := 0 to bTmp.Height-1 do begin
    sfrom_y := to_y / yscale;
    ifrom_y := Trunc(sfrom_y);
    weight_y[1] := sfrom_y - ifrom_y;
    weight_y[0] := 1 - weight_y[1];
    for to_x := 0 to bTmp.Width-1 do begin
      sfrom_x := to_x / xscale;
      ifrom_x := Trunc(sfrom_x);
      weight_x[1] := sfrom_x - ifrom_x;
      weight_x[0] := 1 - weight_x[1];

      total_red   := 0.0;
      total_green := 0.0;
      total_blue  := 0.0;
      total_alpha  := 0.0;
      for ix := 0 to 1 do begin
        for iy := 0 to 1 do begin
          sli := apng.Scanline[ifrom_y + iy];
          if IsAlpha then ali := Pointer(apng.AlphaScanline[ifrom_y + iy]);
          new_red := sli[ifrom_x + ix].rgbtRed;
          new_green := sli[ifrom_x + ix].rgbtGreen;
          new_blue := sli[ifrom_x + ix].rgbtBlue;
          if IsAlpha then new_alpha := ali[ifrom_x + ix];
          weight := weight_x[ix] * weight_y[iy];
          total_red   := total_red   + new_red   * weight;
          total_green := total_green + new_green * weight;
          total_blue  := total_blue  + new_blue  * weight;
          if IsAlpha then total_alpha  := total_alpha  + new_alpha  * weight;
        end;
      end;
      slo := bTmp.ScanLine[to_y];
      if IsAlpha then alo := Pointer(bTmp.AlphaScanLine[to_y]);
      slo[to_x].rgbtRed := Round(total_red);
      slo[to_x].rgbtGreen := Round(total_green);
      slo[to_x].rgbtBlue := Round(total_blue);
      if isAlpha then alo[to_x] := Round(total_alpha);
    end;
  end;
  apng.Assign(bTmp);
  bTmp.Free;
end;

function GetColor2(Min, Max, Index: integer; MinColor, MaxColor:TColor; Brightness: Byte):TColor;
var
  Rmin,Gmin,Bmin, Rmax, Gmax, Bmax: Byte;
  Rout, Gout, Bout:Double;
begin
  // Farben zwischen StartColor und EndColor automatisch in Bezug Min, Max und Index abstufen
  TColor2RGB(MinColor, Rmin, Gmin, Bmin);
  TColor2RGB(MaxColor, Rmax, Gmax, Bmax);

  if (Max=Min) or ((Max-Min)=0) then
  begin
    Rout:=Rmin;
    Gout:=Gmin;
    Bout:=Bmin;
  end else
  begin
    // Interpolation über die eingebenen Werte und Berechnung der neuen Farbe
    Rout:=(Rmin-Rmax)*(   (Index-Max)   /   (Min-Max)   )+Rmax;
    Gout:=(Gmin-Gmax)*(   (Index-Max)   /   (Min-Max)   )+Gmax;
    Bout:=(Bmin-Bmax)*(   (Index-Max)   /   (Min-Max)   )+Bmax;
  end;

  result:=RGB2TColor(round(Rout*Brightness/255), round(Gout*Brightness/255), round(Bout*Brightness/255));
end;

function GetColor3(Min, Mean, Max, Index: integer; MinColor, MeanColor, MaxColor:TColor; Brightness: Byte):TColor;
var
  Rmin,Gmin,Bmin, Rmean,Gmean,Bmean, Rmax, Gmax, Bmax: Byte;
  Rout, Gout, Bout:Double;
begin
  // Farben zwischen StartColor und EndColor automatisch in Bezug Min, Max und Index abstufen
  TColor2RGB(MinColor, Rmin, Gmin, Bmin);
  TColor2RGB(MeanColor, Rmean, Gmean, Bmean);
  TColor2RGB(MaxColor, Rmax, Gmax, Bmax);

  if (Max=Min) or ((Max-Min)=0) then
  begin
    Rout:=Rmin;
    Gout:=Gmin;
    Bout:=Bmin;
  end else
  begin
    if Index<Mean then
    begin
      // Interpolation über die eingebenen Werte und Berechnung der neuen Farbe
      Rout:=(Rmin-Rmean)*(   (Index-Mean)   /   (Min-Mean)   )+Rmean;
      Gout:=(Gmin-Gmean)*(   (Index-Mean)   /   (Min-Mean)   )+Gmean;
      Bout:=(Bmin-Bmean)*(   (Index-Mean)   /   (Min-Mean)   )+Bmean;
    end else
    begin
      // Interpolation über die eingebenen Werte und Berechnung der neuen Farbe
      Rout:=(Rmean-Rmax)*(   (Index-Max)   /   (Mean-Max)   )+Rmax;
      Gout:=(Gmean-Gmax)*(   (Index-Max)   /   (Mean-Max)   )+Gmax;
      Bout:=(Bmean-Bmax)*(   (Index-Max)   /   (Mean-Max)   )+Bmax;
    end;
  end;

  result:=RGB2TColor(round(Rout*Brightness/255), round(Gout*Brightness/255), round(Bout*Brightness/255));
end;

end.
