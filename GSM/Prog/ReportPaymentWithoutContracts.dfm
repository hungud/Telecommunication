object ReportPaymentWithoutContractsForm: TReportPaymentWithoutContractsForm
  Left = 0
  Top = 0
  Caption = #1055#1083#1072#1090#1077#1078#1080' '#1073#1077#1079' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  ClientHeight = 401
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 654
    Height = 373
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsReport
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 654
    Height = 28
    Align = alTop
    TabOrder = 1
    ExplicitTop = 8
    object Label1: TLabel
      Left = 8
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
    object btLoadInExcel: TBitBtn
      Left = 167
      Top = -1
      Width = 121
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 288
      Top = -1
      Width = 83
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 371
      Top = -1
      Width = 81
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 458
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
      TabOrder = 3
    end
    object cbPeriod: TComboBox
      Left = 62
      Top = 3
      Width = 99
      Height = 20
      Style = csDropDownList
      TabOrder = 4
      OnChange = cbPeriodChange
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 208
    Top = 112
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT P.*,'
      '       (SELECT MAX(C.CONTRACT_DATE)'
      '          FROM v_CONTRACTS C'
      '          WHERE C.PHONE_NUMBER_FEDERAL=P.PHONE_NUMBER'
      '            AND C.CONTRACT_CANCEL_DATE IS NULL) CONTRACT_DATE,'
      '       (SELECT PH.CELL_PLAN_CODE'
      '          FROM DB_LOADER_ACCOUNT_PHONES PH'
      '          WHERE PH.PHONE_NUMBER = P.PHONE_NUMBER'
      
        '--            AND PH.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, '#39'YY' +
        'YYMM'#39'))'
      '            AND PH.YEAR_MONTH = :YEAR_MONTH'
      '            AND ROWNUM <= 1) TARIFF_CODE'
      '  FROM DB_LOADER_PAYMENTS P'
      '  WHERE '
      '--  P.PAYMENT_DATE>=SYSDATE-4'
      '    p.year_month = :YEAR_MONTH'
      '    AND ( NOT EXISTS ('
      '           SELECT 1'
      '             FROM v_CONTRACTS C'
      '             WHERE C.PHONE_NUMBER_FEDERAL = P.PHONE_NUMBER'
      '               AND C.CONTRACT_CANCEL_DATE IS NULL)'
      '           '
      '      OR P.PHONE_NUMBER IN ('
      '           SELECT PH.PHONE_NUMBER'
      '             FROM DB_LOADER_ACCOUNT_PHONES PH'
      '             WHERE PH.CONSERVATION=1'
      '               AND PH.LAST_CHECK_DATE_TIME>P.PAYMENT_DATE'
      
        '               AND PH.PHONE_NUMBER IN (SELECT C1.PHONE_NUMBER_FE' +
        'DERAL'
      '                                         FROM CONTRACTS C1'
      
        '--                                         WHERE C1.CONTRACT_DAT' +
        'E>SYSDATE-4)'
      
        '                                         WHERE C1.CONTRACT_DATE ' +
        '>  trunc(to_date(:YEAR_MONTH, '#39'yyyymm'#39'), '#39'mm'#39'))'
      '           )'
      '       )'
      '  ORDER BY P.PAYMENT_DATE DESC')
    FetchAll = True
    Left = 136
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReportPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportPAYMENT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 12
      FieldName = 'PAYMENT_DATE'
    end
    object qReportPAYMENT_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'PAYMENT_SUM'
    end
    object qReportPAYMENT_NUMBER: TStringField
      DisplayLabel = #1053#1086#1080#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 30
      FieldName = 'PAYMENT_NUMBER'
      Size = 120
    end
    object qReportCONTRACT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 12
      FieldName = 'CONTRACT_DATE'
    end
    object qReportTARIFF_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      DisplayWidth = 12
      FieldName = 'TARIFF_CODE'
      Size = 200
    end
  end
  object alReport: TActionList
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
  object qPeriods: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM DB_LOADER_PAYMENTS'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    ReadOnly = True
    Left = 160
    Top = 152
  end
end
