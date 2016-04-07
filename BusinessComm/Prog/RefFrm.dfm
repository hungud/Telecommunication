object RefForm: TRefForm
  Left = 0
  Top = 0
  Caption = 'RefForm'
  ClientHeight = 396
  ClientWidth = 807
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TlBr: TsToolBar
    Left = 0
    Top = 0
    Width = 807
    Height = 29
    ButtonHeight = 32
    ButtonWidth = 35
    DoubleBuffered = True
    Images = Dm.ImageList24
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    SkinData.SkinSection = 'TOOLBAR'
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
    object btn4: TToolButton
      Left = 105
      Top = 0
      Width = 8
      Caption = 'btn4'
      ImageIndex = 3
      Style = tbsSeparator
      Visible = False
    end
    object btnPost: TToolButton
      Left = 113
      Top = 0
      Action = aPost
      Visible = False
    end
    object btnCancel: TToolButton
      Left = 148
      Top = 0
      Action = aCancel
      Visible = False
    end
    object btn7: TToolButton
      Left = 183
      Top = 0
      Width = 8
      Caption = 'btn7'
      ImageIndex = 5
      Style = tbsSeparator
      Visible = False
    end
    object btnRefresh: TToolButton
      Left = 191
      Top = 0
      Action = aRefresh
    end
    object btnFind: TToolButton
      Left = 226
      Top = 0
      Action = aFind
    end
    object btnFiltr: TToolButton
      Left = 261
      Top = 0
      Action = aFiltr
    end
    object btnExcel: TToolButton
      Left = 296
      Top = 0
      Action = aToExcel
    end
    object btn1: TToolButton
      Left = 331
      Top = 0
      Width = 8
      Caption = 'btn1'
      ImageIndex = 16
      Style = tbsSeparator
    end
    object btnFirst: TToolButton
      Left = 339
      Top = 0
      Action = aFirst
    end
    object btnMovePrev: TToolButton
      Left = 374
      Top = 0
      Action = aMovePrev
    end
    object btnPrev: TToolButton
      Left = 409
      Top = 0
      Action = aPrev
    end
    object btnNext: TToolButton
      Left = 444
      Top = 0
      Action = aNext
    end
    object btnMoveNext: TToolButton
      Left = 479
      Top = 0
      Action = aMoveNext
    end
    object btnLast: TToolButton
      Left = 514
      Top = 0
      Action = aLast
    end
  end
  object CRGrid: TCRDBGrid
    Left = 0
    Top = 29
    Width = 807
    Height = 333
    OptionsEx = [dgeLocalFilter, dgeLocalSorting, dgeRecordCount]
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = pm1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    TitleFont.Quality = fqClearTypeNatural
    OnDblClick = CRGridDblClick
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 362
    Width = 807
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      807
      34)
    object sBsave: TsBitBtn
      Left = 516
      Top = 2
      Width = 99
      Height = 31
      Hint = #1042#1099#1073#1088#1072#1090#1100' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = sBsaveClick
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 655
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
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 520
    Top = 36
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Ins'
      ImageIndex = 4
      ShortCut = 45
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
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
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
  end
  object pm1: TPopupMenu
    Left = 488
    Top = 36
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
  object qGetNewId: TOraStoredProc
    Session = Dm.OraSession
    Left = 696
    Top = 41
  end
end
