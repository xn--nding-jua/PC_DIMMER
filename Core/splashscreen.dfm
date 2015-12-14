object splash: Tsplash
  Left = 673
  Top = 158
  BorderStyle = bsNone
  Caption = 'splash'
  ClientHeight = 558
  ClientWidth = 678
  Color = clFuchsia
  TransparentColorValue = clFuchsia
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 312
    Width = 3
    Height = 13
  end
  object Timer1: TSVATimer
    Interval = 30
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
end
