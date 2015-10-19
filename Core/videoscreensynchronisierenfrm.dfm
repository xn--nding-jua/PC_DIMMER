object videoscreensynchronisierenform: Tvideoscreensynchronisierenform
  Left = 575
  Top = 109
  BorderStyle = bsSingle
  Caption = 'Videoscreens synchronisieren'
  ClientHeight = 233
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000F00A0000F00A000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000026181818702424249110101017000000000000
    0000000000000000000000000000000000000000000000000000000000001212
    12050E0E0E58424242B17C7C7CF0999999FF8C8C8CFF252525C71010100E0000
    0000000000000000000000000000000000000000000000000000000000002C2C
    2C958F8F8FFF989898FF7C7C7CFF5A5B5BFF767676FF4B4B4BFF161616A52525
    258E2626269F0F0F0F3F00000000000000000000000000000000000000005050
    50F25E5E5EFF454545FF454545FF313132FF59585CFF4C4C4CFF4B4C4CFF7272
    72FFA2A2A2FF585858FC1F1F1FAE0E0E0E400000000000000000000000004F4F
    4FEF4B4B4BFF2F2F2FFF191918FF101018FF6C7084FF4D4C4AFF777878FF6F6F
    6FFF989899FF7A7A83FF7C7C7CFF4F4F4FFC1010107800000000000000005151
    51F34D4D4DFF454545FF575756FF838284FFA3A2A5FF626261FFC0C0C0FFA3A3
    A3FFBCBCBCFF6D6D6EFF818181FF8A8A8AFF282828D3000000270000000C4040
    40DC949494FF9C9C9CFF868686FF6D6D6DFC666666FF858585FFB5B5B5FFB3B3
    B3FFEEEEEFFFBDBDC0FF9E9FA3FF949393FF585858FD00000042000000061414
    142B1F1F1F811A1A1A8A0B0B0B76080808741B1B1BB7444444F9575757FF9899
    9EFF9C9DA1FFB2B0A5FFAFAB9AFFA1A2A4FF747474FE0404042A000000000000
    0000000000001010103C252525D42A2A2AE8262626E51F1F1EF967686CFFA192
    68FFB19641FFC0A13BFFCCB255FF767574FF1B1C1D8D00000000000000000000
    00000000000015151572434343FF555555FF525252FF5A5A5AFFC5C8CDFFBBAA
    7EFFB08B28FFAE8922FFB69125FF938A71FF16181DBC13131322000000000000
    000000000000171717111818187B1C1C1CB51D1D1DD32D2D2DDE656568ED928D
    85FFB7A47AFFB4A788FFBFB7A2FFC0BEB9FF5A5B5BFF16161694000000000000
    000000000000000000000000000000000000141414051111110D0100001F2121
    22973F4144BE3A3C41B76E7075F07C7C7DFF4B4B4BFB16161662000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000606062E0B0B0B740F0F0F4C00000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF0000FBFF0000C1FF0000003F0000000F000000070000000300000003
    000098030000E0030000E0030000F0010000FF030000FFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 209
    Height = 105
    Caption = ' Videoscreen 1 '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 44
      Width = 83
      Height = 13
      Caption = 'Startposition [ms]:'
    end
    object Label5: TLabel
      Left = 8
      Top = 88
      Width = 97
      Height = 13
      Caption = '0h 00min 00s 000ms'
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 24
      Width = 193
      Height = 17
      Caption = 'Videoseeking verwenden'
      TabOrder = 0
      OnMouseUp = CheckBox1MouseUp
    end
    object Edit1: TEdit
      Left = 8
      Top = 58
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyUp = Edit1KeyUp
    end
    object Button1: TButton
      Left = 80
      Top = 58
      Width = 121
      Height = 20
      Hint = 'Setzt die aktuelle Position des Audioeffektplayers ein'
      Caption = 'Aktuelle Position'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button5: TButton
      Left = 112
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Verringert den aktuellen Wert um 1ms'
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 176
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Erh'#246'ht den aktuellen Wert um 1ms'
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 139
      Top = 85
      Width = 33
      Height = 16
      Hint = 
        'Setzt die Zeitdifferenz von aktueller Audioeffektplayerposition ' +
        'und Videoposition ein. '#220'ber +1ms und -1ms kann danach eine klein' +
        'e Differenz ausgeglichen werden.'
      Caption = '|r|'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button7Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 224
    Top = 8
    Width = 209
    Height = 105
    Caption = ' Videoscreen 2 '
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 83
      Height = 13
      Caption = 'Startposition [ms]:'
    end
    object Label6: TLabel
      Left = 8
      Top = 88
      Width = 97
      Height = 13
      Caption = '0h 00min 00s 000ms'
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 24
      Width = 193
      Height = 17
      Caption = 'Videoseeking verwenden'
      TabOrder = 0
      OnMouseUp = CheckBox2MouseUp
    end
    object Edit2: TEdit
      Left = 8
      Top = 58
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyUp = Edit2KeyUp
    end
    object Button2: TButton
      Left = 80
      Top = 58
      Width = 121
      Height = 20
      Hint = 'Setzt die aktuelle Position des Audioeffektplayers ein'
      Caption = 'Aktuelle Position'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button8: TButton
      Left = 112
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Verringert den aktuellen Wert um 1ms'
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 139
      Top = 85
      Width = 33
      Height = 16
      Hint = 
        'Setzt die Zeitdifferenz von aktueller Audioeffektplayerposition ' +
        'und Videoposition ein. '#220'ber +1ms und -1ms kann danach eine klein' +
        'e Differenz ausgeglichen werden.'
      Caption = '|r|'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 176
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Erh'#246'ht den aktuellen Wert um 1ms'
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button10Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 120
    Width = 209
    Height = 105
    Caption = ' Videoscreen 3 '
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 83
      Height = 13
      Caption = 'Startposition [ms]:'
    end
    object Label7: TLabel
      Left = 8
      Top = 88
      Width = 97
      Height = 13
      Caption = '0h 00min 00s 000ms'
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 24
      Width = 193
      Height = 17
      Caption = 'Videoseeking verwenden'
      TabOrder = 0
      OnMouseUp = CheckBox3MouseUp
    end
    object Edit3: TEdit
      Left = 8
      Top = 58
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyUp = Edit3KeyUp
    end
    object Button3: TButton
      Left = 80
      Top = 58
      Width = 121
      Height = 20
      Hint = 'Setzt die aktuelle Position des Audioeffektplayers ein'
      Caption = 'Aktuelle Position'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button11: TButton
      Left = 112
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Verringert den aktuellen Wert um 1ms'
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button11Click
    end
    object Button12: TButton
      Left = 139
      Top = 85
      Width = 33
      Height = 16
      Hint = 
        'Setzt die Zeitdifferenz von aktueller Audioeffektplayerposition ' +
        'und Videoposition ein. '#220'ber +1ms und -1ms kann danach eine klein' +
        'e Differenz ausgeglichen werden.'
      Caption = '|r|'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button12Click
    end
    object Button13: TButton
      Left = 176
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Erh'#246'ht den aktuellen Wert um 1ms'
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button13Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 224
    Top = 120
    Width = 209
    Height = 105
    Caption = ' Videoscreen 4 '
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 44
      Width = 83
      Height = 13
      Caption = 'Startposition [ms]:'
    end
    object Label8: TLabel
      Left = 8
      Top = 88
      Width = 97
      Height = 13
      Caption = '0h 00min 00s 000ms'
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 24
      Width = 193
      Height = 17
      Caption = 'Videoseeking verwenden'
      TabOrder = 0
      OnMouseUp = CheckBox4MouseUp
    end
    object Edit4: TEdit
      Left = 8
      Top = 58
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyUp = Edit4KeyUp
    end
    object Button4: TButton
      Left = 80
      Top = 58
      Width = 121
      Height = 20
      Hint = 'Setzt die aktuelle Position des Audioeffektplayers ein'
      Caption = 'Aktuelle Position'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button14: TButton
      Left = 112
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Verringert den aktuellen Wert um 1ms'
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button14Click
    end
    object Button15: TButton
      Left = 139
      Top = 85
      Width = 33
      Height = 16
      Hint = 
        'Setzt die Zeitdifferenz von aktueller Audioeffektplayerposition ' +
        'und Videoposition ein. '#220'ber +1ms und -1ms kann danach eine klein' +
        'e Differenz ausgeglichen werden.'
      Caption = '|r|'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button15Click
    end
    object Button16: TButton
      Left = 176
      Top = 85
      Width = 25
      Height = 16
      Hint = 'Erh'#246'ht den aktuellen Wert um 1ms'
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button16Click
    end
  end
end
