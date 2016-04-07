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
    object cbAccounts: TComboBox [4]
      Left = 76
      Top = 4
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbAccountsChange
    end
    object cbPeriod: TComboBox [5]
      Left = 238
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox [6]
      Left = 722
      Top = 6
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cbSearchClick
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 581
      TabOrder = 5
      ExplicitLeft = 581
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
    inherited aShowUserStatInfo: TAction
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
