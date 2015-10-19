object Settings: TSettings
  Left = 578
  Top = 107
  BorderStyle = bsToolWindow
  Caption = 'Joystick-Plugin'
  ClientHeight = 361
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 106
    Height = 16
    Caption = 'Joystick-Plugin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 133
    Height = 13
    Caption = '(c) 2007 by Christian N'#246'ding'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 40
    Width = 118
    Height = 13
    Caption = 'http://www.pcdimmer.de'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 280
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object Label6: TLabel
    Left = 88
    Top = 280
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object Label7: TLabel
    Left = 168
    Top = 280
    Width = 10
    Height = 13
    Caption = 'Z:'
  end
  object Label8: TLabel
    Left = 8
    Top = 256
    Width = 36
    Height = 13
    Caption = 'Kan'#228'le:'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 264
    Width = 225
    Height = 9
    Shape = bsBottomLine
  end
  object Button1: TButton
    Left = 8
    Top = 328
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 296
    Width = 65
    Height = 21
    Hint = 'Kanal f'#252'r Rot'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '1'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 88
    Top = 296
    Width = 65
    Height = 21
    Hint = 'Kanal f'#252'r Gr'#252'n'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '2'
  end
  object Edit3: TEdit
    Left = 168
    Top = 296
    Width = 65
    Height = 21
    Hint = 'Kanal f'#252'r Blau'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = '3'
  end
  object joystickcontrol: TFlightJoyStick
    Left = 8
    Top = 56
    Width = 225
    Height = 193
    Stickybuttons = False
    StickEnabled = False
    ShowZAxis = True
    ShowButtons = True
    Spacing = 4
    AutoPolling = True
    PollingInterval = 50
    OnXYChange = joystickcontrolXYChange
    OnZChange = joystickcontrolZChange
    ZRulerColor = clRed
    RulerColor = clLime
    EnabledColor = clGreen
    ButtonColor = clRed
    ButtonEdgeColor = clLime
    ZPointerColor = clYellow
    PointerColor = clYellow
    Color = clBlack
    TabOrder = 4
  end
  object XPManifest1: TXPManifest
    Left = 160
    Top = 8
  end
  object xtimer: TTimer
    Enabled = False
    OnTimer = xtimerTimer
    Left = 144
    Top = 48
  end
  object ytimer: TTimer
    Enabled = False
    OnTimer = ytimerTimer
    Left = 176
    Top = 48
  end
  object ztimer: TTimer
    Enabled = False
    OnTimer = ztimerTimer
    Left = 208
    Top = 48
  end
  object VistaAltFix1: TVistaAltFix
    Left = 128
    Top = 8
  end
end
