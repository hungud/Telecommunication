object ReportMissingPhonesForm: TReportMissingPhonesForm
  Left = 0
  Top = 0
  Caption = #1053#1086#1084#1077#1088#1072' '#1080#1089#1095#1077#1079#1085#1091#1074#1096#1080#1077' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  ClientHeight = 433
  ClientWidth = 803
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
    Width = 803
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
    Width = 803
    Height = 405
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
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Caption = #1051'/'#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
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
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELL_PLAN_CODE'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076' '#1058#1055
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 97
        Visible = True
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 84
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
      'FROM ACCOUNTS '
      'ORDER BY LOGIN ASC')
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
    Left = 160
    Top = 136
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT a.login, p.phone_number, p.year_month, '
      
        '       NVL(p.new_cell_plan_code, p.cell_plan_code) cell_plan_cod' +
        'e, c.contract_num,'
      '       CASE WHEN c.contract_num IS NOT NULL THEN'
      '         get_abonent_balance(p.phone_number)'
      '       END balance'
      'FROM accounts a, db_loader_account_phones p, v_contracts c'
      'WHERE a.account_id = get_account_id_by_phone(p.phone_number)'
      '  AND p.phone_number = c.phone_number_federal(+)'
      '  AND c.contract_cancel_date IS NULL'
      '  AND ((:ACCOUNT_ID IS NULL) OR (a.account_id = :ACCOUNT_ID))'
      '  AND p.year_month = :YEAR_MONTH-1'
      '  AND NOT exists (SELECT 1 from db_loader_account_phones p1 '
      '                  WHERE p.phone_number = p1.phone_number'
      '                    AND p1.year_month = :YEAR_MONTH)'
      'ORDER BY 1,2')
    FetchRows = 500
    FetchAll = True
    Left = 64
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportCELL_PLAN_CODE: TStringField
      DisplayWidth = 20
      FieldName = 'CELL_PLAN_CODE'
      Size = 50
    end
    object qReportLogin: TStringField
      FieldName = 'LOGIN'
      Size = 30
    end
    object qReportCONTRACT_NUM: TFloatField
      FieldName = 'CONTRACT_NUM'
    end
    object qReportBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 96
    Top = 144
  end
end
