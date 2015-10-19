object videoscreenform: Tvideoscreenform
  Left = 223
  Top = 96
  Width = 737
  Height = 744
  Caption = 'PC_DIMMER Videoscreen'
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
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Videopanel1: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 343
    BevelOuter = bvNone
    TabOrder = 0
    object Panel5: TPanel
      Left = 0
      Top = 288
      Width = 360
      Height = 15
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object TimeLabel1: TLabel
        Left = 0
        Top = 0
        Width = 120
        Height = 15
        Align = alLeft
        Caption = '0h 00min 00s 000ms (0%)'
      end
      object Timelabelms1: TLabel
        Left = 341
        Top = 0
        Width = 19
        Height = 15
        Align = alRight
        Alignment = taRightJustify
        Caption = '0ms'
      end
      object Button1: TButton
        Left = 144
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Play'
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Abspielen2Click
      end
      object Button2: TButton
        Left = 171
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Pause'
        Caption = ';'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Pause2Click
      end
      object Button3: TButton
        Left = 198
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stop'
        Caption = '<'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Stop2Click
      end
      object Button4: TButton
        Left = 225
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Vollbild'
        Caption = '2'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Vollbild2Click
      end
      object Button5: TButton
        Left = 252
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stumm'
        Caption = #175
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Stumm2Click
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 303
      Width = 360
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object DSTrackBar1: TDSTrackBar
        Left = 0
        Top = 0
        Width = 360
        Height = 40
        Align = alClient
        TabOrder = 0
        FilterGraph = FilterGraph1
      end
    end
    object VideoWindow1: TVideoWindow
      Left = 0
      Top = 0
      Width = 360
      Height = 288
      Mode = vmVMR
      FilterGraph = FilterGraph1
      VMROptions.Mode = vmrWindowed
      Color = clBlack
      PopupMenu = PopupMenu1
      Align = alClient
      OnKeyDown = VideoWindow1KeyDown
      OnDblClick = VideoWindow1DblClick
    end
  end
  object Videopanel2: TPanel
    Left = 365
    Top = 0
    Width = 360
    Height = 343
    BevelOuter = bvNone
    TabOrder = 1
    object Panel4: TPanel
      Left = 0
      Top = 288
      Width = 360
      Height = 15
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Timelabel2: TLabel
        Left = 0
        Top = 0
        Width = 120
        Height = 15
        Align = alLeft
        Caption = '0h 00min 00s 000ms (0%)'
      end
      object Timelabelms2: TLabel
        Left = 341
        Top = 0
        Width = 19
        Height = 15
        Align = alRight
        Alignment = taRightJustify
        Caption = '0ms'
      end
      object Button6: TButton
        Left = 144
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Play'
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Abspielen3Click
      end
      object Button7: TButton
        Left = 171
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Pause'
        Caption = ';'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Pause3Click
      end
      object Button8: TButton
        Left = 198
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stop'
        Caption = '<'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Stop3Click
      end
      object Button9: TButton
        Left = 225
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Vollbild'
        Caption = '2'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Vollbild3Click
      end
      object Button10: TButton
        Left = 252
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stumm'
        Caption = #175
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Stumm3Click
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 303
      Width = 360
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object DSTrackBar2: TDSTrackBar
        Left = 0
        Top = 0
        Width = 360
        Height = 40
        Align = alClient
        TabOrder = 0
        FilterGraph = FilterGraph2
      end
    end
    object VideoWindow2: TVideoWindow
      Left = 0
      Top = 0
      Width = 360
      Height = 288
      Mode = vmVMR
      FilterGraph = FilterGraph2
      VMROptions.Mode = vmrWindowed
      Color = clBlack
      PopupMenu = PopupMenu2
      Align = alClient
      OnKeyDown = VideoWindow2KeyDown
      OnDblClick = VideoWindow2DblClick
    end
  end
  object Videopanel3: TPanel
    Left = 0
    Top = 350
    Width = 360
    Height = 343
    BevelOuter = bvNone
    TabOrder = 2
    object Panel7: TPanel
      Left = 0
      Top = 288
      Width = 360
      Height = 15
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Timelabel3: TLabel
        Left = 0
        Top = 0
        Width = 120
        Height = 15
        Align = alLeft
        Caption = '0h 00min 00s 000ms (0%)'
      end
      object Timelabelms3: TLabel
        Left = 341
        Top = 0
        Width = 19
        Height = 15
        Align = alRight
        Alignment = taRightJustify
        Caption = '0ms'
      end
      object Button11: TButton
        Left = 144
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Play'
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Abspielen4Click
      end
      object Button12: TButton
        Left = 171
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Pause'
        Caption = ';'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Pause4Click
      end
      object Button13: TButton
        Left = 198
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stop'
        Caption = '<'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Stop4Click
      end
      object Button14: TButton
        Left = 225
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Vollbild'
        Caption = '2'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Vollbild4Click
      end
      object Button15: TButton
        Left = 252
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stumm'
        Caption = #175
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Stumm4Click
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 303
      Width = 360
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object DSTrackBar3: TDSTrackBar
        Left = 0
        Top = 0
        Width = 360
        Height = 40
        Align = alClient
        TabOrder = 0
        FilterGraph = FilterGraph3
      end
    end
    object VideoWindow3: TVideoWindow
      Left = 0
      Top = 0
      Width = 360
      Height = 288
      Mode = vmVMR
      FilterGraph = FilterGraph3
      VMROptions.Mode = vmrWindowed
      Color = clBlack
      PopupMenu = PopupMenu3
      Align = alClient
      OnKeyDown = VideoWindow3KeyDown
      OnDblClick = VideoWindow3DblClick
    end
  end
  object Videopanel4: TPanel
    Left = 365
    Top = 350
    Width = 360
    Height = 343
    BevelOuter = bvNone
    TabOrder = 3
    object Panel9: TPanel
      Left = 0
      Top = 288
      Width = 360
      Height = 15
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Timelabel4: TLabel
        Left = 0
        Top = 0
        Width = 120
        Height = 15
        Align = alLeft
        Caption = '0h 00min 00s 000ms (0%)'
      end
      object Timelabelms4: TLabel
        Left = 341
        Top = 0
        Width = 19
        Height = 15
        Align = alRight
        Alignment = taRightJustify
        Caption = '0ms'
      end
      object Button16: TButton
        Left = 144
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Play'
        Caption = '4'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Abspielen5Click
      end
      object Button17: TButton
        Left = 171
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Pause'
        Caption = ';'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Pause5Click
      end
      object Button18: TButton
        Left = 198
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stop'
        Caption = '<'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Stop5Click
      end
      object Button19: TButton
        Left = 225
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Vollbild'
        Caption = '2'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Vollbild5Click
      end
      object Button20: TButton
        Left = 252
        Top = 0
        Width = 25
        Height = 13
        Hint = 'Stumm'
        Caption = #175
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Webdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Stumm5Click
      end
    end
    object Panel10: TPanel
      Left = 0
      Top = 303
      Width = 360
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object DSTrackBar4: TDSTrackBar
        Left = 0
        Top = 0
        Width = 360
        Height = 40
        Align = alClient
        TabOrder = 0
        FilterGraph = FilterGraph4
      end
    end
    object VideoWindow4: TVideoWindow
      Left = 0
      Top = 0
      Width = 360
      Height = 288
      Mode = vmVMR
      FilterGraph = FilterGraph4
      VMROptions.Mode = vmrWindowed
      Color = clBlack
      PopupMenu = PopupMenu4
      Align = alClient
      OnKeyDown = VideoWindow4KeyDown
      OnDblClick = VideoWindow4DblClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 56
    object Einstellungen1: TMenuItem
      Caption = 'Ansicht'
      object SingleView: TMenuItem
        Caption = 'Einfache Ansicht'
        Checked = True
        OnClick = SingleViewClick
      end
      object DoubleView: TMenuItem
        Caption = 'Zweifache Ansicht'
        OnClick = DoubleViewClick
      end
      object QuadView: TMenuItem
        Caption = 'Vierfache Ansicht'
        OnClick = QuadViewClick
      end
    end
    object N3: TMenuItem
      Caption = '?'
      object Logfileeinsehen1: TMenuItem
        Caption = 'Logfile einsehen'
        OnClick = Logfileeinsehen1Click
      end
      object WasbringtderVideoscreen1: TMenuItem
        Caption = 'Was bringt der Videoscreen?'
        OnClick = WasbringtderVideoscreen1Click
      end
    end
  end
  object FilterGraph1: TFilterGraph
    AutoCreate = True
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    OnDSEvent = FilterGraph1DSEvent
    Left = 8
    Top = 256
  end
  object OpenVideoDialog: TOpenDialog
    DefaultExt = '*.avi'
    Filter = 
      'Mediendateien (*.avi;*.mpg;*.wmv;*.vob;*.divx;*.wav;*.mp3;*.wma)' +
      '|*.avi;*.mpg;*.wmv;*.vob;*.divx;*.wav;*.mp3;*.wma|Alle Dateien (' +
      '*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 40
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 72
    Top = 56
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 256
    object Videobild42: TMenuItem
      Caption = 'Videobild 1'
      Default = True
    end
    object Videoffnen2: TMenuItem
      Caption = 'Video '#246'ffnen...'
      OnClick = Videoffnen2Click
    end
    object VideoINKamera1: TMenuItem
      Caption = 'Video-IN/Kamera'
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Abspielen2: TMenuItem
      Caption = 'Abspielen'
      OnClick = Abspielen2Click
    end
    object Pause2: TMenuItem
      Caption = 'Pause'
      OnClick = Pause2Click
    end
    object Stop2: TMenuItem
      Caption = 'Stop'
      OnClick = Stop2Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Vollbild2: TMenuItem
      Caption = 'Vollbild'
      OnClick = Vollbild2Click
    end
    object KeepAspectRatio1: TMenuItem
      Caption = 'Keep Aspect Ratio'
      Checked = True
      OnClick = KeepAspectRatio1Click
    end
    object Stumm2: TMenuItem
      Caption = 'Stumm'
      OnClick = Stumm2Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Anzeigeschlieen2: TMenuItem
      Caption = 'Video schlie'#223'en'
      OnClick = Anzeigeschlieen1Click
    end
  end
  object Filter2: TFilter
    BaseFilter.data = {00000000}
    FilterGraph = FilterGraph2
    Left = 456
    Top = 251
  end
  object SampleGrabber2: TSampleGrabber
    FilterGraph = FilterGraph2
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      FFFFFFFF0000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 424
    Top = 251
  end
  object FilterGraph2: TFilterGraph
    AutoCreate = True
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    Left = 392
    Top = 251
  end
  object PopupMenu2: TPopupMenu
    Left = 488
    Top = 251
    object Videobild43: TMenuItem
      Caption = 'Videobild 2'
      Default = True
    end
    object Videoffnen3: TMenuItem
      Caption = 'Video '#246'ffnen...'
      OnClick = Videoffnen3Click
    end
    object VideoINKamera2: TMenuItem
      Caption = 'Video-IN/Kamera'
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Abspielen3: TMenuItem
      Caption = 'Abspielen'
      OnClick = Abspielen3Click
    end
    object Pause3: TMenuItem
      Caption = 'Pause'
      OnClick = Pause3Click
    end
    object Stop3: TMenuItem
      Caption = 'Stop'
      OnClick = Stop3Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Vollbild3: TMenuItem
      Caption = 'Vollbild'
      OnClick = Vollbild3Click
    end
    object KeepAspectRatio2: TMenuItem
      Caption = 'Keep Aspect Ratio'
      Checked = True
      OnClick = KeepAspectRatio2Click
    end
    object Stumm3: TMenuItem
      Caption = 'Stumm'
      OnClick = Stumm3Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Videoschlieen1: TMenuItem
      Caption = 'Video schlie'#223'en'
      OnClick = Anzeigeschlieen2Click
    end
  end
  object SampleGrabber1: TSampleGrabber
    FilterGraph = FilterGraph1
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      FFFFFFFF0000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 40
    Top = 256
  end
  object Filter1: TFilter
    BaseFilter.data = {00000000}
    FilterGraph = FilterGraph1
    Left = 72
    Top = 256
  end
  object FilterGraph3: TFilterGraph
    AutoCreate = True
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    Left = 8
    Top = 362
  end
  object SampleGrabber3: TSampleGrabber
    FilterGraph = FilterGraph3
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      FFFFFFFF0000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 40
    Top = 362
  end
  object Filter3: TFilter
    BaseFilter.data = {00000000}
    FilterGraph = FilterGraph3
    Left = 72
    Top = 362
  end
  object PopupMenu3: TPopupMenu
    Left = 104
    Top = 362
    object Videobild44: TMenuItem
      Caption = 'Videobild 3'
      Default = True
    end
    object Videoffnen4: TMenuItem
      Caption = 'Video '#246'ffnen...'
      OnClick = Videoffnen4Click
    end
    object VideoINKamera3: TMenuItem
      Caption = 'Video-IN/Kamera'
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Abspielen4: TMenuItem
      Caption = 'Abspielen'
      OnClick = Abspielen4Click
    end
    object Pause4: TMenuItem
      Caption = 'Pause'
      OnClick = Pause4Click
    end
    object Stop4: TMenuItem
      Caption = 'Stop'
      OnClick = Stop4Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object Vollbild4: TMenuItem
      Caption = 'Vollbild'
      OnClick = Vollbild4Click
    end
    object KeepAspectRatio3: TMenuItem
      Caption = 'Keep Aspect Ratio'
      Checked = True
      OnClick = KeepAspectRatio3Click
    end
    object Stumm4: TMenuItem
      Caption = 'Stumm'
      OnClick = Stumm4Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object Videoschlieen2: TMenuItem
      Caption = 'Video schlie'#223'en'
      OnClick = Anzeigeschlieen3Click
    end
  end
  object FilterGraph4: TFilterGraph
    AutoCreate = True
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    Left = 393
    Top = 362
  end
  object SampleGrabber4: TSampleGrabber
    FilterGraph = FilterGraph4
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      FFFFFFFF0000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 425
    Top = 362
  end
  object Filter4: TFilter
    BaseFilter.data = {00000000}
    FilterGraph = FilterGraph4
    Left = 457
    Top = 362
  end
  object PopupMenu4: TPopupMenu
    Left = 489
    Top = 362
    object Videobild41: TMenuItem
      Caption = 'Videobild 4'
      Default = True
    end
    object Videoffnen5: TMenuItem
      Caption = 'Video '#246'ffnen...'
      OnClick = Videoffnen5Click
    end
    object VideoINKamera4: TMenuItem
      Caption = 'Video-IN/Kamera'
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object Abspielen5: TMenuItem
      Caption = 'Abspielen'
      OnClick = Abspielen5Click
    end
    object Pause5: TMenuItem
      Caption = 'Pause'
      OnClick = Pause5Click
    end
    object Stop5: TMenuItem
      Caption = 'Stop'
      OnClick = Stop5Click
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object Vollbild5: TMenuItem
      Caption = 'Vollbild'
      OnClick = Vollbild5Click
    end
    object KeepAspectRatio4: TMenuItem
      Caption = 'Keep Aspect Ratio'
      Checked = True
      OnClick = KeepAspectRatio4Click
    end
    object Stumm5: TMenuItem
      Caption = 'Stumm'
      OnClick = Stumm5Click
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object Videoschlieen3: TMenuItem
      Caption = 'Video schlie'#223'en'
      OnClick = Anzeigeschlieen4Click
    end
  end
end
