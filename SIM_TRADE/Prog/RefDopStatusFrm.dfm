inherited RefDopStatusForm: TRefDopStatusForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1089#1090#1072#1090#1091#1089#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitWidth = 704
    inherited ToolBar1: TToolBar
      Width = 704
      Height = 31
      ExplicitWidth = 704
      ExplicitHeight = 31
    end
  end
  inherited Panel2: TPanel
    ExplicitWidth = 704
    ExplicitHeight = 250
    inherited CRDBGrid1: TCRDBGrid
      Width = 702
      Height = 248
      Columns = <
        item
          Expanded = False
          FieldName = 'DOP_STATUS_ID'
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
    UpdatingTable = 'CONTRACT_DOP_STATUSES'
    KeyFields = 'DOP_STATUS_ID'
    SQLInsert.Strings = (
      'INSERT INTO CONTRACT_DOP_STATUSES'
      '  (DOP_STATUS_ID, DOP_STATUS_NAME)'
      'VALUES'
      '  (:DOP_STATUS_ID, :DOP_STATUS_NAME)'
      'RETURNING'
      '   DOP_STATUS_ID, DOP_STATUS_NAME'
      'INTO'
      '   :DOP_STATUS_ID, :DOP_STATUS_NAME')
    SQLDelete.Strings = (
      'DELETE FROM CONTRACT_DOP_STATUSES'
      'WHERE'
      '  DOP_STATUS_ID = :Old_DOP_STATUS_ID')
    SQLUpdate.Strings = (
      'UPDATE CONTRACT_DOP_STATUSES'
      'SET'
      
        '  DOP_STATUS_ID = :DOP_STATUS_ID, DOP_STATUS_NAME = :DOP_STATUS_' +
        'NAME'
      'WHERE'
      '  DOP_STATUS_ID = :Old_DOP_STATUS_ID'
      'RETURNING'
      '  DOP_STATUS_ID, DOP_STATUS_NAME'
      'INTO'
      '  :DOP_STATUS_ID, :DOP_STATUS_NAME')
    SQLRefresh.Strings = (
      'SELECT DOP_STATUS_ID, DOP_STATUS_NAME FROM CONTRACT_DOP_STATUSES'
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
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOP_STATUS_ID:0'
  end
end
