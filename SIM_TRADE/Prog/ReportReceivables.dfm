inherited ReportReceivablesForm: TReportReceivablesForm
  Caption = #1044#1077#1073#1080#1090#1086#1088#1089#1082#1072#1103' '#1079#1072#1076#1086#1083#1078#1077#1085#1085#1086#1089#1090#1100' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084
  ClientWidth = 992
  Position = poScreenCenter
  ExplicitWidth = 1008
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 992
    ExplicitWidth = 992
    object lAccount: TLabel [0]
      Left = 8
      Top = 9
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 184
      Top = 9
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRefresh: TBitBtn
      Left = 343
      ExplicitLeft = 343
    end
    inherited btLoadInExcel: TBitBtn
      Left = 447
      ExplicitLeft = 447
    end
    object cbAccounts: TComboBox
      Left = 76
      Top = 4
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbAccountsChange
    end
    object cbPeriod: TComboBox
      Left = 238
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object BitBtn3: TBitBtn
      Left = 581
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000FF00FF00FF00
        FF00FBFBFB00F4F4F400EEEEEE00E8E8E800E5E5E500E0E0E000DEDEDE00DFDF
        DF00DFDFDF00DFDFDF00DEDEDE00DFDFDF00DEDEDE00DFDFDF00E1E1E100E6E6
        E600EAEAEA00EFEFEF00F5F5F500FDFDFD00FF00FF00FF00FF00FF00FF00FF00
        FF00E5E5E500C8C8C800BCBCBC00B3B1AB00ADA18800B09B7000B4996100B897
        5500BB974E00BC974A00BC974B00BB974F00B7975800B29A6700AF9E7D00AFAA
        A000AAB2B700BDBDBE00CBCBCB00EFEFEF00FF00FF00FF00FF00FF00FF00FF00
        FF00FFFFFE00E4DDD000C1AB7D00B38E3F00B68F3F00BA924200BD954500BF97
        4700C1984900C2994A00C1994A00C1984900BF974700BC954500B99242005B8D
        8F000189DE00A2C4D600FCFCFC00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00CBB58300AD873600B18B3A00B68E3F00B9924100BD954500C0984900C39A
        4A00C69C4C00C79D4D00C79D4E00C69C4C00C39A4B00C0984800BD9545005590
        9900008EE1005E8C8700BD9F5E00F1EBDE00FF00FF00FF00FF00FF00FF00FF00
        FF00BD9F5F00AF893800B48D3C00B8914100BC944400C0984800C49B4C00C89E
        4E00CBA05000CCA15100CCA15200CBA05000C89E4F00C49B4B00C0984700B894
        480087916B00B28D3D00AF893900C8AF7A00FF00FF00FF00FF00FF00FF00FF00
        FF00CDB78600B18A3A00B58E3E00BA924300BE964700C39A4B00C89E4F00CCA1
        5200CFA45500D1A55700D1A55700CFA45500CCA15200C89E4F00C39A4B006898
        91000198E7008A906600B18A3A00CAB27D00FF00FF00FF00FF00FF00FF00FF00
        FF00F1EADC00B48E3F00B78F3F00BB944400C0984700C59C4C00CAA05100CFA4
        5400D3A75700D5A95A00D5A95B00D3A75700CFA35500CAA05000C59C4B00659B
        9600009DEB004698A700B28C3D00E7DBC300FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00E2D3B200BC974B00BC944500C1984800C69C4C00CBA15200D0A5
        5500D5A95A00D9AD5D00D9AD5E00D5A95900D0A55600CBA15100C69C4C00AA99
        5C000CA1E20000A2ED0069B1C000FEFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00ECE2CC00C7A66100C1994B00C69C4D00CBA05200D3AA
        5D00E5BF7900EFC98400EEC88300E4BD7700D2A95C00CBA05100C69C4D00C199
        4A009DA37A001BAEEE0001A7F1006FCDF700FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FBF8F300DCC69900C8A15400E5C17E00FDD7
        9800FBD59800EFD4A500EFD4A600FAD59900F0D59C0043ACC50079A38E00D6C1
        9200F7F5EE00DCF2FA000DB0F50001ACF400CEEFFD00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FBF4E800FBE0B500D9D5
        C500C3DAED00C4DDF300C4DDF300C3DAEE00ADCFD50008B3F7001BB7F200F9FC
        FD00FF00FF00FF00FF0033C1F80003B1F700B0E7FC00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FEFEFE00C7DF
        F400BAD8F100BAD8F100BAD8F100BAD8F100CCE8F80048C9FA0000B5F90056CF
        FC00B8EBFE007EDAFC0002B6F9001FBEF900E7F8FE00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E2EE
        F900B5D5F000D0E4F500CFE4F500B6D6F000FBFDFE00E2F7FE0055CFFC0016BF
        FC0003BAFC000DBDFC0034C7FB00BCECFD00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EEF5
        FB00D8E8F700DCEBF800DCEBF800D8E8F700F8FBFE00FF00FF00FEFFFF00D5F4
        FE00C0EEFE00C9F0FE00F6FCFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FDFDFE00D3E6
        F600CEE3F500CEE3F500CEE3F500CEE3F500D5E7F600FEFEFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7F1FA00C0DB
        F200C0DBF200C0DBF200C0DBF200C0DBF200C0DBF200E2E8EF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5CDE300B2D4
        F000B2D4F000B2D4F000B2D4F000B2D4F000B2D4F0008295A900FCFCFC00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D3D7DE0093B7D800A5CC
        ED00A5CCED00A5CCED00A5CCED00A5CCED00A5CCED00667D9700BFC2C800FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008E98AA0084ABD20097C3
        EA0097C3EA0097C3EA0097C3EA0097C3EA0092BCE4003E4E690081869300FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006A778E005573980087B8
        E40089BBE8007DA8D3005E7B9F00526C8E003A4A66002B354C005F687800FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0074809400314464004258
        7A006184AD0032405A002C384F002C384F002C384F002C384F00636B7C00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C5C9D100334361002C39
        53002B354C002C3851002D3952002C3851002D3952002D3951009EA3AE00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AAB1BB003843
        5A002B364D002D3A54002D3B55002D3A5400323F570080879600FCFCFC00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E4E5
        E8009A9FAA0068728500616B7E0080899700CFD2D700FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object cbSearch: TCheckBox
      Left = 698
      Top = 7
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = cbSearchClick
    end
  end
  inherited pGrid: TPanel
    Width = 992
    ExplicitWidth = 992
    inherited gReport: TCRDBGrid
      Width = 990
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPANY_NAME'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 274
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 206
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEBIT_VAL'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMMENT_CLENT'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 160
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'SELECT '
      
        '   dt1.ACCOUNT_ID, AC.ACCOUNT_NUMBER, AC.COMPANY_NAME, dt1.PHONE' +
        '_NUMBER, '
      
        '   DECODE(NVL(dt1.DEBIT_LAST_MONTH, 0), 0, dt1.DEBITOR, DECODE(d' +
        't1.PLUSBALANCE, 1, dt1.DEBITOR, 0)) DEBIT_VAL,'
      '   dt1.BALANCE, st.COMMENT_CLENT'
      'FROM '
      ' (select'
      
        '    dt.ACCOUNT_ID, dt.YEAR_MONTH, dt.PHONE_NUMBER, dt.STATUS_ID,' +
        ' dt.LAST_CHANGE_STATUS_DATE, '
      
        '    dt.ABON_TP_OLD, dt.ABON_TP_NEW, dt.BALANCE, dt.DEBITOR, dt.P' +
        'LUSBALANCE,'
      '    --'#1086#1087#1088#1077#1076#1077#1083#1103#1077#1084' '#1073#1099#1083#1072' '#1083#1080' '#1091' '#1085#1086#1084#1077#1088#1072' '#1076#1077#1073#1080#1090#1086#1088#1082#1072' '#1074' '#1087#1088#1086#1096#1083#1086#1084' '#1084#1077#1089#1103#1094#1077
      '    (select max(YEAR_MONTH)'
      '     from'
      
        '     (SELECT accphVs.ACCOUNT_ID, accphVs.YEAR_MONTH, accphVs.PHO' +
        'NE_NUMBER,'
      '        accphVs.STATUS_ID, accphVs.LAST_CHANGE_STATUS_DATE,'
      '        --'#1073#1072#1083#1083#1072#1085#1089' '#1085#1072' '#1082#1086#1085#1077#1094' '#1084#1077#1089#1103#1094#1072
      '        (select bh.balance '
      '         from iot_balance_history bh '
      '         where bh.phone_number=accphVs.PHONE_NUMBER'
      '         and bh.last_update = (select max(bh.last_update)'
      
        '                                          from iot_balance_histo' +
        'ry bh '
      
        '                                          where bh.phone_number=' +
        'accphVs.PHONE_NUMBER'
      
        '                                          and to_number(to_char(' +
        'bh.last_update, '#39'YYYYMM'#39')) = accphVs.YEAR_MONTH)) BALANCE'
      '      FROM V_CONTRACTS conVs,'
      '               DB_LOADER_ACCOUNT_PHONES accphVs'
      
        '      WHERE ((conVs.CONTRACT_CANCEL_DATE is null) OR (conVs.CONT' +
        'RACT_CANCEL_DATE > to_date(sysdate)))'
      '      AND conVs.PHONE_NUMBER_FEDERAL = accphVs.PHONE_NUMBER(+)'
      '      AND accphVs.STATUS_ID in (29,37)'
      
        '      AND to_number(to_char(accphVs.LAST_CHANGE_STATUS_DATE, '#39'yy' +
        'yymm'#39')) = accphVs.YEAR_MONTH'
      '      AND accphVs.YEAR_MONTH < :pYEAR_MONTH) vs'
      '     WHERE vs.BALANCE < 0'
      '     AND vs.PHONE_NUMBER = dt.PHONE_NUMBER'
      
        '     AND vs.YEAR_MONTH = to_char(add_months(to_date(to_char(dt.Y' +
        'EAR_MONTH)||'#39'01'#39', '#39'YYYY.MM.DD'#39'), -1), '#39'YYYYMM'#39')) DEBIT_LAST_MONT' +
        'H'
      '  from'
      '  (select '
      
        '     deb.ACCOUNT_ID, deb.YEAR_MONTH, deb.PHONE_NUMBER, deb.STATU' +
        'S_ID, deb.LAST_CHANGE_STATUS_DATE,'
      
        '     deb.ABON_TP_OLD, deb.ABON_TP_NEW, deb.BALANCE, deb.PLUSBALA' +
        'NCE,'
      '     CASE'
      '       WHEN (deb.ABON_TP_OLD = 0) and (deb.ABON_TP_NEW = 0)'
      '       THEN ABS(deb.BALANCE)'
      
        '       ELSE DECODE(SIGN(deb.ABON_TP_OLD - (deb.ABON_TP_NEW + deb' +
        '.BALANCE)), 1, (deb.ABON_TP_OLD - (deb.ABON_TP_NEW + deb.BALANCE' +
        ')), 0) '
      '     END'
      '       DEBITOR   '
      '   from'
      '   (SELECT '
      
        '      accph.ACCOUNT_ID, accph.YEAR_MONTH, accph.PHONE_NUMBER, ac' +
        'cph.STATUS_ID,'
      '      accph.LAST_CHANGE_STATUS_DATE,'
      '      --'#1072#1073#1086#1085#1082#1072' '#1073#1080#1083#1072#1081#1085#1072
      '      NVL((select V.ABON_TP_OLD'
      '              from V_BILL_FINANCE_FOR_CLIENTS V'
      '              where V.PHONE_NUMBER = accph.PHONE_NUMBER'
      '              and V.YEAR_MONTH = accph.YEAR_MONTH'
      '              and V.ACCOUNT_ID = accph.ACCOUNT_ID'
      '              and ROWNUM = 1), 0) ABON_TP_OLD,'
      '      --'#1072#1073#1086#1085#1082#1072' '#1050'7'
      '      NVL((select V.ABON_TP_NEW'
      '              from V_BILL_FINANCE_FOR_CLIENTS V'
      '              where V.PHONE_NUMBER = accph.PHONE_NUMBER'
      '              and V.YEAR_MONTH = accph.YEAR_MONTH'
      '              and V.ACCOUNT_ID = accph.ACCOUNT_ID'
      '              and ROWNUM = 1), 0) ABON_TP_NEW,'
      '      --'#1073#1072#1083#1083#1072#1085#1089' '#1085#1072' '#1082#1086#1085#1077#1094' '#1084#1077#1089#1103#1094#1072
      '      (select bh.balance '
      '       from iot_balance_history bh '
      '       where bh.phone_number=accph.PHONE_NUMBER'
      '       and bh.last_update = (select max(bh.last_update)'
      
        '                                        from iot_balance_history' +
        ' bh '
      
        '                                        where bh.phone_number=ac' +
        'cph.PHONE_NUMBER'
      
        '                                        and to_number(to_char(bh' +
        '.last_update, '#39'YYYYMM'#39')) = accph.YEAR_MONTH)) BALANCE,'
      
        '      --'#1089#1082#1072#1095#1086#1082' '#1073#1072#1083#1083#1072#1085#1089#1072' '#1074' '#1090#1077#1095#1077#1085#1080#1080' '#1084#1077#1089#1103#1094#1072' '#1074' '#1087#1083#1102#1089' (1 - '#1073#1099#1083', 0 - '#1085#1077 +
        ' '#1073#1099#1083#1086' '#1087#1083#1102#1089#1086#1074#1086#1075#1086' '#1073#1072#1083#1083#1072#1085#1089#1072')'
      '      (select DECODE(count(bh.balance), 0, 0, 1) PlusBalance'
      '       from iot_balance_history bh '
      '       where bh.phone_number = accph.PHONE_NUMBER'
      
        '       and to_number(to_char(bh.last_update, '#39'YYYYMM'#39')) = accph.' +
        'YEAR_MONTH'
      '       and bh.balance > 0) PLUSBALANCE'
      '    FROM V_CONTRACTS con,'
      '             DB_LOADER_ACCOUNT_PHONES accph            '
      
        '    WHERE ((con.CONTRACT_CANCEL_DATE is null) OR (con.CONTRACT_C' +
        'ANCEL_DATE > to_date(sysdate)))'
      '    AND con.PHONE_NUMBER_FEDERAL = accph.PHONE_NUMBER(+)'
      '    AND accph.STATUS_ID in (29,37)'
      
        '    AND to_number(to_char(accph.LAST_CHANGE_STATUS_DATE, '#39'yyyymm' +
        #39')) = accph.YEAR_MONTH'
      '    AND accph.YEAR_MONTH = :pYEAR_MONTH) deb'
      '   WHERE deb.BALANCE < 0) dt) dt1'
      'LEFT JOIN ACCOUNTS ac ON ac.ACCOUNT_ID = dt1.ACCOUNT_ID'
      
        'LEFT JOIN BEELINE_STATUS_CODE st ON  dt1.STATUS_ID = st.STATUS_I' +
        'D'
      'WHERE ((:ACCOUNT_ID IS NULL) OR (dt1.ACCOUNT_ID=:ACCOUNT_ID))')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qReportACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
    end
    object qReportACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportCOMPANY_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1086#1084#1087#1072#1085#1080#1080
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportDEBIT_VAL: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090'. '#1079#1072#1076#1086#1083#1078#1077#1085#1085#1086#1089#1090#1100
      FieldName = 'DEBIT_VAL'
    end
    object qReportBALANCE: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1076#1086#1083#1075#1072
      FieldName = 'BALANCE'
    end
    object qReportCOMMENT_CLENT: TStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'COMMENT_CLENT'
      Size = 4000
    end
  end
  inherited aList: TActionList
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN '
      'FROM ACCOUNTS '
      'ORDER BY LOGIN ASC')
    Left = 216
    Top = 88
  end
  object qFastPeriods: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      
        '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100))|' +
        '| '#39' - '#39
      '       || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM DB_LOADER_ACCOUNT_PHONES'
      'WHERE YEAR_MONTH <= (SELECT MAX(YEAR_MONTH) '
      
        '                                       FROM V_BILL_FINANCE_FOR_C' +
        'LIENTS)'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    ReadOnly = True
    Left = 280
    Top = 88
  end
end
