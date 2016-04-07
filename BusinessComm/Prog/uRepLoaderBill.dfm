inherited RepLoaderBillFrm: TRepLoaderBillFrm
  Left = 549
  Top = 405
  Caption = 'RepLoaderBillFrm'
  ClientHeight = 541
  ClientWidth = 798
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 806
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter1: TsSplitter
    Left = 0
    Top = 107
    Width = 798
    Height = 6
    Cursor = crVSplit
    ParentCustomHint = False
    Align = alTop
    Color = clSkyBlue
    ParentColor = False
    ResizeStyle = rsLine
    Visible = False
    Glyph.Data = {
      EE020000424DEE0200000000000036000000280000003A000000030000000100
      200000000000B802000000000000000000000000000000000000FFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF46DE79FF2FDE6AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF30E96CFF30E96CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF46DE79FF2FDE6AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF30E96CFF30E96CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFFFFFFFFFF40E67AFF34E776FF27E767FF28E9
      6BFFFFFFFFFFFFFFFFFF2FE970FF2AEA6CFF2AEA6CFF18FF5FFFFFFFFFFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFFFFFFFFFF40E67AFF34E776FF27E767FF28E9
      6BFFFFFFFFFFFFFFFFFF2FE970FF2AEA6CFF2AEA6CFF18FF5FFFFFFFFFFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2DEA
      6FFF2FE970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A9C47FF1A9C47FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2DEA
      6FFF2FE970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A9C47FF1A9C47FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFF}
    ShowGrip = True
    SkinData.SkinSection = 'SPLITTER'
    ExplicitTop = 97
    ExplicitWidth = 928
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 522
    Width = 798
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Style = psOwnerDraw
        Width = 200
      end>
    SkinData.SkinSection = 'STATUSBAR'
    ExplicitTop = 462
    ExplicitWidth = 736
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 798
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    ExplicitWidth = 736
    object sLabel1: TsLabel
      Left = 14
      Top = 9
      Width = 86
      Height = 13
      Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090':'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object sAll: TsSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 28
      Width = 96
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aCheckedAll
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 49
      Images = Dm.ImageList24
    end
    object s_cancel: TsSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 64
      Width = 96
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aUncheckedAll
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 50
      Images = Dm.ImageList24
    end
    object sPanel2: TsPanel
      Left = 388
      Top = 60
      Width = 328
      Height = 34
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sBevel1: TsBevel
        Left = 103
        Top = 1
        Width = 3
        Height = 38
      end
      object sBevel2: TsBevel
        Left = 210
        Top = 2
        Width = 3
        Height = 38
      end
      object sSpeedButton1: TsSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 100
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aRefresh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 9
        Images = Dm.ImageList24
      end
      object sSpeedButton2: TsSpeedButton
        AlignWithMargins = True
        Left = 108
        Top = 1
        Width = 100
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aToExcel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 45
        Images = Dm.ImageList24
      end
      object sSpeedButton3: TsSpeedButton
        AlignWithMargins = True
        Left = 215
        Top = 1
        Width = 109
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 17
        Images = Dm.ImageList24
      end
    end
    object sPanel3: TsPanel
      Left = 564
      Top = 15
      Width = 171
      Height = 32
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object sBevel4: TsBevel
        Left = 84
        Top = 1
        Width = 3
        Height = 38
      end
      object sBitBtn4: TsBitBtn
        Left = 89
        Top = 0
        Width = 80
        Height = 31
        Action = aFiltr
        Caption = #1060#1080#1083#1100#1090#1088
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
        Down = True
        ImageIndex = 13
        Images = Dm.ImageList24
      end
      object sBitBtn5: TsBitBtn
        Left = 2
        Top = 0
        Width = 80
        Height = 31
        Action = aFind
        Caption = #1055#1086#1080#1089#1082
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
        Down = True
        ImageIndex = 15
        Images = Dm.ImageList24
      end
    end
    object cbPeriod: TsComboBox
      Left = 434
      Top = 20
      Width = 129
      Height = 22
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1052#1077#1089#1103#1094':'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object CLB_Accounts: TsCheckListBox
      Left = 103
      Top = 1
      Width = 279
      Height = 104
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
      BorderStyle = bsSingle
      Color = clWhite
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      PopupMenu = pm1
      TabOrder = 3
      Visible = False
      BoundLabel.Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
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
  object cRGrid: TCRDBGrid
    Left = 0
    Top = 113
    Width = 798
    Height = 409
    Align = alClient
    DataSource = dsqReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleFont.Quality = fqClearTypeNatural
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 520
    Top = 164
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      ImageIndex = 7
      ShortCut = 16467
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
      ShortCut = 27
    end
    object aRefresh: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
      Enabled = False
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aFind: TAction
      AutoCheck = True
      Caption = #1055#1086#1080#1089#1082
      Enabled = False
      Hint = #1055#1086#1080#1089#1082' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+G'
      ImageIndex = 15
      ShortCut = 16455
      OnExecute = aFindExecute
    end
    object aFiltr: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+A'
      ImageIndex = 13
      ShortCut = 16449
      OnExecute = aFiltrExecute
    end
    object aNext: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
    end
    object aLast: TAction
      Caption = 'aLast'
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Enabled = False
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcelExecute
    end
    object aInfo: TAction
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Enabled = False
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1073#1086#1085#1077#1085#1090#1077
      ImageIndex = 17
      OnExecute = aInfoExecute
    end
    object aCheckedAll: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAllExecute
    end
    object aUncheckedAll: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      Enabled = False
      ImageIndex = 50
      OnExecute = aUncheckedAllExecute
    end
  end
  object pm1: TPopupMenu
    Left = 240
    Top = 16
    object D1: TMenuItem
      Action = aCheckedAll
    end
    object N1: TMenuItem
      Action = aUncheckedAll
    end
  end
  object qMonthYearforRepFrm: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      'p.YEARS, '
      'p.MONTHS, '
      'p.YEAR_MONTH,'
      'CASE p.MONTHS'
      '   WHEN  1 THEN '#39'  '#1071#1085#1074#1072#1088#1100' - '#39'||p.YEARS '
      '   WHEN  2 THEN '#39' '#1060#1077#1074#1088#1072#1083#1100' - '#39'||p.YEARS'
      '   WHEN  3 THEN '#39'    '#1052#1072#1088#1090' - '#39'||p.YEARS'
      '   WHEN  4 THEN '#39'  '#1040#1087#1088#1077#1083#1100' - '#39'||p.YEARS'
      '   WHEN  5 THEN '#39'     '#1052#1072#1081' - '#39'||p.YEARS'
      '   WHEN  6 THEN '#39'    '#1048#1102#1085#1100' - '#39'||p.YEARS'
      '   WHEN  7 THEN '#39'    '#1048#1102#1083#1100' - '#39'||p.YEARS'
      '   WHEN  8 THEN '#39'  '#1040#1074#1075#1091#1089#1090' - '#39'||p.YEARS'
      '   WHEN  9 THEN '#39#1057#1077#1085#1090#1103#1073#1088#1100' - '#39'||p.YEARS'
      '   WHEN 10 THEN '#39' '#1054#1082#1090#1103#1073#1088#1100' - '#39'||p.YEARS'
      '   WHEN 11 THEN '#39'  '#1053#1086#1103#1073#1088#1100' - '#39'||p.YEARS'
      '   WHEN 12 THEN '#39' '#1044#1077#1082#1072#1073#1088#1100' - '#39'||p.YEARS'
      '    END YEAR_MONTH_NAME '
      'from periods p '
      'where p.IS_ACTIVE = 1 '
      'order by YEAR_MONTH')
    Left = 142
    Top = 275
    object qMonthYearforRepFrmYEARS: TFloatField
      FieldName = 'YEARS'
      Required = True
    end
    object qMonthYearforRepFrmMONTHS: TFloatField
      FieldName = 'MONTHS'
      Required = True
    end
    object qMonthYearforRepFrmYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qMonthYearforRepFrmYEAR_MONTH_NAME: TStringField
      FieldName = 'YEAR_MONTH_NAME'
      Size = 59
    end
  end
  object qAccount: TOraQuery
    UpdatingTable = 'ACCOUNTS'
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT account_id, ACCOUNT_NUMBER, login,'
      'ACCOUNT_NUMBER||'#39'; '#39'||login  ACCOUNT_NUMBER_LOGIN'
      'FROM ACCOUNTS '
      'where MOBILE_OPERATOR_NAME_ID is not null'
      'ORDER BY ACCOUNT_NUMBER ASC')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    Left = 33
    Top = 170
    object qAccountACCOUNT_ID: TFloatField
      DisplayWidth = 13
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qAccountLOGIN: TStringField
      DisplayWidth = 58
      FieldName = 'LOGIN'
      Size = 30
    end
    object qAccountACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
      Required = True
    end
    object qAccountACCOUNT_NUMBER_LOGIN: TStringField
      FieldName = 'ACCOUNT_NUMBER_LOGIN'
      Size = 72
    end
  end
  object dsqAccount: TOraDataSource
    Tag = 1
    DataSet = qAccount
    Left = 31
    Top = 218
  end
  object qReport: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT '
      '  dlb.BILL_ID,'
      '  dlb.ACCOUNT_ID,'
      '  dlb.YEAR_MONTH,'
      '  dlb.PHONE_ID,'
      '  dlb.DATE_BEGIN,'
      '  dlb.DATE_END,'
      '  dlb.TARIFF_CODE,'
      '  dlb.BILL_SUM,'
      '  dlb.SUBSCRIBER_PAYMENT_MAIN,'
      '  dlb.SUBSCRIBER_PAYMENT_ADD,'
      '  dlb.SINGLE_PAYMENTS,'
      '  dlb.CALLS_LOCAL_COST,'
      '  dlb.CALLS_OTHER_CITY_COST,'
      '  dlb.CALLS_OTHER_COUNTRY_COST,'
      '  dlb.MESSAGES_COST,'
      '  dlb.INTERNET_COST,'
      '  dlb.OTHER_COUNTRY_ROAMING_COST,'
      '  dlb.NATIONAL_ROAMING_COST,'
      '  dlb.PENI_COST,'
      '  dlb.DISCOUNT_VALUE,'
      '  dlb.OTHER_COUNTRY_ROAMING_CALLS,'
      '  dlb.OTHER_COUNTRY_ROAMING_MESSAGES,'
      '  dlb.OTHER_COUNTRY_ROAMING_INTERNET,'
      '  dlb.NATIONAL_ROAMING_CALLS,'
      '  dlb.NATIONAL_ROAMING_MESSAGES,'
      '  dlb.NATIONAL_ROAMING_INTERNET '
      '  from DB_LOADER_BILLS dlb'
      '  where dlb.YEAR_MONTH = :YEAR_MONTH'
      '  and dlb.ACCOUNT_ID = :ACCOUNT_ID')
    BeforeOpen = qReportBeforeOpen
    Left = 398
    Top = 179
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
        Value = Null
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
        Value = Null
      end>
    object qReportBILL_ID: TFloatField
      FieldName = 'BILL_ID'
      Required = True
      Visible = False
    end
    object qReportACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
      Visible = False
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
      Visible = False
    end
    object qReportPeriod: TStringField
      DisplayLabel = #1052#1077#1089#1103#1094' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093
      FieldKind = fkLookup
      FieldName = 'Period'
      LookupDataSet = qMonthYearforRepFrm
      LookupKeyFields = 'YEAR_MONTH'
      LookupResultField = 'YEAR_MONTH_NAME'
      KeyFields = 'YEAR_MONTH'
      Size = 60
      Lookup = True
    end
    object qReportACCOUNT_NAME: TStringField
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      FieldKind = fkLookup
      FieldName = 'ACCOUNT_NAME'
      LookupDataSet = qAccount
      LookupKeyFields = 'ACCOUNT_ID'
      LookupResultField = 'ACCOUNT_NUMBER_LOGIN'
      KeyFields = 'ACCOUNT_ID'
      Size = 100
      Lookup = True
    end
    object qReportPHONE: TIntegerField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldKind = fkLookup
      FieldName = 'PHONE'
      LookupDataSet = Dm.qPhones
      LookupKeyFields = 'PHONE_ID'
      LookupResultField = 'PHONE_NUMBER'
      KeyFields = 'PHONE_ID'
      Lookup = True
    end
    object qReportPHONE_ID: TFloatField
      FieldName = 'PHONE_ID'
      Required = True
      Visible = False
    end
    object qReportDATE_BEGIN: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1077#1088#1080#1086#1076#1072
      FieldName = 'DATE_BEGIN'
    end
    object qReportDATE_END: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072
      FieldName = 'DATE_END'
    end
    object qReportTARIFF_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qReportBILL_SUM: TFloatField
      DisplayLabel = #1053#1072#1095#1080#1089#1083#1077#1085#1085#1072#1103' '#1089#1091#1084#1084#1072
      FieldName = 'BILL_SUM'
    end
    object qReportSUBSCRIBER_PAYMENT_MAIN: TFloatField
      DisplayLabel = #1040#1073#1086#1085#1077#1085#1090#1089#1082#1072#1103' '#1087#1083#1072#1090#1072' '#1087#1086' '#1090#1072#1088#1080#1092#1091
      FieldName = 'SUBSCRIBER_PAYMENT_MAIN'
    end
    object qReportSUBSCRIBER_PAYMENT_ADD: TFloatField
      DisplayLabel = #1040#1073#1086#1085#1087#1083#1072#1090#1072' '#1079#1072' '#1076#1086#1087'. '#1091#1089#1083#1091#1075#1080
      FieldName = 'SUBSCRIBER_PAYMENT_ADD'
    end
    object qReportSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079#1086#1074#1099#1077' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      FieldName = 'SINGLE_PAYMENTS'
    end
    object qReportCALLS_LOCAL_COST: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1077#1089#1090#1085#1099#1093' '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'CALLS_LOCAL_COST'
    end
    object qReportCALLS_OTHER_CITY_COST: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1077#1078#1076#1091#1075#1086#1088#1086#1076#1085#1080#1093' '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'CALLS_OTHER_CITY_COST'
    end
    object qReportCALLS_OTHER_COUNTRY_COST: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1093' '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'CALLS_OTHER_COUNTRY_COST'
    end
    object qReportMESSAGES_COST: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' (SMS, MMS)'
      FieldName = 'MESSAGES_COST'
    end
    object qReportINTERNET_COST: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090#1072
      FieldName = 'INTERNET_COST'
    end
    object qReportOTHER_COUNTRY_ROAMING_COST: TFloatField
      DisplayLabel = #1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'OTHER_COUNTRY_ROAMING_COST'
    end
    object qReportNATIONAL_ROAMING_COST: TFloatField
      DisplayLabel = #1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'NATIONAL_ROAMING_COST'
    end
    object qReportPENI_COST: TFloatField
      DisplayLabel = #1053#1072#1095#1080#1089#1083#1077#1085#1085#1099#1077' '#1087#1077#1085#1080
      FieldName = 'PENI_COST'
    end
    object qReportDISCOUNT_VALUE: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      FieldName = 'DISCOUNT_VALUE'
    end
    object qReportOTHER_COUNTRY_ROAMING_CALLS: TFloatField
      DisplayLabel = #1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' '#1069#1092#1080#1088#1085#1086#1077' '#1074#1088#1077#1084#1103' ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'OTHER_COUNTRY_ROAMING_CALLS'
    end
    object qReportOTHER_COUNTRY_ROAMING_MESSAGES: TFloatField
      DisplayLabel = #1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' SMS ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'OTHER_COUNTRY_ROAMING_MESSAGES'
    end
    object qReportOTHER_COUNTRY_ROAMING_INTERNET: TFloatField
      DisplayLabel = #1052#1077#1078#1076#1091#1085#1072#1088#1086#1076#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' GPRS ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'OTHER_COUNTRY_ROAMING_INTERNET'
    end
    object qReportNATIONAL_ROAMING_CALLS: TFloatField
      DisplayLabel = #1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' '#1069#1092#1080#1088#1085#1086#1077' '#1074#1088#1077#1084#1103' ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'NATIONAL_ROAMING_CALLS'
    end
    object qReportNATIONAL_ROAMING_MESSAGES: TFloatField
      DisplayLabel = #1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' SMS ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'NATIONAL_ROAMING_MESSAGES'
    end
    object qReportNATIONAL_ROAMING_INTERNET: TFloatField
      DisplayLabel = #1053#1072#1094#1080#1086#1085#1072#1083#1100#1085#1099#1081' '#1088#1086#1091#1084#1080#1085#1075' GPRS ('#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1072#1088#1090#1085#1077#1088#1072')'
      FieldName = 'NATIONAL_ROAMING_INTERNET'
    end
  end
  object dsqReport: TOraDataSource
    Tag = 1
    DataSet = qReport
    Left = 399
    Top = 234
  end
end
