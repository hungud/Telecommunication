inherited ShowLogMailFrm: TShowLogMailFrm
  Caption = #1046#1091#1088#1085#1072#1083' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1087#1086#1095#1090#1086#1074#1099#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
  ClientHeight = 428
  ClientWidth = 933
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 941
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 394
    Width = 933
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      933
      34)
    object sBsave: TsBitBtn
      Left = 826
      Top = 2
      Width = 75
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
      Left = 475
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
    Width = 933
    Height = 394
    Align = alClient
    DataSource = dsLoaderLog
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
    OnDrawColumnCell = cRGridDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'YEAR_MONTH_NAME'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Title.Alignment = taCenter
        Width = 184
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INN'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        ButtonStyle = cbsNone
        Expanded = False
        FieldName = 'EMAIL'
        Title.Alignment = taCenter
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_SEND'
        Title.Alignment = taCenter
        Width = 157
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DELIVERED'
        Title.Alignment = taCenter
        Width = 162
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR'
        Title.Alignment = taCenter
        Width = 174
        Visible = True
      end>
  end
  object LoaderLog: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT s.VIRTUAL_ACCOUNTS_ID,'
      '       v.VIRTUAL_ACCOUNTS_NAME, '
      '       v.INN,'
      '       s.DATE_SEND, '
      '       p.YEAR_MONTH_NAME, '
      
        '       case when s.DELIVERED = 0 then '#39#1087#1080#1089#1100#1084#1086' '#1085#1077' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086#39' els' +
        'e  '#39#1087#1080#1089#1100#1084#1086' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086' '#1091#1089#1087#1077#1096#1085#1086#39' end DELIVERED, '
      '       s.ERROR, '
      '       s.EMAIL'
      '  FROM SEND_MAIL_LOG s, '
      '       VIRTUAL_ACCOUNTS v,'
      '       V_PERIODS p'
      'where s.VIRTUAL_ACCOUNTS_ID = v.VIRTUAL_ACCOUNTS_ID'
      '  and s.PERIOD = p.YEAR_MONTH'
      '  and p.YEAR_MONTH = :YEAR_MONTH'
      '  order by DATE_SEND')
    Left = 30
    Top = 331
    ParamData = <
      item
        DataType = ftInteger
        Name = 'YEAR_MONTH'
        Value = 201511
      end>
    object LoaderLogVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
      Required = True
      Visible = False
    end
    object LoaderLogVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object LoaderLogINN: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Size = 48
    end
    object LoaderLogEMAIL: TStringField
      DisplayLabel = #1069#1083'. '#1087#1086#1095#1090#1072
      FieldName = 'EMAIL'
      Size = 400
    end
    object LoaderLogYEAR_MONTH_NAME: TStringField
      DisplayLabel = #1055#1077#1088#1080#1086#1076
      FieldName = 'YEAR_MONTH_NAME'
      Size = 212
    end
    object LoaderLogDATE_SEND: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      FieldName = 'DATE_SEND'
      Required = True
    end
    object LoaderLogDELIVERED: TStringField
      DisplayLabel = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1090#1087#1088#1072#1074#1082#1080
      FieldName = 'DELIVERED'
      Size = 48
    end
    object LoaderLogERROR: TStringField
      DisplayLabel = #1054#1096#1080#1073#1082#1080' '#1087#1088#1080' '#1086#1090#1087#1088#1072#1074#1082#1077
      FieldName = 'ERROR'
      Size = 8064
    end
  end
  object dsLoaderLog: TDataSource
    DataSet = LoaderLog
    Left = 24
    Top = 384
  end
  object qBlob: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select  '
      '      s.BODY_MAIL'
      'from SEND_MAIL_LOG s'
      'where s.VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID')
    Left = 94
    Top = 331
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'VIRTUAL_ACCOUNTS_ID'
      end>
    object qBlobBODY_MAIL: TBlobField
      FieldName = 'BODY_MAIL'
      BlobType = ftOraBlob
    end
  end
end
