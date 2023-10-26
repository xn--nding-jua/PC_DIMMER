object setupform: Tsetupform
  Left = 277
  Top = 292
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 385
  ClientWidth = 1033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 113
    Caption = ' Kommunikationseinstellungen '
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Serieller Anschluss:'
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 46
      Height = 13
      Caption = 'Baudrate:'
    end
    object Label4: TLabel
      Left = 8
      Top = 44
      Width = 152
      Height = 13
      Caption = 'kein serieller Anschluss mehr frei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object baudratechange: TComboBox
      Left = 8
      Top = 80
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '115200'
        '57600'
        '38400'
        '19200'
        '9600')
    end
    object portchange: TComboBox
      Left = 8
      Top = 40
      Width = 337
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16')
    end
    object Button1: TButton
      Left = 208
      Top = 11
      Width = 137
      Height = 25
      Hint = 
        'Falls oben nicht alle verf'#252'gbaren COM-Ports angezeigt werden, k'#246 +
        'nnen hier auf eine alternative Weise die COM-Ports erkannt werde' +
        'n.'
      Caption = 'COM-Ports neu suchen'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 309
      Top = 64
      Width = 35
      Height = 17
      Caption = '?'
      TabOrder = 3
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 200
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Vertausche L/H'
      TabOrder = 4
    end
    object autoconnectcheckbox: TCheckBox
      Left = 200
      Top = 85
      Width = 145
      Height = 17
      Caption = 'Auto-Connect COM-Port'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 128
    Width = 353
    Height = 97
    Caption = ' Sende Werte an folgende Data-In-Kan'#228'le '
    TabOrder = 1
    object Label13: TLabel
      Left = 8
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Temperatur:'
    end
    object Label9: TLabel
      Left = 264
      Top = 24
      Width = 67
      Height = 13
      Caption = '"Heizung-Ein"'
    end
    object Label22: TLabel
      Left = 72
      Top = 24
      Width = 44
      Height = 13
      Caption = 'Minimum:'
    end
    object Label23: TLabel
      Left = 136
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Mittelwert:'
    end
    object Label24: TLabel
      Left = 200
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Maximum:'
    end
    object Label25: TLabel
      Left = 64
      Top = 72
      Width = 190
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Skalierungsfaktor f'#252'r Temperaturwerte:'
    end
    object datainchtemp: TJvSpinEdit
      Left = 8
      Top = 39
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 0
    end
    object datainchon: TJvSpinEdit
      Left = 264
      Top = 39
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      Value = 5.000000000000000000
      TabOrder = 1
    end
    object TempFaktor: TJvSpinEdit
      Left = 264
      Top = 68
      Width = 57
      Height = 21
      MaxValue = 100.000000000000000000
      ValueType = vtFloat
      Value = 10.000000000000000000
      TabOrder = 2
    end
    object datainchmin: TJvSpinEdit
      Left = 72
      Top = 39
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 3
    end
    object datainchmean: TJvSpinEdit
      Left = 136
      Top = 39
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      Value = 3.000000000000000000
      TabOrder = 4
    end
    object datainchmax: TJvSpinEdit
      Left = 200
      Top = 39
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      Value = 4.000000000000000000
      TabOrder = 5
    end
  end
  object Button3: TButton
    Left = 8
    Top = 352
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 368
    Top = 272
    Width = 657
    Height = 73
    Caption = ' Temperaturen und Verbrauch in folgendes Verzeichnis speichern: '
    TabOrder = 3
    object Label10: TLabel
      Left = 8
      Top = 48
      Width = 231
      Height = 13
      Caption = '(Feld leer lassen, um keine Dateien zu speichern)'
    end
    object savefilestoedit: TEdit
      Left = 8
      Top = 24
      Width = 641
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 232
    Width = 353
    Height = 113
    Caption = ' Sonstige Einstellungen '
    TabOrder = 4
    object Label11: TLabel
      Left = 8
      Top = 21
      Width = 164
      Height = 13
      Caption = 'Installierte elektrische Heizleistung:'
    end
    object Label12: TLabel
      Left = 75
      Top = 42
      Width = 17
      Height = 13
      Caption = 'kW'
    end
    object Label14: TLabel
      Left = 192
      Top = 21
      Width = 70
      Height = 13
      Caption = 'Preis pro kWh:'
    end
    object Label15: TLabel
      Left = 259
      Top = 39
      Width = 37
      Height = 13
      Caption = 'ct/kWh'
    end
    object Label16: TLabel
      Left = 8
      Top = 66
      Width = 145
      Height = 13
      Caption = 'Zeit f'#252'r "Delta T"-Berechnung:'
    end
    object Label17: TLabel
      Left = 75
      Top = 87
      Width = 16
      Height = 13
      Caption = 'min'
    end
    object MaxInstalledPowerEdit: TJvSpinEdit
      Left = 8
      Top = 39
      Width = 65
      Height = 21
      CheckMinValue = True
      Value = 7500.000000000000000000
      TabOrder = 0
    end
    object PricePerkWhEdit: TJvSpinEdit
      Left = 192
      Top = 36
      Width = 65
      Height = 21
      CheckMinValue = True
      ValueType = vtFloat
      Value = 28.000000000000000000
      TabOrder = 1
    end
    object TimeForDeltaTEdit: TJvSpinEdit
      Left = 8
      Top = 84
      Width = 65
      Height = 21
      MaxValue = 1000.000000000000000000
      MinValue = 1.000000000000000000
      Value = 15.000000000000000000
      TabOrder = 2
    end
  end
  object GroupBox5: TGroupBox
    Left = 368
    Top = 8
    Width = 657
    Height = 257
    Caption = ' Temperaturquellen '
    TabOrder = 5
    object Label1: TLabel
      Left = 16
      Top = 44
      Width = 25
      Height = 13
      Caption = 'Ch 1:'
    end
    object Label5: TLabel
      Left = 48
      Top = 24
      Width = 30
      Height = 13
      Caption = 'Quelle'
    end
    object Label6: TLabel
      Left = 120
      Top = 24
      Width = 26
      Height = 13
      Caption = 'MSB:'
    end
    object Label7: TLabel
      Left = 176
      Top = 24
      Width = 23
      Height = 13
      Caption = 'LSB:'
    end
    object Label8: TLabel
      Left = 232
      Top = 24
      Width = 25
      Height = 13
      Caption = 'URL:'
    end
    object Label18: TLabel
      Left = 288
      Top = 24
      Width = 34
      Height = 13
      Caption = 'Nutzer:'
    end
    object Label19: TLabel
      Left = 328
      Top = 24
      Width = 46
      Height = 13
      Caption = 'Passwort:'
    end
    object Label20: TLabel
      Left = 384
      Top = 24
      Width = 55
      Height = 13
      Caption = 'Start-String:'
    end
    object Label21: TLabel
      Left = 440
      Top = 24
      Width = 52
      Height = 13
      Caption = 'Stop-String'
    end
    object Label26: TLabel
      Left = 16
      Top = 68
      Width = 25
      Height = 13
      Caption = 'Ch 2:'
    end
    object Label27: TLabel
      Left = 16
      Top = 92
      Width = 25
      Height = 13
      Caption = 'Ch 3:'
    end
    object Label28: TLabel
      Left = 16
      Top = 116
      Width = 25
      Height = 13
      Caption = 'Ch 4:'
    end
    object Label29: TLabel
      Left = 16
      Top = 140
      Width = 25
      Height = 13
      Caption = 'Ch 5:'
    end
    object Label30: TLabel
      Left = 16
      Top = 164
      Width = 25
      Height = 13
      Caption = 'Ch 6:'
    end
    object Label31: TLabel
      Left = 16
      Top = 188
      Width = 25
      Height = 13
      Caption = 'Ch 7:'
    end
    object Label32: TLabel
      Left = 16
      Top = 212
      Width = 25
      Height = 13
      Caption = 'Ch 8:'
    end
    object Label33: TLabel
      Left = 496
      Top = 24
      Width = 43
      Height = 13
      Caption = 't_amb %:'
    end
    object Label34: TLabel
      Left = 600
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Bezeichn.'
    end
    object Label35: TLabel
      Left = 552
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Mitteln'
    end
    object ch1_src: TComboBox
      Left = 48
      Top = 40
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch1_msb: TJvSpinEdit
      Left = 120
      Top = 39
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
    end
    object ch1_lsb: TJvSpinEdit
      Left = 176
      Top = 39
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 2
    end
    object ch1_url: TEdit
      Left = 232
      Top = 40
      Width = 49
      Height = 21
      TabOrder = 3
    end
    object ch1_usr: TEdit
      Left = 288
      Top = 40
      Width = 33
      Height = 21
      TabOrder = 4
    end
    object ch1_pwd: TEdit
      Left = 328
      Top = 40
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 5
    end
    object ch1_start: TEdit
      Left = 384
      Top = 40
      Width = 49
      Height = 21
      TabOrder = 6
    end
    object ch1_stop: TEdit
      Left = 440
      Top = 40
      Width = 49
      Height = 21
      TabOrder = 7
    end
    object ch2_src: TComboBox
      Left = 48
      Top = 64
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 8
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch2_msb: TJvSpinEdit
      Left = 120
      Top = 63
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 9
    end
    object ch2_lsb: TJvSpinEdit
      Left = 176
      Top = 63
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 10
    end
    object ch2_url: TEdit
      Left = 232
      Top = 64
      Width = 49
      Height = 21
      TabOrder = 11
    end
    object ch2_usr: TEdit
      Left = 288
      Top = 64
      Width = 33
      Height = 21
      TabOrder = 12
    end
    object ch2_pwd: TEdit
      Left = 328
      Top = 64
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 13
    end
    object ch2_start: TEdit
      Left = 384
      Top = 64
      Width = 49
      Height = 21
      TabOrder = 14
    end
    object ch2_stop: TEdit
      Left = 440
      Top = 64
      Width = 49
      Height = 21
      TabOrder = 15
    end
    object ch3_src: TComboBox
      Left = 48
      Top = 88
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 16
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch3_msb: TJvSpinEdit
      Left = 120
      Top = 87
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 17
    end
    object ch3_lsb: TJvSpinEdit
      Left = 176
      Top = 87
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 18
    end
    object ch3_url: TEdit
      Left = 232
      Top = 88
      Width = 49
      Height = 21
      TabOrder = 19
    end
    object ch3_usr: TEdit
      Left = 288
      Top = 88
      Width = 33
      Height = 21
      TabOrder = 20
    end
    object ch3_pwd: TEdit
      Left = 328
      Top = 88
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 21
    end
    object ch3_start: TEdit
      Left = 384
      Top = 88
      Width = 49
      Height = 21
      TabOrder = 22
    end
    object ch3_stop: TEdit
      Left = 440
      Top = 88
      Width = 49
      Height = 21
      TabOrder = 23
    end
    object ch4_src: TComboBox
      Left = 48
      Top = 112
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 24
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch4_msb: TJvSpinEdit
      Left = 120
      Top = 111
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 25
    end
    object ch4_lsb: TJvSpinEdit
      Left = 176
      Top = 111
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 26
    end
    object ch4_url: TEdit
      Left = 232
      Top = 112
      Width = 49
      Height = 21
      TabOrder = 27
    end
    object ch4_usr: TEdit
      Left = 288
      Top = 112
      Width = 33
      Height = 21
      TabOrder = 28
    end
    object ch4_pwd: TEdit
      Left = 328
      Top = 112
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 29
    end
    object ch4_start: TEdit
      Left = 384
      Top = 112
      Width = 49
      Height = 21
      TabOrder = 30
    end
    object ch4_stop: TEdit
      Left = 440
      Top = 112
      Width = 49
      Height = 21
      TabOrder = 31
    end
    object ch5_src: TComboBox
      Left = 48
      Top = 136
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 32
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch5_msb: TJvSpinEdit
      Left = 120
      Top = 135
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 33
    end
    object ch5_lsb: TJvSpinEdit
      Left = 176
      Top = 135
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 34
    end
    object ch5_url: TEdit
      Left = 232
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 35
    end
    object ch5_usr: TEdit
      Left = 288
      Top = 136
      Width = 33
      Height = 21
      TabOrder = 36
    end
    object ch5_pwd: TEdit
      Left = 328
      Top = 136
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 37
    end
    object ch5_start: TEdit
      Left = 384
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 38
    end
    object ch5_stop: TEdit
      Left = 440
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 39
    end
    object ch6_src: TComboBox
      Left = 48
      Top = 160
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 40
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch6_msb: TJvSpinEdit
      Left = 120
      Top = 159
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 41
    end
    object ch6_lsb: TJvSpinEdit
      Left = 176
      Top = 159
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 42
    end
    object ch6_url: TEdit
      Left = 232
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 43
    end
    object ch6_usr: TEdit
      Left = 288
      Top = 160
      Width = 33
      Height = 21
      TabOrder = 44
    end
    object ch6_pwd: TEdit
      Left = 328
      Top = 160
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 45
    end
    object ch6_start: TEdit
      Left = 384
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 46
    end
    object ch6_stop: TEdit
      Left = 440
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 47
    end
    object ch7_src: TComboBox
      Left = 48
      Top = 184
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 48
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch7_msb: TJvSpinEdit
      Left = 120
      Top = 183
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 49
    end
    object ch7_lsb: TJvSpinEdit
      Left = 176
      Top = 183
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 50
    end
    object ch7_url: TEdit
      Left = 232
      Top = 184
      Width = 49
      Height = 21
      TabOrder = 51
    end
    object ch7_usr: TEdit
      Left = 288
      Top = 184
      Width = 33
      Height = 21
      TabOrder = 52
    end
    object ch7_pwd: TEdit
      Left = 328
      Top = 184
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 53
    end
    object ch7_start: TEdit
      Left = 384
      Top = 184
      Width = 49
      Height = 21
      TabOrder = 54
    end
    object ch7_stop: TEdit
      Left = 440
      Top = 184
      Width = 49
      Height = 21
      TabOrder = 55
    end
    object ch8_src: TComboBox
      Left = 48
      Top = 208
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 56
      Text = 'Offline'
      Items.Strings = (
        'Offline'
        'RS232'
        'HTTP'
        'DMX')
    end
    object ch8_msb: TJvSpinEdit
      Left = 120
      Top = 207
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 57
    end
    object ch8_lsb: TJvSpinEdit
      Left = 176
      Top = 207
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 58
    end
    object ch8_url: TEdit
      Left = 232
      Top = 208
      Width = 49
      Height = 21
      TabOrder = 59
    end
    object ch8_usr: TEdit
      Left = 288
      Top = 208
      Width = 33
      Height = 21
      TabOrder = 60
    end
    object ch8_pwd: TEdit
      Left = 328
      Top = 208
      Width = 49
      Height = 21
      PasswordChar = '*'
      TabOrder = 61
    end
    object ch8_start: TEdit
      Left = 384
      Top = 208
      Width = 49
      Height = 21
      TabOrder = 62
    end
    object ch8_stop: TEdit
      Left = 440
      Top = 208
      Width = 49
      Height = 21
      TabOrder = 63
    end
    object ch1_percent: TJvSpinEdit
      Left = 496
      Top = 39
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 64
    end
    object ch2_percent: TJvSpinEdit
      Left = 496
      Top = 63
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 65
    end
    object ch3_percent: TJvSpinEdit
      Left = 496
      Top = 87
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 66
    end
    object ch4_percent: TJvSpinEdit
      Left = 496
      Top = 111
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 67
    end
    object ch5_percent: TJvSpinEdit
      Left = 496
      Top = 135
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 68
    end
    object ch6_percent: TJvSpinEdit
      Left = 496
      Top = 159
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 69
    end
    object ch7_percent: TJvSpinEdit
      Left = 496
      Top = 183
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 70
    end
    object ch8_percent: TJvSpinEdit
      Left = 496
      Top = 207
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 100.000000000000000000
      TabOrder = 71
    end
    object ch1_name: TEdit
      Left = 600
      Top = 40
      Width = 49
      Height = 21
      TabOrder = 72
    end
    object ch2_name: TEdit
      Left = 600
      Top = 64
      Width = 49
      Height = 21
      TabOrder = 73
    end
    object ch3_name: TEdit
      Left = 600
      Top = 88
      Width = 49
      Height = 21
      TabOrder = 74
    end
    object ch4_name: TEdit
      Left = 600
      Top = 112
      Width = 49
      Height = 21
      TabOrder = 75
    end
    object ch5_name: TEdit
      Left = 600
      Top = 136
      Width = 49
      Height = 21
      TabOrder = 76
    end
    object ch6_name: TEdit
      Left = 600
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 77
    end
    object ch7_name: TEdit
      Left = 600
      Top = 184
      Width = 49
      Height = 21
      TabOrder = 78
    end
    object ch8_name: TEdit
      Left = 600
      Top = 208
      Width = 49
      Height = 21
      TabOrder = 79
    end
    object ch1_mean: TJvSpinEdit
      Left = 552
      Top = 39
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 80
    end
    object ch2_mean: TJvSpinEdit
      Left = 552
      Top = 63
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 81
    end
    object ch3_mean: TJvSpinEdit
      Left = 552
      Top = 87
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 82
    end
    object ch4_mean: TJvSpinEdit
      Left = 552
      Top = 111
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 83
    end
    object ch5_mean: TJvSpinEdit
      Left = 552
      Top = 135
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 84
    end
    object ch6_mean: TJvSpinEdit
      Left = 552
      Top = 159
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 85
    end
    object ch7_mean: TJvSpinEdit
      Left = 552
      Top = 183
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 86
    end
    object ch8_mean: TJvSpinEdit
      Left = 552
      Top = 207
      Width = 49
      Height = 21
      Decimal = 0
      MaxValue = 15.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 87
    end
  end
end
