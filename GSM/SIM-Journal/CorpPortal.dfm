object CorpPortalForm: TCorpPortalForm
  Left = 0
  Top = 0
  Caption = #1050#1086#1088#1087#1086#1088#1072#1090#1080#1074#1085#1099#1081' '#1050#1072#1073#1080#1085#1077#1090' '#1052#1077#1075#1072#1092#1086#1085#1072
  ClientHeight = 735
  ClientWidth = 1318
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
  object sToolBar1: TsToolBar
    Left = 0
    Top = 0
    Width = 1318
    Height = 54
    ButtonHeight = 56
    ButtonWidth = 134
    Caption = 'sToolBar1'
    Images = MainForm.ilToolbar
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    SkinData.SkinSection = 'TOOLBAR'
    object tbPrihod: TToolButton
      Left = 0
      Top = 0
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnClick = tbPrihodClick
    end
    object ToolButton2: TToolButton
      Left = 134
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 13
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 268
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbLoadXLS: TToolButton
      Left = 276
      Top = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 26
      OnClick = tbLoadXLSClick
    end
    object ToolButton6: TToolButton
      Left = 410
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 26
      Style = tbsSeparator
    end
    object ToolButton10: TToolButton
      Left = 418
      Top = 0
      Caption = #1059#1073#1088#1072#1090#1100' '#1075#1086#1090#1086#1074#1099#1077
      ImageIndex = 5
      OnClick = ToolButton10Click
    end
    object tbHistory: TToolButton
      Left = 552
      Top = 0
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 14
      OnClick = tbHistoryClick
    end
    object ToolButton1: TToolButton
      Left = 686
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 15
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 694
      Top = 0
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' Excel'
      ImageIndex = 15
      OnClick = ToolButton9Click
    end
    object ToolButton5: TToolButton
      Left = 828
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 836
      Top = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074' '#1073#1072#1079#1091
      ImageIndex = 6
      OnClick = ToolButton4Click
    end
    object ToolButton8: TToolButton
      Left = 970
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 978
      Top = 0
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 4
      OnClick = ToolButton7Click
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 54
    Width = 472
    Height = 652
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    AllowedOperations = [alopInsertEh, alopUpdateEh]
    AllowedSelections = [gstRecordBookmarks, gstAll]
    AutoFitColWidths = True
    Ctl3D = True
    DataGrouping.GroupLevels = <>
    DataSource = dsTransfers
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
    RowDetailPanel.Color = clBtnFace
    ShowHint = True
    STFilter.InstantApply = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        Alignment = taCenter
        EditButtons = <
          item
            Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1072#1088#1080#1092
          end>
        FieldName = 'AccountFrom'
        Footers = <>
        Title.Caption = #1057#1095#1077#1090' '#1048#1089#1090#1086#1095#1085#1080#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'AccountTo'
        Footers = <>
        Title.Caption = #1057#1095#1077#1090' '#1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
      end
      item
        EditButtons = <>
        FieldName = 'TransferSum'
        Footers = <>
        Title.Caption = #1057#1091#1084#1084#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 104
      end>
    object RowDetailData: TRowDetailPanelControlEh
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
    end
  end
  object sPanel1: TsPanel
    Left = 472
    Top = 54
    Width = 846
    Height = 652
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object sGroupBox1: TsGroupBox
      Left = 34
      Top = 29
      Width = 375
      Height = 192
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1057#1073#1086#1088' '#1089#1088#1077#1076#1089#1090#1074' '#1089#1086' '#1089#1095#1077#1090#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'GROUPBOX'
      object sLabel1: TsLabel
        Left = 24
        Top = 34
        Width = 154
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1057#1095#1077#1090' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1100':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel3: TsLabel
        Left = 70
        Top = 69
        Width = 108
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1057#1085#1080#1084#1072#1090#1100' '#1076#1086':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sLabel4: TsLabel
        Left = 25
        Top = 105
        Width = 152
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1052#1077#1089#1103#1094#1099' '#1090#1080#1096#1080#1085#1099':'
        ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3484708
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
      end
      object sEdit1: TsEdit
        Left = 179
        Top = 33
        Width = 170
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
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
      end
      object sEdit2: TsEdit
        Left = 179
        Top = 68
        Width = 170
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
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
      object sEdit3: TsEdit
        Left = 179
        Top = 103
        Width = 170
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '2,5'
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
      object sBitBtn1: TsBitBtn
        Left = 21
        Top = 139
        Width = 328
        Height = 32
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1057#1086#1073#1088#1072#1090#1100' '#1084#1086#1083#1095#1072#1097#1080#1077' '#1085#1086#1084#1077#1088#1072
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = sBitBtn1Click
        SkinData.SkinSection = 'BUTTON'
      end
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 706
    Width = 1318
    Height = 29
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    Caption = 'sPanel2'
    TabOrder = 3
    OnClick = sPanel2Click
    SkinData.SkinSection = 'PANEL'
    object sLabel2: TsLabel
      Left = 196
      Top = 7
      Width = 5
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alCustom
      Alignment = taRightJustify
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3484708
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sProgressBar1: TsProgressBar
      Left = 209
      Top = 1
      Width = 1108
      Height = 27
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      Smooth = True
      Step = 1
      TabOrder = 0
      SkinData.SkinSection = 'GAUGE'
    end
  end
  object vtTransfers: TVirtualTable
    Left = 56
    Top = 168
    Data = {03000000000000000000}
    object vtTransfersAccountFrom: TIntegerField
      FieldName = 'AccountFrom'
    end
    object vtTransfersAccountTo: TIntegerField
      FieldName = 'AccountTo'
    end
    object vtTransfersTransferSum: TFloatField
      FieldName = 'TransferSum'
    end
  end
  object dsTransfers: TDataSource
    DataSet = vtTransfers
    Left = 88
    Top = 176
  end
  object spTransfers: TOraStoredProc
    StoredProcName = 'LOADER4_PCKG.CP_TRANSFERS'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER4_PCKG.CP_TRANSFERS(:PACCOUNTS_FROM, :PACCOUN' +
        'TS_TO, :PTRANSFER_SUM);'
      'end;')
    Left = 72
    Top = 240
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PACCOUNTS_FROM'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PACCOUNTS_TO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PTRANSFER_SUM'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER4_PCKG.CP_TRANSFERS'
  end
  object qTransComplite: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT SIM_CP_TRANSFERS.ACCOUNT_FROM,'
      '       SIM_CP_TRANSFERS.ACCOUNT_TO,'
      '       SIM_CP_TRANSFERS.TRANSFER_SUM'
      '  FROM SIM_CP_TRANSFERS'
      
        '  WHERE to_char(SIM_CP_TRANSFERS.DATE_BEGIN, '#39'YYYYMM'#39') = to_char' +
        '(SYSDATE, '#39'YYYYMM'#39')'
      '  ORDER BY SIM_CP_TRANSFERS.ACCOUNT_FROM ASC')
    FetchAll = True
    Left = 176
    Top = 168
    object qTransCompliteACCOUNT_FROM: TFloatField
      FieldName = 'ACCOUNT_FROM'
      Required = True
    end
    object qTransCompliteACCOUNT_TO: TFloatField
      FieldName = 'ACCOUNT_TO'
      Required = True
    end
    object qTransCompliteTRANSFER_SUM: TFloatField
      FieldName = 'TRANSFER_SUM'
      Required = True
    end
  end
  object qSelectNoSound: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT SIM.CELL_NUMBER,'
      '       SIM.ACCOUNT,'
      '       SIM.BALANCE'
      '  FROM SIM'
      
        '  WHERE ADD_MONTHS(SIM.DATE_LAST_ACTIVITY, :pMONTH)+:pDAYS<SYSDA' +
        'TE'
      '  ORDER BY SIM.BALANCE DESC')
    Left = 392
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pMONTH'
      end
      item
        DataType = ftUnknown
        Name = 'pDAYS'
      end>
    object qSelectNoSoundCELL_NUMBER: TStringField
      FieldName = 'CELL_NUMBER'
      Required = True
      Size = 10
    end
    object qSelectNoSoundACCOUNT: TStringField
      FieldName = 'ACCOUNT'
      Required = True
      Size = 100
    end
    object qSelectNoSoundBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
  end
end
