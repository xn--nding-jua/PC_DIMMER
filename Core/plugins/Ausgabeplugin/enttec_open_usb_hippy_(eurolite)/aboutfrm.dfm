object About: TAbout
  Left = 505
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Info...'
  ClientHeight = 81
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
    Width = 178
    Height = 16
    Caption = 'Eurolite DMX512 Interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 24
    Width = 171
    Height = 13
    Caption = 'Infos unter http://www.pcdimmer.de'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 40
    Width = 257
    Height = 9
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 8
    Top = 48
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
