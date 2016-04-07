object ShowBillDetailsForm: TShowBillDetailsForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1082#1072#1076#1088#1086#1074#1082#1072' '#1089#1095#1077#1090#1072
  ClientHeight = 315
  ClientWidth = 1084
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
    Width = 1084
    Height = 35
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 447
    object BitBtn1: TBitBtn
      Left = 5
      Top = 5
      Width = 89
      Height = 25
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object CRDBGrid1: TCRDBGrid
    Left = 0
    Top = 35
    Width = 1084
    Height = 280
    Align = alClient
    DataSource = dsBillDetails
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
  end
  object qBillDetails: TOraQuery
    SQL.Strings = (
      'SELECT B.DATE_BEGIN,'
      '       B.DATE_END,'
      '       B.PHONE_NUMBER,'
      '       V.BILL_SUM,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, V.SUBSCRIBER_PAY' +
        'MENT_NEW), 2) SUBSCRIBER_PAYMENT_NEW,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.SUBSCRIBER_PAY' +
        'MENT_ADD), 2) SUBSCRIBER_PAYMENT_ADD,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, V.OPTION_CORRECT' +
        '_SUM), 2) OPTION_CORRECT_SUM,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.SUBSCRIBER_PAY' +
        'MENT_ADD+OPTION_CORRECT_SUM), 2) SUBSCRIBER_PAYMENT_ADD_NEW,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.CALLS_LOCAL_CO' +
        'ST), 2) CALLS_LOCAL_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.CALLS_OTHER_CI' +
        'TY_COST), 2) CALLS_OTHER_CITY_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.CALLS_OTHER_CO' +
        'UNTRY_COST), 2) CALLS_OTHER_COUNTRY_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.INTERNET_COST)' +
        ', 2) INTERNET_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.MESSAGES_COST)' +
        ', 2) MESSAGES_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.NATIONAL_ROAMI' +
        'NG_COST), 2) NATIONAL_ROAMING_COST,'
      
        '       TRUNC(RECALC_CHARGE_COST(B.PHONE_NUMBER, B.OTHER_COUNTRY_' +
        'ROAMING_COST), 2) OTHER_COUNTRY_ROAMING_COST,'
      '       CASE'
      
        '         WHEN B.SINGLE_PAYMENTS>0 THEN TRUNC(RECALC_CHARGE_COST(' +
        'B.PHONE_NUMBER, B.SINGLE_PAYMENTS ), 2)'
      '         ELSE 0'
      '       END SINGLE_PAYMENTS '
      '  FROM DB_LOADER_BILLS B,'
      '       V_BILL_FOR_CLIENT V'
      '  WHERE V.ACCOUNT_ID=B.ACCOUNT_ID'
      '    AND V.YEAR_MONTH=B.YEAR_MONTH'
      '    AND V.PHONE_NUMBER=B.PHONE_NUMBER'
      '    AND B.PHONE_NUMBER=:PHONE_NUMBER'
      '    AND B.YEAR_MONTH=:YEAR_MONTH')
    Left = 160
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qBillDetailsDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
    end
    object qBillDetailsDATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
    end
    object qBillDetailsPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qBillDetailsBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1077#1090#1072
      FieldName = 'BILL_SUM'
    end
    object qBillDetailsSUBSCRIBER_PAYMENT_NEW: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object qBillDetailsSUBSCRIBER_PAYMENT_ADD_NEW: TFloatField
      DisplayLabel = #1059#1089#1083#1091#1075#1080
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_NEW'
    end
    object qBillDetailsCALLS_LOCAL_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1089#1090#1085#1099#1077
      FieldName = 'CALLS_LOCAL_COST'
    end
    object qBillDetailsCALLS_OTHER_CITY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1075#1086#1088'.'
      FieldName = 'CALLS_OTHER_CITY_COST'
    end
    object qBillDetailsCALLS_OTHER_COUNTRY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1085#1072#1088'.'
      FieldName = 'CALLS_OTHER_COUNTRY_COST'
    end
    object qBillDetailsINTERNET_COST: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'INTERNET_COST'
    end
    object qBillDetailsMESSAGES_COST: TFloatField
      DisplayLabel = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      FieldName = 'MESSAGES_COST'
    end
    object qBillDetailsNATIONAL_ROAMING_COST: TFloatField
      DisplayLabel = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'NATIONAL_ROAMING_COST'
    end
    object qBillDetailsOTHER_COUNTRY_ROAMING_COST: TFloatField
      DisplayLabel = #1052'. '#1085#1072#1088'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'OTHER_COUNTRY_ROAMING_COST'
    end
    object qBillDetailsSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079'. '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
    end
  end
  object dsBillDetails: TDataSource
    DataSet = qBillDetails
    Left = 192
    Top = 120
  end
end
