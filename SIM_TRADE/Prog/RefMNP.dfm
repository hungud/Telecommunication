inherited MNP_NUMBERS: TMNP_NUMBERS
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' MNP '#1085#1086#1084#1077#1088#1086#1074
  ClientWidth = 550
  ExplicitWidth = 558
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 550
    inherited ToolBar1: TToolBar
      Width = 550
      ExplicitWidth = 704
    end
  end
  inherited Panel2: TPanel
    Width = 550
    inherited CRDBGrid1: TCRDBGrid
      Width = 548
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'mnp_remove'
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO MNP_REMOVE'
      '  (PHONE_NUMBER, TEMP_PHONE_NUMBER)'
      'VALUES'
      '  (:PHONE_NUMBER, :TEMP_PHONE_NUMBER)')
    SQLDelete.Strings = (
      'DELETE FROM MNP_REMOVE'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE MNP_REMOVE'
      'SET'
      
        '  PHONE_NUMBER = :PHONE_NUMBER, TEMP_PHONE_NUMBER = :TEMP_PHONE_' +
        'NUMBER'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLRefresh.Strings = (
      'SELECT PHONE_NUMBER, TEMP_PHONE_NUMBER FROM MNP_REMOVE'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'SELECT * '
      'FROM mnp_remove')
    object qMainPHONE_NUMBER: TStringField
      DisplayLabel = #1054#1089#1085#1086#1074#1085#1086#1081' '#1085#1086#1084#1077#1088
      DisplayWidth = 21
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qMainTEMP_PHONE_NUMBER: TStringField
      DisplayLabel = #1042#1088#1077#1084#1077#1085#1085#1099#1081' '#1085#1086#1084#1077#1088
      DisplayWidth = 22
      FieldName = 'TEMP_PHONE_NUMBER'
      Size = 40
    end
    object qMainDATE_ACTIVATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1077#1088#1077#1093#1086#1076#1072' ('#1092#1072#1082#1090'.)'
      DisplayWidth = 27
      FieldName = 'DATE_ACTIVATE'
    end
    object qMainIS_ACTIVE: TIntegerField
      DisplayLabel = #1060#1072#1082#1090' '#1087#1077#1088#1077#1093#1086#1076#1072
      DisplayWidth = 12
      FieldName = 'IS_ACTIVE'
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
