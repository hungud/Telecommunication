object RefAccountBillLoadForm: TRefAccountBillLoadForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1089#1095#1077#1090#1086#1074' '#1074' '#1073#1072#1083#1072#1085#1089
  ClientHeight = 542
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 542
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1048
    object sSplitter1: TsSplitter
      Left = 678
      Top = 0
      Height = 542
      ParentCustomHint = False
      Align = alRight
      Color = clBtnFace
      ParentColor = False
      ResizeStyle = rsLine
      Glyph.Data = {
        EE020000424DEE020000000000003600000028000000030000003A0000000100
        180000000000B802000000000000000000000000000000000000FFFFFF2EF06D
        FFFFFF00000028EA6B22EA5E36AA5500000029E16C22EE672DB852000000FFFF
        FF21F367FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00
        0000FFFFFF0BFF4DFFFFFF00000000EF1F6166762DB85200000000EF1F616676
        23C04A000000FFFFFF616676FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFF000000FFFFFF18FF5FFFFFFF00000030E96C2AEA6C1A9C4700
        000030E96C2AEA6C1A9C47000000FFFFFF2FE970FFFFFF000000FFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF28E96BFFFFFF0000002FDE
        6A27E7672FE97000000046DE7934E7762DEA6F000000FFFFFF40E67AFFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF2EF06D
        FFFFFF00000028EA6B22EA5E36AA5500000029E16C22EE672DB852000000FFFF
        FF21F367FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00
        0000FFFFFF0BFF4DFFFFFF00000000EF1F6166762DB85200000000EF1F616676
        23C04A000000FFFFFF616676FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFF000000FFFFFF18FF5FFFFFFF00000030E96C2AEA6C1A9C4700
        000030E96C2AEA6C1A9C47000000FFFFFF2FE970FFFFFF000000FFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF28E96BFFFFFF0000002FDE
        6A27E7672FE97000000046DE7934E7762DEA6F000000FFFFFF40E67AFFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFF2EF06D
        FFFFFF00000028EA6B22EA5E36AA5500000029E16C22EE672DB852000000FFFF
        FF21F367FFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00
        0000FFFFFF0BFF4DFFFFFF00000000EF1F6166762DB85200000000EF1F616676
        23C04A000000FFFFFF616676FFFFFF000000}
      ShowGrip = True
      SkinData.SkinSection = 'SPLITTER'
      ExplicitLeft = 863
    end
    object pnl2: TPanel
      Left = 0
      Top = 0
      Width = 678
      Height = 542
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 863
      object pnl5: TPanel
        Left = 0
        Top = 0
        Width = 678
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -10
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 863
        object cbPeriod: TsComboBox
          Left = 65
          Top = 8
          Width = 140
          Height = 22
          AutoDropDown = True
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = #1052#1077#1089#1103#1094':'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = [fsBold]
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          ItemIndex = -1
          ParentFont = False
          TabOrder = 0
          OnChange = cbPeriodChange
        end
        object sPanel1: TsPanel
          Left = 205
          Top = 4
          Width = 197
          Height = 32
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sBevel1: TsBevel
            Left = 95
            Top = 1
            Width = 3
            Height = 38
          end
          object sBevel2: TsBevel
            Left = 197
            Top = 2
            Width = 3
            Height = 38
          end
          object sBitBtn2: TsBitBtn
            Left = 3
            Top = 0
            Width = 91
            Height = 32
            Action = aRefresh
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 9
            Images = Dm.ImageList24
          end
          object sBitBtn3: TsBitBtn
            Left = 100
            Top = 0
            Width = 95
            Height = 32
            Action = aToExcel
            Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 45
            Images = Dm.ImageList24
          end
          object sBitBtn4: TsBitBtn
            Left = 202
            Top = 0
            Width = 102
            Height = 36
            Action = aInfo
            Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
            TabOrder = 2
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 17
            Images = Dm.ImageList24
          end
        end
        object sPanel2: TsPanel
          Left = 401
          Top = 4
          Width = 170
          Height = 32
          BevelOuter = bvNone
          TabOrder = 2
          SkinData.SkinSection = 'PANEL'
          object sBevel3: TsBevel
            Left = 84
            Top = 1
            Width = 3
            Height = 38
          end
          object sBitBtn1: TsBitBtn
            Left = 89
            Top = 0
            Width = 80
            Height = 32
            Action = aFiltr
            Caption = #1060#1080#1083#1100#1090#1088
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 13
            Images = Dm.ImageList24
          end
          object sBitBtn5: TsBitBtn
            Left = 2
            Top = 0
            Width = 80
            Height = 32
            Action = aFind
            Caption = #1055#1086#1080#1089#1082
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 15
            Images = Dm.ImageList24
          end
        end
        object sPanel3: TsPanel
          Left = 308
          Top = 39
          Width = 277
          Height = 32
          BevelOuter = bvNone
          TabOrder = 3
          SkinData.SkinSection = 'PANEL'
          object sBevel4: TsBevel
            Left = 120
            Top = -2
            Width = 3
            Height = 38
          end
          object sBitBtn6: TsBitBtn
            Left = 125
            Top = 0
            Width = 148
            Height = 32
            Action = aCheckedAll
            Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089#1095#1077#1090#1072' '#1076#1083#1103' '#1074#1082#1083#1102#1095#1077#1085#1080#1103' '#1074' '#1073#1072#1083#1072#1085#1089
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 49
            Images = Dm.ImageList24
          end
          object sBitBtn7: TsBitBtn
            Left = 2
            Top = 0
            Width = 116
            Height = 32
            Action = aEdit
            Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 6
            Images = Dm.ImageList24
          end
        end
        object sPanel4: TsPanel
          Left = 67
          Top = 40
          Width = 229
          Height = 31
          BevelOuter = bvNone
          TabOrder = 4
          SkinData.SkinSection = 'PANEL'
          object sBevel5: TsBevel
            Left = 37
            Top = 0
            Width = 3
            Height = 38
          end
          object sBevel6: TsBevel
            Left = 76
            Top = 0
            Width = 3
            Height = 38
          end
          object sBevel7: TsBevel
            Left = 115
            Top = 0
            Width = 3
            Height = 38
          end
          object sBevel8: TsBevel
            Left = 153
            Top = 0
            Width = 3
            Height = 38
          end
          object sBevel9: TsBevel
            Left = 190
            Top = 0
            Width = 3
            Height = 38
          end
          object sBitBtn8: TsBitBtn
            Left = 3
            Top = 0
            Width = 32
            Height = 30
            Action = aFirst
            Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 0
            Images = Dm.ImageList24
            ShowCaption = False
          end
          object sBitBtn9: TsBitBtn
            Left = 42
            Top = 0
            Width = 32
            Height = 30
            Action = aMovePrev
            Caption = #1053#1072#1079#1072#1076' '#1085#1072'  10 '#1079#1072#1087#1080#1089#1077#1081
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 43
            Images = Dm.ImageList24
            ShowCaption = False
          end
          object sBitBtn10: TsBitBtn
            Left = 81
            Top = 0
            Width = 32
            Height = 30
            Action = aPrev
            Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 1
            Images = Dm.ImageList24
            ShowCaption = False
          end
          object sBitBtn11: TsBitBtn
            Left = 120
            Top = 0
            Width = 32
            Height = 30
            Action = aNext
            Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 2
            Images = Dm.ImageList24
            ShowCaption = False
          end
          object sBitBtn12: TsBitBtn
            Left = 157
            Top = 0
            Width = 32
            Height = 30
            Action = aMoveNext
            Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 10 '#1079#1072#1087#1080#1089#1077#1081
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 42
            Images = Dm.ImageList24
            ShowCaption = False
          end
          object sBitBtn13: TsBitBtn
            Left = 194
            Top = 0
            Width = 32
            Height = 30
            Action = aLast
            Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            SkinData.SkinSection = 'BUTTON'
            ImageIndex = 3
            Images = Dm.ImageList24
            ShowCaption = False
          end
        end
      end
      object pnl6: TPanel
        Left = 5
        Top = 85
        Width = 560
        Height = 427
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'pnl6'
        TabOrder = 1
        object cRGrid: TCRDBGrid
          Left = 1
          Top = 1
          Width = 558
          Height = 425
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          DataSource = dsRef
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
        end
      end
      object sPanel5: TsPanel
        Left = 73
        Top = 82
        Width = 833
        Height = 309
        TabOrder = 2
        SkinData.SkinSection = 'PANEL'
        object sLabel1: TsLabel
          Left = 1
          Top = 1
          Width = 831
          Height = 19
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = #1054#1090#1084#1077#1090#1100' '#1085#1091#1078#1085#1099#1077' '#1089#1095#1077#1090#1072
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object CLB_Accounts: TsCheckListBox
          Left = 1
          Top = 20
          Width = 831
          Height = 252
          Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
          Align = alClient
          BorderStyle = bsSingle
          Color = clWhite
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          BoundLabel.Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
        end
        object sPanel6: TsPanel
          Left = 1
          Top = 272
          Width = 831
          Height = 36
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object sDateEdit1: TsDateEdit
            Left = 291
            Top = 3
            Width = 96
            Height = 27
            Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            AutoSize = False
            EditMask = '!99/99/9999;1; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            BoundLabel.Indent = 0
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = [fsBold]
            BoundLabel.Layout = sclLeft
            BoundLabel.MaxWidth = 0
            BoundLabel.UseSkinColor = True
            SkinData.SkinSection = 'EDIT'
            GlyphMode.Blend = 0
            GlyphMode.Grayed = False
            DefaultToday = True
            DialogTitle = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
          end
          object sBitBtn14: TsBitBtn
            Left = 426
            Top = 3
            Width = 114
            Height = 29
            Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1084#1077#1095#1077#1085#1085#1099#1077' '#1089#1095#1077#1090#1072' '#1074' '#1073#1072#1083#1072#1085#1089#1077
            Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btn1Click
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 7
            Images = Dm.ImageList24
          end
          object sBitBtn16: TsBitBtn
            Left = 552
            Top = 3
            Width = 114
            Height = 29
            Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1091#1089#1090#1072#1085#1086#1074#1082#1091' '#1089#1095#1077#1090#1086#1074' '#1074' '#1073#1072#1083#1072#1085#1089#1077
            Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = sBitBtn16Click
            SkinData.SkinSection = 'BUTTON'
            Down = True
            ImageIndex = 8
            Images = Dm.ImageList24
          end
        end
      end
      object sPanel7: TsPanel
        Left = 21
        Top = 215
        Width = 628
        Height = 111
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        SkinData.SkinSection = 'PANEL'
        object sBevel14: TsBevel
          Left = 496
          Top = 6
          Width = 121
          Height = 64
        end
        object sBevel13: TsBevel
          Left = 377
          Top = 6
          Width = 119
          Height = 64
        end
        object sBevel12: TsBevel
          Left = 256
          Top = 6
          Width = 121
          Height = 64
        end
        object sBevel11: TsBevel
          Left = 135
          Top = 6
          Width = 121
          Height = 64
        end
        object sBevel10: TsBevel
          Left = 16
          Top = 6
          Width = 119
          Height = 64
        end
        object sLabel3: TsLabel
          Left = 29
          Top = 14
          Width = 99
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = #1051'/'#1057
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel4: TsLabel
          Left = 151
          Top = 14
          Width = 94
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = #1053#1072#1095#1072#1083#1086
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel5: TsLabel
          Left = 266
          Top = 14
          Width = 99
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = #1050#1086#1085#1077#1094
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel6: TsLabel
          Left = 502
          Top = 14
          Width = 110
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = #1057#1088#1086#1082' '#1082#1088#1077#1076#1080#1090#1072
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object sLabel7: TsLabel
          Left = 382
          Top = 14
          Width = 110
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1095#1077#1090
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object dbedtLOGIN: TDBEdit
          Left = 28
          Top = 36
          Width = 100
          Height = 24
          DataField = 'LOGIN'
          DataSource = dsRef
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object dbchkLoadBillInBalance_: TDBCheckBox
          Left = 388
          Top = 40
          Width = 97
          Height = 17
          Caption = #1074' '#1073#1072#1083#1072#1085#1089#1077
          DataField = 'LOAD_BILL_IN_BALANCE'
          DataSource = dsRef
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object sBitBtn17: TsBitBtn
          Left = 253
          Top = 77
          Width = 114
          Height = 29
          Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = sBitBtn17Click
          SkinData.SkinSection = 'BUTTON'
          Down = True
          ImageIndex = 7
          Images = Dm.ImageList24
        end
        object sBitBtn18: TsBitBtn
          Left = 373
          Top = 77
          Width = 114
          Height = 29
          Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = sBitBtn18Click
          SkinData.SkinSection = 'BUTTON'
          Down = True
          ImageIndex = 8
          Images = Dm.ImageList24
        end
        object sDateEdit2: TsDateEdit
          Left = 149
          Top = 36
          Width = 96
          Height = 24
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = [fsBold]
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
        end
        object sDateEdit3: TsDateEdit
          Left = 268
          Top = 36
          Width = 96
          Height = 27
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = [fsBold]
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
        end
        object sDateEdit4: TsDateEdit
          Left = 509
          Top = 36
          Width = 96
          Height = 27
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = [fsBold]
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          DefaultToday = True
          DialogTitle = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
        end
      end
    end
    object pnl3: TPanel
      Left = 684
      Top = 0
      Width = 186
      Height = 542
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'pnl3'
      TabOrder = 1
      object crdbgrd1: TCRDBGrid
        Left = 1
        Top = 43
        Width = 184
        Height = 498
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsAccNotBalance
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnl4: TPanel
        Left = 1
        Top = 1
        Width = 184
        Height = 42
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 181
        object sLabel2: TsLabel
          Left = 7
          Top = 9
          Width = 76
          Height = 28
          Alignment = taCenter
          AutoSize = False
          Caption = #1057#1095#1077#1090#1072' '#1085#1077' '#1074' '#1073#1072#1083#1072#1085#1089#1077
          WordWrap = True
        end
        object sBitBtn15: TsBitBtn
          Left = 87
          Top = 5
          Width = 90
          Height = 32
          Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1095#1077#1090#1072' '#1085#1077' '#1074' '#1073#1072#1083#1072#1085#1089#1077
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = sBitBtn15Click
          SkinData.SkinSection = 'BUTTON'
          ImageIndex = 9
          Images = Dm.ImageList24
        end
      end
    end
  end
  object qRef: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE ACCOUNT_LOADED_BILLS'
      'SET'
      
        '  LOAD_BILL_IN_BALANCE = :LOAD_BILL_IN_BALANCE, DATE_BEGIN = :DA' +
        'TE_BEGIN, DATE_END = :DATE_END, DATE_CREDIT_END = :DATE_CREDIT_E' +
        'ND'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID AND YEAR_MONTH = :Old_YEAR_MONTH')
    SQLRefresh.Strings = (
      
        'SELECT ACCOUNT_ID, LOAD_BILL_IN_BALANCE, DATE_BEGIN, DATE_END, D' +
        'ATE_CREDIT_END, USER_LAST_UPDATE, DATE_LAST_UPDATE FROM ACCOUNT_' +
        'LOADED_BILLS'
      'WHERE'
      '  ACCOUNT_ID = :ACCOUNT_ID AND YEAR_MONTH = :YEAR_MONTH')
    SQL.Strings = (
      'SELECT AB.ACCOUNT_ID,'
      '       ACCOUNTS.LOGIN,'
      '       AB.YEAR_MONTH,'
      '       AB.DATE_BEGIN,'
      '       AB.DATE_END,'
      '       AB.DATE_CREDIT_END,'
      '       AB.LOAD_BILL_IN_BALANCE,'
      '       AB.USER_LAST_UPDATE,'
      '       AB.DATE_LAST_UPDATE'
      '  FROM ACCOUNT_LOADED_BILLS AB,'
      '       ACCOUNTS'
      '  WHERE AB.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)'
      '    AND AB.YEAR_MONTH = :YEAR_MONTH')
    FetchRows = 500
    FetchAll = True
    ReadOnly = True
    BeforeOpen = qRefBeforeOpen
    Left = 152
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qRefACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
      Visible = False
    end
    object qRefYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
      Visible = False
    end
    object qRefLOGIN: TStringField
      Alignment = taCenter
      DisplayLabel = #1051'/'#1057
      DisplayWidth = 15
      FieldName = 'LOGIN'
      ReadOnly = True
      Size = 80
    end
    object qRefDATE_BEGIN: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
      Required = True
    end
    object qRefDATE_END: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
      Required = True
    end
    object qRefLOAD_BILL_IN_BALANCE: TFloatField
      DisplayLabel = #1042' '#1073#1072#1083#1072#1085#1089#1077'(1-'#1044#1072', 0-'#1053#1077#1090')'
      FieldName = 'LOAD_BILL_IN_BALANCE'
      Required = True
      Visible = False
    end
    object qRefLoadBillInBalance_: TBooleanField
      Alignment = taCenter
      DisplayLabel = #1042' '#1073#1072#1083#1072#1085#1089#1077
      FieldKind = fkLookup
      FieldName = 'LoadBillInBalance_'
      LookupDataSet = Dm.vt
      LookupKeyFields = 'int'
      LookupResultField = 'bool'
      KeyFields = 'LOAD_BILL_IN_BALANCE'
      OnGetText = qRefLoadBillInBalance_GetText
      Lookup = True
    end
    object qRefDATE_CREDIT_END: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1057#1088#1086#1082' '#1082#1088#1077#1076#1080#1090#1072
      DisplayWidth = 10
      FieldName = 'DATE_CREDIT_END'
      Required = True
    end
    object qRefUSER_LAST_UPDATE: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      DisplayWidth = 20
      FieldName = 'USER_LAST_UPDATE'
      Size = 120
    end
    object qRefDATE_LAST_UPDATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
      DisplayWidth = 19
      FieldName = 'DATE_LAST_UPDATE'
    end
  end
  object dsRef: TDataSource
    DataSet = qRef
    Left = 232
    Top = 96
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'select distinct YEAR_MONTH, CASE substr(YEAR_MONTH,5,2)'
      '   WHEN '#39'01'#39' THEN '#39'  '#1071#1085#1074#1072#1088#1100' - '#39'||substr(YEAR_MONTH,1,4) '
      '   WHEN '#39'02'#39' THEN '#39' '#1060#1077#1074#1088#1072#1083#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'03'#39' THEN '#39'    '#1052#1072#1088#1090' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'04'#39' THEN '#39'  '#1040#1087#1088#1077#1083#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'05'#39' THEN '#39'     '#1052#1072#1081' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'06'#39' THEN '#39'    '#1048#1102#1085#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'07'#39' THEN '#39'    '#1048#1102#1083#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'08'#39' THEN '#39'  '#1040#1074#1075#1091#1089#1090' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'09'#39' THEN '#39#1057#1077#1085#1090#1103#1073#1088#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'10'#39' THEN '#39' '#1054#1082#1090#1103#1073#1088#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'11'#39' THEN '#39'  '#1053#1086#1103#1073#1088#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '   WHEN '#39'12'#39' THEN '#39' '#1044#1077#1082#1072#1073#1088#1100' - '#39'||substr(YEAR_MONTH,1,4)'
      '    END YEAR_MONTH_NAME '
      'from ACCOUNT_LOADED_BILLS ul '
      'GROUP BY YEAR_MONTH'
      'order by YEAR_MONTH desc')
    ReadOnly = True
    Left = 672
    Top = 8
    object qPeriodsYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qPeriodsYEAR_MONTH_NAME: TStringField
      FieldName = 'YEAR_MONTH_NAME'
      Size = 179
    end
  end
  object qAccNotBalance: TOraQuery
    SQL.Strings = (
      
        'SELECT A.LOGIN, TRUNC(T.YEAR_MONTH/100) || '#39' - '#39' || (T.YEAR_MONT' +
        'H - TRUNC(T.YEAR_MONTH/100)*100) YEAR_MONTH'
      '  FROM (SELECT *'
      '          FROM (SELECT B.ACCOUNT_ID, B.YEAR_MONTH'
      '                  FROM DB_LOADER_BILLS B'
      '                  GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH'
      '                UNION ALL  '
      '                SELECT B.ACCOUNT_ID, B.YEAR_MONTH'
      '                  FROM DB_LOADER_FULL_FINANCE_BILL B'
      '                  GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH)'
      '          WHERE (ACCOUNT_ID, YEAR_MONTH) NOT IN '
      '                  (SELECT AB.ACCOUNT_ID, AB.YEAR_MONTH'
      '                     FROM ACCOUNT_LOADED_BILLS AB'
      '                     WHERE AB.LOAD_BILL_IN_BALANCE = 1)'
      '          GROUP BY ACCOUNT_ID, YEAR_MONTH) T, ACCOUNTS A'
      '  WHERE T.ACCOUNT_ID = A.ACCOUNT_ID(+)')
    FetchAll = True
    Left = 928
    Top = 120
    object qAccNotBalanceLOGIN: TStringField
      Alignment = taCenter
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      DisplayWidth = 18
      FieldName = 'LOGIN'
      Size = 120
    end
    object qAccNotBalanceYEAR_MONTH: TStringField
      Alignment = taCenter
      DisplayLabel = #1052#1077#1089#1103#1094
      DisplayWidth = 10
      FieldName = 'YEAR_MONTH'
      Size = 100
    end
  end
  object dsAccNotBalance: TDataSource
    DataSet = qAccNotBalance
    Left = 920
    Top = 184
  end
  object qSetupParamYearMonth: TOraQuery
    SQL.Strings = (
      'update account_loaded_bills'
      '  set DATE_CREDIT_END = :PDATE_CREDIT,'
      '      LOAD_BILL_IN_BALANCE = :PLOAD '
      '  where YEAR_MONTH = :PYEAR_MONTH and ACCOUNT_ID = :PACCOUNT_ID')
    Left = 768
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PDATE_CREDIT'
      end
      item
        DataType = ftUnknown
        Name = 'PLOAD'
      end
      item
        DataType = ftUnknown
        Name = 'PYEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'PACCOUNT_ID'
      end>
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 616
    Top = 4
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      ImageIndex = 7
      ShortCut = 16467
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
      ShortCut = 27
    end
    object aRefresh: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aFind: TAction
      AutoCheck = True
      Caption = #1055#1086#1080#1089#1082
      Hint = #1055#1086#1080#1089#1082' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+G'
      ImageIndex = 15
      ShortCut = 16455
      OnExecute = aFindExecute
    end
    object aFiltr: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+A'
      ImageIndex = 13
      ShortCut = 16449
      OnExecute = aFiltrExecute
    end
    object aNext: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
      OnExecute = aNextExecute
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
      OnExecute = aPrevExecute
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
      OnExecute = aFirstExecute
    end
    object aLast: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 10 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 10 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNextExecute
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  10 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  10 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrevExecute
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcelExecute
    end
    object aInfo: TAction
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Enabled = False
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1073#1086#1085#1077#1085#1090#1077
      ImageIndex = 17
      Visible = False
    end
    object aCheckedAll: TAction
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1089#1095#1077#1090#1072' '#1076#1083#1103' '#1074#1082#1083#1102#1095#1077#1085#1080#1103' '#1074' '#1073#1072#1083#1072#1085#1089
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077' '#1089#1095#1077#1090#1072' '#1089#1088#1072#1079#1091' '#1089' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100#1102' '#1074#1099#1073#1086#1088#1072
      ImageIndex = 49
      OnExecute = aCheckedAllExecute
    end
    object aUncheckedAll: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      Enabled = False
      ImageIndex = 50
    end
  end
end
