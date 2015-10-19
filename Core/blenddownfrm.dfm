object blenddown: Tblenddown
  Left = 862
  Top = 89
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'blenddown'
  ClientHeight = 218
  ClientWidth = 391
  Color = clBlack
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object blendfadein: TTimer
    Enabled = False
    Interval = 1
    OnTimer = blendfadeinTimer
    Left = 8
    Top = 8
  end
  object blendfadeout: TTimer
    Enabled = False
    Interval = 1
    OnTimer = blendfadeoutTimer
    Left = 40
    Top = 8
  end
end
