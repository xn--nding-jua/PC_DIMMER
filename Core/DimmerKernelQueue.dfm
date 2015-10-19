object DimmerkernelQueueForm: TDimmerkernelQueueForm
  Left = 457
  Top = 150
  Width = 645
  Height = 396
  Caption = 'DimmerKernelQueue'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 637
    Height = 366
    Align = alClient
    ColCount = 3
    DefaultColWidth = 200
    DefaultRowHeight = 15
    ScrollBars = ssVertical
    TabOrder = 0
    OnMouseUp = StringGrid1MouseUp
    RowHeights = (
      15
      15
      15
      15
      15)
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 24
    Top = 16
  end
end
