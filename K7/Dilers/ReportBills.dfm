object ReportBillsForm: TReportBillsForm
  Left = 0
  Top = 0
  Caption = #1057#1095#1077#1090#1072
  ClientHeight = 394
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 786
    Height = 28
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 184
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
    object btLoadInExcel: TBitBtn
      Left = 343
      Top = 0
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 479
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 585
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 238
      Top = 3
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 702
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
      OnClick = cbSearchClick
    end
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 5
      OnChange = cbAccountsChange
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 28
    Width = 786
    Height = 366
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
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_ORIGIN'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
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
        FieldName = 'BILL_SUM'
        Title.Alignment = taCenter
        Title.Caption = #1044#1083#1103' '#1082#1083#1080#1077#1085#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 97
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
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIBER_PAYMENT_COEF'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1101#1092'. '#1072#1073'./'#1087'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
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
      'FROM DB_LOADER_BILLS'
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
    Left = 96
    Top = 144
  end
  object qReportSimTrade: TOraQuery
    SQL.Strings = (
      'SELECT B.PHONE_NUMBER,'
      '       B.BILL_SUM BILL_SUM_ORIGIN,'
      '       V1.BILL_SUM, '
      '       case '
      
        '         when (b.bill_sum>0)and(b.SUBSCRIBER_PAYMENT_MAIN+b.SING' +
        'LE_PAYMENTS+b.DISCOUNT_VALUE >0)'
      
        '           then b.SUBSCRIBER_PAYMENT_MAIN+b.SINGLE_PAYMENTS+b.DI' +
        'SCOUNT_VALUE+b.CALLS_LOCAL_COST+b.MESSAGES_COST'
      '         else 0 '
      '       end AS KOMISSIYA'
      '  FROM V_BILL_FOR_CLIENT V1,'
      '       DB_LOADER_BILLS B'
      '  WHERE B.PHONE_NUMBER=V1.PHONE_NUMBER(+)'
      '    AND B.YEAR_MONTH=V1.YEAR_MONTH(+)    '
      '    AND B.ACCOUNT_ID=V1.ACCOUNT_ID(+)    '
      '    AND B.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(B.ACCOUNT_ID=:ACCOUNT_ID))'
      '  ORDER BY B.PHONE_NUMBER ASC')
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
    SQL.Strings = (
      'SELECT V1.PHONE_NUMBER,'
      '       V1.BILL_SUM_ORIGIN,'
      '       V1.BILL_SUM,'
      '       V1.SUBSCRIBER_PAYMENT_COEF,'
      '       V1.BILL_SUM-V1.BILL_SUM_ORIGIN AS DOXOD,'
      
        '       V1.SUBSCRIBER_PAYMENT_OLD+B.MESSAGES_COST+B.INTERNET_COST' +
        ' AS DILER'
      '  FROM V_BILL_FOR_CLIENT V1,'
      '       DB_LOADER_BILLS B'
      '  WHERE V1.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(V1.ACCOUNT_ID=:ACCOUNT_ID))'
      '    AND V1.ACCOUNT_ID=B.ACCOUNT_ID'
      '    AND V1.YEAR_MONTH=B.YEAR_MONTH'
      '    AND V1.PHONE_NUMBER=B.PHONE_NUMBER'
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
end
