object Config: TConfig
  Left = 702
  Top = 118
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 177
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
  OnShow = FormShow
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
    Top = 136
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
    Left = 112
    Top = 32
    Width = 65
    Height = 13
    Caption = 'Letzter Kanal:'
  end
  object Label7: TLabel
    Left = 18
    Top = 76
    Width = 87
    Height = 13
    Alignment = taRightJustify
    Caption = 'Timerintervall [ms]:'
  end
  object Label3: TLabel
    Left = 8
    Top = 104
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
    Top = 120
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
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnCloseUp = portchangeCloseUp
    OnDropDown = portchangeDropDown
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
    Top = 144
    Width = 81
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Abbrechen: TButton
    Left = 96
    Top = 144
    Width = 81
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 112
    Top = 48
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '64'
    OnChange = Edit1Change
    OnKeyUp = Edit1KeyUp
  end
  object Edit2: TEdit
    Left = 112
    Top = 72
    Width = 65
    Height = 21
    TabOrder = 4
    Text = '75'
    OnChange = Edit2Change
    OnKeyUp = Edit2KeyUp
  end
  object DMXValueRefreshTimer: TCHHighResTimer
    OnTimer = DMXValueRefreshTimerTimer
    Interval = 75
    Accuracy = 0
    Enabled = True
    Left = 120
  end
  object comport: TCommPortDriver
    PortName = '\\.\COM2'
    BaudRate = br19200
    BaudRateValue = 19200
    Left = 152
  end
end
