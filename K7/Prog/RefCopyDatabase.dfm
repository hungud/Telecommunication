object RefCopyDataBaseForm: TRefCopyDataBaseForm
  Left = 0
  Top = 0
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1089#1090#1088#1091#1082#1090#1091#1088#1099' '#1041#1044
  ClientHeight = 607
  ClientWidth = 1459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1459
    Height = 59
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 1459
      Height = 48
      AutoSize = True
      ButtonHeight = 48
      ButtonWidth = 105
      Caption = 'ToolBar1'
      Images = MainForm.ImageList24
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = aInsert
      end
      object ToolButton2: TToolButton
        Left = 105
        Top = 0
        Action = aEdit
      end
      object ToolButton3: TToolButton
        Left = 210
        Top = 0
        Action = aDelete
      end
      object ToolButton7: TToolButton
        Left = 315
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 323
        Top = 0
        Action = aPost
      end
      object ToolButton11: TToolButton
        Left = 428
        Top = 0
        Action = aExcel
        Caption = 'Excel'
      end
      object ToolButton5: TToolButton
        Left = 533
        Top = 0
        Action = aCancel
      end
      object ToolButton8: TToolButton
        Left = 638
        Top = 0
        Width = 8
        Caption = 'ToolButton8'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 646
        Top = 0
        Action = aRefresh
      end
      object ToolButton9: TToolButton
        Left = 751
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object ToolButton10: TToolButton
        Left = 759
        Top = 0
        Action = aShowUserStatInfo
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 59
    Width = 1189
    Height = 548
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 252
      Width = 1187
      Height = 4
      Cursor = crVSplit
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      ExplicitWidth = 1186
    end
    object CRDBGrid1: TCRDBGrid
      Left = 1
      Top = 1
      Width = 1187
      Height = 251
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      DataSource = DataSource1
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID_DATABASE'
          ReadOnly = True
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'SCHEMA_NAME'
          ReadOnly = True
          Title.Caption = #1048#1084#1103' '#1089#1093#1077#1084#1099
          Width = 184
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          ReadOnly = True
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMMENT_SCHEMA'
          Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_CREATED'
          ReadOnly = True
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1089#1086#1079#1076#1072#1090#1077#1083#1100
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CNT'
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1087#1080#1089#1077#1081
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNT1'
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1089#1093#1086#1078#1076#1077#1085#1080#1081
          Width = 135
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 1
      Top = 256
      Width = 1187
      Height = 291
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      TabOrder = 1
      object dgCompareBalRes: TCRDBGrid
        Left = 1
        Top = 1
        Width = 1185
        Height = 289
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        DataSource = DataSource2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = dgCompareBalResDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_DATABASE'
            Width = -1
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'SOURCE_BALANCE'
            Title.Caption = #1041#1072#1083#1072#1085#1089' '#1074' '#1073#1086#1077#1074#1086#1081' '#1073#1072#1079#1077
            Width = 104
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DEST_BALANCE'
            Title.Caption = #1041#1072#1083#1072#1085#1089' '#1089#1088#1072#1074#1085#1080#1074#1086#1077#1084#1086#1081' '#1089#1093#1077#1084#1077
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DIFFR'
            Title.Caption = #1056#1072#1079#1085#1080#1094#1072
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATEBALANCE'
            Title.Caption = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTRACT_DATE'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_CREDIT_CONTRACT'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IS_COLLECTOR'
            Width = 64
            Visible = True
          end>
      end
    end
  end
  object Panel4: TPanel
    Left = 1189
    Top = 59
    Width = 270
    Height = 548
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alRight
    TabOrder = 2
    object Gauge1: TGauge
      Left = 9
      Top = 167
      Width = 254
      Height = 32
      HelpContext = 1
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BorderStyle = bsNone
      ForeColor = clNavy
      Progress = 0
    end
    object bCompareBalance: TButton
      Left = 8
      Top = 73
      Width = 233
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1088#1072#1074#1085#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072
      TabOrder = 0
      OnClick = bCompareBalanceClick
    end
    object cbAllRecords: TCheckBox
      Left = 31
      Top = 9
      Width = 190
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
      TabOrder = 1
      OnClick = cbAllRecordsClick
    end
    object StatusBar1: TStatusBar
      Left = 7
      Top = 128
      Width = 194
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alNone
      Panels = <>
    end
  end
  object qMain: TOraQuery
    UpdatingTable = 'DATABASE_COPIES'
    KeyFields = 'ID_DATABASE'
    SQL.Strings = (
      'SELECT TT.*,'
      
        '       (SELECT COUNT(*) FROM BALANCE_COMPARE_RESULT BB WHERE BB.' +
        'ID_DATABASE=TT.ID_DATABASE ) CNT,'
      
        '       (SELECT COUNT(*) FROM BALANCE_COMPARE_RESULT BB WHERE BB.' +
        'ID_DATABASE=TT.ID_DATABASE AND SOURCE_BALANCE<>DEST_BALANCE) CNT' +
        '1'
      'FROM DATABASE_COPIES TT'
      'order by TT.DATE_CREATED desc')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 240
    Top = 65
    object qMainID_DATABASE: TFloatField
      FieldName = 'ID_DATABASE'
      Visible = False
    end
    object qMainSCHEMA_NAME: TStringField
      FieldName = 'SCHEMA_NAME'
      Size = 30
    end
    object qMainDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qMainCOMMENT_SCHEMA: TStringField
      FieldName = 'COMMENT_SCHEMA'
      Size = 250
    end
    object qMainUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 30
    end
    object qMainCNT: TFloatField
      FieldName = 'CNT'
    end
    object qMainCNT1: TFloatField
      FieldName = 'CNT1'
    end
  end
  object DataSource1: TDataSource
    DataSet = qMain
    Left = 304
    Top = 65
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ImageList24
    Left = 256
    Top = 132
    object N1: TMenuItem
      Action = aInsert
    end
    object N2: TMenuItem
      Action = aEdit
    end
    object N3: TMenuItem
      Action = aDelete
    end
    object N4: TMenuItem
      Action = aPost
    end
    object N5: TMenuItem
      Action = aCancel
    end
    object N6: TMenuItem
      Action = aRefresh
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 320
    Top = 132
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aInsertExecute
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      ShortCut = 113
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aDeleteExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 16467
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 8
      ShortCut = 27
    end
    object aShowUserStatInfo: TAction
      Caption = 'aShowUserStatInfo'
      ImageIndex = 22
      OnExecute = aShowUserStatInfoExecute
    end
    object aExcel: TAction
      Caption = 'aExcel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
  end
  object spAllTurnOnOff: TOraStoredProc
    StoredProcName = 'CHANGE_ROBOT_ALL_ACCOUNTS'
    SQL.Strings = (
      'begin'
      '  CHANGE_ROBOT_ALL_ACCOUNTS(:PNEW_STATE);'
      'end;')
    Left = 920
    Top = 64
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PNEW_STATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'CHANGE_ROBOT_ALL_ACCOUNTS'
  end
  object spCopySchema: TOraStoredProc
    StoredProcName = 'COPY_SCHEMA'
    SQL.Strings = (
      'begin'
      '  COPY_SCHEMA(:SOURCE_SCHEME, :DEST_SCHEME);'
      'end;')
    Left = 448
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'SOURCE_SCHEME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'DEST_SCHEME'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'COPY_SCHEMA'
  end
  object qCompareBalance: TOraQuery
    SQL.Strings = (
      'select dd.*, '
      '       DD.DEST_BALANCE-DD.SOURCE_BALANCE DIFFR,'
      '       v.CONTRACT_DATE,'
      '       v.IS_CREDIT_CONTRACT,'
      
        '       convert_pckg.GET_IS_COLLECTOR_BY_PHONE(v.PHONE_NUMBER_FED' +
        'ERAL) is_collector'
      '  from BALANCE_COMPARE_RESULT dd,'
      '       v_contracts v '
      '  WHERE (SOURCE_BALANCE<>DEST_BALANCE OR :ALL_RECORDS=1)'
      '    and dd.PHONE_NUMBER = v.PHONE_NUMBER_FEDERAL(+)'
      '    and v.CONTRACT_CANCEL_DATE is null'
      '  ORDER BY DIFFR DESC')
    MasterSource = DataSource1
    MasterFields = 'ID_DATABASE'
    DetailFields = 'ID_DATABASE'
    FetchRows = 500
    Left = 608
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ALL_RECORDS'
      end
      item
        DataType = ftUnknown
        Name = 'ID_DATABASE'
      end>
    object qCompareBalancePHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 10
    end
    object qCompareBalanceID_DATABASE: TFloatField
      FieldName = 'ID_DATABASE'
    end
    object qCompareBalanceSOURCE_BALANCE: TFloatField
      FieldName = 'SOURCE_BALANCE'
    end
    object qCompareBalanceDEST_BALANCE: TFloatField
      FieldName = 'DEST_BALANCE'
    end
    object qCompareBalanceDATEBALANCE: TDateTimeField
      FieldName = 'DATEBALANCE'
    end
    object qCompareBalanceDIFFR: TFloatField
      FieldName = 'DIFFR'
    end
    object qCompareBalanceCONTRACT_DATE: TDateTimeField
      DisplayLabel = #1044#1086#1075#1086#1074#1086#1088
      FieldName = 'CONTRACT_DATE'
    end
    object qCompareBalanceIS_CREDIT_CONTRACT: TIntegerField
      DisplayLabel = #1050#1088#1077#1076#1080#1090
      FieldName = 'IS_CREDIT_CONTRACT'
    end
    object qCompareBalanceIS_COLLECTOR: TFloatField
      DisplayLabel = #1050#1086#1083#1083#1077#1082#1090#1086#1088
      FieldName = 'IS_COLLECTOR'
    end
  end
  object DataSource2: TDataSource
    DataSet = qCompareBalance
    Left = 576
    Top = 152
  end
  object qExecuteJobCompare: TOraQuery
    Left = 448
    Top = 144
  end
  object spDropUser: TOraStoredProc
    StoredProcName = 'DROP_SCHEMA'
    SQL.Strings = (
      'begin'
      '  DROP_SCHEMA(:SCHEMA_NAME);'
      'end;')
    Left = 528
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'SCHEMA_NAME'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'DROP_SCHEMA'
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 704
    Top = 72
  end
end
