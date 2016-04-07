object ShowUserAlertForm: TShowUserAlertForm
  Left = 0
  Top = 0
  Caption = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1077' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103' '#1087#1086' '#1085#1086#1084#1077#1088#1091
  ClientHeight = 235
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 6
    Top = 6
    Width = 463
    Height = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1050#1088#1077#1076#1080#1090
    TabOrder = 0
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 463
      Height = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1088#1077#1076#1080#1090
      TabOrder = 0
      object lblCreditInfo: TLabel
        Left = 3
        Top = 15
        Width = 59
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'lCreditInfo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 47
    Width = 463
    Height = 56
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1056#1072#1089#1089#1088#1086#1095#1082#1072
    TabOrder = 1
    object lRassrochka: TLabel
      Left = 13
      Top = 11
      Width = 329
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 
        #1056#1072#1089#1089#1088#1086#1095#1082#1072' %sum%'#1088' '#1089' %date% '#1085#1072' %month% '#1084#1077#1089#1103#1094#1072'.'#13#10#1042#1099#1087#1083#1072#1095#1077#1085#1086': %rass%'#1088 +
        '. '#1054#1089#1090#1072#1090#1086#1082': %tail%'#1088'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btAdvRepayment: TBitBtn
      Left = 360
      Top = 12
      Width = 92
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1086#1075#1072#1089#1080#1090#1100' '#1076#1086#1089#1088#1086#1095#1085#1086
      TabOrder = 0
      OnClick = btAdvRepaymentClick
    end
    object dtpAdvRepaymentDate: TDateTimePicker
      Left = 360
      Top = 29
      Width = 92
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Date = 41393.577076805560000000
      Time = 41393.577076805560000000
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 7
    Top = 107
    Width = 463
    Height = 70
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
    TabOrder = 2
    object DisconSum: TLabel
      Left = 12
      Top = 16
      Width = 175
      Height = 16
      Caption = #1041#1072#1083#1072#1085#1089' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080' %dislim%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Unblocksum: TLabel
      Left = 12
      Top = 33
      Width = 199
      Height = 16
      Caption = #1041#1072#1083#1072#1085#1089' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080' %conlim%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object numcost: TLabel
      Left = 12
      Top = 49
      Width = 185
      Height = 16
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1085#1086#1084#1077#1088#1072' %numcost%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object spGetCreditInfo: TOraStoredProc
    StoredProcName = 'SHOW_USER_ALERT.GET_CREDIT_INFO'
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := SHOW_USER_ALERT.GET_CREDIT_INFO(:PCONTRACT_ID);'
      'end;')
    Left = 136
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SHOW_USER_ALERT.GET_CREDIT_INFO'
  end
  object OraStoredProc1: TOraStoredProc
    DataTypeMap = <>
    Left = 64
    Top = 168
  end
  object qRassrochka: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      
        '  INSTALLMENT_ADVANCED_REPAYMENT = TRUNC(:INSTALLMENT_ADVANCED_R' +
        'EPAYMENT)'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      
        'SELECT INSTALLMENT_PAYMENT_DATE, INSTALLMENT_PAYMENT_SUM, INSTAL' +
        'LMENT_ADVANCED_REPAYMENT FROM CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT C.CONTRACT_ID,'
      '       C.INSTALLMENT_PAYMENT_DATE,'
      '       C.INSTALLMENT_PAYMENT_SUM,'
      
        '       NVL(C.INSTALLMENT_PAYMENT_MONTHS, 0) INSTALLMENT_PAYMENT_' +
        'MONTHS,'
      
        '       SHOW_USER_ALERT.GET_CURRENT_INSTALLMENT_PAID(C.CONTRACT_I' +
        'D) FULL_INST_PAID,'
      '       C.INSTALLMENT_ADVANCED_REPAYMENT,'
      '       c.disconnect_limit,'
      '       c.connect_limit,'
      '       c.gold_number_sum'
      '  FROM CONTRACTS C'
      'WHERE C.CONTRACT_ID = :pCONTRACT_ID')
    AfterOpen = qRassrochkaAfterOpen
    Left = 144
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pCONTRACT_ID'
      end>
    object qRassrochkaINSTALLMENT_PAYMENT_DATE: TDateTimeField
      FieldName = 'INSTALLMENT_PAYMENT_DATE'
    end
    object qRassrochkaINSTALLMENT_PAYMENT_SUM: TFloatField
      FieldName = 'INSTALLMENT_PAYMENT_SUM'
    end
    object qRassrochkaINSTALLMENT_PAYMENT_MONTHS: TFloatField
      FieldName = 'INSTALLMENT_PAYMENT_MONTHS'
    end
    object qRassrochkaFULL_INST_PAID: TFloatField
      FieldName = 'FULL_INST_PAID'
    end
    object qRassrochkaINSTALLMENT_ADVANCED_REPAYMENT: TDateTimeField
      FieldName = 'INSTALLMENT_ADVANCED_REPAYMENT'
    end
    object qRassrochkaCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
    end
    object qRassrochkaDISCONNECT_LIMIT: TFloatField
      FieldName = 'DISCONNECT_LIMIT'
    end
    object qRassrochkaCONNECT_LIMIT: TFloatField
      FieldName = 'CONNECT_LIMIT'
    end
    object qRassrochkaGOLD_NUMBER_SUM: TFloatField
      FieldName = 'GOLD_NUMBER_SUM'
    end
  end
end
