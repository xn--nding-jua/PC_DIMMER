object Form1: TForm1
  Left = 969
  Top = 238
  Width = 286
  Height = 449
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 224
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Open SimpleIO.dll'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 104
    Width = 137
    Height = 25
    Caption = 'Close SimpleIO.dll'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 72
    Width = 137
    Height = 25
    Caption = 'Send some randome values'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 8
    Top = 40
    Width = 137
    Height = 25
    Caption = 'Connect'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 160
    Width = 137
    Height = 25
    Caption = 'OpenComPort'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 240
    Width = 137
    Height = 25
    Caption = 'CloseComPort'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 192
    Width = 137
    Height = 25
    Caption = 'SendData'
    TabOrder = 6
    OnClick = Button7Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 272
    Width = 265
    Height = 137
    ItemHeight = 13
    TabOrder = 7
  end
  object comport: TCommPortDriver
    Port = pnCOM5
    PortName = '\\.\COM5'
    BaudRate = br115200
    BaudRateValue = 115200
    EnableDTROnOpen = False
    OnReceiveData = comportReceiveData
    Left = 152
    Top = 160
  end
  object ComPort1: TComPort
    BaudRate = br115200
    Port = 'COM5'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    Left = 192
    Top = 160
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 152
    Top = 192
  end
end
