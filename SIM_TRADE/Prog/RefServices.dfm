inherited RefServicesForm: TRefServicesForm
  Caption = #1059#1089#1083#1091#1075#1080' '#1074#1099#1073#1086#1088#1072' '#1085#1086#1084#1077#1088#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'SERVICE_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
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
          FieldName = 'PRICE'
          Title.Caption = #1062#1077#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = 'SERVICE_ID'
    SQLInsert.Strings = (
      'INSERT INTO SERVICES'
      '  (SERVICE_ID, SERVICE_NAME, PRICE)'
      'VALUES'
      '  (:SERVICE_ID, :SERVICE_NAME, :PRICE)'
      'RETURNING'
      '  SERVICE_ID, SERVICE_NAME, PRICE'
      'INTO'
      '  :SERVICE_ID, :SERVICE_NAME, :PRICE')
    SQLDelete.Strings = (
      'DELETE FROM SERVICES'
      'WHERE'
      '  SERVICE_ID = :Old_SERVICE_ID')
    SQLUpdate.Strings = (
      'UPDATE SERVICES'
      'SET'
      
        '  SERVICE_ID = :SERVICE_ID, SERVICE_NAME = :SERVICE_NAME, PRICE ' +
        '= :PRICE'
      'WHERE'
      '  SERVICE_ID = :Old_SERVICE_ID'
      'RETURNING'
      '  SERVICE_ID, SERVICE_NAME, PRICE'
      'INTO'
      '  :SERVICE_ID, :SERVICE_NAME, :PRICE')
    SQLRefresh.Strings = (
      'SELECT SERVICE_ID, SERVICE_NAME, PRICE FROM SERVICES'
      'WHERE'
      '  SERVICE_ID = :SERVICE_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM SERVICES')
    Active = True
    IndexFieldNames = 'SERVICE_NAME'
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_SERVICE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_SERVICE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_SERVICE_ID:0'
  end
end
