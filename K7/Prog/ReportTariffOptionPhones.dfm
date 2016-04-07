object ReportTariffOptionPhonesForm: TReportTariffOptionPhonesForm
  Left = 0
  Top = 0
  Caption = #1058#1072#1088#1080#1092#1085#1099#1077' '#1086#1087#1094#1080#1080' '#1080' '#1091#1089#1083#1091#1075#1080' - '#1057#1087#1080#1089#1082#1080' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 476
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 241
    Top = 27
    Width = 2
    Height = 449
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 27
    Align = alTop
    TabOrder = 0
    object lTariffOptions: TLabel
      Left = 9
      Top = 8
      Width = 148
      Height = 13
      Caption = #1058#1072#1088#1080#1092#1085#1072#1103' '#1086#1087#1094#1080#1103'/'#1091#1089#1083#1091#1075#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 378
      Top = 0
      Width = 121
      Height = 27
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 499
      Top = 0
      Width = 83
      Height = 27
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 582
      Top = 0
      Width = 81
      Height = 27
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 669
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
    object cbTariffOptions: TComboBox
      Left = 153
      Top = 5
      Width = 219
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 4
      OnChange = cbTariffOptionsChange
    end
  end
  object TarOptMonthsGrid: TCRDBGrid
    Left = 0
    Top = 27
    Width = 241
    Height = 449
    Align = alLeft
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'OPTION_CODE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'YEAR_MONTH'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNT_OPTION'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 106
        Visible = True
      end>
  end
  object TarOptPhonesGrid: TCRDBGrid
    Left = 243
    Top = 27
    Width = 648
    Height = 449
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsPhones
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
        SortOrder = soDesc
      end
      item
        Expanded = False
        FieldName = 'TURN_ON_DATE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURN_OFF_DATE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_CHECK_DATE_TIME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1085#1086#1084#1077#1088#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end>
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
  object qTariffOptions: TOraQuery
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT O.OPTION_CODE, O.OPTION_NAME'
      '  FROM DB_LOADER_ACCOUNT_PHONE_OPTS O'
      '  GROUP BY O.OPTION_CODE, O.OPTION_NAME'
      '  ORDER BY O.OPTION_CODE')
    Left = 216
    Top = 80
  end
  object qPhones: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT O.PHONE_NUMBER,'
      '       O.TURN_ON_DATE,'
      '       O.TURN_OFF_DATE,      '
      '       O.LAST_CHECK_DATE_TIME,'
      '       case when DB.PHONE_IS_ACTIVE = 1'
      '        then '#39#1040#1082#1090'.'#39
      '        else case when nvl(DB.CONSERVATION,0) = 0'
      '              then '#39#1041#1083#1086#1082'.'#39
      '              else '#39#1057#1086#1093#1088'.'#39
      '              end'
      '       end Status  '
      
        '  FROM DB_LOADER_ACCOUNT_PHONE_OPTS O, DB_LOADER_ACCOUNT_PHONES ' +
        'db'
      '  WHERE O.OPTION_CODE = :OPTION_CODE'
      '    and O.PHONE_NUMBER=DB.PHONE_NUMBER'
      '    AND db.YEAR_MONTH = O.YEAR_MONTH'
      '    AND O.YEAR_MONTH = :YEAR_MONTH'
      '  ORDER BY O.PHONE_NUMBER DESC')
    FetchRows = 500
    FetchAll = True
    Active = True
    Left = 344
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
        Value = Null
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
        Value = Null
      end>
    object qPhonesPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qPhonesTURN_ON_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      FieldName = 'TURN_ON_DATE'
    end
    object qPhonesTURN_OFF_DATE: TDateTimeField
      DisplayLabel = #1042#1099#1082#1083#1102#1095#1077#1085#1080#1077
      FieldName = 'TURN_OFF_DATE'
    end
    object qPhonesLAST_CHECK_DATE_TIME: TDateTimeField
      DisplayLabel = #1055#1086#1089#1083'. '#1087#1088#1086#1074#1077#1088#1082#1072
      FieldName = 'LAST_CHECK_DATE_TIME'
    end
    object qPhonesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 9
    end
  end
  object qReport: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT O.OPTION_CODE, '
      
        '       SUBSTR(YEAR_MONTH, 1, 4) || '#39' - '#39' || SUBSTR(YEAR_MONTH, 5' +
        ', 2) YEAR_MONTH,'
      '       COUNT(1) COUNT_OPTION       '
      '  FROM DB_LOADER_ACCOUNT_PHONE_OPTS O'
      '  WHERE O.OPTION_CODE = :OPTION_CODE'
      '  GROUP BY O.OPTION_CODE, O.YEAR_MONTH'
      '  ORDER BY O.YEAR_MONTH DESC')
    FetchRows = 500
    Left = 96
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end>
    object qReportOPTION_CODE: TStringField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 12
      FieldName = 'OPTION_CODE'
      Size = 120
    end
    object qReportYEAR_MONTH: TStringField
      DisplayLabel = #1052#1077#1089#1103#1094
      DisplayWidth = 12
      FieldName = 'YEAR_MONTH'
      Size = 112
    end
    object qReportCOUNT_OPTION: TFloatField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1085#1086#1084#1077#1088#1086#1074
      DisplayWidth = 10
      FieldName = 'COUNT_OPTION'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    OnDataChange = dsReportDataChange
    Left = 128
    Top = 88
  end
  object dsPhones: TDataSource
    DataSet = qPhones
    Left = 384
    Top = 120
  end
end
