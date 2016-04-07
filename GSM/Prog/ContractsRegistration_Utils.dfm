object dmUtils: TdmUtils
  OldCreateOrder = False
  Height = 387
  Width = 665
  object qDefaultCountry: TOraQuery
    SQL.Strings = (
      'SELECT COUNTRY_ID'
      'FROM COUNTRIES'
      'WHERE IS_DEFAULT = 1')
    Left = 40
    Top = 17
  end
  object qDefaultregion: TOraQuery
    SQL.Strings = (
      'SELECT REGION_ID'
      'FROM REGIONS'
      'WHERE IS_DEFAULT = 1')
    Left = 40
    Top = 67
  end
  object qFreeValue: TOraStoredProc
    StoredProcName = 'FREE_CONTRACT_NUMBER'
    Left = 152
    Top = 16
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PCONTRACT_NUM'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'FREE_CONTRACT_NUMBER:0'
  end
  object qGetNextNum: TOraStoredProc
    StoredProcName = 'GET_NEXT_CONTRACT_NUMBER'
    Left = 152
    Top = 64
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'GET_NEXT_CONTRACT_NUMBER:0'
  end
  object qDefaultFilial: TOraQuery
    SQL.Strings = (
      'SELECT UN.FILIAL_ID '
      'FROM USER_NAMES UN'
      'WHERE UPPER(TRIM(UN.USER_NAME)) = USER'
      'ORDER BY DATE_LAST_UPDATED DESC')
    Left = 256
    Top = 16
  end
  object qContract: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  CONTRACTS.ABONENT_ID,'
      '  CONTRACTS.PHONE_NUMBER_FEDERAL,'
      '  CONTRACTS.CONTRACT_ID'
      'FROM'
      '  V_CONTRACTS CONTRACTS'
      'WHERE'
      
        '  ((:CONTRACT_ID IS NULL) OR (CONTRACTS.CONTRACT_ID=:CONTRACT_ID' +
        '))'
      '  AND '
      
        '  ((:PHONE_NUMBER IS NULL) OR (CONTRACTS.PHONE_NUMBER_FEDERAL=:P' +
        'HONE_NUMBER))'
      '  AND '
      '  ((:CONTRACT_NUM=0) OR (CONTRACTS.CONTRACT_NUM=:CONTRACT_NUM))')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 256
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_NUM'
      end>
  end
  object qGetConstant: TOraStoredProc
    StoredProcName = 'MS_CONSTANTS.GET_CONSTANT_VALUE'
    Left = 152
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'CONSTANT_NAME'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'MS_CONSTANTS.GET_CONSTANT_VALUE'
  end
end
