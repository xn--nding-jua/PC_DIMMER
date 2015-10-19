object joysticksetupform: Tjoysticksetupform
  Left = 433
  Top = 177
  BorderStyle = bsSingle
  Caption = 'Joystick konfigurieren'
  ClientHeight = 321
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000130B0000130B000000000000000000000000
    00050000000C0000000D0000000A0000000A0000000A0000000A0000000A0000
    000A0000000A0000000A0000000A0000000C0000000E00000008000000010000
    001B0000003A0000003F0000002E0000001F0000001E0000001F0000001F0000
    001F0000001F0000001E00000021000000350000003F000000290000000A0202
    02480D0C0B9D0D0C0BAD000000620000003F0000003400000034000000350000
    003500000034000000350000004800000075151311B50505046C000000141615
    137F504742E872665EFE0A0908AC0000005500000043000000450000004C0000
    004A0000004200000046000000651E1B19CE786A60FF28241FB2000000193833
    2F845B524CE97C6E64FF5A514BF30202028F000000620000006C000000810000
    007C00000063000000660E0D0CB06E6259FD75675FFF433F30B8000000173C36
    326C59504ADD847970FF968B82FF564F4AED17150FC4473A2DDF68503EF2624B
    39EF2C241BD2171513C8736A62F98C8279FF7E736AFF413A37A900000010362D
    2B3B4F4641BB90867EFFAEA7A1FFA69D94FF9C887FFF92655DFF9A8B81FF947A
    71FF93675FFFA1948BFF9F968CFFA59D96FF857B74FF3D392781000000082723
    210E423D3980928880FFACA7A2FF8B8881FFA5766DFFCA655BFF9F827DFFAA77
    6FFFCB675DFF896F6AFF9C9891FFBBB4AEFF817671FC3330174A000000020000
    00012624222F888079F55E5854FF56534FFF81736CFF9E7A72FF9D9188FF9E8C
    83FF9B7871FF726A63FF847E78FF928B84FF615851DA07060614000000000000
    0000000000074B47439B6D6964FF57524EFF7A736CFF878179FF877D76FF8A81
    79FF948E84FF877E77FF756E68FF706A65FF3D37337300000004000000000000
    000000000001232213186C6560C28D8781FF948B82FE7D756CE1625C53BD645F
    56C37E756EE7958C84FF968E87FF534D48AF0B0A090D00000000000000000000
    00000000000000000002483F3B3C6F6762A467605595524C3753403E2E26423F
    332E4E46425D635C57996B635EA0413B362F0000000100000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF00009FFB00008FF1000006E10000800100008001000080030000C003
    0000C0070000E0070000F3CF0000FFFF0000FFFF0000FFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TShape
    Left = 0
    Top = 280
    Width = 929
    Height = 41
    Align = alBottom
    Pen.Style = psClear
  end
  object Shape1: TShape
    Left = 0
    Top = 280
    Width = 929
    Height = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 145
    Height = 265
    Caption = ' Joysticktasten '
    TabOrder = 0
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 129
      Height = 214
      ItemHeight = 13
      Items.Strings = (
        'X-Achse'
        'Y-Achse'
        'Z-Achse'
        'R-Achse'
        'U-Achse'
        'V-Achse'
        'Slider A'
        'Slider B'
        'Hoch'
        'Runter'
        'Rechts'
        'Links'
        'Button 1'
        'Button 2'
        'Button 3'
        'Button 4'
        'Button 5'
        'Button 6'
        'Button 7'
        'Button 8'
        'Button 9'
        'Button 10'
        'Button 11'
        'Button 12'
        'Button 13'
        'Button 14'
        'Button 15'
        'Button 16'
        'Button 17'
        'Button 18'
        'Button 19'
        'Button 20'
        'Button 21'
        'Button 22'
        'Button 23'
        'Button 24'
        'Button 25'
        'Button 26'
        'Button 27'
        'Button 28'
        'Button 29'
        'Button 30'
        'Button 31'
        'Button 32')
      TabOrder = 0
      OnKeyUp = ListBox1KeyUp
      OnMouseUp = ListBox1MouseUp
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 230
      Width = 129
      Height = 17
      Caption = 'Button aktiviert'
      TabOrder = 1
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 246
      Width = 129
      Height = 17
      Caption = 'Kontinuierlich senden'
      TabOrder = 2
      OnMouseUp = CheckBox2MouseUp
    end
  end
  object Button1: TButton
    Left = 16
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object GroupBox3: TGroupBox
    Left = 160
    Top = 200
    Width = 481
    Height = 73
    Caption = ' Achseneinstellungen '
    Enabled = False
    TabOrder = 2
    object Label1: TLabel
      Left = 136
      Top = 24
      Width = 129
      Height = 13
      Caption = 'Geschwindigkeitszunahme:'
    end
    object Label2: TLabel
      Left = 272
      Top = 24
      Width = 3
      Height = 13
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Position absolut'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnMouseUp = RadioButton1MouseUp
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 32
      Width = 113
      Height = 17
      Caption = 'Position relativ'
      TabOrder = 1
      OnMouseUp = RadioButton1MouseUp
    end
    object TrackBar2: TTrackBar
      Left = 128
      Top = 40
      Width = 249
      Height = 25
      Max = 20000
      Min = 1
      Position = 1000
      TabOrder = 2
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar2Change
    end
    object Button2: TButton
      Left = 384
      Top = 40
      Width = 89
      Height = 25
      Caption = 'Zur'#252'cksetzen'
      TabOrder = 3
      OnClick = Button2Click
    end
    object invertaxis: TCheckBox
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Achse invertieren'
      TabOrder = 4
      OnMouseUp = invertaxisMouseUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 160
    Top = 8
    Width = 761
    Height = 185
    Caption = ' Befehl bearbeiten '
    TabOrder = 3
    object Label7: TLabel
      Left = 8
      Top = 19
      Width = 31
      Height = 13
      Caption = 'Name:'
      Enabled = False
    end
    object Label8: TLabel
      Left = 256
      Top = 19
      Width = 68
      Height = 13
      Caption = 'Beschreibung:'
      Enabled = False
    end
    object Label9: TLabel
      Left = 8
      Top = 59
      Width = 63
      Height = 13
      Caption = 'Programmteil:'
    end
    object Label10: TLabel
      Left = 256
      Top = 59
      Width = 52
      Height = 13
      Caption = 'Steuerung:'
    end
    object Label11: TLabel
      Left = 504
      Top = 59
      Width = 102
      Height = 13
      Caption = 'Ger'#228't/Gruppe/Effekt:'
      Visible = False
    end
    object Label12: TLabel
      Left = 664
      Top = 19
      Width = 69
      Height = 13
      Caption = 'Obere Grenze:'
    end
    object Label13: TLabel
      Left = 504
      Top = 19
      Width = 72
      Height = 13
      Caption = 'Untere Grenze:'
    end
    object Label3: TLabel
      Left = 584
      Top = 19
      Width = 74
      Height = 13
      Caption = 'Schaltschwelle:'
    end
    object ZeitBox: TGroupBox
      Left = 584
      Top = 104
      Width = 169
      Height = 73
      Caption = ' Zeiteinstellungen '
      TabOrder = 4
      Visible = False
      object Label14: TLabel
        Left = 8
        Top = 24
        Width = 6
        Height = 13
        Caption = 'h'
      end
      object Label15: TLabel
        Left = 48
        Top = 24
        Width = 16
        Height = 13
        Caption = 'min'
      end
      object Label16: TLabel
        Left = 88
        Top = 24
        Width = 5
        Height = 13
        Caption = 's'
      end
      object Label17: TLabel
        Left = 128
        Top = 24
        Width = 13
        Height = 13
        Caption = 'ms'
      end
      object hEdit: TEdit
        Left = 8
        Top = 40
        Width = 35
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = hEditChange
      end
      object minEdit: TEdit
        Left = 48
        Top = 40
        Width = 35
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = hEditChange
      end
      object sEdit: TEdit
        Left = 88
        Top = 40
        Width = 35
        Height = 21
        TabOrder = 2
        Text = '0'
        OnChange = hEditChange
      end
      object msEdit: TEdit
        Left = 128
        Top = 40
        Width = 35
        Height = 21
        TabOrder = 3
        Text = '0'
        OnChange = hEditChange
      end
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 241
      Height = 21
      Enabled = False
      TabOrder = 0
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 256
      Top = 32
      Width = 241
      Height = 21
      Hint = 
        'Hier besteht die M'#246'glichkeit einen kleinen Beschreibungstext ein' +
        'zugeben.'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = Edit2Change
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 72
      Width = 241
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 2
      OnSelect = ComboBox1Select
    end
    object ComboBox2: TComboBox
      Left = 256
      Top = 72
      Width = 241
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 3
      OnEnter = ComboBox2Enter
      OnExit = ComboBox2Exit
      OnSelect = ComboBox2Select
    end
    object Optionen1Box: TGroupBox
      Left = 8
      Top = 104
      Width = 185
      Height = 73
      Caption = ' Optionen 1 '
      TabOrder = 5
      Visible = False
      object Arg1Label: TLabel
        Left = 8
        Top = 23
        Width = 28
        Height = 13
        Caption = 'Arg 1:'
      end
      object Arg1Edit: TEdit
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Arg1EditChange
      end
      object Arg1Combobox: TComboBox
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        OnSelect = Arg1ComboboxSelect
      end
    end
    object Optionen2Box: TGroupBox
      Left = 200
      Top = 104
      Width = 185
      Height = 73
      Caption = ' Optionen 2 '
      TabOrder = 6
      Visible = False
      object Arg2Label: TLabel
        Left = 8
        Top = 23
        Width = 28
        Height = 13
        Caption = 'Arg 2:'
      end
      object Arg2Edit: TEdit
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Arg2EditChange
      end
      object Arg2Combobox: TComboBox
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        OnSelect = Arg2ComboboxSelect
      end
    end
    object devicelist: TComboBox
      Left = 504
      Top = 72
      Width = 249
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 7
      Visible = False
      OnSelect = devicelistSelect
    end
    object Optionen3Box: TGroupBox
      Left = 392
      Top = 104
      Width = 185
      Height = 73
      Caption = ' Optionen 3 '
      TabOrder = 8
      Visible = False
      object Arg3Label: TLabel
        Left = 8
        Top = 23
        Width = 28
        Height = 13
        Caption = 'Arg 3:'
      end
      object Arg3Edit: TEdit
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Arg3EditChange
      end
      object Arg3Combobox: TComboBox
        Left = 8
        Top = 40
        Width = 169
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        OnSelect = Arg3ComboboxSelect
      end
    end
    object OffValue: TJvSpinEdit
      Left = 504
      Top = 32
      Width = 73
      Height = 21
      MaxValue = 254.000000000000000000
      TabOrder = 9
      OnChange = OffValueChange
    end
    object OnValue: TJvSpinEdit
      Left = 664
      Top = 32
      Width = 89
      Height = 21
      MaxValue = 255.000000000000000000
      MinValue = 1.000000000000000000
      Value = 255.000000000000000000
      TabOrder = 10
      OnChange = OnValueChange
    end
    object grouplist: TComboBox
      Left = 504
      Top = 72
      Width = 249
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 11
      Visible = False
      OnSelect = grouplistSelect
    end
    object effektlist: TComboBox
      Left = 504
      Top = 72
      Width = 249
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 12
      Visible = False
      OnSelect = effektlistSelect
    end
    object SwitchValue: TJvSpinEdit
      Left = 584
      Top = 32
      Width = 73
      Height = 21
      MaxValue = 255.000000000000000000
      Value = 128.000000000000000000
      TabOrder = 13
      OnChange = SwitchValueChange
    end
    object ScaleValue: TCheckBox
      Left = 664
      Top = 53
      Width = 89
      Height = 17
      Caption = 'Skaliere Wert'
      TabOrder = 14
      OnMouseUp = ScaleValueMouseUp
    end
    object InvertSwitchValue: TCheckBox
      Left = 616
      Top = 53
      Width = 41
      Height = 17
      Caption = '<='
      TabOrder = 15
      OnMouseUp = InvertSwitchValueMouseUp
    end
  end
end
