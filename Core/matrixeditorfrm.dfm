object matrixeditorform: Tmatrixeditorform
  Left = 342
  Top = 135
  Width = 754
  Height = 573
  Caption = 'Matrixeditor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 560
    Height = 484
    Hint = 'Rechte Maustaste f'#252'r Men'#252
    Align = alClient
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
  end
  object Panel1: TPanel
    Left = 560
    Top = 0
    Width = 186
    Height = 484
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 63
      Height = 13
      Caption = 'Zeilenanzahl:'
    end
    object Label13: TLabel
      Left = 80
      Top = 4
      Width = 70
      Height = 13
      Caption = 'Spaltenanzahl:'
    end
    object rowcount: TJvSpinEdit
      Left = 8
      Top = 24
      Width = 65
      Height = 21
      MaxValue = 256.000000000000000000
      MinValue = 2.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 0
      OnChange = rowcountChange
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 384
      Width = 169
      Height = 97
      Caption = ' Ger'#228'tedetails '
      TabOrder = 1
      object Label6: TLabel
        Left = 8
        Top = 40
        Width = 41
        Height = 13
        Caption = 'Adresse:'
      end
      object deviceaddress: TLabel
        Left = 56
        Top = 40
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label8: TLabel
        Left = 8
        Top = 56
        Width = 26
        Height = 13
        Caption = 'RGB:'
      end
      object hasrgb: TLabel
        Left = 40
        Top = 56
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label10: TLabel
        Left = 8
        Top = 72
        Width = 38
        Height = 13
        Caption = 'Dimmer:'
      end
      object hasdimmer: TLabel
        Left = 56
        Top = 72
        Width = 9
        Height = 13
        Caption = '...'
      end
      object devicebox: TComboBox
        Left = 8
        Top = 16
        Width = 129
        Height = 19
        Style = csOwnerDrawVariable
        ItemHeight = 13
        TabOrder = 0
        OnDrawItem = deviceboxDrawItem
        OnSelect = deviceboxSelect
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 56
      Width = 169
      Height = 321
      Caption = ' Kanaleinstellungen '
      TabOrder = 2
      object Label5: TLabel
        Left = 8
        Top = 56
        Width = 30
        Height = 13
        Caption = 'Kanal:'
      end
      object Label3: TLabel
        Left = 61
        Top = 97
        Width = 29
        Height = 13
        Caption = '0% (0)'
      end
      object Label2: TLabel
        Left = 8
        Top = 97
        Width = 50
        Height = 13
        Caption = 'Kanalwert:'
      end
      object Label7: TLabel
        Left = 64
        Top = 139
        Width = 43
        Height = 13
        Caption = 'Fadezeit:'
      end
      object Label9: TLabel
        Left = 8
        Top = 140
        Width = 46
        Height = 13
        Caption = 'Delayzeit:'
      end
      object channeltype: TComboBox
        Left = 8
        Top = 72
        Width = 129
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = channeltypeChange
      end
      object delayedit: TJvSpinEdit
        Left = 8
        Top = 152
        Width = 49
        Height = 21
        Hint = 'Delayzeit in Millisekunden (kleiner 0 = Zufall)'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = delayeditChange
      end
      object fadetimeedit: TJvSpinEdit
        Left = 64
        Top = 152
        Width = 41
        Height = 21
        Hint = 'Fadezeit in Millisekunden (-1 = Szenenzeit, unter -1 = Zufall)'
        Value = -1.000000000000000000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = fadetimeeditChange
      end
      object dimmerslider: TTrackBar
        Left = 3
        Top = 112
        Width = 137
        Height = 22
        Hint = 'Kanalwert'
        Max = 255
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TickStyle = tsNone
        OnChange = dimmersliderChange
      end
      object useonlyrgb: TCheckBox
        Left = 8
        Top = 33
        Width = 129
        Height = 17
        Hint = 'Aktiviert die RGB-Kontrollen'
        Caption = 'Verwende RGB'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnMouseUp = useonlyrgbMouseUp
      end
      object chanactive: TCheckBox
        Left = 8
        Top = 16
        Width = 129
        Height = 17
        Hint = 'Aktiviert den selektierten Kanal'
        Caption = 'Kanal aktiviert'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnMouseUp = chanactiveMouseUp
      end
      object colorpicker: THSLColorPicker
        Left = 7
        Top = 176
        Width = 154
        Height = 137
        SelectedColor = 240
        HSPickerHintFormat = 'R: %r G: %g B: %b, Hex: %hex'
        LPickerHintFormat = 'Luminance: %l'
        HSPickerCursor = crCross
        LPickerCursor = crCross
        ShowHint = False
        ParentShowHint = False
        TabOrder = 6
        OnChange = colorpickerChange
        DesignSize = (
          154
          137)
      end
      object ColorPicker2: TJvOfficeColorPanel
        Left = 8
        Top = 178
        Width = 152
        Height = 133
        SelectedColor = clDefault
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 7
        Visible = False
        Properties.ShowDefaultColor = False
        Properties.NoneColorCaption = 'No Color'
        Properties.DefaultColorCaption = 'Automatic'
        Properties.CustomColorCaption = 'Andere Farben...'
        Properties.NoneColorHint = 'No Color'
        Properties.DefaultColorHint = 'Automatic'
        Properties.CustomColorHint = 'Other Colors...'
        Properties.NoneColorFont.Charset = DEFAULT_CHARSET
        Properties.NoneColorFont.Color = clWindowText
        Properties.NoneColorFont.Height = -11
        Properties.NoneColorFont.Name = 'MS Sans Serif'
        Properties.NoneColorFont.Style = []
        Properties.DefaultColorFont.Charset = DEFAULT_CHARSET
        Properties.DefaultColorFont.Color = clWindowText
        Properties.DefaultColorFont.Height = -11
        Properties.DefaultColorFont.Name = 'MS Sans Serif'
        Properties.DefaultColorFont.Style = []
        Properties.CustomColorFont.Charset = DEFAULT_CHARSET
        Properties.CustomColorFont.Color = clWindowText
        Properties.CustomColorFont.Height = -11
        Properties.CustomColorFont.Name = 'MS Sans Serif'
        Properties.CustomColorFont.Style = []
        OnColorChange = ColorPicker2ColorChange
      end
      object Button2: TButton
        Left = 104
        Top = 152
        Width = 57
        Height = 19
        Caption = 'Wechsel'
        TabOrder = 8
        OnClick = Button2Click
      end
    end
    object colcount: TJvSpinEdit
      Left = 80
      Top = 24
      Width = 65
      Height = 21
      MaxValue = 256.000000000000000000
      MinValue = 2.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 3
      OnChange = colcountChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 484
    Width = 746
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 169
      Height = 57
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object okbtn: TButton
        Left = 8
        Top = 23
        Width = 73
        Height = 25
        Caption = 'OK'
        TabOrder = 0
        OnClick = okbtnClick
      end
      object previewtodevices: TCheckBox
        Left = 8
        Top = 6
        Width = 153
        Height = 17
        Caption = #196'nderung auf Ger'#228'ten'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cancelbtn: TButton
        Left = 88
        Top = 23
        Width = 73
        Height = 25
        Caption = 'Abbrechen'
        ModalResult = 2
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 169
      Top = 0
      Width = 577
      Height = 57
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Label12: TLabel
        Left = 320
        Top = 9
        Width = 81
        Height = 13
        Caption = 'Geschwindigkeit:'
      end
      object Label11: TLabel
        Left = 413
        Top = 9
        Width = 46
        Height = 13
        Caption = 'Blendzeit:'
      end
      object Label4: TLabel
        Left = 0
        Top = 8
        Width = 45
        Height = 13
        Caption = 'Zeitleiste:'
      end
      object Label14: TLabel
        Left = 256
        Top = 8
        Width = 58
        Height = 13
        Caption = 'Szenenzahl:'
      end
      object NewMatrixBtn: TSpeedButton
        Left = 467
        Top = 29
        Width = 29
        Height = 25
        Hint = 'Neue Matrix...'
        Glyph.Data = {
          2E020000424D2E0200000000000036000000280000000B0000000E0000000100
          180000000000F801000000000000000000000000000000000000B0A090604830
          604830604830604830604830604830604830604830604830604830000000B0A0
          90FFFFFFB0A090B0A090B0A090B0A090B0A090B0A090B0A090B0A09060483000
          0000B0A090FFFFFFFFFFFFFFF8FFF0F0F0F0E8E0F0E0D0E0D0D0E0C8C0B0A090
          604830000000B0A090FFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E0E0F0D8D0E0D0
          C0B0A090604830000000B0A090FFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0E8E0F0
          E0E0E0D8D0B0A090604830000000C0A890FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0
          F0F0F0F0E8E0F0D8D0B0A090604830000000C0A8A0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF8F0F0E8E0F0E0E0B0A090604830000000C0B0A0FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF8FFF0F0F0F0E8E0B0A090604830000000D0B0A0FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0B0A090604830000000D0B8
          A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A090B0A09060483000
          0000D0B8B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A090604830604830
          604830000000D0C0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0A890D0C8
          C0604830E0CBC2000000E0C0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          A8A0604830E0CCC3F6F1F1000000E0C0B0E0C0B0E0C0B0E0C0B0E0C0B0D0C0B0
          D0B8B0D0B0A0E0CCC3F7F2F2F7F2F2000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = NewMatrixBtnClick
      end
      object OpenMatrixBtn: TSpeedButton
        Left = 499
        Top = 29
        Width = 29
        Height = 25
        Hint = 'Matrix importieren...'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCD0D0D0D0D0D0D0D0D0D0D0D0D0
          D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0DCDCDCFFFFFFFFFFFFFFFFFFC4C4C4
          8888887070707070707070707070707070707070707070707070707070707070
          70888888C4C4C4FFFFFFDCDCDC0C72A50C72A50C72A50C72A50C72A50C72A50C
          72A50C72A50C72A50C72A50C72A50C72A5646464888888DCDCDC189AC61B9CC7
          9CFFFF6BD7FF6BD7FF6BD7FF6BD7FF6BD7FF6BD7FF6BD7FF6BD7FF6BD7FF2899
          BF0C72A5707070D0D0D0189AC6199AC679E4F09CFFFF7BE3FF7BE3FF7BE3FF7B
          E3FF7BE3FF7BE3FF7BE3FF7BDFFF42B2DE197A9D646464B8B8B8189AC625A2CF
          3FB8D79CFFFF84EBFF84EBFF84EBFF84EBFF84EBFF84EBFF84EBFF84E7FF42BA
          EF189AC6646464888888189AC642B3E220A0C9A5FFFF94F7FF94F7FF94F7FF94
          F7FF94F7FF94F7FF94F7FF94F7FF52BEE75BBCCE0C72A5707070189AC66FD5FD
          189AC689F0F79CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF5AC7
          FF96F9FB187A9B707070189AC684D7FF189AC66BBFDAFFFFFFFFFFFFF7FBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF84E7FFFFFFFF187DA1888888189AC684EBFF
          4FC1E2189AC6189AC6189AC6189AC6189AC6189AC6189AC6189AC6189AC6189A
          C6189AC61889B1C4C4C4189AC69CF3FF8CF3FF8CF3FF8CF3FF8CF3FF8CF3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF189AC6197A9DC4C4C4FFFFFF189AC6FFFFFF
          9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF189AC6189AC6189AC6189AC6189AC6189A
          C6DCDCDCFFFFFFFFFFFFFFFFFF21A2CEFFFFFFFFFFFFFFFFFFFFFFFF189AC6C4
          C4C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          21A2CE21A2CE21A2CE21A2CEDCDCDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = OpenMatrixBtnClick
      end
      object SaveMatrixBtn: TSpeedButton
        Left = 531
        Top = 29
        Width = 29
        Height = 25
        Hint = 'Matrix exportieren...'
        Glyph.Data = {
          9E020000424D9E0200000000000036000000280000000E0000000E0000000100
          1800000000006802000000000000000000000000000000000000E4BBBEC06860
          B05850A05050A05050A050509048509048409048408040408038408038407038
          407038300000D06870F09090E08080B04820403020C0B8B0C0B8B0D0C0C0D0C8
          C0505050A04030A04030A038307038400000D07070FF98A0F08880E080807058
          50404030907870F0E0E0F0E8E0908070A04030A04040A040308038400000D078
          70FFA0A0F09090F08880705850000000404030F0D8D0F0E0D0807860B04840B0
          4840A040408040400000D07880FFA8B0FFA0A0F0909070585070585070585070
          5850706050806860C05850B05050B048408040400000E08080FFB0B0FFB0B0FF
          A0A0F09090F08880E08080E07880D07070D06870C06060C05850B05050904840
          0000E08890FFB8C0FFB8B0D06060C06050C05850C05040B05030B04830A04020
          A03810C06060C058509048400000E09090FFC0C0D06860FFFFFFFFFFFFFFF8F0
          F0F0F0F0E8E0F0D8D0E0D0C0E0C8C0A03810C060609048500000E098A0FFC0C0
          D07070FFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0E0D0C0A04020D068
          60A050500000F0A0A0FFC0C0E07870FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0
          F0F0E8E0F0D8D0B04830D07070A050500000F0A8A0FFC0C0E08080FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0B05030E07880A050500000F0B0
          B0FFC0C0F08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0C0
          5040603030B058500000F0B0B0FFC0C0FF9090FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF8F0C05850B05860B058600000F0B8B0F0B8B0F0B0B0F0
          B0B0F0A8B0F0A0A0E098A0E09090E09090E08890E08080D07880D07870D07070
          0000}
        ParentShowHint = False
        ShowHint = True
        OnClick = SaveMatrixBtnClick
      end
      object hedit: TEdit
        Left = 464
        Top = 6
        Width = 25
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = heditChange
      end
      object TrackBar2: TTrackBar
        Left = 304
        Top = 20
        Width = 105
        Height = 21
        Max = 99
        Position = 75
        TabOrder = 1
        ThumbLength = 16
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = TrackBar2Change
      end
      object stepslider: TScrollBar
        Left = 2
        Top = 24
        Width = 247
        Height = 17
        Max = 3
        PageSize = 0
        TabOrder = 2
        OnChange = stepsliderChange
        OnEnter = stepsliderEnter
      end
      object stepcount: TJvSpinEdit
        Left = 256
        Top = 22
        Width = 47
        Height = 21
        MaxValue = 256.000000000000000000
        MinValue = 1.000000000000000000
        Value = 4.000000000000000000
        MaxLength = 512
        TabOrder = 3
        OnChange = stepcountChange
      end
      object sedit: TEdit
        Left = 512
        Top = 6
        Width = 25
        Height = 21
        TabOrder = 4
        Text = '0'
        OnChange = heditChange
      end
      object msedit: TEdit
        Left = 536
        Top = 6
        Width = 25
        Height = 21
        TabOrder = 5
        Text = '0'
        OnChange = heditChange
      end
      object minedit: TEdit
        Left = 488
        Top = 6
        Width = 25
        Height = 21
        TabOrder = 6
        Text = '0'
        OnChange = heditChange
      end
      object CheckBox1: TCheckBox
        Left = 312
        Top = 40
        Width = 97
        Height = 17
        Caption = 'Vorschau'
        TabOrder = 7
        OnMouseUp = CheckBox1MouseUp
      end
    end
  end
  object drawtimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = drawtimerTimer
    Left = 8
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.PngImageList1
    Left = 40
    Top = 8
    object AlleKanleaktivieren1: TMenuItem
      Caption = 'Alle Kan'#228'le aktivieren'
      ImageIndex = 75
      OnClick = AlleKanleaktivieren1Click
    end
    object AlleKanledeaktivieren1: TMenuItem
      Caption = 'Alle Kan'#228'le deaktivieren'
      ImageIndex = 74
      OnClick = AlleKanledeaktivieren1Click
    end
    object AlleGerteselektieren1: TMenuItem
      Caption = 'Alle Ger'#228'te selektieren'
      ImageIndex = 75
      OnClick = AlleGerteselektieren1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object AlleKanleaufRGBschalten1: TMenuItem
      Caption = 'Alle Kan'#228'le auf RGB-Modus schalten'
      ImageIndex = 67
      OnClick = AlleKanleaufRGBschalten1Click
    end
    object AlleKanleaufNormalschalten1: TMenuItem
      Caption = 'Alle Kan'#228'le auf Normal-Modus schalten'
      ImageIndex = 15
      OnClick = AlleKanleaufNormalschalten1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object AlleKanleBlackout1: TMenuItem
      Caption = 'Alle Kan'#228'le Blackout'
      ImageIndex = 62
      OnClick = AlleKanleBlackout1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object AlleDelayzeitenzurcksetzen1: TMenuItem
      Caption = 'Alle Delayzeiten zur'#252'cksetzen'
      OnClick = AlleDelayzeitenzurcksetzen1Click
    end
    object AlleFadezeitenzurcksetzen1: TMenuItem
      Caption = 'Alle Fadezeiten zur'#252'cksetzen'
      OnClick = AlleFadezeitenzurcksetzen1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 8
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.pcdmtrx'
    Filter = 'PC_DIMMER Matrix (*.pcdmtrx)|*.pcdmtrx|Alle Dateien (*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 344
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.pcdmtrx'
    Filter = 'PC_DIMMER Effekte (*.pcdmtrx)|*.pcdmtrx|Alle Dateien (*.*)|*.*'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 376
    Top = 8
  end
end
