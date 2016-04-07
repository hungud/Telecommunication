inherited RefDocumentForm: TRefDocumentForm
  Caption = 'RefDocumentForm'
  ClientHeight = 467
  ClientWidth = 807
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 815
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  object TlBr: TsToolBar
    Left = 0
    Top = 0
    Width = 807
    Height = 29
    ButtonHeight = 30
    ButtonWidth = 31
    DoubleBuffered = True
    Images = Dm.ImageList24
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    SkinData.SkinSection = 'TOOLBAR'
    ExplicitWidth = 1128
    object btnInsert: TToolButton
      Left = 0
      Top = 0
      Action = aFiltr
    end
    object ToolButton1: TToolButton
      Left = 31
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 14
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 39
      Top = 0
      Action = aToExcel
    end
    object ToolButton3: TToolButton
      Left = 70
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 46
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 78
      Top = 0
      Action = aFirst
    end
    object ToolButton5: TToolButton
      Left = 109
      Top = 0
      Action = aMovePrev
    end
    object ToolButton9: TToolButton
      Left = 140
      Top = 0
      Action = aPrev
    end
    object ToolButton6: TToolButton
      Left = 171
      Top = 0
      Action = aNext
    end
    object ToolButton7: TToolButton
      Left = 202
      Top = 0
      Action = aMoveNext
    end
    object ToolButton8: TToolButton
      Left = 233
      Top = 0
      Action = aLast
    end
  end
  object CRGrid: TCRDBGrid
    Left = 0
    Top = 29
    Width = 807
    Height = 438
    OptionsEx = [dgeLocalFilter, dgeLocalSorting, dgeRecordCount]
    Align = alClient
    DataSource = dsqReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleFont.Quality = fqClearTypeNatural
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'YEAR_MONTH_NAME'
        Title.Alignment = taCenter
        Width = 114
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Title.Alignment = taCenter
        Width = 142
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_ID'
        Title.Alignment = taCenter
        Width = 175
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PHONE_NUMBER_CITY'
        Title.Alignment = taCenter
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Width = 198
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1054#1087#1094#1080#1080
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILIAL_NAME'
        Title.Alignment = taCenter
        Width = 179
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SIM_NUMBER'
        Title.Alignment = taCenter
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ALL_CLIENT_SCHET'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Title.Alignment = taCenter
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED_'
        Title.Alignment = taCenter
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATED_FIO'
        Title.Alignment = taCenter
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED_'
        Title.Alignment = taCenter
        Width = 105
        Visible = True
      end>
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 520
    Top = 36
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      ImageIndex = 7
      ShortCut = 16467
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Enabled = False
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
      ImageIndex = 9
      ShortCut = 116
    end
    object aFind: TAction
      Caption = #1055#1086#1080#1089#1082
      Enabled = False
      Hint = #1055#1086#1080#1089#1082' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+G'
      ImageIndex = 15
      ShortCut = 16455
    end
    object aFiltr: TAction
      Caption = #1060#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+F'
      ImageIndex = 13
      ShortCut = 16454
      OnExecute = aFiltrExecute
    end
    object aNext: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
      OnExecute = aNextExecute
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
      OnExecute = aPrevExecute
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
      OnExecute = aFirstExecute
    end
    object aLast: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNextExecute
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrevExecute
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Enabled = False
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcelExecute
    end
  end
  object qReport: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  dlb.ACCOUNT_ID,'
      '  dlb.CONTRACT_ID,'
      '  dlb.SIM_NUMBER,'
      '  dlb.tariff_id,'
      '  dlb.abonent_id,'
      '  dlb.filial_id,'
      '  dlb.MOBILE_OPERATOR_NAME_ID,'
      '  dlb.VIRTUAL_ACCOUNTS_ID,'
      '  dlb.MOBILE_OPERATOR_NAME,'
      '  dlb.ACCOUNT_NUMBER, '
      '  dlb.login ,'
      '  dlb.ACCOUNT_NUMBER_LOGIN,'
      '  dlb.filial_name,'
      '  dlb.phone_id,'
      '  dlb.PHONE_NUMBER_CITY,'
      '  dlb.surname,'
      '  dlb.VIRTUAL_ACCOUNTS_name,'
      '  dlb.tariff_name,'
      '  dlb.CALL_LOCAL,'
      '  dlb.CALL_INTERCITY,'
      '  dlb.MESSAGE,'
      '  dlb.INTERNET,  '
      '  dlb.OTHERS_SERVISES,'
      '  dlb.SUBSCRIPTION_SUM,'
      '  dlb.INTERNATIONAL_ROAMING,'
      '  dlb.NATIONAL_INTRANET_ROAMING,  '
      '  dlb.ADJUSTMENT,'
      '  dlb.PAYMENTS,'
      '  dlb.ALL_CLIENT_SCHET,'
      '  dlb.DATE_CREATED,'
      '  dlb.USER_CREATED,'
      '  dlb.USER_LAST_UPDATED,'
      '  dlb.DATE_LAST_UPDATED,'
      '  dlb.LOG_BILL_ID,'
      '  dlb.YEAR_MONTH,'
      '  dlb.YEAR_MONTH_NAME, '
      '  case'
      '    when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then'
      '      '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| dlb.USER_CREATED'
      '  else'
      '    un.USER_FIO'
      '  end USER_CREATED_FIO,'
      '  '
      '  dlb.DATE_CREATED  DATE_CREATED_,'
      '  '
      '  case'
      '    when nvl(un2.USER_FIO, '#39'0'#39') = '#39'0'#39' then'
      '      '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| dlb.USER_LAST_UPDATED'
      '  else'
      '    un2.USER_FIO'
      '  end USER_LAST_UPDATED_FIO,'
      '  '
      '  dlb.DATE_LAST_UPDATED DATE_LAST_UPDATED_'
      '  from V_BILLS dlb,'
      '       USER_NAMES un, '
      '       USER_NAMES un2  '
      'where dlb.USER_CREATED = un.USER_NAME(+)   '
      '  and dlb.USER_LAST_UPDATED = un2.USER_NAME(+)')
    FetchRows = 1000
    Filtered = True
    BeforeOpen = qReportBeforeOpen
    AfterOpen = qReportAfterOpen
    AfterScroll = qReportAfterScroll
    Left = 406
    Top = 227
    object qReportYEAR_MONTH_NAME: TStringField
      DisplayLabel = #1055#1077#1088#1080#1086#1076
      FieldName = 'YEAR_MONTH_NAME'
      Size = 59
    end
    object qReportVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Required = True
      Size = 600
    end
    object qReportPHONE_ID: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'PHONE_ID'
      Required = True
    end
    object qReportPHONE_NUMBER_CITY: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
      FieldName = 'PHONE_NUMBER_CITY'
      Size = 52
    end
    object qReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      FieldName = 'TARIFF_NAME'
      Required = True
      Size = 400
    end
    object qReportFILIAL_NAME: TStringField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      FieldName = 'FILIAL_NAME'
      Required = True
      Size = 200
    end
    object qReportSIM_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1089#1080#1084'-'#1082#1072#1088#1090#1099
      FieldName = 'SIM_NUMBER'
      Size = 30
    end
    object qReportALL_CLIENT_SCHET: TFloatField
      DisplayLabel = #1056#1072#1089#1093#1086#1076#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      FieldName = 'ALL_CLIENT_SCHET'
    end
    object qReportUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      FieldName = 'USER_CREATED_FIO'
      Size = 240
    end
    object qReportDATE_CREATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1085#1072
      FieldName = 'DATE_CREATED_'
    end
    object qReportUSER_LAST_UPDATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1080#1083
      FieldName = 'USER_LAST_UPDATED_FIO'
      Size = 240
    end
    object qReportDATE_LAST_UPDATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1077#1085#1072
      FieldName = 'DATE_LAST_UPDATED_'
    end
    object qReportACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
      Visible = False
    end
    object qReportTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
      Visible = False
    end
    object qReportABONENT_ID: TFloatField
      FieldName = 'ABONENT_ID'
      Required = True
      Visible = False
    end
    object qReportFILIAL_ID: TFloatField
      FieldName = 'FILIAL_ID'
      Required = True
      Visible = False
    end
    object qReportMOBILE_OPERATOR_NAME_ID: TFloatField
      FieldName = 'MOBILE_OPERATOR_NAME_ID'
      Required = True
      Visible = False
    end
    object qReportVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
      Required = True
      Visible = False
    end
    object qReportMOBILE_OPERATOR_NAME: TStringField
      FieldName = 'MOBILE_OPERATOR_NAME'
      Required = True
      Visible = False
      Size = 240
    end
    object qReportACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
      Required = True
      Visible = False
    end
    object qReportLOGIN: TStringField
      FieldName = 'LOGIN'
      Required = True
      Visible = False
      Size = 30
    end
    object qReportACCOUNT_NUMBER_LOGIN: TStringField
      FieldName = 'ACCOUNT_NUMBER_LOGIN'
      Visible = False
      Size = 72
    end
    object qReportSURNAME: TStringField
      FieldName = 'SURNAME'
      Visible = False
      Size = 462
    end
    object qReportCALL_LOCAL: TFloatField
      FieldName = 'CALL_LOCAL'
      Visible = False
    end
    object qReportCALL_INTERCITY: TFloatField
      FieldName = 'CALL_INTERCITY'
      Visible = False
    end
    object qReportMESSAGE: TFloatField
      FieldName = 'MESSAGE'
      Visible = False
    end
    object qReportINTERNET: TFloatField
      FieldName = 'INTERNET'
      Visible = False
    end
    object qReportOTHERS_SERVISES: TFloatField
      FieldName = 'OTHERS_SERVISES'
      Visible = False
    end
    object qReportSUBSCRIPTION_SUM: TFloatField
      FieldName = 'SUBSCRIPTION_SUM'
      Visible = False
    end
    object qReportINTERNATIONAL_ROAMING: TFloatField
      FieldName = 'INTERNATIONAL_ROAMING'
      Visible = False
    end
    object qReportNATIONAL_INTRANET_ROAMING: TFloatField
      FieldName = 'NATIONAL_INTRANET_ROAMING'
      Visible = False
    end
    object qReportADJUSTMENT: TFloatField
      FieldName = 'ADJUSTMENT'
      Visible = False
    end
    object qReportPAYMENTS: TFloatField
      FieldName = 'PAYMENTS'
      Visible = False
    end
    object qReportDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
      Visible = False
    end
    object qReportUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Visible = False
      Size = 30
    end
    object qReportUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Visible = False
      Size = 30
    end
    object qReportDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
      Visible = False
    end
    object qReportLOG_BILL_ID: TFloatField
      FieldName = 'LOG_BILL_ID'
      Visible = False
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Visible = False
    end
    object qReportCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
      Visible = False
    end
  end
  object dsqReport: TOraDataSource
    Tag = 1
    DataSet = qReport
    Left = 687
    Top = 266
  end
  object tmp: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  dlb.ACCOUNT_ID,'
      '  dlb.CONTRACT_ID,'
      '  dlb.SIM_NUMBER,'
      '  dlb.tariff_id,'
      '  dlb.abonent_id,'
      '  dlb.filial_id,'
      '  dlb.MOBILE_OPERATOR_NAME_ID,'
      '  dlb.VIRTUAL_ACCOUNTS_ID,'
      '  dlb.MOBILE_OPERATOR_NAME,'
      '  dlb.ACCOUNT_NUMBER, '
      '  dlb.login ,'
      '  dlb.ACCOUNT_NUMBER_LOGIN,'
      '  dlb.filial_name,'
      '  dlb.phone_id,'
      '  dlb.PHONE_NUMBER_CITY,'
      '  dlb.surname,'
      '  dlb.VIRTUAL_ACCOUNTS_name,'
      '  dlb.tariff_name,'
      '  dlb.CALL_LOCAL,'
      '  dlb.CALL_INTERCITY,'
      '  dlb.MESSAGE,'
      '  dlb.INTERNET,  '
      '  dlb.OTHERS_SERVISES,'
      '  dlb.SUBSCRIPTION_SUM,'
      '  dlb.INTERNATIONAL_ROAMING,'
      '  dlb.NATIONAL_INTRANET_ROAMING,  '
      '  dlb.ADJUSTMENT,'
      '  dlb.PAYMENTS,'
      '  dlb.ALL_CLIENT_SCHET,'
      '  dlb.DATE_CREATED,'
      '  dlb.USER_CREATED,'
      '  dlb.USER_LAST_UPDATED,'
      '  dlb.DATE_LAST_UPDATED,'
      '  dlb.LOG_BILL_ID,'
      '  dlb.YEAR_MONTH,'
      '  dlb.YEAR_MONTH_NAME, '
      '  case'
      '    when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then'
      '      '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| dlb.USER_CREATED'
      '  else'
      '    un.USER_FIO'
      '  end USER_CREATED_FIO,'
      '  '
      '  dlb.DATE_CREATED  DATE_CREATED_,'
      '  '
      '  case'
      '    when nvl(un2.USER_FIO, '#39'0'#39') = '#39'0'#39' then'
      '      '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| dlb.USER_LAST_UPDATED'
      '  else'
      '    un2.USER_FIO'
      '  end USER_LAST_UPDATED_FIO,'
      '  '
      '  dlb.DATE_LAST_UPDATED DATE_LAST_UPDATED_'
      '  from V_BILLS dlb,'
      '       USER_NAMES un, '
      '       USER_NAMES un2  '
      'where dlb.USER_CREATED = un.USER_NAME(+)   '
      '  and dlb.USER_LAST_UPDATED = un2.USER_NAME(+)')
    FetchRows = 1000
    Filtered = True
    Left = 558
    Top = 131
  end
end
