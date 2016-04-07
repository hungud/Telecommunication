object RepPhoneWhisContractfrm: TRepPhoneWhisContractfrm
  Left = 0
  Top = 0
  Caption = ' '#1054#1090#1095#1077#1090' 7.8 '#1089' '#1091#1089#1083#1091#1075#1072#1084#1080' ('#1053#1086#1084#1077#1088#1072' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1086#1084')'
  ClientHeight = 521
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1015
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 370
      Top = 10
      Width = 43
      Height = 13
      Caption = #1059#1089#1083#1091#1075#1080':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbSearch: TCheckBox
      Left = 538
      Top = 8
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cbSearchClick
    end
    object BitBtn3: TBitBtn
      Left = 253
      Top = 3
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 147
      Top = 3
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 11
      Top = 3
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cbShowOpt: TComboBox
      Left = 426
      Top = 5
      Width = 101
      Height = 21
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 4
      Text = #1040#1082#1090#1080#1074#1085#1099#1077
      OnChange = cbShowOptChange
      Items.Strings = (
        #1042#1089#1077
        #1054#1090#1082#1083#1102#1095#1077#1085#1085#1099#1077
        #1040#1082#1090#1080#1074#1085#1099#1077)
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 33
    Width = 1015
    Height = 488
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
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
        FieldName = 'PHONE_NUMBER_FEDERAL'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1072#1088#1080#1092
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 156
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_CODE'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_IS_ACTIVE'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPTION_CODE'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076' '#1091#1089#1083#1091#1075#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPTION_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Title.Caption = 'C'#1090#1072#1090#1091#1089' '#1091#1089#1083#1091#1075#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURN_ON_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURN_OFF_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 184
    Top = 128
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = BitBtn1Click
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = BitBtn2Click
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = BitBtn3Click
    end
  end
  object qreport: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select t.PHONE_NUMBER_FEDERAL,'
      '       t.TARIFF_NAME, '
      ' CASE WHEN t.phone_is_active_code = 0 '
      
        '      THEN CASE WHEN T.PHONE_CONSERVATION=1 THEN '#39#1057#1086#1093#1088'.'#39' ELSE '#39#1041 +
        #1083#1086#1082'.'#39' END  ELSE '#39#1040#1082#1090'.'#39' '
      ' END AS phone_is_active,'
      '      t.OPTION_CODE,'
      '      t.OPTION_NAME,     '
      
        ' CASE when ( t.TURN_OFF_DATE is not null and t.TURN_OFF_DATE <sy' +
        'sdate)  '
      '      then '#39#1053#1077#1090#39'   '
      '      else '#39#1040#1082#1090#1080#1074#1085#1072#39'        '
      ' end as status,'
      '       t.TURN_ON_DATE,'
      '       t.TURN_OFF_DATE,'
      '       t.CONTRACT_NUM,'
      '       t.TARIFF_CODE'
      '      '
      '     '
      '     from (    '
      '            select c.PHONE_NUMBER_FEDERAL,'
      '                   DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,'
      '                   DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME,'
      '                   DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,'
      '                   DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE,'
      '                   TARIFFS.TARIFF_NAME,'
      '                   C.CONTRACT_NUM,'
      '                   TARIFFS.TARIFF_CODE,                '
      
        '     (SELECT db_loader_account_phones.phone_is_active  FROM db_l' +
        'oader_account_phones'
      
        '                   WHERE db_loader_account_phones.phone_number =' +
        ' c.phone_number_federal'
      
        '                    AND ROWNUM<=1 AND (db_loader_account_phones.' +
        'year_month =  '
      '                        (SELECT MAX (t2.year_month) '
      '                         FROM db_loader_account_phones t2 '
      
        '                          WHERE t2.phone_number = c.phone_number' +
        '_federal))) AS phone_is_active_code,'
      '    (SELECT db_loader_account_phones.CONSERVATION  '
      '                FROM db_loader_account_phones '
      
        '                 WHERE db_loader_account_phones.phone_number = c' +
        '.phone_number_federal '
      '                                   AND ROWNUM<=1  '
      '                AND (db_loader_account_phones.year_month = '
      '                       (SELECT MAX (t2.year_month) '
      '                          FROM db_loader_account_phones t2  '
      
        '                          WHERE t2.phone_number = c.phone_number' +
        '_federal))) AS PHONE_CONSERVATION,'
      
        '                 (SELECT TRUNC (MAX (db_loader_account_phone_his' +
        'ts.begin_date)) '
      '  FROM db_loader_account_phone_hists '
      
        '                   WHERE db_loader_account_phone_hists.phone_num' +
        'ber = c.phone_number_federal) AS status_date '
      
        '                   from v_contracts c, DB_LOADER_ACCOUNT_PHONE_O' +
        'PTS, tariffs '
      
        '                   where (c.CONTRACT_CANCEL_DATE is null or c.CO' +
        'NTRACT_CANCEL_DATE>=trunc(sysdate))'
      
        '                        and  c.PHONE_NUMBER_FEDERAL = DB_LOADER_' +
        'ACCOUNT_PHONE_OPTS.PHONE_NUMBER(+)'
      
        '                        AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MO' +
        'NTH = to_number(to_char(sysdate, '#39'yyyymm'#39'))'
      '                        and C.TARIFF_ID =  TARIFFS.TARIFF_ID'
      '                        and '
      '                        ('
      '                          --'#1090#1086#1083#1100#1082#1086' '#1076#1077#1081#1089#1090#1091#1102#1097#1080#1077' '#1091#1089#1083#1091#1075#1080
      
        '                          (:SHOW_ACTIVE_OPT = 2 AND   (DB_LOADER' +
        '_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE is null OR DB_LOADER_ACCOUNT_P' +
        'HONE_OPTS.TURN_OFF_DATE > sysdate))'
      '                          OR'
      '                          --'#1090#1086#1083#1100#1082#1086' '#1086#1090#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1091#1089#1083#1091#1075#1080
      
        '                          (:SHOW_ACTIVE_OPT = 1 AND  DB_LOADER_A' +
        'CCOUNT_PHONE_OPTS.TURN_OFF_DATE is not null and DB_LOADER_ACCOUN' +
        'T_PHONE_OPTS.TURN_OFF_DATE <sysdate)'
      '                          OR'
      '                          --'#1042#1089#1077' '#1091#1089#1083#1091#1075#1080
      '                          (:SHOW_ACTIVE_OPT = 0)'
      '                        )'
      '                        ) t')
    Left = 128
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SHOW_ACTIVE_OPT'
      end>
    object qreportPHONE_NUMBER_FEDERAL: TStringField
      FieldName = 'PHONE_NUMBER_FEDERAL'
      Size = 40
    end
    object qreportTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qreportPHONE_IS_ACTIVE: TStringField
      FieldName = 'PHONE_IS_ACTIVE'
      Size = 9
    end
    object qreportOPTION_CODE: TStringField
      FieldName = 'OPTION_CODE'
      Size = 120
    end
    object qreportOPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Size = 800
    end
    object qreportSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 14
    end
    object qreportTURN_ON_DATE: TDateTimeField
      FieldName = 'TURN_ON_DATE'
    end
    object qreportTURN_OFF_DATE: TDateTimeField
      FieldName = 'TURN_OFF_DATE'
    end
    object qreportCONTRACT_NUM: TFloatField
      FieldName = 'CONTRACT_NUM'
    end
    object qreportTARIFF_CODE: TStringField
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
  end
  object dsReport: TDataSource
    DataSet = qreport
    Left = 112
    Top = 136
  end
end
