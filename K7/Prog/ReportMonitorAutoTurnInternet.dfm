object ReportMonitorAutoTurnInternetFrm: TReportMonitorAutoTurnInternetFrm
  Left = 0
  Top = 0
  Caption = #1052#1086#1085#1080#1090#1086#1088#1080#1085#1075' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
  ClientHeight = 683
  ClientWidth = 1118
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pMain: TPanel
    Left = 0
    Top = 0
    Width = 1118
    Height = 683
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 240
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object PageControlMain: TPageControl
      Left = 0
      Top = 0
      Width = 1118
      Height = 683
      ActivePage = tsDisconnect
      Align = alClient
      BiDiMode = bdLeftToRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      HotTrack = True
      MultiLine = True
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      OnChange = PageControlMainChange
      object tsAlienOpts: TTabSheet
        Caption = #1063#1091#1078#1080#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        object SplitterDop: TSplitter
          Left = 387
          Top = 0
          Height = 637
          Align = alRight
          ExplicitLeft = 380
          ExplicitTop = -8
          ExplicitHeight = 655
        end
        object pAlien: TPanel
          Left = 0
          Top = 0
          Width = 387
          Height = 637
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object gReport: TCRDBGrid
            Left = 0
            Top = 0
            Width = 357
            Height = 637
            Align = alClient
            DataSource = dsReport
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = [fsBold]
            OnDblClick = gReportDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'PHONE'
                Title.Alignment = taCenter
                Title.Caption = #1058#1077#1083#1077#1092#1086#1085
                Width = 67
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CURR_CODE'
                Title.Alignment = taCenter
                Title.Caption = #1058#1077#1082#1091#1097#1072#1103' '#1086#1087#1094#1080#1103
                Width = 93
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ALIEN_CODE'
                Title.Alignment = taCenter
                Title.Caption = #1063#1091#1078#1072#1103' '#1086#1087#1094#1080#1103
                Width = 81
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Phone_active'
                Title.Alignment = taCenter
                Title.Caption = #1057#1090#1072#1090#1091#1089
                Width = 83
                Visible = True
              end>
          end
          object pBtnAlien: TPanel
            Left = 357
            Top = 0
            Width = 30
            Height = 637
            Align = alRight
            BevelOuter = bvLowered
            TabOrder = 1
            object bRefreshAlien: TSpeedButton
              Left = 2
              Top = 77
              Width = 26
              Height = 26
              Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1095#1091#1078#1080#1084' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103#1084' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
              Action = aRefresh
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bLoadInExcelAlien: TSpeedButton
              Left = 2
              Top = 113
              Width = 26
              Height = 26
              Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel '#1076#1072#1085#1085#1099#1077' '#1086' '#1095#1091#1078#1080#1093' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103#1093
              Action = aLoadInExcel
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bTreated: TSpeedButton
              Left = 2
              Top = 149
              Width = 26
              Height = 26
              Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1086#1081
              Action = aTreated
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bAddLogicAlien: TSpeedButton
              Left = 2
              Top = 185
              Width = 26
              Height = 26
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1102' '#1074' '#1083#1086#1075#1080#1082#1091' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
              Action = aAddLogic
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bShowUserStatInfoAlien: TSpeedButton
              Left = 2
              Top = 5
              Width = 26
              Height = 26
              Action = aShowUserStatInfo
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bDetailInfoAlien: TSpeedButton
              Left = 2
              Top = 41
              Width = 26
              Height = 26
              Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1090#1072#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103#1084
              Action = aDetailInfoBtn
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bViewHelpAlien: TSpeedButton
              Left = 2
              Top = 221
              Width = 26
              Height = 26
              Action = aViewHelp
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
          end
        end
        object pDopInfo: TPanel
          Left = 390
          Top = 0
          Width = 720
          Height = 637
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object Splitter1: TSplitter
            Left = 0
            Top = 153
            Width = 720
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitLeft = 1
            ExplicitTop = 127
            ExplicitWidth = 1101
          end
          object Splitter2: TSplitter
            Left = 0
            Top = 299
            Width = 720
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitLeft = 4
            ExplicitTop = 128
            ExplicitWidth = 1101
          end
          object Splitter3: TSplitter
            Left = 0
            Top = 446
            Width = 720
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitTop = 385
            ExplicitWidth = 248
          end
          object pReq: TPanel
            Left = 0
            Top = 156
            Width = 720
            Height = 143
            Align = alTop
            TabOrder = 0
            object Label5: TLabel
              Left = 1
              Top = 1
              Width = 718
              Height = 13
              Align = alTop
              Caption = '  '#1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077'/'#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1091#1089#1083#1091#1075
              Color = clActiveCaption
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 313
            end
            object gReq: TCRDBGrid
              Left = 1
              Top = 14
              Width = 688
              Height = 128
              Align = alClient
              DataSource = dsReq
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = [fsBold]
              Columns = <
                item
                  Expanded = False
                  FieldName = 'OPTION_CODE'
                  Title.Alignment = taCenter
                  Title.Caption = #1050#1086#1076
                  Width = 68
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'OPTION_NAME'
                  Title.Alignment = taCenter
                  Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
                  Width = 89
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'INCLUSION_TYPE'
                  Title.Alignment = taCenter
                  Title.Caption = #1054#1087#1077#1088#1072#1094#1080#1103
                  Width = 94
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EFF_DATE'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1074#1082#1083'./'#1086#1090#1082#1083'.'
                  Width = 116
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'REQUEST_ID'
                  Title.Alignment = taCenter
                  Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1087#1088#1086#1089#1072
                  Width = 95
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'REQUEST_DATE_TIME'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1079#1072#1087#1088#1086#1089#1072
                  Width = 113
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ANSWER'
                  Title.Alignment = taCenter
                  Title.Caption = #1054#1090#1074#1077#1090
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'USER_NAME'
                  Title.Alignment = taCenter
                  Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
                  Width = 89
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'REQUEST_INITIATOR'
                  Title.Alignment = taCenter
                  Title.Caption = #1048#1085#1080#1094#1080#1072#1090#1086#1088
                  Width = 74
                  Visible = True
                end>
            end
            object pBtnReq: TPanel
              Left = 689
              Top = 14
              Width = 30
              Height = 128
              Align = alRight
              BevelOuter = bvLowered
              TabOrder = 1
              object bRefreshReq: TSpeedButton
                Left = 2
                Top = 5
                Width = 26
                Height = 26
                Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1079#1072#1103#1074#1082#1072#1084' '#1085#1072' '#1087#1086#1076#1082#1083'./'#1086#1090#1082#1083'. '#1091#1089#1083#1091#1075
                Action = aRefreshReq
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
              object bLoadInExcelReq: TSpeedButton
                Left = 2
                Top = 36
                Width = 26
                Height = 26
                Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1079#1072#1103#1074#1082#1072#1084' '#1085#1072' '#1087#1086#1076#1082#1083'./'#1086#1090#1082#1083'. '#1091#1089#1083#1091#1075
                Action = aLoadInExcelReq
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
            end
          end
          object pPCKG: TPanel
            Left = 0
            Top = 0
            Width = 720
            Height = 153
            Align = alTop
            TabOrder = 1
            object Label6: TLabel
              Left = 1
              Top = 1
              Width = 718
              Height = 13
              Align = alTop
              Caption = '  '#1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1087#1072#1082#1077#1090#1072#1084
              Color = clActiveCaption
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 124
            end
            object gRemains_PCKG: TCRDBGrid
              Left = 1
              Top = 14
              Width = 688
              Height = 138
              Align = alClient
              DataSource = dsRemains_PCKG
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = [fsBold]
              Columns = <
                item
                  Expanded = False
                  FieldName = 'REST_NAME'
                  Title.Alignment = taCenter
                  Title.Caption = #1055#1072#1082#1077#1090
                  Width = 161
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SOC_NAME'
                  Title.Alignment = taCenter
                  Title.Caption = #1059#1089#1083#1091#1075#1072
                  Width = 185
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SOC'
                  Title.Alignment = taCenter
                  Title.Caption = #1050#1086#1076' '#1091#1089#1083#1091#1075#1080' ('#1074' '#1041#1080#1083#1072#1081#1085#1077')'
                  Width = 156
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SPENT'
                  Title.Alignment = taCenter
                  Title.Caption = #1055#1086#1090#1088#1072#1095#1077#1085#1086
                  Width = 92
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CURR_VALUE'
                  Title.Alignment = taCenter
                  Title.Caption = #1054#1089#1090#1072#1090#1086#1082
                  Width = 78
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'INITIAL_SIZE'
                  Title.Alignment = taCenter
                  Title.Caption = #1042#1089#1077#1075#1086
                  Width = 94
                  Visible = True
                end>
            end
            object pBtnPCKG: TPanel
              Left = 689
              Top = 14
              Width = 30
              Height = 138
              Align = alRight
              BevelOuter = bvLowered
              TabOrder = 1
              object bRefreshPCKG: TSpeedButton
                Left = 2
                Top = 5
                Width = 26
                Height = 26
                Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1087#1072#1082#1077#1090#1072#1084
                Action = aRefreshPCKG
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
              object bLoadInExcelPCKG: TSpeedButton
                Left = 2
                Top = 36
                Width = 26
                Height = 26
                Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' excel '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1087#1072#1082#1077#1090#1086#1074
                Action = aLoadInExcelPCKG
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
            end
          end
          object pTurnConnect: TPanel
            Left = 0
            Top = 302
            Width = 720
            Height = 144
            Align = alTop
            TabOrder = 2
            object Label3: TLabel
              Left = 1
              Top = 1
              Width = 718
              Height = 13
              Align = alTop
              Caption = '  '#1048#1089#1090#1086#1088#1080#1103' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
              Color = clActiveCaption
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 264
            end
            object gTurnLog: TCRDBGrid
              Left = 1
              Top = 14
              Width = 688
              Height = 129
              Align = alClient
              DataSource = dsTurnLog
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = [fsBold]
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PHONE'
                  Title.Alignment = taCenter
                  Title.Caption = #1058#1077#1083#1077#1092#1086#1085
                  Width = 67
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TARIFF_CODE'
                  Title.Alignment = taCenter
                  Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072'/'#1086#1087#1094#1080#1080
                  Width = 118
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DATE_ON'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083'.'
                  Width = 126
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DATE_OFF'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083'.'
                  Width = 118
                  Visible = True
                end>
            end
            object pBtnTurnLog: TPanel
              Left = 689
              Top = 14
              Width = 30
              Height = 129
              Align = alRight
              BevelOuter = bvLowered
              TabOrder = 1
              object bRefreshTurnLog: TSpeedButton
                Left = 2
                Top = 5
                Width = 26
                Height = 26
                Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
                Action = aRefreshTurnLog
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
              object bLoadInExcelTurnLog: TSpeedButton
                Left = 2
                Top = 36
                Width = 26
                Height = 26
                Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1080#1089#1090#1086#1088#1080#1080' '#1087#1086#1076#1082#1083'. '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
                Action = aLoadInExcelTurnLog
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
            end
          end
          object pStatConnect: TPanel
            Left = 0
            Top = 449
            Width = 720
            Height = 188
            Align = alClient
            TabOrder = 3
            object Label4: TLabel
              Left = 1
              Top = 1
              Width = 718
              Height = 13
              Align = alTop
              Caption = '  '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
              Color = clActiveCaption
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 260
            end
            object gStat: TCRDBGrid
              Left = 1
              Top = 14
              Width = 688
              Height = 173
              Align = alClient
              DataSource = dsStat
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = [fsBold]
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PHONE'
                  Title.Alignment = taCenter
                  Title.Caption = #1058#1077#1083#1077#1092#1086#1085
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'TARIFF_CODE'
                  Title.Alignment = taCenter
                  Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072'/'#1086#1087#1094#1080#1080
                  Width = 115
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'INITVALUE'
                  Title.Alignment = taCenter
                  Title.Caption = #1054#1073#1098#1077#1084' '#1085#1072#1095'. '#1090#1088#1072#1092#1080#1082#1072
                  Width = 121
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CURRVALUE'
                  Title.Alignment = taCenter
                  Title.Caption = #1054#1073#1098#1077#1084' '#1090#1077#1082'. '#1090#1088#1072#1092#1080#1082
                  Width = 119
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CURR_CHECK_DATE'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1087#1088#1086#1074#1077#1088#1082#1080
                  Width = 127
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NEXT_CHECK_DATE'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072' '#1089#1083#1077#1076'. '#1087#1088#1086#1074#1077#1088#1082#1080
                  Width = 138
                  Visible = True
                end>
            end
            object pBtnStat: TPanel
              Left = 689
              Top = 14
              Width = 30
              Height = 173
              Align = alRight
              BevelOuter = bvLowered
              TabOrder = 1
              object bRefreshStat: TSpeedButton
                Left = 2
                Top = 5
                Width = 26
                Height = 26
                Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1091' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
                Action = aRefreshStat
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
              object bLoadInExcelStat: TSpeedButton
                Left = 2
                Top = 36
                Width = 26
                Height = 26
                Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1077' '#1080#1089#1087'. '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
                Action = aLoadInExcelStat
                Flat = True
                ParentShowHint = False
                ShowHint = True
              end
            end
          end
        end
      end
      object tsTurnAutoInternet: TTabSheet
        Caption = #1054#1095#1077#1088#1077#1076#1100' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1081' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ImageIndex = 1
        ParentFont = False
        object pTurnAutoConnectInet: TPanel
          Left = 0
          Top = 0
          Width = 1110
          Height = 637
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object pBtnTurnAutoConnectInet: TPanel
            Left = 1080
            Top = 0
            Width = 30
            Height = 620
            Align = alRight
            BevelOuter = bvLowered
            TabOrder = 0
            object bRefreshTurnConnect: TSpeedButton
              Left = 2
              Top = 77
              Width = 26
              Height = 26
              Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1087#1088#1086#1074#1077#1088#1082#1077' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
              Action = aRefresh
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bLoadInExcelTurnConnect: TSpeedButton
              Left = 2
              Top = 113
              Width = 26
              Height = 26
              Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
              Action = aLoadInExcel
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bStartCheckConnectPCKG: TSpeedButton
              Left = 2
              Top = 149
              Width = 26
              Height = 26
              Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1085#1072' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1087#1086' '#1085#1086#1084#1077#1088#1091
              Action = aStartCheckConnectPCKG
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bStartCheckConnectPCKGAll: TSpeedButton
              Left = 2
              Top = 185
              Width = 26
              Height = 26
              Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1085#1072' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1087#1086' '#1074#1089#1077#1084' '#1085#1086#1084#1077#1088#1072#1084
              Action = aStartCheckConnectPCKGAll
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bShowUserStatInfoTurnCon: TSpeedButton
              Left = 2
              Top = 5
              Width = 26
              Height = 26
              Action = aShowUserStatInfo
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bDetailInfoTurnCon: TSpeedButton
              Left = 3
              Top = 41
              Width = 26
              Height = 26
              Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1090#1072#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103#1084
              Action = aDetailInfoBtn
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bViewHelp: TSpeedButton
              Left = 2
              Top = 257
              Width = 26
              Height = 26
              Action = aViewHelp
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
            object bAddLogicTurn: TSpeedButton
              Left = 2
              Top = 221
              Width = 26
              Height = 26
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1102' '#1074' '#1083#1086#1075#1080#1082#1091' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
              Action = aAddLogic
              Flat = True
              ParentShowHint = False
              ShowHint = True
            end
          end
          object gTurnAutoConnectInet: TCRDBGrid
            Left = 0
            Top = 0
            Width = 1080
            Height = 620
            Align = alClient
            DataSource = dsTurnAutoConnectInet
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = [fsBold]
            OnDblClick = gTurnAutoConnectInetDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'phone'
                Title.Alignment = taCenter
                Title.Caption = #1058#1077#1083#1077#1092#1086#1085
                Width = 86
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'next_check_date'
                Title.Alignment = taCenter
                Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1087#1088#1086#1074#1077#1088#1082#1080
                Width = 183
                Visible = True
              end>
          end
          object ProgressBar: TProgressBar
            Left = 0
            Top = 620
            Width = 1110
            Height = 17
            Align = alBottom
            TabOrder = 2
          end
        end
      end
      object tsSelectionOptions: TTabSheet
        Caption = #1055#1086#1076#1073#1086#1088' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1080
        ImageIndex = 2
        object pBtnSelect: TPanel
          Left = 1080
          Top = 41
          Width = 30
          Height = 596
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 0
          object bViewHelpSelectOpt: TSpeedButton
            Left = 3
            Top = 5
            Width = 26
            Height = 26
            Action = aViewHelp
            Flat = True
          end
        end
        object pPhone: TPanel
          Left = 0
          Top = 0
          Width = 1110
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object edtPhone: TEdit
            Left = 12
            Top = 11
            Width = 109
            Height = 21
            TabOrder = 0
          end
          object bSelectOptions: TBitBtn
            Left = 127
            Top = 10
            Width = 196
            Height = 25
            Action = aSelectOptions
            Caption = #1055#1086#1076#1086#1073#1088#1072#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1102
            TabOrder = 1
          end
        end
        object mSelectOptions: TMemo
          Left = 0
          Top = 41
          Width = 1080
          Height = 596
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
      end
      object tsConfines: TTabSheet
        Caption = #1053#1086#1084#1077#1088#1072' '#1089' GPRS_U '#1080' SPEED3B2B'
        ImageIndex = 3
        object gConfines: TCRDBGrid
          Left = 0
          Top = 0
          Width = 1080
          Height = 637
          Align = alClient
          DataSource = dsConfines
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
          OnDblClick = gConfinesDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'PHONE'
              Title.Alignment = taCenter
              Title.Caption = #1058#1077#1083#1077#1092#1086#1085
              Width = 69
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TARIFF_CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1080
              Width = 134
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONE_ACTIVE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 118
              Visible = True
            end>
        end
        object pBtnConfines: TPanel
          Left = 1080
          Top = 0
          Width = 30
          Height = 637
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 1
          object bShowUserStatInfoConf: TSpeedButton
            Left = 2
            Top = 5
            Width = 26
            Height = 26
            Action = aShowUserStatInfo
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bRefreshConf: TSpeedButton
            Left = 2
            Top = 41
            Width = 26
            Height = 26
            Action = aRefresh
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bLoadInExcelConf: TSpeedButton
            Left = 2
            Top = 77
            Width = 26
            Height = 26
            Action = aLoadInExcel
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bViewHelpConf: TSpeedButton
            Left = 3
            Top = 113
            Width = 26
            Height = 26
            Action = aViewHelp
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
        end
      end
      object tsDisconnect: TTabSheet
        Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
        ImageIndex = 4
        object gDisconnect: TCRDBGrid
          Left = 0
          Top = 97
          Width = 1080
          Height = 540
          Align = alClient
          DataSource = dsDisconnect
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
          OnDblClick = gDisconnectDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'PHONE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1088
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE_OPT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076' '#1086#1087#1094#1080#1080
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACTIVE_PHONE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 104
              Visible = True
            end>
        end
        object pBtnDisconnect: TPanel
          Left = 1080
          Top = 97
          Width = 30
          Height = 540
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 1
          ExplicitTop = 43
          ExplicitHeight = 594
          object bShowUserStatInfoDis: TSpeedButton
            Left = 2
            Top = 5
            Width = 26
            Height = 26
            Action = aShowUserStatInfo
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bRefreshDis: TSpeedButton
            Left = 2
            Top = 41
            Width = 26
            Height = 26
            Action = aRefresh
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bLoadInExcelDis: TSpeedButton
            Left = 2
            Top = 77
            Width = 26
            Height = 26
            Action = aLoadInExcel
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bViewHelpDis: TSpeedButton
            Left = 3
            Top = 113
            Width = 26
            Height = 26
            Action = aViewHelp
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bTurnOffPhoneError: TSpeedButton
            Left = 2
            Top = 149
            Width = 26
            Height = 26
            Action = aTurnOffPhoneError
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
        end
        object pStatusWorkJob: TPanel
          Left = 0
          Top = 0
          Width = 1110
          Height = 97
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object lbState: TLabel
            Left = 12
            Top = 18
            Width = 43
            Height = 13
            Caption = #1057#1090#1072#1090#1091#1089': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbTimeWork: TLabel
            Left = 732
            Top = 19
            Width = 107
            Height = 13
            Caption = #1052#1072#1082#1089'. '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbStatus: TLabel
            Left = 327
            Top = 19
            Width = 122
            Height = 13
            Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbInfo: TLabel
            Left = 0
            Top = 0
            Width = 1110
            Height = 13
            Align = alTop
            Caption = ' '#1056#1072#1073#1086#1090#1072' '#1087#1086#1090#1086#1082#1086#1074' '#1084#1077#1093#1072#1085#1080#1079#1084#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
            ExplicitWidth = 336
          end
          object lbStart: TLabel
            Left = 58
            Top = 18
            Width = 56
            Height = 13
            Caption = #1079#1072#1087#1091#1097#1077#1085#1085#1086
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbNoStart: TLabel
            Left = 58
            Top = 36
            Width = 71
            Height = 13
            Caption = #1085#1077' '#1079#1072#1087#1091#1097#1077#1085#1085#1086
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbWorked: TLabel
            Left = 58
            Top = 54
            Width = 66
            Height = 13
            Caption = #1086#1090#1088#1072#1073#1086#1090#1072#1085#1085#1086
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbResNoError: TLabel
            Left = 455
            Top = 19
            Width = 58
            Height = 13
            Caption = #1073#1077#1079' '#1086#1096#1080#1073#1086#1082
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbResError: TLabel
            Left = 455
            Top = 38
            Width = 58
            Height = 13
            Caption = #1089' '#1086#1096#1080#1073#1082#1072#1084#1080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbNoRes: TLabel
            Left = 455
            Top = 54
            Width = 82
            Height = 13
            Caption = #1085#1077' '#1074#1099#1087#1086#1083#1085#1103#1083#1080#1089#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbCountStream: TLabel
            Left = 732
            Top = 38
            Width = 165
            Height = 13
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1090#1086#1082#1086#1074' '#1084#1077#1093#1072#1085#1080#1079#1084#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbRepeat: TLabel
            Left = 12
            Top = 78
            Width = 434
            Height = 13
            Caption = 
              #1056#1072#1073#1086#1090#1072' '#1084#1077#1093#1072#1085#1080#1079#1084#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081' '#1085#1072' '#1085#1086#1084#1077#1088#1072#1093' '#1089' '#1086#1096#1080#1073#1082#1072#1084#1080 +
              ' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbCountLog: TLabel
            Left = 455
            Top = 78
            Width = 158
            Height = 13
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1087#1099#1090#1086#1082' '#1088#1072#1073#1086#1090#1099' - '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbCountLogNoErr: TLabel
            Left = 676
            Top = 78
            Width = 125
            Height = 13
            Caption = #1059#1076#1072#1095#1085#1086' '#1086#1090#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' - '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbCountLogErr: TLabel
            Left = 888
            Top = 78
            Width = 50
            Height = 13
            Caption = #1054#1096#1080#1073#1086#1082' - '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
      end
      object tsErrorConnectPCKG: TTabSheet
        Caption = #1054#1096#1080#1073#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
        ImageIndex = 5
        object gErrorConnectPCKG: TCRDBGrid
          Left = 0
          Top = 0
          Width = 1080
          Height = 620
          Align = alClient
          DataSource = dsErrorConnectPCKG
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = gErrorConnectPCKGDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'PHONE'
              Title.Alignment = taCenter
              Title.Caption = #1058#1077#1083#1077#1092#1086#1085
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE_OPT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076' '#1086#1087#1094#1080#1080
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 83
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOAD_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACTIVE_PHONE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RESPONSE'
              Title.Alignment = taCenter
              Title.Caption = #1054#1096#1080#1073#1082#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 692
              Visible = True
            end>
        end
        object pBtnErrorConnectPCKG: TPanel
          Left = 1080
          Top = 0
          Width = 30
          Height = 620
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 1
          object bShowUserStatInfoErr: TSpeedButton
            Left = 2
            Top = 5
            Width = 26
            Height = 26
            Action = aShowUserStatInfo
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bRefreshErr: TSpeedButton
            Left = 2
            Top = 41
            Width = 26
            Height = 26
            Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1096#1080#1073#1082#1072#1084' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
            Action = aRefresh
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bLoadInExcelErr: TSpeedButton
            Left = 2
            Top = 77
            Width = 26
            Height = 26
            Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel '#1076#1072#1085#1085#1099#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1072#1093' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
            Action = aLoadInExcel
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bViewHelpErr: TSpeedButton
            Left = 3
            Top = 185
            Width = 26
            Height = 26
            Action = aViewHelp
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bHandleErrorConnectPhone: TSpeedButton
            Left = 3
            Top = 113
            Width = 26
            Height = 26
            Action = aHandleErrorConnectPhone
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
          object bHandleErrorConnectAll: TSpeedButton
            Left = 3
            Top = 149
            Width = 26
            Height = 26
            Action = aHandleErrorConnectAll
            Flat = True
            ParentShowHint = False
            ShowHint = True
          end
        end
        object prbErrConnectPCKG: TProgressBar
          Left = 0
          Top = 620
          Width = 1110
          Height = 17
          Align = alBottom
          TabOrder = 2
        end
      end
    end
  end
  object aList: TActionList
    Images = MainForm.ImageList24
    Left = 312
    Top = 144
    object aShowUserStatInfo: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1085#1086#1084#1077#1088#1091
      ImageIndex = 22
      OnExecute = aShowUserStatInfoExecute
    end
    object aDetailInfoBtn: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 11
      OnExecute = aDetailInfoBtnExecute
    end
    object aRefresh: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aRefreshPCKG: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 9
      OnExecute = aRefreshPCKGExecute
    end
    object aRefreshReq: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 9
      OnExecute = aRefreshReqExecute
    end
    object aRefreshTurnLog: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 9
      OnExecute = aRefreshTurnLogExecute
    end
    object aRefreshStat: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 9
      OnExecute = aRefreshStatExecute
    end
    object aLoadInExcel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 12
      OnExecute = aLoadInExcelExecute
    end
    object aLoadInExcelPCKG: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 12
      OnExecute = aLoadInExcelPCKGExecute
    end
    object aLoadInExcelReq: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 12
      OnExecute = aLoadInExcelReqExecute
    end
    object aLoadInExcelTurnLog: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 12
      OnExecute = aLoadInExcelTurnLogExecute
    end
    object aLoadInExcelStat: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 12
      OnExecute = aLoadInExcelStatExecute
    end
    object aTreated: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 23
      OnExecute = aTreatedExecute
    end
    object aAddLogic: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 4
      OnExecute = aAddLogicExecute
    end
    object aStartCheckConnectPCKG: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 7
      OnExecute = aStartCheckConnectPCKGExecute
    end
    object aStartCheckConnectPCKGAll: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 25
      OnExecute = aStartCheckConnectPCKGAllExecute
    end
    object aViewHelp: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1089#1087#1088#1072#1074#1082#1091
      ImageIndex = 28
      OnExecute = aViewHelpExecute
    end
    object aSelectOptions: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1055#1086#1076#1086#1073#1088#1072#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1102
      OnExecute = aSelectOptionsExecute
    end
    object aHandleErrorConnectPhone: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1086#1096#1080#1073#1082#1091' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1085#1072' '#1085#1086#1084#1077#1088#1077
      ImageIndex = 7
      OnExecute = aHandleErrorConnectPhoneExecute
    end
    object aHandleErrorConnectAll: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1074#1089#1077' '#1086#1096#1080#1073#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      ImageIndex = 25
      OnExecute = aHandleErrorConnectAllExecute
    end
    object aTurnOffPhoneError: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
      ImageIndex = 25
      OnExecute = aTurnOffPhoneErrorExecute
    end
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'select '
      '  v.phone, '
      '  v.CURR_CODE, '
      '  v.ALIEN_CODE, '
      '  v.Cnt_Phone,'
      '  ('
      '    select '
      '          case'
      '            when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '              case'
      '                when nvl(DB.CONSERVATION,0) = 1 then'
      '                  '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '                else '
      '                  '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '              end'
      '            else'
      '              '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '          end'
      '      from DB_LOADER_ACCOUNT_PHONES db'
      '    where DB.PHONE_NUMBER = v.phone'
      '        and DB.YEAR_MONTH = ('
      '                               select max(DBM.YEAR_MONTH)'
      
        '                                 from DB_LOADER_ACCOUNT_PHONES d' +
        'bm'
      
        '                                where DBM.PHONE_NUMBER = DB.PHON' +
        'E_NUMBER'
      '                            )'
      '  ) Phone_active'
      'from'
      '('
      '    select '
      '      op.phone, '
      '      OP.CURR_CODE, '
      '      OP.ALIEN_CODE, '
      '      count(*) Cnt_Phone'
      '    from GPRS_ALIEN_OPTS op'
      '    where OP.IS_CHECKED = 0'
      '    group by op.phone, OP.ALIEN_CODE, OP.CURR_CODE'
      ') v'
      'order by Phone_active')
    AfterScroll = qReportAfterScroll
    Left = 32
    Top = 152
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 88
    Top = 152
  end
  object qTurnLog: TOraQuery
    SQL.Strings = (
      'select '
      '  LOG_ID, PHONE, TARIFF_CODE, '
      
        '  to_date(to_char(DATE_ON, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYYY' +
        ' HH24:MI:SS'#39') DATE_ON, '
      
        '  to_date(to_char(DATE_OFF, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYY' +
        'Y HH24:MI:SS'#39') DATE_OFF  '
      'from gprs_turn_log'
      'where phone = :p_phone'
      'order by log_id desc')
    BeforeOpen = qTurnLogBeforeOpen
    AfterScroll = qTurnLogAfterScroll
    Left = 912
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end>
  end
  object dsTurnLog: TDataSource
    DataSet = qTurnLog
    Left = 968
    Top = 352
  end
  object qStat: TOraQuery
    SQL.Strings = (
      'select '
      '  STAT_ID, PHONE, TARIFF_CODE, '
      '  INITVALUE, CURRVALUE, '
      
        '  to_date(to_char(CURR_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') CURR_CHECK_DATE, '
      
        '  to_date(to_char(NEXT_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') NEXT_CHECK_DATE, '
      '  CTRL_PNT, IS_CHECKED, TURN_LOG_ID'
      'from gprs_stat '
      'where phone = :p_phone'
      'and turn_log_id = :pturn_log_id'
      'order by stat_id desc')
    BeforeOpen = qStatBeforeOpen
    Left = 928
    Top = 552
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end
      item
        DataType = ftUnknown
        Name = 'pturn_log_id'
      end>
  end
  object dsStat: TDataSource
    DataSet = qStat
    Left = 976
    Top = 552
  end
  object qReportUpdate: TOraQuery
    SQL.Strings = (
      'update GPRS_ALIEN_OPTS al'
      'set AL.IS_CHECKED = :pIS_CHECKED'
      'where AL.phone = :p_phone'
      'and AL.ALIEN_CODE = :pALIEN_CODE'
      'and al.CURR_CODE = :pCURR_CODE'
      'and AL.IS_CHECKED = 0')
    Left = 160
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pIS_CHECKED'
      end
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end
      item
        DataType = ftUnknown
        Name = 'pALIEN_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'pCURR_CODE'
      end>
  end
  object qTurnAutoConnectInet: TOraQuery
    SQL.Strings = (
      'select * '
      ' from '
      ' ('
      '    select '
      '        phone,'
      
        '        to_date(to_char(max(next_check_date), '#39'DD.MM.YYYY HH24:M' +
        'I:SS'#39'), '#39'DD.MM.YYYY HH24:MI:SS'#39') next_check_date'
      '      from gprs_stat'
      '    where is_checked=0 '
      '        and TARIFF_CODE<>'#39'GPRS_U'#39'    '
      '    group by phone, next_check_date'
      '    having max(next_check_date) < sysdate-2/24'
      ' ) ph'
      
        'where nvl((select count(1) from mnp_remove mnp where mnp.temp_ph' +
        'one_number=ph.phone and mnp.date_created>=sysdate-1),0)=0 -- '#1085#1077' ' +
        'MNP       '
      
        '   and nvl((select phone_is_active from db_loader_account_phones' +
        ' where phone_number=ph.phone and year_month=to_char(sysdate,'#39'yyy' +
        'ymm'#39')),0)=1 -- '#1085#1077' '#1079#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
      '    -- '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1085#1086#1084#1077#1088#1072' '#1089' '#1072#1074#1090#1086#1080#1085#1090#1077#1085#1077#1090' '#1090#1072#1088#1080#1092#1086#1084
      '   and exists'
      '        ('
      '          select 1'
      '            from v_contracts ct,'
      '                    tariffs tf'
      '          where CT.PHONE_NUMBER_FEDERAL=phone'
      '             and  CT.CONTRACT_CANCEL_DATE is null'
      '             and  TF.TARIFF_ID=CT.TARIFF_ID'
      '             and  TF.IS_AUTO_INTERNET = 1'
      '        )      '
      'order by next_check_date desc')
    AfterScroll = qTurnAutoConnectInetAfterScroll
    Left = 64
    Top = 224
  end
  object dsTurnAutoConnectInet: TDataSource
    DataSet = qTurnAutoConnectInet
    Left = 200
    Top = 224
  end
  object spGprsCheckPhoneTariff: TOraStoredProc
    StoredProcName = 'beeline_rest_api_pckg.gprs_check_phone_tariff'
    SQL.Strings = (
      'begin'
      '  beeline_rest_api_pckg.gprs_check_phone_tariff(:P_PHONE);'
      'end;')
    Left = 64
    Top = 296
    ParamData = <
      item
        DataType = ftString
        Name = 'P_PHONE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'beeline_rest_api_pckg.gprs_check_phone_tariff'
  end
  object qTariffCode: TOraQuery
    SQL.Strings = (
      'select TR.TARIFF_CODE'
      'from v_contracts v,'
      '        tariffs tr'
      'where V.TARIFF_ID = TR.TARIFF_ID'
      'and V.CONTRACT_CANCEL_DATE IS NULL'
      'and V.PHONE_NUMBER_FEDERAL = :PHONE_NUMBER'
      'and nvl(TR.IS_AUTO_INTERNET, 0) = 1')
    Left = 240
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qRemains_PCKG: TOraQuery
    SQL.Strings = (
      'select '
      ' UNIT_TYPE'
      ' ,REST_TYPE'
      ' ,INITIAL_SIZE'
      ' ,CURR_VALUE'
      ' ,case '
      
        '    when (INITIAL_SIZE - CURR_VALUE) > INITIAL_SIZE then INITIAL' +
        '_SIZE'
      '    else'
      '      (INITIAL_SIZE - CURR_VALUE)'
      '   end SPENT'
      ' ,NEXT_VALUE'
      ' ,FREQUENCY '
      ' ,SOC       '
      ' ,SOC_NAME'
      ' ,REST_NAME  from table (TARIFF_RESTS_TABLE(:p_phone))')
    BeforeOpen = qRemains_PCKGBeforeOpen
    Left = 720
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end>
  end
  object qReq: TOraQuery
    SQL.Strings = (
      'select tol.PHONE_NUMBER, '
      '       tol.OPTION_CODE,'
      '       opt.OPTION_NAME,'
      '       case'
      '         when tol.INCLUSION_TYPE = '#39'A'#39' then '#39#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077#39
      '         when tol.INCLUSION_TYPE = '#39'D'#39' then '#39#1054#1090#1082#1083#1102#1095#1077#1085#1080#1077#39
      '         else '#39#1054#1096#1080#1073#1082#1072#39
      '       end INCLUSION_TYPE,'
      '       nvl(tol.EFF_DATE, tol.REQUEST_DATE_TIME) EFF_DATE,'
      '       tol.REQUEST_ID, '
      '       tol.REQUEST_DATE_TIME,'
      '       case'
      '         when bt.ANSWER = 1 then '#39#1042#1099#1087#1086#1083#1085#1077#1085#1086#39
      '         when bt.ANSWER = 0 then '#39#1054#1090#1082#1072#1079#1072#1085#1086#39
      '         else '#39#1042' '#1087#1088#1086#1094#1077#1089#1089#1077#39'  '
      '       end ANSWER,'
      '       tol.USER_NAME,'
      '       case'
      
        '         when tol.REQUEST_INITIATOR = '#39'RETARIF'#39' then '#39#1040#1074#1090#1086#1054#1087#1077#1088#1072#1094 +
        #1080#1103#39
      '         else '#39#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#39
      '       end REQUEST_INITIATOR'
      '  from TARIFF_OPTIONS_REQ_LOG tol, '
      '       BEELINE_TICKETS bt,'
      '       tariff_options opt'
      '  where tol.PHONE_NUMBER = :PHONE_NUMBER'
      '    and tol.REQUEST_ID = bt.TICKET_ID(+)'
      '    and tol.OPTION_CODE = opt.OPTION_CODE(+)'
      '    and ((tol.request_initiator <> '#39'RETARIF'#39') or (:RETARIF = 1))'
      '    /*and not exists (select 1'
      '                      from ROAMING_RETARIF_PHONES rrp'
      
        '                      where tol.REQUEST_ID = rrp.SERVICE_ON_TICK' +
        'ET_ID'
      
        '                        or tol.REQUEST_ID = rrp.SERVICE_OFF_TICK' +
        'ET_ID)*/'
      '  order by tol.REQUEST_DATE_TIME desc')
    BeforeOpen = qReqBeforeOpen
    Left = 912
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'RETARIF'
      end>
  end
  object dsRemains_PCKG: TDataSource
    DataSet = qRemains_PCKG
    Left = 808
    Top = 256
  end
  object dsReq: TDataSource
    DataSet = qReq
    Left = 984
    Top = 208
  end
  object qSelectionOpt: TOraQuery
    SQL.Strings = (
      'select SELECTION_OPTION_AUTO_CONNECT(:p_phone) v_data from dual')
    Left = 312
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end>
  end
  object qFile: TOraQuery
    SQL.Strings = (
      'select FILE_CLB, DATE_LAST_UPDATED'
      'from DEPOSITORY_FILE'
      'where file_name = '#39'HELP_FILE'#39)
    Left = 352
    Top = 144
  end
  object qConfines: TOraQuery
    SQL.Strings = (
      'select '
      '  GP.PHONE,'
      '  GP.TARIFF_CODE,'
      '  ('
      '     select'
      '          case'
      '            when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '              case'
      '                when nvl(DB.CONSERVATION,0) = 1 then'
      '                  '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '                else '
      '                  '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '              end'
      '            else'
      '              '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '          end'
      '      from DB_LOADER_ACCOUNT_PHONES db'
      '    where DB.PHONE_NUMBER = gp.phone'
      
        '        and DB.YEAR_MONTH = to_number(to_char(sysdate, '#39'YYYYMM'#39')' +
        ')'
      '  ) PHONE_ACTIVE'
      'from gprs_turn_log gp'
      'where GP.DATE_OFF is null'
      'and GP.TARIFF_CODE = '#39'GPRS_U'#39
      'and 2 = ('
      '           select count(*)'
      
        '             from table(corp_mobile.beeline_rest_api_pckg.get_se' +
        'rviceList(gp.PHONE))'
      '            where name = '#39'SPEED3B2B'#39
      '               or name = '#39'GPRS_U'#39
      '        )')
    Left = 48
    Top = 384
  end
  object dsConfines: TDataSource
    DataSet = qConfines
    Left = 120
    Top = 384
  end
  object qDisconnect: TOraQuery
    SQL.Strings = (
      'select '
      '  rs.phone,'
      
        '  substr(RS.REQUEST,  instr(RS.REQUEST, '#39'Tariff:'#39')+Length('#39'Tarif' +
        'f: '#39'),  (instr(RS.REQUEST, '#39'User:'#39')-3)-(instr(RS.REQUEST, '#39'Tarif' +
        'f:'#39')+Length('#39'Tariff: '#39'))) code_opt,'
      '  ('
      '       select '
      '          case'
      '            when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '              case'
      '                when nvl(DB.CONSERVATION,0) = 1 then'
      '                  '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '                else '
      '                  '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '              end'
      '            else'
      '              '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '          end'
      '      from DB_LOADER_ACCOUNT_PHONES db'
      '    where DB.PHONE_NUMBER = rs.phone'
      '        and DB.YEAR_MONTH = ('
      
        '                                              select max(DBM.YEA' +
        'R_MONTH)'
      
        '                                                from DB_LOADER_A' +
        'CCOUNT_PHONES dbm'
      
        '                                              where DBM.PHONE_NU' +
        'MBER = DB.PHONE_NUMBER'
      '                                           )'
      '  ) ACTIVE_PHONE                                          '
      'from db_loader_resp_log rs'
      'where RS.NOTE = '#39'gprs_opts_turn_off_all_phones - End of month.'#39
      'and trunc(RS.LOAD_DATE) = trunc(sysdate)'
      'and ('
      '         upper(rs.message) like ('#39'%ERR%'#39') or'
      '         upper(rs.status)  like ('#39'%ERR%'#39')'
      '      )'
      'and RS.LOAD_DATE = ('
      '                                    select max(RS1.LOAD_DATE)'
      
        '                                      from db_loader_resp_log rs' +
        '1'
      '                                    where RS1.PHONE = RS.PHONE'
      
        '                                        and RS1.NOTE = '#39'gprs_opt' +
        's_turn_off_all_phones - End of month.'#39
      '                                        and ('
      
        '                                                 upper(rs1.messa' +
        'ge) like ('#39'%ERR%'#39') or'
      
        '                                                 upper(rs1.statu' +
        's)  like ('#39'%ERR%'#39')'
      '                                              )'
      '                                 )'
      'and not exists ('
      '                         select 1'
      '                           from db_loader_resp_log rs2'
      '                         where RS2.PHONE = RS.PHONE'
      
        '                             and RS2.NOTE = '#39'gprs_opts_turn_off_' +
        'all_phones - End of month.'#39
      
        '                             and upper(rs2.message) not like ('#39'%' +
        'ERR%'#39')'
      '                             and RS2.LOAD_DATE > RS.LOAD_DATE  '
      '                     )')
    Left = 48
    Top = 448
  end
  object dsDisconnect: TDataSource
    DataSet = qDisconnect
    Left = 120
    Top = 448
  end
  object spAddLogic: TOraStoredProc
    StoredProcName = 'ADD_OPT_IN_AUTO_CONNECT_INET'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := ADD_OPT_IN_AUTO_CONNECT_INET(:P_PHONE, :P_TARIFF_CO' +
        'DE);'
      'end;')
    Left = 168
    Top = 296
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptResult
        Value = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086' '#1091#1082#1072#1079#1072#1085#1099' '#1085#1086#1084#1077#1088' '#1080' '#1082#1086#1076' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1080'!'
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'P_PHONE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_TARIFF_CODE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'ADD_OPT_IN_AUTO_CONNECT_INET'
  end
  object qWORK_J_GPRS_CHECK_FLOW_TURN_OFF: TOraQuery
    SQL.Strings = (
      'select'
      '  jb.state,'
      '  trunc(cast(jb.last_start_date as date)) last_start_date,'
      '  jb.last_run_duration,'
      '  ('
      '        select dt.status'
      '          from USER_SCHEDULER_JOB_RUN_DETAILS dt'
      '        where dt.job_name = jb.job_name'
      '            and dt.owner = jb.owner'
      '            and dt.actual_start_date = ('
      
        '                                                      select max' +
        '(RS.ACTUAL_START_DATE)'
      
        '                                                        from USE' +
        'R_SCHEDULER_JOB_RUN_DETAILS rs'
      
        '                                                       where RS.' +
        'JOB_NAME = dt.job_name'
      
        '                                                         and rs.' +
        'owner = dt.owner'
      '                                                   )'
      '  ) status'
      'from DBA_SCHEDULER_JOBS jb'
      'where jb.job_name like '#39'J_GPRS_CHECK_FLOW_1_TURN_OFF%'#39
      'and jb.owner = '#39'CORP_MOBILE'#39)
    Left = 120
    Top = 512
  end
  object qErrorConnectPCKG: TOraQuery
    SQL.Strings = (
      'select '
      
        '     to_date(to_char(LG.LOAD_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') LOAD_DATE, '
      '     LG.PHONE, '
      
        '     substr(lg.REQUEST,  instr(lg.REQUEST, '#39'Tariff:'#39')+Length('#39'Ta' +
        'riff: '#39'),  (instr(lg.REQUEST, '#39'User:'#39')-3)-(instr(lg.REQUEST, '#39'Ta' +
        'riff:'#39')+Length('#39'Tariff: '#39'))) code_opt,'
      '     to_char(LG.RESPONSE) RESPONSE,'
      '     ('
      '        select '
      '              case'
      '                when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '                  case'
      '                    when nvl(DB.CONSERVATION,0) = 1 then'
      '                      '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '                    else '
      '                      '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '                  end'
      '                else'
      '                  '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '              end'
      '          from DB_LOADER_ACCOUNT_PHONES db'
      '        where DB.PHONE_NUMBER = lg.phone'
      '            and DB.YEAR_MONTH = ('
      
        '                                                  select max(DBM' +
        '.YEAR_MONTH)'
      
        '                                                    from DB_LOAD' +
        'ER_ACCOUNT_PHONES dbm'
      
        '                                                  where DBM.PHON' +
        'E_NUMBER = DB.PHONE_NUMBER'
      '                                               )'
      '     ) ACTIVE_PHONE'
      '  from db_loader_resp_log lg'
      'where LG.NOTE = '#39'gprs_check_turn_tariff'#39
      '    and UPPER(LG.MESSAGE) like '#39'%ERROR%'#39
      '    and UPPER(LG.MESSAGE) not like '#39'%OFF%'#39'   '
      '    and LG.LOG_ID = ('
      '                                 select max(RS.LOG_ID)'
      '                                   from db_loader_resp_log rs'
      '                                 where rs.NOTE = LG.NOTE'
      '                                     and rs.MESSAGE = LG.MESSAGE'
      '                                     and RS.PHONE = LG.PHONE'
      
        '                                     --and RS.REQUEST = LG.REQUE' +
        'ST'
      '                              )'
      '    and not exists ('
      '                            select 1'
      '                              from db_loader_resp_log db'
      '                            where DB.PHONE = LG.PHONE'
      
        '                                --and DB.REQUEST = LG.REQUEST --' +
        #1084#1086#1075#1083#1080' '#1087#1086#1076#1082#1083#1102#1095#1080#1090#1100' '#1076#1088#1091#1075#1086#1081' '#1087#1072#1082#1077#1090
      '                                and DB.NOTE = LG.NOTE'
      
        '                                and UPPER(DB.MESSAGE) not like '#39 +
        '%ERROR%'#39
      
        '                                and UPPER(DB.MESSAGE) not like '#39 +
        '%OFF%'#39'  '
      '                                and DB.LOAD_DATE > LG.LOAD_DATE'
      '                         )'
      '    and not exists ('
      '                      select 1'
      '                        from DB_LOADER_ACCOUNT_PHONE_OPTS op'
      '                       where OP.PHONE_NUMBER = LG.PHONE'
      
        '                         and OP.YEAR_MONTH = to_number(to_char(s' +
        'ysdate, '#39'YYYYMM'#39'))'
      
        '                         and OP.OPTION_CODE = substr(lg.REQUEST,' +
        '  instr(lg.REQUEST, '#39'Tariff:'#39')+Length('#39'Tariff: '#39'),  (instr(lg.RE' +
        'QUEST, '#39'User:'#39')-3)-(instr(lg.REQUEST, '#39'Tariff:'#39')+Length('#39'Tariff:' +
        ' '#39')))'
      
        '                         and ((OP.TURN_OFF_DATE is null) OR ((OP' +
        '.TURN_OFF_DATE is not null) AND (OP.TURN_OFF_DATE > sysdate)))'
      '                   )'
      '    /*and not exists ('
      '                      select 1'
      '                        from phone_gprs_u_201601'
      '                       where phone_number = LG.PHONE'
      '                   )*/'
      '    order by LG.LOAD_DATE desc')
    Left = 40
    Top = 584
  end
  object dsErrorConnectPCKG: TDataSource
    DataSet = qErrorConnectPCKG
    Left = 136
    Top = 584
  end
  object spHandleErrorConnect: TOraStoredProc
    StoredProcName = 'HANDLE_ERR_AUTOCONNECT_INET_PH'
    SQL.Strings = (
      'begin'
      '  HANDLE_ERR_AUTOCONNECT_INET_PH(:PPHONE_NUMBER);'
      'end;')
    Left = 256
    Top = 584
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'HANDLE_ERR_AUTOCONNECT_INET_PH'
  end
  object spTurnOffPhoneError: TOraStoredProc
    StoredProcName = 'BEELINE_REST_API_PCKG.gprs_opts_turn_off_phone_err'
    SQL.Strings = (
      'begin'
      '  BEELINE_REST_API_PCKG.gprs_opts_turn_off_phone_err;'
      'end;')
    Left = 416
    Top = 296
    CommandStoredProcName = 'BEELINE_REST_API_PCKG.gprs_opts_turn_off_phone_err'
  end
  object qGPRS_TURN_OFF_PHN_ERR_LOG: TOraQuery
    SQL.Strings = (
      'select '
      '    lg.GPRS_TURN_OFF_PHN_ERR_ID, '
      '    lg.DATE_BEGIN,'
      '    lg.DATE_END,'
      '    lg.DATE_INSERT'
      '  from JOB_GPRS_TURN_OFF_PHN_ERR_LOG lg'
      'where trunc(lg.DATE_INSERT) = trunc(sysdate)')
    Left = 360
    Top = 512
  end
end
