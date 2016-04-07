object RefTurnTariffOptionsForm: TRefTurnTariffOptionsForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1076#1072#1085#1080#1103' '#1085#1072' '#1086#1090#1083#1086#1078#1077#1085#1085#1086#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077'/'#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1091#1089#1083#1091#1075
  ClientHeight = 502
  ClientWidth = 1127
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object CRDBGrid1: TCRDBGrid
    Left = 0
    Top = 31
    Width = 1127
    Height = 471
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        DropDownRows = 20
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        Width = 104
        Visible = True
      end
      item
        DropDownRows = 20
        Expanded = False
        FieldName = 'OPTION_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1072#1088#1080#1092#1085#1072#1103' '#1086#1087#1094#1080#1103
        Width = 166
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTION_TYPE'
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077'(0- '#1086#1090#1082#1083'., 1- '#1087#1086#1076#1082#1083'.)'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ACTION_TYPE_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTION_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        Width = 179
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1079#1072#1076#1072#1085#1080#1103
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1086#1073#1085#1086#1074#1083'.'
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATED'
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1085#1086#1074#1080#1074#1096#1080#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 184
        Visible = True
      end>
  end
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 1127
    Height = 31
    AutoSize = True
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = MainForm.ImageList24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbAdd: TToolButton
      Left = 0
      Top = 0
      Action = aAdd
    end
    object tbEdit: TToolButton
      Left = 31
      Top = 0
      Action = aEdit
    end
    object tbDelete: TToolButton
      Left = 62
      Top = 0
      Action = aDelete
    end
    object ToolButton19: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object tbRefresh: TToolButton
      Left = 101
      Top = 0
      Action = aRefresh
    end
    object tbExcelExport: TToolButton
      Left = 132
      Top = 0
      Action = aExcelExport
    end
    object tbLoadFromFile: TToolButton
      Left = 163
      Top = 0
      Action = aLoadOptFromFile
    end
  end
  object qMain: TOraQuery
    UpdatingTable = 'DELAYED_ON_OFF_TARIFF_OPTIONS'
    KeyFields = 'DELAYED_TURN_TO_ID'
    KeySequence = 'S_NEW_DELAYED_TURN_TO_ID'
    SQLInsert.Strings = (
      'INSERT INTO DELAYED_ON_OFF_TARIFF_OPTIONS'
      
        '  (DELAYED_TURN_TO_ID, PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, A' +
        'CTION_DATE)'
      'VALUES'
      
        '  (:DELAYED_TURN_TO_ID, :PHONE_NUMBER, :OPTION_CODE, :ACTION_TYP' +
        'E, :ACTION_DATE)'
      'RETURNING'
      
        '  DELAYED_TURN_TO_ID, PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, AC' +
        'TION_DATE'
      'INTO'
      
        '  :DELAYED_TURN_TO_ID, :PHONE_NUMBER, :OPTION_CODE, :ACTION_TYPE' +
        ', :ACTION_DATE')
    SQLDelete.Strings = (
      'DELETE FROM DELAYED_ON_OFF_TARIFF_OPTIONS'
      'WHERE DELAYED_TURN_TO_ID = :old_DELAYED_TURN_TO_ID')
    SQLUpdate.Strings = (
      'UPDATE DELAYED_ON_OFF_TARIFF_OPTIONS'
      'SET'
      '  PHONE_NUMBER = :PHONE_NUMBER,'
      '  OPTION_CODE = :OPTION_CODE,'
      '  ACTION_TYPE = :ACTION_TYPE,'
      '  ACTION_DATE = :ACTION_DATE'
      'WHERE'
      '  DELAYED_TURN_TO_ID = :OLD_DELAYED_TURN_TO_ID'
      'RETURNING'
      '  PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, ACTION_DATE '
      'INTO'
      '  :PHONE_NUMBER, :OPTION_CODE, :ACTION_TYPE, :ACTION_DATE')
    SQLLock.Strings = (
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT * FROM DELAYED_ON_OFF_TARIFF_OPTIONS'
      'WHERE DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID'
      'ORDER BY DATE_CREATED DESC')
    SQL.Strings = (
      'SELECT * FROM DELAYED_ON_OFF_TARIFF_OPTIONS'
      'ORDER BY DATE_CREATED DESC')
    FetchAll = True
    Options.StrictUpdate = False
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 256
    Top = 65
    object qMainDELAYED_TURN_TO_ID: TFloatField
      FieldName = 'DELAYED_TURN_TO_ID'
    end
    object qMainPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 11
    end
    object qMainOPTION_CODE: TStringField
      FieldName = 'OPTION_CODE'
      Size = 30
    end
    object qMainOPTION_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPTION_NAME'
      LookupDataSet = qTarffOptions
      LookupKeyFields = 'OPTION_CODE'
      LookupResultField = 'OPTION_NAME'
      KeyFields = 'OPTION_CODE'
      Size = 100
      Lookup = True
    end
    object qMainACTION_TYPE: TIntegerField
      FieldName = 'ACTION_TYPE'
      Required = True
      Visible = False
    end
    object qMainACTION_DATE: TDateTimeField
      FieldName = 'ACTION_DATE'
      Required = True
    end
    object qMainTASK_DATE: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qMainUSER_NAME: TStringField
      FieldName = 'USER_CREATED'
      Size = 30
    end
    object qMainDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
    end
    object qMainUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 30
    end
    object qMainACTION_TYPE_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'ACTION_TYPE_NAME'
      LookupDataSet = qActionType
      LookupKeyFields = 'ACTION_TYPE'
      LookupResultField = 'ACTION_NAME'
      KeyFields = 'ACTION_TYPE'
      Lookup = True
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 120
    Top = 88
    object aExcelExport: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1090#1080#1090#1100' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1090#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelExportExecute
    end
    object aLoadOptFromFile: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 24
      OnExecute = aLoadOptFromFileExecute
    end
    object aAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aAddExecute
    end
    object aEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 6
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      OnExecute = aDeleteExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
  end
  object qGetNewId: TOraStoredProc
    Left = 64
    Top = 80
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object qTarffOptions: TOraQuery
    SQL.Strings = (
      'SELECT option_code, option_name FROM tariff_options')
    FetchAll = True
    Left = 312
    Top = 96
  end
  object qActionType: TOraQuery
    SQL.Strings = (
      'SELECT 1 ACTION_TYPE, '#39#1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#39' ACTION_NAME FROM dual'
      'UNION ALL'
      'SELECT 0 , '#39#1054#1090#1082#1083#1102#1095#1080#1090#1100#39' FROM dual')
    FetchAll = True
    Left = 312
    Top = 144
  end
  object qCheck: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  DELAYED_TURN_TO_ID '
      'FROM '
      '  DELAYED_ON_OFF_TARIFF_OPTIONS d'
      'WHERE phone_number = :phone_number '
      '      AND option_code = :option_code'
      '      AND ACTION_TYPE = :ACTION_TYPE')
    Left = 256
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone_number'
      end
      item
        DataType = ftUnknown
        Name = 'option_code'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end>
  end
  object qEdit: TOraQuery
    SQL.Strings = (
      'UPDATE DELAYED_ON_OFF_TARIFF_OPTIONS'
      'SET'
      '  ACTION_TYPE = :ACTION_TYPE,'
      '  ACTION_DATE = :ACTION_DATE'
      'WHERE'
      '  DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID')
    Left = 256
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end
      item
        DataType = ftUnknown
        Name = 'DELAYED_TURN_TO_ID'
      end>
  end
  object Transaction: TOraTransaction
    DefaultSession = Dm.OraSession
    DefaultCloseAction = taRollback
    Left = 336
    Top = 216
  end
  object qDelete: TOraQuery
    SQL.Strings = (
      'DELETE FROM DELAYED_ON_OFF_TARIFF_OPTIONS'
      'WHERE DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID')
    Left = 264
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DELAYED_TURN_TO_ID'
      end>
  end
  object DataSource1: TDataSource
    DataSet = qMain
    Left = 432
    Top = 152
  end
end
