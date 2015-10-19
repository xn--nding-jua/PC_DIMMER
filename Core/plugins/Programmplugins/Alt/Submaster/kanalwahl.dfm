object kanalwahlform: Tkanalwahlform
  Left = 821
  Top = 59
  BorderStyle = bsToolWindow
  Caption = 'Kanalauswahl'
  ClientHeight = 465
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object a: TLabel
    Left = 286
    Top = 424
    Width = 235
    Height = 13
    Alignment = taRightJustify
    Caption = '(Strg+Klick oder Alt+Klick f'#252'r globales Selektieren)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object OKBtn: TButton
    Left = 16
    Top = 432
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 417
    Caption = ' Kanalauswahl '
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 392
      Width = 83
      Height = 13
      Caption = 'Springe zu Kanal:'
    end
    object StringGrid1: TStringGrid
      Left = 16
      Top = 24
      Width = 481
      Height = 361
      BorderStyle = bsNone
      Color = clWhite
      ColCount = 3
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goThumbTracking]
      TabOrder = 0
      OnDrawCell = StringGrid1DrawCell
      OnGetEditMask = StringGrid1GetEditMask
      OnKeyUp = StringGrid1KeyUp
      OnMouseUp = StringGrid1MouseUp
      ColWidths = (
        17
        34
        404)
    end
    object JumpToChannel: TEdit
      Left = 104
      Top = 388
      Width = 57
      Height = 21
      Color = clWhite
      TabOrder = 1
      OnKeyUp = JumpToChannelKeyUp
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.pcdfscn'
    Filter = 'PC_DIMMER Szene (*.pcdfscn)|*.pcdfscn|Alle Dateien (*.*)|*.*'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Title = 'PC_DIMMER Kanalwerte importieren'
    Left = 440
    Top = 24
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.pcdfscn'
    Filter = 'PC_DIMMER Szene (*.pcdfscn)|*.pcdfscn|Alle Dateien (*.*)|*.*'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Title = 'PC_DIMMER Kanalwerte exportieren'
    Left = 472
    Top = 24
  end
end
