object FramePlayList: TFramePlayList
  Left = 0
  Top = 0
  Width = 595
  Height = 349
  TabOrder = 0
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BtnLaden: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Laden'
      TabOrder = 0
      OnClick = BtnLadenClick
    end
    object BtnSpeichern: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Speichern'
      TabOrder = 1
      OnClick = BtnSpeichernClick
    end
    object BtnAddDatei: TButton
      Left = 272
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Datei hinzuf'#252'gen'
      TabOrder = 2
      OnClick = BtnAddDateiClick
    end
    object BtnAddVerzeichnis: TButton
      Left = 408
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Verzeichnis hinzuf'#252'gen'
      TabOrder = 3
      OnClick = BtnAddVerzeichnisClick
    end
    object BtnSpeichernUnter: TButton
      Left = 168
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Speichern unter'
      TabOrder = 4
      OnClick = BtnSpeichernUnterClick
    end
  end
  object TvPlaylist: TTreeView
    Left = 0
    Top = 41
    Width = 595
    Height = 308
    Align = alClient
    Indent = 19
    ReadOnly = True
    TabOrder = 1
    OnCustomDrawItem = TvPlaylistCustomDrawItem
    OnDblClick = TvPlaylistDblClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'M3U'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 40
    Top = 48
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'M3U'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 8
    Top = 48
  end
end
