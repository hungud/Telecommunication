inherited RefCountriesForm: TRefCountriesForm
  Caption = #1057#1090#1088#1072#1085#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'COUNTRY_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_DEFAULT_NAME'
          Title.Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'COUNTRIES'
    KeyFields = 'COUNTRY_ID'
    SQLInsert.Strings = (
      'INSERT INTO COUNTRIES'
      '  (COUNTRY_ID, COUNTRY_NAME, IS_DEFAULT)'
      'VALUES'
      '  (:COUNTRY_ID, :COUNTRY_NAME, :IS_DEFAULT)'
      'RETURNING'
      '  COUNTRY_ID, COUNTRY_NAME, IS_DEFAULT'
      'INTO'
      '  :COUNTRY_ID, :COUNTRY_NAME, :IS_DEFAULT')
    SQLDelete.Strings = (
      'DELETE FROM COUNTRIES'
      'WHERE'
      '  COUNTRY_ID = :Old_COUNTRY_ID')
    SQLUpdate.Strings = (
      'UPDATE COUNTRIES'
      'SET'
      
        '  COUNTRY_ID = :COUNTRY_ID, COUNTRY_NAME = :COUNTRY_NAME, IS_DEF' +
        'AULT = :IS_DEFAULT'
      'WHERE'
      '  COUNTRY_ID = :Old_COUNTRY_ID'
      'RETURNING'
      '  COUNTRY_ID, COUNTRY_NAME, IS_DEFAULT'
      'INTO'
      '  :COUNTRY_ID, :COUNTRY_NAME, :IS_DEFAULT')
    SQLRefresh.Strings = (
      'SELECT COUNTRY_ID, COUNTRY_NAME, IS_DEFAULT FROM COUNTRIES'
      'WHERE'
      '  COUNTRY_ID = :COUNTRY_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM COUNTRIES')
    IndexFieldNames = 'COUNTRY_NAME'
    object qMainIS_DEFAULT: TIntegerField
      DisplayWidth = 1
      FieldName = 'IS_DEFAULT'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object qMainCOUNTRY_NAME: TStringField
      FieldName = 'COUNTRY_NAME'
      Size = 400
    end
    object qMainCOUNTRY_ID: TFloatField
      FieldName = 'COUNTRY_ID'
      Required = True
    end
    object qMainIS_DEFAULT_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'IS_DEFAULT_NAME'
      LookupDataSet = qIsDefault
      LookupKeyFields = 'IS_DEFAULT'
      LookupResultField = 'IS_DEFAULT_NAME'
      KeyFields = 'IS_DEFAULT'
      Size = 2
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_COUNTRY_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_COUNTRY_ID;'
      'end;')
    CommandStoredProcName = 'NEW_COUNTRY_ID:0'
  end
  object qIsDefault: TOraQuery
    SQL.Strings = (
      'SELECT 0 IS_DEFAULT, '#39#39' IS_DEFAULT_NAME  FROM DUAL'
      'UNION ALL'
      'SELECT 1 IS_DEFAULT, '#39#1044#1072#39' IS_DEFAULT_NAME  FROM DUAL')
    Left = 176
    Top = 121
  end
end
