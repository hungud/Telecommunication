object SettingsPanelForm: TSettingsPanelForm
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1057#1080#1084'-'#1046#1091#1088#1085#1072#1083#1072
  ClientHeight = 476
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 368
    Height = 476
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object GroupBox1: TGroupBox
      Left = 17
      Top = 16
      Width = 328
      Height = 105
      Caption = #1041#1072#1079#1072' '#1044#1072#1085#1085#1099#1093
      TabOrder = 0
      object sLabel1: TsLabel
        Left = 45
        Top = 17
        Width = 84
        Height = 16
        Alignment = taRightJustify
        Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel2: TsLabel
        Left = 28
        Top = 44
        Width = 101
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel3: TsLabel
        Left = 74
        Top = 71
        Width = 55
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object DBEditEh1: TDBEditEh
        Left = 135
        Top = 16
        Width = 178
        Height = 21
        DataField = 'LOADER_DB_CONNECTION'
        DataSource = dsSettings
        EditButtons = <>
        TabOrder = 0
        Visible = True
      end
      object DBEditEh2: TDBEditEh
        Left = 135
        Top = 43
        Width = 178
        Height = 21
        DataField = 'LOADER_DB_USER_NAME'
        DataSource = dsSettings
        EditButtons = <>
        TabOrder = 1
        Visible = True
      end
      object DBEditEh3: TDBEditEh
        Left = 135
        Top = 70
        Width = 178
        Height = 21
        DataField = 'LOADER_DB_PASSWORD'
        DataSource = dsSettings
        EditButtons = <>
        PasswordChar = '*'
        TabOrder = 2
        Visible = True
      end
    end
    object GroupBox2: TGroupBox
      Left = 17
      Top = 127
      Width = 328
      Height = 82
      Caption = #1050#1086#1088#1087#1086#1088#1072#1090#1080#1074#1085#1099#1081' '#1087#1086#1088#1090#1072#1083
      TabOrder = 1
      object sLabel4: TsLabel
        Left = 28
        Top = 20
        Width = 101
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel5: TsLabel
        Left = 74
        Top = 47
        Width = 55
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object DBEditEh4: TDBEditEh
        Left = 135
        Top = 19
        Width = 178
        Height = 21
        DataField = 'CORP_PORTAL_LOGIN'
        DataSource = dsSettings
        EditButtons = <>
        TabOrder = 0
        Visible = True
      end
      object DBEditEh5: TDBEditEh
        Left = 135
        Top = 46
        Width = 178
        Height = 21
        DataField = 'CORP_PORTAL_PASSWORD'
        DataSource = dsSettings
        EditButtons = <>
        PasswordChar = '*'
        TabOrder = 1
        Visible = True
      end
    end
    object GroupBox3: TGroupBox
      Left = 17
      Top = 215
      Width = 328
      Height = 82
      Caption = #1057#1077#1088#1074#1080#1089'-'#1043#1080#1076
      TabOrder = 2
      object sLabel6: TsLabel
        Left = 56
        Top = 20
        Width = 73
        Height = 16
        Alignment = taRightJustify
        Caption = #1047#1072#1075#1088#1091#1079#1095#1080#1082':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel7: TsLabel
        Left = 74
        Top = 47
        Width = 55
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object DBEditEh6: TDBEditEh
        Left = 135
        Top = 19
        Width = 178
        Height = 21
        DataField = 'LOADER_NAME'
        DataSource = dsSettings
        EditButtons = <>
        TabOrder = 0
        Visible = True
      end
      object DBEditEh7: TDBEditEh
        Left = 135
        Top = 46
        Width = 178
        Height = 21
        DataField = 'SERVICE_GID_PASSWORD'
        DataSource = dsSettings
        EditButtons = <>
        PasswordChar = '*'
        TabOrder = 1
        Visible = True
      end
    end
    object GroupBox4: TGroupBox
      Left = 17
      Top = 303
      Width = 328
      Height = 122
      Caption = #1052#1072#1089#1090#1077#1088'-'#1087#1072#1088#1086#1083#1100
      TabOrder = 3
      object sLabel8: TsLabel
        Left = 23
        Top = 17
        Width = 106
        Height = 16
        Alignment = taRightJustify
        Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel9: TsLabel
        Left = 29
        Top = 43
        Width = 100
        Height = 16
        Alignment = taRightJustify
        Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
        Color = clBtnFace
        ParentColor = False
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel10: TsLabel
        Left = 13
        Top = 71
        Width = 116
        Height = 16
        Alignment = taRightJustify
        Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel11: TsLabel
        Left = 62
        Top = 97
        Width = 251
        Height = 13
        Alignment = taRightJustify
        Caption = #1044#1083#1103' '#1074#1085#1077#1089#1077#1085#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1074#1074#1077#1076#1080#1090#1077' '#1089#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sEdit2: TsEdit
        Left = 135
        Top = 43
        Width = 178
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 0
        OnChange = sEdit2Change
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
      end
      object sEdit1: TsEdit
        Left = 135
        Top = 16
        Width = 178
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
      end
      object sEdit3: TsEdit
        Left = 135
        Top = 70
        Width = 178
        Height = 21
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnChange = sEdit3Change
        SkinData.SkinSection = 'EDIT'
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
      end
    end
    object sBitBtn1: TsBitBtn
      Left = 108
      Top = 431
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = sBitBtn1Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sBitBtn2: TsBitBtn
      Left = 189
      Top = 431
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 5
      OnClick = sBitBtn2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sBitBtn3: TsBitBtn
      Left = 270
      Top = 431
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
      OnClick = sBitBtn3Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object qSettings: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO SIM_SETTINGS'
      
        '  (SETTINGS_ID, SETTINGS_NAME, LOADER_DB_CONNECTION, LOADER_DB_U' +
        'SER_NAME, LOADER_DB_PASSWORD, MASTER_PASSWORD, CORP_PORTAL_LOGIN' +
        ', CORP_PORTAL_PASSWORD, SERVICE_GID_PASSWORD, LOADER_NAME)'
      'VALUES'
      
        '  (:SETTINGS_ID, :SETTINGS_NAME, :LOADER_DB_CONNECTION, :LOADER_' +
        'DB_USER_NAME, :LOADER_DB_PASSWORD, :MASTER_PASSWORD, :CORP_PORTA' +
        'L_LOGIN, :CORP_PORTAL_PASSWORD, :SERVICE_GID_PASSWORD, :LOADER_N' +
        'AME)')
    SQLDelete.Strings = (
      'DELETE FROM SIM_SETTINGS'
      'WHERE'
      '  SETTINGS_ID = :Old_SETTINGS_ID')
    SQLUpdate.Strings = (
      'UPDATE SIM_SETTINGS'
      'SET'
      
        '  SETTINGS_ID = :SETTINGS_ID, SETTINGS_NAME = :SETTINGS_NAME, LO' +
        'ADER_DB_CONNECTION = :LOADER_DB_CONNECTION, LOADER_DB_USER_NAME ' +
        '= :LOADER_DB_USER_NAME, LOADER_DB_PASSWORD = :LOADER_DB_PASSWORD' +
        ', MASTER_PASSWORD = :MASTER_PASSWORD, CORP_PORTAL_LOGIN = :CORP_' +
        'PORTAL_LOGIN, CORP_PORTAL_PASSWORD = :CORP_PORTAL_PASSWORD, SERV' +
        'ICE_GID_PASSWORD = :SERVICE_GID_PASSWORD, LOADER_NAME = :LOADER_' +
        'NAME'
      'WHERE'
      '  SETTINGS_ID = :Old_SETTINGS_ID')
    SQLLock.Strings = (
      'SELECT * FROM SIM_SETTINGS'
      'WHERE'
      '  SETTINGS_ID = :Old_SETTINGS_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT SETTINGS_ID, SETTINGS_NAME, LOADER_DB_CONNECTION, LOADER_' +
        'DB_USER_NAME, LOADER_DB_PASSWORD, MASTER_PASSWORD, CORP_PORTAL_L' +
        'OGIN, CORP_PORTAL_PASSWORD, SERVICE_GID_PASSWORD, LOADER_NAME FR' +
        'OM SIM_SETTINGS'
      'WHERE'
      '  SETTINGS_ID = :SETTINGS_ID')
    SQL.Strings = (
      'select *'
      '  from sim_settings'
      '  where settings_active=1')
    AfterOpen = qSettingsAfterOpen
    Left = 16
    Top = 32
    object qSettingsMASTER_PASSWORD: TStringField
      FieldName = 'MASTER_PASSWORD'
      Required = True
      Size = 400
    end
    object qSettingsSETTINGS_ID: TFloatField
      FieldName = 'SETTINGS_ID'
      Required = True
    end
    object qSettingsLOADER_DB_CONNECTION: TStringField
      FieldName = 'LOADER_DB_CONNECTION'
      Required = True
      Size = 400
    end
    object qSettingsLOADER_DB_USER_NAME: TStringField
      FieldName = 'LOADER_DB_USER_NAME'
      Required = True
      Size = 400
    end
    object qSettingsLOADER_DB_PASSWORD: TStringField
      FieldName = 'LOADER_DB_PASSWORD'
      Required = True
      Size = 400
    end
    object qSettingsCORP_PORTAL_LOGIN: TStringField
      FieldName = 'CORP_PORTAL_LOGIN'
      Required = True
      Size = 400
    end
    object qSettingsCORP_PORTAL_PASSWORD: TStringField
      FieldName = 'CORP_PORTAL_PASSWORD'
      Required = True
      Size = 400
    end
    object qSettingsSERVICE_GID_PASSWORD: TStringField
      FieldName = 'SERVICE_GID_PASSWORD'
      Required = True
      Size = 400
    end
    object qSettingsLOADER_NAME: TStringField
      FieldName = 'LOADER_NAME'
      Size = 400
    end
    object qSettingsSETTINGS_NAME: TStringField
      FieldName = 'SETTINGS_NAME'
      Required = True
      Size = 200
    end
  end
  object dsSettings: TOraDataSource
    DataSet = qSettings
    Left = 48
    Top = 40
  end
end
