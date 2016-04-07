object ReportBillsForm: TReportBillsForm
  Left = 0
  Top = 0
  Caption = #1057#1095#1077#1090#1072
  ClientHeight = 394
  ClientWidth = 902
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
  object pAccounts: TPanel
    Left = 0
    Top = 41
    Width = 902
    Height = 29
    Align = alTop
    TabOrder = 0
    ExplicitTop = 0
    object lAccount: TLabel
      Left = 8
      Top = 8
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lPeriod: TLabel
      Left = 480
      Top = 7
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
      Left = 534
      Top = 2
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPeriodChange
    end
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 198
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object btCheckAll: TButton
      Left = 280
      Top = 3
      Width = 91
      Height = 24
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      TabOrder = 2
      OnClick = btCheckAllClick
    end
    object btUnCheckAll: TButton
      Left = 383
      Top = 3
      Width = 91
      Height = 24
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      TabOrder = 3
      OnClick = btUnCheckAllClick
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 70
    Width = 902
    Height = 324
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = grDataCellClick
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
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_OLD'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_NEW'
        Title.Alignment = taCenter
        Title.Caption = #1044#1083#1103' '#1082#1083#1080#1077#1085#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOXOD'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1093#1086#1076
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'KOEF'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1101#1092'. '#1072#1073'./'#1087'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 97
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 902
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitTop = -9
    object pButton: TPanel
      Left = 155
      Top = 1
      Width = 746
      Height = 39
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 0
      ExplicitWidth = 183
      ExplicitHeight = 41
      object btInfoAbonent: TBitBtn
        Left = 250
        Top = 6
        Width = 111
        Height = 29
        Action = aShowUserStatInfo
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object btLoadInExcel: TBitBtn
        Left = 8
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
        Left = 144
        Top = 6
        Width = 105
        Height = 29
        Action = aRefresh
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object cbBadBills: TCheckBox
        Left = 428
        Top = 12
        Width = 149
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1086#1090#1088'. '#1084#1072#1088#1078#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = cbBadBillsClick
      end
      object cbSearch: TCheckBox
        Left = 367
        Top = 12
        Width = 60
        Height = 17
        Caption = #1055#1086#1080#1089#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = cbSearchClick
      end
    end
    object pPeriod: TPanel
      Left = 1
      Top = 1
      Width = 154
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
    end
  end
  object ActionList: TActionList
    Images = MainForm.ImageList24
    Left = 64
    Top = 88
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
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, ACCOUNT_NUMBER, COMPANY_NAME FROM ACCOUNTS OR' +
        'DER BY LOGIN ASC')
    Left = 160
    Top = 88
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM (SELECT YEAR_MONTH '
      '        FROM DB_LOADER_BILLS'
      '      UNION ALL  '
      '      SELECT YEAR_MONTH '
      '        FROM DB_LOADER_FULL_FINANCE_BILL)'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 160
    Top = 136
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT V1.*,'
      '       V1.BILL_SUM-V1.BILL_SUM_ORIGIN AS DOXOD'
      '  FROM V_BILL_FOR_CLIENT V1'
      '  WHERE V1.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(V1.ACCOUNT_ID=:ACCOUNT_ID))'
      '  ORDER BY DOXOD ASC')
    FetchRows = 500
    Left = 64
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
        Value = Null
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
        Value = Null
      end>
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 144
    Top = 208
  end
  object qReportSimTrade: TOraQuery
    SQL.Strings = (
      'SELECT ACCOUNT_ID,'
      '   YEAR_MONTH,'
      '   PHONE_NUMBER,'
      '   BILL_SUM_ORIGIN BILL_SUM_OLD,'
      '   BILL_SUM BILL_SUM_NEW,'
      '   KOMISSIYA,'
      '   TARIFF_CODE'
      '  FROM V_BILL_FOR_DILER_SIM_TRADE V '
      '  WHERE V.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(V.ACCOUNT_ID=:ACCOUNT_ID))   '
      '    AND (:SHOW_BAD = 0'
      '          OR (:SHOW_BAD = 1 '
      '                AND (V.BILL_SUM_ORIGIN > V.BILL_SUM '
      '                       OR V.KOMISSIYA*1.18 > V.BILL_SUM)))'
      '    ORDER BY V.PHONE_NUMBER ASC')
    FetchRows = 500
    Left = 56
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'SHOW_BAD'
      end>
  end
  object qCorpMobileDilerPay: TOraQuery
    SQL.Strings = (
      'SELECT V_BILL_FOR_KOMISSIYA.*, '
      
        '       TRUNC(V_BILL_FOR_KOMISSIYA.KOMISSIYA_SUM/1.18, 2) AS SUM_' +
        'NO_NDS'
      '  FROM V_BILL_FOR_KOMISSIYA'
      '  WHERE V_BILL_FOR_KOMISSIYA.YEAR_MONTH=:YEAR_MONTH'
      
        '    AND ((:ACCOUNT_ID IS NULL)OR(V_BILL_FOR_KOMISSIYA.ACCOUNT_ID' +
        '=:ACCOUNT_ID))')
    FetchRows = 500
    Left = 176
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
        Value = Null
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
        Value = Null
      end>
    object qCorpMobileDilerPayACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
    end
    object qCorpMobileDilerPayYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qCorpMobileDilerPayPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qCorpMobileDilerPayKOMISSIYA_SUM: TFloatField
      FieldName = 'KOMISSIYA_SUM'
    end
    object qCorpMobileDilerPaySUM_NO_NDS: TFloatField
      FieldName = 'SUM_NO_NDS'
    end
  end
  object qGsmCorpDiler: TOraQuery
    SQLRefresh.Strings = (
      'SELECT BILL_CHECKED FROM DB_LOADER_BILLS'
      'WHERE'
      
        '  PHONE_NUMBER = :PHONE_NUMBER AND YEAR_MONTH = :YEAR_MONTH AND ' +
        'ACCOUNT_ID = :ACCOUNT_ID')
    SQL.Strings = (
      'SELECT V1.PHONE_NUMBER,'
      '       V1.BILL_SUM_OLD,'
      '       V1.BILL_SUM_NEW,'
      '        round(case v1.ABON_TP_OLD'
      '        when 0 then 1'
      '        else V1.ABON_TP_NEW/V1.ABON_TP_OLD'
      '       end, 4) KOEF ,'
      '       '
      '       V1.BILL_SUM_NEW-V1.BILL_SUM_OLD AS DOXOD,'
      '       '
      
        '       trunc(V1.ABON_TP_OLD +V1.CALLS_SMS_MMS + V1.CALLS_GPRS, 2' +
        ') AS DILER,'
      '       '
      '--       NVL(B.BILL_CHECKED, 0) BILL_CHECKED,'
      '       V1.YEAR_MONTH,'
      '       v1.ACCOUNT_ID,'
      '       (select TARIFF_NAME from V_BILL_ABON_PER_FOR_CLIENT  AA'
      '       '
      '          WHERE AA.YEAR_MONTH= V1.YEAR_MONTH'
      '          AND AA.ACCOUNT_ID = V1.ACCOUNT_ID'
      '          AND AA.PHONE_NUMBER = V1.PHONE_NUMBER'
      '          AND TARIFF_CODE IS NOT NULL AND ROWNUM <= 1 '
      
        '          AND DATE_END = (SELECT MAX(DATE_END) FROM V_BILL_ABON_' +
        'PER_FOR_CLIENT '
      
        '                         WHERE V_BILL_ABON_PER_FOR_CLIENT.DATE_E' +
        'ND =  AA.DATE_END )'
      '          ) TARIFF_NAME,'
      
        '       GET_ABONENT_BALANCE_FULL_BILLS(V1.PHONE_NUMBER) BALANCE_F' +
        'ULL_BILLS'
      '  FROM --V_BILL_FOR_CLIENT V1,'
      '    V_BILL_FINANCE_FOR_CLIENTS V1'
      '       '
      ''
      '  WHERE V1.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(V1.ACCOUNT_ID=:ACCOUNT_ID))'
      ''
      '  ORDER BY DOXOD ASC')
    FetchRows = 500
    Left = 288
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object qReportK7: TOraQuery
    SQL.Strings = (
      'SELECT V1.PHONE_NUMBER,'
      '       V1.BILL_SUM_OLD,'
      '       V1.BILL_SUM_NEW,'
      '       V1.BILL_SUM_NEW-V1.BILL_SUM_OLD AS DOXOD,'
      '       '
      '       round(case v1.ABON_TP_OLD'
      '        when 0 then 1'
      '        else V1.ABON_TP_NEW/V1.ABON_TP_OLD'
      '       end, 4) KOEF '
      '        '
      '        '
      '  FROM V_BILL_FINANCE_FOR_CLIENTS V1'
      '  WHERE V1.YEAR_MONTH=:YEAR_MONTH')
    Left = 376
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
end
