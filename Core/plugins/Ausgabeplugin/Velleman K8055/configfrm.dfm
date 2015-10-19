object Config: TConfig
  Left = 584
  Top = 123
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 169
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Ger'#228'testatus:'
  end
  object statuslabel: TLabel
    Left = 80
    Top = 8
    Width = 107
    Height = 13
    Caption = 'Nicht verbunden...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 153
    Height = 97
    Caption = ' Verbindung '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 72
      Height = 13
      Caption = 'Ger'#228'teadresse:'
    end
    object Button1: TButton
      Left = 56
      Top = 40
      Width = 89
      Height = 21
      Caption = 'Verbinden...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object AddressEdit: TJvSpinEdit
      Left = 8
      Top = 40
      Width = 41
      Height = 21
      MaxValue = 3.000000000000000000
      TabOrder = 1
    end
    object Button2: TButton
      Left = 8
      Top = 68
      Width = 137
      Height = 21
      Caption = 'Verbindung trennen'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 168
    Top = 32
    Width = 241
    Height = 97
    Caption = ' Generelle Einstellungen '
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 23
      Width = 156
      Height = 13
      Caption = 'Schaltschwelle f'#252'r Digital-Output:'
    end
    object Label4: TLabel
      Left = 8
      Top = 46
      Width = 156
      Height = 13
      Caption = 'Startadresse f'#252'r Eingangsevents:'
    end
    object Label5: TLabel
      Left = 8
      Top = 67
      Width = 121
      Height = 13
      Caption = 'Abtastrate Eing'#228'nge (ms):'
    end
    object switchvalueedit: TJvSpinEdit
      Left = 176
      Top = 19
      Width = 57
      Height = 21
      MaxValue = 254.000000000000000000
      Value = 127.000000000000000000
      TabOrder = 0
    end
    object startaddressedit: TJvSpinEdit
      Left = 176
      Top = 43
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
    end
    object intervaledit: TJvSpinEdit
      Left = 176
      Top = 67
      Width = 57
      Height = 21
      MaxValue = 10000.000000000000000000
      MinValue = 25.000000000000000000
      Value = 50.000000000000000000
      TabOrder = 2
      OnChange = intervaleditChange
    end
  end
  object Button3: TButton
    Left = 16
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Schlie'#223'en'
    TabOrder = 2
    OnClick = Button3Click
  end
  object CHHighResTimer1: TCHHighResTimer
    OnTimer = CHHighResTimer1Timer
    Interval = 50
    Accuracy = 0
    Enabled = True
    Left = 376
    Top = 8
  end
end
