object DM: TDM
  OldCreateOrder = False
  Height = 453
  Width = 777
  object qFormAccess: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'select * from FORM_ACCESS where upper(FORM_NAME)=upper(:FORM_NAM' +
        'E) AND '
      '('
      ' upper(USER_NAME)=upper(:USER_NAME) '
      
        ' or (RIGHTS_TYPE=:RIGHTS_TYPE AND nvl(CHECK_ALLOW_ACCOUNT,0)=nvl' +
        '(:CHECK_ALLOW_ACCOUNT,0) and nvl(CHECK_ALLOW_ACCOUNT,0)=nvl(:CHE' +
        'CK_ALLOW_ACCOUNT,0))'
      ')')
    Left = 48
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'FORM_NAME'
      end
      item
        DataType = ftUnknown
        Name = 'USER_NAME'
      end
      item
        DataType = ftInteger
        Name = 'RIGHTS_TYPE'
      end
      item
        DataType = ftInteger
        Name = 'CHECK_ALLOW_ACCOUNT'
      end>
  end
  object qMenuAccess: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select * from MENU_ACCESS where '
      '('
      ' upper(USER_NAME)=upper(:USER_NAME) '
      
        ' or (RIGHTS_TYPE=:RIGHTS_TYPE AND nvl(CHECK_ALLOW_ACCOUNT,0)=nvl' +
        '(:CHECK_ALLOW_ACCOUNT,0) and nvl(CHECK_ALLOW_ACCOUNT,0)=nvl(:CHE' +
        'CK_ALLOW_ACCOUNT,0))'
      ')')
    Left = 120
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USER_NAME'
      end
      item
        DataType = ftInteger
        Name = 'RIGHTS_TYPE'
      end
      item
        DataType = ftInteger
        Name = 'CHECK_ALLOW_ACCOUNT'
      end>
  end
  object qAccounts: TOraQuery
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, LOGIN, company_name FROM ACCOUNTS ORDER BY LO' +
        'GIN ASC')
    Left = 216
    Top = 24
  end
  object qPeriods: TOraQuery
    Left = 296
    Top = 24
  end
  object dsPeriods: TDataSource
    DataSet = qPeriods
    Left = 296
    Top = 80
  end
  object DS_Rep: TDataSource
    DataSet = qReport
    Left = 296
    Top = 136
  end
  object qReport: TOraQuery
    Left = 232
    Top = 136
  end
end
