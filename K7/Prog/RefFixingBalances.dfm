object RefFixingBalancesFrm: TRefFixingBalancesFrm
  Left = 0
  Top = 0
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1087#1077#1088#1080#1086#1076#1086#1074
  ClientHeight = 434
  ClientWidth = 921
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 420
    Top = 53
    Height = 381
    ExplicitLeft = 456
    ExplicitTop = 200
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 921
    Height = 28
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 179
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
    object lAccount: TLabel
      Left = 9
      Top = 7
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
      Left = 336
      Top = 0
      Width = 145
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 481
      Top = 0
      Width = 90
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 571
      Top = 0
      Width = 88
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 231
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 664
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
    object cbAccount: TComboBox
      Left = 74
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 5
      OnChange = cbAccountChange
    end
  end
  object FixBalanceGrid: TCRDBGrid
    Left = 0
    Top = 53
    Width = 420
    Height = 381
    Align = alLeft
    DataSource = dsPhoneBalances
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
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
        FieldName = 'BALANCE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1073#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIX_BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081' '#1073#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 28
    Width = 921
    Height = 25
    Align = alTop
    TabOrder = 2
    object lStatus: TLabel
      Left = 9
      Top = 5
      Width = 40
      Height = 13
      Caption = 'lStatus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object btUnFix: TBitBtn
      Left = 289
      Top = 0
      Width = 129
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1077#1088#1080#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btUnFixClick
    end
    object btFix: TBitBtn
      Left = 420
      Top = 0
      Width = 126
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1077#1088#1080#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btFixClick
    end
  end
  object pBalanceDetail: TPanel
    Left = 423
    Top = 53
    Width = 498
    Height = 381
    Align = alClient
    TabOrder = 3
    object pBalanceCaption: TPanel
      Left = 1
      Top = 1
      Width = 496
      Height = 20
      Align = alTop
      Caption = 'pBalanceCaption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object BalanceRowGrid: TCRDBGrid
      Left = 1
      Top = 21
      Width = 496
      Height = 359
      Align = alClient
      DataSource = dsBalanceRows
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ROW_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COST_PLUS'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1080#1093#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COST_MINUS'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1089#1093#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ROW_COMMENT'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end>
    end
  end
  object qAccounts: TOraQuery
    SQL.Strings = (
      'SELECT ACCOUNT_ID,'
      '       LOGIN'
      '  FROM ACCOUNTS'
      '  ORDER BY LOGIN ASC')
    Left = 32
    Top = 80
  end
  object qFixPeriods: TOraQuery
    SQL.Strings = (
      'SELECT FIX_YEAR_MONTH,'
      
        '       '#39'  '#39' || TO_CHAR(FIX_YEAR_MONTH - (TRUNC(FIX_YEAR_MONTH / ' +
        '100) * 100)) '
      '         || '#39' - '#39' || TRUNC(FIX_YEAR_MONTH / 100) YEAR_MONTH_NAME'
      '  FROM FIX_YEAR_MONTHS'
      '  WHERE FIX_YEAR_MONTHS.ACCOUNT_ID=:ACCOUNT_ID'
      '  ORDER BY FIX_YEAR_MONTH DESC')
    Left = 32
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT YEAR_MONTH,'
      
        '       '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 1' +
        '00)) '
      '         || '#39' - '#39' || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME,'
      
        '       ADD_MONTHS(TO_DATE(TO_CHAR(YEAR_MONTH) || '#39'01'#39','#39'YYYYMMDD'#39 +
        ')-1/(24*60*60),1) balance_date'
      '  FROM DB_LOADER_BILLS'
      '  WHERE DB_LOADER_BILLS.ACCOUNT_ID=:ACCOUNT_ID'
      '  GROUP BY YEAR_MONTH'
      '  ORDER BY YEAR_MONTH DESC')
    Left = 32
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object qPhoneBalances: TOraQuery
    SQL.Strings = (
      'SELECT PHONE_NUMBER,'
      '       BALANCE,'
      '       BALANCE FIX_BALANCE,'
      '       YEAR_MONTH,'
      '       BALANCE_DATE'
      '  FROM V_YEAR_MONTH_BALANCE '
      '  WHERE ACCOUNT_ID=:ACCOUNT_ID'
      '    AND YEAR_MONTH=:YEAR_MONTH'
      '    AND BALANCE<>0')
    FetchRows = 250
    FetchAll = True
    Left = 32
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
  object dsAccounts: TDataSource
    DataSet = qAccounts
    Left = 64
    Top = 88
  end
  object dsPeriods: TDataSource
    DataSet = qPeriods
    Left = 64
    Top = 144
  end
  object dsFixPeriods: TDataSource
    DataSet = qFixPeriods
    Left = 64
    Top = 200
  end
  object dsPhoneBalances: TDataSource
    DataSet = qPhoneBalances
    OnDataChange = dsPhoneBalancesDataChange
    Left = 64
    Top = 256
  end
  object ActionList: TActionList
    Images = MainForm.ImageList24
    Left = 128
    Top = 80
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
  object qBalanceRows: TOraQuery
    SQL.Strings = (
      'SELECT * FROM'
      '('
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  ABONENT_BALANCE_ROWS.ROW_COST AS COST_PLUS,'
      '  TO_NUMBER(NULL) AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST > 0'
      'UNION ALL'
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  TO_NUMBER(NULL) AS COST_PLUS,'
      '  -ABONENT_BALANCE_ROWS.ROW_COST AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST < 0'
      ')'
      'ORDER BY'
      '  ROW_DATE')
    FetchRows = 50
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 32
    Top = 305
  end
  object dsBalanceRows: TDataSource
    DataSet = qBalanceRows
    Left = 64
    Top = 312
  end
  object spCalcBalanceRows: TOraStoredProc
    StoredProcName = 'CALC_BALANCE_ROWS'
    SQL.Strings = (
      'begin'
      '  CALC_BALANCE_ROWS(:PPHONE_NUMBER, :PBALANCE_DATE);'
      'end;')
    Left = 96
    Top = 320
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PBALANCE_DATE'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'CALC_BALANCE_ROWS:0'
  end
  object spGetFixMonthID: TOraStoredProc
    StoredProcName = 'GET_FIX_YEAR_MONTH_ID'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := GET_FIX_YEAR_MONTH_ID(:PACCOUNT_ID, :PFIX_YEAR_MONT' +
        'H);'
      'end;')
    Left = 96
    Top = 208
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PACCOUNT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PFIX_YEAR_MONTH'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'GET_FIX_YEAR_MONTH_ID'
  end
  object qInsertFixMonth: TOraQuery
    SQL.Strings = (
      
        'INSERT INTO FIX_YEAR_MONTHS (FIX_YEAR_MONTH, FIX_DATE, ACCOUNT_I' +
        'D) '
      '  VALUES (:FIX_YEAR_MONTH, SYSDATE, :ACCOUNT_ID)')
    Left = 96
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FIX_YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object spInsertBalanceRow: TOraStoredProc
    StoredProcName = 'INSERT_FIX_BALANCE'
    SQL.Strings = (
      'begin'
      
        '  INSERT_FIX_BALANCE(:PPHONE_NUMBER, :PBALANCE_DATE, :PFIX_BALAN' +
        'CE, :PFIX_YEAR_MONTH_ID);'
      'end;')
    Left = 128
    Top = 272
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PBALANCE_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PFIX_BALANCE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PFIX_YEAR_MONTH_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'INSERT_FIX_BALANCE'
  end
  object spDeleteFixMonth: TOraStoredProc
    StoredProcName = 'DELETE_FIX_MONTH'
    SQL.Strings = (
      'begin'
      '  DELETE_FIX_MONTH(:PACCOUNT_ID, :PFIX_YEAR_MONTH_ID);'
      'end;')
    Left = 160
    Top = 280
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PACCOUNT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PFIX_YEAR_MONTH_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'DELETE_FIX_MONTH'
  end
end
