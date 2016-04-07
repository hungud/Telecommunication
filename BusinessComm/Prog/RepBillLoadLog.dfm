inherited RepBillLoadLogFrm: TRepBillLoadLogFrm
  Caption = ''
  ClientHeight = 452
  ClientWidth = 940
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 948
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 418
    Width = 940
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      940
      34)
    object sBsave: TsBitBtn
      Left = 649
      Top = 2
      Width = 99
      Height = 31
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1086#1089#1084#1086#1090#1088
      Anchors = [akTop, akRight]
      Caption = #1054#1082
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 212
      Top = 2
      Width = 99
      Height = 31
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083' '#1089#1095#1077#1090#1072' '#1080#1079' '#1073#1072#1079#1099' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1086#1077' '#1084#1077#1089#1090#1086
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1042' '#1092#1072#1081#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = sBCloseClick
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 24
      Images = Dm.ImageList24
    end
  end
  object cRGrid: TCRDBGrid
    Left = 0
    Top = 0
    Width = 940
    Height = 418
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
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleFont.Quality = fqClearTypeNatural
    Columns = <
      item
        Expanded = False
        FieldName = 'Period'
        Title.Alignment = taCenter
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Account_name'
        Title.Alignment = taCenter
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILE_NAME'
        Title.Alignment = taCenter
        Width = 210
        Visible = True
      end
      item
        ButtonStyle = cbsNone
        Expanded = False
        FieldName = 'DATA_EXIST'
        Title.Alignment = taCenter
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME_STATUS'
        Title.Alignment = taCenter
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR_LOAD'
        Title.Alignment = taCenter
        Width = 201
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Title.Alignment = taCenter
        Width = 143
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED_'
        Title.Alignment = taCenter
        Width = 97
        Visible = True
      end>
  end
  object qReport: TOraQuery
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
      '      BLL.DATE_CREATED  DATE_CREATED_'
      'from DB_LOADER_BILL_LOAD_LOG BLL,'
      '     USER_NAMES un  '
      'where BLL.USER_CREATED = un.USER_NAME(+)'
      '  and BLL.LOG_BILL_ID = :LOG_BILL_ID')
    FetchRows = 1000
    Active = True
    BeforeOpen = qReportBeforeOpen
    AfterOpen = qReportAfterOpen
    OnCalcFields = qReportCalcFields
    Left = 142
    Top = 107
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LOG_BILL_ID'
        Value = Null
      end>
    object qReportLOG_BILL_ID: TFloatField
      FieldName = 'LOG_BILL_ID'
      Required = True
      Visible = False
    end
    object qReportPeriod: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Period'
      ReadOnly = True
      Size = 60
      Calculated = True
    end
    object qReportAccount_name: TStringField
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      FieldKind = fkCalculated
      FieldName = 'Account_name'
      ReadOnly = True
      Size = 80
      Calculated = True
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
      KeyFields = 'DATA_EXIST_'
      Size = 30
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
      Required = True
      Visible = False
    end
  end
  object dsqReport: TOraDataSource
    Tag = 1
    DataSet = qReport
    Left = 143
    Top = 162
  end
  object qBlob: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '      BLL.FILE_BODY'
      'from DB_LOADER_BILL_LOAD_LOG BLL'
      'where BLL.LOG_BILL_ID = :LOG_BILL_ID')
    Left = 318
    Top = 155
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
    Active = True
    Left = 121
    Top = 269
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
    Top = 317
  end
end
