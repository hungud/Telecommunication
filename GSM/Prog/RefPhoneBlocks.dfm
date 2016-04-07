inherited RefPhoneBlocksForm: TRefPhoneBlocksForm
  Caption = #1041#1083#1086#1082#1080' '#1090#1077#1083#1077#1092#1086#1085#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_BEGIN'
          Title.Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_END'
          Title.Caption = #1050#1086#1085#1077#1095#1085#1099#1081' '#1085#1086#1084#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPERATOR_NAME'
          Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = 'PHONE_BLOCK_ID'
    SQLInsert.Strings = (
      'INSERT INTO PHONE_BLOCKS'
      
        '  (PHONE_BLOCK_ID, OPERATOR_ID, PHONE_NUMBER_BEGIN, PHONE_NUMBER' +
        '_END)'
      'VALUES'
      
        '  (:PHONE_BLOCK_ID, :OPERATOR_ID, :PHONE_NUMBER_BEGIN, :PHONE_NU' +
        'MBER_END)'
      'RETURNING'
      
        '  PHONE_BLOCK_ID, OPERATOR_ID, PHONE_NUMBER_BEGIN, PHONE_NUMBER_' +
        'END'
      'INTO'
      
        '  :PHONE_BLOCK_ID, :OPERATOR_ID, :PHONE_NUMBER_BEGIN, :PHONE_NUM' +
        'BER_END')
    SQLDelete.Strings = (
      'DELETE FROM PHONE_BLOCKS'
      'WHERE'
      '  PHONE_BLOCK_ID = :Old_PHONE_BLOCK_ID')
    SQLUpdate.Strings = (
      'UPDATE PHONE_BLOCKS'
      'SET'
      
        '  PHONE_BLOCK_ID = :PHONE_BLOCK_ID, OPERATOR_ID = :OPERATOR_ID, ' +
        'PHONE_NUMBER_BEGIN = :PHONE_NUMBER_BEGIN, PHONE_NUMBER_END = :PH' +
        'ONE_NUMBER_END'
      'WHERE'
      '  PHONE_BLOCK_ID = :Old_PHONE_BLOCK_ID'
      'RETURNING'
      
        '  PHONE_BLOCK_ID, OPERATOR_ID, PHONE_NUMBER_BEGIN, PHONE_NUMBER_' +
        'END'
      'INTO'
      
        '  :PHONE_BLOCK_ID, :OPERATOR_ID, :PHONE_NUMBER_BEGIN, :PHONE_NUM' +
        'BER_END')
    SQLRefresh.Strings = (
      
        'SELECT PHONE_BLOCK_ID, OPERATOR_ID, PHONE_NUMBER_BEGIN, PHONE_NU' +
        'MBER_END FROM PHONE_BLOCKS'
      'WHERE'
      '  PHONE_BLOCK_ID = :PHONE_BLOCK_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM PHONE_BLOCKS')
    IndexFieldNames = 'PHONE_NUMBER_BEGIN'
    object qMainPHONE_BLOCK_ID: TFloatField
      FieldName = 'PHONE_BLOCK_ID'
      Required = True
    end
    object qMainOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
    end
    object qMainPHONE_NUMBER_BEGIN: TStringField
      FieldName = 'PHONE_NUMBER_BEGIN'
      Size = 80
    end
    object qMainPHONE_NUMBER_END: TStringField
      FieldName = 'PHONE_NUMBER_END'
      Size = 80
    end
    object qMainOPERATOR_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPERATOR_NAME'
      LookupDataSet = qOperators
      LookupKeyFields = 'OPERATOR_ID'
      LookupResultField = 'OPERATOR_NAME'
      KeyFields = 'OPERATOR_ID'
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_REGION_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_REGION_ID;'
      'end;')
    CommandStoredProcName = 'NEW_REGION_ID:0'
  end
  object qOperators: TOraQuery
    SQL.Strings = (
      'SELECT * '
      'FROM OPERATORS')
    Left = 192
    Top = 137
  end
end
