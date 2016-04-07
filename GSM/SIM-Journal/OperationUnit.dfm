object OperationForm: TOperationForm
  Left = 0
  Top = 0
  Caption = 'OperationForm'
  ClientHeight = 518
  ClientWidth = 1008
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
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 110
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel2: TsPanel
      Left = 1
      Top = 84
      Width = 1006
      Height = 25
      Align = alBottom
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sLabel1: TsLabel
        Left = 11
        Top = 6
        Width = 65
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object sEdit1: TsEdit
        Left = 216
        Top = 1
        Width = 789
        Height = 23
        Align = alRight
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
        ExplicitHeight = 21
      end
    end
    object sPageControl1: TsPageControl
      Left = 1
      Top = 1
      Width = 1006
      Height = 83
      ActivePage = sTabSheet2
      Align = alClient
      TabOrder = 1
      SkinData.SkinSection = 'PAGECONTROL'
      object sTabSheet1: TsTabSheet
        Caption = #1055#1088#1080#1093#1086#1076
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sLabel2: TsLabel
          Left = 23
          Top = 25
          Width = 36
          Height = 13
          Caption = #1058#1072#1088#1080#1092':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel3: TsLabel
          Left = 386
          Top = 25
          Width = 30
          Height = 13
          Caption = #1044#1072#1090#1072':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel7: TsLabel
          Left = 536
          Top = 25
          Width = 54
          Height = 13
          Caption = #1054#1087#1077#1088#1072#1090#1086#1088':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sDateEdit1: TsDateEdit
          Left = 422
          Top = 21
          Width = 86
          Height = 21
          AutoSize = False
          Color = clWhite
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  .  .    '
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object DBLookupComboBox3: TDBLookupComboBox
          Left = 596
          Top = 21
          Width = 150
          Height = 21
          KeyField = 'OPERATOR_ID'
          ListField = 'OPERATOR_NAME'
          ListSource = dsOperator
          TabOrder = 1
        end
        object DBLookupComboboxEh1: TDBLookupComboboxEh
          Left = 63
          Top = 21
          Width = 288
          Height = 21
          DropDownBox.Rows = 25
          EditButtons = <>
          KeyField = 'TARIFF_ID'
          ListField = 'TARIFF_NAME'
          ListSource = dsTariff
          TabOrder = 2
          Visible = True
        end
      end
      object sTabSheet2: TsTabSheet
        Caption = #1054#1090#1075#1088#1091#1079#1082#1072
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sLabel4: TsLabel
          Left = 238
          Top = 25
          Width = 52
          Height = 13
          Caption = #1057#1091#1073#1072#1075#1077#1085#1090':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sLabel5: TsLabel
          Left = 531
          Top = 23
          Width = 30
          Height = 13
          Caption = #1044#1072#1090#1072':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object Label1: TLabel
          Left = 29
          Top = 24
          Width = 34
          Height = 13
          Caption = #1040#1075#1077#1085#1090':'
        end
        object sDateEdit2: TsDateEdit
          Left = 567
          Top = 20
          Width = 86
          Height = 21
          AutoSize = False
          Color = clWhite
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  .  .    '
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object DBLookupComboboxEh2: TDBLookupComboboxEh
          Left = 296
          Top = 20
          Width = 212
          Height = 21
          DropDownBox.Rows = 25
          EditButtons = <>
          KeyField = 'SUB_AGENT_ID'
          ListField = 'NAME'
          ListSource = dsSubagent
          TabOrder = 1
          Visible = True
        end
        object DBLookupComboboxEh4: TDBLookupComboboxEh
          Left = 69
          Top = 20
          Width = 150
          Height = 21
          DropDownBox.Rows = 25
          EditButtons = <>
          KeyField = 'AGENT_ID'
          ListField = 'NAME'
          ListSource = dsAgent
          TabOrder = 2
          Visible = True
        end
      end
      object sTabSheet3: TsTabSheet
        Caption = #1055#1077#1088#1077#1076#1072#1095#1072
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet4: TsTabSheet
        Caption = #1042#1086#1079#1074#1088#1072#1090
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sLabel6: TsLabel
          Left = 7
          Top = 20
          Width = 30
          Height = 13
          Caption = #1044#1072#1090#1072':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
        end
        object sDateEdit3: TsDateEdit
          Left = 54
          Top = 16
          Width = 86
          Height = 21
          AutoSize = False
          Color = clWhite
          EditMask = '!99/99/9999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  .  .    '
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object sTabSheet5: TsTabSheet
        Caption = #1057#1087#1080#1089#1072#1085#1080#1077
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet6: TsTabSheet
        Caption = #1059#1089#1083#1091#1075#1080
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sBitBtn3: TsBitBtn
          Left = 514
          Top = 14
          Width = 127
          Height = 38
          Caption = #1059#1073#1088#1072#1090#1100' '#1085#1086#1084#1077#1088#1072#13#10#1089#1076#1077#1083#1072#1085#1085#1099#1077' '#1089#1077#1075#1086#1076#1085#1103
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 0
          Visible = False
          OnClick = sBitBtn3Click
          SkinData.SkinSection = 'BUTTON'
        end
        object DBGridEh1: TDBGridEh
          Left = 0
          Top = 0
          Width = 443
          Height = 55
          Align = alLeft
          AllowedOperations = [alopInsertEh, alopUpdateEh]
          AllowedSelections = [gstRecordBookmarks, gstAll]
          AutoFitColWidths = True
          Ctl3D = True
          DataGrouping.GroupLevels = <>
          DataSource = dsOptions
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'Tahoma'
          FooterFont.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghExtendVertLines]
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
          OnDblClick = grMainDblClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'OPTION_NAME'
              Footers = <>
              ReadOnly = True
              Title.Caption = #1054#1087#1094#1080#1103
              Width = 287
            end
            item
              Checkboxes = True
              EditButtons = <>
              FieldName = 'CHK_ON'
              Footers = <>
              Title.Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
              Width = 73
            end
            item
              Checkboxes = True
              EditButtons = <>
              FieldName = 'CHK_OFF'
              Footers = <>
              Title.Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object sTabSheet7: TsTabSheet
        Caption = #1055#1083#1072#1090#1085#1099#1077' '#1057#1052#1057
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sBitBtn2: TsBitBtn
          Left = 219
          Top = 17
          Width = 224
          Height = 38
          Caption = #1053#1077#1087#1088#1086#1076#1072#1085#1085#1099#1077' '#1085#1077#1072#1082#1090#1080#1074#1085#1099#1077' '#13#10#1073#1086#1083#1077#1077' 2 '#1084#1077#1089#1103#1094#1077#1074' '#1089' '#1073#1072#1083#1072#1085#1089#1086#1084' < 3 '#1088'.'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 0
          OnClick = sBitBtn2Click
          SkinData.SkinSection = 'BUTTON'
        end
        object sBitBtn1: TsBitBtn
          Left = 17
          Top = 17
          Width = 184
          Height = 38
          Caption = #1053#1077#1087#1088#1086#1076#1072#1085#1085#1099#1077' '#1085#1077#1072#1082#1090#1080#1074#1085#1099#1077#13#10#1073#1086#1083#1077#1077' 2-'#1093' '#1084#1077#1089#1103#1094#1077#1074
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = sBitBtn1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sTabSheet8: TsTabSheet
        Caption = #1041#1072#1083#1072#1085#1089' '#1080' '#1057#1087#1080#1089#1086#1082' '#1091#1089#1083#1091#1075
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object cbBalance: TCheckBox
          Left = 29
          Top = 29
          Width = 88
          Height = 17
          Caption = ' '#1041#1072#1083#1072#1085#1089
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 0
        end
        object cbServices: TCheckBox
          Left = 146
          Top = 29
          Width = 144
          Height = 17
          Caption = '  '#1057#1087#1080#1089#1086#1082' '#1091#1089#1083#1091#1075
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  object sToolBar1: TsToolBar
    Left = 0
    Top = 110
    Width = 1008
    Height = 54
    ButtonHeight = 52
    ButtonWidth = 108
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
      Left = 108
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 13
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 216
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbLoadXLS: TToolButton
      Left = 224
      Top = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 26
      OnClick = tbLoadXLSClick
    end
    object ToolButton6: TToolButton
      Left = 332
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 26
      Style = tbsSeparator
    end
    object tbHistory: TToolButton
      Left = 340
      Top = 0
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 14
      OnClick = tbHistoryClick
    end
    object ToolButton1: TToolButton
      Left = 448
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 15
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 456
      Top = 0
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' Excel'
      ImageIndex = 15
      OnClick = ToolButton9Click
    end
    object ToolButton5: TToolButton
      Left = 564
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 572
      Top = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1073#1072#1079#1091
      ImageIndex = 6
      OnClick = ToolButton4Click
    end
    object ToolButton8: TToolButton
      Left = 680
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 688
      Top = 0
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      OnClick = ToolButton7Click
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 164
    Width = 758
    Height = 332
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
    OnDblClick = grMainDblClick
    Columns = <
      item
        EditButtons = <
          item
            DropdownMenu = PopupMenu1
            Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1072#1088#1080#1092
          end>
        FieldName = 'agent'
        Footers = <>
        Title.Caption = #1040#1075#1077#1085#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'account'
        Footers = <>
        Title.Caption = #8470' '#1083'/'#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'cellnum'
        Footers = <>
        Title.Caption = #8470' '#1090#1077#1083#1077#1092#1086#1085#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
      end
      item
        EditButtons = <>
        FieldName = 'datelastactiv'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 184
      end
      item
        EditButtons = <>
        FieldName = 'datesell'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1076#1072#1078#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 116
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pFilter: TsPanel
    Left = 758
    Top = 164
    Width = 250
    Height = 332
    Align = alRight
    Caption = 'pFilter'
    TabOrder = 3
    SkinData.SkinSection = 'PANEL'
  end
  object sPanel3: TsPanel
    Left = 0
    Top = 496
    Width = 1008
    Height = 22
    Align = alBottom
    Caption = 'sPanel3'
    TabOrder = 4
    OnClick = sPanel3Click
    SkinData.SkinSection = 'PANEL'
    object sLabel8: TsLabel
      Left = 151
      Top = 5
      Width = 3
      Height = 13
      Align = alCustom
      Alignment = taRightJustify
      ParentFont = False
      OnClick = sPanel3Click
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sProgressBar1: TsProgressBar
      Left = 160
      Top = 1
      Width = 847
      Height = 20
      Align = alRight
      Smooth = True
      Step = 1
      TabOrder = 0
      SkinData.SkinSection = 'GAUGE'
    end
  end
  object vtLoad: TVirtualTable
    AfterOpen = vtLoadAfterInsert
    AfterInsert = vtLoadAfterInsert
    AfterCancel = vtLoadAfterInsert
    AfterDelete = vtLoadAfterInsert
    FieldDefs = <
      item
        Name = 'account'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cellnum'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'tarif'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'simnumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'datelastactiv'
        DataType = ftDate
      end
      item
        Name = 'datesell'
        DataType = ftDate
      end>
    Left = 32
    Top = 256
    Data = {
      0300060007006163636F756E740100640000000000070063656C6C6E756D0100
      640000000000050074617269660100640000000000090073696D6E756D626572
      01001400000000000D00646174656C6173746163746976090000000000000008
      006461746573656C6C0900000000000000000000000000}
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
    object vtLoadsimnumber: TStringField
      FieldName = 'simnumber'
      Size = 100
    end
    object vtLoaddatelastactiv: TDateField
      FieldName = 'datelastactiv'
    end
    object vtLoaddatesell: TDateField
      FieldName = 'datesell'
    end
    object vtLoadagent: TStringField
      FieldName = 'agent'
      Size = 100
    end
  end
  object dsLoad: TDataSource
    DataSet = vtLoad
    Left = 64
    Top = 264
  end
  object dsAgent: TDataSource
    DataSet = qAgent
    Left = 248
    Top = 216
  end
  object qAgent: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select AGENT_ID,'
      '       AGENT_NAME NAME'
      '  from agentS'
      '  order by name')
    Left = 216
    Top = 208
    object qAgentAGENT_ID: TFloatField
      FieldName = 'AGENT_ID'
      Required = True
    end
    object qAgentNAME: TStringField
      FieldName = 'NAME'
      Size = 100
    end
  end
  object spLoad: TOraStoredProc
    StoredProcName = 'PCKG_SIMUTILS.LOAD_OLD_XLS'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  PCKG_SIMUTILS.LOAD_OLD_XLS(:VAGENT, :VOPERATORID, :VSUBAGENT, ' +
        ':VACCOUNT, :VCELLNUMBER, :VSIMNUMBER, :VTARIFFID, :VDATEINIT, :V' +
        'DATEACTIV, :VDATETECHACTIV, :VDATEMOVE);'
      'end;')
    Left = 96
    Top = 272
    ParamData = <
      item
        DataType = ftString
        Name = 'VAGENT'
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
        Name = 'VTARIFFID'
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
  object qSubagent: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select sub_agent_ID,'
      '       sub_agent_NAME NAME'
      '  from sub_agentS'
      '  order by SUB_AGENT_name')
    Left = 216
    Top = 264
    object qSubagentSUB_AGENT_ID: TFloatField
      FieldName = 'SUB_AGENT_ID'
      Required = True
    end
    object qSubagentNAME: TStringField
      FieldName = 'NAME'
      Size = 512
    end
  end
  object dsSubagent: TDataSource
    DataSet = qSubagent
    Left = 248
    Top = 272
  end
  object spSetSimStatus: TOraStoredProc
    StoredProcName = 'PCKG_SIMUTILS.SET_SIM_STATUS2'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  PCKG_SIMUTILS.SET_SIM_STATUS2(:VCELLNUMBER, :VSTATUSID, :VDATE' +
        ', :VDESCR);'
      'end;')
    Left = 88
    Top = 320
    ParamData = <
      item
        DataType = ftString
        Name = 'VCELLNUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'VSTATUSID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'VDATE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'VDESCR'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'PCKG_SIMUTILS.SET_SIM_STATUS2'
  end
  object qOperator: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select operator_id, operator_name from operators'
      'order by operator_name')
    Left = 312
    Top = 208
    object qOperatorOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
      Required = True
    end
    object qOperatorOPERATOR_NAME: TStringField
      FieldName = 'OPERATOR_NAME'
      Size = 400
    end
  end
  object dsOperator: TDataSource
    DataSet = qOperator
    Left = 344
    Top = 216
  end
  object qUpdateMoveSim: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      'update sim s'
      '   set s.subagent_id = :subagentid'
      ' where :idlist like '#39'%;'#39' || s.cell_number || '#39';%'#39';'
      'commit;'
      'end;')
    Debug = True
    Left = 32
    Top = 320
    ParamData = <
      item
        DataType = ftInteger
        Name = 'subagentid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'idlist'
        ParamType = ptInput
      end>
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 408
    Top = 232
  end
  object qTariff: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select tariff_name,'
      '       tariff_id'
      ' from tariffs'
      'where is_active = 1'
      'order by tariff_name')
    Left = 312
    Top = 264
    object qTariffTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTariffTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
  end
  object qOptions: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT OPTION_NAME, 0 chk_on, 0 chk_off'
      '  FROM SIM_PHONE_OPTION_TYPE')
    Left = 288
    Top = 392
    object qOptionsOPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Required = True
      Size = 800
    end
    object qOptionsCHK_ON: TFloatField
      FieldName = 'CHK_ON'
    end
    object qOptionsCHK_OFF: TFloatField
      FieldName = 'CHK_OFF'
    end
  end
  object spSetOptionOn: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.SET_PHONE_OPTION_ON'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER4_PCKG.SET_PHONE_OPTION_ON(:PPHONE_NUMBER, :P' +
        'OPTION_NAME);'
      'end;')
    Left = 248
    Top = 328
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        Value = ''
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'POPTION_NAME'
        ParamType = ptInput
      end>
  end
  object spSetOptionOff: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.SET_PHONE_OPTION_OFF'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER4_PCKG.SET_PHONE_OPTION_OFF(:PPHONE_NUMBER, :' +
        'POPTION_NAME);'
      'end;')
    Left = 280
    Top = 336
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'POPTION_NAME'
        ParamType = ptInput
      end>
  end
  object spSendPaidSMS: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.SEND_PAID_SMS'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := LOADER4_PCKG.SEND_PAID_SMS(:PPHONE_NUMBER);'
      'end;')
    Left = 216
    Top = 440
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
  end
  object spGetPhoneStatus: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.GET_PHONE_STATUS'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER4_PCKG.GET_PHONE_STATUS(:PPHONE_NUMBER, :PFUL' +
        'L_CHECK);'
      'end;')
    Left = 216
    Top = 384
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PFULL_CHECK'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'LOADER4_PCKG.GET_PHONE_STATUS'
  end
  object qSimNoActiv: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CELL_NUMBER'
      '  FROM SIM'
      '  WHERE ADD_MONTHS(SYSDATE,-2)>SIM.DATE_LAST_ACTIVITY'
      '    AND not (SIM.STATUS_ID in (4, 5, 6))'
      '  ORDER BY CELL_NUMBER ASC')
    Left = 360
    Top = 416
    object qSimNoActivCELL_NUMBER: TStringField
      FieldName = 'CELL_NUMBER'
      Required = True
      Size = 10
    end
  end
  object qSimNoActivNoMoney: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT SIM.CELL_NUMBER "'#1058#1077#1083#1077#1092#1086#1085'",'
      '       3-SIM.BALANCE "'#1053#1077#1076#1086#1089#1090#1072#1090#1086#1082'"'
      '  FROM SIM'
      '  WHERE ADD_MONTHS(SYSDATE,-2)>SIM.DATE_LAST_ACTIVITY'
      '    AND not (SIM.STATUS_ID in (4, 5, 6))  '
      '    AND SIM.BALANCE<3'
      '  ORDER BY SIM.CELL_NUMBER ASC')
    Left = 360
    Top = 464
    object qSimNoActivNoMoneyТелефон: TStringField
      FieldName = #1058#1077#1083#1077#1092#1086#1085
      Required = True
      Size = 10
    end
    object qSimNoActivNoMoneyНедостаток: TFloatField
      FieldName = #1053#1077#1076#1086#1089#1090#1072#1090#1086#1082
    end
  end
  object dsTariff: TDataSource
    DataSet = qTariff
    Left = 344
    Top = 272
  end
  object spSimMove: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.SIM_MOVE'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  LOADER4_PCKG.SIM_MOVE(:PCELL_NUMBER, :PAGENT_ID, :PSUB_AGENT_I' +
        'D);'
      'end;')
    Left = 88
    Top = 368
    ParamData = <
      item
        DataType = ftString
        Name = 'PCELL_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PAGENT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PSUB_AGENT_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER4_PCKG.SIM_MOVE'
  end
  object qCheckPhones: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT distinct PHONE_NUMBER'
      '  FROM SIM_PHONE_OPTION_SET_HISTORY'
      '  WHERE OPTION_NAME=:POPTION_NAME'
      '    AND TYPE_SET=:PTYPE_SET'
      
        '    AND(NOTE in ('#39#39', '#39#1054#1096#1080#1073#1082#1072': '#1054#1087#1094#1080#1103' '#1091#1078#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1072#39', '#39#1054#1096#1080#1073#1082#1072': '#1054#1087 +
        #1094#1080#1103' '#1091#1078#1077' '#1086#1090#1082#1083#1102#1095#1077#1085#1072#39'))'
      '  ORDER BY PHONE_NUMBER ASC')
    FetchAll = True
    Left = 88
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pOPTION_NAME'
      end
      item
        DataType = ftUnknown
        Name = 'pTYPE_SET'
      end>
  end
  object ActionList1: TActionList
    Left = 72
    Top = 200
    object aShowSimInfo: TAction
      Caption = 'aShowSimInfo'
      OnExecute = aShowSimInfoExecute
    end
  end
  object dsOptions: TDataSource
    DataSet = qOptions
    Left = 328
    Top = 392
  end
end
