object Form1: TForm1
  Left = 391
  Top = 107
  BorderStyle = bsSingle
  Caption = 'PC_DIMMER Setup-/Diagnoseprogramm'
  ClientHeight = 345
  ClientWidth = 703
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 360
    Height = 329
    Caption = ' Kanalkontrolle '
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 36
      Height = 13
      Caption = 'Kanal 1'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 36
      Height = 13
      Caption = 'Kanal 2'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 36
      Height = 13
      Caption = 'Kanal 3'
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 36
      Height = 13
      Caption = 'Kanal 4'
    end
    object Label5: TLabel
      Left = 16
      Top = 104
      Width = 36
      Height = 13
      Caption = 'Kanal 5'
    end
    object Label6: TLabel
      Left = 16
      Top = 120
      Width = 36
      Height = 13
      Caption = 'Kanal 6'
    end
    object Label7: TLabel
      Left = 16
      Top = 136
      Width = 36
      Height = 13
      Caption = 'Kanal 7'
    end
    object Label8: TLabel
      Left = 16
      Top = 152
      Width = 36
      Height = 13
      Caption = 'Kanal 8'
    end
    object Label9: TLabel
      Left = 152
      Top = 224
      Width = 27
      Height = 13
      Caption = 'Kanal'
    end
    object Label10: TLabel
      Left = 200
      Top = 224
      Width = 22
      Height = 13
      Caption = 'Start'
    end
    object Label11: TLabel
      Left = 248
      Top = 224
      Width = 25
      Height = 13
      Caption = 'Ende'
    end
    object Label12: TLabel
      Left = 296
      Top = 224
      Width = 18
      Height = 13
      Caption = 'Zeit'
    end
    object Label13: TLabel
      Left = 16
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Kanal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 64
      Top = 16
      Width = 64
      Height = 13
      Caption = 'Einzelfader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 16
      Top = 32
      Width = 329
      Height = 1
      Shape = bsTopLine
    end
    object Bevel2: TBevel
      Left = 16
      Top = 240
      Width = 329
      Height = 1
      Shape = bsTopLine
    end
    object Label15: TLabel
      Left = 16
      Top = 224
      Width = 131
      Height = 13
      Caption = 'Automatisches Dimmen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 16
      Top = 280
      Width = 329
      Height = 1
      Shape = bsTopLine
    end
    object Label28: TLabel
      Left = 16
      Top = 288
      Width = 179
      Height = 13
      Caption = 'Programmversion 4.0 vom 30.09.2008'
    end
    object Label29: TLabel
      Left = 16
      Top = 304
      Width = 119
      Height = 13
      Caption = '(c) 2008 Christian N'#246'ding'
    end
    object Bevel4: TBevel
      Left = 16
      Top = 192
      Width = 329
      Height = 1
      Shape = bsTopLine
    end
    object Label30: TLabel
      Left = 16
      Top = 176
      Width = 111
      Height = 13
      Caption = 'Startadressauswahl'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label31: TLabel
      Left = 16
      Top = 200
      Width = 36
      Height = 13
      Caption = 'Kanal 1'
    end
    object Button8: TButton
      Left = 16
      Top = 248
      Width = 125
      Height = 25
      Caption = 'Ausf'#252'hren'
      TabOrder = 0
      OnClick = Button8Click
    end
    object Edit1: TEdit
      Left = 152
      Top = 248
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '1'
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 200
      Top = 248
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      Left = 248
      Top = 248
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '255'
      OnChange = Edit3Change
    end
    object Edit4: TEdit
      Left = 296
      Top = 248
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '5000'
    end
    object ScrollBar1: TScrollBar
      Left = 72
      Top = 40
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 5
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 72
      Top = 56
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 6
      OnChange = ScrollBar1Change
    end
    object ScrollBar3: TScrollBar
      Left = 72
      Top = 72
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 7
      OnChange = ScrollBar1Change
    end
    object ScrollBar4: TScrollBar
      Left = 72
      Top = 88
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 8
      OnChange = ScrollBar1Change
    end
    object ScrollBar5: TScrollBar
      Left = 72
      Top = 104
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 9
      OnChange = ScrollBar1Change
    end
    object ScrollBar6: TScrollBar
      Left = 72
      Top = 120
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 10
      OnChange = ScrollBar1Change
    end
    object ScrollBar7: TScrollBar
      Left = 72
      Top = 136
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 11
      OnChange = ScrollBar1Change
    end
    object ScrollBar8: TScrollBar
      Left = 72
      Top = 152
      Width = 274
      Height = 17
      Max = 255
      PageSize = 25
      SmallChange = 10
      TabOrder = 12
      OnChange = ScrollBar1Change
    end
    object Button1: TButton
      Left = 216
      Top = 296
      Width = 125
      Height = 25
      Caption = 'Beenden'
      TabOrder = 13
      OnClick = Button1Click
    end
    object ScrollBar9: TScrollBar
      Left = 72
      Top = 200
      Width = 273
      Height = 17
      LargeChange = 8
      Max = 127
      PageSize = 0
      TabOrder = 14
      OnChange = ScrollBar9Change
    end
  end
  object GroupBox2: TGroupBox
    Left = 704
    Top = 8
    Width = 193
    Height = 329
    Caption = ' RS232 - Input '
    TabOrder = 1
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 177
      Height = 305
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 376
    Top = 8
    Width = 321
    Height = 257
    Caption = ' PC_DIMMER Ger'#228'tedaten '
    TabOrder = 2
    object Label17: TLabel
      Left = 8
      Top = 24
      Width = 68
      Height = 13
      Caption = 'Beschreibung:'
    end
    object Label18: TLabel
      Left = 8
      Top = 40
      Width = 38
      Height = 13
      Caption = 'Version:'
    end
    object Label19: TLabel
      Left = 8
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Datum:'
    end
    object Label20: TLabel
      Left = 8
      Top = 200
      Width = 82
      Height = 13
      Caption = 'Betriebsfrequenz:'
    end
    object Label21: TLabel
      Left = 8
      Top = 96
      Width = 49
      Height = 13
      Caption = 'Hardware:'
    end
    object Label22: TLabel
      Left = 8
      Top = 112
      Width = 66
      Height = 13
      Caption = 'Taktfrequenz:'
    end
    object Label23: TLabel
      Left = 8
      Top = 128
      Width = 85
      Height = 13
      Caption = #220'bertragungsrate:'
    end
    object Label24: TLabel
      Left = 8
      Top = 144
      Width = 72
      Height = 13
      Caption = 'Ger'#228'teadresse:'
    end
    object Label25: TLabel
      Left = 8
      Top = 184
      Width = 66
      Height = 13
      Caption = 'ZC-Detection:'
    end
    object sinusfrequenz: TLabel
      Left = 96
      Top = 200
      Width = 27
      Height = 13
      Caption = '? Hz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object zerocrossing: TLabel
      Left = 80
      Top = 184
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object adresse: TLabel
      Left = 88
      Top = 144
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object uebertragungsrate: TLabel
      Left = 96
      Top = 128
      Width = 46
      Height = 13
      Caption = '? kBit/s'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object frequenz: TLabel
      Left = 80
      Top = 112
      Width = 37
      Height = 13
      Caption = '? MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object hardware: TLabel
      Left = 64
      Top = 96
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object datum: TLabel
      Left = 48
      Top = 56
      Width = 65
      Height = 13
      Caption = '??.??.????'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object version: TLabel
      Left = 56
      Top = 40
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object beschreibung: TLabel
      Left = 80
      Top = 24
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 8
      Top = 72
      Width = 21
      Height = 13
      Caption = 'Typ:'
    end
    object typ: TLabel
      Left = 32
      Top = 72
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal1: TLabel
      Left = 280
      Top = 24
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label33: TLabel
      Left = 224
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 1:'
    end
    object Label34: TLabel
      Left = 224
      Top = 40
      Width = 39
      Height = 13
      Caption = 'Kanal 2:'
    end
    object Label35: TLabel
      Left = 224
      Top = 56
      Width = 39
      Height = 13
      Caption = 'Kanal 3:'
    end
    object Label36: TLabel
      Left = 224
      Top = 72
      Width = 39
      Height = 13
      Caption = 'Kanal 4:'
    end
    object Label37: TLabel
      Left = 224
      Top = 88
      Width = 39
      Height = 13
      Caption = 'Kanal 5:'
    end
    object Label38: TLabel
      Left = 224
      Top = 104
      Width = 39
      Height = 13
      Caption = 'Kanal 6:'
    end
    object Label39: TLabel
      Left = 224
      Top = 120
      Width = 39
      Height = 13
      Caption = 'Kanal 7:'
    end
    object Label40: TLabel
      Left = 224
      Top = 136
      Width = 39
      Height = 13
      Caption = 'Kanal 8:'
    end
    object kanal2: TLabel
      Left = 280
      Top = 40
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal3: TLabel
      Left = 280
      Top = 56
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal4: TLabel
      Left = 280
      Top = 72
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal5: TLabel
      Left = 280
      Top = 88
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal6: TLabel
      Left = 280
      Top = 104
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal7: TLabel
      Left = 280
      Top = 120
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object kanal8: TLabel
      Left = 280
      Top = 136
      Width = 31
      Height = 13
      Caption = '???%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label32: TLabel
      Left = 8
      Top = 160
      Width = 56
      Height = 13
      Caption = 'Dimmkurve:'
    end
    object dimmkurve: TLabel
      Left = 72
      Top = 160
      Width = 8
      Height = 13
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label41: TLabel
      Left = 192
      Top = 202
      Width = 76
      Height = 13
      Caption = 'zu Startadresse:'
    end
    object Label42: TLabel
      Left = 192
      Top = 184
      Width = 104
      Height = 13
      Caption = 'Startadresse 1 '#228'ndern'
      FocusControl = baudratechange
    end
    object Button2: TButton
      Left = 8
      Top = 224
      Width = 121
      Height = 25
      Caption = 'Hardwareinfo abrufen'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 192
      Top = 152
      Width = 121
      Height = 25
      Caption = 'Kanalwerte abrufen'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 192
      Top = 224
      Width = 121
      Height = 25
      Caption = 'Adresse '#228'ndern'
      TabOrder = 2
      OnClick = Button4Click
    end
    object Edit5: TEdit
      Left = 280
      Top = 200
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '1'
      OnChange = Edit5Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 376
    Top = 272
    Width = 321
    Height = 65
    Caption = ' Serielle Schnittstelle '
    TabOrder = 3
    object Label16: TLabel
      Left = 16
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label27: TLabel
      Left = 168
      Top = 16
      Width = 82
      Height = 13
      Caption = #220'bertragungsrate'
    end
    object portchange: TComboBox
      Left = 16
      Top = 32
      Width = 137
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnCloseUp = portchangeCloseUp
      OnDropDown = portchangeDropDown
      OnSelect = portchangeSelect
    end
    object baudratechange: TComboBox
      Left = 168
      Top = 32
      Width = 137
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = baudratechangeChange
      Items.Strings = (
        '115200'
        '57600'
        '38400'
        '9600')
    end
  end
  object XPManifest1: TXPManifest
    Left = 344
    Top = 8
  end
  object Comport: TCommPortDriver
    Port = pnCustom
    PortName = '\\.\COM1'
    BaudRate = brCustom
    BaudRateValue = 115200
    OnReceiveData = ComportReceiveData
    Left = 280
    Top = 8
  end
end
