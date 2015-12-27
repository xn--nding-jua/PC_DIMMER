object kanaluebersichtform: Tkanaluebersichtform
  Left = 360
  Top = 128
  Width = 608
  Height = 397
  Caption = 'Kanal'#252'bersicht'
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000890B0000890B00000000000000000000BABA
    BA26656565DA5F5F5FDA5F5F5FDA5F5F5FDA5F5F5FDA606060DA5F5F5FDA5F5F
    5FDA5F5F5FDA606060DA5F5F5FDA5F5F5FDA5F5F5FDA5A5A5ADEA8A8A877A2A2
    A2A7747474FF898989FFB3B3B4FFB0AFAFFFB2B2B2FF818181FFB3B4B3FFAEAE
    AEFFB1B0B0FF848484FFAAAAABFFAAAAAAFFAAAAAAFF808080FF848484FCA9A9
    A9BF7E7E7EFFB9B9B9FFF8F8F8FFF3F3F2FFF6F6F6FFABABABFFF8F8F8FFEFF0
    F0FFF3F3F3FFB0B0B0FFEAEAEAFFE9E9E9FFE9E9E9FFAFAFAFFF848484FF9D9D
    9DC1797979FF858585FFA7A7A7FFA4A4A4FFA6A7A6FF7F7F7FFFA7A7A7FFA2A2
    A2FFA4A4A4FF808080FFA0A0A0FF9F9F9FFF9F9F9FFF7B7B7BFF888888FFACAC
    ACBA717171FFBEBEBEFFFDFEFEFFF8F8F8FFFBFCFBFFADADADFFFCFCFCFFF3F3
    F3FFF7F8F8FFB2B2B2FFEDEDEDFFECECECFFECECECFFB1B1B1FF848484FFA8A8
    A8BF7F7F7FFF9A9A9AFFC9C9C9FFC4C4C4FFC8C7C8FF919191FFC7C8C8FFC1C1
    C1FFC4C4C5FF939393FFBDBDBDFFBCBCBCFFBCBCBCFF8F8F8FFF878787FF9F9F
    9FBF808080FF9F9F9FFFD2D2D2FFCECECEFFD1D1D1FF969696FFD2D1D1FFCACA
    CAFFCDCDCDFF989898FFC5C5C5FFC4C4C4FFC4C4C4FF949494FF868686FFA7A7
    A7BC7F7F7FFFB5B5B5FFF4F4F4FFEEEEEEFFF2F2F2FFA8A8A8FFF2F2F2FFE9E9
    E9FFECECECFFABABABFFE3E3E3FFE1E1E1FFE1E1E1FFA9A9A9FF848484FF9797
    97C17C7C7CFF8D8E8EFFB7B7B7FFB4B4B4FFB6B6B5FF878787FFB6B6B5FFB0B0
    AFFFB1B1B2FF888888FFACABABFFAAAAAAFFAAAAAAFF828282FF888888FFA8A8
    A8BA858585FFC1C2C2FFFFFFFFFFFFFFFFFFFFFFFFFFB4B4B4FFFFFFFFFFFBFB
    FBFFFEFEFEFFB5B5B5FFF4F4F4FFF1F1F1FFF1F1F1FFB4B4B4FF838383FFA0A0
    A0C0828282FF969696FFC6C6C6FFC3C3C3FFC4C5C4FF8E8E8EFFC4C4C4FFBDBD
    BDFFBEBEBEFF8F8F8FFFB7B7B7FFB6B6B6FFB6B6B6FF8A8A8AFF878787FFA9A9
    A9BD959595FFA8A8A8FFE2E2E2FFE2E2E1FFE2E2E2FF9F9F9FFFE1E1E1FFD8D8
    D8FFDBDBDBFFA0A0A0FFD3D3D2FFD0D0D0FFD0D0D0FF9D9D9DFF868686FF9F9F
    9FBD919191FFB0B0B0FFEFEFEFFFF0F0F0FFEEEEEEFFA6A6A6FFEDEDEDFFE9E9
    E9FFE6E6E6FFA6A6A6FFDCDCDCFFDEDEDEFFDADADAFFA4A4A4FF858585FFA6A6
    A6C2949494FF818181FF9A9A9AFF848484FFA0A0A0FF7B7B7BFFA1A1A1FF8080
    80FFA0A0A0FF7D7D7DFF9E9E9EFF878787FF9C9C9CFF797979FF868686F6C2C2
    C2B7BDBDBDFF949494FFB0B0B0FF636363FFC8C8C8FF8A8A8AFFC6C6C6FF3E3E
    3EFFC9C9C9FF909090FFC7C7C7FF707070FFC0C0C0FF9B9B9BFF99999981C5C5
    C542C5C5C593B3B3B392C7C7C792B8B8B892CACACA92AFAFAF92C9C9C992A5A5
    A592CACACA92B2B2B292C8C8C892B5B5B592C6C6C693B9B9B96AAFAFAF088001
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000FFFF8003FFFF}
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 41
    Top = 0
    Width = 535
    Height = 324
    Hint = 'Scrollen mit STRG+Mausrad'
    Align = alClient
    Color = clGray
    ParentColor = False
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    OnDblClick = PaintBoxDblClick
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnMouseUp = PaintBoxMouseUp
    OnPaint = PaintBoxPaint
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 0
    Width = 41
    Height = 324
    Align = alLeft
    Max = 255
    Orientation = trVertical
    Position = 255
    TabOrder = 1
    TickMarks = tmBoth
    TickStyle = tsManual
    OnChange = TrackBar1Change
    OnEnter = TrackBar1Enter
    OnExit = TrackBar1Exit
  end
  object ScrollBar1: TScrollBar
    Left = 576
    Top = 0
    Width = 16
    Height = 324
    Align = alRight
    Kind = sbVertical
    LargeChange = 10
    Max = 512
    PageSize = 0
    TabOrder = 0
    OnEnter = ScrollBar1Enter
    OnScroll = ScrollBar1Scroll
  end
  object Panel1: TPanel
    Left = 0
    Top = 324
    Width = 592
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 592
      Height = 1
      Align = alTop
    end
    object Label6: TLabel
      Left = 339
      Top = 2
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label6'
    end
    object Label7: TLabel
      Left = 339
      Top = 16
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label7'
    end
    object Panel2: TPanel
      Left = 384
      Top = 1
      Width = 208
      Height = 33
      Align = alRight
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 0
      object Label3: TLabel
        Left = 169
        Top = 2
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label3'
      end
      object Label4: TLabel
        Left = 169
        Top = 16
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label4'
      end
      object Label5: TLabel
        Left = 8
        Top = 2
        Width = 58
        Height = 13
        Caption = 'Zellenbreite:'
      end
      object WidthTrackbar: TTrackBar
        Left = 8
        Top = 14
        Width = 65
        Height = 20
        Ctl3D = True
        Max = 256
        Min = 64
        ParentCtl3D = False
        Position = 64
        TabOrder = 0
        ThumbLength = 15
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = WidthTrackbarChange
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 16
    object DDFanzeigen1: TMenuItem
      Caption = 'DDF anzeigen'
      OnClick = DDFanzeigen1Click
    end
    object Info1: TMenuItem
      Caption = 'Tastenk'#252'rzel...'
      OnClick = Info1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MinWertndern1: TMenuItem
      Caption = 'Min-Wert '#228'ndern...'
      OnClick = MinWertndern1Click
    end
    object MaxWertndern1: TMenuItem
      Caption = 'Max-Wert '#228'ndern...'
      OnClick = MaxWertndern1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Kanalselektioneinaus1: TMenuItem
      Caption = 'Kanalselektion ein/aus'
      OnClick = Kanalselektioneinaus1Click
    end
  end
  object RefreshTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = RefreshTimerTimer
    Left = 144
    Top = 16
  end
end
