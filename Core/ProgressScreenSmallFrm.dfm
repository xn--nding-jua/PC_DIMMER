object ProgressScreenSmall: TProgressScreenSmall
  Left = 651
  Top = 385
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 97
  ClientWidth = 305
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 289
    Height = 13
    AutoSize = False
    Caption = 'Titel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 289
    Height = 33
    AutoSize = False
    Caption = 'Nachricht'
    Transparent = True
    WordWrap = True
  end
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 305
    Height = 9
    Brush.Color = clNavy
    Pen.Color = clNavy
  end
  object Label3: TLabel
    Left = 8
    Top = -3
    Width = 39
    Height = 13
    Caption = 'PC_DIMMER'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -8
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 72
    Width = 289
    Height = 17
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = Timer1Timer
    Left = 264
    Top = 8
  end
end
