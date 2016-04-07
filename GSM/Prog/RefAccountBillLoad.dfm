object RefAccountBillLoadForm: TRefAccountBillLoadForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1089#1095#1077#1090#1086#1074' '#1074' '#1073#1072#1083#1072#1085#1089
  ClientHeight = 723
  ClientWidth = 1006
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
  object Splitter2: TSplitter
    Left = 773
    Top = 37
    Height = 686
    Align = alRight
    ExplicitLeft = 768
    ExplicitTop = 360
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 8
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
    object cbPeriod: TComboBox
      Left = 74
      Top = 5
      Width = 129
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPeriodChange
    end
    object BitBtn1: TBitBtn
      Left = 210
      Top = 0
      Width = 137
      Height = 38
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
  end
  object Panel2: TPanel
    Left = 776
    Top = 37
    Width = 230
    Height = 686
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 1
    object CRDBGrid2: TCRDBGrid
      Left = 1
      Top = 25
      Width = 228
      Height = 660
      Align = alClient
      DataSource = dsAccNotBalance
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 228
      Height = 24
      Align = alTop
      Caption = #1057#1095#1077#1090#1072' '#1085#1077' '#1074' '#1073#1072#1083#1072#1085#1089#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 37
    Width = 773
    Height = 686
    Align = alClient
    Caption = 'Panel5'
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 640
      Width = 771
      Height = 45
      Align = alBottom
      TabOrder = 0
      object lSetup: TLabel
        Left = 16
        Top = 11
        Width = 217
        Height = 18
        Caption = #1047#1072#1076#1072#1090#1100' '#1077#1076#1080#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Splitter1: TSplitter
        Left = 1
        Top = 1
        Height = 43
        ExplicitLeft = 712
        ExplicitTop = 24
        ExplicitHeight = 100
      end
      object cbTurnOffSetup: TCheckBox
        Left = 245
        Top = 14
        Width = 140
        Height = 17
        Hint = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1080' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1089#1095#1077#1090#1086#1074' '#1074' '#1088#1072#1089#1095#1077#1090' '#1073#1072#1083#1072#1085#1089#1072
        Caption = #1055#1086#1076#1082#1083'/'#1053#1077#1087#1086#1076#1082#1083
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object deDateCreditSetup: TsDateEdit
        Left = 391
        Top = 12
        Width = 94
        Height = 21
        Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1085#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1088#1077#1076#1080#1090#1072
        AutoSize = False
        EditMask = '!99/99/9999;1; '
        MaxLength = 10
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = '  .  .    '
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -13
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
      end
      object BitBtn2: TBitBtn
        Left = 491
        Top = 10
        Width = 126
        Height = 25
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtn2Click
      end
    end
    object CRDBGrid1: TCRDBGrid
      Left = 1
      Top = 1
      Width = 771
      Height = 639
      Align = alClient
      DataSource = dsRef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
    end
  end
  object qRef: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE ACCOUNT_LOADED_BILLS'
      'SET'
      
        '  LOAD_BILL_IN_BALANCE = :LOAD_BILL_IN_BALANCE, DATE_BEGIN = :DA' +
        'TE_BEGIN, DATE_END = :DATE_END, DATE_CREDIT_END = :DATE_CREDIT_E' +
        'ND'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID AND YEAR_MONTH = :Old_YEAR_MONTH')
    SQLRefresh.Strings = (
      
        'SELECT ACCOUNT_ID, LOAD_BILL_IN_BALANCE, DATE_BEGIN, DATE_END, D' +
        'ATE_CREDIT_END, USER_LAST_UPDATE, DATE_LAST_UPDATE FROM ACCOUNT_' +
        'LOADED_BILLS'
      'WHERE'
      '  ACCOUNT_ID = :ACCOUNT_ID AND YEAR_MONTH = :YEAR_MONTH')
    SQL.Strings = (
      'SELECT AB.ACCOUNT_ID,'
      '       ACCOUNTS.LOGIN,'
      '       AB.YEAR_MONTH,'
      '       AB.DATE_BEGIN,'
      '       AB.DATE_END,'
      '       AB.DATE_CREDIT_END,'
      '       AB.LOAD_BILL_IN_BALANCE,'
      '       AB.USER_LAST_UPDATE,'
      '       AB.DATE_LAST_UPDATE'
      '  FROM ACCOUNT_LOADED_BILLS AB,'
      '       ACCOUNTS'
      '  WHERE AB.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)'
      '    AND AB.YEAR_MONTH = :YEAR_MONTH'
      '  ORDER BY AB.ACCOUNT_ID ASC')
    FetchRows = 500
    FetchAll = True
    Left = 248
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qRefLOGIN: TStringField
      Alignment = taCenter
      DisplayLabel = #1051'/'#1057
      DisplayWidth = 15
      FieldName = 'LOGIN'
      Size = 80
    end
    object qRefDATE_BEGIN: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
      Required = True
    end
    object qRefDATE_END: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
      Required = True
    end
    object qRefLOAD_BILL_IN_BALANCE: TFloatField
      DisplayLabel = #1042' '#1073#1072#1083#1072#1085#1089#1077'(1-'#1044#1072', 0-'#1053#1077#1090')'
      FieldName = 'LOAD_BILL_IN_BALANCE'
      Required = True
    end
    object qRefDATE_CREDIT_END: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1057#1088#1086#1082' '#1082#1088#1077#1076#1080#1090#1072
      DisplayWidth = 10
      FieldName = 'DATE_CREDIT_END'
      Required = True
    end
    object qRefUSER_LAST_UPDATE: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      DisplayWidth = 20
      FieldName = 'USER_LAST_UPDATE'
      Size = 120
    end
    object qRefDATE_LAST_UPDATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
      DisplayWidth = 19
      FieldName = 'DATE_LAST_UPDATE'
    end
  end
  object dsRef: TDataSource
    DataSet = qRef
    Left = 280
    Top = 72
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM ACCOUNT_LOADED_BILLS'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    ReadOnly = True
    Left = 144
    Top = 72
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 112
    Top = 112
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
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
    end
  end
  object qAccNotBalance: TOraQuery
    SQL.Strings = (
      'SELECT A.LOGIN,'
      
        '       TRUNC(T.YEAR_MONTH/100) || '#39' - '#39' || (T.YEAR_MONTH - TRUNC' +
        '(T.YEAR_MONTH/100)*100) YEAR_MONTH'
      '  FROM (SELECT *'
      '          FROM (SELECT B.ACCOUNT_ID, B.YEAR_MONTH'
      '                  FROM DB_LOADER_BILLS B'
      '                  GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH'
      '                UNION ALL  '
      '                SELECT B.ACCOUNT_ID, B.YEAR_MONTH'
      '                  FROM DB_LOADER_FULL_FINANCE_BILL B'
      '                  GROUP BY B.ACCOUNT_ID, B.YEAR_MONTH)'
      '          WHERE (ACCOUNT_ID, YEAR_MONTH) NOT IN '
      '                  (SELECT AB.ACCOUNT_ID, AB.YEAR_MONTH'
      '                     FROM ACCOUNT_LOADED_BILLS AB'
      '                     WHERE AB.LOAD_BILL_IN_BALANCE = 1)'
      '          GROUP BY ACCOUNT_ID, YEAR_MONTH) T, ACCOUNTS A'
      '  WHERE T.ACCOUNT_ID = A.ACCOUNT_ID(+)'
      '  ORDER BY T.ACCOUNT_ID, T.YEAR_MONTH DESC')
    FetchAll = True
    Left = 680
    Top = 112
    object qAccNotBalanceLOGIN: TStringField
      Alignment = taCenter
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      DisplayWidth = 18
      FieldName = 'LOGIN'
      Size = 120
    end
    object qAccNotBalanceYEAR_MONTH: TStringField
      Alignment = taCenter
      DisplayLabel = #1052#1077#1089#1103#1094
      DisplayWidth = 10
      FieldName = 'YEAR_MONTH'
      Size = 100
    end
  end
  object dsAccNotBalance: TDataSource
    DataSet = qAccNotBalance
    Left = 688
    Top = 176
  end
  object qSetupParamYearMonth: TOraQuery
    SQL.Strings = (
      'update account_loaded_bills'
      '  set account_loaded_bills.DATE_CREDIT_END = :PDATE_CREDIT,'
      '      account_loaded_bills.LOAD_BILL_IN_BALANCE = :PLOAD '
      '  where account_loaded_bills.YEAR_MONTH = :PYEAR_MONTH')
    Left = 560
    Top = 624
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PDATE_CREDIT'
      end
      item
        DataType = ftUnknown
        Name = 'PLOAD'
      end
      item
        DataType = ftUnknown
        Name = 'PYEAR_MONTH'
      end>
  end
end
