object Form1: TForm1
  Left = 501
  Top = 186
  BorderStyle = bsSingle
  Caption = 'PC_DIMMER Plugintester'
  ClientHeight = 527
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000232E0000232E000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000001616
    160D000000880000008F00000089000000930404046900000000000000000000
    0000000000000000000000000000000000000000000000000000000000001717
    1763000000FF000000FF000000FF000000FF050505FF00000002000000000000
    0038000000650000005D0000005D0000005D0000005D0000005E000000470000
    00A6C2C2C2FFC0C0C0FFB9B9B9FFD2D2D2FF4B4B4BFC0000005E00000000757A
    7AEEE4E2E2FFCECBCBFFD2D4D4FFD5D8D8FFD8D9D9FFD8D4D4FFE1E2E2FF9196
    96FFD6D6D6FFEAEAEAFFE4E4E4FFF0F0F0FFABABABFF515151FB0000000E8BA0
    A0D8F56363FFB80000FFAF0909FFA10909FF940909FF770000FFAD5959FFAFB9
    B9FFA6A7A7FFC0C0C0FFBABABAFFC0C0C0FFAAAAAAFF6B6B6BEF000000077B97
    97D6EC4E4EFFB70000FFAE0000FFA10000FF950000FF790000FFA43F3FFFACBC
    BCFFE0E2E2FFFBFBFBFFF4F4F4FFFEFEFEFFBCBCBCFF606060EC000000077996
    96D6F65353FFC90000FFBE0000FFB10000FFA60000FF8C0000FFB54949FFA9B9
    B9FFB5B8B8FFD1D0D0FFCDCDCDFFD1D1D1FFA9A9A9FF656565EC000000077594
    94D6FF5151FFD80000FFCD0000FFBF0000FFB50000FF9C0000FFC34A4AFF97A8
    A8FF323535FF464545FF424242FF404040FF737373FF717171EC000000077290
    90D7FF4747FFF60000FFE50000FFD60000FFC70000FFAF0000FFCC3A3AFFB0C1
    C1FFF9FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCBFF636363EF000000096A74
    74F6F4D0D0FFEAB8B8FFE8C2C2FFE8C4C4FFE9C7C7FFE7C2C2FFF7DBDBFF9BA1
    A1FFC7C8C8FFDCDCDCFFD5D5D5FFE2E2E2FFB0B0B0FF606060F8000000072C2C
    2C3F101F1F541129294F1428284F1628284F1729294F1829294F162121402626
    269DB7B7B7FFB7B7B7FFAEAEAEFFCECECEFF505050FB0000004F000000000000
    0000000000000000000000000000000000000000000000000000000000002120
    2066FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B6B6BFA00000000000000000000
    0000000000000000000000000000000000000000000000000000000000002F2F
    2F5CB5B5B5FFB2B2B2FFB1B1B1FFBEBEBEFF535353D300000000000000000000
    0000000000000000000000000000000000000000000000000000000000003A3A
    3A232525259C21212195222222932727279E1F1F1F6500000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FF870000FF830000FF030000000100000001000000010000000100000001
    00000001000000010000FF030000FF830000FF830000FF87FFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 8
    Top = 8
    Width = 175
    Height = 16
    Caption = 'PC_DIMMER Plugintester'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 8
    Top = 24
    Width = 146
    Height = 13
    Caption = '(c) 2009-2015 Christian N'#246'ding'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 248
    Width = 345
    Height = 97
    Caption = ' Nachrichtensystem '
    TabOrder = 0
    Visible = False
    object Label15: TLabel
      Left = 8
      Top = 24
      Width = 286
      Height = 13
      Caption = 'Bitte entsprechend die Datei messagesystem.pas einsehen...'
    end
    object Label16: TLabel
      Left = 144
      Top = 48
      Width = 27
      Height = 13
      Caption = 'MSG:'
    end
    object Label17: TLabel
      Left = 192
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Data1:'
    end
    object Label18: TLabel
      Left = 240
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Data2:'
    end
    object Button2: TButton
      Left = 8
      Top = 64
      Width = 129
      Height = 25
      Caption = 'DLLSendMessage'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Edit6: TEdit
      Left = 144
      Top = 64
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '14'
    end
    object Edit7: TEdit
      Left = 192
      Top = 64
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object Edit8: TEdit
      Left = 240
      Top = 64
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '255'
    end
  end
  object GroupBox2: TGroupBox
    Left = 360
    Top = 248
    Width = 345
    Height = 97
    Caption = ' Infos '
    TabOrder = 1
    Visible = False
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 329
      Height = 73
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 360
    Top = 88
    Width = 345
    Height = 153
    Caption = ' Kanalwerte zur DLL senden '
    TabOrder = 2
    Visible = False
    object Label7: TLabel
      Left = 8
      Top = 32
      Width = 30
      Height = 13
      Caption = 'Kanal:'
    end
    object Label9: TLabel
      Left = 56
      Top = 32
      Width = 45
      Height = 13
      Caption = 'Startwert:'
    end
    object Label10: TLabel
      Left = 104
      Top = 32
      Width = 42
      Height = 13
      Caption = 'Endwert:'
    end
    object Label11: TLabel
      Left = 152
      Top = 32
      Width = 43
      Height = 13
      Caption = 'Zeit [ms]:'
    end
    object Label12: TLabel
      Left = 208
      Top = 32
      Width = 56
      Height = 13
      Caption = 'Kanalname:'
    end
    object btnDLLSenddata: TButton
      Left = 8
      Top = 88
      Width = 329
      Height = 25
      Caption = 'DLLSendData'
      TabOrder = 0
      OnClick = btnDLLSenddataClick
    end
    object Edit1: TEdit
      Left = 8
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object Edit2: TEdit
      Left = 56
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Edit3: TEdit
      Left = 104
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '255'
    end
    object Edit4: TEdit
      Left = 152
      Top = 48
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '5000'
    end
    object Edit5: TEdit
      Left = 208
      Top = 48
      Width = 129
      Height = 21
      TabOrder = 5
      Text = 'Kanalname'
    end
    object Button1: TButton
      Left = 8
      Top = 120
      Width = 329
      Height = 25
      Caption = 'DLLIsSending (um Feedbacks z.B. bei DMX-In zu vermeiden)'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 88
    Width = 345
    Height = 153
    Caption = ' Generelle Pluginfunktionen '
    TabOrder = 3
    Visible = False
    object btnDLLActivate: TButton
      Left = 8
      Top = 24
      Width = 161
      Height = 25
      Caption = 'DLLCreate + DLLStart'
      TabOrder = 0
      OnClick = btnDLLActivateClick
    end
    object btnDLLDeactivate: TButton
      Left = 176
      Top = 24
      Width = 161
      Height = 25
      Caption = 'DLLDestroy'
      TabOrder = 1
      OnClick = btnDLLDeactivateClick
    end
    object btnDLLIdentify: TButton
      Left = 8
      Top = 56
      Width = 161
      Height = 25
      Caption = 'DLLIdentify'
      TabOrder = 2
      OnClick = btnDLLIdentifyClick
    end
    object btnDLLGetVersion: TButton
      Left = 176
      Top = 56
      Width = 161
      Height = 25
      Caption = 'DLLGetVersion'
      TabOrder = 3
      OnClick = btnDLLGetVersionClick
    end
    object btnDLLGetName: TButton
      Left = 176
      Top = 88
      Width = 161
      Height = 25
      Caption = 'DLLGetName'
      TabOrder = 4
      OnClick = btnDLLGetNameClick
    end
    object btnDLLAbout: TButton
      Left = 8
      Top = 88
      Width = 161
      Height = 25
      Caption = 'DLLAbout (nur Outputplugin)'
      TabOrder = 5
      OnClick = btnDLLAboutClick
    end
    object btnDLLConfigure: TButton
      Left = 8
      Top = 120
      Width = 161
      Height = 25
      Caption = 'DLLConfigure (nur Outputplugin)'
      TabOrder = 6
      OnClick = btnDLLConfigureClick
    end
    object Button6: TButton
      Left = 176
      Top = 120
      Width = 161
      Height = 25
      Caption = 'DLLShow (nur Programmplugin)'
      TabOrder = 7
      OnClick = Button6Click
    end
  end
  object Button3: TButton
    Left = 8
    Top = 496
    Width = 129
    Height = 25
    Caption = 'Beenden'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 48
    Width = 169
    Height = 25
    Caption = 'Plugin laden'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 184
    Top = 48
    Width = 161
    Height = 25
    Caption = 'Plugin schlie'#223'en'
    TabOrder = 6
    Visible = False
    OnClick = Button5Click
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 352
    Width = 697
    Height = 137
    Caption = ' Faderpanel '
    TabOrder = 7
    Visible = False
    object ScrollBar1: TScrollBar
      Left = 8
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 36
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 1
      OnChange = ScrollBar1Change
    end
    object ScrollBar3: TScrollBar
      Left = 65
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 2
      OnChange = ScrollBar1Change
    end
    object ScrollBar4: TScrollBar
      Left = 94
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 3
      OnChange = ScrollBar1Change
    end
    object ScrollBar5: TScrollBar
      Left = 123
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 4
      OnChange = ScrollBar1Change
    end
    object ScrollBar6: TScrollBar
      Left = 151
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 5
      OnChange = ScrollBar1Change
    end
    object ScrollBar7: TScrollBar
      Left = 180
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 6
      OnChange = ScrollBar1Change
    end
    object ScrollBar8: TScrollBar
      Left = 209
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 7
      OnChange = ScrollBar1Change
    end
    object ScrollBar9: TScrollBar
      Left = 238
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 8
      OnChange = ScrollBar1Change
    end
    object ScrollBar10: TScrollBar
      Left = 267
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 9
      OnChange = ScrollBar1Change
    end
    object ScrollBar11: TScrollBar
      Left = 295
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 10
      OnChange = ScrollBar1Change
    end
    object ScrollBar12: TScrollBar
      Left = 324
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 11
      OnChange = ScrollBar1Change
    end
    object ScrollBar13: TScrollBar
      Left = 353
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 12
      OnChange = ScrollBar1Change
    end
    object ScrollBar14: TScrollBar
      Left = 382
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 13
      OnChange = ScrollBar1Change
    end
    object ScrollBar15: TScrollBar
      Left = 410
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 14
      OnChange = ScrollBar1Change
    end
    object ScrollBar16: TScrollBar
      Left = 439
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 15
      OnChange = ScrollBar1Change
    end
    object ScrollBar17: TScrollBar
      Left = 468
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 16
      OnChange = ScrollBar1Change
    end
    object ScrollBar18: TScrollBar
      Left = 497
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 17
      OnChange = ScrollBar1Change
    end
    object ScrollBar19: TScrollBar
      Left = 526
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 18
      OnChange = ScrollBar1Change
    end
    object ScrollBar20: TScrollBar
      Left = 554
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 19
      OnChange = ScrollBar1Change
    end
    object ScrollBar21: TScrollBar
      Left = 583
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 20
      OnChange = ScrollBar1Change
    end
    object ScrollBar22: TScrollBar
      Left = 612
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 21
      OnChange = ScrollBar1Change
    end
    object ScrollBar23: TScrollBar
      Left = 641
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 22
      OnChange = ScrollBar1Change
    end
    object ScrollBar24: TScrollBar
      Left = 670
      Top = 16
      Width = 20
      Height = 113
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 23
      OnChange = ScrollBar1Change
    end
  end
  object fulluniverseslider: TScrollBar
    Left = 144
    Top = 496
    Width = 561
    Height = 17
    Hint = 'Gesamtes Universe'
    Max = 255
    PageSize = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Visible = False
    OnChange = fulluniversesliderChange
  end
  object XPManifest1: TXPManifest
    Left = 368
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.dll'
    Filter = 'PC_DIMMER2010 Plugins (*.dll)|*.dll|Alle Dateien (*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 336
    Top = 8
  end
end
