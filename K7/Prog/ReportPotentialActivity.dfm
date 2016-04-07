inherited ReportPotencialActivityFrm: TReportPotencialActivityFrm
  Caption = #1054#1090#1095#1077#1090' "'#1055#1086#1090#1077#1085#1094#1080#1072#1083#1100#1085#1072#1103' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100' '#1072#1073#1086#1085#1077#1085#1090#1086#1074'"'
  ClientHeight = 523
  ClientWidth = 1083
  Position = poScreenCenter
  OnCreate = FormCreate
  ExplicitWidth = 1099
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 1083
    Height = 97
    ExplicitWidth = 1083
    ExplicitHeight = 97
    object lbl1: TLabel [0]
      Left = 316
      Top = 8
      Width = 107
      Height = 13
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lAccount: TLabel [1]
      Left = 8
      Top = 8
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRefresh: TBitBtn
      Left = 316
      Top = 35
      ExplicitLeft = 316
      ExplicitTop = 35
    end
    inherited btLoadInExcel: TBitBtn
      Left = 427
      Top = 35
      ExplicitLeft = 427
      ExplicitTop = 35
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 568
      Top = 35
      TabOrder = 5
      ExplicitLeft = 568
      ExplicitTop = 35
    end
    object cbAccounts: TComboBox
      Left = 591
      Top = 5
      Width = 174
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = #1042#1089#1077' '#1089#1095#1077#1090#1072
      Items.Strings = (
        #1042#1089#1077' '#1089#1095#1077#1090#1072
        #1050#1086#1083#1083#1077#1082#1090#1086#1088
        #1050#1088#1086#1084#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072)
    end
    object cbYearMonth: TComboBox
      Left = 440
      Top = 5
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object CLB_Accounts: TsCheckListBox
      Left = 68
      Top = 4
      Width = 242
      Height = 88
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnExit = CLB_AccountsExit
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      OnClickCheck = CLB_AccountsClickCheck
    end
  end
  inherited pGrid: TPanel
    Top = 97
    Width = 1083
    Height = 426
    ExplicitTop = 97
    ExplicitWidth = 1083
    ExplicitHeight = 426
    inherited gReport: TCRDBGrid
      Width = 1081
      Height = 424
      ParentFont = False
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'COMPANY'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1087#1072#1085#1080#1103
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072'_'#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIF'
          Title.Alignment = taCenter
          Title.Caption = #1058#1072#1088#1080#1092
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_ACTIVE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOP_STATUS'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1089#1090#1072#1090#1091#1089#1072
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Width = 64
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select DAT.COMPANY_NAME as Company,'
      '        V.CONTRACT_DATE as Contract_Date ,'
      '        v.phone_number_federal as Phone_number, '
      '        T.TARIFF_NAME as Tarif,'
      '        CASE '
      '          WHEN dat.PHONE_IS_ACTIVE = 1 THEN  '#39#1040#1082#1090#1080#1074#1077#1085#39
      '          ELSE '#39#1053#1077#1072#1082#1090#1080#1074#1077#1085#39
      '        END as Is_Active,'
      '        DOS_S.DOP_STATUS_NAME as Dop_status,'
      '        dat.LAST_CHANGE_STATUS_DATE as Status_date,'
      '        GET_ABONENT_BALANCE(v.phone_number_federal) as Balance,'
      '        kol.kol as Block_in_month,'
      
        '        GET_AVERAGE_PAYMENT(v.phone_number_federal,to_date('#39'01.'#39 +
        '||to_char(sysdate,'#39'mm.yyyy'#39'),'#39'dd.mm.yyyy'#39'),sysdate) as Avg_pay_i' +
        'n_mon'
      '  FROM V_CONTRACTS V,'
      '        tariffs t,'
      '        CONTRACT_DOP_STATUSES dos_s,'
      
        '        (select d.phone_number, d.m_date, db.PHONE_IS_ACTIVE,DB.' +
        'LAST_CHANGE_STATUS_DATE, AC.COMPANY_NAME'
      '         from DB_LOADER_ACCOUNT_PHONES db,'
      '              accounts ac,'
      
        '        (select PHONE_NUMBER, max(year_month) as m_date from DB_' +
        'LOADER_ACCOUNT_PHONES group by PHONE_NUMBER) d'
      '         where  d.phone_number = DB.PHONE_NUMBER'
      '                and d.m_date = DB.YEAR_MONTH'
      '                and DB.ACCOUNT_ID = AC.ACCOUNT_ID ) dat,'
      '        (select phone_number, count(phone_number) as kol'
      
        '        from db_loader_account_phone_hists where phone_is_active' +
        ' = 0'
      '        group by phone_number) kol'
      'where'
      ' V.TARIFF_ID = T.TARIFF_ID(+) '
      ' and V.CONTRACT_CANCEL_DATE is null '
      ' and V.CONTRACT_CANCEL_DATE is null '
      ' and V.PHONE_NUMBER_FEDERAL = DAT.PHONE_NUMBER(+) '
      ' and V.PHONE_NUMBER_FEDERAL = kol.phone_number(+) '
      ' and V.DOP_STATUS = DOS_S.DOP_STATUS_ID(+)'
      
        ' and (v.contract_date>=:DATE_BEGIN and v.contract_date<=:DATE_EN' +
        'D )')
    Left = 104
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATE_BEGIN'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_END'
      end>
  end
  inherited dsReport: TDataSource
    Left = 200
    Top = 64
  end
  inherited aList: TActionList
    Left = 32
    Top = 304
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qReportTemplate: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select'
      '  DAT.COMPANY_NAME as Company,'
      '  t.CONTRACT_DATE as Contract_Date ,'
      '  t.phone_number, '
      '  Tar.TARIFF_NAME as Tarif,'
      '  CASE '
      '    WHEN dat.PHONE_IS_ACTIVE = 1 THEN  '#39#1040#1082#1090#1080#1074#1077#1085#39' '
      '  ELSE'
      '    '#39#1041#1083#1086#1082#1080#1088#1086#1074#1072#1085#39' '
      '          '
      '  END as Is_Active,'
      '  DOS_S.DOP_STATUS_NAME as Dop_status,'
      '  dat.LAST_CHANGE_STATUS_DATE as Status_date,'
      '  GET_ABONENT_BALANCE(t.phone_number) as Balance'
      '  %SELECT_STATMENT%   '
      'from'
      '    '
      '  ('
      '    select'
      '      V.PHONE_NUMBER_FEDERAL Phone_number,'
      '      V.CONTRACT_DATE,'
      '      v.dop_status'
      '    from'
      '      v_contracts V'
      '    where'
      '      v.CONTRACT_CANCEL_DATE is null'
      '    union all'
      '    --'#1088#1072#1089#1090#1086#1088#1078#1077#1085#1085#1099#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
      '    select'
      '      cancel_contracts.PHONE_NUMBER_FEDERAL Phone_number,'
      '      null,'
      '      null'
      
        '                                                                ' +
        '                '
      '    from'
      '      ('
      '        select'
      '          distinct PHONE_NUMBER_FEDERAL'
      '        from'
      '          v_contracts c'
      '        where'
      '          C.CONTRACT_CANCEL_DATE is not null'
      '        and not exists ('
      '                        select 1'
      '                        from'
      '                          V_ACTIVE_CONTRACTS va'
      '                        where'
      
        '                          VA.PHONE_NUMBER_FEDERAL = C.PHONE_NUMB' +
        'ER_FEDERAL'
      '                      )'
      '      ) cancel_contracts'
      '  )t,'
      ''
      '  tariffs tar,'
      '  CONTRACT_DOP_STATUSES dos_s,'
      '  ('
      '    select'
      '      d.phone_number,'
      '      d.m_date,'
      '      db.PHONE_IS_ACTIVE,'
      '      DB.LAST_CHANGE_STATUS_DATE,'
      '      AC.COMPANY_NAME,'
      '      ac.account_id,'
      '      ac.IS_COLLECTOR'
      '    from'
      '      DB_LOADER_ACCOUNT_PHONES db,'
      '      accounts ac,'
      '     ('
      '      select'
      '        PHONE_NUMBER,'
      '        max(year_month) as m_date'
      '      from'
      '        DB_LOADER_ACCOUNT_PHONES'
      '      group by PHONE_NUMBER'
      '     ) d'
      '    where'
      '      d.phone_number = DB.PHONE_NUMBER'
      '      and d.m_date = DB.YEAR_MONTH'
      '      and DB.ACCOUNT_ID = AC.ACCOUNT_ID '
      '   ) dat'
      'where '
      '   '
      '  GET_CURR_PHONE_TARIFF_ID(t.Phone_number) = Tar.TARIFF_ID(+) '
      '  '
      '  and t.PHONE_NUMBER = DAT.PHONE_NUMBER(+) '
      '  and t.DOP_STATUS = DOS_S.DOP_STATUS_ID(+)'
      
        '  and (nvl(DAT.IS_COLLECTOR, 0) = :P_IS_COLLECTOR OR :P_IS_COLLE' +
        'CTOR IS NULL)  '
      ''
      '  %WHERE_STATMENT%')
    Left = 192
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'P_IS_COLLECTOR'
      end>
  end
  object qYearMonth: TOraQuery
    SQL.Strings = (
      'select '
      ' distinct year_month'
      ' from DB_LOADER_ACCOUNT_PHONES'
      'order by year_month desc')
    Left = 304
    Top = 80
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, '
      
        '       decode(COMPANY_NAME,null,login, login||'#39' : '#39'||COMPANY_NAM' +
        'E) login,'
      '       COMPANY_NAME'
      'FROM ACCOUNTS '
      'ORDER BY 2 ASC')
    Left = 264
    Top = 184
  end
end
