inherited RefRegionsForm: TRefRegionsForm
  Left = 223
  Top = 135
  Caption = #1056#1077#1075#1080#1086#1085#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'ORDER_NUMBER'
          Title.Caption = #8470
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REGION_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 240
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COUNTRY_NAME'
          Title.Caption = #1057#1090#1088#1072#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 74
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
          Width = 90
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'REGIONS'
    KeyFields = 'REGION_ID'
    SQLInsert.Strings = (
      'INSERT INTO REGIONS'
      '  (REGION_ID, REGION_NAME, ORDER_NUMBER, IS_DEFAULT, COUNTRY_ID)'
      'VALUES'
      
        '  (:REGION_ID, :REGION_NAME, :ORDER_NUMBER, :IS_DEFAULT, :COUNTR' +
        'Y_ID)'
      'RETURNING'
      '  REGION_ID, REGION_NAME, ORDER_NUMBER, IS_DEFAULT, COUNTRY_ID'
      'INTO'
      
        '  :REGION_ID, :REGION_NAME, :ORDER_NUMBER, :IS_DEFAULT, :COUNTRY' +
        '_ID')
    SQLDelete.Strings = (
      'DELETE FROM REGIONS'
      'WHERE'
      '  REGION_ID = :Old_REGION_ID')
    SQLUpdate.Strings = (
      'UPDATE REGIONS'
      'SET'
      
        '  REGION_ID = :REGION_ID, REGION_NAME = :REGION_NAME, ORDER_NUMB' +
        'ER = :ORDER_NUMBER, IS_DEFAULT = :IS_DEFAULT, COUNTRY_ID = :COUN' +
        'TRY_ID'
      'WHERE'
      '  REGION_ID = :Old_REGION_ID'
      'RETURNING'
      '  REGION_ID, REGION_NAME, ORDER_NUMBER, IS_DEFAULT, COUNTRY_ID'
      'INTO'
      
        '  :REGION_ID, :REGION_NAME, :ORDER_NUMBER, :IS_DEFAULT, :COUNTRY' +
        '_ID')
    SQLRefresh.Strings = (
      
        'SELECT REGION_ID, REGION_NAME, ORDER_NUMBER, IS_DEFAULT, COUNTRY' +
        '_ID FROM REGIONS'
      'WHERE'
      '  REGION_ID = :REGION_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM REGIONS')
    IndexFieldNames = 'ORDER_NUMBER'
    AfterInsert = qMainAfterInsert
    object qMainREGION_ID: TFloatField
      FieldName = 'REGION_ID'
      Required = True
    end
    object qMainREGION_NAME: TStringField
      FieldName = 'REGION_NAME'
      Size = 400
    end
    object qMainORDER_NUMBER: TFloatField
      FieldName = 'ORDER_NUMBER'
    end
    object qMainIS_DEFAULT: TIntegerField
      FieldName = 'IS_DEFAULT'
    end
    object qMainCOUNTRY_ID: TFloatField
      FieldName = 'COUNTRY_ID'
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
    object qMainCOUNTRY_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'COUNTRY_NAME'
      LookupDataSet = qCountries
      LookupKeyFields = 'COUNTRY_ID'
      LookupResultField = 'COUNTRY_NAME'
      KeyFields = 'COUNTRY_ID'
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
  object qIsDefault: TOraQuery
    SQL.Strings = (
      'SELECT 0 IS_DEFAULT, '#39#39' IS_DEFAULT_NAME  FROM DUAL'
      'UNION ALL'
      'SELECT 1 IS_DEFAULT, '#39#1044#1072#39' IS_DEFAULT_NAME  FROM DUAL')
    Active = True
    Left = 176
    Top = 121
  end
  object qCountries: TOraQuery
    SQL.Strings = (
      'SELECT * '
      'FROM COUNTRIES'
      'ORDER BY NVL(IS_DEFAULT, 0) DESC, COUNTRY_NAME')
    Active = True
    Left = 176
    Top = 177
  end
end
