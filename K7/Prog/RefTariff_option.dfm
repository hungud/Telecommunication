inherited Tariff_option: TTariff_option
  Caption = 'Tariff_option'
  ClientHeight = 592
  ClientWidth = 962
  Constraints.MinHeight = 619
  Constraints.MinWidth = 970
  KeyPreview = True
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 970
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 13
  object Ctrl_Options: TDBCtrlGrid
    Left = 0
    Top = 36
    Width = 962
    Height = 556
    Align = alClient
    PanelHeight = 185
    PanelWidth = 945
    ParentShowHint = False
    TabOrder = 0
    ShowHint = True
    OnPaintPanel = Ctrl_OptionsPaintPanel
    ExplicitTop = 142
    ExplicitHeight = 580
    object bvl3: TBevel
      Left = 631
      Top = 10
      Width = 310
      Height = 172
      Shape = bsFrame
    end
    object bvl2: TBevel
      Left = 318
      Top = 11
      Width = 310
      Height = 172
      Shape = bsFrame
    end
    object bvl1: TBevel
      Left = 5
      Top = 11
      Width = 310
      Height = 172
      Shape = bsFrame
    end
    object sLabel13: TsLabel
      Left = 21
      Top = 1
      Width = 160
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1087#1094#1080#1080
      ParentFont = False
      Transparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel14: TsLabel
      Left = 8
      Top = 26
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1050#1086#1076' '#1086#1087#1094#1080#1080
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel11: TsBevel
      Left = 5
      Top = 45
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sBevel12: TsBevel
      Left = 5
      Top = 72
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel19: TsLabel
      Left = 8
      Top = 52
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel16: TsBevel
      Left = 5
      Top = 99
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel20: TsLabel
      Left = 8
      Top = 79
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1053#1072#1080#1084'. '#1076#1083#1103' '#1072#1073#1086#1085#1077#1085#1090#1072'.'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel17: TsBevel
      Left = 5
      Top = 126
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel21: TsLabel
      Left = 8
      Top = 106
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1050#1086#1101#1092'.'#1082#1086#1084#1080#1089#1089#1080#1080
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel18: TsBevel
      Left = 5
      Top = 153
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel22: TsLabel
      Left = 8
      Top = 133
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel23: TsLabel
      Left = 5
      Top = 161
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1059#1089#1083#1086#1074#1080#1077' '#1073#1083#1086#1082#1072
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel1: TsLabel
      Left = 334
      Top = 1
      Width = 176
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = #1054#1073#1097#1080#1077' '#1094#1077#1085#1086#1074#1099#1077' '#1087#1088#1072#1074#1080#1083#1072
      ParentFont = False
      Transparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 321
      Top = 26
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1089' '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel1: TsBevel
      Left = 318
      Top = 45
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sBevel2: TsBevel
      Left = 318
      Top = 72
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel3: TsLabel
      Left = 321
      Top = 52
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1087#1086' '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel3: TsBevel
      Left = 318
      Top = 99
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel4: TsLabel
      Left = 321
      Top = 79
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel4: TsBevel
      Left = 318
      Top = 126
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel5: TsLabel
      Left = 321
      Top = 106
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel5: TsBevel
      Left = 318
      Top = 153
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel6: TsLabel
      Left = 321
      Top = 133
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel24: TsLabel
      Left = 321
      Top = 160
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel7: TsLabel
      Left = 647
      Top = 3
      Width = 254
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = #1062#1077#1085#1086#1074#1099#1077' '#1087#1088#1072#1074#1080#1083#1072' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1090#1072#1088#1080#1092#1072
      ParentFont = False
      Transparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sBevel8: TsBevel
      Left = 631
      Top = 62
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel10: TsLabel
      Left = 634
      Top = 36
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel9: TsBevel
      Left = 631
      Top = 102
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel11: TsLabel
      Left = 634
      Top = 74
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sBevel10: TsBevel
      Left = 631
      Top = 141
      Width = 310
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object sLabel12: TsLabel
      Left = 634
      Top = 114
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sLabel25: TsLabel
      Left = 634
      Top = 154
      Width = 139
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object dbedtOPTION_CODE: TDBEdit
      Left = 150
      Top = 22
      Width = 160
      Height = 21
      DataField = 'OPTION_CODE'
      ReadOnly = True
      TabOrder = 0
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtOPTION_NAME: TDBEdit
      Left = 150
      Top = 49
      Width = 160
      Height = 21
      DataField = 'OPTION_NAME'
      ReadOnly = True
      TabOrder = 1
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtOPTION_NAME_FOR_AB: TDBEdit
      Left = 150
      Top = 76
      Width = 160
      Height = 21
      DataField = 'OPTION_NAME_FOR_AB'
      ReadOnly = True
      TabOrder = 2
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtKOEF_KOMISS_O: TDBEdit
      Left = 152
      Top = 103
      Width = 160
      Height = 21
      DataField = 'KOEF_KOMISS_O'
      ReadOnly = True
      TabOrder = 3
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtDISCR_SPISANIE: TDBEdit
      Left = 150
      Top = 130
      Width = 160
      Height = 21
      DataField = 'DISCR_SPISANIE'
      ReadOnly = True
      TabOrder = 4
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtCALC_UNBLOCK_O: TDBEdit
      Left = 150
      Top = 157
      Width = 160
      Height = 21
      DataField = 'CALC_UNBLOCK_O'
      ReadOnly = True
      TabOrder = 5
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtOPTION_CODE1: TDBEdit
      Left = 463
      Top = 22
      Width = 160
      Height = 21
      DataField = 'BEGIN_DATE'
      ReadOnly = True
      TabOrder = 6
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtOPTION_NAME1: TDBEdit
      Left = 463
      Top = 49
      Width = 160
      Height = 21
      DataField = 'END_DATE'
      ReadOnly = True
      TabOrder = 7
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtOPTION_NAME_FOR_AB1: TDBEdit
      Left = 463
      Top = 76
      Width = 160
      Height = 21
      DataField = 'TURN_ON_COST_o'
      ReadOnly = True
      TabOrder = 8
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtKOEF_KOMISS_O1: TDBEdit
      Left = 463
      Top = 103
      Width = 160
      Height = 21
      DataField = 'MONTHLY_COST_o'
      ReadOnly = True
      TabOrder = 9
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtDISCR_SPISANIE1: TDBEdit
      Left = 463
      Top = 130
      Width = 160
      Height = 21
      DataField = 'OPERATOR_TURN_ON_COST'
      ReadOnly = True
      TabOrder = 10
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtCALC_UNBLOCK_O1: TDBEdit
      Left = 463
      Top = 157
      Width = 160
      Height = 21
      DataField = 'OPERATOR_MONTHLY_COST'
      ReadOnly = True
      TabOrder = 11
      OnMouseEnter = dbedtOPTION_CODEMouseEnter
    end
    object dbedtTURN_ON_COST_o: TDBEdit
      Left = 776
      Top = 33
      Width = 160
      Height = 21
      DataField = 'TURN_ON_COST'
      ReadOnly = True
      TabOrder = 12
    end
    object dbedtMONTHLY_COST_o: TDBEdit
      Left = 776
      Top = 72
      Width = 160
      Height = 21
      DataField = 'MONTHLY_COST'
      ReadOnly = True
      TabOrder = 13
    end
    object dbedtOPERATOR_TURN_ON_COST: TDBEdit
      Left = 776
      Top = 111
      Width = 160
      Height = 21
      DataField = 'TURN_ON_COST_FOR_BILLS'
      ReadOnly = True
      TabOrder = 14
    end
    object dbedtOPERATOR_MONTHLY_COST: TDBEdit
      Left = 776
      Top = 151
      Width = 160
      Height = 21
      DataField = 'MONTHLY_COST_FOR_BILLS'
      ReadOnly = True
      TabOrder = 15
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 962
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnl2: TPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 36
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = 'ttt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnl3: TPanel
      Left = 177
      Top = 0
      Width = 785
      Height = 36
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 368
      ExplicitTop = 24
      ExplicitWidth = 185
      ExplicitHeight = 41
      object sToolBar1: TsToolBar
        Left = 0
        Top = 0
        Width = 785
        Height = 35
        ButtonHeight = 35
        ButtonWidth = 35
        Caption = 'sToolBar1'
        Customizable = True
        DoubleBuffered = True
        EdgeInner = esNone
        EdgeOuter = esNone
        Images = Dm.ImageList24
        List = True
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Transparent = True
        SkinData.SkinSection = 'TOOLBAR'
        ExplicitWidth = 721
        object btnInsert: TToolButton
          Left = 0
          Top = 0
          Action = aInsert
        end
        object btnEdit: TToolButton
          Left = 35
          Top = 0
          Action = aEdit
        end
        object btnDelete: TToolButton
          Left = 70
          Top = 0
          Action = aDelete
        end
        object btn1: TToolButton
          Left = 105
          Top = 0
          Width = 8
          Caption = 'btn1'
          ImageIndex = 10
          Style = tbsSeparator
        end
        object btnPost: TToolButton
          Left = 113
          Top = 0
          Action = aPost
          AutoSize = True
        end
        object btnCancel: TToolButton
          Left = 148
          Top = 0
          Action = aCancel
        end
        object btn2: TToolButton
          Left = 183
          Top = 0
          Width = 8
          Caption = 'btn2'
          ImageIndex = 10
          Style = tbsSeparator
        end
        object btnRefresh: TToolButton
          Left = 191
          Top = 0
          Action = aRefresh
          AutoSize = True
        end
        object btn3: TToolButton
          Left = 226
          Top = 0
          Width = 8
          Caption = 'btn3'
          ImageIndex = 10
          Style = tbsSeparator
        end
        object btnFirst: TToolButton
          Left = 234
          Top = 0
          Action = aFirst
        end
        object btnMovePrev: TToolButton
          Left = 269
          Top = 0
          Action = aMovePrev
        end
        object btnPrev: TToolButton
          Left = 304
          Top = 0
          Action = aPrev
        end
        object btnNext: TToolButton
          Left = 339
          Top = 0
          Action = aNext
        end
        object btnMoveNext: TToolButton
          Left = 374
          Top = 0
          Action = aMoveNext
        end
        object btnLast: TToolButton
          Left = 409
          Top = 0
          Action = aLast
        end
      end
    end
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 440
    Top = 236
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
      Visible = False
      OnExecute = aInsertExecute
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aDeleteExecute
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = aPostExecute
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
      OnExecute = aCancelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Enabled = False
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aFind: TAction
      AutoCheck = True
      Caption = #1055#1086#1080#1089#1082
      Enabled = False
      Hint = #1055#1086#1080#1089#1082' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+G'
      ImageIndex = 15
      ShortCut = 16455
    end
    object aFiltr: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+A'
      ImageIndex = 13
      ShortCut = 16449
    end
    object aNext: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
      OnExecute = aNextExecute
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
      OnExecute = aPrevExecute
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
      OnExecute = aFirstExecute
    end
    object aLast: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 50 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 50 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNextExecute
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  50 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  50 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrevExecute
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Enabled = False
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
    end
  end
end
