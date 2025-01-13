object OptionenBox: TOptionenBox
  Left = 788
  Top = 140
  BorderStyle = bsSingle
  Caption = 'Erweiterte Einstellungen'
  ClientHeight = 457
  ClientWidth = 576
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000130B0000130B000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000040305180C1E346A0C1C2F6B0201011E000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000070A112A1760A1D61396F6FF1292F2FF165287CF0303051E0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000060A132A1A6EACDD16ACFFFF16ADFFFF0C9FFFFF159CF9FF0D21346C0000
    000000000000000000000000000000000000000000000000000000000000060B
    14281F7AB1DD2DD4FFFF1CB3FFFF0C96FFFF0B99FFFF1CACFFFF0E273C6B0000
    0000000000000000000000000000000000000000000000000000060B15252180
    B4D82DD4FFFF34DBFFFE26C2FFFE1CB2FFFE1FBCFFFF1F7AB0D904070C1A0000
    00000000000000000000000000000000000000000000051420292288BAD827CA
    FFFF27C4FFFF26C2FFFF25C1FEFF25C8FFFF2389BCDD070F192A000000000000
    000000000000000000000000000000000000000000001F4D6D9523BDFCFF16AC
    FDFF19ADFFFF17AAFEFF21BFFFFF2590C0DD07101A2A00000000000000000000
    00000000000005010117302424663F32328136292978A59292E477B8DAFF14A7
    EDFF0A93F9FF1DB7FFFF2899C5DD07111D2A0000000000000000000000000000
    00001E1717399A8787DDD3C4C4FFD7CACAFFD3C5C5FFDCCFCDFFD8C9C9FF75B9
    DAFF26C2FCFF2AA0CADD07131F2A000000000000000000000000000000001613
    1311A29292DCF3ECECFFEDE8E8FFE7E1E1FFE7E2E2FFDFD7D7FFD6C8C7FF9584
    85CE1F5C7B8A071A282C00000000000000000000000000000000000000005148
    484FF0E8E8FFD8CFCFFAB2A4A4E5F2EDEDFFEEEAEAFFF0ECECFFE4DBDBFF372C
    2B6B000000000000000000000000000000000000000000000000000000006962
    6268ECE2E2FF473E3E661B14141FB5A8A8D0F9F6F6FFF8F6F6FFF7F2F2FF554D
    4D84000000000000000000000000000000000000000000000000000000005049
    493F5148486D00000000000000001F171728D8CFCFF2FFFFFFFFFDF9F9FF433C
    3C69000000000000000000000000000000000000000000000000000000000000
    00000000000000000000030202098A8383A4F9F8F8FDFFFFFFFFC8C0C0E40D0B
    0B1A000000000000000000000000000000000000000000000000000000000000
    0000000000000F0E0E05908888ABFFFFFFFFFFFFFFFFCBC6C6DB2E2A2A3E0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000242222026B676749736F6F626560605215131311000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFE10000FFC10000FF810000FF010000FE030000FC070000F40F0000C01F
    0000803F000080FF0000B07F0000F8FF0000F0FF0000E1FFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label60: TLabel
    Left = 8
    Top = 56
    Width = 48
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Ausgabe'
    Transparent = True
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 67
    Width = 576
    Height = 350
    Align = alClient
    PageIndex = 3
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Ausgabeplugins'
      object Plugingrid: TStringGrid
        Left = 8
        Top = 48
        Width = 560
        Height = 256
        Align = alClient
        ColCount = 7
        DefaultColWidth = 70
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 0
        OnDblClick = PlugingridDblClick
        OnDrawCell = PlugingridDrawCell
        OnGetEditMask = PlugingridGetEditMask
        OnGetEditText = PlugingridGetEditText
        OnKeyPress = PlugingridKeyPress
        OnKeyUp = PlugingridKeyUp
        OnMouseUp = PlugingridMouseUp
        ColWidths = (
          17
          223
          37
          40
          42
          155
          18)
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 576
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label10: TLabel
          Left = 16
          Top = 8
          Width = 226
          Height = 16
          Caption = 'Ausgabeplugins f'#252'r PC_DIMMER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 48
          Top = 32
          Width = 65
          Height = 13
          Caption = 'Beschreibung'
        end
        object Label12: TLabel
          Left = 290
          Top = 32
          Width = 22
          Height = 13
          Caption = 'Start'
        end
        object Label16: TLabel
          Left = 8
          Top = 32
          Width = 30
          Height = 13
          Caption = 'Status'
        end
        object Label26: TLabel
          Left = 331
          Top = 32
          Width = 22
          Height = 13
          Caption = 'Stop'
        end
        object Label46: TLabel
          Left = 374
          Top = 32
          Width = 51
          Height = 13
          Caption = 'Dateiname'
        end
        object Label47: TLabel
          Left = 515
          Top = 32
          Width = 56
          Height = 13
          Caption = 'Ausblenden'
        end
        object Label34: TLabel
          Left = 251
          Top = 32
          Width = 35
          Height = 13
          Caption = 'Version'
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 304
        Width = 576
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object Label48: TLabel
          Left = 336
          Top = 0
          Width = 225
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Einige Plugins wurden ausgeblendet...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          WordWrap = True
        end
        object pluginconfigure: TButton
          Left = 8
          Top = 8
          Width = 80
          Height = 25
          Caption = 'Konfigurieren'
          Enabled = False
          TabOrder = 0
          OnClick = pluginconfigureClick
        end
        object pluginabout: TButton
          Left = 96
          Top = 8
          Width = 80
          Height = 25
          Caption = 'Info'
          Enabled = False
          TabOrder = 1
          OnClick = pluginaboutClick
        end
        object Button2: TButton
          Left = 344
          Top = 16
          Width = 219
          Height = 25
          Caption = 'Alle Plugins bei n'#228'chstem Start laden'
          TabOrder = 2
          Visible = False
          OnClick = Button2Click
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 48
        Width = 8
        Height = 256
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object Panel6: TPanel
        Left = 568
        Top = 48
        Width = 8
        Height = 256
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 4
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Startup'
      object Label2: TLabel
        Left = 16
        Top = 8
        Width = 198
        Height = 16
        Caption = 'Verhalten beim Startvorgang'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label87: TLabel
        Left = 16
        Top = 104
        Width = 193
        Height = 13
        Caption = 'Folgenden Nutzer beim Start verwenden:'
      end
      object startupwitholdscene_checkbox: TCheckBox
        Left = 16
        Top = 52
        Width = 233
        Height = 17
        Caption = 'Letzte Kanalwerte wiederherstellen'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object powerswitch_checkbox: TCheckBox
        Left = 16
        Top = 72
        Width = 233
        Height = 17
        Caption = 'Computer-Ein-/Ausschalter deaktivieren'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object showlastplugins_checkbox: TCheckBox
        Left = 16
        Top = 32
        Width = 233
        Height = 17
        Caption = 'Aktiviere zuletzt genutzte Plugins'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object CheckUpdatesOnStartup: TCheckBox
        Left = 256
        Top = 28
        Width = 233
        Height = 17
        Caption = 'Online nach Updates suchen'
        Checked = True
        State = cbChecked
        TabOrder = 3
        Visible = False
      end
      object startupuseredit: TComboBox
        Left = 16
        Top = 124
        Width = 209
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = 'Admin'
        Items.Strings = (
          'Admin')
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Hardware'
      object Label3: TLabel
        Left = 16
        Top = 8
        Width = 160
        Height = 16
        Caption = 'Hardwareeinstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox5: TGroupBox
        Left = 16
        Top = 32
        Width = 305
        Height = 113
        Caption = ' Kanaleinstellungen '
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 24
          Width = 224
          Height = 13
          Caption = 'Maximal verwendeter Kanal (Anzahl Universes):'
        end
        object Label6: TLabel
          Left = 14
          Top = 72
          Width = 12
          Height = 13
          Caption = '32'
        end
        object Label7: TLabel
          Left = 226
          Top = 72
          Width = 24
          Height = 13
          Caption = '8192'
        end
        object Label8: TLabel
          Left = 59
          Top = 72
          Width = 24
          Height = 13
          Caption = '2048'
        end
        object Label17: TLabel
          Left = 117
          Top = 71
          Width = 24
          Height = 13
          Caption = '4096'
        end
        object Label18: TLabel
          Left = 170
          Top = 72
          Width = 24
          Height = 13
          Caption = '6144'
        end
        object Label28: TLabel
          Left = 232
          Top = 88
          Width = 12
          Height = 13
          Caption = '16'
        end
        object Label29: TLabel
          Left = 176
          Top = 88
          Width = 12
          Height = 13
          Caption = '12'
        end
        object Label30: TLabel
          Left = 126
          Top = 88
          Width = 6
          Height = 13
          Caption = '8'
        end
        object Label31: TLabel
          Left = 68
          Top = 88
          Width = 6
          Height = 13
          Caption = '4'
        end
        object Label32: TLabel
          Left = 29
          Top = 88
          Width = 6
          Height = 13
          Caption = '1'
        end
        object Label33: TLabel
          Left = 248
          Top = 24
          Width = 42
          Height = 13
          Caption = 'Eingabe:'
        end
        object lastchan: TTrackBar
          Left = 8
          Top = 40
          Width = 241
          Height = 25
          Max = 8192
          Min = 32
          Position = 512
          TabOrder = 0
          TickStyle = tsManual
          OnChange = lastchanChange
        end
        object lastchan_edit: TEdit
          Left = 256
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 1
          Text = '8192'
          OnKeyUp = lastchan_editKeyUp
        end
      end
      object GroupBox6: TGroupBox
        Left = 16
        Top = 152
        Width = 305
        Height = 81
        Caption = ' Priorit'#228't des Hauptprogrammthreads '
        TabOrder = 1
        object prioritaet_label: TLabel
          Left = 264
          Top = 12
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Normal'
        end
        object Label19: TLabel
          Left = 111
          Top = 56
          Width = 33
          Height = 13
          Caption = 'Normal'
        end
        object Label20: TLabel
          Left = 52
          Top = 56
          Width = 42
          Height = 13
          Caption = 'Niedriger'
        end
        object Label21: TLabel
          Left = 214
          Top = 56
          Width = 26
          Height = 13
          Caption = 'Hoch'
        end
        object Label22: TLabel
          Left = 164
          Top = 56
          Width = 29
          Height = 13
          Caption = 'H'#246'her'
        end
        object Label54: TLabel
          Left = 3
          Top = 56
          Width = 38
          Height = 13
          Caption = 'Leerlauf'
        end
        object Label55: TLabel
          Left = 261
          Top = 56
          Width = 38
          Height = 13
          Caption = 'Echtzeit'
        end
        object prioritaet: TTrackBar
          Left = 8
          Top = 24
          Width = 281
          Height = 33
          Hint = 'Prozesspriorit'#228't des PC_DIMMERs ver'#228'ndern'
          Max = 5
          ParentShowHint = False
          PageSize = 1
          Position = 2
          ShowHint = True
          TabOrder = 0
          OnChange = prioritaetChange
        end
      end
      object GroupBox12: TGroupBox
        Left = 328
        Top = 152
        Width = 225
        Height = 81
        Caption = ' MIDI Backtrack '
        TabOrder = 2
        object Label53: TLabel
          Left = 8
          Top = 24
          Width = 182
          Height = 13
          Caption = 'Interval f'#252'r Backtrack zum MIDI-Ger'#228't:'
        end
        object Label57: TLabel
          Left = 75
          Top = 44
          Width = 102
          Height = 13
          Caption = 'ms (Standard=150ms)'
        end
        object midibacktrackintervaledit: TJvSpinEdit
          Left = 8
          Top = 40
          Width = 65
          Height = 21
          MaxValue = 5000.000000000000000000
          MinValue = 15.000000000000000000
          Value = 150.000000000000000000
          TabOrder = 0
        end
      end
      object GroupBox13: TGroupBox
        Left = 328
        Top = 32
        Width = 225
        Height = 113
        Caption = ' Dimmerkernel-Einstellungen '
        TabOrder = 3
        object Label56: TLabel
          Left = 8
          Top = 24
          Width = 186
          Height = 13
          Caption = 'Minimale Aufl'#246'sung des Dimmerkernels:'
        end
        object Label58: TLabel
          Left = 75
          Top = 44
          Width = 96
          Height = 13
          Caption = 'ms (Standard=20ms)'
        end
        object Label59: TLabel
          Left = 8
          Top = 64
          Width = 196
          Height = 13
          Caption = '1ms=beste Qualit'#228't, 50ms=beste Leistung'
        end
        object dimmerkernelresolutionedit: TJvSpinEdit
          Left = 8
          Top = 40
          Width = 65
          Height = 21
          MaxValue = 5000.000000000000000000
          MinValue = 1.000000000000000000
          Value = 20.000000000000000000
          TabOrder = 0
        end
        object dimmerkernelresolutioncheck: TCheckBox
          Left = 8
          Top = 88
          Width = 209
          Height = 17
          Caption = 'Aufl'#246'sung automatisch anpassen'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Allgemein'
      object Label9: TLabel
        Left = 16
        Top = 8
        Width = 176
        Height = 16
        Caption = 'Allgemeine Einstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 16
        Top = 324
        Width = 213
        Height = 13
        Caption = 'Minimale Helligkeit bei Bildschirmabdunklung:'
        Visible = False
      end
      object Label39: TLabel
        Left = 266
        Top = 325
        Width = 8
        Height = 13
        Caption = '%'
        Visible = False
      end
      object levelanzeigeoptionen: TRadioGroup
        Left = 16
        Top = 200
        Width = 265
        Height = 113
        Caption = 'Darstellung der Faderlevel im Faderbereich '
        ItemIndex = 0
        Items.Strings = (
          'Prozentanzeige (0%...50%...100%)'
          'Prozentanzeige (0.0%...50.0%...100.0%)'
          'Byteanzeige (0...127...255)'
          'Hexdezimalanzeige (0..7F..FF)'
          'Prozent- und Byteanzeige (50%/128)')
        TabOrder = 0
      end
      object askforsaveproject_checkbox: TCheckBox
        Left = 16
        Top = 32
        Width = 233
        Height = 17
        Caption = 'Speichern des Projektes best'#228'tigen'
        TabOrder = 1
      end
      object bildschirmhelligkeit: TEdit
        Left = 232
        Top = 320
        Width = 33
        Height = 21
        Hint = '[%]'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = '10'
        Visible = False
        OnChange = bildschirmhelligkeitChange
      end
      object scrolllockled_checkbox: TCheckBox
        Left = 16
        Top = 48
        Width = 233
        Height = 17
        Caption = 'Scroll-Lock LED bei Beat blinken lassen'
        TabOrder = 3
      end
      object showaccuwarnings: TCheckBox
        Left = 16
        Top = 64
        Width = 233
        Height = 17
        Caption = 'Akkuwarnmeldungen anzeigen'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object BlendOutFormsCheckbox: TCheckBox
        Left = 16
        Top = 112
        Width = 193
        Height = 17
        Caption = 'Fenster im Hintergrund transparent'
        TabOrder = 6
      end
      object Button1: TButton
        Left = 32
        Top = 80
        Width = 249
        Height = 25
        Caption = 'Akkuanzeige testen'
        TabOrder = 5
        OnClick = Button1Click
      end
      object GroupBox14: TGroupBox
        Left = 288
        Top = 8
        Width = 281
        Height = 305
        Caption = ' Aktualisierungsraten einzelner Programmteile '
        TabOrder = 7
        object Label35: TLabel
          Left = 9
          Top = 23
          Width = 189
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Hauptprogramm (Universumsanzeige):'
          WordWrap = True
        end
        object Label61: TLabel
          Left = 8
          Top = 55
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Audioeffektplayer:'
          WordWrap = True
        end
        object Label62: TLabel
          Left = 8
          Top = 87
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Grafische B'#252'hnenansicht (Haupttimer):'
          WordWrap = True
        end
        object Label65: TLabel
          Left = 8
          Top = 119
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Cuelist:'
          WordWrap = True
        end
        object Label66: TLabel
          Left = 8
          Top = 151
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Faderpanel:'
          WordWrap = True
        end
        object Label67: TLabel
          Left = 8
          Top = 183
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Kanal'#252'bersicht:'
          WordWrap = True
        end
        object Label68: TLabel
          Left = 8
          Top = 215
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Kontrollpanel:'
          WordWrap = True
        end
        object Label70: TLabel
          Left = 8
          Top = 247
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Kontrollpanel (Pr'#252'fen ob Button aktiv):'
          WordWrap = True
        end
        object Label71: TLabel
          Left = 8
          Top = 279
          Width = 189
          Height = 15
          Hint = '15'
          Align = alCustom
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Submaster:'
          WordWrap = True
        end
        object Label69: TLabel
          Left = 251
          Top = 23
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label72: TLabel
          Left = 251
          Top = 55
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label73: TLabel
          Left = 251
          Top = 87
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label75: TLabel
          Left = 251
          Top = 119
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label76: TLabel
          Left = 251
          Top = 151
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label77: TLabel
          Left = 251
          Top = 183
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label78: TLabel
          Left = 251
          Top = 215
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label80: TLabel
          Left = 251
          Top = 247
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object Label81: TLabel
          Left = 251
          Top = 279
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object rfr_main: TJvSpinEdit
          Left = 200
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 0
        end
        object rfr_aep: TJvSpinEdit
          Left = 200
          Top = 52
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 100.000000000000000000
          TabOrder = 1
        end
        object rfr_buehnenansicht: TJvSpinEdit
          Left = 200
          Top = 84
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 2
        end
        object rfr_cuelist: TJvSpinEdit
          Left = 200
          Top = 116
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 250.000000000000000000
          TabOrder = 3
        end
        object rfr_faderpanel: TJvSpinEdit
          Left = 200
          Top = 148
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 4
        end
        object rfr_kanaluebersicht: TJvSpinEdit
          Left = 200
          Top = 180
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 5
        end
        object rfr_kontrollpanel: TJvSpinEdit
          Left = 200
          Top = 212
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 6
        end
        object rfr_kontrollpanelcheckforactive: TJvSpinEdit
          Left = 200
          Top = 244
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 250.000000000000000000
          TabOrder = 7
        end
        object rfr_submaster: TJvSpinEdit
          Left = 200
          Top = 276
          Width = 49
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 1.000000000000000000
          Value = 50.000000000000000000
          TabOrder = 8
        end
      end
      object Button3: TButton
        Left = 296
        Top = 318
        Width = 267
        Height = 25
        Caption = 'Aktualisierungsraten auf Standardwerte'
        TabOrder = 8
        OnClick = Button3Click
      end
      object autoambercheckbox: TCheckBox
        Left = 16
        Top = 128
        Width = 265
        Height = 17
        Caption = 'Amber-Kanal automatisch aus RGB berechnen'
        TabOrder = 9
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Soundsystem'
      object Label13: TLabel
        Left = 16
        Top = 8
        Width = 222
        Height = 16
        Caption = 'Einstellungen zum Soundsystem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 16
        Top = 32
        Width = 115
        Height = 13
        Caption = 'Verwendete Soundkarte'
      end
      object sounddevices: TComboBox
        Left = 16
        Top = 48
        Width = 265
        Height = 21
        Hint = 'Soundkarte: '
        Style = csDropDownList
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = sounddevicesChange
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 80
        Width = 265
        Height = 89
        Caption = ' Verwendete Lautsprecher '
        TabOrder = 1
        object frontspeaker: TCheckBox
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Front'
          TabOrder = 0
        end
        object rearspeaker: TCheckBox
          Left = 8
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Rear'
          TabOrder = 1
        end
        object centerlfespeaker: TCheckBox
          Left = 8
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Center / LFE'
          TabOrder = 2
        end
        object backsurroundspeaker: TCheckBox
          Left = 8
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Back Surround'
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 16
        Top = 176
        Width = 265
        Height = 129
        Caption = ' MIDI-Beatsignal '
        TabOrder = 2
        object Label38: TLabel
          Left = 8
          Top = 51
          Width = 51
          Height = 13
          Caption = 'MSG (Ein):'
        end
        object Label40: TLabel
          Left = 8
          Top = 75
          Width = 56
          Height = 13
          Caption = 'Data1 (Ein):'
        end
        object Label41: TLabel
          Left = 8
          Top = 99
          Width = 56
          Height = 13
          Caption = 'Data2 (Ein):'
        end
        object Label42: TLabel
          Left = 112
          Top = 51
          Width = 54
          Height = 13
          Caption = 'MSG (Aus):'
        end
        object Label43: TLabel
          Left = 112
          Top = 75
          Width = 59
          Height = 13
          Caption = 'Data1 (Aus):'
        end
        object Label44: TLabel
          Left = 112
          Top = 99
          Width = 59
          Height = 13
          Caption = 'Data2 (Aus):'
        end
        object mbs_onlineCheckbox: TCheckBox
          Left = 8
          Top = 24
          Width = 161
          Height = 17
          Caption = 'Beatsignal per MIDI senden'
          TabOrder = 0
        end
        object mbs_msgonEdit: TEdit
          Left = 72
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 1
          Text = '144'
          OnKeyUp = OnlyNumbersInTEdit
        end
        object mbs_data1onEdit: TEdit
          Left = 72
          Top = 72
          Width = 33
          Height = 21
          TabOrder = 2
          Text = '64'
          OnKeyUp = OnlyNumbersInTEdit
        end
        object mbs_data2onEdit: TEdit
          Left = 72
          Top = 96
          Width = 33
          Height = 21
          TabOrder = 3
          Text = '127'
          OnKeyUp = OnlyNumbersInTEdit
        end
        object mbs_msgoffEdit: TEdit
          Left = 176
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 4
          Text = '144'
          OnKeyUp = OnlyNumbersInTEdit
        end
        object mbs_data1offEdit: TEdit
          Left = 176
          Top = 72
          Width = 33
          Height = 21
          TabOrder = 5
          Text = '64'
          OnKeyUp = OnlyNumbersInTEdit
        end
        object mbs_data2offEdit: TEdit
          Left = 176
          Top = 96
          Width = 33
          Height = 21
          TabOrder = 6
          Text = '0'
          OnKeyUp = OnlyNumbersInTEdit
        end
      end
      object bassrefreshbtn: TButton
        Left = 288
        Top = 45
        Width = 75
        Height = 25
        Caption = 'Aktualisieren'
        TabOrder = 3
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Programmfunktionen'
      object Label4: TLabel
        Left = 16
        Top = 8
        Width = 142
        Height = 16
        Caption = 'Programmfunktionen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox7: TGroupBox
        Left = 16
        Top = 32
        Width = 529
        Height = 145
        Caption = ' 3D Visualizer '
        TabOrder = 0
        object Label15: TLabel
          Left = 8
          Top = 24
          Width = 307
          Height = 13
          Caption = 
            'Position der MEVP.dll (meist im Installationsordner des Visualiz' +
            'ers)'
        end
        object Label63: TLabel
          Left = 320
          Top = 24
          Width = 201
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'DLL kann nicht gefunden werden!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object mevpdir: TEdit
          Left = 8
          Top = 40
          Width = 473
          Height = 21
          TabOrder = 0
          Text = 'C:\SLEMV\MEVP.dll'
        end
        object PngBitBtn1: TPngBitBtn
          Left = 488
          Top = 39
          Width = 33
          Height = 21
          TabOrder = 1
          OnClick = PngBitBtn1Click
          PngImage.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
            6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
            F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
            561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
            7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
            1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
            01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
            C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
            00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
            00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
            CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
            4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
            48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
            223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
            560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
            2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
            FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
            F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
            4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
            79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
            812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
            0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
            170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
            48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
            90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
            5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
            5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
            8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
            272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
            48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
            6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
            A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
            2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
            1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
            192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
            3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
            09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
            46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
            EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
            4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
            EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
            79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
            3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
            67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
            6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
            A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
            5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
            D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
            743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
            4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
            D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
            C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
            3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
            FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
            0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
            15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
            476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
            BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
            F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
            A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
            6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
            68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
            949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
            F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
            DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
            772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
            A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
            955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
            EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
            CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
            26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
            8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
            B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
            7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
            EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
            E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
            5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
            EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
            EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
            FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
            CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
            ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
            CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
            F73EE77CFEFC2FF784F3FB25D29F330000035A4944415478DA85536B6C145514
            FEEECC6CBBBBD50EFB2869D6A5AD940AC402FE300DC42A69FD01A6221084100A
            040A111B09B11A9BA0318A893158FEF843258241833192A66D8CA5B412A36950
            712161BB5D96F268D94E69B7CBEEB2D3EE63B6F3D8F174358DAFC42FF79B3B73
            E79CEF9E73EE3DACF7AD12E8BA8EBCAE82E719CADC1EBC3F14B39D4FCC1D8580
            FAB22565761B6F0B4B3DD22798C420FE01F6DD512B4C66A9E78B4A6B048B6073
            BB1639DEE9BEE1EB1D52ABC1619D73BDB7B1E5E02EEF40EF85D0F0C7C3BBA061
            E86F02FDC71637D76E6AFD42F47A045EB042E066F0D9B18F7C5D7DD21BE54E2B
            9F03EA2C3B9F6ADFF962ABF395C3072E477AE22F905F6C4120F8EDDEB195CF3D
            FDA8961D9FFF2C0C2561404B73AACB61679CC3C5750C5CC09AB547F86F7E3C8D
            33BBBFDE41869D0B02B7FAB6A5ABEA5695E84AEA0F01022708282E2EC60FA13B
            F8F5D634C298C3330DFB713BE9C789D74F5ECA45B57EBB84B34A06121BE9DE28
            57AD7E5CD4E7D20B02F328B208B81E0EE3D58B23D8B2BB0D8E7215F7AC7E0C5E
            F6635BAE09CBA7FC0F361EEE6B6223E79E952B6B968ABA9A0547FE86AE219FD7
            3047F206F3E081731D4E04FAB1A88187248D614376335EDAD082EE8E667547FB
            600B0B9DAD972B2B2A442515C3AC4231D85C60C5A560760FDC35AB611773084B
            A368FFA9136B4B97E0B54D07918D04B06FCF7BBECE5F8C16163CF384EC7DC42B
            C6670D886BB6A24454C198065E30606A7198790345820599AC0E93A2B43D2CE2
            DAF717D1F4B2EF782C837759E0F35AD9E1768858DC88F26A2B0C3A0D936E103D
            FE3C15567817781E4A2685225347C7F19EC8DB5FCEEC27830176EDF40AF92177
            85E85AF13CEC2C48F9E33FC11807435510BF3B8AED6D3FF75C19335B6939CAAE
            9E5C2A3B6B1AC572EF3220ED274BCB5F9C58210A46D5B5501A8622A3ABEB92D2
            FC41A48DF639453FF3CCF769A55C51774874F053C8E7EE93B1403DC1919B49F9
            EB34EB5052B3882766119D8EE3C3AFC67DDDBFE907C83958D8E4EAA9554A6DC3
            21AB90A43E31F3D0943412891944E329842792B9E0686A3A34AE4CDE99D2C66E
            4E22905111A092CC3755AE2070EE4DCF95EAC7563E199142EAF068361A0A2B93
            1331ED5E68C2BC9E4CE3B66ED2450424A24C4CFDAB3656015514ED7A8322D6F2
            98A0B5BBC4243143D4F13FF81D23196DF617F702D50000000049454E44AE4260
            82}
        end
        object MevpUseThread: TCheckBox
          Left = 8
          Top = 72
          Width = 193
          Height = 17
          Caption = 'Separater Thread f'#252'r 3D-Visualizer'
          Enabled = False
          TabOrder = 2
          OnClick = MevpUseThreadClick
        end
        object GroupBox15: TGroupBox
          Left = 216
          Top = 64
          Width = 305
          Height = 73
          Caption = ' Priorit'#228't des Visualizer-Threads '
          Enabled = False
          TabOrder = 3
          object MevpThreadPriorityLabel: TLabel
            Left = 264
            Top = 12
            Width = 33
            Height = 13
            Alignment = taRightJustify
            Caption = 'Normal'
          end
          object Label74: TLabel
            Left = 111
            Top = 56
            Width = 33
            Height = 13
            Caption = 'Normal'
          end
          object Label79: TLabel
            Left = 52
            Top = 56
            Width = 42
            Height = 13
            Caption = 'Niedriger'
          end
          object Label82: TLabel
            Left = 214
            Top = 56
            Width = 26
            Height = 13
            Caption = 'Hoch'
          end
          object Label83: TLabel
            Left = 164
            Top = 56
            Width = 29
            Height = 13
            Caption = 'H'#246'her'
          end
          object Label84: TLabel
            Left = 3
            Top = 56
            Width = 38
            Height = 13
            Caption = 'Leerlauf'
          end
          object Label85: TLabel
            Left = 261
            Top = 56
            Width = 38
            Height = 13
            Caption = 'Echtzeit'
          end
          object MevpThreadPriority: TTrackBar
            Left = 8
            Top = 24
            Width = 281
            Height = 33
            Hint = 'Prozesspriorit'#228't des PC_DIMMERs ver'#228'ndern'
            Max = 5
            ParentShowHint = False
            PageSize = 1
            Position = 2
            ShowHint = True
            TabOrder = 0
            OnChange = MevpThreadPriorityChange
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 184
        Width = 529
        Height = 58
        Caption = ' Autobackup '
        TabOrder = 1
        object Label24: TLabel
          Left = 14
          Top = 28
          Width = 59
          Height = 13
          Caption = 'Zeitabstand:'
        end
        object Label45: TLabel
          Left = 334
          Top = 32
          Width = 59
          Height = 13
          Caption = 'Dateianzahl:'
        end
        object Autosavelabel: TLabel
          Left = 207
          Top = 28
          Width = 18
          Height = 13
          Caption = 'Aus'
        end
        object Autosavetrackbar: TTrackBar
          Left = 72
          Top = 24
          Width = 129
          Height = 25
          Max = 120
          TabOrder = 0
          TickStyle = tsNone
          OnChange = AutosavetrackbarChange
        end
        object maxautobackupfilesedit: TJvSpinEdit
          Left = 400
          Top = 28
          Width = 113
          Height = 21
          MaxValue = 255.000000000000000000
          MinValue = 5.000000000000000000
          Value = 5.000000000000000000
          TabOrder = 1
        end
      end
      object GroupBox8: TGroupBox
        Left = 16
        Top = 248
        Width = 385
        Height = 89
        Caption = ' Auto-Lock '
        TabOrder = 2
        object Label49: TLabel
          Left = 8
          Top = 24
          Width = 88
          Height = 13
          Caption = 'Zeit bis zur Sperre:'
        end
        object Label50: TLabel
          Left = 120
          Top = 24
          Width = 55
          Height = 13
          Caption = 'Kennwort *:'
        end
        object Label64: TLabel
          Left = 120
          Top = 64
          Width = 201
          Height = 13
          Caption = '* wird auch f'#252'r manuelles Lock verwendet!'
        end
        object autolocktime: TComboBox
          Left = 8
          Top = 40
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Deaktiviert'
          Items.Strings = (
            'Deaktiviert'
            '1min'
            '2min'
            '5min'
            '10min'
            '15min'
            '30min'
            '60min')
        end
        object autolockcode: TEdit
          Left = 120
          Top = 40
          Width = 105
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object GroupBox1: TGroupBox
        Left = 408
        Top = 248
        Width = 137
        Height = 89
        Caption = ' Auto-Logout '
        TabOrder = 3
        object Label36: TLabel
          Left = 8
          Top = 24
          Width = 95
          Height = 13
          Caption = 'Zeit bis zum Logout:'
        end
        object autologouttime: TComboBox
          Left = 8
          Top = 40
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Deaktiviert'
          Items.Strings = (
            'Deaktiviert'
            '1min'
            '2min'
            '5min'
            '10min'
            '15min'
            '30min'
            '60min')
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Fehlerbehandlung'
      object Label27: TLabel
        Left = 16
        Top = 8
        Width = 238
        Height = 16
        Caption = 'Fehlerbehandlung im PC_DIMMER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 32
        Width = 305
        Height = 89
        Caption = ' Optionen (wird bei jedem Start zur'#252'ckgesetzt) '
        ItemIndex = 0
        Items.Strings = (
          'Alle Fehler melden'
          'Nur schwere Fehler melden'
          'Keine Fehler melden (nur Eintrag in Protokolldatei)')
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Netzwerkserver'
      object Label25: TLabel
        Left = 16
        Top = 8
        Width = 156
        Height = 16
        Caption = 'Netzwerkeinstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox9: TGroupBox
        Left = 16
        Top = 32
        Width = 177
        Height = 89
        Caption = ' HTTP-Server '
        TabOrder = 0
        object Label37: TLabel
          Left = 8
          Top = 24
          Width = 96
          Height = 13
          Caption = 'Kennwort f'#252'r Zugriff:'
        end
        object HTTPServerPasswordCheckbox: TCheckBox
          Left = 8
          Top = 64
          Width = 153
          Height = 17
          Caption = 'Kennwortabfrage aktiviert'
          TabOrder = 0
        end
        object HTTPServerPassword: TEdit
          Left = 8
          Top = 40
          Width = 161
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object GroupBox10: TGroupBox
        Left = 200
        Top = 32
        Width = 137
        Height = 89
        Caption = ' Terminalschnittstelle '
        TabOrder = 1
        object Label51: TLabel
          Left = 8
          Top = 24
          Width = 46
          Height = 13
          Caption = 'TCP-Port:'
        end
        object terminalportedit: TJvSpinEdit
          Left = 8
          Top = 40
          Width = 81
          Height = 21
          Value = 10160.000000000000000000
          TabOrder = 0
        end
      end
      object GroupBox11: TGroupBox
        Left = 344
        Top = 32
        Width = 137
        Height = 89
        Caption = ' MediaCenter Timecode '
        TabOrder = 2
        object Label52: TLabel
          Left = 8
          Top = 24
          Width = 46
          Height = 13
          Caption = 'TCP-Port:'
        end
        object mediacenterportedit: TJvSpinEdit
          Left = 8
          Top = 40
          Width = 81
          Height = 21
          Value = 10153.000000000000000000
          TabOrder = 0
        end
      end
      object GroupBox16: TGroupBox
        Left = 16
        Top = 128
        Width = 465
        Height = 73
        Caption = ' MQTT-Broker '
        TabOrder = 3
        object Label88: TLabel
          Left = 8
          Top = 24
          Width = 54
          Height = 13
          Caption = 'IP-Adresse:'
        end
        object Label89: TLabel
          Left = 104
          Top = 24
          Width = 46
          Height = 13
          Caption = 'TCP-Port:'
        end
        object Label90: TLabel
          Left = 192
          Top = 24
          Width = 71
          Height = 13
          Caption = 'Benutzername:'
        end
        object Label91: TLabel
          Left = 336
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Passwort:'
        end
        object MQTTBrokerIP: TEdit
          Left = 8
          Top = 40
          Width = 89
          Height = 21
          TabOrder = 0
          Text = '127.0.0.1'
        end
        object MQTTBrokerPort: TJvSpinEdit
          Left = 104
          Top = 40
          Width = 65
          Height = 21
          Value = 1883.000000000000000000
          TabOrder = 1
        end
        object MQTTBrokerUser: TEdit
          Left = 192
          Top = 40
          Width = 137
          Height = 21
          TabOrder = 2
        end
        object MQTTBrokerPassword: TEdit
          Left = 336
          Top = 40
          Width = 121
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Beenden'
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 171
        Height = 16
        Caption = 'Verhalten beim Beenden'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object deactivateoutputdllsonclose: TCheckBox
        Left = 16
        Top = 48
        Width = 233
        Height = 17
        Caption = 'Ausgabeplugins deaktivieren'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object deactivateinputdllsonclose: TCheckBox
        Left = 16
        Top = 32
        Width = 233
        Height = 17
        Caption = 'Programmplugins deaktivieren'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object switchofflightsatshutdown: TCheckBox
        Left = 16
        Top = 64
        Width = 233
        Height = 17
        Caption = 'Kanalwerte beim Beenden auf 0% setzen'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object QuitWithoutConfirmation: TCheckBox
        Left = 16
        Top = 80
        Width = 233
        Height = 17
        Caption = 'Ohne Nachfragen beenden'
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 417
    Width = 576
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Shape1: TShape
      Left = 0
      Top = -9
      Width = 576
      Height = 49
      Align = alBottom
      Pen.Style = psClear
    end
    object Shape2: TShape
      Left = 0
      Top = 0
      Width = 720
      Height = 1
      Brush.Color = clBlack
    end
    object Label86: TLabel
      Left = 208
      Top = 16
      Width = 355
      Height = 13
      Caption = 
        'Hinweis: Weitere Plugins sind im Unterordner "Plugins\Unused" zu' +
        ' finden...'
      Transparent = True
    end
    object OKBtn: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Abbrechen'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Shape3: TShape
      Left = 0
      Top = 0
      Width = 576
      Height = 66
      Align = alClient
      Pen.Color = clWhite
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape1: TShape
      Left = 64
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape2: TShape
      Left = 128
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape3: TShape
      Left = 192
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape4: TShape
      Left = 256
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape5: TShape
      Left = 320
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape6: TShape
      Left = 384
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape7: TShape
      Left = 448
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape8: TShape
      Left = 512
      Top = -1
      Width = 65
      Height = 68
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionshape0: TShape
      Left = 0
      Top = -1
      Width = 65
      Height = 68
      Brush.Color = 16759214
      Pen.Style = psClear
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel2: TLabel
      Left = 128
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Hardware'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel3: TLabel
      Left = 192
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Allgemein'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel4: TLabel
      Left = 256
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sound'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel5: TLabel
      Left = 320
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sonstiges'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel6: TLabel
      Left = 384
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Fehler'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel7: TLabel
      Left = 448
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Netzwerk'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel8: TLabel
      Left = 512
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Beenden'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel1: TLabel
      Left = 64
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Startup'
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionlabel0: TLabel
      Left = 0
      Top = 51
      Width = 65
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Plugins'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage0: TImage
      Left = 8
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000B1300000B1301009A9C
        1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB51930000105C4944415478DAED5A0970D47596FEFABED377
        A71392CE1D02843B808A208B6EC908BAEB89338EBA0CEB8C3B47E958B86369ED
        CEBAAE537BD54C15AB0E83D4C8A110E510041126102090908B9C74EE4ED247D2
        9D74D2DDE9FBFA77EFFB77325B5B335E8BE0AC55D355AFD274FEF5EFF7BDDFF7
        BEF7BD7FE0A4D3697C935F9C3F03F83380AF08E0BD0F8E82CF3090488508CDCC
        60FDBA0D90C964E072B9B00C5B3062B362E3A67B118BC7E1181D4496900F9198
        8F317724739DC73BC356017ABD1EDD9D5D90CBE5906529E199F6202DE082CB13
        20E4F341ADD6C0373D45D77B515060029F2FC08C6F06DF7EE2B14F4D6CEF3BFB
        65FE99C0B268247A473018284B24E2D3D39EA9D3BBF7EC6EA15FC72952FFEF00
        1CAE3EA272381C77B8C65DDFF67ABC1B3D5E4FAE97AE0986230885E34832A9F4
        B265157BAAAB0FBC42977B29927F1A0026022014201808E2B1AD0FE3CD9D6F55
        0E0C587EE2704D3D9C12C8B5BCA8072EE738A2090691441A09868334970FA453
        E024C2D87CEFBA5FFF6AE7AFFE85004C7EED00BCF4BEA4A4181CBAFF40DFC05D
        C396919FDAEC63F7CD84E30246A8C09AB51B30D45E878EAEEBE08A14740FCA05
        69F0D209887929E4EAB25052680A749ADBB65DBA74F1C2D700804F0066A0D168
        119CF161D0322495CBE4DFB20C0E3F6FB5D9EF8CC49248F38580400EEDBC62E4
        E9643875F263247912F008009B3C1F49487809E46A24282E34C1E7F5C037335D
        7DECF8D1576F39001E4F8868D04F3FF9AA819EBE6DA3A3D61F4F4D4E17C71209
        A48816093645BE0452951195958BD072F5322CAE20C4722504D4A77C260C2927
        8A6CA508F372B3C13049F45FEF86DBEB6EEC3277BF744B0170447C70383C61C3
        E5FABFB7DA1D3F1A738C1963D128940A15DD438A689201C3938227552237BF08
        06B514C7CFB742289143485517230611E3874EC6835E9D8534F580DD66C398C3
        065D8EA1B6F662ED7FDE3200ACC2F8A3A1FC51BBEBBD618B651D5F20409CEEE1
        997661DAE307136720CAD24228D3412655A1B8AC04533E3F1A3AADC8E22729A7
        2064BC3888355067C9A87F53704FB8303E3E46B4E4324299E8ADFAFAFA13371D
        8042A1804AA7437757CFE36D6D6D6F4CB85CDA5038CC9E04845231D49451B64E
        023E4F8CA6AE51383952E4972DC73D0B2B601B77E35C6D3DD49214A4DC283432
        0194323192F4DDD3535398744FC0E7F36045D5CAEBD587DFDF452A74E5A60230
        9372C815727E6F4FEF2FEAEBEA5E9C748D231C8920914C51D584102AD4E04BC4
        902B65A8282B0493E6C34A9468F4C5B065C3263CBE7E1576ED3E80E9B1111894
        12C82402C462518A18981403EBF03024125132964AEEEEE8ECA821004D370500
        91133946239A1A9B349DD7DA8E76B65DDBC0562C1C092118994D80CFE3422A55
        202BBB0029AD916494C1AA0565D06AB5385F7316BE240F3FDAF63D9416E6A1E1
        E225C4A3746A5C3A3589045924C1021A7CF5E77F07B130DD7AF083EABD947C3D
        45DF4D0120E0F1E87A9EFEF0C14347BBDAAEADF3D17D82C110C294448AC0F1D8
        E4A969734D45E0690A1029AC823B3A8160FF35CC9F9703792A899EF616CC2BAA
        C0D6471E058FFAC54FF760A8C96374822192DF71BB1591D08CA7BEB1EE2DA7D3
        7995926FA598FA4A00E4749D9F12758E8DE7B535B51C6F6B6E5C39E17623140A
        D1E88F80358A3C3E0F3AB50A3AD27869C1522817AE45429D8B69A71D7D978E40
        1870204FA58052A9817B72020BCA2B50585C8200E512A7E463E110FC34FCFC33
        9E749C89549FAD397B86A50EC508EB896E0880900038A7A2D4B072D81CCEC52D
        0D4D1FDA2D832522450E8C32111A1A6BD067B1219E8CC3986D84D25000DDC23B
        C02D5B0346ACC1F4502FC69BCE20ED19845C95452A2481A9B0144EC728A2013F
        6EBF6D2DA244BF08251F0A0649B9A6909DA3B9BAFFDDFDD59474338599224891
        BEE1136837DBA4D170E4D7A4F14F9ABBAF73EEBE7B3DF4C63CE46835787BF75B
        A8BBDA4A7E4784C2F2C5285DFF5748E42D459C2F83BBB311E9E146387BEBC161
        E2282CAB448CF49D47D9F8A626682E08B0A8621135B028D33BECD435E61A86DE
        3DB8FF9D4422718D2EEBA070DF981BB50E4249262C120DC89904532D128A36BF
        BBFF104C4BEF82402AC31BAFBE445EC74377E6C054500227A346C2B40AC5556B
        A1140B31D1518F50F719045C4350CA65442F3E1EDFF6B7A8BFDA8CC11E33B89C
        3422F43D3AAD1E8564F8027E3F542AA5E3DCC5B37B272626DA295F16C03845E2
        CBED03160B461D76DCB3F95B884663708CF40A66A6677432956E8F5686FB0251
        B60E09642FBC0DD57BF6E0F5975F240799C23FBFF612557131FAFB87F09BE832
        84C30C0AC75B61BB520D613A04866C44F982C558B0BC8AE457879EEB66D45DA8
        058FCB81404432ABC88251A7855822F67774B7EDE91FE86B9D4BDE4A11FBD20B
        CDC8C808BAA9326BEEB80DFE8057EA9D9838691B71AC0BC439023551A5A8B810
        71E27445510EFEF5673B70F0E07BE065E560E9FDDB316F9E067A72C067A7B210
        36378067BF0A492A040E9F8B0D77DF8B1C532151244ED27816539393F0852299
        13118944D4134AE8B52A2A4DB4FA934F4E9FA73CD925C642116179FFA50158AD
        5634B634A3A0A898D33F30F4EF4A2977C7EAA50574125644F90694ACBE0B42FA
        C2F60E335ED9BE1501A101B2150F2259529531691CC72024968B4839BBC8DBC4
        5154361F2BD7DC0EC3BC7C8CF699C9B8D563D2390621F54A5A24CF38570E1150
        A9D0A2A0D87871DFFE778ECD25DF4BE1FFC3E43F1DC07A02209D0530363E8EA3
        C78E96F5F7F4EDA149BABEAC240F45F91AD27401B4D979285DB9019349215E7E
        763BDAFA9C50DEF95D30058BA04E057057CC8CA19E565C27E7281772B068C972
        CC5FB6126482D0D7D98E7E7337C2A12014E49B589F1361B81983C7211A552E5E
        D4BB77DF6E7658B55174524CFFBE693F174090F4761D9D8052A9A4958F8FAECE
        CEBCD7FEE9D53A91505CA4D168327788D370118B45D0ABE478E43B8FA2DF19C4
        0BAFEEA2E46935CC2B418C0C57656C00FFF5FD07C04D4FE3C9679E435EE9222C
        5AB61C2192C88EA6068C0CF4412014922D905249D319A51153D545E44273730D
        9EF6AED6B76D366BD3DCB072B2ABE3172EF552A908339E69CAA1146281080A3A
        85DDBB7657FB3DAEADCFFEF807D8B7F70398F2F4F07AFDE8E919444E2E4966AE
        11B6B10938B32AE0C8BD1D09A715F18ED3508646B1EDD10720D1C8D1D5D50763
        5E21DC4E077A3ADB68E8D9A900928C358844C2E45ABDE0D024CF36CD479E29CF
        67B5F61D6A6E6EBE3A479D913F6CDA2F00E0416E6121C6462CB83EE4DC5E6F76
        FCA65012E2CD27AB3B3468C1CF7FF10A1A7FF731CA162F47734B0FFAAEF74047
        7239E90962D0C360B8AF1FDCE93E88B849A298118B97AF825AA5C4C8603F86A9
        EA3324B1AC3D90C8A434A4C29989CD95EBA1D51BB1A8BC60E4E2A59A2336BBED
        FA1C6DD8A60D7D1AEF3F1340848E180281FAE4A5CE5DAEA9D06395D9A4DDE4BF
        472C43786AFB13A4C92A1CA221B5ED7B4FA1FAF049B8421C6CD9F4975066E7A2
        ABB505CD0D974932C358B36419565556C01E4DC0DCDD0D9B65203394381C0E6D
        540CA2B10871820769761934791528D6C43B0EBF7FE028ED0BFD94130BC04E11
        FE2CDEFF3100B2AA5AF2236DED1D55B5DDCEF714026E798E208A0997933CB81B
        1E3A19BE8047EF3D343585502DBD0709729502D53C14D96AF1C8FD1B914C7130
        408D198DC7A012AAB07ECD9DA8A9FF18A74E9F8690CC19EB8BD88D4A404A13E5
        D1C6A52F41E1BC6C688581AB7B0FEC3D3EA734E6B94115FBA2CAFF0F8003EF1F
        858C9B4647CF204B999DF992949417F1C135E9869B92F7D33E1B0C47339E9E67
        2885B0EA217057FC0584BE09843F791BD1E1ABD8BC7913363FF810ECE4D7C564
        35EA2FD35262D0A2EB5A0BC9E464E60904151F34B9A1D6E720A9298749CD71BB
        ECFDE76ACE9F6BA43CD8CAF7504C60F6A1D5977E714E7E72060D579AFFE3446D
        CB0E05595C0E8D8F0879F8381D799C26A62F18A0E92883A4E47660ED13E01494
        216DE90173E1B7885A5B327EBE6CFE026CDAB299944584AE9616D45D3A4F6ED2
        9FD1772EC9225B4CA94C011D2D3DC679A6549A87D6C347AA3F26BAB14D3A38D7
        ACD39FA7369F09A0B1A181FFE6CE37076A6B6A8A7854A62CE27981291F7A839E
        FC4F124396118C2B164076F7D348D1329EE86941BAE52818570FB2E99AD524BB
        C9385993541C2B6FBB03E6B66BA8AFA38584789EA6FBA5181A4CA4F50683918C
        5BC9447B77C7992BF557585B303497BCEBCBF2FD53011C3B72A4F267CFBF704D
        2A950A4DA60298CD66326B119A0B52B0FF2E2B2E46B074235A537988369FA4C3
        BE8064C089828242AC59B73123BD9DA47A525296FB1FD90A2F6D6275B5E7F077
        7FF31DB00FD37EF9E65E141515436B34B41F3874E078241219A6EF1DC0ACAFF1
        E07F19B31B02F0E2733F7DF94875F5EB55AB56673E686F6B23EA24333B286B29
        E6CF9F8FAA55AB50D3D48FFEF62B10A4E328292F47F9C2C5E4DFED18224B90A6
        2A4B65726CBA9F6C73228E8EE6463CFD831FD256E642737D273862FEF9BDFBDE
        3933C7F5DEDF57FDD447A7525B1ED8F255F207E7C9C7B61E1A1E187ABCA4B49C
        145480A696464C7B58BD4E42AFD3A3BC7C3EE4590A949596E2C4472790A55423
        2FDF84FE5E33DC2E5766A2A653B36BE3868D77934CA6A908AD302D5E8615A63C
        880CEACE1777EC780FB3DACEAA8CFBA36327E2029AE6EC777C6500DB9F7CFA00
        799DEF3AECA3282D2DA3E99A0F17D9814020403C8EA288065B22C1A0A8B4188B
        9754E2C4F15318ECEF257B1DCDD88D149D148FA4913D81E54B96C04FC369C6E7
        C7A2154B6D8C54D8F1CE1B6F5EA6666513EFA2983876F8C324BBE0DF34003B9E
        7BFEE5D1A191D7A7C88FD4D320BA7FD3960C75D89BB3421CA37E10529519F289
        4B96AFC099532761A72547408B4D8A4C98942C875A6B009FD4263B9BB51A3EB2
        23454DFB0EECFB888616CBF3D1B9705FEBBA1EB7F60FE2A6027863E7CE75B567
        CE5D326467734E7FF231161265F47A43661715088418ECEDC00C49E99215B767
        14CA611B451F590681804F40E5282C22594DD3740D0732E64CA8905DF8F0C4F1
        D3735CEFA39864F93EE2F3321EDB186E3A000AD1B6279EAA8B85C2AB196A4696
        CB7C4A2E4AB380A58656A7C681FDBFA5A5BB0C95954B1021796C6D6E825AADA3
        E48BC99809C13EC0526BB55E5FD07FE1E2E5CB97303B94D8708FBA1C09462026
        AFCFC3AD02C0FDF93FFCE3435DADED1FC8A4520E97252B5902216D4E25A51550
        2855181E1A409C382F273DF7927B8C466228AF5898D41835CD83FD7D769BDD3E
        46BBC378281C6627292B93ACC67BAE8E0C25732462DC5200C37D0328AE28973D
        F7C39FFCB2B7ABEBFB4643362629C90BB535D4944B49EF8B33268C4BD1D9D581
        649A83B5EBD6076DE3B68FCECDDA001BC514661F73F830FBA79F50CD853A465E
        988B5B0E60D2E98221C7C8165EF7ECF667DEB20E0D3F5C5EB10097AF5CCE34F0
        6D55AB6922C7304A8D3B30D08F7B36DD37DEDA71EDF0C0E040F71C4D46290298
        F530AC15485FA8BD944E12E0AF05807B6232F3469F6DA0B989EC471E7CF08580
        D7FF0CD90305875486CBE791B278C9894ED2F05AD8DED0D274827C3C3B90CC73
        D50FFCDB6BAFA7B2940A68346AC8C96E481559F8DA01B03BB056AF13B0584A8A
        8B9715E4E7FF753818AAA27D352B9164027C91A0BBB9B5955DF1D84583551776
        D58B1C3B74303D3834823F19804FF98C7D48A66081501829D414420AF62910DB
        A4ECB2E1C1FFD1F6DEAA17E7733E67814828C473EF597E87E780DC9073BC2500
        BEF1FFD5E09B0EE0BF01B95FE5013D6E4A100000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage1: TImage
      Left = 72
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000EC300000EC301C76FA8
        6400000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000013504944415478DAD55A09781455B6FEABAAABF7
        743A0921010C02B20982910104854F11451FA088CEC8031415F705117144C511
        59020E821B232838A03C717B0C2A2EB8300F047514D914040C6242804042B6DE
        AAAABBB639F7567727A0BED179CEFBBEA9FE2EB5DDBAF7FC67F9CFB93708B66D
        E3DFF9107ADA537EF4058315506D8435039624C2B025C8F4D4300151F2D25B11
        B02C98BCA701DBB6028220761304BB030D7B2AE9A51D8D9267C3124D1831CB36
        AAA97725B52AD846B929E8752674EA42034A16E2742D99F456A07BC1802158BC
        7904C017F2FF6B00D816BD839D2F42182CC13D48843C408050424217D0F44126
        A069A7C0CE74AFD1F3061BE6513AEFA0B6D940F263CB4E1D84641000E3FF0B80
        0D417293A2E5915E3B74BD1FF9835C82A790B9A2892489AA52D3489C74B393F4
        3C45D7297EB61828FAB119483655846B0B04F3E598A0BC063315B148E87F1900
        174D6C59F2155E143C902314F7F521970DC105D5ED96822739980C004778BD05
        00839F2D7E3621B0B1054F95655B4F6A4262A9252413A660FF9A000412D0D5DD
        63F99FF2A1D5302F42E44032044100D33C138409971292D06C8544571C4096CA
        015802094D5A254D4324C144DBCA0ACF9B6DF07BB20664C1BFCF1492531242EC
        7D9384FF750088F2758295F3A407C15C17DC7C22D604FA976280F44C5A363584
        68C612311745961F6DC430F2E41C020934E9111C368EA14AACC17EAB0A87C4A3
        48B90CB80589C090026C46056616901B0116680BE362E43E5980E5FFDF0074B7
        A7FE04001B21CD428E623F04C137DB050F581488BC31001254D25CC014D1DB2E
        C6104F779CE1391505EE7C4E503FA515454F6057B21CEFAA1F63BDFD390E4947
        E1153C8C129A2D42D660F3B9C4E01A5D8A5CE30BF9949F1A52B8C8BEE1870F69
        B0942D438BFB67BA53F6C3A240020B3289EC861309A416D3C40576378C0B0C42
        075F3BF651F68891FB345A3128B606E62C1EFA362C045120E69E304F63B2112F
        C4D76099F13AA2AE047C34BE43CC0E10A6A880185E170D69A39292A8FF2880A1
        E64D3F02807E1AAE4BA8E20AA21C2EB42438DA676158A80731D93B02E7E59C95
        15BCDA6AC0C6D4D7D8AA9763BF5185881DA378D0786C30BFF79012DA8B85F88D
        DC1D17BA07E04C57B7EC7C7B12E5981E5F80CFA41D080A3E6E0B1B4E9CB86C37
        7477EED26301F516EE8F27CB7A9676CF0F1F5A385D52635F0A30031997612018
        B79C6616E1D1E044B4F7B575B468C5F15FDA5FF14EF20B345851EA477989CFD3
        EC0E0E03E94852406B44B3CC8E43DCFD31D977354E779DC6C7D1740D7737CDC4
        1AE1030438083B0D4287D7CE81DBEBBBC670292F9D606A26EB258D779CA47D11
        514BFD50817291D4C2DF751AAE8D998765A17B51EC29E47DBFD2BFC7238995A8
        326BE113DC27F8B1CDD9DE48BB83910593791EB313F013948703B7639CF7323E
        9E611AB8A1612ADE153E4E5BC24CC330E9BEB0C690B45E34C6F19610840B1B1F
        3E417CA2BE0B23A8FA88DD499C69984E459EF19704A6A29FBF27EFF9A5BE0FF7
        C69EE57EEE25F7B2D266779AC97F2921E5F832D1A6701238AE5BCAD20AD1EE8C
        C024DCE21BCBC7AD4BD56378E45A62AA6A82E74A5BC122557A8962736626C4E8
        23420B961086D44FCF5204135641ED9B09D48C725C47729ED14463C50BF170DE
        CDBCE731F2F70991D9A8B3A36CD8B4B9ED16BE6BC165D9284C052949D938EE8E
        202629696E4B03B09DBE064B7FA48495A18518EA3E878FFF97F83BB8557D003E
        D1CBBF407AECA0507C84FA76A3EF13991254B828F28716DC63B5AE33CAF7D190
        79CC7D04EE1404C112F17AE88FE8EC6ECF7B3E185F8237921F232404D283233B
        096B09D2EA65F2603C4A9A6584F0B2F61E1ED2167137E37D6C2B6B0576CFACD0
        593A15EBC22FC04FAEA35B3A86365C856F85036405393D3AB11982E4169E8B53
        62F2C34C2C08031BEFCFFABE80E4A826ABFC4D268AA37D91B4636090588AE5E1
        59FC9B0AA31A63A2F7F3B094D2A66C09809D997F5FED1D4EAE712B7FB336B501
        93636504C07392F0198B5888126B3D1B2CC395F41D3BE6479FC1DCD422E47025
        39E373A50AA127EA85C67B840C80C54D6FF30BD116F1A5B973C64661C3236EC2
        2DA401C489D32779C6626AF03ADEEF15ED7DFC21F14C7A60213B78464B1900E3
        499059813BF9F33792EB71777C2EF1BC87EE3200EC163163D13731FCCE3D1C8B
        4373F937EBB54D1813BF955B2473303EEB669FF13F178B83863A53937FA8954D
        FCA5C77217CE935FDCB9D8FF72DB1C3B4048456EFE38F9E71CFF5DB8C6E730C5
        63891558A2BDDE42332D2158FC1CB7E3648191981DB82B0DE0A3B405DCBC8F95
        B55673CCA8A4A8B35DA5782BBC3CCD70DF50305F0DC6FD625A511AD55A8353E7
        1AAFA71E1F264AC206368A50BE7D0F7F19B07C0F3E5DB8BAECA59CB7E8DAEF24
        330291A081E7F9EFC178DFA5BCDFDCF8522C4DAE3E0940B31335BBD0A5280BDC
        CD9FAF2197BD2B369BB4E949F771846E19370ACDD3CFD51BEF845FE4DFECD2F7
        E23FA2E3E1B8B3E3AA4962B5B3F4522CAD9EF181ACBB2EB128410A87376F6143
        794539BC6771EBB51D5F0CBF4900BC70A88A5940C1FDBE9B7167E06A3EC8D2C4
        6B98A33D47011C3C49FC0C0407C004E2F6B2C09434800F3029369300785BB0D5
        894098D586BBCEC7CAF022FECD27A92D181D9D4819DC8D8CBF33007D93A55874
        F441CB93524B25CBD825EC5FFF296C513C5796733F79A5702316B77E053ECB9D
        0E6A813493C428CF502CCA71D86AABB60B6363F74296E41323C06EB6429C005C
        EBBD1C738253D22EF421EE8C3DC28318D9E0CD9C9DEB88154199F7F7B8236722
        FFE6797515A626669DA0284D4CE2BCD840CC3F720F2C23364D4825E70B5F6EFA
        9CCA747B668EE57D785DE1563C59F22A5CA663360682855B5808E1BDF0F32814
        F3684163E13F1BA6608BB09B32A9EF07EEE3B89082B19E11782C671A7FF77AF2
        5D8A81595422345B002D84D7E917B47CD8105E8DB67231FF6674642236E99F9F
        10C4AA98C2C886F331FDF04D50C4E4065B122F10BA77E9866993EE5933E88CB3
        477F14FC020B3BAF81483CECB090C0DD88C501CB9637FA7ECB07FA5CD98EF1B1
        FBE072B9B2FED91280C9938E0FBD5C5DF918DF999554EC1DE37D333EDF1240A3
        D58432F9F79814BED1B1B2FE152E8D4EE0FDC5B42B3349142989314786E1CE23
        E308807628AEAADDB917FCF9F1C59F0D38A3DFC0CFE4ED58D0FB2DBE53C006CE
        B89191B6C2DBE12528165B39B1D0F80A66EA8B119402BC57B31D32206851490C
        C6EE5D02AF67D3FEDE2C3CBB6FB41B71953D02CF153C064994F873A6FDCD5CFB
        FEACF07C014D15C1B507466062DD15A8D31B6237DD3B8903109F5FF8CCB6DF74
        3BB374B7558E3967AF22CD86A84E496401B033B3C205EEB3B12C671609E4E2CA
        7EAE7115E6EBCB61B9A85C86FB845CD0D2BF9B8135FB3DAB9314238171C26558
        9037033E97E32A7F549EC13CE56962B9603AC1A6238D18515315DCB1F72A8C4A
        0C45BDDEA48DBF7DE219ECADEBB9F94F7D59DAB557E941F5081E1EB41452B080
        AA61A794758A396710C62E63BC9750393D359B853F896EC16C6531764BDFD10A
        8A169C6CDD6037436829B4C597FA54525B1ADA9AAD30D57D33AE0F8FCDAEE09E
        D75EC6FDF1322A0E9B49C4C9B2744DCB5B2D1EC37D7B6FC060A32F9A5251F5FA
        29B7F5623DA4857F28DB3CA0B4DFC0DAC871CC1EBC0275AD54B4B23AD054D1F4
        20CD7ECE1866A87B20E611C7B716F31D7AA35AFEFDC426ACD6D661A7FD2D9AA4
        280C5AC4DB8293DC58E146944DF4EC41579C8ACBE561B8223802ADD365B941BF
        B2C4D358A42EE7B499495C7C6E96C868D9AA1F8941708B98FED5CDE82D75475D
        A2A1E9BA29B7720B48D36EBF7BEDC80B2E1E1EAF8FE3F13EAFE2EBAE15C8D38B
        C88C45B40089A4734246A3E0204E118B30C93F1E577A2ECA06327B5DAD1EC53E
        E300056D2D516394FB7940F4A348284057574774F17606376AFAD8AC7F8147C9
        6D3ED3B7F2C077AC6D3BE20B02F700AB228E94A1224F2EC08CEDB7A25D4E312A
        AA0F56DE3C6D725FAEDE6BAE18B3FC96F1D75FAB35AA585DF057BC35E473B80D
        1742684381D48A4034A5352266C1B01258A5E2BB9498661C2D2F87CA03917FD2
        9AF7A70E96753FD3B761A5B61A1FA536F180F7A5B3748604782943AE6395C761
        D62B48150BE853DD03930F4F404E7E10DBF77EBD75CA8C07CEE73C39A04FBF87
        E64D9B31CB4C99F85ADB872517BE8D54D8E2A6635608A235AD6C1369088EFA4C
        5E5A2529B863DCAF8BC50274933AD09AB7279D3BF29CC1F20483AC900A1A882A
        BF37ABB0C5D8895DC63E549A87B8759CE4D62C38673F178945735B5F4760D5D2
        3A224F86912B60FC5723305C1E027F6E00AB3F78FBB5279FFBD378EE6C256DDB
        4D7876DE132F7A5D1E1C4BD6E1D5E20FB16D50057C292F17DA8F7CB69870783C
        1D5716DB2EB4D956A2C21725ACA588E6741EF8E0B429A659C9B42DBE3BC7DEB1
        3164BE51D0D22DD3814E8162B3F2BF81887B5B23EC4812C895A153A89534B6C3
        0D477E8B2EE18EC8CDCBC363CB16CDFDCB5B6F4CE7E2783C9E41CB1E7DEADDF6
        6D4E09D5094DD815FB16AB076E46FC1403B2EEE693BA288B0650481A0B733BF0
        3D507205032ADF4A74162A1976CF94C92DABCE1F5EDB2D0467EB163B4981BF27
        066B57D401964BFE9F43B3BB658CDA3714E7E6F727E2284061495BDC38E58E6B
        B6EFDCFE52A69C6933EDB6C9AB475F72E93935893A54BB8F635B7C37D65FBC1B
        9257A6D242E6FB42025FE27BE917262DFA48B349D26B9CEF89DA2755970E98E6
        05CB89425B8ED0123D2343D88A0E7B7F0CD849411FA175748012A39FAC1D2045
        E5D8E85F598A8B5C83D12ED4062539259491CD9ACBAE1A3D445195BD190072FF
        33FB4C7BBA6CC1EC5822864A5F35A2D11836BB7760C7D0C3C4ED1E9A4BE68BFC
        0C4B3028AE74D56A0B2617C8129AF73B4F169AEDD530F7B3D9EE33DB4E5449D0
        7A0D56551CF67744910D3AD18900CB4B8DC2C2F60948E598E85CDB0923F4A1C8
        6F9D8712B443AF5E7DB06CD50BAFCC5BF0E87524482ABB4321BB5CA58BE73DB1
        B6FF59FD4AF646BEC5317F0394E3717CEADF853DE7D542963D640957B6CCE6AE
        6291C90D9DEF588896533BB15D3CC6DD594D5B26DFC5B375E21A2509B3518145
        6C671F57812809AD5B69BA14387B5AE44AA69732B5DF44A7860E18669E8F56C5
        053C33F72CEC0D7F7E2875F9982B46571CAC7C0F387197C833B8FF390F2C99FF
        D40CC552B145D9094D4E42A94B6007CAF1CDE05AD8792EC829296B058B094700
        4CDE52B053BAE3C7C466BCB18D6185D0A906D5C2D43749D7298B6DFF93454964
        8BB18DCD8CE394482CA9B9C97E549A746FEA8A41EE01C82BCA834494DA25D005
        9D3BF6C08A552FFCF7FC27165CCB8AD39301B0A3C3DCE9335F9EF0BBF1032BD4
        43F822B20DBA48EC124BE2FBD821ECEE7914D12EB498271661423816203AA5C6
        80D83A139EAE09081756A5B36A72E191246B90F014F9F42DB9A0B3DBCE0138E1
        63F3ECED4F05D14BEB895EB93D1020BE972817B4A6A4D921BF338E37D51D9B78
        DB4D2362B1D8F68CC0270310C3A1DC21AF2D7FE9D53EBDFBB4AAD28E6063ED66
        44AD18B908505FDB80F260350EF78C432B62E5013D24412D9D0130D20048680E
        C2D1BCC5B5EFF4CB001009005117E519F032C3244BBA5519ED1325E8299F8EE2
        C222B8FC323CA21BE16418B944E3390561EBFE190FDEB4EB9BDDCB5B0AFCC3DD
        52C0DDAD73D731AFBDB06A49E78E5D02F57A03361EDB84CAC441F87C7EA83115
        871B8FA0CA5F8763EDA2881726C9EC06F771CAF769410DC702DC85D2005296E3
        56EC8F6C04C0362C48491181841FC52A69582C4171A8089EA007B24786D7A424
        5823C247E756458558FAD28A591B367F5CC602F71F01E0F17066AFDE57AFFAF3
        CA85A79FDE2337651B3810FF1E4D460415B10AEC6D2A879288231E4FA0DE8CA0
        3E1045C49780E253917413BBD814133A03430098FBA8642DEE4A36DC8A04BFE2
        43281944A1499C2EB542281082DB43F1E576519EF1433F66205A1143C0ED47EB
        E222AC59B776EEA6BF7D3A27E3F73F0700B744A78E9D46AE5AB1F28901E79DDB
        3EF3F040C301BC4304B03F710086C8FEBE25702193AA0645A3EA8808403535E8
        14D486EEB08CA80B545B49F0981E4A863E04241F58D677B9291F938F3357F1B1
        E5691D1583DFD4A0B1A609ADF2F3110A8594751BD74FDF53BE6FF1C99AFF3900
        784CE40483A573E6CC9971D7E4C997651EEAA68EEF9A0E607BED76EC8BEF474D
        EA382957E57F2AB2D83A4267CDA14E9B0320D6A1DAC645542B51E6628DFD5526
        6007E0553D308E99A839508B9AEA5AF22E1314879487A2DBFEB663EB834D91A6
        8FD072E3E31702C81CF9C3860D1B57565636B96FDFBE9DB34FC9251AA30DA822
        863A4C015FA154D252AF1E318382DCD038BD3200125940D65DF0E814982937FC
        1A65F17AAAA26A55D4D734D0184D143E14FCC4A78AAAD6551C3CB8ECFBAACA3F
        D10CD5FF48B09F0B80F7257377B8F2CA2BAF9A7CF7E409E70E3CA7074B585A23
        F97E24815442A3259F8A849280AA29E44EEC4CF7142B4A2C81442C8E4494AE15
        F68CEE932A52A6CED7DB5A52C3F186FA23DF5556BC5A557D78856118DFFC6CA1
        7E01809647DBD2D2D273468F1A3D72E8E0F307756ADFF13417F9B2C6846382C6
        625028C0151234168B528B51C0C79876B9A6933A5550B4BE3DDE5077F4E091C3
        5F1CA8AA5C5B5B5FB7D1B2AC8A5F2AC83F0B2073B0E2B7B873A7D37A76EFD2AD
        57CFEE3DCE2C2A685512F0FA0A287B0652A994CC4090158CC64893DAD0D8D850
        DFD4507DB8E6E8EEA3C76BBFAA6F6ADC659AB44800F47F5680FF2B801F1B8FAD
        0BD92AC547350EDFDCA7CA9438954A56A7397FE9F8B526FC77FFEF367F07D19F
        DDCAA38320AA0000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage2: TImage
      Left = 136
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300002E2300002E230178A53F
        7600000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB519300000D344944415478DAED597B7054E5153F77EFBD7B
        F7FD4A36BBD9CD9384240422585BABED68452858111C04DB711C1DEBA3B6E2AB
        76DADAA9DA7174B4FFD899329DA97546ADA252D13A2DAD0802419004929084CD
        9B04C86EB2BB79ECFBBD7BF7DEBD3DDFDD2030555143A1CE7033677673BFBB77
        CFEF7CBFF33BE7DCA5244982AFF3415D027009C025005F7300AFBCFAEA392F62
        59164E8E9F84D6D656107811962C69866DDBB6412412F9E41ABBDD8EE75BC05A
        6683E1E1216868A807B150009DCE0C055180743A0540D300788E5128C06030C0
        F0C808D8CBED10098541A552E39208B1781C965ED6527BE870E7E31CC7EEED38
        7C689BC16084E6454BA1BAA61A7DD80581C0ECFF0F80724739840221D069B540
        29A8DA49AF77B958106F757B266ED06AD4FD0C4D6F5E7AD91553B1682C5D51E9
        9CDCB367E7F8ECEC8C787101E0ABC564C2EB46C0622DA94EC4122BFCFEA9B578
        BF2BD399B42397CB8152C98242C180C562E1294A21E6727C5EA952C5B55AAE0B
        EFF7C2607F5F3B7EAD744101480A1A580545EEA7CF66B257BBDDEEBB3D1ECF9A
        4C36A363952AA0290A949C7242AFD309D1786241013F4F0017489EE26749BED2
        08DE5E5E1E6C5ED4F8E4EE9D3BDEBA00004C32B733E934706A8DD5E79D5C1B09
        47EE70BB3DD765B339D01BF4A064E9A45428784451E8477AEC5B50B7D0214A8A
        C763B128879890271428F08FC80D01A1D51BE1B2652D9E8E8FF73DF8A50188F9
        022C5DDA025BB76E8570387C0E001298CDA590CD66ACD148E427FD83437745C2
        E1DA3C9FA7551A0DE8D45C30140AB94431DF290A422F72FF78F3E296ACD56ADB
        D83FD0FFB828511AE23A09006E030291590F2AB511AAEB9DA91157CFD3D41B6F
        BEF985008CBBC7A9BD7B5BCD8978B2ACC259DED4DDDDED1E1F1F3FFAA9008686
        A07971230805C92C8AD4ADBD3D3DBF9A999EAEA390061A8D1AD42A2ECCF3D9FE
        29BF7F17C7A9BA44219FAE5DB0A08266B975E14060352BF1A5055605C0689056
        0CC463418CBE02939CC1CD60C1A03342634B75A8ABEDE317A8279E7CF29C0094
        4A25333834F8485BDBC1DBC5BC54954CA64A1C15E51EBFCFFB58229E78EF4C00
        65363B8C8D8ED22A35B72110083DE6F3FBBF2D0A22E8F506A4B1224049625F20
        30F3110554C7C2A6264B7DF3A2E563C363CBC78E1F5FA8567394C36E81BC20C1
        7DF76D82F6838760FF81569048E2336A4C7E2D528886129B5E5029F97D7D475D
        2F522B57AD3A2700FC627B3814FEA02016968D8E8EC99AADE45810043EA0E254
        0F4E783CDBECF672A4D652305B2CF5DDDD3D4F6FB8E5965BD079D5DB6FBF0376
        5B792E998CF42453893D7C8E6FAF5FD8604059FCE1BD8FDEBB62CDFA1F98BA0E
        F7C32B7FDE02E1D02C06A20CF27935D45496C2C60D1BE1F9E77F0F7E9F074A4B
        AB913C1C824B83CD6198EE6C3BB0195D7B83FAEE35D79C1300EA73453291DA65
        315B9A676767B19004A0A4D422BF9A0CE66024127A14797AB8B171D15DC74F9C
        780065D0B27EFD7A181B1B433B3E994CC43E645966BFD96C46BCEA0DD3D3B3DF
        4B2692AA479E78186EBFFB36C8A573303931057B771D80E3C76760B8A70752A9
        38ACBBF966A8A9A985375EDF42828554D640A9CD284C8C1FFBD7ECF40C01B09F
        BAF2EAAB404E6FEA730050941365EF4347B9B3D9EBF5163029039168D4546229
        E17C3E1FA8D5EAD0DAB537A576EFDE53459489616894CDB464D0EB0752E9D456
        8EE3C225A5A5372412A91BC3A190D2683401CBB02105430D3DF3C7A717D737D6
        5930818143291D1E38092F6F7E5796CE858BEC5221971DF78CF9A444265EC7A9
        580177A9FBC4E8D82BE8D6DFD142D4BA9BD71107916700E4260AD46902480269
        CE79053AC438D0F19D8220B62452A9422699FCA756A3894DCDCCDE896B0A9A66
        E0FAEBAF83BEBE7E88C562F2FDD00A288BD3A83627D7AD5DB7D0E572D9DADADA
        A1C2E948A653A921A4D3217CDDB3FAA6D5CE9FFD72D37326AC58054100A3510F
        BB7774C13FFEF6AE2415123DDD1D47B66B75864183D1B82C998C5BE2B158AF28
        8ABBD1B509A2AAD4030F3F043ABD0ED2C9146E531E48C211F49C528905A800A4
        2A6204ED1D9D5D1FF40F0C2C33615F62321A5A150C9D89C513376261A188C339
        D4749641952005A7180110B08089B8F50D8D4D28A5D9FC84DB3D8A05AD3D9BC9
        ECC32FEF429B44E3977E63D9C6BB1FBCE7D9C6C58D0D469301DC631E78EEB7CF
        0FF4BB8E6EC175221227D1F46846B4D89C15034C00E811402697858A9A4A084D
        CF4286E7A1AAC201D94416B037814C267345EBFEFDFBB2E9AC9E42C71896416D
        26D59182B3BA593C5738838B644D81164F260897B3C978E44D9FD7FB175C1A40
        CB9CA913B801DF6A5AD2B4D1525AB218A34C771CEC3888C17B07D78E01C067B6
        CC7300F490CE65C051E980F04C107208A00201444251F9FD405FFF46575FDF3B
        A8D91855DC21AC2B5281C45944270B700A83249D769EA24EBF17F23CD4D4D682
        C168EA771DE9B80369E6FA0C7F0C4491D1B468A44AFAC8C73F57603E0D4096CF
        41755525246229B567726283ABB7EFA9A929FF4292E9C42F127D51248E13000A
        A0E62AA41C7CE9BF0190B79C4A097575F5303BE57F756468E817B83B11380FC7
        A7021030C466B3D1D97BC4F587431D9DB7E6733C4523BF312BE56893268B3855
        74522153E534958A28E4466C0E08CA309044D76894E0282FCBBA4F4C3C343DE5
        7F0D97F3E71D402C188154267D556747D74BC746C65A685421A08A4ECB8ECB4D
        D529A6630EA09D72B6C8234A4E628A92E67647924133348B155D85EF73505A62
        FA7074E4D843A826A3E70F40360355B59530E39B5EFBC1AE5D5BFCDE6923CC45
        56E6B64CFC629409EFA9B9EEB030C71105AA0FAD6031D22C2A981AABB50E5825
        47DA63107909D2A924F04206F87C122AABAC33FDBD47EFCFE7F33BE6BB0B9F00
        C8E57350E6B45DF5EFEDEFBF37367CA25C428E8B44068992140A329062A41580
        4D975C1F40C2FCC2E98A384D9A2E9A56CA545112C7F11A423B0978BC8E96EB0B
        A9AE22FE352DA94FB4EED8F16BEC4A5FC71BA6E60560D3230F8356A76552E9F4
        8FFD61FFEF06BA879CD160ACA8E184F3442E89A3C4717448C1A88ACA53107034
        64499F846018199082A2E58183802046F81F4BCC808AD3601BA0C4FBE4218F81
        A96FAA0DB4EDDDF734CFF37F9D3780DBEFBCF3A7F144E2DA09FFE46D46AB09DC
        236E8886E3B293641A2200286C0D542A8E5C5E94D11C8F549780414E33747137
        4E0150C83BC2E0790631E3AE89792C0F82BC0358B58156E2544643FFA0ABEF19
        DCD1ED78D3DCBC00AC5CF5FDCDD8AFAC08C713CD2A8D0A7CE35EC8667232BF19
        9C03D43878907F78CC11D25029E6224C0EC27B6278A55C816904203B498C2EAA
        932064310E79D22F6155E7C1EA2805EFC993DBA77CFE67A1588DE77550ABD7AC
        792A9E88AF989CF45F5BC0A8E7D259B92DD0E9F460755A211A8D422A96904190
        368351228D0800A998D314509F00A1D1E4DCA08A0F0D2842298622F304B6234A
        60711759054CF57675BD8855F625BC647ADE00EEB9EFFE8D816070655BFBA1FB
        49C564711242750067B513F99A868037202B0D494CF294406EF3CED47C542805
        A59023CEB0451080F422B941F2866158D06AB538C7AA3128AA5457DBE1EDC160
        F0455C244F1584AFEAF8E91D58BDDA892DC2153D2ED76BA148D4A4E270585131
        A02FD5412A9C46091480EC0CA1CD590FF1E4B6A1C86BE2B0125F554893E25DE5
        F11B815148412D184ACCA0D771B9A31D47F64D78265FC6C55D6889F93A2F7F15
        71C06030D0367BF94E8FD7BF52AE98060EB4663564C27CB168A1B3A278DA7BA2
        2E446DC8AC8CCD28D4362C8214366C01BF57D67EB93DC7CF68B56AB057D9C934
        9BEE3974F8A0CFEB270338D1FEE0F9707E8E03C563F9F52B6E1B18197D8B4500
        0A0E23AAE5808F0BF22502524A7E3220F39D929586508AC6F77AA305965E790D
        162C0E46877A61D63729B7E51A831E0BA303B0B98EB5B7B6EDC349EE6DBCC19E
        F3E9FC59002A2A2B4D565B457B241A5B44330ACC035ECE05F2508A382F0F3608
        4EA5E18A392051320872BEA2BA0E1D3660159F8478240C5AA386382FCD787D7E
        57976B773299243DFDC768D1F3E9FC5900089596AF58B9E984C7F7A7542C89F9
        27C89598D081ACE150430A1E124A8244342E1726955A23EBBC9017E59420C02B
        6B9CA411E4878E0EB886078609D777A2F5A2A5CFB7F367012087CD6EB3D53636
        BE373238F81DD27C11C70935484397408E939683D0271808CA55DA6EB3CB450E
        473D70545580DD691563C1F0646F676F5B2A9922743980E64113BF92775F1600
        39F446FD372BAB6B5E8AC5129713FD26FA1E9E9D952B30719ED087CCCE248971
        A80783D9042556138FA3A2D77DDCDD3BED9F3A88B7398C360C678C7E170C0039
        4C66F3E5950B6A7E830EAF0B07435C68363827A3923CCC304A164ACBACE0A8B0
        8190E5274F8C9DE808060207709D5456D2229361E582FC72F2390F53A0DC662B
        5B6DB5DBEFC9E4725727E3299AF447A455B639AC5855D9A8CF3DD13D31EE2103
        FA476843504CD20BFA930F758E751693B8B2AEA1FE477A83F10EACAE8B347A6D
        2E1E898C8D0C0CB762CB411E6FF4A0CDC0FF90E7F30170EAA0173634ACAA5A50
        F3F344222675B675BC8FE75AA14817FE6238FE65019004260F80EA90E74E6C83
        C7A1A82E17FD17C22F0C60EE20DD9C0E2D3B6717FDF8FAFFCC7A09C02500F33B
        FE03EFE1170ADA72F88C0000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage3: TImage
      Left = 200
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000EC400000EC401952B0E
        1B00000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB51930000106D4944415478DADD5A698C5DF5753F777FFB32
        FBBECF78E2050F249810994DD086A852E1432B6CA44A286AAB36129552B5446A
        BFB4344DD37E683FA44AA2B61F9A800222856244B0538C11180FB519DB637B16
        C6B3EF1ECFF2DEBCF5BE77DFBDB7BFF3BFEF59363889672855DB2BFECCDBEEFF
        9EDF39BFF33BE7DC6BC9755DFABF7C48FF2F004892F49936E9E9E9A1A9A929F1
        BABABA9AB2D92C85C3618A44229ACFE78B0F0C0C348E8F8DC570546F2512D1FA
        86FAAA782C1E397EFCF8BBDBDBDBE7709A89E5FC8F0080614A6F6F6F706E6E2E
        02838230200A00D5E9747A5F434343A72CCB3DD82FE6F7F9C23E9F1152352DAA
        697A44911572C926C3E7235796C8CC9A7465F8E2F2C54B97BF0E1B18C436D68E
        E9700B8048341AA88AC783F8B8ABB6B6A6B1BABAA67F6B73B32E180A55E5CD7C
        2C1A8B56E1F72DB84CD4CC9B3E0D96C1712A9F1BF007C8B40AE43A2EE9305222
        8500860AC502299A46B6AB92552AE2BD4505CBA552314F6E66D31DFB78E287A5
        52E9FBD86202CBDA15805A1C6DADAD3F761C7B40D7F5A0A1EBE1222EC6172457
        12C1D554950A2513462964E8018096C5069604BFE27B8954E1BE12C964E11CDE
        D7C16B077F5DC7A652090B3FB4B06C3EC12952D0CED2EAD2FC3B9655FA2E4EFD
        102BBB2B007D7D7DBF67DBF63FA930525614B6862418CA0B1690A3C854927572
        F05A72752A398A30D6756090E408004C11FC0F4B25097B28F0BE84F7BC878C08
        4B8E2BA2E33816CE47A44A25F2E712B4B2307DC134CDBFC676EF62257605A0B9
        B9F90FABABABBE5F248372A4C33878D385D1363B8AC36E9211AB030D4AF89CE9
        C6083DEA696C1CD0B0B1321825F35F1500004202B9386292A4F085B0590991B0
        10011B002C8AD9DBB4B63035736D6DED2FB1E9CFB1D67605A0BEBEFED79B5B9A
        4E6C171529EFAB85913ABEB0C92E8042769172D904E9810829FEB09766308461
        082F0B0F23223058564124CD00100D81F0402888882C232A38C106251DEC67DB
        0062952868ADD3FACCE8F5D595B5BFC176AF612DEE34910500485D734747FB15
        5BF1C773C156688546327B0CFF99D92469087B3693233914269FEE2733931406
        CA8A46120C36741F299CB84C1918AD1B3E91C81C0949051819BF83F23800EE20
        D139AA9665919459A1D4ECA5F4CAD2CA3FC2961F614DD20EE55400805AE8DDDD
        1D97142DD49F0B7690A5C28B8E2478CA28F2B90CF85B22AB90A7483044995C0A
        06FAC985F12A125A0510561ABC2016261D207D002BE9AAF85C11F9C4001C01C0
        2D14A8689964A756C89CBD549C9D9E62E37F8035423B54A28A8C4ABDBDDD3F81
        741FC9F99A29A786110148C2D686700853A1E4B0BE3802940CC34163F2C7E324
        F942028026A82343AD00C0F09382A8A83E1D91020891CCAE487AC782F721A156
        314794DE20F9FA847B79E8DCB1926DFF3D2E368495DF0D00AEA07FD0D4D8F883
        42A099D27AA3500B62BD36539449AE825438343FA94600C2E408A36544CA1FAB
        118098F7AA0E20A00FE781C17F7D9C0BF89CF38305AD1C018EA455CC909D4993
        766D9446CE0F9EC9E5F3DFC1154E63A5770520180C3DD0D5DEFA9E156C90B2BE
        6EC4117CB525E4B049522943A5D43699508E705D0B0C28908A735CD402231C23
        03B4E25CD074500AD452E17D1FC0A83E0391D044B22B8A571B6C14361B11289A
        D8339BA6C2F4599A1B1B1ACD64B27F057B4E626DEE0A4020106CDED7DF379A76
        B568D2698664DA649949841DEA0169353495CC7C86FC916A44401205CAF08710
        151F056355220AAA8E1C408498429A818217F02389BD9A202B5E2D704A5E2E15
        726972CC6DB2168769F6C2070BC9EDD4F3B0E72DACD55D01C0A1EEE9ED3D8B66
        E51E33B887B2B64CE6D622D9A0902CFBBCDAC0C9C8090B39F58562D0748040B2
        FAC351242B2200903ABCAEF93DFEABA08F1F20B8A560319091C84513099C37A9
        00E7989904F91233949C1CDEBA3A39C952FA6F58F3B40329BD1980D4D5D9F98A
        3F18F8AD42FC0065A4383C049E16B264E7939433B390DB18B9304A87D7B99570
        5597FC55759E12E133F44602806A20790DC303035562DE3338A658C184F17950
        28B305694E909A5A2667792C3772E5F2F7C893D209DA8194DED2CC757676FE79
        3C1AFD76466B2533807A000099ED755C3045BE7015BC1F425E58E462A96C2053
        C86F08CE1BBE00F8EEE5810EEF6BBA97D42A0A19EBBF65A2C68BEB389403155D
        4482E5D9D95E24E9FA556B627CF405D8C24DDD65DA8194DE0220140A3DD8D3D5
        79AAA0D52BA9480FE5136B544CA74482EA8128BAC83CF70CE4F74584D248904C
        300B12290B83B955D60C361E2D05CB277B5DF16A4101C56F7D76428073D16338
        AE826296277B6B9EC2E6AAFBF1E8956350A97F80191FD10EA4F4160068E6EA7A
        7B3B47647F436D127990D95823500A0D7390AC7C4EF442BA111209CB5557F43B
        582A0CE5C5C58A6924BC8FBF5CA9B97552A004E9E4262A708AB270888C448F05
        83541352A9CA275362618C4EBFFB1FEF178B45EE4A3FA01D48E92D00F0573B78
        D7812134757765437D94C9A26AA277D18331D1C495B87A7127CC86B291C80701
        40142B5514324F3255B1A78DDF21CF49B1001EB5A4AD294EADADEDB477CF1E6A
        C2D8B1BC344F172F0ED3DCE4285D1A1ABC6C9A856FC38C53B40329FDE44426F5
        7477FDC808467E27EB6BA3821AA3426A0B16C09B7A507496424FD042A3260B43
        B94D90D960955B6C57B4DCAC364178B6ABA589FAFBBAA8A7A9869A633A59C885
        8B132B343D3945B3335769766E0E399610DFADAFCECF2793DB5C0B7624A59F1A
        29EBEBEABFD5D0D8F8DDACD64019AD86CB2715B972DA79D2159FA801DC1A6848
        5C96519BFB5250241830A8ADA59EFADA1B69607F3FD5D7C629A84B9448666872
        768E2E9C3F4F1F4FCE502A53A25C2103394D936CBB64E5D6A9AB2EC6C99DC05C
        FDB778F10AD61CDDA1947E0A00C6C8AFB5B737FF2CE304A594DE4CDC944A2568
        37A8E4706BC1030906053F46C8A68606EAED6EA583FD3DD4D7D102F055B49DC9
        D0ECE2328D4F2ED2C4D41C5DDBDCA21C7AC27C16FCBFBE443A42284B5C1D7354
        1389501380D6D756D1EAEA4A6170F00C3774FF82F53171FDDC0D005D37DA3A3A
        5A2E4B463C9A545BA8888A5C44C9E796391EAFA25678796F77137DE9C05E6A69
        6945644C5A5E5DA3E191099A985BA1D5EB1B94CEA2769430A971FB67A306A09D
        B6724992F3098A467C545D15A328221640E23B962DA8552898CE3BEFBCF312EC
        E17A308C55D815006EADF77DA17FB4241B3D79B58EC235D5D4DFDF4DF71DD847
        EDE0743010A0B5CD4D1AB97285A616D6687EE53A689145841CAAECC24D1BBA40
        B40E9003C9A2A8215118AE0FA24FE23982D9C1D2CB53CEFAFA3AD5D4D4D0F4F4
        74666C6CEC257CF963F2BA52735700F8B32F7DF18BFF6E168A4F1C7AE46B7460
        E010F4DAA4F5CD0D9A5D5AA5C5E535F03A4DD94402434C90B557C8A78B3C9040
        3305866B305A974AF032E6025D1163666546E64E960B5B2E9DA7D4764A80EDE8
        E840E4750B39303E3333F3BD4C26C32D458AEEA022DFF6BE506B4BCB9F5657D7
        FE5DA0B685C8A8A62D5C288DA2E3703EC05849C1609FCDA170A1DB0451540CE9
        BC0CD901C75DAA8A86E8A9A34769F0834171C3CB40D5B69037B95C8E52E86AD3
        E9B437E0030C6671AAABAB475E95C4C2BC8C66B7F09F5B5B5B3F999F9FFF29EC
        E3FB45A51D010885825FEDEAEA3E91C36C5C5022E015AAA718D0C9A30967767E
        9B0CC511ED81260CA7F2E02253381CA1BD7BF7D3D8D8A8A0081BCE2B8F1E88AF
        853CC335C2089E2CCE615180D1E23B2E8E0C3816E3DAE34E2D2E2EBEBCBABAFA
        12CE9DC6958BF40975BA2D00C3D0DBFB7A7B2E210FA25905A3214ABFE4C0D368
        5154C829AA9BF0B4CC55966B00D702D91BE2793F0C27B49D4C102A2B7978DD1B
        8671A516155C5284434C332FFCC1C590E9C49D2BFF9E1768257EDBD2D292C679
        AF9E3D7BF69F0186133C5F01F28B6E2DAACDCD4DA7E3D5755F4EC3060D7C5640
        47BE35C212C89DA8247A7CAF02F31E1606954C165D66A1C8E50C9112370B8467
        D968AF5A2BDE54C6498E5F70C1AB7CCE433E7FCEEFF91CA61327F7430F3D4447
        8E1CA103070E5032992CBCF0C20B275F7CF1C57F1D1D1D7D1BD7CD7C0A003AD2
        B67BEFBDF7A985F9F96F2692DB8D3CB8287CF7CD2E71472FBC227804FC7C5136
        D8C2A4E6D85C9BBD7D78F6E5018601F0DEBC2ADEBDF9E06B33B8CA6BA61803E8
        EFEFA7279F7C92EEBBEF3E6A40ADE173F95E127F178D46317C05E8E8D1A3AFBE
        FCF2CB7F760B007CF8175555557FB2B2B212C442715915DF313D7813C171BC2F
        62CC64DE3A8E2CEEF7F0771563D848F6AC24E8A588DFB3372BF42A4BF50D6FB3
        13D8F0BABA3A7AE0810784C7F7A057F2FBFD828215E0EC0CFE6C13127EEEDC39
        7AFEF9E7A7911FDFB905004E7E1D92F604424573E85312904A3694B9CB77D4C4
        BD9CF26F6DDBA5724AC310EF46AE8E068FBF66836F8EAA170557DCED63201C3E
        BE05CF06B6B5B5D1E38F3F4E8F3DF6183535357951C5E7E5DB3DE2DA0C747979
        994E9D3A45AFBDF65A6962622201605C2B5EBD0500BC7F0421FB21F816E59350
        5898773738C91BF25F4F31147885D524E4759EDCA996C74671F3B64C0B2F821C
        15E4095A11749C00AA3255E9C1071F145EF71C54125EE6D715C379CFAB57AFD2
        891327E8ADB7DE2A5CBB768DEFF3CC628D91770FE9FC27732082D7CF8063DFBA
        FFFEFB9BF6EFDF4F274F9EA4A5A525E1053EE2F1381D3C78906666A611A5F9B2
        EC86105E1F3C6795817834E190B3A74D8C919C43310CFFC82F3A7CF82BF07CBB
        E07204FD10EF9D4AA5048820E6043E2E5EBC486FBCF1069D3E7D3A873DB83B9D
        2A1B3E83355D06B2FA49001C5FB4A07418C9FAC788C49771417964644444838D
        3A7CF8303DF1C46FD2D0F9B3F4D3575E1591A8F0948DA94820478901F0DF7DFB
        F689F3DADBDBC5939B8A1271CEF07BF6368361A0172E5C20288D03C94CE1374B
        B0E52A79CDDD74D9F805F2E605BE156FDF4E461904AA177563FD3E34F8295C3C
        C2DE610EB291D5D5714A6C6F886707F99C75432598BF9548717B70CF3DF78868
        B172F0C1C5895FA3CA8AF7FC9A8DE722771EEDF6EBAFBF5EFAE8A38FB6702D36
        72BC6C7CC5F065F26EBF738F74A353FD4575803FF0613562FD062EF28D471E79
        A49F8D6210C87E78CC2F2495A732F63E530039840ABC97EEBEFB6EC171FEBEA2
        247C304006C1CFD4D8FB68E0E8F8F1E374E6CC19737C7CFC3A6C992D1B3E555E
        7358D7C87BFC54A0DBCC08BFEA1919BBB30AEB2EA8C71F1D3A74E8AB304EC7C5
        68686848789D23D2DBDB4B9C2FBCF8215F45492A8727C18AF038478813F3C30F
        3F74DF7FFFFDECC6C6C6B5B2B1A3656F4F9769B24EDE6C6CD12F196EEEE4211F
        571FCEAC36ACA791C45F7FF8E1871BEAEBEB8591CCEBEEEE6E6118BF170F2FF8
        F152B9367014D8EBFC9E730932680F0F0FA7F0DD7299DBE3E58464C317CBFCCE
        9569F22BA7B23B7D4AC93F4009A65AACAFC0D86F42A50E3DF7DC7332D3062DF0
        0DF5A918CE92C88AC5FC7EEFBDF7E8D8B163D6C2C2C256D958367CF2267EAF60
        25C9EB7176FE7C60078F592B09CE8F527F17097EF4D9679F0D3FFAE8A384D657
        A808AB09AFD9D9597AFBEDB70953561E05F17AD9D09BF9CD1ACCF4E1BEFFB6FC
        FE3C0054A27123C161EC379E7EFAE9FE679E7986C06791986FBEF9A63B383898
        8684AE963D7DB37E57F89D21AFCFFF4CFF54E0B33CA9AF24F84124E8B3030303
        BF06001A22C154602E5F2D7BBC62386B3A5388697247FCFEBC01F0717382FF36
        D617CA46CE950D67BE73B2B20CEEFA9F137C9E00C41EE42578335667D948A608
        3F32657E7F6A8AFADF06A07230A50CF2A2C249F94BF5FBBFEBF82F499375DBAB
        99A1F40000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage4: TImage
      Left = 264
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000B1300000B1301009A9C
        1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB519300000F394944415478DAD55A0B5494651A7E07C67146
        19E42A570394B82A2060D25289D2295BBCACD831834C0B2FB867F798C75D5B2D
        85D26396E16EB56AB96BABD95AEB82A68B692A5E101442E3A2825C868B5C0507
        0606980106D8E7FD9861C97413CF5EEC3BE73DFFCF7FF9BEE779EFDF3F48FAFB
        FBE9A73C243F7902F7FBE04B2F9D70EFE868886E6A2A3A9E91F16E092EF5FEBF
        C1DF1781E5CB2F47E8F52D7BBBBAB46E7ABD86743A0D6934AACF6B6ABE7DB3AE
        2EE7261EF9BF9AF04709CC9FFFC5144B4B9B6FE3E22268CF9E64AAA82821BDBE
        95BABBDB3BFBFA0C7BF3F2F6FE0E8F691F5A0218D2F9F30FF4AC5A154D274F9E
        A5B367CF080266665292CBADC8DC7CC4CDD6D69AF8DCDC3DA7F0ACE161244033
        677E7071C992E8C76FDFBE457BF7FE495C93CBAD69E4484B92C994A45058517B
        7BC347274FFE76036EB53E7404A64FDFF4EE8C19E16B274F0EA08484F583C0E5
        F23100FF2F221D1D8DE92929310BF14AFD434560EAD4550BBDBCBCBF888F5F49
        6FBCB18EFAFA46080B2814630689F0DF128984EAEA2E67A5A6AE7C01AFDD7C68
        080406BEECA554DA146FDDFA7BDABFFFAF545E5E0FAD2B85E619381330379721
        B0B5900E52A9BE49C9CEFEE8D7F43FB0C4FDD601F3909065556BD726BA949656
        5166E615E1F70C9E2D20938D268341CF9989BABA5AA9B3B3A9E7DCB9B7E3E152
        07F16EFBC34080C2C2561F7FE1859766DADA3AD0E1C36943E2C00A2E6500F036
        21DDDD6DC20AC5C547CFA854A7E2F16A19FD176BC57D13080F5FBB2E2C6CC696
        A8A86769D7AEBFD377DFFDF95A40C022477B7B1F3BD63A0A9DD1025A41A4B636
        5B55547478155E3D03D1DD6DCE909010771C5E834C87040CB9D5D6D7D797D9DB
        DB9B5A5050F0977BBD3F2C0211116F3DEBEEEE7362D1A205F4D5579974F4E8FA
        8CAAAAF4FD53A6FCF2390F8FE951B0C28881023740A0B5B54A9D97F7D99B78F5
        AF7447A13302DF0B9926954A69C4084E0A7271E4BFB93FEBE9E9C11CAC98AE46
        1C179797979FA6BBD499FB2680218B8EDEDF1517B710DA2FA7D4D41D05D9D91F
        AEC6F50A67E7D067FDFD176C4271B3632B3089BABA2B5515156776E3FEC790E6
        21E097E0F0077373F3310CD8240CDC4406F7C4B94C26A396961658B396C96C2D
        2B2BDB72A732864380162C48BE346BD6F430BDBE1F164869484D5DC1048E42CC
        6C6C1E9D3A71E282E4FEFE5E2BB684B775A6CED7A6A0CE7214357519E81F4D6D
        74F87475C8EB7876F19D80EF05DE74CED6282C2CA4FAFAFA6D376FDE64129A07
        22B070E157BBA64C098E7771B1A543878EE90E1E5CB00997771927947A7BCF79
        D9CACA6D8FC1D045EF2F2D276F0F4BEAD2E9A852A5A27D693ABADA3896860B9E
        CF150A8570A79C9C9CEECACACA95B0CA9758AF73D8046262525F7CF4519F038F
        3D36810E1EFC06F2E29F75BA963770AB91EFEF584A9B8E14CF7FD3DDC3813ED9
        6841484F68BA7B29F57C3D25FEA9F481C1B3708CE4E5E5B1DC28292989C17205
        90DEE1BA9097B5B56BF1AC5953E99B6FCED2B1639B2FC0CFE370ABEC93E5344D
        A6509CAD92C6D0AC671C28C4CF5C80AF6FE8A098B559A4EBA241D00C50AFD793
        6933C515DCCACA8AECECECEE097EF4E8D188AD6EFAF2CB2F0904DED26AB51F72
        6C0D8B0086796CECD75551514FB99494DCA09494ED37AE5E3DF02B5CCFD8B58C
        4E86FF62EE53231D42C96BFC08015EDBAAA715EB324855D521003130A44714BA
        4E9A346912393B3BA3001AA8A9A90975A358DCF7F4F4448D1929000F05CFEF8F
        1A350ADDF0593A7DFA744E4D4DCD52AC7B7DB804B03F38703C3C3C6CA65C3E82
        3EFBEC7D7556D607BF4D789E8ADD5D4765C62426920C8B9B5C27E9A32BF4C5A1
        92C114C9E059E2E2E284B6DBDBDB459661022CF9F9F964696949BEBEBE02EC9D
        E0F9BCA2A282F6EDDBD776EDDAB5159C40864D60F6ECDD5BFDFD27BE1E14144C
        1F7FBC85D0326C4E7A99E4C11161BF8978E5958187D8756A5B697674F2608E67
        37696B6BA38D1B3792ABAB2B3AD70E01FAF6EDDBE2D8DCDC0C326D5450904B33
        66CC206B6BEB1F80E77978242424D0952B57DEC5E9B6611378FAE92DCF3938B8
        7D3D6F5E0C7668EFA02FDA919A38AF5611151D15E91516C61B05C26AF4C5C142
        4A4ABA4416161602047C16EF3E8D4CB650F8BE49F34309E87406AAAAAA212727
        6B0A0808F80178534C24C2D2595959C7A090F86113C09045466EE98A8F5F8720
        DE47A74EEDCA5F1D994D31739E0974727727AC2808AC48C8A1FCA256E1120C58
        8774BA66CD1A1A3B76AC9884ADC12EC404D46AB520C0F5A5B9B983EFA2F2470C
        82E780B7B7B727A5522948252525D1891327D2A184350F42007DD1EBD7E7CF5F
        EE575F5F81C6EEFDEA571F3BA15BF254B09793A3A3000F3551E8AAEB62711606
        EFE2E24273E7CE155966C0CB7A49A3D1888066F06C0573732B641A390AD6657A
        FEF9E70735CFF739E03953F13012B800021B1F88406868FCAEC71F8F8AF7F40C
        841BADD73DE3FE79E9A2296E010163ED38570A12A1EF69841FB3C9D95DD04290
        B7B7B7D0200F4E899C81181C5B42ABEDC46B1EB006BB920A297BC1A0DB545555
        89ECC416B98340E2BF2510179719D4D3D339A3A7476FDBD7D72DE9ED3560515D
        557575A6BDA7E7E44D73E6ACA4EDDB579093D96739B1E18A29D37C6792253591
        1C5B80A9BB7B84D638886FDDBA454141412278875A802DC3C255562E77004077
        E4F84BE4E6A6A4C8C8C8419FBF7AF5AA5080696CDEBC99CE9F3F7F6F02CB97E7
        2CE9EDED4E4487E96661A1C4951E68490DADE9E08F3A6301D2D3BC794B293939
        89D2D3776624CC2DF79B3061B68DCBD82052929A16EECE06103701B8A1A181C6
        8F1F4F8E7031CE464309F4F41890F7ED41C005649598EB53047A34F9F8F808F0
        E84609395FA456D358B1620567A14338FDBDE4FBC02FB3931D3637EF8FF0F37B
        84C68CB181C6A548793AAAAEBE0E73D7C15755F0DD26B882354547C7433BE711
        CCEF158D535CF83CFA317ADDCAC6CDD2DA3684B61CAD2677043517A7C6C646CC
        654B0E0E8E00AE176B999BCB210A80B601013BF13767AAC2C2645AB76E9D00CF
        EE565D5D2DC8F25C3C508569EBD6AD7AEC1352F0E77AC9F7C1F79F430A0B0C0D
        75C3C452689C001E7B426C0AD5EA3AF8E2551CAB91392A61890E9A362D160B29
        51DE37A80B0BFFFEBB7176D4123A9E5EF574A4A033B521CE5E5E5E0204BB8856
        DB45C1C1512864DD623D33339920307094E3684167CE6CA759B39E16E9D6C9C9
        092D799D709F71E3C60D06706A6A2AF6E5FBEB552A5532FEDC349440AEAFAF6D
        506CAC3BB19591200078E03840404D9595F982C000896AB4039130F5E368AD3F
        345CBCF8FE3B986627045D1CF9C1678F4C9C3851B810BB0D03090C9C8374E836
        6801062F958E16C7ACAC4FA18C4E7AEDB5D78889F3E077D07D8AB6832DC0E7EC
        FF191919DF21FDEEC7237F9118C1275A592913D6ACF182A9B163D00E08620F5A
        1838BF170117175FB4006998F483C31A4D257F89C01BA8CCC1C1B7FCFDFD95EC
        0A4C82D36571B10AC1F822827B9200289148314F39DE4F4600F7D2EAD5AB45BA
        9D306182E8FFB9B5E0BAC1843821A4A4A4D0B66DDB0CB9B9B9BC07E18D52BAC4
        E83A9591910163222264D006217006B48ED42C08B01BA9D54D20903748A0B5B5
        89FCFDA7C3BCFE54567605C1B7030DD6A59598341F62983C79F2D708DCE71800
        E7734E81AC04F4307023198A9293D8FCEBF5B7E889279EA03973E690ADADAD00
        CF7ECFCF719D602BFAF9F9896B1B366C60ED57E2FC6BACC1ADC44DC9B265DFAE
        562A2DB6FBF8F8D2934F0EA4716C800468BC238E5A6D1F8A4B09B2491902B25C
        0433765E8280B3B317AE57222FBF575C5E7EEA3798340DA20B0C0C5C07F05B70
        14E039164C8589EB025B8603DCD4B8B18BB0DFB39B70A03260D63CBB0F8FE3C7
        8F0BEDC3AD4EA37EFC0D973806DA257171978E2A95D2D94E4EAE309723B4C0FE
        39E036A8E0229019705D5D09CA7FA3D03E137174F4240F8F1098DC4704F7F1E3
        5B4BB037D8CC598C27461AF405E0426ECCC6C02F4DE04DED81A9CF61E17E8903
        155B46019C4998C073FB809429FA1F58A50C817D12F37F042986F44B5E79E542
        8154DA3189A3DCDADA05935B61F25142C39CF7B55AB500DDDEAE11D947A36980
        3FB7C1AC4F41FBDE488D13A8B4F402B2C37B259595E7DE316986E3140D590A2A
        E8DC27615A06CF7D3E6BDEE45226CB98EA0203E754CAE0D96D18135B63E7CE9D
        949696A6292A2A4A33CE9F6A5C8324AFBE7AA15FA7BB89492DE03E2331A92516
        1A053FED452C70A56C15C7D6D67A01BCA9A94AB88DBBFB6458CC0396F0A0ECEC
        CF510BB6E7D7D7E726992CC09323068200E2E2ECD9B3155CC84C5D291FB9C9E3
        56838B190738FB3B03664B98D22FB7100C1E9B98766C782EC175CE625ACE3E35
        A6EC2959B4E8D4B5D6D61BFE12498FF8582B975BF0377FB1F1E8EDED811BB50B
        120C9E5DC8D6761C3DF2480034EF0102E3911615F4C73FAE8199F79ED2E99A3F
        A0EF7FC83247FFF32682333136365680634B700FC41596C19B5C89C1B32BB1E6
        99245B63CF9E3D480EE9FAF2F2F2EFD02FF1BCBC992FA4215FFA243131C78E35
        355DFFB95EDF28C0B3980693E8EEEE44206B10D8DCD2BAA39FF117B9DCC6C659
        648DD2D23374E8D00E98F7D0316366E00586FE7E66E1E1E1F10ED2E0AF162F5E
        2CB28AC96DEE36980C6F2FB1EBC2DCA5ACF96C10BE825B472097B90F1CFABC24
        3AFAC02FFBFB0D3BD4EAEB00DAF28309CD9057478FB64686F086961C05704B4B
        7B807784CBA969F7EECDC8D77FBBD4DE5ECFA9ED1348D35D70D980C4DBD0F2B2
        F0F07019376A6C8D3B87F1AB033649990614AA1A04741E5F36BAE58D3BC10B02
        E1E16BD1634DCE572A1563FBFA74DF236102CFAEC5B1A154DA0A125656FC59BD
        13257D3BE5E61E4166B87C018F7F0AC9A27BFFCC6483008E8225D6C0FFFDE02E
        23B83B350D6ED8D072E89162918CEA8BA1F54A5CBE04394F03BF35DCF5033157
        62C9F4E96FC5DBDBFBEC747474123DD050029C91468E5408222C4AA519E2A196
        8E1CD94B4545E90D2AD5C974A379D9857EECE7256EE8DD21E120F10C2AB41DC7
        09DFC0AEAB43C73F811235407221DF426AE9477E4034F5428AE0E0A5EB9D9C82
        D7BABA3E2AF3F0F013198983592A1D29D21FEF257A7A5A10AC67D1B7A4A116E4
        A1225ECC316A885BDBFBFD3183D7E440B384D81B49A1FE8BB86105F07754CE62
        1D741F9FE587B6D363E04AF3BDBC66BDAD50D8B8D8D83888AC606DAD44FEAF45
        F56C44A1A946BAABBC5D5B9B55A2D5D697E29D739053464D3DC8901AC19B462F
        0DF307F43B3734AC0D3F078780C59696AE3F9348CC2CFAFBFB444DD0EB5B74CD
        CDAA469D4E8D168FAE42326820E36886B3E07F7ADC6D47C63E8986821E318A05
        FDCBC46C5E0E28EE38D9DCFFF3DF85EF878069B07965F4431377D343F27F1282
        C04FFDBF55FE09E6BC744ABC01DCD20000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage5: TImage
      Left = 328
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300002E2300002E230178A53F
        7600000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000008554944415478DAED997B4C54571EC77F770001
        11C5C7FA5A1723356297B56B77573A6D366E3425B646F101481141A54045F195
        184D5123EBFB0524A6F8565051909782552B7F68ADE983EE1FB555D95653D747
        A1501F54446098B933FBFD9D3B030332702F85694C7B925FEE6BEE3DE7737EAF
        F33B23592C167A919BF43BC0EF00BF75006774E2EBEBAB9B3061C29B59595951
        AEAEAEEE6AFB75717131F9FBFB9FBF76EDDA472693E9296E35405ACCB8530046
        8C18E1EBE7E797693018DE183A74A80E8351F55E434383E5C68D1BDFF6EEDD7B
        0920CA70AB1AD2E2E56E07F0F4F4A480808029FDFAF53B939B9B4BD000A9355B
        A3D148111111660C3EB5A2A2E2106EFD00A9752A80BBBB3B9B50E4983163B20A
        0A0A34BDCBA0919191727676761E2E3F80FC97142D34CD40B703F4E8D183860D
        1B163576ECD8A39D01983D7BB69C93935384CB3D90AF210F7F0D80E8D1A3471F
        C140C86C36536363A3EA77E7CF9F2F9F3A75AA18977B2157210F9C0E00138A1E
        3264C891AD5BB70A00B54ECCE6B766CD1AF9E2C58B3680AFC8D91AE0060D8402
        222F39395933C0C68D1BE5CB972F17926242AC816AEBB80584042F0FA8AFAF1F
        8C90E5868F0BA0AE4C6E1C75EEDCB9F32F1F1F9F552929299A01929292CCA5A5
        A59F0E1C38F00222D977E5E5E5FFA9AAAAAAC063330F55427C3EEBEDEDFD8F3E
        7DFA48B22C93244942743A5DD379CBD604DFE299EDBCF53D1600786000DEBB76
        EDD204C0E6B76AD52ABA77EF9E61D0A0410D38D6565656AEC7647354AA670809
        71FA8BE5CB97BF3679F2648226C8C3C38DDCDCDCC4CBC8844D83680BAC6DB107
        D7E17B1E545C5C4C870F1FA643870E690260ED2D5BB68C73014D9A3489626262
        E49292929D7894092987C81266FF33A8E9F5E0E0607AF6AC0E2F7960F0AEE265
        DB8079D6793CCF6BA6F9BE6DE03A5DF33337371D797979527E7E01EDDEBD9B8E
        1D3B26CC9313949AC613B970E1429A376F1ECD9831834243434D67CF9ECDC0A3
        C390EF20260969FAF3F7DF4FD247454DA58F3F96283D7D1852B805B36F146626
        493283E268B29A9D6C2726DC6F79CFF67B93A991D6AF7F09333794B2B272E9E0
        C18374F2E449CD00B1B1B19CCC68FAF4E9346BD62CF9DCB973C7F088B3725913
        C0DAB56BF5EFBE1B8C0E5C2831F14FC4BE40D448CAB2C3683DDACE6D22B7BA6E
        FD1B0306FE3774EE47478FE60813423CD70C3077EE5C0A0F0F171A7008909CFC
        6F7D6CEC74A8DA4C8B17FF01A6640F20B71AA0A91540EBFBB677EA2927671C3A
        67806CCACCCC24A85F73224326A6B0B030C700F081CF376DDAA48F8B0B81060C
        B468918F15C0D8C140DB036069C0F75E47A70A00676174AE6AE0F60D83A62953
        A650484888630D6CDEBC551F1F3F934E9C7806805E2A00D48030C03FD1E92898
        52361D387000DF3F214C88B5A0A6F1EF12131345146AD707B66DDB06130A4107
        4FE1F51E76006D0D582D403DE5E64E80FA5FA6C2C2429A33670EA1161003D392
        286B6A6A68FFFEFD141414C4BEE018202E2E14004F2821C115006DCD76670082
        00F0672A2A2A1233D899D6B3674FC2729A264E9CE81860FBF6ED02E0F8F19F01
        4076009D319D6680BCBCB711BB0384FD6FD8B08156AF5EDD641A6A5B7A7A3A2D
        5DBA94A64E9DEAD88418203E3E0C00D5B46081B10D0D6805617986A8160CE70B
        10098C6751AB13B3A97108EDD08977ECD801805970B6870068E80200BEAE03C0
        0C74FC174CCC71B18C387FFEBC1894DA30CA79801D98073F73E64CC7003B77EE
        840985C3077EA2F7DEABA5DADAF606ACDE07F2F3C30400471F76C4D3A74F6B4E
        64D1D1D11D27B266804A8A8FAF81061AC9B654E83C401D1514BC83997B4598CF
        9E3D7BBA6F299192928A301A8E8E2A282EEE31000CA4AC7B7E99131716CEC1CC
        BD229C9897D26C4A9D59CC454545B50F909A9A8AB55004007E8006AA6042AD35
        60BF4430AA00519CB8B09057917F15338F3EC472A233CB69D4C5346DDAB4F600
        D2AC00F7A1B272AAAB33B4026824ED9A608078008C25DE0F42A4A37DFBF6090D
        680158B972A530A37601D2D2D2F43131B301700751E81E190C06EBF2598D0FD8
        8328E7FCAEC5520BD359848E5F453EC8A32D5BB60833D20A80A21E635A405CAF
        385CCCE1C3A807DEA1EBD7ABA8B4B40E61CE4C5CC74892C52A444A6D60B1162B
        CA3997967CE49581FD35D708BC240F0A1A4DC3870F4034CA476DB09E10AE3501
        704588A21E2BE4C58E1319032046EB79C96A34D6C3717A1097825DB96171E1C2
        0531939C0BB8A975620658B162052D59B24468008E2C6359926505B86103B88E
        381BA0D7EBE1BCB5A234E4D65C365A48291D9B8B762E1BEDCB49FBDFDB8BCD0C
        AE5CB94277EFDE15898C9D582D00BFCB89AC6FDFBE346EDC38DABB772F5DBD7A
        F508B4B81F8FBF1500FDFBF7DF505D5D1D880FF7C30DF72E9BF6E6C633E083A2
        DC37232343988F5A00DE10484848B0141717F36E5CB5BBBBFB538CF343BC7F06
        D7DF1317F5B8F947A4763F50F15AD7AB9B00FE3E7EFCF8456CCF5A34C0FB42EB
        D6AD932F5DBAF4292E3FD1E9747771BC8D6FFC0FC74AE26D15068578433C596B
        D4B5BB7516DEC540420A1E3972641AD7040CA0D4DC1D374E64487E725959D947
        782F9B94DDE91F214D7F7648D601EBACD2E5B30F47D4F5EAD52B02C7CC51A346
        29375516340C7FF3E64DF9C9932767607A6CF7DF407E22256E8BD6ED7BA33C8B
        83070F8EBC7FFF7E96B2C7A4B999310145A8CC6CDBEBCEDF9DF6F7F79F585959
        79FAC18307DECF6F55B6DFBCBCBCEA7967FBD6AD5B2749D1C063FBE74ED99D1E
        3060C090C0C0C0A4929292786884674F952AA0310B06FFCDEDDBB733E0035F92
        B21BF7D4E9009E6830A3C08A8A8AB77039909480D12104B46582066E3E7AF4A8
        941407AE22DE317336009A0B29D18E73CD20521FAE395C71B461B361E7AD2365
        9DEF74009E6D4E921CAEFB90FA84C983E51967B3A9B19EB7FC9FF885FFA7FE45
        07F83F6C1667A6B941EC830000000049454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage6: TImage
      Left = 392
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000B1300000B1301009A9C
        1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000010264944415478DABD590BB05D65755EFF7E9E73
        EE39F715486E2E25C82348B186871430046A4168258AADD30E0589198C5808F2
        18815498CA305A4C3442114753141DD48E566DA12F64AC8083F218A67A5330B1
        24370F6E243721B9CFF33EFBF5F75B6BFFFBE4DCDC03A622EE99FFEE7DFEB3EF
        DEDFB7D6B7D6BFD67F94D69A9E3F6398BA1D4A11D9181686329FF94AAEE50E9D
        FDB531966AADCEC4C7D3308ED7A417E0D1F9045F24448D38A1C958D3EE98F40B
        51422309A9D138D198268A70135FC45A61E05AF31C5188F908D771A2E8B50EF5
        06099C8C3F5728A5DE8FFB4EC59CDFBE8F81E32C04188400D114E21C24D40A62
        DA1A69FDEF98FF0E086CFF5D13586611FD8D6DD1071C8B720E662D4C58ED7BA8
        ED9F367833C224B538085013D7AD5837311EC6FC6713AD5E7CB309F403FE5DAE
        45D7617818E4C83D4A08C0132901E301CD03205212299830C98696738BF515B1
        C674D08C6813EEBB0B0466DE0C02CB6D4B7DDDB7E8ADBE4DE462C2C197168672
        9809266DE38639E68FC59C1A6863637D9111A603396B7801DEC0A8036D3DA26D
        41A23F8C7B9FFDAD11C079B5A7D42600CF33781F8C6C985EC90708C87340C24E
        DD6119176823FE08611B325A98B915914600C84723A320959178035EA01A6EAB
        86D468C6FA3A90FDC66F83C04D9EADEECBC3B22C768FC17BF8907749E5BD9480
        B8840958C65D864026E60C7C338499439C23F082E50D09F6007B22E82051869B
        1A21DD8C40FFC21B21700DACFD95820BF099E5196C8F478A279900880801F182
        655C46923B25498AB959232CF45086AE05A4EB0145614A8209702CB4E584B90A
        6E9D0D5852FAA349A2BEFABA049E3B7DB81BF84B60E8FFCC3BCACD035F1EC01C
        B67CD1275504F01E1FC3359EC0D9335EB04D108807041569589FC4FA01510D67
        26506D6184F83A11FDB78C943259713CB017665A1482D44AE0FCD16B1278FAB4
        C587CF0FBB967AB6C755C7097891B9458A2D5F02F0520E4440A2E4C91CF9AE89
        859480361252A1918FB1BEAEB720701E20500199729312CC378CE5D371283BD5
        9840C083C65A71B21C4F1DEF4AE027CBE612B094FA66C1A15505A49A82CDF281
        7498455F0E0400BE97490034E18D399C87FA40A4000F58E9C8B2109088F50152
        C1EA297026D0249AA95172B02C24426D5343B9023E8B0B0E5E4EAF1590986A09
        916F01EA87BA12F8F1B23912BA187AFFAF1E64149020F6800F500AA0556F5E48
        500993E450E1A28F9135384CF59F7D85F43040167AC1DE31598851402E2DD63B
        AC0FF0546992028164AA4CAA8CE75FFE09B272052A6F5C47B5F1BDD4720A5273
        0449B6909104F40CDC31D1443CC4FA123CFC47F3083CFEF6E1B6D180FBF1A24B
        173101367A0181EB8091EA07F03E2600EB3B2EF55C763BF9E7AD94FF8B5E1EA5
        DA4F3F4FEAA401B2F247E1A9905502793427316620E846AA79585B4F5748BD1A
        50E983EBC93DF3FCF4FFFF77334DAC5B4D95FDFBA9094F0446469CC4585633F0
        C264933D913C0162EF568713F8E1DB86B28F17E61CF504ABA3C004ECF46C21E3
        A87E800709ED2754F8E36B29FFFE6BE7B832DEBD8D9ABF7884DCB32F80550791
        EFAB1495775038B59592EA3EC8A641C94C9568AC4EC595779267C06747EBA78F
        D1F82DABA9AE1D2931D80B6C50965205713009E51D6C24F0105D08023F9E43E0
        3143004BD3434547AD2E72723112CA310104AC1A28887C740125E605D750E1BD
        7309649E48C6779177EEC50864ACBCE5310AF63F4DE1C4664A2A078846AB545C
        711BB9679C3FEF7F83E77E40E3EBD650BDC969544910F33AC82438234D83C001
        302B07F41066AF9E43E0D15385C0A063A92D25572DEEE1CC930530EB1F99470D
        A41E209C39600B2B6E20FF9D2BE701895FDE4EF18171F2FEF05D08833A05FB9E
        A1D6FE2729FEE50E2A9E7633B9A79F379FF8F69FD3ECC6EBA9F28BDD544F1C59
        07583A2C215E17B12A634D00818604F43E7CFC034C4FB509FCDB29432CABF7C0
        EA8F8200F53869DEE718C865012C12CA8B27F400C7814FC577AC85B5FF743E09
        C8293EB08FDCB3CEA1E0E0B3D47AFA5F297FD2E500BF62DEBDE1E80855EE5D4B
        E18B3BA9A13D046A0AB8653211AF8B1CD0BCA81D441C7030435E9762FAB13681
        7F79EBE21391FC583A9F6402221D3B93D05C02E2019CF5608EACC4A3FCA96BC8
        3FE74FBA7802FA1F1BA1B8F12BF286CF2577D97CCB87B07C65D3CDA4B7ECA4A8
        A9A8210B182F1B5AE28081330134472C1D01CF0371F069FCFB9D6D02DF3F79E8
        52E4FEEB7B3DBAB4648237D771B6390632021909CE480BB02EB4904E4FF81079
        5D48443BB620FB9461F9E5F3C16FFB3955BF7E0B253BF7C0BC1185CD44163421
        100B4891505699549189265A4C40AE7F80A9956D02DF5D3A743D6AFA6B90214F
        2B1E4E804B08CE427D26064C3A15427C1EC0775587F2C75D051297D0911CE1B6
        11AA7E6B1DE957F622B502E96C13CBC55C029984A4C0A5743D60029C4E5162BC
        00D867B18D84C0B74F1AFA0C02F8AA7E8F8E65023923A19C9D2E641E176BBDB0
        765FB61618126655567D485B659B0A6FF92079675FF2EBC17FF70E4AF6EFC362
        863A69B6216545137AE9B47E16C4AE29703913B17C389D9603FD2BB4A7DC7B4F
        0B817F3C71E84B207039082C28BA297026E09B129A532A177042805763AE8798
        109F8B7E5A9D9670E36444F9E357917FFEFBBA828FB6FE8CCAFFB44E64A5CA5C
        33F3E2D6A0083543234A8167040293465D53E03281C943042643ADDF8EE97D42
        E01B270C6D42AC5E3EE0AB015EC4B86CCE1A17DF4E09B85CA84939914B097055
        CAE7822743FB781B2C5A5C7E1B79EF78577702BB5FA2CA173F46C9E45E147A56
        BA32A3466A71D066044C00F36ACC25B1673C503335D1544B32D2143E32817121
        F0B5B70CDD0B02570EFA6A51C94DADCF78B979913EC0788457E43670AE42F91A
        67CD755DCBA6D2FBEEECBA48CDC94E633BA87CF71A39ABD8A62848C4EACD8EF4
        D98CD3D6937B6CD7D2B28D508B0E118007F6A3DD5C06020785C0034B866E0781
        AB416069AF97AE01AEE910FD8E5870B9FFE5802E1E22402EEFECE4A9B46A03C0
        AFA02339E2B1512A7F6215053BB751E8F788075A1981246D37B995B0A5B85522
        25AE4A79359E6E714AD5DBD1FCF31E544D087CF9D84557A2615FDBEFD379039E
        12C93078D69F6764C41EC9E1DAE578E0158E093809AE4B54BCFE0B90CD7CCB87
        5B9EA564760245DF655D494CDE722555778EA6244C4B29FD00D70F1A18607D07
        5E80DE651D100201776BFA194CAD68A7D1FB7F6FD1D9C0F6D13E4FAD81178803
        59B64BAC74F7C1B3532D6671C124000F2974807AEFF807ACB87FD46591C20AFB
        0016A9EA3415AF5E4FFEB9EF9D4F62CF0EDA77D31534BD633B457E512C2F3B11
        A8856C05F07817A7D01630CE027C26A17A943C88E96BDA04FEFE9845BD80F497
        00FE20130011012B4D3D918067577AC6136ED822BFAF97FAD73F04F0177407FF
        A51B48BFBC9779A2CA2AC04B1B503B5DD695C49E1BAEA08951D450B9A210E0B5
        37DDE0480B676E6C66A5224DE30031F2114C7FAD4DE09EE1457C7D2AA4B37981
        AFBC5E2EA75D25E98B8F4C4E4CC241A352EC2BD1D0FA0791F3BB589E6B9B7BD6
        52B27D0C0670899FAFD1D4D0317DD4FBF17BBB7B0272DA75E3557470E74ED28E
        27EFCDDECD115695D692D2F6B2A50364A933F0F52FDB04362E5E24652B403E7D
        74C13AAFD749FB75968BA64324844850A313EE584FBD57AE9D9F264737D3CCC6
        EB28466D43B6C78F07002DCF888390EC25FDB4E096EE249ACF3D415BAFFB2B2C
        AD0EA4ABB2CD3D696CB8B9E75D8A4ADAD83C032FADC89A1A21B0616861F6F186
        C19CBAFFA8BC45455E8D4D0E8E85851639B9E8B44E597707F5ADBAED30F02334
        B1E15A6A6ED985AED2378F33DB8BE9BF531286E482C4C25BEF819CE62E768DA7
        1EA6D175208FF5415996D066357166AAC68AAA66219B6D2637E2F62F522781CF
        1802B85CE83B6A64A8601D3300F45C56BB08266D2A437EA8C28781E11E3AF9D6
        4F51FEE2AB5209EC18A1F1BBAFA5EA8BBBC80678A50E6DF2B6DBBF6CBB280CC8
        5F32400B6F3BE489E085A768DF676FA4CAF6FDB8C991F7A4DD9842870609715F
        CC95683DDE8B2C75269E73600E81BB87161D3285A6BFEDCFA94F434A687F2D91
        92C73539A739582181597414D1E092122D5DFB71728F1EA6BD0F6EA4E9915172
        A05FD9A556A904B2DDEA6C73D8CA367DD1ECFBC72FA0C135B74A533FF1D5CF51
        EDA55748417631A5FF98280BD927954D998BB83A5B3FFE24BEFD3B734B870716
        2DECC04FBD485FCF2F28D8A7404EA81ED0E0200D7110B39402B822C443931075
        4F097181C008CB09529E2DDAB524FDA6E9CF36A9D8EE2092BD989298AC9E7422
        A972DDEC50C231C7FB4A243B9154C5C2C0FD305B7FB211BF04E79F0363964572
        BCEB7D48421D1E4849FC39B2D0C32CA37E78A12824946C6E69131311578B610C
        1C491B98A5D338C9B288043E672E134BB2D3CDE438482D13A5966C73CB7325D8
        8DA71B88DEAAD43D092C8FD419241FD8D50A1FD9DC68C97D5B70AE73B9D18D80
        39EE2BF9D64DFD2051E2C50D040A70839F15E830A9E665DE883DD3BA6586D326
        D0E109033E935416787006E22C116344A6A0AB01384BA78631560DEFFFE7A9EA
        4D3FE19D8DC340BE26019D66D1477A73D67B241640A087DB4D2F2561735D94ED
        44F38F1B96259F795876B68A2B39679C332F59D9D67B9202D752FBE8B6F59B9C
        36219D1652E79313F5C737ED9FFDB38928AEE9F411C93C02EBBB7B8073C1203A
        B5FF28E5ACE525CE4A4C00230F4FE45C25C59D654848F032095BB5A5E218F0D9
        8A6EA72F244BB29916E03AFB818F4B08C4171776F59064E7FAA989C60B9FDA33
        7D4539495E314E0E383991EC69A6D9F97509A41ED68300F3FDA26F5DC8245846
        7921414284EB24FE6D2395869188918D838BF4171EDD11272404583AFCEE841B
        9758A7BFDC70551A719623FAE181FA96BBC6A66F2DC7C92E03B88ED1E4F8A6B4
        40111242E0F38B87E8B50F5E50541E77DE5FF2EC8FE473A9F5E5E701F30B9FE7
        28434489CE3B35EF6404284BADE9CAA60C015E6362B3ADCEB242B0D237F756FF
        FBBE57663735B51E37C067312AE6BAD1E90921F0D78383BF8600A8E34D1371FC
        E1734A850DC715BCA35DCF34FE20C331E19B268865E598BA292360CF21A1C50B
        025E4201671040654EA395A0F5B997679F7974AAF1245E3C8931D371E6F45935
        049A8644220454E76FA35D0ED5A6825EDEB2DF7651A970FBF252E12F16E61DDF
        4370F35AD0EEE24CE92DBD846D0A4095A5D1B4BB62EBF3E1F0AE03AE5F6DC4C9
        F7F655C71F18AFFCCFC130D96D001F34232330DB41A06508C44744A0E370CC28
        1C65DBE7BFB327BFFAAC62FEC2630B6E5F09F53703764C4C7047E7296AB7A6DC
        57486FA1D2078488DCDDB5307A6CA27EF07BAFD6F78CB52296CBB419073AC04F
        1B0299843AE3E0C83C70D8C11D70DE0C54DFEAF4133CF7E2DFCFFBE72ECDBB4B
        86734EA11FA87B6573D8929D0DCB4A7F276EC431BD1A44D1D66A587DBEDC9C1C
        A904076A899E32F2983580794C74009F3D0C7C90816F07F1FF93001F9C11B9E4
        ECC14041411C444B304E2E2875629F630FF7586A1096979F17005E63D50CA6C2
        B8514974CD00AA99513120673A0097CD7CD5DCD369F5883AD682DF94402711F6
        488E658551C4E835A3CF10644F71736075FC5F6800358D65B3D1E83867D926B3
        784C346F217EC3040E279311F23A067F76CC77528490F9EDC2808A0CC0CE917D
        D715F49B45A0DB9101CECE9D2FD2AF338EF8F83F27391F5728644E9300000000
        49454E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage7: TImage
      Left = 456
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000DD700000DD70142289B
        7800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000014604944415478DAD55A7B8C1D7775FEE6CEF3DE
        B9EF7D7B77BD5E7BBDF61A3B8E9D754CECA481266D924634D0145C5550098A54
        D4442D29883EA496FC8128155015D5052111A1AA894422821A93983A400231F1
        3B5E9BC476FC5C7BED5DEFEBEEDDFB7ECDA3DFEF37F77AFD12D09656EA4D2633
        77F6CECCF9CEF9CE39DFF94D14DFF7F1FFF9A308002BFFEAE8EDFFEABBF03D2F
        D8FB621F6CF2589EF783EFF0E0B9AE516F386B752DB4C6D4F5358D86D3D770DD
        580830A128654509E53CAF31EE7BFE19C5774F86148C879490CFBF352D69FE47
        7E5FDA2B62AF8482EDD70DC0755D61781F9FF3BB6A487968757FCFA69E74B22F
        123595B1D397307E790E8616826E8431B26A08AE5345A5526A640BF9F3A552F1
        50BD5E7B59F19C5743A1504E09350DFCBF00E0388ED8B6B6C5EDA74656F43C7A
        E4CC95E8FB360CE1FEF57DD87B62127A54052380D77EF63622860E45B3F0D07B
        B7429035A2D451AA96902D14309B2F6066B130BD90CB3F57AB947612C8C590AA
        FEEF02709DFA50C20E7F71F3D0F2C7370FF5857E7CEC2C0E9E1AC7677FFF7E1C
        3B77053F3B7606CB7B5288452CD4AA7554CA15A8BA8507B78EA2E12AB8B850C5
        EA94CE481450AD1650A9555074144C2E968A97A7A77756CAE52FA9AAD68CC8AF
        1980E7794FBA8AF9C5F76D1C887D78B41B2FEE1BC7F3AF1F437BCC425B3C4C3A
        39B00D0D1A1F9A4ADA303515C552159E6AE0DE8D23E849447070A284DE5898BF
        F151AE14512E2D1268813423E090895397AF9E1FBF7CE553B4FC476A48FDF500
        F07D3701A7F14D33DEB1E3F16DEB708CDC562B19ECFBF979586A08B1B08E308D
        B52D0D96AE4ADE6B7CAEA0CC7B865712B88FF1E9056C5F3F8CE97C0D6A48432A
        6C904A1E4114502A6651E5DE342D44A2294CE60AEEC113A79E2E57AA5FD035FD
        7F06C0759D2E53F15F54F5C8F647B7AEC5BA6E0BAF8E97B0FBB53761FB75A4A2
        61D8A646CFABB0B899345E262ECB8CC77B8FAC1EC4504F12BBF69DC09A15FD58
        D39346B90E905DA834C0638228E7512C6450AB9560595124E36DC83B2E7E3236
        F68DF96CFE495D37BCFF1600D7697458117BB7EE79A3A36BFBF1E8488AC60167
        32657CF585BD481821C4233AA2262340CF878DA6F75505FC17113B8207EE5A85
        8EA88E0B73CC0545459C9E2FD6687C3DD8CA0244D521D5B21284E7B98844E288
        C7DAD1A0CDBB0F1C7C666E21F74982F8AF0160898C5891C8AEFB370E3F90A3BB
        7E6765047153A101C0B9851AFEF1C5FD082B1E921183954643D85CF2BEC14AA2
        9152111AFB9EA11E74F2A2A4A5C2653A959A9EAFD402E34B62CF73A54A0585C2
        BCCC099D491F89240982D1F26A7879DF812F67F3E5CF69B242DD0EC0DF1CBFE1
        2493158AAAEE7C64D3F01303698B86010331D0CBA0B7816CDDC73FBC78044EB9
        84A46D4A00964ECFD3784B176034988C88CEFC70E9F5DEEE24B60FA5C0CA8A9A
        D334B86578F3B854F351642EE4F373745E0361029020A251E64D16BBDE3CF831
        D688674321E59703705CEF23A36B069F7F705512CC4B69349D49EFFA68B02A14
        AA0D7CFDA523D0186E91C0115227CA1FF6B74710E67EB1E49146210942653954
        751D5B56B7A19D54CA967D69B4C3925ABE667C13083995CBCDA2443A19A60D5B
        8248F09E2A8E5DBA98D93B76721BA370E61600837F3D76BDF1C99ECE8E431FBA
        63F96A3A9FC605009211606CA604838D695552C7CE5D4751AF5491E00F44B9EC
        489878785327CB5E0847C78B9242A222C518A13B07E388F098BA014726CA2C0E
        0AF380259755672627AA928989B92C81B0CFB062A9F545D903227612BE21F221
        8C2367CEE1E8A9732F98BAB6E316002BFEF2ADA0E8F038A41B4F3FB269E4F3EB
        DA747A108809E36D4680607E7E398F675F3F8136DB4085F53D4AAA4405F7699C
        A0D2504F94C71A23E44B1A8904EF4818B867282AF93F53F471E46249CAA890A6
        612157C6CCDC221A08A154AEA1E2306AE104947A01F57A4502809160538C326F
        2AF8EE1B0745AF799834DA73038081CF1E6C7ADFED1E5AB162EC919165DDD126
        DF3B12C0AE6397F1E3B17186B60283C22D4D63DBD8BC62A48BA04F9839609363
        118B74226ADB322400713E4A8A6D1F16A556459E75BFC2FC09312F32A4D2F18B
        39CC668BD0593A2D2BC9BEC0BC6054E7B3B3A854F32C1851D8761A563846C00A
        5E3A7004D399ECABAAAA3E740380FEBFD827BDAFEAC6671ED9B2F12BABE935C1
        F90E26EEF94C015FFEEE7E2CCCE7904E8579CE929527416363E12680A6D1B6A5
        079B00C37322A10D6E91B08AE16E0DE9881A7437E12CEEF3347862C1C764D667
        D44232178A2C518B4CE42B39F60496CE15E9387433CE9C50B1FBD0115C9AC943
        3342DB788BFDD700F4FEF95EE17D65795FDFFE47EF18DA6AF3396D5160963AE6
        DB3F3C864B53ACCFBE83140D17DE4FD93ABD4300A61694504B78DA0840F07CD4
        32650484903398C0DD491577F66B81813281C124070D64C52390B9021D35078C
        CFB3C2151D76E6796E19CC3861DE3B8A91EE76586603DFFA8FFDEC19D4E756E8
        9FA80F9E5A02F0673F85E3799BEEDBB4F1F0E6656955DCD8511CFCFBFE53D2F8
        5CB98C7AA34EE30D1A4F00E476221C343019812680A804100011111020841418
        1DD4D04B108BE5A0DA149A9547E48528CD0C2A851E70390B9C987471E96A863D
        61169A6E62B26663CB8A3614DD1ADE78FB222E4D6610B58DD30DCFDD4CFBCB12
        40F79FFE9861319FF8E07D5B77F6F28ED45E387CEE32DE1D9F46819CCC148AA8
        D66A4D00868C8404602D51480210C69B4B14D299A8835D06B60D99A8B3FE17AB
        018062B30714AA018DC45C946083E4AD09CEC7D9C91C4E8C5F65A30B61756F27
        F5117B4149C7898BE33874721CA9988DB2EB8C12C05B1240FB9FECC1B2F6F6EF
        3C70F7E61D115D81060787DEBD88994C9E35BD844CBEC804AB49CF8B08A40940
        52E81A00ADE9795D0288340108FE3F744714DD7155CA86627DA9E6976B011011
        8D7C250022E44732EC21E41571753E8B3265B649FE2FD644926B78EDEDB33871
        E1323A9371141A8D27A9B5FE450248FDF12BD8B062F9A10736AEDF32C3EEDACF
        042873E878E5E019E48A65F2B2883CF341189C6E5128227240549D400345CC80
        FF1153BF667C7F7B188FDD1597497B73E72D372321A222408868E42A41126B5E
        065D760D61D6EEAB791335B00A515A7FFFF071CCCC2FA23B9D40BE51FF5AB5E1
        7D3A00F089EFB7BD7764CDF1ADEB867B8B6CE36DA62E437A98687F3276090B85
        12235065D229EC0126AB904E4F19129050A216455D9809DB2AA36109404557D2
        C287DF9B66D954AE09B816884A0B40D3F8D63ECF2C2D91FF0E7B413216472A91
        62686C2CB2B73CFFC621F89C06BBDB921C829CDDD972F5510920F9F1EFF7BF7F
        F48E139B570FC472940946C8E3D061CAEEFBF389691C3E338503A7A6583D1C56
        275396D124BD1D9794092260C97E10182F286588F980BFF9E87D5DF26FB728D0
        6624AE0168812815282766D8C8AA524624E36976739B135B05DF7BF3888CBAA0
        50AEDE38B050AEDE2B01243EFED2D063F7DF73726D4FA79EE15D6BB52A2F222D
        5421253CF4B519D873F422BEFD8313F488291339210188CAA35E1373A2235B04
        61199A8C80508F8FDDDD85955D615981AA8DA6126D46A1452301409CCF973D56
        9F050ABA593913DB764A0ABAB065E1F242013F38748C0E8CA03D1143B65A7F67
        BE541E0D007CEC7B43EFBF7BD3C9CDC383BACB7236B7906787CCA3EE37C849CA
        DC62099F787025FEEEB943C8116007A323BC9F68D228E8C6AA345A486A530F00
        08E598E66F1FDAD4C3CE6D06D58786D69B8AB448BA78A4ACA758B898D5996F55
        14F294D4658A39234200349E51D0540DC54603AFBEF58E7C566F7B0A97E60BEF
        CCB400C43FFADDFEBB47D69E18DDB03666D07BB96245CEB7BD295BCA8989F905
        3907FCF34B47313BCF161F3765498D59018D4404C48D8578D3D9F20D2A515D0E
        36AAF4A40037B23C8165E9185CD1B8180E617CB55EC395B922FABB3BD1D09721
        935D94F5DF71EA923EC2FB96654B61A7B244BD7561825D99D2BE3BCDDC9C3830
        576A5228F687CFB7AD5FB5EAF83DEF59D76B452DCE022CA57C9029C26804622E
        C20BDF383581DD87CF61623627B99826BA981474DA0D34D2C5F5042122A07273
        69B55099427AF4A404053552C6C3F9E932A6B315B433D9067A9621CB72B4985F
        207863C9FB5A308989FBCC15F2F04C97F68439A98DEFCE946B4112DB7FF02C6F
        D077E8FE8D9BB6C439E31AA485D0F11CB8E408294008599D8E8AD9DAC785990C
        BEFABD234CB83A3A1396041395E22D1829C52023161344F511CD6EB02B823E6A
        F354D460CD6FE0F45411E33365E6822B819529AD3DFEB37EA0030D02B3C27119
        01D38C06AB12FC08674C64E611A39437D8695F3E70EE6B855AFDD34D00CFB1BB
        25BEF3C8F6AD3B92CC78935A4617E1F702E125861A0140480C1189368ABC8367
        27F1FC4FDFC53CBB90A906F4915D984012F4F4B2741843DD3646FA6294D93613
        B4813D6373387E29875A43DCD8A77CF1990F1E93DB6592D7D9759358DDC39942
        E5601416DED703E309A24C5A1D3F3F814D1B7A39B939EC51679FA49C081A5974
        C7B3621079E28F3EF49B3B7BDBD30C234119E635E5287C20C64ACB08C088A824
        229003F85C2E0F9D65F7FCD5051C1F9FC3405B04C3CB628C96218DCB9759B753
        06667375BC796A41464018DEA0106A5092D6A8EC04801CCF6F5AD585F5CBFB28
        9D23F4BEBD34B4F01F5E85B357A6D1918C619E39BAF7D4F82859124889E847FE
        8DA174376D5CB3EEF0BAC14135CE8C8D47C208F9A16B21141FBDA9208500137B
        5B0C3B4C6EA68D1464194AE0970F5F40A6D8A0C13546A72E29B2B2935125BDCE
        923A148D72B94502E056234811911C6BEB235B86B1AEB79F84B764E76D7D4404
        72350E3F94F66DD4452726A74FBF73656A3359128839FBC3FF2A5621948EB6CE
        FD778D6CD8DA9EB0D1D11963226B7229E4DA02B2124422A22F514A44A3F577DF
        ABE26F9FDB8BE9C59AA4546B9542BD6E10E7C82A2B91D8D7DDC07811011189BE
        8E241EDF3E4A8AC625F06B004262E9312B24B25CB27CE5E83BFF942D969E9279
        2A00441EFFB61C68344DFBCCC6B51BBFD2DBCE019C199BE200E33BAACC07054B
        460883C5CA9BD0F46A28A09828B33F1C7B1B2FFCF40C34B35989F8002D14AC6F
        B6408A553A4121C7F59BD110F7081AA0F0F49DC38378F08E6149AF167D5C8554
        5DA4B488D8744E0EBBDF7A7B1B9DB234D0847FEF99602DC873BB7BBBFAC7D6AE
        5CDD9D64C7EBEE8822CAD9D2A9B3BA84347A626975ACE59FE66238FB82876FED
        D98773D345B1142906244995DBBD401146897B89526B689A345E343F53174AD6
        C23DEBD6707E88C879C1E193F29532544F2CA2591474C75EBD383BFF90DE5C23
        0A007CE85BD7867A46E1E9B543EB3FDFD59666D9B3D1DD6E538F6B94170A9355
        2CDCAA37E445E0D5A0C4BE72E838DEA596F725C7C5B2A45865105EF6AEE373D0
        1F4493D365C3D39AC60700E4BA929DC0868165A49ACB418A74648412ACFDE7AF
        CEB10F8D3DAC70A86F592001588F7D736945CE7393E954F7A1A115AB57A76211
        360DEAF9F60874561DAA0A39A70A10827F22E4BEAF482A85F53AF5D25956A59A
        345A4440EC5DB938ECCB88C968294DEF3723200008E1278C37E5A218EFAF7218
        B2C22C102AE2A629CF55EB0D4E88875E98CD2EEEB87E854E02303EF08DEBFC29
        1FF591BEBEA1E797757643504944A2ABDBA480AAC2504C26A72EA3A12AA1403E
        A8758C4F2FE2CA7C59BEB5A94BEFBB92EBDEED00F03A556D0250030D65680100
        CB3002696E1A72136045DEEC3FF96EE6C899B3DB08F8D6852DE3035FBF8112E2
        5D80A685770E0C0C3F918E271067F806BAE3D0E20EC59C43C385F10108A14685
        E49898A9CAEB1AD4500DC70DAA4DB3644A0AF901FB4332024AB062D7A4918880
        D18C80A5EBD2E33ACF09F00ECBECD9C929BC7EECF8C7E880676FA6AF04A07FF0
        9980C85E3D185025AFBD48249AD8D5D73BF440DC8E5055DA58BF26C1D2E330A1
        157AD9A786F7A42E31FD241658F305EF1BE2F553933E9E7C29726322FB52D784
        E4A6AB81E0BB1E808888F84D9D94A9F35E539905BC71FCF897CBB5DAE7D4EBDE
        A3296270A7032580D08AFB11EAD904253D4403590FDDBA7C37E0B96E871D4BEF
        EE5936381A362C0CF62790EAB240A7A327AE713A5331904CA05A35023D5F150D
        C9A30477F99D6044A974832804092C7455B0FCEEB14972FA0D728100643E4969
        E148BED71B0E25FD22F69F78E79962A5FC49212B14D1DC68B8EFD6E05C398ADA
        85BD0180565894C4009455BF05A57D0D94709A358C09E9D4BA2276F2C5CEEEC1
        ED094662C3864E9469141F8781B48D382C269A86F6B82EE91418A7C865926AC3
        0FA6B0862FBF8BCF70A74219A2E01C67962B8B814A1511ABF307C2F02A855D9D
        149CCE6470F4F4A96F94EBD5270D2BEA299A09AF9245FDF41ED4CEBC0A373F2D
        9D7C038025CD60075159F11BF0C3ED6456256198C637536DCB77AC59D58B95AB
        52B2731AF510A6671A7201B735CCDB962AC74C31468A6626BBA5122C6089082C
        4F2BE849283879D5C585D90695A8305C785D68A2C0FB5766A6DD3313E34F33DB
        BE20AA9197B980DAC95D684C8EC12B676ECD815B00B43E06E5ECF2FBA0746F84
        6F7741D1C24F46E3ED5FBC67CB48AC7F791A4E95D5E7420E8D3AB5BE6D51EF18
        B231094A6821554A08516D42F2455D90005153918BC68B2C06C5AA2BA912E48E
        4BE1576631983E3F9BCD7C4AF1DD1F29C569344ED1F04BFBE8ECC66D4DFCC500
        AE751FF1928000FAEF839F185CA5A506FEFECEBBEE7C7CE3C69521C5A170BB5A
        E4A45666CEF804A1CB0A1280083523B00420D038BEA489C80D2129CA049159CC
        1666A7CEEDACE5A6BE84A92379F7F241F8D545F88DCA2F34ED5703D0FC6DEB12
        44BBA9E6966DEBB8FBF1A736DCFBFE8763898EE8C9B319B956A8C91219549A56
        B9945AA879B9305FE6080FAAB52AF20B53D3B90BFBBF5339B367278AD3E7519A
        6D3DEB57FA9F38AE0710BA69539BDBED8EC50535F9DDEA5E8BDED1DF367B37DC
        6B76AC1E31A36D1DBA1583AA054D2824DF2EFAB247B81C4A9C6AD1ADE56726AB
        73A7DFAE4D1E7BCD9D3AFA3A2A9909FE4813D9C74DA4BBD7DCDF7CEC3681B5F6
        7E0B40CB68AD69E0CDFB9B37ED3A30E2660E31B1FBD89D08A77B94C4F23EC5B4
        DB959016E6AD75D6C79AEF3965AFB278D5CF5D9A42353F054766A3D7345AB9C9
        C8E63D6FF9EEDCF4DDBB1D85949BB6EBA3A2FC8263E53A6FB5D4DBCD34685DD3
        8AA2DF625573FB65C7FECDF7FC4FFC550BFCF005D5620000000049454E44AE42
        6082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object optionimage8: TImage
      Left = 520
      Top = 0
      Width = 48
      Height = 48
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000EC300000EC301C76FA8
        6400000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000013244944415478DAD55A099815D595FE6FBD7DE9
        D71B4D0302CA0E4203022A08049145828C0C122582221A95018596D12FA828A0
        34202882A341050248C49541C50515A328061365150486ADA181069AEE7EFDF6
        7AB5CEB9B7EAF52298602699EF4B7DDCAFAA6BB9F7FC67F9CF39F7C14CD3C4BF
        F2C1CCD99D7FE291899411802C87E0904C984E0D305CD0251D0E8F0438E84F83
        BFA603F4C834CC0093580766B2CBC070297D71094D910BC394A0E9315333CAA1
        1BC7E8A33253C541A6E995507598F4ADC32025EA09E8BA03CCD0C1E81ED33512
        8E063C08F97DFF24009AC925CF0393FAC3E5E80797D41B8CB58069E643338242
        408500AA1CA42113986A1AA769ECA4B10569ED4B336D1C77F0798CFF2F008C00
        B819335D6C8499E5BD1379FE7ECCED2C10AEC8854DA9804C234DEFCB1A4C7EE6
        F715FBAC91D9749D4FCF974FD1E4DF32DD7C8DA5E26FEA0A22CC34FE89007427
        0CB77913F2BC8FB02659BD906D4FCC05956DC1E95A089FD6C5D902A059561083
        006899330763C07430308FB3CC348C252C212F638A911096F887016004C0AD76
        347CDEE750E01B8AA017E42EE42D0C42F32404D72E4B2B30933259212D001964
        0D0E80A95CABF45CE70B4AE47552ADF00240E6DA4173FA5D0798A24F63B1C4C7
        0CFA3F00402A04C96D4E30B2A5250878B2E176024EC91A12E331409A96A193E6
        75D0BB59CD61780B216537832B9843024850A335D0CE9E8074EE048C53872055
        9C805355C01C6E520001E2C2F340CE0009B82139B1488AC47F4BBE6A8402FEBF
        02604EC79F929FBC210B492DF818F3B339F090E02E479DF0A42D534B514CF861
        167483A7DDB5F0342F823B379F44FEC929A12612481FD98BD49F3E84B9ED3338
        080C7393450988109E531B772F5A4F0A3AD73BA2EAED21AF2F4944F11300EE1B
        708195C835DC1AE221ED094577CF64DC5D6858001C3CC2280E89615A0F42A0F7
        58F89A72E6ACF7B91C83110FD339292CC49C1EB0400EA4507E8365D23561C437
        AC86B661399CC928CDEFB341D8D620454939818DA17474A4C39956718194C5F4
        A91700C0E3923926A4DCF22A019C84665C780EC250A0FA0BE01D5C8CACAE036A
        05376ACAA1ECDB0CF5C83668270FC18C4708802C0297FB3D737820356A0957BB
        9E70F71C0C67DB6EB56B250EEF43FC851970ECD90AE60B5A006C10A6CB09778E
        BA2CA09C99C8D80500C8B37B9C77D360E8948A38BE83C6024268E1369CF8D3D0
        1BB541F0D6A748EB2DAD771361C85BFE80F4CE0F6044AB49E3049627090A58A1
        4D2DC33A64B1749A3443A0C8F7DD570C84EF9662382FEB24E651E97ECD8207C0
        36AF07F3062D57CA8020D2F0FADCB73B53DAABF81108167E6848C33B92444A8E
        7F4AD13B24E3EBE24CE953CF6E8AD0E465F0346A6A2D7A7C37126FCD865E5946
        16F2D5F9B118A6C5F79A59774FB3EF13203319238BFA11F8CD4C78878D15F3E9
        9A86EAC7EE02DBFA916509FEAECD72AC51F0AC23AD15D11CE7500F050B2F1C5C
        0F0E814E698371A26693F037AE75E2681E95B42402935E84BFD39596F087BE43
        6CF543946929BE9CDE3A8D650609CF14450030C5C4AC21387ADF54C8AD534904
        EE9905DFE889625EA5BA1291C9C3219D3941EBBBEDF9E81BAF0B2CE87A428A25
        660BF6CB885C356F601D002E6C45F25D9C4B8CACD53EDDE3424ABFB815B977CC
        B4DC267C069145E361C62A498B5E4B4B9961581A33E084E22B102CEB8E57C241
        810D5E3B09CB10A80C6095273B19A1396BE0BE6A90983FFEF13AA44A2641F2F8
        EC7921DE6585C15314571DE8FB0405960520B26048ADF6E94163ED70E501CAA8
        B9827138527AD1901C08CD7C0BEEE66DAD05563D8AF4D67728E9846CDAB117B1
        0198C9045C7D6E44E0EEF9E0F4276F7A0DF28AC72C37E3CF0DB3D60AFC1B6E05
        07CD9DF3C246721D3F0C5545F55D83C08EFD8F6505580010F4501D86EB2545F9
        34E3452C3CB78FEDFB8C53CF48E350CDBB42108795A84C4D86D4A51F721E5E09
        CE02DAE952444BC69000543610B05A009945F8BF440CDE21B721306196E5165F
        6F40ECD962E27B9F257CC62DEAB99C198F2238E325FA6EB4F826BA622194E5F3
        484959F61A1034CEB2D86216A9FA4FD894C46A3E596A3DA7E0D5F77E378B6DD9
        3C1B2EB7EDFB04408EC3337A0A82BF7ED0A2D73FBE8EC4CAC7EB26AE25FF3A4B
        F000F50E1E471678D2E2FB2FDF417CF103E44B3ECB8D2E048040BB07DF8CD0E3
        963CF2D6CF107F700C3152BD2C4C059E797987CFA5AB870D62B0D662C7C2294B
        792E4F81EBCDF9BBFCEB973633493826DCC702E0BFB704BE5FDE6E71F66B4F43
        7EEFC5F301F0D90CEB6C26E2F00E250BDC3BC702B0F91DC41691053C190046AD
        B53260CC540ACEA2AB91F3FC7B16491CD88DC8C4E196A2ED2CCCD2292857FF42
        53E6BC3DD4C1A42FB8C2D88E7D072D009EE0A3051F3E3737EBE35761F8024278
        262C90807FD27CF8868DB3FCFF9579486F58469935ABA1F6EBC582B0C0300230
        71AE05E08BF5883D3D9500F8ED3881554319F5E286E2C0D9F94AE42CFDC00270
        700FA2F7FED29A3C034049432DBA02E50F2EFF44753A87310E60CB372779A07A
        5D396C5FE34D4B5BE56C7C85C004EC00A6CF5371F8C63F8CC02DF75B16786719
        E4574A084008E721B0DDC802309E68D706F0390730C50260D4632B33630D0E3A
        0E67DFE1C859B0C68A9BED5F233A6514C58D07B5FE4E00D245BD707AEAF38692
        F4743754690FFB6C0B558792D9D715727D5DF0E7D7D1F8DDA5E44E3E1B005920
        9D8467C048643DF4BCE59BFBB62136F356385C2ED42514B3368E0500EE4237DC
        81E0A412DB02E4420BEE17415C9FADEA9F8D6804DE29739135EE3EF14D6ADD0A
        24163ED84051922223D66B004E4D5C082D6A4C57D26C21FBEA9BEF88D1D81386
        276B66C19E8D68F1DE12A271A7C5421C396F2C4239C859F211155605A43003D5
        337E0D76E05BAA18EB05582D955A2EE4197A2BB28A9FB6007CFA16598062C01B
        F891F66D10449B06950F39ABBF80ABB099F82642DA57B77DD52088253585EA6B
        46E0E4D8190426F905355AD7B1761D3A62CAB4E9EBBB5CDD6F5470C726B4FD78
        11951256021300841B252820295BDE78B79828B9FBCF88CD1E0727155AB5656E
        3D0002349502CE3645620EBDEC308C8A72EBDDFA00EC6B231286EBFE12E48C9F
        6AF9FFDE6D884EFE37EB7D49B20D4D151625D45303C6E0D4A8FB21C9C913A954
        BCA378F4ECEF7EBFB54BAFDE7D5C540D76FDEC19B1532016B1DD88BA77E25FB2
        C233EF43CA6F221609AF5B0675D56C38381B091066032AE5A58428DE78A03908
        28752856E2AA47B99C7DA8A43687DC82FC275FA6B4E210F72DED6F11492D233C
        3F99648123D7DD81CAE177410D57C61E9A7A8F00202D7A61C5F60E5D7B76378E
        ECC1D5EFCD8533E4243F56EB00D86CE4EE791DB21E592E04E23284DF7E19EADA
        85543490602E4F8364D6A0BC30CFBFCFEB242D4975D4F563913BFD19387D56DB
        985CB100C9E5F349F82C589D911DC0749DA27675FF88FB90E83F126AA44A9EFC
        9B715DF853E7C2252F7FD7BE4BF7EEA9D3C7D1EFB599083672889A4B74460E56
        1BAB825D068D4170F253B559384A9A4AAE2C81E3D85E52B293CA05AB4D6C207C
        C66DB80588490C2A9DF5BC66708F7F1039BFBAB3B683932970E38B1E26B6F2DA
        EE6B2DCCBD2845C5603C4E00C6FC165AF7FE506235A96993EE2CE26F381E2F59
        B4A53BB950A4B202FDD7CD41A374258C4B1B917469DB02F51886E8CEDD8B3AB1
        FF980F29B7B1E5B3721A89AD1F43FEEC6D988777C311AFB1B745ECBCC01B77D2
        82E1269768D101AE8123111C3A9ACA72EB7B50199D583617A9B5CF93023C7571
        C573112F6209C1A9880A3779C2EEDBA8F169DB15897065CDB4491384051C938B
        A76FB8EEFA11C3AB6231F4787F31DA9FFC1E6AE35CB0C664C6A86C37EFA8AD79
        3808A9A039FCBF9A02CFB5A32D15D9AE9D3A530EAD743F8CCAD330623542EB12
        0534CB2B84F3D276F0B66E0F47BD0CA26E270BAE780AEA4EBB1B63F644C2004C
        784069C480262B70E5E562C76DB390D5E4129497951E9B5E7C6F2F1103378DB9
        7DE5B80913EF08A764E46F791B03776F80C6ABC02621B07CD25A44B679ACCEAC
        A25DE4E9BF4D772A1BC6C24556914279B89883F7CAEAAEAD9037AC81B27593D5
        3B644A67C32E93692D89843F48C257C57534712A286FD703276F2E465E300BFB
        F7ECD836EB9169D78A4AA3C795BD1F9B3E73FE930A754AF2A1DD18FCF94BC881
        029D4CC90AC90A05A499A4626987E707BE066F1315629A5842F8B594DB048E96
        E41E1D7B8A33CF19E02CC2FD8F92A111A9867EF228B43DDF423BB4077AF931AB
        D3F2F81AB217017092F03AADF57DB5818AB8815CF2AA6C8786DD034951FD6F40
        B6DF8F4F3E58F7E6CBBF5B324EA8B3D9252DC6CF7FF6A5579C143C69327D932F
        DF40BF333BA18860A21772FC604D82C2553255200F70B1EBC6B71255CD6A4C54
        452425F111A74D58C16CF2D692BFA3A9C2BF99C36591406D805B671E332EBA59
        4DD36CAF3410499BC82647C89354840B5BE0D40D7721A7557BE4E66663F90B4F
        CF7BEF9DFF9E2100783C9E7E4F2D59FE61D3E62D43ACE61C6207BF479F9DEBD1
        DC8843E5250317DC4B02350A80E5D86506DF75E35B89297B2B911764F5D9A67E
        A950AF686BC84A669DE034659A94B28FB4BEA75A174AC8763364390CB85D120E
        F4BD11793DFB521E2A448B66059876DFDDB7EFDAB9E3D54C31D37452F1F475C3
        468CBA26597916AECA9388EFDF8EEB8F7E0EAF9B2895322ECBECC47120D95E0A
        3897B5F31C57AC3DD106E5B10DC6CC745EE6F942D3D9216C6422A99A384442EF
        3AA721A250EF4D4BF89D4C9CB3A0E2D8E557C1D97B30424D2F41568B9670E8C9
        B3B7DC74E3C05432B93F03C0D5ADC755D3E73EFD5F7312C444BED347118D46E1
        FEE16B0CAADA454518717BEDA696CD1204C8E0600814D32D2DB2CCD6A061D4ED
        28D40A0CEB1DD32AFC520A056742475944C7E1B086EA9469E98796F0D0F01180
        2C534545CBB650FB0F47E3DC5CF2F54B51D4A3086B572F7FFD9905F327F0A2B5
        B6BD773A5DDDE72F5EBAE18A9E57B5881CDA073F35EEE7E249F80F6CC580E83E
        6AD25CD09DCEDA325BD43024B0A699242B5DDBC51FB714439D250C1A3A8152E9
        BD645A479818259CD4696E1D51125A25B02CC36CB0F6CEBC92093F7454376F05
        BDEF1034C9CF070B66A3A0A80BF2427E65CCE87F1F75FC58E9477579DA3A3C57
        F5E9FFC8C2E75E9C6510CD2577FD052E554665823AB6233BD13FF20372DD2614
        1E80F66A0609A6A97CE8D0C89D1472853409AAD843E64213C89496D97537A018
        D6569169326B038383AF6BE6E026C1B9B7D6B4E94809B31F0A89FB19057CA05D
        7BB4EAD80E6BD7AC7A7BF1330BEFE029E7C700F871D98CD9F35EBB79ECF83EA9
        534711D9F12D244D414C5111230AEC5CB517ED58544CC877EE3316D088523910
        AE650E42A16B2E6C4AC4B80159B77E2E500CB3F66781CC1E5706006FF679F656
        8241C89DBA21BB5311F17D80F8C301A97121F2DAB6424DE5B93393EEBDEB8658
        2CB62323F08F0148A1EC9C812BFFF0E61B5D7BF46C24971F47C5D6CD30E251D2
        90848AEA2A04CF1E4467F9240A21D3A24C08A60A200D0128B6E6CF03A03704C0
        CB0C836836456C97B8E452CA234528286C023F118744DD583A877C3F3707F939
        59C6AC190FDFF3C3DE3D2BEB0B7C81ED52B8DBB6EF3066F5AB6FBED8AA5DDB00
        95AD38B3F54B248E97525EF223964C217CFA24FCD565B8247906052AD546A439
        21BCF5A38C701F4E89DC6D923600C506202C46926BE4FB94FE90A0A628D5B829
        A4E6972144820729F778088C4ED5E959E610E7C282467875F5B227B77CF905EF
        5195BF0540C44351D76EB7FD7ECDDA459D3A75CA367505F16347A88DAB41EC58
        296A0EED472291449C5A473D528540BC0ABE64043ECAB86ECACA5CAB2AA93ACD
        7F71A2EB14FFE98C52AB4C164B52824B526B99F687A0E7368223BF0081AC1009
        ED86DBE902F3FB7086BE2D253674FB036852D8181BDF5F3FEF9B3F7D5592F1FB
        8B01202CD1AA75EB11ABD6AC5D3CA06FEF96999BD5478FE0D8271F20514ABD34
        DFA7210691B9BB50F322A7A864A0A1CB290A6A954068C2E7555A469348ABBCD2
        248D3BA84DE459DF4DAC267C9C681ABE002A69FE1FCE9EC1D9700DF2F2F2110A
        85929BFFB871C6C103FB96FE58F3170340C4443098D5BDA4A4645671F1D41B33
        37752A176A8E1E46C5EE1D881F3E0085921F2FEEB8E675720D4E8D3C2E549D07
        2D0D1EACE42E06B98449A5844956E035BF19082245B5D0192281231515283F47
        F350694D71C8F3D0F69DDBBE793412A9D9045CE8A78D8B039039F2860E1D3A76
        EEDCB9C5BD7AF56A9BB9299376A3E130315419E45327912C2B855A5D092D11A3
        F25716EC2440D0322A7341A50A57212BC8FE20AAC84D2A289ECE5657235A534D
        2CA680FFC44AD9B5F2F8F1D2E565C78FBE404B94FF2DC12E1680785792A4CB46
        8F1E7DCB03C5C5E3FB5CD3F7729E7FC2D42545281E1254AFA7A81C4F261290A9
        5594297FC8546E27E8EF1825C4583C81288D24B918BF974E25A0F3ED776AC0D3
        04B6BAEADCA963A587DF283F55B64AD3B41F2E5AA89F01A0FED1AC7BF7EED78C
        1C356A44FF0183FAB56CD5BA8DC48393007041635462C739281AB1688CFE8E21
        1E8B73ED925514A814E8296A8AAA2BCF9D3E75F2F85FCA8E1FD9505559B1D930
        8CD29F2BC8DF0B2073F0B4DCA4759BB69DDBB5EF58D4F1F2CEDDF21B15B6F0FA
        03F994EC024A5A7171108978428BD48453E17075754DB8AAFCECE9937BCF559C
        DE4DD77B745D2F038FF3BFF3F8BF02B8D07C7C7B816F51F8A8C611750755A67C
        A346B647127F25287FF682FFEAFFDDE67F016C50E2A033EB011A000000004945
        4E44AE426082}
      OnMouseDown = optionimage0MouseDown
      OnMouseMove = optionimage0MouseMove
    end
    object Shape4: TShape
      Left = 0
      Top = 66
      Width = 576
      Height = 1
      Align = alBottom
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.dll'
    FileName = 'mevp.dll'
    Filter = 
      'Visualizer (MEVP.DLL)|mevp.dll|DLL-Dateien (*.dll)|*.dll|Alle Da' +
      'teien (*.*)|*.*'
    InitialDir = 'C:\SLMEV'
    Options = [ofEnableSizing]
    Left = 217
    Top = 57
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 248
    Top = 57
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 400
    Top = 139
  end
end
