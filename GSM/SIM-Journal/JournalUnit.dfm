object JournalForm: TJournalForm
  Left = 0
  Top = 0
  Caption = 'JournalForm'
  ClientHeight = 543
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 110
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel2: TsPanel
      Left = 1
      Top = 84
      Width = 868
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
        Left = 367
        Top = 1
        Width = 500
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
      Width = 868
      Height = 83
      ActivePage = sTabSheet6
      Align = alTop
      TabOrder = 1
      SkinData.SkinSection = 'PAGECONTROL'
      object sTabSheet0: TsTabSheet
        Caption = #1059#1089#1083#1091#1075#1080
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet1: TsTabSheet
        Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1057#1052#1057
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet2: TsTabSheet
        Caption = #1041#1072#1083#1072#1085#1089#1099' '#1080' '#1091#1089#1083#1091#1075#1080
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet3: TsTabSheet
        Caption = #1053#1077#1086#1087#1088#1080#1093#1086#1076#1086#1074#1072#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet4: TsTabSheet
        Caption = #1054#1087#1077#1088#1072#1094#1080#1080
        SkinData.CustomColor = False
        SkinData.CustomFont = False
      end
      object sTabSheet5: TsTabSheet
        Caption = #1057#1095#1077#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sLabel2: TsLabel
          Left = 35
          Top = 24
          Width = 55
          Height = 16
          Caption = #1055#1077#1088#1080#1086#1076':'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 3484708
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object DBLookupComboboxEh1: TDBLookupComboboxEh
          Left = 96
          Top = 23
          Width = 121
          Height = 21
          DropDownBox.Rows = 30
          EditButtons = <>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          KeyField = 'YEAR_MONTH'
          ListField = 'YEAR_MONTH_NAME'
          ListSource = dsPeriod
          ParentFont = False
          TabOrder = 0
          Visible = True
          OnChange = DBLookupComboboxEh1Change
        end
        object sBitBtn1: TsBitBtn
          Left = 240
          Top = 20
          Width = 101
          Height = 26
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsItalic]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = sBitBtn1Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object sTabSheet6: TsTabSheet
        Caption = #1041#1072#1075#1080
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sBitBtn2: TsBitBtn
          Left = 32
          Top = 20
          Width = 101
          Height = 26
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsItalic]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 0
          OnClick = sBitBtn2Click
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
  end
  object grMain: TDBGridEh
    Left = 0
    Top = 110
    Width = 415
    Height = 433
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
    FooterFont.Height = -11
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
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'Date'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DateEnd'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'CellNum'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'TypeSet'
        Footers = <>
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'OptionName'
        Footers = <>
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
      end
      item
        EditButtons = <>
        FieldName = 'Operation'
        Footers = <>
        Title.Caption = #1054#1087#1077#1088#1072#1094#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
      end
      item
        EditButtons = <>
        FieldName = 'User'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'Note'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
      end
      item
        EditButtons = <>
        FieldName = 'Balance'
        Footers = <>
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 75
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'Account'
        Footers = <>
        Title.Caption = #1051#1080#1094'. '#1089#1095#1077#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'BillSum'
        Footers = <>
        Title.Caption = #1057#1095#1077#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'KomSumBill'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 68
      end
      item
        EditButtons = <>
        FieldName = 'FullSum'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 68
      end
      item
        EditButtons = <>
        FieldName = 'NoRouming'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'KomSum'
        Footers = <>
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object grOptions: TDBGridEh
    Left = 415
    Top = 110
    Width = 455
    Height = 433
    Align = alRight
    DataGrouping.GroupLevels = <>
    DataSource = dsGetOptions
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_OPTION_CHECK'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
      end
      item
        EditButtons = <>
        FieldName = 'OPTION_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1059#1089#1083#1091#1075#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object qOptionSetLog: TOraQuery
    SQL.Strings = (
      'SELECT DATE_OPTION_SET DATE_DO, '
      '       PHONE_NUMBER, '
      '       OPTION_NAME,'
      '       TYPE_SET,'
      '       NOTE'
      '  FROM SIM_PHONE_OPTION_SET_HISTORY'
      '  ORDER BY DATE_DO DESC')
    FetchRows = 250
    Left = 32
    Top = 216
    object qOptionSetLogPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qOptionSetLogOPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Required = True
      Size = 800
    end
    object qOptionSetLogTYPE_SET: TStringField
      FieldName = 'TYPE_SET'
      Size = 60
    end
    object qOptionSetLogNOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object qOptionSetLogDATE_DO: TDateTimeField
      FieldName = 'DATE_DO'
    end
  end
  object dsMain: TDataSource
    DataSet = vtMain
    OnDataChange = dsMainDataChange
    Left = 88
    Top = 288
  end
  object vtMain: TVirtualTable
    FieldDefs = <
      item
        Name = 'Date'
        DataType = ftDateTime
      end
      item
        Name = 'CellNum'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'OptionName'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TypeSet'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Note'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'Balance'
        DataType = ftFloat
      end
      item
        Name = 'DateEnd'
        DataType = ftDateTime
      end
      item
        Name = 'User'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Operation'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Account'
        DataType = ftInteger
      end
      item
        Name = 'BillSum'
        DataType = ftFloat
      end
      item
        Name = 'KomSum'
        DataType = ftFloat
      end>
    Left = 56
    Top = 280
    Data = {
      03000C000400446174650B00000000000000070043656C6C4E756D01000A0000
      0000000A004F7074696F6E4E616D650100C80000000000070054797065536574
      01000F000000000004004E6F74650100F40100000000070042616C616E636506
      00000000000000070044617465456E640B000000000000000400557365720100
      1E000000000009004F7065726174696F6E010064000000000007004163636F75
      6E740300000000000000070042696C6C53756D060000000000000006004B6F6D
      53756D0600000000000000000000000000}
    object vtMainDate: TDateTimeField
      FieldName = 'Date'
    end
    object vtMainCellNum: TStringField
      DisplayLabel = #8470' '#1090#1077#1083#1077#1092#1086#1085#1072
      FieldName = 'CellNum'
      Size = 10
    end
    object vtMainOptionName: TStringField
      FieldName = 'OptionName'
      Size = 200
    end
    object vtMainTypeSet: TStringField
      FieldName = 'TypeSet'
      Size = 15
    end
    object vtMainNote: TStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'Note'
      Size = 500
    end
    object vtMainBalance: TFloatField
      FieldName = 'Balance'
    end
    object vtMainDateEnd: TDateTimeField
      FieldName = 'DateEnd'
    end
    object vtMainUser: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FieldName = 'User'
      Size = 30
    end
    object vtMainOperation: TStringField
      FieldName = 'Operation'
      Size = 100
    end
    object vtMainAccount: TIntegerField
      DisplayLabel = #1051#1080#1094#1102' '#1089#1095#1077#1090
      FieldName = 'Account'
    end
    object vtMainBillSum: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BillSum'
    end
    object vtMainKomSum: TFloatField
      DisplayLabel = #1050#1086#1084#1080#1089#1089#1080#1103
      FieldName = 'KomSum'
    end
    object vtMainKomSumBill: TFloatField
      DisplayLabel = #1050#1086#1084#1080#1089#1089#1080#1103' '#1087#1086' '#1089#1095#1077#1090#1091
      FieldName = 'KomSumBill'
    end
    object vtMainFullSum: TFloatField
      DisplayLabel = #1042#1099#1087#1083#1072#1090#1099
      FieldName = 'FullSum'
    end
    object vtMainNoRouming: TFloatField
      DisplayLabel = #1041#1077#1079' '#1088#1086#1091#1084#1080#1085#1075#1072
      FieldName = 'NoRouming'
    end
  end
  object qSendPaidSMS: TOraQuery
    SQL.Strings = (
      'SELECT DATE_SEND DATE_DO, '
      '       PHONE_NUMBER, '
      '       NOTE'
      '  FROM SIM_SEND_PAID_SMS_HISTORY'
      '  ORDER BY DATE_DO DESC')
    FetchRows = 250
    Left = 32
    Top = 168
    object qSendPaidSMSPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qSendPaidSMSNOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object qSendPaidSMSDATE_DO: TDateTimeField
      FieldName = 'DATE_DO'
    end
  end
  object qGetOptions: TOraQuery
    SQL.Strings = (
      'SELECT OPTION_NAME,'
      '       DATE_OPTION_CHECK'
      '  FROM V_SIM_CURRENT_PHONE_OPTIONS'
      '  WHERE PHONE_NUMBER=:PHONE_NUMBER'
      '  ORDER BY DATE_OPTION_CHECK DESC')
    FetchRows = 250
    Left = 56
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qGetOptionsOPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Size = 800
    end
    object qGetOptionsDATE_OPTION_CHECK: TDateTimeField
      FieldName = 'DATE_OPTION_CHECK'
    end
  end
  object qGetBalance: TOraQuery
    SQL.Strings = (
      'SELECT CELL_NUMBER PHONE_NUMBER,'
      '       BALANCE,'
      '       DATE_BALANCE DATE_DO'
      '  FROM SIM'
      '  ORDER BY DATE_DO DESC')
    FetchRows = 250
    Left = 184
    Top = 160
    object qGetBalancePHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 10
    end
    object qGetBalanceBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qGetBalanceDATE_DO: TDateTimeField
      FieldName = 'DATE_DO'
    end
  end
  object qGetBalanceUndefPhone: TOraQuery
    SQL.Strings = (
      'SELECT PHONE_NUMBER,'
      '       BALANCE,'
      '       DATE_BALANCE_CHECK DATE_DO'
      '  FROM SIM_BALANCE_PHONE_UNDEF'
      '  ORDER BY DATE_DO DESC')
    FetchRows = 250
    Left = 184
    Top = 208
    object qGetBalanceUndefPhonePHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qGetBalanceUndefPhoneBALANCE: TFloatField
      FieldName = 'BALANCE'
      Required = True
    end
    object qGetBalanceUndefPhoneDATE_DO: TDateTimeField
      FieldName = 'DATE_DO'
    end
  end
  object dsGetOptions: TDataSource
    DataSet = qGetOptions
    Left = 88
    Top = 360
  end
  object qOperations: TOraQuery
    SQL.Strings = (
      'SELECT OPERATION_TYPE,'
      '       NOTE,'
      '       USER_CREATED,'
      '       DATE_BEGIN,'
      '       DATE_END'
      '  FROM SIM_OPERATION_HISTORY'
      '  ORDER BY DATE_BEGIN DESC')
    FetchRows = 250
    Left = 184
    Top = 256
    object qOperationsOPERATION_TYPE: TStringField
      FieldName = 'OPERATION_TYPE'
      Required = True
      Size = 400
    end
    object qOperationsNOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object qOperationsUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qOperationsDATE_BEGIN: TDateTimeField
      FieldName = 'DATE_BEGIN'
    end
    object qOperationsDATE_END: TDateTimeField
      FieldName = 'DATE_END'
    end
  end
  object qPeriod: TOraQuery
    SQL.Strings = (
      'SELECT YEAR_MONTH,'
      '       YEAR_MONTH_NAME'
      '  FROM (SELECT YEAR_MONTH,'
      
        '               '#39' '#39'||TO_CHAR(YEAR_MONTH-TRUNC(YEAR_MONTH/100)*100' +
        ')||'#39' - '#39'||TO_CHAR(TRUNC(YEAR_MONTH/100)) YEAR_MONTH_NAME'
      '          FROM SIM_PHONE_BILLS'
      '        UNION ALL'
      '        SELECT YEAR_MONTH,'
      
        '               '#39' '#39'||TO_CHAR(YEAR_MONTH-TRUNC(YEAR_MONTH/100)*100' +
        ')||'#39' - '#39'||TO_CHAR(TRUNC(YEAR_MONTH/100)) YEAR_MONTH_NAME'
      '          FROM SIM_PHONE_BILL_DETAILS'
      '          WHERE YEAR_MONTH NOT IN(SELECT YEAR_MONTH'
      '                                    FROM SIM_PHONE_BILLS))  '
      '  GROUP BY YEAR_MONTH, YEAR_MONTH_NAME'
      '  ORDER BY YEAR_MONTH DESC')
    FetchAll = True
    Left = 160
    Top = 40
    object qPeriodYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qPeriodYEAR_MONTH_NAME: TStringField
      FieldName = 'YEAR_MONTH_NAME'
      Size = 84
    end
  end
  object dsPeriod: TDataSource
    DataSet = qPeriod
    Left = 192
    Top = 48
  end
  object qBills: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM V_SIM_PHONES_KOMISSIYA'
      '  WHERE YEAR_MONTH=:PERIOD'
      '  ORDER BY V_SIM_PHONES_KOMISSIYA.PHONE_NUMBER ASC')
    FetchRows = 500
    FetchAll = True
    Left = 184
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PERIOD'
      end>
    object qBillsBILL_ID: TFloatField
      FieldName = 'BILL_ID'
      Required = True
    end
    object qBillsPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qBillsBILL_SUM: TFloatField
      FieldName = 'BILL_SUM'
      Required = True
    end
    object qBillsDATE_BEGIN: TDateTimeField
      FieldName = 'DATE_BEGIN'
      Required = True
    end
    object qBillsDATE_END: TDateTimeField
      FieldName = 'DATE_END'
      Required = True
    end
    object qBillsYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qBillsKOM_SUM: TFloatField
      FieldName = 'KOM_SUM'
    end
    object qBillsACCOUNT: TStringField
      FieldName = 'ACCOUNT'
      Size = 100
    end
    object qBillsKOM_SUM_BILL: TFloatField
      FieldName = 'KOM_SUM_BILL'
    end
    object qBillsFULL_SUM: TFloatField
      FieldName = 'FULL_SUM'
    end
    object qBillsNO_ROUMING_SUM: TFloatField
      FieldName = 'NO_ROUMING_SUM'
    end
  end
  object qPhoneUnAccess: TOraQuery
    SQL.Strings = (
      'SELECT CELL_NUMBER'
      '  FROM SIM'
      '  WHERE NVL(DATE_BALANCE, SYSDATE-4)+3<=SYSDATE'
      '  ORDER BY CELL_NUMBER ASC')
    FetchAll = True
    Left = 184
    Top = 352
    object qPhoneUnAccessCELL_NUMBER: TStringField
      DisplayLabel = #8470' '#1090#1077#1083#1077#1092#1086#1085#1072
      FieldName = 'CELL_NUMBER'
      Required = True
      Size = 10
    end
  end
end
