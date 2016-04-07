object InitForm: TInitForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1072#1088#1090
  ClientHeight = 514
  ClientWidth = 919
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 41
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object Label1: TsLabel
      Left = 12
      Top = 13
      Width = 34
      Height = 13
      Caption = #1040#1075#1077#1085#1090':'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object Label2: TsLabel
      Left = 203
      Top = 13
      Width = 249
      Height = 13
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088' '#1089#1074#1103#1079#1080'('#1058#1054#1051#1068#1050#1054' '#1044#1051#1071' '#1053#1054#1042#1067#1061' '#1058#1040#1056#1048#1060#1054#1042'):'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object DBLookupComboboxEh1: TDBLookupComboboxEh
      Left = 51
      Top = 10
      Width = 145
      Height = 21
      DropDownBox.Rows = 25
      EditButtons = <>
      KeyField = 'AGENT_ID'
      ListField = 'NAME'
      ListSource = dsAgent
      TabOrder = 0
      Visible = True
    end
    object DBLookupComboboxEh2: TDBLookupComboboxEh
      Left = 456
      Top = 10
      Width = 145
      Height = 21
      DropDownBox.Rows = 25
      EditButtons = <>
      KeyField = 'OPERATOR_ID'
      ListField = 'OPERATOR_NAME'
      ListSource = dsOperator
      TabOrder = 1
      Visible = True
    end
  end
  object sToolBar1: TsToolBar
    Left = 0
    Top = 41
    Width = 919
    Height = 54
    ButtonHeight = 52
    ButtonWidth = 110
    Caption = 'sToolBar1'
    Images = MainForm.ilToolbar
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 1
    SkinData.SkinSection = 'TOOLBAR'
    object tbPrihod: TToolButton
      Left = 0
      Top = 0
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnClick = tbPrihodClick
    end
    object ToolButton2: TToolButton
      Left = 110
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 13
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 220
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbLoadXLS: TToolButton
      Left = 228
      Top = 0
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1077#1097#1105' '#1092#1072#1081#1083
      ImageIndex = 26
      OnClick = tbLoadXLSClick
    end
    object ToolButton6: TToolButton
      Left = 338
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 26
      Style = tbsSeparator
    end
    object tbHistory: TToolButton
      Left = 346
      Top = 0
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 14
      OnClick = tbHistoryClick
    end
    object ToolButton1: TToolButton
      Left = 456
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 15
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 464
      Top = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1073#1072#1079#1091
      ImageIndex = 6
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 574
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 582
      Top = 0
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      OnClick = ToolButton7Click
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 95
    Width = 919
    Height = 419
    Align = alClient
    AllowedOperations = [alopInsertEh, alopUpdateEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    AutoFitColWidths = True
    Ctl3D = True
    DataGrouping.GroupLevels = <>
    DataSource = dsLoad
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
    RowDetailPanel.Color = clBtnFace
    ShowHint = True
    STFilter.InstantApply = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'Subagent'
        Footers = <>
        Title.Caption = #1057#1091#1073#1072#1075#1077#1085#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 124
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'account'
        Footers = <>
        Title.Caption = #8470' '#1083'/'#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 124
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'cellnum'
        Footers = <>
        Title.Caption = #8470' '#1090#1077#1083#1077#1092#1086#1085#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 124
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'tarif'
        Footers = <>
        Title.Caption = #1058#1072#1088#1080#1092
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 124
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'dateactiv'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1072#1082#1090#1080#1074#1072#1094#1080#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 89
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'datetechactiv'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1086#1081' '#1072#1082#1090#1080#1074#1072#1094#1080#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 94
      end
      item
        AutoFitColWidth = False
        EditButtons = <>
        FieldName = 'datemove'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 66
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object vtLoad: TVirtualTable
    AfterOpen = vtLoadAfterInsert
    AfterInsert = vtLoadAfterInsert
    AfterCancel = vtLoadAfterInsert
    AfterDelete = vtLoadAfterInsert
    Left = 64
    Top = 136
    Data = {03000000000000000000}
    object vtLoadSubagent: TStringField
      FieldName = 'Subagent'
      Size = 100
    end
    object vtLoadaccount: TStringField
      FieldName = 'account'
      Size = 100
    end
    object vtLoadcellnum: TStringField
      FieldName = 'cellnum'
      Size = 100
    end
    object vtLoadtarif: TStringField
      FieldName = 'tarif'
      Size = 100
    end
    object vtLoaddateactiv: TDateField
      FieldName = 'dateactiv'
    end
    object vtLoaddatetechactiv: TDateField
      FieldName = 'datetechactiv'
    end
    object vtLoaddatemove: TDateField
      FieldName = 'datemove'
    end
  end
  object dsLoad: TDataSource
    DataSet = vtLoad
    Left = 120
    Top = 136
  end
  object dsAgent: TDataSource
    DataSet = qAgent
    Left = 216
    Top = 176
  end
  object dsOperator: TDataSource
    DataSet = qOperator
    Left = 280
    Top = 176
  end
  object qAgent: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select agent_id,'
      '       agent_name name'
      '  from agents'
      '  order by name')
    Left = 216
    Top = 240
    object qAgentAGENT_ID: TFloatField
      FieldName = 'AGENT_ID'
      Required = True
    end
    object qAgentNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 400
    end
  end
  object qOperator: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select operator_id, operator_name from operators'
      'order by operator_name')
    Left = 280
    Top = 240
    object qOperatorOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
      Required = True
    end
    object qOperatorOPERATOR_NAME: TStringField
      FieldName = 'OPERATOR_NAME'
      Size = 400
    end
  end
  object spLoad: TOraStoredProc
    StoredProcName = 'PCKG_SIMUTILS.LOAD_OLD_XLS'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  PCKG_SIMUTILS.LOAD_OLD_XLS(:VAGENTID, :VOPERATORID, :VSUBAGENT' +
        ', :VACCOUNT, :VCELLNUMBER, :VSIMNUMBER, :VTARIF, :VDATEINIT, :VD' +
        'ATEACTIV, :VDATETECHACTIV, :VDATEMOVE);'
      'end;')
    Left = 424
    Top = 208
    ParamData = <
      item
        DataType = ftFloat
        Name = 'VAGENTID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'VOPERATORID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VSUBAGENT'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VACCOUNT'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VCELLNUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VSIMNUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VTARIF'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'VDATEINIT'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'VDATEACTIV'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'VDATETECHACTIV'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'VDATEMOVE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PCKG_SIMUTILS.LOAD_OLD_XLS'
  end
end
