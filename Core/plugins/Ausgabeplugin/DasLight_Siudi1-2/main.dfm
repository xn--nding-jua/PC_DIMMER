object Mainform: TMainform
  Left = 375
  Top = 74
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 217
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 176
    Width = 329
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 221
    Height = 13
    Caption = 'DasLight DVC-Plugin (Siudi1x, Siudi2x)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ConfigOK: TButton
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 32
    Width = 313
    Height = 65
    Caption = ' Externe Pins (Output) '
    TabOrder = 1
    object CheckBox1: TCheckBox
      Left = 64
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 1'
      TabOrder = 0
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox2: TCheckBox
      Left = 64
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 2'
      TabOrder = 1
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox3: TCheckBox
      Left = 128
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 3'
      TabOrder = 2
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox4: TCheckBox
      Left = 128
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 4'
      TabOrder = 3
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox5: TCheckBox
      Left = 192
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 5'
      TabOrder = 4
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox6: TCheckBox
      Left = 192
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 6'
      TabOrder = 5
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox7: TCheckBox
      Left = 256
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 7'
      TabOrder = 6
      OnMouseUp = CheckBox1MouseUp
    end
    object CheckBox8: TCheckBox
      Left = 256
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 8'
      TabOrder = 7
      OnMouseUp = CheckBox1MouseUp
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 104
    Width = 313
    Height = 65
    Caption = ' Externe Pins (Input) '
    TabOrder = 2
    object input2: TCheckBox
      Left = 64
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 1'
      Enabled = False
      TabOrder = 0
    end
    object input3: TCheckBox
      Left = 64
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 2'
      Enabled = False
      TabOrder = 1
    end
    object input4: TCheckBox
      Left = 128
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 3'
      Enabled = False
      TabOrder = 2
    end
    object input5: TCheckBox
      Left = 128
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 4'
      Enabled = False
      TabOrder = 3
    end
    object input6: TCheckBox
      Left = 192
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 5'
      Enabled = False
      TabOrder = 4
    end
    object input7: TCheckBox
      Left = 192
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 6'
      Enabled = False
      TabOrder = 5
    end
    object input8: TCheckBox
      Left = 256
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Pin 7'
      Enabled = False
      TabOrder = 6
    end
    object input9: TCheckBox
      Left = 256
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Pin 8'
      Enabled = False
      TabOrder = 7
    end
    object input0: TCheckBox
      Left = 8
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Next'
      Enabled = False
      TabOrder = 8
    end
    object input1: TCheckBox
      Left = 8
      Top = 40
      Width = 49
      Height = 17
      Caption = 'Prev'
      Enabled = False
      TabOrder = 9
    end
  end
  object RefreshTimer: TCHHighResTimer
    OnTimer = RefreshTimerTimer
    Interval = 50
    Accuracy = 0
    Enabled = True
    Left = 248
    Top = 16
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 280
    Top = 128
  end
end
