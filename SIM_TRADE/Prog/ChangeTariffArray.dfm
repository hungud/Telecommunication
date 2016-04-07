object ChangeTariffArrayForm: TChangeTariffArrayForm
  Left = 0
  Top = 0
  Caption = 'ChangeTariffArrayForm'
  ClientHeight = 404
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 907
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 907
    Height = 47
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 1
    object lFilial: TLabel
      Left = 34
      Top = 24
      Width = 45
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Alignment = taRightJustify
      Caption = #1060#1080#1083#1080#1072#1083':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 905
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
      object tbCheckTariff: TToolButton
        Left = 112
        Top = 0
        Action = aFindTariff
        Enabled = False
      end
      object tbCheckContract: TToolButton
        Left = 224
        Top = 0
        Action = aFindContract
        Enabled = False
      end
      object tbAddChanges: TToolButton
        Left = 336
        Top = 0
        Action = aAddChanges
        Enabled = False
      end
      object tbCheckBalance: TToolButton
        Left = 448
        Top = 0
        Action = aFindBalance
        Enabled = False
      end
      object tbActive: TToolButton
        Left = 560
        Top = 0
        Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1057#1052#1057
        Enabled = False
        ImageIndex = 0
        OnClick = tbActiveClick
      end
      object tbImportExcel: TToolButton
        Left = 672
        Top = 0
        Action = aExcel
      end
      object ToolButton1: TToolButton
        Left = 784
        Top = 0
        Action = aClear
      end
    end
    object cbFilial: TComboBox
      Left = 83
      Top = 23
      Width = 170
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      Text = 'ComboBox1'
    end
  end
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 47
    Width = 907
    Height = 341
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsChanges
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
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
        FieldName = 'TariffName'
        Title.Alignment = taCenter
        Width = 195
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ChangeDate'
        Title.Alignment = taCenter
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ChangePayment'
        Title.Alignment = taCenter
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ContractDate'
        Title.Alignment = taCenter
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIO'
        Title.Alignment = taCenter
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Itog'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end>
  end
  object vtChanges: TVirtualTable
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
        Name = 'ContractDate'
        DataType = ftDateTime
      end
      item
        Name = 'FIO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Itog'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'TariffName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TariffId'
        DataType = ftInteger
      end
      item
        Name = 'ChangeDate'
        DataType = ftDate
      end
      item
        Name = 'ChangePayment'
        DataType = ftFloat
      end>
    Left = 96
    Top = 120
    Data = {
      030009000B0050686F6E654E756D62657201000A00000000000A00436F6E7472
      616374496403000000000000000C00436F6E7472616374446174650B00000000
      000000030046494F0100640000000000040049746F6701006400000000000A00
      5461726966664E616D6501003200000000000800546172696666496403000000
      000000000A004368616E67654461746509000000000000000D004368616E6765
      5061796D656E740600000000000000000000000000}
    object vtChangesPhoneNumber: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PhoneNumber'
      Size = 10
    end
    object vtChangesContractId: TIntegerField
      DisplayLabel = #1044#1086#1075#1086#1074#1086#1088
      FieldName = 'ContractId'
    end
    object vtChangesContractDate: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'ContractDate'
    end
    object vtChangesFIO: TStringField
      DisplayLabel = #1060'.'#1048'.'#1054'.'
      FieldName = 'FIO'
      Size = 100
    end
    object vtChangesItog: TStringField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'Itog'
      Size = 100
    end
    object vtChangesTariffName: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      DisplayWidth = 20
      FieldName = 'TariffName'
      Size = 50
    end
    object vtChangesTariffId: TIntegerField
      FieldName = 'TariffId'
    end
    object vtChangesChangeDate: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099
      FieldName = 'ChangeDate'
    end
    object vtChangesChangePayment: TFloatField
      DisplayLabel = #1055#1083#1072#1090#1072' '#1079#1072' '#1089#1084#1077#1085#1091
      FieldName = 'ChangePayment'
    end
    object vtChangesChangePaymentReverseschet: TFloatField
      DisplayLabel = #1055#1083#1072#1090#1072' '#1079#1072' '#1089#1084#1077#1085#1091' '
      FieldName = 'ChangePaymentReverseschet'
    end
  end
  object dsChanges: TDataSource
    DataSet = vtChanges
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
    object aFindTariff: TAction
      Caption = #1053#1072#1081#1090#1080' '#1090#1072#1088#1080#1092#1099
      OnExecute = aFindTariffExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
    object aFindBalance: TAction
      Caption = #1053#1072#1081#1090#1080' '#1073#1072#1083#1072#1085#1089#1099
      OnExecute = aFindBalanceExecute
    end
  end
  object qCheckTariff: TOraQuery
    SQL.Strings = (
      'SELECT TARIFF_ID,'
      '       TARIFF_NAME'
      '  FROM TARIFFS'
      '  WHERE IS_ACTIVE = 1'
      '    AND TARIFF_NAME = :pTARIFF_NAME')
    Left = 272
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pTARIFF_NAME'
      end>
    object qCheckTariffTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
    object qCheckTariffTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
  end
  object qFilials: TOraQuery
    SQL.Strings = (
      'SELECT FILIAL_ID,'
      '       FILIAL_NAME'
      '  FROM FILIALS'
      '  ORDER BY FILIAL_NAME')
    Left = 352
    Top = 192
  end
  object qAddChange: TOraQuery
    SQL.Strings = (
      
        'INSERT INTO CONTRACT_CHANGES(CONTRACT_ID, FILIAL_ID, CONTRACT_CH' +
        'ANGE_DATE, SUM_GET, TARIFF_ID, DOCUM_TYPE_ID)'
      
        '      VALUES(:CONTRACT_ID, :FILIAL_ID, TRUNC(:DATE_CHANGE), :SUM' +
        '_GET, :NEW_TARIFF_ID, 4)')
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'FILIAL_ID'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_CHANGE'
      end
      item
        DataType = ftUnknown
        Name = 'SUM_GET'
      end
      item
        DataType = ftUnknown
        Name = 'NEW_TARIFF_ID'
      end>
  end
  object qCheckContract: TOraQuery
    SQL.Strings = (
      'SELECT C.CONTRACT_ID, '
      '       c.CONTRACT_DATE,'
      '       (select a.SURNAME || '#39' '#39' || a.NAME || '#39' '#39' || a.PATRONYMIC'
      '          from abonents a'
      '          where a.ABONENT_ID = c.ABONENT_ID) FIO'
      '  FROM CONTRACTS C '
      '  WHERE C.PHONE_NUMBER_FEDERAL = :PHONE_NUMBER'
      '    AND NOT EXISTS (SELECT 1'
      '                      FROM CONTRACT_CANCELS CC'
      '                      WHERE CC.CONTRACT_ID = C.CONTRACT_ID)')
    FetchAll = True
    Left = 272
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qCheckContractCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
      Required = True
    end
    object qCheckContractCONTRACT_DATE: TDateTimeField
      FieldName = 'CONTRACT_DATE'
    end
    object qCheckContractFIO: TStringField
      FieldName = 'FIO'
      Size = 424
    end
  end
  object OpenDialog: TOpenDialog
    Left = 112
    Top = 288
  end
  object Transaction: TOraTransaction
    DefaultSession = MainForm.OraSession
    Left = 400
    Top = 280
  end
  object qCheckChanges: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT *'
      '  FROM CONTRACT_CHANGES'
      '  WHERE CONTRACT_ID = :CONTRACT_ID'
      '    AND FILIAL_ID = :FILIAL_ID'
      '    AND CONTRACT_CHANGE_DATE = TRUNC(:DATE_CHANGE)'
      '    AND SUM_GET = :SUM_GET'
      '    AND TARIFF_ID =:NEW_TARIFF_ID'
      '    AND DOCUM_TYPE_ID = 4')
    Left = 272
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'FILIAL_ID'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_CHANGE'
      end
      item
        DataType = ftUnknown
        Name = 'SUM_GET'
      end
      item
        DataType = ftUnknown
        Name = 'NEW_TARIFF_ID'
      end>
  end
  object qCheckBalance: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT GET_ABONENT_BALANCE_NO_AT(:PHONE_NUMBER)'
      '         - NVL((SELECT C.DISCONNECT_LIMIT'
      '                  FROM CONTRACTS C'
      '                  WHERE C.PHONE_NUMBER_FEDERAL=:PHONE_NUMBER'
      '                    AND NOT EXISTS (SELECT 1'
      '                                      FROM CONTRACT_CANCELS CC'
      
        '                                      WHERE CC.CONTRACT_ID = C.C' +
        'ONTRACT_ID )),'
      '               0)  BALANCE, '
      '       NVL((SELECT CASE'
      
        '                     WHEN ((NVL(C.IS_CREDIT_CONTRACT, 0) = 1)AND' +
        '(T.BALANCE_BLOCK_CREDIT IS NOT NULL))'
      
        '                            OR ((NVL(C.IS_CREDIT_CONTRACT, 0) = ' +
        '0)AND(T.BALANCE_BLOCK IS NOT NULL)) THEN '
      '                       CASE'
      
        '                         WHEN C.IS_CREDIT_CONTRACT = 1 THEN T.BA' +
        'LANCE_BLOCK_CREDIT'
      '                         ELSE T.BALANCE_BLOCK'
      '                       END '
      '                     ELSE (SELECT CASE'
      
        '                                    WHEN C.IS_CREDIT_CONTRACT = ' +
        '1 THEN A.BALANCE_BLOCK_CREDIT'
      '                                    ELSE A.BALANCE_BLOCK'
      '                                  END                     '
      
        '                             FROM DB_LOADER_ACCOUNT_PHONES P, AC' +
        'COUNTS A'
      
        '                             WHERE P.PHONE_NUMBER = :PHONE_NUMBE' +
        'R AND P.YEAR_MONTH = TO_CHAR(SYSDATE, '#39'YYYYMM'#39') '
      
        '                               AND P.ACCOUNT_ID = A.ACCOUNT_ID(+' +
        ') AND ROWNUM = 1)'
      '                   END POROG'
      '              FROM CONTRACTS C, TARIFFS T'
      '              WHERE C.PHONE_NUMBER_FEDERAL=:PHONE_NUMBER'
      '                AND NOT EXISTS (SELECT 1'
      '                                  FROM CONTRACT_CANCELS CC'
      
        '                                  WHERE CC.CONTRACT_ID = C.CONTR' +
        'ACT_ID )'
      '                AND T.TARIFF_ID = C.CURR_TARIFF_ID), '
      '           -2) POROG '
      '  FROM DUAL')
    Left = 272
    Top = 400
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone_number'
      end>
    object qCheckBalanceBALANCE: TFloatField
      FieldName = 'BALANCE'
    end
    object qCheckBalancePOROG: TFloatField
      FieldName = 'POROG'
    end
  end
  object qAddReversePayment: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'INSERT INTO RECEIVED_PAYMENTS(PHONE_NUMBER, PAYMENT_SUM, PAYMENT' +
        '_DATE_TIME, '
      
        '                                    CONTRACT_ID, IS_CONTRACT_PAY' +
        'MENT, FILIAL_ID,'
      
        '                                    PAYMENT_ANNUL_FLAG, REMARK, ' +
        'RECEIVED_PAYMENT_TYPE_ID)'
      '        VALUES(:PHONE_NUMBER, :PAYMENT_SUM, :PAYMENT_DATE_TIME, '
      '                                    :CONTRACT_ID, 0, :FILIAL_ID,'
      '                                    0, "'#1054#1087#1083#1072#1090#1072' '#1079#1072' '#1089#1084#1077#1085#1091' '#1058#1055'", 21)')
    Left = 192
    Top = 216
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
        Name = 'FILIAL_ID'
      end>
  end
  object qCheckActive: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select * '
      'from DB_LOADER_ACCOUNT_PHONES'
      'where Phone_number=:Phone_Number'
      'and YEAR_MONTH=TO_CHAR(SYSDATE, '#39'YYYYMM'#39')'
      'and PHONE_IS_ACTIVE=1')
    Left = 448
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Phone_Number'
        Value = Null
      end>
  end
  object spSendSms: TOraStoredProc
    StoredProcName = 'SEND_SMS_ABOUT_TARIFF_CHANGE'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  SEND_SMS_ABOUT_TARIFF_CHANGE(:PPHONENUMBER);'
      'end;')
    Left = 736
    Top = 208
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONENUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SEND_SMS_ABOUT_TARIFF_CHANGE'
  end
end
