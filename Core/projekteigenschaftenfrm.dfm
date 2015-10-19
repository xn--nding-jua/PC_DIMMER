object projekteigenschaftenform: Tprojekteigenschaftenform
  Left = 159
  Top = 124
  BorderStyle = bsSingle
  Caption = 'Projekteigenschaften'
  ClientHeight = 233
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 185
    Caption = ' Projekteigenschaften bearbeiten '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 49
      Height = 13
      Caption = 'Projekttitel'
    end
    object Label2: TLabel
      Left = 8
      Top = 72
      Width = 67
      Height = 13
      Caption = 'Projektversion'
    end
    object Label3: TLabel
      Left = 8
      Top = 120
      Width = 48
      Height = 13
      Caption = 'Bearbeiter'
    end
    object Label4: TLabel
      Left = 200
      Top = 24
      Width = 113
      Height = 13
      Caption = 'Letzte Programmversion'
    end
    object Label5: TLabel
      Left = 200
      Top = 40
      Width = 33
      Height = 13
      Caption = '4.0.0.0'
    end
    object Label6: TLabel
      Left = 200
      Top = 72
      Width = 71
      Height = 13
      Caption = 'Speicherdatum'
    end
    object Label7: TLabel
      Left = 200
      Top = 88
      Width = 54
      Height = 13
      Caption = '01.01.2008'
    end
    object Label8: TLabel
      Left = 200
      Top = 120
      Width = 125
      Height = 13
      Caption = 'Anzahl der Speicherungen'
    end
    object Label9: TLabel
      Left = 200
      Top = 136
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label10: TLabel
      Left = 280
      Top = 88
      Width = 27
      Height = 13
      Caption = '12:00'
    end
    object Label11: TLabel
      Left = 280
      Top = 72
      Width = 33
      Height = 13
      Caption = 'Uhrzeit'
    end
    object Edit1: TEdit
      Left = 8
      Top = 40
      Width = 177
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 8
      Top = 88
      Width = 177
      Height = 21
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 8
      Top = 136
      Width = 177
      Height = 21
      TabOrder = 2
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 160
      Width = 209
      Height = 17
      Caption = 'Automatisch Computernutzer eintragen'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnMouseUp = CheckBox1MouseUp
    end
  end
  object Button1: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
end
