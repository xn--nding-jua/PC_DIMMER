object FrameEquiliser: TFrameEquiliser
  Left = 0
  Top = 0
  Width = 320
  Height = 123
  TabOrder = 0
  object RbAn: TRadioButton
    Left = 8
    Top = 8
    Width = 41
    Height = 17
    Caption = 'An'
    TabOrder = 0
    OnClick = RbAnClick
  end
  object RbAus: TRadioButton
    Left = 8
    Top = 24
    Width = 41
    Height = 17
    Caption = 'Aus'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = RbAusClick
  end
  object BtnReset: TButton
    Left = 8
    Top = 56
    Width = 25
    Height = 25
    Caption = 'R'
    TabOrder = 2
    OnClick = BtnResetClick
  end
end
