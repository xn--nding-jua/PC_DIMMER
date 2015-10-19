object Config: TConfig
  Left = 557
  Top = 121
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 217
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 91
    Height = 16
    Caption = 'Konfiguration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 88
    Height = 13
    Caption = 'Serieller Anschluss'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 176
    Width = 265
    Height = 9
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 52
    Width = 91
    Height = 13
    Caption = 'kein Anschluss frei!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 80
    Width = 70
    Height = 13
    Caption = 'RGB-Lampe 1:'
  end
  object Label5: TLabel
    Left = 96
    Top = 80
    Width = 70
    Height = 13
    Caption = 'RGB-Lampe 2:'
  end
  object Label6: TLabel
    Left = 184
    Top = 80
    Width = 70
    Height = 13
    Caption = 'RGB-Lampe 3:'
  end
  object Shape1: TShape
    Left = 8
    Top = 96
    Width = 73
    Height = 73
    Brush.Color = clBlack
  end
  object Shape2: TShape
    Left = 96
    Top = 96
    Width = 73
    Height = 73
    Brush.Color = clBlack
  end
  object Shape3: TShape
    Left = 184
    Top = 96
    Width = 73
    Height = 73
    Brush.Color = clBlack
  end
  object portchange: TComboBox
    Left = 8
    Top = 48
    Width = 249
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = portchangeChange
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
  object ConfigOK: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object comport: TCommPortDriver
    Port = pnCustom
    PortName = '\\.\COM2'
    BaudRate = brCustom
    BaudRateValue = 4800
    Left = 224
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 192
    Top = 8
  end
  object sendtimer: TCHHighResTimer
    OnTimer = sendtimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = True
    Left = 160
    Top = 8
  end
end
