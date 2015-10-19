object Form1: TForm1
  Left = 713
  Top = 88
  Width = 287
  Height = 156
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DMXTimer: TCHHighResTimer
    OnTimer = DMXTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = False
    Left = 8
    Top = 8
  end
end
