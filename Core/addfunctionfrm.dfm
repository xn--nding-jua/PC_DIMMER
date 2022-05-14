object addfunctionform: Taddfunctionform
  Left = 542
  Top = 228
  Width = 692
  Height = 411
  Caption = 'Funktion hinzuf'#252'gen...'
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
  object ListBox1: TListBox
    Left = 0
    Top = 57
    Width = 284
    Height = 276
    Align = alLeft
    ItemHeight = 13
    Items.Strings = (
      'Einen Kanalwert unabh'#228'ngig der Ger'#228'te setzen '
      'Einen Kanal eines Ger'#228'tes setzen'
      'Einen Kanal einer Ger'#228'tegruppe setzen'
      'Einen Kanalwert unabh'#228'ngig der Ger'#228'te abfragen'
      'Einen Kanal eines Ger'#228'tes abfragen'
      'Byte-Werte in Prozent umrechnen'
      'Eine Szene starten'
      'Eine Szene stoppen'
      'Eine Szenen starten/stoppen'
      'Einen Effekt starten'
      'Einen Effekt stoppen'
      'Einen Effekt starten/stoppen'
      ''
      'Eingabe von Werten'
      'Nachricht anzeigen'
      'Umwandlung Text->Zahl'
      'Umwandlung Zahl->Text'
      'Datum und Uhrzeit'
      'IF-Then-Else'
      'Case-Select'
      'Abfragedialog'
      ''
      'Variablen setzen/abfragen'
      'Kontrollpanel Buttonfarbe oder -text setzen oder abfragen'
      'MIDI-Nachricht senden'
      'DataIn-Nachricht senden'
      'PCD-Nachricht senden')
    TabOrder = 0
    OnKeyDown = ListBox1KeyDown
    OnKeyUp = ListBox1KeyUp
    OnMouseDown = ListBox1MouseDown
    OnMouseMove = ListBox1MouseMove
    OnMouseUp = ListBox1MouseUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object JvGradient1: TJvGradient
      Left = 0
      Top = 0
      Width = 676
      Height = 57
      Style = grVertical
      StartColor = clWhite
      EndColor = clBtnFace
    end
    object Image1: TImage
      Left = 6
      Top = 5
      Width = 57
      Height = 49
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F9870000000473424954080808087C08648800000009
        7048597300000DD700000DD70142289B780000001974455874536F6674776172
        65007777772E696E6B73636170652E6F72679BEE3C1A000004344944415478DA
        ED985F68537714C74F9A3F4DD2A66D9AC576D5B6D8C2DADA963EA875828C6D20
        6C6E45A60F636C7BB0086E4AB028E8C39882A0A8DBC3C69863B363D20D8630D8
        CB0407F3614CA27B681FDA3A53DBA57F5285C43636AD69139BDCEC7B6EEE8DED
        4DAC114B6E3AEE81C3BDBFDFFDFD7EF77C7EE79CDF3D892E9148D05A169D06A0
        0168001A8006A001AC65D100D4160D406DC908D0D6D67606972EA85139FE690B
        0A82B0E2181D241BBB147316A07F5BADD65D6EB77B61450018BF01977FABABAB
        4D06835E5C8BC7C82A1929DECB57D6783C9ED69705ECB23999D695157D6140B8
        0606062E25962C9E029076A6A0B9B9F9039BCD76C1E97CC11A0ACDA6BD548D90
        5B5C5CA47038CCB7BF00E07D5C63B0435002F0769B00F0535959D91E93C944B1
        588CDADBDB69DBB6AD698BBADD37A8B7B72F67100C007BA6FAFBFB5FE22673B1
        27440069F739DE6DADADAD43F08043AFD7E77CA79F263333338FFC7EFFAB8140
        6010CD79D81E97010AD061A9A8A86881FE55535363B4582CE2A464CAA5E79D9C
        8BCB7332911ABB74DEF2FBC7E393EF4E3E53BE47393F1C9E27AFD7BB008833A3
        A3A3DF310F7B410630F0EED7D5D51D40F89C8407CC9C48AB29D91D3E4F1E6BB1
        98E181500200D73C1ECF7E74DD87467412A6096A6F6A6AEA81F13B0B0B0B57D5
        F8D5123EE9666767838383833BD0BC070D8B270FD40A7522FEFB0050D675D445
        C97010F783BEFAE202B9BA0E921C22B9687F72E278AA7DFAD4B914043C101B1F
        1FEF00482F9A210610C3C7E1706CA9AAAABA821032BEF7E1BB38A42580021DFD
        FCE3654AF5E5A8BDFFC03E4E123101BABFFD210530373717090683E72726262E
        A239CD001C2FF6DADADA8376BBFD183C909FF1234924124960F7AF0D0D0D7D8C
        A69F018AA0EB1A1B1B2F959494BC22C77FD2A59417E1B3D416FE36C10B9C07AF
        A3CBC70076E886969696EB002891CF7FD1A5907C081FD996DFBB7BA8F3D62DFA
        B4BE3E363636B61B9EE863804AC4FD76D43E9739FED50E919564DFEDDB54F456
        157D79471FF54D4E7DE6F3F9BE67808D88FF43E5E5E5AEE2E262D3637792C2C5
        B90C27E5BB5026C043159F1FA1F53D9BA9F3A3E9C4C464F08FE1E1E1C30CB0A9
        A1A1A1BBB4B4743BC7FF134FA05C8693E25D62A20A31DAD17695BE11FEA1FE8B
        0EBADB17BB8F3C78839F6D4601F72BC2BFDA6030A81D2519E5B5C9497A7B8F8D
        3C7B8DF4E7D803F27CFD228520007893015E4602FF86AFB0C36C36A74D7E96F2
        399BB15C263CEB9AEF78BD34DD514FA345F3E4BF63A4870181504E4C01603703
        6C01C015FCDA59F7BC3B954DBD23D55ECFB5264A0A0127D04D7C0B5CFCB4A1B2
        B2B2C3E9749EC57DFED5D019048566606464A4331A8D7A188077DE2E297FD4F8
        28958BBC7C128E3B2E911F411F4283D01936920B7FFEFC9A24E30BF2D0F8A510
        71E82234CA2A57A3B2E6E3CE6782106455FEA85F3322FF33F1FFFC636B2D8906
        A0B668006A8B06A0B668006ACB7F2C96EFA08FAB219C0000000049454E44AE42
        6082}
    end
    object Label34: TLabel
      Left = 72
      Top = 8
      Width = 229
      Height = 22
      Caption = 'Funktionen hinzuf'#252'gen...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label35: TLabel
      Left = 72
      Top = 32
      Width = 505
      Height = 13
      Caption = 
        'W'#228'hlen Sie aus den zahlreichen Funktionen aus (es k'#246'nnen weitere' +
        ' Delphi-Funktionen verwendet werden)'
      Transparent = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 333
    Width = 676
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Shape1: TShape
      Left = 0
      Top = 1
      Width = 676
      Height = 38
      Align = alBottom
      Pen.Style = psClear
    end
    object Shape2: TShape
      Left = 0
      Top = 0
      Width = 676
      Height = 1
      Align = alTop
      Brush.Color = clBlack
    end
    object OKBtn: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Abbrechen'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    Left = 284
    Top = 57
    Width = 392
    Height = 276
    Align = alClient
    TabOrder = 3
  end
end
