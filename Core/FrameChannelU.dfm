object FrameChannel: TFrameChannel
  Left = 0
  Top = 0
  Width = 469
  Height = 320
  TabOrder = 0
  TabStop = True
  object GbChannel: TGroupBox
    Left = 0
    Top = 0
    Width = 469
    Height = 320
    Align = alClient
    Caption = 'GbChannel'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 224
      Width = 465
      Height = 94
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 465
        Height = 2
        Align = alTop
      end
      object PbWave: TPaintBox
        Left = 0
        Top = 2
        Width = 465
        Height = 92
        Align = alClient
        OnPaint = PbWavePaint
      end
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 15
      Width = 465
      Height = 209
      ActivePage = TsSteuerung
      Align = alClient
      TabOrder = 1
      object TsSteuerung: TTabSheet
        Caption = 'Steuerung'
        DesignSize = (
          457
          181)
        object LaUp: TLabel
          Left = 9
          Top = 92
          Width = 72
          Height = 16
          Alignment = taRightJustify
          Caption = '00:00:000'
          Font.Charset = ANSI_CHARSET
          Font.Color = clHotLight
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object LaDown: TLabel
          Left = 9
          Top = 105
          Width = 72
          Height = 16
          Alignment = taRightJustify
          Caption = '00:00:000'
          Font.Charset = ANSI_CHARSET
          Font.Color = clHotLight
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object LaStatus: TLabel
          Left = 104
          Top = 100
          Width = 57
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 192
          Top = 43
          Width = 41
          Height = 13
          Caption = 'Position:'
          Transparent = True
        end
        object Label2: TLabel
          Left = 192
          Top = 67
          Width = 41
          Height = 13
          Caption = 'Balance:'
          Transparent = True
        end
        object VolLabel: TLabel
          Left = 192
          Top = 91
          Width = 61
          Height = 13
          Caption = 'Volume: 0 %'
          Transparent = True
        end
        object BtnLoadPlay: TButton
          Left = 8
          Top = 39
          Width = 75
          Height = 18
          Caption = 'Load && Play'
          TabOrder = 0
          OnClick = BtnLoadPlayClick
        end
        object BtnPlay: TButton
          Left = 8
          Top = 63
          Width = 50
          Height = 18
          Caption = 'Play'
          TabOrder = 1
          OnClick = BtnPlayClick
        end
        object BtnPause: TButton
          Left = 63
          Top = 63
          Width = 50
          Height = 18
          Caption = 'Pause'
          TabOrder = 2
          OnClick = BtnPauseClick
        end
        object BtnLoad: TButton
          Left = 94
          Top = 39
          Width = 75
          Height = 18
          Caption = 'Load'
          TabOrder = 3
          OnClick = BtnLoadClick
        end
        object BtnStop: TButton
          Left = 119
          Top = 63
          Width = 50
          Height = 18
          Caption = 'Stop'
          TabOrder = 4
          OnClick = BtnStopClick
        end
        object TrackBarVolume: TTrackBar
          Left = 264
          Top = 80
          Width = 169
          Height = 24
          Max = 100
          Frequency = 10
          TabOrder = 5
          ThumbLength = 14
          TickMarks = tmTopLeft
          OnChange = TrackBarVolumeChange
        end
        object TrackBarBalance: TTrackBar
          Left = 264
          Top = 56
          Width = 169
          Height = 24
          Max = 100
          Min = -100
          Frequency = 10
          TabOrder = 6
          ThumbLength = 14
          TickMarks = tmTopLeft
          OnChange = TrackBarBalanceChange
        end
        object TrackBarPosition: TTrackBar
          Left = 264
          Top = 31
          Width = 169
          Height = 26
          PageSize = 5
          Frequency = 10
          TabOrder = 7
          ThumbLength = 14
          TickMarks = tmBoth
          OnChange = TrackBarPositionChange
        end
        object EdLied: TEdit
          Left = 8
          Top = 8
          Width = 445
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ReadOnly = True
          TabOrder = 8
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 128
          Width = 441
          Height = 51
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Crossfading'
          TabOrder = 9
          object Label4: TLabel
            Left = 8
            Top = 24
            Width = 57
            Height = 13
            Caption = 'zu Channel:'
          end
          object CoCrossfading: TComboBox
            Left = 72
            Top = 20
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
            OnChange = CoCrossfadingChange
          end
          object CbCrossfading: TCheckBox
            Left = 208
            Top = 21
            Width = 89
            Height = 17
            Caption = 'automatisch'
            TabOrder = 1
            OnClick = CbCrossfadingClick
          end
          object BtnCrossfading: TButton
            Left = 304
            Top = 16
            Width = 75
            Height = 25
            Caption = 'Manuell'
            TabOrder = 2
            OnClick = BtnCrossfadingClick
          end
        end
        object CbNormalisieren: TCheckBox
          Left = 272
          Top = 112
          Width = 97
          Height = 17
          Caption = 'Normalisieren'
          Checked = True
          State = cbChecked
          TabOrder = 10
          OnClick = CbNormalisierenClick
        end
      end
      object TsEquiliser: TTabSheet
        Caption = 'Equiliser'
        ImageIndex = 2
        object PaEquiliser: TPanel
          Left = 0
          Top = 0
          Width = 457
          Height = 181
          Align = alClient
          TabOrder = 0
        end
      end
      object TsEffekte: TTabSheet
        Caption = 'Effekte'
        ImageIndex = 1
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 457
          Height = 181
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = 'Einfache'
            object Label3: TLabel
              Left = 12
              Top = 96
              Width = 39
              Height = 13
              Caption = 'Reverb:'
            end
            object CbEcho: TCheckBox
              Left = 12
              Top = 12
              Width = 53
              Height = 17
              Caption = 'Echo'
              TabOrder = 0
              OnClick = CbEchoClick
            end
            object CbFlange: TCheckBox
              Left = 12
              Top = 36
              Width = 53
              Height = 17
              Caption = 'Flange'
              TabOrder = 1
              OnClick = CbFlangeClick
            end
            object CbRotate: TCheckBox
              Left = 12
              Top = 60
              Width = 53
              Height = 17
              Caption = 'Rotate'
              TabOrder = 2
              OnClick = CbRotateClick
            end
            object TbReverb: TTrackBar
              Left = 64
              Top = 96
              Width = 249
              Height = 17
              Max = 20
              TabOrder = 3
              ThumbLength = 10
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbReverbChange
            end
            object TbEcho: TTrackBar
              Left = 64
              Top = 13
              Width = 249
              Height = 13
              Max = 50000
              Min = 100
              Position = 1200
              TabOrder = 4
              ThumbLength = 10
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbEchoChange
            end
            object TbRotate: TTrackBar
              Left = 64
              Top = 61
              Width = 249
              Height = 13
              Max = 100
              Min = 1
              Position = 3
              TabOrder = 5
              ThumbLength = 10
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbRotateChange
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Tempo'
            ImageIndex = 1
            object LaTempo: TLabel
              Left = 8
              Top = 8
              Width = 273
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Tempo = 0%'
              ParentShowHint = False
              ShowHint = True
            end
            object LaSamplerate: TLabel
              Left = 8
              Top = 48
              Width = 273
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Samplerate = 44100Hz'
              ParentShowHint = False
              ShowHint = True
            end
            object LaPitch: TLabel
              Left = 8
              Top = 96
              Width = 273
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Pitch Scaling = 0 semitones'
              ParentShowHint = False
              ShowHint = True
            end
            object TbTempo: TTrackBar
              Left = 8
              Top = 24
              Width = 273
              Height = 17
              Max = 30
              Min = -30
              PageSize = 1
              TabOrder = 0
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbTempoChange
            end
            object TbSamplerate: TTrackBar
              Left = 8
              Top = 64
              Width = 273
              Height = 17
              Max = 57330
              Min = 30870
              PageSize = 441
              Position = 44100
              TabOrder = 1
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbSamplerateChange
            end
            object TbPitch: TTrackBar
              Left = 8
              Top = 107
              Width = 273
              Height = 17
              Max = 30
              Min = -30
              PageSize = 1
              TabOrder = 2
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbPitchChange
            end
          end
          object TabSheet3: TTabSheet
            Caption = 'Phaser'
            ImageIndex = 2
            object LaDryMix: TLabel
              Left = 16
              Top = 40
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'DryMix'
            end
            object LaWetMix: TLabel
              Left = 16
              Top = 64
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'WetMix'
            end
            object LaFeedback: TLabel
              Left = 16
              Top = 88
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Feedback'
            end
            object LaRate: TLabel
              Left = 216
              Top = 40
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Rate'
            end
            object LaRange: TLabel
              Left = 216
              Top = 64
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Range'
            end
            object LaFreq: TLabel
              Left = 216
              Top = 88
              Width = 57
              Height = 13
              Alignment = taCenter
              AutoSize = False
              Caption = 'Freq'
            end
            object TbDryMix: TTrackBar
              Left = 72
              Top = 40
              Width = 121
              Height = 17
              Max = 2000
              Min = -2000
              PageSize = 1
              Position = 999
              TabOrder = 0
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbDryMixChange
            end
            object TbWetMix: TTrackBar
              Left = 72
              Top = 64
              Width = 121
              Height = 17
              Max = 2000
              Min = -2000
              PageSize = 1
              Position = -999
              TabOrder = 1
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbWetMixChange
            end
            object TbFeedback: TTrackBar
              Left = 72
              Top = 88
              Width = 121
              Height = 17
              Max = 1000
              Min = -1000
              PageSize = 1
              Position = -60
              TabOrder = 2
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbFeedbackChange
            end
            object TbRate: TTrackBar
              Left = 272
              Top = 40
              Width = 121
              Height = 17
              Max = 100
              PageSize = 1
              Position = 2
              TabOrder = 3
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbRateChange
            end
            object TbRange: TTrackBar
              Left = 272
              Top = 64
              Width = 121
              Height = 17
              Max = 100
              PageSize = 1
              Position = 60
              TabOrder = 4
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbRangeChange
            end
            object TbFreq: TTrackBar
              Left = 272
              Top = 88
              Width = 121
              Height = 17
              Max = 10000
              PageSize = 1
              Position = 1000
              TabOrder = 5
              ThumbLength = 15
              TickMarks = tmBoth
              TickStyle = tsNone
              OnChange = TbFreqChange
            end
            object CbPhaser: TCheckBox
              Left = 8
              Top = 8
              Width = 65
              Height = 17
              Caption = 'Phaser'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnClick = CbPhaserClick
            end
          end
        end
      end
    end
  end
end
