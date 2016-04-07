object ReportLoadAccountsForm: TReportLoadAccountsForm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1087#1088#1086#1075#1088#1091#1079#1082#1080' '#1089#1095#1077#1090#1086#1074
  ClientHeight = 363
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 41
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 405
      Top = 15
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
    object cbPeriod: TComboBox
      Left = 460
      Top = 10
      Width = 100
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPeriodChange
    end
    object btLoadInExcel: TBitBtn
      Left = 677
      Top = 6
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btRefresh: TBitBtn
      Left = 566
      Top = 5
      Width = 105
      Height = 30
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btCheckAll: TButton
      Left = 205
      Top = 5
      Width = 90
      Height = 30
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      TabOrder = 3
      OnClick = btCheckAllClick
    end
    object btUnCheckAll: TButton
      Left = 305
      Top = 5
      Width = 90
      Height = 30
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      TabOrder = 4
      OnClick = btUnCheckAllClick
    end
  end
  object gBills: TCRDBGrid
    Left = 0
    Top = 41
    Width = 823
    Height = 322
    Align = alClient
    DataSource = dsBills
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsBills: TDataSource
    DataSet = qBills
    Left = 64
    Top = 144
  end
  object qBills: TOraQuery
    SQL.Strings = (
      'SELECT A.ACCOUNT_NUMBER,'
      '       V.COUNT_DETAIL_NONZERO_BILL,'
      '       V.COUNT_NONZERO_BILL_FROM_ACC,'
      '       V.COUNT_DETAIL_BILL,'
      '       V.COUNT_BILL_FROM_ACC,'
      '       V.COUNT_PHONES_ON_END_MONTH,'
      '       V.DIF_BETWEEN_NONZERO_BILLS,'
      '       V.DIF_BETWEEN_BILLS,'
      '       V.QUERY_LOAD,'
      '       V.LOGIN'
      '  FROM V_COUNT_LOADED_BILLS v, ACCOUNTS a'
      ' WHERE V.ACCOUNT_ID = A.ACCOUNT_ID'
      '       AND V.YEAR_MONTH = :PYEAR_MONTH'
      ' ORDER BY A.ACCOUNT_NUMBER')
    Left = 136
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PYEAR_MONTH'
        ParamType = ptInput
      end>
    object qBillsACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qBillsCOUNT_DETAIL_NONZERO_BILL: TFloatField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1076#1077#1090#1072#1083#1100#1085#1099#1093' '#1085#1077#1085#1091#1083#1077#1074#1099#1093' '#1089#1095#1077#1090#1086#1074
      FieldName = 'COUNT_DETAIL_NONZERO_BILL'
    end
    object qBillsCOUNT_NONZERO_BILL_FROM_ACC: TFloatField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1085#1077#1085#1091#1083#1077#1074#1099#1093' '#1089#1095#1077#1090#1086#1074
      FieldName = 'COUNT_NONZERO_BILL_FROM_ACC'
    end
    object qBillsCOUNT_DETAIL_BILL: TFloatField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1076#1077#1090#1072#1083#1100#1085#1099#1093' '#1089#1095#1077#1090#1086#1074
      FieldName = 'COUNT_DETAIL_BILL'
    end
    object qBillsCOUNT_BILL_FROM_ACC: TFloatField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1089#1095#1077#1090#1086#1074
      FieldName = 'COUNT_BILL_FROM_ACC'
    end
    object qBillsCOUNT_PHONES_ON_END_MONTH: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1090#1074#1086' '#1085#1086#1084#1077#1088#1086#1074' '#1085#1072' '#1083#1080#1094#1077#1074#1086#1084' '#1089#1095#1077#1090#1077' '#1085#1072' '#1082#1086#1085#1077#1094' '#1084#1077#1089#1103#1094#1072
      FieldName = 'COUNT_PHONES_ON_END_MONTH'
    end
    object qBillsDIF_BETWEEN_NONZERO_BILLS: TFloatField
      DisplayLabel = #1056#1072#1079#1085#1080#1094#1072' '#1084#1077#1078#1076#1091' '#1085#1077#1085#1091#1083#1077#1074#1099#1084#1080' '#1089#1095#1077#1090#1072#1084#1080
      FieldName = 'DIF_BETWEEN_NONZERO_BILLS'
    end
    object qBillsDIF_BETWEEN_BILLS: TFloatField
      DisplayLabel = #1056#1072#1079#1085#1080#1094#1072' '#1084#1077#1078#1076#1091' '#1089#1095#1077#1090#1072#1084#1080
      FieldName = 'DIF_BETWEEN_BILLS'
    end
    object qBillsQUERY_LOAD: TFloatField
      DisplayLabel = #1054#1089#1090#1072#1083#1086#1089#1100' '#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1084' '#1088#1077#1078#1080#1084#1077
      FieldName = 'QUERY_LOAD'
    end
    object qBillsLOGIN: TStringField
      DisplayLabel = #1051#1086#1075#1080#1085
      FieldName = 'LOGIN'
      Size = 30
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 120
    Top = 104
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
    Left = 216
    Top = 128
  end
  object qAccounts: TOraQuery
    SQL.Strings = (
      'Select ACCOUNT_ID, ACCOUNT_NUMBER from ACCOUNTS'
      'Order by ACCOUNT_NUMBER')
    Left = 216
    Top = 72
  end
end
