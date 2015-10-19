object Form1: TForm1
  Left = 35
  Top = 115
  BorderStyle = bsDialog
  Caption = 'TUSBDMX'
  ClientHeight = 354
  ClientWidth = 211
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
  object GB_Ports: TGroupBox
    Left = 0
    Top = 0
    Width = 210
    Height = 93
    Caption = 'Ports'
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 19
      Width = 68
      Height = 13
      Caption = 'Bouton  Next :'
    end
    object Label2: TLabel
      Left = 104
      Top = 19
      Width = 28
      Height = 13
      Caption = 'Prev :'
    end
    object Bevel1: TBevel
      Left = 82
      Top = 19
      Width = 12
      Height = 12
    end
    object Shape0: TShape
      Left = 83
      Top = 20
      Width = 9
      Height = 10
      Brush.Color = clGray
      Pen.Color = clGray
    end
    object Bevel2: TBevel
      Left = 136
      Top = 19
      Width = 12
      Height = 13
    end
    object Shape1: TShape
      Left = 137
      Top = 20
      Width = 10
      Height = 11
      Brush.Color = clGray
      Pen.Color = clGray
    end
    object SB1: TSpeedButton
      Left = 75
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 1
      Caption = '1'
      OnClick = SBClick
    end
    object SB2: TSpeedButton
      Left = 91
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 2
      Caption = '2'
      OnClick = SBClick
    end
    object SB3: TSpeedButton
      Left = 107
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 3
      Caption = '3'
      OnClick = SBClick
    end
    object SB4: TSpeedButton
      Left = 123
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 4
      Caption = '4'
      OnClick = SBClick
    end
    object SB5: TSpeedButton
      Left = 139
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 5
      Caption = '5'
      OnClick = SBClick
    end
    object SB6: TSpeedButton
      Left = 155
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 6
      Caption = '6'
      OnClick = SBClick
    end
    object SB7: TSpeedButton
      Left = 171
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 7
      Caption = '7'
      OnClick = SBClick
    end
    object SB8: TSpeedButton
      Left = 187
      Top = 47
      Width = 17
      Height = 17
      AllowAllUp = True
      GroupIndex = 8
      Caption = '8'
      OnClick = SBClick
    end
    object Shape2: TShape
      Left = 76
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape3: TShape
      Left = 92
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape4: TShape
      Left = 108
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape5: TShape
      Left = 124
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape6: TShape
      Left = 140
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape7: TShape
      Left = 156
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape8: TShape
      Left = 172
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Shape9: TShape
      Left = 188
      Top = 71
      Width = 13
      Height = 14
      Brush.Color = clGray
      Pen.Color = clWhite
      OnMouseUp = ShapeMouseUp
    end
    object Label7: TLabel
      Left = 6
      Top = 47
      Width = 61
      Height = 14
      Caption = 'Input/Output'
    end
    object Label8: TLabel
      Left = 6
      Top = 71
      Width = 19
      Height = 13
      Caption = 'Etat'
    end
  end
  object GB_DMX: TGroupBox
    Left = 1
    Top = 96
    Width = 209
    Height = 238
    Caption = 'DMX'
    TabOrder = 1
    object Label3: TLabel
      Left = 76
      Top = 216
      Width = 54
      Height = 13
      Caption = 'Channel : 1'
      Color = clScrollBar
      ParentColor = False
    end
    object Label4: TLabel
      Left = 37
      Top = 78
      Width = 33
      Height = 17
      AutoSize = False
      Caption = 'Valeur'
      Color = clScrollBar
      ParentColor = False
    end
    object Label5: TLabel
      Left = 37
      Top = 94
      Width = 33
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
      Color = clScrollBar
      ParentColor = False
    end
    object SpeedButton1: TSpeedButton
      Left = 176
      Top = 16
      Width = 23
      Height = 22
      Enabled = False
      Visible = False
      OnClick = SpeedButton1Click
    end
    object DMX_V: TTrackBar
      Left = 83
      Top = 16
      Width = 45
      Height = 150
      Max = 0
      Min = -255
      Orientation = trVertical
      Frequency = 8
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsAuto
      OnChange = DMX_VChange
    end
    object DMX_C: TTrackBar
      Left = 9
      Top = 167
      Width = 190
      Height = 45
      Max = 512
      Min = 1
      Orientation = trHorizontal
      PageSize = 5
      Frequency = 16
      Position = 1
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = DMX_CChange
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 335
    Width = 211
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Timer1: TTimer
    Interval = 20
    OnTimer = Timer1Timer
    Left = 176
    Top = 304
  end
end
