inherited ReportAutoTurnInternetLimitForm: TReportAutoTurnInternetLimitForm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103#1084' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1081' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
  ClientHeight = 683
  ClientWidth = 1119
  Position = poScreenCenter
  ExplicitWidth = 1135
  ExplicitHeight = 721
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 461
    Width = 1119
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 33
    ExplicitWidth = 447
  end
  inherited pButtons: TPanel
    Width = 1119
    Height = 33
    ExplicitWidth = 1100
    ExplicitHeight = 33
    object lbMonth: TLabel [0]
      Left = 8
      Top = 10
      Width = 179
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1072#1073#1083#1102#1076#1072#1077#1084#1099#1093' '#1084#1077#1089#1103#1094#1077#1074
    end
    object lbInternet: TLabel [1]
      Left = 257
      Top = 10
      Width = 176
      Height = 13
      Caption = #1055#1088#1077#1076#1077#1083' '#1087#1086' '#1090#1088#1072#1092#1080#1082#1091' '#1080#1085#1090#1077#1088#1085#1077#1090#1072', '#1043#1041
    end
    object lbMinutes: TLabel [2]
      Left = 503
      Top = 10
      Width = 158
      Height = 13
      Caption = #1055#1088#1077#1076#1077#1083' '#1087#1086' '#1080#1089#1093#1086#1076#1103#1097#1080#1084' '#1084#1080#1085#1091#1090#1072#1084
    end
    inherited btRefresh: TBitBtn
      Left = 731
      Top = 2
      Width = 118
      ExplicitLeft = 731
      ExplicitTop = 2
      ExplicitWidth = 118
    end
    inherited btLoadInExcel: TBitBtn
      Left = 1065
      Top = 2
      Width = 51
      Visible = False
      ExplicitLeft = 1065
      ExplicitTop = 2
      ExplicitWidth = 51
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 1016
      Top = 2
      Width = 43
      Visible = False
      ExplicitLeft = 1016
      ExplicitTop = 2
      ExplicitWidth = 43
    end
    object edtInternet: TEdit
      Left = 439
      Top = 6
      Width = 58
      Height = 21
      TabOrder = 3
    end
    object edtMinutes: TEdit
      Left = 667
      Top = 6
      Width = 58
      Height = 21
      TabOrder = 4
    end
    object cbMonth: TComboBox
      Left = 193
      Top = 6
      Width = 58
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12')
    end
    object BitBtn1: TBitBtn
      Left = 850
      Top = 2
      Width = 160
      Height = 29
      Action = aShowLimit
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
  end
  inherited pGrid: TPanel
    Top = 33
    Width = 1119
    Height = 428
    ExplicitTop = 33
    ExplicitWidth = 1100
    ExplicitHeight = 392
    inherited gReport: TCRDBGrid
      Width = 1087
      Height = 426
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      OnDblClick = gReportDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 179
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_IS_ACTIVE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_1'
          Title.Alignment = taCenter
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
          FieldName = 'CALL_MINUTES_1'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_1'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_2'
          Title.Alignment = taCenter
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
          FieldName = 'CALL_MINUTES_2'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_2'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_3'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_3'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_3'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_4'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_4'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_4'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_5'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_5'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_5'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_6'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_6'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_6'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_7'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_7'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_7'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_8'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_8'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_8'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_9'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_9'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_9'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_10'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_10'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_10'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_11'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_11'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_11'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_VOL_12'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALL_MINUTES_12'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFIT_12'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end>
    end
    object Panel1: TPanel
      Left = 1088
      Top = 1
      Width = 30
      Height = 426
      Align = alRight
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitLeft = 1024
      ExplicitHeight = 155
      object bLoadInExcelRep: TSpeedButton
        Left = 2
        Top = 41
        Width = 26
        Height = 26
        Action = aLoadInExcel
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
      object bShowUserStatInfoRep: TSpeedButton
        Left = 2
        Top = 5
        Width = 26
        Height = 26
        Action = aShowUserStatInfo
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
      object bAddLimit: TSpeedButton
        Left = 2
        Top = 77
        Width = 26
        Height = 26
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1084#1077#1088' '#1074' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
        Action = aAddLimit
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
    end
  end
  object pLimit: TPanel [3]
    Left = 0
    Top = 464
    Width = 1119
    Height = 219
    Align = alBottom
    TabOrder = 2
    ExplicitWidth = 1100
    object lbLimit: TLabel
      Left = 1
      Top = 1
      Width = 1117
      Height = 13
      Align = alTop
      Caption = '  '#1053#1086#1084#1077#1088#1072' '#1089' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077#1084' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 354
    end
    object pBtnLimit: TPanel
      Left = 1088
      Top = 14
      Width = 30
      Height = 204
      Align = alRight
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitLeft = 1024
      ExplicitTop = 1
      ExplicitHeight = 155
      object bLoadInExcelLim: TSpeedButton
        Left = 2
        Top = 41
        Width = 26
        Height = 26
        Action = aLoadInExcelLim
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
      object bShowUserStatInfoLim: TSpeedButton
        Left = 2
        Top = 5
        Width = 26
        Height = 26
        Action = aShowUserStatInfoLim
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
      object bDeleteLimit: TSpeedButton
        Left = 2
        Top = 77
        Width = 26
        Height = 26
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1085#1086#1084#1077#1088' '#1080#1079' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081
        Action = aDeleteLimit
        Flat = True
        ParentShowHint = False
        ShowHint = True
      end
    end
    object gLimit: TCRDBGrid
      Left = 1
      Top = 14
      Width = 1087
      Height = 204
      Align = alClient
      DataSource = dsLimit
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = gLimitDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 179
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_IS_ACTIVE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1074#1089#1090#1072#1074#1082#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 120
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select'
      '  lm.PHONE_NUMBER,'
      '  lm.CONTRACT_DATE, '
      '  lm.CONTRACT_ID,'
      '  lm.TARIFF_CODE,'
      '  lm.TARIFF_NAME,'
      '  lm.PHONE_IS_ACTIVE,'
      '  lm.BALANCE,'
      '  lm.INTERNET_VOL_1,'
      '  lm.CALL_MINUTES_1,'
      '  lm.PROFIT_1,'
      '  lm.INTERNET_VOL_2,'
      '  lm.CALL_MINUTES_2,'
      '  lm.PROFIT_2,'
      '  lm.INTERNET_VOL_3,'
      '  lm.CALL_MINUTES_3,'
      '  lm.PROFIT_3,'
      '  lm.INTERNET_VOL_4,'
      '  lm.CALL_MINUTES_4,'
      '  lm.PROFIT_4,'
      '  lm.INTERNET_VOL_5,'
      '  lm.CALL_MINUTES_5,'
      '  lm.PROFIT_5,'
      '  lm.INTERNET_VOL_6,'
      '  lm.CALL_MINUTES_6,'
      '  lm.PROFIT_6,'
      '  lm.INTERNET_VOL_7,'
      '  lm.CALL_MINUTES_7,'
      '  lm.PROFIT_7,'
      '  lm.INTERNET_VOL_8,'
      '  lm.CALL_MINUTES_8,'
      '  lm.PROFIT_8,'
      '  lm.INTERNET_VOL_9,'
      '  lm.CALL_MINUTES_9,'
      '  lm.PROFIT_9,'
      '  lm.INTERNET_VOL_10,'
      '  lm.CALL_MINUTES_10,'
      '  lm.PROFIT_10,'
      '  lm.INTERNET_VOL_11,'
      '  lm.CALL_MINUTES_11,'
      '  lm.PROFIT_11,'
      '  lm.INTERNET_VOL_12,'
      '  lm.CALL_MINUTES_12,'
      '  lm.PROFIT_12'
      
        'from table(GET_GPRS_PHONE_LIMIT_TAB(:pMONTH, :pINTERNET, :pMINUT' +
        'ES)) lm'
      'where not exists ('
      '                    select 1'
      '                      from GPRS_PHONE_LIMIT gp'
      '                     where GP.PHONE_NUMBER = lm.PHONE_NUMBER'
      '                       and gp.CONTRACT_ID = lm.CONTRACT_ID'
      '                  )')
    Left = 80
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pMONTH'
      end
      item
        DataType = ftUnknown
        Name = 'pINTERNET'
      end
      item
        DataType = ftUnknown
        Name = 'pMINUTES'
      end>
  end
  inherited dsReport: TDataSource
    Left = 136
    Top = 120
  end
  inherited aList: TActionList
    Left = 32
    Top = 120
    object aShowLimit: TAction [1]
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      ImageIndex = 11
      OnExecute = aShowLimitExecute
    end
    inherited aShowUserStatInfo: TAction [2]
      Caption = ''
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1085#1086#1084#1077#1088#1091
      OnExecute = aShowUserStatInfoExecute
    end
    object aShowUserStatInfoLim: TAction [3]
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1085#1086#1084#1077#1088#1091
      ImageIndex = 22
      OnExecute = aShowUserStatInfoLimExecute
    end
    inherited aLoadInExcel: TAction [4]
      Caption = ''
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
    end
    object aLoadInExcelLim: TAction
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aLoadInExcelLimExecute
    end
    object aDeleteLimit: TAction
      ImageIndex = 8
      OnExecute = aDeleteLimitExecute
    end
    object aAddLimit: TAction
      ImageIndex = 4
      OnExecute = aAddLimitExecute
    end
  end
  object qLimit: TOraQuery
    SQLInsert.Strings = (
      
        'INSERT INTO GPRS_PHONE_LIMIT (PHONE_NUMBER, CONTRACT_ID) VALUES ' +
        '(:pPHONE_NUMBER, :pCONTRACT_ID)')
    SQLDelete.Strings = (
      'DELETE FROM GPRS_PHONE_LIMIT '
      ' WHERE PHONE_NUMBER = :pPHONE_NUMBER'
      '   AND CONTRACT_ID = :pCONTRACT_ID')
    SQL.Strings = (
      'select'
      '    GP.PHONE_NUMBER,'
      '    V.CONTRACT_DATE,'
      '    V.CONTRACT_ID,'
      '    TR.TARIFF_CODE,'
      '    TR.TARIFF_NAME,'
      '    case'
      '      when nvl(ph.PHONE_IS_ACTIVE, 0) = 0 then'
      '        case'
      '          when nvl(ph.CONSERVATION,0) = 1 then'
      '            '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '          else '
      '            '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '        end'
      '      else'
      '        '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '    end'
      '    PHONE_IS_ACTIVE,'
      '    GET_ABONENT_BALANCE(GP.PHONE_NUMBER) BALANCE,'
      '    GP.DATE_CREATED'
      '  from GPRS_PHONE_LIMIT gp,'
      '          v_contracts v,'
      '          tariffs tr,'
      '          db_loader_account_phones ph'
      'where GP.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL'
      '    and V.CONTRACT_CANCEL_DATE is null'
      '    and V.TARIFF_ID = TR.TARIFF_ID'
      '    and PH.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL'
      '    and PH.YEAR_MONTH = ('
      '                           select max(DB.YEAR_MONTH)'
      '                             from db_loader_account_phones db'
      
        '                            where DB.PHONE_NUMBER = PH.PHONE_NUM' +
        'BER'
      '                        )'
      '    and nvl(tr.IS_AUTO_INTERNET, 0) = 1')
    Left = 24
    Top = 560
  end
  object dsLimit: TDataSource
    DataSet = qLimit
    Left = 64
    Top = 560
  end
end
