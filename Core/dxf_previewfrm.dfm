object dxf_previewform: Tdxf_previewform
  Left = 461
  Top = 143
  BorderStyle = bsSingle
  Caption = 'DXF-Importer'
  ClientHeight = 474
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 436
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Zoombox: Zoom_panel
      Left = 0
      Top = 0
      Width = 419
      Height = 436
      Align = alClient
      TabOrder = 0
      OnMouseDown = ZoomboxMouseDown
      OnMouseUp = ZoomboxMouseUp
      OnMouseMove = ZoomboxMouseMove
      OnPaint = ZoomboxPaint
      ZoomFactor = 1.250000000000000000
    end
  end
  object Panel2: TPanel
    Left = 419
    Top = 0
    Width = 191
    Height = 436
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 1
    object Files_listbox: TListBox
      Left = 1
      Top = 1
      Width = 189
      Height = 189
      Hint = 'Verf'#252'gbare Knotenlayer'
      Align = alClient
      ItemHeight = 13
      MultiSelect = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyDown = Files_listboxKeyDown
      OnKeyUp = Files_listboxKeyUp
      OnMouseUp = Files_listboxMouseUp
    end
    object messages: TListBox
      Left = 1
      Top = 254
      Width = 189
      Height = 181
      Hint = 'Ignorierte DXF-Eigenschaften'
      Align = alBottom
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object Panel3: TPanel
      Left = 1
      Top = 190
      Width = 189
      Height = 64
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object delete: TButton
        Left = 104
        Top = 8
        Width = 75
        Height = 25
        Caption = 'L'#246'schen'
        TabOrder = 0
        OnClick = deleteClick
      end
      object Track_mouse: TCheckBox
        Left = 104
        Top = 40
        Width = 73
        Height = 17
        Caption = 'Tracking'
        TabOrder = 1
        OnMouseUp = Track_mouseMouseUp
      end
      object Thick_lines: TCheckBox
        Left = 8
        Top = 40
        Width = 89
        Height = 17
        Caption = 'Dickere Linien'
        TabOrder = 2
        OnMouseUp = Thick_linesMouseUp
      end
      object Button1: TButton
        Left = 8
        Top = 8
        Width = 89
        Height = 25
        Caption = 'Neu zeichnen'
        TabOrder = 3
        OnClick = Button1Click
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 436
    Width = 610
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Button2: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Abbrechen'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Track_Timer: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Track_TimerTimer
    Left = 17
    Top = 17
  end
end
