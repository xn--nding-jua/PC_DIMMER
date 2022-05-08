object elgatostreamdeckform: Telgatostreamdeckform
  Left = 697
  Top = 145
  BorderStyle = bsSingle
  Caption = 'Elgato Stream Deck'
  ClientHeight = 721
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 81
    Height = 13
    Caption = 'Erkannte Ger'#228'te:'
  end
  object Label3: TLabel
    Left = 368
    Top = 24
    Width = 46
    Height = 13
    Caption = 'Helligkeit:'
  end
  object PaintBox1: TPaintBox
    Left = 8
    Top = 88
    Width = 768
    Height = 384
    OnMouseUp = PaintBox1MouseUp
  end
  object devicelistbox: TListBox
    Left = 8
    Top = 24
    Width = 353
    Height = 57
    ItemHeight = 13
    TabOrder = 0
    OnKeyUp = devicelistboxKeyUp
    OnMouseUp = devicelistboxMouseUp
  end
  object brightnessbar: TScrollBar
    Left = 368
    Top = 40
    Width = 353
    Height = 17
    PageSize = 0
    Position = 50
    TabOrder = 1
    OnChange = brightnessbarChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 480
    Width = 769
    Height = 201
    Caption = ' Einstellungen f'#252'r gew'#228'hlten Button '
    TabOrder = 2
    object btnlabel: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 13
      Caption = 'Button ...'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 44
      Height = 13
      Caption = 'Funktion:'
    end
    object Label4: TLabel
      Left = 312
      Top = 32
      Width = 64
      Height = 13
      Caption = 'Kontrollpanel:'
    end
    object Label5: TLabel
      Left = 312
      Top = 48
      Width = 10
      Height = 13
      Caption = 'X:'
    end
    object Label6: TLabel
      Left = 368
      Top = 48
      Width = 10
      Height = 13
      Caption = 'Y:'
    end
    object Label7: TLabel
      Left = 312
      Top = 96
      Width = 145
      Height = 13
      Caption = 'Ger'#228'te- oder Gruppenauswahl:'
    end
    object Label8: TLabel
      Left = 312
      Top = 144
      Width = 68
      Height = 13
      Caption = 'Data-In-Kanal:'
    end
    object btntype: TComboBox
      Left = 16
      Top = 64
      Width = 281
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = btntypeChange
      Items.Strings = (
        'Frei'
        'Kontrollpanelbutton'
        'Ger'#228'te- oder Gruppenauswahl'
        'Data-In')
    end
    object panelbtnx: TJvSpinEdit
      Left = 312
      Top = 64
      Width = 49
      Height = 21
      CheckMaxValue = False
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
      OnChange = panelbtnxChange
    end
    object panelbtny: TJvSpinEdit
      Left = 368
      Top = 64
      Width = 49
      Height = 21
      CheckMaxValue = False
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 2
      OnChange = panelbtnyChange
    end
    object deviceorgroupid: TComboBox
      Left = 312
      Top = 112
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = deviceorgroupidChange
    end
    object datainchannel: TJvSpinEdit
      Left = 312
      Top = 160
      Width = 105
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 4
      OnChange = datainchannelChange
    end
  end
  object Button1: TButton
    Left = 8
    Top = 688
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
  object selectmodecheckbox: TCheckBox
    Left = 368
    Top = 64
    Width = 353
    Height = 17
    Caption = 'Letzten Button als Modus-Umschalter nutzen'
    TabOrder = 4
    OnMouseUp = selectmodecheckboxMouseUp
  end
  object ElgatoStreamDeckTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ElgatoStreamDeckTimerTimer
    Left = 272
    Top = 8
  end
end
