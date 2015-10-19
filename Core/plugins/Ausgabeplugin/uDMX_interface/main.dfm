object Mainform: TMainform
  Left = 664
  Top = 100
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 209
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 168
    Width = 273
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 164
    Height = 13
    Caption = 'uDMX-Interfacekonfiguration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 133
    Height = 13
    Caption = '(c) 2008 by Christian N'#246'ding'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 187
    Height = 13
    Caption = 'max. '#252'bertragene Kan'#228'le zur Hardware:'
  end
  object Label4: TLabel
    Left = 36
    Top = 84
    Width = 160
    Height = 13
    Caption = 'Refreshintervall [in Millisekunden]:'
  end
  object Label5: TLabel
    Left = 8
    Top = 112
    Width = 73
    Height = 13
    Caption = 'Interfacestatus:'
  end
  object statuslabel: TLabel
    Left = 88
    Top = 112
    Width = 107
    Height = 13
    Caption = 'Nicht verbunden...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ConfigOK: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Abbrechen: TButton
    Left = 88
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object maxchansedit: TJvSpinEdit
    Left = 200
    Top = 56
    Width = 65
    Height = 21
    MaxValue = 512.000000000000000000
    MinValue = 32.000000000000000000
    Value = 256.000000000000000000
    TabOrder = 2
    OnChange = maxchanseditChange
  end
  object refreshtimeedit: TJvSpinEdit
    Left = 200
    Top = 80
    Width = 65
    Height = 21
    CheckMaxValue = False
    MinValue = 25.000000000000000000
    Value = 50.000000000000000000
    TabOrder = 3
    OnChange = refreshtimeeditChange
  end
  object Button1: TButton
    Left = 8
    Top = 136
    Width = 257
    Height = 25
    Caption = 'uDMX Interface suchen...'
    TabOrder = 4
    OnClick = Button1Click
  end
  object uDMXTimer: TCHHighResTimer
    OnTimer = uDMXTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = False
    Left = 216
    Top = 8
  end
end
