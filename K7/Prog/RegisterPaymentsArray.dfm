object RegisterPaymentsArrayForm: TRegisterPaymentsArrayForm
  Left = 0
  Top = 0
  Caption = #1052#1072#1089#1089#1086#1074#1072#1103' '#1079#1072#1075#1088#1091#1079#1082#1072' '#1088#1091#1095#1085#1099#1093' '#1087#1083#1072#1090#1077#1078#1077#1081
  ClientHeight = 404
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 49
    Width = 900
    Height = 339
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsLoad
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PhoneNumber'
        Title.Alignment = taCenter
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PaymentDateTime'
        Title.Alignment = taCenter
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Summa'
        Title.Alignment = taCenter
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PaymentTypeId'
        Title.Alignment = taCenter
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Remark'
        Title.Alignment = taCenter
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ReverseSchet'
        Title.Alignment = taCenter
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ContractNum'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Itog'
        Title.Alignment = taCenter
        Width = 294
        Visible = True
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 900
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 49
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 2
    object Label14: TLabel
      Left = 8
      Top = 31
      Width = 56
      Height = 13
      Caption = #1060#1080#1083#1080#1072#1083' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 898
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 112
      Caption = 'ToolBar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object tbAddPhones: TToolButton
        Left = 0
        Top = 0
        Action = aFileOpen
      end
      object tbCheckContract: TToolButton
        Left = 112
        Top = 0
        Action = aFindContract
        Enabled = False
      end
      object tbAddChanges: TToolButton
        Left = 224
        Top = 0
        Action = aAddChanges
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        Enabled = False
      end
      object tbImportExcel: TToolButton
        Left = 336
        Top = 0
        Action = aExcel
      end
      object ToolButton1: TToolButton
        Left = 448
        Top = 0
        Action = aClear
      end
    end
    object cbFilial: TComboBox
      Left = 65
      Top = 27
      Width = 313
      Height = 20
      TabOrder = 1
    end
  end
  object vtLoad: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    FieldDefs = <
      item
        Name = 'PhoneNumber'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ContractId'
        DataType = ftInteger
      end
      item
        Name = 'PaymentDateTime'
        DataType = ftDateTime
      end
      item
        Name = 'Summa'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PaymentTypeId'
        DataType = ftInteger
      end
      item
        Name = 'PaymentType'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Remark'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ReverseSchet'
        DataType = ftInteger
      end
      item
        Name = 'ContractNum'
        DataType = ftInteger
      end
      item
        Name = 'Itog'
        DataType = ftString
        Size = 100
      end>
    Left = 160
    Top = 120
    Data = {
      03000A000B0050686F6E654E756D62657201000A00000000000A00436F6E7472
      616374496403000000000000000F005061796D656E744461746554696D650B00
      000000000000050053756D6D6101006400000000000D005061796D656E745479
      7065496403000000000000000B005061796D656E745479706501006400000000
      00060052656D61726B0100F401000000000C0052657665727365536368657403
      000000000000000B00436F6E74726163744E756D030000000000000004004974
      6F670100640000000000000000000000}
    object vtLoadPhoneNumber: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PhoneNumber'
      Size = 10
    end
    object vtLoadContractId: TIntegerField
      Alignment = taCenter
      DisplayLabel = #1044#1086#1075#1086#1074#1086#1088
      FieldName = 'ContractId'
    end
    object vtLoadPaymentDateTime: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'PaymentDateTime'
    end
    object vtLoadSumma: TStringField
      Alignment = taCenter
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'Summa'
      Size = 100
    end
    object vtLoadPaymentType: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1080#1087' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 20
      FieldName = 'PaymentType'
      Size = 50
    end
    object vtLoadPaymentTypeId: TIntegerField
      Alignment = taCenter
      DisplayLabel = #1058#1080#1087' '#1087#1083#1072#1090#1077#1078#1072
      FieldName = 'PaymentTypeId'
    end
    object vtLoadRemark: TStringField
      DisplayLabel = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      FieldName = 'Remark'
      Size = 500
    end
    object vtLoadReverseSchet: TIntegerField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1084#1087'. '#1087#1088#1080' '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1080#1080' '#1089#1095#1077#1090#1072
      FieldName = 'ReverseSchet'
    end
    object vtLoadContractNum: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'ContractNum'
    end
    object vtLoadItog: TStringField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'Itog'
      Size = 100
    end
  end
  object dsLoad: TDataSource
    DataSet = vtLoad
    Left = 200
    Top = 128
  end
  object ActionList: TActionList
    Left = 360
    Top = 96
    object aFindContract: TAction
      Caption = #1053#1072#1081#1090#1080' '#1076#1086#1075#1086#1074#1086#1088#1072
      OnExecute = aFindContractExecute
    end
    object aFileOpen: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      OnExecute = aFileOpenExecute
    end
    object aAddChanges: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1058#1055
      OnExecute = aAddChangesExecute
    end
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      OnExecute = aExcelExecute
    end
    object aFindStatus: TAction
      Caption = #1053#1072#1081#1090#1080' '#1089#1090#1072#1090#1091#1089#1099
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
  end
  object qAddChange: TOraQuery
    SQL.Strings = (
      'INSERT INTO RECEIVED_PAYMENTS'
      
        '  (PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, RECEIVED_PAYMEN' +
        'T_TYPE_ID, CONTRACT_ID, IS_CONTRACT_PAYMENT, FILIAL_ID, REMARK, ' +
        'REVERSESCHET)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :PAYMENT_SUM, :PAYMENT_DATE_TIME, :RECEIVED_PA' +
        'YMENT_TYPE_ID, :CONTRACT_ID, :IS_CONTRACT_PAYMENT, :FILIAL_ID, :' +
        'REMARK, :REVERSESCHET)')
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_SUM'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_DATE_TIME'
      end
      item
        DataType = ftUnknown
        Name = 'RECEIVED_PAYMENT_TYPE_ID'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'IS_CONTRACT_PAYMENT'
      end
      item
        DataType = ftUnknown
        Name = 'FILIAL_ID'
      end
      item
        DataType = ftUnknown
        Name = 'REMARK'
      end
      item
        DataType = ftUnknown
        Name = 'REVERSESCHET'
      end>
  end
  object qCheckContract: TOraQuery
    SQL.Strings = (
      'SELECT C.CONTRACT_ID, '
      '       C.CONTRACT_NUM'
      '  FROM CONTRACTS C '
      '  WHERE C.PHONE_NUMBER_FEDERAL = :PHONE_NUMBER'
      '    AND C.CONTRACT_DATE <= :PAYMENTDATE'
      '    AND NOT EXISTS (SELECT 1'
      '                      FROM CONTRACT_CANCELS CC'
      '                      WHERE CC.CONTRACT_ID = C.CONTRACT_ID'
      
        '                        AND CC.CONTRACT_CANCEL_DATE <= :PAYMENTD' +
        'ATE)')
    FetchAll = True
    Left = 272
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENTDATE'
      end>
    object qCheckContractCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
    end
    object qCheckContractCONTRACT_NUM: TFloatField
      FieldName = 'CONTRACT_NUM'
    end
  end
  object OpenDialog: TOpenDialog
    Left = 112
    Top = 288
  end
  object Transaction: TOraTransaction
    DefaultSession = Dm.OraSession
    Left = 400
    Top = 280
  end
  object qCheckReceivedType: TOraQuery
    SQL.Strings = (
      'SELECT * FROM received_payment_types '
      'WHERE received_payment_type_id = :received_payment_type_id')
    Left = 360
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'received_payment_type_id'
      end>
  end
  object qFilials: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM FILIALS'
      'ORDER BY FILIAL_NAME')
    Left = 304
    Top = 97
  end
  object qAddChange_GSM_CORP: TOraQuery
    SQL.Strings = (
      'INSERT INTO RECEIVED_PAYMENTS'
      
        '  (PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, CONTRACT_ID, IS' +
        '_CONTRACT_PAYMENT, FILIAL_ID, REMARK)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :PAYMENT_SUM, :PAYMENT_DATE_TIME, :CONTRACT_ID' +
        ', :IS_CONTRACT_PAYMENT, :FILIAL_ID, :REMARK)')
    Left = 120
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_SUM'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_DATE_TIME'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'IS_CONTRACT_PAYMENT'
      end
      item
        DataType = ftUnknown
        Name = 'FILIAL_ID'
      end
      item
        DataType = ftUnknown
        Name = 'REMARK'
      end>
  end
end
