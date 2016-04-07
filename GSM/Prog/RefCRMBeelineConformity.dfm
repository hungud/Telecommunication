inherited RefCRMBeelineConformityForm: TRefCRMBeelineConformityForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1103' '#1085#1086#1084#1077#1088#1086#1074' '#1041#1080#1083#1072#1081#1085' '#1085#1086#1084#1077#1088#1072#1084' '#1052#1058#1057'/'#1052#1077#1075#1072#1092#1086#1085
  ExplicitWidth = 720
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_TARIFER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1041#1080#1083#1072#1081#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 117
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_CLIENT'
          Title.Alignment = taCenter
          Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1072#1073#1086#1085#1077#1085#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 153
          Visible = True
        end
        item
          DropDownRows = 2
          Expanded = False
          FieldName = 'TYPE_CRM_BEELINE_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 124
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO CRM_BEELINE_CONFORMITY'
      
        '  (PHONE_NUMBER_TARIFER, PHONE_NUMBER_CLIENT, TYPE_CRM_BEELINE_I' +
        'D)'
      'VALUES'
      
        '  (:PHONE_NUMBER_TARIFER, :PHONE_NUMBER_CLIENT, :TYPE_CRM_BEELIN' +
        'E_ID)'
      'RETURNING'
      
        ' CONFORMITY_ID, PHONE_NUMBER_TARIFER, PHONE_NUMBER_CLIENT, TYPE_' +
        'CRM_BEELINE_ID'
      'INTO'
      
        ' :CONFORMITY_ID, :PHONE_NUMBER_TARIFER, :PHONE_NUMBER_CLIENT, :T' +
        'YPE_CRM_BEELINE_ID')
    SQLDelete.Strings = (
      'DELETE FROM CRM_BEELINE_CONFORMITY'
      'WHERE'
      '  CONFORMITY_ID = :Old_CONFORMITY_ID')
    SQLUpdate.Strings = (
      'UPDATE CRM_BEELINE_CONFORMITY'
      'SET'
      '  PHONE_NUMBER_TARIFER = :PHONE_NUMBER_TARIFER,'
      '  PHONE_NUMBER_CLIENT = :PHONE_NUMBER_CLIENT,'
      '  TYPE_CRM_BEELINE_ID = :TYPE_CRM_BEELINE_ID'
      'WHERE'
      '  CONFORMITY_ID = :Old_CONFORMITY_ID'
      'RETURNING'
      
        ' CONFORMITY_ID, PHONE_NUMBER_TARIFER, PHONE_NUMBER_CLIENT, TYPE_' +
        'CRM_BEELINE_ID'
      'INTO'
      
        ' :CONFORMITY_ID, :PHONE_NUMBER_TARIFER, :PHONE_NUMBER_CLIENT, :T' +
        'YPE_CRM_BEELINE_ID')
    SQLRefresh.Strings = (
      'SELECT'
      '  CONFORMITY_ID,'
      '  PHONE_NUMBER_TARIFER,'
      '  PHONE_NUMBER_CLIENT,'
      '  TYPE_CRM_BEELINE_ID'
      'FROM CRM_BEELINE_CONFORMITY'
      'where CONFORMITY_ID = :OLD_CONFORMITY_ID')
    SQL.Strings = (
      'SELECT'
      '  CONFORMITY_ID,'
      '  PHONE_NUMBER_TARIFER,'
      '  PHONE_NUMBER_CLIENT,'
      '  TYPE_CRM_BEELINE_ID'
      'FROM CRM_BEELINE_CONFORMITY cc')
    RefreshOptions = []
    object qMainPHONE_NUMBER_TARIFER: TStringField
      FieldName = 'PHONE_NUMBER_TARIFER'
      Required = True
      Size = 40
    end
    object qMainPHONE_NUMBER_CLIENT: TStringField
      FieldName = 'PHONE_NUMBER_CLIENT'
      Required = True
      Size = 40
    end
    object qMainCONFORMITY_ID: TFloatField
      FieldName = 'CONFORMITY_ID'
    end
    object qMainTYPE_CRM_BEELINE_ID: TFloatField
      FieldName = 'TYPE_CRM_BEELINE_ID'
      Required = True
    end
    object qMainTYPE_CRM_BEELINE_NAME: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'TYPE_CRM_BEELINE_NAME'
      LookupDataSet = qTYPES_CRM_BEELINE
      LookupKeyFields = 'ID'
      LookupResultField = 'TYPE_NAME'
      KeyFields = 'TYPE_CRM_BEELINE_ID'
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object qTYPES_CRM_BEELINE: TOraQuery
    SQL.Strings = (
      'Select * from TYPES_CRM_BEELINE')
    FetchRows = 2
    Left = 420
    Top = 126
    object qTYPES_CRM_BEELINEID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object qTYPES_CRM_BEELINETYPE_NAME: TStringField
      FieldName = 'TYPE_NAME'
      Required = True
      Size = 200
    end
  end
end
