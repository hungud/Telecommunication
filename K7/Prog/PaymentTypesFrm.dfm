inherited PaymentTypesForm: TPaymentTypesForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1087#1083#1072#1090#1077#1078#1077#1081
  ExplicitWidth = 712
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
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
        end
        item
          Expanded = False
          FieldName = 'PROFIT_INCLUDING_NAME'
          Title.Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1074' '#1076#1086#1093#1086#1076#1085#1086#1089#1090#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 154
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'RECEIVED_PAYMENT_TYPES'
    KeyFields = 'RECEIVED_PAYMENT_TYPE_ID'
    SQLInsert.Strings = (
      'INSERT INTO RECEIVED_PAYMENT_TYPES'
      
        '  (RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME, PROFIT_' +
        'INCLUDING)'
      'VALUES'
      
        '  (:RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME, :PROF' +
        'IT_INCLUDING)'
      'RETURNING'
      
        '  RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME, PROFIT_I' +
        'NCLUDING'
      'INTO'
      
        '  :RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME, :PROFI' +
        'T_INCLUDING')
    SQLDelete.Strings = (
      'DELETE FROM RECEIVED_PAYMENT_TYPES'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :Old_RECEIVED_PAYMENT_TYPE_ID')
    SQLUpdate.Strings = (
      'UPDATE RECEIVED_PAYMENT_TYPES'
      'SET'
      
        '  RECEIVED_PAYMENT_TYPE_ID = :RECEIVED_PAYMENT_TYPE_ID, RECEIVED' +
        '_PAYMENT_TYPE_NAME = :RECEIVED_PAYMENT_TYPE_NAME,'
      '  PROFIT_INCLUDING = :PROFIT_INCLUDING'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :Old_RECEIVED_PAYMENT_TYPE_ID'
      'RETURNING'
      
        '  RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME, PROFIT_I' +
        'NCLUDING'
      'INTO'
      
        '  :RECEIVED_PAYMENT_TYPE_ID, :RECEIVED_PAYMENT_TYPE_NAME, :PROFI' +
        'T_INCLUDING')
    SQLRefresh.Strings = (
      
        'SELECT RECEIVED_PAYMENT_TYPE_ID, RECEIVED_PAYMENT_TYPE_NAME, PRO' +
        'FIT_INCLUDING FROM RECEIVED_PAYMENT_TYPES'
      'WHERE'
      '  RECEIVED_PAYMENT_TYPE_ID = :RECEIVED_PAYMENT_TYPE_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM RECEIVED_PAYMENT_TYPES')
    IndexFieldNames = 'RECEIVED_PAYMENT_TYPE_ID'
    object qMainRECEIVED_PAYMENT_TYPE_ID: TFloatField
      FieldName = 'RECEIVED_PAYMENT_TYPE_ID'
    end
    object qMainRECEIVED_PAYMENT_TYPE_NAME: TStringField
      FieldName = 'RECEIVED_PAYMENT_TYPE_NAME'
    end
    object qMainPROFIT_INCLUDING: TIntegerField
      FieldName = 'PROFIT_INCLUDING'
    end
    object qMainPROFIT_INCLUDING_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'PROFIT_INCLUDING_NAME'
      LookupDataSet = qPROFIT_INCLUDING
      LookupKeyFields = 'PROFIT_INCLUDING'
      LookupResultField = 'PROFIT_INCLUDING_NAME'
      KeyFields = 'PROFIT_INCLUDING'
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_RECEIVED_PAYMENT_TYPE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_RECEIVED_PAYMENT_TYPE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_RECEIVED_PAYMENT_TYPE_ID'
  end
  object qPROFIT_INCLUDING: TOraQuery
    SQL.Strings = (
      'SELECT 0 PROFIT_INCLUDING, '#39#1053#1077#1090#39' PROFIT_INCLUDING_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 1 PROFIT_INCLUDING, '#39#1044#1072#39' PROFIT_INCLUDING_NAME FROM DUAL')
    Left = 416
    Top = 112
  end
end
