inherited RepLoaderBillFrm: TRepLoaderBillFrm
  Left = 274
  Top = 243
  Caption = 'RepLoaderBillFrm'
  ClientWidth = 1439
  Position = poMainFormCenter
  ExplicitWidth = 1455
  ExplicitHeight = 631
  PixelsPerInch = 96
  TextHeight = 13
  inherited sSplitter1: TsSplitter
    Width = 1439
    ExplicitWidth = 2612
  end
  inherited sStatusBar1: TsStatusBar
    Width = 1439
    ExplicitWidth = 1439
  end
  inherited CRGrid: TCRDBGrid
    Width = 1439
    Filtered = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'Period'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILIAL_NAME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACCOUNT_NUMBER'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_ID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SURNAME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALL_LOCAL'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 133
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'CALL_INTERCITY'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'MESSAGE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'INTERNET'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'OTHERS_SERVISES'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'SUBSCRIPTION_SUM'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'INTERNATIONAL_ROAMING'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 71
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'NATIONAL_INTRANET_ROAMING'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 77
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'ADJUSTMENT'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 77
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'PAYMENTS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 77
        Visible = True
        SummaryMode = smSum
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM'
        Title.Alignment = taCenter
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
        FieldName = 'MARGIN'
        Title.Alignment = taCenter
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
        FieldName = 'ALL_CLIENT_SCHET'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 94
        Visible = True
        SummaryMode = smSum
      end>
  end
  inherited sScrollBox1: TsScrollBox
    Width = 1439
    ExplicitWidth = 1439
    object sbShowBeginInfo: TsSpeedButton [0]
      Left = 1292
      Top = 41
      Width = 140
      Height = 34
      Action = aShowBeginInfo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 55
      Images = Dm.ImageList24
    end
    object sbSendToFTPfor1C: TsSpeedButton [1]
      Left = 1074
      Top = 80
      Width = 113
      Height = 32
      Action = aSendToFTPfor1C
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 47
      Images = Dm.ImageList24
    end
    object sbSendEmeilAll: TsSpeedButton [2]
      Left = 1197
      Top = 80
      Width = 108
      Height = 32
      Action = aSendEmeilAll
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 58
      Images = Dm.ImageList24
    end
    object sbShowReport: TsSpeedButton [3]
      Left = 1293
      Top = 119
      Width = 139
      Height = 30
      Action = aShowReport
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1080#1088#1090'. '#1089#1095#1077#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 59
      Images = Dm.ImageList24
    end
    object sbShowSendEmeil: TsSpeedButton [4]
      Left = 1312
      Top = 80
      Width = 120
      Height = 32
      Action = aShowSendEmeil
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 57
      Images = Dm.ImageList24
    end
    inherited spVirtAcc: TsPanel
      inherited CLB_VirtAcc: TsCheckListBox
        Left = 122
        Top = 0
        ExplicitLeft = 122
        ExplicitTop = 0
      end
    end
    inherited spAccount: TsPanel
      inherited sp: TsPanel
        Top = 3
        Width = 143
        ExplicitTop = 3
        ExplicitWidth = 143
        inherited sGauge1: TsGauge
          Width = 133
          ExplicitWidth = 133
        end
      end
    end
    inherited cbPeriod: TsComboBox
      Left = 1128
      Top = 10
      ExplicitLeft = 1128
      ExplicitTop = 10
    end
    inherited spFiltrSearch: TsPanel
      Left = 1267
      Top = 4
      ExplicitLeft = 1267
      ExplicitTop = 4
    end
    inherited spShow: TsPanel
      Left = 1073
      Top = 40
      Width = 218
      ExplicitLeft = 1073
      ExplicitTop = 40
      ExplicitWidth = 218
      inherited sbInfoShow: TsSpeedButton
        Width = 98
        ExplicitWidth = 98
      end
    end
    inherited pButtonMove: TsPanel
      Left = 1074
      Top = 119
      Width = 210
      ExplicitLeft = 1074
      ExplicitTop = 119
      ExplicitWidth = 210
    end
  end
  inherited actlst1: TActionList
    Left = 992
    Top = 180
    object aShowBeginInfo: TAction [25]
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      Enabled = False
      Hint = 
        #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077', '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080' '#1082#1086#1090#1086#1088#1099#1093' '#1087#1086#1083#1091#1095#1077#1085#1072' '#1090#1077#1082#1091#1097#1072#1103' ' +
        #1079#1072#1087#1080#1089#1100
      ImageIndex = 55
      OnExecute = aShowBeginInfoExecute
    end
    object aSendEmeilAll: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1095#1077#1090#1099
      Enabled = False
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086' '#1101#1083'. '#1087#1086#1095#1090#1077' '#1086#1090#1095#1077#1090#1099' '#1086' '#1088#1072#1089#1093#1086#1076#1072#1093' '#1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1089#1095#1077#1090#1072#1084
      ImageIndex = 58
      OnExecute = aSendEmeilAllExecute
    end
    object aShowReport: TAction
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1086#1084#1091' '#1089#1095#1077#1090#1091
      Enabled = False
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1086#1090#1095#1077#1090' '#1087#1086' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1086#1084#1091' '#1089#1095#1077#1090#1091
      ImageIndex = 59
      OnExecute = aShowReportExecute
    end
    object aSendToFTPfor1C: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1092#1072#1081#1083' '#1074' 1'#1057
      Hint = #1042#1099#1083#1086#1078#1080#1090#1100' '#1092#1072#1081#1083' '#1089#1095#1077#1090#1072' '#1076#1083#1103' 1'#1057' '#1079#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1085#1072' '#1089#1077#1088#1074#1077#1088
      ImageIndex = 47
      OnExecute = aSendToFTPfor1CExecute
    end
    object aShowSendEmeil: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1086#1095#1090#1099
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1078#1091#1088#1085#1072#1083#1072' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1085#1086#1081' '#1087#1086#1095#1090#1099' '#1079#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
      ImageIndex = 57
      OnExecute = aShowSendEmeilExecute
    end
  end
  inherited pm1: TPopupMenu
    Left = 1016
    Top = 24
  end
  inherited qMonthYearforRepFrm: TOraQuery
    inherited qMonthYearforRepFrmYEAR_MONTH_NAME: TStringField
      Size = 212
    end
  end
  inherited qAccount: TOraQuery
    Left = 353
    Top = 194
  end
  inherited dsqAccount: TOraDataSource
    Left = 351
    Top = 242
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select '
      '  ACCOUNT_ID,'
      '  tariff_id,'
      '  abonent_id,'
      '  filial_id,'
      '  MOBILE_OPERATOR_NAME_ID,'
      '  VIRTUAL_ACCOUNTS_ID,'
      '  MOBILE_OPERATOR_NAME,'
      '  ACCOUNT_NUMBER, '
      '  login ,'
      '  ACCOUNT_NUMBER_LOGIN,'
      '  filial_name,'
      '  to_char(PHONE_ID) PHONE_ID,'
      '  surname,'
      '  VIRTUAL_ACCOUNTS_name,'
      '  tariff_name,'
      '  CALL_LOCAL,'
      '  CALL_INTERCITY,'
      '  MESSAGE,'
      '  INTERNET,  '
      '  OTHERS_SERVISES,'
      '  SUBSCRIPTION_SUM,'
      '  INTERNATIONAL_ROAMING,'
      '  NATIONAL_INTRANET_ROAMING,  '
      '  ADJUSTMENT,'
      '  PAYMENTS,'
      '  ALL_CLIENT_SCHET,'
      '  dlb.DATE_CREATED,'
      '  dlb.USER_CREATED,'
      '  dlb.USER_LAST_UPDATED,'
      '  dlb.DATE_LAST_UPDATED,'
      '  dlb.LOG_BILL_ID,'
      '  dlb.YEAR_MONTH,'
      '  dlb.MARGIN,'
      '  dlb.BILL_SUM,'
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
      '  '
      'from V_BILLS dlb,'
      '     USER_NAMES un, '
      '     USER_NAMES un2  '
      'where dlb.USER_CREATED = un.USER_NAME(+)   '
      '  and dlb.USER_LAST_UPDATED = un2.USER_NAME(+)')
    Filtered = False
    Left = 598
    Top = 251
    ParamData = <>
    object qReportPeriod: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'Period'
      LookupDataSet = qMonthYearforRepFrm
      LookupKeyFields = 'YEAR_MONTH'
      LookupResultField = 'YEAR_MONTH_NAME'
      KeyFields = 'YEAR_MONTH'
      Size = 60
      Lookup = True
    end
    object qReportMOBILE_OPERATOR_NAME: TStringField
      DisplayLabel = #1052#1086#1073#1080#1083#1100#1085#1099#1081' '#1086#1087#1077#1088#1072#1090#1086#1088
      FieldName = 'MOBILE_OPERATOR_NAME'
      Required = True
      Size = 240
    end
    object qReportUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      DisplayWidth = 346
      FieldName = 'USER_CREATED_FIO'
      Size = 240
    end
    object qReportDATE_CREATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1085#1072
      DisplayWidth = 27
      FieldName = 'DATE_CREATED_'
    end
    object qReportUSER_LAST_UPDATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1080#1083
      DisplayWidth = 346
      FieldName = 'USER_LAST_UPDATED_FIO'
      Size = 240
    end
    object qReportDATE_LAST_UPDATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1077#1085#1072
      DisplayWidth = 33
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
    object qReportVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
      Required = True
      Visible = False
    end
    object qReportACCOUNT_NUMBER_LOGIN: TStringField
      DisplayLabel = #8470' '#1089#1095#1077#1090#1072' '#1080' '#1051#1086#1075#1080#1085
      FieldName = 'ACCOUNT_NUMBER_LOGIN'
      Visible = False
      Size = 72
    end
    object qReportFILIAL_NAME: TStringField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      FieldName = 'FILIAL_NAME'
      Required = True
      Size = 200
    end
    object qReportLOGIN: TStringField
      DisplayLabel = #1051#1086#1075#1080#1085
      FieldName = 'LOGIN'
      Required = True
      Visible = False
      Size = 30
    end
    object qReportVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1042#1080#1088#1090'. '#1089#1095#1077#1090
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Required = True
      Size = 600
    end
    object qReportACCOUNT_NUMBER: TFloatField
      DisplayLabel = #8470' '#1089#1095#1077#1090#1072
      FieldName = 'ACCOUNT_NUMBER'
      Required = True
    end
    object qReportPHONE_ID: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      FieldName = 'PHONE_ID'
      Size = 40
    end
    object qReportSURNAME: TStringField
      DisplayLabel = #1060'.'#1048'.'#1054'.'
      FieldName = 'SURNAME'
      Size = 462
    end
    object qReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      FieldName = 'TARIFF_NAME'
      Required = True
      Size = 400
    end
    object qReportCALL_LOCAL: TFloatField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085#1080#1103' '#1084#1077#1089#1090'.'
      FieldName = 'CALL_LOCAL'
    end
    object qReportCALL_INTERCITY: TFloatField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085#1080#1103' '#1052#1043', '#1052#1053
      FieldName = 'CALL_INTERCITY'
    end
    object qReportMESSAGE: TFloatField
      DisplayLabel = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      FieldName = 'MESSAGE'
    end
    object qReportINTERNET: TFloatField
      DisplayLabel = #1052#1086#1073'.'#1080#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'INTERNET'
    end
    object qReportOTHERS_SERVISES: TFloatField
      DisplayLabel = #1044#1086#1087'. '#1091#1089#1083#1091#1075#1080
      FieldName = 'OTHERS_SERVISES'
    end
    object qReportSUBSCRIPTION_SUM: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072
      FieldName = 'SUBSCRIPTION_SUM'
    end
    object qReportINTERNATIONAL_ROAMING: TFloatField
      DisplayLabel = #1056#1086#1091#1084#1080#1085#1075' '#1052#1053
      FieldName = 'INTERNATIONAL_ROAMING'
    end
    object qReportNATIONAL_INTRANET_ROAMING: TFloatField
      DisplayLabel = #1056#1086#1091#1084#1080#1085#1075' '#1042#1053', '#1053#1040#1062'.'
      FieldName = 'NATIONAL_INTRANET_ROAMING'
    end
    object qReportADJUSTMENT: TFloatField
      DisplayLabel = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080
      FieldName = 'ADJUSTMENT'
    end
    object qReportPAYMENTS: TFloatField
      DisplayLabel = #1055#1083#1072#1090#1077#1078#1080
      FieldName = 'PAYMENTS'
    end
    object qReportBILL_SUM: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'BILL_SUM'
    end
    object qReportMARGIN: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1085#1072#1076#1073#1072#1074#1082#1080
      FieldName = 'MARGIN'
    end
    object qReportALL_CLIENT_SCHET: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1050#1083#1080#1077#1085#1090#1091
      FieldName = 'ALL_CLIENT_SCHET'
    end
    object qReportLOG_BILL_ID: TFloatField
      FieldName = 'LOG_BILL_ID'
      Visible = False
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Visible = False
    end
    object qReportMOBILE_OPERATOR_NAME_ID: TFloatField
      FieldName = 'MOBILE_OPERATOR_NAME_ID'
      Required = True
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
  end
  inherited dsqReport: TOraDataSource
    Left = 695
    Top = 250
  end
  inherited qLogin: TOraQuery
    Left = 417
    Top = 194
  end
  inherited dsqLogin: TOraDataSource
    Left = 415
    Top = 242
  end
  inherited qVirt_Acc: TOraQuery
    Left = 281
    Top = 194
  end
  inherited dsqVirt_Acc: TOraDataSource
    Left = 279
    Top = 242
  end
  inherited pm3: TPopupMenu
    Left = 792
    Top = 64
  end
  object qSQL_TEMP: TOraQuery [21]
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  ACCOUNT_ID,'
      '  tariff_id,'
      '  abonent_id,'
      '  filial_id,'
      '  MOBILE_OPERATOR_NAME_ID,'
      '  VIRTUAL_ACCOUNTS_ID,'
      '  MOBILE_OPERATOR_NAME,'
      '  ACCOUNT_NUMBER, '
      '  login ,'
      '  ACCOUNT_NUMBER_LOGIN,'
      '  filial_name,'
      '  to_char(PHONE_ID) PHONE_ID,'
      '  surname,'
      '  VIRTUAL_ACCOUNTS_name,'
      '  tariff_name,'
      '  CALL_LOCAL,'
      '  CALL_INTERCITY,'
      '  MESSAGE,'
      '  INTERNET,  '
      '  OTHERS_SERVISES,'
      '  SUBSCRIPTION_SUM,'
      '  INTERNATIONAL_ROAMING,'
      '  NATIONAL_INTRANET_ROAMING,  '
      '  ADJUSTMENT,'
      '  PAYMENTS,'
      '  ALL_CLIENT_SCHET,'
      '  dlb.DATE_CREATED,'
      '  dlb.USER_CREATED,'
      '  dlb.USER_LAST_UPDATED,'
      '  dlb.DATE_LAST_UPDATED,'
      '  dlb.LOG_BILL_ID,'
      '  dlb.YEAR_MONTH,'
      '  dlb.MARGIN,'
      '  dlb.BILL_SUM,'
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
      '  '
      'from V_BILLS dlb,'
      '     USER_NAMES un, '
      '     USER_NAMES un2  '
      'where dlb.USER_CREATED = un.USER_NAME(+)   '
      '  and dlb.USER_LAST_UPDATED = un2.USER_NAME(+)')
    Left = 870
    Top = 251
  end
  object spCREATE_DBF_BILL_FOR_1C: TOraStoredProc
    StoredProcName = 'crEATE_DBF_BILL_FOR_1C'
    Session = Dm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := crEATE_DBF_BILL_FOR_1C(:P_YEAR_MONTH);'
      'end;')
    Left = 632
    Top = 413
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'P_YEAR_MONTH'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'crEATE_DBF_BILL_FOR_1C'
  end
  object Virt_Acc_With_Email: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT '
      'VIRTUAL_ACCOUNTS_ID, '
      '   EMAIL'
      'FROM VIRTUAL_ACCOUNTS'
      'where EMAIL is not null'
      'and VIRTUAL_ACCOUNTS_IS_ACTIVE <> 2'
      'order by VIRTUAL_ACCOUNTS_ID')
    BeforeOpen = Virt_Acc_With_EmailBeforeOpen
    Left = 1134
    Top = 267
    object Virt_Acc_With_EmailVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
      Required = True
    end
    object Virt_Acc_With_EmailEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 400
    end
  end
  object LoadersBill: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  VIRTUAL_ACCOUNTS_name,'
      '  to_char(PHONE_ID) PHONE_ID,'
      '  CALL_LOCAL,'
      '  CALL_INTERCITY,'
      '  MESSAGE,'
      '  INTERNET,  '
      '  OTHERS_SERVISES,'
      '  SUBSCRIPTION_SUM,'
      '  INTERNATIONAL_ROAMING,'
      '  NATIONAL_INTRANET_ROAMING,  '
      '  ALL_CLIENT_SCHET'
      '  from V_BILLS dlb'
      'where VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID'
      '  and dlb.YEAR_MONTH = :YEAR_MONTH')
    Left = 1134
    Top = 331
    ParamData = <
      item
        DataType = ftInteger
        Name = 'VIRTUAL_ACCOUNTS_ID'
        Value = 376
      end
      item
        DataType = ftInteger
        Name = 'YEAR_MONTH'
        Value = 201511
      end>
    object LoadersBillVIRTUAL_ACCOUNTS_NAME: TStringField
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object LoadersBillPHONE_ID: TStringField
      FieldName = 'PHONE_ID'
      Size = 40
    end
    object LoadersBillCALL_LOCAL: TFloatField
      FieldName = 'CALL_LOCAL'
    end
    object LoadersBillCALL_INTERCITY: TFloatField
      FieldName = 'CALL_INTERCITY'
    end
    object LoadersBillMESSAGE: TFloatField
      FieldName = 'MESSAGE'
    end
    object LoadersBillINTERNET: TFloatField
      FieldName = 'INTERNET'
    end
    object LoadersBillOTHERS_SERVISES: TFloatField
      FieldName = 'OTHERS_SERVISES'
    end
    object LoadersBillSUBSCRIPTION_SUM: TFloatField
      FieldName = 'SUBSCRIPTION_SUM'
    end
    object LoadersBillINTERNATIONAL_ROAMING: TFloatField
      FieldName = 'INTERNATIONAL_ROAMING'
    end
    object LoadersBillNATIONAL_INTRANET_ROAMING: TFloatField
      FieldName = 'NATIONAL_INTRANET_ROAMING'
    end
    object LoadersBillALL_CLIENT_SCHET: TFloatField
      FieldName = 'ALL_CLIENT_SCHET'
    end
  end
  object qMailParam: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT '
      '  SMPT_SERVER, SMPT_PORT,'
      '  USER_LOGIN, USER_PASSWORD,'
      '  SMPT_FROM '
      '     FROM SEND_MAIL_PARAM')
    Left = 1254
    Top = 259
    object qMailParamSMPT_SERVER: TStringField
      FieldName = 'SMPT_SERVER'
      Required = True
      Size = 400
    end
    object qMailParamSMPT_PORT: TFloatField
      FieldName = 'SMPT_PORT'
      Required = True
    end
    object qMailParamUSER_LOGIN: TStringField
      FieldName = 'USER_LOGIN'
      Required = True
      Size = 400
    end
    object qMailParamUSER_PASSWORD: TStringField
      FieldName = 'USER_PASSWORD'
      Required = True
      Size = 400
    end
    object qMailParamSMPT_FROM: TStringField
      FieldName = 'SMPT_FROM'
      Size = 2000
    end
  end
  object qSEND_MAIL_LOG: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'UPDATE SEND_MAIL_LOG'
      '   SET DELIVERED  = 1'
      ' where VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID')
    Left = 1254
    Top = 323
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'VIRTUAL_ACCOUNTS_ID'
      end>
  end
  object frxReport1: TfrxReport
    Version = '4.12.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.ShowCaptions = True
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42352.391739074100000000
    ReportOptions.LastChange = 42354.564698194440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 712
    Top = 344
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'LoadersBill'
      end>
    Variables = <
      item
        Name = ' new'
        Value = Null
      end
      item
        Name = 'period'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object PageHeader1: TfrxPageHeader
        Height = 41.692950000000000000
        Top = 139.842610000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Width = 109.606301650000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 213.165354330000000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1058#1077#1083#1077#1092#1086#1085#1080#1103' '#1084#1077#1089#1090#1085'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 316.724409448819000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1058#1077#1083#1077#1092#1086#1085#1080#1103' '#1052#1043', '#1052#1053)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 420.283464566929000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1057#1086#1086#1073#1097#1077#1085#1080#1103)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 523.842519685039000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1052#1086#1073'. '#1080#1085#1090#1077#1088#1085#1077#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 627.401574800000000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1044#1086#1087'. '#1091#1089#1083#1091#1075#1080)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 109.606299210000000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 730.960629921260000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1056#1086#1091#1084#1080#1085#1075' '#1052#1053)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 834.519685039370000000
          Width = 103.559055120000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1056#1086#1091#1084#1080#1085#1075' '#1042#1053', '#1053#1040#1062'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 938.078740160000000000
          Width = 108.850393700000000000
          Height = 41.574830000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clGradientActiveCaption
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1057#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1091)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        Height = 27.015770000000000000
        Top = 241.889920000000000000
        Width = 1046.929810000000000000
        AllowSplit = True
        ColumnWidth = 90.708661417322800000
        ColumnGap = 37.795275590551200000
        DataSet = frxDBDataset1
        DataSetName = 'LoadersBill'
        RowCount = 0
        Stretched = True
        object frxDBDataset1PHONE_ID: TfrxMemoView
          Width = 109.606299210000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          LineSpacing = 1.000000000000000000
          Memo.UTF8W = (
            '[LoadersBill."PHONE_ID"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1CALL_INTERCITY: TfrxMemoView
          Left = 316.724409450000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."CALL_INTERCITY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1MESSAGE: TfrxMemoView
          Left = 420.283464570000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."MESSAGE"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1INTERNET: TfrxMemoView
          Left = 523.842519690000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."INTERNET"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1SUBSCRIPTION_SUM: TfrxMemoView
          Left = 109.606299210000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."SUBSCRIPTION_SUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1INTERNATIONAL_ROAMING: TfrxMemoView
          Left = 730.960629920000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."INTERNATIONAL_ROAMING"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1NATIONAL_INTRANET_ROAMING: TfrxMemoView
          Left = 834.519685040000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."NATIONAL_INTRANET_ROAMING"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1CALL_LOCAL: TfrxMemoView
          Left = 213.165354330000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."CALL_LOCAL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDataset1ALL_CLIENT_SCHET: TfrxMemoView
          Left = 938.078740160000000000
          Width = 108.850393700000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."ALL_CLIENT_SCHET"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 627.401574800000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'LoadersBill'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -1
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Color = 16777173
          Highlight.Condition = '<Line>mod 2 = 1'
          Memo.UTF8W = (
            '[LoadersBill."OTHERS_SERVISES"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 98.165430000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo11: TfrxMemoView
          Top = 1.779530000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1090#1095#1077#1090' '#1087#1086' '#1088#1072#1089#1093#1086#1076#1072#1084' '#1079#1072' '#1091#1089#1083#1091#1075#1080' '#1089#1077#1090#1080' '#1054#1054#1054' "'#1048#1085#1090#1077#1088#1085#1077#1090' '#1057#1080#1089#1090#1077#1084#1099'"')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Top = 49.031540000000000000
          Width = 1046.929810000000000000
          Height = 49.133890000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1076#1083#1103' [LoadersBill."VIRTUAL_ACCOUNTS_NAME"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo11: TfrxSysMemoView
          Top = 25.015770000000000000
          Width = 1046.929810000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1079#1072' '#1087#1077#1088#1080#1086#1076' [PERIOD]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        Height = 30.236240000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object SysMemo1: TfrxSysMemoView
          Left = 938.078740160000000000
          Width = 108.850393700000000000
          Height = 30.236220470000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."ALL_CLIENT_SCHET">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Width = 109.606299210000000000
          Height = 30.236220472440900000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            #1048#1090#1086#1075#1086)
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo2: TfrxSysMemoView
          Left = 213.165354330000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."CALL_LOCAL">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo4: TfrxSysMemoView
          Left = 316.724409450000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."CALL_INTERCITY">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo5: TfrxSysMemoView
          Left = 420.283464570000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."MESSAGE">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo6: TfrxSysMemoView
          Left = 523.842519690000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."INTERNET">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo7: TfrxSysMemoView
          Left = 627.401574800000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."OTHERS_SERVISES">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo8: TfrxSysMemoView
          Left = 109.606299210000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."SUBSCRIPTION_SUM">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo9: TfrxSysMemoView
          Left = 730.960629920000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."INTERNATIONAL_ROAMING">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object SysMemo10: TfrxSysMemoView
          Left = 834.519685040000000000
          Width = 103.559055120000000000
          Height = 30.236220472440900000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = [fsBold]
          Highlight.Color = clMoneyGreen
          Highlight.Condition = '1'
          Memo.UTF8W = (
            '[SUM(<LoadersBill."NATIONAL_INTRANET_ROAMING">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 30.236220472440900000
        Top = 381.732530000000000000
        Width = 1046.929810000000000000
        object SysMemo3: TfrxSysMemoView
          Left = 887.189550000000000000
          Width = 154.960730000000000000
          Height = 30.236220470000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            #1057#1090#1088'. [PAGE#] '#1080#1079' [TOTALPAGES#]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'LoadersBill'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = LoadersBill
    BCDToCurrency = True
    Left = 1216
    Top = 416
  end
  object dsLoadersBill: TDataSource
    DataSet = LoadersBill
    Left = 1120
    Top = 392
  end
  object frxPDFExport1: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = False
    OverwritePrompt = False
    CreationTime = 42353.712164988430000000
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = True
    HTMLTags = True
    Title = #1054#1090#1095#1077#1090' '#1087#1086' '#1076#1086#1093#1086#1076#1072#1084' '#1079#1072' '#1091#1089#1083#1091#1075#1080
    Author = 'SmartCard'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 792
    Top = 352
  end
end
