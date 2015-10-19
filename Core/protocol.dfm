object protocolbox: Tprotocolbox
  Left = 292
  Top = 115
  BorderStyle = bsToolWindow
  Caption = 'PC_DIMMER Protokollfenster'
  ClientHeight = 281
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TShape
    Left = 0
    Top = 240
    Width = 753
    Height = 41
    Align = alBottom
    Pen.Style = psClear
  end
  object Label1: TLabel
    Left = 312
    Top = 256
    Width = 429
    Height = 13
    Caption = 
      'Die Daten werden automatisch im Programmverzeichnis als PC_DIMME' +
      'R.log gespeichert...'
    Transparent = True
  end
  object Shape1: TShape
    Left = 0
    Top = 240
    Width = 753
    Height = 1
  end
  object OK: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 737
    Height = 225
    Caption = ' Programm-Meldungen '
    TabOrder = 1
    object debuglistbox: TListBox
      Left = 8
      Top = 16
      Width = 721
      Height = 201
      Style = lbOwnerDrawFixed
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      ItemHeight = 13
      TabOrder = 0
      OnDrawItem = debuglistboxDrawItem
    end
  end
end
