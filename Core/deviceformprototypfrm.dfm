object deviceformprototyp: Tdeviceformprototyp
  Left = 377
  Top = 124
  Width = 409
  Height = 315
  Caption = 'deviceformprototyp'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object devicename: TLabel
    Left = 48
    Top = 8
    Width = 28
    Height = 13
    Caption = 'Name'
    Visible = False
  end
  object deviceimage: TImage
    Left = 8
    Top = 8
    Width = 32
    Height = 32
    Visible = False
  end
  object deviceadress: TLabel
    Left = 48
    Top = 24
    Width = 38
    Height = 13
    Caption = 'Address'
    Visible = False
  end
  object position: TPanel
    Left = 8
    Top = 44
    Width = 225
    Height = 226
    BevelOuter = bvLowered
    TabOrder = 0
    Visible = False
    OnMouseDown = positionMouseDown
    OnMouseMove = positionMouseMove
    object Bevel1: TBevel
      Left = 113
      Top = 0
      Width = 1
      Height = 225
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 0
      Top = 113
      Width = 225
      Height = 1
      Shape = bsTopLine
    end
    object Shape1: TShape
      Left = 103
      Top = 103
      Width = 20
      Height = 20
      Brush.Color = clBlack
      Shape = stCircle
    end
  end
  object Colorpicker: TJvOfficeColorPanel
    Left = 242
    Top = 48
    Width = 158
    Height = 104
    TabOrder = 1
    Visible = False
    Properties.ShowAutoButton = False
    Properties.ShowOtherButton = False
    Properties.AutoCaption = 'Automatic'
    Properties.OtherCaption = 'Other Colors...'
  end
end
