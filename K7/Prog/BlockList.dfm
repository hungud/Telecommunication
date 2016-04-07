object BlockListFrm: TBlockListFrm
  Left = 146
  Top = 188
  Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 442
  ClientWidth = 901
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 901
    Height = 28
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
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbAccountsChange
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
      TabOrder = 4
      OnClick = cbSearchClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 28
    Width = 901
    Height = 414
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = tsPhoneForBlock
    Align = alClient
    TabOrder = 1
    object tsAllPhoneBlock: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1089#1077' '#1085#1086#1084#1077#1088#1072
      object BlockListGrd: TCRDBGrid
        Left = 0
        Top = 0
        Width = 893
        Height = 386
        Align = alClient
        DataSource = dsBlockList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ABONENT_FIO'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1060'.'#1048'.'#1054'.'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BALLANCE'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1041#1072#1083#1072#1085#1089
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'BLOCK_DATE_TIME'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
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
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1103
            Width = 200
            Visible = True
          end>
      end
    end
    object tsBlockPhoneNoContract: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1086#1084#1077#1088#1072' '#1073#1077#1079' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
      ImageIndex = 1
      OnShow = tsBlockPhoneNoContractShow
      object PhoneNoContGrid: TCRDBGrid
        Left = 0
        Top = 0
        Width = 893
        Height = 386
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsPhoneNoContract
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
      end
    end
    object tsPhoneForBlock: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1095#1077#1088#1077#1076#1100' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      ImageIndex = 2
      OnShow = tsPhoneForBlockShow
      object PhoneForBlockGrid: TCRDBGrid
        Left = 0
        Top = 0
        Width = 893
        Height = 386
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsPhonesForBlock
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
            FieldName = 'BALANCE_BLOCK'
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
            FieldName = 'IS_CREDIT_CONTRACT'
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
    end
  end
  object dsBlockList: TDataSource
    DataSet = qBlockList
    Left = 96
    Top = 160
  end
  object qBlockList: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID,'
      '       AUTO_BLOCKED_PHONE.PHONE_NUMBER, '
      '       AUTO_BLOCKED_PHONE.ABONENT_FIO, '
      '       AUTO_BLOCKED_PHONE.BALLANCE, '
      '       AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME, '
      
        '       DECODE(AUTO_BLOCKED_PHONE.MANUAL_BLOCK, 0, '#39#1040#1074#1090#1086#39', '#39#1056#1091#1095#1085#1072 +
        #1103#39') TYPE_BLOCK, '
      '       NVL('
      '         (SELECT USER_FIO '
      '            FROM USER_NAMES '
      
        '            WHERE USER_NAMES.USER_NAME=AUTO_BLOCKED_PHONE.USER_N' +
        'AME'
      '              AND ROWNUM <= 1), '
      '         AUTO_BLOCKED_PHONE.USER_NAME) USER_NAME, '
      '       case when (select count(*) from  fraud_blocked_phone fb'
      'where fb.phone_number=AUTO_BLOCKED_PHONE.PHONE_NUMBER'
      'and fb.status=1'
      
        'and fb.date_block between AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME and' +
        ' nvl((select min(abp.block_date_time) from AUTO_BLOCKED_PHONE ab' +
        'p'
      'where abp.phone_number=AUTO_BLOCKED_PHONE.PHONE_NUMBER'
      
        'and abp.block_date_time>AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME),sysd' +
        'ate))=0 then AUTO_BLOCKED_PHONE.NOTE else '#39#1041#1083#1086#1082#1080#1088#1086#1074#1072#1085' '#1087#1086' '#1087#1086#1076#1086#1079#1088#1077 +
        #1085#1080#1102' '#1074' '#1084#1086#1096#1077#1085#1085#1080#1095#1077#1089#1090#1074#1077#39' end NOTE'
      '--AUTO_BLOCKED_PHONE.NOTE'
      '  FROM AUTO_BLOCKED_PHONE,'
      '       DB_LOADER_ACCOUNT_PHONES '
      
        '  WHERE ((:PHONE_NUMBER IS NULL) OR (AUTO_BLOCKED_PHONE.PHONE_NU' +
        'MBER=:PHONE_NUMBER))'
      
        '    AND AUTO_BLOCKED_PHONE.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHONES' +
        '.PHONE_NUMBER(+)'
      
        '    AND TO_NUMBER(TO_CHAR(AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME,'#39'YY' +
        'YYMM'#39'))=DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH(+) '
      
        '    AND ((:ACCOUNT_ID IS NULL)OR(DB_LOADER_ACCOUNT_PHONES.ACCOUN' +
        'T_ID=:ACCOUNT_ID)) '
      '  ORDER BY BLOCK_DATE_TIME DESC')
    FetchRows = 250
    Left = 40
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
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 56
    Top = 72
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
    Top = 72
  end
  object qPhonesForBlock: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select vb.*, a.login'
      '  from v_phone_numbers_for_block vb, accounts a'
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
    object qPhonesForBlockLOGIN: TStringField
      DisplayLabel = #1051'/'#1057
      FieldName = 'LOGIN'
      Size = 120
    end
    object qPhonesForBlockPHONE_NUMBER_FEDERAL: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER_FEDERAL'
      Size = 40
    end
    object qPhonesForBlockBALANCE: TFloatField
      DisplayLabel = #1041#1072#1083#1072#1085#1089
      FieldName = 'BALANCE'
    end
    object qPhonesForBlockBALANCE_BLOCK: TFloatField
      DisplayLabel = #1055#1086#1088#1086#1075
      FieldName = 'BALANCE_BLOCK'
    end
    object qPhonesForBlockDISCONNECT_LIMIT: TFloatField
      DisplayLabel = #1051#1080#1084#1080#1090' '#1086#1090#1082#1083
      FieldName = 'DISCONNECT_LIMIT'
    end
    object qPhonesForBlockIS_CREDIT_CONTRACT: TIntegerField
      DisplayLabel = #1050#1088#1077#1076#1080#1090
      FieldName = 'IS_CREDIT_CONTRACT'
    end
    object qPhonesForBlockFIO: TStringField
      DisplayLabel = #1060'.'#1048'.'#1054'.'
      FieldName = 'FIO'
      Size = 362
    end
  end
  object dsPhonesForBlock: TDataSource
    DataSet = qPhonesForBlock
    Left = 400
    Top = 176
  end
  object dsPhoneNoContract: TDataSource
    DataSet = qPhoneNoContract
    Left = 248
    Top = 336
  end
  object qPhoneNoContract: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT *'
      '  FROM AUTO_BLOCKED_PHONE_NO_CONTRACT'
      '  ORDER BY AUTO_BLOCKED_PHONE_NO_CONTRACT.BLOCK_DATE_TIME DESC')
    Left = 168
    Top = 272
    object qPhoneNoContractACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1051'/'#1057
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qPhoneNoContractPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qPhoneNoContractBLOCK_DATE_TIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'BLOCK_DATE_TIME'
      Required = True
    end
    object qPhoneNoContractMANUAL_BLOCK: TFloatField
      DisplayLabel = #1040#1074#1090#1086
      FieldName = 'MANUAL_BLOCK'
    end
    object qPhoneNoContractUSER_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FieldName = 'USER_NAME'
      Size = 120
    end
    object qPhoneNoContractNOTE: TStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'NOTE'
      Size = 1200
    end
  end
end
