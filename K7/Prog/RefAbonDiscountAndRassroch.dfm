object RefAbonDiscountAndRassrochForm: TRefAbonDiscountAndRassrochForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1089#1088#1086#1095#1082#1080' '#1080' '#1089#1082#1080#1076#1082#1080' '#1085#1072' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1099'.'
  ClientHeight = 365
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 942
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object btLoadInExcel: TBitBtn
      Left = 0
      Top = 0
      Width = 176
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 178
      Top = 0
      Width = 138
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 317
      Top = 0
      Width = 145
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 470
      Top = 8
      Width = 78
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object cbFilter: TComboBox
      Left = 555
      Top = 7
      Width = 150
      Height = 24
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = #1057#1082#1080#1076#1082#1080' '#1080' '#1056#1072#1089#1089#1088#1086#1095#1082#1080
      OnChange = cbFilterChange
      Items.Strings = (
        #1057#1082#1080#1076#1082#1080' '#1080' '#1056#1072#1089#1089#1088#1086#1095#1082#1080
        #1057#1082#1080#1076#1082#1080
        #1056#1072#1089#1089#1088#1086#1095#1082#1080
        #1042#1089#1077' '#1085#1086#1084#1077#1088#1072)
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 37
    Width = 942
    Height = 328
    Align = alClient
    DataSource = dsRef
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
  end
  object dsRef: TDataSource
    DataSet = qRef
    Left = 240
    Top = 144
  end
  object qRef: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      
        '  ABON_TP_DISCOUNT = :ABON_TP_DISCOUNT, INSTALLMENT_PAYMENT_DATE' +
        ' = :INSTALLMENT_PAYMENT_DATE, INSTALLMENT_PAYMENT_SUM = :INSTALL' +
        'MENT_PAYMENT_SUM, INSTALLMENT_PAYMENT_MONTHS = :INSTALLMENT_PAYM' +
        'ENT_MONTHS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      
        'SELECT ABON_TP_DISCOUNT, INSTALLMENT_PAYMENT_DATE, INSTALLMENT_P' +
        'AYMENT_SUM, INSTALLMENT_PAYMENT_MONTHS FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    SQL.Strings = (
      'SELECT C.* '
      '  FROM CONTRACTS C'
      '  WHERE NOT EXISTS (SELECT 1'
      '                      FROM CONTRACT_CANCELS CC'
      '                      WHERE CC.CONTRACT_ID = C.CONTRACT_ID)'
      
        '    AND ((:SHOW_MOD = 0 AND (C.ABON_TP_DISCOUNT IS NOT NULL OR C' +
        '.INSTALLMENT_PAYMENT_SUM IS NOT NULL))'
      '          OR (:SHOW_MOD = 1 AND C.ABON_TP_DISCOUNT IS NOT NULL)'
      
        '          OR (:SHOW_MOD = 2 AND C.INSTALLMENT_PAYMENT_DATE IS NO' +
        'T NULL)'
      '          OR (:SHOW_MOD = 3))')
    FetchRows = 500
    Left = 208
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SHOW_MOD'
      end>
    object qRefCONTRACT_NUM: TFloatField
      DisplayLabel = #8470' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 8
      FieldName = 'CONTRACT_NUM'
      ReadOnly = True
    end
    object qRefCONTRACT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 12
      FieldName = 'CONTRACT_DATE'
      ReadOnly = True
    end
    object qRefPHONE_NUMBER_FEDERAL: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER_FEDERAL'
      ReadOnly = True
      Required = True
      Size = 40
    end
    object qRefABON_TP_DISCOUNT: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1089#1082#1080#1076#1082#1072'(%)'
      DisplayWidth = 7
      FieldName = 'ABON_TP_DISCOUNT'
    end
    object qRefINSTALLMENT_PAYMENT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1088#1072#1089#1089#1088#1086#1095#1082#1080
      DisplayWidth = 15
      FieldName = 'INSTALLMENT_PAYMENT_DATE'
    end
    object qRefINSTALLMENT_PAYMENT_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072'('#1088'.)'
      FieldName = 'INSTALLMENT_PAYMENT_SUM'
    end
    object qRefINSTALLMENT_PAYMENT_MONTHS: TFloatField
      DisplayLabel = #1057#1088#1086#1082'('#1084#1077#1089'.)'
      FieldName = 'INSTALLMENT_PAYMENT_MONTHS'
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 80
    Top = 64
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
end
