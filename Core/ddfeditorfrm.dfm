object ddfeditorform: Tddfeditorform
  Left = 704
  Top = 298
  Width = 895
  Height = 542
  Caption = 'DDF Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Symbols: TTBDock
    Left = 0
    Top = 25
    Width = 879
    Height = 26
    object gitternetzgroessen: TLabel
      Left = 440
      Top = 8
      Width = 75
      Height = 13
      Caption = 'Gitternetzgr'#246#223'e:'
    end
    object GridSizeTrackbar: TTrackBar
      Left = 528
      Top = 1
      Width = 206
      Height = 25
      Hint = 'Gitternetzgr'#246#223'e'
      Max = 4
      Min = 1
      ParentShowHint = False
      Position = 2
      ShowHint = True
      TabOrder = 0
      ThumbLength = 15
      OnChange = GridSizeTrackbarChange
    end
    object TBToolbar2: TTBToolbar
      Left = 0
      Top = 0
      BorderStyle = bsNone
      Caption = 'Standardoptionen'
      DockPos = -2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object TBItem14: TTBItem
        Caption = 'Neues DDF'
        Hint = 'Neue Ger'#228'tedatei'
        ImageIndex = 0
        Images = MainForm.PngImageList1
        OnClick = NeuesDDF1Click
      end
      object TBItem13: TTBItem
        Caption = 'DDF '#246'ffnen...'
        Hint = 'Ger'#228'tedatei '#246'ffnen...'
        ImageIndex = 1
        Images = MainForm.PngImageList1
        OnClick = DDFffnen1Click
      end
      object TBItem12: TTBItem
        Caption = 'DDF speichern...'
        Hint = 'Ger'#228'tedatei speichern...'
        ImageIndex = 2
        Images = MainForm.PngImageList1
        OnClick = TBItem23Click
      end
    end
    object TBToolbar1: TTBToolbar
      Left = 79
      Top = 0
      BorderStyle = bsNone
      Caption = 'Komponenten'
      Images = TBImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object TBItem11: TTBItem
        Caption = 'Ger'#228'tebild und -name'
        Hint = 'Ger'#228'tebild und -name'
        ImageIndex = 16
        Images = TBImageList1
        OnClick = TBItem11Click
      end
      object TBItem8: TTBItem
        Caption = 'Label'
        Hint = 'Label'
        ImageIndex = 0
        Images = TBImageList1
        OnClick = TBItem8Click
      end
      object TBItem7: TTBItem
        Caption = 'Editbox'
        Hint = 'Editbox'
        ImageIndex = 9
        OnClick = TBItem7Click
      end
      object TBItem6: TTBItem
        Caption = 'Button'
        Hint = 'Button'
        ImageIndex = 1
        Images = TBImageList1
        OnClick = TBItem6Click
      end
      object TBItem15: TTBItem
        Caption = 'Progressbar'
        Hint = 'Fortschrittsbalken'
        ImageIndex = 5
        Images = TBImageList1
        OnClick = TBItem15Click
      end
      object TBItem5: TTBItem
        Caption = 'Checkbox'
        Hint = 'Checkbox'
        ImageIndex = 2
        Images = TBImageList1
        OnClick = TBItem5Click
      end
      object TBItem9: TTBItem
        Caption = 'Radiobutton'
        Hint = 'Radiobutton'
        ImageIndex = 6
        Images = TBImageList1
        OnClick = TBItem9Click
      end
      object TBItem4: TTBItem
        Caption = 'Combobox'
        Hint = 'Combobox'
        ImageIndex = 3
        Images = TBImageList1
        OnClick = TBItem4Click
      end
      object TBItem3: TTBItem
        Caption = 'Slider'
        Hint = 'Slider'
        ImageIndex = 4
        Images = TBImageList1
        OnClick = TBItem3Click
      end
      object TBItem2: TTBItem
        Caption = 'Colorpicker'
        Hint = 'Colorpicker'
        ImageIndex = 7
        Images = TBImageList1
        OnClick = TBItem2Click
      end
      object TBItem10: TTBItem
        Caption = 'Linie'
        Hint = 'Linie'
        ImageIndex = 10
        Images = TBImageList1
        OnClick = TBItem10Click
      end
      object TBItem1: TTBItem
        Caption = 'Positionierung'
        Hint = 'Positionierung'
        ImageIndex = 15
        Images = TBImageList1
        OnClick = TBItem1Click
      end
      object TBItem18: TTBItem
        Caption = 'Farbauswahl (COLOR1-Kanal)'
        Hint = 'Farbauswahl (COLOR1-Kanal)'
        ImageIndex = 3
        OnClick = TBItem17Click
      end
      object TBItem21: TTBItem
        Caption = 'Farbauswahl (COLOR2-Kanal)'
        Hint = 'Farbauswahl (COLOR1-Kanal)'
        ImageIndex = 3
        OnClick = TBItem21Click
      end
      object TBItem20: TTBItem
        Caption = 'DIP-Anzeige'
        Hint = 'DIP-Anzeige der Startadresse'
        ImageIndex = 17
        Images = TBImageList1
        OnClick = TBItem19Click
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 484
    Width = 879
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PageControl1: TPageControl
    Left = 233
    Top = 51
    Width = 646
    Height = 433
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Grundeinstellungen'
      object grundeinstellungelbl: TLabel
        Left = 8
        Top = 8
        Width = 100
        Height = 13
        Caption = 'Ger'#228'teeinstellung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object namelbl: TLabel
        Left = 46
        Top = 35
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Name:'
      end
      object herstellerlbl: TLabel
        Left = 30
        Top = 59
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Hersteller:'
      end
      object autorlbl: TLabel
        Left = 49
        Top = 84
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Autor:'
      end
      object beschreibunglbl: TLabel
        Left = 9
        Top = 107
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Beschreibung:'
      end
      object geraetebildlbl: TLabel
        Left = 28
        Top = 132
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Ger'#228'tebild:'
      end
      object theline: TBevel
        Left = 8
        Top = 24
        Width = 377
        Height = 9
        Shape = bsTopLine
      end
      object breitelbl: TLabel
        Left = 49
        Top = 164
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Breite:'
      end
      object hoehelbl: TLabel
        Left = 154
        Top = 164
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'H'#246'he:'
      end
      object Bevel2: TBevel
        Left = 8
        Top = 240
        Width = 377
        Height = 9
        Shape = bsTopLine
      end
      object matrixheaderlbl: TLabel
        Left = 8
        Top = 224
        Width = 64
        Height = 13
        Caption = 'Matrixger'#228't'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object matrixbreitelbl: TLabel
        Left = 9
        Top = 276
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Breite:'
      end
      object matrixhoehelbl: TLabel
        Left = 114
        Top = 276
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'H'#246'he:'
      end
      object typeofmatrixlbl: TLabel
        Left = 8
        Top = 300
        Width = 65
        Height = 13
        Caption = 'Art der Matrix:'
      end
      object nameedit: TEdit
        Left = 80
        Top = 32
        Width = 169
        Height = 21
        TabOrder = 0
        Text = 'Neues Ger'#228't'
      end
      object vendoredit: TEdit
        Left = 80
        Top = 56
        Width = 169
        Height = 21
        TabOrder = 1
        Text = 'Vendor'
      end
      object autoredit: TEdit
        Left = 80
        Top = 80
        Width = 169
        Height = 21
        TabOrder = 2
        Text = 'Neuer Autor'
      end
      object beschreibungedit: TEdit
        Left = 80
        Top = 104
        Width = 169
        Height = 21
        TabOrder = 3
        Text = 'Neues Ger'#228't'
      end
      object bildedit: TEdit
        Left = 80
        Top = 128
        Width = 129
        Height = 21
        TabOrder = 4
        Text = 'Par56silber.png'
      end
      object openpicturebtn: TButton
        Left = 216
        Top = 128
        Width = 33
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = openpicturebtnClick
      end
      object widthspin: TJvSpinEdit
        Left = 80
        Top = 160
        Width = 65
        Height = 21
        CheckMinValue = True
        Value = 233.000000000000000000
        TabOrder = 6
        OnChange = widthspinChange
      end
      object heightspin: TJvSpinEdit
        Left = 184
        Top = 160
        Width = 65
        Height = 21
        Value = 305.000000000000000000
        TabOrder = 7
        OnChange = heightspinChange
      end
      object autoddfbtn2: TButton
        Left = 8
        Top = 192
        Width = 241
        Height = 25
        Caption = 'Erzeuge GUI anhand Kan'#228'len'
        TabOrder = 8
        OnClick = autoddfbtnClick
      end
      object IsMatrixDevice: TCheckBox
        Left = 8
        Top = 248
        Width = 185
        Height = 17
        Caption = 'Ger'#228't als Matrixger'#228't verwenden'
        TabOrder = 9
      end
      object MatrixXCount: TJvSpinEdit
        Left = 40
        Top = 272
        Width = 65
        Height = 21
        MaxValue = 64.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 10
        OnChange = widthspinChange
      end
      object MatrixYCount: TJvSpinEdit
        Left = 144
        Top = 272
        Width = 65
        Height = 21
        MaxValue = 64.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 11
        OnChange = heightspinChange
      end
      object MatrixType: TComboBox
        Left = 8
        Top = 320
        Width = 377
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 12
        Text = 'L->R, n'#228'chste Zeile wieder L->R'
        Items.Strings = (
          'L->R, n'#228'chste Zeile wieder L->R'
          'Gerade Reihe: L->R, ungerade Reihe: R->L'
          'Oben->Unten, n'#228'chste Spalte wieder Oben->Unten'
          'Gerade Spalte Oben->Unten, ungerade Spalte Unten->Oben')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Kan'#228'le'
      ImageIndex = 1
      object kanaleinstellungenlbl: TLabel
        Left = 8
        Top = 8
        Width = 108
        Height = 13
        Caption = 'Kanaleinstellungen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object theline2: TBevel
        Left = 7
        Top = 24
        Width = 377
        Height = 9
        Shape = bsTopLine
      end
      object editierekanallb: TLabel
        Left = 9
        Top = 59
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Editiere Kanal:'
      end
      object kanalanzahllbl: TLabel
        Left = 16
        Top = 35
        Width = 61
        Height = 13
        Alignment = taRightJustify
        Caption = 'Kanalanzahl:'
      end
      object kanananzahlanzeigelbl: TLabel
        Left = 83
        Top = 35
        Width = 6
        Height = 13
        Caption = '1'
      end
      object kanalnamelbl: TLabel
        Left = 21
        Top = 108
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Kanalname:'
      end
      object minvaluelbl: TLabel
        Left = 4
        Top = 131
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'Minimaler Wert:'
      end
      object maxvaluelbl: TLabel
        Left = 1
        Top = 156
        Width = 76
        Height = 13
        Alignment = taRightJustify
        Caption = 'Maximaler Wert:'
      end
      object kanaltyplbl: TLabel
        Left = 33
        Top = 84
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Kanaltyp:'
      end
      object initlbl: TLabel
        Left = 32
        Top = 180
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Startwert:'
      end
      object JvSpinEdit1: TJvSpinEdit
        Left = 80
        Top = 56
        Width = 105
        Height = 21
        CheckMaxValue = False
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 2
        OnChange = JvSpinEdit1Change
      end
      object PngBitBtn1: TPngBitBtn
        Left = 112
        Top = 32
        Width = 33
        Height = 21
        Hint = 'F'#252'gt dem Ger'#228't einen neuen Kanal hinzu'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = PngBitBtn1Click
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
          6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
          F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
          561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
          7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
          1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
          01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
          C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
          00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
          00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
          CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
          4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
          48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
          223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
          560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
          2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
          FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
          F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
          4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
          79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
          812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
          0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
          170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
          48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
          90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
          5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
          5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
          8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
          272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
          48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
          6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
          A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
          2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
          1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
          192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
          3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
          09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
          46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
          EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
          4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
          EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
          79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
          3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
          67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
          6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
          A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
          5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
          D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
          743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
          4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
          D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
          C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
          3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
          FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
          0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
          15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
          476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
          BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
          F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
          A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
          6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
          68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
          949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
          F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
          DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
          772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
          A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
          955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
          EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
          CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
          26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
          8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
          B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
          7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
          EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
          E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
          5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
          EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
          EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
          FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
          CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
          ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
          CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
          F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
          86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
          56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
          566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
          C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
          3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
          67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
          1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
          CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
          42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
          5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
          0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
          80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
          782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
          0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
          937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
          746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
          611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
          CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
          2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
          2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
          2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
          D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
          9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
          BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
          C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
          246B0000000049454E44AE426082}
        PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
      end
      object PngBitBtn2: TPngBitBtn
        Left = 152
        Top = 32
        Width = 33
        Height = 21
        Hint = 'L'#246'scht den letzten Kanal des Ger'#228'tes'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PngBitBtn2Click
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
          6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
          F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
          561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
          7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
          1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
          01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
          C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
          00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
          00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
          CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
          4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
          48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
          223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
          560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
          2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
          FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
          F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
          4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
          79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
          812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
          0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
          170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
          48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
          90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
          5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
          5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
          8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
          272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
          48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
          6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
          A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
          2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
          1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
          192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
          3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
          09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
          46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
          EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
          4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
          EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
          79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
          3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
          67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
          6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
          A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
          5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
          D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
          743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
          4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
          D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
          C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
          3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
          FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
          0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
          15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
          476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
          BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
          F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
          A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
          6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
          68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
          949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
          F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
          DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
          772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
          A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
          955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
          EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
          CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
          26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
          8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
          B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
          7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
          EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
          E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
          5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
          EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
          EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
          FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
          CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
          ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
          CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
          F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
          86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
          9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
          669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
          BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
          6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
          C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
          1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
          101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
          F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
        PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
      end
      object kanalnameedit: TEdit
        Left = 80
        Top = 104
        Width = 105
        Height = 21
        TabOrder = 4
        Text = 'DIMMER'
        OnKeyUp = kanalnameeditKeyUp
      end
      object typliste: TComboBox
        Left = 80
        Top = 80
        Width = 105
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = 'DIMMER'
        OnSelect = typlisteSelect
      end
      object initvalueedit: TJvSpinEdit
        Left = 80
        Top = 176
        Width = 105
        Height = 21
        MaxValue = 255.000000000000000000
        MinValue = -1.000000000000000000
        Value = -1.000000000000000000
        TabOrder = 7
        OnChange = initvalueeditChange
      end
      object minvalueedit: TJvSpinEdit
        Left = 80
        Top = 128
        Width = 105
        Height = 21
        MaxValue = 255.000000000000000000
        TabOrder = 5
        OnChange = minvalueeditChange
      end
      object maxvalueedit: TJvSpinEdit
        Left = 80
        Top = 152
        Width = 105
        Height = 21
        MaxValue = 255.000000000000000000
        Value = 255.000000000000000000
        TabOrder = 6
        OnChange = maxvalueeditChange
      end
      object autoddfbtn: TButton
        Left = 8
        Top = 224
        Width = 177
        Height = 25
        Caption = 'Erzeuge GUI anhand Kan'#228'len'
        TabOrder = 9
        OnClick = autoddfbtnClick
      end
      object PageControl2: TPageControl
        Left = 192
        Top = 32
        Width = 449
        Height = 369
        ActivePage = TabSheet6
        TabOrder = 10
        object TabSheet6: TTabSheet
          Caption = 'Farben'
          object colorlbl2: TLabel
            Left = 224
            Top = 3
            Width = 203
            Height = 13
            Caption = 'Tabelle der Ger'#228'tefarben (COLOR2-Kanal):'
          end
          object startvaluelbl2: TLabel
            Left = 224
            Top = 160
            Width = 45
            Height = 13
            Caption = 'Startwert:'
          end
          object endvaluelbl2: TLabel
            Left = 280
            Top = 160
            Width = 42
            Height = 13
            Caption = 'Endwert:'
          end
          object colorlbl: TLabel
            Left = 8
            Top = 3
            Width = 203
            Height = 13
            Caption = 'Tabelle der Ger'#228'tefarben (COLOR1-Kanal):'
          end
          object startvaluelbl: TLabel
            Left = 8
            Top = 160
            Width = 45
            Height = 13
            Caption = 'Startwert:'
          end
          object endvaluelbl: TLabel
            Left = 64
            Top = 160
            Width = 42
            Height = 13
            Caption = 'Endwert:'
          end
          object amberratio2lbl: TLabel
            Left = 8
            Top = 296
            Width = 130
            Height = 13
            Caption = 'Verh'#228'ltnis von Rot zu Gr'#252'n:'
          end
          object ambersettingslbl: TLabel
            Left = 8
            Top = 216
            Width = 156
            Height = 13
            Caption = 'Amber-Kanal-Einstellungen:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel1: TBevel
            Left = 7
            Top = 232
            Width = 218
            Height = 9
            Shape = bsTopLine
          end
          object amberredlbl: TLabel
            Left = 8
            Top = 315
            Width = 8
            Height = 13
            Caption = 'R'
          end
          object ambergreenlbl: TLabel
            Left = 80
            Top = 315
            Width = 16
            Height = 13
            Caption = '/ G'
          end
          object DDFEcolorlist2: TListBox
            Left = 224
            Top = 16
            Width = 208
            Height = 113
            ItemHeight = 13
            TabOrder = 7
            OnKeyUp = DDFEcolorlist2KeyUp
            OnMouseUp = DDFEcolorlist2MouseUp
          end
          object DDFEcoloredit2: TEdit
            Left = 224
            Top = 136
            Width = 157
            Height = 21
            TabOrder = 8
            Text = 'Neue Farbe'
            OnKeyUp = DDFEcoloredit2KeyUp
          end
          object DDFEcolorbutton2: TJvColorButton
            Left = 384
            Top = 136
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            Color = clRed
            OnChange = DDFEcolorbutton2Change
            ParentShowHint = False
            ShowHint = False
            TabOrder = 9
            TabStop = False
          end
          object colorvalueedit2: TJvSpinEdit
            Left = 224
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 10
            OnChange = colorvalueedit2Change
          end
          object colorvalueendedit2: TJvSpinEdit
            Left = 280
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 11
            OnChange = colorvalueendedit2Change
          end
          object PngBitBtn9: TPngBitBtn
            Left = 333
            Top = 173
            Width = 48
            Height = 25
            Hint = 'F'#252'gt dem Ger'#228't eine neue Farbe hinzu'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            OnClick = PngBitBtn9Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
              86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
              56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
              566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
              C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
              3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
              67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
              1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
              CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
              42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
              5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
              0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
              80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
              782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
              0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
              937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
              746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
              611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
              CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
              2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
              2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
              2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
              D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
              9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
              BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
              C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
              246B0000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object PngBitBtn13: TPngBitBtn
            Left = 385
            Top = 173
            Width = 48
            Height = 25
            Hint = 'L'#246'scht die markierte Farbe aus dem Ger'#228'tes'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
            OnClick = PngBitBtn13Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
              86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
              9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
              669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
              BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
              6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
              C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
              1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
              101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
              F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object DDFEcoloredit: TEdit
            Left = 8
            Top = 136
            Width = 157
            Height = 21
            TabOrder = 1
            Text = 'Neue Farbe'
            OnKeyUp = DDFEcoloreditKeyUp
          end
          object DDFEcolorbutton: TJvColorButton
            Left = 168
            Top = 136
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            Color = clRed
            OnChange = DDFEcolorbuttonChange
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            TabStop = False
          end
          object colorvalueedit: TJvSpinEdit
            Left = 8
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 3
            OnChange = colorvalueeditChange
          end
          object DDFEcolorlist: TListBox
            Left = 8
            Top = 16
            Width = 209
            Height = 113
            ItemHeight = 13
            TabOrder = 0
            OnKeyUp = DDFEcolorlistKeyUp
            OnMouseUp = DDFEcolorlistMouseUp
          end
          object PngBitBtn11: TPngBitBtn
            Left = 117
            Top = 173
            Width = 48
            Height = 25
            Hint = 'F'#252'gt dem Ger'#228't eine neue Farbe hinzu'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = PngBitBtn11Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
              86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
              56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
              566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
              C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
              3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
              67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
              1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
              CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
              42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
              5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
              0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
              80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
              782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
              0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
              937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
              746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
              611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
              CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
              2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
              2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
              2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
              D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
              9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
              BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
              C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
              246B0000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object PngBitBtn12: TPngBitBtn
            Left = 169
            Top = 173
            Width = 48
            Height = 25
            Hint = 'L'#246'scht die markierte Farbe aus dem Ger'#228'tes'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = PngBitBtn12Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
              86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
              9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
              669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
              BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
              6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
              C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
              1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
              101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
              F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object colorvalueendedit: TJvSpinEdit
            Left = 64
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 4
            OnChange = colorvalueendeditChange
          end
          object UseAmberMixingCheck: TCheckBox
            Left = 8
            Top = 240
            Width = 209
            Height = 17
            Hint = 
              'Schaltet die Amber-Mischung f'#252'r dieses Ger'#228't ein. Hiermit wird a' +
              'utomatisch der Amber-Kanal zu den RGB-Farben zugemischt.'
            Caption = 'Verwende Amber-Kanal-Farbmischung'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 14
          end
          object AmberMixingCompensateRGCheck: TCheckBox
            Left = 8
            Top = 256
            Width = 225
            Height = 17
            Hint = 
              'Diese Option reduziert die Kan'#228'le R und G, sofern der Kanal A ei' +
              'ngeblendet wird.'
            Caption = 'Reduziere Rot und Gr'#252'n bei Amberwerten'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 15
          end
          object AmbermixingCompensateBlueCheck: TCheckBox
            Left = 8
            Top = 272
            Width = 209
            Height = 17
            Hint = 
              'Entsprechend dem eingestellten Wert f'#252'r Kanal B wird Kanal A red' +
              'uziert.'
            Caption = 'Reduziere Amber bei Blauwerten'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 16
          end
          object AmberratioGBox: TJvSpinEdit
            Left = 104
            Top = 312
            Width = 49
            Height = 21
            Hint = 'Tragen Sie hier z.B. 255 f'#252'r reines Gelb oder 191 f'#252'r Gold ein'
            MaxValue = 255.000000000000000000
            Value = 191.000000000000000000
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            OnChange = colorvalueeditChange
          end
          object AmberratioRBox: TJvSpinEdit
            Left = 24
            Top = 312
            Width = 49
            Height = 21
            Hint = 'Tragen Sie hier z.B. 255 f'#252'r reines Gelb oder 191 f'#252'r Gold ein'
            MaxValue = 255.000000000000000000
            Value = 255.000000000000000000
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
            OnChange = colorvalueeditChange
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Gobos'
          ImageIndex = 1
          object gobolbl2: TLabel
            Left = 224
            Top = 3
            Width = 201
            Height = 13
            Caption = 'Tabelle der Ger'#228'te-Gobos (GOBO2-Kanal):'
          end
          object gobostartvaluelbl2: TLabel
            Left = 224
            Top = 160
            Width = 45
            Height = 13
            Caption = 'Startwert:'
          end
          object goboendvaluelbl2: TLabel
            Left = 280
            Top = 160
            Width = 42
            Height = 13
            Caption = 'Endwert:'
          end
          object gobolbl: TLabel
            Left = 8
            Top = 3
            Width = 201
            Height = 13
            Caption = 'Tabelle der Ger'#228'te-Gobos (GOBO1-Kanal):'
          end
          object gobostartvaluelbl: TLabel
            Left = 8
            Top = 160
            Width = 45
            Height = 13
            Caption = 'Startwert:'
          end
          object goboendvaluelbl: TLabel
            Left = 64
            Top = 160
            Width = 42
            Height = 13
            Caption = 'Endwert:'
          end
          object DDFEgoboedit2: TEdit
            Left = 224
            Top = 136
            Width = 105
            Height = 21
            TabOrder = 8
            Text = 'Neues Gobo'
            OnKeyUp = DDFEgoboedit2KeyUp
          end
          object gobovalueedit2: TJvSpinEdit
            Left = 224
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 10
            OnChange = gobovalueedit2Change
          end
          object gobovalueendedit2: TJvSpinEdit
            Left = 280
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 11
            OnChange = gobovalueendedit2Change
          end
          object PngBitBtn16: TPngBitBtn
            Left = 333
            Top = 173
            Width = 48
            Height = 25
            Hint = 'F'#252'gt dem Ger'#228't eine neue Farbe hinzu'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            OnClick = PngBitBtn16Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
              86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
              56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
              566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
              C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
              3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
              67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
              1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
              CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
              42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
              5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
              0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
              80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
              782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
              0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
              937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
              746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
              611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
              CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
              2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
              2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
              2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
              D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
              9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
              BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
              C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
              246B0000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object PngBitBtn17: TPngBitBtn
            Left = 385
            Top = 173
            Width = 48
            Height = 25
            Hint = 'L'#246'scht die markierte Farbe aus dem Ger'#228'tes'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
            OnClick = PngBitBtn17Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
              86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
              9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
              669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
              BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
              6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
              C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
              1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
              101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
              F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object DDFEgobolist2: TJvImageListBox
            Left = 224
            Top = 16
            Width = 209
            Height = 113
            Items = <>
            ImageHeight = 0
            ImageWidth = 0
            ButtonStyle = fsLighter
            Images = ImageList1
            ItemHeight = 17
            TabOrder = 7
            OnKeyUp = DDFEgobolist2KeyUp
            OnMouseUp = DDFEgobolist2MouseUp
          end
          object goboselectbox2: TmbXPImageComboBox
            Left = 333
            Top = 136
            Width = 100
            Height = 23
            Style = csOwnerDrawFixed
            DropDownCount = 20
            TabOrder = 9
            OnSelect = goboselectbox2Select
          end
          object DDFEgoboedit: TEdit
            Left = 8
            Top = 136
            Width = 105
            Height = 21
            TabOrder = 1
            Text = 'Neues Gobo'
            OnKeyUp = DDFEgoboeditKeyUp
          end
          object gobovalueedit: TJvSpinEdit
            Left = 8
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 3
            OnChange = gobovalueeditChange
          end
          object gobovalueendedit: TJvSpinEdit
            Left = 64
            Top = 176
            Width = 49
            Height = 21
            MaxValue = 255.000000000000000000
            TabOrder = 4
            OnChange = gobovalueendeditChange
          end
          object PngBitBtn14: TPngBitBtn
            Left = 117
            Top = 173
            Width = 48
            Height = 25
            Hint = 'F'#252'gt dem Ger'#228't eine neue Farbe hinzu'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = PngBitBtn14Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
              86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
              56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
              566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
              C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
              3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
              67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
              1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
              CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
              42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
              5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
              0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
              80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
              782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
              0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
              937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
              746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
              611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
              CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
              2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
              2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
              2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
              D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
              9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
              BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
              C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
              246B0000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object PngBitBtn15: TPngBitBtn
            Left = 169
            Top = 173
            Width = 48
            Height = 25
            Hint = 'L'#246'scht die markierte Farbe aus dem Ger'#228'tes'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = PngBitBtn15Click
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
              6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
              F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
              561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
              7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
              1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
              01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
              C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
              00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
              00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
              CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
              4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
              48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
              223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
              560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
              2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
              FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
              F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
              4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
              79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
              812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
              0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
              170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
              48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
              90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
              5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
              5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
              8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
              272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
              48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
              6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
              A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
              2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
              1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
              192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
              3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
              09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
              46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
              EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
              4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
              EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
              79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
              3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
              67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
              6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
              A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
              5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
              D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
              743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
              4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
              D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
              C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
              3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
              FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
              0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
              15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
              476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
              BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
              F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
              A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
              6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
              68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
              949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
              F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
              DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
              772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
              A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
              955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
              EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
              CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
              26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
              8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
              B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
              7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
              EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
              E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
              5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
              EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
              EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
              FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
              CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
              ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
              CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
              F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
              86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
              9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
              669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
              BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
              6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
              C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
              1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
              101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
              F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
            PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
          end
          object DDFEgobolist: TJvImageListBox
            Left = 8
            Top = 16
            Width = 209
            Height = 113
            Items = <>
            ImageHeight = 0
            ImageWidth = 0
            ButtonStyle = fsLighter
            Images = ImageList1
            ItemHeight = 17
            TabOrder = 0
            OnKeyUp = DDFEgobolistKeyUp
            OnMouseUp = DDFEgobolistMouseUp
          end
          object goboselectbox: TmbXPImageComboBox
            Left = 118
            Top = 136
            Width = 99
            Height = 23
            Style = csOwnerDrawFixed
            DropDownCount = 20
            TabOrder = 2
            OnSelect = goboselectboxSelect
          end
          object goborot1box: TGroupBox
            Left = 8
            Top = 208
            Width = 209
            Height = 129
            Caption = ' Gobo1-Rotation '
            TabOrder = 14
            object goborotofflbl: TLabel
              Left = 80
              Top = 56
              Width = 45
              Height = 13
              Caption = 'Stillstand:'
            end
            object goborightlbl: TLabel
              Left = 144
              Top = 80
              Width = 59
              Height = 13
              Caption = 'Rechts max:'
            end
            object goboleftlbl: TLabel
              Left = 8
              Top = 80
              Width = 50
              Height = 13
              Caption = 'Links max:'
            end
            object gobo1rotchllbl: TLabel
              Left = 8
              Top = 20
              Width = 30
              Height = 13
              Caption = 'Kanal:'
            end
            object goborightlbl2: TLabel
              Left = 144
              Top = 40
              Width = 56
              Height = 13
              Caption = 'Rechts min:'
            end
            object goboleftlbl2: TLabel
              Left = 8
              Top = 40
              Width = 47
              Height = 13
              Caption = 'Links min:'
            end
            object goborotoffvalueedit: TJvSpinEdit
              Left = 80
              Top = 72
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 128.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
            object goborotrightvalueedit: TJvSpinEdit
              Left = 144
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 5
              OnChange = maxvalueeditChange
            end
            object goborotleftvalueedit: TJvSpinEdit
              Left = 8
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 4
              OnChange = maxvalueeditChange
            end
            object gobo1rotchlbox: TComboBox
              Left = 56
              Top = 16
              Width = 137
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'GOBO1ROT'
              OnSelect = typlisteSelect
            end
            object goborotrightminvalueedit: TJvSpinEdit
              Left = 144
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 3
              OnChange = maxvalueeditChange
            end
            object goborotleftminvalueedit: TJvSpinEdit
              Left = 8
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
          end
          object gobo2rotbox: TGroupBox
            Left = 224
            Top = 208
            Width = 209
            Height = 129
            Caption = ' Gobo2-Rotation '
            TabOrder = 15
            object gobooff2lbl: TLabel
              Left = 80
              Top = 56
              Width = 45
              Height = 13
              Caption = 'Stillstand:'
            end
            object goboright2lbl: TLabel
              Left = 144
              Top = 80
              Width = 59
              Height = 13
              Caption = 'Rechts max:'
            end
            object goboleft2lbl: TLabel
              Left = 8
              Top = 80
              Width = 50
              Height = 13
              Caption = 'Links max:'
            end
            object gobo2rotchllbl: TLabel
              Left = 8
              Top = 20
              Width = 30
              Height = 13
              Caption = 'Kanal:'
            end
            object gobo2rightlbl2: TLabel
              Left = 144
              Top = 40
              Width = 56
              Height = 13
              Caption = 'Rechts min:'
            end
            object gobo2leftlbl2: TLabel
              Left = 8
              Top = 40
              Width = 47
              Height = 13
              Caption = 'Links min:'
            end
            object gobo2rotoffvalueedit: TJvSpinEdit
              Left = 80
              Top = 72
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 128.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
            object gobo2rotrightvalueedit: TJvSpinEdit
              Left = 144
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 5
              OnChange = maxvalueeditChange
            end
            object gobo2rotleftvalueedit: TJvSpinEdit
              Left = 8
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 4
              OnChange = maxvalueeditChange
            end
            object gobo2rotchlbox: TComboBox
              Left = 56
              Top = 16
              Width = 137
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'GOBO2ROT'
              OnSelect = typlisteSelect
            end
            object gobo2rotrightminvalueedit: TJvSpinEdit
              Left = 144
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 3
              OnChange = maxvalueeditChange
            end
            object gobo2rotleftminvalueedit: TJvSpinEdit
              Left = 8
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Prisma/Iris'
          ImageIndex = 3
          object prismabox1: TGroupBox
            Left = 248
            Top = 8
            Width = 177
            Height = 73
            Caption = ' Prisma '
            TabOrder = 1
            object prismaofflbl: TLabel
              Left = 8
              Top = 24
              Width = 39
              Height = 13
              Caption = 'Einfach:'
            end
            object prismatriplelbl: TLabel
              Left = 64
              Top = 24
              Width = 43
              Height = 13
              Caption = 'Dreifach:'
            end
            object prismaoffedit: TJvSpinEdit
              Left = 8
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 0
              OnChange = maxvalueeditChange
            end
            object prismatripleedit: TJvSpinEdit
              Left = 64
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
          end
          object prismarotbox1: TGroupBox
            Left = 8
            Top = 8
            Width = 233
            Height = 129
            Caption = ' Prisma-Rotation '
            TabOrder = 0
            object prismarotofflbl: TLabel
              Left = 88
              Top = 56
              Width = 45
              Height = 13
              Caption = 'Stillstand:'
            end
            object prismarotrightmaxlbl: TLabel
              Left = 168
              Top = 80
              Width = 59
              Height = 13
              Caption = 'Rechts max:'
            end
            object prismaleftmaxlbl: TLabel
              Left = 8
              Top = 80
              Width = 50
              Height = 13
              Caption = 'Links max:'
            end
            object prismachannellbl: TLabel
              Left = 8
              Top = 20
              Width = 30
              Height = 13
              Caption = 'Kanal:'
            end
            object prismarightminlbl: TLabel
              Left = 168
              Top = 40
              Width = 56
              Height = 13
              Caption = 'Rechts min:'
            end
            object prismaleftminlbl: TLabel
              Left = 8
              Top = 40
              Width = 47
              Height = 13
              Caption = 'Links min:'
            end
            object prismarotstopedit: TJvSpinEdit
              Left = 88
              Top = 72
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 128.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
            object prismarotrightmaxedit: TJvSpinEdit
              Left = 168
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 5
              OnChange = maxvalueeditChange
            end
            object prismarotleftmaxedit: TJvSpinEdit
              Left = 8
              Top = 96
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 4
              OnChange = maxvalueeditChange
            end
            object prismarotchanneledit: TComboBox
              Left = 56
              Top = 16
              Width = 137
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'PRISMAROT'
              OnSelect = typlisteSelect
            end
            object prismarotrightminedit: TJvSpinEdit
              Left = 168
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 3
              OnChange = maxvalueeditChange
            end
            object prismarotleftminedit: TJvSpinEdit
              Left = 8
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
          end
          object irisbox1: TGroupBox
            Left = 8
            Top = 144
            Width = 233
            Height = 73
            Caption = ' Iris '
            TabOrder = 2
            object irisofflbl: TLabel
              Left = 8
              Top = 24
              Width = 16
              Height = 13
              Caption = 'Zu:'
            end
            object irisopenlbl: TLabel
              Left = 64
              Top = 24
              Width = 19
              Height = 13
              Caption = 'Auf:'
            end
            object irisminlbl: TLabel
              Left = 120
              Top = 24
              Width = 20
              Height = 13
              Caption = 'Min:'
            end
            object irismaxlbl: TLabel
              Left = 176
              Top = 24
              Width = 23
              Height = 13
              Caption = 'Max:'
            end
            object irisoffedit: TJvSpinEdit
              Left = 8
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 0
              OnChange = maxvalueeditChange
            end
            object irisopenedit: TJvSpinEdit
              Left = 64
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
            object irisminedit: TJvSpinEdit
              Left = 120
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
            object irismaxedit: TJvSpinEdit
              Left = 176
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 3
              OnChange = maxvalueeditChange
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Dimmer/Shutter/Strobo/Nebel'
          ImageIndex = 2
          object shuttergroupbox: TGroupBox
            Left = 8
            Top = 88
            Width = 177
            Height = 89
            Caption = ' Shutter-Einstellungen '
            TabOrder = 2
            object shutterlbl: TLabel
              Left = 8
              Top = 20
              Width = 63
              Height = 13
              Caption = 'Shutterkanal:'
            end
            object closelbl: TLabel
              Left = 8
              Top = 40
              Width = 64
              Height = 13
              Caption = 'Geschlossen:'
            end
            object openlbl: TLabel
              Left = 88
              Top = 40
              Width = 29
              Height = 13
              Caption = 'Offen:'
            end
            object shutterchannellist: TComboBox
              Left = 80
              Top = 16
              Width = 89
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'SHUTTER'
              OnSelect = typlisteSelect
            end
            object shutterclosevalueedit: TJvSpinEdit
              Left = 8
              Top = 56
              Width = 65
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
            object shutteropenvalueedit: TJvSpinEdit
              Left = 88
              Top = 56
              Width = 65
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
          end
          object strobegroupbox: TGroupBox
            Left = 192
            Top = 88
            Width = 177
            Height = 89
            Caption = ' Strobo-Einstellungen '
            TabOrder = 3
            object strobelbl: TLabel
              Left = 8
              Top = 20
              Width = 64
              Height = 13
              Caption = 'Strobe-Kanal:'
            end
            object strobeofflbl: TLabel
              Left = 8
              Top = 40
              Width = 21
              Height = 13
              Caption = 'Aus:'
            end
            object strobemaxlbl: TLabel
              Left = 120
              Top = 40
              Width = 23
              Height = 13
              Caption = 'Max:'
            end
            object strobeminlbl: TLabel
              Left = 64
              Top = 40
              Width = 20
              Height = 13
              Caption = 'Min:'
            end
            object strobochannellist: TComboBox
              Left = 80
              Top = 16
              Width = 89
              Height = 21
              ItemHeight = 13
              TabOrder = 0
              Text = 'SHUTTER'
              OnSelect = typlisteSelect
            end
            object strobeoffvalueedit: TJvSpinEdit
              Left = 8
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
            object strobemaxvalueedit: TJvSpinEdit
              Left = 120
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 3
              OnChange = maxvalueeditChange
            end
            object strobeminvalueedit: TJvSpinEdit
              Left = 64
              Top = 56
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 2
              OnChange = maxvalueeditChange
            end
          end
          object dimmergroupbox: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 73
            Caption = ' Dimmer-Einstellungen '
            TabOrder = 0
            object dimmerofflbl: TLabel
              Left = 8
              Top = 24
              Width = 21
              Height = 13
              Caption = 'Aus:'
            end
            object dimmermaxlbl: TLabel
              Left = 64
              Top = 24
              Width = 23
              Height = 13
              Caption = 'Max:'
            end
            object dimmermaxvalueedit: TJvSpinEdit
              Left = 64
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
            object dimmeroffvalueedit: TJvSpinEdit
              Left = 8
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 0
              OnChange = maxvalueeditChange
            end
          end
          object foggroupbox: TGroupBox
            Left = 192
            Top = 8
            Width = 177
            Height = 73
            Caption = ' Nebel-Einstellungen '
            TabOrder = 1
            object fogofflbl: TLabel
              Left = 8
              Top = 24
              Width = 21
              Height = 13
              Caption = 'Aus:'
            end
            object fogmaxlbl: TLabel
              Left = 64
              Top = 24
              Width = 23
              Height = 13
              Caption = 'Max:'
            end
            object fogmaxvalueedit: TJvSpinEdit
              Left = 64
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              Value = 255.000000000000000000
              TabOrder = 1
              OnChange = maxvalueeditChange
            end
            object fogoffvalueedit: TJvSpinEdit
              Left = 8
              Top = 40
              Width = 49
              Height = 21
              MaxValue = 255.000000000000000000
              TabOrder = 0
              OnChange = maxvalueeditChange
            end
          end
        end
      end
      object channelfadebox: TCheckBox
        Left = 8
        Top = 200
        Width = 177
        Height = 17
        Hint = 
          'F'#252'r Farbr'#228'der ausschalten, f'#252'r Dimmer, PAN/TILT oder RGB einscha' +
          'lten'
        Caption = 'Kanal unterst'#252'tzt Fadings'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 8
        OnClick = channelfadeboxClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Komponenten'
      ImageIndex = 4
      object komponentenlbl: TLabel
        Left = 8
        Top = 8
        Width = 139
        Height = 13
        Caption = 'Komponenteneinstellung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object theline3: TBevel
        Left = 7
        Top = 24
        Width = 377
        Height = 9
        Shape = bsTopLine
      end
      object name2lbl: TLabel
        Left = 46
        Top = 67
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Name:'
      end
      object funktionlbl: TLabel
        Left = 33
        Top = 115
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Funktion:'
      end
      object textlbl: TLabel
        Left = 53
        Top = 91
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'Text:'
      end
      object itemslbl: TLabel
        Left = 49
        Top = 139
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Items:'
        Visible = False
      end
      object itemtextlbl: TLabel
        Left = 53
        Top = 234
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'Text:'
        Visible = False
      end
      object itemvaluelbl: TLabel
        Left = 27
        Top = 283
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Kanalwert:'
        Visible = False
      end
      object bildlbl: TLabel
        Left = 34
        Top = 260
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Item-Bild:'
        Visible = False
      end
      object itempicture: TImage
        Left = 83
        Top = 258
        Width = 16
        Height = 16
        Visible = False
      end
      object komponentennameedit: TEdit
        Left = 79
        Top = 64
        Width = 169
        Height = 21
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnKeyUp = komponentennameeditKeyUp
      end
      object funktionsliste2: TComboBox
        Left = 80
        Top = 112
        Width = 169
        Height = 21
        Style = csDropDownList
        DropDownCount = 16
        ItemHeight = 13
        TabOrder = 2
        OnSelect = funktionsliste2Select
      end
      object textedit: TEdit
        Left = 79
        Top = 88
        Width = 169
        Height = 21
        TabOrder = 1
        OnKeyUp = texteditKeyUp
      end
      object PngBitBtn3: TPngBitBtn
        Left = 80
        Top = 32
        Width = 169
        Height = 25
        Caption = 'Komponente entfernen'
        TabOrder = 13
        OnClick = PngBitBtn3Click
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
          6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
          F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
          561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
          7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
          1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
          01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
          C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
          00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
          00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
          CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
          4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
          48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
          223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
          560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
          2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
          FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
          F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
          4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
          79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
          812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
          0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
          170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
          48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
          90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
          5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
          5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
          8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
          272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
          48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
          6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
          A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
          2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
          1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
          192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
          3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
          09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
          46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
          EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
          4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
          EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
          79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
          3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
          67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
          6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
          A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
          5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
          D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
          743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
          4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
          D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
          C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
          3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
          FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
          0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
          15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
          476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
          BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
          F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
          A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
          6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
          68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
          949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
          F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
          DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
          772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
          A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
          955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
          EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
          CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
          26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
          8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
          B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
          7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
          EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
          E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
          5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
          EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
          EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
          FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
          CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
          ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
          CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
          F73EE77CFEFC2FF784F3FB25D29F330000036C4944415478DA3D937B48537114
          C7CFD5B9EB63BB9BF381A54DC3425BD9B287EB45F6CE4AC34A2B2A88B082A2AC
          88E89D96947F48644552D2C32C354BC7CCD7AC45C54CAD253A89D2349D577CCE
          59D9DCD6D6B2F3B36B173E7FDCF3E27BCFF95E0A0028C4B532EF8CC26DC45E26
          9C20C955C49D4AC59883E337FC7B5C6A9FA6CDB5DB1D2ED13B2E36E0BB9330D6
          8CD065D7926B6A72D4F29931515DDBD21F2DC7D8086241ECAFF2CECFE69BCC37
          8DEF9AE55E220130D111E98AADE73231672503F8AA7B2762D92A5D7153492D84
          2D980EF4D28894E494FB4ACC7DCFBF7A285C6C3016B5ABEA44BFBA8740286120
          72FF7A78D86688B99E57D5440678DCBCB47729EF335BD1F0E40D3062212892D6
          0E6C4ECFDD9994B88C4E904ECCFB92FF86710CFC00069BA50B6540AD92BF6C68
          EB529FCC2C2C2503BC103F55C68122DD8D923923DD2608899C0A4ED9A48A403E
          1D36F4521F6A658D20F6F786E0B828EBE3C1C1823BCAD71FB0A70B61FF0F4839
          9290106A3467B43CAB03B73F0042B1005CED4E18FD6101C6470493E317D8323E
          363FA9D4EA3BB0BE0FE91C1FE081481069F6E57D475D5EE813FB6A9BC1C5E600
          1A0F44064963A36C991D9D4AF5DB2616EB064923A7A0776C89881099804CC94E
          DA906A51BD973B4D3F31418177901FB4CC0FD5A51569B498EFE79A594EC5B7F1
          331215BE91B29088B30AF9DD9EE21A3F6AD83A3640800A02D6CFB35F61D9FC72
          6D630DD6B573034CE4D41467241AF17E7D25B9C470E7F93C4B6B2FD03C1ED0AE
          AEE0E67082C087019F15725BBB6C62E9F6D3593738F943888D34BBA51D490C58
          3E25F8962147B36EB8C9009E9EEE208E08B15BBD688BA47348ECF8DA07EE2436
          2318F88BA6B599C302CACD165BDDAA8319955443497AB249FBE9588FBA5E6A69
          EBC30B8C4210DEBA5E16507FAD506328D897B08CAFD2497EB7620EC57AF83220
          59390B6C717394E15B4F1EA5B4E7F68CB63CD0801D5DC6C7F3F94E0D047AFB92
          AEB5A9B7CB89D703FDBD79C587776CF4ACD4FB3B3E7703EDE50EA29DD196B8A7
          E5BB1B5BD9664A5770A1B027BB6ACB70630708D06941898B7FC5DF53E6740F7C
          234B1A26FF02F9CCDBA776AD5E43338B1C02DA7656ADCD29D4BCABC3B881EC40
          5E9675FCBC747064533F8F325CADA8AEAEA8D67FC5F80062243FCCF8921111C2
          43CCC403E3469A4E4C84047145C06DB897BBBB95F38A88CBD39C2AA2B0FF2F7F
          435DF5691DE66C0000000049454E44AE426082}
      end
      object PngBitBtn6: TPngBitBtn
        Left = 252
        Top = 179
        Width = 33
        Height = 21
        Hint = 'F'#252'gt ein neues Item hinzu'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        Visible = False
        OnClick = PngBitBtn6Click
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
          6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
          F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
          561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
          7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
          1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
          01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
          C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
          00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
          00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
          CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
          4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
          48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
          223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
          560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
          2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
          FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
          F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
          4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
          79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
          812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
          0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
          170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
          48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
          90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
          5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
          5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
          8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
          272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
          48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
          6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
          A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
          2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
          1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
          192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
          3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
          09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
          46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
          EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
          4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
          EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
          79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
          3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
          67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
          6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
          A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
          5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
          D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
          743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
          4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
          D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
          C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
          3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
          FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
          0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
          15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
          476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
          BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
          F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
          A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
          6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
          68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
          949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
          F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
          DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
          772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
          A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
          955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
          EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
          CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
          26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
          8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
          B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
          7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
          EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
          E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
          5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
          EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
          EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
          FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
          CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
          ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
          CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
          F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
          86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
          56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
          566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
          C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
          3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
          67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
          1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
          CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
          42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
          5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
          0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
          80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
          782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
          0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
          937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
          746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
          611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
          CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
          2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
          2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
          2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
          D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
          9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
          BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
          C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
          246B0000000049454E44AE426082}
        PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
      end
      object PngBitBtn7: TPngBitBtn
        Left = 252
        Top = 203
        Width = 33
        Height = 21
        Hint = 'L'#246'scht das letzte Item'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        Visible = False
        OnClick = PngBitBtn7Click
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
          6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
          F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
          561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
          7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
          1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
          01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
          C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
          00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
          00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
          CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
          4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
          48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
          223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
          560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
          2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
          FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
          F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
          4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
          79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
          812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
          0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
          170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
          48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
          90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
          5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
          5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
          8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
          272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
          48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
          6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
          A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
          2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
          1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
          192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
          3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
          09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
          46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
          EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
          4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
          EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
          79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
          3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
          67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
          6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
          A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
          5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
          D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
          743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
          4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
          D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
          C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
          3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
          FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
          0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
          15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
          476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
          BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
          F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
          A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
          6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
          68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
          949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
          F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
          DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
          772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
          A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
          955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
          EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
          CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
          26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
          8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
          B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
          7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
          EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
          E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
          5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
          EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
          EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
          FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
          CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
          ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
          CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
          F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
          86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
          9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
          669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
          BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
          6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
          C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
          1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
          101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
          F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
        PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
      end
      object itemlistbox: TListBox
        Left = 80
        Top = 136
        Width = 169
        Height = 89
        ItemHeight = 13
        TabOrder = 5
        Visible = False
        OnKeyUp = itemlistboxKeyUp
        OnMouseUp = itemlistboxMouseUp
      end
      object itemnameedit: TEdit
        Left = 80
        Top = 232
        Width = 169
        Height = 21
        TabOrder = 9
        Visible = False
        OnKeyUp = itemnameeditKeyUp
      end
      object itemvalueedit: TJvSpinEdit
        Left = 80
        Top = 280
        Width = 49
        Height = 21
        MaxValue = 255.000000000000000000
        Value = 1.000000000000000000
        MaxLength = 3
        TabOrder = 11
        Visible = False
        OnChange = itemvalueeditChange
      end
      object minvaluespin: TJvSpinEdit
        Left = 80
        Top = 136
        Width = 73
        Height = 21
        MaxValue = 255.000000000000000000
        MaxLength = 3
        TabOrder = 3
        Visible = False
        OnChange = minvaluespinChange
      end
      object maxvaluespin: TJvSpinEdit
        Left = 176
        Top = 136
        Width = 73
        Height = 21
        MaxValue = 255.000000000000000000
        Value = 255.000000000000000000
        MaxLength = 3
        TabOrder = 4
        Visible = False
        OnChange = maxvaluespinChange
      end
      object defaultvaluespin: TJvSpinEdit
        Left = 80
        Top = 232
        Width = 73
        Height = 21
        MaxValue = 255.000000000000000000
        MaxLength = 3
        TabOrder = 8
        Visible = False
        OnChange = defaultvaluespinChange
      end
      object bildedt: TEdit
        Left = 104
        Top = 256
        Width = 97
        Height = 21
        TabOrder = 14
        Visible = False
        OnKeyUp = bildedtKeyUp
      end
      object bildchange: TButton
        Left = 208
        Top = 256
        Width = 41
        Height = 21
        Caption = '...'
        TabOrder = 15
        Visible = False
        OnClick = bildchangeClick
      end
      object mbXPImageComboBox1: TmbXPImageComboBox
        Left = 104
        Top = 256
        Width = 145
        Height = 23
        Style = csOwnerDrawFixed
        DropDownCount = 20
        TabOrder = 10
        Visible = False
        OnSelect = mbXPImageComboBox1Select
      end
      object itemvalueendedit: TJvSpinEdit
        Left = 130
        Top = 280
        Width = 49
        Height = 21
        MaxValue = 255.000000000000000000
        Value = 2.000000000000000000
        MaxLength = 3
        TabOrder = 12
        Visible = False
        OnChange = itemvalueendeditChange
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Funktionen'
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 638
        Height = 137
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object funktionentoplbl: TLabel
          Left = 8
          Top = 8
          Width = 64
          Height = 13
          Caption = 'Funktionen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel7: TBevel
          Left = 7
          Top = 24
          Width = 538
          Height = 9
          Shape = bsTopLine
        end
        object unitnamelbl: TLabel
          Left = 29
          Top = 35
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'Unitname:'
        end
        object funktionsnamelbl: TLabel
          Left = 2
          Top = 84
          Width = 75
          Height = 13
          Alignment = taRightJustify
          Caption = 'Funktionsname:'
        end
        object funktionenlbl: TLabel
          Left = 21
          Top = 60
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Funktionen:'
        end
        object standardfktlbl: TLabel
          Left = 10
          Top = 115
          Width = 67
          Height = 13
          Alignment = taRightJustify
          Caption = 'Standard-Fkt.:'
        end
        object Bevel8: TBevel
          Left = 7
          Top = 104
          Width = 538
          Height = 9
          Shape = bsTopLine
        end
        object specialfunctionlbl: TLabel
          Left = 279
          Top = 115
          Width = 58
          Height = 13
          Caption = 'Spezial-Fkt.:'
        end
        object PngBitBtn4: TPngBitBtn
          Left = 432
          Top = 56
          Width = 33
          Height = 21
          Hint = 'Neue Funktion hinzuf'#252'gen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = PngBitBtn4Click
          PngImage.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
            6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
            F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
            561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
            7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
            1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
            01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
            C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
            00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
            00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
            CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
            4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
            48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
            223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
            560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
            2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
            FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
            F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
            4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
            79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
            812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
            0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
            170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
            48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
            90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
            5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
            5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
            8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
            272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
            48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
            6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
            A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
            2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
            1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
            192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
            3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
            09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
            46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
            EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
            4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
            EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
            79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
            3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
            67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
            6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
            A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
            5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
            D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
            743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
            4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
            D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
            C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
            3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
            FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
            0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
            15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
            476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
            BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
            F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
            A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
            6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
            68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
            949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
            F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
            DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
            772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
            A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
            955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
            EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
            CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
            26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
            8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
            B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
            7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
            EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
            E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
            5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
            EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
            EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
            FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
            CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
            ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
            CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
            F73EE77CFEFC2FF784F3FB25D29F33000003274944415478DA6D935968135114
            86FF3B4B1A634AD5D616F2D2A0B8A33E29484470412B2AB850438D4B9AB45690
            56507C51D117517C7079758B7569B4011545ACB5757B28058B50B56A8A46E3D2
            566ADACEE024997DBC33B53EA8776038C39CFFBBE7FCE75E8213F87BC566F8FC
            C102CE0D5816886A22DDFF0567175DC18605EB9B65438EF00C0F9EE5219B32C8
            3F000B4D67EB0E6C717B541A027943C2E95B0904DE6CC291C8C138C331A1CFE2
            67BC1A7C856820FA5FC0B593E1FA90C27F052104239284C6960EAC7ABF19C777
            1D6D1A5686B756C42B10F00790D891F82FE0E2C970434473F5DB31C47C16B1FB
            CF50F97127766FAF8B55DDA98A76F776A366590DCE07CF3B80184D7481868EC2
            42E054F51EBFE6EA83AE1B905419575B3AE14DF9C095B1E99EF4EB0EC840EDE2
            5A9C0B9E53C98C2B7E6BEFBA2A488A041B623F9E711C7EC81F6C0FA1EA2A58AD
            0896E9866E68287479F1ACF70986DA26E272D5259079D76766F76D5CEBE9933E
            80219C5387AA6B300D0BA669C2300CA732C33428C4A4B189F6B7EF20DE2E422C
            782147E6C6470103D914CD631C914E456362DB486BECFB37E0D1BB247EDE9D30
            0A98DF382DBB6BF372CFA7A114585A81BD58FB65D26668398AAA21A7C9605802
            937AC2720C3A532988377F5750700CD9F2F2628F20E51D014F5C88AEA880C989
            746713829CC3A3AE5E08991C7446775A94350DA5C929680C5ECA91E62709ABF5
            611B744DC738C68D16B4225CB7043AFBCD6929AB2B88DFEB42D9D35998E39B0D
            CFF8026AAE89499E09D8B67E1B882229B181EF032E8D527D5E1FC28FAB03E50B
            2D3F57304C4D0305C848B4BEC0D264250E86F7A70B271576D8DEB03C8BE2C9C5
            2A114511838383F0725E74F675A2E141C3C59DD52B233992A6000B7953C78D96
            2EACF91AC2E1BA4331C550A2169D2FC771282D2D850318C98CA0FD633B6A6ED7
            D019E2DAAACAE9A121EDA773AE589EA0A7A71F9B0676E048EDE126D552B7DA00
            9EE747018220401C1671E6F9190879C126377577BFDC220822188671A6621BB7
            BAAC02F5E1FAB86119211B60FF2B29290191E865D1751D45EE228071B263C9D7
            C9602693F903B0CF80B7D88BA9D3A736D3B62263D7866559FC025B8499EFA294
            246B0000000049454E44AE426082}
          PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
        end
        object PngBitBtn5: TPngBitBtn
          Left = 472
          Top = 56
          Width = 33
          Height = 21
          Hint = 'Aktuelle Funktion l'#246'schen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = PngBitBtn5Click
          PngImage.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000B1300000B1301009A9C1800000A4D694343505068
            6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
            F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
            561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
            7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
            1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
            01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
            C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
            00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
            00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
            CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
            4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
            48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
            223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
            560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
            2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
            FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
            F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
            4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
            79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
            812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
            0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
            170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
            48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
            90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
            5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
            5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
            8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
            272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
            48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
            6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
            A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
            2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
            1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
            192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
            3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
            09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
            46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
            EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
            4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
            EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
            79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
            3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
            67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
            6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
            A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
            5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
            D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
            743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
            4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
            D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
            C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
            3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
            FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
            0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
            15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
            476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
            BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
            F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
            A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
            6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
            68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
            949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
            F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
            DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
            772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
            A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
            955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
            EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
            CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
            26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
            8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
            B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
            7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
            EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
            E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
            5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
            EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
            EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
            FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
            CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
            ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
            CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
            F73EE77CFEFC2FF784F3FB25D29F33000001134944415478DAED92B14A034110
            86FFD9BBE23439236A27482C4C6223E40D8494C6CAC2CEB7115B7B0D56492742
            9E208808763646C51CA60FC120276772B73BCEDE85F4D1420B077E8661663E7E
            669798193F09FA07804ECAC41B8B2B087584BCB3906612E65D611D4AA96C8A09
            BBE160D67B1F8FF1B4B689F3DB5E955A7B95E8607BDF0B7B01C8752C13493C81
            6603630CB4D602008C645BC330BA6F0FB8CAFB68DCBC9C52B32E804ADDFB085E
            C18AA64BC96C998824735A1BA353C0E3A88BB6BF84B3EBE70E5DD4B6A2C352CD
            1BF6AD0337B36CE764D1DA9DE81871FC09C73A4B345C5208C20097393F031C97
            101573ABDE376FD02169EF888E4455919AF311EE2DA0202A8A96D30BCE17A33F
            F0917E1DF005E0E2A8B12CA995E90000000049454E44AE426082}
          PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
        end
        object funktionsliste1: TComboBox
          Left = 80
          Top = 56
          Width = 345
          Height = 21
          Style = csDropDownList
          DropDownCount = 16
          ItemHeight = 13
          TabOrder = 1
          OnSelect = funktionsliste1Select
        end
        object funktionsnameedit: TEdit
          Left = 80
          Top = 80
          Width = 465
          Height = 21
          TabOrder = 2
          OnKeyUp = funktionsnameeditKeyUp
        end
        object unitnameedit: TEdit
          Left = 80
          Top = 32
          Width = 345
          Height = 21
          TabOrder = 0
          Text = 'NewDeviceUnit'
        end
        object standardfunktionen: TComboBox
          Left = 80
          Top = 112
          Width = 193
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 3
          OnCloseUp = standardfunktionenCloseUp
          OnDropDown = standardfunktionenDropDown
          OnSelect = standardfunktionenSelect
          Items.Strings = (
            '{#VARIABLE#}:=get_channel('#39'#KANALTYP#'#39');'
            'set_channel('#39#39',-1,{#ENDWERT#},0,0);'
            
              'set_channel('#39'#KANALTYP#'#39',{#STARTWERT#},{#ENDWERT#},{#ZEITINMS#},' +
              '{#DELAYINMS#});'
            
              'set_channel('#39'#KANALTYP#'#39',{#STARTWERT#},{#ENDWERT#},{#ZEITINMS#})' +
              ';'
            
              'set_channel('#39'#KANALTYP#'#39',-1,{#ENDWERT#},{#ZEITINMS#},{#DELAYINMS' +
              '#});'
            'set_channel('#39'#KANALTYP#'#39',-1,{#ENDWERT#},{#ZEITINMS#});'
            'get_channel('#39'#KANALTYP#'#39');'
            
              'set_color('#39'#ROT#'#39',{#GRUEN#},{#BLAU#},{#ZEITINMS#},{#DELAYINMS#})' +
              ';'
            'case {#VARIABLE#} of 0:; 1:; end;'
            'strtoint('#39'#TEXT#'#39');'
            'inttostr({#ZAHL#});'
            
              'if {#BEDINGUNG#}>={#WERT#} then {#AUSF'#220'HRUNG#} else {#AUSF'#220'HRUNG' +
              '#};'
            'ShowMessage('#39'Dies ist eine Nachricht'#39');'
            
              'if messagedlg('#39'Dies ist ein Abfragefenster'#39',mtWarning,[mbYes,mbN' +
              'o],0)=mrYes then ;'
            
              'if messagedlg('#39'Dies ist ein Abfragefenster'#39',mtConfirmation,[mbYe' +
              's,mbNo],0)=mrYes then ;')
        end
        object PngBitBtn8: TPngBitBtn
          Left = 432
          Top = 31
          Width = 113
          Height = 21
          Hint = 'L'#228'sst die aktuelle Funktion ablaufen'
          Caption = 'Funktion testen'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = PngBitBtn8Click
          PngImage.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            61000000097048597300000AF000000AF00142AC349800000A4D694343505068
            6F746F73686F70204943432070726F66696C65000078DA9D53775893F7163EDF
            F7650F5642D8F0B1976C81002223AC08C81059A21092006184101240C585880A
            561415119C4855C482D50A489D88E2A028B867418A885A8B555C38EE1FDCA7B5
            7D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691E6A26A003952853C3AD8
            1F8F4F48C4C9BD80021548E0042010E6CBC26705C50000F00379787E74B03FFC
            01AF6F00020070D52E2412C7E1FF83BA50265700209100E02212E70B01905200
            C82E54C81400C81800B053B3640A009400006C797C422200AA0D00ECF4493E05
            00D8A993DC1700D8A21CA908008D0100992847240240BB00605581522C02C0C2
            00A0AC40222E04C0AE018059B632470280BD0500768E58900F4060008099422C
            CC0020380200431E13CD03204C03A030D2BFE0A95F7085B8480100C0CB95CD97
            4BD23314B895D01A77F2F0E0E221E2C26CB142611729106609E4229C979B2313
            48E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666E76CEFF4C5A2FE6BF06F
            223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370C701B075BF6BA95B00DA
            560068DFF95D33DB09A05A0AD07AF98B7938FC401E9EA150C83C1D1C0A0B0BED
            2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7AF000719A4099ADC0A383
            FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD8E29D1E234B15C2C158A
            F15889B850224DC779B952914421C995E212E97F32F11F96FD0993770D00AC86
            4FC04EB607B5CB6CC07EEE01028B0E58D27600407EF32D8C1A0B910010673432
            79F7000093BFF98F402B0100CD97A4E30000BCE8185CA894174CC608000044A0
            812AB041070CC114ACC00E9CC11DBCC01702610644400C24C03C104206E4801C
            0AA11896411954C03AD804B5B0031AA0119AE110B4C131380DE7E0125C81EB70
            170660189EC218BC86090441C8081361213A8811628ED822CE0817998E042261
            48349280A420E988145122C5C872A402A9426A915D4823F22D7214398D5C40FA
            90DBC820328AFC8ABC47319481B25103D4027540B9A81F1A8AC6A073D174340F
            5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A8E6380D1310E668CD961
            5C8C87456089581A26C71663E55835568F35631D583776151BC09E61EF082402
            8B8013EC085E8410C26C82909047584C5843A825EC23B412BA085709838431C2
            272293A84FB4257A12F9C478623AB1905846AC26EE211E219E255E270E135F93
            48240EC992E44E0A21259032490B496B48DB482DA453A43ED210699C4C26EB90
            6DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7143AC588E24C09A22452
            A494124A35653FE504A59F324299A0AA51CDA99ED408AA883A9F5A496DA07650
            2F5387A91334759A25CD9B1643CBA42DA3D5D09A696769F7682FE974BA09DD83
            1E4597D097D26BE807E9E7E983F4770C0D860D83C7486228196B197B19A718B7
            192F994CA605D39799C85430D7321B9967980F986F55582AF62A7C1591CA1295
            3A9556957E95E7AA545573553FD579AA0B54AB550FAB5E567DA64655B350E3A9
            09D416ABD5A91D55BBA936AECE5277528F50CF515FA3BE5FFD82FA630DB28685
            46A08648A35463B7C6198D2116C63265F15842D6725603EB2C6B984D625BB2F9
            EC4C7605FB1B762F7B4C534373AA66AC6691669DE671CD010EC6B1E0F039D99C
            4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA7ADABEDA62ED72ED16ED
            EBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA85BADB75CFEA3ED363EB
            79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD11F373034083690196C31
            3863F0CC9063E86B9869B8D1F084E1A811CB68BA91C468A3D149A327B826EE87
            67E33578173E66AC6F1C62AC34DE65DC6B3C61626932DBA4C4A4C5E4BE29CD94
            6B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C6B9E61BED9BCDBFC8D85
            A5459CC54A8B368BC796DA967CCB05964D96F7AC98563E567956F556D7AC49D6
            5CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BADC4769B6DDF14E2148F29
            D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F66DF6CF1DCC1C121DD63B
            743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957671B67A1739DF33517A6
            4B90CB1297769717536DA78AA76E9F7ACB95E51AEEBAD2B5D3F5A39BBB9BDCAD
            D96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0F758E271CCE39DA79BA7
            C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8DBC45BE0BDCB7B603A3E
            3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE237ED67E997E07FC9EFB3B
            FACBFD8FF8BFE179F216F14E056001C101E501BD811A81B3036B031F049904A5
            0735058D05BB062F0C3E15420C090D591F72936FC017F21BF96333DC672C9AD1
            15CA089D155A1BFA30CC264C1ED6118E86CF08DF107E6FA6F94CE9CCB60888E0
            476C88B81F69199917F97D14292A32AA2EEA51B453747174F72CD6ACE459FB67
            BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9BB880B8AAB8817887F845
            F1971274132409ED89E4C4D8C43D89E37302E76C9A339CE49A54967463AEE5DC
            A2B917E6E9CECB9E773C593559907C3885981297B23FE5832042502F184FE5A7
            6E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E69D5695F638DD3B7D43FA
            68864F4675C633094F522B79911992B923F34D5644D6DEACCFD971D92D39949C
            949CA3520D6996B42BD730B728B74F662B2B930DE479E66DCA1B9387CAF7E423
            F973F3DB156C854CD1A3B452AE500E164C2FA82B785B185B78B848BD485AD433
            DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1E022BF45BB16238B5317
            772E315D52BA647869F0D27DCB68CBB296FD50E2585255F26A79DCF28E5283D2
            A5A5432B82573495A994C9CB6EAEF45AB9631561956455EF6A97D55B567F2A17
            955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDADADE4AB7CAEDEB48EBA4
            EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B5F6D4ADE74A17A6AF58E
            CDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D7F5DCB56FDADABB7BED9
            26DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78576BBD457DF56ED2EE82DD
            8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645EFEB6A746F6CDCAFBFBF
            B2096D52368D1E483A70E59B806FDA9BED9A77B5705A2A0EC241E5C127DFA67C
            7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23ABF75AC2DA36DA03DA1BD
            EFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F579EA09D283DF1F9E48293
            E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD6743CF9E3F1774EE4CB7
            5FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE3D477E70FDE148AF5B6F
            EB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573D7F8D72E5D9F79BDEFC6
            EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D7A8F78AFFCBEDAFDEA07
            FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09879EFE94FFD387E1D247
            CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2A713CFCA7E56FF79EB73
            ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372EFABA9AF3AC723C71FBC
            CE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40FE50F3D1FA63C7A7D04F
            F73EE77CFEFC2FF784F3FB25D29F33000002AF4944415478DA8DD35B4853711C
            07F0EFD9CE2EA5D4435A2D282C29E728A8F7280CEA2588AE56C2D2A0074B4848
            B3392F902F091625592F114189500476811443A7D381264B4CD4B45C9BE6653A
            776967D3ED9CB3D3EFB45149173DF0E53C9CF3FBFC7FFF1B83CC5A0520EDDEBC
            65DDE3D55ACDDA117B6B2DA69F3E80E80F60994792243048AF495724698BAB4D
            07F2535392D0F0C6094B5BAF55703C2B03D7DBB53C005D867AEB91D2AA6A532E
            A3E4E10DC730E40AA3CB36C6F9862DB59869BC83C8B4E73F404A862AED98A9B0
            B2244F64784CF9A2084401EF8284314700F3C3FDDD70BEA884A7E32D10FB1B90
            AA576D3B6ECABB5A9C1B9508F04731CB89985F9410101408514731B72782CFAF
            EAE07A7913E1C999A500B35ECFA69F306717161943311E9304B8B91866433144
            44F2D52A80A5048380736400838FAE61BAB5E917A0D8A067B79F321F2EB862E4
            8428267CD405011C4FC50ADA20A59200165011027A8F0ECDA1A5200FDF3EB510
            2030501290916D3E985F6C0C44A370F905CC8424884CA2588E0CC9487232F075
            4EC2939375F0F5D71030C180958133E6AC8B25461FCFC3E98BCF5F52FC06C8D3
            5069007F18B03EFC889E1BF510C20D047C2160A39E35E498F75F32C501EAC01B
            95DB4F146BB58048D8E84008B67B1F30D66881B8F09AE6D3474084005D26BBD3
            589E75B934E7071088613E420BA452C7479DF30AE8793E89DEBBEDE01C9D54D8
            4E7152C4F822B23A03BBEB5CD9A1A28A1CBFC0633C04B8790DF808EDF9903D8C
            CEDB3D703577415C6CA3223B25B8741B559B0CEC9EF3E547CDD7CF7210E00A2A
            E018714B116BFD28DEDFB7819BB0D0BFF2C8E372CD9F0729394D07FDE90BFBF2
            2BAAD46B34E86EEE0870ADB7DEC1D5D49168B78F12FEF7514ECDA4C55A95A2D0
            EDAD661818C4C1063B221E1B7DB752A65670997E3E6B293B12A339280B2BB9CE
            DF0170EC61F09B3BA4610000000049454E44AE426082}
        end
        object PngBitBtn10: TPngBitBtn
          Left = 512
          Top = 56
          Width = 33
          Height = 21
          Caption = '?'
          TabOrder = 7
          OnClick = PngBitBtn10Click
        end
        object spezialfunktionen: TComboBox
          Left = 344
          Top = 112
          Width = 201
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 8
          OnSelect = spezialfunktionenSelect
          Items.Strings = (
            'COLORBOX1-Select'
            'COLORBOX2-Select'
            'GOBOBOX1-Select'
            'GOBOBOX2-Select'
            'DIMMER-Change'
            'COMBOBOX-Select'
            '--------------------------------'
            'COLOR1-Refresh'
            'COLOR2-Refresh'
            'GOBO1-Refresh'
            'GOBO2-Refresh'
            'DIMMER-Refresh'
            'COMBOBOX-Refresh')
        end
      end
      object Memo2: TSynEdit
        Left = 0
        Top = 137
        Width = 638
        Height = 268
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        OnExit = Memo2Exit
        OnKeyDown = Memo2KeyDown
        OnKeyUp = Memo2KeyUp
        Gutter.DigitCount = 2
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.ShowLineNumbers = True
        Gutter.Gradient = True
        Highlighter = SynPasSyn1
        Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete]
        TabWidth = 2
        WantTabs = True
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Vorschau'
      ImageIndex = 3
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 638
        Height = 405
        Align = alClient
        BevelInner = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object Mainmenu: TTBDock
    Left = 0
    Top = 0
    Width = 879
    Height = 25
    object TBToolbar3: TTBToolbar
      Left = 0
      Top = 0
      BorderStyle = bsNone
      Caption = 'Hauptmen'#252
      Images = TBImageList1
      TabOrder = 0
      object Datei1: TTBSubmenuItem
        Caption = 'Datei'
        object NeuesDDF1: TTBItem
          Caption = 'Neues DDF'
          ImageIndex = 14
          OnClick = NeuesDDF1Click
        end
        object DDFffnen1: TTBItem
          Caption = 'DDF '#246'ffnen...'
          ImageIndex = 12
          OnClick = DDFffnen1Click
        end
        object TBItem23: TTBItem
          Caption = 'DDF speichern'
          OnClick = TBItem23Click
        end
        object GerteeinstellungenalsXMLspeichern1: TTBItem
          Caption = 'DDF speichern unter...'
          ImageIndex = 13
          OnClick = GerteeinstellungenalsXMLspeichern1Click
        end
        object TBSeparatorItem1: TTBSeparatorItem
        end
        object TBItem16: TTBItem
          Caption = 'Schlie'#223'en'
          OnClick = TBItem16Click
        end
      end
      object Komponenten1: TTBSubmenuItem
        Caption = 'Neue Komponente'
        object Gertebildundname1: TTBItem
          Caption = 'Ger'#228'tebild und -name'
          ImageIndex = 16
          OnClick = TBItem11Click
        end
        object menuitemlabel: TTBItem
          Caption = 'Label'
          ImageIndex = 0
          OnClick = TBItem8Click
        end
        object menuitemedit: TTBItem
          Caption = 'Editbox'
          ImageIndex = 9
          OnClick = TBItem7Click
        end
        object menuitembutton: TTBItem
          Caption = 'Button'
          ImageIndex = 1
          OnClick = TBItem6Click
        end
        object menuitemcheckbox1: TTBItem
          Caption = 'Checkbox'
          ImageIndex = 2
          OnClick = TBItem5Click
        end
        object menuitemRadiobutton1: TTBItem
          Caption = 'Radiobutton'
          ImageIndex = 6
          OnClick = TBItem9Click
        end
        object menuitemDropdown1: TTBItem
          Caption = 'Combobox'
          ImageIndex = 3
          OnClick = TBItem4Click
        end
        object menuitemslider: TTBItem
          Caption = 'Slider'
          ImageIndex = 4
          OnClick = TBItem3Click
        end
        object menuitemColorpicker1: TTBItem
          Caption = 'Colorpicker'
          ImageIndex = 7
          OnClick = TBItem2Click
        end
        object menuitemShape1: TTBItem
          Caption = 'Linie'
          ImageIndex = 10
          OnClick = TBItem10Click
        end
        object menuitemPositionierung1: TTBItem
          Caption = 'Positionierung'
          ImageIndex = 15
          OnClick = TBItem1Click
        end
        object TBItem17: TTBItem
          Caption = 'Farbauswahl (COLOR1-Kanal)'
          ImageIndex = 3
          OnClick = TBItem17Click
        end
        object TBItem22: TTBItem
          Caption = 'Farbauswahl (COLOR2-Kanal)'
          ImageIndex = 3
          OnClick = TBItem21Click
        end
        object TBItem19: TTBItem
          Caption = 'DIP-Anzeige'
          ImageIndex = 17
          OnClick = TBItem19Click
        end
      end
    end
    object sizecontrolchecked: TCheckBox
      Left = 416
      Top = 5
      Width = 137
      Height = 17
      Caption = 'Komponenten bewegen'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = sizecontrolcheckedClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 51
    Width = 233
    Height = 433
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object Panel3: TPanel
      Left = 0
      Top = 305
      Width = 233
      Height = 128
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      Color = clBtnHighlight
      TabOrder = 0
      object JvGradient1: TJvGradient
        Left = 1
        Top = 1
        Width = 231
        Height = 126
        StartColor = clGradientInactiveCaption
        EndColor = clWhite
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 233
      Height = 305
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object deviceimage: TImage
        Left = 8
        Top = 8
        Width = 64
        Height = 64
        Picture.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000004000
          0000400806000000AA6971DE000000097048597300000B1300000B1301009A9C
          1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
          78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
          92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
          885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
          91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
          0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
          9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
          422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
          40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
          8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
          7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
          29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
          66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
          70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
          9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
          7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
          FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
          F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
          F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
          5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
          400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
          C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
          8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
          4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
          A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
          8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
          3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
          23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
          211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
          53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
          B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
          08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
          6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
          486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
          55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
          AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
          A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
          5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
          71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
          DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
          BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
          D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
          C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
          32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
          9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
          563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
          ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
          F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
          57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
          BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
          F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
          C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
          237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
          1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
          17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
          7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
          747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
          9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
          339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
          3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
          E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
          D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
          79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
          5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
          F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
          5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
          6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
          DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
          1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
          9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
          576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
          45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
          5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
          3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
          579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
          BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
          AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
          73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
          5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
          09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
          B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
          72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
          40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
          4D410000B18E7CFB5193000021EF4944415478DADD7B07789555BAF54A4E49CE
          49EFBD514220098150030A115110028C3214B18C3A828AA0D87566BC57BDEA8C
          327A511CEB2828489116409080B490909004D21302E93D27FDE4F496BBF60738
          F35FF50ACA75FEFFFF9E67534EF9BEBDD75BD67ADFBD8FD3E0E020C4E5E4E484
          ABBD4CC60127579587F4C50E4D17AAABAB11191989A29252848785C2D3DD1D8D
          8D8D183F7E3CDFBB0077FEBFB2E2221212E35156568AA8A868D4D7D7213C3C14
          A3468DC295395CDB350887DC05EE4AF9CFF8EE3F2EA79F0380B8F4069393C160
          50F29FB2F3E7CF074746467497559EEF8F8E8C22006AD4D4D461C284F1B878B1
          0A6E6E6EFF7F00D0DAD6E94B6BAF0D8F8CDCA2542A0D369B6D537149B1576949
          99AF5AADD2D96CF6BAD0E0C07C1F2FCF32995C5E382E39B9AAB5BDA5C7C7DBC7
          5A525C81D14989282E2E92BCA5BEBEFEFF2D00EA5BBB924A8A8A7634D5D70F9F
          72C38DE686E616990C766D477BCB07AE2EAE81269369A4B3B3F388016DBF6F7F
          7FBFCCE170888539D42A7575404060B1CC595E149F382AAFA9A9B1263636B6AD
          B6B6C644AFC1C891234120FFEF07A0B2B6F9898AF2F2B7617760547C223ABA7A
          A069AD2F5DBC70FE277C5BC521F7F7F7770D0D0D5524278F778F8F1F15ECE7E7
          1F66B5DA230948A0CD6A55D86C56285D94460F0F8F063EAF262626FA143D605F
          505070A5C361BFE6C93BE48A5F0F808AEAC667EB6A6BDFF0F1F44654740C064C
          161CDAB7B361CD638FECE6DBB51C7A0E2F0E770E85B8A5186AB5DA79F4E82497
          848478B78484D13172B9FCD681810127BBCD0E93C90C82D6939090307BE62D37
          9DEDD4F43AAE7AE29CAF8BB7273C14CEBF0E008515175FA8ABA97D7D684C0C02
          0283A1339A91F1F5AEB6D58F3EFC11DF3EC8D18C4B9E2000F0E4F0E6F0BD3CC4
          6B52C27CE59557971497940C8D8B1B059BD58EA6A626A4A44CFA66F5EA47EEE1
          FBBDFDFDC69F04419A33A72B7753C15D7E6DC9FB6703505456F562E5F9AA57E2
          E2E2E0E71F00B3C98ADD3B36B73EF7CC936FF1ED3DF905857513C68F95AC8E4B
          1EE0721910F565008477F83EF8E08AB421C3462E0F0E09435F5F9F34542AD781
          5D3BBE5C56907FE644FAFEA3BA9F9AB4D56A45F28431080D0F82EA1AD9EB6703
          505DDF7C2C2B3BE7A6A4A424F8F8FA43AF37E0AB2F3734BCFCD28BEBF876FA37
          87BEADF7F07087B3D320BCBD7D60369B111A1A8296965624278F71BE0C8A6B5A
          DABCF1B72F5C9AEEE5EDE72EAC2F34825EAFC7BBEBDE78B9B6E6E267FC4CD3EA
          352FFC282D88C587478463F5138F42A19043EDFC2B01505C5E957F2AEBF4F849
          932641EDE60EAD5687F41D5FD6BCF197D7DEE5DB7B73720B1A5C5C55880C0981
          C9A0C7997305183326095E5EBEFCBCDB77CF489B3B3BF081E58F647B7AFA0EAB
          A9A9211586A3A7A7077F7EF5C58FEBEA6A3EE4C74A5F7DFDAD1FA5058BC58A59
          736EC5C409636166DEFCD54220FBCCD99253D93989D36EBC0132B912DDDDBDCC
          01BB2BDE59F7D6DFF8F6FEEA9AC6262178544A05BA3A3A70ECE4094CBF2955B2
          D820A3C2C3DD0B821A57AD7A58B57CC5AA33EE9E3E8915156508216064096CFC
          F46FDBB2B3B3C4BDF2753A9DF9876731480F7382B38B0A365C4A7EBF0A00750D
          F5F286E68EB2D3A773474C9F3E9D9F95414309FC6DC6DED2F7DE5DB79E1F39B8
          6BD7BE961B6E9C06255DB2A7AB1327B232318D9FEDEEEE46696929171A01B5DA
          033366A438ED493F5CE0E6EE995C79BE9C6112868101AD00606766E6C9F778AF
          5C7EE70701107354AB5CE050B8C2F16B02505D5BA3686EED2CCBC9CD8B4D4D9D
          0EC7A0133A3A3A71ECD0BE92F7DE7B47E4806FDE59F7B7F6BBEEBD17725AA9BB
          538313A72E0120925C616121020383101C1C86AFBFDE2F1B9D34BEC0DDC36B4C
          754D155FBBE4015B367FB2E7F8B163229C72DBDADA4C3F340FEA0728E5CEB0CA
          5C30E8F42B02703C3353056765E99933F94353535361E757DA5ADA71F8E0EE82
          8F3FFA603D2776E4B5D7DEECBE7DE1420F25EFA3D3F6EB4EE7E55A09804378C0
          B973E7084020A6DC38152DCD1A4531AB260F4F9F11CD2DCDF0F3F32348FD48DF
          BD69FFE18C8C77F8B89CBABA3A8378AE989B9897081D5F5F5FB8BABA4A49D6F6
          6B0370222BC7D33A88D2C2330591A98C6B0B5FD3B46A505551D4AC52C8CA7B7B
          7B4329877DB9188586F1DFDEDE6195BB28FBC64F987096593EA7A1A15ECD58D7
          4EBB69FAE1E08080A61DBBBF3EEBECAC1CDBDAA62100BEE8D76A7120FDCB43F4
          8EB779EBECB2B2328324745C5C9820BB21A628E897F5C7BF06806F4F647A0DCA
          14A54579E7225267A4C2EC18447B731B2E56962029711472E8EE26A341B27210
          F9BDBCF2226C0E1B7E77DFEF683D1B3EFB740343A61DC346C4EA264E9AF2BA52
          A15A68B1D8C7D537344A6E6D341A9171F0AB23FBF6EE150064151515E9A818A5
          2A527CCF898B8D8B1B490014FF1A00328E9EF072522A4B2A8ACA22A73307E82C
          16B434B4203CC817E3C62631890D90EF5BB071E3E7B4680056AF7E1416EAFEB6
          0E0DE2860FA1E435E1E38F3FC1814319F0F1F16705988429536E403B17E7CC85
          88F78F64EC3AB667F72E0140E6912347068282822470349A76BEF42F02C06A34
          392954AE83F5CDADC3ABEB1B8BEAAA6AD4295353D04BE1D254D7086F7757C4C5
          0E85D1E24065A5486801D0B46B104A6A1B373E49B26C4B530302299C7C830240
          1D81F7DE598F3A96C2F1F123A5858F19331163C64E2478EF656EDBB6F5AF0280
          A3478FF60B6F72A3DEE8ECFC3E000EC53F00F85F1742B55535C9171A1A96CBD4
          6E0FB7D6356052CA64743269D55EA84152FC30248D8EC799FC62E808CACDA953
          18CF3A66FD62444545213C2C108F3E781FCE9755E0C9E79FC782858B25FDB07E
          FD7A1C3E9C2120C6A884242C597217B66DFDB2E4DCB9B31B59189D7FE8A1870A
          E901ED22077474B47D0F009DD5993AC00932D6DF4D8DAD8B5BDBDAC37C7DFD3B
          6242BC8F0507F9B55E37008A8B8BC7EDDD91FEAD93CAD57BF2F46968AD6FC1E4
          944968A0BC6DAD6B620E28457464285A3ABB612733AF5EB51201BE3E52D21221
          A020659D389281C30732307FD142C40C8FE36B72787B7961EBD6EDD8BB7B2F35
          7D326E9D750B32299CD2D3F75C8EF7B84EB2CDBB898989EFDAED56ADC562C388
          1123A424E8A27042554337724A9AA054C8E2359DDD853ADD80423C73D2C8A0B7
          67DF32ED0F9CBAC8D357D565F951007A07FA5C367EF279564B7DDD78A3CD81B9
          8B96A0E1E245082558DFD286DAEA7A641CD88F59B7CC840B6355D7DF8DCEB626
          2C5EB2842E3D9649D001BBDD01854C0667BAA9788C78525757379C65CE7055AA
          D0DBDD07FF005F68A81B3C3D3D91959D85EDDBB7A3A9B11E7282C74537248D1E
          BD397174D28763C72637D3E0F40007AC9C4F47671F5A3BFBA66795379F1077B6
          B1BCF67668BE58B5E281D7F898260EE3350390979797929B9BFB7052F298BC88
          8868DDC1BD5FFF7DC7D64D72FFA030DCBF6A0DF2B24EE2A6D469D05BEC5487CD
          30EA8D484C180DAD7E00D1A1FE78F3A53FA2A9A5118F3CF638EEBA9BA248A180
          CD4C67250052B2B35A20F4BF9FBF3F0203FC21975D8A63B3D94A10BAF9B745CA
          FAFBF7EE45CEE91C0C12446F7A54D298C4BA1B6E98BA70F6ECD945568B715008
          3138CB713ABF70C5B182CA8F7C7D7C088A1D2527D2D3377FBE71236F99C5D17D
          4D0074767645DD75E7E2331D1A4D50DCC8043CF0FB877060FF3E6CFDE2534C99
          3603AB9EFE030AF34EA3A3BD0DE3264E165C8FEE3E3D42C2A228523CD0D15483
          033BB740AFD3C2C04A706EDA7C3CFEC453A4C5607A02981BFA9179EA1486C4C4
          480950006EA7250D2C9CC4BD44BDA052A921A3C7787B7B63FFBEAF5156568E0B
          172E306FB422313161202565CA17D40D1F0F1D36A224383C02878F1CDBBF6DCF
          C134032998A820C81DF99F7EF2B11053473834D704C0E9D3A7EFBCF7AEA55BAC
          16336E4C9D853973E763FD3B6FE17C7909D2162CC4CCDB1660F386BF43EDEA02
          1F5A4F089E1189E3A1F60E8497BB0B8AF3B3D0D7DE040A23B4B5B7C3C00C1F1B
          370ACFBDF8EF4826555631697A7ABA23243888800C72D8B9C032A9393A7CF870
          8C8A1F25854A67678F14EB8C6FC92B44F7F8934F3E424D758DD440F5F5F3374E
          4E99FA9FB1717186F2CAAA575BDA3A5156528AA6D61684F8B9990DBA81E749A7
          5F70493DD704C0FB1F7C10589C97B77FE7F6AF262EBDFF01F2B50F4A0AB261A6
          9586C48E425549190A7273E1CDD7434282A054BB62ECE41990AB7DA070616253
          2BA0A9BB80CAF2628601EB7C5298897AE1F625F762C64DD3F1C5E71B10191985
          FBEEBF1F915111282D2E43495929446D1116162A012224AFF00CE105E2EFBEBE
          5E7A88086505B67DB503478F9F808A9560784404A64C9D8A3E865E0F3F535D7E
          1E0DEDAD30F46B919C94D0E1EFEBB9E0A57FFFB77C7EF127BB4BFF9C03D474BD
          2937A7A6BE3979CA8D638A8A4B9C2E30CB0BAEBEE38E85D8B6790BCCE4753121
          2F2F77A83CDC70F39C85189772139ADB9AE1E922C391BD3B50547086B1AF64C9
          2C4352D218CC9EB7005BBEDC8CDA8B5590295DF1C0F215D40EB1E8628DB078E9
          1272BD5A8A7DBD5E07D15011D6177312430021AE939939A8387F8182CB00667C
          694E32B24948443818B2283D7B0E3ED4193DBCA7B6AF0713C68D396FD0F6CDFE
          E0830F1A7F8A0DFE1900D1B119C671F3DA37D73E999EFE75CCD3CF3E8B13DF1E
          C6BEDD3BE1E9E10923176FD01BE0EEA1C6A0CC09D36E998FB9772C63A2F24273
          CD79BCF68767C0C09612D2B061C33061E244E4D06B2ACA4A683905264C9D86D0
          A86814E4E5E1C9A79E44DABC795C248B279D1E8284542A96B98EC1FF8391443F
          E1934FBE809561E3E4AC80C56C240046F4B17E30580804936B37C5573315636C
          DC08CE71805330232A34E842B0AF4F49605050775F6FAFA1A74F6F1C3224A691
          FAA439C03FA03E7E7442F97F07403C55F5FB07EE9F6AD5EBB7B57776F9CE4DBB
          1D1D6DADF83A7D973441ED800E465A6BE8F018BAB791AE1C87AE1E83B4B0A913
          C7E299C75772C2460404F860C6B4549C3E95878B3517254A0B60E61F3B2E1985
          45C592C67751A9B072CD1AC40E8FE5E7FD111A1A2CED0F5CA900C525EA81D3D9
          B9C82B28853B69526730C048EB9B69082B176964F213DF11F9C8C4C46BA51A19
          74D8A59E8469A00F36A356A26229AC1472893E3DBDFC909636EFD5871E79F855
          81EFF774C0CB2FFE71C3AE2D5BEE53F3817A8315362645572A30272AB03ED6ED
          9ED4F2A93366E0E889E37053AB58AD75C1EEACC633AFBC213A44C83F79046973
          67A1EC5C21AACFD793F32195B16161E1D4F56D4C6E0AD819EBA1E161989A3A03
          C78E1DC3D8B163B07CC5722424264AB9400CE1FE468309DBB6ED84CADD0B66E6
          131D176CB6DA60B75809829EA14330782F0BE7287A9466E3002CF40E3167BBD9
          00E7419B9457C49E8383DAB1B77700D352671664E7E4BE999D9D5D22F4C2F700
          78FAB1D53B338F1D5BE8E2A6C2A0DD19FA817E497E8A66AF811392338EA3870E
          45ABA6030181FE68A6D6A714C5E8E96948A6CBAB6C2654149EC1A9E387A17056
          42EE24471817DB4FF96CB19AA4E70840222223A5024A44A8887B1FB2C39D77DF
          853B99175C5D55D25C4E65E6A2B6B60E2A370F494398B830A3898B379A288E1D
          309B0C9268120D1505F3CEA058B8DD0AABC30A87DD82417A8704A804921EEEEE
          5EF6EE7EFDC1CCCC536779FB4C8E73DF0360E3679FCEFF7AD7AEF4E696162731
          393D2B3D21589C09808DEE2444889EEE4F3F83AF4F30860D8D230D9D85999F0D
          8E8DC78D93A6A2F0F4094E3E032E320562A28648AEAA1DD012503B95A11C3EBE
          BED0F1FF1686939BDA8D49530E27E60825C3E2D6D9B3F1F89AA7687D0B0E1D3A
          84E09050869D555A886015B3D50C03E7D44EF08ACFE649B9473096488CA20E59
          B878116C34582DE953D8CD46E0449868B53D881D31B2F9B30D9BF2B8CC5C0E51
          8C547D0F80A953A7C6DC31FF37F9FB76EDF25332B3B753F70B15E77439360719
          5F0E49EB3BA49CA0242D2994A42D82E4C4BFE7DCBA00F3E62FC481C37B7160F7
          0E38AC76A26FA2156815EB2093A997B418D10ABF92E58507B8BB2AE1CCE2C73B
          200877DDFF20B19753377840AD5673E136BAB55532425D5D390A0B72D0D3D24E
          F1D5020F1F4F2957883C60E7EDD67FF82145A22BD6AD7F8FA1AB240066499C79
          79FB5A0B0A0A72A93B0AF9C8AF390410DA1FAA053C3FFDF4D3E33BB66F4F66D1
          C924D84E4B99457F0A760E87C42AA457BAD500A5B0850BF4F0F422084A2ED442
          709CF1F8D3CF22E5C614BCF2C29FC8D115A4AF7E667007C3C7858B964B8B17BA
          FEBB6447205C9572C8E901294C9EC3E212A02650712C8084656D36D102B5A320
          3F17278F7C4DCDA1468FA64B6A8B2A3D44C9DC095782C798C37FFCF92F484C1A
          87D56B9EA0D1583710FC01AAD0E090B0FACD9B379FE1578E731CC2A57AC1F143
          00C83FDFBCE935AAA967F5E458417B0ED2DA00F95724220F2F4F2818C362A162
          5A629748E9A6440363D58921D254DF8485CB96217AC850E49ECCC2D2C5BFC52E
          D2686EEE69CE4F468ABAD4F2771200FC131F2B498791438660F4B80904C21D33
          67CD9112A6705F39E9AF8879257DEF3684F906F0394ED4115DA4637752681F8D
          602585AAD0D9DD899DE97B499106FC65ED5F25AFD5910DFCFD7C4D07BFC938AD
          D16844ECEF13B1CF61F8EF34F89D3658B57AF564C7E0E0A17367723C9DE97A36
          72FB406F1FF47CD0E49969881B33192E8C5D3DE3B89C1CDFD6508DD8614371CF
          DDF748B5421FC5483A0B9A19A93761D93D77A1BEA11EEFBFFF01DAEAEA50565C
          444DA064592C9312A05413F0FE3EFE5E181E170F374F5F4C9B390B231347C342
          0F7362BCE59FA3102A2E849DB92480F1DEDDC33A87EA53509C851E2292AA0B3D
          D02F3008AB5888ED4EDF47C0F3A47B6BFBFBA84A5517B66DDF2E94E1B7B85427
          B45E11483F560EFBBFFDF6BACFF7A7EF99A3A7BAB231B30E74752264582CD21E
          580367550019544756D0492C515D5C8045BF5D483A4B96EE7BFCD8B7282E29C1
          DD77DF4DDEF5443575BC70D3203F5F6CA32ACC3A95C944A6851BE35ED0940B01
          098B0C43505804C2A38661C11D8B499F32916771F4F021E4661D86891A20C02F
          502AAB359C8B87B7975448B13A96C2A9B9B9190B162DC233CFBDC0BAA31AEFBD
          F7BE448D4101BEBA8D9F6FCC32180C0597AD2FE8EFBB7D871F03C0E5E147562E
          F076F7DA78FC9B6F5462A11A0AA2C5B4E6FC7B96A377C02E3801DE2C6EE44C8A
          D5555594BDA3B91057899B8B0A0BA55A606CF258F4F4F6A2A2A2423A0821E4AB
          DD66C5F9CA72ECD9B11D67B24F480950B4BF860E1F4A16F0C02DB7CDC7A89189
          12CD15D3F2BBB66D82729094C6FC11183904ED6D6DD2DE831BE9584736705529
          251A6C6701F6C7975FC5A2A577515B9CC0860D1B25E16331EBCBF6ECD97DF672
          DC1FE3E8FC6779FC630088FF84BDF1E737D7EFDFB9F337DD1D1A4C4899827696
          A5513143F1F0CA27A4CEB0853CDCDDD5C54CE28C117171E45E07BA3BBB50575B
          2F35451414500DACF6448214C76274B4984894C28C2CDBA4523B3F3F0FD191E1
          14585EF0F60FE302EE955A5FAD8D35F8FB07EFC26ED24973F30F09878C82A89F
          C58F9A6CA363182809A8ABA83EC906FE54926FBFFF11354714366EDA8C6F0E1E
          A2FAF4EBFDDB7BEF665DCEF8C2FAE771A95B849F02405CEADB6E9B73AB975AFD
          657961897ACEFC05507BA97026BF004F3DFD2738D32222A1895A3E322A8C35BC
          1713E32017DC0899B31C51D1518C3F2D6AC8D36DADAD4849492115F9D0223682
          E060D656A2BCF42C766CDFC224E545A6D0E1B6DFDC89F8C43104568BED5B3F87
          898B7508061242C93F88AEDF0327B952CA213D5D1AB830EB8BBCD0CBB2F98E65
          4BB1E2D1D518A04C7E63EDDB686D6A446B734351464686887D717EE1142E95C8
          83570B80E4052FBDF4D29739A74F4F6B27CAA3E28763C62DB33132613CAC1444
          6626202DDD70C890282A3185B425DED0D08898E8211237373737318BEBD1462A
          8D60E516E81F2C1EC4C5BB49A1F2D9A71FD183C8DF7633FCFC82C9FF0F43CD84
          B66FC76634D4554174BC07997F026855B36D109ADE7EC4F0DF3AED005944263D
          A3B74703920256AD5A85F10CB9CCEC1C7CB1F94BB8AB5D7BDE79FB2DB1E8D31C
          FB392E727C6FD7F9A7BAC2AEBFBBEF7777C48D1AF5517579A5FBF98A12161D56
          DC387D1666CD9B2F756BC49E5FDCA8112C822C52BF4FDC2E9CC94C8041DA4110
          E5F2A5ED2DD6123D9D52FCA7A52D40E6A96CD436D492624D38CE8AF3EEFB1F42
          CA0DA928CECBC186F7D7C19F02A7B5AD893258856026464D4F1F5CDDBDE1C598
          6FACAB4148640C9F6197B6E9152CCFC3028271F7928568A6B7159C2D44655949
          D191C387CE5C163D220CFA7E68813F0580783162DEBC79BF9F7EF32DAB5A5B5A
          7C2F90F65A1BEA2439EBE61380D54F3CCB9A2090F4D74E7AEA41546494747EA0
          97C94F283D5F1F5F26232B0C461629C67E9868BDE0C8686CD8BE13D3A6DD0A6F
          7715CE52E00C4F48A4C05162FD5FFE4D9CC424A094AF3A1DD92192F46B819114
          EC1F1C423AD64ABDC2A0A060865F1BF38B2B4CB46B678F162E34F094C9E3C5AA
          BAFEFAD7B5D997172EAC5FCD61FF3900884B9C6E48F20F0898FBE0832BEEE9ED
          EA8E30EBB5282929C2C8A40958F5F8D35CA833A9EEA2748FE1B123242F109BA2
          42A38B2C2FA4AFB89C197EC13E81D89F71046D8CD584B19358B5E9E12BD41C85
          4D7375050E6CDB88006F7789D67C59420B1A6D686A82B79F3F73903781D52224
          28443A60257A8132328FB65F87C0E030DE47450F2B63FE096FDAB469D3817FB2
          7EFF8F2DEE6A00108AD38723817C3BF5FEFB1F5C32343A26BEA9A94E16161D8B
          99B7CD838519BDB2B20241ACE822C269312E4E8480D8F9BD7C5E50E26A57F2BE
          61C0801D7B0F20F9C669A86B68432935C4D285B7D375BBD0DBDE84D68BC59418
          3D74ED7EA964169C6FECD723302C0C7D3A4A68B98BB4BDD6DEDE4A4FF38095D2
          DA444F89898C407F6F3781EF723074B2F2F2F204EDEDE5B8F043B17F2D005C01
          C1836328C7E49123E353972C5D36951A3D64F498B14E015CA8380431323E015E
          3EDE92FB8B5D1D0F7777E9488B688F09BDAF72F7C0C91327A163ECC6F0B31BDE
          FF1BA68C9B84D88478E6830694E59C4280BB33C3A9093EDEDE5259DCCE22C797
          9617C2A89FE1E34FD717FB1446B28933DDDFC8123838909F55BAA1A4F02CD42A
          65E3D66D5B45E213D59E00A1FD7F5AD8B51C95151F70E588E218C731E691152B
          96159F3B1B9A3AF3368484862379C24421CBD0C6D814475F1497B5BCB8B5588C
          D8E139FAED114C989A8AD63E1D4E1ECBC09C5BE6A28B42E67C610ECEE765C3AC
          ED92BA4DE1CCF65D548F227784D1FA22A4C43E4390BF0F1A191E312CBDEF5BBE
          121B366DE2FF6B31223601066DAFF9F8F1A3B9ADADAD42EB0BDE1714A8BF5E00
          5CB9C4793F7FE10D4FAD796CCDA913C7EE70F7F4C1ECB90BC03C812002D1D4DA
          86C48484EFBABB220788D360B517AAB07FCF2E0C61B53766EA2D30389CD0D9DB
          C5C4D683BC035B21336869FD667831C1CA652E521E08E03DE57285A4FF434343
          A53697F08A3FBCFC3AE6DEF15B74D3DB3EFBEC0B9C38790C9E6E6ED5DBB66D15
          8B168AEF302E9D5DFC1F3BC33FF7B4B8D43F7CE6D967E7B1D8D862D4E99CBD28
          84323333319496B97DD1524447474BD427B85A748985BACB3C721007F7ED6140
          CA31E3B685884B9A8A464D234AC9025DD579301108335D3A80D4DAD1A2915463
          38F3407B672BDC546A78B1EC6EA1149E71EB2CFCE995D7E1A27245E5858B38B8
          FF5B54D796F47CB9E9CB82818101A1F945E62FC6556C8FFDECE3F2972FFF75EB
          DEF9A2AB67E0B6BAEA52B4D45CC0A04C8D35CFFF9134152275709C693D17853B
          6356872D9F7F80869A1AE9E8DCA225CB101A154BC1538BC387F7C0CB8DD99C42
          47749104682D4C72C26B4418F5697BE0CF3258BCEF496679E6F9E7103364B8C4
          0E99D9F97C7DC0F2CEBAD7F2EAEBEB84D811D59EA8F93B70151BA4BF14003533
          FDA4679F797E6D87A6795C5F772FAC16BBD4811D376112C744A99DEDA2744769
          79110EEED922B143C29889F8CDED8BC80ECEA8AAACC499334759E35BC8107A0A
          205FB46B3A585F80407931243AA052AB61A33739139CE79E7D466A9E8A6ED4DE
          FDDF60406F467DDDF9FA756FAD1505CF95E42780B05CCD027E2900821DC2396E
          7AE8A115ABFC0242C6BB51A71F3D7C00BDE4E69B6E9E8939F3EF80B7973F0E1C
          DCC710D8C75070C57D8F3C89E0B0484ED18CFC33B9C8CACA80BEAF07AED4F962
          166D2D2D94CD0152BD2FEA793F5F4FF4B3907AF1D5FFC0CC5BD330E824C3B7C7
          4EE2C2C55A7A96C9FCC1FABFE6D4D6D40AD717BC2F80D05F8DF5AF0700E21267
          826398F06E78E1853FAE898D8D8DCFCA3A89FAEA2A74D392A16151B8356D115A
          E8EA19DF1CC48CB969B863E932E8A9071414FBF9A74FE2F037E918A4D213CC41
          B5299DFE08080C80A6B5194A163C268733563EF618C3E64E496465679D4571C5
          452A4C13AACAF26B3FFEE823D1E414CD0E91F8BE6B76FC2A00980C56B8AA1502
          8448C6EBD471E3C6CF9B357BD68D3D5D9D012D4DF568ACAF813B3D20828B6B6E
          EAC4CAA79E831F0593496F927698BEDAFC194E32394632698A9988DA3E38985C
          4F8B6BFBFA983F645872EFEFB0FCA147A5B348E5951770F66C390659711A8DBD
          A6FF7CF3B5ECB6B6B62BE5EE5525BEEB0EC0E0A09D458BABA047A11152222222
          A63EB2F2D13483C91ADA547D01BADE368A171B12E227E3378BEF449F5E0F1B35
          81D82D4E67E5A769A947F4F011D20FB08462F4604214872DF97DCC983913CB97
          3F4886C9A6BEE880D668612D2097CE235796E5D57CF2C94739B894F8C468BF16
          EB5F37009C9CA8F59D1C7071550B4F08E218C16269D2FDBF5FB1282C302CBEA9
          A652D64CFA5A76CF83F00E0894D841FC564078C0D16FF6A2E14239E4AE6AA996
          179D2451E2EA75037870C54A2C5D7627A9D186ED5FED123F26801B3587C96865
          51D56358BBF6D5D31A4D87B0FEDECBD6375FEBFCAF2B00E2220822318ADF070C
          E798B264C99DF3939327A4E8B53AB79B67CF85496C6DD9C406AA4DFC7C06F555
          656487AFD0D7D90E3716458241F42613563CBC526A6F89E2273BBF50DA591227
          4D0C4633CC2C82CA8B0B68FD0FAF64FDA3B84ADAFB5F07E032089250E288E618
          BF72E5EA07526E98313DF4729F405C62BB4AB4DBD52E72ECDEF9154E1DDE8FE8
          984869CBECA14757C183A5767B47376AEA1AA5F3463267192CA22CE6F7CDA601
          E3DAD75FC9D2683422F989D82FFD39D6BF2E00586811272787B479FADD4D3964
          2E1208CAC0C0C0B0975E797D7FD89011A3144E7269F7F6CAF95F01803815267E
          4C557CF6B4D47D9E939626360D5057DB00DBA07427BE6F913C46F41CF5461DB5
          4371F5DF3F7C3FE7975AFFBA00200E2CFCD825646D6171E9032DAD9A4F43C2A2
          29926C5243542A911D979E2BFE143583522997BA4A032C6D1D97FB07A29012C3
          4260842C16FF7658F4C637FFFC9AB0BEE8F6ECFD25D6BF2E00086AFAA14BC66C
          3EA0D3BB6DD9BEF3ECA8F8C411834E0A0CDA2FF5062E6D593BA43341E2648874
          748E9FF7F2F2943639A44573C1A288129D2151450A5044E3B4FA4261F5A77FFF
          F8BA58FFBA0020F6F97EE8121AFEF8F1134FB46B7ADF0E8B8866E66798401C7D
          7140FC640ED2BF6DD8B06183B4E5A664C1E4C96267DAB469973644A5B69855DC
          C7D1D7DB6D26400ABBDD667D8BBCDFDEDE2600F845B17FDD00A8ABABFBFE4D79
          2F5A3082D561F6D061712E35B5B52CF9B5DED1D131FE7CCBA9B5B545DBD050A7
          7551A98332328EA847278D964EA24445459A2BCB2BCE7B7878C8870E1DEA2E7E
          38515959AEBD5075DE1018182473F770979595960A9D2F149F507E1AFC02EB5F
          17008A8A8A7EF0757A46405959D994279E78C2C360304C639C0751E1B9D2BD15
          BDBD7D368BC56C1C352ADE65E2E44991168B55C1FFDA6A6A6A060ACF158A4589
          0EAE6863C92FFF2D7E4A7745E1B5709CE4A8D01ACC664F497AFC0B01282929F9
          C1D7478F1E2D261FC331852302FFA8CEC4EF07C5C3C42685705F219C4270A9A6
          10AEDEC2FC20FA78862BAF5DFEACEEF2F70C9741E8270083BF1480FF020A3C75
          634605403F0000000049454E44AE426082}
        Visible = False
      end
      object devicename: TLabel
        Left = 80
        Top = 8
        Width = 61
        Height = 13
        Caption = 'Ger'#228'tename:'
        Transparent = True
        Visible = False
      end
      object deviceadress: TLabel
        Left = 80
        Top = 24
        Width = 62
        Height = 13
        Caption = 'Startadresse:'
        Transparent = True
        Visible = False
      end
      object dipswitchpanel: TImage
        Left = 80
        Top = 40
        Width = 105
        Height = 38
        Picture.Data = {
          07544269746D6170A62C0000424DA62C00000000000036000000280000006900
          0000240000000100180000000000702C00000000000000000000000000000000
          0000AC7715AC7715AC7715AC7715AB7614AB7613AB7614AC7715AC7715AC7715
          AB7614AB7613AB7613AB7614AC7715AC7715AC7715AC7715AC7715AB7614AB76
          13AB7613AB7614AC7715AC7715AC7715AC7715AC7715AB7614AB7513AB7512AB
          7614AC7715AC7715AC7715AC7715AC7715AC7715AC7715AB7614AB7614AC7715
          AC7715AC7715AC7715AC7715AB7614AB7513AB7512AB7614AC7715AC7715AC77
          15AC7715AC7715AC7715AC7715AB7512AB7513AC7715AC7715AC7715AC7715AC
          7715AC7715AB7614AB7614AC7715AC7715AC7715AC7715AC7715AC7715AC7715
          AC7715AB7513AB7512AB7614AC7715AC7715AC7715AC7715AC7715AC7715AB75
          12AB7513AC7715AC7715AC7715AC7715AC7715AB7614AB7613AB7613AB7614AC
          7715AB7513AB7512AB7614AC7715AC7715AC7715AC7715AC7715AC771500AC77
          15AC7715AC7715AB7614A8710BAB7512A9720DAA730FAC7715AB7614AB7613AA
          7410AA7512AB7613AB7614AC7715AC7715AC7715AB7614AA7410AA7411AA7512
          AB7513AB7614AC7715AC7715AC7715AB7614A9720EAE7A1BAE7A1BA9720DAB76
          14AC7715AC7715AC7715AC7715AC7715AB7614AB7613AB7512AB7614AC7715AC
          7715AC7715AB7614AB7512AC7817B07D20A9720DAB7613AC7715AC7715AC7715
          AC7715AC7715A8710AAF7C1EAD7918A9720DAC7715AC7715AC7715AC7715AB76
          14AC7715AA7410AB7613AC7715AC7715AC7715AC7715AC7715AC7715A8710BAD
          7818AE7B1CA8710BAB7614AC7715AC7715AC7715AC7715AB7512B07E21AD7818
          A9720DAC7715AC7715AC7715AB7614AB7512AA740FAB7512AB7613A9730FAD78
          18AE7B1CA9720DAB7614AC7715AC7715AC7715AC7715AC771500AC7715AC7715
          AB7614A76F08D1B47DE4D4B6E5D5B8B4852DAA730FA9720DC6A25EE7D9BDE5D6
          B8BC9244AA730FAC7715AC7715AC7715A66E05E3D2B2DFCDA8E1CFADDAC397A7
          6F08AC7715AC7715AC7715A9720CC7A463E1CFACE8DBC0C5A15EA87009AC7715
          AC7715AC7715AC7715AA7410A87009B58630C5A15EA8710AAC7715AC7715AC77
          15AA7411B58630E8DAC0E2D2B1DAC297A8700AAB7614AC7715AC7715AC7715A8
          700AC09950E8DAC0E4D2B3B98D3BA9730FAC7715AC7715AC7715AB7614AB7614
          DAC49BA8710CAB7614AC7715AC7715AC7715AC7715A8710BC0984FEADEC8E0CE
          ABCBAB6FA8700AAC7715AC7715AC7715AC7715A66D05E7DABFE5D4B6B98C3AA9
          730EAC7715AC7715A76F08DAC296E6D8BCDFCBA4AF7C1EAF7B1BECE0CCE2D1B0
          C39D56A8720CAC7715AC7715AC7715AC7715AC771500AC7715AC7715A9730EC2
          9B54C9A869A76E07AD7918E5D6B9AA740FAB7613A66E06D9C195B58732A9730E
          AB7614AC7715AC7715AC7715A9720DBF984EE2D1AFA9720CA9730EAB7614AC77
          15AC7715AC7715AB7513B17F23A8710CA46B01F1E8D9AC7918AB7513AC7715AC
          7715AA7410B88B39C0984ECEB179E1CDABAE7B1CAB7512AC7715AC7715AB7614
          AC7715AB7513A36800DDC9A2C19A52A9720DAC7715AC7715AB7512AD7A1AF3EC
          DEA36900B4852EE8DCC2A66D04AC7715AC7715AC7715AB7614A66D04E5D6B8BA
          8F3FA9730EAC7715AC7715AC7715AB7613A9730FF6F0E7A66E06A66C04F4EFE4
          A56B01AC7715AC7715AC7715AC7715AB7513A26800A77009EADEC6A56C02AB76
          14AC7715AB7512AA7512E4D5B6A56B02A66E05E9DCC3B28127AF7D20F8F5EDA4
          6A00AC7715AC7715AC7715AC7715AC771500AC7715AC7715A9720DC5A25EB383
          2AA66D04A26700DECAA3AD7A1AAB7513A76F07D8C093B68732AA7410AC7715AC
          7715AC7715AC7715AB7614A77009C7A463E7D8BCA9730EAB7613AC7715AC7715
          AC7715AC7715AB7512AB7512BB9041E2D1B1A8720CAB7614AC7715AC7715A76E
          06DFCCA7D7BF91D5BB8BE5D6B8B18026AA7511AC7715AC7715AB7614AB7512AD
          7818AC7715E0CEAAC09A50A9720EAC7715AC7715AA7411B4842CE9DCC3A66D05
          BE964AE2D2B0A66D05AC7715AC7715AC7715AC7715A9730EBC9243DECAA4A66D
          05AB7614AC7715AC7715AB7614A76F08D8C093BD9346CDAE73E7D8BDA56C03AC
          7715AC7715AC7715AB7614A66D04E8DBC0E7D7BAF7F2EAB78A34AA730FAC7715
          AB7613AB7513E3D3B2A56C02A9730FF4EDE1A36900AA7412F7F1E9A46A00AC77
          15AC7715AC7715AC7715AC771500AC7715AC7715AA7411B3832CD8C092D0B37C
          D2B683D3B885A76F07AC7715A56C03D6BD8EB68833AA7410AC7715AC7715AC77
          15AC7715AC7715AA7410A36800D7BF90CAA96BA8710BAC7715AC7715AC7715AC
          7715A9730EB68730F2EBDEC19B53A8700AAC7715AC7715AC7715AA7411B07F24
          E4D3B3B58731D0B27CA66E06AC7715AC7715AC7715AB7512AF7D1EE8DABFE0CD
          AACAA86AA76F08AB7614AC7715AC7715AA7511B07F22F2ECDDCCAD71E5D5B7B4
          842DAA7410AC7715AC7715AC7715AB7614AB7613A46A00DCC79FBA8F3EA9730F
          AC7715AC7715AC7715A9720DBB903FFBFAF6DAC398C8A667A87009AC7715AC77
          15AC7715A8700AD0B27CC9A6669E6000D8C093C9A767A8710CAC7715AB7613A9
          720DE2D2B0A56C03AA7410F5EFE4A16500AA7512FAF8F3A46A00AC7715AC7715
          AC7715AC7715AC771500AC7715AC7715AB7614A76F08AA7410BC9244B4852EA5
          6C02AB7614AA7410B68934EEE6D3B4852EAA7410AC7715AC7715AC7715AC7715
          AA7410B88B38AB7613CDAE74D7BF90A76F08AC7715AC7715AC7715AB7512B282
          28B28127A97410EBDEC6A66D04AC7715AC7715AC7715AB7614A9720DB4852EF3
          EDDFD2B783A76F08AC7715AC7715AC7715AB7512B08023DFCCA7A66E05AA7511
          AC7715AB7614AC7715AC7715AB7614A8710BDFCBA7BD9447AA730FAA730FAB76
          14AC7715AC7715AB7614AB7614AD7919AC7716B78B38E1CFABA66E05AC7715AC
          7715AC7715A76F07DECAA4BC9346AD7B1BF2E9DBA56C02AC7715AC7715AC7715
          A8700AD2B784BF974CA9730EEFE5D3AB7613AB7512AC7715A9720CC5A15EF0E7
          D6A56B01A76F07E6D6B9BA8F3FB68832F8F3ECA46A00AC7715AC7715AC7715AC
          7715AC771500AC7715AC7715A9720DC59F5CE3D3B3D4B987D9C296D4B987A870
          0AAB7512B07E21D8BE91B4842CAA7511AC7715AC7715AC7715AC7715A8700AD3
          B884E3D2B2E9DBC1B68934AA730FAC7715AC7715AC7715A9730EBE954BE7D8BB
          E2D1AFC6A362A8710BAC7715AC7715AC7715AC7715AB7614A66E05CCAC70D1B4
          7DA8700AAC7715AC7715AC7715AB7512AE7B1CE4D4B4E2D1AFE3D2B1B98E3DAA
          7410AC7715AC7715AC7715AA7511AD7818D2B784E8DABFBB9141AA740FAC7715
          AC7715AB7614AB7613D3B986E4D3B3E2D1B0EADCC5A56C03AC7715AC7715AC77
          15AA7410B28126EDE2CDE6D6B9CFB179A77009AC7715AC7715AC7715AB7513A9
          730FE5D7B9E5D5B6D1B581A76E06AC7715AC7715AA7410B78A36DDC8A1A76F07
          AA730FB4842CEFE5D2E7D7BBCAAA6DA8700AAC7715AC7715AC7715AC7715AC77
          1500AC7715AC7715AA7411B3842CDDC7A0D3B885A46A00A46A00AC7715AC7715
          AB7512A76F08AA7511AC7715AC7715AC7715AC7715AC7715AC7715A8700AA66D
          05A56D03AA730FAC7715AC7715AC7715AC7715AC7715A9730EA66D05A66E05A8
          710BAC7715AC7715AC7715AC7715AC7715AC7715AC7715A8710AA8700AAC7715
          AC7715AC7715AC7715AC7715AB7512A66D04A66D05A66E06AA7410AC7715AC77
          15AC7715AC7715AC7715AB7512A87009A66D05AA740FAC7715AC7715AC7715AC
          7715AB7614A8700AA66D05A66D04A56C03AC7715AC7715AC7715AC7715AC7715
          AA7410A56C03A66D04A77009AC7715AC7715AC7715AC7715AC7715AB7513A66D
          05A66D04A77009AC7715AC7715AC7715AC7715AA7410A76F07AC7715AC7715AA
          7410A56C02A66D04A8700AAC7715AC7715AC7715AC7715AC7715AC771500AC77
          15AC7715AB7613AD7919B18025C49F5AEDE3CFC8A665A8710BB07913B07913B0
          7913B07913B07913B07913AC7714AC7715AC7715AE7814B07913B07913B07913
          B07913B07913AE7814AC7715AC7715AD7814B07913B07913B07913B07913B079
          13AE7814AC7715AC7715AC7714B07913B07913B07913B07913B07913AF7914AC
          7714AC7715AC7714B07913B07913B07913B07913B07913AF7914AC7714AC7715
          AD7714B27A13B37B13B37B13B37B13B37B13B17A13AC7714AC7715AD7714B27A
          13B37B13B37B13B37B13B37B13B17A13AC7714AC7715AC7715AF7914B37B13B3
          7B13B37B13B37B13B37B13AF7914AC7715AC7715AD7714B27A13B37B13B37B13
          B37B13B37B13B27A13AC7714AC7715AC7714B17A13B37B13B37B13B37B13B37B
          13B27A13AD7714AC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715
          AA7411B88C39CEB179CAAA6DCBAC70D6BC8CAC7715AC7715AC7715AC7715AC77
          15AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC
          7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715
          AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC77
          15AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC
          7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715
          AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC77
          15AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC
          7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715
          AC7715AC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715AA
          7411A8710BA8710BA8700AA77009C8A564C49F5AC49F5AC49F5AC49F5AC7A361
          B28025AC7715AC7715C8A564C49F5AC49F5AC49F5AC49F5AC7A361B28025AC77
          15AC7715C8A564C49F5AC49F5AC49F5AC49F5AC7A361B28025AC7715AC7715AC
          7715C8A564C49F5AC49F5AC49F5AC49F5AC7A361B28025AC7715AC7715C8A564
          C49F5AC49F5AC49F5AC49F5AC7A361B28025AC7715AC7715C8A564C49F5AC49F
          5AC49F5AC49F5AC7A361B28025AC7715AC7715AC7715C8A564C49F5AC49F5AC4
          9F5AC49F5AC7A361B28025AC7715AC7715C8A564C49F5AC49F5AC49F5AC49F5A
          C7A361B28025AC7715AC7715C8A564C49F5AC49F5AC49F5AC49F5AC7A361B280
          25AC7715AC7715AC7715C8A564C49F5AC49F5AC49F5AC49F5AC7A361B28025AC
          7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715AC7715AC77
          15AC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC
          7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC7715AC7715
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC7715AC7715AC7715FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC7715AC7715FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFC29C55AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC29C55AC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC29C55AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2
          9C55AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC7715
          AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC29C55AC7715AC77
          15AC7715AC7715AC7715AC771500AC7715AC7715AC7715AC7715AC7715AC7715
          AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC77
          15FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC7715FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC7715AC7715FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC7715FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFC0994FAC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0994FAC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C0994FAC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC77
          15AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC7715AC
          7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0994FAC7715AC7715AC7715
          AC7715AC7715AC771500AC7715AC7715AC7715AC7715AB7613A76F08AC7715AC
          7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFC1994FAC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFC1994FAC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC199
          4FAC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC
          7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715AC7715FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1994FAC7715AC7715AC7715AC7715AC
          7715AC771500AC7715AC7715AC7715AB7613AC7817D7BE8FA76F08AC7715FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC7715FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC39B52AC7715AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC39B52AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3
          9B52AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715
          AC7715AC7715FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC77
          15FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC7715FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC7715AC7715FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC39B52AC7715AC7715AC7715AC7715AC7715AC77
          1500AC7715AC7715AC7715AB7512AE7B1BFFFFFFA36900AC7715ABAAA8D9DADB
          D0D0D0C9C9C9C6C6C6B1B6C09F7018AC7715AC7715ABAAA8D9DADBD0D0D0C9C9
          C9C6C6C6B1B6C09F7018AC7715AC7715ABAAA8D9DADBD0D0D0C9C9C9C6C6C6B1
          B6C09F7018AC7715AC7715AC7715ABAAA8D9DADBD0D0D0C9C9C9C6C6C6B1B6C0
          9F7018AC7715AC7715ABAAA8D9DADBD0D0D0C9C9C9C6C6C6B1B6C09F7018AC77
          15AC7715ABAAA8D9DADBD0D0D0C9C9C9C6C6C6B1B6C09F7018AC7715AC7715AC
          7715ABAAA8D9DADBD0D0D0C9C9C9C6C6C6B1B6C09F7018AC7715AC7715ABAAA8
          D9DADBD0D0D0C9C9C9C6C6C6B1B6C09F7018AC7715AC7715ABAAA8D9DADBD0D0
          D0C9C9C9C6C6C6B1B6C09F7018AC7715AC7715AC7715ABAAA8D9DADBD0D0D0C9
          C9C9C6C6C6B1B6C09F7018AC7715AC7715AC7715AC7715AC7715AC771500AC77
          15AC7715AC7715AB7512AD7A1AFDFDFBA36900AC771589857FC4C5C7B7B7B7AF
          AFAFACACAC8D939D956507AC7715AC771589857FC4C5C7B7B7B7AFAFAFACACAC
          8D939D956507AC7715AC771589857FC4C5C7B7B7B7AFAFAFACACAC8D939D9565
          07AC7715AC7715AC771589857FC4C5C7B7B7B7AFAFAFACACAC8D939D956507AC
          7715AC771589857FC4C5C7B7B7B7AFAFAFACACAC8D939D956507AC7715AC7715
          89857FC4C5C7B7B7B7AFAFAFACACAC8D939D956507AC7715AC7715AC77158985
          7FC4C5C7B7B7B7AFAFAFACACAC8D939D956507AC7715AC771589857FC4C5C7B7
          B7B7AFAFAFACACAC8D939D956507AC7715AC771589857FC4C5C7B7B7B7AFAFAF
          ACACAC8D939D956507AC7715AC7715AC771589857FC4C5C7B7B7B7AFAFAFACAC
          AC8D939D956507AC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715
          AC7715AB7512AD7A1AFDFDFBA36900AC771588857FBCBDBFB2B2B2A9A9A9A5A5
          A5898E9998670AAC7715AC771588857FBCBDBFB2B2B2A9A9A9A5A5A5898E9998
          670AAC7715AC771588857FBCBDBFB2B2B2A9A9A9A5A5A5898E9998670AAC7715
          AC7715AC771588857FBCBDBFB2B2B2A9A9A9A5A5A5898E9998670AAC7715AC77
          1588857FBCBDBFB2B2B2A9A9A9A5A5A5898E9998670AAC7715AC771588857FBC
          BDBFB2B2B2A9A9A9A5A5A5898E9998670AAC7715AC7715AC771588857FBCBDBF
          B2B2B2A9A9A9A5A5A5898E9998670AAC7715AC771588857FBCBDBFB2B2B2A9A9
          A9A5A5A5898E9998670AAC7715AC771588857FBCBDBFB2B2B2A9A9A9A5A5A589
          8E9998670AAC7715AC7715AC771588857FBCBDBFB2B2B2A9A9A9A5A5A5898E99
          98670AAC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715AB
          7512AD7A1AFDFDFBA36900AC7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F
          99680CAC7715AC7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F99680CAC77
          15AC7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F99680CAC7715AC7715AC
          7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F99680CAC7715AC7715828079
          B3B3B5A7A7A79F9F9F9B9B9B7F858F99680CAC7715AC7715828079B3B3B5A7A7
          A79F9F9F9B9B9B7F858F99680CAC7715AC7715AC7715828079B3B3B5A7A7A79F
          9F9F9B9B9B7F858F99680CAC7715AC7715828079B3B3B5A7A7A79F9F9F9B9B9B
          7F858F99680CAC7715AC7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F9968
          0CAC7715AC7715AC7715828079B3B3B5A7A7A79F9F9F9B9B9B7F858F99680CAC
          7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715AB7512AD7A
          1AFDFDFBA36900AC77157D7A74A9AAAC9F9F9F979797929292777C879A690CAC
          7715AC77157D7A74A9AAAC9F9F9F979797929292777C879A690CAC7715AC7715
          7D7A74A9AAAC9F9F9F979797929292777C879A690CAC7715AC7715AC77157D7A
          74A9AAAC9F9F9F979797929292777C879A690CAC7715AC77157D7A74A9AAAC9F
          9F9F979797929292777C879A690CAC7715AC77157D7A74A9AAAC9F9F9F979797
          929292777C879A690CAC7715AC7715AC77157D7A74A9AAAC9F9F9F9797979292
          92777C879A690CAC7715AC77157D7A74A9AAAC9F9F9F979797929292777C879A
          690CAC7715AC77157D7A74A9AAAC9F9F9F979797929292777C879A690CAC7715
          AC7715AC77157D7A74A9AAAC9F9F9F979797929292777C879A690CAC7715AC77
          15AC7715AC7715AC7715AC771500AC7715AC7715AC7715AB7512AD7A1AFDFDFB
          A36900AC77157A7570A0A1A39696968E8E8E8989896F757F9A6A0DAC7715AC77
          157A7570A0A1A39696968E8E8E8989896F757F9A6A0DAC7715AC77157A7570A0
          A1A39696968E8E8E8989896F757F9A6A0DAC7715AC7715AC77157A7570A0A1A3
          9696968E8E8E8989896F757F9A6A0DAC7715AC77157A7570A0A1A39696968E8E
          8E8989896F757F9A6A0DAC7715AC77157A7570A0A1A39696968E8E8E8989896F
          757F9A6A0DAC7715AC7715AC77157A7570A0A1A39696968E8E8E8989896F757F
          9A6A0DAC7715AC77157A7570A0A1A39696968E8E8E8989896F757F9A6A0DAC77
          15AC77157A7570A0A1A39696968E8E8E8989896F757F9A6A0DAC7715AC7715AC
          77157A7570A0A1A39696968E8E8E8989896F757F9A6A0DAC7715AC7715AC7715
          AC7715AC7715AC771500AC7715AC7715AC7715AB7512AD7A1AFDFDFBA36900AC
          771573706A9596988B8B8B8484847F7F7F666B769C6B0EAC7715AC771573706A
          9596988B8B8B8484847F7F7F666B769C6B0EAC7715AC771573706A9596988B8B
          8B8484847F7F7F666B769C6B0EAC7715AC7715AC771573706A9596988B8B8B84
          84847F7F7F666B769C6B0EAC7715AC771573706A9596988B8B8B8484847F7F7F
          666B769C6B0EAC7715AC771573706A9596988B8B8B8484847F7F7F666B769C6B
          0EAC7715AC7715AC771573706A9596988B8B8B8484847F7F7F666B769C6B0EAC
          7715AC771573706A9596988B8B8B8484847F7F7F666B769C6B0EAC7715AC7715
          73706A9596988B8B8B8484847F7F7F666B769C6B0EAC7715AC7715AC77157370
          6A9596988B8B8B8484847F7F7F666B769C6B0EAC7715AC7715AC7715AC7715AC
          7715AC771500AC7715AC7715AC7715AA7410AC7816FDFDFBA26700AB75126E6B
          658C8D8F8383837C7C7C7676765E646E9C6C0FAC7715AC77156E6B658C8D8F83
          83837C7C7C7676765E646E9C6C0FAC7715AC77156E6B658C8D8F8383837C7C7C
          7676765E646E9C6C0FAC7715AC7715AC77156E6B658C8D8F8383837C7C7C7676
          765E646E9C6C0FAC7715AC77156E6B658C8D8F8383837C7C7C7676765E646E9C
          6C0FAC7715AC77156E6B658C8D8F8383837C7C7C7676765E646E9C6C0FAC7715
          AC7715AC77156E6B658C8D8F8383837C7C7C7676765E646E9C6C0FAC7715AC77
          156E6B658C8D8F8383837C7C7C7676765E646E9C6C0FAC7715AC77156E6B658C
          8D8F8383837C7C7C7676765E646E9C6C0FAC7715AC7715AC77156E6B658C8D8F
          8383837C7C7C7676765E646E9C6C0FAC7715AC7715AC7715AC7715AC7715AC77
          1500AC7715AC7715AB7512AF7B1DB28329FCFBF8A8720CB07F2269665F838486
          7B7B7B7373736D6D6D555A659D6D10AC7715AC771569665F8384867B7B7B7373
          736D6D6D555A659D6D10AC7715AC771569665F8384867B7B7B7373736D6D6D55
          5A659D6D10AC7715AC7715AC771569665F8384867B7B7B7373736D6D6D555A65
          9D6D10AC7715AC771569665F8384867B7B7B7373736D6D6D555A659D6D10AC77
          15AC771569665F8384867B7B7B7373736D6D6D555A659D6D10AC7715AC7715AC
          771569665F8384867B7B7B7373736D6D6D555A659D6D10AC7715AC771569665F
          8384867B7B7B7373736D6D6D555A659D6D10AC7715AC771569665F8384867B7B
          7B7373736D6D6D555A659D6D10AC7715AC7715AC771569665F8384867B7B7B73
          73736D6D6D555A659D6D10AC7715AC7715AC7715AC7715AC7715AC771500AC77
          15AC7715A8710BCAA96BFFFFFFFFFFFFFFFFFFD1B47F64605B797A7C70707069
          69696464644C515C9E6E11AC7715AC771564605B797A7C707070696969646464
          4C515C9E6E11AC7715AC771564605B797A7C7070706969696464644C515C9E6E
          11AC7715AC7715AC771564605B797A7C7070706969696464644C515C9E6E11AC
          7715AC771564605B797A7C7070706969696464644C515C9E6E11AC7715AC7715
          64605B797A7C7070706969696464644C515C9E6E11AC7715AC7715AC77156460
          5B797A7C7070706969696464644C515C9E6E11AC7715AC771564605B797A7C70
          70706969696464644C515C9E6E11AC7715AC771564605B797A7C707070696969
          6464644C515C9E6E11AC7715AC7715AC771564605B797A7C7070706969696464
          644C515C9E6E11AC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715
          AA7511AC7818F9F6F0FFFFFFFDFDFBB282275F5C567071736868686060605B5B
          5B4449549F6F12AC7715AC77155F5C567071736868686060605B5B5B4449549F
          6F12AC7715AC77155F5C567071736868686060605B5B5B4449549F6F12AC7715
          AC7715AC77155F5C567071736868686060605B5B5B4449549F6F12AC7715AC77
          155F5C567071736868686060605B5B5B4449549F6F12AC7715AC77155F5C5670
          71736868686060605B5B5B4449549F6F12AC7715AC7715AC77155F5C56707173
          6868686060605B5B5B4449549F6F12AC7715AC77155F5C567071736868686060
          605B5B5B4449549F6F12AC7715AC77155F5C567071736868686060605B5B5B44
          49549F6F12AC7715AC7715AC77155F5C567071736868686060605B5B5B444954
          9F6F12AC7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715A5
          6B02DAC397FFFFFFE2CFAEA76F075A56506566685F5F5F5757575151513B414B
          A07013AC7715AC77155A56506566685F5F5F5757575151513B414BA07013AC77
          15AC77155A56506566685F5F5F5757575151513B414BA07013AC7715AC7715AC
          77155A56506566685F5F5F5757575151513B414BA07013AC7715AC77155A5650
          6566685F5F5F5757575151513B414BA07013AC7715AC77155A56506566685F5F
          5F5757575151513B414BA07013AC7715AC7715AC77155A56506566685F5F5F57
          57575151513B414BA07013AC7715AC77155A56506566685F5F5F575757515151
          3B414BA07013AC7715AC77155A56506566685F5F5F5757575151513B414BA070
          13AC7715AC7715AC77155A56506566685F5F5F5757575151513B414BA07013AC
          7715AC7715AC7715AC7715AC7715AC771500AC7715AC7715AC7715AA730FB485
          2DFFFFFFB98D3BA9720D55514B5C5D5F5656564D4D4D484848333843A17114AC
          7715AC771555514B5C5D5F5656564D4D4D484848333843A17114AC7715AC7715
          55514B5C5D5F5656564D4D4D484848333843A17114AC7715AC7715AC77155551
          4B5C5D5F5656564D4D4D484848333843A17114AC7715AC771555514B5C5D5F56
          56564D4D4D484848333843A17114AC7715AC771555514B5C5D5F5656564D4D4D
          484848333843A17114AC7715AC7715AC771555514B5C5D5F5656564D4D4D4848
          48333843A17114AC7715AC771555514B5C5D5F5656564D4D4D484848333843A1
          7114AC7715AC771555514B5C5D5F5656564D4D4D484848333843A17114AC7715
          AC7715AC771555514B5C5D5F5656564D4D4D484848333843A17114AC7715AC77
          15AC7715AC7715AC7715AC771500AC7715AC7715AC7715AB7613AA7411E3D2B1
          A56C02AB7614504D465455574D4D4D4545454040402A303AA27215AC7715AC77
          15504D465455574D4D4D4545454040402A303AA27215AC7715AC7715504D4654
          55574D4D4D4545454040402A303AA27215AC7715AC7715AC7715504D46545557
          4D4D4D4545454040402A303AA27215AC7715AC7715504D465455574D4D4D4545
          454040402A303AA27215AC7715AC7715504D465455574D4D4D4545454040402A
          303AA27215AC7715AC7715AC7715504D465455574D4D4D4545454040402A303A
          A27215AC7715AC7715504D465455574D4D4D4545454040402A303AA27215AC77
          15AC7715504D465455574D4D4D4545454040402A303AA27215AC7715AC7715AC
          7715504D465455574D4D4D4545454040402A303AA27215AC7715AC7715AC7715
          AC7715AC7715AC771500AC7715AC7715AC7715AC7715AB7613A66D05AB7614AC
          77154A4741494A4B4343433C3C3C353535262B36A37216AC7715AC77154A4741
          494A4B4343433C3C3C353535262B36A37216AC7715AC77154A4741494A4B4343
          433C3C3C353535262B36A37216AC7715AC7715AC77154A4741494A4B4343433C
          3C3C353535262B36A37216AC7715AC77154A4741494A4B4343433C3C3C353535
          262B36A37216AC7715AC77154A4741494A4B4343433C3C3C353535262B36A372
          16AC7715AC7715AC77154A4741494A4B4343433C3C3C353535262B36A37216AC
          7715AC77154A4741494A4B4343433C3C3C353535262B36A37216AC7715AC7715
          4A4741494A4B4343433C3C3C353535262B36A37216AC7715AC7715AC77154A47
          41494A4B4343433C3C3C353535262B36A37216AC7715AC7715AC7715AC7715AC
          7715AC771500AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC77154542
          3C4041433A3A3A333333323232262B36A37316AC7715AC771545423C4041433A
          3A3A333333323232262B36A37316AC7715AC771545423C4041433A3A3A333333
          323232262B36A37316AC7715AC7715AC771545423C4041433A3A3A3333333232
          32262B36A37316AC7715AC771545423C4041433A3A3A333333323232262B36A3
          7316AC7715AC771545423C4041433A3A3A333333323232262B36A37316AC7715
          AC7715AC771545423C4041433A3A3A333333323232262B36A37316AC7715AC77
          1545423C4041433A3A3A333333323232262B36A37316AC7715AC771545423C40
          41433A3A3A333333323232262B36A37316AC7715AC7715AC771545423C404143
          3A3A3A333333323232262B36A37316AC7715AC7715AC7715AC7715AC7715AC77
          1500AC7715AC7715AC7715AC7715AC7715AC7715AC7715AC7715343535292F39
          282D35282C35282D351C2538A17216AC7715AC7715343535292F39282D35282C
          35282D351C2538A17216AC7715AC7715343535292F39282D35282C35282D351C
          2538A17216AC7715AC7715AC7715343535292F39282D35282C35282D351C2538
          A17216AC7715AC7715343535292F39282D35282C35282D351C2538A17216AC77
          15AC7715343535292F39282D35282C35282D351C2538A17216AC7715AC7715AC
          7715343535292F39282D35282C35282D351C2538A17216AC7715AC7715343535
          292F39282D35282C35282D351C2538A17216AC7715AC7715343535292F39282D
          35282C35282D351C2538A17216AC7715AC7715AC7715343535292F39282D3528
          2C35282D351C2538A17216AC7715AC7715AC7715AC7715AC7715AC771500AC77
          15AC7715AC7715AC7715AC7715AC7715AC7715AC77158B641C88631D89641D8A
          641D8A641D85611EA97615AA7512AC77158B641C88631D89641D8A641D8A641D
          85611EA97615A9730FAC77158B641C88631D89641D8A641D8A641D85611EA976
          15A9720EAB7614AC77158B641C88631D89641D8A641D8A641D85611EA97615AB
          7613AC77158B641C88631D89641D8A641D8A641D85611EA97615AB7613AC7715
          8B641C88631D89641D8A641D8A641D85611EA97615AB7613AC7715AB75128B64
          1C88631D89641D8A641D8A641D85611EA97615AC7715AC77158B641C88631D89
          641D8A641D8A641D85611EA97615AC7715AC77158B641C88631D89641D8A641D
          8A641D85611EA97615AB7613AC7715AB76138B641C88631D89641D8A641D8A64
          1D85611EA97615AC7715AC7715AC7715AC7715AC7715AC771500B57D16B57D16
          B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D
          16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B5
          7D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16
          B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D
          16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B5
          7D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16
          B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D
          16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B5
          7D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16B57D16
          B57D16B57D16B57D16B57D16B57D16B57D16B57D160053390A53390A53390A53
          390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A
          53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A5339
          0A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53
          390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A
          53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A5339
          0A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53
          390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A
          53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A5339
          0A53390A53390A53390A53390A53390A53390A53390A53390A53390A53390A53
          390A53390A53390A53390A53390A53390A00}
      end
      object fadenkreuz: TPanel
        Left = 8
        Top = 72
        Width = 226
        Height = 226
        BevelOuter = bvLowered
        TabOrder = 0
        Visible = False
        OnMouseDown = fadenkreuzMouseDown
        OnMouseMove = fadenkreuzMouseMove
        object vertical_line: TBevel
          Left = 113
          Top = 0
          Width = 1
          Height = 225
          Shape = bsLeftLine
        end
        object horizontal_line: TBevel
          Left = 0
          Top = 113
          Width = 225
          Height = 1
          Shape = bsTopLine
        end
        object PositionXY: TShape
          Left = 103
          Top = 103
          Width = 20
          Height = 20
          Brush.Color = clBlack
          Shape = stCircle
          OnMouseMove = PositionXYMouseMove
        end
      end
      object panmirror: TCheckBox
        Left = 80
        Top = 40
        Width = 97
        Height = 17
        Caption = 'Invertiere PAN'
        TabOrder = 1
        Visible = False
      end
      object tiltmirror: TCheckBox
        Left = 80
        Top = 56
        Width = 97
        Height = 17
        Caption = 'Invertiere TILT'
        TabOrder = 2
        Visible = False
      end
      object ColorPicker: TJvOfficeColorPanel
        Left = 17
        Top = 80
        Width = 152
        Height = 133
        SelectedColor = clDefault
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 3
        Visible = False
        Properties.ShowDefaultColor = False
        Properties.NoneColorCaption = 'No Color'
        Properties.DefaultColorCaption = 'Automatic'
        Properties.CustomColorCaption = 'Andere Farben...'
        Properties.NoneColorHint = 'No Color'
        Properties.DefaultColorHint = 'Automatic'
        Properties.CustomColorHint = 'Other Colors...'
        Properties.NoneColorFont.Charset = DEFAULT_CHARSET
        Properties.NoneColorFont.Color = clWindowText
        Properties.NoneColorFont.Height = -11
        Properties.NoneColorFont.Name = 'MS Sans Serif'
        Properties.NoneColorFont.Style = []
        Properties.DefaultColorFont.Charset = DEFAULT_CHARSET
        Properties.DefaultColorFont.Color = clWindowText
        Properties.DefaultColorFont.Height = -11
        Properties.DefaultColorFont.Name = 'MS Sans Serif'
        Properties.DefaultColorFont.Style = []
        Properties.CustomColorFont.Charset = DEFAULT_CHARSET
        Properties.CustomColorFont.Color = clWindowText
        Properties.CustomColorFont.Height = -11
        Properties.CustomColorFont.Name = 'MS Sans Serif'
        Properties.CustomColorFont.Style = []
      end
      object ColorBox: TJvColorComboBox
        Left = 8
        Top = 72
        Width = 145
        Height = 22
        ColorNameMap.Strings = (
          'clBlack=Black'
          'clMaroon=Maroon'
          'clGreen=Green'
          'clOlive=Olive green'
          'clNavy=Navy blue'
          'clPurple=Purple'
          'clTeal=Teal'
          'clGray=Gray'
          'clSilver=Silver'
          'clRed=Red'
          'clLime=Lime'
          'clYellow=Yellow'
          'clBlue=Blue'
          'clFuchsia=Fuchsia'
          'clAqua=Aqua'
          'clWhite=White'
          'clMoneyGreen=Money green'
          'clSkyBlue=Sky blue'
          'clCream=Cream'
          'clMedGray=Medium gray'
          'clScrollBar=Scrollbar'
          'clBackground=Desktop background'
          'clActiveCaption=Active window title bar'
          'clInactiveCaption=Inactive window title bar'
          'clMenu=Menu background'
          'clWindow=Window background'
          'clWindowFrame=Window frame'
          'clMenuText=Menu text'
          'clWindowText=Window text'
          'clCaptionText=Active window title bar text'
          'clActiveBorder=Active window border'
          'clInactiveBorder=Inactive window border'
          'clAppWorkSpace=Application workspace'
          'clHighlight=Selection background'
          'clHighlightText=Selection text'
          'clBtnFace=Button face'
          'clBtnShadow=Button shadow'
          'clGrayText=Dimmed text'
          'clBtnText=Button text'
          'clInactiveCaptionText=Inactive window title bar text'
          'clBtnHighlight=Button highlight'
          'cl3DDkShadow=Dark shadow 3D elements'
          'cl3DLight=Highlight 3D elements'
          'clInfoText=Tooltip text'
          'clInfoBk=Tooltip background'
          'clGradientActiveCaption=Gradient Active Caption'
          'clGradientInactiveCaption=Gradient Inactive Caption'
          'clHotLight=Hot Light'
          'clMenuBar=Menu Bar'
          'clMenuHighlight=Menu Highlight')
        ColorDialogText = 'Custom...'
        DroppedDownWidth = 145
        NewColorText = 'Custom'
        TabOrder = 4
        Visible = False
        OnChange = ColorBoxChange
      end
      object ColorBox2: TJvColorComboBox
        Left = 8
        Top = 96
        Width = 145
        Height = 22
        ColorNameMap.Strings = (
          'clBlack=Black'
          'clMaroon=Maroon'
          'clGreen=Green'
          'clOlive=Olive green'
          'clNavy=Navy blue'
          'clPurple=Purple'
          'clTeal=Teal'
          'clGray=Gray'
          'clSilver=Silver'
          'clRed=Red'
          'clLime=Lime'
          'clYellow=Yellow'
          'clBlue=Blue'
          'clFuchsia=Fuchsia'
          'clAqua=Aqua'
          'clWhite=White'
          'clMoneyGreen=Money green'
          'clSkyBlue=Sky blue'
          'clCream=Cream'
          'clMedGray=Medium gray'
          'clScrollBar=Scrollbar'
          'clBackground=Desktop background'
          'clActiveCaption=Active window title bar'
          'clInactiveCaption=Inactive window title bar'
          'clMenu=Menu background'
          'clWindow=Window background'
          'clWindowFrame=Window frame'
          'clMenuText=Menu text'
          'clWindowText=Window text'
          'clCaptionText=Active window title bar text'
          'clActiveBorder=Active window border'
          'clInactiveBorder=Inactive window border'
          'clAppWorkSpace=Application workspace'
          'clHighlight=Selection background'
          'clHighlightText=Selection text'
          'clBtnFace=Button face'
          'clBtnShadow=Button shadow'
          'clGrayText=Dimmed text'
          'clBtnText=Button text'
          'clInactiveCaptionText=Inactive window title bar text'
          'clBtnHighlight=Button highlight'
          'cl3DDkShadow=Dark shadow 3D elements'
          'cl3DLight=Highlight 3D elements'
          'clInfoText=Tooltip text'
          'clInfoBk=Tooltip background'
          'clGradientActiveCaption=Gradient Active Caption'
          'clGradientInactiveCaption=Gradient Inactive Caption'
          'clHotLight=Hot Light'
          'clMenuBar=Menu Bar'
          'clMenuHighlight=Menu Highlight')
        ColorDialogText = 'Custom...'
        DroppedDownWidth = 145
        NewColorText = 'Custom'
        TabOrder = 5
        Visible = False
        OnChange = ColorBox2Change
      end
      object ColorPicker2: THSLRingPicker
        Left = 16
        Top = 80
        Width = 137
        Height = 129
        RingPickerHintFormat = 'Hue: %h'
        SLPickerHintFormat = 'S: %hslS L: %l'#13'Hex: %hex'
        Visible = False
        TabOrder = 6
        OnChange = OwnColorPickerChange
      end
    end
  end
  object TBImageList1: TTBImageList
    Left = 488
    Top = 72
    Bitmap = {
      494C010112001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      00000000000000000000000000000000000000000000D5D5D500D1D1D100D1D1
      D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1
      D100D1D1D100D1D1D100D1D1D100DADADA0000000000AC761400AB751200B17E
      2100B2812700AB751200AC761400AD7A1A00AC771700AC771400AB761400AE7A
      1B00B4852D00AB771400AC771500AC7613000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ABABAB00909090008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D00898989008989890085858500838383008383
      8300808080007A7A7A008E8E8E00D1D1D100C8A66500A9710C0000000000C9A6
      6700CAA96B00B07D2000A9720C00B7893400BE954A00A9720D00A9720D00C19A
      5200D0B27C00B88B3900AA730E00AA730F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009393930000A0340000A4330000A0
      320000A4330000A0320000A4330000A0320000A4330000A0320000A4330000A0
      320000A43300009C33007A7A7A00D1D1D100BB914100A9730E00AD7A1A00D0B4
      7E00C39D5600AC771600AB761300AE7A1B00C8A66700B07E2100A8700900C099
      4F00D9C39800B7893500A76F0700B78935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009393930000AB350000A0340000A4
      360000A0320000A4330000A0320000A4330000A0340000A4360000A0340000A4
      360000A0340000A4330080808000D1D1D100B5872F00AB751200AA740F00B686
      2F00BA8C3900AB751100AB741100B7893200C6A05B00B17F2100A9730D00B482
      2800C49F5800B17F2200AA741000AE7A1A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009393930000AB340000B13A0000AB
      380000B13A0000AB380000B13A0000AB380000B13A0000AB380000B13A0026B3
      540000B13A0000A0320083838300D1D1D100AC751000AC781500AD781600AD75
      0F00AC750F00AD781500AD781600AD761000AB720900AD771300AC781600AD76
      1100AB720900AE771200AC771600AD7714000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009696960000B93D0000B33B0000B9
      3D0000B33B0000B93D0000B33B0000B93D0014B7490043B7520070C1650085C3
      690044B6480000B53B0089898900D1D1D100E7D8BC00B07E2200D8BF9100F0E6
      D500EBDEC600B6873100B5852E00ECE0CA00F0E6D400D7BD8E00B17F2200E8DA
      BF00F0E5D400DEC8A100AF7B1D00E3D2B1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000096969600C4BB5E0074AC4C0000B3
      3B0000B93D0000B33B0000B93D007DB05900C4BB5E00FCC87500FCC87500F9CA
      7E00FFC66B00C4BB5E0089898900D1D1D100F9F4ED00B2812500E5D4B500FFFF
      FF00FDFCFA00B98D3A00B7893400FFFFFF00FFFFFF00E4D2B200B2812600FAF6
      F000FFFFFF00EDE1CA00B07D1F00F3ECDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000096969600FFCB7700FFC66B00D2BE
      6100AFB75900B3BA6500D4C37600FFC66B00FFC66B00FCC16100F9BD5800F9BD
      5800F4BB5700F9BD58008D8D8D00D1D1D100B5B1AA00A4701100B6A58600CFD3
      DA00B8B7B600A6771F00AA7C2700C5C5C500C9CDD500AC997700A6731400C1BE
      B800CCD0D700AEA28B00A5700E00BEB6A9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900FFD28A00FFCB7700FCD3
      9100FCC87500FFC66B00FCC87500FCC87500FCCC8200FFD08500FFD08500FFCB
      7900F9C36A00F9BD58008D8D8D00D1D1D1008E8A8300A16C0B009D8C6B00A9AD
      B4008F8E8E009F6F1600A4762000A2A1A000A1A6AE008F7C5900A36F0F00A09C
      9500A5A9B1008D806900A36D09009E9688000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900FFC66B00FCD39100FFCB
      7700FFD59400FFC66B00FFD38A00FCDEAB00FFE0AF00FCDFB000FFDFAC00FCDF
      B000FFD79800FFD99C008D8D8D00D1D1D100807C7500A36F0D00958363009699
      A100807F7F00A0701700A4762000929291008E929A0087745100A5711100928E
      880091959C0083775F00A5700C00938B7C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000099999900FFC66B00FCC87500FFC6
      6B00FFC66B00FFC66B00FFC66B00FFE6BE00FCF6EE00F9F3EC00FCF6EE00FFF9
      F000FFE9CD00FFE1B0008D8D8D00D1D1D1006F6B6400A4700F008A7858008083
      8B006D6D6C009F701700A3751F0080807F00777B84007C694600A6731300817E
      77007A7E860076695200A7720E00837C6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FFDDA500FCD69B00FFE6
      BE00FFE6BE00FFE6BE00FFD69500FFD08500FFDFAC00FCDFB000FFDFAC00FFDF
      AC00FFD99D00FFDBA1008D8D8D00D1D1D1005E5A5300A6711000806E4E006A6D
      75005A5A59009F6F1600A2741E006E6E6D0061656D00715E3B00A7741400716E
      670064687000685C4400A9731000756D5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FFD99C00FFEED200FCF9
      F400FCFBF900FFFEFC00FFEED200FCDCA600FCCF8900FFD08500FFD08500FFCB
      7900FFC66B00F6B950008D8D8D00D1D1D1004C494100A7731200756343005357
      5E00474746009F6F1600A1721D005C5B5A00494E560066543000A9751500615D
      56004C5058005B4F3700AB761200675E50000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C00FFC66B00FFD89B00FFE6
      BE00FFE6BE00FCE5C100FCE2B900FFE8C100FCCF8400FCCA7800FCC16100FCC1
      6100F4B54900EEAC37008D8D8D00D1D1D10039373400A975140066563900363C
      4800313336009E6F17009F711C00444649002D3440005A492900AA7617004B49
      4600303642004C412D00AD771400534D42000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009E9E9E00FCC16100F6B95000F6B9
      5000F6B95000F2B24200F6B95000F6B95000F4B84F00F2B24200EEAC3700ECAA
      3200EEAC3700ECAA320090909000E7E7E70058482B00B17B1500745A28004B42
      300052452C00A8761800A77519005549300049402E0073582400B17B17005B4C
      2F004A412F0068512700B47D160063512D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF009E9E9E009C9C9C009A9A
      9A009A9A9A009A9A9A0096969600969696009696960096969600969696009393
      93009393930093939300A3A3A30000000000895E1000885E1100885E1000895E
      1000895E1000885E1100885E1000885E1000895E1000895E1000885E1100885E
      1000895E1000895E1000885E1100885E10000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DCDCDC00D0D0
      D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0
      D000D0D0D000DCDCDC0000000000000000000000000000000000C0686000B058
      5000A0505000A0505000A0505000904850009048400090484000804040008038
      4000803840007038400070383000000000000000000000000000000000006048
      3000604830006048300060483000604830006048300060483000604830006048
      3000604830000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006D1705000000000000000000000000000000
      00000000000000000000000000000000000000000000C4C4C400888888007070
      7000707070007070700070707000707070007070700070707000707070007070
      70007070700088888800C4C4C4000000000000000000D0687000F0909000E080
      8000B048200040302000C0B8B000C0B8B000D0C0C000D0C8C00050505000A040
      3000A0403000A03830007038400000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000604830000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B88077000000000000000000000000000000
      000000000000000000000000000000000000DCDCDC000C72A5000C72A5000C72
      A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72
      A5000C72A5006464640088888800DCDCDC0000000000D0707000FF98A000F088
      8000E0808000705850004040300090787000F0E0E000F0E8E00090807000A040
      3000A0404000A04030008038400000000000000000000000000000000000FFFF
      FF00FFFFFF00FFF8FF00F0F0F000F0E8E000F0E0D000E0D0D000E0C8C0000000
      0000604830000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B67E73000000000000000000000000000000
      000000000000000000000000000000000000189AC6001B9CC7009CFFFF006BD7
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF002899BF000C72A50070707000D0D0D00000000000D0787000FFA0A000F090
      9000F0888000705850000000000040403000F0D8D000F0E0D00080786000B048
      4000B0484000A04040008040400000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFF8F000F0F0F000F0E0E000F0D8D000E0D0C0000000
      0000604830000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B67E73000000000000000000000000000000
      000000000000000000000000000000000000189AC600199AC60079E4F0009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE00197A9D0064646400B8B8B80000000000D0788000FFA8B000FFA0
      A000F0909000705850007058500070585000705850007060500080686000C058
      5000B0505000B04840008040400000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF0F000F0E8E000F0E0E000E0D8D0000000
      0000604830000000000000000000000000000000000000000000000000000000
      00001F7D30005AE0780000000000B67E73000000000000000000000000000000
      000000000000000000000000000000000000189AC60025A2CF003FB8D7009CFF
      FF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084E7
      FF0042BAEF00189AC600646464008888880000000000E0808000FFB0B000FFB0
      B000FFA0A000F0909000F0888000E0808000E0788000D0707000D0687000C060
      6000C0585000B050500090484000000000000000000000000000C0A89000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0F000F0E8E000F0D8D0000000
      0000604830000000000000000000000000000000000000000000000000000000
      000000000000000000009BE2AE00B37F73000000000000000000000000000000
      000000000000000000007373D70000000000189AC60042B3E20020A0C900A5FF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7
      FF0052BEE7005BBCCE000C72A5007070700000000000E0889000FFB8C000FFB8
      B000D0606000C0605000C0585000C0504000B0503000B0483000A0402000A038
      1000C0606000C058500090484000000000000000000000000000C0A8A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0E8E000F0E0E0000000
      0000604830000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004C7F230000000000000000004546B1000202
      9F000C0BA1007779C4007373DA0000000000189AC6006FD5FD00189AC60089F0
      F7009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF005AC7FF0096F9FB00187A9B007070700000000000E0909000FFC0C000D068
      6000FFFFFF00FFFFFF00FFF8F000F0F0F000F0E8E000F0D8D000E0D0C000E0C8
      C000A0381000C060600090485000000000000000000000000000C0B0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8FF00F0F0F000F0E8E0000000
      0000604830000000000000000000000000000000000000000000000000000000
      00007374BD000C0BA0000503A10060464700387C890000000000000000000000
      000000000000000000000000000000000000189AC60084D7FF00189AC6006BBF
      DA000000000000000000F7FBFF00000000000000000000000000000000000000
      000084E7FF0000000000187DA1008888880000000000E098A000FFC0C000D070
      7000FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0F000F0E8E000F0D8D000E0D0
      C000A0402000D0686000A0505000000000000000000000000000D0B0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0F0000000
      00006048300000000000000000000000000000003A002323AD009696CE000000
      0000000000000000000000000000B680730000000000A0E6B000000000000000
      000000000000000000000000000000000000189AC60084EBFF004FC1E200189A
      C600189AC600189AC600189AC600189AC600189AC600189AC600189AC600189A
      C600189AC600189AC6001889B100C4C4C40000000000F0A0A000FFC0C000E078
      7000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0F000F0E8E000F0D8
      D000B0483000D0707000A0505000000000000000000000000000D0B8A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000604830000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B77F730000000000000000005BC672000000
      000000000000000000000000000000000000189AC6009CF3FF008CF3FF008CF3
      FF008CF3FF008CF3FF008CF3FF00000000000000000000000000000000000000
      0000189AC600197A9D00C4C4C4000000000000000000F0A8A000FFC0C000E080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0F000F0E8
      E000B0503000E0788000A0505000000000000000000000000000D0B8B000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000604830006048
      3000604830000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B67E7300000000000000000044A453000000
      000000000000000000000000000000000000189AC600000000009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000189AC600189AC600189AC600189AC600189A
      C600189AC600DCDCDC00000000000000000000000000F0B0B000FFC0C000F088
      9000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8F000F0F0
      F000C050400060303000B0585000000000000000000000000000D0C0B000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0A89000D0C8C0006048
      3000E0CBC2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B67E73000000000000000000000000000000
      0000000000000000000000000000000000000000000021A2CE00000000000000
      00000000000000000000189AC600C4C4C4000000000000000000000000000000
      00000000000000000000000000000000000000000000F0B0B000FFC0C000FF90
      9000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF8
      F000C0585000B0586000B0586000000000000000000000000000E0C0B000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0A8A00060483000E0CC
      C300F6F1F1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B77E73000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A2CE0021A2
      CE0021A2CE0021A2CE00DCDCDC00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0B8B000F0B8B000F0B0
      B000F0B0B000F0A8B000F0A0A000E098A000E0909000E0909000E0889000E080
      8000D0788000D0787000D0707000000000000000000000000000E0C0B000E0C0
      B000E0C0B000E0C0B000E0C0B000D0C0B000D0B8B000D0B0A000E0CCC300F7F2
      F200F7F2F2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B56D5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AA7469000000000000000000000000000000
      00000000000000000000000000000000000000000000D5D5D500D1D1D100D1D1
      D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1D100D1D1
      D100D1D1D100D1D1D100D1D1D100DADADA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFDFB00F3FA
      F500F3FAF500FBFDFB00FBFDFB00000000000000000000000000000000000000
      0000EDF2ED00E5EDE500D1DFD100D1DFD100D1DFD100D1DFD100E4ECE400F6F8
      F60000000000000000000000000000000000ABABAB00909090008D8D8D008D8D
      8D008D8D8D008D8D8D008D8D8D00898989008989890085858500838383008383
      8300808080007A7A7A008E8E8E00D1D1D1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFDFB00CCEAD5008CCF
      A2009FD7B100F3FAF500FBFDFB0000000000000000000000000000000000E9EF
      E90086D89F0000B93D0000B93D0000B93D0000B93D0000B93D0075CC8E00D2E1
      D300F6F8F6000000000000000000000000009393930000A0340000A4330000A0
      320000A4330000A0320000A4330000A0320000A4330000A0320000A4330000A0
      320000A43300009C33007A7A7A00D1D1D100FBFAFA00F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500FBFAFA000000000000000000000000000000
      000000000000000000000000000000000000FBFDFB00CCEAD50056B976000096
      3100A4D9B500F7FBF800FBFDFB00000000000000000000000000E9EFE90000B9
      3D0000B93D0032C3600034BE610034BE610025B9560012B9490000B93D0000B9
      3D00D1DFD100F3F6F30000000000000000009393930000AB350000A0340000A4
      360000A0320000A4330000A0320000A4330000A0340000A4360000A0340000A4
      360000A0340000A4330080808000D1D1D100FBFAFA00B0A199009C8980009C89
      80009C8980009C8980009C8980009C8980009C8980009C8980009C8980009C89
      80009C8980009C898000B0A19900F7F5F5000000000000000000000000000000
      0000000000000000000000000000FBFDFB00DBF0E100A3D9B4000096310056B9
      7600B9E2C600F7FBF800000000000000000000000000F2F6F20000B93D002BC5
      5B0035C962003ACC660037C5630034BE610032B95F0032B95F0014B94A0017B9
      4D0000B93D00D1DFD100F6F8F600000000009393930000AB340000B13A0000AB
      380000B13A0000AB380000B13A0000AB380000B13A0000AB380000B13A0026B3
      540000B13A0000A0320083838300D1D1D100F7F5F5009C898000ECE8E600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009C898000F7F5F5000000000000000000000000000000
      000000000000FBFDFB00EEF8F100DBF0E100B9E2C6004EB6700000963100A3D9
      B400E4F3E900FBFDFB000000000000000000F2F6F20000B93D002CCA5C003FD9
      6A003CD268003ACC66003ACC660037C5630034BE610032B95F0032B95F0025B9
      560007B9410000B93D00D2E1D300F5F8F5009696960000B93D0000B33B0000B9
      3D0000B33B0000B93D0000B33B0000B93D0014B7490043B7520070C1650085C3
      690044B6480000B53B0089898900D1D1D100F7F5F5009C898000E4DEDB00E2C6
      B800A44D2300A44D2300FFFFFF00A9552D00A9552D00C8A5940010101000BBBB
      BB0010101000BBBBBB009C898000F7F5F5000000000000000000000000000000
      000000000000FBFDFB00DEF1E400C0E5CC004EB67000009631004EB67000C9E8
      D300F7FBF80000000000000000000000000099DCAD0000B93D003AD8660042E0
      6D003FD96A003CD268003ACC66003ACC660037C5630034BE610032B95F0032B9
      5F0025B9560000B93D0062C57F00E4ECE40096969600C4BB5E0074AC4C0000B3
      3B0000B93D0000B33B0000B93D007DB05900C4BB5E00FCC87500FCC87500F9CA
      7E00FFC66B00C4BB5E0089898900D1D1D100F7F5F5009C898000E4DEDB00A44D
      2300FFFFFF00A44D2300FFFFFF00A9552D00D8B2A000A9552D00ECECEC001010
      1000DADADA00FFFFFF009C898000F7F5F5000000000000000000000000000000
      000000000000EEF8F100C3E6CE008DD0A200009631004EB67000AFDEBE00E8F5
      EC00F4FAF6000000000000000000000000001AB94F0037DC630044E66F0042E0
      6D003FD96A003FD96A003CD268003ACC66003ACC660037C5630034BE610032B9
      5F0032B95F001BB94F0000B93D00D1DFD10096969600FFCB7700FFC66B00D2BE
      6100AFB75900B3BA6500D4C37600FFC66B00FFC66B00FCC16100F9BD5800F9BD
      5800F4BB5700F9BD58008D8D8D00D1D1D100F7F5F5009C898000E4DEDB00E2C6
      B800A44D2300A44D2300FFFFFF00A9552D00EAD5CB00A9552D00FFFFFF001010
      1000FFFFFF00FFFFFF009C898000F7F5F5000000000000000000000000000000
      0000FBFDFB00DEF1E400ABDCBB0044B26700009631008ACEA000DCF0E200F4FA
      F600000000000000000000000000000000001FB9520044EA6E0047ED710044E6
      6F0042E06D003FD96A003FD96A003CD268003ACC660037C5630037C5630034BE
      610032B95F0025B9560000B93D00D1DFD10099999900FFD28A00FFCB7700FCD3
      9100FCC87500FFC66B00FCC87500FCC87500FCCC8200FFD08500FFD08500FFCB
      7900F9C36A00F9BD58008D8D8D00D1D1D100F7F5F5009C898000E4DEDB00F5F5
      F500E2C6B800A44D2300FFFFFF00A9552D00A9552D00CE9E8700FFFFFF001010
      1000FFFFFF00FFFFFF009C898000F7F5F5000000000000000000000000000000
      0000EAF6EE00CFEBD80049B46B00009631003DAF6200BAE2C700EBF6EE000000
      0000000000000000000000000000000000001FB952005BF1810047ED710047ED
      710044E66F0042E06D003FD96A003FD96A003CD268003ACC660037C5630037C5
      630034BE610032B95F0000B93D00D1DFD10099999900FFC66B00FCD39100FFCB
      7700FFD59400FFC66B00FFD38A00FCDEAB00FFE0AF00FCDFB000FFDFAC00FCDF
      B000FFD79800FFD99C008D8D8D00D1D1D100F7F5F5009C898000E4DEDB00CD9D
      8500BE7F6000E2C6B800FFFFFF00A9552D00D8B2A000FFFFFF00ECECEC001010
      1000DADADA00FFFFFF009C898000F7F5F500000000000000000000000000FBFD
      FB00D2ECDA00A2D8B300009631003EAF6300A2D8B300DBF0E100F7FBF8000000
      00000000000000000000000000000000000026B9570066E989005BF1810047ED
      710044E66F0044E66F0042E06D003FD96A003FD96A003CD268003ACC660037C5
      630037C5630034BE610000B93D00D1DFD10099999900FFC66B00FCC87500FFC6
      6B00FFC66B00FFC66B00FFC66B00FFE6BE00FCF6EE00F9F3EC00FCF6EE00FFF9
      F000FFE9CD00FFE1B0008D8D8D00D1D1D100F7F5F5009C898000E4DEDB00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A9552D00FFFFFF00DADADA0010101000CACA
      CA0010101000BBBBBB009C898000F7F5F500000000000000000000000000F7FB
      F800B9E2C6004AB46C00009631008ED0A300D5EDDD00F8FCF900000000000000
      0000000000000000000000000000000000002BB95A005CDC800076F395005BF1
      810047ED710044E66F0044E66F0042E06D003FD96A003CD268003CD268003ACC
      660037C5630026BD570000B93D00E0E9E0009A9A9A00FFDDA500FCD69B00FFE6
      BE00FFE6BE00FFE6BE00FFD69500FFD08500FFDFAC00FCDFB000FFDFAC00FFDF
      AC00FFD99D00FFDBA1008D8D8D00D1D1D100F7F5F5009C898000E4DEDB00ECE8
      E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8
      E600ECE8E600ECE8E6009C898000F7F5F5000000000000000000F3FAF500E6F4
      EA004EB670000096310050B67100BEE4CA00EEF8F10000000000000000000000
      00000000000000000000000000000000000099DCAD002DB95B0076F3950076F3
      95005BF1810047ED710044E66F0044E66F0042E06D003FD96A003CD268003CD2
      68002BC75B0000B93D006ACD8800EDF2ED009A9A9A00FFD99C00FFEED200FCF9
      F400FCFBF900FFFEFC00FFEED200FCDCA600FCCF8900FFD08500FFD08500FFCB
      7900FFC66B00F6B950008D8D8D00D1D1D100F7F5F500B0A199009C8980009C89
      80009C8980009C8980009C8980009C8980009C8980009C8980009C8980009C89
      80009C8980009C898000B0A19900F7F5F5000000000000000000EEF8F100BAE2
      C7000096310044B26700BCE3C800EEF8F1000000000000000000000000000000
      000000000000000000000000000000000000F2F6F2002DB95B006CDE8C0076F3
      95005BF181005BF1810047ED710044E66F0044E66F0042E06D003FD96A003CD2
      680011C0490000B93D00EDF3ED00F8FAF8009C9C9C00FFC66B00FFD89B00FFE6
      BE00FFE6BE00FCE5C100FCE2B900FFE8C100FCCF8400FCCA7800FCC16100FCC1
      6100F4B54900EEAC37008D8D8D00D1D1D100FBFAFA00F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500FBFAFA0000000000F8FCF900D4EDDC0064BF
      810000963100A6DAB700DCF0E200000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F2F6F20032B95F006CDE
      8C0070EE900056EB7C005BF1810047ED710044E66F0030D6600030D6600012C2
      4A0000B93D00EFF4EF00F8FAF800000000009E9E9E00FCC16100F6B95000F6B9
      5000F6B95000F2B24200F6B95000F6B95000F4B84F00F2B24200EEAC3700ECAA
      3200EEAC3700ECAA320090909000E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8FCF900BAE2C70025A5
      4E006EC38900CFEBD80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F2F6F20030B9
      5D0029B9590058D87C004FE475005BF1810034DF630025D1580000B93D0000B9
      3D00EFF4EF00000000000000000000000000AFAFAF009E9E9E009C9C9C009A9A
      9A009A9A9A009A9A9A0096969600969696009696960096969600969696009393
      93009393930093939300A3A3A300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8F5EC00BAE2
      C700E8F5EC000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F2F6
      F20099DCAD0030B95D002DB95B002BB95A0026B957001FB9520099DCAD00F2F6
      F200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3E9E400F3E9E400F3E9E400F3E9E400F3E9E400F9F3F1000000
      00000000000000000000000000000000000000000000F3F3F300E5E5E500E5E5
      E500E5E5E50000000000F3F3F300E5E5E500E5E5E500E5E5E50000000000F3F3
      F300E5E5E500E5E5E500E5E5E500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3E9
      E400E0C2B4009734040097340400973404009734040097340400DCBAAA00EEDF
      D800F9F3F100000000000000000000000000F3F3F300B9B9B900B9B9B900B9B9
      B900B9B9B900E5E5E500B9B9B900B9B9B900B9B9B900B9B9B900E5E5E500B9B9
      B900B9B9B900B9B9B900BCBCBC00E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0C2B4009734
      040097340400E0C2B300F4E9E400FCFCFC00F4E9E400E0C2B300973404009734
      0400E0C2B400000000000000000000000000F3F3F30074747400FF00FF00E51B
      E500B9B9B900E5E5E5007474740000FFAA001BE5A100B9B9B900E5E5E5007474
      7400FFAA0000E5A11B00B9B9B900E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0C2B40097340400E0C2
      B300F4E9E400F7F7F700FAFAFA00FAFAFA00FCFCFC00FFFFFF00F4E9E400E0C2
      B30097340400E0C2B400F9F3F10000000000F3F3F30074747400FF72FF00FF00
      FF00B9B9B900E5E5E5007474740072FFD00000FFAA00B9B9B900E5E5E5007474
      7400FFD07200FFAA0000B9B9B900E5E5E50000000000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000E3E3E300E3E3E300E3E3
      E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3
      E300E3E3E300E3E3E300E3E3E300F0F0F000F3E9E40097340400E0C2B300F2F2
      F200F5F5F500F5F5F500F7F7F700FAFAFA00FAFAFA00FCFCFC00FFFFFF00FFFF
      FF00E0C2B30097340400EEDFD80000000000F3F3F30074747400747474007474
      740074747400F3F3F30074747400747474007474740074747400F3F3F3007474
      740074747400747474007B7B7B00F3F3F300E2D6BF00C6AE8000C6AE8000C6AE
      8000C6AE8000C6AE8000EFE5D300FDF8EF00FDF8EF00EFE5D300C6AE8000C6AE
      8000C6AE8000C6AE8000C6AE8000D4CAB900A7A7A7006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E00A7A7A700E0C2B40097340400F2E9E400F0F0
      F000F2F2F20097DE970000B9000000B9000000B9000075D87500FCFCFC00FCFC
      FC00F4E9E40097340400DCBAAA00F9F3F10000000000F3F3F300E5E5E500E5E5
      E500E5E5E50000000000F3F3F300E5E5E500E5E5E500E5E5E50000000000F3F3
      F300E5E5E500E5E5E500E5E5E50000000000C6AE8000F6D8AD00FBC57F00FBC5
      7F00FBC57F00F4C27F00C6AE8000FDF8EF00FDF8EF00C6AE8000F6D8AD00FBC5
      7F00FBC57F00FBC57F00F4C27F00AFA081006E6E6E009D9D9D0061AF7A0061AF
      7A00E4E4E40061AF7A0061AF7A00E4E4E40061AF7A0061AF7A00E4E4E400E4E4
      E400E4E4E400E4E4E400AFAFAF006E6E6E0097340400CD9D8400E8E3E000F0F0
      F00093DB930000C61C0000C2130000BC070000BC070000B9000075D87500FCFC
      FC00FCFCFC00E0C2B30097340400F9F3F100F3F3F300B9B9B900B9B9B900B9B9
      B900B9B9B900E5E5E500B9B9B900B9B9B900B9B9B900BCBCBC00E5E5E500B9B9
      B900B9B9B900B9B9B900B9B9B900E5E5E500C6AE8000FDE5C400FCD8AA00A064
      2A00A0642A00FCD8AA00C6AE8000FBF4E700FBF4E700C6AE8000FDE5C400A064
      2A00A0642A00FCD8AA00FCD8AA00AFA081006E6E6E00C4C4C40006E24B0025FF
      5700F2F2F20006E24B0025FF5700F2F2F20006E24B0025FF5700F2F2F200F2F2
      F200F2F2F200F2F2F200E4E4E4006E6E6E0097340400E0C1B300E6E1DE00EDED
      ED0000C61C0000CD2A001FD23B0000C2130000C2130000BC070000B90000FAFA
      FA00FAFAFA00F4E9E40097340400F9F3F100F3F3F30074747400FFFF0000E5E5
      1B00B9B9B900E5E5E50074747400FF000000E51B1B00B9B9B900E5E5E5007474
      740000AAFF001BA1E500B9B9B900E5E5E500C6AE8000FEEFD900A0642A00A064
      2A00FDE6C700FDE6C700C6AE8000F3EAD900F3EAD900C6AE8000FEEFD900FDE6
      C700A0642A00A0642A00FDE6C700AFA081006E6E6E00C4C4C40000B93D0000B9
      3D00F2F2F20000B93D0000B93D00F2F2F20000B93D0000B93D00F2F2F200F2F2
      F200F2F2F200F2F2F200E4E4E4006E6E6E0097340400D7C2B800DFD5CF00EBEB
      EB0000C61C001FE45E001FDB4D0000C61C0000C2130000BC070000B90000F7F7
      F700FAFAFA00FAFAFA0097340400F9F3F100F3F3F30074747400FFFF7200FFFF
      0000B9B9B900E5E5E50074747400FF727200FF000000B9B9B900E5E5E5007474
      740072D0FF0000AAFF00B9B9B900E5E5E500C6AE8000F8F1E500FFFBF300A064
      2A00A0642A00F8F1E500C6AE8000F0E7D600F0E7D600C6AE8000F8F1E500A064
      2A00A0642A00FFFBF300F8F1E500AFA081006E6E6E00A2A2A20061AF7A0061AF
      7A00C4C4C40061AF7A0061AF7A00C4C4C40061AF7A0061AF7A00C4C4C400C4C4
      C400C4C4C400C4C4C400A2A2A2006E6E6E0097340400D6B2A000DBCCC400E8E8
      E80000CD2A001FDB4D0059F286001FDB4D001FD23B0000C2130000B90000F5F5
      F500F7F7F700F4E9E40097340400F9F3F100F3F3F30074747400747474007474
      740074747400F3F3F30074747400747474007474740074747400F3F3F3007474
      7400747474007474740074747400F3F3F300C6AE8000F8F1E500FFFBF300FFFB
      F300FFFBF300F8F1E500C6AE8000EFE5D500EFE5D500C6AE8000F8F1E500FFFB
      F300FFFBF300FFFBF300F8F1E500AFA08100B5B5B5006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E00B5B5B50097340400C6927B00D6C2B700E2DC
      D9008FD68F0000D133001FDB4D001FE45E0000CD2A0000C61C0095DC9500F2F2
      F200F5F5F500E0C2B30097340400F9F3F10000000000ECECEC00E5E5E500E5E5
      E500E5E5E50000000000F3F3F300E5E5E500E5E5E500E5E5E50000000000F3F3
      F300E5E5E500E5E5E500E5E5E50000000000E2D6BF00C6AE8000C6AE8000C6AE
      8000C6AE8000C6AE8000E0D3BB00E9DFCF00E9DFCF00E0D3BB00C6AE8000C6AE
      8000C6AE8000C6AE8000C6AE8000D7CEBA0000000000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F00000000000E0C2B40097340400DABBAB00DED3
      CD00E2DCD9008FD68F0000CD2A0000C61C0000C61C0092D99200F0F0F000F2F2
      F200EDE7E50097340400E0C2B40000000000F3F3F300B9B9B900B9B9B900B9B9
      B900B9B9B900E5E5E500B9B9B900B9B9B900B9B9B900B9B9B900E5E5E500B9B9
      B900B9B9B900B9B9B900B9B9B900E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3E9E40097340400C6927B00CFB2
      A400DED3CD00E2DCD900E8E8E800E8E8E800EBEBEB00EDEDED00E8E3E000E6DC
      D700E0C2B30097340400F3E9E40000000000F3F3F300747474000000FF000000
      FF00B9B9B900E5E5E5007474740000FFFF001BE5E500B9B9B900E5E5E5007474
      740000FF00001BE51B00B9B9B900E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0C2B40097340400C791
      7700D2AC9900D2BAAD00DACAC200DFD5CF00DFD5CF00E2D7D200DFD0C800E0C2
      B30097340400E0C2B4000000000000000000F3F3F300747474007272FF000000
      FF00B9B9B900E5E5E5007474740072FFFF0000FFFF00B9B9B900E5E5E5007474
      740072FF720000FF0000B9B9B900E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0C2B4009734
      040097340400BE816300CC9D8500CCAB9B00D7BAAB00D1A59100973404009734
      0400E0C2B400000000000000000000000000F3F3F30074747400747474007474
      740074747400F3F3F30074747400747474007474740074747400F3F3F3007474
      7400747474007474740074747400F3F3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3E9
      E400E0C2B4009734040097340400973404009734040097340400E0C2B400F3E9
      E4000000000000000000000000000000000000000000F3F3F300F3F3F300F3F3
      F300F3F3F30000000000F3F3F300F3F3F300F3F3F300F3F3F30000000000F3F3
      F300F3F3F300F3F3F300F3F3F300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFAF900F5EBE700F5EBE700F5EB
      E700F5EBE700F5EBE700F5EBE700F5EBE700F5EBE700F5EBE700F5EBE700F5EB
      E700F5EBE700F5EBE700FCFAF90000000000000000000000000000000000DED7
      D400C8BDB800C8BDB800C8BDB800C8BDB800C8BDB800C8BDB800C8BDB800C8BD
      B800C8BDB800C8BDB800C8BDB800DED7D4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1E5DF0097340400973404009734
      0400973404009734040097340400973404009734040097340400973404009734
      04009734040097340400F5EBE700000000000000000000000000000000009C89
      80009D8A81009D8A81009D8A81009D8A81009D8A81009D8A81009D8A81009D8A
      81009D8A81009D8A81009D8A8100C8BDB8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1E5DF0097340400F0F0F000F2F2
      F200F5F5F500DEEFE400F7F7F700F7F7F700FAFAFA00FCFCFC00FCFCFC00FFFF
      FF00FFFFFF0097340400F5EBE700000000000000000000000000000000009D8A
      8100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009D8A8100C8BDB80000000000F6F6F600E5E5E500E5E5
      E500E5E5E500F6F6F600EDEDED00EDEDED00EDEDED00F6F6F600F6F6F600E5E5
      E500E5E5E500E5E5E500F6F6F60000000000C1ACA20081564200451700004517
      0000451700004517000045170000451700004517000045170000451700004517
      0000451700004517000075534300C1ACA200F1E5DF0097340400F0F0F000F0F0
      F000DBEDE10040BD6900DEEFE400F7F7F700F7F7F700FAFAFA00FCFCFC00FCFC
      FC00FFFFFF0097340400F5EBE700000000000000000000000000000000009D8A
      8100FFFFFF007528040075280400752804007528040075280400752804007528
      040075280400FFFFFF009D8A8100C8BDB80000000000EDEDED00000000000000
      000000000000D4D4D40000000000000000002222220090909000EDEDED000000
      00000000000000000000D4D4D40000000000815642003CA5DA0039B4F30039B4
      F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4
      F30039B4F30039B4F3003CA5DA0075534300F1E5DF0097340400EDEDED00D5E6
      DB0000B93D0000B93D0000AE3900DEEFE400F7F7F700F7F7F700FAFAFA00FAFA
      FA00FCFCFC0097340400F5EBE700000000000000000000000000000000009D8A
      8100B97A0000B97A0000B97A0000B97A0000B97A0000B97A0000B97A0000B97A
      0000B97A0000B97A00009D8A8100C8BDB80000000000EDEDED0000000000BFBF
      BF00DDDDDD00F6F6F60000000000CDCDCD00ACACAC0032323200D4D4D4000000
      0000C6C6C600DDDDDD00F6F6F60000000000561C000039B4F300C9ADAA00FAAB
      9000815648000000000081564800FAAB900000000000FAAB900000000000FAAB
      9000FAAB9000C9ADAA0039B4F30045170000F1E5DF0097340400EBEBEB0074D0
      920019C6500019C6500000B93D0000AA3700DEEFE400F5F5F500F7F7F700FAFA
      FA00FAFAFA0097340400F5EBE700000000000000000000000000000000009D8A
      8100B97A0000FFF0D400FFF0D400FFF0D400FFF0D400FFF0D400FFF0D400FFF0
      D400FFF0D400B97A00009D8A8100C8BDB80000000000EDEDED0000000000EDED
      ED0000000000F6F6F60000000000E5E5E500B2B2B2002E2E2E00D4D4D4000000
      0000E5E5E500000000000000000000000000561C000039B4F300C9ADAA00FFAB
      8E0000000000CB88710000000000FFAB8E00000000008156480000000000FFAB
      8E00FFAB8E00C9ADAA0039B4F30045170000F1E5DF0097340400D2E4D80076D4
      940019C65000D7E8DC0019C6500000B93D0000A63600DEEFE400F5F5F500F7F7
      F700FAFAFA0097340400F5EBE700000000000000000000000000000000009D8A
      8100B97A0000B97A0000B97A0000B97A0000B97A0000B97A0000B97A0000B97A
      0000B97A0000B97A00009D8A8100C8BDB80000000000EDEDED0000000000EDED
      ED0000000000F6F6F60000000000000000003C3C3C0095959500F6F6F6000000
      0000E5E5E500000000000000000000000000561C000039B4F300C9CBCF00FFC7
      B10000000000CB9E8D0000000000FFC7B1000000000000000000A27E7000FFC7
      B100FFC7B100CDCCCE0039B4F30045170000F1E5DF0097340400D0E2D60078D8
      9600D5E6DB00EBEBEB00D7E8DC0019C6500000B93D0000A83600DBEDE100F5F5
      F500F7F7F70097340400F5EBE700000000000000000000000000000000009D8A
      8100FFFFFF007528040075280400752804007528040075280400752804007528
      040075280400FFFFFF009D8A8100C8BDB80000000000EDEDED0000000000EDED
      ED0000000000F6F6F60000000000E5E5E500B2B2B2002E2E2E00D4D4D4000000
      0000E5E5E500000000000000000000000000561C000039B4F300C9CBCF00FAD3
      C200816B620000000000816B6200FAD3C20000000000A2877B0000000000FAD3
      C200FAD3C200C9CBCF0039B4F30045170000F1E5DF0097340400D0E2D600D0E2
      D600E8E8E800EBEBEB00EBEBEB00D7E8DC0019C6500000B93D0000B63C00DBED
      E100F5F5F50097340400F5EBE70000000000FBFAFA00F7F5F500F7F5F5009D8A
      8100FFFFFF00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FFFFFF009D8A8100C6BBB60000000000EDEDED0000000000EDED
      ED0000000000F6F6F60000000000CDCDCD00A6A6A60032323200D4D4D4000000
      0000E5E5E500000000000000000000000000815642003CA5DA0039B4F30039B4
      F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4F30039B4
      F30039B4F30039B4F3003CA5DA0081564200F1E5DF0097340400E6E6E600E6E6
      E600E6E6E600E8E8E800E8E8E800EBEBEB00D7E8DC0019C6500000B93D0064CB
      8500F2F2F20097340400F5EBE70000000000FBFAFA00B0A199009C8980009C89
      80009C8980009C8980009C8980009C8980009C8980009C8980009C8980009C89
      80009C8980009C898000B0A19900D8D1CE0000000000EDEDED0000000000EDED
      ED0000000000F6F6F60000000000000000003939390088888800F6F6F6000000
      0000E5E5E500000000000000000000000000C1ACA20081564200561C0000561C
      0000561C0000561C0000561C0000561C0000561C0000561C0000561C0000561C
      0000561C0000561C000081564200C1ACA200F1E5DF0097340400E6E6E600E6E6
      E600E6E6E600E6E6E600E8E8E800E8E8E800EBEBEB00D7E8DC0019C6500063CA
      8400F0F0F00097340400F5EBE70000000000F7F5F5009C898000ECE8E600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFA4
      8500FFA08000FFA080009C898000F7F5F50000000000F6F6F600EDEDED00F6F6
      F60000000000F6F6F600EDEDED00EDEDED00EDEDED00F6F6F600F6F6F600F6F6
      F600F6F6F6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1E5DF0097340400E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E8E8E800EBEBEB00D5E6DB0077D3
      9500F0F0F00097340400F5EBE70000000000F7F5F5009C898000E4DEDB007325
      00007325000073250000611F0000611F0000611F000050190000D0BDB400EAA2
      820089590900EF9671009C898000F7F5F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1E5DF0097340400E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E8E8E800EBEBEB00EBEB
      EB00EDEDED0097340400F5EBE70000000000F7F5F5009C898000E4DEDB00ECE8
      E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600ECE8E600A677
      3200EFB99D00A7742C009C898000F7F5F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1E5DF0097340400973404009734
      0400973404009734040097340400973404009734040097340400973404009734
      04009734040097340400F5EBE70000000000F7F5F500B0A199009C8980009C89
      80009C8980009C8980009C8980009C8980009C8980009C8980009C8980009C89
      80009C8980009C898000B0A19900F7F5F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5ECE800F1E5DF00F1E5DF00F1E5
      DF00F1E5DF00F1E5DF00F1E5DF00F1E5DF00F1E5DF00F1E5DF00F1E5DF00F1E5
      DF00F1E5DF00F1E5DF00FCFAF90000000000FBFAFA00F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500FBFAFA00424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0080008000000000000000200000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000001000000000000FFFFFFFFFFFFFFFFC003C001E007FEFF
      80018001EFF7FEFF00008001E017FEFF00008001E017FEFF00008001E017F2FF
      00008001C017FCFD00008001C017FEC100008001C017F07F0DF48001C0171EBF
      00008001C037FEDF01F18001C047FEDF42038001C007FEFFBCFF8001C007FEFF
      C1FF8001C007FEFFFFFFFFFFFFFFFEFF8000FFFFFFC1F00F0000FFFFFF81E007
      00000000FF01C00300000000FE03800100000000F803000000000000F8070000
      00000000F807000000000000F00F000000000000F01F000000000000E01F0000
      00000000E03F000000000000C07F000000000000C0FF00000000000081FF8001
      0000FFFF83FFC0070001FFFFC7FFE00FFFFFFFFFF81F8421FFFFFFFFE0070000
      FFFFFFFFC0070000FFFFFFFF8001000080000000000100000000000000008421
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084210000800100010000FFFFFFFF00010000FFFFFFFF80030000
      FFFFFFFFC0070000FFFFFFFFE00F8421FFFFFFFFFFFFFFFFFFFFFFFF0001E000
      FFFFFFFF0001E000FFFFFFFF0001E000800100000001E000800100000001E000
      800100000001E000880700000001E000880700000001E0008807000000010000
      880700000001000088070000000100008807FFFF00010000FFFFFFFF00010000
      FFFFFFFF00010000FFFFFFFF0001000000000000000000000000000000000000
      000000000000}
  end
  object SizeCtrl: TSizeCtrl
    MoveOnly = False
    BtnColor = clNavy
    BtnColorDisabled = clGray
    GridSize = 10
    MultiTargetResize = False
    OnDuringSizeMove = SizeCtrlDuringSizeMove
    OnEndSizeMove = SizeCtrlEndSizeMove
    OnTargetChange = SizeCtrlTargetChange
    Left = 520
    Top = 74
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.pcddevc'
    Filter = 'DDF-Datei (*.pcddevc)|*.pcddevc|Alle Dateien (*.*)|*.*'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 584
    Top = 72
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.pcddevc'
    Filter = 'DDF-Datei (*.pcddevc)|*.pcddevc|Alle Dateien (*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 552
    Top = 72
  end
  object XML: TJvAppXMLFileStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    StorageOptions.AutoEncodeValue = False
    StorageOptions.AutoEncodeEntity = False
    StorageOptions.InvalidCharReplacement = '_'
    ReadOnly = True
    RootNodeName = 'device'
    SubStorages = <>
    Left = 456
    Top = 72
  end
  object ScriptInterpreter: TJvInterpreterProgram
    OnGetValue = ScriptInterpreterGetValue
    Left = 424
    Top = 72
  end
  object SynPasSyn1: TSynPasSyn
    CommentAttri.Foreground = clBlue
    NumberAttri.Foreground = clRed
    FloatAttri.Foreground = clRed
    HexAttri.Foreground = clRed
    StringAttri.Foreground = clBlue
    DelphiVersion = dvDelphi7
    Left = 392
    Top = 72
  end
  object ImageList1: TImageList
    Left = 285
    Top = 369
  end
end
