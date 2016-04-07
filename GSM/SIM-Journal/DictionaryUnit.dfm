object DictionaryForm: TDictionaryForm
  Left = 0
  Top = 0
  Caption = 'DictionaryForm'
  ClientHeight = 511
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object sToolBar1: TsToolBar
    Left = 0
    Top = 0
    Width = 943
    Height = 54
    ButtonHeight = 52
    ButtonWidth = 57
    Caption = 'sToolBar1'
    Images = MainForm.ilToolbar
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    SkinData.SkinSection = 'TOOLBAR'
    object tbPrihod: TToolButton
      Left = 0
      Top = 0
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnClick = tbPrihodClick
    end
    object ToolButton2: TToolButton
      Left = 57
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 13
      OnClick = ToolButton2Click
    end
    object ToolButton6: TToolButton
      Left = 114
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 26
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 122
      Top = 0
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 31
      OnClick = ToolButton1Click
    end
    object ToolButton4: TToolButton
      Left = 179
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 27
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 187
      Top = 0
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      OnClick = ToolButton5Click
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 54
    Width = 943
    Height = 457
    Align = alClient
    AllowedSelections = [gstRecordBookmarks, gstAll]
    AutoFitColWidths = True
    Ctl3D = True
    DataGrouping.GroupLevels = <>
    DataSource = dsCommon
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
    RowDetailPanel.Color = clBtnFace
    ShowHint = True
    STFilter.InstantApply = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object qAgent: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO AGENTS'
      '  (AGENT_NAME)'
      'VALUES'
      '  (:AGENT_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM AGENTS'
      'WHERE'
      '  AGENT_ID = :Old_AGENT_ID')
    SQLUpdate.Strings = (
      'UPDATE AGENTS'
      'SET'
      '  AGENT_NAME = :AGENT_NAME'
      'WHERE'
      '  AGENT_ID = :Old_AGENT_ID')
    SQLLock.Strings = (
      'SELECT * FROM AGENTS'
      'WHERE'
      '  AGENT_ID = :Old_AGENT_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT AGENT_NAME FROM AGENTS'
      'WHERE'
      '  AGENT_ID = :AGENT_ID')
    Session = MainForm.OraSession
    SQL.Strings = (
      'select agent_id,'
      '       agent_name'
      '  from agents'
      '  order by agent_name')
    FetchRows = 250
    Left = 128
    Top = 64
    object qAgentAGENT_NAME: TStringField
      DisplayLabel = #1040#1075#1077#1085#1090
      FieldName = 'AGENT_NAME'
      Size = 100
    end
  end
  object dsCommon: TDataSource
    Left = 48
    Top = 152
  end
  object qSubagent: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO SUB_AGENTS'
      '  (SUB_AGENT_NAME)'
      'VALUES'
      '  (:SUB_AGENT_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM SUB_AGENTS'
      'WHERE'
      '  SUB_AGENT_ID = :Old_SUB_AGENT_ID')
    SQLUpdate.Strings = (
      'UPDATE SUB_AGENTS'
      'SET'
      '  SUB_AGENT_NAME = :SUB_AGENT_NAME'
      'WHERE'
      '  SUB_AGENT_ID = :Old_SUB_AGENT_ID')
    SQLLock.Strings = (
      'SELECT * FROM SUB_AGENTS'
      'WHERE'
      '  SUB_AGENT_ID = :Old_SUB_AGENT_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT SUB_AGENT_NAME FROM SUB_AGENTS'
      'WHERE'
      '  SUB_AGENT_ID = :SUB_AGENT_ID')
    Session = MainForm.OraSession
    SQL.Strings = (
      'select sub_agent_id,'
      '       sub_agent_name'
      '  from sub_agents'
      'order by sub_agent_name')
    FetchRows = 250
    Left = 128
    Top = 120
    object qSubagentSUB_AGENT_NAME: TStringField
      DisplayLabel = #1057#1091#1073#1072#1075#1077#1085#1090
      FieldName = 'SUB_AGENT_NAME'
      Size = 512
    end
  end
  object qOperator: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID')
    SQLUpdate.Strings = (
      'UPDATE OPERATORS'
      'SET'
      
        '  OPERATOR_ID = :OPERATOR_ID, OPERATOR_NAME = :OPERATOR_NAME, US' +
        'ER_CREATED = :USER_CREATED, DATE_CREATED = :DATE_CREATED, USER_L' +
        'AST_UPDATED = :USER_LAST_UPDATED, DATE_LAST_UPDATED = :DATE_LAST' +
        '_UPDATED, LOADER_SCRIPT_NAME = :LOADER_SCRIPT_NAME, ORDER_NUMBER' +
        ' = :ORDER_NUMBER'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID')
    SQLLock.Strings = (
      'SELECT * FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT OPERATOR_ID, OPERATOR_NAME, USER_CREATED, DATE_CREATED, U' +
        'SER_LAST_UPDATED, DATE_LAST_UPDATED, LOADER_SCRIPT_NAME, ORDER_N' +
        'UMBER FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :OPERATOR_ID')
    Session = MainForm.OraSession
    SQL.Strings = (
      'select operator_id, operator_name from operators'
      'order by operator_name')
    FetchRows = 250
    Left = 128
    Top = 176
    object qOperatorOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
      Visible = False
    end
    object qOperatorOPERATOR_NAME: TStringField
      DisplayLabel = #1054#1087#1077#1088#1072#1090#1086#1088
      FieldName = 'OPERATOR_NAME'
      Size = 400
    end
  end
  object qTariff: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID')
    SQLUpdate.Strings = (
      'UPDATE OPERATORS'
      'SET'
      
        '  OPERATOR_ID = :OPERATOR_ID, OPERATOR_NAME = :OPERATOR_NAME, US' +
        'ER_CREATED = :USER_CREATED, DATE_CREATED = :DATE_CREATED, USER_L' +
        'AST_UPDATED = :USER_LAST_UPDATED, DATE_LAST_UPDATED = :DATE_LAST' +
        '_UPDATED, LOADER_SCRIPT_NAME = :LOADER_SCRIPT_NAME, ORDER_NUMBER' +
        ' = :ORDER_NUMBER'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID')
    SQLLock.Strings = (
      'SELECT * FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :Old_OPERATOR_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT OPERATOR_ID, OPERATOR_NAME, USER_CREATED, DATE_CREATED, U' +
        'SER_LAST_UPDATED, DATE_LAST_UPDATED, LOADER_SCRIPT_NAME, ORDER_N' +
        'UMBER FROM OPERATORS'
      'WHERE'
      '  OPERATOR_ID = :OPERATOR_ID')
    Session = MainForm.OraSession
    SQL.Strings = (
      'select tariff_id,'
      '       tariff_name,'
      '       case t.is_active'
      '         when 0 then'
      '          '#39#1053#1077' '#1072#1082#1090#1080#1074#1085#1099#1081#39
      '         when 1 then'
      '          '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '       end activ,'
      '       o.operator_name,'
      '       t.start_balance,'
      '       t.connect_price,'
      '       case t.phone_number_type'
      '         when 0 then'
      '          '#39#1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081#39
      '         when 1 then'
      '          '#39#1043#1086#1088#1086#1076#1089#1082#1086#1081#39
      '       end phone_type,'
      '       t.dayly_payment,'
      '       t.monthly_payment'
      '  from tariffs t, operators o'
      ' where t.operator_id = o.operator_id'
      ' order by o.operator_name, t.tariff_name')
    FetchRows = 250
    Left = 128
    Top = 224
    object qTariffTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Visible = False
    end
    object qTariffOPERATOR_NAME: TStringField
      DisplayLabel = #1054#1087#1077#1088#1072#1090#1086#1088
      DisplayWidth = 10
      FieldName = 'OPERATOR_NAME'
      Size = 400
    end
    object qTariffTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      DisplayWidth = 20
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTariffACTIV: TStringField
      DisplayLabel = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
      FieldName = 'ACTIV'
      Size = 21
    end
    object qTariffSTART_BALANCE: TFloatField
      DisplayLabel = #1041#1072#1083#1072#1085#1089' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      DisplayWidth = 20
      FieldName = 'START_BALANCE'
    end
    object qTariffCONNECT_PRICE: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      DisplayWidth = 20
      FieldName = 'CONNECT_PRICE'
    end
    object qTariffPHONE_TYPE: TStringField
      DisplayLabel = #1058#1080#1087' '#1085#1086#1084#1077#1088#1072
      FieldName = 'PHONE_TYPE'
      Size = 22
    end
    object qTariffDAYLY_PAYMENT: TFloatField
      DisplayLabel = #1045#1078#1077#1076#1085#1077#1074#1085#1072#1103' '#1087#1083#1072#1090#1072
      DisplayWidth = 20
      FieldName = 'DAYLY_PAYMENT'
    end
    object qTariffMONTHLY_PAYMENT: TFloatField
      DisplayLabel = #1045#1078#1077#1084#1077#1089#1103#1095#1085#1072#1103' '#1087#1083#1072#1090#1072
      DisplayWidth = 20
      FieldName = 'MONTHLY_PAYMENT'
    end
  end
  object qService: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO SIM_PHONE_OPTION_TYPE'
      '  (OPTION_ID, OPTION_NAME)'
      'VALUES'
      '  (:OPTION_ID, :OPTION_NAME)')
    Session = MainForm.OraSession
    SQL.Strings = (
      'select option_id, '
      '       option_name       '
      '  from sim_phone_option_type'
      '  order by option_id')
    FetchRows = 250
    Left = 128
    Top = 280
    object qServiceOPTION_ID: TFloatField
      DisplayLabel = #1050#1086#1076
      FieldName = 'OPTION_ID'
      Required = True
    end
    object qServiceOPTION_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'OPTION_NAME'
      Required = True
      Size = 800
    end
  end
end
