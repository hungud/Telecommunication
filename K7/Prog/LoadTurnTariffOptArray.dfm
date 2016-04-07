object LoadTurnTariffOptArrayForm: TLoadTurnTariffOptArrayForm
  Left = 0
  Top = 0
  Caption = 
    #1052#1072#1089#1089#1086#1074#1072#1103' '#1079#1072#1075#1088#1091#1079#1082#1072' '#1079#1072#1076#1072#1085#1080#1081' '#1085#1072' '#1086#1090#1083#1086#1078#1077#1085#1085#1086#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1080' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077 +
    ' '#1091#1089#1083#1091#1075
  ClientHeight = 404
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 25
    Width = 912
    Height = 363
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsChanges
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
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'PhoneNumber'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Option_code'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Option_name'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 218
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTION_TYPE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTION_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Itog'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
        Visible = True
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 912
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 2
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 910
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 160
      Caption = 'ToolBar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object tbAddPhones: TToolButton
        Left = 0
        Top = 0
        Action = aFileOpen
      end
      object tbCheckTariffOpt: TToolButton
        Left = 160
        Top = 0
        Action = aFindTariffOpt
        Caption = #1053#1072#1081#1090#1080' '#1090#1072#1088#1080#1092#1085#1099#1077' '#1086#1087#1094#1080#1080
        Enabled = False
      end
      object tbAddChanges: TToolButton
        Left = 320
        Top = 0
        Action = aAddChanges
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        Enabled = False
      end
      object tbImportExcel: TToolButton
        Left = 480
        Top = 0
        Action = aExcel
        Enabled = False
      end
      object ToolButton1: TToolButton
        Left = 640
        Top = 0
        Action = aClear
      end
    end
  end
  object vtChanges: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    FieldDefs = <
      item
        Name = 'PhoneNumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Option_code'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Option_name'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ACTION_TYPE'
        DataType = ftInteger
      end
      item
        Name = 'ACTION_DATE'
        DataType = ftDateTime
      end
      item
        Name = 'Itog'
        DataType = ftString
        Size = 100
      end>
    Left = 96
    Top = 96
    Data = {
      030006000B0050686F6E654E756D62657201000A00000000000B004F7074696F
      6E5F636F646501001E00000000000B004F7074696F6E5F6E616D650100640000
      0000000B00414354494F4E5F5459504503000000000000000B00414354494F4E
      5F444154450B00000000000000040049746F6701006400000000000000000000
      00}
    object vtChangesPhoneNumber: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PhoneNumber'
      Size = 10
    end
    object vtChangesOption_code: TStringField
      DisplayLabel = #1050#1086#1076' '#1086#1087#1094#1080#1080
      FieldName = 'Option_code'
      Size = 30
    end
    object vtChangesOption_name: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1086#1087#1094#1080#1080
      DisplayWidth = 50
      FieldName = 'Option_name'
      Size = 100
    end
    object vtChangesACTION_TYPE: TIntegerField
      DisplayLabel = #1058#1080#1087' '#1086#1087#1077#1088#1072#1094#1080#1080
      FieldName = 'ACTION_TYPE'
    end
    object vtChangesACTION_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      FieldName = 'ACTION_DATE'
    end
    object vtChangesItog: TStringField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'Itog'
      Size = 100
    end
  end
  object dsChanges: TDataSource
    DataSet = vtChanges
    Left = 200
    Top = 128
  end
  object ActionList: TActionList
    Left = 360
    Top = 96
    object aFileOpen: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      OnExecute = aFileOpenExecute
    end
    object aAddChanges: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1058#1055
      OnExecute = aAddChangesExecute
    end
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      OnExecute = aExcelExecute
    end
    object aFindTariffOpt: TAction
      Caption = #1053#1072#1081#1090#1080' '#1089#1090#1072#1090#1091#1089#1099
      OnExecute = aFindTariffOptExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
  end
  object qAddChange: TOraQuery
    SQL.Strings = (
      'INSERT INTO DELAYED_ON_OFF_TARIFF_OPTIONS '
      
        '  (PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, ACTION_DATE, DATE_CRE' +
        'ATED, USER_CREATED)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :OPTION_CODE, :ACTION_TYPE, :ACTION_DATE, SYSD' +
        'ATE, USER)')
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end>
  end
  object OpenDialog: TOpenDialog
    Left = 112
    Top = 288
  end
  object Transaction: TOraTransaction
    DefaultSession = MainForm.OraSession
    DefaultCloseAction = taRollback
    Left = 400
    Top = 280
  end
  object qFindTariffOpt: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  option_name '
      'FROM'
      '  tariff_options'
      'WHERE '
      '  option_code = :option_code')
    Left = 216
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'option_code'
      end>
  end
  object qCheck: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT DELAYED_TURN_TO_ID '
      'FROM DELAYED_ON_OFF_TARIFF_OPTIONS d'
      'WHERE phone_number = :phone_number'
      '  AND option_code = :option_code'
      '  AND ACTION_TYPE = :ACTION_TYPE')
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
  object qEditChange: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'UPDATE'
      '  DELAYED_ON_OFF_TARIFF_OPTIONS'
      'SET'
      '  ACTION_TYPE = :ACTION_TYPE, '
      '  ACTION_DATE = :ACTION_DATE'
      'WHERE'
      '  DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID')
    Left = 176
    Top = 256
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
end
