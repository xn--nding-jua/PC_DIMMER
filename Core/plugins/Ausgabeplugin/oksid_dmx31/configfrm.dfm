object Config: TConfig
  Left = 887
  Top = 87
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 361
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 312
    Width = 225
    Height = 9
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 168
    Height = 13
    Caption = 'OksiD DMX3/1 LPT Interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 264
    Width = 207
    Height = 13
    Caption = 'Dieses Plugin ist bislang ungetestet.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 280
    Width = 129
    Height = 13
    Caption = 'Bei Problemen bitte an'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 296
    Width = 209
    Height = 13
    Caption = 'christian.noeding@arcor.de wenden.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ConfigOK: TButton
    Left = 8
    Top = 328
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = ConfigOKClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 209
    Height = 49
    Caption = ' LPT-Port'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 55
      Height = 13
      Caption = 'Parallelport:'
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 16
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'LPT1: &H378'
      Items.Strings = (
        'LPT1: &H378'
        'LPT2: &H278')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 88
    Width = 209
    Height = 89
    Caption = ' DMX-Out '
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 26
      Width = 45
      Height = 13
      Caption = 'Universe:'
    end
    object Label3: TLabel
      Left = 8
      Top = 58
      Width = 132
      Height = 13
      Caption = 'Aktualisierungsintervall (ms):'
    end
    object ComboBox2: TComboBox
      Left = 72
      Top = 24
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Universe 1'
      Items.Strings = (
        'Universe 1'
        'Universe 2'
        'Universe 3')
    end
    object Edit1: TEdit
      Left = 152
      Top = 56
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '50'
      OnChange = Edit1Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 184
    Width = 209
    Height = 73
    Caption = ' DMX-In '
    TabOrder = 3
    object Label5: TLabel
      Left = 24
      Top = 48
      Width = 98
      Height = 13
      Caption = 'Abfrageintervall (ms):'
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 24
      Width = 97
      Height = 17
      Caption = 'DMX-In aktiv'
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 152
      Top = 44
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '50'
      OnChange = Edit2Change
    end
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 8
    Top = 32
  end
  object Timer2: TTimer
    Interval = 50
    OnTimer = Timer2Timer
    Left = 40
    Top = 32
  end
end
