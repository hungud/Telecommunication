object ReportTariffViolationsFrm: TReportTariffViolationsFrm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1086' '#1085#1077#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1103#1093' '#1074' '#1090#1072#1088#1080#1092#1072#1093
  ClientHeight = 518
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 518
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 322
      Width = 882
      Height = 7
      Cursor = crVSplit
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      ExplicitTop = 323
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 882
      Height = 28
      Align = alTop
      TabOrder = 0
      object lPeriod: TLabel
        Left = 14
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
        Left = 166
        Top = -1
        Width = 123
        Height = 28
        Action = aExcel
        Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object btRefresh: TBitBtn
        Left = 289
        Top = -1
        Width = 85
        Height = 28
        Action = aRefresh
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object btInfoAbonent: TBitBtn
        Left = 374
        Top = -1
        Width = 82
        Height = 28
        Action = aShowUserStatInfo
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object cbPeriod: TComboBox
        Left = 61
        Top = 3
        Width = 99
        Height = 21
        Style = csDropDownList
        DropDownCount = 50
        TabOrder = 3
        OnChange = cbPeriodChange
      end
      object cbSearch: TCheckBox
        Left = 462
        Top = 4
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
    object TariffViolationsGrid: TCRDBGrid
      Left = 1
      Top = 29
      Width = 882
      Height = 293
      Align = alClient
      DataSource = dsTariffViolations
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
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CELL_PLAN_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1072#1088#1080#1092#1072' '#1091' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          Width = 134
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME_FROM_OPERATOR'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          Width = 210
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1072#1088#1080#1092#1072' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
          Width = 136
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1074' '#1076#1086#1075#1086#1074#1086#1088#1077
          Width = 210
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS_CODE'
          Title.Alignment = taCenter
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LAST_CHANGE_STATUS_DATE'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS'
          Title.Alignment = taCenter
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOP_STATUS_NAME'
          Title.Alignment = taCenter
          Width = 324
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOP_STATUS_DATE'
          Title.Alignment = taCenter
          Width = 148
          Visible = True
        end>
    end
    object TarViolOptionGrid: TCRDBGrid
      Left = 1
      Top = 329
      Width = 882
      Height = 188
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      DataSource = dsTarViolOptions
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
    end
  end
  object qTariffViolations: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM V_TARIFF_VIOLATIONS'
      '  WHERE YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(ACCOUNT_ID=:ACCOUNT_ID))'
      '  ORDER BY PHONE_NUMBER')
    FetchRows = 500
    Left = 128
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qTariffViolationsPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qTariffViolationsCELL_PLAN_CODE: TStringField
      FieldName = 'CELL_PLAN_CODE'
      Size = 200
    end
    object qTariffViolationsTARIFF_CODE: TStringField
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qTariffViolationsYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qTariffViolationsTARIFF_NAME_FROM_OPERATOR: TStringField
      FieldName = 'TARIFF_NAME_FROM_OPERATOR'
      Size = 400
    end
    object qTariffViolationsTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTariffViolationsSTATUS_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1089#1090#1072#1090#1091#1089#1072
      DisplayWidth = 8
      FieldName = 'STATUS_CODE'
      Size = 80
    end
    object qTariffViolationsLAST_CHANGE_STATUS_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1089#1090#1072#1090#1091#1089#1072
      DisplayWidth = 12
      FieldName = 'LAST_CHANGE_STATUS_DATE'
    end
    object qTariffViolationsSTATUS: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      DisplayWidth = 7
      FieldName = 'STATUS'
      Size = 9
    end
    object qTariffViolationsDOP_STATUS_NAME: TStringField
      DisplayLabel = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
      DisplayWidth = 40
      FieldName = 'DOP_STATUS_NAME'
      Size = 400
    end
    object qTariffViolationsDOP_STATUS_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1087'.'#1089#1090#1072#1090#1091#1089#1072
      DisplayWidth = 18
      FieldName = 'DOP_STATUS_DATE'
    end
  end
  object dsTariffViolations: TDataSource
    DataSet = qTariffViolations
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
      'FROM DB_LOADER_ACCOUNT_PHONES'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 216
    Top = 128
  end
  object alTariffViolations: TActionList
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
  object qTarViolOptions: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM V_TARIFF_VIOLATION_OPTION')
    FetchRows = 250
    FetchAll = True
    Left = 128
    Top = 136
    object qTarViolOptionsPHONE_NUMBER_FEDERAL: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER_FEDERAL'
      Required = True
      Size = 40
    end
    object qTarViolOptionsTARIFF_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1058#1055
      DisplayWidth = 12
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qTarViolOptionsTARIFF_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1058#1055
      DisplayWidth = 40
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTarViolOptionsOPTION_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1091#1089#1083#1091#1075#1080
      DisplayWidth = 12
      FieldName = 'OPTION_CODE'
      Size = 120
    end
    object qTarViolOptionsOPTION_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080
      DisplayWidth = 40
      FieldName = 'OPTION_NAME'
      Size = 400
    end
  end
  object dsTarViolOptions: TDataSource
    DataSet = qTarViolOptions
    Left = 160
    Top = 144
  end
end
