inherited RefTariffsForm_Ivideon: TRefTariffsForm_Ivideon
  Caption = #1058#1072#1088#1080#1092#1085#1099#1077' '#1087#1083#1072#1085#1099' IVIDEON'
  ClientWidth = 767
  ExplicitWidth = 775
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 767
    ExplicitWidth = 767
    inherited ToolBar1: TToolBar
      Width = 767
      ExplicitWidth = 767
    end
  end
  inherited Panel2: TPanel
    Width = 767
    ExplicitWidth = 767
    inherited CRDBGrid1: TCRDBGrid
      Width = 765
      Columns = <
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MONTHLY_COST'
          Title.Caption = #1052#1077#1089#1103#1095#1085#1072#1103' '#1072#1073#1086#1085'.'#1087#1083#1072#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_DAYLY_TARIFF'
          Title.Caption = #1055#1088#1080#1079#1085#1072#1082' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1099'(0-'#1084#1077#1089#1103#1094'/1-'#1076#1077#1085#1100')'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 146
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COST_COEEF'
          Title.Caption = #1050#1086#1077#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 158
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'IVIDEON.TARIFFS'
    KeyFields = 'TARIFF_ID'
    SQLInsert.Strings = (
      'INSERT INTO IVIDEON.TARIFFS'
      
        '  (TARIFF_ID, TARIFF_CODE, TARIFF_NAME, MONTHLY_COST, IS_DAYLY_T' +
        'ARIFF, COST_COEEF)'
      'VALUES'
      
        '  (:TARIFF_ID, :TARIFF_CODE, :TARIFF_NAME, :MONTHLY_COST, :IS_DA' +
        'YLY_TARIFF, :COST_COEEF)'
      'RETURNING'
      
        '  TARIFF_ID, TARIFF_CODE, TARIFF_NAME, MONTHLY_COST, IS_DAYLY_TA' +
        'RIFF, COST_COEEF'
      'INTO'
      
        '  :TARIFF_ID, :TARIFF_CODE, :TARIFF_NAME, :MONTHLY_COST, :IS_DAY' +
        'LY_TARIFF, :COST_COEEF')
    SQLDelete.Strings = (
      'DELETE FROM IVIDEON.TARIFFS'
      'WHERE'
      '  TARIFF_ID = :Old_TARIFF_ID')
    SQLUpdate.Strings = (
      'UPDATE IVIDEON.TARIFFS'
      'SET'
      '  TARIFF_ID = :TARIFF_ID, '
      '  TARIFF_CODE = :TARIFF_CODE,'
      '  TARIFF_NAME = :TARIFF_NAME,'
      '  MONTHLY_COST = :MONTHLY_COST,'
      '  IS_DAYLY_TARIFF = :IS_DAYLY_TARIFF,'
      '  COST_COEEF = :COST_COEEF'
      'WHERE'
      '  TARIFF_ID = :Old_TARIFF_ID'
      'RETURNING'
      '  TARIFF_ID'
      'INTO'
      '  :TARIFF_ID')
    SQLRefresh.Strings = (
      
        'SELECT TARIFF_ID, TARIFF_CODE, TARIFF_NAME, MONTHLY_COST, IS_DAY' +
        'LY_TARIFF, COST_COEEF'
      'FROM IVIDEON.TARIFFS'
      'WHERE'
      '  TARIFF_ID = :TARIFF_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM IVIDEON.TARIFFS')
    IndexFieldNames = 'TARIFF_NAME'
    object qMainTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
    end
    object qMainTARIFF_CODE: TStringField
      FieldName = 'TARIFF_CODE'
    end
    object qMainTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
    end
    object qMainMONTHLY_COST: TFloatField
      FieldName = 'MONTHLY_COST'
    end
    object qMainIS_DAYLY_TARIFF: TFloatField
      FieldName = 'IS_DAYLY_TARIFF'
    end
    object qMainCOST_COEEF: TFloatField
      FieldName = 'COST_COEEF'
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'IVIDEON.NEW_TARIFF_ID_IVIDEON'
    SQL.Strings = (
      'begin'
      '  :RESULT := IVIDEON.NEW_TARIFF_ID_IVIDEON;'
      'end;')
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        Value = 6.000000000000000000
        IsResult = True
      end>
    CommandStoredProcName = 'IVIDEON.NEW_TARIFF_ID_IVIDEON'
  end
end
