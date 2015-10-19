object Mainform: TMainform
  Left = 664
  Top = 100
  BorderStyle = bsToolWindow
  Caption = 'Konfiguration'
  ClientHeight = 345
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 304
    Width = 417
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 214
    Height = 13
    Caption = 'PC_DIMMER PluginSDK Outputplugin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 125
    Height = 13
    Caption = '- Konfigurationsbildschirm -'
  end
  object Label3: TLabel
    Left = 8
    Top = 224
    Width = 57
    Height = 13
    Caption = 'Verzeichnis:'
  end
  object ConfigOK: TButton
    Left = 8
    Top = 312
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Abbrechen: TButton
    Left = 88
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object memo1: TMemo
    Left = 8
    Top = 240
    Width = 401
    Height = 57
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 64
    Width = 401
    Height = 25
    Caption = 'Kanalwert von Kanal 1 im Hauptprogramm ver'#228'ndern'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 96
    Width = 401
    Height = 25
    Caption = 'DataIn Event auf Kanal 1 im Hauptprogramm ver'#228'ndern'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 128
    Width = 401
    Height = 25
    Caption = 'Kanalnamen von Kanal 1 im Hauptprogramm ver'#228'ndern'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 160
    Width = 401
    Height = 25
    Caption = 'Kanalwert von Kanal 1 vom Hauptprogramm abfragen'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 192
    Width = 401
    Height = 25
    Caption = 'Message zum Hauptprogramm senden (siehe messagesystem.pas)'
    TabOrder = 7
    OnClick = Button5Click
  end
end
