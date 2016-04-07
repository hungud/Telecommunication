inherited RefMaskBeautyForm: TRefMaskBeautyForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1072#1089#1082#1080' '#1082#1088#1072#1089#1086#1090#1099' '#1085#1086#1084#1077#1088#1072
  ClientHeight = 339
  ClientWidth = 491
  ExplicitWidth = 499
  ExplicitHeight = 366
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 491
    ExplicitWidth = 491
    inherited ToolBar1: TToolBar
      Width = 491
      ExplicitWidth = 491
    end
  end
  inherited Panel2: TPanel
    Width = 491
    Height = 312
    ExplicitWidth = 491
    ExplicitHeight = 312
    inherited CRDBGrid1: TCRDBGrid
      Width = 489
      Height = 310
      Columns = <
        item
          Expanded = False
          FieldName = 'MASK_BEAUTY_ID'
          ReadOnly = True
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
          FieldName = 'PATTERN'
          Title.Caption = #1052#1072#1089#1082#1072
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
    UpdatingTable = 'MASK_BEAUTY'
    KeyFields = 'MASK_BEAUTY_ID'
    SQLInsert.Strings = (
      
        'INSERT INTO MASK_BEAUTY (MASK_BEAUTY_ID, PATTERN) VALUES (:MASK_' +
        'BEAUTY_ID, :PATTERN)'
      'RETURNING MASK_BEAUTY_ID, PATTERN INTO :MASK_BEAUTY_ID, :PATTERN')
    SQLDelete.Strings = (
      'DELETE FROM MASK_BEAUTY'
      'WHERE'
      '  MASK_BEAUTY_ID = :Old_MASK_BEAUTY_ID')
    SQLUpdate.Strings = (
      'UPDATE MASK_BEAUTY'
      'SET'
      ' PATTERN = :PATTERN'
      'WHERE'
      '  MASK_BEAUTY_ID = :Old_MASK_BEAUTY_ID'
      'RETURNING'
      '  PATTERN'
      'INTO'
      '  :PATTERN')
    SQLRefresh.Strings = (
      'SELECT MASK_BEAUTY_ID, PATTERN FROM MASK_BEAUTY'
      'WHERE MASK_BEAUTY_ID = :MASK_BEAUTY_ID')
    SQL.Strings = (
      'SELECT * FROM mask_beauty')
    IndexFieldNames = 'MASK_BEAUTY_ID'
    object qMainMASK_BEAUTY_ID: TFloatField
      FieldName = 'MASK_BEAUTY_ID'
      Required = True
    end
    object qMainPATTERN: TStringField
      FieldName = 'PATTERN'
      Required = True
      Size = 300
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_MASK_BEAUTY_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_MASK_BEAUTY_ID;'
      'end;')
    CommandStoredProcName = 'NEW_MASK_BEAUTY_ID'
  end
end
