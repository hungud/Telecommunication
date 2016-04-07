inherited ReportCreditNumberFrm: TReportCreditNumberFrm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1082#1088#1077#1076#1080#1090#1085#1099#1084' '#1085#1086#1084#1077#1088#1072#1084
  ClientHeight = 578
  ClientWidth = 1065
  Position = poScreenCenter
  ExplicitWidth = 1081
  ExplicitHeight = 616
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 1065
    Height = 137
    ExplicitWidth = 1065
    ExplicitHeight = 137
    object lblPeriod: TLabel [0]
      Left = 352
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
    object lblAccount: TLabel [1]
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
    inherited btRefresh: TBitBtn
      Left = 521
      Top = 1
      ExplicitLeft = 521
      ExplicitTop = 1
    end
    inherited btLoadInExcel: TBitBtn
      Left = 632
      Top = 1
      ExplicitLeft = 632
      ExplicitTop = 1
    end
    object cbbPeriod: TComboBox [4]
      Left = 407
      Top = 5
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbbPeriodChange
    end
    object lstCLB_Accounts: TsCheckListBox [5]
      Left = 76
      Top = 3
      Width = 253
      Height = 128
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
      TabOrder = 3
      OnExit = lstCLB_AccountsExit
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
      OnClickCheck = lstCLB_AccountsClickCheck
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 773
      Top = 1
      TabOrder = 4
      ExplicitLeft = 773
      ExplicitTop = 1
    end
  end
  inherited pGrid: TPanel
    Top = 137
    Width = 1065
    Height = 441
    ExplicitTop = 137
    ExplicitWidth = 1065
    ExplicitHeight = 441
    inherited gReport: TCRDBGrid
      Width = 1063
      Height = 439
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_FEDERAL'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #8470' '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPANY_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1087#1072#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 108
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
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BILL_SUMM'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BILL_SUM_CREDIT'
          Title.Alignment = taCenter
          Title.Caption = #1057#1095#1077#1090' '#1089' '#1082#1088#1077#1076#1080#1090#1086#1084
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
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_NO_CREDIT'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089' '#1073#1077#1079' '#1082#1088#1077#1076#1080#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 126
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select '
      '    V.PHONE_NUMBER_FEDERAL,'
      '    A.ACCOUNT_NUMBER, '
      '    A.COMPANY_NAME,'
      '    V.CONTRACT_DATE,'
      '    V.BILL_SUMM,'
      '    V.BILL_SUM_CREDIT,'
      '    V.BALANCE,'
      '    V.BALANCE_NO_CREDIT,'
      '    case DB.PHONE_IS_ACTIVE'
      '      when 1  then '#39#1040#1082#1090#1080#1074#1077#1085#39
      '    else'
      '      '#39#1053#1077#1072#1082#1090#1080#1074#1077#1085#39
      '    end as status'
      'from v_credit_phone_bills v,'
      '        DB_LOADER_ACCOUNT_PHONES DB,'
      '        ACCOUNTS A'
      'where V.PHONE_NUMBER_FEDERAL = DB.PHONE_NUMBER(+)'
      '--AND v.YEAR_MONTH = DB.YEAR_MONTH(+)'
      'and DB.YEAR_MONTH = ('
      '                      select max(DB1.YEAR_MONTH)'
      '                        from DB_LOADER_ACCOUNT_PHONES db1'
      '                       where DB1.PHONE_NUMBER = DB.PHONE_NUMBER'
      '                    )'
      'AND DB.ACCOUNT_ID = A.ACCOUNT_ID(+)'
      'and  v.YEAR_MONTH = :pYEAR_MONTH')
    Left = 56
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH'
      end>
  end
  inherited dsReport: TDataSource
    Left = 104
    Top = 184
  end
  inherited aList: TActionList
    Left = 16
    Top = 184
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'select distinct TR.YEAR_MONTH '
      'from TARIFER_BILL_FOR_CLIENTS tr'
      'order by TR.YEAR_MONTH desc')
    Left = 160
    Top = 184
  end
  object qAccounts: TOraQuery
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login, COMPANY_NAME  FROM ACCOUNTS '
      'ORDER BY 2 ASC')
    Left = 216
    Top = 184
  end
  object qcredit_phone: TOraQuery
    SQL.Strings = (
      'select '
      '    V.PHONE_NUMBER_FEDERAL,'
      '    A.ACCOUNT_NUMBER, '
      '    A.COMPANY_NAME,'
      '    V.CONTRACT_DATE,'
      '    V.BILL_SUMM,'
      '    V.BILL_SUM_CREDIT,'
      '    V.BALANCE,'
      '    V.BALANCE_NO_CREDIT,'
      '    case DB.PHONE_IS_ACTIVE'
      '      when 1  then '#39#1040#1082#1090#1080#1074#1077#1085#39
      '    else'
      '      '#39#1053#1077#1072#1082#1090#1080#1074#1077#1085#39
      '    end as status'
      'from v_credit_phone_bills v,'
      '        DB_LOADER_ACCOUNT_PHONES DB,'
      '        ACCOUNTS A'
      'where V.PHONE_NUMBER_FEDERAL = DB.PHONE_NUMBER(+)'
      '--AND v.YEAR_MONTH = DB.YEAR_MONTH(+)'
      'and DB.YEAR_MONTH = ('
      '                      select max(DB1.YEAR_MONTH)'
      '                        from DB_LOADER_ACCOUNT_PHONES db1'
      '                       where DB1.PHONE_NUMBER = DB.PHONE_NUMBER'
      '                    )'
      'AND DB.ACCOUNT_ID = A.ACCOUNT_ID(+)'
      'and  v.YEAR_MONTH = :pYEAR_MONTH')
    Left = 56
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH'
      end>
  end
end
