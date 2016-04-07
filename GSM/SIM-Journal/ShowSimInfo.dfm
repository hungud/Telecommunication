object ShowSimInfoForm: TShowSimInfoForm
  Left = 0
  Top = 0
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1057#1048#1052'-'#1082#1072#1088#1090#1077
  ClientHeight = 458
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 54
    Width = 382
    Height = 404
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 69
      Top = 56
      Width = 69
      Height = 16
      Alignment = taRightJustify
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 94
      Top = 83
      Width = 44
      Height = 16
      Alignment = taRightJustify
      Caption = #1040#1075#1077#1085#1090':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel3: TsLabel
      Left = 70
      Top = 110
      Width = 68
      Height = 16
      Alignment = taRightJustify
      Caption = #1057#1091#1073#1040#1075#1077#1085#1090':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel4: TsLabel
      Left = 92
      Top = 137
      Width = 46
      Height = 16
      Alignment = taRightJustify
      Caption = #1058#1072#1088#1080#1092':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel5: TsLabel
      Left = 48
      Top = 164
      Width = 90
      Height = 16
      Alignment = taRightJustify
      Caption = #1053#1072#1093#1086#1078#1076#1077#1085#1080#1077':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel6: TsLabel
      Left = 88
      Top = 191
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = #1057#1090#1072#1090#1091#1089':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBText1: TDBText
      Left = 144
      Top = 191
      Width = 161
      Height = 17
      DataField = 'PHONE_IS_ACTIVE'
      DataSource = dsSim
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sLabel7: TsLabel
      Left = 21
      Top = 218
      Width = 117
      Height = 16
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel8: TsLabel
      Left = 76
      Top = 245
      Width = 62
      Height = 16
      Alignment = taRightJustify
      Caption = #1040#1073#1086#1085#1077#1085#1090':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBText2: TDBText
      Left = 144
      Top = 245
      Width = 161
      Height = 17
      DataField = 'ABONENT_NAME'
      DataSource = dsInfo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sLabel9: TsLabel
      Left = 27
      Top = 272
      Width = 111
      Height = 16
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1072#1082#1090#1080#1074#1072#1094#1080#1080':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBText3: TDBText
      Left = 144
      Top = 272
      Width = 161
      Height = 17
      DataField = 'DATE_ACTIVATE'
      DataSource = dsInfo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sLabel10: TsLabel
      Left = 40
      Top = 326
      Width = 98
      Height = 16
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel11: TsLabel
      Left = 50
      Top = 353
      Width = 88
      Height = 16
      Alignment = taRightJustify
      Caption = #1057#1077#1088#1074#1080#1089'-'#1043#1080#1076#1072':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel12: TsLabel
      Left = 85
      Top = 299
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = #1041#1072#1083#1072#1085#1089':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBText4: TDBText
      Left = 144
      Top = 299
      Width = 161
      Height = 17
      DataField = 'BALANCE'
      DataSource = dsSim
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 144
      Top = 326
      Width = 161
      Height = 17
      DataField = 'DATE_BALANCE'
      DataSource = dsSim
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sLabel13: TsLabel
      Left = 74
      Top = 29
      Width = 64
      Height = 16
      Alignment = taRightJustify
      Caption = #1058#1077#1083#1077#1092#1086#1085':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBLookupComboboxEh1: TDBLookupComboboxEh
      Left = 144
      Top = 82
      Width = 209
      Height = 21
      DataField = 'AGENT_ID'
      DataSource = dsSim
      DropDownBox.Rows = 50
      EditButtons = <>
      KeyField = 'AGENT_ID'
      ListField = 'AGENT_NAME'
      ListSource = dsAgents
      TabOrder = 0
      Visible = True
    end
    object DBLookupComboboxEh2: TDBLookupComboboxEh
      Left = 144
      Top = 109
      Width = 209
      Height = 21
      DataField = 'SUBAGENT_ID'
      DataSource = dsSim
      DropDownBox.Rows = 50
      EditButtons = <>
      KeyField = 'SUB_AGENT_ID'
      ListField = 'SUB_AGENT_NAME'
      ListSource = dsSubAgents
      TabOrder = 1
      Visible = True
    end
    object DBLookupComboboxEh3: TDBLookupComboboxEh
      Left = 144
      Top = 136
      Width = 209
      Height = 21
      DataField = 'TARIFF_ID'
      DataSource = dsSim
      DropDownBox.Rows = 50
      EditButtons = <>
      KeyField = 'TARIFF_ID'
      ListField = 'TARIFF_NAME'
      ListSource = dsTariff
      TabOrder = 2
      Visible = True
    end
    object DBEditEh1: TDBEditEh
      Left = 144
      Top = 55
      Width = 209
      Height = 21
      DataField = 'ACCOUNT'
      DataSource = dsSim
      EditButtons = <>
      TabOrder = 3
      Visible = True
    end
    object DBLookupComboboxEh4: TDBLookupComboboxEh
      Left = 144
      Top = 163
      Width = 209
      Height = 21
      DataField = 'STATUS_ID'
      DataSource = dsSim
      DropDownBox.Rows = 50
      EditButtons = <>
      KeyField = 'SIM_STATUS_ID'
      ListField = 'SIM_STATUS_NAME'
      ListSource = dsSimStatus
      TabOrder = 4
      Visible = True
    end
    object DBDateTimeEditEh1: TDBDateTimeEditEh
      Left = 144
      Top = 217
      Width = 209
      Height = 21
      DataField = 'DATE_LAST_ACTIVITY'
      DataSource = dsSim
      EditButtons = <>
      Kind = dtkDateEh
      TabOrder = 5
      Visible = True
    end
    object DBLookupComboboxEh7: TDBLookupComboboxEh
      Left = 144
      Top = 352
      Width = 209
      Height = 21
      DataField = 'SERVICEGID_STATUS'
      DataSource = dsSim
      DropDownBox.Rows = 50
      EditButtons = <>
      KeyField = 'SIM_SG_STATUS_ID'
      ListField = 'SIM_SG_STATUS_NAME'
      ListSource = dsSGStatus
      TabOrder = 6
      Visible = True
    end
    object sEdit1: TsEdit
      Left = 144
      Top = 28
      Width = 209
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
      Text = 'sEdit1'
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
  object sToolBar1: TsToolBar
    Left = 0
    Top = 0
    Width = 382
    Height = 54
    ButtonHeight = 52
    ButtonWidth = 84
    Caption = 'sToolBar1'
    Images = MainForm.ilToolbar
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 1
    SkinData.SkinSection = 'TOOLBAR'
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = aSetInfo
    end
    object ToolButton2: TToolButton
      Left = 84
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 92
      Top = 0
      Action = aRefresh
    end
    object ToolButton4: TToolButton
      Left = 176
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 184
      Top = 0
      Action = aDeleteNumber
    end
  end
  object qInfo: TOraQuery
    SQL.Strings = (
      'SELECT * '
      '  FROM V_SIM'
      '  WHERE V_SIM.CELL_NUMBER=:CELL_NUM')
    FetchRows = 500
    Left = 8
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CELL_NUM'
      end>
    object qInfoSIM_ID: TFloatField
      FieldName = 'SIM_ID'
      Required = True
    end
    object qInfoAGENT_NAME: TStringField
      FieldName = 'AGENT_NAME'
      Size = 100
    end
    object qInfoSUBAGENT_NAME: TStringField
      FieldName = 'SUBAGENT_NAME'
      Size = 512
    end
    object qInfoOPERATOR_NAME: TStringField
      FieldName = 'OPERATOR_NAME'
      Size = 400
    end
    object qInfoDATE_INIT: TDateTimeField
      FieldName = 'DATE_INIT'
    end
    object qInfoSTATUS_NAME: TStringField
      FieldName = 'STATUS_NAME'
      Size = 100
    end
    object qInfoDATE_MOVE: TDateTimeField
      FieldName = 'DATE_MOVE'
    end
    object qInfoACCOUNT: TStringField
      FieldName = 'ACCOUNT'
      Required = True
      Size = 100
    end
    object qInfoCELL_NUMBER: TStringField
      FieldName = 'CELL_NUMBER'
      Required = True
      Size = 10
    end
    object qInfoTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qInfoSIM_NUMBER: TStringField
      FieldName = 'SIM_NUMBER'
      Size = 100
    end
    object qInfoABON_PAY: TFloatField
      FieldName = 'ABON_PAY'
    end
    object qInfoDATE_ACTIVATE: TDateTimeField
      FieldName = 'DATE_ACTIVATE'
    end
    object qInfoDATE_ERASE: TDateTimeField
      FieldName = 'DATE_ERASE'
    end
    object qInfoABONENT_NAME: TStringField
      FieldName = 'ABONENT_NAME'
      Size = 362
    end
    object qInfoBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qInfoDATE_BALANCE: TDateTimeField
      FieldName = 'DATE_BALANCE'
    end
    object qInfoDATE_LAST_ACTIVITY: TDateTimeField
      FieldName = 'DATE_LAST_ACTIVITY'
    end
    object qInfoGID_STATUS: TStringField
      FieldName = 'GID_STATUS'
      Size = 25
    end
  end
  object dsInfo: TDataSource
    DataSet = qInfo
    Left = 40
    Top = 152
  end
  object qSim: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM SIM'
      'WHERE'
      '  SIM_ID = :Old_SIM_ID')
    SQLUpdate.Strings = (
      'UPDATE SIM'
      'SET'
      
        '  AGENT_ID = :AGENT_ID, SUBAGENT_ID = :SUBAGENT_ID, OPERATOR_ID ' +
        '= :OPERATOR_ID, DATE_INIT = :DATE_INIT, STATUS_ID = :STATUS_ID, ' +
        'DATE_MOVE = :DATE_MOVE, ACCOUNT = :ACCOUNT, CELL_NUMBER = :CELL_' +
        'NUMBER, TARIFF_ID = :TARIFF_ID, SIM_NUMBER = :SIM_NUMBER, DATE_E' +
        'RASE = :DATE_ERASE, DATE_LAST_ACTIVITY = :DATE_LAST_ACTIVITY, SE' +
        'RVICEGID_STATUS = :SERVICEGID_STATUS'
      'WHERE'
      '  SIM_ID = :Old_SIM_ID')
    SQLLock.Strings = (
      'SELECT * FROM SIM'
      'WHERE'
      '  SIM_ID = :Old_SIM_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT AGENT_ID, SUBAGENT_ID, OPERATOR_ID, DATE_INIT, STATUS_ID,' +
        ' DATE_MOVE, ACCOUNT, CELL_NUMBER, TARIFF_ID, SIM_NUMBER, DATE_ER' +
        'ASE, DATE_LAST_ACTIVITY, SERVICEGID_STATUS FROM SIM'
      'WHERE'
      '  SIM_ID = :SIM_ID')
    SQL.Strings = (
      
        'select SIM_ID, AGENT_ID, SUBAGENT_ID, OPERATOR_ID, DATE_INIT, ST' +
        'ATUS_ID, DATE_MOVE,'
      
        '       ACCOUNT, CELL_NUMBER, TARIFF_ID, SIM_NUMBER, ABON_PAY, DA' +
        'TE_ACTIVATE, DATE_ERASE,'
      
        '       BALANCE, DATE_BALANCE, DATE_LAST_ACTIVITY, SERVICEGID_STA' +
        'TUS, '
      '       CASE'
      '         WHEN PHONE_IS_ACTIVE=1 THEN '#39#1040#1082#1090#1080#1074#1077#1085#39
      '         ELSE '#39#1041#1083#1086#1082#1080#1088#1086#1074#1072#1085#39
      '       END PHONE_IS_ACTIVE'
      '  from sim'
      '  where sim.cell_number=:CELL_NUM')
    FetchRows = 500
    Left = 8
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cell_num'
      end>
    object qSimSIM_ID: TFloatField
      FieldName = 'SIM_ID'
      Required = True
    end
    object qSimAGENT_ID: TFloatField
      FieldName = 'AGENT_ID'
      Required = True
    end
    object qSimSUBAGENT_ID: TFloatField
      FieldName = 'SUBAGENT_ID'
    end
    object qSimOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
      Required = True
    end
    object qSimDATE_INIT: TDateTimeField
      FieldName = 'DATE_INIT'
    end
    object qSimSTATUS_ID: TFloatField
      FieldName = 'STATUS_ID'
    end
    object qSimDATE_MOVE: TDateTimeField
      FieldName = 'DATE_MOVE'
    end
    object qSimACCOUNT: TStringField
      FieldName = 'ACCOUNT'
      Required = True
      Size = 100
    end
    object qSimCELL_NUMBER: TStringField
      FieldName = 'CELL_NUMBER'
      Required = True
      Size = 10
    end
    object qSimTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
    object qSimSIM_NUMBER: TStringField
      FieldName = 'SIM_NUMBER'
      Size = 100
    end
    object qSimABON_PAY: TFloatField
      FieldName = 'ABON_PAY'
    end
    object qSimDATE_ACTIVATE: TDateTimeField
      FieldName = 'DATE_ACTIVATE'
    end
    object qSimDATE_ERASE: TDateTimeField
      FieldName = 'DATE_ERASE'
    end
    object qSimBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qSimDATE_BALANCE: TDateTimeField
      FieldName = 'DATE_BALANCE'
    end
    object qSimDATE_LAST_ACTIVITY: TDateTimeField
      FieldName = 'DATE_LAST_ACTIVITY'
    end
    object qSimSERVICEGID_STATUS: TIntegerField
      FieldName = 'SERVICEGID_STATUS'
    end
    object qSimPHONE_IS_ACTIVE: TStringField
      FieldName = 'PHONE_IS_ACTIVE'
    end
  end
  object dsSim: TDataSource
    DataSet = qSim
    OnStateChange = dsSimStateChange
    OnDataChange = dsSimDataChange
    Left = 40
    Top = 96
  end
  object ActionList1: TActionList
    Left = 72
    Top = 48
    object aDeleteNumber: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1085#1086#1084#1077#1088
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1101#1090#1086#1090' '#1085#1086#1084#1077#1088
      ImageIndex = 4
      OnExecute = aDeleteNumberExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 31
      OnExecute = aRefreshExecute
    end
    object aSetInfo: TAction
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 32
      OnExecute = aSetInfoExecute
    end
  end
  object qAgents: TOraQuery
    SQL.Strings = (
      'select agent_id, '
      '       agent_name'
      '  from agents '
      '  order by agent_name')
    FetchRows = 500
    Left = 272
    Top = 64
    object qAgentsAGENT_ID: TFloatField
      FieldName = 'AGENT_ID'
      Required = True
    end
    object qAgentsAGENT_NAME: TStringField
      FieldName = 'AGENT_NAME'
      Size = 100
    end
  end
  object dsAgents: TDataSource
    DataSet = qAgents
    Left = 304
    Top = 72
  end
  object qSubAgents: TOraQuery
    SQL.Strings = (
      'select sub_agent_id,'
      '       sub_agent_name'
      '  from sub_agents '
      '  order by sub_agent_name')
    FetchRows = 500
    Left = 272
    Top = 112
    object qSubAgentsSUB_AGENT_ID: TFloatField
      FieldName = 'SUB_AGENT_ID'
      Required = True
    end
    object qSubAgentsSUB_AGENT_NAME: TStringField
      FieldName = 'SUB_AGENT_NAME'
      Size = 512
    end
  end
  object dsSubAgents: TDataSource
    DataSet = qSubAgents
    Left = 304
    Top = 120
  end
  object qTariff: TOraQuery
    SQL.Strings = (
      'select tariff_id, '
      '       tariff_name '
      '  from tariffs '
      '  where is_active = 1 '
      '  order by tariff_name')
    FetchRows = 500
    Left = 272
    Top = 160
    object qTariffTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
    object qTariffTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
  end
  object dsTariff: TDataSource
    DataSet = qTariff
    Left = 304
    Top = 168
  end
  object qSimStatus: TOraQuery
    SQL.Strings = (
      'SELECT SIM_STATUS_ID,'
      '       SIM_STATUS_NAME '
      '  FROM SIM_STATUSES'
      '  ORDER BY SIM_STATUS_ID')
    Left = 272
    Top = 216
    object qSimStatusSIM_STATUS_ID: TFloatField
      FieldName = 'SIM_STATUS_ID'
      Required = True
    end
    object qSimStatusSIM_STATUS_NAME: TStringField
      FieldName = 'SIM_STATUS_NAME'
      Size = 100
    end
  end
  object dsSimStatus: TDataSource
    DataSet = qSimStatus
    Left = 304
    Top = 224
  end
  object qSGStatus: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT SIM_SG_STATUS_ID,'
      '       SIM_SG_STATUS_NAME'
      '  FROM SIM_SERVICE_GID_STATUSES'
      '  ORDER BY SIM_SG_STATUS_ID ASC')
    Left = 264
    Top = 288
    object qSGStatusSIM_SG_STATUS_ID: TFloatField
      FieldName = 'SIM_SG_STATUS_ID'
    end
    object qSGStatusSIM_SG_STATUS_NAME: TStringField
      FieldName = 'SIM_SG_STATUS_NAME'
      Size = 100
    end
  end
  object dsSGStatus: TDataSource
    DataSet = qSGStatus
    Left = 296
    Top = 296
  end
end
