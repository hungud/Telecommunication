object ReportContractHandBlockForm: TReportContractHandBlockForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1075#1086#1074#1086#1088#1072' '#1089' '#1088#1091#1095#1085#1086#1081' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1086#1081
  ClientHeight = 433
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 875
    Height = 81
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
    object btLoadInExcel: TBitBtn
      Left = 305
      Top = 1
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 439
      Top = 1
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 545
      Top = 1
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 662
      Top = 7
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
    object cbHandBlock: TCheckBox
      Left = 728
      Top = 7
      Width = 137
      Height = 17
      Caption = #1056#1091#1095#1085#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object CLB_Accounts: TsCheckListBox
      Left = 70
      Top = 3
      Width = 229
      Height = 75
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
      TabOrder = 5
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
    Top = 81
    Width = 875
    Height = 352
    OnGetCellParams = grDataGetCellParams
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
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
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
        FieldName = 'CONTRACT_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HAND_BLOCK'
        Title.Alignment = taCenter
        Title.Caption = #1056#1091#1095#1085#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_CANCEL_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
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
        FieldName = 'CURRENT_BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
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
        FieldName = 'COMMENTS'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIO'
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 109
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
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login, COMPANY_NAME  FROM ACCOUNTS '
      'ORDER BY 2 ASC')
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
      'SELECT v.PHONE_NUMBER,'
      ' v.CONTRACT_NUM,'
      ' v.CONTRACT_DATE,'
      ' CASE '
      '   WHEN v.HAND_BLOCK=1 THEN '#39#1041#1083#1086#1082'.'#39
      '   ELSE '#39#39
      ' END HAND_BLOCK,'
      ' v.CONTRACT_CANCEL_DATE,'
      ' v.CURRENT_BALANCE,'
      ' CASE '
      '   WHEN v.HAND_BLOCK = 1 THEN'
      '     v.USER_LAST_UPDATED||'
      '     (SELECT '#39' ('#39'||USER_FIO||'#39')'#39' '
      '      FROM USER_NAMES '
      '      WHERE v.USER_LAST_UPDATED = UPPER(USER_NAME))'
      '   ELSE NULL'
      ' END USER_NAME,'
      ' COMMENTS,'
      ' FIO'
      'FROM v_contracts_hand_block v'
      'WHERE ((:HAND_BLOCK IS NULL)OR(v.HAND_BLOCK = :HAND_BLOCK))')
    Left = 168
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'HAND_BLOCK'
      end>
  end
end
