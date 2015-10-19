object commandform: Tcommandform
  Left = 783
  Top = 112
  BorderStyle = bsToolWindow
  Caption = 'Kommandozeile'
  ClientHeight = 209
  ClientWidth = 209
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 168
    Width = 9
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 184
    Width = 193
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Kommando hier eingeben...'
    OnEnter = Edit1Enter
    OnExit = Edit1Exit
    OnKeyUp = Edit1KeyUp
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 33
    Height = 33
    Caption = '1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 8
    Width = 33
    Height = 33
    Caption = '2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 88
    Top = 8
    Width = 33
    Height = 33
    Caption = '3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 48
    Width = 33
    Height = 33
    Caption = '4'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 48
    Top = 48
    Width = 33
    Height = 33
    Caption = '5'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 88
    Top = 48
    Width = 33
    Height = 33
    Caption = '6'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 88
    Width = 33
    Height = 33
    Caption = '7'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 48
    Top = 88
    Width = 33
    Height = 33
    Caption = '8'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 88
    Top = 88
    Width = 33
    Height = 33
    Caption = '9'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 8
    Top = 128
    Width = 33
    Height = 33
    Caption = '0'
    TabOrder = 10
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 48
    Top = 128
    Width = 73
    Height = 33
    Hint = 'Entertaste'
    Caption = 'Enter'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = Button11Click
  end
  object Button13: TButton
    Left = 128
    Top = 88
    Width = 33
    Height = 33
    Hint = '- Taste'
    Caption = 'Thru'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = Button13Click
  end
  object Button15: TButton
    Left = 128
    Top = 128
    Width = 33
    Height = 33
    Hint = '+ Taste'
    Caption = '@'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = Button15Click
  end
  object TrackBar1: TTrackBar
    Left = 168
    Top = 0
    Width = 33
    Height = 169
    Max = 255
    Orientation = trVertical
    TabOrder = 14
    TickStyle = tsManual
    OnChange = TrackBar1Change
  end
end
