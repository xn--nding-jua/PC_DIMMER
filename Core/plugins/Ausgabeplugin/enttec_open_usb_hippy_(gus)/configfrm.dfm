object Config: TConfig
  Left = 657
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 137
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 191
    Height = 16
    Caption = 'Gus Electronics USB-VL344'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 0
    Top = 96
    Width = 265
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 163
    Height = 13
    Caption = 'Zeit zwischen zwei Datenpaketen:'
  end
  object Label3: TLabel
    Left = 235
    Top = 40
    Width = 13
    Height = 13
    Caption = 'ms'
  end
  object ConfigOK: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 64
    Width = 121
    Height = 25
    Caption = 'Verbindung herstellen'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 64
    Width = 121
    Height = 25
    Caption = 'Verbindung trennen'
    TabOrder = 2
    OnClick = Button2Click
  end
  object intervaledit: TJvSpinEdit
    Left = 176
    Top = 37
    Width = 57
    Height = 21
    MaxValue = 5000.000000000000000000
    MinValue = 50.000000000000000000
    Value = 150.000000000000000000
    TabOrder = 3
    OnChange = intervaleditChange
  end
  object DMXTimer: TCHHighResTimer
    OnTimer = DMXTimerTimer
    Interval = 150
    Accuracy = 0
    Enabled = False
    Left = 232
    Top = 8
  end
end
