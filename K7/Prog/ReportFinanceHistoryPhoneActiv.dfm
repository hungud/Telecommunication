object ReportFinanceHistoryPhoneActivForm: TReportFinanceHistoryPhoneActivForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1082#1080' '#1072#1082#1090#1080#1074#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 440
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 28
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 8
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
    object btLoadInExcel: TBitBtn
      Left = 156
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
      Left = 277
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
      Left = 511
      Top = 0
      Width = 89
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 53
      Top = 5
      Width = 98
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 606
      Top = 6
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
    object BitBtn1: TBitBtn
      Left = 671
      Top = 0
      Width = 137
      Height = 28
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1077#1088#1080#1086#1076
      TabOrder = 5
      OnClick = BitBtn1Click
    end
    object cbAccounts: TComboBox
      Left = 363
      Top = 3
      Width = 145
      Height = 20
      Style = csDropDownList
      TabOrder = 6
      Items.Strings = (
        #1042#1089#1077
        #1050#1086#1083#1083#1077#1082#1090#1086#1088
        #1050#1088#1086#1084#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072)
    end
  end
  object GridReport: TCRDBGrid
    Left = 0
    Top = 28
    Width = 808
    Height = 412
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsReport
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
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Width = 109
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAN'
        Title.Alignment = taCenter
        Width = 109
        Visible = True
      end>
  end
  object qReport: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT *'
      '  FROM PHONE_ACTIV_LOG'
      '  WHERE YEAR_MONTH=:YEAR_MONTH'
      '  ORDER BY PHONE_NUMBER')
    FetchRows = 250
    FetchAll = True
    Left = 80
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReportPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 15
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportBAN: TFloatField
      Alignment = taCenter
      DisplayLabel = #1041#1072#1085
      DisplayWidth = 15
      FieldName = 'BAN'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 136
    Top = 104
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
  object qPeriods: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM PHONE_ACTIV_LOG'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 184
    Top = 88
  end
end
