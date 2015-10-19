object Form1: TForm1
  Left = 192
  Top = 107
  Width = 291
  Height = 226
  Caption = 'K8062 Light Controller Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 21
    Height = 13
    Caption = '00'
  end
  object Label2: TLabel
    Left = 52
    Top = 8
    Width = 12
    Height = 13
    Caption = '00'
  end
  object Label3: TLabel
    Left = 88
    Top = 8
    Width = 12
    Height = 13
    Caption = '00'
  end
  object Label4: TLabel
    Left = 124
    Top = 8
    Width = 12
    Height = 13
    Caption = '00'
  end
  object Label5: TLabel
    Left = 20
    Top = 172
    Width = 17
    Height = 13
    Caption = '1'
  end
  object Label6: TLabel
    Left = 56
    Top = 172
    Width = 17
    Height = 13
    Caption = '2'
  end
  object Label7: TLabel
    Left = 92
    Top = 172
    Width = 17
    Height = 13
    Caption = '3'
  end
  object Label8: TLabel
    Left = 128
    Top = 172
    Width = 17
    Height = 13
    Caption = '4'
  end
  object Label9: TLabel
    Left = 184
    Top = 124
    Width = 65
    Height = 13
    Caption = 'Start address:'
  end
  object ScrollBar1: TScrollBar
    Left = 16
    Top = 24
    Width = 17
    Height = 141
    Kind = sbVertical
    Max = 255
    PageSize = 0
    Position = 255
    TabOrder = 0
    OnChange = ScrollBar1Change
  end
  object ScrollBar2: TScrollBar
    Left = 52
    Top = 24
    Width = 17
    Height = 141
    Kind = sbVertical
    Max = 255
    PageSize = 0
    Position = 255
    TabOrder = 1
    OnChange = ScrollBar2Change
  end
  object ScrollBar3: TScrollBar
    Left = 88
    Top = 24
    Width = 17
    Height = 141
    Kind = sbVertical
    Max = 255
    PageSize = 0
    Position = 255
    TabOrder = 2
    OnChange = ScrollBar3Change
  end
  object ScrollBar4: TScrollBar
    Left = 124
    Top = 24
    Width = 17
    Height = 141
    Kind = sbVertical
    Max = 255
    PageSize = 0
    Position = 255
    TabOrder = 3
    OnChange = ScrollBar4Change
  end
  object Edit1: TEdit
    Left = 184
    Top = 144
    Width = 65
    Height = 21
    TabOrder = 4
    Text = '1'
    OnChange = Edit1Change
  end
end
