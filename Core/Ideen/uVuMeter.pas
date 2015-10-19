unit uVuMeter;

interface

uses
  Classes, Controls, Graphics, Types;

type
  TVuMeter = class(TGraphicControl)
    private
      fBuffer: TBitmap;
      fLeft: Integer;
      fRight: Integer;
      fMax: Integer;

      procedure fSetValue(Index, Value: Integer);
    protected
      procedure Paint; override;
      procedure DrawVuBar(Left, Top, Value: Integer; Buffer: TBitmap); virtual;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
    published
      property LeftPos : Integer index 0 read fLeft write fSetValue;
      property RightPos : Integer index 1 read fRight write fSetValue;
      property Max: Integer read fMax write fMax;
      property Color;
  end;

implementation

constructor TVuMeter.Create(AOwner: TComponent);
begin
  inherited;
  fBuffer := TBitmap.Create;
  fLeft := 0;
  fRight := 0;
end;

destructor TVuMeter.Destroy;
begin
  inherited;
  fBuffer.Free;
end;

procedure TVuMeter.DrawVuBar(Left, Top, Value: Integer; Buffer: TBitmap);
  var
    DigitSize   : Integer;
    DigitCount  : Integer;
    DigitHeight : Integer;
    DigitWidth  : Integer;
    DigitYMarg  : Integer;
    I           : Integer;
    R           : TRect;
begin
  DigitHeight := 4;
  DigitWidth  := 15;
  DigitYMarg  := 1;
  DigitCount  := 60;

  with Buffer.Canvas do
  begin
    R.Left  := Left;
    R.Right := Left + Digitwidth;
    R.Top := Top;
    R.Bottom := Top + DigitHeight;

    DigitSize := fMax div DigitCount;

    for I := DigitCount downto 1 do
    begin
      if (I <= Round(DigitCount * 0.60)) then
      begin
        if ((I * DigitSize) < Value) then
          Brush.Color := clLime
        else
          Brush.Color := clGreen;
      end
      else if (I <= Round(DigitCount * 0.80)) then
      begin
        if ((I * DigitSize) < Value) then
          Brush.Color := clYellow
        else
          Brush.Color := clOlive;
      end
      else
      begin
        if ((I * DigitSize) < Value) then
          Brush.Color := clRed
        else
          Brush.Color := clMaroon;
      end;

      FillRect(R);
      R.Top := R.Bottom + DigitYMarg;
      R.Bottom := R.Top + DigitHeight;
    end;
  end;
end;

procedure TVuMeter.Paint;
  var
    R: TRect;
begin
  fBuffer.Width := Width;
  fBuffer.Height := Height;

  R.Left := 0;
  R.Top := 0;
  R.Right := Width;
  R.Bottom := Height;

  with fBuffer.Canvas do
  begin
    Brush.Color := Self.Color;
    FillRect(R);

    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    Font.Color := clWhite;

    TextOut(12, 315, 'L');
    TextOut(37, 315, 'R');

    DrawVuBar(10, 10, fLeft, fBuffer);
    DrawVuBar(35, 10, fRight, fBuffer);
  end;
  Canvas.Draw(0, 0, fBuffer);
end;

procedure TVuMeter.fSetValue(Index, Value: Integer);
begin
  case Index of
    0: // Left
      if (Value <> fLeft) then
      begin
        fLeft := Value;
        Paint;
      end;
    1: // Right
      if (Value <> fRight) then
      begin
        fRight := Value;
        Paint;
      end;
  end;
end;

end.