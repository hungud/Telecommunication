object UnBlockListFrm: TUnBlockListFrm
  Left = 225
  Top = 232
  Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 441
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UnBlockListGrd: TCRDBGrid
    Left = 0
    Top = 28
    Width = 915
    Height = 413
    Align = alClient
    DataSource = dsUnblockList
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABONENT_FIO'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1060'.'#1048'.'#1054'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALLANCE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'UNBLOCK_DATE_TIME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TYPE_BLOCK'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_NAME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 915
    Height = 28
    Align = alTop
    TabOrder = 1
    object lAccount: TLabel
      Left = 8
      Top = 8
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
      Left = 180
      Top = 0
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 331
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 436
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 553
      Top = 6
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      OnChange = cbAccountsChange
    end
    object cbPhoneForUnBlock: TCheckBox
      Left = 618
      Top = 6
      Width = 124
      Height = 17
      Caption = #1054#1095#1077#1088#1077#1076#1100' '#1088#1072#1079#1073#1083'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = cbPhoneForUnBlockClick
    end
  end
  object PhoneForUnBlockGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 915
    Height = 413
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsPhonesForUnBlock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_FEDERAL'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCONNECT_LIMIT'
        Title.Alignment = taCenter
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIO'
        Title.Alignment = taCenter
        Width = 400
        Visible = True
      end>
  end
  object qUnblockList: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID,'
      '       AUTO_UNBLOCKED_PHONE.PHONE_NUMBER, '
      '       AUTO_UNBLOCKED_PHONE.ABONENT_FIO, '
      '       AUTO_UNBLOCKED_PHONE.BALLANCE, '
      '       AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME, '
      
        '       DECODE(AUTO_UNBLOCKED_PHONE.MANUAL_BLOCK, 0, '#39#1040#1074#1090#1086#39', '#39#1056#1091#1095 +
        #1085#1072#1103#39') TYPE_BLOCK, '
      '       NVL('
      '         (SELECT USER_FIO '
      '            FROM USER_NAMES '
      
        '            WHERE USER_NAMES.USER_NAME=AUTO_UNBLOCKED_PHONE.USER' +
        '_NAME'
      '              AND ROWNUM <= 1), '
      '         AUTO_UNBLOCKED_PHONE.USER_NAME) USER_NAME, '
      '       AUTO_UNBLOCKED_PHONE.NOTE'
      '  FROM AUTO_UNBLOCKED_PHONE,'
      '       DB_LOADER_ACCOUNT_PHONES '
      
        '  WHERE ((:PHONE_NUMBER IS NULL) OR (AUTO_UNBLOCKED_PHONE.PHONE_' +
        'NUMBER=:PHONE_NUMBER))'
      
        '    AND AUTO_UNBLOCKED_PHONE.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHON' +
        'ES.PHONE_NUMBER(+)'
      
        '    AND TO_NUMBER(TO_CHAR(AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME' +
        ','#39'YYYYMM'#39'))=DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH(+) '
      
        '    AND ((:ACCOUNT_ID IS NULL)OR(DB_LOADER_ACCOUNT_PHONES.ACCOUN' +
        'T_ID=:ACCOUNT_ID)) '
      '  ORDER BY UNBLOCK_DATE_TIME DESC')
    FetchRows = 250
    Left = 64
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object dsUnblockList: TDataSource
    DataSet = qUnblockList
    Left = 96
    Top = 136
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 64
    Top = 80
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
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN '
      'FROM ACCOUNTS '
      'ORDER BY LOGIN ASC')
    Left = 152
    Top = 80
  end
  object dsPhonesForUnBlock: TDataSource
    DataSet = qPhonesForUnBlock
    Left = 400
    Top = 176
  end
  object qPhonesForUnBlock: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select vb.*, a.login'
      '  from v_phone_numbers_for_unlock vb, accounts a'
      '  where vb.account_id=a.account_id(+) AND '
      '((:ACCOUNT_ID IS NULL)OR(vb.account_id=:ACCOUNT_ID)) '
      '  order by a.login, vb.BALANCE asc')
    FetchRows = 500
    Left = 352
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qPhonesForUnBlockLOGIN: TStringField
      DisplayLabel = #1051'/'#1057
      FieldName = 'LOGIN'
      Size = 120
    end
    object qPhonesForUnBlockPHONE_NUMBER_FEDERAL: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER_FEDERAL'
      Size = 40
    end
    object qPhonesForUnBlockBALANCE: TFloatField
      DisplayLabel = #1041#1072#1083#1072#1085#1089
      FieldName = 'BALANCE'
    end
    object qPhonesForUnBlockDISCONNECT_LIMIT: TFloatField
      DisplayLabel = #1051#1080#1084#1080#1090' '#1086#1090#1082#1083
      FieldName = 'DISCONNECT_LIMIT'
    end
    object qPhonesForUnBlockFIO: TStringField
      DisplayLabel = #1060'.'#1048'.'#1054'.'
      FieldName = 'FIO'
      Size = 362
    end
  end
end
