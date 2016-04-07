object ReportPhoneInactivityForm: TReportPhoneInactivityForm
  Left = 0
  Top = 0
  ActiveControl = eBeginDate
  Caption = #1053#1086#1084#1077#1088#1072' c '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1077#1081' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100#1102
  ClientHeight = 449
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 91
    Align = alTop
    TabOrder = 0
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
    object Label1: TLabel
      Left = 343
      Top = 45
      Width = 80
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 534
      Top = 45
      Width = 101
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 324
      Top = 2
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 475
      Top = 2
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 580
      Top = 2
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 697
      Top = 9
      Width = 60
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
    object eBeginDate: TsDateEdit
      Left = 429
      Top = 39
      Width = 86
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 4
      Text = '  .  .    '
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
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
      CheckOnExit = True
      DialogTitle = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
    end
    object eEndDate: TsDateEdit
      Left = 641
      Top = 39
      Width = 86
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 5
      Text = '  .  .    '
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
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
    end
    object CLB_Accounts: TsCheckListBox
      Left = 76
      Top = 2
      Width = 242
      Height = 85
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
  object grData: TCRDBGrid
    Left = 0
    Top = 91
    Width = 764
    Height = 358
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'LOGIN'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1051'/'#1089
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_FEDERAL'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONTRACT_DATE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_IS_ACTIVE'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOP_STATUS_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_CHECK_DATE_TIME'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1103
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1072#1088#1080#1092
        Width = 193
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 48
    Top = 128
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
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
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login, COMPANY_NAME  FROM ACCOUNTS '
      'ORDER BY 2 ASC')
    Left = 152
    Top = 72
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'select *'
      'from table(GET_PHONE_INACTIVE_TAB(:DATE_BEGIN, :DATE_END)) v')
    FetchRows = 500
    Left = 40
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATE_BEGIN'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_END'
      end>
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 88
    Top = 144
  end
  object qAllTables: TOraQuery
    SQL.Strings = (
      'SELECT * FROM all_tables WHERE table_name = :CALL')
    Left = 160
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CALL'
      end>
  end
  object qUserCheckAllow: TOraQuery
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
