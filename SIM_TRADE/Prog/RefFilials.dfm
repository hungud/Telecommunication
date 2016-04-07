inherited RefFilialsForm: TRefFilialsForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1092#1080#1083#1080#1072#1083#1086#1074' '#1080' '#1086#1092#1080#1089#1086#1074' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'FILIAL_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 1000
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = 'FILIAL_ID'
    SQLInsert.Strings = (
      'INSERT INTO FILIALS'
      '  (FILIAL_ID, FILIAL_NAME)'
      'VALUES'
      '  (:FILIAL_ID, :FILIAL_NAME)'
      'RETURNING'
      '  FILIAL_ID, FILIAL_NAME'
      'INTO'
      '  :FILIAL_ID, :FILIAL_NAME')
    SQLDelete.Strings = (
      'DELETE FROM FILIALS'
      'WHERE'
      '  FILIAL_ID = :Old_FILIAL_ID')
    SQLUpdate.Strings = (
      'UPDATE FILIALS'
      'SET'
      '  FILIAL_NAME = :FILIAL_NAME'
      'WHERE'
      '  FILIAL_ID = :Old_FILIAL_ID'
      'RETURNING'
      '  FILIAL_NAME'
      'INTO'
      '  :FILIAL_NAME')
    SQLRefresh.Strings = (
      'SELECT FILIAL_ID, FILIAL_NAME FROM FILIALS'
      'WHERE'
      '  FILIAL_ID = :FILIAL_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM FILIALS')
    RefreshOptions = []
    IndexFieldNames = 'FILIAL_NAME'
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_FILIAL_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_FILIAL_ID;'
      'end;')
    CommandStoredProcName = 'NEW_FILIAL_ID:0'
  end
end
