inherited RepPayments: TRepPayments
  Left = 478
  Top = 162
  Caption = 'RepPayments'
  ClientHeight = 500
  ClientWidth = 1124
  Position = poDesigned
  ExplicitWidth = 1132
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 13
  inherited sSplitter1: TsSplitter
    Width = 1124
    ExplicitWidth = 1169
  end
  inherited sStatusBar1: TsStatusBar
    Top = 481
    Width = 1124
    ExplicitTop = 481
    ExplicitWidth = 1124
  end
  inherited CRGrid: TCRDBGrid
    Width = 1124
    Height = 296
    Columns = <
      item
        Expanded = False
        FieldName = 'DATE_PAY'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INN'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_ID'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYER_BIK'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUM_PAY'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC_NUMBER'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_PURPOSE'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILE_NAME'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  inherited sScrollBox1: TsScrollBox
    Width = 1124
    ExplicitWidth = 1124
    object sbChooseHist: TsSpeedButton [0]
      Left = 599
      Top = 122
      Width = 111
      Height = 32
      Action = aChooseHist
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 56
      Images = Dm.ImageList24
    end
    object sbChooseData: TsSpeedButton [1]
      AlignWithMargins = True
      Left = 599
      Top = 48
      Width = 111
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aChooseData
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 11
      Images = Dm.ImageList24
    end
    object spDeletePlat: TsSpeedButton [2]
      AlignWithMargins = True
      Left = 599
      Top = 85
      Width = 111
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aDelete
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 5
      Images = Dm.ImageList24
    end
    object sSpeedButton1: TsSpeedButton [3]
      AlignWithMargins = True
      Left = 599
      Top = 16
      Width = 111
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = aInsert
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      SkinData.SkinSection = 'SPEEDBUTTON'
      DisabledGlyphKind = [dgBlended, dgGrayed]
      ImageIndex = 4
      Images = Dm.ImageList24
    end
    inherited spMobOper: TsPanel
      Width = 0
      ExplicitWidth = 0
    end
    inherited spFilial: TsPanel
      Left = 0
      Width = 0
      ExplicitLeft = 0
      ExplicitWidth = 0
    end
    inherited spVirtAcc: TsPanel
      Left = 0
      Width = 353
      Visible = True
      ExplicitLeft = 0
      ExplicitWidth = 353
      inherited CLB_VirtAcc: TsCheckListBox
        Width = 230
        ExplicitWidth = 230
      end
    end
    inherited spAccount: TsPanel
      Left = 353
      Width = 0
      ExplicitLeft = 353
      ExplicitWidth = 0
    end
    inherited cbPeriod: TsComboBox
      Left = 443
      BoundLabel.Caption = #1055#1077#1088#1080#1086#1076' c:'
      Visible = True
      ExplicitLeft = 443
    end
    inherited spFiltrSearch: TsPanel
      Left = 759
      Top = 121
      Width = 201
      Visible = False
      ExplicitLeft = 759
      ExplicitTop = 121
      ExplicitWidth = 201
    end
    inherited spShow: TsPanel
      Left = 357
      Top = 81
      Width = 218
      ExplicitLeft = 357
      ExplicitTop = 81
      ExplicitWidth = 218
      inherited sBevel1: TsBevel
        Left = 111
        ExplicitLeft = 111
      end
      inherited sBevel2: TsBevel
        Left = 222
        ExplicitLeft = 222
      end
      inherited sbToExcel: TsSpeedButton [2]
        Left = 113
        Top = 0
        Width = 103
        ExplicitLeft = 113
        ExplicitTop = 0
        ExplicitWidth = 103
      end
      inherited sbInfoShow: TsSpeedButton [3]
        Left = 237
        Top = 5
        Width = 4
        ExplicitLeft = 237
        ExplicitTop = 5
        ExplicitWidth = 4
      end
      inherited sbShowSel: TsSpeedButton [4]
        Left = 8
        Width = 102
        ExplicitLeft = 8
        ExplicitWidth = 102
      end
    end
    inherited pButtonMove: TsPanel
      Left = 364
      Top = 124
      Width = 211
      ExplicitLeft = 364
      ExplicitTop = 124
      ExplicitWidth = 211
    end
    object cbPeriodAfter: TsComboBox
      Left = 443
      Top = 50
      Width = 132
      Height = 22
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1087#1086':'
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
      TabOrder = 8
    end
  end
  inherited actlst1: TActionList
    inherited aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      OnExecute = aInsertExecute
    end
    inherited aDelete: TAction
      Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      Enabled = False
      OnExecute = aDeleteExecute
    end
    object aChooseData: TAction
      Caption = #1055#1077#1088#1077#1085#1086#1089' '#1087#1083#1072#1090#1077#1078#1072
      Enabled = False
      Hint = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1087#1083#1072#1090#1077#1078' '#1085#1072' '#1076#1088#1091#1075#1086#1081' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090
      ImageIndex = 11
      OnExecute = aChooseDataExecute
    end
    object aChooseHist: TAction
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1087#1083#1072#1090#1077#1078#1072
      Enabled = False
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1089#1090#1086#1088#1080#1080' '#1087#1083#1072#1090#1077#1078#1072
      ImageIndex = 56
      OnExecute = aChooseHistExecute
    end
  end
  inherited qAccount: TOraQuery
    Top = 386
  end
  inherited qReport: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO '
      '  PAYMENTS ('
      '            VIRTUAL_ACCOUNT_ID, '
      '            PHONE_ID, '
      '            INN,'
      '            DATE_PAY,'
      '            SUM_PAY,'
      '            DOC_NUMBER,'
      '            PAYMENT_PURPOSE,'
      '            YEAR_MONTH,'
      '            PAYER_BIK,'
      '            PAYMENT_FILE_ID,'
      '            ID_PAYMENTS_TYPE  '
      '           ) '
      'VALUES (   '
      '        :VIRTUAL_ACCOUNT_ID, '
      '        :PHONE_ID, '
      '        :INN,'
      '        :DATE_PAY,'
      '        :SUM_PAY,'
      '        :DOC_NUMBER,'
      '        :PAYMENT_PURPOSE,'
      '        :YEAR_MONTH,'
      '        :PAYER_BIK,'
      '        :PAYMENT_FILE_ID,'
      '        :ID_PAYMENTS_TYPE  '
      '       )')
    SQLRefresh.Strings = (
      'select '
      '  DATE_PAY,'
      '  VIRTUAL_ACCOUNTS_NAME,'
      '  INN,'
      '  PHONE_ID,'
      '  SUM_PAY,'
      '  DOC_NUMBER,'
      '  PAYMENT_PURPOSE,'
      '  file_name,'
      '  PAYER_BIK,'
      '  VIRTUAL_ACCOUNT_ID,'
      '  PAYMENT_ID,'
      '  ID_PAYMENTS_TYPE'
      '  from'
      '  V_PAYMENTS'
      'where'
      '  PAYMENT_ID := :NEW_PAYMENT_ID')
    SQL.Strings = (
      
        '/*'#1058#1045#1050#1057#1058' '#1047#1040#1055#1056#1054#1057#1040' '#1060#1054#1056#1052#1048#1056#1059#1045#1058#1057#1071' '#1044#1048#1053#1040#1052#1048#1063#1045#1057#1050#1048', '#1054#1057#1053#1040#1042#1053#1040#1071' '#1063#1040#1057#1058#1068' '#1041#1045#1056#1045#1058#1057#1071' ' +
        #1048#1047' qSQL_TEMP*/'
      'SELECT'
      '         P.YEAR_MONTH,'
      '         P.DATE_PAY,'
      '         VA.VIRTUAL_ACCOUNTS_NAME,'
      '         P.INN,'
      '         to_char(p.PHONE_ID) PHONE_ID,'
      '         P.SUM_PAY,'
      '         P.DOC_NUMBER,'
      '         P.PAYMENT_PURPOSE,'
      '         pf.file_name,'
      '         P.VIRTUAL_ACCOUNT_ID,'
      '         p.PAYER_BIK,'
      '         p.PAYMENT_ID,'
      '         P.PAYMENT_FILE_ID, '
      '         P.ID_PAYMENTS_TYPE,'
      '         pt.NAME_PAYMENTS_TYPE,'
      
        '         (select max(h.PAYMANT_ID_HIST) from PAYMANTS_HIST h whe' +
        're p.PAYMENT_ID = h.PAYMENT_ID) PAYMANT_ID_HIST'
      '    FROM PAYMENTS p, VIRTUAL_ACCOUNTS va, PAYMENTS_FILES pf,'
      '         PAYMENTS_TYPE pt'
      '   WHERE P.VIRTUAL_ACCOUNT_ID = VA.VIRTUAL_ACCOUNTS_ID(+)'
      '     AND P.PAYMENT_FILE_ID = pf.FILE_ID(+)'
      '     AND p.year_month >= :year_month_start'
      '     and p.year_month <= :year_month_end'
      '     AND P.ID_PAYMENTS_TYPE = Pt.ID_PAYMENTS_TYPE')
    AfterScroll = qReportAfterScroll
    Left = 670
    Top = 315
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'year_month_start'
      end
      item
        DataType = ftUnknown
        Name = 'year_month_end'
      end>
    object qReportDATE_PAY: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'DATE_PAY'
      Required = True
    end
    object qReportVIRTUAL_ACCOUNTS_NAME: TStringField
      DisplayLabel = #1042#1080#1088#1090'. '#1089#1095#1077#1090
      FieldName = 'VIRTUAL_ACCOUNTS_NAME'
      Size = 600
    end
    object qReportINN: TStringField
      DisplayLabel = #1048#1053#1053
      FieldName = 'INN'
      Size = 48
    end
    object qReportPHONE_ID: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_ID'
      Size = 40
    end
    object qReportPAYER_BIK: TFloatField
      DisplayLabel = #1041#1048#1050' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
      FieldName = 'PAYER_BIK'
    end
    object qReportNAME_PAYMENTS_TYPE: TStringField
      DisplayLabel = #1058#1080#1087' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      FieldName = 'NAME_PAYMENTS_TYPE'
      Size = 120
    end
    object qReportSUM_PAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'SUM_PAY'
      Required = True
    end
    object qReportDOC_NUMBER: TStringField
      DisplayLabel = #8470' '#1044#1086#1082#1091#1084#1077#1085#1090#1072
      FieldName = 'DOC_NUMBER'
      Required = True
      Size = 40
    end
    object qReportPAYMENT_PURPOSE: TStringField
      DisplayLabel = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'PAYMENT_PURPOSE'
      Size = 2000
    end
    object qReportFILE_NAME: TStringField
      DisplayLabel = #1048#1084#1103' '#1092#1072#1081#1083#1072
      FieldName = 'FILE_NAME'
      Size = 50
    end
    object qReportVIRTUAL_ACCOUNT_ID: TFloatField
      FieldName = 'VIRTUAL_ACCOUNT_ID'
      Visible = False
    end
    object qReportPAYMENT_ID: TFloatField
      FieldName = 'PAYMENT_ID'
      Required = True
      Visible = False
    end
    object qReportPAYMANT_ID_HIST: TFloatField
      FieldName = 'PAYMANT_ID_HIST'
      Visible = False
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
      Visible = False
    end
    object qReportPAYMENT_FILE_ID: TFloatField
      FieldName = 'PAYMENT_FILE_ID'
      Visible = False
    end
    object qReportID_PAYMENTS_TYPE: TFloatField
      FieldName = 'ID_PAYMENTS_TYPE'
      Required = True
      Visible = False
    end
  end
  inherited dsqReport: TOraDataSource
    Top = 458
  end
  inherited qVirt_Acc: TOraQuery
    BeforeOpen = nil
  end
  inherited qAccount_cnt: TOraQuery
    Top = 418
  end
  object qSQL_TEMP: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT'
      '         P.YEAR_MONTH,'
      '         P.DATE_PAY,'
      '         VA.VIRTUAL_ACCOUNTS_NAME,'
      '         P.INN,'
      '         to_char(p.PHONE_ID) PHONE_ID,'
      '         P.SUM_PAY,'
      '         P.DOC_NUMBER,'
      '         P.PAYMENT_PURPOSE,'
      '         pf.file_name,'
      '         P.VIRTUAL_ACCOUNT_ID,'
      '         p.PAYER_BIK,'
      '         p.PAYMENT_ID,'
      '         P.PAYMENT_FILE_ID, '
      '         P.ID_PAYMENTS_TYPE,'
      '         pt.NAME_PAYMENTS_TYPE,'
      
        '         (select max(h.PAYMANT_ID_HIST) from PAYMANTS_HIST h whe' +
        're p.PAYMENT_ID = h.PAYMENT_ID) PAYMANT_ID_HIST'
      '    FROM PAYMENTS p, VIRTUAL_ACCOUNTS va, PAYMENTS_FILES pf,'
      '         PAYMENTS_TYPE pt'
      '   WHERE P.VIRTUAL_ACCOUNT_ID = VA.VIRTUAL_ACCOUNTS_ID(+)'
      '     AND P.PAYMENT_FILE_ID = pf.FILE_ID(+)'
      '     AND p.year_month >= :year_month_start'
      '     and p.year_month <= :year_month_end'
      '     AND P.ID_PAYMENTS_TYPE = Pt.ID_PAYMENTS_TYPE')
    FetchRows = 1000
    Filtered = True
    Left = 774
    Top = 323
    ParamData = <
      item
        DataType = ftInteger
        Name = 'year_month_start'
        ParamType = ptInput
        Value = 201511
      end
      item
        DataType = ftInteger
        Name = 'year_month_end'
        ParamType = ptInput
        Value = 201511
      end>
  end
  object qDeletePayment: TOraQuery
    SQL.Strings = (
      'delete from PAYMENTS WHERE  PAYMENT_ID = :PAYMENT_ID')
    Left = 720
    Top = 388
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PAYMENT_ID'
      end>
  end
  object qInsertPayment: TOraQuery
    SQL.Strings = (
      'INSERT INTO '
      '  PAYMENTS ('
      '            VIRTUAL_ACCOUNT_ID, '
      '            PHONE_ID, '
      '            INN,'
      '            DATE_PAY,'
      '            SUM_PAY,'
      '            DOC_NUMBER,'
      '            PAYMENT_PURPOSE,'
      '            YEAR_MONTH,'
      '            PAYER_BIK,'
      '            PAYMENT_FILE_ID  '
      '           ) '
      'VALUES (   '
      '        :VIRTUAL_ACCOUNT_ID, '
      '        :PHONE_ID, '
      '        :INN,'
      '        :DATE_PAY,'
      '        :SUM_PAY,'
      '        :DOC_NUMBER,'
      '        :PAYMENT_PURPOSE,'
      '        :YEAR_MONTH,'
      '        :PAYER_BIK,'
      '        :PAYMENT_FILE_ID  '
      '       )')
    Left = 428
    Top = 244
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'VIRTUAL_ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_ID'
      end
      item
        DataType = ftUnknown
        Name = 'INN'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_PAY'
      end
      item
        DataType = ftUnknown
        Name = 'SUM_PAY'
      end
      item
        DataType = ftUnknown
        Name = 'DOC_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_PURPOSE'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'PAYER_BIK'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_FILE_ID'
      end>
  end
end
