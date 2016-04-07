object ReportBillsForm: TReportBillsForm
  Left = 0
  Top = 0
  Caption = #1057#1095#1077#1090#1072
  ClientHeight = 735
  ClientWidth = 1132
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1132
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 241
      Top = 10
      Width = 61
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lAccount: TLabel
      Left = 10
      Top = 10
      Width = 75
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 449
      Top = 0
      Width = 176
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 626
      Top = 0
      Width = 138
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 765
      Top = 0
      Width = 145
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 311
      Top = 4
      Width = 130
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      DropDownCount = 25
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 918
      Top = 8
      Width = 78
      Height = 22
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
      TabOrder = 4
      OnClick = cbSearchClick
    end
    object cbAccounts: TComboBox
      Left = 99
      Top = 4
      Width = 129
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      DropDownCount = 25
      TabOrder = 5
      OnChange = cbAccountsChange
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 37
    Width = 1132
    Height = 698
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'BILL_SUM'
        Title.Alignment = taCenter
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAIL'
        Title.Alignment = taCenter
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_ITOG_SUM'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEELINE_FULL_SUM'
        Title.Alignment = taCenter
        Width = 128
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHECK_LONG_PLUS_BALANCE2'
        Title.Alignment = taCenter
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_FULL_SUM'
        Title.Alignment = taCenter
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIBER_PAYMENT_OLD'
        Title.Alignment = taCenter
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIBER_PAYMENT_NEW'
        Title.Alignment = taCenter
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_PAYMENT_FULL'
        Title.Alignment = taCenter
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_PAYMENT'
        Title.Alignment = taCenter
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIBER_PAYMENT_ADD_OLD'
        Title.Alignment = taCenter
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPTION_COST_DILER_BEELINE'
        Title.Alignment = taCenter
        Width = 172
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPTION_COST_DILER'
        Title.Alignment = taCenter
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPTION_COST_FULL'
        Title.Alignment = taCenter
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INSTALLMENT_PAYMENT_SUM'
        Title.Alignment = taCenter
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_SUMM_OLD_MONTH_IN_MINUS'
        Title.Alignment = taCenter
        Width = 131
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
      'SELECT ACCOUNT_ID, LOGIN '
      '  FROM ACCOUNTS'
      '  WHERE DILER_PAYMETS=1'
      '  ORDER BY LOGIN ASC')
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
      'SELECT *'
      '  FROM V_BILL_FOR_DILER2 V'
      '  WHERE V.YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(V.ACCOUNT_ID=:ACCOUNT_ID))'
      '  ORDER BY V.PHONE_NUMBER ASC')
    FetchRows = 500
    FetchAll = True
    Left = 64
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportBILL_SUM_ORIGIN: TFloatField
      FieldName = 'BILL_SUM_ORIGIN'
    end
    object qReportBILL_SUM: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'BILL_SUM'
    end
    object qReportDISCOUNT_VALUE: TFloatField
      FieldName = 'DISCOUNT_VALUE'
    end
    object qReportDILER_PAYMENT: TFloatField
      DisplayLabel = #1053#1072#1095#1080#1089#1083'. '#1076#1080#1083#1077#1088#1091
      FieldName = 'DILER_PAYMENT'
    end
    object qReportDILER_PAYMENT_FULL: TFloatField
      DisplayLabel = #1042#1089#1077' '#1085#1072#1095#1080#1089#1083'.'
      FieldName = 'DILER_PAYMENT_FULL'
    end
    object qReportSUBSCRIBER_PAYMENT_NEW: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object qReportSUBSCRIBER_PAYMENT_OLD: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'SUBSCRIBER_PAYMENT_OLD'
    end
    object qReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField
      DisplayLabel = #1042#1089#1077' '#1091#1089#1083'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_OLD'
    end
    object qReportOPTION_COST_DILER: TFloatField
      DisplayLabel = #1059#1089#1083#1091#1075#1080' '#1076#1080#1083#1077#1088#1072#1084
      FieldName = 'OPTION_COST_DILER'
    end
    object qReportOPTION_COST_FULL: TFloatField
      DisplayLabel = #1042#1089#1077' '#1091#1089#1083#1091#1075#1080
      FieldName = 'OPTION_COST_FULL'
    end
    object qReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qReportOPTION_COST_DILER_BEELINE: TFloatField
      DisplayLabel = #1040#1075#1077#1085#1090' '#1091#1089#1083#1091#1075#1080' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'OPTION_COST_DILER_BEELINE'
    end
    object qReportTAIL: TFloatField
      DisplayLabel = #1044#1086#1083#1075
      FieldName = 'TAIL'
    end
    object qReportDILER_FULL_SUM: TFloatField
      DisplayLabel = #1042#1086#1079#1085#1072#1075#1088' '#1076#1080#1083#1077#1088#1091
      FieldName = 'DILER_FULL_SUM'
    end
    object qReportBEELINE_FULL_SUM: TFloatField
      DisplayLabel = #1042#1086#1079#1085#1072#1075#1088' '#1086#1090' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'BEELINE_FULL_SUM'
    end
    object qReportDILER_ITOG_SUM: TFloatField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'DILER_ITOG_SUM'
    end
    object qReportCHECK_LONG_PLUS_BALANCE2: TStringField
      DisplayLabel = #1056#1077#1087#1091#1090#1072#1094#1080#1103
      FieldName = 'CHECK_LONG_PLUS_BALANCE2'
      FixedChar = True
      Size = 1
    end
    object qReportINSTALLMENT_PAYMENT_SUM: TFloatField
      FieldName = 'INSTALLMENT_PAYMENT_SUM'
    end
    object qReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField
      FieldName = 'DILER_SUMM_OLD_MONTH_IN_MINUS'
    end
  end
  object dsReport: TDataSource
    DataSet = vtReport
    Left = 96
    Top = 144
  end
  object vtReport: TVirtualTable
    FieldDefs = <
      item
        Name = 'PHONE_NUMBER'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BILL_SUM_ORIGIN'
        DataType = ftFloat
      end
      item
        Name = 'BILL_SUM'
        DataType = ftFloat
      end
      item
        Name = 'DISCOUNT_VALUE'
        DataType = ftFloat
      end
      item
        Name = 'DILER_PAYMENT'
        DataType = ftFloat
      end
      item
        Name = 'DILER_PAYMENT_FULL'
        DataType = ftFloat
      end
      item
        Name = 'SUBSCRIBER_PAYMENT_NEW'
        DataType = ftFloat
      end
      item
        Name = 'SUBSCRIBER_PAYMENT_OLD'
        DataType = ftFloat
      end
      item
        Name = 'SUBSCRIBER_PAYMENT_ADD_OLD'
        DataType = ftFloat
      end
      item
        Name = 'OPTION_COST_DILER'
        DataType = ftFloat
      end
      item
        Name = 'OPTION_COST_FULL'
        DataType = ftFloat
      end
      item
        Name = 'TARIFF_NAME'
        DataType = ftString
        Size = 400
      end
      item
        Name = 'OPTION_COST_DILER_BEELINE'
        DataType = ftFloat
      end
      item
        Name = 'TAIL'
        DataType = ftFloat
      end
      item
        Name = 'DILER_FULL_SUM'
        DataType = ftFloat
      end
      item
        Name = 'BEELINE_FULL_SUM'
        DataType = ftFloat
      end
      item
        Name = 'DILER_ITOG_SUM'
        DataType = ftFloat
      end
      item
        Name = 'CHECK_LONG_PLUS_BALANCE2'
        DataType = ftString
        Size = 1
      end>
    Left = 64
    Top = 184
    Data = {
      030012000C0050484F4E455F4E554D42455201002800000000000F0042494C4C
      5F53554D5F4F524947494E0600000000000000080042494C4C5F53554D060000
      00000000000E00444953434F554E545F56414C554506000000000000000D0044
      494C45525F5041594D454E540600000000000000120044494C45525F5041594D
      454E545F46554C4C06000000000000001600535542534352494245525F504159
      4D454E545F4E455706000000000000001600535542534352494245525F504159
      4D454E545F4F4C4406000000000000001A00535542534352494245525F504159
      4D454E545F4144445F4F4C44060000000000000011004F5054494F4E5F434F53
      545F44494C4552060000000000000010004F5054494F4E5F434F53545F46554C
      4C06000000000000000B005441524946465F4E414D4501009001000000001900
      4F5054494F4E5F434F53545F44494C45525F4245454C494E4506000000000000
      0004005441494C06000000000000000E0044494C45525F46554C4C5F53554D06
      0000000000000010004245454C494E455F46554C4C5F53554D06000000000000
      000E0044494C45525F49544F475F53554D06000000000000001800434845434B
      5F4C4F4E475F504C55535F42414C414E43453201000100000000000000000000
      00}
    object vtReportPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object vtReportBILL_SUM_ORIGIN: TFloatField
      FieldName = 'BILL_SUM_ORIGIN'
    end
    object vtReportBILL_SUM: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'BILL_SUM'
    end
    object vtReportDISCOUNT_VALUE: TFloatField
      FieldName = 'DISCOUNT_VALUE'
    end
    object vtReportDILER_PAYMENT: TFloatField
      DisplayLabel = #1053#1072#1095#1080#1089#1083'. '#1076#1080#1083#1077#1088#1091
      FieldName = 'DILER_PAYMENT'
    end
    object vtReportDILER_PAYMENT_FULL: TFloatField
      DisplayLabel = #1042#1089#1077' '#1085#1072#1095#1080#1089#1083'.'
      FieldName = 'DILER_PAYMENT_FULL'
    end
    object vtReportSUBSCRIBER_PAYMENT_NEW: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object vtReportSUBSCRIBER_PAYMENT_OLD: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'SUBSCRIBER_PAYMENT_OLD'
    end
    object vtReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField
      DisplayLabel = #1042#1089#1077' '#1091#1089#1083'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_OLD'
    end
    object vtReportOPTION_COST_DILER: TFloatField
      DisplayLabel = #1059#1089#1083#1091#1075#1080' '#1076#1080#1083#1077#1088#1072#1084
      FieldName = 'OPTION_COST_DILER'
    end
    object vtReportOPTION_COST_FULL: TFloatField
      DisplayLabel = #1042#1089#1077' '#1091#1089#1083#1091#1075#1080
      FieldName = 'OPTION_COST_FULL'
    end
    object vtReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object vtReportOPTION_COST_DILER_BEELINE: TFloatField
      DisplayLabel = #1040#1075#1077#1085#1090' '#1091#1089#1083#1091#1075#1080' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'OPTION_COST_DILER_BEELINE'
    end
    object vtReportTAIL: TFloatField
      DisplayLabel = #1044#1086#1083#1075
      FieldName = 'TAIL'
    end
    object vtReportDILER_FULL_SUM: TFloatField
      DisplayLabel = #1042#1086#1079#1085#1072#1075#1088' '#1076#1080#1083#1077#1088#1091
      FieldName = 'DILER_FULL_SUM'
    end
    object vtReportBEELINE_FULL_SUM: TFloatField
      DisplayLabel = #1042#1086#1079#1085#1072#1075#1088' '#1086#1090' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'BEELINE_FULL_SUM'
    end
    object vtReportDILER_ITOG_SUM: TFloatField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'DILER_ITOG_SUM'
    end
    object vtReportCHECK_LONG_PLUS_BALANCE2: TStringField
      DisplayLabel = #1056#1077#1087#1091#1090#1072#1094#1080#1103
      FieldName = 'CHECK_LONG_PLUS_BALANCE2'
      FixedChar = True
      Size = 1
    end
    object vtReportINSTALLMENT_PAYMENT_SUM: TFloatField
      DisplayLabel = #1056#1072#1089#1089#1088#1086#1095#1082#1072
      FieldName = 'INSTALLMENT_PAYMENT_SUM'
    end
    object vtReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField
      DisplayLabel = #1048#1089#1087#1088#1072#1074#1080#1074#1096#1080#1077#1089#1103' '#1089#1095#1077#1090#1072
      FieldName = 'DILER_SUMM_OLD_MONTH_IN_MINUS'
    end
  end
end
