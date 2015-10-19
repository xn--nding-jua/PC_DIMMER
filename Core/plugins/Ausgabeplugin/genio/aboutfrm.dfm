object About: TAbout
  Left = 505
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Info...'
  ClientHeight = 137
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
    Width = 159
    Height = 16
    Caption = 'GenIO DMX512-Sender'
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
    Width = 152
    Height = 13
    Caption = 'Ausgabeplugin f'#252'r PC_DIMMER'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 101
    Height = 13
    Caption = 'v1.0 vom 17.06.2012'
  end
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 171
    Height = 13
    Caption = 'Infos unter http://www.pcdimmer.de'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 96
    Width = 257
    Height = 9
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
