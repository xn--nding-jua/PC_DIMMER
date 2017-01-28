object Form1: TForm1
  Left = 284
  Top = 141
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'ENTTEC DMX USB Tester V1.41'
  ClientHeight = 490
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 471
    Width = 594
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Button3: TButton
    Left = 344
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Receive'
    Enabled = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 96
    Width = 153
    Height = 249
    Caption = 'Send DMX'
    TabOrder = 3
    object Label1: TLabel
      Left = 14
      Top = 24
      Width = 59
      Height = 13
      Caption = 'DMX Output'
    end
    object TrackBar1: TTrackBar
      Left = 28
      Top = 40
      Width = 45
      Height = 185
      Max = 255
      Orientation = trVertical
      Frequency = 15
      Position = 255
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 96
    Width = 401
    Height = 257
    Caption = 'Receive DMX'
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 50
      Height = 13
      Caption = 'Start Code'
    end
    object Edit1: TEdit
      Left = 72
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
    end
    object StringGrid: TStringGrid
      Left = 2
      Top = 48
      Width = 397
      Height = 207
      Align = alBottom
      ColCount = 17
      DefaultColWidth = 35
      DefaultRowHeight = 18
      RowCount = 33
      TabOrder = 1
      ColWidths = (
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35
        35)
    end
  end
  object Button1: TButton
    Left = 22
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Send'
    Enabled = False
    TabOrder = 5
    OnClick = Button1Click
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 360
    Width = 153
    Height = 105
    Caption = 'Transmit Refresh Rate'
    TabOrder = 6
    object Label3: TLabel
      Left = 80
      Top = 32
      Width = 13
      Height = 13
      Caption = 'Hz'
    end
    object Edit2: TEdit
      Left = 24
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '25'
    end
    object Button4: TButton
      Left = 30
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
end
