object timingform: Ttimingform
  Left = 545
  Top = 225
  BorderStyle = bsToolWindow
  Caption = 'Erweiterte Funktionen'
  ClientHeight = 241
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 193
    Caption = ' Timing des DMX512-Ausganges f'#252'r '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 34
      Width = 50
      Height = 13
      Caption = 'Breaktime:'
    end
    object Label2: TLabel
      Left = 8
      Top = 58
      Width = 46
      Height = 13
      Caption = 'Marktime:'
    end
    object Label3: TLabel
      Left = 8
      Top = 82
      Width = 63
      Height = 13
      Caption = 'Interbytetime:'
    end
    object Label4: TLabel
      Left = 8
      Top = 106
      Width = 69
      Height = 13
      Caption = 'Interframetime:'
    end
    object breaktimelabel: TLabel
      Left = 272
      Top = 32
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '17 (96us)'
    end
    object marktimelabel: TLabel
      Left = 272
      Top = 56
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '13 (9us)'
    end
    object interbytetimelabel: TLabel
      Left = 272
      Top = 80
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 (0us)'
    end
    object interframetimelabel: TLabel
      Left = 272
      Top = 104
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 (21us)'
    end
    object Label9: TLabel
      Left = 8
      Top = 139
      Width = 108
      Height = 13
      Caption = 'Maximale Kanalanzahl:'
    end
    object Label10: TLabel
      Left = 8
      Top = 163
      Width = 96
      Height = 13
      Caption = 'Wert des Startbytes:'
    end
    object breaktimescrollbar: TScrollBar
      Left = 88
      Top = 32
      Width = 177
      Height = 17
      Max = 65535
      PageSize = 0
      Position = 17
      TabOrder = 0
    end
    object marktimescrollbar: TScrollBar
      Left = 88
      Top = 56
      Width = 177
      Height = 17
      Max = 65535
      PageSize = 0
      Position = 13
      TabOrder = 1
      OnChange = marktimescrollbarChange
    end
    object interbytetimescrollbar: TScrollBar
      Left = 88
      Top = 80
      Width = 177
      Height = 17
      Max = 65535
      PageSize = 0
      TabOrder = 2
      OnChange = interbytetimescrollbarChange
    end
    object interframetimescrollbar: TScrollBar
      Left = 88
      Top = 104
      Width = 177
      Height = 17
      Max = 65535
      PageSize = 0
      TabOrder = 3
      OnChange = interframetimescrollbarChange
    end
    object maxchansedit: TJvSpinEdit
      Left = 128
      Top = 136
      Width = 49
      Height = 21
      MaxValue = 512.000000000000000000
      MinValue = 1.000000000000000000
      Value = 512.000000000000000000
      TabOrder = 4
      OnChange = maxchanseditChange
    end
    object startbyteedit: TJvSpinEdit
      Left = 128
      Top = 160
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 5
      OnChange = startbyteeditChange
    end
    object useinterbytedelaycheckbox: TCheckBox
      Left = 192
      Top = 136
      Width = 153
      Height = 17
      Caption = 'Interbyte Delay verwenden'
      TabOrder = 6
      OnMouseUp = useinterbytedelaycheckboxMouseUp
    end
    object useinterframedelaycheckbox: TCheckBox
      Left = 192
      Top = 160
      Width = 153
      Height = 17
      Caption = 'Interframe Delay verwenden'
      TabOrder = 7
      OnMouseUp = useinterframedelaycheckboxMouseUp
    end
  end
  object okbutton: TButton
    Left = 16
    Top = 208
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object saveineeprombutton: TButton
    Left = 232
    Top = 208
    Width = 123
    Height = 25
    Caption = 'Im Eeprom speichern'
    TabOrder = 2
  end
  object resetbutton: TButton
    Left = 152
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
  end
end
