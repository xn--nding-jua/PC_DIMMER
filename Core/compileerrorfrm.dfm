object compileerrorform: Tcompileerrorform
  Left = 445
  Top = 124
  Width = 602
  Height = 380
  Caption = 'Fehler in Ger'#228'tedefinition'
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
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 594
    Height = 219
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 219
    Width = 594
    Height = 88
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 307
    Width = 594
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Schlie'#223'en'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
