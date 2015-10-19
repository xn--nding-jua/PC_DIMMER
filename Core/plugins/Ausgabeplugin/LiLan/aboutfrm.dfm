object About: TAbout
  Left = 505
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Info...'
  ClientHeight = 153
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 112
    Width = 257
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 151
    Height = 13
    Caption = 'LiLAN PC_DIMMER-Plugin'
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
    Width = 197
    Height = 13
    Caption = 'UDP-Nachrichtengesteuertes Lichtsystem'
  end
  object Label3: TLabel
    Left = 8
    Top = 40
    Width = 144
    Height = 13
    Caption = 'Light@Night Ethernet Protocol'
  end
  object Label5: TLabel
    Left = 8
    Top = 88
    Width = 164
    Height = 13
    Caption = '(c) 2013 Dipl.-Ing. Christian N'#246'ding'
  end
  object Label4: TLabel
    Left = 8
    Top = 56
    Width = 189
    Height = 13
    Caption = 'Support f'#252'r DMX512, Q-Bus und Tasten'
  end
  object Button1: TButton
    Left = 8
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
