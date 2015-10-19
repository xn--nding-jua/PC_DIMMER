object layerbezeichnungenform: Tlayerbezeichnungenform
  Left = 335
  Top = 132
  BorderStyle = bsSingle
  Caption = 'Layerbezeichnungen'
  ClientHeight = 217
  ClientWidth = 265
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
  object Shape4: TShape
    Left = 0
    Top = 176
    Width = 265
    Height = 41
    Align = alBottom
    Pen.Style = psClear
  end
  object Shape1: TShape
    Left = 0
    Top = 176
    Width = 265
    Height = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 1'
    TabOrder = 0
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit2: TLabeledEdit
    Left = 8
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 2'
    TabOrder = 1
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit3: TLabeledEdit
    Left = 8
    Top = 104
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 3'
    TabOrder = 2
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit4: TLabeledEdit
    Left = 8
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 4'
    TabOrder = 3
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit5: TLabeledEdit
    Left = 136
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 5'
    TabOrder = 4
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit6: TLabeledEdit
    Left = 136
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 6'
    TabOrder = 5
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit7: TLabeledEdit
    Left = 136
    Top = 104
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 7'
    TabOrder = 6
    OnKeyUp = LabeledEdit1KeyUp
  end
  object LabeledEdit8: TLabeledEdit
    Left = 136
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Layer 8'
    TabOrder = 7
    OnKeyUp = LabeledEdit1KeyUp
  end
  object Button1: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 8
  end
  object Button2: TButton
    Left = 88
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 9
  end
end
