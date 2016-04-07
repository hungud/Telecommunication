inherited RefUserNamesForm: TRefUserNamesForm
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1089#1080#1089#1090#1077#1084#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited Panel2: TPanel
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    inherited CRDBGrid1: TCRDBGrid
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Columns = <
        item
          Expanded = False
          FieldName = 'USER_FIO'
          Title.Caption = #1060#1048#1054' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 147
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_NAME'
          Title.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' Oracle'
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
          FieldName = 'PASSWORD'
          Title.Caption = #1055#1072#1088#1086#1083#1100
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
          FieldName = 'RIGHT_NAME'
          Title.Caption = #1055#1088#1072#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
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
          FieldName = 'FILIAL_NAME'
          Title.Caption = #1060#1080#1083#1080#1072#1083
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
          FieldName = 'CHECK_ALLOW_NAME'
          Title.Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1076#1086#1089#1090#1091#1087
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENCRYPT_PWD_STR'
          ReadOnly = True
          Title.Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1087#1072#1088#1086#1083#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'USER_NAMES'
    KeyFields = 'USER_NAME_ID'
    KeySequence = 'S_NEW_USER_NAME_ID'
    SQLInsert.Strings = (
      'begin'
      
        '  USER_NAMES_INSERT(:USER_NAME_ID, :USER_FIO, :USER_NAME, :PASSW' +
        'ORD, :FILIAL_ID, :RIGHTS_TYPE, :CHECK_ALLOW_ACCOUNT, :ENCRYPT_PW' +
        'D);'
      'end;')
    SQLDelete.Strings = (
      'begin'
      '  USER_NAMES_DELETE(:USER_NAME_ID);'
      'end;')
    SQLUpdate.Strings = (
      'begin'
      
        '  USER_NAMES_UPDATE(:OLD_USER_NAME_ID, :USER_NAME_ID, :USER_FIO,' +
        ' :USER_NAME, :PASSWORD, :FILIAL_ID, :RIGHTS_TYPE, :CHECK_ALLOW_A' +
        'CCOUNT, :ENCRYPT_PWD);'
      'end;')
    SQLLock.Strings = (
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT USER_NAME_ID, USER_FIO, USER_NAME, LPAD('#39' '#39', 30) PASSWORD' +
        ', FILIAL_ID, RIGHTS_TYPE, CHECK_ALLOW_ACCOUNT, ENCRYPT_PWD FROM ' +
        'USER_NAMES'
      'WHERE'
      '  USER_NAME_ID = :USER_NAME_ID')
    SQL.Strings = (
      'SELECT UN.*, LPAD('#39' '#39', 30) PASSWORD,'
      '       CASE WHEN encrypt_pwd = 1'
      '        THEN '#39#1044#1072#39
      '        ELSE null'
      '        END encrypt_pwd_str'
      'FROM USER_NAMES UN')
    IndexFieldNames = 'USER_FIO'
    Top = 57
    object qMainUSER_NAME_ID: TFloatField
      FieldName = 'USER_NAME_ID'
    end
    object qMainUSER_FIO: TStringField
      FieldName = 'USER_FIO'
      Required = True
      Size = 400
    end
    object qMainUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Size = 120
    end
    object qMainFILIAL_ID: TFloatField
      FieldName = 'FILIAL_ID'
    end
    object qMainRIGHTS_TYPE: TFloatField
      FieldName = 'RIGHTS_TYPE'
    end
    object qMainFILIAL_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'FILIAL_NAME'
      LookupDataSet = qFilials
      LookupKeyFields = 'FILIAL_ID'
      LookupResultField = 'FILIAL_NAME'
      KeyFields = 'FILIAL_ID'
      Size = 100
      Lookup = True
    end
    object qMainRIGHT_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'RIGHT_NAME'
      LookupDataSet = qRightNames
      LookupKeyFields = 'RIGHT_ID'
      LookupResultField = 'RIGHT_NAME'
      KeyFields = 'RIGHTS_TYPE'
      Size = 30
      Lookup = True
    end
    object qMainPASSWORD: TStringField
      FieldName = 'PASSWORD'
      OnGetText = qMainPASSWORDGetText
      OnSetText = qMainPASSWORDSetText
      Size = 30
    end
    object qMainCHECK_ALLOW_ACCOUNT: TIntegerField
      FieldName = 'CHECK_ALLOW_ACCOUNT'
    end
    object qMainCHECK_ALLOW_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'CHECK_ALLOW_NAME'
      LookupDataSet = qCheckAllow
      LookupKeyFields = 'CHECK_ALLOW_ID'
      LookupResultField = 'CHECK_ALLOW_NAME'
      KeyFields = 'CHECK_ALLOW_ACCOUNT'
      Lookup = True
    end
    object qMainENCRYPT_PWD: TIntegerField
      FieldName = 'ENCRYPT_PWD'
    end
    object qMainENCRYPT_PWD_STR: TStringField
      FieldName = 'ENCRYPT_PWD_STR'
      FixedChar = True
      Size = 4
    end
  end
  inherited dsMain: TDataSource
    Left = 376
    Top = 97
  end
  object qFilials: TOraTable [6]
    TableName = 'FILIALS'
    OrderFields = 'FILIAL_NAME'
    KeyFields = 'FILIAL_ID'
    Left = 168
    Top = 129
  end
  object qRightNames: TOraQuery [7]
    SQL.Strings = (
      'SELECT 1 RIGHT_ID, '#39#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#39' RIGHT_NAME FROM DUAL'
      'UNION ALL'
      'SELECT NULL , '#39#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#39' FROM DUAL'
      'UNION ALL'
      'SELECT 2, '#39#1055#1088#1086#1089#1084#1086#1090#1088#39' FROM DUAL'
      'UNION ALL'
      'SELECT 3, '#39#1058#1086#1083#1100#1082#1086' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092'. '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091#39' FROM DUAL')
    Left = 168
    Top = 177
  end
  object OraQuery1: TOraQuery [8]
    SQL.Strings = (
      'begin'
      
        '  USER_NAMES_UPDATE(:OLD_USER_NAME_ID, :USER_NAME_ID, :USER_FIO,' +
        ' :USER_NAME, :PASSWORD, :FILIAL_ID, :RIGHTS_TYPE, :CHECK_ALLOW_A' +
        'CCOUNT);'
      'end;')
    Left = 48
    Top = 89
    ParamData = <
      item
        Name = 'OLD_USER_NAME_ID'
        ParamType = ptInput
        Value = Null
        ExtDataType = 107
      end
      item
        Name = 'USER_NAME_ID'
        ParamType = ptInput
        Value = Null
        ExtDataType = 107
      end
      item
        DataType = ftString
        Name = 'USER_FIO'
        ParamType = ptInput
        Size = 100
        Value = 'SDF123'
      end
      item
        DataType = ftString
        Name = 'USER_NAME'
        ParamType = ptInput
        Size = 30
        Value = 'NAME'
      end
      item
        DataType = ftString
        Name = 'PASSWORD'
        ParamType = ptInput
        Size = 30
      end
      item
        Name = 'FILIAL_ID'
        ParamType = ptInput
        Value = Null
        ExtDataType = 107
      end
      item
        Name = 'RIGHTS_TYPE'
        ParamType = ptInput
        Value = Null
        ExtDataType = 107
      end
      item
        DataType = ftUnknown
        Name = 'CHECK_ALLOW_ACCOUNT'
      end>
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object qCheckAllow: TOraQuery
    SQL.Strings = (
      'SELECT 1 Check_allow_id, '#39#1044#1072#39' Check_allow_name FROM DUAL'
      'UNION ALL'
      'SELECT NULL , '#39#1053#1077#1090#39' FROM DUAL')
    Left = 568
    Top = 64
  end
end
