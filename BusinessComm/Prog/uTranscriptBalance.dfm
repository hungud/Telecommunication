inherited TranscriptBalanceFrm: TTranscriptBalanceFrm
  Caption = 'TranscriptBalanceFrm'
  ClientHeight = 524
  ClientWidth = 870
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 886
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 153
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object Bevel2: TBevel
      Left = 7
      Top = 16
      Width = 379
      Height = 123
    end
    object sLabel5: TsLabel
      Left = 15
      Top = 3
      Width = 61
      Height = 13
      Caption = #1041#1072#1083#1072#1085#1089' '#1085#1072' '
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object DBGridEh2: TDBGridEh
      Left = 16
      Top = 22
      Width = 365
      Height = 115
      AutoFitColWidths = True
      DataGrouping.GroupLevels = <>
      DataSource = dsMonthBalance
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      IndicatorOptions = [gioShowRecNoEh]
      OddRowColor = 15269887
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGridEh2CellClick
      OnDblClick = DBGridEh2DblClick
      Columns = <
        item
          Checkboxes = False
          EditButtons = <>
          FieldName = 'YEAR_MONTH_NAME'
          Footers = <>
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 119
        end
        item
          EditButtons = <>
          FieldName = 'DATE_BALANCE'
          Footers = <>
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'SUM_BALANCE'
          Footers = <>
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 96
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object pButtonMove: TsPanel
      Left = 387
      Top = 22
      Width = 262
      Height = 77
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'PANEL'
      object sbFirst: TsSpeedButton
        AlignWithMargins = True
        Left = 26
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFirst
        Flat = True
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
        Left = 56
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aMovePrev
        Flat = True
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
        Left = 86
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aPrev
        Flat = True
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
        Left = 116
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aNext
        Flat = True
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
        Left = 146
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aMoveNext
        Flat = True
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
      object sbLast: TsSpeedButton
        AlignWithMargins = True
        Left = 176
        Top = 45
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aLast
        Flat = True
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
      object sSpeedButton1: TsSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aInsert
        Flat = True
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
        ImageIndex = 4
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton2: TsSpeedButton
        AlignWithMargins = True
        Left = 32
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aEdit
        Flat = True
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
        ImageIndex = 6
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton3: TsSpeedButton
        AlignWithMargins = True
        Left = 62
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aDelete
        Flat = True
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
        ImageIndex = 5
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton4: TsSpeedButton
        AlignWithMargins = True
        Left = 92
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aRefresh
        Flat = True
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
        ImageIndex = 9
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton5: TsSpeedButton
        AlignWithMargins = True
        Left = 122
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFiltr
        Flat = True
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
        ImageIndex = 13
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton6: TsSpeedButton
        AlignWithMargins = True
        Left = 154
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aFind
        Flat = True
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
        ImageIndex = 15
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton7: TsSpeedButton
        AlignWithMargins = True
        Left = 184
        Top = 0
        Width = 30
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aToExcel
        Flat = True
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
        ImageIndex = 45
        Images = Dm.ImageList24
        ShowCaption = False
      end
      object sSpeedButton8: TsSpeedButton
        AlignWithMargins = True
        Left = 226
        Top = 0
        Width = 30
        Height = 30
        Hint = 
          #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1072#1095#1072#1083#1100#1085#1086#1075#1086' '#1073#1072#1083#1072#1085#1089#1072' '#1080' '#1087#1077#1088#1077#1089#1095#1077#1090' '#1084#1077#1089#1103#1095#1085#1086#1075 +
          #1086' '#1073#1072#1083#1072#1085#1089#1072
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Action = aInsertAuto
        Flat = True
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
        ImageIndex = 25
        Images = Dm.ImageList24
        ShowCaption = False
      end
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 153
    Width = 870
    Height = 371
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
    IndicatorOptions = [gioShowRowIndicatorEh]
    OddRowColor = 16510691
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    ReadOnly = True
    SumList.Active = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    UseMultiTitle = True
    OnApplyFilter = DBGridEh1ApplyFilter
    Columns = <
      item
        EditButtons = <>
        FieldName = 'PHONE_ID'
        Footer.ValueType = fvtStaticText
        Footers = <>
        Width = 130
      end
      item
        EditButtons = <>
        FieldName = 'BALANCE_TYPE_NAME'
        Footers = <>
        Width = 161
      end
      item
        Alignment = taRightJustify
        EditButtons = <>
        FieldName = 'DATE_BALANCE'
        Footers = <>
        Width = 124
      end
      item
        EditButtons = <>
        FieldName = 'SUM_BALANCE'
        Footer.ValueType = fvtStaticText
        Footers = <>
        MRUList.Active = True
        Width = 142
      end
      item
        EditButtons = <>
        FieldName = 'SUM_PAY'
        Footer.ValueType = fvtSum
        Footers = <>
        Width = 142
      end
      item
        EditButtons = <
          item
            Glyph.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000F207F6FF6B427BFF8C409AFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000F008
              F5FF346D3FFF009103FF009500FF834890FF0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000F202F3FF4A59
              5AFF008813FF007B2AFF008027FF0D8D25FFC735BEFF00000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000943899FF00AB
              18FF009631FF007B29FF00802EFF009321FF0C9327FFCB19D5FF000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000E110DEFF00AC0AFF1AD3
              46FF1CC746FF1DC346FF00952FFF00792EFF00921FFF258231FFFF03FFFF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FE00FFFF00B000FF19E14FFF1FC9
              4CFF1EC54BFF1DCF47FF2BD554FF23CE4AFF08A339FF00B321FF4B6054FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000ED09EBFF077A21FF14E84BFF21D050FF1DCD
              4EFF1DCE4FFF1DCD4FFF1BCD4DFF21D251FF38D762FF20C057FF00BF00FF8441
              8AFF000000000000000000000000000000000000000000000000000000000000
              00000000000000000000F400F5FF506658FF0BD73CFF29D75AFF25D151FF21D2
              52FF22D152FF21D152FF21D152FF33D264FF2AD65FFF22D953FF1CD75BFF00A2
              17FF99309EFF0000000000000000000000000000000000000000000000000000
              000000000000000000007A4C7AFF0DD62FFF25E462FF26D456FF26D55EFF26D5
              5EFF26DA58FF21D552FF3CDC6CFF30D961FF22D854FF24D755FF2BD85FFF1BE8
              52FF14992CFFCC0BC7FF00000000000000000000000000000000000000000000
              0000000000009F1EA1FF02AE2BFF25ED63FF26DC60FF25DC5EFF25DC5FFF25DC
              5FFF20DD5BFF47DD76FF25DD5FFF25DD5EFF25DD5EFF25DD5DFF24DB5FFF29E3
              62FF16E553FF29823AFFE601DDFF000000000000000000000000000000000000
              0000E10CE0FF00C222FF25FE6EFF28E16BFF27EA6AFF27E069FF2BE968FF29E4
              69FF45DE78FF2EDE69FF2CE768FF28DD68FF30DE68FF29DD69FF2FE96BFF27DD
              62FF34EB73FF09F04BFF3A6B51FFFA00F8FF0000000000000000000000000000
              0000C51ECCFF00EF1EFF20F366FF21EE66FF21EA5DFF2DF06CFF26E767FF3FE6
              79FF33E775FF26E766FF27E96AFF2FE96AFF2EE869FF2EE96FFF29EA6BFF17FF
              5EFF19FC62FF0AFF4CFF3B8D4AFFF800F6FF0000000000000000000000000000
              0000F900F9FF606575FF22C049FF2CB851FF35AA54FF0FB43FFF44FB89FF34E9
              73FF2CEA6EFF2EE96FFF2EEF70FF2EEC6FFF2FEF73FF20F36FFF199C46FF5770
              76FF437A6BFF437B5EFF9B2EA1FF000000000000000000000000000000000000
              000000000000FA02FBFFD623D6FFD71BD8FFF136ECFF00B013FF48FF96FF2AF4
              73FF2DF575FF2DF579FF2EF475FF2DF475FF33F679FF17FF60FF3B5451FF0000
              0000EB00E9FFEF00EEFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF36FFFF00BB05FF37FF90FF30F5
              75FF37F677FF2EF676FF2DF677FF2DF576FF34FB82FF18FF67FF366455FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF33FFFF00B900FF44FF9FFF31FF
              83FF2DFF84FF2EFF84FF2EFF84FF2EFF84FF35FF87FF18FF69FF326654FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF34FFFF00B900FF42FFA4FF35FF
              84FF36FF86FF36FF86FF36FF86FF36FF85FF38FF8CFF1AFF71FF33665EFF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF32FFFF00B903FF4BFFADFF3DFF
              8EFF3DFF90FF3DFF90FF3EFF90FF3CFF8FFF3DFF94FF24FF79FF356659FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF46FFFF00C200FF23FF86FF16FF
              66FF17FF67FF17FF67FF17FF67FF16FF67FF18FF6FFF00FF56FF206B41FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000FF00FFFF546365FF6C498BFF7049
              87FF704987FF704987FF704987FF704987FF714988FF5A4C77FFAB3EB7FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1082#1074#1080#1090#1072#1085#1094#1080#1080' - '#1089#1095#1077#1090#1072
            Style = ebsGlyphEh
            Width = 24
            OnClick = DBGridEh1Columns5EditButtons0Click
          end>
        FieldName = 'BILL_SUM'
        Footer.ValueType = fvtSum
        Footers = <>
        Width = 132
      end
      item
        ButtonStyle = cbsEllipsis
        EditButtons = <>
        FieldName = 'USER_CREATED_FIO'
        Footers = <>
        Width = 101
      end
      item
        EditButtons = <>
        FieldName = 'DATE_CREATED_'
        Footers = <>
        Width = 103
      end
      item
        EditButtons = <>
        FieldName = 'USER_LAST_UPDATED_FIO'
        Footers = <>
        Width = 99
      end
      item
        EditButtons = <>
        FieldName = 'DATE_LAST_UPDATED_'
        Footers = <>
        Width = 107
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object qRef: TOraQuery
    SQLRefresh.Strings = (
      'select '
      '  bva.ID_BALANCE_VIRT_ACOUNTS,'
      '  bva.VIRTUAL_ACCOUNTS_ID,'
      '  bva.PHONE_ON_ACCOUNTS_ID,'
      '  bva.PAYMENT_ID,'
      '  bva.BILL_ID,'
      '  to_char(bva.PHONE_ID) PHONE_ID,'
      '  bva.YEAR_MONTH,'
      '  bva.DATE_BALANCE,'
      '  bva.SUM_BALANCE,'
      '  bva.SUM_PAY,'
      '  bva.BILL_SUM,'
      '  BT.TYPE_NAME  BALANCE_TYPE_NAME,'
      '  bva.BALANCE_TYPE_ID,'
      
        '  nvl((select max(ID_BALANCE_VIRT_ACOUNTS) from BALANCE_VIRT_ACO' +
        'UNTS where YEAR_MONTH = bva.YEAR_MONTH and VIRTUAL_ACCOUNTS_ID =' +
        ' bva.VIRTUAL_ACCOUNTS_ID and bva.BALANCE_TYPE_ID = -1),0) ID_STA' +
        'RT_BAL,'
      '  '
      
        '  nvl(un.USER_FIO, '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_CREATED) USER_CREATED_' +
        'FIO,'
      '  bva.DATE_CREATED  DATE_CREATED_,'
      
        '  nvl(un2.USER_FIO,  '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_LAST_UPDATED)USER_LA' +
        'ST_UPDATED_FIO,'
      '  bva.DATE_LAST_UPDATED DATE_LAST_UPDATED_'
      'from '
      '  BALANCE_VIRT_ACOUNTS bva,'
      '  BALANCE_TYPES bt,'
      '  USER_NAMES un, '
      '  USER_NAMES un2'
      ' where '
      '  bva.USER_CREATED       = un.USER_NAME(+) and '
      '  bva.USER_LAST_UPDATED = un2.USER_NAME(+) and'
      '  bva.YEAR_MONTH = :YEAR_MONTH'
      '  and bva.ID_BALANCE_VIRT_ACOUNTS = :Old_ID_BALANCE_VIRT_ACOUNTS'
      '  and bva.BALANCE_TYPE_ID = BT.BALANCE_TYPE_ID(+)'
      
        '  order by bva.BALANCE_TYPE_ID asc, bva.ID_BALANCE_VIRT_ACOUNTS ' +
        'asc'
      ''
      '-- -1 row(s) affected.')
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  bva.ID_BALANCE_VIRT_ACOUNTS,'
      '  bva.VIRTUAL_ACCOUNTS_ID,'
      '  bva.PHONE_ON_ACCOUNTS_ID,'
      '  bva.PAYMENT_ID,'
      '  bva.BILL_ID,'
      '  to_char(bva.PHONE_ID) PHONE_ID,'
      '  bva.YEAR_MONTH,'
      '  bva.DATE_BALANCE,'
      '  bva.SUM_BALANCE,'
      '  bva.SUM_PAY,'
      '  bva.BILL_SUM,'
      '  BT.TYPE_NAME  BALANCE_TYPE_NAME,'
      '  bva.BALANCE_TYPE_ID,'
      
        '  nvl((select max(ID_BALANCE_VIRT_ACOUNTS) from BALANCE_VIRT_ACO' +
        'UNTS where YEAR_MONTH = bva.YEAR_MONTH and VIRTUAL_ACCOUNTS_ID =' +
        ' bva.VIRTUAL_ACCOUNTS_ID and bva.BALANCE_TYPE_ID = -1),0) ID_STA' +
        'RT_BAL,'
      '  '
      
        '  nvl(un.USER_FIO, '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_CREATED) USER_CREATED_' +
        'FIO,'
      '  bva.DATE_CREATED  DATE_CREATED_,'
      
        '  nvl(un2.USER_FIO,  '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_LAST_UPDATED)USER_LA' +
        'ST_UPDATED_FIO,'
      '  bva.DATE_LAST_UPDATED DATE_LAST_UPDATED_'
      'from '
      '  BALANCE_VIRT_ACOUNTS bva,'
      '  BALANCE_TYPES bt,'
      '  USER_NAMES un, '
      '  USER_NAMES un2'
      ' where '
      '  bva.USER_CREATED       = un.USER_NAME(+) and '
      '  bva.USER_LAST_UPDATED = un2.USER_NAME(+) and'
      '  bva.YEAR_MONTH = :YEAR_MONTH'
      '  and bva.Virtual_accounts_id = :Virtual_accounts_id'
      '  and bva.BALANCE_TYPE_ID = BT.BALANCE_TYPE_ID(+)'
      '   order by bva.DATE_BALANCE desc'
      ''
      '-- -1 row(s) affected.')
    FetchRows = 1000
    Filtered = True
    BeforeOpen = qRefBeforeOpen
    AfterOpen = qRefAfterOpen
    AfterScroll = qRefAfterScroll
    Left = 105
    Top = 267
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'Virtual_accounts_id'
      end>
    object qRefID_BALANCE_VIRT_ACOUNTS: TFloatField
      FieldName = 'ID_BALANCE_VIRT_ACOUNTS'
      Required = True
    end
    object qRefPHONE_ON_ACCOUNTS_ID: TFloatField
      FieldName = 'PHONE_ON_ACCOUNTS_ID'
      Required = True
    end
    object qRefPAYMENT_ID: TFloatField
      FieldName = 'PAYMENT_ID'
      Required = True
    end
    object qRefBILL_ID: TFloatField
      FieldName = 'BILL_ID'
      Required = True
    end
    object qRefPHONE_ID: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_ID'
      Size = 40
    end
    object qRefYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
    end
    object qRefDATE_BALANCE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'DATE_BALANCE'
      Required = True
    end
    object qRefSUM_BALANCE: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'SUM_BALANCE'
      Required = True
      DisplayFormat = '0.00'
    end
    object qRefSUM_PAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'SUM_PAY'
      Required = True
      DisplayFormat = '0.00'
    end
    object qRefBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1087#1086' '#1089#1095#1077#1090#1091
      FieldName = 'BILL_SUM'
      Required = True
      DisplayFormat = '0.00'
    end
    object qRefBALANCE_TYPE_NAME: TStringField
      DisplayLabel = #1058#1080#1087'  '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'BALANCE_TYPE_NAME'
      Size = 240
    end
    object qRefBALANCE_TYPE_ID: TFloatField
      FieldName = 'BALANCE_TYPE_ID'
      Required = True
    end
    object qRefID_START_BAL: TFloatField
      FieldName = 'ID_START_BAL'
    end
    object qRefUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      FieldName = 'USER_CREATED_FIO'
      Size = 240
    end
    object qRefDATE_CREATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1085#1072
      FieldName = 'DATE_CREATED_'
      Required = True
    end
    object qRefUSER_LAST_UPDATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1080#1083
      FieldName = 'USER_LAST_UPDATED_FIO'
      Size = 240
    end
    object qRefDATE_LAST_UPDATED_: TDateTimeField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1077#1085#1072
      FieldName = 'DATE_LAST_UPDATED_'
      Required = True
    end
    object qRefVIRTUAL_ACCOUNTS_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNTS_ID'
      Required = True
    end
  end
  object dsqRef: TOraDataSource
    Tag = 1
    DataSet = qRef
    Left = 106
    Top = 322
  end
  object qRefCnt: TOraQuery
    SQLRefresh.Strings = (
      'select '
      '  va.VIRTUAL_ACCOUNTS_NAME,'
      '  va.VIRTUAL_ACCOUNTS_IS_ACTIVE,'
      '  va.INN,'
      '  va.EMAIL,'
      '  va.comments,'
      '  va.VIRTUAL_ACCOUNTS_ID,'
      '  t.DATE_BALANCE,'
      '  t.SUM_BALANCE,'
      '  t.YEAR_MONTH'
      ' from VIRTUAL_ACCOUNTS va,   '
      '     (select'
      '       bva.VIRTUAL_ACCOUNTS_ID,'
      '       bva.ID_BALANCE_VIRT_ACOUNTS,'
      '       bva.YEAR_MONTH,'
      '       bva.DATE_BALANCE,'
      '       bva.SUM_BALANCE'
      '        from BALANCE_VIRT_ACOUNTS bva,'
      
        '            (select max(b.ID_BALANCE_VIRT_ACOUNTS) ID_BALANCE_VI' +
        'RT_ACOUNTS, B.VIRTUAL_ACCOUNTS_ID, b.YEAR_MONTH '
      '               from BALANCE_VIRT_ACOUNTS b '
      '               where B.BALANCE_TYPE_ID <> 1 '
      '             group by B.VIRTUAL_ACCOUNTS_ID, b.YEAR_MONTH'
      '            ) c'
      
        '      where c.ID_BALANCE_VIRT_ACOUNTS = bva.ID_BALANCE_VIRT_ACOU' +
        'NTS'
      '        and c.YEAR_MONTH = bva.YEAR_MONTH'
      '      --  and bva.YEAR_MONTH = :YEAR_MONTH'
      '     ) t'
      '  where t.VIRTUAL_ACCOUNTS_ID(+) = va.VIRTUAL_ACCOUNTS_ID     '
      'order by va.VIRTUAL_ACCOUNTS_NAME'
      '  t.ID_BALANCE_VIRT_ACOUNTS = :Old_ID_BALANCE_VIRT_ACOUNTS')
    Session = Dm.OraSession
    SQL.Strings = (
      'select count(bva.ID_BALANCE_VIRT_ACOUNTS) cnt'
      'from '
      '  BALANCE_VIRT_ACOUNTS bva'
      '  where '
      '  bva.YEAR_MONTH = :YEAR_MONTH'
      '  and bva.Virtual_accounts_id = :Virtual_accounts_id')
    FetchRows = 1000
    Filtered = True
    BeforeOpen = qRefCntBeforeOpen
    Left = 281
    Top = 331
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'Virtual_accounts_id'
      end>
    object qRefCntCNT: TFloatField
      FieldName = 'CNT'
    end
  end
  object qMonthBalance: TOraQuery
    SQLRefresh.Strings = (
      'select'
      '  YEAR_MONTH_NAME,'
      '  YEAR_MONTH,'
      '  DATE_BALANCE,'
      '  ('
      '        select '
      '          bva.SUM_BALANCE'
      '         from'
      '          BALANCE_VIRT_ACOUNTS bva'
      '         where'
      '          bva.VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID'
      '          and bva.year_month = t.YEAR_MONTH'
      '          and bva.DATE_BALANCE = t.DATE_BALANCE'
      '          and BVA.ID_BALANCE_VIRT_ACOUNTS =  (select'
      
        '                                                max(ID_BALANCE_V' +
        'IRT_ACOUNTS)'
      '                                              from'
      
        '                                                BALANCE_VIRT_ACO' +
        'UNTS bv'
      '                                              where'
      
        '                                                 bva.year_month ' +
        '= bv.YEAR_MONTH'
      
        '                                                 and bva.DATE_BA' +
        'LANCE = bv.DATE_BALANCE'
      '                                                      '
      '                                              )'
      '   ) SUM_BALANCE'
      '   '
      '  from'
      '    ('
      '  '
      '      select'
      '        p.YEAR_MONTH_NAME,'
      ''
      '        p.YEAR_MONTH,'
      '        ('
      '         select '
      '          max(bva.DATE_BALANCE)'
      '         from'
      '          BALANCE_VIRT_ACOUNTS bva'
      '         where'
      '          bva.VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID'
      '          and bva.year_month = p.YEAR_MONTH'
      '        ) DATE_BALANCE'
      '     '
      '       '
      '       from V_PERIODS p'
      '       where'
      '       p.YEAR_MONTH <= to_number(to_char(sysdate, '#39'yyyymm'#39'))'
      ' )t'
      ' order by t.YEAR_MONTH desc')
    Session = Dm.OraSession
    SQL.Strings = (
      'select'
      '  YEAR_MONTH_NAME,'
      '  YEAR_MONTH,'
      '  DATE_BALANCE,'
      '  ('
      '        select '
      '          bva.SUM_BALANCE'
      '         from'
      '          BALANCE_VIRT_ACOUNTS bva'
      '         where'
      '          bva.VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID'
      '          and bva.year_month = t.YEAR_MONTH'
      '          and bva.DATE_BALANCE = t.DATE_BALANCE'
      '          and BVA.ID_BALANCE_VIRT_ACOUNTS =  (select'
      
        '                                                max(ID_BALANCE_V' +
        'IRT_ACOUNTS)'
      '                                              from'
      
        '                                                BALANCE_VIRT_ACO' +
        'UNTS bv'
      '                                              where'
      
        '                                                 bva.year_month ' +
        '= bv.YEAR_MONTH'
      
        '                                                 and bva.DATE_BA' +
        'LANCE = bv.DATE_BALANCE'
      '                                                      '
      '                                              )'
      '   ) SUM_BALANCE'
      '   '
      '  from'
      '    ('
      '  '
      '      select'
      '        p.YEAR_MONTH_NAME,'
      ''
      '        p.YEAR_MONTH,'
      '        ('
      '         select '
      '          max(bva.DATE_BALANCE)'
      '         from'
      '          BALANCE_VIRT_ACOUNTS bva'
      '         where'
      '          bva.VIRTUAL_ACCOUNTS_ID = :VIRTUAL_ACCOUNTS_ID'
      '          and bva.year_month = p.YEAR_MONTH'
      '        ) DATE_BALANCE'
      '     '
      '       '
      '       from V_PERIODS p'
      '       where'
      '       p.YEAR_MONTH <= to_number(to_char(sysdate, '#39'yyyymm'#39'))'
      ' )t'
      ' order by t.YEAR_MONTH desc')
    FetchRows = 1000
    Filtered = True
    BeforeOpen = qMonthBalanceBeforeOpen
    AfterOpen = qMonthBalanceAfterOpen
    Left = 537
    Top = 195
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Virtual_accounts_id'
      end>
    object qMonthBalanceYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Required = True
      Visible = False
    end
    object qMonthBalanceYEAR_MONTH_NAME: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1055#1077#1088#1080#1086#1076
      FieldName = 'YEAR_MONTH_NAME'
      ReadOnly = True
      Size = 212
    end
    object qMonthBalanceDATE_BALANCE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'DATE_BALANCE'
      ReadOnly = True
      Required = True
    end
    object qMonthBalanceSUM_BALANCE: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'SUM_BALANCE'
      ReadOnly = True
      Required = True
      DisplayFormat = '0.00'
    end
  end
  object dsMonthBalance: TOraDataSource
    Tag = 1
    DataSet = qMonthBalance
    Left = 538
    Top = 250
  end
  object actlst1: TActionList
    Images = Dm.ImageList24
    Left = 752
    Top = 244
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1073#1072#1083#1072#1085#1089
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aInsertExecute
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1073#1072#1083#1072#1085#1089
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1073#1072#1083#1072#1085#1089
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
      Visible = False
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      ImageIndex = 8
      ShortCut = 27
      Visible = False
    end
    object aRefresh: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077
      Enabled = False
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
    end
    object aCheckedAll: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 49
    end
    object aUncheckedAll: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077'       '
      Enabled = False
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077
      ImageIndex = 50
    end
    object aCheckedSel: TAction
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Enabled = False
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099
      ImageIndex = 49
    end
    object aTranscriptBalance: TAction
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072
      Enabled = False
      Hint = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1072#1083#1072#1085#1089#1072' '
      ImageIndex = 48
    end
    object aInsertAuto: TAction
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1072#1095#1072#1083#1100#1085#1086#1075#1086' '#1073#1072#1083#1072#1085#1089#1072
      Hint = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1072#1095#1072#1083#1100#1085#1086#1075#1086' '#1073#1072#1083#1072#1085#1089#1072
      ImageIndex = 25
      OnExecute = aInsertAutoExecute
    end
  end
  object qtmp: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      '  bva.ID_BALANCE_VIRT_ACOUNTS,'
      '  bva.VIRTUAL_ACCOUNTS_ID,'
      '  bva.PHONE_ON_ACCOUNTS_ID,'
      '  bva.PAYMENT_ID,'
      '  bva.BILL_ID,'
      '   to_char(bva.PHONE_ID) PHONE_ID,'
      '  bva.YEAR_MONTH,'
      '  bva.DATE_BALANCE,'
      '  bva.SUM_BALANCE,'
      '  bva.SUM_PAY,'
      '  bva.BILL_SUM,'
      '  BT.TYPE_NAME  BALANCE_TYPE_NAME,'
      '  bva.BALANCE_TYPE_ID,'
      
        '  nvl((select max(ID_BALANCE_VIRT_ACOUNTS) from BALANCE_VIRT_ACO' +
        'UNTS where YEAR_MONTH = bva.YEAR_MONTH and VIRTUAL_ACCOUNTS_ID =' +
        ' bva.VIRTUAL_ACCOUNTS_ID and BALANCE_TYPE_ID = -1),0) ID_START_B' +
        'AL,'
      
        '  nvl(un.USER_FIO, '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_CREATED) USER_CREATED_' +
        'FIO,'
      '  bva.DATE_CREATED  DATE_CREATED_,'
      
        '  nvl(un2.USER_FIO,  '#39'C'#1080#1089#1090#1077#1084#1072'; '#39'|| bva.USER_LAST_UPDATED)USER_LA' +
        'ST_UPDATED_FIO,'
      '  bva.DATE_LAST_UPDATED DATE_LAST_UPDATED_'
      'from '
      '  BALANCE_VIRT_ACOUNTS bva,'
      '  BALANCE_TYPES bt,'
      '  USER_NAMES un, '
      '  USER_NAMES un2'
      '  where '
      '  bva.USER_CREATED       = un.USER_NAME(+) and '
      '  bva.USER_LAST_UPDATED = un2.USER_NAME(+) and'
      '  bva.YEAR_MONTH = :YEAR_MONTH'
      '  and bva.BALANCE_TYPE_ID = BT.BALANCE_TYPE_ID(+)'
      '  and bva.Virtual_accounts_id = :Virtual_accounts_id')
    FetchRows = 1000
    Filtered = True
    Left = 225
    Top = 267
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'Virtual_accounts_id'
      end>
  end
  object qtmp2: TOraQuery
    SQLRefresh.Strings = (
      'select '
      '  va.VIRTUAL_ACCOUNTS_NAME,'
      '  va.VIRTUAL_ACCOUNTS_IS_ACTIVE,'
      '  va.INN,'
      '  va.EMAIL,'
      '  va.comments,'
      '  va.VIRTUAL_ACCOUNTS_ID,'
      '  t.DATE_BALANCE,'
      '  t.SUM_BALANCE,'
      '  t.YEAR_MONTH'
      ' from VIRTUAL_ACCOUNTS va,   '
      '     (select'
      '       bva.VIRTUAL_ACCOUNTS_ID,'
      '       bva.ID_BALANCE_VIRT_ACOUNTS,'
      '       bva.YEAR_MONTH,'
      '       bva.DATE_BALANCE,'
      '       bva.SUM_BALANCE'
      '        from BALANCE_VIRT_ACOUNTS bva,'
      
        '            (select max(b.ID_BALANCE_VIRT_ACOUNTS) ID_BALANCE_VI' +
        'RT_ACOUNTS, B.VIRTUAL_ACCOUNTS_ID, b.YEAR_MONTH '
      '               from BALANCE_VIRT_ACOUNTS b '
      '               where B.BALANCE_TYPE_ID <> 1 '
      '             group by B.VIRTUAL_ACCOUNTS_ID, b.YEAR_MONTH'
      '            ) c'
      
        '      where c.ID_BALANCE_VIRT_ACOUNTS = bva.ID_BALANCE_VIRT_ACOU' +
        'NTS'
      '        and c.YEAR_MONTH = bva.YEAR_MONTH'
      '      --  and bva.YEAR_MONTH = :YEAR_MONTH'
      '     ) t'
      '  where t.VIRTUAL_ACCOUNTS_ID(+) = va.VIRTUAL_ACCOUNTS_ID     '
      'order by va.VIRTUAL_ACCOUNTS_NAME'
      '  t.ID_BALANCE_VIRT_ACOUNTS = :Old_ID_BALANCE_VIRT_ACOUNTS')
    Session = Dm.OraSession
    SQL.Strings = (
      'select count(bva.ID_BALANCE_VIRT_ACOUNTS) cnt'
      'from '
      '  BALANCE_VIRT_ACOUNTS bva'
      '  where '
      '  bva.YEAR_MONTH = :YEAR_MONTH'
      '  and bva.Virtual_accounts_id = :Virtual_accounts_id')
    FetchRows = 1000
    Filtered = True
    Left = 228
    Top = 318
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'Virtual_accounts_id'
      end>
    object FloatField12: TFloatField
      FieldName = 'CNT'
    end
  end
  object spCalc_Balance: TOraStoredProc
    StoredProcName = 'BALANCE.INSERT_BEGINNER_BALANCE'
    Session = Dm.OraSession
    SQL.Strings = (
      'begin'
      
        '  BALANCE.INSERT_BEGINNER_BALANCE(:P_VIRTUAL_ACCOUNTS_ID, :P_SUM' +
        '_BALANCE, :P_DATE_BALANCE);'
      'end;')
    Left = 496
    Top = 376
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_VIRTUAL_ACCOUNTS_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'P_SUM_BALANCE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'P_DATE_BALANCE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BALANCE.INSERT_BEGINNER_BALANCE'
  end
  object spDeleteRef: TOraStoredProc
    StoredProcName = 'BALANCE.DELETE_BEGINNER_BALANCE'
    Session = Dm.OraSession
    SQL.Strings = (
      'begin'
      '  BALANCE.DELETE_BEGINNER_BALANCE(:P_ID_BALANCE_VIRT_ACOUNTS);'
      'end;')
    Left = 400
    Top = 384
    ParamData = <
      item
        DataType = ftInteger
        Name = 'P_ID_BALANCE_VIRT_ACOUNTS'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BALANCE.DELETE_BEGINNER_BALANCE'
  end
  object spCalcBal: TOraStoredProc
    StoredProcName = 'BALANCE.RECALC_BALANCE2'
    Session = Dm.OraSession
    SQL.Strings = (
      'begin'
      
        '  BALANCE.RECALC_BALANCE2(:P_VIRTUAL_ACCOUNTS_ID, :P_YEAR_MONTH)' +
        ';'
      'end;')
    Left = 600
    Top = 376
    ParamData = <
      item
        DataType = ftFloat
        Name = 'P_VIRTUAL_ACCOUNTS_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'P_YEAR_MONTH'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BALANCE.RECALC_BALANCE2'
  end
end
