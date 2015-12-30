object lauflichtassistentownpatternform: Tlauflichtassistentownpatternform
  Left = 253
  Top = 239
  Width = 754
  Height = 666
  Caption = 'Eigenes Lauflicht erstellen'
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
    Width = 552
    Height = 538
    Hint = 'Rechte Maustaste f'#252'r Men'#252
    Align = alClient
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
  end
  object Panel1: TPanel
    Left = 552
    Top = 0
    Width = 186
    Height = 538
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 63
      Height = 13
      Caption = 'Zeilenanzahl:'
    end
    object rowcount: TJvSpinEdit
      Left = 80
      Top = 8
      Width = 73
      Height = 21
      CheckMaxValue = False
      MinValue = 2.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 0
      OnChange = rowcountChange
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 448
      Width = 169
      Height = 97
      Caption = ' Ger'#228'tedetails '
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object devicename: TLabel
        Left = 56
        Top = 24
        Width = 9
        Height = 13
        Caption = '...'
      end
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
        Left = 56
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
      object Label13: TLabel
        Left = 88
        Top = 56
        Width = 33
        Height = 13
        Caption = 'Amber:'
      end
      object hasamber: TLabel
        Left = 136
        Top = 56
        Width = 9
        Height = 13
        Caption = '...'
      end
      object Label15: TLabel
        Left = 88
        Top = 72
        Width = 25
        Height = 13
        Caption = 'Wei'#223
      end
      object haswhite: TLabel
        Left = 136
        Top = 72
        Width = 9
        Height = 13
        Caption = '...'
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 32
      Width = 169
      Height = 409
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
        Left = 56
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
      object Label14: TLabel
        Left = 8
        Top = 321
        Width = 33
        Height = 13
        Caption = 'Amber:'
      end
      object Label16: TLabel
        Left = 8
        Top = 361
        Width = 28
        Height = 13
        Caption = 'Wei'#223':'
      end
      object ColorPicker: THSLColorPicker
        Left = 8
        Top = 176
        Width = 153
        Height = 137
        SelectedColor = 240
        HSPickerHintFormat = 'R: %r G: %g B: %b, Hex: %hex'
        LPickerHintFormat = 'Luminance: %l'
        HSPickerCursor = crCross
        LPickerCursor = crCross
        ShowHint = False
        ParentShowHint = False
        Visible = False
        TabOrder = 6
        OnChange = ColorPickerChange
        DesignSize = (
          153
          137)
      end
      object channeltype: TComboBox
        Left = 8
        Top = 72
        Width = 153
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
        Hint = 'Delayzeit in Millisekunden'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = delayeditChange
      end
      object fadetimeedit: TJvSpinEdit
        Left = 56
        Top = 152
        Width = 49
        Height = 21
        Hint = 'Fadezeit in Millisekunden'
        Value = -1.000000000000000000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = fadetimeeditChange
      end
      object dimmerslider: TTrackBar
        Left = 3
        Top = 112
        Width = 158
        Height = 25
        Hint = 'Kanalwert'
        Max = 255
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TickStyle = tsManual
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
      object Button1: TButton
        Left = 64
        Top = 53
        Width = 95
        Height = 17
        Caption = 'Dimmer @ 100%'
        TabOrder = 7
        OnClick = Button1Click
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
        TabOrder = 8
        OnMouseUp = ColorPicker2MouseUp
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
      end
      object Button2: TButton
        Left = 104
        Top = 152
        Width = 57
        Height = 19
        Caption = 'Wechsel'
        TabOrder = 9
        OnClick = Button2Click
      end
      object amberslider: TTrackBar
        Left = 3
        Top = 336
        Width = 158
        Height = 25
        Hint = 'Kanalwert'
        Max = 255
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        TickStyle = tsManual
        OnChange = ambersliderChange
      end
      object whiteslider: TTrackBar
        Left = 3
        Top = 376
        Width = 158
        Height = 25
        Hint = 'Kanalwert'
        Max = 255
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        TickStyle = tsManual
        OnChange = whitesliderChange
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 538
    Width = 738
    Height = 89
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 169
      Height = 89
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object okbtn: TButton
        Left = 8
        Top = 56
        Width = 153
        Height = 25
        Caption = 'OK'
        ModalResult = 1
        TabOrder = 0
      end
      object previewtodevices: TCheckBox
        Left = 8
        Top = 8
        Width = 153
        Height = 17
        Caption = 'Anzeige auf Ger'#228'ten'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnMouseUp = previewtodevicesMouseUp
      end
    end
    object Panel4: TPanel
      Left = 169
      Top = 0
      Width = 569
      Height = 89
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PaintBox2: TPaintBox
        Left = 0
        Top = 33
        Width = 569
        Height = 56
        Align = alClient
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label11: TLabel
          Left = 413
          Top = 9
          Width = 46
          Height = 13
          Caption = 'Blendzeit:'
        end
        object Label12: TLabel
          Left = 208
          Top = 9
          Width = 81
          Height = 13
          Caption = 'Geschwindigkeit:'
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
        object minedit: TEdit
          Left = 488
          Top = 6
          Width = 25
          Height = 21
          TabOrder = 1
          Text = '0'
          OnChange = heditChange
        end
        object sedit: TEdit
          Left = 512
          Top = 6
          Width = 25
          Height = 21
          TabOrder = 2
          Text = '0'
          OnChange = heditChange
        end
        object msedit: TEdit
          Left = 536
          Top = 6
          Width = 25
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = heditChange
        end
        object TrackBar2: TTrackBar
          Left = 296
          Top = 4
          Width = 105
          Height = 25
          Max = 99
          Position = 75
          TabOrder = 4
          ThumbLength = 16
          TickMarks = tmBoth
          TickStyle = tsNone
          OnChange = TrackBar2Change
        end
        object showanimation: TCheckBox
          Left = 0
          Top = 8
          Width = 185
          Height = 17
          Caption = 'Zeige Animation'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnMouseUp = showanimationMouseUp
        end
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
    object N4: TMenuItem
      Caption = '-'
    end
    object AlleKanleselektieren1: TMenuItem
      Caption = 'Alle Kan'#228'le selektieren'
      ImageIndex = 75
      OnClick = AlleKanleselektieren1Click
    end
    object Diagonalselektieren1: TMenuItem
      Caption = 'Diagonal selektieren'
      ImageIndex = 75
      OnClick = Diagonalselektieren1Click
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
end
