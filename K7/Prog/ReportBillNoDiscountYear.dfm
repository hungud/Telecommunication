object ReportBillNoDiscountYearForm: TReportBillNoDiscountYearForm
  Left = 0
  Top = 0
  Caption = #1057#1095#1077#1090#1072' '#1073#1077#1079' '#1075#1086#1076#1086#1074#1086#1081' '#1089#1082#1080#1076#1082#1080
  ClientHeight = 621
  ClientWidth = 988
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 988
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 186
      Height = 36
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 186
      Top = 0
      Width = 129
      Height = 36
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 315
      Top = 0
      Width = 137
      Height = 36
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 459
      Top = 7
      Width = 74
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 36
    Width = 988
    Height = 585
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 56
    Top = 72
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
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
  object qReport: TOraQuery
    SQLLock.Strings = (
      'SELECT * FROM V_DISCOUNT_BILLS'
      'WHERE'
      
        '  ACCOUNT_ID = :Old_ACCOUNT_ID AND YEAR_MONTH = :Old_YEAR_MONTH ' +
        'AND PHONE_NUMBER = :Old_PHONE_NUMBER'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT YEAR_MONTH_DOSCOUNT, ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER' +
        ', ABONKA, CALLS, SINGLE_PAYMENTS, DISCOUNTS, BILL_SUM, COMPLETE_' +
        'BILL, ABON_MAIN, ABON_ADD, ABON_OTHER, SINGLE_MAIN, SINGLE_ADD, ' +
        'SINGLE_PENALTI, SINGLE_CHANGE_TARIFF, SINGLE_OTHER, DISCOUNT_YEA' +
        'R, DISCOUNT_SMS_PLUS, DISCOUNT_CALL, DISCOUNT_OTHERS, CALLS_COUN' +
        'TRY, CALLS_SITY, CALLS_LOCAL, CALLS_SMS_MMS, CALLS_GPRS, CALLS_R' +
        'US_RPP, CALLS_ALL, SINGLE_TURN_ON_SERV, DISCOUNT_COUNT_ON_PHONES' +
        ', SINGLE_CORRECTION_ROUMING, SINGLE_INTRA_WEB, SINGLE_VIEW_BLACK' +
        '_LIST, ROUMING_NATIONAL, ROUMING_INTERNATIONAL, DATE_CREATED, US' +
        'ER_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED FROM V_DISCOUNT' +
        '_BILLS'
      'WHERE'
      
        '  ACCOUNT_ID = :ACCOUNT_ID AND YEAR_MONTH = :YEAR_MONTH AND PHON' +
        'E_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'select *'
      '  from V_DISCOUNT_BILLS'
      '  where year_month = (select max(year_month)'
      '                        from db_loader_full_finance_bill)')
    FetchAll = True
    ReadOnly = True
    Left = 160
    Top = 176
    object qReportYEAR_MONTH_DOSCOUNT: TFloatField
      DisplayLabel = #1052#1077#1089#1103#1094' '#1089#1082#1080#1076#1082#1080
      FieldName = 'YEAR_MONTH_DOSCOUNT'
    end
    object qReportYEAR_MONTH: TFloatField
      DisplayLabel = #1052#1077#1089#1103#1094
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BILL_SUM'
      Required = True
    end
    object qReportABONKA: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083'.'
      FieldName = 'ABONKA'
      Required = True
    end
    object qReportCALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080
      FieldName = 'CALLS'
      Required = True
    end
    object qReportSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079'. '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
      Required = True
    end
    object qReportDISCOUNTS: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      FieldName = 'DISCOUNTS'
      Required = True
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 192
    Top = 184
  end
end
