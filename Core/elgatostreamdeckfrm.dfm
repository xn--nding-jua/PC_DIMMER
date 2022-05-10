object elgatostreamdeckform: Telgatostreamdeckform
  Left = 550
  Top = 124
  BorderStyle = bsSingle
  Caption = 'Elgato Stream Deck'
  ClientHeight = 617
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 81
    Height = 13
    Caption = 'Erkannte Ger'#228'te:'
  end
  object Label3: TLabel
    Left = 368
    Top = 24
    Width = 46
    Height = 13
    Caption = 'Helligkeit:'
  end
  object devicelistbox: TListBox
    Left = 8
    Top = 24
    Width = 353
    Height = 57
    ItemHeight = 13
    TabOrder = 0
    OnKeyUp = devicelistboxKeyUp
    OnMouseUp = devicelistboxMouseUp
  end
  object brightnessbar: TScrollBar
    Left = 368
    Top = 40
    Width = 409
    Height = 17
    PageSize = 0
    Position = 50
    TabOrder = 1
    OnChange = brightnessbarChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 480
    Width = 769
    Height = 97
    Caption = ' Einstellungen f'#252'r gew'#228'hlten Button '
    TabOrder = 2
    object btnlabel: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 13
      Caption = 'Button ...'
    end
    object Label4: TLabel
      Left = 224
      Top = 24
      Width = 64
      Height = 13
      Caption = 'Kontrollpanel:'
    end
    object Label5: TLabel
      Left = 224
      Top = 44
      Width = 10
      Height = 13
      Caption = 'X:'
    end
    object Label6: TLabel
      Left = 224
      Top = 68
      Width = 10
      Height = 13
      Caption = 'Y:'
    end
    object Label7: TLabel
      Left = 304
      Top = 24
      Width = 145
      Height = 13
      Caption = 'Ger'#228'te- oder Gruppenauswahl:'
    end
    object Label8: TLabel
      Left = 456
      Top = 24
      Width = 68
      Height = 13
      Caption = 'Data-In-Kanal:'
    end
    object Label9: TLabel
      Left = 536
      Top = 24
      Width = 33
      Height = 13
      Caption = 'Befehl:'
    end
    object Label2: TLabel
      Left = 600
      Top = 24
      Width = 50
      Height = 13
      Caption = 'Inkrement:'
    end
    object btntype: TComboBox
      Left = 16
      Top = 40
      Width = 201
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = btntypeChange
      Items.Strings = (
        'Frei'
        'Kontrollpanelbutton'
        'Ger'#228'te- oder Gruppenauswahl'
        'Data-In'
        'Befehl')
    end
    object panelbtnx: TJvSpinEdit
      Left = 248
      Top = 40
      Width = 49
      Height = 21
      CheckMaxValue = False
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
      OnChange = panelbtnxChange
    end
    object panelbtny: TJvSpinEdit
      Left = 248
      Top = 64
      Width = 49
      Height = 21
      CheckMaxValue = False
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 2
      OnChange = panelbtnyChange
    end
    object deviceorgroupid: TComboBox
      Left = 304
      Top = 40
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = deviceorgroupidChange
    end
    object datainchannel: TJvSpinEdit
      Left = 456
      Top = 40
      Width = 73
      Height = 21
      MaxValue = 8192.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 4
      OnChange = datainchannelChange
    end
    object useholdcheckbox: TCheckBox
      Left = 456
      Top = 68
      Width = 201
      Height = 17
      Caption = 'Gedr'#252'ckt halten f'#252'r '#196'nderung'
      TabOrder = 5
      OnKeyUp = useholdcheckboxKeyUp
      OnMouseUp = useholdcheckboxMouseUp
    end
    object incrementedit: TJvSpinEdit
      Left = 600
      Top = 40
      Width = 49
      Height = 21
      MaxValue = 64.000000000000000000
      MinValue = 1.000000000000000000
      Value = 5.000000000000000000
      TabOrder = 6
      OnChange = incrementeditChange
    end
    object editbtn: TPngBitBtn
      Left = 532
      Top = 40
      Width = 61
      Height = 25
      Hint = 'Bearbeitet die ausgew'#228'hlte Szene'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = editbtnClick
      PngImage.Data = {
        89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
        0D000000097048597300000B1300000B1301009A9C1800000A4D694343505068
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
        F73EE77CFEFC2FF784F3FB25D29F33000003D34944415478DA9D945F4C5B551C
        C7BFBD6D29941570A44B18A0C6B031373675CB32126388F1612F9BC6902D8A9A
        ED618B2FEEC1C4640F4BF47526CE98F9A2C13F9B6E86CD88A0FCEBB003D7AD94
        D1155A0A050A85FEA1957FB5BDEDED6D7BFF1CCFEDCA5081613CC937B927E7FC
        3EF7F7EFFC5422BF80B5A50224013217C7468B9E2223033CD4283194E2D78E9F
        8C4762CB1F18ADFD27679F3DDC7EEED6E025D5FF010A5A3DC6DCEE7AA7E9F3D6
        43CF3015D541193BC3325A0C55DF6F028CD12FC59CE431ABA7745FA087C56E7F
        DEF2F397371B2AB85DFAA72A52F16D6505FB5C494DEF04EF5C0F9445487C0AD9
        6C866E356B50950A1AEAD97DFB50FD40C7C7E683FBB6EBAB7794A2AA6A076C61
        5EE416B5990B974C5DFF023E5CB22022C3FAA12BDF0D29EE075221D00D488141
        B5307AB9D730D7F2CA34578D65C341D41DD98DF1B110AEDE08DB6FFCD8D5B909
        508090083C04C66640127E3085256A71E9EB1F8AC296934A222583848EC073C8
        16D4CA2DADBE91D63693859A9AB706520F8313B6A24AE3488B36D4F32A381128
        96A13ED4806BD7A77167B866B2F9DB9BBF51B37E2ADB638185C63A84C6AD7AA3
        EA5AAB2E663D4A9214A61380FDC7E1F1498977DFB73BAD36A7839A58A906A8C2
        9B0393F360534C6959F6ABF602CED200360D42A80E34613AC871C74E74F4CFF8
        82767A7D906A944A01091B036506D1B941633177E517FD13A17A124B026C0C64
        FF3BF00692A9C6B73BEF78267CF7F2618E51B15452AE4FD601191D124BC14A4D
        F8A31E7D255B47E209A82221C807DE82D797E01B4F99149812621F952B0F238F
        1A4FE0FF58EB42460B6E79EE69ADFFC3DEC21AA686704910AF8786F91A2667D3
        E9A6B30316977B4AF1EC763ECCF8DF613906BBF0609586E84ABCB47CF1F250F1
        5ED52E221290D17B90F7BE44C3D4644FBDE7B2D81DE38A67662AA7021B1EEA23
        2F1C7EF99FCF33B3E8CBFD83A875C804CC1775D1FEF3AA2733D086CC10ABF760
        22A213CF5D58B1FE6EB1DFCDC386A962726689385D6EAC030A6C90E64D0D3EB6
        50AB9DFC86BE4551C78B1204830BA1B45A3C7F51B2F5DEB6AD86A984F327CDBB
        CC300C360466D979687585C8B8AFF730D1D1A329F536B8223C3C8B1CD7D63DE3
        E8BE65B5E6ABA9C0561458AE769B0157E667E01A71BCB833D67EB76C7B092C61
        92310FC566AF7ED7F62095E2C7E99DFBF96AAE88E98804C2E0B1C0807F8E79BD
        F184436003B56FBE717CF28B2BDD33FEC0BC375F4537159D0E4888E9B0949B3A
        5B013FFBF49333CDCDCD4D8224F74D4D79957915CA37EBACE295D2FDD433F268
        8C6D053C7BE6F4B1CE2E131B0E47CA958453D1B263892A9D8C7A48919E8EADDC
        23F86FC0BF004AAE3D5317D0D0E10000000049454E44AE426082}
      PngOptions = [pngBlendOnDisabled, pngGrayscaleOnDisabled]
    end
  end
  object Button1: TButton
    Left = 8
    Top = 584
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
  object selectmodecheckbox: TCheckBox
    Left = 368
    Top = 64
    Width = 353
    Height = 17
    Caption = 'Letzten Button als Modus-Umschalter nutzen'
    TabOrder = 4
    OnMouseUp = selectmodecheckboxMouseUp
  end
  object Panel1: TPanel
    Left = 8
    Top = 88
    Width = 769
    Height = 385
    BevelOuter = bvLowered
    TabOrder = 5
    object PaintBox1: TPaintBox
      Left = 1
      Top = 1
      Width = 768
      Height = 384
      OnMouseUp = PaintBox1MouseUp
    end
  end
  object ElgatoStreamDeckTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = ElgatoStreamDeckTimerTimer
    Left = 272
    Top = 8
  end
  object ElgatoStreamDeckDisplayTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = ElgatoStreamDeckDisplayTimerTimer
    Left = 304
    Top = 8
  end
end
