inherited RepFrm: TRepFrm
  Left = 549
  Top = 405
  HorzScrollBar.Style = ssFlat
  HorzScrollBar.Tracking = True
  Caption = 'RepFrm'
  ClientHeight = 593
  ClientWidth = 1426
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1434
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter1: TsSplitter
    Left = 0
    Top = 179
    Width = 1426
    Height = 6
    Cursor = crVSplit
    ParentCustomHint = False
    Align = alTop
    Color = clSkyBlue
    ParentColor = False
    ResizeStyle = rsLine
    Visible = False
    Glyph.Data = {
      EE020000424DEE0200000000000036000000280000003A000000030000000100
      200000000000B802000000000000000000000000000000000000FFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF46DE79FF2FDE6AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF30E96CFF30E96CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF46DE79FF2FDE6AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF30E96CFF30E96CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00EF
      1FFF00EF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF29E16CFF28EA6BFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFFFFFFFFFF40E67AFF34E776FF27E767FF28E9
      6BFFFFFFFFFFFFFFFFFF2FE970FF2AEA6CFF2AEA6CFF18FF5FFFFFFFFFFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFFFFFFFFFF40E67AFF34E776FF27E767FF28E9
      6BFFFFFFFFFFFFFFFFFF2FE970FF2AEA6CFF2AEA6CFF18FF5FFFFFFFFFFFFFFF
      FFFF616676FF616676FF616676FF0BFF4DFFFFFFFFFFFFFFFFFF21F367FF22EE
      67FF22EA5EFF2EF06DFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2DEA
      6FFF2FE970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A9C47FF1A9C47FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2DEA
      6FFF2FE970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A9C47FF1A9C47FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF23C04AFF2DB852FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF2DB852FF36AA55FFFFFFFFFF}
    ShowGrip = True
    SkinData.SkinSection = 'SPLITTER'
    ExplicitLeft = 8
    ExplicitTop = 0
    ExplicitWidth = 1275
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 574
    Width = 1426
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Style = psOwnerDraw
        Width = 200
      end>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object CRGrid: TCRDBGrid
    Left = 0
    Top = 185
    Width = 1426
    Height = 389
    OptionsEx = [dgeLocalFilter, dgeLocalSorting, dgeRecordCount]
    Align = alClient
    DataSource = dsqReport
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object sScrollBox1: TsScrollBox
    Left = 0
    Top = 0
    Width = 1426
    Height = 179
    HorzScrollBar.Color = clSkyBlue
    HorzScrollBar.ParentColor = False
    Align = alTop
    Constraints.MinHeight = 179
    TabOrder = 2
    SkinData.SkinSection = 'PANEL_LOW'
    object spMobOper: TsPanel
      Left = 0
      Top = 0
      Width = 268
      Height = 175
      Align = alLeft
      TabOrder = 0
      Visible = False
      SkinData.SkinSection = 'PANEL'
      object slMobOperCapt: TsLabel
        Left = 4
        Top = 2
        Width = 114
        Height = 41
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1052#1086#1073#1080#1083#1100#1085#1099#1081' '#1086#1087#1077#1088#1072#1090#1086#1088': '#1074#1099#1073#1088#1072#1085#1086' - 0.'
        ParentFont = False
        Visible = False
        WordWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
      end
      object sAll1: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 47
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedAll1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object s_cancel1: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 72
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aUncheckedAll1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 50
        Images = Dm.ImageList24
      end
      object sbCheckedSel1: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 123
        Width = 115
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedSel1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object sbCheckSel2: TsSpeedButton
        Left = 93
        Top = 99
        Width = 25
        Height = 22
        Hint = #1042#1099#1087#1086#1083#1085#1088#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        OnClick = sbCheckSel2Click
        SkinData.SkinSection = 'SPEEDBUTTON'
        ImageIndex = 39
        Images = Dm.ImageList24
      end
      object CLB_Mob_Oper: TsCheckListBox
        Left = 121
        Top = 5
        Width = 144
        Height = 152
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiSelect = True
        ParentFont = False
        PopupMenu = pm2
        TabOrder = 0
        Visible = False
        OnClick = CLB_Mob_OperClick
        OnMouseDown = CLB_Mob_OperMouseDown
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
        OnClickCheck = CLB_Mob_OperClickCheck
      end
      object seMobOperSearch: TsEdit
        Left = 1
        Top = 99
        Width = 86
        Height = 21
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        AutoSize = False
        TabOrder = 1
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
    object spFilial: TsPanel
      Left = 268
      Top = 0
      Width = 268
      Height = 175
      Align = alLeft
      BevelOuter = bvSpace
      TabOrder = 1
      Visible = False
      SkinData.SkinSection = 'PANEL'
      object slFilialCapt: TsLabel
        Left = 4
        Top = 2
        Width = 114
        Height = 41
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1060#1080#1083#1080#1072#1083#1099': '#1074#1099#1073#1088#1072#1085#1086' - 0.'
        ParentFont = False
        WordWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
      end
      object sAll3: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 47
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedAll3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object s_cancel3: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 72
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aUncheckedAll3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 50
        Images = Dm.ImageList24
      end
      object sbCheckedSel3: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 123
        Width = 115
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedSel3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object sbCheckSel4: TsSpeedButton
        Left = 93
        Top = 99
        Width = 25
        Height = 22
        Hint = #1042#1099#1087#1086#1083#1085#1088#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        OnClick = sbCheckSel4Click
        SkinData.SkinSection = 'SPEEDBUTTON'
        ImageIndex = 39
        Images = Dm.ImageList24
      end
      object CLB_Filial: TsCheckListBox
        Left = 121
        Top = 2
        Width = 144
        Height = 152
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiSelect = True
        ParentFont = False
        TabOrder = 0
        OnClick = CLB_FilialClick
        OnMouseDown = CLB_VirtAccMouseDown
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
        OnClickCheck = CLB_FilialClickCheck
      end
      object seFilialSearch: TsEdit
        Left = 4
        Top = 99
        Width = 86
        Height = 21
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        AutoSize = False
        TabOrder = 1
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
    object spVirtAcc: TsPanel
      Left = 536
      Top = 0
      Width = 268
      Height = 175
      Align = alLeft
      TabOrder = 2
      Visible = False
      SkinData.SkinSection = 'PANEL'
      object slVirtAcc: TsLabel
        Left = 4
        Top = 2
        Width = 114
        Height = 41
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090': '#1074#1099#1073#1088#1072#1085#1086' - 0.'
        ParentFont = False
        WordWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
      end
      object sAll2: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 47
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedAll2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object s_cancel2: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 72
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aUncheckedAll2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 50
        Images = Dm.ImageList24
      end
      object sbCheckedSel2: TsSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 123
        Width = 115
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedSel2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object sbCheckSel3: TsSpeedButton
        Left = 93
        Top = 99
        Width = 25
        Height = 22
        Hint = #1042#1099#1087#1086#1083#1085#1088#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        OnClick = sbCheckSel3Click
        SkinData.SkinSection = 'SPEEDBUTTON'
        ImageIndex = 39
        Images = Dm.ImageList24
      end
      object CLB_VirtAcc: TsCheckListBox
        Left = 120
        Top = 2
        Width = 144
        Height = 152
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiSelect = True
        ParentFont = False
        PopupMenu = pm3
        TabOrder = 0
        OnClick = CLB_VirtAccClick
        OnMouseDown = CLB_VirtAccMouseDown
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
        OnClickCheck = CLB_VirtAccClickCheck
      end
      object seVirtAccSearch: TsEdit
        Left = 3
        Top = 99
        Width = 86
        Height = 21
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        AutoSize = False
        TabOrder = 1
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
    object spAccount: TsPanel
      Left = 804
      Top = 0
      Width = 266
      Height = 175
      Align = alLeft
      TabOrder = 3
      Visible = False
      SkinData.SkinSection = 'PANEL'
      object slAccontCapt: TsLabel
        Left = 2
        Top = 2
        Width = 115
        Height = 41
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090': '#1074#1099#1073#1088#1072#1085#1086' - 0.'
        ParentFont = False
        WordWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
      end
      object sAll: TsSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 47
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedAll
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object s_cancel: TsSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 72
        Width = 115
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aUncheckedAll
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 50
        Images = Dm.ImageList24
      end
      object sbCheckedSel: TsSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 123
        Width = 115
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aCheckedSel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 49
        Images = Dm.ImageList24
      end
      object sbCheckSel: TsSpeedButton
        Left = 92
        Top = 99
        Width = 25
        Height = 22
        Hint = #1042#1099#1087#1086#1083#1085#1088#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        OnClick = sbCheckSelClick
        SkinData.SkinSection = 'SPEEDBUTTON'
        ImageIndex = 39
        Images = Dm.ImageList24
      end
      object CLB_Accounts: TsCheckListBox
        Left = 119
        Top = 1
        Width = 144
        Height = 152
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
        BorderStyle = bsSingle
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MultiSelect = True
        ParentFont = False
        PopupMenu = pm1
        TabOrder = 0
        OnClick = CLB_AccountsClick
        OnMouseDown = CLB_AccountsMouseDown
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
        OnClickCheck = CLB_AccountsClickCheck
      end
      object sp: TsPanel
        Left = 119
        Top = 30
        Width = 144
        Height = 153
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        Visible = False
        SkinData.SkinSection = 'PANEL'
        object sGauge1: TsGauge
          Left = 3
          Top = 66
          Width = 268
          Height = 20
          SkinData.SkinSection = 'GAUGE'
          ForeColor = clSkyBlue
          MaxValue = 10
          Progress = 2
          Suffix = '%'
        end
      end
      object seAccountSearch: TsEdit
        Left = 2
        Top = 99
        Width = 86
        Height = 21
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
        AutoSize = False
        TabOrder = 1
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
    object cbPeriod: TsComboBox
      Left = 1119
      Top = 20
      Width = 132
      Height = 22
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1055#1077#1088#1080#1086#1076':'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object spFiltrSearch: TsPanel
      Left = 1253
      Top = 15
      Width = 167
      Height = 32
      BevelOuter = bvNone
      TabOrder = 5
      SkinData.SkinSection = 'PANEL'
      object sBevel4: TsBevel
        Left = 80
        Top = -4
        Width = 3
        Height = 38
      end
      object sbFind: TsSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 77
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFind
        AllowAllUp = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 15
        Images = Dm.ImageList24
      end
      object sbFiltr: TsSpeedButton
        AlignWithMargins = True
        Left = 85
        Top = 1
        Width = 80
        Height = 31
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFiltr
        AllowAllUp = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 13
        Images = Dm.ImageList24
      end
      object sBevel5: TsBevel
        Left = 167
        Top = -4
        Width = 3
        Height = 38
      end
    end
    object spShow: TsPanel
      Left = 1076
      Top = 58
      Width = 342
      Height = 34
      BevelOuter = bvNone
      TabOrder = 6
      SkinData.SkinSection = 'PANEL'
      object sBevel1: TsBevel
        Left = 107
        Top = 1
        Width = 3
        Height = 38
      end
      object sBevel2: TsBevel
        Left = 218
        Top = 2
        Width = 3
        Height = 38
        Visible = False
      end
      object sbShowSel: TsSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 104
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aRefresh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 9
        Images = Dm.ImageList24
      end
      object sbToExcel: TsSpeedButton
        AlignWithMargins = True
        Left = 112
        Top = 1
        Width = 104
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aToExcel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 45
        Images = Dm.ImageList24
      end
      object sbInfoShow: TsSpeedButton
        AlignWithMargins = True
        Left = 223
        Top = 1
        Width = 117
        Height = 33
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 17
        Images = Dm.ImageList24
      end
    end
    object pButtonMove: TsPanel
      Left = 1079
      Top = 102
      Width = 226
      Height = 30
      BevelOuter = bvNone
      TabOrder = 7
      SkinData.SkinSection = 'PANEL'
      object sbFirst: TsSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFirst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 0
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sbMovePrior: TsSpeedButton
        AlignWithMargins = True
        Left = 38
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aMovePrev
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 43
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sbPrior: TsSpeedButton
        AlignWithMargins = True
        Left = 74
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aPrev
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 1
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sbNext: TsSpeedButton
        AlignWithMargins = True
        Left = 110
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aNext
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 2
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sbMoveNext: TsSpeedButton
        AlignWithMargins = True
        Left = 145
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aMoveNext
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 42
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sBevel3: TsBevel
        Left = 34
        Top = -5
        Width = 3
        Height = 38
      end
      object sBevel6: TsBevel
        Left = 176
        Top = -3
        Width = 3
        Height = 38
      end
      object sBevel7: TsBevel
        Left = 141
        Top = -3
        Width = 3
        Height = 38
      end
      object sBevel8: TsBevel
        Left = 106
        Top = -3
        Width = 3
        Height = 38
      end
      object sBevel9: TsBevel
        Left = 70
        Top = -4
        Width = 3
        Height = 38
      end
      object sbLast: TsSpeedButton
        AlignWithMargins = True
        Left = 180
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aLast
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SkinData.SkinSection = 'SPEEDBUTTON'
        DisabledGlyphKind = [dgBlended, dgGrayed]
        ImageIndex = 3
        Images = Dm.ImageList24
        ShowCaption = False
      end
    end
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 576
    Top = 444
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' F2'
      ImageIndex = 6
      ShortCut = 113
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+Del'
      ImageIndex = 5
      ShortCut = 16430
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      ImageIndex = 7
      ShortCut = 16467
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
      ShortCut = 27
    end
    object aRefresh: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077' -  '#1082#1083#1072#1074#1080#1096#1072' F5'
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
      OnExecute = aFindExecute
    end
    object aFiltr: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Enabled = False
      Hint = #1060#1080#1083#1100#1090#1088' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+A'
      ImageIndex = 13
      ShortCut = 16449
      OnExecute = aFiltrExecute
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
      Caption = 'aLast'
      Enabled = False
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNextExecute
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Enabled = False
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrevExecute
    end
    object aToExcel: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Enabled = False
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcelExecute
    end
    object aInfo: TAction
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Enabled = False
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1073#1086#1085#1077#1085#1090#1077
      ImageIndex = 17
      Visible = False
      OnExecute = aInfoExecute
    end
    object aCheckedAll: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAllExecute
    end
    object aUncheckedAll: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077'       '
      Enabled = False
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077
      ImageIndex = 50
      OnExecute = aUncheckedAllExecute
    end
    object aCheckedSel: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Enabled = False
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099
      ImageIndex = 49
      OnExecute = aCheckedSelExecute
    end
    object aCheckedAll1: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAll1Execute
    end
    object aUncheckedAll1: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077'       '
      Enabled = False
      ImageIndex = 50
      OnExecute = aUncheckedAll1Execute
    end
    object aCheckedSel1: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Enabled = False
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099
      ImageIndex = 49
      OnExecute = aCheckedSel1Execute
    end
    object aCheckedAll2: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAll2Execute
    end
    object aUncheckedAll2: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077'       '
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077
      ImageIndex = 50
      OnExecute = aUncheckedAll2Execute
    end
    object aCheckedSel2: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099
      ImageIndex = 49
      OnExecute = aCheckedSel2Execute
    end
    object aCheckedAll3: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAll3Execute
    end
    object aUncheckedAll3: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077
      ImageIndex = 50
      OnExecute = aUncheckedAll3Execute
    end
    object aCheckedSel3: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099
      ImageIndex = 49
      OnExecute = aCheckedSel3Execute
    end
  end
  object pm1: TPopupMenu
    Images = Dm.ImageList24
    Left = 1232
    Top = 392
    object D1: TMenuItem
      Action = aCheckedAll
    end
    object N1: TMenuItem
      Action = aUncheckedAll
    end
    object miCheckedSel: TMenuItem
      Action = aCheckedSel
    end
  end
  object qMonthYearforRepFrm: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT '
      '   p.YEARS, '
      '   p.MONTHS, '
      '   p.YEAR_MONTH, '
      '   p.YEAR_MONTH_NAME'
      'FROM V_PERIODS p '
      'where p.IS_ACTIVE = 1 '
      'order by YEAR_MONTH desc')
    Left = 54
    Top = 347
    object qMonthYearforRepFrmYEARS: TFloatField
      FieldName = 'YEARS'
      Required = True
    end
    object qMonthYearforRepFrmMONTHS: TFloatField
      FieldName = 'MONTHS'
      Required = True
    end
    object qMonthYearforRepFrmYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qMonthYearforRepFrmYEAR_MONTH_NAME: TStringField
      FieldName = 'YEAR_MONTH_NAME'
      Size = 59
    end
  end
  object qAccount: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select distinct '
      '        v.ACCOUNT_ID,'
      '        v.ACCOUNT_NUMBER, '
      '        v.login, '
      '        v.ACCOUNT_NUMBER||'#39'; '#39'||v.login  ACCOUNT_NUMBER_LOGIN'
      '  from ACCOUNTS v'
      ' ORDER BY ACCOUNT_NUMBER ASC')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    Left = 414
    Top = 410
    object qAccountACCOUNT_ID: TFloatField
      DisplayWidth = 13
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qAccountLOGIN: TStringField
      DisplayWidth = 58
      FieldName = 'LOGIN'
      Size = 30
    end
    object qAccountACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
      Required = True
    end
    object qAccountACCOUNT_NUMBER_LOGIN: TStringField
      FieldName = 'ACCOUNT_NUMBER_LOGIN'
      Size = 72
    end
  end
  object dsqAccount: TOraDataSource
    Tag = 1
    DataSet = qAccount
    Left = 412
    Top = 458
  end
  object qReport: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select'
      '  DATE_PAY,'
      '  VIRTUAL_ACCOUNTS_NAME,'
      '  INN,'
      '  PHONE_ID,'
      '  SUM_PAY,'
      '  DOC_NUMBER,'
      '  PAYMENT_PURPOSE,'
      '  file_name'
      'from'
      '  V_PAYMENTS'
      'where'
      '  year_month = :year_month')
    FetchRows = 1000
    Filtered = True
    BeforeOpen = qReportBeforeOpen
    Left = 734
    Top = 379
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'year_month'
      end>
  end
  object dsqReport: TOraDataSource
    Tag = 1
    DataSet = qReport
    Left = 735
    Top = 442
  end
  object qMob_Oper: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select distinct '
      '  v.MOBILE_OPERATOR_NAME_ID,'
      '  v.MOBILE_OPERATOR_NAME'
      '  from MOBILE_OPERATOR_NAMES v'
      'ORDER BY MOBILE_OPERATOR_NAME ASC')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    Left = 89
    Top = 402
    object qMob_OperMOBILE_OPERATOR_NAME_ID: TFloatField
      FieldName = 'MOBILE_OPERATOR_NAME_ID'
      Required = True
    end
    object qMob_OperMOBILE_OPERATOR_NAME: TStringField
      FieldName = 'MOBILE_OPERATOR_NAME'
      Required = True
      Size = 240
    end
  end
  object dsqMob_Oper: TOraDataSource
    Tag = 1
    DataSet = qMob_Oper
    Left = 87
    Top = 450
  end
  object pm2: TPopupMenu
    Left = 216
    Top = 16
    object MenuItem1: TMenuItem
      Action = aCheckedAll1
    end
    object MenuItem2: TMenuItem
      Action = aUncheckedAll1
    end
    object miCheckedSel1: TMenuItem
      Action = aCheckedSel1
    end
  end
  object qLogin: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select ROWNUM id, login from'
      '(select  distinct login from aCCOUNTS '
      'order by login'
      ')r'
      'union '
      'select 0, '#39#1042#1089#1105#39' login from dual')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    BeforeOpen = qAccountBeforeOpen
    Left = 478
    Top = 410
    object qLoginID: TFloatField
      FieldName = 'ID'
    end
    object qLoginLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 30
    end
  end
  object dsqLogin: TOraDataSource
    Tag = 1
    DataSet = qLogin
    Left = 476
    Top = 458
  end
  object qVirt_Acc: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select distinct '
      '    v.VIRTUAL_ACCOUNTS_ID, '
      '    v.VIRTUAL_ACCOUNTS_name,'
      '    v.INN '
      '    from VIRTUAL_ACCOUNTS v'
      '    order by VIRTUAL_ACCOUNTS_name')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    BeforeOpen = qVirt_AccBeforeOpen
    AfterOpen = qVirt_AccAfterOpen
    Left = 342
    Top = 410
    object qVirt_AccVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
    end
    object qVirt_AccVIRTUAL_ACCOUNTS_NAME: TStringField
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object qVirt_AccINN: TStringField
      FieldName = 'INN'
      Size = 48
    end
  end
  object dsqVirt_Acc: TOraDataSource
    Tag = 1
    DataSet = qVirt_Acc
    Left = 340
    Top = 458
  end
  object pm3: TPopupMenu
    Left = 664
    Top = 392
    object MenuItem3: TMenuItem
      Action = aCheckedAll2
    end
    object MenuItem4: TMenuItem
      Action = aUncheckedAll2
    end
    object MenuItem5: TMenuItem
      Action = aCheckedSel2
    end
  end
  object qAccount_cnt: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT count(account_id) cnt'
      'FROM ACCOUNTS '
      'where '
      '(filial_id is not null)')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    Left = 249
    Top = 450
    object qAccount_cntCNT: TFloatField
      FieldName = 'CNT'
    end
  end
  object pm4: TPopupMenu
    Left = 528
    Top = 424
    object MenuItem6: TMenuItem
      Action = aCheckedAll3
    end
    object MenuItem7: TMenuItem
      Action = aUncheckedAll3
    end
    object MenuItem8: TMenuItem
      Action = aCheckedSel3
    end
  end
  object qfilials: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select distinct '
      '      v.filial_id, '
      '      v.filial_name '
      '     from FILIALS v'
      'ORDER BY filial_name ASC')
    FetchRows = 1000
    Options.TemporaryLobUpdate = True
    Options.PrepareUpdateSQL = True
    BeforeOpen = qfilialsBeforeOpen
    AfterOpen = qfilialsAfterOpen
    Left = 185
    Top = 410
    object qfilialsFILIAL_ID: TFloatField
      FieldName = 'FILIAL_ID'
    end
    object qfilialsFILIAL_NAME: TStringField
      FieldName = 'FILIAL_NAME'
      Size = 200
    end
  end
  object dsqfilials: TOraDataSource
    Tag = 1
    DataSet = qfilials
    Left = 183
    Top = 458
  end
end
