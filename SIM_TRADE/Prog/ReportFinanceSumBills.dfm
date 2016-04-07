object ReportFinanceSumBillsForm: TReportFinanceSumBillsForm
  Left = 0
  Top = 0
  Caption = #1057#1091#1084#1084#1099' '#1089#1095#1077#1090#1086#1074' '#1080' '#1087#1083#1072#1090#1077#1078#1077#1081
  ClientHeight = 570
  ClientWidth = 929
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
    Left = 450
    Top = 28
    Height = 542
    ExplicitLeft = 465
    ExplicitTop = 29
    ExplicitHeight = 406
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 28
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 8
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
    object btLoadInExcelAccounts: TBitBtn
      Left = 157
      Top = 0
      Width = 138
      Height = 28
      Action = aExcelAccounts
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1083'/'#1089' '#1074' Excel '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 295
      Top = 0
      Width = 114
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1083'/'#1089
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbPeriod: TComboBox
      Left = 53
      Top = 5
      Width = 98
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 2
      OnChange = cbPeriodChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 28
    Width = 450
    Height = 542
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object GridReport_Accounts: TCRDBGrid
      Left = 0
      Top = 0
      Width = 450
      Height = 542
      Align = alClient
      DataSource = dsReport_Accounts
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -10
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel3: TPanel
    Left = 453
    Top = 28
    Width = 476
    Height = 542
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel5: TPanel
      Left = 0
      Top = 105
      Width = 476
      Height = 437
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object GridReport_Phones: TCRDBGrid
        Left = 0
        Top = 0
        Width = 476
        Height = 437
        Align = alClient
        DataSource = dsReport_Phones
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 476
      Height = 105
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object btLoadInExcelPhones: TBitBtn
        Left = 130
        Top = 40
        Width = 158
        Height = 28
        Action = aExcelPhones
        Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1074' Excel'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object clbAccounts: TCheckListBox
        Left = 3
        Top = 6
        Width = 121
        Height = 97
        OnClickCheck = clbAccountsClickCheck
        ItemHeight = 13
        TabOrder = 1
      end
      object btInfoAbonent: TBitBtn
        Left = 130
        Top = 71
        Width = 159
        Height = 28
        Action = aShowUserStatInfo
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object btRefreshPhone: TBitBtn
        Left = 130
        Top = 6
        Width = 159
        Height = 28
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1085#1086#1084#1077#1088#1072
        Glyph.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400BD733900C673
          3900C6733900C67B4200C6733900BD6B3100BD7B4A00BD9C8400FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00D6AD9C00BD6B3100C6844A00DE9C5A00DE9C
          5A00DE9C5200DE9C5200DE944A00DE8C4200D6843900C6733100BD734200B5AD
          A500BD9C8C00BD6B3100BD6B3100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00D6AD9C00BD6B3900DEAD7300E7B57300E7AD7300DEAD
          6B00E7B57B00E7BD8C00E7BD8C00DEA56300D68C4200DE8C3900CE7B3100B563
          2900B5632900C66B1800BD5A1800B58C7300FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00DEBDAD00B5633100E7B57B00E7BD8400E7B57B00E7B58400DEAD
          7B00D6A56B00D6945A00DEA57300E7BD9400EFCEA500DEA56300D68C3900D684
          3100CE7B2100CE731800B55A1800B57B5200FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00B55A3100DEB58400E7BD8C00E7BD8400D6A56B00BD6B3900AD52
          2100BD7B5200CE9C7B00BD6B4200AD522100C6733900DEA56300D68C4200CE84
          2900CE7B2100CE7B1800B55A1800AD633900FF00FF00FF00FF00FF00FF00FF00
          FF00CE947B00CE946B00EFC69C00E7BD8C00CE946300AD5A2900C69C8400FF00
          FF00FF00FF00FF00FF00FF00FF00D6B5A500A54A1800CE7B3100D6843100CE84
          2900CE7B2100CE7B1800BD631800AD522100FF00FF00FF00FF00FF00FF00FF00
          FF00A5522900EFCEA500EFC69400CE946300AD5A2900BD9C8C00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00A5522100CE8C4A00D68C3900D6843100CE84
          2900CE7B2100CE7B1800C66B2100A54A1800FF00FF00FF00FF00FF00FF00FF00
          FF00B56B4200F7D6B500E7BD8C00C67B4A00A5633900FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00D6A59400BD734200F7E7CE00EFC69C00D6944200CE84
          2900CE7B2100CE7B1800C66B2100A54A1800BDADA500FF00FF00FF00FF00CEA5
          8C00CE9C7B00F7DEBD00D69C6B00B56B4200AD8C7B00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00B56B4A00A54A2100D69C6B00EFCEAD00DEAD
          7300CE842900CE7B1800CE732100A54A1800B5948C00FF00FF00FF00FF00CEA5
          9400CE947300F7DEC600D6945A00AD633900B59C8C00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEC600A55A3100A5522100D69C
          6300E7BD8400D6944200CE7B2100AD521000A57B6B00FF00FF00FF00FF00CEAD
          9C00C68C6B00F7E7CE00D69C6300AD633900AD8C8400FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBDAD009C4A
          2100A5522100D6945200DEA56300B5631800A56B5200FF00FF00FF00FF00D6AD
          A500BD7B5A00FFF7E700DEA56B00C67B4A009C5A4200FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00CEA5940094391800AD521800B55A1800A5634A00FF00FF00FF00FF00FF00
          FF008C311800FFEFE700EFCEAD00D6844A008C311000ADA59C00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00C6948400A55A3900FF00FF00FF00FF00FF00FF00FF00
          FF00AD735A00D6AD8C00FFEFDE00DE9C6300C6844A0084311000AD9C9C00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BDB500AD8C8400B5A5A500FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF008C391800FFF7EF00EFD6B500D6945200C6844A00842908009452
          4200A58C8400AD948C00A5847B008C422900842908009439100084210800A584
          7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00A5635200B57B5A00FFF7F700EFCEA500DE9C5A00CE844A00BD73
          39009C4A29009C4A21009C4A2100BD6B3100C67B3100B55A2100A55218008C39
          1800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009C523900BD846300FFF7E700F7E7CE00E7B58400DE9C
          5A00D6945200CE8C4A00D6944A00D6944A00D6944200D68C4200AD5A29008C39
          2100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00AD6B520094392100DEBD9C00F7E7D600FFEF
          E700F7DEC600EFC69C00E7BD8400E7C69400DEAD7B00BD7B4A0084290800CEAD
          A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00D6BDB500944229007B1800009439
          1800B57B5200CE9C7B00BD845A00A55A310084290800A5634A00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEA5
          9C00B5847300AD735A00BD8C8400CEADA500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        TabOrder = 0
        OnClick = btRefreshPhoneClick
      end
    end
  end
  object qReport_Accounts: TOraQuery
    SQL.Strings = (
      'SELECT a.account_id, '
      '       a.login, '
      '       bill_beeline.bill_sum,'
      '       bill_client.bill_sum_new,'
      '       payments.payment_sum,'
      '       payments.payment_sum_1'
      'FROM (SELECT fb.account_id, SUM(fb.bill_sum) bill_sum'
      '      FROM db_loader_full_finance_bill fb'
      '      WHERE fb.complete_bill = 1'
      '        AND fb.year_month = :YEAR_MONTH'
      '      GROUP BY fb.account_id) bill_beeline,'
      '      (SELECT v.account_id, SUM(v.bill_sum_new) bill_sum_new'
      '       FROM v_bill_finance_for_client_det v'
      '       WHERE v.year_month = :YEAR_MONTH'
      '       GROUP BY v.account_id) bill_client,'
      
        '       (SELECT p.account_id, SUM(p.payment_sum) payment_sum, SUM' +
        '(p.payment_sum_1) payment_sum_1'
      
        '        FROM (SELECT get_account_id_by_phone(phone_number) accou' +
        'nt_id, '
      '                     CASE '
      '                       WHEN payment_type <> 1 THEN payment_sum'
      '                       ELSE 0 '
      '                     END payment_sum,'
      '                     CASE '
      '                       WHEN payment_type = 1 THEN payment_sum'
      '                       ELSE 0'
      '                     END payment_sum_1'
      '              FROM v_full_balance_payments'
      
        '              WHERE TO_NUMBER(TO_CHAR(payment_date,'#39'YYYYMM'#39'))=:Y' +
        'EAR_MONTH) p'
      '        GROUP BY p.account_id) payments,'
      '        accounts a'
      'WHERE a.account_id = bill_beeline.account_id'
      '  AND a.account_id = bill_client.account_id'
      '  AND a.account_id = payments.account_id'
      'ORDER BY a.login')
    Left = 80
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReport_AccountsLOGIN: TStringField
      DisplayLabel = #1051'/'#1089
      DisplayWidth = 15
      FieldName = 'LOGIN'
      Size = 15
    end
    object qReport_AccountsBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1105#1090#1072' '#1073#1080#1083#1072#1081#1085
      FieldName = 'BILL_SUM'
    end
    object qReport_AccountsBILL_SUM_NEW: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1105#1090#1072' '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'BILL_SUM_NEW'
    end
    object qReport_AccountsPAYMENT_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1077#1081' ('#1073#1077#1079' '#1088#1091#1095#1085#1099#1093')'
      FieldName = 'PAYMENT_SUM'
    end
    object qReport_AccountsPAYMENT_SUM_1: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1088#1091#1095#1085#1099#1093' '#1087#1083#1072#1090#1077#1078#1077#1081
      FieldName = 'PAYMENT_SUM_1'
    end
    object qReport_AccountsACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
      Visible = False
    end
  end
  object dsReport_Accounts: TDataSource
    DataSet = qReport_Accounts
    Left = 152
    Top = 96
  end
  object alReport: TActionList
    Images = MainForm.ImageList24
    Left = 40
    Top = 128
    object aExcelAccounts: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1083'/'#1089' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelAccountsExecute
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
    object aExcelPhones: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelPhonesExecute
    end
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
    Left = 144
    Top = 40
  end
  object qReport_Phones: TOraQuery
    SQL.Strings = (
      'SELECT a.login,'
      '       bill_beeline.phone_number,'
      '       bill_beeline.bill_sum,'
      '       bill_client.bill_sum_new,'
      '       payments.payment_sum,'
      '       payments.payment_sum_1'
      'FROM (SELECT fb.phone_number, SUM(FB.BILL_SUM) bill_sum'
      '      FROM db_loader_full_finance_bill fb'
      '      WHERE fb.complete_bill = 1'
      '        AND fb.year_month = :YEAR_MONTH'
      '        %ACCOUNTS%'
      '      GROUP BY fb.phone_number) bill_beeline,'
      '      (SELECT v.phone_number, SUM(v.bill_sum_new) bill_sum_new'
      '       FROM v_bill_finance_for_client_det v'
      '       WHERE v.year_month = :YEAR_MONTH'
      '        %ACCOUNTS%'
      '       GROUP BY v.phone_number) bill_client,'
      
        '       (SELECT p.phone_number, SUM(p.payment_sum) payment_sum, S' +
        'UM(p.payment_sum_1) payment_sum_1'
      '        FROM (SELECT phone_number,'
      '                     CASE '
      '                       WHEN payment_type <> 1 THEN payment_sum'
      '                       ELSE 0 '
      '                     END payment_sum,'
      '                     CASE '
      '                       WHEN payment_type = 1 THEN payment_sum'
      '                       ELSE 0'
      '                     END payment_sum_1'
      '              FROM v_full_balance_payments'
      
        '              WHERE TO_NUMBER(TO_CHAR(payment_date,'#39'YYYYMM'#39'))=:Y' +
        'EAR_MONTH'
      '                %ACCOUNTS2%) p'
      '        GROUP BY p.phone_number) payments,'
      '        accounts a'
      'WHERE bill_beeline.phone_number = bill_client.phone_number'
      '  AND bill_client.phone_number = payments.phone_number'
      
        '  AND a.account_id = get_account_id_by_phone(bill_beeline.phone_' +
        'number)'
      'ORDER BY a.login')
    Left = 464
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReport_Phoneslogin: TStringField
      DisplayLabel = #1051'/'#1089
      DisplayWidth = 15
      FieldName = 'login'
      Size = 15
    end
    object qReport_PhonesPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 15
      FieldName = 'PHONE_NUMBER'
      Size = 15
    end
    object qReport_PhonesBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1105#1090#1072' '#1073#1080#1083#1072#1081#1085
      FieldName = 'BILL_SUM'
    end
    object qReport_PhonesBILL_SUM_NEW: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1105#1090#1072' '#1082#1083#1080#1077#1085#1090#1091
      FieldName = 'BILL_SUM_NEW'
    end
    object qReport_PhonesPAYMENT_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1077#1081' ('#1073#1077#1079' '#1088#1091#1095#1085#1099#1093')'
      FieldName = 'PAYMENT_SUM'
    end
    object qReport_PhonesPAYMENT_SUM_1: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1088#1091#1095#1085#1099#1093' '#1087#1083#1072#1090#1077#1078#1077#1081
      FieldName = 'PAYMENT_SUM_1'
    end
  end
  object dsReport_Phones: TDataSource
    DataSet = qReport_Phones
    Left = 544
    Top = 80
  end
end
