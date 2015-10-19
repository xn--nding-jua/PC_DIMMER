object About: TAbout
  Left = 505
  Top = 108
  BorderStyle = bsToolWindow
  Caption = 'Info...'
  ClientHeight = 313
  ClientWidth = 321
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
    Width = 177
    Height = 16
    Caption = 'Elektor MoMoLight-Plugin'
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
    Width = 145
    Height = 13
    Caption = 'USB LivingColor -Lamp Control'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 230
    Height = 13
    Caption = 'Copyrights (c) 2009 by Dipl.-Ing. Christian N'#246'ding'
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
    Top = 272
    Width = 321
    Height = 9
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 8
    Top = 88
    Width = 130
    Height = 13
    Caption = 'christian.noeding@arcor.de'
  end
  object Bevel2: TBevel
    Left = -2
    Top = 112
    Width = 323
    Height = 9
    Shape = bsTopLine
  end
  object Label6: TLabel
    Left = 8
    Top = 120
    Width = 136
    Height = 13
    Caption = 'Protokoll-Informationen:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 144
    Width = 305
    Height = 41
    AutoSize = False
    Caption = 
      'Das "MoMoLight"-Protokoll wird unter anderem in der Elektor 06/2' +
      '009 beschrieben. Es umfasst lediglich 9 Byte, die die Helligkeit' +
      'sinformation der einzelnen Farben beinhaltet:'
    WordWrap = True
  end
  object Label8: TLabel
    Left = 8
    Top = 200
    Width = 212
    Height = 13
    Caption = 'R1, R2, R3, G1, G2, G3, B1, B2, B3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 224
    Width = 305
    Height = 41
    AutoSize = False
    Caption = 
      'Es wird eine RS232-Verbindungsgeschwindigkeit von 4800 Baud verw' +
      'endet. Somit kann man auch eigene Hardware mit diesem Plugin sch' +
      'nell verwenden.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 8
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
