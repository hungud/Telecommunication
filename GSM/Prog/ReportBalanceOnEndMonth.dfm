object ReportBalanceOnEndMonthForm: TReportBalanceOnEndMonthForm
  Left = 0
  Top = 0
  Caption = #1041#1072#1083#1072#1085#1089#1099' '#1085#1072' '#1082#1086#1085#1077#1094' '#1084#1077#1089#1103#1094#1072
  ClientHeight = 466
  ClientWidth = 919
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 81
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 328
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
      Left = 6
      Top = 8
      Width = 69
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Lb_daterep: TLabel
      AlignWithMargins = True
      Left = 328
      Top = 34
      Width = 151
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086'  '#1086#1090#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btLoadInExcel: TBitBtn
      Left = 487
      Top = -1
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 623
      Top = -1
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 729
      Top = -1
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 382
      Top = 2
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 846
      Top = 5
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
    end
    object CLB_Accounts: TsCheckListBox
      Left = 76
      Top = 3
      Width = 246
      Height = 72
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnMouseMove = CLB_AccountsMouseMove
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      OnClickCheck = CLB_AccountsClickCheck
    end
    object CBRefresh: TCheckBox
      Left = 626
      Top = 34
      Width = 156
      Height = 19
      Caption = #1057' '#1087#1077#1088#1077#1089#1073#1086#1088#1086#1084' '#1076#1072#1085#1085#1099#1093
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 7
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 441
    Width = 919
    Height = 25
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    object Gauge1: TGauge
      Left = 298
      Top = 1
      Width = 620
      Height = 23
      Align = alClient
      BorderStyle = bsNone
      ForeColor = clNavy
      Progress = 0
      ExplicitLeft = 228
      ExplicitWidth = 690
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 1
      Width = 297
      Height = 23
      Align = alLeft
      Panels = <>
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 81
    Width = 919
    Height = 360
    OnGetCellParams = grDataGetCellParams
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
        Width = 124
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
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATE_BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
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
        Width = 97
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEGIN_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089#1090#1072#1090#1091#1089#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTIV'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIBER_PAYMENT_NEW'
        Title.Alignment = taCenter
        Title.Caption = #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_CALLS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ALL_CALLS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_NEW'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_SUM'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_SUM_OLD'
        Title.Alignment = taCenter
        Title.Caption = #1041#1080' '#1044#1080#1083#1077#1088' '#1089#1091#1084#1084#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TYPE_ABON'
        Title.Caption = #1060#1086#1088#1084#1072' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1099
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 122
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXIT_PLUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1089#1095#1077#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_CHANGE_STATUS_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089#1090#1072#1090#1091#1089#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 108
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
      'FROM ACCOUNTS'
      'ORDER BY 1')
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
      'FROM DB_LOADER_FULL_FINANCE_BILL'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 160
    Top = 136
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  v.*,'
      '  CASE '
      '    WHEN V.PHONE_IS_ACTIVE=1 THEN '#39#1040#1082#1090'.'#39
      '  ELSE'
      '    '#39#1041#1083#1086#1082'.'#39
      '  END AS STATUS,'
      '  p.LAST_CHANGE_STATUS_DATE'
      '  FROM BalanceEndM_Report V'
      '      left join db_loader_account_phones p'
      '          on  V.PHONE_NUMBER = P.phone_number '
      '              and V.YEAR_MONTH = P.YEAR_MONTH  '
      '  WHERE V.session_id = :SESSION_ID'
      '  '
      '  order by v.phone_number')
    FetchRows = 500
    FetchAll = True
    Left = 32
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SESSION_ID'
      end>
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportDATE_BALANCE: TDateTimeField
      FieldName = 'DATE_BALANCE'
    end
    object qReportBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qReportSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 9
    end
    object qReportBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
    end
    object qReportSUBSCRIBER_PAYMENT_NEW: TFloatField
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object qReportACTIV: TFloatField
      DisplayLabel = #1053#1072#1083#1080#1095'. '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'ACTIV'
    end
    object qReportDILER_CALLS: TFloatField
      DisplayLabel = #1044#1080#1083#1077#1088'. '#1079#1074#1086#1085#1082#1080
      FieldName = 'DILER_CALLS'
    end
    object qReportALL_CALLS: TFloatField
      DisplayLabel = #1042#1089#1077' '#1079#1074#1086#1085#1082#1080
      FieldName = 'ALL_CALLS'
    end
    object qReportBILL_SUM_NEW: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'BILL_SUM_NEW'
    end
    object qReportDILER_SUM: TFloatField
      DisplayLabel = #1044#1080#1083#1077#1088' '#1089#1091#1084#1084#1072
      FieldName = 'DILER_SUM'
    end
    object qReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      DisplayWidth = 80
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qReportLOGIN: TStringField
      DisplayLabel = #1051'/'#1057
      FieldName = 'LOGIN'
      Size = 15
    end
    object qReportPHONE_IS_ACTIVE: TIntegerField
      FieldName = 'PHONE_IS_ACTIVE'
    end
    object qReportSESSION_ID: TFloatField
      FieldName = 'SESSION_ID'
    end
    object qReportDATE_REPORT: TDateTimeField
      FieldName = 'DATE_REPORT'
    end
    object qReportTYPE_ABON: TStringField
      FieldName = 'TYPE_ABON'
      Size = 30
    end
    object qReportEXIT_PLUS: TStringField
      FieldName = 'EXIT_PLUS'
      Size = 30
    end
    object qReportDILER_SUM_OLD: TFloatField
      FieldName = 'DILER_SUM_OLD'
    end
    object LAST_CHANGE_STATUS_DATE: TDateTimeField
      FieldName = 'LAST_CHANGE_STATUS_DATE'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 96
    Top = 144
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 832
    Top = 32
  end
end
