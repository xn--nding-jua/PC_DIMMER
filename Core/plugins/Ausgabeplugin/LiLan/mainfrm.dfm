object mainform: Tmainform
  Left = 1221
  Top = 173
  BorderStyle = bsSingle
  Caption = 'LiLAN Konfiguration'
  ClientHeight = 641
  ClientWidth = 505
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 113
    Caption = ' Netzwerkeinstellungen '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 13
      Caption = 'IP-Adresse:'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 57
      Height = 13
      Caption = 'UDP-Port 1:'
    end
    object Label3: TLabel
      Left = 168
      Top = 24
      Width = 79
      Height = 13
      Caption = #220'bermittlungsart:'
    end
    object Label15: TLabel
      Left = 80
      Top = 64
      Width = 57
      Height = 13
      Caption = 'UDP-Port 2:'
    end
    object ipaddressedit: TJvIPAddress
      Left = 8
      Top = 40
      Width = 150
      Height = 21
      Address = -1062731444
      AddressValues.Address = -1062731444
      AddressValues.Value1 = 192
      AddressValues.Value2 = 168
      AddressValues.Value3 = 1
      AddressValues.Value4 = 76
      ParentColor = False
      TabOrder = 0
      Text = '192.168.1.76'
    end
    object udpport1edit: TJvSpinEdit
      Left = 8
      Top = 80
      Width = 65
      Height = 21
      CheckMinValue = True
      Value = 11080.000000000000000000
      TabOrder = 1
    end
    object RadioButton1: TRadioButton
      Left = 168
      Top = 40
      Width = 145
      Height = 17
      Caption = 'An IP-Adresse'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 168
      Top = 56
      Width = 145
      Height = 17
      Caption = 'Broadcasting'
      TabOrder = 3
    end
    object udpport2edit: TJvSpinEdit
      Left = 80
      Top = 80
      Width = 65
      Height = 21
      CheckMinValue = True
      Value = 11081.000000000000000000
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 336
    Top = 8
    Width = 161
    Height = 113
    Caption = ' Antwort '
    TabOrder = 1
    object Shape1: TShape
      Left = 8
      Top = 24
      Width = 145
      Height = 17
      Brush.Color = clBlack
    end
    object Label4: TLabel
      Left = 8
      Top = 48
      Width = 9
      Height = 13
      Caption = '...'
    end
    object Memo1: TMemo
      Left = 8
      Top = 64
      Width = 145
      Height = 41
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 208
    Width = 265
    Height = 121
    Caption = ' Lichtpunkte '
    TabOrder = 2
    object Label6: TLabel
      Left = 136
      Top = 24
      Width = 119
      Height = 13
      Caption = 'Adresse des Lichtpunkts:'
    end
    object Label7: TLabel
      Left = 136
      Top = 40
      Width = 57
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'HIGH'
    end
    object Label8: TLabel
      Left = 200
      Top = 40
      Width = 57
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LOW'
    end
    object AllLightsOffBtn: TButton
      Left = 8
      Top = 88
      Width = 249
      Height = 25
      Caption = 'Alle Lichtpunkte aus'
      TabOrder = 0
      OnClick = AllLightsOffBtnClick
    end
    object LightsOnBtn: TButton
      Left = 8
      Top = 24
      Width = 121
      Height = 25
      Caption = 'Lichtpunkt ein'
      TabOrder = 1
      OnClick = LightsOnBtnClick
    end
    object LightsOffBtn: TButton
      Left = 8
      Top = 56
      Width = 121
      Height = 25
      Caption = 'Lichtpunkt aus'
      TabOrder = 2
      OnClick = LightsOffBtnClick
    end
    object hiaddressedit: TJvSpinEdit
      Left = 136
      Top = 56
      Width = 57
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 3
    end
    object lowaddressedit: TJvSpinEdit
      Left = 200
      Top = 56
      Width = 57
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 4
    end
  end
  object GroupBox4: TGroupBox
    Left = 280
    Top = 208
    Width = 217
    Height = 265
    Caption = ' Statusinfos '
    TabOrder = 3
    object Label9: TLabel
      Left = 8
      Top = 40
      Width = 24
      Height = 13
      Caption = 'Typ: '
    end
    object Label10: TLabel
      Left = 8
      Top = 56
      Width = 41
      Height = 13
      Caption = 'Version: '
    end
    object Label11: TLabel
      Left = 8
      Top = 72
      Width = 39
      Height = 13
      Caption = 'Tasten: '
    end
    object Label12: TLabel
      Left = 80
      Top = 40
      Width = 16
      Height = 13
      Caption = 'IP: '
    end
    object Label13: TLabel
      Left = 80
      Top = 56
      Width = 48
      Height = 13
      Caption = 'Netmask: '
    end
    object Label14: TLabel
      Left = 80
      Top = 72
      Width = 29
      Height = 13
      Caption = 'MAC: '
    end
    object Label16: TLabel
      Left = 8
      Top = 104
      Width = 194
      Height = 13
      Caption = 'Gespeicherte DMX512 Startwerte:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 8
      Top = 120
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label18: TLabel
      Left = 8
      Top = 136
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label19: TLabel
      Left = 8
      Top = 152
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label20: TLabel
      Left = 8
      Top = 168
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label21: TLabel
      Left = 8
      Top = 184
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label22: TLabel
      Left = 8
      Top = 200
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label23: TLabel
      Left = 104
      Top = 120
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label24: TLabel
      Left = 104
      Top = 136
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label25: TLabel
      Left = 104
      Top = 152
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label26: TLabel
      Left = 104
      Top = 168
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label27: TLabel
      Left = 104
      Top = 184
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label28: TLabel
      Left = 104
      Top = 200
      Width = 45
      Height = 13
      Caption = 'Kanal ...: '
    end
    object Label29: TLabel
      Left = 8
      Top = 24
      Width = 147
      Height = 13
      Caption = 'Allgemeine Informationen:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RequestStatusinfosBtn: TButton
      Left = 8
      Top = 232
      Width = 201
      Height = 25
      Caption = 'Statusinfos abfragen'
      TabOrder = 0
      OnClick = RequestStatusinfosBtnClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 336
    Width = 265
    Height = 137
    Caption = ' Tastereing'#228'nge '
    TabOrder = 4
    object Label5: TLabel
      Left = 8
      Top = 84
      Width = 68
      Height = 13
      Caption = 'Tasteninput: 0'
    end
    object ReadKeysBtn: TButton
      Left = 8
      Top = 104
      Width = 249
      Height = 25
      Caption = 'Tasten abfragen'
      TabOrder = 0
      OnClick = ReadKeysBtnClick
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Taste 1'
      Enabled = False
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Taste 2'
      Enabled = False
      TabOrder = 2
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Taste 3'
      Enabled = False
      TabOrder = 3
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Taste 4'
      Enabled = False
      TabOrder = 4
    end
    object CheckBox5: TCheckBox
      Left = 128
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Taste 5'
      Enabled = False
      TabOrder = 5
    end
    object CheckBox6: TCheckBox
      Left = 128
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Taste 6'
      Enabled = False
      TabOrder = 6
    end
    object CheckBox7: TCheckBox
      Left = 128
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Taste 7'
      Enabled = False
      TabOrder = 7
    end
    object CheckBox8: TCheckBox
      Left = 128
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Taste 8'
      Enabled = False
      TabOrder = 8
    end
  end
  object GroupBox6: TGroupBox
    Left = 8
    Top = 480
    Width = 489
    Height = 153
    Caption = ' DMX512 Startwerte setzen '
    TabOrder = 5
    object Label30: TLabel
      Left = 80
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 1:'
    end
    object Label31: TLabel
      Left = 136
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 2:'
    end
    object Label32: TLabel
      Left = 192
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 3:'
    end
    object Label33: TLabel
      Left = 248
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 4:'
    end
    object Label34: TLabel
      Left = 304
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 5:'
    end
    object Label35: TLabel
      Left = 360
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Kanal 6:'
    end
    object Label36: TLabel
      Left = 80
      Top = 72
      Width = 39
      Height = 13
      Caption = 'Kanal 7:'
    end
    object Label37: TLabel
      Left = 136
      Top = 72
      Width = 39
      Height = 13
      Caption = 'Kanal 8:'
    end
    object Label38: TLabel
      Left = 192
      Top = 72
      Width = 39
      Height = 13
      Caption = 'Kanal 9:'
    end
    object Label39: TLabel
      Left = 248
      Top = 72
      Width = 45
      Height = 13
      Caption = 'Kanal 10:'
    end
    object Label40: TLabel
      Left = 304
      Top = 72
      Width = 45
      Height = 13
      Caption = 'Kanal 11:'
    end
    object Label41: TLabel
      Left = 360
      Top = 72
      Width = 45
      Height = 13
      Caption = 'Kanal 12:'
    end
    object SetDMX512StartvaluesBtn: TButton
      Left = 8
      Top = 120
      Width = 473
      Height = 25
      Caption = 'DMX512 Startwerte setzen'
      TabOrder = 0
      OnClick = SetDMX512StartvaluesBtnClick
    end
    object JvSpinEdit1: TJvSpinEdit
      Left = 80
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 1
    end
    object JvSpinEdit2: TJvSpinEdit
      Left = 136
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 2
    end
    object JvSpinEdit3: TJvSpinEdit
      Left = 192
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 3
    end
    object JvSpinEdit4: TJvSpinEdit
      Left = 248
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 4
    end
    object JvSpinEdit5: TJvSpinEdit
      Left = 304
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 5
    end
    object JvSpinEdit6: TJvSpinEdit
      Left = 360
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 6
    end
    object JvSpinEdit7: TJvSpinEdit
      Left = 80
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 7
    end
    object JvSpinEdit8: TJvSpinEdit
      Left = 136
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 8
    end
    object JvSpinEdit9: TJvSpinEdit
      Left = 192
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 9
    end
    object JvSpinEdit10: TJvSpinEdit
      Left = 248
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 10
    end
    object JvSpinEdit11: TJvSpinEdit
      Left = 304
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 11
    end
    object JvSpinEdit12: TJvSpinEdit
      Left = 360
      Top = 92
      Width = 49
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 12
    end
  end
  object GroupBox8: TGroupBox
    Left = 8
    Top = 128
    Width = 489
    Height = 73
    Caption = ' Einstellungen '
    TabOrder = 6
    object Label44: TLabel
      Left = 8
      Top = 24
      Width = 110
      Height = 13
      Caption = 'Letzter DMX512-Kanal:'
    end
    object Label45: TLabel
      Left = 240
      Top = 24
      Width = 40
      Height = 13
      Caption = 'Intervall:'
    end
    object Label46: TLabel
      Left = 291
      Top = 43
      Width = 13
      Height = 13
      Caption = 'ms'
    end
    object Label47: TLabel
      Left = 128
      Top = 24
      Width = 97
      Height = 13
      Caption = 'Letzter Q-Bus-Kanal:'
    end
    object LastDMX512ChannelEdit: TJvSpinEdit
      Left = 8
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 127.000000000000000000
      MinValue = 3.000000000000000000
      Value = 127.000000000000000000
      TabOrder = 0
    end
    object TxIntervalEdit: TJvSpinEdit
      Left = 240
      Top = 40
      Width = 49
      Height = 21
      MaxValue = 10000.000000000000000000
      MinValue = 25.000000000000000000
      Value = 50.000000000000000000
      TabOrder = 1
      OnChange = TxIntervalEditChange
    end
    object SendDMXCheckbox: TCheckBox
      Left = 328
      Top = 16
      Width = 105
      Height = 17
      Caption = 'Sende DMX512'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object SendQBusCheckbox: TCheckBox
      Left = 328
      Top = 32
      Width = 105
      Height = 17
      Caption = 'Sende Q-Bus'
      TabOrder = 3
    end
    object LastQBusChannelEdit: TJvSpinEdit
      Left = 128
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 80.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 4
    end
    object ReadTastenCheckbox: TCheckBox
      Left = 328
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Lesen Tasten'
      TabOrder = 5
    end
  end
  object udp: TIdUDPClient
    Port = 0
    Left = 304
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 150
    OnTimer = Timer1Timer
    Left = 464
    Top = 16
  end
  object XPManifest1: TXPManifest
    Left = 272
    Top = 8
  end
  object SendTimer: TCHHighResTimer
    OnTimer = SendTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = False
    Left = 464
    Top = 128
  end
end
