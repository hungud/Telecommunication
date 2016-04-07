inherited RefContractForm: TRefContractForm
  Caption = 'RefContractForm'
  ClientHeight = 530
  ClientWidth = 1058
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1066
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 496
    Width = 1058
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      1058
      34)
    object sBsave: TsBitBtn
      Left = 767
      Top = 2
      Width = 99
      Height = 31
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 906
      Top = 2
      Width = 99
      Height = 31
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 8
      Images = Dm.ImageList24
    end
  end
  object TlBr: TsToolBar
    Left = 0
    Top = 0
    Width = 1058
    Height = 29
    ButtonHeight = 30
    ButtonWidth = 31
    DoubleBuffered = True
    Images = Dm.ImageList24
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    SkinData.SkinSection = 'TOOLBAR'
    object btnInsert: TToolButton
      Left = 0
      Top = 0
      Action = aInsert
    end
    object btnEdit: TToolButton
      Left = 31
      Top = 0
      Action = aEdit
    end
    object btnDelete: TToolButton
      Left = 62
      Top = 0
      Action = aDelete
    end
    object btn4: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'btn4'
      ImageIndex = 3
      Style = tbsSeparator
      Visible = False
    end
    object btnRefresh: TToolButton
      Left = 101
      Top = 0
      Action = aRefresh
    end
    object ToolButton2: TToolButton
      Left = 132
      Top = 0
      Caption = 'ToolButton2'
      DropdownMenu = pmFiltr
      ImageIndex = 14
      PopupMenu = pmFiltr
      Style = tbsDropDown
      OnClick = ToolButton2Click
    end
    object btnFiltr: TToolButton
      Left = 176
      Top = 0
      Action = aFiltr
    end
    object btnExcel: TToolButton
      Left = 207
      Top = 0
      Action = aToExcel
    end
    object btn1: TToolButton
      Left = 238
      Top = 0
      Width = 8
      Caption = 'btn1'
      ImageIndex = 16
      Style = tbsSeparator
    end
    object btnFirst: TToolButton
      Left = 246
      Top = 0
      Action = aFirst
    end
    object btnMovePrev: TToolButton
      Left = 277
      Top = 0
      Action = aMovePrev
    end
    object btnPrev: TToolButton
      Left = 308
      Top = 0
      Action = aPrev
    end
    object btnNext: TToolButton
      Left = 339
      Top = 0
      Action = aNext
    end
    object btnMoveNext: TToolButton
      Left = 370
      Top = 0
      Action = aMoveNext
    end
    object btnLast: TToolButton
      Left = 401
      Top = 0
      Action = aLast
    end
    object ToolButton1: TToolButton
      Left = 432
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
      Visible = False
    end
    object ToolButton3: TToolButton
      Left = 440
      Top = 0
      Action = aShowGroup
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 29
    Width = 1058
    Height = 467
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataGrouping.DefaultStateExpanded = True
    DataSource = dsqRef
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterColor = 14283263
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    FooterRowCount = 1
    FrozenCols = 1
    IndicatorOptions = [gioShowRowIndicatorEh]
    OddRowColor = 16510691
    OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    PopupMenu = pm1
    ReadOnly = True
    SumList.Active = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    UseMultiTitle = True
    OnApplyFilter = DBGridEh1ApplyFilter
    OnDblClick = DBGridEh1DblClick
    Columns = <
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'PHONE_NUMBER'
        Footer.ValueType = fvtStaticText
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'CONTRACT_NUM'
        Footers = <>
        Width = 85
      end
      item
        EditButtons = <>
        FieldName = 'CONTRACT_DATE'
        Footers = <>
        MRUList.Active = True
        Width = 103
      end
      item
        EditButtons = <>
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Footers = <>
        Width = 143
      end
      item
        EditButtons = <>
        FieldName = 'PHONE_FOR_VIEW'
        Footers = <>
        Width = 108
      end
      item
        EditButtons = <>
        FieldName = 'REGION'
        Footers = <>
        Width = 144
      end
      item
        EditButtons = <>
        FieldName = 'TARIFF_NAME'
        Footers = <>
        Width = 109
      end
      item
        EditButtons = <>
        FieldName = 'FILIAL_NAME'
        Footers = <>
        Width = 116
      end
      item
        EditButtons = <>
        FieldName = 'FIO'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'SIM_NUMBER'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'CONTRACT_DISCOUNT'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'OPERATOR_PHONE_STATUSE_NAME'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'LOCAL_PHONE_STATUSE_NAME'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'SALE_COST'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'SALE_DATE'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'OPERATOR_ACCOUNT_NAME'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PROJECT_NAME'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'SUB_ACCOUNT_NUMBER'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'AGENT_DATE_DISPATCH'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'AGENT_NAME'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'ADDRESS'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'EMAIL'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PAYABLE'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PHONE_NUMBER_1'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PHONE_NUMBER_2'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PHONE_NUMBER_3'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'PHONE_NUMBER_4'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'USER_CREATED_FIO'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'DATE_CREATED_'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'USER_LAST_UPDATED_FIO'
        Footers = <>
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'DATE_LAST_UPDATED_'
        Footers = <>
        Width = 120
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pm1: TPopupMenu
    Images = Dm.ImageList24
    Left = 16
    Top = 148
    object N1: TMenuItem
      Action = aInsert
    end
    object N2: TMenuItem
      Action = aEdit
    end
    object N3: TMenuItem
      Action = aDelete
    end
    object N6: TMenuItem
      Action = aRefresh
    end
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 120
    Top = 68
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aInsertExecute
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aDeleteExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aFind: TAction
      AutoCheck = True
      Caption = #1055#1086#1080#1089#1082
      Hint = #1055#1086#1080#1089#1082' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+G'
      ImageIndex = 15
      ShortCut = 16455
      OnExecute = aFindExecute
    end
    object aFiltr: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+A'
      ImageIndex = 13
      ShortCut = 16449
      OnExecute = aFiltrExecute
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
      OnExecute = aFirstExecute
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrevExecute
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
      OnExecute = aPrevExecute
    end
    object aNext: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
      OnExecute = aNextExecute
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNextExecute
    end
    object aLast: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcelExecute
    end
    object aF1: TAction
      Category = #1092#1080#1083#1100#1090#1088#1099
      Caption = #1053#1086#1074#1099#1081' '#1092#1080#1083#1100#1090#1088
      Hint = #1053#1086#1074#1099#1081' '#1087#1091#1089#1090#1086#1081' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 14
      OnExecute = aF1Execute
    end
    object aF3: TAction
      Category = #1092#1080#1083#1100#1090#1088#1099
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1081' '#1092#1080#1083#1100#1090#1088
      Enabled = False
      ImageIndex = 13
      OnExecute = aF3Execute
    end
    object aF2: TAction
      Category = #1092#1080#1083#1100#1090#1088#1099
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 26
      OnExecute = aF2Execute
    end
    object aShowGroup: TAction
      AutoCheck = True
      Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1088#1077#1078#1080#1084' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
      ImageIndex = 27
      Visible = False
      OnExecute = aShowGroupExecute
    end
  end
  object pmFiltr: TPopupMenu
    Left = 72
    Top = 100
    object miF1: TMenuItem
      Tag = 1
      Action = aF1
      RadioItem = True
    end
    object miF3: TMenuItem
      Action = aF3
    end
    object miF2: TMenuItem
      Tag = 1
      Action = aF2
      RadioItem = True
      ShortCut = 123
    end
  end
  object qRef: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS'
      'where'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS')
    FetchRows = 1000
    Filtered = True
    AfterScroll = qRefAfterScroll
    Left = 78
    Top = 176
    object qRefPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 52
      FieldName = 'PHONE_NUMBER'
      Size = 52
    end
    object qRefCONTRACT_NUM: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 10
      FieldName = 'CONTRACT_NUM'
      Required = True
    end
    object qRefCONTRACT_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      DisplayWidth = 18
      FieldName = 'CONTRACT_DATE'
      Required = True
    end
    object qRefVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090' '#1074#1080#1088#1090'.  '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      DisplayWidth = 24
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object qRefPHONE_FOR_VIEW: TStringField
      DisplayLabel = #1042#1080#1079#1091#1072#1083#1100#1085#1086' '#1082#1088#1072#1089#1080#1074#1086#1077' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1085#1086#1084#1077#1088#1072
      DisplayWidth = 80
      FieldName = 'PHONE_FOR_VIEW'
      Size = 80
    end
    object qRefREGION: TStringField
      DisplayLabel = #1056#1077#1075#1080#1086#1085' '#1087#1088#1080#1087#1080#1089#1082#1080' '#1085#1086#1084#1077#1088#1072
      DisplayWidth = 200
      FieldName = 'REGION'
      Size = 200
    end
    object qRefTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      DisplayWidth = 400
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qRefFILIAL_NAME: TStringField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      DisplayWidth = 200
      FieldName = 'FILIAL_NAME'
      Size = 200
    end
    object qRefFIO: TStringField
      DisplayLabel = #1040#1073#1086#1085#1077#1085#1090
      DisplayWidth = 462
      FieldName = 'FIO'
      Size = 462
    end
    object qRefSIM_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' SIM '#1082#1072#1088#1090#1099
      DisplayWidth = 30
      FieldName = 'SIM_NUMBER'
      Size = 30
    end
    object qRefCONTRACT_DISCOUNT: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1091
      DisplayWidth = 10
      FieldName = 'CONTRACT_DISCOUNT'
    end
    object qRefOPERATOR_PHONE_STATUSE_NAME: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1089#1074#1103#1079#1080
      DisplayWidth = 120
      FieldName = 'OPERATOR_PHONE_STATUSE_NAME'
      Size = 120
    end
    object qRefSALE_COST: TFloatField
      DisplayLabel = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
      DisplayWidth = 10
      FieldName = 'SALE_COST'
    end
    object qRefSALE_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1086#1076#1072#1078#1080
      DisplayWidth = 18
      FieldName = 'SALE_DATE'
    end
    object qRefOPERATOR_ACCOUNT_NAME: TStringField
      DisplayLabel = 'C'#1095#1077#1090' '#1091' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1089#1074#1103#1079#1080
      DisplayWidth = 200
      FieldName = 'OPERATOR_ACCOUNT_NAME'
      Size = 200
    end
    object qRefLOCAL_PHONE_STATUSE_NAME: TStringField
      DisplayLabel = 'C'#1090#1072#1090#1091#1089' '#1074' '#1090#1072#1088#1080#1092#1077#1088#1077
      DisplayWidth = 120
      FieldName = 'LOCAL_PHONE_STATUSE_NAME'
      Size = 120
    end
    object qRefPROJECT_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1086#1077#1082#1090#1072
      DisplayWidth = 120
      FieldName = 'PROJECT_NAME'
      Size = 120
    end
    object qRefSUB_ACCOUNT_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1086#1076#1089#1095#1077#1090#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072' '#1089#1074#1103#1079#1080
      DisplayWidth = 80
      FieldName = 'SUB_ACCOUNT_NUMBER'
      Size = 80
    end
    object qRefAGENT_DATE_DISPATCH: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080' '#1072#1075#1077#1085#1090#1091
      DisplayWidth = 18
      FieldName = 'AGENT_DATE_DISPATCH'
    end
    object qRefAGENT_NAME: TStringField
      DisplayLabel = ' '#1040#1075#1077#1085#1090
      DisplayWidth = 400
      FieldName = 'AGENT_NAME'
      Size = 400
    end
    object qRefADDRESS: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089' '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 1000
      FieldName = 'ADDRESS'
      Size = 1000
    end
    object qRefEMAIL: TStringField
      DisplayLabel = 'E-mail '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 200
      FieldName = 'EMAIL'
      Size = 200
    end
    object qRefPAYABLE: TStringField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 25
      FieldName = 'PAYABLE'
      Size = 25
    end
    object qRefPHONE_NUMBER_1: TStringField
      DisplayLabel = #1055#1077#1088#1074#1099#1081' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 80
      FieldName = 'PHONE_NUMBER_1'
      Size = 80
    end
    object qRefPHONE_NUMBER_2: TStringField
      DisplayLabel = #1042#1090#1086#1088#1086#1081' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 80
      FieldName = 'PHONE_NUMBER_2'
      Size = 80
    end
    object qRefPHONE_NUMBER_3: TStringField
      DisplayLabel = #1058#1088#1077#1090#1080#1081' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 80
      FieldName = 'PHONE_NUMBER_3'
      Size = 80
    end
    object qRefPHONE_NUMBER_4: TStringField
      DisplayLabel = #1063#1077#1090#1074#1077#1088#1090#1099#1081' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1072#1075#1077#1085#1090#1072
      DisplayWidth = 80
      FieldName = 'PHONE_NUMBER_4'
      Size = 80
    end
    object qRefUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      DisplayWidth = 240
      FieldName = 'USER_CREATED_FIO'
      Size = 240
    end
    object qRefDATE_CREATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1085#1072
      DisplayWidth = 18
      FieldName = 'DATE_CREATED_'
      Required = True
    end
    object qRefUSER_LAST_UPDATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1080#1083
      DisplayWidth = 240
      FieldName = 'USER_LAST_UPDATED_FIO'
      Size = 240
    end
    object qRefDATE_LAST_UPDATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1077#1085#1072
      DisplayWidth = 18
      FieldName = 'DATE_LAST_UPDATED_'
      Required = True
    end
    object qRefPHONE_NUMBER_TYPE: TFloatField
      FieldName = 'PHONE_NUMBER_TYPE'
      Required = True
      Visible = False
    end
    object qRefCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
      Visible = False
    end
  end
  object dsqRef: TOraDataSource
    Tag = 1
    DataSet = qRef
    Left = 119
    Top = 183
  end
  object qtmp: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS'
      'where'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS')
    FetchRows = 1000
    Filtered = True
    Left = 6
    Top = 48
  end
  object qRefCnt: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS'
      'where'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    Session = Dm.OraSession
    SQL.Strings = (
      'select count(CONTRACT_NUM) cnt'
      '   from '
      '   V_CONTRACTS')
    FetchRows = 1000
    Filtered = True
    AfterOpen = qRefCntAfterOpen
    Left = 230
    Top = 176
    object qRefCntCNT: TFloatField
      FieldName = 'CNT'
    end
  end
  object qtmp2: TOraQuery
    SQLDelete.Strings = (
      'DELETE FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      'select '
      '   CONTRACT_NUM,'
      '   CONTRACT_DATE,'
      '   VIRTUAL_ACCOUNTS_NAME,'
      '   PHONE_NUMBER,'
      '   PHONE_FOR_VIEW,'
      '   REGION,'
      '   TARIFF_NAME,'
      '   FILIAL_NAME,'
      '   FIO,'
      '   SIM_NUMBER,'
      '   CONTRACT_DISCOUNT,'
      '   OPERATOR_PHONE_STATUSE_NAME,'
      '   SALE_COST,'
      '   SALE_DATE,'
      '   OPERATOR_ACCOUNT_NAME,'
      '   PROJECT_NAME,'
      '   SUB_ACCOUNT_NUMBER,'
      '   AGENT_DATE_DISPATCH,'
      '   AGENT_NAME,'
      '   ADDRESS,'
      '   EMAIL,'
      
        '   case when PAYABLE = 0 then '#39#1085#1077' '#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else case when PAY' +
        'ABLE = 1 then '#39#1086#1087#1083#1072#1095#1080#1074#1072#1077#1084#39' else '#39#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39' end end PAYABLE,'
      '   PHONE_NUMBER_1,'
      '   PHONE_NUMBER_2,'
      '   PHONE_NUMBER_3,'
      '   PHONE_NUMBER_4,'
      '   ABONENT_ID,'
      '   AGENT_ID,'
      '   OPERATOR_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_ID,'
      '   LOCAL_PHONE_STATUSE_NAME,'
      '   OPERATOR_ACCOUNT_NAME_ID,'
      '   PROJECT_ID,'
      '   SUB_ACCOUNT_ID,'
      '   USER_CREATED_FIO,'
      '   DATE_CREATED_,'
      '   USER_LAST_UPDATED_FIO,'
      '   DATE_LAST_UPDATED_,'
      '   PHONE_NUMBER_TYPE,'
      '   VIRTUAL_ACCOUNTS_ID,'
      '  CONTRACT_ID'
      '   from '
      '   V_CONTRACTS'
      'where'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    Session = Dm.OraSession
    SQL.Strings = (
      'select count(CONTRACT_NUM) cnt'
      '   from '
      '   V_CONTRACTS')
    FetchRows = 1000
    Filtered = True
    Left = 230
    Top = 112
    object FloatField1: TFloatField
      FieldName = 'CNT'
    end
  end
end
