object ShowPaymentsForm: TShowPaymentsForm
  Left = 0
  Top = 0
  Caption = #1055#1083#1072#1090#1077#1078#1080' '#1084#1077#1078#1076#1091' '#1089#1086#1093#1088#1072#1085#1077#1085#1085#1099#1084#1080' '#1073#1072#1083#1072#1085#1089#1072#1084#1080
  ClientHeight = 215
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grData: TCRDBGrid
    Left = 0
    Top = 0
    Width = 394
    Height = 215
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
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
        FieldName = 'payment_sum'
        Title.Alignment = taCenter
        Title.Caption = #1055#1083#1072#1090#1077#1078
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
        Width = 152
        Visible = True
      end>
  end
  object dsReport: TDataSource
    DataSet = qreport
    Left = 112
    Top = 136
  end
  object qreport: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT a.account_id, a.login, p.payment_sum, p.date_created FROM' +
        ' db_loader_payments p, accounts a WHERE p.account_id=:account_id' +
        ' AND p.account_id = a.account_id'
      
        'AND p.date_created BETWEEN (SELECT MAX(NVL(date_last_updated,dat' +
        'e_created)) FROM balance_change'
      
        '                            WHERE NVL(date_last_updated,date_cre' +
        'ated) < :date_balance AND account_id = :account_id) '
      '                          AND :date_balance')
    Left = 168
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'date_balance'
      end>
  end
end
