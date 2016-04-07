object ReportAccountPhonesForm: TReportAccountPhonesForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1082#1080' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 467
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 27
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 242
      Top = 8
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lAccount: TLabel
      Left = 8
      Top = 8
      Width = 28
      Height = 13
      Caption = #1051'/C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 391
      Top = 0
      Width = 120
      Height = 27
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 511
      Top = 0
      Width = 83
      Height = 27
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 594
      Top = 0
      Width = 81
      Height = 27
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 287
      Top = 4
      Width = 98
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 681
      Top = 5
      Width = 59
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object cbAccounts: TComboBox
      Left = 33
      Top = 4
      Width = 203
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 5
      OnChange = cbAccountsChange
    end
    object cbSubstValues: TCheckBox
      Left = 746
      Top = 5
      Width = 135
      Height = 17
      Caption = #1055#1086#1076#1089#1090#1072#1074#1083#1103#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = cbSubstValuesClick
    end
  end
  object PhoneNumberViolationsGrid: TCRDBGrid
    Left = 0
    Top = 27
    Width = 912
    Height = 410
    Align = alClient
    DataSource = dsReports
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'ACCOUNT_NUMBER'
        Title.Alignment = taCenter
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1075#1086#1074#1086#1088
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1072#1088#1080#1092
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELL_PLAN_CODE'
        Title.Alignment = taCenter
        Width = 166
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_IS_ACTIVE'
        Title.Alignment = taCenter
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONSERVATION'
        Title.Alignment = taCenter
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SYSTEM_BLOCK'
        Title.Alignment = taCenter
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_CHECK_DATE_TIME'
        Title.Alignment = taCenter
        Width = 161
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DETAIL_SUM'
        Title.Caption = #1057#1091#1084#1084#1072' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IS_CONTRACT'
        Title.Caption = #1053#1072#1083'. '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Width = 108
        Visible = True
      end>
  end
  object pCount: TPanel
    Left = 0
    Top = 437
    Width = 912
    Height = 30
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 2
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN||'#39': '#39'||COMPANY_NAME LOGIN'
      '  FROM ACCOUNTS '
      '  ORDER BY LOGIN ASC')
    Left = 240
    Top = 80
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM DB_LOADER_ACCOUNT_PHONES'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 240
    Top = 128
  end
  object alReports: TActionList
    Images = MainForm.ImageList24
    Left = 80
    Top = 80
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qReports: TOraQuery
    SQL.Strings = (
      'SELECT C.CONTRACT_NUM, T.TARIFF_NAME, p.*'
      '  FROM V_ACCOUNT_PHONES_LIST P,'
      '       contracts c,'
      '       tariffs t'
      '  WHERE P.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(P.ACCOUNT_ID=:ACCOUNT_ID))'
      '    AND P.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL(+)'
      '    AND C.TARIFF_ID = T.TARIFF_ID(+)'
      '  ORDER BY P.PHONE_NUMBER ASC')
    FetchRows = 250
    FetchAll = True
    Left = 80
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qReportsPHONE_IS_ACTIVE: TIntegerField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      FieldName = 'PHONE_IS_ACTIVE'
    end
    object qReportsLAST_CHECK_DATE_TIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080
      FieldName = 'LAST_CHECK_DATE_TIME'
    end
    object qReportsCONSERVATION: TIntegerField
      DisplayLabel = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077
      FieldName = 'CONSERVATION'
    end
    object qReportsSYSTEM_BLOCK: TIntegerField
      DisplayLabel = #1052#1086#1096#1077#1085#1085#1080#1082
      FieldName = 'SYSTEM_BLOCK'
    end
    object qReportsACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1051'/'#1057
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportsPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportsCELL_PLAN_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      FieldName = 'CELL_PLAN_CODE'
      Size = 200
    end
    object qReportsDETAIL_SUM: TFloatField
      FieldName = 'DETAIL_SUM'
    end
    object qReportsIS_CONTRACT: TStringField
      FieldName = 'IS_CONTRACT'
      Size = 6
    end
    object qReportsCONTRACT_NUM: TFloatField
      FieldName = 'CONTRACT_NUM'
    end
    object qReportsTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 100
    end
  end
  object dsReports: TDataSource
    DataSet = qReports
    Left = 152
    Top = 152
  end
end
