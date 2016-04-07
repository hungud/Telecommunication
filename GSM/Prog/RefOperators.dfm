inherited RefOperatorsForm: TRefOperatorsForm
  Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099' '#1089#1086#1090#1086#1074#1086#1081' '#1089#1074#1103#1079#1080
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'OPERATOR_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 524
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORDER_NUMBER'
          Title.Caption = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#1085#1086#1084#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 128
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'OPERATORS'
    KeyFields = 'OPERATOR_ID'
    SQLInsert.Strings = (
      'INSERT INTO OPERATORS'
      '  (OPERATOR_ID, OPERATOR_NAME, ORDER_NUMBER)'
      'VALUES'
      '  (:OPERATOR_ID, :OPERATOR_NAME, :ORDER_NUMBER)'
      'RETURNING'
      '  OPERATOR_ID, OPERATOR_NAME, ORDER_NUMBER'
      'INTO'
      '  :OPERATOR_ID, :OPERATOR_NAME, :ORDER_NUMBER')
    SQLDelete.Strings = (
      'DELETE FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID')
    SQLUpdate.Strings = (
      'UPDATE OPERATORS'
      'SET'
      '  OPERATOR_ID = :OPERATOR_ID, '
      '  OPERATOR_NAME = :OPERATOR_NAME,'
      '  ORDER_NUMBER = :ORDER_NUMBER'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID'
      'RETURNING'
      '  OPERATOR_ID, OPERATOR_NAME'
      'INTO'
      '  :OPERATOR_ID, :OPERATOR_NAME')
    SQLRefresh.Strings = (
      'SELECT OPERATOR_ID, OPERATOR_NAME, ORDER_NUMBER FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :OPERATOR_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM OPERATORS')
    IndexFieldNames = 'OPERATOR_NAME'
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_OPERATOR_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_OPERATOR_ID;'
      'end;')
    CommandStoredProcName = 'NEW_OPERATOR_ID:0'
  end
end
