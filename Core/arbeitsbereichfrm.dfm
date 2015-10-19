object arbeitsbereichform: Tarbeitsbereichform
  Left = 386
  Top = 97
  BorderStyle = bsSingle
  Caption = 'Desktops'
  ClientHeight = 105
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 56
    Width = 233
    Height = 9
    Shape = bsBottomLine
  end
  object Button1: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Speichern'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 88
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 217
    Height = 21
    TabOrder = 2
    Text = 'Neuer Arbeitsbereich'
    OnKeyUp = Edit1KeyUp
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 32
    Width = 217
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'Letzter Desktop'
      'Desktop 2'
      'Desktop 3'
      'Desktop 4'
      'Desktop 5'
      'Desktop 6'
      'Desktop 7'
      'Desktop 8'
      'Desktop 9')
  end
end
