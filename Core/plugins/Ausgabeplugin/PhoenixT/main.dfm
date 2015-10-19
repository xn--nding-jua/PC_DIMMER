object Mainform: TMainform
  Left = 896
  Top = 184
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 337
  ClientWidth = 417
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 296
    Width = 417
    Height = 9
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 304
    Top = 312
    Width = 61
    Height = 13
    Caption = 'DLL-Version:'
  end
  object dllversionlbl: TLabel
    Left = 368
    Top = 312
    Width = 9
    Height = 13
    Caption = '...'
  end
  object Label4: TLabel
    Left = 8
    Top = 24
    Width = 106
    Height = 13
    Caption = 'Gefundene Interfaces:'
  end
  object Label5: TLabel
    Left = 312
    Top = 24
    Width = 103
    Height = 13
    Caption = 'DMX-Out ab Adresse:'
  end
  object Label6: TLabel
    Left = 312
    Top = 64
    Width = 81
    Height = 13
    Caption = 'Offset f'#252'r DataIn:'
  end
  object Label7: TLabel
    Left = 314
    Top = 104
    Width = 85
    Height = 13
    Caption = 'DMX-Out Interval:'
  end
  object Label8: TLabel
    Left = 314
    Top = 144
    Width = 77
    Height = 13
    Caption = 'DMX-In Interval:'
  end
  object Label9: TLabel
    Left = 395
    Top = 124
    Width = 13
    Height = 13
    Caption = 'ms'
  end
  object Label10: TLabel
    Left = 395
    Top = 163
    Width = 13
    Height = 13
    Caption = 'ms'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 169
    Height = 13
    Caption = 'PhoenixT USB DMX-Interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ConfigOK: TButton
    Left = 8
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 8
    Top = 40
    Width = 297
    Height = 113
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
    OnKeyUp = ListBox1KeyUp
  end
  object Button1: TButton
    Left = 8
    Top = 160
    Width = 297
    Height = 25
    Caption = 'Erneut nach Interfaces suchen...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 192
    Width = 297
    Height = 17
    Caption = 'DMX-Eingang verwenden'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnKeyUp = CheckBox1KeyUp
    OnMouseUp = CheckBox1MouseUp
  end
  object dmxoutoffsetedit: TJvSpinEdit
    Left = 312
    Top = 40
    Width = 97
    Height = 21
    Value = 1.000000000000000000
    TabOrder = 4
    OnChange = dmxoutoffseteditChange
  end
  object datainoffsetedit: TJvSpinEdit
    Left = 312
    Top = 80
    Width = 97
    Height = 21
    TabOrder = 5
    OnChange = datainoffseteditChange
  end
  object dmxoutintervaledit: TJvSpinEdit
    Left = 312
    Top = 120
    Width = 81
    Height = 21
    MaxValue = 1000.000000000000000000
    MinValue = 20.000000000000000000
    Value = 40.000000000000000000
    TabOrder = 6
    OnChange = dmxoutintervaleditChange
  end
  object dmxinintervaledit: TJvSpinEdit
    Left = 312
    Top = 160
    Width = 81
    Height = 21
    MaxValue = 1000.000000000000000000
    MinValue = 20.000000000000000000
    Value = 40.000000000000000000
    TabOrder = 7
    OnChange = dmxinintervaleditChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 216
    Width = 401
    Height = 73
    Caption = ' Erweiterte Einstellungen '
    TabOrder = 8
    object Label11: TLabel
      Left = 96
      Top = 24
      Width = 70
      Height = 13
      Caption = 'Breaktime ['#181's]:'
    end
    object Label12: TLabel
      Left = 184
      Top = 24
      Width = 128
      Height = 13
      Caption = 'Mark-Time after Break ['#181's]:'
    end
    object Label13: TLabel
      Left = 8
      Top = 24
      Width = 79
      Height = 13
      Caption = 'Blockierzeit [ms]:'
    end
    object breaktimeedit: TJvSpinEdit
      Left = 96
      Top = 40
      Width = 73
      Height = 21
      Value = 200.000000000000000000
      TabOrder = 0
    end
    object mabtimeedit: TJvSpinEdit
      Left = 184
      Top = 40
      Width = 73
      Height = 21
      Value = 20.000000000000000000
      TabOrder = 1
    end
    object blocktimeedit: TJvSpinEdit
      Left = 8
      Top = 40
      Width = 73
      Height = 21
      CheckMaxValue = False
      MinValue = 1.000000000000000000
      Value = 100.000000000000000000
      TabOrder = 2
    end
  end
  object DMXTimer: TCHHighResTimer
    OnTimer = DMXTimerTimer
    Interval = 40
    Accuracy = 0
    Enabled = False
    Left = 240
    Top = 48
  end
  object DMXInTimer: TCHHighResTimer
    OnTimer = DMXInTimerTimer
    Interval = 40
    Accuracy = 0
    Enabled = False
    Left = 272
    Top = 48
  end
end
