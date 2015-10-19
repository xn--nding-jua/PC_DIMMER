unit splashscreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, GR32, PNGImage, XPMan,
  gnugettext, SVATimer;

type
  Tsplash = class(TForm)
    XPManifest1: TXPManifest;
    Label1: TLabel;
    Timer1: TSVATimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    ScrBmp32, PNGBmp32: TBitmap32;
    BlendF: TBlendFunction;
    P: TPoint;
    Size: TSize;
    FIsModal: boolean;
    FReqToClose: boolean;
    function PNGToBitmap32(DstBitmap: TBitmap32; Png: TPngObject): Boolean;
  public
    { Public-Deklarationen }
    versioninfo:string;
    captioninfo:string;
    text:array[0..4] of string;
    switchinfo:string;
    BlendValue : Byte;
    ea:boolean;
    Fortschritt,FortschrittMax:integer;
    Fortschritt2,FortschrittMax2:integer;
    ShowFortschritt2:boolean;
    // Constructor
    procedure CloseMe;
    constructor Create( AOwner: TComponent; isModal: boolean ); reintroduce; virtual;
    property ReqToClose: boolean read FReqToClose;
    procedure AddText(Text:string);
  end;

var
  splash: Tsplash;

implementation

{$R *.dfm}

// Result is TRUE has Pngimage a Alphachannel.
function Tsplash.PNGToBitmap32(DstBitmap: TBitmap32; Png: TPngObject): Boolean;
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

procedure ChangeCleartype(Canvas: TCanvas; ClearType: Boolean);
var
  lFnt: TLogFont;
  Fnt: TFont;
begin
  Fnt := TFont.Create;
  try
    Fnt.Assign(Canvas.Font);
    GetObject(Fnt.Handle, sizeof(lFnt), @lFnt);
    if ClearType
      then lFnt.lfQuality := DEFAULT_QUALITY
      else lFnt.lfQuality := NONANTIALIASED_QUALITY;
    Fnt.Handle := CreateFontIndirect(lFnt);
    Canvas.Font.Assign(Fnt);
  finally
    Fnt.Free;
  end;
end;

procedure Tsplash.FormCreate(Sender: TObject);
var
  PngImg: TPngObject;
begin
  FortschrittMax:=100;
  FortschrittMax2:=100;
  Fortschritt:=0;
  Fortschritt2:=0;
  ShowFortschritt2:=false;

  TranslateComponent(self);
  versioninfo:='';
  captioninfo:='';
  text[0]:='';
  text[1]:='';
  text[2]:='';
  text[3]:='';
  text[4]:='';
  switchinfo:='';

  // Das Fenster soll rechts Unten erscheinen, dazu mussen der Taskbar er-
  // mittelt werden.
  //  GetWindowRect(FindWindow('Shell_TrayWnd', nil), R);

  ScrBmp32 := TBitmap32.Create;
  PNGBmp32 := TBitmap32.Create;

  // Das PNG-Image aus der Resource holen und in ein TBitmap32
  // konvertieren.
  PngImg := TPngObject.Create;
  try
//    PngImg.LoadFromFile(ExtractFilePath(paramstr(0))+'splashscreen2010.png');
    PngImg.LoadFromResourceName(hInstance, 'SPLASHSCREENPNGIMAGE');
    PNGToBitmap32(PNGBmp32, PngImg);
  finally
    PngImg.Free;
  end;

  // Das PNGBitmap32 dem Screen-Bitmap32 zuweisen
  ScrBmp32.Assign(PNGBmp32);

  // Fenstergrösse anpassen und Position setzen
  Width := ScrBmp32.Width;
  Height := ScrBmp32.Height;
//  Left := Screen.Width - Form1.Width;
//  Top := Screen.Height - Form1.Height - (Screen.Height - R.Top) - 20;

  // Das Fenster mit neuen Parametern ausstatten um Transparenz zu ermöglichen
  // ( WS_EX_TRANSPARENT macht das Fenster für Mausklicks transparent )
  SetWindowLong(Handle, GWL_EXSTYLE,
  GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED {or WS_EX_TRANSPARENT});

  // Fensterblendoptionen festlegen (für UpdateLayeredWindow)
  BlendF.BlendOp := AC_SRC_OVER;
  BlendF.BlendFlags := 0;
  BlendF.SourceConstantAlpha := BlendValue;  // Blendwert zwischen Desktop und Fenster (0..255)
  BlendF.AlphaFormat := AC_SRC_ALPHA;

  P := Point(0, 0);
  Size.cx := ScrBmp32.Width;
  Size.cy := ScrBmp32.Height;
end;

procedure Tsplash.FormDestroy(Sender: TObject);
begin
  FreeAndNil(PNGBmp32); // PNGBmp32.Free;
  FreeAndNil(ScrBmp32); // ScrBmp32.Free;
end;

procedure Tsplash.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Shift = [ssLeft] then  // Das verschieben der Form auf eine einfache Weise
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

// Constructor
constructor Tsplash.Create( AOwner: TComponent; isModal: boolean );
begin
  inherited Create( AOwner );
  FIsModal := isModal;
  FReqToClose := false;
end;

procedure Tsplash.CloseMe;
begin
  if FIsModal then
    ModalResult := mrOk
  else
    FReqToClose := true;
end;

procedure Tsplash.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CloseMe;
end;

procedure Tsplash.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  CloseMe;
end;

procedure Tsplash.Timer1Timer(Sender: TObject);
var
  newline: Integer;
begin
  splash.BringToFront;

//  if IsIconic(Handle) then exit; // nur zeichnen wenn Fenster sichtbar.

  try
    // Png Image auf Bitmap32 "Zeichnen"
    ScrBmp32.ResetAlpha;
    ScrBmp32.Assign(PNGBmp32);

    // Textausgabe für Datum und Zeit
    ScrBmp32.Font.Name := 'Arial';
    ScrBmp32.Font.Size := 10;
    ScrBmp32.Font.Style := [];

    newline := 125;
    inc(newline, ScrBmp32.Font.Size + 6); // Neue Y- Liniepos
    ScrBmp32.Font.Size := 10;
    ScrBmp32.Font.Style := [];

    ScrBmp32.RenderText(35, newline, versioninfo, 1, clWhite32);

    newline := 170;
    inc(newline, ScrBmp32.Font.Size + 6); // Neue Y- Liniepos
    ScrBmp32.Font.Size := 10;

    ScrBmp32.Font.Style := [];
    ScrBmp32.RenderText(45, newline, text[0], 0, clWhite32);
    ScrBmp32.RenderText(45, newline+16, text[1], 0, clWhite32);
    ScrBmp32.RenderText(45, newline+32, text[2], 0, clWhite32);
    ScrBmp32.RenderText(45, newline+48, text[3], 0, clWhite32);
    ScrBmp32.RenderText(45, newline+64, text[4], 0, clWhite32);
    ScrBmp32.Font.Style := [fsBold];
    ScrBmp32.RenderText(45, newline+80, captioninfo, 0, clWhite32);

    ScrBmp32.Font.Style := [];
    ScrBmp32.RenderText(35, 310, switchinfo, 1, clBlack32);

    newline := 476;
    inc(newline, ScrBmp32.Font.Size + 6); // Neue Y- Liniepos
    ScrBmp32.Font.Size := 10;
    ScrBmp32.Font.Style := [fsBold];

    ScrBmp32.RenderText(430, newline, DateToStr(Now), 2, clWhite32);
    inc(newline, ScrBmp32.Font.Size + 4);

    ScrBmp32.RenderText(435, newline, TimeToStr(Now), 2, clWhite32);

    // Ladebalken malen
    ScrBmp32.FillRect(31,297,round(32+(Fortschritt/FortschrittMax)*329),312, clNavy32);
    ScrBmp32.RenderText(185, 297, inttostr(round((Fortschritt/FortschrittMax)*100))+'%', 2, clWhite32);

    // Ladebalken 2 (für Dateien) malen
    if ShowFortschritt2 then
    begin
      ScrBmp32.FillRect(31,316,round(32+(Fortschritt2/FortschrittMax2)*329),331, clNavy32);
      ScrBmp32.RenderText(185, 316, inttostr(Fortschritt2)+'/'+inttostr(FortschrittMax2), 2, clWhite32);
    end;
  
    // aktualisieren des Fensters mit dem neuen Bitmap.
    BlendF.SourceConstantAlpha := BlendValue; // Blendwert zwischen Desktop und Fenster (0..255)
    UpdateLayeredWindow(Handle, 0, nil, @Size, ScrBmp32.Handle, @P, 0, @BlendF, ULW_ALPHA);
  except
    on E: Exception do
      begin
        Timer1.Enabled := FALSE; // Timer aus bei Fehlern, sonst gibt es eine Messageflut...
        ShowMessage(E.Message);
        Close;
      end;
  end;
end;

procedure Tsplash.FormClick(Sender: TObject);
begin
  if ea then
    close;
end;

procedure Tsplash.AddText(Text:string);
var
  i:integer;
begin
  for i:=0 to 3 do
  begin
    splash.text[i]:=splash.text[i+1];
  end;
  splash.text[4]:=Text;
end;

end.
