object ReportPhoneNumberViolationsFrm: TReportPhoneNumberViolationsFrm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1077#1083#1077#1092#1086#1085#1072#1084' '#1089' '#1087#1086#1090#1088#1077#1073#1083#1077#1085#1080#1077#1084' '#1091#1089#1083#1091#1075' '#1073#1077#1079' '#1076#1086#1075#1086#1074#1086#1088#1072' '
  ClientHeight = 423
  ClientWidth = 763
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
    Width = 763
    Height = 28
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 769
    object lPeriod: TLabel
      Left = 246
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
      Width = 28
      Height = 13
      Caption = #1051'/C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 398
      Top = 0
      Width = 123
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 521
      Top = 0
      Width = 85
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 606
      Top = 0
      Width = 82
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 293
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 694
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
      Left = 34
      Top = 4
      Width = 206
      Height = 21
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 5
      OnChange = cbAccountsChange
    end
  end
  object PhoneNumberViolationsGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 763
    Height = 395
    Align = alClient
    DataSource = dsPhoneNumberViolations
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTIMATE_SUM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZEROCOST_OUTCOME_COUNT'
        Title.Alignment = taCenter
        Title.Caption = #1041#1077#1089#1087#1083' '#1079#1074
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZEROCOST_OUTCOME_MINUTES'
        Title.Alignment = taCenter
        Title.Caption = #1052#1080#1085' '#1074' '#1073#1077#1089#1087#1083' '#1079#1074
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_COUNT'
        Title.Alignment = taCenter
        Title.Caption = #1055#1083' '#1079#1074
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_MINUTES'
        Title.Alignment = taCenter
        Title.Caption = #1052#1080#1085' '#1074' '#1087#1083' '#1079#1074
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALLS_COST'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1083' '#1079#1074
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMS_COUNT'
        Title.Alignment = taCenter
        Title.Caption = #1055#1083' '#1057#1052#1057
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMS_COST'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1057#1052#1057
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
        FieldName = 'MMS_COUNT'
        Title.Alignment = taCenter
        Title.Caption = #1055#1083' '#1052#1052#1057
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MMS_COST'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1052#1052#1057
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INTERNET_MB'
        Title.Alignment = taCenter
        Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090' (Mb)'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INTERNET_COST'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1048#1085#1090#1077#1088#1085#1077#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 143
        Visible = True
      end>
  end
  object qPhoneNumberViolations: TOraQuery
    SQL.Strings = (
      'SELECT * '
      '  FROM V_PHONE_NUMBER_VIOLATIONS'
      '  WHERE V_PHONE_NUMBER_VIOLATIONS.YEAR_MONTH=:YEAR_MONTH'
      
        '    AND ((:ACCOUNT_ID IS NULL)OR(V_PHONE_NUMBER_VIOLATIONS.ACCOU' +
        'NT_ID=:ACCOUNT_ID) or (:ACCOUNT_ID=-1))'
      '  ORDER BY V_PHONE_NUMBER_VIOLATIONS.ESTIMATE_SUM DESC')
    FetchRows = 250
    Left = 112
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object dsPhoneNumberViolations: TDataSource
    DataSet = qPhoneNumberViolations
    Left = 112
    Top = 136
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
    Left = 240
    Top = 128
  end
  object alPhoneNumberViolations: TActionList
    Images = MainForm.ImageList24
    Left = 80
    Top = 80
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
      'SELECT ACCOUNT_ID, '
      '       LOGIN||'#39': '#39'||COMPANY_NAME LOGIN'
      '  FROM ACCOUNTS '
      '--union all'
      '--select -1, '#39#1042#1089#1077#39' from dual'
      'ORDER BY 2 ASC')
    Left = 240
    Top = 80
  end
end
