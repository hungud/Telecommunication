inherited frmRefRoamingProviders: TfrmRefRoamingProviders
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1056#1086#1091#1084#1080#1085#1075'-'#1087#1088#1086#1074#1072#1081#1076#1077#1088#1099'"'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited ToolBar1: TToolBar
      inherited ToolButton1: TToolButton
        Visible = False
      end
      inherited ToolButton3: TToolButton
        Visible = False
      end
      object ToolButton9: TToolButton
        Left = 202
        Top = 0
        Action = aExcelExport
      end
    end
  end
  inherited Panel2: TPanel
    BevelOuter = bvNone
    inherited CRDBGrid1: TCRDBGrid
      Left = 0
      Top = 0
      Width = 704
      Height = 256
      Columns = <
        item
          Expanded = False
          FieldName = 'ROAMING_PROVIDER_CODE'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COUNTRY_CODE'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DAMPS_PROV_NAME'
          Title.Alignment = taCenter
          Width = 285
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ROAMING_PROVIDER_ID'
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ROAMING_TYPE_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1088#1086#1091#1084#1080#1085#1075#1072
          Width = 175
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'ROAMING_PROVIDERS'
    KeyFields = 'ROAMING_PROVIDER_ID'
    SQLInsert.Strings = (
      'INSERT INTO ROAMING_PROVIDERS'
      
        '  (ROAMING_PROVIDER_CODE, COUNTRY_CODE, DAMPS_PROV_NAME, ROAMING' +
        '_TYPE_ID)'
      'VALUES'
      
        '  (:ROAMING_PROVIDER_CODE, :COUNTRY_CODE, :DAMPS_PROV_NAME, :ROA' +
        'MING_TYPE_ID)'
      'RETURNING'
      
        '  ROAMING_PROVIDER_CODE, COUNTRY_CODE, DAMPS_PROV_NAME, ROAMING_' +
        'TYPE_ID'
      'INTO'
      
        '  :ROAMING_PROVIDER_CODE, :COUNTRY_CODE, :DAMPS_PROV_NAME, :ROAM' +
        'ING_TYPE_ID')
    SQLDelete.Strings = (
      'DELETE FROM ROAMING_PROVIDERS'
      'WHERE'
      '  ROAMING_PROVIDER_ID = :olD_ROAMING_PROVIDER_ID')
    SQLUpdate.Strings = (
      'UPDATE ROAMING_PROVIDERS'
      'SET'
      '  ROAMING_PROVIDER_CODE = :ROAMING_PROVIDER_CODE,'
      '  COUNTRY_CODE = :COUNTRY_CODE,'
      '  DAMPS_PROV_NAME = :DAMPS_PROV_NAME,'
      '  ROAMING_TYPE_ID = :ROAMING_TYPE_ID'
      'WHERE'
      '  ROAMING_PROVIDER_ID = :olD_ROAMING_PROVIDER_ID'
      'RETURNING'
      
        '  ROAMING_PROVIDER_CODE, COUNTRY_CODE, DAMPS_PROV_NAME, ROAMING_' +
        'TYPE_ID'
      'INTO'
      
        '  :ROAMING_PROVIDER_CODE, :COUNTRY_CODE, :DAMPS_PROV_NAME, :ROAM' +
        'ING_TYPE_ID')
    SQLRefresh.Strings = (
      'SELECT RP.ROAMING_PROVIDER_CODE,'
      '       RP.COUNTRY_CODE,'
      '       RP.DAMPS_PROV_NAME,'
      '       RP.ROAMING_PROVIDER_ID,'
      '       RP.ROAMING_TYPE_ID'
      'FROM ROAMING_PROVIDERS rp'
      'WHERE'
      '   rp.ROAMING_PROVIDER_ID = :olD_ROAMING_PROVIDER_ID')
    SQL.Strings = (
      'select RP.ROAMING_PROVIDER_CODE,'
      '       RP.COUNTRY_CODE,'
      '       RP.DAMPS_PROV_NAME,'
      '       RP.ROAMING_PROVIDER_ID,'
      '       RP.ROAMING_TYPE_ID'
      'from ROAMING_PROVIDERS rp'
      'order by RP.ROAMING_PROVIDER_CODE')
    BeforeInsert = qMainBeforeInsert
    Left = 112
    Top = 64
    object qMainROAMING_PROVIDER_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1087#1088#1086#1074#1072#1081#1076#1077#1088#1072
      FieldName = 'ROAMING_PROVIDER_CODE'
      Size = 32
    end
    object qMainCOUNTRY_CODE: TFloatField
      DisplayLabel = #1050#1086#1076' '#1089#1090#1088#1072#1085#1099
      FieldName = 'COUNTRY_CODE'
    end
    object qMainDAMPS_PROV_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1088#1090#1085#1077#1088#1072
      FieldName = 'DAMPS_PROV_NAME'
      Size = 150
    end
    object qMainROAMING_PROVIDER_ID: TFloatField
      FieldName = 'ROAMING_PROVIDER_ID'
      Required = True
    end
    object qMainROAMING_TYPE_ID: TFloatField
      FieldName = 'ROAMING_TYPE_ID'
    end
    object qMainROAMING_TYPE_NAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'ROAMING_TYPE_NAME'
      LookupDataSet = qRoamingTypes
      LookupKeyFields = 'ROAMING_TYPE_ID'
      LookupResultField = 'ROAMING_TYPE_NAME'
      KeyFields = 'ROAMING_TYPE_ID'
      Size = 50
      Lookup = True
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 224
  end
  inherited ActionList1: TActionList
    object aExcelExport: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1101#1082#1089#1077#1083#1100
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1101#1082#1089#1077#1083#1100
      ImageIndex = 12
      OnExecute = aExcelExportExecute
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object qRoamingTypes: TOraQuery
    SQL.Strings = (
      'select'
      '  RT.ROAMING_TYPE_ID,'
      '  RT.ROAMING_TYPE_NAME'
      ''
      ' from roaming_type rt')
    Left = 440
    Top = 72
    object qRoamingTypesROAMING_TYPE_ID: TFloatField
      FieldName = 'ROAMING_TYPE_ID'
      Required = True
    end
    object qRoamingTypesROAMING_TYPE_NAME: TStringField
      FieldName = 'ROAMING_TYPE_NAME'
      Size = 200
    end
  end
end
