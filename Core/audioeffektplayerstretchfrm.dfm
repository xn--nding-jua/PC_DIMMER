object audioeffektplayerstretchform: Taudioeffektplayerstretchform
  Left = 272
  Top = 205
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'Zeitkorrektur'
  ClientHeight = 161
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 152
    Top = 88
    Width = 9
    Height = 13
    Caption = '->'
  end
  object Label7: TLabel
    Left = 152
    Top = 48
    Width = 9
    Height = 13
    Caption = '->'
  end
  object Shape4: TShape
    Left = 0
    Top = 120
    Width = 401
    Height = 41
    Align = alBottom
    Pen.Style = psClear
  end
  object Shape1: TShape
    Left = 0
    Top = 120
    Width = 401
    Height = 1
  end
  object Button1: TButton
    Left = 8
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 88
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 105
    Caption = ' Quellwerte '
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 72
      Height = 13
      Caption = 'Gesamtlaufzeit:'
    end
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 47
      Height = 13
      Caption = '100,000%'
    end
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 9
      Height = 13
      Caption = '...'
    end
    object Label10: TLabel
      Left = 8
      Top = 62
      Width = 81
      Height = 13
      Caption = 'Geschwindigkeit:'
    end
  end
  object GroupBox2: TGroupBox
    Left = 168
    Top = 8
    Width = 225
    Height = 105
    Caption = ' Zielwerte '
    TabOrder = 3
    object Label1: TLabel
      Left = 175
      Top = 40
      Width = 41
      Height = 13
      Caption = 'h:m:s:ms'
    end
    object Label5: TLabel
      Left = 175
      Top = 80
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label8: TLabel
      Left = 8
      Top = 20
      Width = 72
      Height = 13
      Caption = 'Gesamtlaufzeit:'
    end
    object Label9: TLabel
      Left = 8
      Top = 62
      Width = 81
      Height = 13
      Caption = 'Geschwindigkeit:'
    end
    object percent_edit: TJvSpinEdit
      Left = 8
      Top = 76
      Width = 161
      Height = 21
      CheckMaxValue = False
      Decimal = 3
      MinValue = 1.000000000000000000
      ValueType = vtFloat
      Value = 100.000000000000000000
      TabOrder = 0
      OnKeyUp = percent_editKeyUp
      OnMouseUp = percent_editMouseUp
    end
    object h_edit: TJvSpinEdit
      Left = 8
      Top = 36
      Width = 41
      Height = 21
      TabOrder = 1
      OnKeyUp = h_editKeyUp
      OnMouseUp = h_editMouseUp
    end
    object m_edit: TJvSpinEdit
      Left = 48
      Top = 36
      Width = 41
      Height = 21
      TabOrder = 2
      OnKeyUp = h_editKeyUp
    end
    object s_edit: TJvSpinEdit
      Left = 88
      Top = 36
      Width = 41
      Height = 21
      TabOrder = 3
      OnKeyUp = h_editKeyUp
    end
    object ms_edit: TJvSpinEdit
      Left = 128
      Top = 36
      Width = 41
      Height = 21
      TabOrder = 4
      OnKeyUp = h_editKeyUp
    end
  end
end
