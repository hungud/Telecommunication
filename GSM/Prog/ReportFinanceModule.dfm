object ReportFinance: TReportFinance
  Left = 0
  Top = 0
  Caption = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1086#1090#1095#1105#1090
  ClientHeight = 632
  ClientWidth = 1139
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1139
    Height = 73
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 13
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
    object Lb_daterep: TLabel
      AlignWithMargins = True
      Left = 13
      Top = 37
      Width = 151
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086'  '#1086#1090#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btLoadInExcel: TBitBtn
      Left = 172
      Top = 0
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 308
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 414
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 67
      Top = 3
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 531
      Top = 6
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
    end
    object CBRefresh: TCheckBox
      Left = 308
      Top = 35
      Width = 156
      Height = 19
      Caption = #1057' '#1087#1077#1088#1077#1089#1073#1086#1088#1086#1084' '#1076#1072#1085#1085#1099#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 73
    Width = 1139
    Height = 530
    OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting, dgeRecordCount, dgeSummary]
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'YEAR_MONTH'
        Title.Caption = #1043#1086#1076
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEELINE_BILL'
        Title.Caption = #1057#1095#1105#1090' '#1073#1080#1083#1072#1081#1085
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENT_BILL'
        Title.Caption = #1057#1095#1105#1090' '#1058#1072#1088#1080#1092#1077#1088
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_TP_OLD'
        Title.Caption = #1040#1073#1086#1085'.'#1087#1083#1072#1090#1072' '#1041#1080#1083#1072#1081#1085
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_TP_NEW'
        Title.Caption = #1040#1073#1086#1085'.'#1087#1083#1072#1090#1072' '#1058#1072#1088#1080#1092#1077#1088
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_ADD_OLD'
        ReadOnly = True
        Title.Caption = #1040#1073#1086#1085'.'#1058#1055' '#1041#1080#1083#1072#1081#1085'('#1076#1086#1087')'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_ADD_NEW'
        Title.Caption = #1040#1073#1086#1085'.'#1058#1055' '#1058#1072#1088#1080#1092#1077#1088'('#1076#1086#1087')'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_GPRS'
        Title.Caption = 'GPRS'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_COUNTRY'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SMS_MMS'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CALLS_LOCAL'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CALLS_RUS_RPP'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CALLS_SITY'
        Title.Caption = #1052#1077#1078#1076#1091#1075#1086#1088#1086#1076#1085#1080#1077' '#1079#1074#1086#1085#1082#1080
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCOUNT_OLD'
        Title.Caption = #1057#1082#1080#1076#1082#1072' '#1041#1080#1083#1072#1081#1085
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCOUNT_NEW'
        Title.Caption = #1057#1082#1080#1076#1082#1072' '#1058#1072#1088#1080#1092#1077#1088
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENTS'
        Title.Caption = #1055#1083#1072#1090#1077#1078#1080
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENTS_FULL'
        Title.Caption = #1055#1083#1072#1090#1077#1078#1080'+'#1074#1080#1088#1090'.'#1087#1083#1072#1090
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE_ON_BEGIN'
        Title.Caption = #1041#1072#1083#1072#1085#1089' '#1085#1072' '#1085#1072#1095#1072#1083#1086
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE_ON_END'
        Title.Caption = #1041#1072#1083#1072#1085#1089' '#1085#1072' '#1082#1086#1085#1077#1094
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_DATE'
        Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIRT_PLAT'
        Title.Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1077' '#1087#1083#1072#1090#1077#1078#1080
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PLAT_MIN_NACH'
        Title.Caption = #1055#1083#1072#1090'. '#1084#1080#1085#1091#1089' '#1085#1072#1095'. '#1058#1072#1088#1080#1092#1077#1088#1072
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'KATEG'
        Title.Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNT1'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENTS_FULL1'
        Title.Caption = #1055#1083#1072#1090#1077#1078#1080
        Width = 60
        Visible = True
        FloatPrecision = 2
        FloatDigits = 2
      end
      item
        Expanded = False
        FieldName = 'PROFIT'
        Title.Caption = #1055#1088#1080#1073#1099#1083#1100
        Width = 60
        Visible = True
        FloatPrecision = 2
        FloatDigits = 2
      end
      item
        Expanded = False
        FieldName = 'FIN_RES'
        Title.Caption = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1100
        Width = 60
        Visible = True
        FloatPrecision = 2
        FloatDigits = 2
      end
      item
        Expanded = False
        FieldName = 'ROUMING_NATIONAL'
        Title.Caption = #1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROUMING_INTERNATIONAL'
        Title.Caption = #1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_TP_OLD1'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1087#1086#1083#1102' '#1040#1073#1086#1085'.'#1058#1055' '#1041#1080#1083#1072#1081#1085
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABON_TP_NEW1'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1087#1086#1083#1102' '#1040#1073#1086#1085'.'#1058#1055' '#1058#1072#1088#1080#1092#1077#1088
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_GPRS1'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1087#1086#1083#1102' GPRS'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROUMING_NATIONAL1'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1087#1086#1083#1102' '#1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROUMING_INTERNATIONAL1'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086' '#1087#1086#1083#1102' '#1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXIT_PLUS'
        Title.Caption = #1042#1099#1093#1086#1076' '#1074' '#1087#1083#1102#1089
        Width = 60
        Visible = True
      end>
  end
  object cbGroup: TCheckBox
    Left = 616
    Top = 5
    Width = 97
    Height = 17
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 2
    OnClick = cbGroupClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 603
    Width = 1139
    Height = 29
    Align = alBottom
    TabOrder = 3
    Visible = False
    object Gauge1: TGauge
      Left = 273
      Top = 1
      Width = 865
      Height = 27
      Align = alClient
      BorderStyle = bsNone
      ForeColor = clNavy
      Progress = 0
      Visible = False
      ExplicitLeft = 209
      ExplicitWidth = 929
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 1
      Width = 272
      Height = 27
      Align = alLeft
      Panels = <>
      SimpleText = '1'
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
      'SELECT ACCOUNT_ID, LOGIN FROM ACCOUNTS ORDER BY LOGIN ASC')
    Left = 320
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
    Left = 312
    Top = 128
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT'
      ' distinct'
      ' v1.YEAR_MONTH, '
      ' v1.PHONE_NUMBER, '
      ' BEELINE_BILL, '
      ' CLIENT_BILL, '
      ' PAYMENTS, '
      ' PAYMENTS_FULL, '
      ' BALANCE_ON_BEGIN, '
      
        ' BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL BALANCE_ON_EN' +
        'D, '
      ' CONTRACT_DATE,'
      ' CONTRACT_NUM,'
      ' NVL(PAYMENTS_FULL,0)-NVL(PAYMENTS,0) VIRT_PLAT, '
      ' NVL(PAYMENTS_FULL,0)-CLIENT_BILL PLAT_MIN_NACH,'
      ' CASE '
      '   WHEN CLIENT_BILL<=0 THEN '#39#1053#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1102#1090#1089#1103#39
      
        '   WHEN (CONTRACT_DATE IS NULL) AND (CLIENT_BILL<>0) THEN '#39#1041#1077#1079' '#1082 +
        #1086#1085#1090#1088#1072#1082#1090#1086#1074#39
      
        '   WHEN (NVL(PAYMENTS_FULL,0)-CLIENT_BILL>0) AND (BALANCE_ON_BEG' +
        'IN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL>0) THEN '#39#1042#1089#1105' '#1054#1082#39
      
        '   WHEN (BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL<0) TH' +
        'EN '#39#1059#1096#1083#1080' '#1074' '#1084#1080#1085#1091#1089#39
      '   ELSE '#39#1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072#39
      ' END KATEG,'
      ' NVL(PAYMENTS_FULL,0)-BEELINE_BILL FIN_RES,'
      ' CLIENT_BILL-BEELINE_BILL PROFIT,'
      ' CASE '
      
        '    WHEN NVL(IO.BALANCE,0)<=0 AND V1.BEELINE_BILL<>0 then '#39#1057#1095#1105#1090' ' +
        #1085#1077' '#1087#1086#1075#1072#1096#1077#1085#39' '
      '    WHEN V1.BEELINE_BILL=0 then '#39#1053#1091#1083#1077#1074#1086#1081' '#1089#1095#1105#1090' '#1073#1080#1083#1072#1081#1085#39' '
      ' ELSE '#39#1057#1095#1105#1090' '#1087#1086#1075#1072#1096#1077#1085#39
      ' END EXIT_PLUS'
      'FROM V_DEBIT_AND_CREDIT v1'
      'INNER JOIN  BILLS_PERIODS BIL ON BIL.YEAR_MONTH=:YEAR_MONTH    '
      
        'LEFT OUTER JOIN IOT_BALANCE_HISTORY IO ON IO.PHONE_NUMBER=V1.PHO' +
        'NE_NUMBER AND IO.BALANCE>0 AND IO.START_TIME between BIL.BEGIN_D' +
        'ATE AND BIL.BEGIN_DATE+45 '
      '  WHERE v1.YEAR_MONTH=:YEAR_MONTH')
    FetchRows = 500
    Left = 56
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'YEAR_MONTH'
        ParamType = ptInput
      end>
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 304
    Top = 176
  end
  object qReportLontana: TOraQuery
    SQL.Strings = (
      'SELECT'
      ' distinct'
      ' v1.YEAR_MONTH, '
      ' v1.PHONE_NUMBER, '
      ' BEELINE_BILL, '
      ' CLIENT_BILL, '
      ' PAYMENTS, '
      ' PAYMENTS_FULL, '
      ' BALANCE_ON_BEGIN, '
      
        ' BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL BALANCE_ON_EN' +
        'D, '
      ' CONTRACT_DATE,'
      ' CONTRACT_NUM,'
      ' NVL(PAYMENTS_FULL,0)-NVL(PAYMENTS,0) VIRT_PLAT, '
      ' NVL(PAYMENTS_FULL,0)-CLIENT_BILL PLAT_MIN_NACH,'
      ' CASE '
      '   WHEN CLIENT_BILL<=0 THEN '#39#1053#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1102#1090#1089#1103#39
      
        '   WHEN (CONTRACT_DATE IS NULL) AND (CLIENT_BILL<>0) THEN '#39#1041#1077#1079' '#1082 +
        #1086#1085#1090#1088#1072#1082#1090#1086#1074#39
      
        '   WHEN (NVL(PAYMENTS_FULL,0)-CLIENT_BILL>0) AND (BALANCE_ON_BEG' +
        'IN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL>0) THEN '#39#1042#1089#1105' '#1054#1082#39
      
        '   WHEN (BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL<0) TH' +
        'EN '#39#1059#1096#1083#1080' '#1074' '#1084#1080#1085#1091#1089#39
      '   ELSE '#39#1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072#39
      ' END KATEG,'
      ' NVL(PAYMENTS_FULL,0)-BEELINE_BILL FIN_RES,'
      ' CLIENT_BILL-BEELINE_BILL PROFIT,'
      ' CASE '
      
        '    WHEN NVL(IO.BALANCE,0)<=0 AND V1.BEELINE_BILL<>0 then '#39#1057#1095#1105#1090' ' +
        #1085#1077' '#1087#1086#1075#1072#1096#1077#1085#39' '
      '    WHEN V1.BEELINE_BILL=0 then '#39#1053#1091#1083#1077#1074#1086#1081' '#1089#1095#1105#1090' '#1073#1080#1083#1072#1081#1085#39' '
      ' ELSE '#39#1057#1095#1105#1090' '#1087#1086#1075#1072#1096#1077#1085#39
      ' END EXIT_PLUS'
      'FROM V_DEBIT_AND_CREDIT v1'
      'INNER JOIN  BILLS_PERIODS BIL ON BIL.YEAR_MONTH=:YEAR_MONTH    '
      
        'LEFT OUTER JOIN IOT_BALANCE_HISTORY IO ON IO.PHONE_NUMBER=V1.PHO' +
        'NE_NUMBER AND IO.BALANCE>0 AND IO.START_TIME between BIL.BEGIN_D' +
        'ATE AND BIL.BEGIN_DATE+45 '
      '  WHERE v1.YEAR_MONTH=:YEAR_MONTH')
    FetchRows = 500
    Left = 56
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
  object qReportLontanaGroup: TOraQuery
    SQL.Strings = (
      
        'SELECT KATEG, COUNT(KATEG) CNT1, SUM(FIN_RES) FIN_RES, SUM(PAYME' +
        'NTS_FULL) PAYMENTS_FULL1, SUM(PROFIT) PROFIT, SUM(ABON_TP_OLD) A' +
        'BON_TP_OLD1, SUM(ABON_TP_NEW) ABON_TP_NEW1, SUM(CALLS_GPRS) CALL' +
        'S_GPRS1, SUM(ROUMING_NATIONAL) ROUMING_NATIONAL1, SUM(ROUMING_IN' +
        'TERNATIONAL) ROUMING_INTERNATIONAL1 FROM '
      '(SELECT               '
      '     YEAR_MONTH,         '
      '     PHONE_NUMBER,       '
      '     BEELINE_BILL,       '
      '     CLIENT_BILL,     '
      '     ABON_TP_OLD,              '
      '     ABON_TP_NEW,              '
      '     ABON_ADD_OLD,             '
      '     ABON_ADD_NEW,             '
      '     CALLS_GPRS,               '
      '     CALLS_COUNTRY,            '
      '     CALLS_SMS_MMS,            '
      '     CALLS_LOCAL,              '
      '     CALLS_RUS_RPP,            '
      '     CALLS_SITY,               '
      '     DISCOUNT_OLD,             '
      '     DISCOUNT_NEW,             '
      '     ROUMING_NATIONAL,         '
      '     ROUMING_INTERNATIONAL,    '
      '     PAYMENTS,           '
      '     PAYMENTS_FULL,      '
      '     BALANCE_ON_BEGIN,   '
      
        '     BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL BALANCE_O' +
        'N_END, '
      '     CONTRACT_DATE, '
      '     CONTRACT_NUM,                                              '
      
        '     NVL(PAYMENTS_FULL,0)-NVL(PAYMENTS,0) VIRT_PLAT,            ' +
        '       '
      
        '     NVL(PAYMENTS_FULL,0)-CLIENT_BILL PLAT_MIN_NACH,            ' +
        '       '
      
        '     CASE                                                       ' +
        '       '
      
        '       WHEN CLIENT_BILL<=0 THEN '#39#1053#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1102#1090#1089#1103#39'               ' +
        '     '
      
        '       WHEN (CONTRACT_DATE IS NULL) AND (CLIENT_BILL<>0) THEN '#39#1041 +
        #1077#1079' '#1082#1086#1085#1090#1088#1072#1082#1090#1086#1074#39' '
      '       WHEN (NVL(PAYMENTS_FULL,0)-CLIENT_BILL>0) THEN '#39#1042#1089#1105' '#1054#1082#39' '
      
        '       WHEN (BALANCE_ON_BEGIN+NVL(PAYMENTS_FULL,0)-CLIENT_BILL<0' +
        ') THEN '#39#1059#1096#1083#1080' '#1074' '#1084#1080#1085#1091#1089#39' '
      '       ELSE '#39#1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072#39'                  '
      '     END KATEG,                                     '
      '     NVL(PAYMENTS_FULL,0)-BEELINE_BILL FIN_RES,     '
      '     CLIENT_BILL-BEELINE_BILL PROFIT                '
      '     FROM '
      'finance_report                       '
      '      WHERE YEAR_MONTH=:YEAR_MONTH) '
      'GROUP BY Rollup(KATEG)')
    FetchRows = 500
    Left = 160
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 792
    Top = 8
  end
end
