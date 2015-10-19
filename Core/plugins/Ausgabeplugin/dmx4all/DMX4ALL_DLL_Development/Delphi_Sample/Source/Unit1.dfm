object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sample Projekt  - DMX4ALL Interfaces inc.  FreeStylers'#174' GmbH'
  ClientHeight = 241
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 177
    Height = 221
    Caption = ' DMX Channels '
    PopupMenu = PopupMenu1
    TabOrder = 0
    object CL1: TLabel
      Left = 16
      Top = 26
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CL2: TLabel
      Left = 55
      Top = 26
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CL3: TLabel
      Left = 94
      Top = 26
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CL4: TLabel
      Left = 133
      Top = 26
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object VL1: TLabel
      Left = 16
      Top = 180
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object VL2: TLabel
      Left = 55
      Top = 180
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object VL3: TLabel
      Left = 94
      Top = 180
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object VL4: TLabel
      Left = 133
      Top = 180
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Ch1: TScrollBar
      Tag = 1
      Left = 16
      Top = 45
      Width = 17
      Height = 129
      Kind = sbVertical
      LargeChange = 255
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 0
      OnChange = ChChange
    end
    object Ch2: TScrollBar
      Tag = 2
      Left = 55
      Top = 45
      Width = 17
      Height = 129
      Kind = sbVertical
      LargeChange = 255
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 1
      OnChange = ChChange
    end
    object Ch3: TScrollBar
      Tag = 3
      Left = 94
      Top = 45
      Width = 17
      Height = 129
      Kind = sbVertical
      LargeChange = 255
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 2
      OnChange = ChChange
    end
    object Ch4: TScrollBar
      Tag = 4
      Left = 133
      Top = 45
      Width = 17
      Height = 129
      Kind = sbVertical
      LargeChange = 255
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 3
      OnChange = ChChange
    end
    object ScrollBar5: TScrollBar
      Left = 16
      Top = 199
      Width = 134
      Height = 17
      LargeChange = 4
      Max = 508
      PageSize = 0
      TabOrder = 4
      OnChange = ScrollBar5Change
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 222
    Width = 528
    Height = 19
    Panels = <
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
    ExplicitLeft = 368
    ExplicitTop = 248
    ExplicitWidth = 0
  end
  object GroupBox2: TGroupBox
    Left = 191
    Top = 0
    Width = 332
    Height = 221
    Caption = ' Interface '
    TabOrder = 2
    object Memo1: TMemo
      Left = 16
      Top = 23
      Width = 185
      Height = 193
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Interface Info')
      ParentFont = False
      TabOrder = 0
    end
    object RadioButton1: TRadioButton
      Left = 207
      Top = 25
      Width = 113
      Height = 17
      Caption = 'International Pins'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 207
      Top = 45
      Width = 113
      Height = 17
      Caption = 'Martin Pins'
      TabOrder = 2
      OnClick = RadioButton2Click
    end
    object Button1: TButton
      Left = 207
      Top = 68
      Width = 105
      Height = 25
      Caption = 'Reboot Interface'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 207
      Top = 99
      Width = 106
      Height = 25
      Caption = 'Firmware Update'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 207
      Top = 130
      Width = 106
      Height = 25
      Caption = 'Refresh Info'
      TabOrder = 5
      OnClick = Button3Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 80
    object SetallDMXchannelsto2551: TMenuItem
      Caption = 'Set all DMX channels to 255'
      OnClick = SetallDMXchannelsto2551Click
    end
    object ResetallDMXchannelsto01: TMenuItem
      Caption = 'Reset all DMX channels to 0'
      OnClick = ResetallDMXchannelsto01Click
    end
  end
end
