object Form1: TForm1
  Left = 521
  Top = 117
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 353
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 209
    Height = 13
    Caption = 'PC_DIMMER Netzwerk-Kommunikationstest'
  end
  object Label6: TLabel
    Left = 8
    Top = 272
    Width = 54
    Height = 13
    Caption = 'IP-Adresse:'
  end
  object Label7: TLabel
    Left = 152
    Top = 272
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object Label8: TLabel
    Left = 48
    Top = 248
    Width = 186
    Height = 19
    Caption = 'Verbindung hergestellt...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Button1: TButton
    Left = 8
    Top = 312
    Width = 137
    Height = 25
    Caption = 'Verbinden'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 312
    Width = 131
    Height = 25
    Caption = 'Trennen'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ipaddress: TEdit
    Left = 8
    Top = 288
    Width = 137
    Height = 21
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object portaddress: TEdit
    Left = 152
    Top = 288
    Width = 129
    Height = 21
    TabOrder = 3
    Text = '10160'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 289
    Height = 97
    Caption = ' Absoluter Kanal '
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 30
      Height = 13
      Caption = 'Kanal:'
    end
    object Label3: TLabel
      Left = 80
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Wert:'
    end
    object ScrollBar1: TScrollBar
      Left = 80
      Top = 40
      Width = 201
      Height = 17
      Max = 255
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object JvSpinEdit1: TJvSpinEdit
      Left = 8
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
    end
    object Button5: TButton
      Left = 8
      Top = 64
      Width = 81
      Height = 25
      Caption = '0%'
      TabOrder = 2
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 96
      Top = 64
      Width = 97
      Height = 25
      Caption = '50%'
      TabOrder = 3
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 200
      Top = 64
      Width = 83
      Height = 25
      Caption = '100%'
      TabOrder = 4
      OnClick = Button7Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 289
    Height = 97
    Caption = ' Szene '
    TabOrder = 5
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 53
      Height = 13
      Caption = 'Szenen-ID:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 273
      Height = 21
      TabOrder = 0
    end
    object Button3: TButton
      Left = 8
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 88
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 304
    Top = 32
    Width = 289
    Height = 313
    Caption = ' Ger'#228'teliste '
    TabOrder = 6
    object Button8: TButton
      Left = 8
      Top = 208
      Width = 273
      Height = 25
      Caption = 'Ger'#228'te abrufen'
      TabOrder = 0
      OnClick = Button8Click
    end
    object ListBox1: TListBox
      Left = 8
      Top = 24
      Width = 273
      Height = 177
      ItemHeight = 13
      TabOrder = 1
      OnMouseUp = ListBox1MouseUp
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 240
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
    object ScrollBar2: TScrollBar
      Left = 144
      Top = 240
      Width = 137
      Height = 17
      Max = 255
      PageSize = 0
      TabOrder = 3
      OnChange = ScrollBar2Change
    end
    object Button9: TButton
      Left = 8
      Top = 280
      Width = 81
      Height = 25
      Caption = '0%'
      TabOrder = 4
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 96
      Top = 280
      Width = 97
      Height = 25
      Caption = '50%'
      TabOrder = 5
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 200
      Top = 280
      Width = 83
      Height = 25
      Caption = '100%'
      TabOrder = 6
      OnClick = Button11Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 600
    Top = 32
    Width = 241
    Height = 113
    Caption = ' Ger'#228'teinformationen '
    TabOrder = 7
    object Memo1: TMemo
      Left = 8
      Top = 24
      Width = 225
      Height = 81
      TabOrder = 0
    end
  end
  object GroupBox5: TGroupBox
    Left = 600
    Top = 152
    Width = 241
    Height = 193
    Caption = ' Kontrollpanel '
    TabOrder = 8
    object Label5: TLabel
      Left = 173
      Top = 163
      Width = 5
      Height = 13
      Caption = 'x'
    end
    object Memo2: TMemo
      Left = 8
      Top = 24
      Width = 225
      Height = 105
      TabOrder = 0
    end
    object Button12: TButton
      Left = 8
      Top = 128
      Width = 225
      Height = 25
      Caption = 'Anzahl Buttons abfrage'
      TabOrder = 1
      OnClick = Button12Click
    end
    object Button13: TButton
      Left = 8
      Top = 160
      Width = 105
      Height = 25
      Caption = 'Buttoninfo abfragen'
      TabOrder = 2
      OnClick = Button13Click
    end
    object buttony: TJvSpinEdit
      Left = 184
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 3
    end
    object buttonx: TJvSpinEdit
      Left = 120
      Top = 160
      Width = 49
      Height = 21
      TabOrder = 4
    end
  end
  object idclient: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 256
    Top = 8
  end
  object XPManifest1: TXPManifest
    Left = 568
    Top = 8
  end
end
