object devicechannelselectionform: Tdevicechannelselectionform
  Left = 528
  Top = 94
  Width = 664
  Height = 475
  Caption = 'Ger'#228'tekanalauswahl'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 88
    Top = 200
    Width = 134
    Height = 13
    Caption = 'Ger'#228'teliste wird aktualisiert...'
  end
  object Panel1: TPanel
    Left = 0
    Top = 412
    Width = 656
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object OKBtn: TButton
      Left = 8
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 88
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Abbrechen'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 317
    Top = 33
    Width = 339
    Height = 379
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 153
      Height = 161
      Caption = ' Kanaleinstellungen: '
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 24
        Width = 75
        Height = 13
        Caption = 'Aktuelles Ger'#228't:'
      end
      object Label3: TLabel
        Left = 8
        Top = 40
        Width = 13
        Height = 13
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 8
        Top = 56
        Width = 74
        Height = 13
        Caption = 'Aktueller Kanal:'
      end
      object Label5: TLabel
        Left = 8
        Top = 72
        Width = 13
        Height = 13
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 7
        Top = 116
        Width = 69
        Height = 13
        Caption = 'Wert [%/Byte]:'
      end
      object Label6: TLabel
        Left = 79
        Top = 116
        Width = 56
        Height = 13
        Caption = 'Wert [Byte]:'
        Visible = False
      end
      object Label7: TLabel
        Left = 79
        Top = 117
        Width = 52
        Height = 13
        Caption = 'Delay [ms]:'
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Kanal aktiviert'
        TabOrder = 0
        OnMouseUp = CheckBox1MouseUp
      end
      object Edit2: TEdit
        Left = 8
        Top = 132
        Width = 33
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = '0'
        OnKeyUp = Edit2KeyUp
      end
      object Edit3: TEdit
        Left = 40
        Top = 132
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
        OnKeyUp = Edit3KeyUp
      end
      object Edit4: TEdit
        Left = 80
        Top = 132
        Width = 65
        Height = 21
        TabOrder = 3
        Text = '0'
        OnKeyUp = Edit4KeyUp
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 176
      Width = 153
      Height = 57
      Caption = ' Gesamte Auswahl: '
      TabOrder = 1
      object Button1: TButton
        Left = 8
        Top = 24
        Width = 137
        Height = 25
        Caption = 'Alle Ger'#228'te deaktivieren'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 240
      Width = 153
      Height = 121
      Caption = ' Zusatzoptionen: '
      TabOrder = 2
      object Button4: TButton
        Left = 8
        Top = 56
        Width = 137
        Height = 25
        Hint = 'Setzt selektierte Werte auf den aktuellen Kanalwert'
        Caption = 'Selektierte Kan'#228'le -> Wert'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Button4Click
        OnMouseUp = Button4MouseUp
      end
      object Button9: TButton
        Left = 8
        Top = 24
        Width = 137
        Height = 25
        Caption = 'Aktivierte Kan'#228'le ->'
        TabOrder = 1
        OnMouseUp = Button9MouseUp
      end
      object Button3: TButton
        Left = 8
        Top = 88
        Width = 137
        Height = 25
        Caption = 'Gesamte Szene ->'
        TabOrder = 2
        OnMouseUp = Button3MouseUp
      end
    end
    object GroupBox4: TGroupBox
      Left = 171
      Top = 8
      Width = 158
      Height = 353
      Caption = ' Ge'#228'nderte Kan'#228'le '
      TabOrder = 3
      object ListBox2: TListBox
        Left = 8
        Top = 16
        Width = 137
        Height = 297
        ItemHeight = 13
        TabOrder = 0
      end
      object Button15: TButton
        Left = 8
        Top = 320
        Width = 137
        Height = 25
        Caption = 'Liste zur'#252'cksetzen'
        TabOrder = 1
        OnClick = Button15Click
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 656
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Edit1: TEdit
      Left = 8
      Top = 8
      Width = 233
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Suchtext hier eingeben...'
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
      OnKeyUp = Edit1KeyUp
    end
    object Button6: TButton
      Left = 243
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Klappt alle Elemente ein'
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button6Click
    end
    object Button5: TButton
      Left = 291
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Klappt alle Elemente aus'
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button5Click
    end
    object Button7: TButton
      Left = 267
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Klappt nur aktive Elemente aus'
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button7Click
    end
    object ShowDDFCheckbox: TCheckBox
      Left = 320
      Top = 8
      Width = 97
      Height = 17
      Caption = 'DDF anzeigen'
      TabOrder = 4
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 33
    Width = 8
    Height = 379
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
  end
  object VST: TVirtualStringTree
    Left = 8
    Top = 33
    Width = 309
    Height = 379
    Align = alClient
    DrawSelectionMode = smBlendedRectangle
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    Images = MainForm.PngImageList1
    TabOrder = 4
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight, toEditOnClick]
    TreeOptions.PaintOptions = [toShowBackground, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toSimpleDrawSelection]
    OnDblClick = VSTDblClick
    OnGetText = VSTGetText
    OnPaintText = VSTPaintText
    OnGetImageIndex = VSTGetImageIndex
    OnKeyUp = VSTKeyUp
    OnMouseUp = VSTMouseUp
    Columns = <
      item
        CheckType = ctTriStateCheckBox
        CheckBox = True
        Position = 0
        Width = 200
        WideText = 'Ger'#228'te'
      end
      item
        Position = 1
        Width = 40
        WideText = 'Wert'
      end
      item
        Position = 2
        Width = 40
        WideText = 'Delay'
      end>
  end
  object activatedmenu: TPopupMenu
    Left = 410
    Top = 288
    object AktuelleWerte1: TMenuItem
      Caption = '...auf aktuelle Kanalwerte'
      OnClick = AktuelleWerte1Click
    end
    object deaktivieren1: TMenuItem
      Caption = '...deaktivieren'
      OnClick = Button1Click
    end
  end
  object selectedmenu: TPopupMenu
    Left = 410
    Top = 322
    object AktuellerKanalwert1: TMenuItem
      Caption = '...auf aktuelle Kanalwerte'
      Hint = 'Setzt alle selektierten Kan'#228'le auf aktuelle Werte'
      OnClick = AktuellerKanalwert1Click
    end
  end
  object wholescenemenu: TPopupMenu
    Left = 410
    Top = 354
    object beinhaltetnurseitletzterSzenegenderteKanle1: TMenuItem
      Caption = '...beinhaltet nur seit letzter Szene ge'#228'nderte Kan'#228'le'
      OnClick = beinhaltetnurseitletzterSzenegenderteKanle1Click
    end
    object beinhaltetnurderzeitselektierteGerte1: TMenuItem
      Caption = '...beinhaltet nur derzeit selektierte Ger'#228'te'
      OnClick = beinhaltetnurderzeitselektierteGerte1Click
    end
    object beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1: TMenuItem
      Caption = 
        '...beinhaltet seit letzter Szene ge'#228'nderte Kan'#228'le und aktuell se' +
        'lektierte Ger'#228'te'
      OnClick = beinhaltetseitletzterSzenegenderteKanleundaktuellselektierteGerte1Click
    end
    object beinhaltetalleKanle1: TMenuItem
      Caption = '...beinhaltet alle Kan'#228'le'
      OnClick = beinhaltetalleKanle1Click
    end
  end
  object ChangedChannels: TTimer
    Enabled = False
    Interval = 250
    OnTimer = ChangedChannelsTimer
    Left = 608
    Top = 56
  end
end
