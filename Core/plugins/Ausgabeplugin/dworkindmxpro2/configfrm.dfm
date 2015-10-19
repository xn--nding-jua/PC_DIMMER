object Config: TConfig
  Left = 594
  Top = 114
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 209
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 91
    Height = 16
    Caption = 'Konfiguration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 88
    Height = 13
    Caption = 'Serieller Anschluss'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 168
    Width = 185
    Height = 9
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 52
    Width = 88
    Height = 13
    Caption = 'kein Anschluss frei'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 80
    Width = 94
    Height = 13
    Caption = 'Interface-EEPROM:'
  end
  object Label3: TLabel
    Left = 8
    Top = 128
    Width = 41
    Height = 13
    Caption = 'Status:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object statuslabel: TLabel
    Left = 8
    Top = 144
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
  object portchange: TComboBox
    Left = 8
    Top = 48
    Width = 169
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnSelect = portchangeSelect
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16')
  end
  object ConfigOK: TButton
    Left = 8
    Top = 176
    Width = 81
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Abbrechen: TButton
    Left = 96
    Top = 176
    Width = 81
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 169
    Height = 25
    Hint = 'Speichert die aktuellen Werte im EEPROM des Interfaces'
    Caption = 'Aktuelle Kanalwerte speichern'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object comport: TCommPortDriver
    Port = pnCustom
    PortName = '\\.\COM2'
    BaudRate = brCustom
    BaudRateValue = 115200
    InputTimeout = 100
    Left = 152
  end
  object SendTimer: TCHHighResTimer
    OnTimer = SendTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = False
    Left = 120
  end
end
