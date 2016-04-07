inherited VIP_Abonents: TVIP_Abonents
  Caption = 'VIP '#1072#1073#1086#1085#1077#1085#1090#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited qMain: TOraQuery
    UpdatingTable = 'ABONENTS_VIP'
    KeyFields = 'ABONENTS_VIP_ID'
    SQLInsert.Strings = (
      'INSERT INTO ABONENTS_VIP'
      
        '  (ABONENTS_VIP_ID, PHONE_NUMBER, INFO, USER_CREATED, DATE_LAST_' +
        'UPDATE)'
      'VALUES'
      
        '  (:ABONENTS_VIP_ID, :PHONE_NUMBER, :INFO, :USER_CREATED, :DATE_' +
        'LAST_UPDATE)')
    SQLDelete.Strings = (
      'DELETE FROM ABONENTS_VIP'
      'WHERE'
      '  ABONENTS_VIP_ID = :Old_ABONENTS_VIP_ID')
    SQLUpdate.Strings = (
      'UPDATE ABONENTS_VIP'
      'SET'
      
        '  ABONENTS_VIP_ID = :ABONENTS_VIP_ID, PHONE_NUMBER = :PHONE_NUMB' +
        'ER, INFO = :INFO, USER_CREATED = :USER_CREATED, DATE_LAST_UPDATE' +
        ' = :DATE_LAST_UPDATE'
      'WHERE'
      '  ABONENTS_VIP_ID = :Old_ABONENTS_VIP_ID')
    SQLLock.Strings = (
      'SELECT * FROM ABONENTS_VIP'
      'WHERE'
      '  ABONENTS_VIP_ID = :Old_ABONENTS_VIP_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT ABONENTS_VIP_ID, PHONE_NUMBER, INFO, USER_CREATED, DATE_L' +
        'AST_UPDATE FROM ABONENTS_VIP'
      'WHERE'
      '  ABONENTS_VIP_ID = :ABONENTS_VIP_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM abonents_vip')
    object qMainPHONE_NUMBER: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
    end
    object qMainINFO: TStringField
      DisplayLabel = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      DisplayWidth = 99
      FieldName = 'INFO'
      Size = 1000
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_abonents_vip_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_abonents_vip_ID;'
      'end;')
    CommandStoredProcName = 'NEW_abonents_vip_ID'
  end
end
