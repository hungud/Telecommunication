object ReportPromisedPaymentsForm: TReportPromisedPaymentsForm
  Left = 0
  Top = 0
  Caption = #1054#1073#1077#1097#1072#1085#1085#1099#1077' '#1087#1083#1072#1090#1077#1078#1080
  ClientHeight = 591
  ClientWidth = 1063
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1063
    Height = 105
    Align = alTop
    TabOrder = 0
    object lAccount: TLabel
      Left = 8
      Top = 7
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 376
      Top = 7
      Width = 133
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 510
      Top = 7
      Width = 102
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 614
      Top = 7
      Width = 109
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 729
      Top = 13
      Width = 58
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object CLB_Accounts: TsCheckListBox
      Left = 76
      Top = 3
      Width = 286
      Height = 96
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
      TabOrder = 4
      OnExit = CLB_AccountsExit
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
  end
  object Payments: TCRDBGrid
    Left = 0
    Top = 105
    Width = 1063
    Height = 486
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Caption = #1051#1086#1075#1080#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 101
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROMISED_SUM'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PAYMENT_DATE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PROMISED_DATE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 134
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATE_CREATED'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRIZNAK'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1080#1079#1085#1072#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 208
    Top = 224
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
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT pp.PHONE_NUMBER,'
      '       pp.PROMISED_SUM,'
      '       TRUNC(pp.PAYMENT_DATE) PAYMENT_DATE,'
      
        '       TO_CHAR(pp.PROMISED_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39') PROMIS' +
        'ED_DATE,'
      '       pp.DATE_CREATED,'
      '       pp.USER_CREATED,'
      '       acc.login,'
      '       IOT_CURRENT_BALANCE.BALANCE,'
      '       case'
      '         when pp.promised_date < sysdate then'
      '           null'
      '       else '
      '         '#39#1044#1077#1081#1089#1090#1074#1091#1102#1097#1080#1081#39
      '       end   as priznak,'
      '       ACC.COMPANY_NAME        '
      
        '  FROM PROMISED_PAYMENTS pp, db_loader_account_phones dbl, accou' +
        'nts acc, '
      '  IOT_CURRENT_BALANCE'
      '  where pp.phone_number=dbl.phone_number '
      '    and acc.account_id=dbl.account_id '
      '    and pp.phone_number = IOT_CURRENT_BALANCE.phone_number(+)'
      '    AND dbl.year_month = to_CHAR(sysdate,'#39'yyyymm'#39')')
    FetchRows = 250
    Left = 144
    Top = 272
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportPROMISED_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'PROMISED_SUM'
      Required = True
    end
    object qReportPAYMENT_DATE: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      FieldName = 'PAYMENT_DATE'
    end
    object qReportPROMISED_DATE: TStringField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 18
      FieldName = 'PROMISED_DATE'
      Size = 19
    end
    object qReportDATE_CREATED: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'DATE_CREATED'
    end
    object qReportUSER_CREATED: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qReportLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 120
    end
    object qReportPRIZNAK: TStringField
      FieldName = 'PRIZNAK'
      Size = 22
    end
    object qReportBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qReportCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 160
    Top = 224
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login, COMPANY_NAME  FROM ACCOUNTS '
      'ORDER BY 2 ASC')
    Left = 216
    Top = 272
  end
  object qUserCheckAllow: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT check_allow_account FROM user_names'
      'WHERE UPPER(user_name) = UPPER(:user_name)')
    Left = 320
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'user_name'
      end>
  end
  object qAccounts_Allow: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT a.ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : ' +
        #39'||COMPANY_NAME) as login, COMPANY_NAME'
      'FROM ACCOUNTS a, user_names u, rights_type_account_allow r'
      'WHERE UPPER(u.user_name) = UPPER(:user_name) '
      
        '  AND u.rights_type = r.rights_type AND r.account_id = a.account' +
        '_id'
      'ORDER BY 2 ASC')
    Left = 320
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'user_name'
      end>
  end
end
