object patcontrol: Tpatcontrol
  Left = 485
  Top = 110
  BorderStyle = bsToolWindow
  Caption = 'Patterncontrol'
  ClientHeight = 338
  ClientWidth = 633
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
  object zeilenlabel: TLabel
    Left = 488
    Top = 296
    Width = 63
    Height = 13
    Caption = 'Zeilenanzahl:'
  end
  object pattern: TStringGrid
    Left = 8
    Top = 8
    Width = 617
    Height = 281
    BorderStyle = bsNone
    Color = clWhite
    ColCount = 33
    Ctl3D = False
    DefaultColWidth = 17
    DefaultRowHeight = 17
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goAlwaysShowEditor]
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnMouseDown = patternMouseDown
  end
  object optoabfolge: TEdit
    Left = 376
    Top = 256
    Width = 121
    Height = 21
    TabStop = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 1
    Visible = False
  end
  object Open: TButton
    Left = 184
    Top = 296
    Width = 75
    Height = 25
    Caption = #214'ffnen'
    TabOrder = 2
    OnClick = OpenClick
  end
  object Save: TButton
    Left = 272
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 3
    OnClick = SaveClick
  end
  object start: TButton
    Left = 8
    Top = 296
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = startClick
  end
  object ablauf: TListBox
    Left = 504
    Top = 256
    Width = 89
    Height = 25
    ItemHeight = 13
    TabOrder = 5
    Visible = False
  end
  object zeilenanzahl: TEdit
    Left = 560
    Top = 296
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 6
    Text = '1'
  end
  object Button2: TButton
    Left = 560
    Top = 312
    Width = 33
    Height = 17
    Caption = '<'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 592
    Top = 312
    Width = 33
    Height = 17
    Caption = '>'
    TabOrder = 8
    OnClick = Button3Click
  end
  object pendeln: TCheckBox
    Left = 392
    Top = 296
    Width = 65
    Height = 17
    Caption = 'Pendeln'
    TabOrder = 9
    Visible = False
  end
  object cancel: TButton
    Left = 96
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 10
  end
  object resetbtn: TButton
    Left = 488
    Top = 312
    Width = 65
    Height = 17
    Caption = 'Reset'
    TabOrder = 11
    OnClick = resetbtnClick
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.pcdptrn'
    Filter = 'PC_DIMMER Pattern-File (*.pcdptrn)|*.pcdptrn'
    Left = 56
    Top = 216
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.pcdptrn'
    Filter = 'PC_DIMMER Pattern-File (*.pcdptrn)|*.pcdptrn'
    Left = 16
    Top = 216
  end
end
