inherited RepFrm: TRepFrm
  Left = 549
  Top = 405
  Caption = 'RepFrm'
  ClientHeight = 481
  ClientWidth = 736
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 744
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter1: TsSplitter
    Left = 0
    Top = 107
    Width = 736
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
    ExplicitTop = 97
    ExplicitWidth = 928
  end
  object sStatusBar1: TsStatusBar
    Left = 0
    Top = 462
    Width = 736
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
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 736
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 14
      Top = 9
      Width = 86
      Height = 13
      Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090':'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object sAll: TsSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 25
      Width = 96
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aCheckedAll
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 49
      Images = Dm.ImageList24
    end
    object s_cancel: TsSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 67
      Width = 96
      Height = 31
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aUncheckedAll
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 50
      Images = Dm.ImageList24
    end
    object sPanel2: TsPanel
      Left = 419
      Top = 60
      Width = 306
      Height = 38
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object sBevel1: TsBevel
        Left = 95
        Top = 1
        Width = 3
        Height = 38
      end
      object sBevel2: TsBevel
        Left = 197
        Top = 2
        Width = 3
        Height = 38
      end
      object sBitBtn1: TsBitBtn
        Left = 3
        Top = 0
        Width = 91
        Height = 36
        Action = aRefresh
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 9
        Images = Dm.ImageList24
      end
      object sBitBtn2: TsBitBtn
        Left = 100
        Top = 0
        Width = 95
        Height = 36
        Action = aToExcel
        Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 45
        Images = Dm.ImageList24
      end
      object sBitBtn3: TsBitBtn
        Left = 202
        Top = 0
        Width = 102
        Height = 36
        Action = aInfo
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
        TabOrder = 2
        SkinData.SkinSection = 'BUTTON'
        ImageIndex = 17
        Images = Dm.ImageList24
      end
    end
    object sPanel3: TsPanel
      Left = 564
      Top = 15
      Width = 171
      Height = 38
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object sBevel4: TsBevel
        Left = 84
        Top = 1
        Width = 3
        Height = 38
      end
      object sBitBtn4: TsBitBtn
        Left = 89
        Top = 0
        Width = 80
        Height = 36
        Action = aFiltr
        Caption = #1060#1080#1083#1100#1090#1088
        TabOrder = 0
        SkinData.SkinSection = 'BUTTON'
        Down = True
        ImageIndex = 13
        Images = Dm.ImageList24
      end
      object sBitBtn5: TsBitBtn
        Left = 2
        Top = 0
        Width = 80
        Height = 36
        Action = aFind
        Caption = #1055#1086#1080#1089#1082
        TabOrder = 1
        SkinData.SkinSection = 'BUTTON'
        Down = True
        ImageIndex = 15
        Images = Dm.ImageList24
      end
    end
    object cbPeriod: TsComboBox
      Left = 434
      Top = 20
      Width = 129
      Height = 22
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1052#1077#1089#1103#1094':'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object CLB_Accounts: TsCheckListBox
      Left = 103
      Top = 1
      Width = 279
      Height = 104
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1080#1083#1080' '#1089#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077' - '#1087#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072' '#1084#1099#1096#1080
      BorderStyle = bsSingle
      Color = clWhite
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      PopupMenu = pm1
      TabOrder = 3
      Visible = False
      BoundLabel.Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
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
  end
  object cRGrid: TCRDBGrid
    Left = 0
    Top = 113
    Width = 736
    Height = 349
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleFont.Quality = fqClearTypeNatural
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 520
    Top = 164
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
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
    end
    object aPrev: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
    end
    object aFirst: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
    end
    object aLast: TAction
      Caption = 'aLast'
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
    end
    object aMoveNext: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
    end
    object aMovePrev: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
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
      OnExecute = aInfoExecute
    end
    object aCheckedAll: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
      OnExecute = aCheckedAllExecute
    end
    object aUncheckedAll: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
      Enabled = False
      ImageIndex = 50
      OnExecute = aUncheckedAllExecute
    end
  end
  object pm1: TPopupMenu
    Left = 240
    Top = 16
    object D1: TMenuItem
      Action = aCheckedAll
    end
    object N1: TMenuItem
      Action = aUncheckedAll
    end
  end
end
