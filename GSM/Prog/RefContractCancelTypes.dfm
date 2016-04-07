inherited RefContractCancelTypesForm: TRefContractCancelTypesForm
  Caption = #1055#1088#1080#1095#1080#1085#1099' '#1088#1072#1089#1090#1086#1088#1078#1077#1085#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'CONTRACT_CANCEL_TYPE_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 2404
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = 'CONTRACT_CANCEL_TYPE_ID'
    SQLInsert.Strings = (
      'INSERT INTO CONTRACT_CANCEL_TYPES'
      '  (CONTRACT_CANCEL_TYPE_ID, CONTRACT_CANCEL_TYPE_NAME)'
      'VALUES'
      '  (:CONTRACT_CANCEL_TYPE_ID, :CONTRACT_CANCEL_TYPE_NAME)'
      'RETURNING'
      '  CONTRACT_CANCEL_TYPE_ID, CONTRACT_CANCEL_TYPE_NAME'
      'INTO'
      '  :CONTRACT_CANCEL_TYPE_ID, :CONTRACT_CANCEL_TYPE_NAME')
    SQLDelete.Strings = (
      'DELETE FROM CONTRACT_CANCEL_TYPES'
      'WHERE'
      '  CONTRACT_CANCEL_TYPE_ID = :Old_CONTRACT_CANCEL_TYPE_ID')
    SQLUpdate.Strings = (
      'UPDATE CONTRACT_CANCEL_TYPES'
      'SET'
      
        '  CONTRACT_CANCEL_TYPE_ID = :CONTRACT_CANCEL_TYPE_ID, CONTRACT_C' +
        'ANCEL_TYPE_NAME = :CONTRACT_CANCEL_TYPE_NAME'
      'WHERE'
      '  CONTRACT_CANCEL_TYPE_ID = :Old_CONTRACT_CANCEL_TYPE_ID'
      'RETURNING'
      '  CONTRACT_CANCEL_TYPE_ID, CONTRACT_CANCEL_TYPE_NAME'
      'INTO'
      '  :CONTRACT_CANCEL_TYPE_ID, :CONTRACT_CANCEL_TYPE_NAME')
    SQLRefresh.Strings = (
      
        'SELECT CONTRACT_CANCEL_TYPE_ID, CONTRACT_CANCEL_TYPE_NAME FROM C' +
        'ONTRACT_CANCEL_TYPES'
      'WHERE'
      '  CONTRACT_CANCEL_TYPE_ID = :CONTRACT_CANCEL_TYPE_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM CONTRACT_CANCEL_TYPES')
    Active = True
    IndexFieldNames = 'CONTRACT_CANCEL_TYPE_NAME'
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_CONTRACT_CANCEL_TYPE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_CONTRACT_CANCEL_TYPE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_CONTRACT_CANCEL_TYPE_ID:0'
  end
end
