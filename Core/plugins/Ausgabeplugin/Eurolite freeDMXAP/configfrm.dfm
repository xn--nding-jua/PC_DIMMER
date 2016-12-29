object config: Tconfig
  Left = 813
  Top = 149
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 315
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape6: TShape
    Left = 0
    Top = -1
    Width = 281
    Height = 57
    Pen.Color = clWhite
  end
  object Shape4: TShape
    Left = 0
    Top = 274
    Width = 281
    Height = 41
    Align = alBottom
    Pen.Color = clWhite
  end
  object Label1: TLabel
    Left = 120
    Top = 224
    Width = 41
    Height = 13
    Caption = 'Timeout:'
    Visible = False
  end
  object Label2: TLabel
    Left = 168
    Top = 224
    Width = 11
    Height = 13
    Caption = '6s'
    Visible = False
  end
  object Label3: TLabel
    Left = 120
    Top = 248
    Width = 59
    Height = 13
    Caption = 'Ausstehend:'
  end
  object Label4: TLabel
    Left = 184
    Top = 248
    Width = 43
    Height = 13
    Caption = '0 Pakete'
  end
  object Label5: TLabel
    Left = 248
    Top = 192
    Width = 14
    Height = 13
    Caption = '0%'
  end
  object Label6: TLabel
    Left = 8
    Top = 176
    Width = 131
    Height = 13
    Caption = 'WLAN-Verbindungsqualit'#228't:'
  end
  object Shape1: TShape
    Left = 8
    Top = 224
    Width = 17
    Height = 17
    Brush.Color = clRed
    Shape = stCircle
  end
  object Label7: TLabel
    Left = 32
    Top = 224
    Width = 55
    Height = 13
    Caption = 'Alive-Signal'
  end
  object Label8: TLabel
    Left = 32
    Top = 248
    Width = 52
    Height = 13
    Caption = 'Verbunden'
  end
  object Shape2: TShape
    Left = 8
    Top = 248
    Width = 17
    Height = 17
    Brush.Color = clRed
    Shape = stCircle
  end
  object Shape3: TShape
    Left = 0
    Top = 273
    Width = 281
    Height = 1
    Align = alBottom
  end
  object Shape5: TShape
    Left = 0
    Top = 56
    Width = 281
    Height = 1
  end
  object Label9: TLabel
    Left = 8
    Top = 8
    Width = 205
    Height = 13
    Caption = 'Eurolite freeDMX-AP Wi-Fi Interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label13: TLabel
    Left = 8
    Top = 24
    Width = 101
    Height = 13
    Caption = 'v1.0 vom 29.12.2016'
    Transparent = True
  end
  object Button1: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Verbinden'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Trennen'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 168
    Top = 144
    Width = 105
    Height = 25
    Caption = 'Send Testdata'
    TabOrder = 2
    Visible = False
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 192
    Width = 233
    Height = 17
    Smooth = True
    TabOrder = 3
  end
  object Button4: TButton
    Left = 8
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 64
    Width = 265
    Height = 73
    Caption = ' Einstellungen '
    TabOrder = 5
    object Label10: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 13
      Caption = 'IP Adresse:'
    end
    object Label11: TLabel
      Left = 104
      Top = 24
      Width = 45
      Height = 13
      Caption = 'Port (AP):'
    end
    object Label12: TLabel
      Left = 168
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Port (Lokal):'
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 89
      Height = 21
      TabOrder = 0
      Text = '192.168.4.1'
    end
    object edit2: TJvSpinEdit
      Left = 104
      Top = 40
      Width = 57
      Height = 21
      Value = 10100.000000000000000000
      TabOrder = 1
    end
    object edit3: TJvSpinEdit
      Left = 168
      Top = 40
      Width = 57
      Height = 21
      Value = 10101.000000000000000000
      TabOrder = 2
    end
  end
  object udpserver: TIdUDPServer
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = udpserverUDPRead
    Left = 208
    Top = 8
  end
  object udpclient: TIdUDPClient
    BroadcastEnabled = True
    Port = 0
    Left = 240
    Top = 8
  end
  object TimeoutTimer: TTimer
    Enabled = False
    OnTimer = TimeoutTimerTimer
    Left = 240
    Top = 72
  end
  object SendTimer: TCHHighResTimer
    OnTimer = SendTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = False
    Left = 240
    Top = 40
  end
  object GUITimer: TTimer
    Enabled = False
    Interval = 150
    OnTimer = GUITimerTimer
    Left = 208
    Top = 40
  end
  object StartupTimer: TTimer
    Enabled = False
    Interval = 750
    OnTimer = StartupTimerTimer
    Left = 176
    Top = 40
  end
end
