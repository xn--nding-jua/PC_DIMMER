object Form1: TForm1
  Left = 262
  Top = 312
  BorderStyle = bsToolWindow
  Caption = 'DMX-Stream Decoder'
  ClientHeight = 210
  ClientWidth = 737
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    Left = 16
    Top = 148
    Width = 33
    Height = 13
    Caption = 'Quelle:'
  end
  object datenratelbl: TLabel
    Left = 336
    Top = 182
    Width = 73
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 129
    Caption = ' Frame-Info '
    TabOrder = 0
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 50
      Height = 13
      Caption = 'Framerate:'
    end
    object Label7: TLabel
      Left = 8
      Top = 40
      Width = 83
      Height = 13
      Caption = 'Keyframeintervall:'
    end
    object Label8: TLabel
      Left = 8
      Top = 72
      Width = 61
      Height = 13
      Caption = 'Kanalanzahl:'
    end
    object Label9: TLabel
      Left = 8
      Top = 88
      Width = 65
      Height = 13
      Caption = 'CRC aktiviert:'
    end
    object frameratelbl: TLabel
      Left = 104
      Top = 24
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object keyframeintervallbl: TLabel
      Left = 104
      Top = 40
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object maxchanlbl: TLabel
      Left = 104
      Top = 72
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object crclbl: TLabel
      Left = 104
      Top = 88
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 56
      Width = 92
      Height = 13
      Caption = 'Frame ist Keyframe:'
    end
    object iskeyframelbl: TLabel
      Left = 104
      Top = 56
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 104
      Width = 58
      Height = 13
      Caption = 'CRC Status:'
    end
    object crcoklbl: TLabel
      Left = 104
      Top = 104
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 264
    Top = 8
    Width = 249
    Height = 129
    Caption = ' ID-Tag '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Titel:'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 62
      Height = 13
      Caption = 'Projektname:'
    end
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 68
      Height = 13
      Caption = 'Beschreibung:'
    end
    object Label4: TLabel
      Left = 8
      Top = 72
      Width = 23
      Height = 13
      Caption = 'Jahr:'
    end
    object Label5: TLabel
      Left = 8
      Top = 88
      Width = 56
      Height = 13
      Caption = 'Kommentar:'
    end
    object titlelbl: TLabel
      Left = 80
      Top = 24
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object projectnamelbl: TLabel
      Left = 80
      Top = 40
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object descriptionlbl: TLabel
      Left = 80
      Top = 56
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object yearlbl: TLabel
      Left = 80
      Top = 72
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object commentlbl: TLabel
      Left = 80
      Top = 88
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 8
      Top = 104
      Width = 51
      Height = 13
      Caption = 'Reserviert:'
    end
    object reservedlbl: TLabel
      Left = 80
      Top = 104
      Width = 13
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object OpenFileBtn: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Datei '#246'ffnen'
    TabOrder = 2
    OnClick = OpenFileBtnClick
  end
  object sourceedit: TEdit
    Left = 56
    Top = 144
    Width = 449
    Height = 21
    TabOrder = 3
    Text = 'c:\Demo.dmxs'
  end
  object DecodeFrameBtn: TButton
    Left = 88
    Top = 176
    Width = 153
    Height = 25
    Caption = 'Einzelnes Frame decodieren'
    Enabled = False
    TabOrder = 4
    OnClick = DecodeFrameBtnClick
  end
  object CloseBtn: TButton
    Left = 416
    Top = 176
    Width = 97
    Height = 25
    Caption = 'Datei schlie'#223'en'
    Enabled = False
    TabOrder = 5
    OnClick = CloseBtnClick
  end
  object CheckBox1: TCheckBox
    Left = 247
    Top = 180
    Width = 82
    Height = 17
    Caption = 'Autodecode'
    Enabled = False
    TabOrder = 6
    OnMouseUp = CheckBox1MouseUp
  end
  object GroupBox3: TGroupBox
    Left = 520
    Top = 8
    Width = 209
    Height = 193
    Caption = ' Kanalwerte: '
    TabOrder = 7
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 193
      Height = 169
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object XPManifest1: TXPManifest
    Left = 488
    Top = 8
  end
  object decodetimer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = decodetimerTimer
    Left = 456
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 424
    Top = 8
  end
end
