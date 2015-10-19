object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsToolWindow
  Caption = 'DMX-Stream Editor'
  ClientHeight = 201
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 89
    Caption = ' Quellstream A '
    TabOrder = 0
    object sourceaedit: TEdit
      Left = 8
      Top = 24
      Width = 225
      Height = 21
      TabOrder = 0
      Text = 'c:\DemoA.dmxs'
    end
    object openabtn: TButton
      Left = 8
      Top = 56
      Width = 225
      Height = 25
      Caption = #214'ffnen'
      TabOrder = 1
      OnClick = openabtnClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 256
    Top = 8
    Width = 241
    Height = 89
    Caption = ' Quellstream B '
    TabOrder = 1
    object sourcebedit: TEdit
      Left = 8
      Top = 24
      Width = 225
      Height = 21
      TabOrder = 0
      Text = 'c:\DemoB.dmxs'
    end
    object openbbtn: TButton
      Left = 8
      Top = 56
      Width = 225
      Height = 25
      Caption = #214'ffnen'
      TabOrder = 1
      OnClick = openbbtnClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 128
    Top = 104
    Width = 241
    Height = 89
    Caption = ' Zielstream  '
    TabOrder = 2
    object destinationedit: TEdit
      Left = 8
      Top = 24
      Width = 225
      Height = 21
      TabOrder = 0
      Text = 'c:\DemoC.dmxs'
    end
    object mergebabtn: TButton
      Left = 8
      Top = 56
      Width = 113
      Height = 25
      Caption = 'Add B -> A'
      Enabled = False
      TabOrder = 1
      OnClick = mergebabtnClick
    end
    object mergeabbtn: TButton
      Left = 128
      Top = 56
      Width = 107
      Height = 25
      Caption = 'Add A -> B'
      Enabled = False
      TabOrder = 2
      OnClick = mergeabbtnClick
    end
  end
end
