object About: TAbout
  Left = 505
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Info...'
  ClientHeight = 129
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
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 170
    Height = 13
    Caption = 'Infos unter http://www.cypress.com'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 88
    Width = 257
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 198
    Height = 13
    Caption = 'Cypress PSoC USB2DMX Interface'
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
    Caption = '(c) 2009 by Christian N'#246'ding'
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
