inherited RepPaymentsHist: TRepPaymentsHist
  Caption = 'RepPaymentsHist'
  ClientWidth = 712
  Position = poMainFormCenter
  Visible = False
  ExplicitWidth = 728
  ExplicitHeight = 631
  PixelsPerInch = 96
  TextHeight = 13
  inherited sSplitter1: TsSplitter
    Width = 712
    ExplicitWidth = 1169
  end
  inherited sStatusBar1: TsStatusBar
    Width = 712
    ExplicitWidth = 646
  end
  inherited CRGrid: TCRDBGrid
    Width = 712
    Columns = <
      item
        Expanded = False
        FieldName = 'HIST_DATE_CREATED'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_PAY'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INN'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_ID'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYER_BIK'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_PAY'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC_NUMBER'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_PURPOSE'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILE_NAME'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Title.Alignment = taCenter
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
        FieldName = 'DATE_CREATED_'
        Title.Alignment = taCenter
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
        FieldName = 'USER_LAST_UPDATED_FIO'
        Title.Alignment = taCenter
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
        FieldName = 'DATE_LAST_UPDATED_'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  inherited sScrollBox1: TsScrollBox
    Width = 712
    ExplicitWidth = 646
    inherited spMobOper: TsPanel
      Width = 0
      ExplicitWidth = 0
    end
    inherited spFilial: TsPanel
      Left = 0
      Width = 0
      ExplicitLeft = 0
      ExplicitWidth = 0
    end
    inherited spVirtAcc: TsPanel
      Left = 0
      Width = 353
      Visible = True
      ExplicitLeft = 0
      ExplicitWidth = 353
      inherited CLB_VirtAcc: TsCheckListBox
        Width = 230
        ExplicitWidth = 230
      end
    end
    inherited spAccount: TsPanel
      Left = 353
      Width = 0
      ExplicitLeft = 353
      ExplicitWidth = 0
    end
    inherited cbPeriod: TsComboBox
      Left = 434
      Top = 23
      BoundLabel.Caption = #1055#1077#1088#1080#1086#1076' c:'
      Visible = True
      ExplicitLeft = 434
      ExplicitTop = 23
    end
    inherited spFiltrSearch: TsPanel
      Left = 423
      Top = 155
      Width = 193
      Visible = False
      ExplicitLeft = 423
      ExplicitTop = 155
      ExplicitWidth = 193
    end
    inherited spShow: TsPanel
      Left = 357
      Top = 77
      Width = 252
      ExplicitLeft = 357
      ExplicitTop = 77
      ExplicitWidth = 252
      inherited sBevel1: TsBevel
        Left = 113
        ExplicitLeft = 113
      end
      inherited sBevel2: TsBevel
        Left = 222
        ExplicitLeft = 222
      end
      inherited sbToExcel: TsSpeedButton [2]
        Left = 117
        ExplicitLeft = 117
      end
      inherited sbInfoShow: TsSpeedButton [3]
        Left = 228
        Width = 9
        ExplicitLeft = 228
        ExplicitWidth = 9
      end
      inherited sbShowSel: TsSpeedButton [4]
        Left = 8
        ExplicitLeft = 8
      end
    end
    inherited pButtonMove: TsPanel
      Left = 367
      Top = 122
      ExplicitLeft = 367
      ExplicitTop = 122
    end
    object cbPeriodAfter: TsComboBox
      Left = 434
      Top = 51
      Width = 132
      Height = 22
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1087#1086':'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 8
    end
  end
  inherited actlst1: TActionList
    inherited aDelete: TAction
      Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      Enabled = False
      Visible = False
    end
  end
  inherited qReport: TOraQuery
    SQLRefresh.Strings = (
      'select '
      '  DATE_PAY,'
      '  VIRTUAL_ACCOUNTS_NAME,'
      '  INN,'
      '  PHONE_ID,'
      '  SUM_PAY,'
      '  DOC_NUMBER,'
      '  PAYMENT_PURPOSE,'
      '  file_name,'
      '  PAYER_BIK,'
      '  VIRTUAL_ACCOUNT_ID,'
      '  PAYMENT_ID'
      '  from'
      '  V_PAYMENTS'
      'where'
      '  PAYMENT_ID := :NEW_PAYMENT_ID')
    SQL.Strings = (
      
        '/*'#1058#1045#1050#1057#1058' '#1047#1040#1055#1056#1054#1057#1040' '#1060#1054#1056#1052#1048#1056#1059#1045#1058#1057#1071' '#1044#1048#1053#1040#1052#1048#1063#1045#1057#1050#1048', '#1054#1057#1053#1040#1042#1053#1040#1071' '#1063#1040#1057#1058#1068' '#1041#1045#1056#1045#1058#1057#1071' ' +
        #1048#1047' qSQL_TEMP*/'
      'SELECT '
      '      ph.PAYMENT_ID, '
      '      ph.VIRTUAL_ACCOUNT_ID, '
      '      to_char(ph.PHONE_ID) PHONE_ID, '
      '      ph.INN, '
      '      ph.DATE_PAY, '
      '      ph.SUM_PAY, '
      '      ph.DOC_NUMBER, '
      '      ph.PAYMENT_PURPOSE, '
      '      ph.USER_CREATED, '
      '      ph.DATE_CREATED, '
      '      ph.USER_LAST_UPDATED, '
      '      ph.DATE_LAST_UPDATED, '
      '      ph.PAYMENT_FILE_ID, '
      '      ph.YEAR_MONTH, '
      '      ph.PAYER_BIK, '
      '      ph.PAYMANT_ID_HIST, '
      '      ph.STATE,'
      '      va.VIRTUAL_ACCOUNTS_NAME,'
      
        '      case when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| p' +
        'h.USER_CREATED else un.USER_FIO end USER_CREATED_FIO,'
      '      ph.DATE_CREATED  DATE_CREATED_,'
      
        '      case when nvl(un2.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| ' +
        'ph.USER_LAST_UPDATED else un2.USER_FIO end USER_LAST_UPDATED_FIO' +
        ','
      '      ph.DATE_LAST_UPDATED DATE_LAST_UPDATED_,'
      '      pf.FILE_NAME,'
      '      ph.HIST_DATE_CREATED '
      'FROM PAYMANTS_HIST ph, '
      '     VIRTUAL_ACCOUNTS va,'
      '     USER_NAMES un, '
      '     USER_NAMES un2,'
      '     PAYMENTS_FILES pf  '
      'where va.VIRTUAL_ACCOUNTS_ID = ph.VIRTUAL_ACCOUNT_ID'
      '  and ph.PAYMENT_FILE_ID = pf.FILE_ID(+)  '
      '  and ph.year_month >= :year_month_start'
      '  and ph.year_month <= :year_month_end'
      '  and (ph.PAYMENT_ID = :PAYMENT_ID or :PAYMENT_ID is null)'
      '  and ph.USER_CREATED = un.USER_NAME(+)   '
      '  and ph.USER_LAST_UPDATED = un2.USER_NAME(+)')
    Left = 143
    Top = 241
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'year_month_start'
      end
      item
        DataType = ftUnknown
        Name = 'year_month_end'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_ID'
      end>
    object qReportVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1042#1080#1088#1090'. '#1089#1095#1077#1090
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object qReportPAYMENT_ID: TFloatField
      FieldName = 'PAYMENT_ID'
      Visible = False
    end
    object qReportVIRTUAL_ACCOUNT_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNT_ID'
      Visible = False
    end
    object qReportINN: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Size = 48
    end
    object qReportPHONE_ID: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_ID'
      Size = 40
    end
    object qReportDATE_PAY: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'DATE_PAY'
    end
    object qReportSUM_PAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'SUM_PAY'
    end
    object qReportDOC_NUMBER: TStringField
      DisplayLabel = #8470' '#1044#1086#1082#1091#1084#1077#1085#1090#1072
      FieldName = 'DOC_NUMBER'
      Size = 40
    end
    object qReportPAYMENT_PURPOSE: TStringField
      DisplayLabel = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'PAYMENT_PURPOSE'
      Size = 2000
    end
    object qReportUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Visible = False
      Size = 120
    end
    object qReportDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
      Visible = False
    end
    object qReportUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Visible = False
      Size = 120
    end
    object qReportDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
      Visible = False
    end
    object qReportPAYMENT_FILE_ID: TFloatField
      FieldName = 'PAYMENT_FILE_ID'
      Visible = False
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Visible = False
    end
    object qReportPAYER_BIK: TFloatField
      DisplayLabel = #1041#1048#1050' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
      FieldName = 'PAYER_BIK'
    end
    object qReportPAYMANT_ID_HIST: TFloatField
      FieldName = 'PAYMANT_ID_HIST'
      Required = True
      Visible = False
    end
    object qReportSTATE: TStringField
      DisplayLabel = #1048#1079#1084#1077#1085#1077#1085#1080#1077
      FieldName = 'STATE'
      Required = True
      Size = 120
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
    object qReportFILE_NAME: TStringField
      DisplayLabel = #1048#1084#1103' '#1092#1072#1081#1083#1072
      FieldName = 'FILE_NAME'
      Size = 50
    end
    object qReportHIST_DATE_CREATED: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1079#1072#1087#1080#1089#1080' '#1074' '#1080#1089#1090#1086#1088#1080#1102
      FieldName = 'HIST_DATE_CREATED'
      Required = True
    end
  end
  inherited dsqReport: TOraDataSource
    Left = 160
    Top = 376
  end
  inherited qVirt_Acc: TOraQuery
    SQL.Strings = (
      'select  '
      '    v.VIRTUAL_ACCOUNTS_ID, '
      '    v.VIRTUAL_ACCOUNTS_name,'
      '    v.INN '
      '    from VIRTUAL_ACCOUNTS v'
      'order by v.VIRTUAL_ACCOUNTS_name')
    BeforeOpen = nil
  end
  inherited pm3: TPopupMenu
    Left = 89
    Top = 310
  end
  object qSQL_TEMP: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT '
      '      ph.PAYMENT_ID, '
      '      ph.VIRTUAL_ACCOUNT_ID, '
      '      to_char(ph.PHONE_ID) PHONE_ID, '
      '      ph.INN, '
      '      ph.DATE_PAY, '
      '      ph.SUM_PAY, '
      '      ph.DOC_NUMBER, '
      '      ph.PAYMENT_PURPOSE, '
      '      ph.USER_CREATED, '
      '      ph.DATE_CREATED, '
      '      ph.USER_LAST_UPDATED, '
      '      ph.DATE_LAST_UPDATED, '
      '      ph.PAYMENT_FILE_ID, '
      '      ph.YEAR_MONTH, '
      '      ph.PAYER_BIK, '
      '      ph.PAYMANT_ID_HIST, '
      '      ph.STATE,'
      '      va.VIRTUAL_ACCOUNTS_NAME,'
      
        '      case when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| p' +
        'h.USER_CREATED else un.USER_FIO end USER_CREATED_FIO,'
      '      ph.DATE_CREATED  DATE_CREATED_,'
      
        '      case when nvl(un2.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| ' +
        'ph.USER_LAST_UPDATED else un2.USER_FIO end USER_LAST_UPDATED_FIO' +
        ','
      '      ph.DATE_LAST_UPDATED DATE_LAST_UPDATED_,'
      '      pf.FILE_NAME,'
      '      ph.HIST_DATE_CREATED '
      'FROM PAYMANTS_HIST ph, '
      '     VIRTUAL_ACCOUNTS va,'
      '     USER_NAMES un, '
      '     USER_NAMES un2,'
      '     PAYMENTS_FILES pf  '
      'where va.VIRTUAL_ACCOUNTS_ID = ph.VIRTUAL_ACCOUNT_ID'
      '  and ph.PAYMENT_FILE_ID = pf.FILE_ID(+)  '
      '  and ph.year_month >= :year_month_start'
      '  and ph.year_month <= :year_month_end'
      '  and (ph.PAYMENT_ID = :PAYMENT_ID or :PAYMENT_ID is null)'
      '  and ph.USER_CREATED = un.USER_NAME(+)   '
      '  and ph.USER_LAST_UPDATED = un2.USER_NAME(+)')
    FetchRows = 1000
    Filtered = True
    Left = 199
    Top = 241
    ParamData = <
      item
        DataType = ftInteger
        Name = 'year_month_start'
        ParamType = ptInput
        Value = 201511
      end
      item
        DataType = ftInteger
        Name = 'year_month_end'
        ParamType = ptInput
        Value = 201511
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_ID'
      end>
    object DateTimeField1: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'DATE_PAY'
      Required = True
    end
    object StringField1: TStringField
      DisplayLabel = #1042#1080#1088#1090'. '#1089#1095#1077#1090
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 200
    end
    object StringField2: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Size = 48
    end
    object FloatField1: TFloatField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_ID'
    end
    object FloatField2: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'SUM_PAY'
      Required = True
    end
    object StringField3: TStringField
      DisplayLabel = #8470' '#1044#1086#1082#1091#1084#1077#1085#1090#1072
      FieldName = 'DOC_NUMBER'
      Required = True
      Size = 40
    end
    object StringField4: TStringField
      DisplayLabel = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'PAYMENT_PURPOSE'
      Size = 2000
    end
    object StringField5: TStringField
      DisplayLabel = #1048#1084#1103' '#1092#1072#1081#1083#1072
      FieldName = 'FILE_NAME'
      Size = 50
    end
    object qSQL_TEMPPAYER_BIK: TFloatField
      FieldName = 'PAYER_BIK'
    end
    object qSQL_TEMPVIRTUAL_ACCOUNT_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNT_ID'
    end
  end
  object OQ: TOraQuery
    Left = 1040
    Top = 384
  end
end
