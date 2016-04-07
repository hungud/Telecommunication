inherited ReportControlTrafficPckgAllPhoneForm: TReportControlTrafficPckgAllPhoneForm
  Caption = #1054#1090#1095#1077#1090' '#1088#1072#1089#1093#1086#1076#1072' '#1090#1088#1072#1092#1080#1082#1072' '#1085#1072' '#1087#1072#1082#1077#1090#1072#1093' '#1087#1086' '#1074#1089#1077#1084' '#1085#1086#1084#1077#1088#1072#1084
  ClientHeight = 675
  ClientWidth = 1086
  Position = poScreenCenter
  ExplicitWidth = 1102
  ExplicitHeight = 713
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 209
    Width = 1086
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 29
    ExplicitWidth = 427
  end
  inherited pButtons: TPanel
    Width = 1086
    ExplicitWidth = 1086
    inherited btnShowUserStatInfo: TBitBtn
      Width = 142
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1073#1086#1085#1077#1085#1090#1072
      ExplicitWidth = 142
    end
    object BitBtn1: TBitBtn
      Left = 380
      Top = 0
      Width = 221
      Height = 29
      Action = aDetailInfo
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1086#1076#1088#1086#1073#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      TabOrder = 3
    end
  end
  inherited pGrid: TPanel
    Width = 1086
    Height = 180
    ExplicitWidth = 1086
    ExplicitHeight = 180
    inherited gReport: TCRDBGrid
      Width = 1084
      Height = 178
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      OnDblClick = gReportDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_FEDERAL'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076' '#1090#1077#1082'. '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1077#1082'. '#1090#1072#1088#1080#1092#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_ACTIVE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end>
    end
  end
  object pData: TPanel [3]
    Left = 0
    Top = 212
    Width = 1086
    Height = 463
    Align = alBottom
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 233
      Width = 1084
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 185
      ExplicitWidth = 277
    end
    object pPckgLog: TPanel
      Left = 1
      Top = 1
      Width = 1084
      Height = 232
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 1082
        Height = 13
        Align = alTop
        Caption = '  '#1048#1089#1090#1086#1088#1080#1103' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1087#1072#1082#1077#1090#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 194
      end
      object gPckgLog: TCRDBGrid
        Left = 1
        Top = 14
        Width = 1082
        Height = 217
        Align = alClient
        DataSource = dsPckgLog
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = gPckgLogDrawColumnCell
        OnDblClick = gPckgLogDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE'
            Title.Alignment = taCenter
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TURN_ON_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083'.'
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
            FieldName = 'PCKG_CODE'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1087#1072#1082#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNITTYPE'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087' '#1087#1072#1082#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_ON'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_OFF'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_ZERO'
            Title.Caption = #1057#1084#1089' '#1086' '#1088#1072#1089#1093#1086#1076#1077' '#1074' 0'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_PREV'
            Title.Alignment = taCenter
            Title.Caption = #1057#1084#1089' '#1086' '#1088#1072#1089#1093#1086#1076#1077' 80%'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PREDVALUE'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1098#1077#1084' '#1087#1088#1086#1075#1085#1086#1079'. '#1090#1088#1072#1092#1080#1082#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DO_NOT_REST'
            Title.Alignment = taCenter
            Title.Caption = #1053#1077' '#1074#1086#1079#1074#1088#1072#1090' '#1086#1089#1090#1072#1090#1082#1086#1074
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 130
            Visible = True
          end>
      end
    end
    object pPckgStat: TPanel
      Left = 1
      Top = 236
      Width = 1084
      Height = 226
      Align = alClient
      TabOrder = 1
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 1082
        Height = 13
        Align = alTop
        Caption = '  '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1088#1072#1089#1093#1086#1076#1072' '#1090#1088#1072#1092#1080#1082#1072' '#1085#1072' '#1087#1072#1082#1077#1090#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 241
      end
      object gPckgStat: TCRDBGrid
        Left = 1
        Top = 14
        Width = 1082
        Height = 211
        Align = alClient
        DataSource = dsPckgStat
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = gPckgStatDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE'
            Title.Alignment = taCenter
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PCKG_CODE'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1087#1072#1082#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNITTYPE'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087' '#1087#1072#1082#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INITVALUE'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1098#1077#1084' '#1085#1072#1095'. '#1090#1088#1072#1092#1080#1082#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 145
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CURRVALUE'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1098#1077#1084' '#1090#1077#1082'. '#1090#1088#1072#1092#1080#1082
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CURR_CHECK_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1087#1088#1086#1074#1077#1088#1082#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 141
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NEXT_CHECK_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1089#1083#1077#1076'. '#1087#1088#1086#1074#1077#1088#1082#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 140
            Visible = True
          end>
      end
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'SELECT'
      '    C.PHONE_NUMBER_FEDERAL,'
      '    C.CONTRACT_DATE,'
      '    TR.TARIFF_CODE,'
      '    TR.TARIFF_NAME,'
      '    ('
      '       select '
      '         case'
      '           when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '             case'
      '               when nvl(DB.CONSERVATION,0) = 1 then'
      '                 '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '               else '
      '                 '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '             end'
      '           else'
      '             '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '         end'
      '        from DB_LOADER_ACCOUNT_PHONES db'
      '       where DB.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL'
      '         and DB.YEAR_MONTH = ('
      '                               select max(DBM.YEAR_MONTH)'
      
        '                                 from DB_LOADER_ACCOUNT_PHONES d' +
        'bm'
      
        '                                where DBM.PHONE_NUMBER = DB.PHON' +
        'E_NUMBER'
      '                             )'
      '    ) Phone_active'
      '  FROM contracts c,'
      '       tariffs tr'
      ' WHERE exists ('
      '                 select 1'
      '                   from all_phone_turn_log lg'
      '                 where LG.PHONE = C.PHONE_NUMBER_FEDERAL'
      '              )'
      '   and c.CONTRACT_ID not in ('
      '                               select cc.CONTRACT_ID '
      '                                 from  contract_cancels cc'
      '                            )'
      '   and NVL(C.CURR_TARIFF_ID, C.TARIFF_ID) = TR.TARIFF_ID')
    AfterScroll = qReportAfterScroll
  end
  inherited aList: TActionList
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
    object aDetailInfo: TAction
      Caption = 'aDetailInfo'
      ImageIndex = 11
      OnExecute = aDetailInfoExecute
    end
  end
  object qPckgLog: TOraQuery
    SQL.Strings = (
      'select '
      '  ALL_PHONE_LOG_ID, '
      '  PHONE,'
      '  TARIFF_ID, '
      '  TURN_ON_DATE, '
      '  PCKG_CODE,'
      '  UNITTYPE,'
      
        '  to_date(to_char(DATE_ON, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYYY' +
        ' HH24:MI:SS'#39') DATE_ON, '
      
        '  to_date(to_char(DATE_OFF, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYY' +
        'Y HH24:MI:SS'#39') DATE_OFF, '
      '  IS_SEND_SMS_ZERO,'
      '  IS_SEND_SMS_PREV,'
      '  PREDVALUE,'
      '  DO_NOT_REST'
      'from all_phone_turn_log'
      'where phone = :p_phone'
      'order by all_phone_log_id desc')
    BeforeOpen = qPckgLogBeforeOpen
    AfterScroll = qPckgLogAfterScroll
    Left = 48
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end>
  end
  object qPckgStat: TOraQuery
    SQL.Strings = (
      'select '
      '  ALL_PHONE_STAT_ID, '
      '  PHONE, '
      '  PCKG_CODE,'
      '  UNITTYPE, '
      '  INITVALUE, '
      '  CURRVALUE, '
      
        '  to_date(to_char(CURR_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') CURR_CHECK_DATE, '
      
        '  to_date(to_char(NEXT_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') NEXT_CHECK_DATE, '
      '  CTRL_PNT, '
      '  IS_CHECKED, '
      '  ALL_PHONE_TURN_LOG_ID'
      'from all_phone_stat '
      'where phone = :p_phone'
      'and all_phone_turn_log_id = :pturn_log_id'
      'order by all_phone_stat_id desc')
    BeforeOpen = qPckgStatBeforeOpen
    Left = 32
    Top = 528
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end
      item
        DataType = ftUnknown
        Name = 'pturn_log_id'
      end>
  end
  object dsPckgLog: TDataSource
    DataSet = qPckgLog
    Left = 104
    Top = 312
  end
  object dsPckgStat: TDataSource
    DataSet = qPckgStat
    Left = 96
    Top = 528
  end
end
