inherited RefDopStatusForm: TRefDopStatusForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1089#1090#1072#1090#1091#1089#1086#1074
  ExplicitWidth = 720
  ExplicitHeight = 321
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
          FieldName = 'DOP_STATUS_ID'
          Title.Alignment = taCenter
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
          FieldName = 'DOP_STATUS_NAME'
          Title.Alignment = taCenter
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
          FieldName = 'DO_BLOCK_PHONE_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1084#1077#1088' '#1089' '#1076#1086#1087'. '#1089#1090#1072#1090#1091#1089#1086#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 225
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'CONTRACT_DOP_STATUSES'
    KeyFields = 'DOP_STATUS_ID'
    SQLInsert.Strings = (
      'INSERT INTO CONTRACT_DOP_STATUSES'
      '  (DOP_STATUS_ID, DOP_STATUS_NAME, DO_BLOCK_PHONE)'
      'VALUES'
      '  (:DOP_STATUS_ID, :DOP_STATUS_NAME, :DO_BLOCK_PHONE)'
      'RETURNING'
      '   DOP_STATUS_ID, DOP_STATUS_NAME, DO_BLOCK_PHONE'
      'INTO'
      '   :DOP_STATUS_ID, :DOP_STATUS_NAME, :DO_BLOCK_PHONE')
    SQLDelete.Strings = (
      'DELETE FROM CONTRACT_DOP_STATUSES'
      'WHERE'
      '  DOP_STATUS_ID = :Old_DOP_STATUS_ID')
    SQLUpdate.Strings = (
      'UPDATE CONTRACT_DOP_STATUSES'
      'SET'
      
        '  DOP_STATUS_ID = :DOP_STATUS_ID, DOP_STATUS_NAME = :DOP_STATUS_' +
        'NAME, DO_BLOCK_PHONE = :DO_BLOCK_PHONE'
      'WHERE'
      '  DOP_STATUS_ID = :Old_DOP_STATUS_ID'
      'RETURNING'
      '  DOP_STATUS_ID, DOP_STATUS_NAME, DO_BLOCK_PHONE'
      'INTO'
      '  :DOP_STATUS_ID, :DOP_STATUS_NAME, :DO_BLOCK_PHONE')
    SQLRefresh.Strings = (
      
        'SELECT DOP_STATUS_ID, DOP_STATUS_NAME, DO_BLOCK_PHONE FROM CONTR' +
        'ACT_DOP_STATUSES'
      'WHERE'
      '  DOP_STATUS_ID = :DOP_STATUS_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM CONTRACT_DOP_STATUSES')
    IndexFieldNames = 'DOP_STATUS_ID'
    object qMainDOP_STATUS_ID: TFloatField
      FieldName = 'DOP_STATUS_ID'
    end
    object qMainDOP_STATUS_NAME: TStringField
      FieldName = 'DOP_STATUS_NAME'
    end
    object qMainDO_BLOCK_PHONE: TIntegerField
      FieldName = 'DO_BLOCK_PHONE'
    end
    object qMainDO_BLOCK_PHONE_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'DO_BLOCK_PHONE_NAME'
      LookupDataSet = qDO_BLOCK_PHONE
      LookupKeyFields = 'DO_BLOCK_PHONE'
      LookupResultField = 'DO_BLOCK_PHONE_NAME'
      KeyFields = 'DO_BLOCK_PHONE'
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOP_STATUS_ID:0'
  end
  object qDO_BLOCK_PHONE: TOraQuery
    SQL.Strings = (
      'SELECT 0 DO_BLOCK_PHONE, '#39#39' DO_BLOCK_PHONE_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 1 DO_BLOCK_PHONE, '#39#1044#1072#39' DO_BLOCK_PHONE_NAME FROM DUAL')
    Left = 416
    Top = 112
  end
end
