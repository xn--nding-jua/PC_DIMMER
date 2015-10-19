object Config: TConfig
  Left = 584
  Top = 123
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 137
  ClientWidth = 184
  Color = clInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 42
    Height = 13
    Caption = 'LPT-Port'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 96
    Top = 32
    Width = 44
    Height = 13
    Caption = 'Switch at'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 146
    Height = 20
    Caption = 'Parallelport Plugin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lptchange: TComboBox
    Left = 8
    Top = 48
    Width = 73
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'LPT 1'
    Items.Strings = (
      'LPT 1'
      'LPT 2'
      'LPT 3')
  end
  object Button1: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 96
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object switchvaluechange: TComboBox
    Left = 96
    Top = 48
    Width = 73
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = '50%'
  end
  object prefading: TCheckBox
    Left = 8
    Top = 80
    Width = 169
    Height = 17
    Caption = 'Werte vor Fadebeginn setzen'
    TabOrder = 4
  end
  object XPManifest1: TXPManifest
    Left = 152
    Top = 96
  end
end
