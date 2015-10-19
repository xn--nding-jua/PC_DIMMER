object drucken: Tdrucken
  Left = 433
  Top = 197
  BorderStyle = bsSingle
  Caption = 'Drucken...'
  ClientHeight = 177
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TShape
    Left = 0
    Top = 136
    Width = 361
    Height = 41
    Align = alBottom
    Pen.Style = psClear
  end
  object Shape1: TShape
    Left = 0
    Top = 136
    Width = 361
    Height = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 121
    Caption = ' Kanal'#252'bersicht drucken '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Drucker:'
    end
    object Label2: TLabel
      Left = 8
      Top = 72
      Width = 52
      Height = 13
      Caption = 'Von Kanal:'
    end
    object Label3: TLabel
      Left = 88
      Top = 72
      Width = 46
      Height = 13
      Caption = 'bis Kanal:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 88
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object Edit2: TEdit
      Left = 88
      Top = 88
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '128'
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 40
      Width = 329
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object OK: TButton
    Left = 16
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Abbrechen: TButton
    Left = 96
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
end
