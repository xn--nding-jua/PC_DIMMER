object setupform: Tsetupform
  Left = 188
  Top = 143
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 337
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
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
    object Label5: TLabel
      Left = 112
      Top = 64
      Width = 33
      Height = 13
      Caption = 'Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object statuslabel: TLabel
      Left = 112
      Top = 83
      Width = 233
      Height = 13
      AutoSize = False
      Caption = 'Nicht verbunden...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
      OnSelect = baudratechangeSelect
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
      OnSelect = portchangeSelect
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
  object GroupBox5: TGroupBox
    Left = 368
    Top = 128
    Width = 353
    Height = 97
    Caption = ' Empfange Temperaturen von folgenden PC_DIMMER-Kan'#228'len '
    TabOrder = 2
    object Label28: TLabel
      Left = 32
      Top = 32
      Width = 26
      Height = 13
      Caption = 'MSB:'
    end
    object Label30: TLabel
      Left = 96
      Top = 32
      Width = 23
      Height = 13
      Caption = 'LSB:'
    end
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Temperatur 2:'
    end
    object Label6: TLabel
      Left = 192
      Top = 16
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Temperatur 3:'
    end
    object Label7: TLabel
      Left = 192
      Top = 32
      Width = 26
      Height = 13
      Caption = 'MSB:'
    end
    object Label8: TLabel
      Left = 256
      Top = 32
      Width = 23
      Height = 13
      Caption = 'LSB:'
    end
    object temp2_msb: TJvSpinEdit
      Left = 32
      Top = 47
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 61.000000000000000000
      TabOrder = 0
    end
    object temp2_lsb: TJvSpinEdit
      Left = 96
      Top = 47
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 62.000000000000000000
      TabOrder = 1
    end
    object temp3_msb: TJvSpinEdit
      Left = 192
      Top = 47
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 63.000000000000000000
      TabOrder = 2
    end
    object temp3_lsb: TJvSpinEdit
      Left = 256
      Top = 47
      Width = 57
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 64.000000000000000000
      TabOrder = 3
    end
    object Temp2LabelEdit: TEdit
      Left = 32
      Top = 70
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'Eingangst'#252'r'
    end
    object Temp3LabelEdit: TEdit
      Left = 192
      Top = 70
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'Decke'
    end
  end
  object Button3: TButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 232
    Width = 353
    Height = 65
    Caption = ' Temperaturen und Verbrauch in Verzeichnis speichern: '
    TabOrder = 4
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
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 368
    Top = 8
    Width = 353
    Height = 113
    Caption = ' Sonstige Einstellungen '
    TabOrder = 5
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
end
