object ChangeDopStatusArrayForm: TChangeDopStatusArrayForm
  Left = 0
  Top = 0
  Caption = #1052#1072#1089#1089#1086#1074#1072#1103' '#1089#1084#1077#1085#1072' '#1076#1086#1087'. '#1089#1090#1072#1090#1091#1089#1086#1074
  ClientHeight = 404
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 47
    Width = 755
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
        FieldName = 'DopStatusName'
        Title.Alignment = taCenter
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CurrentDopStatus'
        Title.Alignment = taCenter
        Width = 153
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
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 755
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
    Width = 755
    Height = 47
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 2
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
      Width = 753
      Height = 48
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 128
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
      object tbCheckDopStatus: TToolButton
        Left = 128
        Top = 0
        Action = aFindStatus
        Enabled = False
      end
      object tbCheckContract: TToolButton
        Left = 256
        Top = 0
        Action = aFindContract
        Enabled = False
      end
      object tbAddChanges: TToolButton
        Left = 384
        Top = 0
        Action = aAddChanges
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089#1099
        Enabled = False
        Wrap = True
      end
      object tbImportExcel: TToolButton
        Left = 0
        Top = 24
        Action = aExcel
      end
      object ToolButton1: TToolButton
        Left = 128
        Top = 24
        Action = aClear
      end
    end
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
        Name = 'DopStatusName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DopStatusId'
        DataType = ftInteger
      end>
    Left = 160
    Top = 120
    Data = {
      030007000B0050686F6E654E756D62657201000A00000000000A00436F6E7472
      616374496403000000000000000C00436F6E7472616374446174650B00000000
      000000030046494F0100640000000000040049746F6701006400000000000D00
      446F705374617475734E616D6501003200000000000B00446F70537461747573
      49640300000000000000000000000000}
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
    object vtChangesDopStatusName: TStringField
      DisplayLabel = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
      DisplayWidth = 20
      FieldName = 'DopStatusName'
      Size = 50
    end
    object vtChangesDopStatusId: TIntegerField
      FieldName = 'DopStatusId'
    end
    object vtChangesCurrentDopStatus: TStringField
      DisplayLabel = #1058#1077#1082#1091#1097#1080#1081' '#1076#1086#1087'.'#1089#1090#1072#1090#1091#1089
      FieldName = 'CurrentDopStatus'
      Size = 50
    end
    object vtChangesCurrentDopStatusId: TIntegerField
      FieldName = 'CurrentDopStatusId'
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
    object aFindStatus: TAction
      Caption = #1053#1072#1081#1090#1080' '#1089#1090#1072#1090#1091#1089#1099
      OnExecute = aFindStatusExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
  end
  object qCheckDopStatus: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT DOP_STATUS_ID,'
      '       DOP_STATUS_NAME'
      '  FROM CONTRACT_DOP_STATUSES'
      '  WHERE DOP_STATUS_NAME = :pDOP_STATUS_NAME')
    Left = 272
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pDOP_STATUS_NAME'
      end>
    object qCheckDopStatusDOP_STATUS_ID: TFloatField
      FieldName = 'DOP_STATUS_ID'
      Required = True
    end
    object qCheckDopStatusDOP_STATUS_NAME: TStringField
      FieldName = 'DOP_STATUS_NAME'
      Size = 400
    end
  end
  object qAddChange: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'UPDATE contracts SET dop_status = :DOP_STATUS'
      'WHERE contract_id = :CONTRACT_ID')
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOP_STATUS'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qCheckContract: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT C.CONTRACT_ID, '
      '       c.CONTRACT_DATE,'
      '       (SELECT dop_status_name FROM contract_dop_statuses'
      '        WHERE dop_status_id = c.dop_status) current_dop_status,'
      '       c.dop_status current_dop_status_id,'
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
    object qCheckContractCURRENT_DOP_STATUS_ID: TFloatField
      FieldName = 'CURRENT_DOP_STATUS_ID'
    end
    object qCheckContractCURRENT_DOP_STATUS: TStringField
      FieldName = 'CURRENT_DOP_STATUS'
      Size = 400
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
    DefaultSession = Dm.OraSession
    Left = 400
    Top = 280
  end
  object qCheckChanges: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      
        'SELECT dop_status FROM CONTRACTS WHERE contract_id = :CONTRACT_I' +
        'D')
    Left = 272
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qCheckBalance: TOraQuery
    Session = Dm.OraSession
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
    Left = 344
    Top = 288
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
end
