object ReportBalanceChangeForm: TReportBalanceChangeForm
  Left = 0
  Top = 0
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1073#1072#1083#1072#1085#1089#1086#1074
  ClientHeight = 431
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 621
    Height = 28
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 756
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
      Left = 291
      Top = -1
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
      Left = 188
      Top = -1
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
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbAccountsChange
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 28
    Width = 621
    Height = 403
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'login'
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATE_CREATED'
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
      
        'SELECT a.ACCOUNT_ID, a.login, b.balance, b.date_created, b.date_' +
        'last_updated, b.user_last_updated'
      'FROM balance_change b, accounts a'
      'WHERE a.account_id = b.account_id AND '
      '((:ACCOUNT_ID IS NULL)OR(b.account_id = :ACCOUNT_ID))'
      'ORDER BY a.account_id, NVL(date_last_updated,date_created)')
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
end
