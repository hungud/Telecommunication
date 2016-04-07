inherited ReportStartPaymentForm: TReportStartPaymentForm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1086#1089#1090#1091#1087#1080#1074#1096#1080#1084' '#1089#1090#1072#1088#1090#1086#1074#1099#1084' '#1087#1083#1072#1090#1077#1078#1072#1084
  ClientHeight = 529
  ClientWidth = 1128
  Position = poScreenCenter
  ExplicitWidth = 1144
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 1128
    Height = 105
    ExplicitWidth = 1128
    ExplicitHeight = 105
    object lAccount: TLabel [0]
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
    object Label1: TLabel [1]
      Left = 391
      Top = 61
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
    object Label2: TLabel [2]
      Left = 614
      Top = 61
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
    inherited btRefresh: TBitBtn
      Left = 521
      Top = 7
      ExplicitLeft = 521
      ExplicitTop = 7
    end
    inherited btLoadInExcel: TBitBtn
      Left = 368
      Top = 7
      ExplicitLeft = 368
      ExplicitTop = 7
    end
    object CLB_Accounts: TsCheckListBox [5]
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
      TabOrder = 2
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
    object eBeginDate: TsDateEdit [6]
      Left = 493
      Top = 58
      Width = 86
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
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
    object eEndDate: TsDateEdit [7]
      Left = 753
      Top = 58
      Width = 86
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
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
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 639
      Top = 7
      TabOrder = 5
      ExplicitLeft = 639
      ExplicitTop = 7
    end
  end
  inherited pGrid: TPanel
    Top = 105
    Width = 1128
    Height = 424
    ExplicitTop = 105
    ExplicitWidth = 1128
    ExplicitHeight = 424
    inherited gReport: TCRDBGrid
      Width = 1126
      Height = 422
      Columns = <
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPANY_NAME'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'START_BALANCE'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_CANCEL_DATE'
          Width = 136
          Visible = True
        end>
    end
    object grData: TCRDBGrid
      Left = 1
      Top = 1
      Width = 1126
      Height = 422
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
          Title.Alignment = taCenter
          Title.Caption = #1051#1086#1075#1080#1085
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPANY_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1086#1084#1087#1072#1085#1080#1080
          Width = 181
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'START_BALANCE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1073#1072#1083#1072#1085#1089
          Width = 134
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAYMENT_SUM'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1072
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Width = 119
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_CANCEL_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Width = 169
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAYMENT_DATE_TIME'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
          Width = 93
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '     FROM v_RECEIVED_PAYMENTS_type_141'
      '--where  account_id=:acc_id'
      
        '--and (PAYMENT_DATE_TIME>=:DATE_BEGIN  and PAYMENT_DATE_TIME<=:D' +
        'ATE_END)')
    Left = 248
    Top = 232
    object qReportACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qReportLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 120
    end
    object qReportCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportPAYMENT_SUM: TFloatField
      FieldName = 'PAYMENT_SUM'
      Required = True
    end
    object qReportPAYMENT_DATE_TIME: TDateTimeField
      FieldName = 'PAYMENT_DATE_TIME'
      Required = True
    end
    object qReportCONTRACT_DATE: TDateTimeField
      FieldName = 'CONTRACT_DATE'
    end
    object qReportSTART_BALANCE: TFloatField
      FieldName = 'START_BALANCE'
      Required = True
    end
    object qReportCONTRACT_CANCEL_DATE: TDateTimeField
      FieldName = 'CONTRACT_CANCEL_DATE'
    end
  end
  inherited dsReport: TDataSource
    Left = 376
    Top = 144
  end
  inherited aList: TActionList
    Left = 472
    Top = 144
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login,ACCOUNT_NUMBER, COMPANY_NAME  FROM ACCOU' +
        'NTS '
      'ORDER BY 2 ASC')
    Left = 504
    Top = 224
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
    Left = 808
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'user_name'
      end>
  end
end
