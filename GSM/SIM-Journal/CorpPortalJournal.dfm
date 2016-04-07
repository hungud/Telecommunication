object CorpPortalJournalForm: TCorpPortalJournalForm
  Left = 0
  Top = 0
  Caption = #1058#1088#1072#1085#1089#1092#1077#1088#1099' '#1050#1086#1088#1087#1086#1088#1072#1090#1080#1074#1085#1086#1075#1086' '#1055#1086#1088#1090#1072#1083#1072
  ClientHeight = 735
  ClientWidth = 1483
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object grMain: TDBGridEh
    Left = 0
    Top = 64
    Width = 1483
    Height = 671
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    AllowedOperations = [alopInsertEh, alopUpdateEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    AutoFitColWidths = True
    Ctl3D = True
    DataGrouping.GroupLevels = <>
    DataSource = dsMain
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -14
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghExtendVertLines]
    ParentCtl3D = False
    ParentShowHint = False
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    ShowHint = True
    STFilter.InstantApply = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    OnGetCellParams = grMainGetCellParams
    Columns = <
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_BEGIN'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 170
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_END'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 170
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'ACCOUNT_FROM'
        Footers = <>
        Title.Caption = #1057#1095#1077#1090'-'#1048#1089#1090#1086#1095#1085#1080#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 131
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'ACCOUNT_TO'
        Footers = <>
        Title.Caption = #1057#1095#1077#1090'-'#1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
      end
      item
        EditButtons = <>
        FieldName = 'TRANSFER_SUM'
        Footers = <>
        Title.Caption = #1055#1077#1088#1077#1074#1086#1076
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 98
      end
      item
        EditButtons = <>
        FieldName = 'TRANSFERED_SUM'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 114
      end
      item
        EditButtons = <>
        FieldName = 'NEW_TRANS_SUM'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
      end
      item
        EditButtons = <>
        FieldName = 'RESULTAT'
        Footers = <>
        Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 523
      end
      item
        EditButtons = <>
        FieldName = 'USER_LAST_UPDATED'
        Footers = <>
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
      end>
    object RowDetailData: TRowDetailPanelControlEh
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1483
    Height = 64
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sLabel1: TsLabel
      Left = 263
      Top = 21
      Width = 61
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1052#1077#1078#1076#1091
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 455
      Top = 21
      Width = 11
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1080
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object sBitBtn1: TsBitBtn
      Left = 21
      Top = 17
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = sBitBtn1Click
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 15
    end
    object sDateEdit1: TsDateEdit
      Left = 335
      Top = 20
      Width = 110
      Height = 27
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Color = clWhite
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '12.12.2011'
      OnChange = sDateEdit1Change
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
      Date = 40889.000000000000000000
    end
    object sDateEdit2: TsDateEdit
      Left = 472
      Top = 20
      Width = 110
      Height = 27
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Color = clWhite
      EditMask = '!99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '12.12.2011'
      OnChange = sDateEdit2Change
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
      Date = 40889.000000000000000000
    end
  end
  object dsMain: TDataSource
    DataSet = qMain
    Left = 88
    Top = 296
  end
  object qMain: TOraQuery
    SQL.Strings = (
      'SELECT SIM_CP_TRANSFERS.ACCOUNT_FROM,'
      '       SIM_CP_TRANSFERS.ACCOUNT_TO,'
      '       SIM_CP_TRANSFERS.TRANSFER_SUM,'
      '       SIM_CP_TRANSFERS.TRANSFERED_SUM,'
      '       SIM_CP_TRANSFERS.DATE_BEGIN,'
      '       SIM_CP_TRANSFERS.DATE_END,'
      '       SIM_CP_TRANSFERS.RESULTAT,'
      '       SIM_CP_TRANSFERS.USER_LAST_UPDATED,'
      
        '       SIM_CP_TRANSFERS.TRANSFER_SUM - SIM_CP_TRANSFERS.TRANSFER' +
        'ED_SUM NEW_TRANS_SUM'
      '  FROM SIM_CP_TRANSFERS'
      
        '  WHERE ((:BEGIN IS NULL) OR (TRUNC(SIM_CP_TRANSFERS.DATE_BEGIN)' +
        '>=TRUNC(:BEGIN)) or (SIM_CP_TRANSFERS.DATE_BEGIN IS NULL))'
      
        '    AND ((:END IS NULL) OR (TRUNC(:END)>=TRUNC(SIM_CP_TRANSFERS.' +
        'DATE_END)) or (SIM_CP_TRANSFERS.DATE_END IS NULL))'
      '  ORDER BY SIM_CP_TRANSFERS.DATE_BEGIN DESC')
    FetchRows = 500
    FetchAll = True
    Left = 56
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'BEGIN'
      end
      item
        DataType = ftUnknown
        Name = 'END'
      end>
    object qMainRESULTAT: TStringField
      FieldName = 'RESULTAT'
      Size = 800
    end
    object qMainACCOUNT_FROM: TFloatField
      FieldName = 'ACCOUNT_FROM'
      Required = True
    end
    object qMainACCOUNT_TO: TFloatField
      FieldName = 'ACCOUNT_TO'
      Required = True
    end
    object qMainTRANSFER_SUM: TFloatField
      FieldName = 'TRANSFER_SUM'
      Required = True
    end
    object qMainDATE_BEGIN: TDateTimeField
      FieldName = 'DATE_BEGIN'
    end
    object qMainDATE_END: TDateTimeField
      FieldName = 'DATE_END'
    end
    object qMainUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qMainTRANSFERED_SUM: TFloatField
      DisplayLabel = #1055#1077#1088#1077#1074#1077#1076#1077#1085#1086
      FieldName = 'TRANSFERED_SUM'
    end
    object qMainNEW_TRANS_SUM: TFloatField
      DisplayLabel = #1054#1089#1090#1072#1090#1086#1082
      FieldName = 'NEW_TRANS_SUM'
    end
  end
end
