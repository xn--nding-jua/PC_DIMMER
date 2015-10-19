object Form1: TForm1
  Left = 169
  Top = 230
  BorderStyle = bsToolWindow
  Caption = 'DMX-Stream Encoder'
  ClientHeight = 305
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000008888888888888888888888880000000000
    000000000000000000000080000000F7777777777777777777777708000000F0
    F000008F0000008F00000FF0800000F8008C84080FBFB30808D8D088080000F7
    80C8C4400BFBF3300D8D8508808000F8808C84440FBFB33308D8D550880800F7
    80C8C4440BFBF3330D8D8550777000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8808C84440FBFB33308D8D550000000F7
    80C8C4440BFBF3330D8D8550000000F8807774440FBFB33308D8D550000000F7
    80CCC8440BFBF3330D8D8550000000F8780CCC840FBFB33308D8D550000000F7
    8780CCC80BFBF3330D8D8550000000F8787800000FBFB33308D8D550000000F7
    878700000BFBF3330D8D8550000000F8787800000FBFB3330DDDD550000000F7
    878700000BFBF33300DDD850000000F8787800000FBFB333000DDD800000000F
    878700000FFFF3330000000000000000F87800000BBBB7330000000000000000
    0F87000000BBBB73000000000000000000F80000000BBBB70000000000000000
    000F000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFC000003F8000001F8000000F800000078000000380000001800000008000
    0000800000008000000F8000000F8000000F8000000F8000000F8000000F8000
    000F8000000F8000000F8000000F8070000F8070000F8070000F8070040FC070
    060FE07007FFF07807FFF87C07FFFC7E07FFFE7FFFFFFF7FFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 193
    Caption = ' ID-Tag '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 63
      Height = 13
      Caption = 'Identifikation:'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 23
      Height = 13
      Caption = 'Titel:'
    end
    object Label3: TLabel
      Left = 136
      Top = 64
      Width = 62
      Height = 13
      Caption = 'Projektname:'
    end
    object Label4: TLabel
      Left = 8
      Top = 104
      Width = 68
      Height = 13
      Caption = 'Beschreibung:'
    end
    object Label5: TLabel
      Left = 136
      Top = 104
      Width = 23
      Height = 13
      Caption = 'Jahr:'
    end
    object Label6: TLabel
      Left = 8
      Top = 144
      Width = 56
      Height = 13
      Caption = 'Kommentar:'
    end
    object Label7: TLabel
      Left = 136
      Top = 24
      Width = 86
      Height = 13
      Caption = 'Reserviertes Byte:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'TAG'
    end
    object Edit2: TEdit
      Left = 8
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Titel'
    end
    object Edit3: TEdit
      Left = 136
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Projektname'
    end
    object Edit4: TEdit
      Left = 8
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Beschreibung'
    end
    object Edit5: TEdit
      Left = 136
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 4
      Text = '2011'
    end
    object Edit6: TEdit
      Left = 8
      Top = 160
      Width = 249
      Height = 21
      TabOrder = 5
      Text = 'Dies ist ein Demokommentar'
    end
    object Edit7: TEdit
      Left = 136
      Top = 40
      Width = 49
      Height = 21
      Enabled = False
      TabOrder = 6
      Text = '0'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 208
    Width = 265
    Height = 89
    Caption = ' DMX-Stream Einstellungen '
    TabOrder = 1
    object Label8: TLabel
      Left = 8
      Top = 24
      Width = 50
      Height = 13
      Caption = 'Framerate:'
    end
    object Label9: TLabel
      Left = 112
      Top = 24
      Width = 83
      Height = 13
      Caption = 'Keyframeintervall:'
    end
    object Label13: TLabel
      Left = 200
      Top = 24
      Width = 53
      Height = 13
      Caption = 'MaxChans:'
    end
    object frameratebox: TComboBox
      Left = 8
      Top = 40
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = '50 Hz (20ms)'
      OnSelect = framerateboxSelect
      Items.Strings = (
        '50 Hz (20ms)'
        '10 Hz (100ms)'
        '5 Hz (200ms)')
    end
    object usecrcbox: TCheckBox
      Left = 8
      Top = 64
      Width = 177
      Height = 17
      Caption = 'CRC16 Checksumme aktivieren'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object keyframeedit: TEdit
      Left = 112
      Top = 40
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '25'
      OnChange = keyframeeditChange
    end
    object maxchanedit: TEdit
      Left = 200
      Top = 40
      Width = 57
      Height = 21
      TabOrder = 3
      Text = '512'
      OnChange = maxchaneditChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 280
    Top = 8
    Width = 265
    Height = 193
    Caption = ' Encoder-Informationen '
    TabOrder = 2
    object Label10: TLabel
      Left = 8
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Encodierte Frames:'
    end
    object Label11: TLabel
      Left = 8
      Top = 64
      Width = 89
      Height = 33
      AutoSize = False
      Caption = 'Durchschnittliche Kan'#228'le pro Frame:'
      WordWrap = True
    end
    object encodedframeslbl: TLabel
      Left = 120
      Top = 24
      Width = 6
      Height = 13
      Caption = '0'
    end
    object channelsperframelbl: TLabel
      Left = 120
      Top = 78
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label14: TLabel
      Left = 8
      Top = 40
      Width = 106
      Height = 13
      Caption = 'Encodierte Keyframes:'
    end
    object encodedkeyframeslbl: TLabel
      Left = 120
      Top = 40
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label15: TLabel
      Left = 8
      Top = 96
      Width = 89
      Height = 33
      AutoSize = False
      Caption = 'Kan'#228'le pro Keyframe:'
      WordWrap = True
    end
    object channelsperkeyframelbl: TLabel
      Left = 120
      Top = 110
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label25: TLabel
      Left = 8
      Top = 136
      Width = 50
      Height = 13
      Caption = 'Datenrate:'
    end
    object datenratelbl: TLabel
      Left = 120
      Top = 136
      Width = 32
      Height = 13
      Caption = '0 kB/s'
    end
  end
  object GroupBox4: TGroupBox
    Left = 280
    Top = 208
    Width = 265
    Height = 89
    Caption = ' Aufnahmefunktionen '
    TabOrder = 3
    object Label12: TLabel
      Left = 8
      Top = 32
      Width = 23
      Height = 13
      Caption = 'Ziel: '
    end
    object filenameedit: TEdit
      Left = 32
      Top = 28
      Width = 225
      Height = 21
      TabOrder = 0
      Text = 'c:\Demo.dmxs'
    end
    object RecordBtn: TButton
      Left = 8
      Top = 56
      Width = 73
      Height = 25
      Caption = 'Encode'
      TabOrder = 1
      OnClick = RecordBtnClick
    end
    object PauseBtn: TButton
      Left = 88
      Top = 56
      Width = 89
      Height = 25
      Caption = 'Pause/Weiter'
      Enabled = False
      TabOrder = 2
      OnClick = PauseBtnClick
    end
    object StopBtn: TButton
      Left = 184
      Top = 56
      Width = 73
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 3
      OnClick = StopBtnClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 560
    Top = 8
    Width = 249
    Height = 289
    Caption = ' Testpanel '
    TabOrder = 4
    Visible = False
    object Label16: TLabel
      Left = 22
      Top = 165
      Width = 6
      Height = 13
      Caption = '1'
    end
    object Label17: TLabel
      Left = 50
      Top = 165
      Width = 6
      Height = 13
      Caption = '2'
    end
    object Label18: TLabel
      Left = 79
      Top = 165
      Width = 6
      Height = 13
      Caption = '3'
    end
    object Label19: TLabel
      Left = 107
      Top = 165
      Width = 6
      Height = 13
      Caption = '4'
    end
    object Label20: TLabel
      Left = 136
      Top = 165
      Width = 6
      Height = 13
      Caption = '5'
    end
    object Label21: TLabel
      Left = 164
      Top = 165
      Width = 6
      Height = 13
      Caption = '6'
    end
    object Label22: TLabel
      Left = 193
      Top = 165
      Width = 6
      Height = 13
      Caption = '7'
    end
    object Label23: TLabel
      Left = 222
      Top = 165
      Width = 6
      Height = 13
      Caption = '8'
    end
    object Label24: TLabel
      Left = 16
      Top = 256
      Width = 63
      Height = 13
      Caption = 'Kan'#228'le 1-512'
    end
    object ScrollBar1: TScrollBar
      Left = 16
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 44
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 1
      OnChange = ScrollBar2Change
    end
    object ScrollBar3: TScrollBar
      Left = 73
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 2
      OnChange = ScrollBar3Change
    end
    object ScrollBar4: TScrollBar
      Left = 101
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 3
      OnChange = ScrollBar4Change
    end
    object ScrollBar5: TScrollBar
      Left = 130
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 4
      OnChange = ScrollBar5Change
    end
    object ScrollBar6: TScrollBar
      Left = 158
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 5
      OnChange = ScrollBar6Change
    end
    object ScrollBar7: TScrollBar
      Left = 187
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 6
      OnChange = ScrollBar7Change
    end
    object ScrollBar8: TScrollBar
      Left = 216
      Top = 35
      Width = 17
      Height = 121
      Kind = sbVertical
      Max = 255
      PageSize = 0
      Position = 255
      TabOrder = 7
      OnChange = ScrollBar8Change
    end
    object ScrollBar9: TScrollBar
      Left = 16
      Top = 232
      Width = 217
      Height = 17
      Max = 255
      PageSize = 0
      TabOrder = 8
      OnChange = ScrollBar9Change
    end
  end
  object encodertimer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = encodertimerTimer
    Left = 432
    Top = 16
  end
  object XPManifest1: TXPManifest
    Left = 464
    Top = 16
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 432
    Top = 56
  end
end
