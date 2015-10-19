object presskeyfrm: Tpresskeyfrm
  Left = 211
  Top = 124
  AlphaBlend = True
  AlphaBlendValue = 200
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 89
  ClientWidth = 418
  Color = clNavy
  TransparentColor = True
  TransparentColorValue = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 401
    Height = 73
    Brush.Color = clGradientInactiveCaption
    Shape = stRoundRect
  end
  object Label1: TLabel
    Left = 89
    Top = 29
    Width = 298
    Height = 29
    Caption = 'Bitte eine Taste dr'#252'cken...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Animate1: TAnimate
    Left = 10
    Top = 18
    Width = 80
    Height = 50
    Color = clGradientInactiveCaption
    CommonAVI = aviFindFolder
    ParentColor = False
    StopFrame = 13
  end
end
