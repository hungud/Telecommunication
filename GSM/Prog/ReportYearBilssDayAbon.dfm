object ReportYearBilssDayAbonForm: TReportYearBilssDayAbonForm
  Left = 0
  Top = 0
  Caption = 'ReportYearBilssDayAbonForm'
  ClientHeight = 325
  ClientWidth = 778
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object grReport: TCRDBGrid
    Left = 0
    Top = 28
    Width = 778
    Height = 297
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
    Width = 778
    Height = 28
    Align = alTop
    TabOrder = 1
    object lPeriod: TLabel
      Left = 14
      Top = 7
      Width = 26
      Height = 13
      Caption = #1043#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 121
      Top = 0
      Width = 121
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 241
      Top = 0
      Width = 83
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 324
      Top = 0
      Width = 81
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 43
      Top = 5
      Width = 72
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 411
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
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 344
    Top = 128
  end
  object qReport: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT * '
      '  FROM V_SUTOCHNIE_BILLS'
      '  WHERE V_SUTOCHNIE_BILLS.YEARS = :YEARS')
    FetchAll = True
    Left = 312
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEARS'
      end>
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportBILL_01: TFloatField
      DisplayLabel = #1071#1085#1074#1072#1088#1100
      FieldName = 'BILL_01'
    end
    object qReportBILL_02: TFloatField
      DisplayLabel = #1060#1077#1074#1088#1072#1083#1100
      FieldName = 'BILL_02'
    end
    object qReportBILL_03: TFloatField
      DisplayLabel = #1052#1072#1088#1090
      FieldName = 'BILL_03'
    end
    object qReportBILL_04: TFloatField
      DisplayLabel = #1040#1087#1088#1077#1083#1100
      FieldName = 'BILL_04'
    end
    object qReportBILL_05: TFloatField
      DisplayLabel = #1052#1072#1081
      FieldName = 'BILL_05'
    end
    object qReportBILL_06: TFloatField
      DisplayLabel = #1048#1102#1085#1100
      FieldName = 'BILL_06'
    end
    object qReportBILL_07: TFloatField
      DisplayLabel = #1048#1102#1083#1100
      FieldName = 'BILL_07'
    end
    object qReportBILL_08: TFloatField
      DisplayLabel = #1040#1074#1075#1091#1089#1090
      FieldName = 'BILL_08'
    end
    object qReportBILL_09: TFloatField
      DisplayLabel = #1057#1077#1085#1090#1103#1073#1088#1100
      FieldName = 'BILL_09'
    end
    object qReportBILL_10: TFloatField
      DisplayLabel = #1054#1082#1090#1103#1073#1088#1100
      FieldName = 'BILL_10'
    end
    object qReportBILL_11: TFloatField
      DisplayLabel = #1053#1086#1103#1073#1088#1100
      FieldName = 'BILL_11'
    end
    object qReportBILL_12: TFloatField
      DisplayLabel = #1044#1077#1082#1072#1073#1088#1100
      FieldName = 'BILL_12'
    end
    object qReportSUTOCHN_ABON: TFloatField
      DisplayLabel = #1055#1086#1089#1091#1090#1086#1095#1085#1099#1081'(1-'#1076#1072')'
      FieldName = 'SUTOCHN_ABON'
    end
  end
  object qYears: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT TRUNC(YEAR_MONTH / 100) YEARS'
      '  FROM DB_LOADER_FULL_FINANCE_BILL'
      '  GROUP BY TRUNC(YEAR_MONTH / 100)'
      '  ORDER BY TRUNC(YEAR_MONTH / 100) DESC')
    Left = 216
    Top = 72
  end
  object alReport: TActionList
    Images = MainForm.ImageList24
    Left = 40
    Top = 128
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
end
