object beatform: Tbeatform
  Left = 808
  Top = 100
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Beat'
  ClientHeight = 327
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000100100D0000010020009C0300001600000028000000100000001A00
    0000010020000000000000000000130B0000130B00000000000000000000797F
    78FF3A583BFF56504FFF465C40FF4C6349FF5A5353FF475D46FF575756FF495C
    47FF4D5C4BFF4F5B4DFF465C45FF425E43FF4A614AFF5A6155FF908585FF3E7E
    3FFF0E6B10FF165514FF066307FF0A6C0CFF034401FF096A0CFF074907FF0161
    04FF076109FF025105FF0B710FFF015202FF08610BFF21611FFF699264FF4E9B
    4EFF35A738FF328E33FF159C1DFF1EAA26FF117913FF1FAF26FF187E1AFF0FA2
    19FF1AA020FF1D861FFF34B339FF1A7E1DFF2A8F2CFF439343FF649C63FF778F
    70FF5FA460FF518851FF35A13EFF35B041FF1E7C23FF3CBB44FF278329FF24AB
    2FFF35A83EFF307D30FF62A55FFF2C612AFF041D04FF142A12FF748271FF8171
    78FF244625FF29422AFF4DA85AFF49BB59FF2B8335FF50C85BFF328A36FF31B7
    42FF54BA60FF0D350DFF0F190AFF0E0F08FF070201FF140C11FF847782FF8976
    80FF224525FF234828FF4CB55EFF48CC5EFF2C993EFF54DE66FF339D3CFF33CE
    4CFF5DD270FF0B360EFF060602FF10050AFF0D0709FF131214FF7E7D82FF9B79
    8EFF4A4C44FF225A29FF58C16CFF62E17DFF2A9B45FF67C07EFF3F8854FF43D1
    70FF6ED98DFF103A17FF0F0D0AFF180A15FF0E040CFF191613FF808278FF9D87
    9EFF515256FF1F472CFF599D6AFF75C485FF195622FF062407FF0F2F13FF5AE0
    89FF7DE49FFF164121FF11120EFF1A0E17FF120A11FF1E1A18FF848479FF9794
    A3FF484D56FF223130FF1E352AFF203326FF1C271BFF201C15FF34332AFF70E9
    A1FF8AEAAFFF21492DFF171B17FF1E161DFF171116FF211D1BFF84817AFF878C
    8FFF35353DFF34303CFF362D3DFF362939FF2D202AFF35282DFF4F4D49FF86ED
    B6FFA4F4C6FF30533CFF232924FF252327FF1D1C1EFF242221FF87837EFF8486
    7CFF3E3B38FF443941FF3F2F3FFF3A2E40FF302C35FF464C4BFF4A5F54FF66B3
    8EFF7CB698FF3A5041FF323531FF2D2E2FFF1F2322FF292A28FF85807EFFA09F
    91FF5D5950FF5C5656FF575158FF4E4E54FF5A6465FF667970FF557263FF3E6B
    5BFF436153FF565C55FF55534FFF484B48FF3D4542FF484B4AFF908B8CFFBBB9
    B4FFB4B3AFFFAFB2AFFFA6AAA9FF9BA19FFF9BA39FFF949A95FF8A928DFF7B8C
    8AFF828584FF928888FF968F8CFF91948FFF8D9794FF949A99FF858284FF0000
    FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
    FFFF0000FFFF0000FFFF0000FFFF0000FFFF}
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 384
    Top = 104
    Width = 50
    Height = 17
    Brush.Color = clMoneyGreen
    Pen.Style = psClear
    Visible = False
  end
  object beat_syncLabel: TLabel
    Left = 32
    Top = 84
    Width = 3
    Height = 13
  end
  object audioinput: TLabel
    Left = 32
    Top = 80
    Width = 3
    Height = 13
  end
  object timelbl: TLabel
    Left = 8
    Top = 136
    Width = 9
    Height = 13
    Caption = '...'
  end
  object PaintBox1: TPaintBox
    Left = 136
    Top = 8
    Width = 249
    Height = 121
    OnMouseUp = PaintBox1MouseUp
  end
  object Label1: TLabel
    Left = 392
    Top = 8
    Width = 9
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 392
    Top = 24
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Label3: TLabel
    Left = 392
    Top = 40
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Label4: TLabel
    Left = 392
    Top = 56
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Label5: TLabel
    Left = 392
    Top = 72
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Label7: TLabel
    Left = 384
    Top = 104
    Width = 49
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'OK!'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 392
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
  object temposlider: TTrackBar
    Left = 4
    Top = 4
    Width = 29
    Height = 119
    Hint = 'Geschwindigkeit'
    HelpType = htKeyword
    BorderWidth = 1
    Max = 59999
    Min = 1
    Orientation = trVertical
    ParentShowHint = False
    PageSize = 50
    Position = 50000
    ShowHint = True
    TabOrder = 1
    ThumbLength = 22
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = temposliderChange
  end
  object record_volume: TTrackBar
    Left = 4
    Top = 8
    Width = 27
    Height = 123
    Hint = 'Eingangs-Lautst'#228'rke'
    HelpType = htKeyword
    BorderWidth = 1
    Max = 100
    Orientation = trVertical
    ParentShowHint = False
    PageSize = 10
    ShowHint = True
    TabOrder = 3
    ThumbLength = 22
    TickMarks = tmBoth
    TickStyle = tsNone
    Visible = False
    OnChange = record_volumeChange
  end
  object audio_empfindlichkeit_micin: TTrackBar
    Left = 32
    Top = 91
    Width = 97
    Height = 15
    Hint = 'Empfindlichkeit'
    Max = 100
    ParentShowHint = False
    PageSize = 10
    Position = 30
    ShowHint = True
    TabOrder = 0
    ThumbLength = 14
    TickStyle = tsNone
    Visible = False
  end
  object vu_meter_micin: TIAeverProgressBar
    Left = 29
    Top = 108
    Width = 82
    Height = 20
    Color = clBlack
    OuterBevelKind = bkNone
    InnerBevelKind = bkNone
    NFColor = clWindow
    NFFieldKind = nkNone
    NFOuterBevelKind = bkNone
    NFInnerBevelKind = bkNone
    NFFont.Charset = DEFAULT_CHARSET
    NFFont.Color = clWindowText
    NFFont.Height = -16
    NFFont.Name = 'Times New Roman'
    NFFont.Style = []
    PFWidth = 80
    PFHeight = 20
    PFColor = clWindow
    PFOuterBevelKind = bkNone
    PFInnerBevelKind = bkNone
    PFProgressKind = pkRelief
    PFMainColor = clLime
  end
  object Temposourcebox: TComboBox
    Left = 32
    Top = 8
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = TemposourceboxChange
    OnDropDown = TemposourceboxDropDown
    Items.Strings = (
      'Temposlider'
      'Soundkarte'
      'Plugin'
      'Manuell'
      'Audioplayer'
      'MidiClock'
      'FFT')
  end
  object ManualSyncButton: TButton
    Left = 32
    Top = 32
    Width = 97
    Height = 25
    Caption = 'Beat'
    TabOrder = 5
    Visible = False
    OnMouseDown = ManualSyncButtonMouseDown
  end
  object beat_syncBtn: TButton
    Left = 32
    Top = 32
    Width = 97
    Height = 25
    Hint = 
      'Die Zeit zwischen zwei Klicks auf diese Schaltfl'#228'che wird als ne' +
      'ues Tempo registriert'
    Caption = 'Beat-Sync'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = beat_syncBtnClick
  end
  object beat: TPanel
    Left = 112
    Top = 108
    Width = 17
    Height = 20
    Hint = 'Beat'
    BevelOuter = bvNone
    BorderWidth = 200
    BorderStyle = bsSingle
    Color = clMaroon
    Ctl3D = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
  end
  object beat_audioin_selection: TComboBox
    Left = 32
    Top = 66
    Width = 97
    Height = 21
    Hint = 'Audio-Eingang'
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
    Visible = False
    OnChange = beat_audioin_selectionChange
  end
  object soundcardselect: TComboBox
    Left = 32
    Top = 40
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 9
    Visible = False
    OnChange = soundcardselectChange
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 310
    Width = 433
    Height = 17
    Hint = 'Fenstertransparenz'
    Align = alBottom
    Max = 255
    Min = 64
    ParentShowHint = False
    Position = 255
    ShowHint = True
    TabOrder = 10
    ThumbLength = 15
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBar1Change
  end
  object bpm: TJvSpinEdit
    Left = 29
    Top = 108
    Width = 68
    Height = 21
    Hint = 'Zeilenanzahl'
    MaxValue = 600.000000000000000000
    MinValue = 1.000000000000000000
    ValueType = vtFloat
    Value = 60.000000000000000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnChange = bpmChange
  end
  object JvSpinEdit1: TJvSpinEdit
    Left = 336
    Top = 128
    Width = 49
    Height = 21
    Hint = 'FFT Empfindlichkeit'
    Increment = 0.020000000000000000
    ValueType = vtFloat
    Value = 2.000000000000000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    Visible = False
    OnChange = JvSpinEdit1Change
  end
  object JvSpinEdit3: TJvSpinEdit
    Left = 288
    Top = 128
    Width = 49
    Height = 21
    Hint = 'Wartezeit, bis neuer Impuls erkannt werden kann [ms]'
    Value = 300.000000000000000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    Visible = False
    OnChange = JvSpinEdit3Change
  end
  object CheckBox1: TCheckBox
    Left = 388
    Top = 129
    Width = 44
    Height = 17
    Caption = 'Beat'
    Enabled = False
    TabOrder = 14
  end
  object CheckBox2: TCheckBox
    Left = 144
    Top = 132
    Width = 137
    Height = 17
    Caption = '<- BPM '#252'bernehmen'
    Checked = True
    State = cbChecked
    TabOrder = 15
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 232
    Width = 417
    Height = 73
    Caption = ' FFT-Werte an DataIn senden '
    TabOrder = 16
    Visible = False
    object Label8: TLabel
      Left = 8
      Top = 24
      Width = 113
      Height = 13
      AutoSize = False
      Caption = 'Gew'#228'hltes FFT-Band:'
    end
    object Label9: TLabel
      Left = 120
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
    object Label10: TLabel
      Left = 184
      Top = 24
      Width = 153
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sende Werte auf DataIn-Kanal:'
    end
    object Label11: TLabel
      Left = 200
      Top = 48
      Width = 137
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Multiplikator f'#252'r Werte:'
    end
    object JvSpinEdit2: TJvSpinEdit
      Left = 344
      Top = 20
      Width = 65
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 400.000000000000000000
      TabOrder = 0
      OnChange = JvSpinEdit2Change
    end
    object JvSpinEdit4: TJvSpinEdit
      Left = 344
      Top = 44
      Width = 65
      Height = 21
      Increment = 0.020000000000000000
      MaxValue = 1024.000000000000000000
      ValueType = vtFloat
      Value = 255.000000000000000000
      TabOrder = 1
      OnChange = JvSpinEdit4Change
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 48
      Width = 209
      Height = 17
      Caption = 'Sende Werte dieses Kanals an DataIn'
      TabOrder = 2
      OnMouseUp = CheckBox3MouseUp
    end
    object ComboBox1: TComboBox
      Left = 143
      Top = 18
      Width = 41
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnSelect = ComboBox1Select
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
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24'
        '25'
        '26'
        '27'
        '28'
        '29'
        '30'
        '31'
        '32')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 152
    Width = 417
    Height = 73
    Caption = ' Aktion bei Beat-Impuls '
    TabOrder = 17
    object Label12: TLabel
      Left = 184
      Top = 24
      Width = 153
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kanalwert bei Beat ON:'
    end
    object Label13: TLabel
      Left = 184
      Top = 48
      Width = 153
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kanalwert bei Beat OFF:'
    end
    object Label14: TLabel
      Left = 8
      Top = 48
      Width = 143
      Height = 13
      Caption = 'Sende Wert auf DataIn-Kanal:'
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 24
      Width = 161
      Height = 17
      Caption = 'Sende Kanalwert an DataIn'
      TabOrder = 0
      OnMouseUp = CheckBox4MouseUp
    end
    object JvSpinEdit5: TJvSpinEdit
      Left = 344
      Top = 20
      Width = 65
      Height = 21
      MaxValue = 255.000000000000000000
      Value = 255.000000000000000000
      TabOrder = 1
      OnChange = JvSpinEdit5Change
    end
    object JvSpinEdit6: TJvSpinEdit
      Left = 344
      Top = 44
      Width = 65
      Height = 21
      MaxValue = 255.000000000000000000
      TabOrder = 2
      OnChange = JvSpinEdit6Change
    end
    object JvSpinEdit7: TJvSpinEdit
      Left = 160
      Top = 44
      Width = 49
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 400.000000000000000000
      TabOrder = 3
      OnChange = JvSpinEdit7Change
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer1Timer
    Left = 360
    Top = 8
  end
  object BeatTimer: TSVATimer
    Interval = 25
    OnTimer = BeatTimerTimer
    Left = 320
    Top = 8
  end
end
