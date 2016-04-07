inherited ReportLossPhoneNumber: TReportLossPhoneNumber
  Caption = '"'#1042#1099#1073#1099#1074#1096#1080#1077'" '#1085#1086#1084#1077#1088#1072
  ClientHeight = 578
  ClientWidth = 912
  Position = poScreenCenter
  OnCreate = FormCreate
  ExplicitWidth = 928
  ExplicitHeight = 616
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 912
    Height = 137
    ExplicitWidth = 912
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
    Width = 912
    Height = 441
    ExplicitTop = 137
    ExplicitWidth = 912
    ExplicitHeight = 441
    inherited gReport: TCRDBGrid
      Width = 910
      Height = 439
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
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
          FieldName = 'BALANCE'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 108
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DOP_STATUS'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 143
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select '
      '  ACC.LOGIN,'
      '  ACC.COMPANY_NAME,'
      '  ACC.ACCOUNT_NUMBER,'
      '  A.PHONE_NUMBER,'
      '  GET_ABONENT_BALANCE(A.PHONE_NUMBER) as Balance,'
      
        '  (SELECT distinct  FIRST_VALUE(cd.DOP_STATUS_NAME) OVER (ORDER ' +
        'BY c.CONTRACT_DATE DESC) AS last_DOP_STATUS'
      '        FROM contracts c'
      '          left join contract_dop_statuses cd'
      '          on CD.DOP_STATUS_ID = C.DOP_STATUS'
      '          where c.PHONE_NUMBER_FEDERAL = A.PHONE_NUMBER'
      '  ) dop_status'
      'from DB_LOADER_PHONE_PERIODS A,'
      '     ACCOUNTS ACC'
      'where'
      '  A.YEAR_MONTH=:YEAR_MONTH'
      '  and not exists ('
      '                    select 1'
      '                    from'
      '                      DB_LOADER_ACCOUNT_PHONES B '
      '                    where'
      '                      B.YEAR_MONTH = A.YEAR_MONTH'
      '                      and B.PHONE_NUMBER=A.PHONE_NUMBER'
      '                      and B.ACCOUNT_ID=A.ACCOUNT_ID'
      '                  )'
      'and exists (  select 1'
      '              from'
      '                DB_LOADER_ACCOUNT_PHONES C '
      '              where'
      '                C.YEAR_MONTH = A.YEAR_MONTH-1'
      '                and C.PHONE_NUMBER = A.PHONE_NUMBER'
      '                AND C.ACCOUNT_ID=A.ACCOUNT_ID'
      '           )'
      'and A.ACCOUNT_ID = ACC.ACCOUNT_ID')
    Left = 56
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
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
      'from DB_LOADER_PHONE_PERIODS tr'
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
  object qReportTemplate: TOraQuery
    SQL.Strings = (
      'select '
      '  ACC.LOGIN,'
      '  ACC.COMPANY_NAME,'
      '  ACC.ACCOUNT_NUMBER,'
      '  A.PHONE_NUMBER,'
      '  GET_ABONENT_BALANCE(A.PHONE_NUMBER) as Balance,'
      
        '  (SELECT distinct  FIRST_VALUE(cd.DOP_STATUS_NAME) OVER (ORDER ' +
        'BY c.CONTRACT_DATE DESC) AS last_DOP_STATUS'
      '        FROM contracts c'
      '          left join contract_dop_statuses cd'
      '          on CD.DOP_STATUS_ID = C.DOP_STATUS'
      '          where c.PHONE_NUMBER_FEDERAL = A.PHONE_NUMBER'
      '  ) dop_status'
      'from DB_LOADER_PHONE_PERIODS A,'
      '     ACCOUNTS ACC'
      'where'
      '  A.YEAR_MONTH=:YEAR_MONTH'
      '  and not exists ('
      '                    select 1'
      '                    from'
      '                      DB_LOADER_ACCOUNT_PHONES B '
      '                    where'
      '                      B.YEAR_MONTH = A.YEAR_MONTH'
      '                      and B.PHONE_NUMBER=A.PHONE_NUMBER'
      '                      and B.ACCOUNT_ID=A.ACCOUNT_ID'
      '                  )'
      'and exists (  select 1'
      '              from'
      '                DB_LOADER_ACCOUNT_PHONES C '
      '              where'
      '                C.YEAR_MONTH = A.YEAR_MONTH-1'
      '                and C.PHONE_NUMBER = A.PHONE_NUMBER'
      '                AND C.ACCOUNT_ID=A.ACCOUNT_ID'
      '           )'
      'and A.ACCOUNT_ID = ACC.ACCOUNT_ID')
    Left = 64
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
end
