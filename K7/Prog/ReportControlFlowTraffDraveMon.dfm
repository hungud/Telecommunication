inherited ReportControlFlowTraffDraveMonForm: TReportControlFlowTraffDraveMonForm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1088#1072#1089#1093#1086#1076#1091' '#1090#1088#1072#1092#1080#1082#1072' '#1080#1085#1090#1077#1088#1085#1077#1090#1072' '#1085#1072' '#1085#1086#1084#1077#1088#1072#1093' '#1089' '#1090#1072#1088#1080#1092#1086#1084' "'#1044#1088#1072#1081#1074'"'
  ClientHeight = 682
  ClientWidth = 1118
  Position = poScreenCenter
  ExplicitWidth = 1134
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 281
    Width = 1118
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitWidth = 285
  end
  inherited pButtons: TPanel
    Width = 1118
    inherited btRefresh: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited btLoadInExcel: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited btnShowUserStatInfo: TBitBtn
      Width = 142
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1073#1086#1085#1077#1085#1090#1072
      Glyph.Data = {00000000}
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
    Width = 1118
    Height = 252
    ExplicitWidth = 1014
    ExplicitHeight = 252
    inherited gReport: TCRDBGrid
      Width = 1116
      Height = 250
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      OnDrawColumnCell = gReportDrawColumnCell
      OnDblClick = gReportDblClick
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
          FieldName = 'CONTRACT_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 93
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
          Width = 179
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Phone_active'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
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
          FieldName = 'LIMIT_SPEED'
          Title.Alignment = taCenter
          Title.Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1089#1082#1086#1088#1086#1089#1090#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 137
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_SEND_SMS_ZERO_FIRST'
          Title.Alignment = taCenter
          Title.Caption = 'C'#1084#1089' '#1086#1075#1088#1072#1085#1080#1095'. '#1089#1082#1086#1088#1086#1089#1090#1080' I '#1095'/'#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 174
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_SEND_SMS_ZERO_SECOND'
          Title.Alignment = taCenter
          Title.Caption = 'C'#1084#1089' '#1086#1075#1088#1072#1085#1080#1095'. '#1089#1082#1086#1088#1086#1089#1090#1080' II '#1095'/'#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 169
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_SEND_SMS_PREV_FIRST'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076'. '#1089#1084#1089' I '#1095'/'#1084
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
          FieldName = 'IS_SEND_SMS_PREV_SECOND'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076'. '#1089#1084#1089' II '#1095'/'#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPENTVALUE'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084' '#1080#1079#1088#1072#1089#1093'. '#1090#1088#1072#1092#1080#1082#1072
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
          FieldName = 'PREDVALUE'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084' '#1087#1088#1086#1075#1085#1086#1079'. '#1090#1088#1072#1092#1080#1082#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 162
          Visible = True
        end>
    end
  end
  object pData: TPanel [3]
    Left = 0
    Top = 284
    Width = 1118
    Height = 398
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 704
    ExplicitTop = 392
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Splitter2: TSplitter
      Left = 1
      Top = 169
      Width = 1116
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 113
      ExplicitWidth = 168
    end
    object pDraveLog: TPanel
      Left = 1
      Top = 1
      Width = 1116
      Height = 168
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 1086
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 1114
        Height = 13
        Align = alTop
        Caption = '  '#1048#1089#1090#1086#1088#1080#1103' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1090#1072#1088#1080#1092#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 195
      end
      object gDraveLog: TCRDBGrid
        Left = 1
        Top = 14
        Width = 1114
        Height = 153
        Align = alClient
        DataSource = dsDraveLog
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = gDraveLogDrawColumnCell
        OnDblClick = gDraveLogDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
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
            FieldName = 'TARIFF_CODE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_ON'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 104
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_OFF'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LIMIT_SPEED'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1089#1082#1086#1088#1086#1089#1090#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 134
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_ZERO_FIRST'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1057#1084#1089' '#1086#1075#1088#1072#1085#1080#1095'. '#1089#1082#1086#1088#1086#1089#1090#1080' I '#1095'/'#1084
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 166
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_ZERO_SECOND'
            Title.Alignment = taCenter
            Title.Caption = #1057#1084#1089' '#1086#1075#1088#1072#1085#1080#1095'. '#1089#1082#1086#1088#1086#1089#1090#1080' II '#1095'/'#1084
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 178
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_PREV_FIRST'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076'. '#1089#1084#1089' I '#1095'/'#1084
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 143
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_SEND_SMS_PREV_SECOND'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076'. '#1089#1084#1089' II '#1095'/'#1084
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PREDVALUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1098#1077#1084' '#1087#1088#1086#1075#1085#1086#1079'. '#1090#1088#1072#1092#1080#1082#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 167
            Visible = True
          end>
      end
    end
    object pDraveStat: TPanel
      Left = 1
      Top = 172
      Width = 1116
      Height = 225
      Align = alClient
      TabOrder = 1
      ExplicitTop = 200
      ExplicitWidth = 1086
      ExplicitHeight = 197
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 1114
        Height = 13
        Align = alTop
        Caption = '  '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1088#1072#1089#1093#1086#1076#1072' '#1080#1085#1090#1077#1088#1085#1077#1090' '#1090#1088#1072#1092#1080#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 237
      end
      object gDraveStat: TCRDBGrid
        Left = 1
        Top = 14
        Width = 1114
        Height = 210
        Align = alClient
        DataSource = dsDraveStat
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = gDraveStatDblClick
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
            FieldName = 'TARIFF_CODE'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
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
      'select '
      '  dr.phone,'
      '  V.CONTRACT_DATE,'
      '  TR.TARIFF_CODE,'
      '  TR.TARIFF_NAME,'
      '  ('
      '    select '
      '          case'
      '            when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then'
      '              case'
      '                when nvl(DB.CONSERVATION,0) = 1 then'
      '                  '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '                else '
      '                  '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '              end'
      '            else'
      '              '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '          end'
      '      from DB_LOADER_ACCOUNT_PHONES db'
      '    where DB.PHONE_NUMBER = dr.phone'
      '        and DB.YEAR_MONTH = ('
      
        '                                               select max(DBM.YE' +
        'AR_MONTH)'
      
        '                                                 from DB_LOADER_' +
        'ACCOUNT_PHONES dbm'
      
        '                                                where DBM.PHONE_' +
        'NUMBER = DB.PHONE_NUMBER'
      '                                            )'
      '  ) Phone_active,'
      '  dr.LIMIT_SPEED, '
      '  dr.IS_SEND_SMS_ZERO_FIRST, '
      '  dr.IS_SEND_SMS_ZERO_SECOND, '
      '  dr.IS_SEND_SMS_PREV_FIRST,'
      '  dr.IS_SEND_SMS_PREV_SECOND,  '
      '  ('
      '     select SUM(st.initvalue - st.CURRVALUE)'
      '       from drave_stat st'
      '     where st.phone = dr.phone'
      '         and st.DRAVE_STAT_ID in ('
      
        '                                                  select DRAVE_S' +
        'TAT_ID'
      '                                                    from'
      '                                                    ('
      
        '                                                      select max' +
        '(st1.DRAVE_STAT_ID) DRAVE_STAT_ID, st1.DRAVE_TURN_LOG_ID, st1.ph' +
        'one'
      
        '                                                        from dra' +
        've_stat st1'
      
        '                                                      group by s' +
        't1.DRAVE_TURN_LOG_ID, st1.phone'
      '                                                    ) c'
      
        '                                                  where c.phone ' +
        '= st.phone'
      '                                                )'
      '  ) SPENTVALUE,'
      '  dr.PREDVALUE'
      'from drave_turn_log dr,'
      '        v_contracts v,'
      '        tariffs tr'
      'where dr.drave_log_id = ('
      
        '                                       select max(lg.drave_log_i' +
        'd)'
      '                                         from drave_turn_log lg'
      
        '                                        where lg.phone = dr.phon' +
        'e'
      '                                     )'
      '    and dr.phone = V.PHONE_NUMBER_FEDERAL'
      '    and V.CONTRACT_CANCEL_DATE is null'
      '    and V.TARIFF_ID = TR.TARIFF_ID')
    AfterScroll = qReportAfterScroll
  end
  inherited aList: TActionList
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
    object aDetailInfo: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1086#1076#1088#1086#1073#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      ImageIndex = 11
      OnExecute = aDetailInfoExecute
    end
  end
  object qDraveStat: TOraQuery
    SQL.Strings = (
      'select '
      '  DRAVE_STAT_ID, PHONE, TARIFF_CODE, '
      '  INITVALUE, CURRVALUE, '
      
        '  to_date(to_char(CURR_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') CURR_CHECK_DATE, '
      
        '  to_date(to_char(NEXT_CHECK_DATE, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD' +
        '.MM.YYYY HH24:MI:SS'#39') NEXT_CHECK_DATE, '
      '  CTRL_PNT, IS_CHECKED, DRAVE_TURN_LOG_ID'
      'from drave_stat '
      'where phone = :p_phone'
      'and drave_turn_log_id = :pturn_log_id'
      'order by drave_stat_id desc')
    BeforeOpen = qDraveStatBeforeOpen
    Left = 40
    Top = 560
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
  object dsDraveStat: TDataSource
    DataSet = qDraveStat
    Left = 112
    Top = 560
  end
  object qDraveLog: TOraQuery
    SQL.Strings = (
      'select '
      '  DRAVE_LOG_ID, '
      '  PHONE, '
      '  TARIFF_CODE, '
      
        '  to_date(to_char(DATE_ON, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYYY' +
        ' HH24:MI:SS'#39') DATE_ON, '
      
        '  to_date(to_char(DATE_OFF, '#39'DD.MM.YYYY HH24:MI:SS'#39'), '#39'DD.MM.YYY' +
        'Y HH24:MI:SS'#39') DATE_OFF,'
      '  LIMIT_SPEED, '
      '  IS_SEND_SMS_ZERO_FIRST, '
      '  IS_SEND_SMS_ZERO_SECOND,'
      '  IS_SEND_SMS_PREV_FIRST, '
      '  IS_SEND_SMS_PREV_SECOND,'
      '  PREDVALUE'
      'from drave_turn_log'
      'where phone = :p_phone'
      'order by drave_log_id desc')
    BeforeOpen = qDraveLogBeforeOpen
    AfterScroll = qDraveLogAfterScroll
    Left = 48
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_phone'
      end>
  end
  object dsDraveLog: TDataSource
    DataSet = qDraveLog
    Left = 120
    Top = 352
  end
end
