object dmShowUserSt: TdmShowUserSt
  OldCreateOrder = False
  Height = 852
  Width = 1116
  object spCheckAlert: TOraStoredProc
    StoredProcName = 'SHOW_USER_ALERT.CHECK_EXISTS_ALERT'
    Session = MainForm.OraSession
    Left = 1008
    Top = 280
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SHOW_USER_ALERT.CHECK_EXISTS_ALERT'
  end
  object qServiceVolumeCheck: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT count(1) as csr'
      '      FROM     service_volume sv'
      '      where sv.option_code=:opt_code')
    Left = 440
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'opt_code'
      end>
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      '--'#1086#1089#1085#1086#1074#1072
      'SELECT'
      '  TRUNC(DB_LOADER_PHONE_STAT.YEAR_MONTH / 100) YEAR,'
      
        '  DB_LOADER_PHONE_STAT.YEAR_MONTH - TRUNC(DB_LOADER_PHONE_STAT.Y' +
        'EAR_MONTH / 100)*100 MONTH,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM,'
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_MINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLS_COST,'
      '  DB_LOADER_PHONE_STAT.SMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_COST,'
      '  DB_LOADER_PHONE_STAT.MMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_COST,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COUNT + DB_LOADER_PHONE_STAT.MMS_COUN' +
        'T SMS_MMS_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COST + DB_LOADER_PHONE_STAT.MMS_COST ' +
        'SMS_MMS_COST,'
      '  DB_LOADER_PHONE_STAT.INTERNET_MB,'
      '  DB_LOADER_PHONE_STAT.INTERNET_COST,'
      '  DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM'
      ''
      '   - DB_LOADER_PHONE_STAT.CALLS_COST'
      '   - DB_LOADER_PHONE_STAT.SMS_COST'
      '   - DB_LOADER_PHONE_STAT.MMS_COST'
      '   - DB_LOADER_PHONE_STAT.INTERNET_COST   OTHER_COST'
      ''
      ''
      ''
      ''
      ''
      'FROM'
      '  DB_LOADER_PHONE_STAT'
      'WHERE '
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY '
      '  DB_LOADER_PHONE_STAT.YEAR_MONTH DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 24
    Top = 657
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qPeriodsCORP_MOBILE: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  TRUNC(DB_LOADER_PHONE_STAT.YEAR_MONTH / 100) YEAR,'
      
        '  DB_LOADER_PHONE_STAT.YEAR_MONTH - TRUNC(DB_LOADER_PHONE_STAT.Y' +
        'EAR_MONTH / 100)*100 MONTH,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM,'
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_MINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLS_COST,'
      '  DB_LOADER_PHONE_STAT.SMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_COST,'
      '  DB_LOADER_PHONE_STAT.MMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_COST,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COUNT + DB_LOADER_PHONE_STAT.MMS_COUN' +
        'T SMS_MMS_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COST + DB_LOADER_PHONE_STAT.MMS_COST ' +
        'SMS_MMS_COST,'
      '  DB_LOADER_PHONE_STAT.INTERNET_MB,'
      '  DB_LOADER_PHONE_STAT.INTERNET_COST,'
      '  DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM'
      '   - DB_LOADER_PHONE_STAT.CALLBACKCOST'
      '   - DB_LOADER_PHONE_STAT.CALLS_COST'
      '   - DB_LOADER_PHONE_STAT.SMS_COST'
      '   - DB_LOADER_PHONE_STAT.MMS_COST'
      '   - DB_LOADER_PHONE_STAT.INTERNET_COST   OTHER_COST,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_INBOX_MINUTES, '
      '  DB_LOADER_PHONE_STAT.CALLBACKCOST,'
      '  DB_LOADER_PHONE_STAT.CALLBACKMINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLBACKCOUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_FREE_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_FREE_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_FREE_COUNT + DB_LOADER_PHONE_STAT.MMS' +
        '_FREE_COUNT SMS_MMS_FREE_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_FULL_MINUTES'
      'FROM'
      '  DB_LOADER_PHONE_STAT'
      'WHERE '
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY '
      '  DB_LOADER_PHONE_STAT.YEAR_MONTH DESC')
    Left = 440
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qBalanceRows: TOraQuery
    SQL.Strings = (
      'SELECT * FROM'
      '('
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  ABONENT_BALANCE_ROWS.ROW_COST AS COST_PLUS,'
      '  TO_NUMBER(NULL) AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST > 0'
      'UNION ALL'
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  TO_NUMBER(NULL) AS COST_PLUS,'
      '  -ABONENT_BALANCE_ROWS.ROW_COST AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST < 0'
      ')'
      'ORDER BY'
      '  ROW_DATE')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 16
    Top = 25
  end
  object qOptionsPer: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT YEAR_MONTH'
      '  FROM DB_LOADER_ACCOUNT_PHONE_OPTS'
      '  WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  group by YEAR_MONTH'
      '  order by YEAR_MONTH desc')
    Left = 440
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object spGetPhoneDetail: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.GET_PHONE_DETAIL'
    Left = 1000
    Top = 24
    ParamData = <
      item
        DataType = ftOraClob
        Name = 'RESULT'
        ParamType = ptOutput
        Value = ''
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMONTH'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER3_PCKG.GET_PHONE_DETAIL:0'
  end
  object spCalcBalanceRows: TOraStoredProc
    StoredProcName = 'CALC_BALANCE_ROWS'
    Left = 1008
    Top = 88
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PBALANCE_DATE'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'CALC_BALANCE_ROWS'
  end
  object dsBalanceRows: TDataSource
    DataSet = qBalanceRows
    Left = 100
    Top = 25
  end
  object qDiscount: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT IS_DISCOUNT_OPERATOR,'
      '       DISCOUNT_BEGIN_DATE,'
      '       DISCOUNT_VALIDITY,'
      
        '       ADD_MONTHS(DISCOUNT_BEGIN_DATE, DISCOUNT_VALIDITY) DISCOU' +
        'NT_END_DATE,'
      'case'
      'when IS_DISCOUNT_OPERATOR=1 then '#39'true'#39
      'else '#39'false'#39
      'end checked'
      '  FROM PHONE_NUMBER_ATTRIBUTES'
      '  WHERE PHONE_NUMBER=:PHONE_NUMBER')
    Left = 16
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qDiscountIS_DISCOUNT_OPERATOR: TIntegerField
      FieldName = 'IS_DISCOUNT_OPERATOR'
    end
    object qDiscountDISCOUNT_BEGIN_DATE: TDateTimeField
      FieldName = 'DISCOUNT_BEGIN_DATE'
    end
    object qDiscountDISCOUNT_VALIDITY: TFloatField
      FieldName = 'DISCOUNT_VALIDITY'
    end
    object qDiscountDISCOUNT_END_DATE: TDateTimeField
      FieldName = 'DISCOUNT_END_DATE'
    end
    object qDiscountCHECKED: TStringField
      FieldName = 'CHECKED'
      Size = 5
    end
  end
  object dsDiscount: TDataSource
    DataSet = qDiscount
    Left = 100
    Top = 89
  end
  object spSetDiscount: TOraStoredProc
    StoredProcName = 'SET_PHONE_ATTR_DISCOUNT'
    Session = MainForm.OraSession
    Left = 1008
    Top = 472
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PCHECK'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PDISCOUNT_VALIDITY'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PDISCOUNT_BEGIN_DATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SET_PHONE_ATTR_DISCOUNT'
  end
  object dsOptions: TDataSource
    DataSet = qOptions
    Left = 100
    Top = 145
  end
  object qOptions: TOraQuery
    UpdatingTable = 'DB_LOADER_ACCOUNT_PHONE_OPTS'
    SQLUpdate.Strings = (
      'UPDATE DB_LOADER_ACCOUNT_PHONE_OPTS'
      'SET TURN_OFF_DATE = :TURN_OFF_DATE'
      'WHERE'
      '  ROWID = :Old_ROWID'
      '  and TURN_OFF_DATE is not null')
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_PARAMETERS, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.rowid'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS'
      'WHERE'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH = :YEAR_MONTH'
      
        '  and nvl(DB_LOADER_ACCOUNT_PHONE_OPTS.ADDED_FOR_RETARIF, 0) <> ' +
        '1'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE DESC NULLS FIRST,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE ASC,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME ASC')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.StrictUpdate = False
    Left = 16
    Top = 145
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
  object qTGOption: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT NULL OPTION_GROUP_ID, '#39'   '#39' OPTION_GROUP_NAME'
      '  FROM DUAL'
      'UNION ALL'
      'SELECT T.OPTION_GROUP_ID,'
      '       T.OPTION_GROUP_NAME'
      '  FROM TARIFF_OPTION_GROUP T'
      '/*SELECT T.OPTION_GROUP_ID,'
      '       T.OPTION_GROUP_NAME'
      '  FROM CONTRACTS C,'
      '       TARIFF_OPTION_GROUP T'
      '  WHERE C.PHONE_NUMBER_FEDERAL = :pPHONE'
      '    AND C.OPTION_GROUP_ID = T.OPTION_GROUP_ID(+)*/')
    Left = 16
    Top = 208
    object qTGOptionOPTION_GROUP_ID: TFloatField
      FieldName = 'OPTION_GROUP_ID'
    end
    object qTGOptionOPTION_GROUP_NAME: TStringField
      FieldName = 'OPTION_GROUP_NAME'
      Size = 200
    end
  end
  object dsTGOption: TDataSource
    DataSet = qTGOption
    Left = 104
    Top = 208
  end
  object dsAPIOptionHistory: TDataSource
    DataSet = qAPIOptionHistory
    Left = 112
    Top = 264
  end
  object qAPIOptionHistory: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select tol.PHONE_NUMBER, '
      '       tol.OPTION_CODE,'
      '       opt.OPTION_NAME,'
      '       case'
      '         when tol.INCLUSION_TYPE = '#39'A'#39' then '#39#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077#39
      '         when tol.INCLUSION_TYPE = '#39'D'#39' then '#39#1054#1090#1082#1083#1102#1095#1077#1085#1080#1077#39
      '         else '#39#1054#1096#1080#1073#1082#1072#39
      '       end INCLUSION_TYPE,'
      '       nvl(tol.EFF_DATE, tol.REQUEST_DATE_TIME) EFF_DATE,'
      '       tol.REQUEST_ID, '
      '       tol.REQUEST_DATE_TIME,'
      '       case'
      '         when bt.ANSWER = 1 then '#39#1042#1099#1087#1086#1083#1085#1077#1085#1086#39
      '         when bt.ANSWER = 0 then '#39#1054#1090#1082#1072#1079#1072#1085#1086#39
      '         else '#39#1042' '#1087#1088#1086#1094#1077#1089#1089#1077#39'  '
      '       end ANSWER,'
      '       tol.USER_NAME,'
      '       case'
      
        '         when tol.REQUEST_INITIATOR = '#39'RETARIF'#39' then '#39#1040#1074#1090#1086#1054#1087#1077#1088#1072#1094 +
        #1080#1103#39
      '         else '#39#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#39
      '       end REQUEST_INITIATOR'
      '  from TARIFF_OPTIONS_REQ_LOG tol, '
      '       BEELINE_TICKETS bt,'
      '       tariff_options opt'
      '  where tol.PHONE_NUMBER = :PHONE_NUMBER'
      '    and tol.REQUEST_ID = bt.TICKET_ID(+)'
      '    and tol.OPTION_CODE = opt.OPTION_CODE(+)'
      '    and ((tol.request_initiator <> '#39'RETARIF'#39') or (:RETARIF = 1))'
      '    /*and not exists (select 1'
      '                      from ROAMING_RETARIF_PHONES rrp'
      
        '                      where tol.REQUEST_ID = rrp.SERVICE_ON_TICK' +
        'ET_ID'
      
        '                        or tol.REQUEST_ID = rrp.SERVICE_OFF_TICK' +
        'ET_ID)*/'
      '  order by tol.REQUEST_DATE_TIME desc')
    Left = 24
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'RETARIF'
      end>
    object qAPIOptionHistoryOPTION_CODE: TStringField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 10
      FieldName = 'OPTION_CODE'
      Size = 120
    end
    object qAPIOptionHistoryOPTION_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      DisplayWidth = 20
      FieldName = 'OPTION_NAME'
      Size = 400
    end
    object qAPIOptionHistoryINCLUSION_TYPE: TStringField
      DisplayLabel = #1054#1087#1077#1088#1072#1094#1080#1103
      DisplayWidth = 13
      FieldName = 'INCLUSION_TYPE'
      Size = 22
    end
    object qAPIOptionHistoryEFF_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1074#1082#1083'/'#1074#1099#1082#1083
      FieldName = 'EFF_DATE'
    end
    object qAPIOptionHistoryREQUEST_ID: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1079#1072#1087#1088#1086#1089#1072
      DisplayWidth = 15
      FieldName = 'REQUEST_ID'
    end
    object qAPIOptionHistoryREQUEST_DATE_TIME: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1087#1088#1086#1089#1072
      FieldName = 'REQUEST_DATE_TIME'
    end
    object qAPIOptionHistoryANSWER: TStringField
      DisplayLabel = #1054#1090#1074#1077#1090
      FieldName = 'ANSWER'
      Size = 19
    end
    object qAPIOptionHistoryUSER_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      DisplayWidth = 15
      FieldName = 'USER_NAME'
      Size = 30
    end
    object qAPIOptionHistoryREQUEST_INITIATOR: TStringField
      DisplayLabel = #1048#1085#1080#1094#1080#1072#1090#1086#1088
      DisplayWidth = 15
      FieldName = 'REQUEST_INITIATOR'
      FixedChar = True
      Size = 24
    end
  end
  object qPeriods2: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  TRUNC(DB_LOADER_PHONE_STAT.YEAR_MONTH / 100) YEAR,'
      
        '  DB_LOADER_PHONE_STAT.YEAR_MONTH - TRUNC(DB_LOADER_PHONE_STAT.Y' +
        'EAR_MONTH / 100)*100 MONTH,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM,'
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_MINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLS_COST,'
      '  DB_LOADER_PHONE_STAT.SMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_COST,'
      '  DB_LOADER_PHONE_STAT.MMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_COST,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COUNT + DB_LOADER_PHONE_STAT.MMS_COUN' +
        'T SMS_MMS_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COST + DB_LOADER_PHONE_STAT.MMS_COST ' +
        'SMS_MMS_COST,'
      '  DB_LOADER_PHONE_STAT.INTERNET_MB,'
      '  DB_LOADER_PHONE_STAT.INTERNET_COST,'
      '  DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM'
      '   - DB_LOADER_PHONE_STAT.CALLS_COST'
      '   - DB_LOADER_PHONE_STAT.SMS_COST'
      '   - DB_LOADER_PHONE_STAT.MMS_COST'
      '   - DB_LOADER_PHONE_STAT.INTERNET_COST   OTHER_COST'
      'FROM'
      '  DB_LOADER_PHONE_STAT'
      'WHERE '
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY '
      '  DB_LOADER_PHONE_STAT.YEAR_MONTH DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 440
    Top = 265
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object spHB_NO_LOAD: TOraStoredProc
    StoredProcName = 'check_hb_no_load'
    Session = MainForm.OraSession
    Left = 1008
    Top = 600
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'check_hb_no_load'
  end
  object spSetHandBlockEndDate: TOraStoredProc
    StoredProcName = 'SET_HAND_BLOCK_END_DATE'
    Session = MainForm.OraSession
    Left = 1008
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PHAND_BLOCK_END_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PBALANCE_NOTICE_HAND_BLOCK'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PBALANCE_BLOCK_HAND_BLOCK'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SET_HAND_BLOCK_END_DATE'
  end
  object qBalanceGroup: TOraQuery
    SQL.Strings = (
      
        'SELECT SUM(get_abonent_balance(phone_number_federal, contract_ca' +
        'ncel_date)) group_balance '
      'FROM v_contracts v'
      'WHERE v.group_id IN (SELECT group_id'
      '                     FROM contracts c'
      '                     WHERE PHONE_NUMBER_FEDERAL=:PHONE_NUMBER'
      
        '                     AND (:CONTRACT_ID=0 or CONTRACT_ID=:CONTRAC' +
        'T_ID)'
      '                     )')
    Left = 440
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object oqApiTickets: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      
        'decode(t.ticket_type,9,'#39#1041#1083#1086#1082#1080#1088#1086#1074#1082#1072#39',10,'#39#1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072#39',12,'#39#1057#1084#1077#1085#1072 +
        ' '#1057#1048#1052#39','#39#1048#1085#1086#1077#39') type_req'
      
        ',decode(nvl(t.answer,'#39'-1'#39'),'#39'-1'#39','#39#1053#1077' '#1087#1088#1086#1074#1077#1088#1077#1085#1086#39','#39'0'#39','#39#1054#1090#1082#1083#1086#1085#1077#1085#1072#39','#39 +
        '1'#39','#39#1048#1089#1087#1086#1083#1085#1077#1085#1086#39','#39#1048#1085#1086#1077#39') state_req'
      ',t.comments'
      ',t.user_created'
      ',t.date_create'
      ',t.date_update'
      'from beeline_tickets t where t.phone_number=:phone'
      'order by t.date_create desc')
    Left = 432
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'phone'
        ParamType = ptInput
      end>
  end
  object spLoadPhoneOptions: TOraStoredProc
    StoredProcName = 'LOADER2_PCKG.LOAD_ACCOUNT_PHONE_OPTIONS'
    Left = 1008
    Top = 536
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PERROR'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'LOADER2_PCKG.LOAD_ACCOUNT_PHONE_OPTIONS'
  end
  object spGetPhoneBillDetail: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.GET_PHONE_BILL_DETAIL'
    Left = 1008
    Top = 152
    ParamData = <
      item
        DataType = ftOraClob
        Name = 'RESULT'
        ParamType = ptOutput
        Value = ''
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMONTH'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER3_PCKG.GET_PHONE_BILL_DETAIL'
  end
  object spGetHBMonth: TOraStoredProc
    StoredProcName = 'HOT_BILLING_PCKG.GET_HOT_BILLING_MONTH'
    Session = MainForm.OraSession
    Left = 912
    Top = 32
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMONTH'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'HOT_BILLING_PCKG.GET_HOT_BILLING_MONTH'
  end
  object qPrivateContract: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ph.ACCOUNT_ID, ac.ACCOUNT_NUMBER '
      'FROM DB_LOADER_ACCOUNT_PHONES ph'
      'LEFT JOIN ACCOUNTS ac ON ac.ACCOUNT_ID = ph.ACCOUNT_ID'
      'WHERE ph.PHONE_NUMBER = :pPHONE_NUMBER'
      '    AND ph.YEAR_MONTH = (SELECT MAX(YEAR_MONTH) YEAR_MONTH'
      
        '                                         FROM DB_LOADER_ACCOUNT_' +
        'PHONES'
      
        '                                         WHERE PHONE_NUMBER = :p' +
        'PHONE_NUMBER)')
    Left = 440
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pPHONE_NUMBER'
      end>
    object qPrivateContractACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
    end
    object qPrivateContractACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
  end
  object qTariffInfo: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,'
      '  DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '  TARIFFS.TARIFF_NAME,'
      '  TARIFFS.PHONE_NUMBER_TYPE,'
      '  DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_CODE,'
      '  NEW_TARIFFS.TARIFF_NAME NEW_TARIFF_NAME,'
      '  DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_DATE,'
      
        '  GET_ABONENT_BALANCE(ap.PHONE_NUMBER,:pBALANCE_DATE) CURRENT_BA' +
        'LANCE,'
      '  DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_ACCOUNT_PHONES.SYSTEM_BLOCK,'
      '  DB_LOADER_ACCOUNT_PHONES.CONSERVATION,'
      '  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH,'
      
        '  DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE||chr(13)||TARIFFS.TARI' +
        'FF_NAME v_tariff,'
      
        #39#1048#1079#1084#1077#1085#1080#1090#1089#1103' '#1085#1072' '#39'||DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_CODE||'#39' ' +
        'c '#39'||to_char(DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_DATE,'#39'DD.MM.' +
        'YY'#39') v_new_tarif,'
      '  BSC.INFO_COLOR,'
      '  BSC.STATUS_CODE'
      ' ,(Select nvl(AC.IS_COLLECTOR, 0) '
      '     from accounts ac '
      '    where AC.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID '
      '  ) IS_COLLECTOR_BAN'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONES,'
      '   (SELECT distinct PHONE_NUMBER'
      '          FROM DB_LOADER_ACCOUNT_PHONES'
      
        '          where DB_LOADER_ACCOUNT_PHONES.Phone_Number is not nul' +
        'l'
      '   ) AP,'
      '  TARIFFS,'
      '  TARIFFS NEW_TARIFFS,'
      '  BEELINE_STATUS_CODE BSC'
      'WHERE'
      '  ap.PHONE_NUMBER =:PHONE_NUMBER'
      '  and ap.PHONE_NUMBER = DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER(+)'
      
        '  AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH(+) = TO_NUMBER(TO_CHAR' +
        '(SYSDATE, '#39'YYYYMM'#39')) '
      '  AND DB_LOADER_ACCOUNT_PHONES.STATUS_ID = BSC.STATUS_ID(+)'
      '  AND TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME'
      '        )'
      '  AND NEW_TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME'
      '        )'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC')
    DetailFields = '.'
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 224
    Top = 313
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'pBALANCE_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qContractInfo_DopStatus: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      '  DOP_STATUS = :DOP_STATUS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'SELECT DOP_STATUS FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    SQL.Strings = (
      'SELECT '
      '  CONTRACT_ID, '
      '  DOP_STATUS'
      'FROM'
      '  CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    Left = 224
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qContractDopStatuses: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT NULL dop_status_id, NULL dop_status_name FROM dual'
      'UNION ALL'
      'SELECT dop_status_id, dop_status_name FROM contract_dop_statuses')
    Left = 224
    Top = 440
  end
  object qContractInfo: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      '  COMMENTS = :COMMENTS,'
      '  DEALER_KOD = :DEALER_KOD,'
      '  OPTION_GROUP_ID = :OPTION_GROUP_ID,'
      '  MN_ROAMING = :MN_ROAMING'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      
        'SELECT CONTRACT_NUM, CONTRACT_DATE, FILIAL_ID, COMMENTS, DEALER_' +
        'KOD, MN_ROAMING FROM CONTRACTS '
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    SQL.Strings = (
      'SELECT '
      '  CONTRACT_ID, '
      '  CONTRACT_DATE, '
      '  FILIAL_ID,'
      '  COMMENTS,'
      '  DEALER_KOD,'
      
        '  CASE     WHEN IS_CREDIT_CONTRACT=1 THEN '#39#1050#1088#1077#1076#1080#1090#39'    ELSE '#39#1040#1074#1072#1085 +
        #1089#39'  END CONTRACT_TYPE,'
      
        ' GET_ACCOUNT_NUMBER_BY_PHONE(PHONE_NUMBER_FEDERAL) ACCOUNT_NUMBE' +
        'R,'
      
        '  (SELECT acc.company_name     FROM ACCOUNTS acc    where ACC.AC' +
        'COUNT_NUMBER=GET_ACCOUNT_NUMBER_BY_PHONE(PHONE_NUMBER_FEDERAL)) ' +
        'company_name,'
      '  SHOW_USER_ALERT.GET_RASSROCHKA_INFO(CONTRACT_ID) RASSROCHKA,'
      '  NVL(DISCONNECT_LIMIT, 0) DISCONNECT_LIMIT,'
      '  OPTION_GROUP_ID, '
      '  MN_ROAMING,'
      
        '( select nvl(vcontr.CONTRACT_CANCEL_DATE,to_date('#39'31.01.3000'#39','#39'd' +
        'd.mm.yyyy'#39')) from V_CONTRACTS vcontr WHERE  vcontr.CONTRACT_ID =' +
        ' :CONTRACT_ID)'
      ''
      'CONTRACT_CANCEL_DATE,'
      
        '(select cg.group_name from contract_groups cg where cg.group_id=' +
        'CONTRACTS.group_id) group_name,'
      
        'nvl(regexp_substr(paramdisable_sms,'#39'\d,\d+'#39',1,1),0) start_sms_ti' +
        'me,'
      'nvl(regexp_substr(paramdisable_sms,'#39'\d,\d+'#39',1,2),1) end_sms_time'
      'FROM '
      '  CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    Left = 24
    Top = 320
    ParamData = <
      item
        DataType = ftString
        Name = 'CONTRACT_ID'
        Value = '15705'
      end>
    object qContractInfoCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
    end
    object qContractInfoCONTRACT_DATE: TDateTimeField
      FieldName = 'CONTRACT_DATE'
    end
    object qContractInfoCONTRACT_CANCEL_DATE: TDateTimeField
      FieldName = 'CONTRACT_CANCEL_DATE'
    end
    object qContractInfoFILIAL_ID: TFloatField
      FieldName = 'FILIAL_ID'
    end
    object qContractInfoCOMMENTS: TStringField
      FieldName = 'COMMENTS'
      Size = 1200
    end
    object qContractInfoDEALER_KOD: TFloatField
      FieldName = 'DEALER_KOD'
    end
    object qContractInfoCONTRACT_TYPE: TStringField
      FieldName = 'CONTRACT_TYPE'
      FixedChar = True
      Size = 32
    end
    object qContractInfoACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qContractInfoCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
    object qContractInfoRASSROCHKA: TStringField
      FieldName = 'RASSROCHKA'
      Size = 4000
    end
    object qContractInfoDISCONNECT_LIMIT: TFloatField
      FieldName = 'DISCONNECT_LIMIT'
    end
    object qContractInfoOPTION_GROUP_ID: TFloatField
      FieldName = 'OPTION_GROUP_ID'
    end
    object qContractInfoOPTION_GROUP_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPTION_GROUP_NAME'
      LookupDataSet = qTGOption
      LookupKeyFields = 'OPTION_GROUP_ID'
      LookupResultField = 'OPTION_GROUP_NAME'
      KeyFields = 'OPTION_GROUP_ID'
      Lookup = True
    end
    object qContractInfoMN_ROAMING: TFloatField
      FieldName = 'MN_ROAMING'
    end
    object qContractInfoSTART_SMS_TIME: TStringField
      FieldName = 'START_SMS_TIME'
      Size = 200
    end
    object qContractInfoEND_SMS_TIME: TStringField
      FieldName = 'END_SMS_TIME'
      Size = 200
    end
    object fldGROUP_NAME: TStringField
      FieldName = 'GROUP_NAME'
      Size = 880
    end
  end
  object dsTariffInfo: TDataSource
    DataSet = qTariffInfo
    Left = 316
    Top = 321
  end
  object dsContractInfo_DopStatus: TDataSource
    DataSet = qContractInfo_DopStatus
    Left = 320
    Top = 376
  end
  object dsContractDopStatuses: TDataSource
    DataSet = qContractDopStatuses
    Left = 328
    Top = 440
  end
  object qPeriodsGSM_CORP: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  TRUNC(DB_LOADER_PHONE_STAT.YEAR_MONTH / 100) YEAR,'
      
        '  DB_LOADER_PHONE_STAT.YEAR_MONTH - TRUNC(DB_LOADER_PHONE_STAT.Y' +
        'EAR_MONTH / 100)*100 MONTH,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM,'
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_MINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLS_COST,'
      '  DB_LOADER_PHONE_STAT.SMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_COST,'
      '  DB_LOADER_PHONE_STAT.MMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_COST,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COUNT + DB_LOADER_PHONE_STAT.MMS_COUN' +
        'T SMS_MMS_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COST + DB_LOADER_PHONE_STAT.MMS_COST ' +
        'SMS_MMS_COST,'
      '  DB_LOADER_PHONE_STAT.INTERNET_MB,'
      '  DB_LOADER_PHONE_STAT.INTERNET_COST,'
      '  DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM'
      ''
      '   - DB_LOADER_PHONE_STAT.CALLS_COST'
      '   - DB_LOADER_PHONE_STAT.SMS_COST'
      '   - DB_LOADER_PHONE_STAT.MMS_COST'
      '   - DB_LOADER_PHONE_STAT.INTERNET_COST   OTHER_COST,'
      '  DB_LOADER_PHONE_STAT.COST_CHNG'
      ''
      'FROM'
      '  DB_LOADER_PHONE_STAT'
      'WHERE '
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY '
      '  DB_LOADER_PHONE_STAT.YEAR_MONTH DESC')
    Left = 440
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsContractInfo: TDataSource
    DataSet = qContractInfo
    Left = 112
    Top = 328
  end
  object qClientBills: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT v.*'
      '  FROM V_BILL_FOR_CLIENT_DETAILS V'
      '  WHERE v.PHONE_NUMBER=:PHONE_NUMBER'
      '  ORDER BY V.YEAR_MONTH DESC')
    Left = 216
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qClientBillsDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
    end
    object qClientBillsDATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
    end
    object qClientBillsPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qClientBillsBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1077#1090#1072
      FieldName = 'BILL_SUM'
    end
    object qClientBillsSUBSCRIBER_PAYMENT_NEW: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object qClientBillsSUBSCRIBER_PAYMENT_ADD_NEW: TFloatField
      DisplayLabel = #1059#1089#1083#1091#1075#1080
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_NEW'
    end
    object qClientBillsCALLS_LOCAL_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1089#1090#1085#1099#1077
      FieldName = 'CALLS_LOCAL_COST'
    end
    object qClientBillsCALLS_OTHER_CITY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1075#1086#1088'.'
      FieldName = 'CALLS_OTHER_CITY_COST'
    end
    object qClientBillsCALLS_OTHER_COUNTRY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1085#1072#1088'.'
      FieldName = 'CALLS_OTHER_COUNTRY_COST'
    end
    object qClientBillsINTERNET_COST: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'INTERNET_COST'
    end
    object qClientBillsMESSAGES_COST: TFloatField
      DisplayLabel = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      FieldName = 'MESSAGES_COST'
    end
    object qClientBillsNATIONAL_ROAMING_COST: TFloatField
      DisplayLabel = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'NATIONAL_ROAMING_COST'
    end
    object qClientBillsOTHER_COUNTRY_ROAMING_COST: TFloatField
      DisplayLabel = #1052'. '#1085#1072#1088'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'OTHER_COUNTRY_ROAMING_COST'
    end
    object qClientBillsSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079'. '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
    end
    object qClientBillsSUBSCRIBER_PAYMENT_ADD_VOZVRAT: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1072'(+, '#1057#1052#1057'300)'
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_VOZVRAT'
    end
  end
  object dsClientBills: TDataSource
    DataSet = qClientBills
    Left = 296
    Top = 24
  end
  object qPhoneStatuses: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE as BEGIN_DATE,'
      '  CASE '
      
        '    WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE = TO_DATE('#39'01.01' +
        '.3000'#39', '#39'DD.MM.YYYY'#39') THEN'
      '      TO_DATE(NULL)'
      '    ELSE'
      '      DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE'
      '  END as END_DATE,'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE,'
      
        '  NVL(TARIFFS.TARIFF_NAME, DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PL' +
        'AN_CODE) TARIFF_NAME,'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.DATE_LAST_UPDATED'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS,'
      '  TARIFFS'
      'WHERE'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE'
      '        )'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC NULLS FIRST')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 216
    Top = 73
    ParamData = <
      item
        DataType = ftString
        Name = 'PHONE_NUMBER'
        ParamType = ptInput
      end>
    object qPhoneStatusesPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 400
    end
    object qPhoneStatusesBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
    end
    object qPhoneStatusesEND_DATE: TDateTimeField
      FieldName = 'END_DATE'
    end
    object qPhoneStatusesPHONE_IS_ACTIVE: TIntegerField
      FieldName = 'PHONE_IS_ACTIVE'
    end
    object qPhoneStatusesTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qPhoneStatusesDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
    end
  end
  object dsPhoneStatuses: TDataSource
    DataSet = qPhoneStatuses
    Left = 300
    Top = 81
  end
  object qBills: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_BILLS.ACCOUNT_ID,'
      '  DB_LOADER_BILLS.YEAR_MONTH,'
      '  DB_LOADER_BILLS.PHONE_NUMBER,'
      '  DB_LOADER_BILLS.DATE_BEGIN,'
      '  DB_LOADER_BILLS.DATE_END,'
      '  DB_LOADER_BILLS.BILL_SUM,'
      '  DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN, '
      '  DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD, '
      '  DB_LOADER_BILLS.SINGLE_PAYMENTS, '
      '  DB_LOADER_BILLS.CALLS_LOCAL_COST, '
      '  DB_LOADER_BILLS.CALLS_OTHER_CITY_COST, '
      '  DB_LOADER_BILLS.CALLS_OTHER_COUNTRY_COST, '
      '  DB_LOADER_BILLS.MESSAGES_COST, '
      '  DB_LOADER_BILLS.INTERNET_COST, '
      '  DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_COST, '
      '  DB_LOADER_BILLS.NATIONAL_ROAMING_COST, '
      '  DB_LOADER_BILLS.PENI_COST,'
      '  DB_LOADER_BILLS.DISCOUNT_VALUE,'
      '  DB_LOADER_BILLS.TARIFF_CODE,'
      '  DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_CALLS,'
      '  DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_MESSAGES,'
      '  DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_INTERNET,'
      '  DB_LOADER_BILLS.NATIONAL_ROAMING_CALLS,'
      '  DB_LOADER_BILLS.NATIONAL_ROAMING_MESSAGES,'
      '  DB_LOADER_BILLS.NATIONAL_ROAMING_INTERNET'
      'FROM'
      '  DB_LOADER_BILLS'
      'WHERE'
      '  DB_LOADER_BILLS.PHONE_NUMBER=:PHONE_NUMBER'
      
        '  --AND DB_LOADER_BILLS.YEAR_MONTH = TO_CHAR(DB_LOADER_BILLS.PAY' +
        'MENT_DATE, '#39'YYYYMM'#39')'
      'ORDER BY'
      '  DB_LOADER_BILLS.DATE_END DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 224
    Top = 129
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsBills: TDataSource
    DataSet = qBills
    Left = 300
    Top = 137
  end
  object qDeposit: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CURRENT_DEPOSITE_VALUE '
      '  FROM CONTRACT_DEPOSITES'
      '  WHERE CONTRACT_ID=:CONTRACT_ID')
    Left = 224
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
    object qDepositCURRENT_DEPOSITE_VALUE: TFloatField
      FieldName = 'CURRENT_DEPOSITE_VALUE'
    end
  end
  object dsDeposit: TDataSource
    DataSet = qDeposit
    Left = 296
    Top = 200
  end
  object qDepositOper: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT OPERATION_DATE_TIME, DEPOSITE_VALUE, OPERATOR_NAME, NOTE'
      '  FROM CONTRACT_DEPOSITE_OPER'
      '  WHERE CONTRACT_DEPOSITE_OPER.CONTRACT_ID=:CONTRACT_ID'
      '  ORDER BY OPERATION_DATE_TIME DESC')
    Left = 224
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
    object qDepositOperOPERATION_DATE_TIME: TDateTimeField
      FieldName = 'OPERATION_DATE_TIME'
    end
    object qDepositOperDEPOSITE_VALUE: TFloatField
      FieldName = 'DEPOSITE_VALUE'
    end
    object qDepositOperOPERATOR_NAME: TStringField
      FieldName = 'OPERATOR_NAME'
      Size = 120
    end
    object qDepositOperNOTE: TStringField
      FieldName = 'NOTE'
      Size = 400
    end
  end
  object dsDepositOper: TDataSource
    DataSet = qDepositOper
    Left = 304
    Top = 256
  end
  object spGetCreditInfo: TOraStoredProc
    StoredProcName = 'GET_CREDIT_INFO'
    Session = MainForm.OraSession
    Left = 1008
    Top = 664
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'GET_CREDIT_INFO'
  end
  object spSendSMSBal: TOraStoredProc
    StoredProcName = 'SEND_ABONENT_BALANCE_MESSAGE'
    Session = MainForm.OraSession
    Left = 1008
    Top = 344
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PREQUEST_ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PERROR_MESSAGE'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'PIS_SENT_BEFORE'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'SEND_ABONENT_BALANCE_MESSAGE'
  end
  object qHandBlockStart: TOraQuery
    SQL.Strings = (
      'Select 1  from v_contracts'
      
        'WHERE v_contracts.CONTRACT_ID=:CONTRACT_ID and CONTRACT_CANCEL_D' +
        'ATE is Null'
      
        'and (v_contracts.PHONE_NUMBER_CITY=:PHONE_NUMBER or v_contracts.' +
        'PHONE_NUMBER_FEDERAL=:PHONE_NUMBER)')
    Left = 524
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object spAddPrPayment: TOraStoredProc
    StoredProcName = 'ADD_PROMISED_PAYMENT'
    Session = MainForm.OraSession
    Left = 1008
    Top = 408
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PPAYMENT_SUM'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PPAYMENT_DATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'ADD_PROMISED_PAYMENT'
  end
  object spDelPrPayment: TOraStoredProc
    StoredProcName = 'DELETE_PROMISED_PAYMENT'
    Session = MainForm.OraSession
    Left = 912
    Top = 592
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'DELETE_PROMISED_PAYMENT'
  end
  object LOBQuery: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'insert into BILL_BLOB(FILENAME,DATA) values(:sFILENAME,:sdata)')
    Left = 532
    Top = 568
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'sFILENAME'
      end
      item
        DataType = ftUnknown
        Name = 'sdata'
      end>
  end
  object OraStoredProc1: TOraStoredProc
    StoredProcName = 'DOWNLOAD_BILL_BLOB'
    Session = MainForm.OraSession
    Left = 912
    Top = 648
    ParamData = <
      item
        DataType = ftString
        Name = 'SFILENAME'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'BDATA'
        ParamType = ptInput
        Value = ''
      end>
    CommandStoredProcName = 'DOWNLOAD_BILL_BLOB'
  end
  object qLinkPayment: TOraQuery
    SQL.Strings = (
      'UPDATE DB_LOADER_PAYMENTS'
      'SET CONTRACT_ID=:CONTRACT_ID'
      'WHERE '
      '('
      '(PAYMENT_NUMBER=:PAYMENT_NUMBER)'
      'or (:PAYMENT_NUMBER IS NULL AND PAYMENT_NUMBER IS NULL)'
      ')'
      'AND PHONE_NUMBER=:PHONE_NUMBER'
      'AND PAYMENT_SUM=:PAYMENT_SUM')
    Left = 440
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_SUM'
      end>
  end
  object oqApi_log: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      't.bsal_id'
      ',to_char(t.insert_date,'#39'HH24:MI'#39')insert_date'
      
        ',t.phone,decode(nvl(t.phone,9999),9999,'#39#1051'\'#1057#39','#39#1053#1086#1084#1077#1088#39') req_source' +
        ','
      'decode(t.load_type'
      '                  ,3,'#39#1057#1090#1072#1090#1091#1089#1099#39
      '                  ,4,'#39#1059#1089#1083#1091#1075#1080#39
      '                  ,5,'#39#1057#1095#1077#1090#1072#39
      '                  ,1,'#39#1055#1083#1072#1090#1077#1078#1080#39
      '                  ,6,'#39#1053#1072#1095#1080#1089#1083#1077#1085#1080#1103'('#1090#1077#1082'.)'#39
      '                  ,7,'#39#1044#1077#1090#1072#1083#1100#1085#1099#1077' '#1089#1095#1077#1090#1072#39
      '                  ,9,'#39#1041#1083#1086#1082#1080#1088#1086#1074#1082#1072#39
      '                  ,10,'#39#1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072#39
      '                  ,14,'#39#1047#1072#1075#1088#1091#1079#1082#1072' '#1087#1086#1076#1073#1072#1085#1086#1074#39
      '                  ,13,'#39#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1079#1072#1082#1072#1079#1072#39
      '                  ,'#39#1048#1085#1086#1077#39'||t.load_type) load_type'
      
        '--bsal_id, soap_request, t.soap_answer.getclobval() soap_answer,' +
        ' insert_date, phone, account_id, load_type '
      'from %s t'
      'where (t.phone = :phone or (t.account_id=(select acc.account_id '
      
        '                                                from db_loader_a' +
        'ccount_phones acc '
      
        '                                                where acc.phone_' +
        'number=:phone'
      
        '                                                and acc.year_mon' +
        'th=to_char(sysdate,'#39'YYYYMM'#39')'
      '                                               ) '
      
        '                                                and t.phone is n' +
        'ull'
      '                                 )'
      '      )'
      'and t.load_type!=13--'#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1079#1072#1103#1074#1082#1080
      'and ('
      '     (t.account_id=93 and instr(t.soap_request'
      '                                ,to_char('
      
        '                                         (select inf.ban from be' +
        'eline_loader_inf inf where inf.phone_number=:phone and inf.accou' +
        'nt_id=93)'
      '                                        )'
      '                               )>0'
      '     )'
      '     or t.account_id!=93'
      '     or t.account_id is null'
      '     )')
    Left = 224
    Top = 624
    ParamData = <
      item
        DataType = ftString
        Name = 'phone'
        Value = '9623630138'
      end>
    object fldApi_logBSAL_ID: TFloatField
      DisplayWidth = 11
      FieldName = 'BSAL_ID'
      Required = True
    end
    object fldApi_logINSERT_DATE: TStringField
      DisplayWidth = 13
      FieldName = 'INSERT_DATE'
      Size = 5
    end
    object fldApi_logPHONE: TStringField
      DisplayWidth = 11
      FieldName = 'PHONE'
      Size = 11
    end
    object fldApi_logREQ_SOURCE: TStringField
      DisplayWidth = 14
      FieldName = 'REQ_SOURCE'
      Size = 10
    end
    object fldApi_logLOAD_TYPE: TStringField
      DisplayWidth = 25
      FieldName = 'LOAD_TYPE'
      Size = 48
    end
  end
  object dsApi_log: TDataSource
    DataSet = oqApi_log
    Left = 328
    Top = 632
  end
  object dsDopPhoneInfo: TDataSource
    DataSet = qDopPhoneInfo
    Left = 336
    Top = 576
  end
  object qDopPhoneInfo: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select * from PHONES_DOP where PHONE_NUMBER=:PHONE_NUMBER')
    Left = 232
    Top = 568
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsHandBlockDate: TDataSource
    DataSet = qHandBlockEndDate
    Left = 112
    Top = 496
  end
  object qHandBlockEndDate: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CONTRACTS.HAND_BLOCK,'
      '       CONTRACTS.HAND_BLOCK_DATE_END,'
      '       CASE '
      '         WHEN CONTRACTS.HAND_BLOCK_DATE_END IS NOT NULL THEN'
      '           CONTRACTS.USER_LAST_UPDATED||'
      '           (SELECT '#39' ('#39'||USER_FIO||'#39')'#39' '
      '            FROM USER_NAMES '
      
        '            WHERE CONTRACTS.USER_LAST_UPDATED = UPPER(USER_NAME)' +
        ')'
      '         ELSE NULL'
      '       END USER_NAME,'
      '       CONTRACTS.BALANCE_NOTICE_HAND_BLOCK,'
      '       CONTRACTS.BALANCE_BLOCK_HAND_BLOCK'
      '  FROM CONTRACTS'
      '  WHERE CONTRACTS.CONTRACT_ID=:CONTRACT_ID'
      '  ORDER BY CONTRACTS.CONTRACT_DATE DESC')
    Left = 536
    Top = 624
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qBlocked: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select count(*) as blocked from fraud_blocked_phone fb'
      'where fb.phone_number=:phonenum'
      'and fb.status=1'
      
        'and fb.date_block>= (select max(abp.block_date_time) from AUTO_B' +
        'LOCKED_PHONE abp'
      'where abp.phone_number=:phonenum)')
    Left = 24
    Top = 496
    ParamData = <
      item
        DataType = ftString
        Name = 'phonenum'
        ParamType = ptInput
        Value = '9083902429'
      end>
  end
  object dsPrPayments: TDataSource
    DataSet = qPrPayments
    Left = 112
    Top = 440
  end
  object qPrPayments: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT PP.*'
      '  FROM PROMISED_PAYMENTS PP'
      '  WHERE PP.PHONE_NUMBER=:PHONE_NUMBER'
      '  ORDER BY PP.PROMISED_DATE DESC')
    Left = 32
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qPrPaymentsPROMISED_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 10
      FieldName = 'PROMISED_SUM'
      Required = True
    end
    object qPrPaymentsPAYMENT_DATE: TDateTimeField
      DisplayLabel = #1057
      DisplayWidth = 16
      FieldName = 'PAYMENT_DATE'
      Required = True
    end
    object qPrPaymentsPROMISED_DATE: TDateTimeField
      DisplayLabel = #1055#1086
      DisplayWidth = 16
      FieldName = 'PROMISED_DATE'
      Required = True
    end
    object qPrPaymentsPROMISED_DATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 12
      FieldName = 'PROMISED_DATE_END'
    end
    object qPrPaymentsUSER_CREATED: TStringField
      DisplayLabel = #1057#1086#1079#1076#1072#1090#1077#1083#1100
      DisplayWidth = 16
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qPrPaymentsDATE_CREATED: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      DisplayWidth = 16
      FieldName = 'DATE_CREATED'
    end
    object qPrPaymentsUSER_LAST_UPDATED: TStringField
      DisplayLabel = #1048#1079#1084#1077#1085#1080#1074#1096#1080#1081
      DisplayWidth = 16
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qPrPaymentsDATE_LAST_UPDATED: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      DisplayWidth = 16
      FieldName = 'DATE_LAST_UPDATED'
    end
  end
  object qPayments: TOraQuery
    SQL.Strings = (
      'SELECT'
      '   PHONE_NUMBER,'
      '   PAYMENT_SUM,'
      '   PAYMENT_DATE,'
      '   CONTRACT_ID,'
      '   PAYMENT_REMARK,'
      '   PAYMENT_TYPE_NAME,'
      '   PAYMENT_NUMBER,'
      '   PAYMENT_TYPE,'
      '   CREATED_DATE,'
      '   RECEIVED_PAYMENT_ID,'
      '   REVERSESCHET'
      'FROM'
      '  V_FULL_BALANCE_PAYMENTS'
      'WHERE'
      '  V_FULL_BALANCE_PAYMENTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND V_FULL_BALANCE_PAYMENTS.PAYMENT_TYPE IN (1, 2)'
      'ORDER BY'
      '  V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE DESC')
    FetchAll = True
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 32
    Top = 385
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qPaymentsPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qPaymentsPAYMENT_SUM: TFloatField
      FieldName = 'PAYMENT_SUM'
    end
    object qPaymentsPAYMENT_DATE: TDateTimeField
      FieldName = 'PAYMENT_DATE'
    end
    object qPaymentsCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
    end
    object qPaymentsPAYMENT_REMARK: TStringField
      FieldName = 'PAYMENT_REMARK'
      Size = 2046
    end
    object qPaymentsPAYMENT_TYPE_NAME: TStringField
      FieldName = 'PAYMENT_TYPE_NAME'
      Size = 200
    end
    object qPaymentsPAYMENT_NUMBER: TStringField
      FieldName = 'PAYMENT_NUMBER'
      Size = 120
    end
    object qPaymentsPAYMENT_TYPE: TFloatField
      FieldName = 'PAYMENT_TYPE'
    end
    object qPaymentsCREATED_DATE: TDateTimeField
      FieldName = 'CREATED_DATE'
    end
    object qPaymentsRECEIVED_PAYMENT_ID: TFloatField
      FieldName = 'RECEIVED_PAYMENT_ID'
    end
    object qPaymentsREVERSESCHET: TFloatField
      FieldName = 'REVERSESCHET'
    end
  end
  object dsPayments: TDataSource
    DataSet = qPayments
    Left = 108
    Top = 385
  end
  object qAbonPeriodList: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT *'
      '  FROM V_BILL_ABON_PER_FOR_CLIENT V'
      '  WHERE V.PHONE_NUMBER = :PHONE_NUMBER'
      '  ORDER BY V.DATE_BEGIN DESC')
    Left = 24
    Top = 552
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qAbonPeriodListDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
      Required = True
    end
    object qAbonPeriodListDATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
      Required = True
    end
    object qAbonPeriodListTARIFF_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      DisplayWidth = 10
      FieldName = 'TARIFF_CODE'
      Size = 60
    end
    object qAbonPeriodListABON_MAIN_OLD: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'ABON_MAIN_OLD'
      Required = True
    end
    object qAbonPeriodListABON_MAIN: TFloatField
      DisplayLabel = #1040#1073#1086#1085' '#1082#1083#1080#1077#1085#1090#1072
      FieldName = 'ABON_MAIN'
    end
    object qAbonPeriodListABON_ADD: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1091#1089#1083#1091#1075#1080
      FieldName = 'ABON_ADD'
      Required = True
    end
    object qAbonPeriodListCALC_KOEFF: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092'. '#1087#1077#1088#1077#1089#1095#1077#1090#1072
      FieldName = 'CALC_KOEFF'
    end
    object qAbonPeriodListTARIFF_ADD_COST: TFloatField
      DisplayLabel = #1044#1086#1073'. '#1072#1073'. '#1087#1083'.'
      DisplayWidth = 8
      FieldName = 'TARIFF_ADD_COST'
    end
    object qAbonPeriodListTARIFF_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1072#1088#1080#1092#1072
      DisplayWidth = 40
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
  end
  object dsAbonPeriodList: TDataSource
    DataSet = qAbonPeriodList
    Left = 112
    Top = 552
  end
  object qBillClientNew: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT *'
      '  FROM V_BILL_FINANCE_FOR_CLIENT_DET V'
      '  WHERE V.PHONE_NUMBER = :PHONE_NUMBER'
      '  ORDER BY V.YEAR_MONTH DESC')
    Left = 24
    Top = 600
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qBillClientNewLOGIN: TStringField
      DisplayLabel = #1051'/'#1057
      DisplayWidth = 12
      FieldName = 'LOGIN'
      Size = 120
    end
    object qBillClientNewYEAR_MONTH: TFloatField
      DisplayLabel = #1052#1077#1089#1103#1094
      DisplayWidth = 8
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qBillClientNewBILL_SUM_NEW: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BILL_SUM_NEW'
    end
    object qBillClientNewABON_TP_NEW: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1058#1055
      DisplayWidth = 10
      FieldName = 'ABON_TP_NEW'
    end
    object qBillClientNewABON_ADD_NEW: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1091#1089#1083#1091#1075#1080
      DisplayWidth = 10
      FieldName = 'ABON_ADD_NEW'
    end
    object qBillClientNewDISCOUNT_NEW: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      DisplayWidth = 10
      FieldName = 'DISCOUNT_NEW'
    end
    object qBillClientNewSINGLE_PAYMENTS_NEW: TFloatField
      DisplayLabel = #1056#1072#1079#1086#1074#1099#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      DisplayWidth = 10
      FieldName = 'SINGLE_PAYMENTS_NEW'
    end
    object qBillClientNewDISCOUNT_SMS_PLUS: TFloatField
      DisplayLabel = #1040#1082#1094#1080#1103' '#1057#1052#1057'300 '#1080' +'
      DisplayWidth = 10
      FieldName = 'DISCOUNT_SMS_PLUS'
      Required = True
    end
    object qBillClientNewDISCOUNT_CALL: TFloatField
      DisplayLabel = #1053#1072#1083#1086#1075' '#1085#1072' '#1089#1074#1103#1079#1100
      DisplayWidth = 10
      FieldName = 'DISCOUNT_CALL'
      Required = True
    end
    object qBillClientNewSINGLE_TURN_ON_SERV: TFloatField
      DisplayLabel = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1091#1089#1083#1091#1075
      DisplayWidth = 10
      FieldName = 'SINGLE_TURN_ON_SERV'
      Required = True
    end
    object qBillClientNewSINGLE_CORRECTION_ROUMING: TFloatField
      DisplayLabel = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1088#1086#1091#1084#1080#1085#1075#1072
      DisplayWidth = 10
      FieldName = 'SINGLE_CORRECTION_ROUMING'
      Required = True
    end
    object qBillClientNewSINGLE_CHANGE_TARIFF: TFloatField
      DisplayLabel = #1057#1084#1077#1085#1072' '#1090#1072#1088#1080#1092#1072
      DisplayWidth = 10
      FieldName = 'SINGLE_CHANGE_TARIFF'
      Required = True
    end
    object qBillClientNewSINGLE_INTRA_WEB: TFloatField
      DisplayLabel = #1048#1085#1090#1088#1072#1042#1077#1073'('#1047#1072#1087#1088#1077#1090' '#1082#1086#1088'. '#1085#1086#1084#1077#1088#1086#1074')'
      DisplayWidth = 10
      FieldName = 'SINGLE_INTRA_WEB'
      Required = True
    end
    object qBillClientNewSINGLE_VIEW_BLACK_LIST: TFloatField
      DisplayLabel = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082' '#1072#1073#1086#1085#1086#1074
      DisplayWidth = 10
      FieldName = 'SINGLE_VIEW_BLACK_LIST'
      Required = True
    end
    object qBillClientNewSINGLE_PENALTI: TFloatField
      DisplayLabel = #1064#1090#1088#1072#1092' '#1041#1080#1083#1072#1081#1085#1072
      DisplayWidth = 10
      FieldName = 'SINGLE_PENALTI'
      Required = True
    end
    object qBillClientNewSINGLE_OTHER: TFloatField
      DisplayLabel = #1055#1088#1086#1095#1080#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      DisplayWidth = 10
      FieldName = 'SINGLE_OTHER'
      Required = True
    end
    object qBillClientNewCALLS_COUNTRY: TFloatField
      DisplayLabel = #1052'/'#1085' '#1079#1074#1086#1085#1082#1080
      DisplayWidth = 10
      FieldName = 'CALLS_COUNTRY'
      Required = True
    end
    object qBillClientNewCALLS_SITY: TFloatField
      DisplayLabel = #1052'/'#1075' '#1079#1074#1086#1085#1082#1080
      DisplayWidth = 10
      FieldName = 'CALLS_SITY'
      Required = True
    end
    object qBillClientNewCALLS_LOCAL: TFloatField
      DisplayLabel = #1052#1077#1089#1090#1085#1099#1077
      DisplayWidth = 10
      FieldName = 'CALLS_LOCAL'
      Required = True
    end
    object qBillClientNewCALLS_SMS_MMS: TFloatField
      DisplayLabel = #1057#1052#1057' '#1080' '#1052#1052#1057
      DisplayWidth = 10
      FieldName = 'CALLS_SMS_MMS'
      Required = True
    end
    object qBillClientNewCALLS_GPRS: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      DisplayWidth = 10
      FieldName = 'CALLS_GPRS'
      Required = True
    end
    object qBillClientNewCALLS_RUS_RPP: TFloatField
      DisplayLabel = 'RUS RPP'
      DisplayWidth = 10
      FieldName = 'CALLS_RUS_RPP'
      Required = True
    end
    object qBillClientNewROUMING_NATIONAL: TFloatField
      DisplayLabel = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
      DisplayWidth = 10
      FieldName = 'ROUMING_NATIONAL'
      Required = True
    end
    object qBillClientNewROUMING_INTERNATIONAL: TFloatField
      DisplayLabel = #1052'/'#1085' '#1088#1086#1091#1084#1080#1085#1075
      DisplayWidth = 10
      FieldName = 'ROUMING_INTERNATIONAL'
      Required = True
    end
  end
  object dsBillClientNew: TDataSource
    DataSet = qBillClientNew
    Left = 120
    Top = 600
  end
  object qBillBeeline: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT AC.LOGIN,'
      '       FB.*'
      '  FROM DB_LOADER_FULL_FINANCE_BILL FB,'
      '       ACCOUNTS AC'
      '  WHERE FB.PHONE_NUMBER = :PHONE_NUMBER'
      '    AND FB.ACCOUNT_ID = AC.ACCOUNT_ID(+)'
      '    AND FB.COMPLETE_BILL = 1'
      '  ORDER BY FB.YEAR_MONTH DESC')
    Left = 232
    Top = 504
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qBillBeelineLOGIN: TStringField
      DisplayLabel = #1051'/'#1057
      DisplayWidth = 10
      FieldName = 'LOGIN'
      Size = 120
    end
    object qBillBeelineYEAR_MONTH: TFloatField
      DisplayLabel = #1052#1077#1089#1103#1094
      DisplayWidth = 8
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qBillBeelineBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BILL_SUM'
      Required = True
    end
    object qBillBeelineABONKA: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083'.'
      FieldName = 'ABONKA'
      Required = True
    end
    object qBillBeelineCALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080
      FieldName = 'CALLS'
      Required = True
    end
    object qBillBeelineDISCOUNTS: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      FieldName = 'DISCOUNTS'
      Required = True
    end
    object qBillBeelineSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079#1086#1074#1099#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      FieldName = 'SINGLE_PAYMENTS'
      Required = True
    end
    object qBillBeelineABON_MAIN: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1058#1055
      DisplayWidth = 10
      FieldName = 'ABON_MAIN'
      Required = True
    end
    object qBillBeelineABON_ADD: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1091#1089#1083#1091#1075#1080
      DisplayWidth = 10
      FieldName = 'ABON_ADD'
      Required = True
    end
    object qBillBeelineABON_OTHER: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'. '#1087#1088#1086#1095#1080#1077
      DisplayWidth = 10
      FieldName = 'ABON_OTHER'
      Required = True
    end
    object qBillBeelineDISCOUNT_YEAR: TFloatField
      DisplayLabel = #1043#1086#1076'. '#1085#1072' '#1072#1073'. '#1087#1083'.'
      FieldName = 'DISCOUNT_YEAR'
      Required = True
    end
    object qBillBeelineDISCOUNT_SMS_PLUS: TFloatField
      DisplayLabel = #1040#1082#1094#1080#1103' '#1057#1052#1057'300 '#1080' +'
      FieldName = 'DISCOUNT_SMS_PLUS'
      Required = True
    end
    object qBillBeelineDISCOUNT_CALL: TFloatField
      DisplayLabel = #1053#1072#1083#1086#1075' '#1085#1072' '#1089#1074#1103#1079#1100
      FieldName = 'DISCOUNT_CALL'
      Required = True
    end
    object qBillBeelineDISCOUNT_COUNT_ON_PHONES: TFloatField
      DisplayLabel = #1055#1086' '#1082#1086#1083'-'#1074#1091' '#1087#1086#1076#1082#1083'.'
      FieldName = 'DISCOUNT_COUNT_ON_PHONES'
      Required = True
    end
    object qBillBeelineDISCOUNT_OTHERS: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080' '#1087#1088#1086#1095#1080#1077
      FieldName = 'DISCOUNT_OTHERS'
      Required = True
    end
    object qBillBeelineSINGLE_MAIN: TFloatField
      DisplayLabel = #1042#1086#1079#1074#1088#1072#1090' '#1072#1073'. '#1058#1055
      FieldName = 'SINGLE_MAIN'
      Required = True
    end
    object qBillBeelineSINGLE_ADD: TFloatField
      DisplayLabel = #1042#1086#1079#1074#1088#1072#1090' '#1072#1073'. '#1091#1089#1083#1091#1075#1080
      FieldName = 'SINGLE_ADD'
      Required = True
    end
    object qBillBeelineSINGLE_TURN_ON_SERV: TFloatField
      DisplayLabel = #1055#1086#1076#1082#1083'. '#1091#1089#1083#1091#1075
      FieldName = 'SINGLE_TURN_ON_SERV'
      Required = True
    end
    object qBillBeelineSINGLE_CORRECTION_ROUMING: TFloatField
      DisplayLabel = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1088#1086#1091#1084#1080#1085#1075#1072
      FieldName = 'SINGLE_CORRECTION_ROUMING'
      Required = True
    end
    object qBillBeelineSINGLE_CHANGE_TARIFF: TFloatField
      DisplayLabel = #1057#1084#1077#1085#1072' '#1090#1072#1088#1080#1092#1072
      FieldName = 'SINGLE_CHANGE_TARIFF'
      Required = True
    end
    object qBillBeelineSINGLE_INTRA_WEB: TFloatField
      DisplayLabel = #1048#1085#1090#1088#1072#1042#1077#1073'('#1079#1072#1087#1088#1077#1090' '#1082#1086#1088'. '#1085#1086#1084#1077#1088#1086#1074')'
      FieldName = 'SINGLE_INTRA_WEB'
      Required = True
    end
    object qBillBeelineSINGLE_VIEW_BLACK_LIST: TFloatField
      DisplayLabel = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082' '#1072#1073#1086#1085#1086#1074
      FieldName = 'SINGLE_VIEW_BLACK_LIST'
      Required = True
    end
    object qBillBeelineSINGLE_PENALTI: TFloatField
      DisplayLabel = #1064#1090#1088#1072#1092' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'SINGLE_PENALTI'
      Required = True
    end
    object qBillBeelineSINGLE_OTHER: TFloatField
      DisplayLabel = #1055#1088#1086#1095#1080#1077' '#1088#1072#1079'. '#1085#1072#1095#1080#1089#1083'.'
      FieldName = 'SINGLE_OTHER'
      Required = True
    end
    object qBillBeelineCALLS_COUNTRY: TFloatField
      DisplayLabel = #1052'/'#1085' '#1079#1074#1086#1085#1082#1080
      FieldName = 'CALLS_COUNTRY'
      Required = True
    end
    object qBillBeelineCALLS_SITY: TFloatField
      DisplayLabel = #1052'/'#1075' '#1079#1074#1086#1085#1082#1080
      FieldName = 'CALLS_SITY'
      Required = True
    end
    object qBillBeelineCALLS_LOCAL: TFloatField
      DisplayLabel = #1052#1077#1089#1090#1085#1099#1077
      FieldName = 'CALLS_LOCAL'
      Required = True
    end
    object qBillBeelineCALLS_SMS_MMS: TFloatField
      DisplayLabel = #1057#1052#1057' '#1080' '#1052#1052#1057
      FieldName = 'CALLS_SMS_MMS'
      Required = True
    end
    object qBillBeelineCALLS_GPRS: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'CALLS_GPRS'
      Required = True
    end
    object qBillBeelineCALLS_RUS_RPP: TFloatField
      DisplayLabel = 'RUS RPP'
      FieldName = 'CALLS_RUS_RPP'
      Required = True
    end
    object qBillBeelineCALLS_ALL: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080'('#1074#1089#1077#1075#1086')'
      FieldName = 'CALLS_ALL'
      Required = True
    end
    object qBillBeelineROUMING_NATIONAL: TFloatField
      DisplayLabel = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'ROUMING_NATIONAL'
      Required = True
    end
    object qBillBeelineROUMING_INTERNATIONAL: TFloatField
      DisplayLabel = #1052'/'#1085' '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'ROUMING_INTERNATIONAL'
      Required = True
    end
  end
  object dsBillBeeline: TDataSource
    DataSet = qBillBeeline
    Left = 328
    Top = 512
  end
  object dsPeriods: TDataSource
    DataSet = qPeriods
    Left = 116
    Top = 657
  end
  object qContractDealers: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT * FROM '
      '(SELECT NULL dealer_kod, NULL dealer_name FROM dual'
      'UNION ALL'
      'SELECT dealer_kod, dealer_name'
      'FROM dealers WHERE dealer_kod <> 0'
      ') ORDER BY 2')
    Left = 24
    Top = 712
  end
  object dsContractDealers: TDataSource
    DataSet = qContractDealers
    Left = 112
    Top = 712
  end
  object qRouming: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT *'
      '  FROM V_BILL_ROUMING_FOR_CLIENT V'
      '  WHERE V.PHONE_NUMBER = :PHONE_NUMBER'
      '  ORDER BY V.DATE_BEGIN DESC')
    Left = 24
    Top = 768
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qRoumingDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
    end
    object qRoumingDATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
    end
    object qRoumingROUMING_COUNTRY: TStringField
      DisplayLabel = #1057#1090#1088#1072#1085#1072', '#1089#1077#1090#1100
      DisplayWidth = 20
      FieldName = 'ROUMING_COUNTRY'
      Size = 200
    end
    object qRoumingROUMING_CALLS: TFloatField
      DisplayLabel = #1069#1092#1080#1088#1085#1086#1077' '#1074#1088#1077#1084#1103
      FieldName = 'ROUMING_CALLS'
    end
    object qRoumingROUMING_GPRS: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'ROUMING_GPRS'
    end
    object qRoumingROUMING_SMS: TFloatField
      DisplayLabel = #1057#1052#1057' '#1080' '#1052#1052#1057
      FieldName = 'ROUMING_SMS'
    end
    object qRoumingCOMPANY_TAX: TFloatField
      DisplayLabel = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1082#1086#1084#1087#1072#1085#1080#1080
      FieldName = 'COMPANY_TAX'
    end
    object qRoumingROUMING_SUM: TFloatField
      DisplayLabel = #1042#1089#1077#1075#1086
      FieldName = 'ROUMING_SUM'
    end
  end
  object dsRouming: TDataSource
    DataSet = qRouming
    Left = 112
    Top = 776
  end
  object qRGBlock: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'Select * from BLOCK_TYPES'
      'order by BLOCK_TYPE_id')
    Left = 232
    Top = 680
  end
  object DsRGBlock: TOraDataSource
    DataSet = qRGBlock
    Left = 328
    Top = 696
  end
  object qDailyAbonPay: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO PHONE_NUMBER_WITH_DAILY_ABON'
      '  (PHONE_NUMBER)'
      'VALUES'
      '  (:PHONE_NUMBER)')
    SQLDelete.Strings = (
      'DELETE FROM PHONE_NUMBER_WITH_DAILY_ABON'
      'WHERE PHONE_NUMBER=:PHONE_NUMBER')
    SQLRefresh.Strings = (
      'SELECT PHONE_NUMBER FROM PHONE_NUMBER_WITH_DAILY_ABON'
      'WHERE PHONE_NUMBER = :PHONE_NUMBER')
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT PHONE_NUMBER'
      '  FROM PHONE_NUMBER_WITH_DAILY_ABON'
      '  WHERE PHONE_NUMBER = :PHONE_NUMBER')
    Left = 520
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qDailyAbonPayBanned: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      '  DAILY_ABON_BANNED = :DAILY_ABON_BANNED'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'SELECT DAILY_ABON_BANNED FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CONTRACT_ID, '
      '       DAILY_ABON_BANNED'
      '  FROM CONTRACTS'
      '  WHERE CONTRACT_ID = :CONTRACT_ID')
    Left = 520
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qSummaryPhone: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select * from V_ABONENT_EVENTS'
      '  where PHONE_NUMBER = :PHONE_NUMBER'
      '  ORDER BY EVENT_DATE DESC')
    Left = 232
    Top = 736
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsSummaryPhone: TDataSource
    DataSet = qSummaryPhone
    Left = 328
    Top = 744
  end
  object LoaderUnBlockPhoneNum2: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.UNLOCK_PHONE'
    Session = MainForm.OraSession
    Left = 896
    Top = 272
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_UNLOCK'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.UNLOCK_PHONE'
  end
  object spMsisdnRefresh: TOraStoredProc
    StoredProcName = 'ADD_MSISDN_REFRESH_UPD'
    Session = MainForm.OraSession
    Left = 896
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PLOADING_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PLOADING_MONTH'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PERROR'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'ADD_MSISDN_REFRESH_UPD'
  end
  object LoaderBlockPhoneNum2: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.LOCK_PHONE'
    Session = MainForm.OraSession
    Left = 904
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_BLOCK'
        ParamType = ptInput
        HasDefault = True
      end
      item
        DataType = ftString
        Name = 'PCODE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.LOCK_PHONE'
  end
  object RefreshDetailSum: TOraStoredProc
    StoredProcName = 'HOT_BILLING_PCKG.CALCDETAILSUMOPT'
    Session = MainForm.OraSession
    Left = 896
    Top = 328
    ParamData = <
      item
        DataType = ftString
        Name = 'SSUBSCR'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'SMONTH'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'HOT_BILLING_PCKG.CALCDETAILSUMOPT'
  end
  object PReplaceSIM: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.REPLACE_SIM'
    Session = MainForm.OraSession
    Left = 904
    Top = 400
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PICC'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.REPLACE_SIM'
  end
  object LoaderBlockPhoneNum: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.LOCK_PHONE'
    Left = 912
    Top = 464
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_BLOCK'
        ParamType = ptInput
        Value = 1.000000000000000000
        HasDefault = True
      end
      item
        DataType = ftFloat
        Name = 'PNEW_SITE_METHOD'
        ParamType = ptInput
        Value = 0.000000000000000000
        HasDefault = True
      end>
    CommandStoredProcName = 'LOADER3_PCKG.LOCK_PHONE'
  end
  object GetSendMailParam: TOraStoredProc
    StoredProcName = 'get_send_mail_param'
    Session = MainForm.OraSession
    Left = 912
    Top = 96
    ParamData = <
      item
        DataType = ftString
        Name = 'VPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VSMTP_SERVER'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'VSMTP_PORT'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'VUSER_LOGIN'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'VUSER_PASSWORD'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'VSMTP_FROM'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'get_send_mail_param'
  end
  object LoaderUnBlockPhoneNum: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.UNLOCK_PHONE'
    Left = 912
    Top = 528
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_UNLOCK'
        ParamType = ptInput
        Value = 1.000000000000000000
        HasDefault = True
      end
      item
        DataType = ftFloat
        Name = 'PNEW_SITE_METHOD'
        ParamType = ptInput
        Value = 0.000000000000000000
        HasDefault = True
      end>
    CommandStoredProcName = 'LOADER3_PCKG.UNLOCK_PHONE'
  end
  object qHandBlock: TOraQuery
    Left = 436
    Top = 552
  end
  object qBaseZone: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select bsz.zone_name from BEELINE_BS_ZONES bsz'
      'where bsz.beeline_bs_zone_id=:bzone')
    Left = 432
    Top = 608
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'bzone'
      end>
  end
  object qSelBalDate: TOraQuery
    SQL.Strings = (
      'Select contract_cancel_date,CONTRACT_ID,abonent_id '
      'from V_CONTRACTS '
      'where PHONE_NUMBER_FEDERAL=:PHONE_NUMBER'
      'and (:CONTRACT_ID=0 or CONTRACT_ID=:CONTRACT_ID)')
    Left = 428
    Top = 664
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qAccountNumber: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT GET_ACCOUNT_NUMBER_BY_PHONE(:PHONE_NUMBER) ACCOUNT_NUMBER' +
        ','
      '       (SELECT acc.company_name'
      '          FROM ACCOUNTS acc'
      
        '          where ACC.ACCOUNT_NUMBER=GET_ACCOUNT_NUMBER_BY_PHONE(:' +
        'PHONE_NUMBER)'
      '       ) company_name,'
      '       NULL CONTRACT_ID, '
      '       NULL CONTRACT_DATE, '
      '       NULL FILIAL_ID,'
      '       NULL COMMENTS,'
      '       NULL CONTRACT_TYPE,'
      '       NULL DOP_STATUS,'
      '       NULL DEALER_KOD,'
      '       NULL RASSROCHKA,'
      '       NULL DISCONNECT_LIMIT,'
      '       NULL OPTION_GROUP_ID, '
      '       NULL OPTION_GROUP_NAME, '
      '       NULL MN_ROAMING'
      '  FROM DUAL')
    Left = 528
    Top = 504
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qPassword: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'UPDATE CONTRACTS SET USER_PASSWORD=:PASSWORD '
      '  WHERE CONTRACT_ID=:CONTRACT_ID')
    Left = 520
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PASSWORD'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qContractID: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CONTRACT_ID, CONTRACT_DATE'
      '  FROM CONTRACTS'
      
        '  WHERE (PHONE_NUMBER_CITY=:PHONE_NUMBER OR PHONE_NUMBER_FEDERAL' +
        '=:PHONE_NUMBER)'
      '  ORDER BY CONTRACT_DATE DESC')
    Left = 520
    Top = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qServiceCodes: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  SERVICE_CODE,'
      '  SERVICE_NAME'
      'FROM'
      '  DB_LOADER_SERVICE_TYPES')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 528
    Top = 449
  end
  object OraUpdateSQL1: TOraUpdateSQL
    Left = 520
    Top = 264
  end
  object qHBDetails: TOraQuery
    SQL.Strings = (
      'select c10.subscr_no as SELF_NUMBER,'
      'c10.call_date as SERVICE_DATE,'
      'c10.call_time as SERVICE_TIME,'
      '(select dl.SERVICE_NAME from DB_LOADER_SERVICE_TYPES dl'
      'where dl.service_code=c10.servicetype) as SERVICE_TYPE,'
      
        'decode(c10.servicedirection,1,'#39#1048#1089#1093#1086#1076#1103#1097#1080#1081#39',2,'#39#1042#1093#1086#1076#1103#1097#1080#1081#39',3,'#39#1087#1077#1088#1077#1072#1076 +
        #1088#1077#1089#1072#1094#1080#1103#39','#39#1053#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39') as SERVICE_DIRECTION,'
      
        'decode(c10.subscr_no,c10.calling_no,c10.dialed_dig,c10.calling_n' +
        'o) as OTHER_NUMBER,'
      'c10.dur as DURATION,'
      'case '
      '  when c10.dur<=2 then 0'
      '  else ceil(c10.dur/60)'
      'end DURATION_MIN,'
      'c10.call_cost as SERVICE_COST,'
      'decode(c10.isroaming,'#39'1'#39','#39#1044#1072#39','#39#39') as IS_ROAMING,'
      'c10.roamingzone as ROAMING_ZONE,'
      'substr(c10.at_ft_de,1,100) as ADD_INFO,'
      'TRIM( BOTH chr(13) FROM c10.cell_id) as BASE_STATION_CODE,'
      'c10.costnovat as COST_NO_VAT,'
      '(select bb.zone_name from BEELINE_BS_ZONES bb'
      
        'where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM c10.cell_id)' +
        ') as BS_PLACE,'
      
        'to_char(nvl(c10.insert_date,(select hbf.load_edate from hot_bill' +
        'ing_files hbf'
      
        'where hbf.hbf_id=c10.dbf_id)),'#39'dd.mm.yyyy hh24:mi:ss'#39') as INSERT' +
        '_DATE,'
      'hbf.file_name as SOURCE_FILE_NAME'
      ' from call_12_2012 c10'
      ' , HOT_BILLING_FILES hbf'
      'where c10.subscr_no = :subscr'
      'and c10.dbf_id = HBF.HBF_ID (+)'
      'order by c10.start_time')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 232
    Top = 800
    ParamData = <
      item
        DataType = ftString
        Name = 'subscr'
        ParamType = ptInput
        Value = '9670103222'
      end>
  end
  object dsDetail: TDataSource
    DataSet = vtDetailFile
    Left = 324
    Top = 793
  end
  object vtDetailFile: TVirtualTable
    FieldDefs = <
      item
        Name = 'SELF_NUMBER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVICE_DATE'
        DataType = ftDate
      end
      item
        Name = 'SERVICE_TIME'
        DataType = ftTime
      end
      item
        Name = 'SERVICE_TYPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVICE_DIRECTION'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'OTHER_NUMBER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DURATION'
        DataType = ftFloat
      end
      item
        Name = 'DURATION_MIN'
        DataType = ftInteger
      end
      item
        Name = 'SERVICE_COST'
        DataType = ftFloat
      end
      item
        Name = 'IS_ROAMING'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ROAMING_ZONE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ADD_INFO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'BASE_STATION_CODE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'COST_NO_VAT'
        DataType = ftFloat
      end
      item
        Name = 'BS_PLACE'
        DataType = ftString
        Size = 50
      end>
    Left = 612
    Top = 40
    Data = {
      03000F000B0053454C465F4E554D42455201001400000000000C005345525649
      43455F4441544509000000000000000C00534552564943455F54494D450A0000
      00000000000C00534552564943455F5459504501001400000000001100534552
      564943455F444952454354494F4E01001400000000000C004F544845525F4E55
      4D424552010014000000000008004455524154494F4E06000000000000000C00
      4455524154494F4E5F4D494E03000000000000000C00534552564943455F434F
      535406000000000000000A0049535F524F414D494E4701000500000000000C00
      524F414D494E475F5A4F4E45010032000000000008004144445F494E464F0100
      6400000000001100424153455F53544154494F4E5F434F444501000A00000000
      000B00434F53545F4E4F5F5641540600000000000000080042535F504C414345
      0100320000000000000000000000}
    object vtDetailFileSELF_NUMBER: TStringField
      FieldName = 'SELF_NUMBER'
    end
    object vtDetailFileSERVICE_DATE: TDateField
      FieldName = 'SERVICE_DATE'
    end
    object vtDetailFileSERVICE_TIME: TTimeField
      FieldName = 'SERVICE_TIME'
    end
    object vtDetailFileSERVICE_TYPE: TStringField
      FieldName = 'SERVICE_TYPE'
    end
    object vtDetailFileSERVICE_DIRECTION: TStringField
      FieldName = 'SERVICE_DIRECTION'
    end
    object vtDetailFileOTHER_NUMBER: TStringField
      FieldName = 'OTHER_NUMBER'
    end
    object vtDetailFileDURATION: TFloatField
      FieldName = 'DURATION'
    end
    object vtDetailFileDURATION_MIN: TIntegerField
      FieldName = 'DURATION_MIN'
    end
    object vtDetailFileSERVICE_COST: TFloatField
      FieldName = 'SERVICE_COST'
    end
    object vtDetailFileIS_ROAMING: TStringField
      FieldName = 'IS_ROAMING'
      Size = 5
    end
    object vtDetailFileROAMING_ZONE: TStringField
      FieldName = 'ROAMING_ZONE'
      Size = 50
    end
    object vtDetailFileADD_INFO: TStringField
      FieldName = 'ADD_INFO'
      Size = 100
    end
    object vtDetailFileBASE_STATION_CODE: TStringField
      FieldName = 'BASE_STATION_CODE'
      Size = 10
    end
    object vtDetailFileCOST_NO_VAT: TFloatField
      FieldName = 'COST_NO_VAT'
    end
    object vtDetailFileBS_PLACE: TStringField
      FieldName = 'BS_PLACE'
      Size = 50
    end
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 712
    Top = 40
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 712
    Top = 104
  end
  object dsApiTickets: TDataSource
    DataSet = oqApiTickets
    Left = 504
    Top = 32
  end
  object qRests: TOraQuery
    SQL.Strings = (
      'select '
      ' UNIT_TYPE'
      ' ,REST_TYPE'
      ' ,INITIAL_SIZE'
      ' ,CURR_VALUE'
      ' ,case '
      
        '    when (INITIAL_SIZE - CURR_VALUE) > INITIAL_SIZE then INITIAL' +
        '_SIZE'
      '    else'
      '      (INITIAL_SIZE - CURR_VALUE)'
      '   end SPENT'
      ' ,NEXT_VALUE'
      ' ,FREQUENCY '
      ' ,SOC       '
      ' ,SOC_NAME'
      ' ,REST_NAME  from table (TARIFF_RESTS_TABLE(:PHONE_NUMBER))')
    Left = 424
    Top = 720
    ParamData = <
      item
        DataType = ftString
        Name = 'PHONE_NUMBER'
      end>
    object qRestsUNIT_TYPE: TStringField
      FieldName = 'UNIT_TYPE'
      Size = 200
    end
    object qRestsREST_TYPE: TStringField
      FieldName = 'REST_TYPE'
      Size = 200
    end
    object qRestsINITIAL_SIZE: TFloatField
      FieldName = 'INITIAL_SIZE'
    end
    object qRestsCURR_VALUE: TFloatField
      FieldName = 'CURR_VALUE'
    end
    object qRestsSPENT: TFloatField
      FieldName = 'SPENT'
    end
    object qRestsNEXT_VALUE: TFloatField
      FieldName = 'NEXT_VALUE'
    end
    object qRestsFREQUENCY: TStringField
      FieldName = 'FREQUENCY'
      Size = 64
    end
    object qRestsSOC: TStringField
      FieldName = 'SOC'
      Size = 64
    end
    object qRestsSOC_NAME: TStringField
      FieldName = 'SOC_NAME'
      Size = 4096
    end
    object qRestsREST_NAME: TStringField
      FieldName = 'REST_NAME'
      Size = 8192
    end
  end
  object dsRests: TDataSource
    DataSet = qRests
    Left = 512
    Top = 720
  end
  object PUpdateSIM: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.phone_SIM'
    SQL.Strings = (
      'begin'
      '  :RESULT := BEELINE_API_PCKG.phone_SIM(:PPHONE_NUMBER);'
      'end;')
    Left = 824
    Top = 400
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.phone_SIM'
  end
end
