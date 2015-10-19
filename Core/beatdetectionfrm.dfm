object beatdetectionform: Tbeatdetectionform
  Left = 580
  Top = 138
  BorderStyle = bsToolWindow
  Caption = 'Beat-Detection'
  ClientHeight = 426
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 796
    Height = 170
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 256
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 16
      Top = 16
      Width = 512
      Height = 177
    end
    object Label3: TLabel
      Left = 16
      Top = 0
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label1: TLabel
      Left = 304
      Top = 0
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Button1: TButton
      Left = 16
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Ende'
      TabOrder = 1
      OnClick = Button2Click
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 200
      Width = 529
      Height = 25
      Max = 512
      Min = 1
      Position = 256
      TabOrder = 2
      ThumbLength = 15
      TickMarks = tmTopLeft
      TickStyle = tsNone
    end
  end
  object Panel3: TPanel
    Left = 531
    Top = 0
    Width = 265
    Height = 256
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object GbEingaenge: TGroupBox
      Left = 8
      Top = 8
      Width = 249
      Height = 241
      Caption = ' Mixereing'#228'nge '
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 256
    Top = 8
  end
end
