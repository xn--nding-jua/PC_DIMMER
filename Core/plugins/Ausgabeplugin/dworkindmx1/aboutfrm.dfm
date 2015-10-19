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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 151
    Height = 16
    Caption = 'Dworkin DMX 1 Plugin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 120
    Height = 13
    Caption = '512 Kanal DMX Interface'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 187
    Height = 13
    Caption = 'Copyrights (c) 2008 by Michael Dworkin'
  end
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 158
    Height = 13
    Caption = 'Infos unter http://dworkin-dmx.de'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 112
    Width = 257
    Height = 9
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 8
    Top = 88
    Width = 108
    Height = 13
    Caption = 'mischa.dw@gmail.com'
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
