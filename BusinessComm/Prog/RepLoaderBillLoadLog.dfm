inherited RepLoaderBillLoadLogFrm: TRepLoaderBillLoadLogFrm
  Caption = 'RepLoaderBillLoadLogFrm'
  ExplicitWidth = 1442
  ExplicitHeight = 631
  DesignSize = (
    1426
    593)
  PixelsPerInch = 96
  TextHeight = 13
  inherited sSplitter1: TsSplitter
    ExplicitWidth = 1692
  end
  inherited CRGrid: TCRDBGrid
    ParentFont = False
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'Period'
        Title.Alignment = taCenter
        Width = 225
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Account_name'
        Title.Alignment = taCenter
        Width = 194
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILE_NAME'
        Title.Alignment = taCenter
        Width = 324
        Visible = True
      end
      item
        ButtonStyle = cbsNone
        Expanded = False
        FieldName = 'DATA_EXIST'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME_STATUS'
        Title.Alignment = taCenter
        Width = 214
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR_LOAD'
        Title.Alignment = taCenter
        Width = 438
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNT'
        Width = 259
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LENGTH_BL'
        Width = 181
        Visible = True
      end>
  end
  object sPanel4: TsPanel [3]
    Left = 309
    Top = 212
    Width = 488
    Height = 130
    Anchors = []
    BevelInner = bvRaised
    BevelKind = bkSoft
    TabOrder = 2
    Visible = False
    SkinData.SkinSection = 'PANEL'
    object sBevel11: TsBevel
      Left = 11
      Top = 22
      Width = 214
      Height = 65
    end
    object sBevel12: TsBevel
      Left = 235
      Top = 22
      Width = 237
      Height = 65
    end
    object sLabel3: TsLabel
      Left = 74
      Top = 28
      Width = 115
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = #1042#1099#1073#1077#1088#1080' '#1087#1077#1088#1080#1086#1076
      ParentFont = False
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object sLabel4: TsLabel
      Left = 288
      Top = 28
      Width = 137
      Height = 19
      Alignment = taCenter
      AutoSize = False
      Caption = #1042#1099#1073#1077#1088#1080' '#1083#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      ParentFont = False
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object sPanel5: TsPanel
      Left = 2
      Top = 90
      Width = 480
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      DesignSize = (
        480
        34)
      object sBsave: TsBitBtn
        Left = 221
        Top = 2
        Width = 99
        Height = 31
        Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
        Anchors = [akTop, akRight]
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Default = True
        Enabled = False
        TabOrder = 0
        OnClick = sBsaveClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 7
        Images = Dm.ImageList24
      end
      object sBClose: TsBitBtn
        Left = 360
        Top = 2
        Width = 99
        Height = 31
        Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        TabOrder = 1
        OnClick = sBCloseClick
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 8
        Images = Dm.ImageList24
      end
    end
    object dblkcbbYEAR_MONTH: TDBLookupComboBox
      Left = 22
      Top = 52
      Width = 158
      Height = 21
      DataField = 'YEAR_MONTH'
      DataSource = dsqBlob2
      KeyField = 'YEAR_MONTH'
      ListField = 'YEAR_MONTH_NAME'
      ListSource = dsqMonthYearforRepFrm
      TabOrder = 1
      OnClick = dblkcbbYEAR_MONTHClick
    end
    object dblkcbbACCOUNT_ID: TDBLookupComboBox
      Left = 243
      Top = 52
      Width = 221
      Height = 21
      DataField = 'ACCOUNT_ID'
      DataSource = dsqBlob2
      KeyField = 'ACCOUNT_ID'
      ListField = 'NNMM'
      ListSource = dsqAccount2
      TabOrder = 2
      OnClick = dblkcbbACCOUNT_IDClick
    end
    object sBitBtn1: TsBitBtn
      Left = 190
      Top = 51
      Width = 25
      Height = 24
      Caption = 'sBitBtn1'
      Margin = 0
      TabOrder = 3
      OnClick = sBitBtn1Click
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 36
      Images = Dm.ImageList24
      ShowCaption = False
    end
  end
  inherited sScrollBox1: TsScrollBox
    TabOrder = 3
    inherited spFilial: TsPanel
      Width = 3
      ExplicitWidth = 3
    end
    inherited spVirtAcc: TsPanel
      Left = 537
      Width = 3
      ExplicitLeft = 537
      ExplicitWidth = 3
    end
    inherited spAccount: TsPanel
      Left = 271
      ExplicitLeft = 271
    end
    inherited cbPeriod: TsComboBox
      Left = 733
      Top = 31
      ExplicitLeft = 733
      ExplicitTop = 31
    end
    inherited spFiltrSearch: TsPanel
      Left = 877
      Top = 25
      ExplicitLeft = 877
      ExplicitTop = 25
      inherited sbFind: TsSpeedButton
        Left = 0
        ExplicitLeft = 0
      end
    end
    inherited spShow: TsPanel
      Left = 676
      Top = 63
      Width = 389
      ExplicitLeft = 676
      ExplicitTop = 63
      ExplicitWidth = 389
      inherited sbInfoShow: TsSpeedButton
        Width = 3
        ExplicitWidth = 3
      end
      object sbBlobToFile: TsSpeedButton
        AlignWithMargins = True
        Left = 222
        Top = 1
        Width = 78
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aBlobToFile
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 24
        Images = Dm.ImageList24
      end
      object sbFileToBlob: TsSpeedButton
        AlignWithMargins = True
        Left = 308
        Top = 1
        Width = 78
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFileToBlob
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 47
        Images = Dm.ImageList24
      end
      object sBevel13: TsBevel
        Left = 303
        Top = -4
        Width = 3
        Height = 38
        Visible = False
      end
    end
    inherited pButtonMove: TsPanel
      Left = 752
      Top = 109
      Width = 258
      ExplicitLeft = 752
      ExplicitTop = 109
      ExplicitWidth = 258
      object sbDelete: TsSpeedButton
        AlignWithMargins = True
        Left = 217
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aDelete
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 5
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sBevel10: TsBevel
        Left = 212
        Top = -8
        Width = 3
        Height = 38
      end
    end
  end
  inherited actlst1: TActionList
    Left = 152
    Top = 36
    inherited aDelete: TAction
      Enabled = False
      OnExecute = aDeleteExecute
    end
    object aBlobToFile: TAction [20]
      Caption = #1042' '#1092#1072#1081#1083
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083' '#1089#1095#1077#1090#1072' '#1080#1079' '#1073#1072#1079#1099' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1086#1077' '#1084#1077#1089#1090#1086
      ImageIndex = 24
      OnExecute = aBlobToFileExecute
    end
    object aFileToBlob: TAction [21]
      Caption = #1042' '#1073#1072#1079#1091
      Hint = #1042#1074#1077#1089#1090#1080' '#1074' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093' '#1092#1072#1081#1083' '#1089#1095#1077#1090#1086#1074
      ImageIndex = 47
      OnExecute = aFileToBlobExecute
    end
  end
  inherited qAccount: TOraQuery
    Left = 710
    Top = 210
  end
  inherited dsqAccount: TOraDataSource
    Left = 716
    Top = 274
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select  '
      '      BLL.LOG_BILL_ID,'
      '      BLL.ACCOUNT_ID,'
      '      BLL.YEAR_MONTH,'
      
        '      case when BLL.FILE_BODY is null then '#39#1053#1077#1090' '#1076#1072#1085#1085#1099#1093#39' else '#39#1045#1089 +
        #1090#1100' '#1076#1072#1085#1085#1099#1077#39' end DATA_EXIST,'
      
        '      case when BLL.FILE_BODY is null then 0 else 1 end DATA_EXI' +
        'ST_,'
      '      BLL.FILE_NAME,'
      '      BLL.BILL_FILE_STATUS_ID,'
      '      BLL.ERROR_LOAD,'
      
        '      case when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| B' +
        'LL.USER_CREATED else un.USER_FIO end USER_CREATED_FIO,'
      '      BLL.DATE_CREATED  DATE_CREATED_,'
      
        '      (select count(LOG_BILL_ID) from V_BILLS dlb where dlb.LOG_' +
        'BILL_ID = BLL.LOG_BILL_ID) cnt,'
      '      round(dbms_lob.getlength(BLL.FILE_BODY) /1024 ) length_bl '
      'from DB_LOADER_BILL_LOAD_LOG BLL,'
      '     USER_NAMES un  '
      'where BLL.USER_CREATED = un.USER_NAME(+)')
    AfterScroll = qReportAfterScroll
    Left = 638
    Top = 371
    ParamData = <>
    object qReportLOG_BILL_ID: TFloatField
      FieldName = 'LOG_BILL_ID'
      Required = True
      Visible = False
    end
    object qReportPeriod: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkLookup
      FieldName = 'Period'
      LookupDataSet = qMonthYearforRepFrm
      LookupKeyFields = 'YEAR_MONTH'
      LookupResultField = 'YEAR_MONTH_NAME'
      KeyFields = 'YEAR_MONTH'
      ReadOnly = True
      Size = 60
      Lookup = True
    end
    object qReportAccount_name: TStringField
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      FieldKind = fkLookup
      FieldName = 'Account_name'
      LookupDataSet = qAccount
      LookupKeyFields = 'ACCOUNT_ID'
      LookupResultField = 'ACCOUNT_NUMBER'
      KeyFields = 'ACCOUNT_ID'
      ReadOnly = True
      Size = 80
      Lookup = True
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
    object qReportFILE_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1091#1095#1077#1085#1086#1075#1086' '#1092#1072#1081#1083#1072
      FieldName = 'FILE_NAME'
      Size = 600
    end
    object qReportDATA_EXIST: TStringField
      DisplayLabel = #1053#1072#1083#1080#1095#1080#1077' '#1076#1072#1085#1085#1099#1093
      FieldName = 'DATA_EXIST'
      Size = 21
    end
    object qReportNAME_STATUS: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1072
      FieldKind = fkLookup
      FieldName = 'NAME_STATUS'
      LookupDataSet = qBillFileStatuses
      LookupKeyFields = 'BILL_FILE_STATUS_ID'
      LookupResultField = 'STATUS_NAME'
      KeyFields = 'BILL_FILE_STATUS_ID'
      Size = 60
      Lookup = True
    end
    object qReportERROR_LOAD: TStringField
      DisplayLabel = #1058#1077#1082#1089#1090' '#1086#1096#1080#1073#1082#1080
      FieldName = 'ERROR_LOAD'
      Size = 1200
    end
    object qReportUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      FieldName = 'USER_CREATED_FIO'
      ReadOnly = True
      Size = 240
    end
    object qReportDATE_CREATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1085#1072
      FieldName = 'DATE_CREATED_'
      ReadOnly = True
      Required = True
    end
    object qReportDATA_EXIST_: TFloatField
      FieldName = 'DATA_EXIST_'
      ReadOnly = True
      Visible = False
    end
    object qReportBILL_FILE_STATUS_ID: TFloatField
      FieldName = 'BILL_FILE_STATUS_ID'
      Visible = False
    end
    object qReportCNT: TFloatField
      DisplayLabel = #1050#1086#1083'-'#1074#1086' '#1085#1086#1084#1077#1088#1086#1074', '#1087#1086#1083#1091#1095#1077#1085#1099#1093' '#1080#1079' '#1101#1090#1086#1075#1086' '#1092#1072#1081#1083#1072
      FieldName = 'CNT'
    end
    object qReportLENGTH_BL: TFloatField
      DisplayLabel = #1054#1073#1098#1077#1084' '#1087#1086#1083#1091#1095#1077#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1074' '#1082#1073
      FieldName = 'LENGTH_BL'
    end
  end
  inherited dsqReport: TOraDataSource
    Left = 639
    Top = 418
  end
  inherited qMob_Oper: TOraQuery
    Left = 33
    Top = 378
  end
  inherited dsqMob_Oper: TOraDataSource
    Left = 31
    Top = 418
  end
  inherited qLogin: TOraQuery
    Left = 774
    Top = 210
  end
  inherited dsqLogin: TOraDataSource
    Left = 780
    Top = 274
  end
  object qSQL_TEMP: TOraQuery [17]
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '      BLL.LOG_BILL_ID,'
      '      BLL.ACCOUNT_ID,'
      '      BLL.YEAR_MONTH,'
      
        '      case when BLL.FILE_BODY is null then '#39#1053#1077#1090' '#1076#1072#1085#1085#1099#1093#39' else '#39#1045#1089 +
        #1090#1100' '#1076#1072#1085#1085#1099#1077#39' end DATA_EXIST,'
      
        '      case when BLL.FILE_BODY is null then 0 else 1 end DATA_EXI' +
        'ST_,'
      '      BLL.FILE_NAME,'
      '      BLL.BILL_FILE_STATUS_ID,'
      '      BLL.ERROR_LOAD,'
      
        '      case when nvl(un.USER_FIO, '#39'0'#39') = '#39'0'#39' then '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| B' +
        'LL.USER_CREATED else un.USER_FIO end USER_CREATED_FIO,'
      '      BLL.DATE_CREATED  DATE_CREATED_,'
      
        '      (select count(LOG_BILL_ID) from V_BILLS dlb where dlb.LOG_' +
        'BILL_ID = BLL.LOG_BILL_ID) cnt,'
      '      round(dbms_lob.getlength(BLL.FILE_BODY) /1024 ) length_bl '
      'from DB_LOADER_BILL_LOAD_LOG BLL,'
      '     USER_NAMES un  '
      'where BLL.USER_CREATED = un.USER_NAME(+)')
    Left = 582
    Top = 419
  end
  object qBlob: TOraQuery [18]
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '      BLL.FILE_BODY'
      'from DB_LOADER_BILL_LOAD_LOG BLL'
      'where BLL.LOG_BILL_ID = :LOG_BILL_ID')
    Left = 966
    Top = 211
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LOG_BILL_ID'
      end>
    object qBlobFILE_BODY: TBlobField
      FieldName = 'FILE_BODY'
      BlobType = ftOraBlob
    end
  end
  object qBlob2: TOraQuery [19]
    SQLInsert.Strings = (
      'INSERT INTO DB_LOADER_BILL_LOAD_LOG'
      '  (LOG_BILL_ID, ACCOUNT_ID, YEAR_MONTH, FILE_NAME, ERROR_LOAD)'
      'VALUES'
      
        '  (:LOG_BILL_ID, :ACCOUNT_ID, :YEAR_MONTH, :FILE_NAME, :ERROR_LO' +
        'AD)'
      'RETURNING'
      '  LOG_BILL_ID, ACCOUNT_ID, YEAR_MONTH, FILE_NAME, ERROR_LOAD'
      'INTO'
      
        '  :LOG_BILL_ID, :ACCOUNT_ID, :YEAR_MONTH, :FILE_NAME, :ERROR_LOA' +
        'D')
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '      BLL.LOG_BILL_ID,'
      '      BLL.ACCOUNT_ID,'
      '      BLL.YEAR_MONTH,'
      '      BLL.FILE_NAME,'
      '      BLL.ERROR_LOAD'
      'from DB_LOADER_BILL_LOAD_LOG BLL')
    Left = 878
    Top = 211
    object qBlob2LOG_BILL_ID: TFloatField
      FieldName = 'LOG_BILL_ID'
      Required = True
    end
    object qBlob2ACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qBlob2YEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qBlob2FILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 600
    end
    object qBlob2ERROR_LOAD: TStringField
      FieldName = 'ERROR_LOAD'
      Size = 1200
    end
  end
  object dsqBlob2: TOraDataSource [20]
    Tag = 1
    DataSet = qBlob2
    Left = 879
    Top = 282
  end
  object dsqMonthYearforRepFrm: TOraDataSource [21]
    Tag = 1
    DataSet = qMonthYearforRepFrm
    Left = 47
    Top = 330
  end
  object qAccount2: TOraQuery [22]
    UpdatingTable = 'ACCOUNTS'
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '  a.ACCOUNT_ID,'
      '  --a.ACCOUNT_NUMBER,'
      ' -- a.filial_id,'
      '  a.ACCOUNT_NUMBER||'#39' '#1086#1090' '#39'||f.filial_name NNMM'
      '  from ACCOUNTS a, '
      '       filials f'
      '  where a.filial_id = f.filial_id')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    BeforeOpen = qAccountBeforeOpen
    Left = 241
    Top = 314
    object qAccount2ACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qAccount2NNMM: TStringField
      FieldName = 'NNMM'
      Size = 416
    end
  end
  object dsqAccount2: TOraDataSource [23]
    Tag = 1
    DataSet = qAccount2
    Left = 247
    Top = 370
  end
  inherited qVirt_Acc: TOraQuery
    Left = 606
    Top = 210
  end
  inherited dsqVirt_Acc: TOraDataSource
    Left = 612
    Top = 250
  end
  inherited qfilials: TOraQuery
    Left = 337
    Top = 378
  end
  inherited dsqfilials: TOraDataSource
    Left = 335
    Top = 418
  end
  object qBillFileStatuses: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '  bfs.BILL_FILE_STATUS_ID,'
      '  bfs.STATUS_NAME'
      '  from BILL_FILE_STATUSES bfs')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    Left = 121
    Top = 418
    object qBillFileStatusesBILL_FILE_STATUS_ID: TFloatField
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080
      FieldName = 'BILL_FILE_STATUS_ID'
      Required = True
    end
    object qBillFileStatusesSTATUS_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1072
      FieldName = 'STATUS_NAME'
      Required = True
      Size = 120
    end
  end
  object dsqBillFileStatuses: TOraDataSource
    Tag = 1
    DataSet = qBillFileStatuses
    Left = 119
    Top = 466
  end
end
