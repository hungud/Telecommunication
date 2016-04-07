inherited PaymentTypesForm: TPaymentTypesForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1087#1083#1072#1090#1077#1078#1077#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited ToolBar1: TToolBar
      Width = 704
      ExplicitWidth = 704
    end
  end
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'RECEIVED_PAYMENT_TYPE_ID'
          Title.Caption = #1050#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RECEIVED_PAYMENT_TYPE_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 250
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'RECEIVED_PAYMENT_TYPES'
    KeyFields = 'RECEIVED_PAYMENT_TYPE_ID'
    SQLInsert.Strings = (
      'INSERT INTO RECEIVED_PAYMENT_TYPES'
      '  (RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME)'
      'VALUES'
      '  (:RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME)'
      'RETURNING'
      '  RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME'
      'INTO'
      '  :RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME')
    SQLDelete.Strings = (
      'DELETE FROM RECEIVED_PAYMENT_TYPES'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :Old_RECEIVED_PAYMENT_TYPE_ID')
    SQLUpdate.Strings = (
      'UPDATE RECEIVED_PAYMENT_TYPES'
      'SET'
      
        '  RECEIVED_PAYMENT_TYPE_ID = :RECEIVED_PAYMENT_TYPE_ID, RECEIVED' +
        '_PAYMENT_TYPE_NAME = :RECEIVED_PAYMENT_TYPE_NAME'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :Old_RECEIVED_PAYMENT_TYPE_ID'
      'RETURNING'
      '  RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME'
      'INTO'
      '  :RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME')
    SQLRefresh.Strings = (
      
        'SELECT RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME FROM' +
        ' RECEIVED_PAYMENT_TYPES'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :RECEIVED_PAYMENT_TYPE_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM RECEIVED_PAYMENT_TYPES')
    IndexFieldNames = 'RECEIVED_PAYMENT_TYPE_ID'
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_RECEIVED_PAYMENT_TYPE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_RECEIVED_PAYMENT_TYPE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_RECEIVED_PAYMENT_TYPE_ID'
  end
end
