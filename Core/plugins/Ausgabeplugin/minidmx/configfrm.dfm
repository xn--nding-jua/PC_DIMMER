object Config: TConfig
  Left = 500
  Top = 117
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 273
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 232
    Width = 353
    Height = 9
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 106
    Height = 13
    Caption = 'MiniDMX Interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 240
    Width = 160
    Height = 13
    Caption = 'Erfolgreiche DMX-'#220'bertragungen:'
  end
  object Label3: TLabel
    Left = 296
    Top = 240
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label5: TLabel
    Left = 128
    Top = 256
    Width = 128
    Height = 13
    Caption = 'Anzahl '#220'bertragungsfehler:'
  end
  object Label6: TLabel
    Left = 264
    Top = 256
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ConfigOK: TButton
    Left = 8
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 337
    Height = 81
    Caption = ' Interfaceoptionen '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 96
      Height = 13
      Caption = 'Kein COM-Port frei...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 56
      Width = 137
      Height = 17
      Caption = '256 Kan'#228'le (schneller)'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnMouseUp = RadioButton1MouseUp
    end
    object RadioButton2: TRadioButton
      Left = 168
      Top = 56
      Width = 97
      Height = 17
      Caption = '512 Kan'#228'le'
      TabOrder = 1
      OnMouseUp = RadioButton1MouseUp
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 24
      Width = 321
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'COM1'
      OnSelect = ComboBox1Select
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'COM13'
        'COM14'
        'COM15'
        'COM16')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 120
    Width = 337
    Height = 105
    Caption = ' Meldungen vom Interface '
    TabOrder = 2
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 321
      Height = 81
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 312
    Top = 8
  end
end
