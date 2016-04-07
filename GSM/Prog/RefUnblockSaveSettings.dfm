object RefUnblockSaveSettingsForm: TRefUnblockSaveSettingsForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1080#1079' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
  ClientHeight = 293
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object sSplitter1: TsSplitter
    Left = 553
    Top = 0
    Height = 293
    SkinData.SkinSection = 'SPLITTER'
    ExplicitLeft = 310
    ExplicitTop = 8
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 293
    Align = alLeft
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 65
      Width = 551
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 1
      ExplicitWidth = 110
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 551
      Height = 64
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 527
      object GroupBox1: TGroupBox
        Left = 1
        Top = 1
        Width = 549
        Height = 62
        Align = alClient
        Caption = #1055#1077#1088#1080#1086#1076' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 525
        ExplicitHeight = 73
        object Label1: TLabel
          Left = 24
          Top = 24
          Width = 371
          Height = 16
          Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1074' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080' '#1088#1072#1079#1088#1077#1096#1077#1085#1086' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100':'
        end
        object Edit1: TEdit
          Left = 401
          Top = 21
          Width = 56
          Height = 24
          TabOrder = 0
          Text = 'Edit1'
          OnExit = Edit1Exit
        end
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 68
      Width = 551
      Height = 224
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 80
      ExplicitTop = 176
      ExplicitWidth = 185
      ExplicitHeight = 41
      object GroupBox2: TGroupBox
        Left = 1
        Top = 1
        Width = 549
        Height = 222
        Align = alClient
        Caption = #1056#1072#1079#1088#1077#1096#1077#1085#1085#1099#1077' '#1080' '#1079#1072#1087#1088#1077#1097#1077#1085#1085#1099#1077' '#1090#1072#1088#1080#1092#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 48
        ExplicitTop = 103
        ExplicitWidth = 185
        ExplicitHeight = 105
        object CRDBGrid1: TCRDBGrid
          Left = 2
          Top = 18
          Width = 545
          Height = 202
          Align = alClient
          DataSource = dsTariffs
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
          Columns = <
            item
              Expanded = False
              FieldName = 'TARIFF_NAME'
              ReadOnly = True
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TARIFF_CODE'
              ReadOnly = True
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACCESS_UNLOCK_SAVE'
              Width = 200
              Visible = True
            end>
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 559
    Top = 0
    Width = 199
    Height = 293
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 360
    ExplicitTop = 80
    ExplicitWidth = 185
    ExplicitHeight = 41
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 197
      Height = 291
      Align = alClient
      Caption = #1047#1072#1087#1088#1077#1097#1077#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = -8
      ExplicitTop = 96
      ExplicitWidth = 185
      ExplicitHeight = 105
      object CRDBGrid2: TCRDBGrid
        Left = 2
        Top = 18
        Width = 193
        Height = 271
        Align = alClient
        DataSource = dsNumberBlockInSave
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Alignment = taCenter
            Width = 140
            Visible = True
          end>
      end
    end
  end
  object qTariffs: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE TARIFFS'
      '  SET ACCESS_UNLOCK_SAVE = :ACCESS_UNLOCK_SAVE'
      '  WHERE TARIFF_ID = :Old_TARIFF_ID')
    SQLLock.Strings = (
      'SELECT TARIFF_ID, TARIFF_CODE, TARIFF_NAME, ACCESS_UNLOCK_SAVE '
      '  FROM TARIFFS'
      '  WHERE TARIFF_ID = :Old_TARIFF_ID'
      '  FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT TARIFF_ID, TARIFF_CODE, TARIFF_NAME, ACCESS_UNLOCK_SAVE '
      '  FROM TARIFFS'
      '  WHERE TARIFF_ID = :TARIFF_ID')
    SQL.Strings = (
      'select *'
      '  from tariffs'
      '  where is_active = 1'
      '  order by tariff_code asc, tariff_name asc')
    FetchRows = 250
    FetchAll = True
    Left = 64
    Top = 168
    object qTariffsTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
    object qTariffsTARIFF_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qTariffsTARIFF_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTariffsACCESS_UNLOCK_SAVE: TIntegerField
      DisplayLabel = #1056#1072#1079#1073#1083#1086#1082' '#1074' '#1089#1086#1093#1088'.(1-'#1044#1072'/0-'#1053#1077#1090')'
      FieldName = 'ACCESS_UNLOCK_SAVE'
    end
  end
  object dsTariffs: TDataSource
    DataSet = qTariffs
    Left = 96
    Top = 176
  end
  object qNumberBlockInSave: TOraQuery
    SQL.Strings = (
      'SELECT phone_number'
      '  FROM number_block_in_save'
      '  order by phone_number asc')
    FetchRows = 500
    ReadOnly = True
    Left = 584
    Top = 72
    object qNumberBlockInSavePHONE_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 10
    end
  end
  object dsNumberBlockInSave: TDataSource
    DataSet = qNumberBlockInSave
    Left = 616
    Top = 80
  end
  object spGetParamValue: TOraStoredProc
    StoredProcName = 'MS_PARAMS.GET_PARAM_VALUE'
    SQL.Strings = (
      'begin'
      '  :RESULT := MS_PARAMS.GET_PARAM_VALUE(:PARAM_NAME);'
      'end;')
    Left = 200
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PARAM_NAME'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'MS_PARAMS.GET_PARAM_VALUE'
  end
  object spSetParamValue: TOraStoredProc
    StoredProcName = 'MS_PARAMS.SET_PARAM_VALUE'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := MS_PARAMS.SET_PARAM_VALUE(:PARAM_NAME, :PARAM_VALUE' +
        ');'
      'end;')
    Left = 312
    Top = 8
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PARAM_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PARAM_VALUE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'MS_PARAMS.SET_PARAM_VALUE'
  end
end
