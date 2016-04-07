object fReportMNRoaming: TfReportMNRoaming
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' "'#1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075'"'
  ClientHeight = 318
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 888
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lPeriod: TLabel
      Left = 7
      Top = 8
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 420
      Top = 2
      Width = 133
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btRefresh: TBitBtn
      Left = 310
      Top = 2
      Width = 108
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btInfoAbonent: TBitBtn
      Left = 559
      Top = 4
      Width = 89
      Height = 25
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cbPeriod: TComboBox
      Left = 55
      Top = 5
      Width = 98
      Height = 21
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 0
    end
    object cbAccounts: TComboBox
      Left = 159
      Top = 5
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = #1042#1089#1077
      Items.Strings = (
        #1042#1089#1077
        #1050#1086#1083#1083#1077#1082#1090#1086#1088
        #1050#1088#1086#1084#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072)
    end
  end
  object GridReport: TCRDBGrid
    Left = 0
    Top = 33
    Width = 888
    Height = 285
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'SUBSCR_NO'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROV_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1056#1086#1091#1084#1080#1085#1075' '#1087#1072#1088#1090#1085#1077#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_CALL'
        Title.Alignment = taCenter
        Title.Caption = #1047#1074#1086#1085#1082#1080', '#1088#1091#1073'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_SMS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1052#1057', '#1088#1091#1073'.'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_MMS'
        Title.Alignment = taCenter
        Title.Caption = #1052#1052#1057', '#1088#1091#1073'.'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_INTERNET'
        Title.Alignment = taCenter
        Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090', '#1088#1091#1073'.'
        Width = 128
        Visible = True
      end>
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'select '
      '  SUBSCR_NO,'
      '  PROV_NAME,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'C'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_call,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'S'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_sms,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'U'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_mms,'
      '  sum('
      '      case'
      '        when SERVICETYPE in ('#39'G'#39','#39'W'#39') then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_internet   '
      ''
      'from '
      '    '
      '('
      'select'
      '  C.SUBSCR_NO,'
      '  nvl(RP.DAMPS_PROV_NAME, C.ROAMING_PROVIDER_ID) PROV_NAME,'
      '  C.SERVICETYPE,'
      '  call_cost'
      '  '
      'from call_06_2015 c,'
      '     ROAMING_PROVIDERS rp'
      'where call_cost <> 0'
      'and '
      '  exists ('
      '         select 1 '
      '         from'
      '           DB_LOADER_ACCOUNT_PHONES'
      '         where'
      '           year_month = :year_month'
      '           and phone_number =  SUBSCR_NO '
      '           and('
      '               :is_collector = -1 OR  account_id in '
      '                             ('
      '                              select'
      '                                account_id'
      '                              from'
      '                                accounts'
      '                              where'
      
        '                                nvl(is_collector, 0) = :is_colle' +
        'ctor'
      '                             )'
      '           )'
      '         )'
      '  and RP.ROAMING_TYPE_ID = 0'
      '  and RP.ROAMING_PROVIDER_ID = C.ROAMING_PROVIDER_ID'
      '    '
      ')  '
      'group by  SUBSCR_NO, PROV_NAME'
      'order by SUBSCR_NO, PROV_NAME')
    FetchRows = 250
    FetchAll = True
    Left = 80
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'is_collector'
      end>
    object qReportSUBSCR_NO: TStringField
      FieldName = 'SUBSCR_NO'
      Size = 11
    end
    object qReportPROV_NAME: TStringField
      FieldName = 'PROV_NAME'
      Size = 150
    end
    object qReportSUM_CALL: TFloatField
      FieldName = 'SUM_CALL'
    end
    object qReportSUM_SMS: TFloatField
      FieldName = 'SUM_SMS'
    end
    object qReportSUM_MMS: TFloatField
      FieldName = 'SUM_MMS'
    end
    object qReportSUM_INTERNET: TFloatField
      FieldName = 'SUM_INTERNET'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 144
    Top = 80
  end
  object alReport: TActionList
    Images = MainForm.ImageList24
    Left = 296
    Top = 104
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qReportTemplate: TOraQuery
    SQL.Strings = (
      'select '
      '  SUBSCR_NO,'
      '  PROV_NAME,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'C'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_call,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'S'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_sms,'
      '  sum('
      '      case SERVICETYPE'
      '        when '#39'U'#39' then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_mms,'
      '  sum('
      '      case'
      '        when SERVICETYPE in ('#39'G'#39','#39'W'#39') then call_cost'
      '      else'
      '        0'
      '      end'
      '    ) sum_internet   '
      ''
      'from '
      '    '
      '('
      'select'
      '  C.SUBSCR_NO,'
      '  nvl(RP.DAMPS_PROV_NAME, C.ROAMING_PROVIDER_ID) PROV_NAME,'
      '  C.SERVICETYPE,'
      '  call_cost'
      '  '
      'from call_%MM_YYYY% c,'
      '     ROAMING_PROVIDERS rp'
      'where call_cost <> 0'
      'and '
      '  exists ('
      '         select 1 '
      '         from'
      '           DB_LOADER_ACCOUNT_PHONES'
      '         where'
      '           year_month = :year_month'
      '           and phone_number =  SUBSCR_NO '
      '           and('
      '               :is_collector = -1 OR  account_id in '
      '                             ('
      '                              select'
      '                                account_id'
      '                              from'
      '                                accounts'
      '                              where'
      
        '                                nvl(is_collector, 0) = :is_colle' +
        'ctor'
      '                             )'
      '           )'
      '         )'
      '  and RP.ROAMING_TYPE_ID = 0'
      '  and RP.ROAMING_PROVIDER_ID = C.ROAMING_PROVIDER_ID'
      '    '
      ')  '
      'group by  SUBSCR_NO, PROV_NAME'
      'order by SUBSCR_NO, PROV_NAME')
    Left = 88
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'year_month'
      end
      item
        DataType = ftUnknown
        Name = 'is_collector'
      end>
  end
  object qPeriod: TOraQuery
    SQL.Strings = (
      'select'
      '  distinct to_char(the_day, '#39'yyyymm'#39') yyyymm from v_calendar'
      'where '
      
        '  the_day >= to_date('#39'201506'#39', '#39'yyyymm'#39') and --'#1079#1072#1075#1088#1091#1079#1082#1091' '#1087#1088#1086#1074#1072#1081#1076#1077 +
        #1088#1072' '#1085#1072#1095#1072#1083#1080' '#1080#1084#1077#1085#1085#1086' '#1089' '#1080#1102#1083#1103' 2015'
      '  the_day <= sysdate'
      'order by to_char(the_day, '#39'yyyymm'#39') desc')
    Left = 306
    Top = 173
  end
end
