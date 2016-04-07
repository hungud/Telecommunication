object ShowBalanceChangeForm: TShowBalanceChangeForm
  Left = 0
  Top = 0
  Caption = #1057#1085#1080#1078#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072' '#1085#1072' '#1083#1080#1094#1077#1074#1086#1084' '#1089#1095#1077#1090#1077
  ClientHeight = 551
  ClientWidth = 989
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
    Width = 989
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
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
      Left = 381
      Top = -1
      Width = 176
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 246
      Top = -1
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
      TabOrder = 2
      OnChange = cbAccountsChange
    end
    object BitBtn1: TBitBtn
      Left = 557
      Top = -1
      Width = 145
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aCheck
      Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 37
    Width = 989
    Height = 514
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
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'login'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1051'/'#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 93
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'balance'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
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
        FieldName = 'lag_balance'
        Title.Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1080#1081' '#1073#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 133
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATE_CREATED'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1079#1072#1087#1080#1089#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 113
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'USER_LAST_UPDATED'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100', '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1074#1096#1080#1081' '#1079#1072#1087#1080#1089#1100' '#1087#1086#1089#1083#1077#1076#1085#1080#1084
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 107
        Visible = True
      end>
  end
  object ActionList: TActionList
    Images = MainForm.ImageList24
    Left = 64
    Top = 88
    object aCheck: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086
      ImageIndex = 7
      OnExecute = aCheckExecute
    end
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
    object aPayments: TAction
      Caption = #1055#1083#1072#1090#1077#1078#1080
      ImageIndex = 20
      OnExecute = aPaymentsExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN FROM ACCOUNTS ORDER BY LOGIN ASC')
    Left = 160
    Top = 88
  end
  object dsReport: TDataSource
    DataSet = qreport
    Left = 112
    Top = 136
  end
  object qreport: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT a.account_id, a.login, b.balance, b.lag_balance, b.date_c' +
        'reated,'
      '       b.date_last_updated, b.user_last_updated'
      'FROM (SELECT ACCOUNT_ID, BALANCE,'
      
        '           LAG(balance) OVER (PARTITION BY account_id ORDER BY N' +
        'VL(date_last_updated,date_created)) lag_balance,'
      '           date_created, date_last_updated, user_last_updated'
      '      FROM balance_change) b, accounts a'
      
        'WHERE a.account_id = b.account_id AND b.user_last_updated IS NUL' +
        'L AND'
      '((:ACCOUNT_ID IS NULL)OR(b.account_id = :ACCOUNT_ID))'
      'ORDER BY a.account_id')
    Left = 168
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 112
    object N1: TMenuItem
      Action = aCheck
      ShortCut = 115
    end
    object N2: TMenuItem
      Action = aRefresh
      ShortCut = 116
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Action = aPayments
    end
  end
  object qUpdate: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'UPDATE balance_change SET user_last_updated = USER'
      'WHERE account_id = :ACCOUNT_ID AND user_last_updated IS NULL AND'
      'NVL(date_last_updated,date_created) = :record_date')
    Left = 248
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'record_date'
      end>
  end
end
