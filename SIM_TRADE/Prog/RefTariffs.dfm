inherited RefTariffsForm: TRefTariffsForm
  Caption = #1058#1072#1088#1080#1092#1085#1099#1077' '#1087#1083#1072#1085#1099
  ClientHeight = 502
  ClientWidth = 843
  ExplicitWidth = 859
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 843
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 843
    inherited ToolBar1: TToolBar
      Width = 843
      ExplicitWidth = 843
      object ToolButton9: TToolButton
        Left = 202
        Top = 0
        Caption = 'ToolButton9'
        ImageIndex = 12
        OnClick = ToolButton9Click
      end
      object btnRecalcBalUnblock: TToolButton
        Left = 233
        Top = 0
        Hint = #1055#1077#1088#1077#1089#1095#1105#1090' '#1073#1072#1083#1072#1085#1089#1072' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
        Caption = 'btnRecalcBalUnblock'
        ImageIndex = 19
        OnClick = btnRecalcBalUnblockClick
      end
    end
  end
  inherited Panel2: TPanel
    Width = 843
    Height = 475
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 843
    ExplicitHeight = 475
    inherited CRDBGrid1: TCRDBGrid
      Width = 841
      Height = 473
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentFont = False
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'OPERATOR_NAME'
          Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 153
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE'
          Title.Caption = #1050#1086#1076
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_CODE_CRM'
          Title.Caption = #1050#1086#1076' CRM'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_TYPE_NAME'
          Title.Caption = #1058#1080#1087
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'START_BALANCE'
          Title.Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1073#1072#1083#1072#1085#1089
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONNECT_PRICE'
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ADVANCE_PAYMENT'
          Title.Caption = #1040#1074#1072#1085#1089#1086#1074#1099#1081' '#1087#1083#1072#1090#1077#1078
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_ACTIVE_NAME'
          Title.Caption = #1040#1082#1090#1080#1074#1085#1099#1081
          Width = 63
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DAYLY_PAYMENT'
          Title.Caption = #1040#1073'.'#1087#1083'./'#1076#1077#1085#1100
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DAYLY_PAYMENT_LOCKED'
          Title.Caption = #1041#1083'.'#1072#1073'.'#1087#1083'./'#1076#1077#1085#1100
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MONTHLY_PAYMENT'
          Title.Caption = #1040#1073'.'#1087#1083'/'#1084#1077#1089'.'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MONTHLY_PAYMENT_LOCKED'
          Title.Caption = #1041#1083'.'#1072#1073'.'#1087#1083'/'#1084#1077#1089'.'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALC_KOEFF'
          Title.Caption = #1050#1086#1101#1092#1092' '#1087#1077#1088#1077#1089#1095#1077#1090#1072' '#1072#1073#1086#1085#1087#1083#1072#1090#1099
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_ADD_COST'
          Title.Caption = #1044#1086#1073'. '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FREE_MONTH_MINUTES_CNT_FOR_RPT'
          Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1099#1093' '#1084#1080#1085#1091#1090' '#1076#1083#1103' '#1086#1090#1095#1105#1090#1072
          Width = 182
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_NOTICE'
          Title.Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103
          Width = 147
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_BLOCK'
          Title.Caption = #1055#1086#1088#1086#1075' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
          Width = 119
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_UNBLOCK'
          Title.Caption = #1055#1086#1088#1086#1075' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
          Width = 143
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_NOTICE_CREDIT'
          Title.Alignment = taCenter
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_BLOCK_CREDIT'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_UNBLOCK_CREDIT'
          Title.Alignment = taCenter
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_PRIORITY'
          Title.Alignment = taCenter
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_ABON_DAILY_PAY'
          Title.Alignment = taCenter
          Title.Caption = #1057#1087#1080#1089'. '#1072#1073'. '#1087#1083'. '#1089#1091#1090'.'
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_ACTION_PLUS_SMS'
          Title.Alignment = taCenter
          Title.Caption = #1040#1082#1094#1080#1103' "'#1057#1052#1057'300" '#1080' "+"'
          Width = 167
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FILIAL_NAME'
          Title.Alignment = taCenter
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_ID'
          Title.Alignment = taCenter
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPERATOR_MONTHLY_ABON_ACTIV'
          Title.Alignment = taCenter
          Width = 141
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPERATOR_MONTHLY_ABON_BLOCK'
          Title.Alignment = taCenter
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALC_KOEFF_DETAL'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1101#1092'.'#1087#1077#1088#1077#1089#1095#1077#1090#1072' '#1076#1077#1090#1072#1083#1080#1079'.'
          Width = 156
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TrafNotIgnor4InactName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1077' '#1080#1075#1085#1086#1088'. '#1090#1088#1072#1092#1080#1082' '#1087#1088#1080' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1089#1090#1080
          Width = 220
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = 'TARIFF_ID'
    SQLInsert.Strings = (
      'INSERT INTO TARIFFS'
      
        '  (TARIFF_ID, TARIFF_CODE, OPERATOR_ID, TARIFF_NAME, IS_ACTIVE, ' +
        'START_BALANCE, CONNECT_PRICE, ADVANCE_PAYMENT, PHONE_NUMBER_TYPE' +
        ', DAYLY_PAYMENT, DAYLY_PAYMENT_LOCKED, MONTHLY_PAYMENT, MONTHLY_' +
        'PAYMENT_LOCKED, CALC_KOEFF, FREE_MONTH_MINUTES_CNT_FOR_RPT, BALA' +
        'NCE_BLOCK, BALANCE_UNBLOCK, BALANCE_NOTICE, TARIFF_ADD_COST, BAL' +
        'ANCE_BLOCK_CREDIT, BALANCE_UNBLOCK_CREDIT, BALANCE_NOTICE_CREDIT' +
        ', TARIFF_CODE_CRM, TARIFF_PRIORITY, TARIFF_ABON_DAILY_PAY, TARIF' +
        'F_ACTION_PLUS_SMS, FILIAL_ID, OPERATOR_MONTHLY_ABON_ACTIV, OPERA' +
        'TOR_MONTHLY_ABON_BLOCK, CALC_KOEFF_DETAL, TRAFFIC_NOT_IGNOR_FOR_' +
        'INACTIVE)'
      'VALUES'
      
        '  (:TARIFF_ID, :TARIFF_CODE, :OPERATOR_ID, :TARIFF_NAME, :IS_ACT' +
        'IVE, :START_BALANCE, :CONNECT_PRICE, :ADVANCE_PAYMENT, :PHONE_NU' +
        'MBER_TYPE, :DAYLY_PAYMENT, :DAYLY_PAYMENT_LOCKED, :MONTHLY_PAYME' +
        'NT, :MONTHLY_PAYMENT_LOCKED, :CALC_KOEFF, :FREE_MONTH_MINUTES_CN' +
        'T_FOR_RPT, :BALANCE_BLOCK, :BALANCE_UNBLOCK, :BALANCE_NOTICE, :T' +
        'ARIFF_ADD_COST, :BALANCE_BLOCK_CREDIT, :BALANCE_UNBLOCK_CREDIT, ' +
        ':BALANCE_NOTICE_CREDIT, :TARIFF_CODE_CRM, :TARIFF_PRIORITY, :TAR' +
        'IFF_ABON_DAILY_PAY, :TARIFF_ACTION_PLUS_SMS, :FILIAL_ID, :OPERAT' +
        'OR_MONTHLY_ABON_ACTIV, :OPERATOR_MONTHLY_ABON_BLOCK, :CALC_KOEFF' +
        '_DETAL, :TRAFFIC_NOT_IGNOR_FOR_INACTIVE)')
    SQLDelete.Strings = (
      'DELETE FROM TARIFFS'
      'WHERE'
      '  TARIFF_ID = :Old_TARIFF_ID')
    SQLUpdate.Strings = (
      'UPDATE TARIFFS'
      'SET'
      
        '  TARIFF_ID = :TARIFF_ID, TARIFF_CODE = :TARIFF_CODE, OPERATOR_I' +
        'D = :OPERATOR_ID, TARIFF_NAME = :TARIFF_NAME, IS_ACTIVE = :IS_AC' +
        'TIVE, START_BALANCE = :START_BALANCE, CONNECT_PRICE = :CONNECT_P' +
        'RICE, ADVANCE_PAYMENT = :ADVANCE_PAYMENT, PHONE_NUMBER_TYPE = :P' +
        'HONE_NUMBER_TYPE, DAYLY_PAYMENT = :DAYLY_PAYMENT, DAYLY_PAYMENT_' +
        'LOCKED = :DAYLY_PAYMENT_LOCKED, MONTHLY_PAYMENT = :MONTHLY_PAYME' +
        'NT, MONTHLY_PAYMENT_LOCKED = :MONTHLY_PAYMENT_LOCKED, CALC_KOEFF' +
        ' = :CALC_KOEFF, FREE_MONTH_MINUTES_CNT_FOR_RPT = :FREE_MONTH_MIN' +
        'UTES_CNT_FOR_RPT, BALANCE_BLOCK = :BALANCE_BLOCK, BALANCE_UNBLOC' +
        'K = :BALANCE_UNBLOCK, BALANCE_NOTICE = :BALANCE_NOTICE, TARIFF_A' +
        'DD_COST = :TARIFF_ADD_COST, BALANCE_BLOCK_CREDIT = :BALANCE_BLOC' +
        'K_CREDIT, BALANCE_UNBLOCK_CREDIT = :BALANCE_UNBLOCK_CREDIT, BALA' +
        'NCE_NOTICE_CREDIT = :BALANCE_NOTICE_CREDIT, TARIFF_CODE_CRM = :T' +
        'ARIFF_CODE_CRM, TARIFF_PRIORITY = :TARIFF_PRIORITY, TARIFF_ABON_' +
        'DAILY_PAY= :TARIFF_ABON_DAILY_PAY, TARIFF_ACTION_PLUS_SMS = :TAR' +
        'IFF_ACTION_PLUS_SMS, FILIAL_ID=:FILIAL_ID, OPERATOR_MONTHLY_ABON' +
        '_ACTIV = :OPERATOR_MONTHLY_ABON_ACTIV, OPERATOR_MONTHLY_ABON_BLO' +
        'CK = :OPERATOR_MONTHLY_ABON_BLOCK, CALC_KOEFF_DETAL=:CALC_KOEFF_' +
        'DETAL, TRAFFIC_NOT_IGNOR_FOR_INACTIVE=:TRAFFIC_NOT_IGNOR_FOR_INA' +
        'CTIVE'
      'WHERE'
      '  TARIFF_ID = :Old_TARIFF_ID')
    SQLLock.Strings = (
      'SELECT * FROM TARIFFS'
      'WHERE'
      '  TARIFF_ID = :Old_TARIFF_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT TARIFF_ID, TARIFF_CODE, OPERATOR_ID, TARIFF_NAME, IS_ACTI' +
        'VE, START_BALANCE, CONNECT_PRICE, ADVANCE_PAYMENT, PHONE_NUMBER_' +
        'TYPE, DAYLY_PAYMENT, DAYLY_PAYMENT_LOCKED, MONTHLY_PAYMENT, MONT' +
        'HLY_PAYMENT_LOCKED, CALC_KOEFF, FREE_MONTH_MINUTES_CNT_FOR_RPT, ' +
        'BALANCE_BLOCK, BALANCE_UNBLOCK, BALANCE_NOTICE, TARIFF_ADD_COST,' +
        ' BALANCE_BLOCK_CREDIT, BALANCE_UNBLOCK_CREDIT, BALANCE_NOTICE_CR' +
        'EDIT, TARIFF_CODE_CRM, TARIFF_PRIORITY, TARIFF_ABON_DAILY_PAY, T' +
        'ARIFF_ACTION_PLUS_SMS, FILIAL_ID, OPERATOR_MONTHLY_ABON_ACTIV, '
      
        'OPERATOR_MONTHLY_ABON_BLOCK, CALC_KOEFF_DETAL, TRAFFIC_NOT_IGNOR' +
        '_FOR_INACTIVE FROM TARIFFS'
      'WHERE'
      '  TARIFF_ID = :TARIFF_ID')
    SQL.Strings = (
      'SELECT *'
      ''
      'FROM TARIFFS')
    IndexFieldNames = 'TARIFF_ID'
    object qMainTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
    object qMainCALC_KOEFF_DETAL: TFloatField
      DisplayWidth = 10
      FieldName = 'CALC_KOEFF_DETAL'
    end
    object qMainTARIFF_CODE: TStringField
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qMainOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
    end
    object qMainPHONE_NUMBER_TYPE: TIntegerField
      FieldName = 'PHONE_NUMBER_TYPE'
    end
    object qMainTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qMainIS_ACTIVE: TIntegerField
      FieldName = 'IS_ACTIVE'
    end
    object qMainSTART_BALANCE: TFloatField
      FieldName = 'START_BALANCE'
    end
    object qMainCONNECT_PRICE: TFloatField
      FieldName = 'CONNECT_PRICE'
    end
    object qMainADVANCE_PAYMENT: TFloatField
      FieldName = 'ADVANCE_PAYMENT'
    end
    object qMainOPERATOR_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPERATOR_NAME'
      LookupDataSet = qOperators
      LookupKeyFields = 'OPERATOR_ID'
      LookupResultField = 'OPERATOR_NAME'
      KeyFields = 'OPERATOR_ID'
      Lookup = True
    end
    object qMainPHONE_NUMBER_TYPE_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'PHONE_NUMBER_TYPE_NAME'
      LookupDataSet = qPhoneNumberTypes
      LookupKeyFields = 'PHONE_NUMBER_TYPE'
      LookupResultField = 'PHONE_NUMBER_TYPE_NAME'
      KeyFields = 'PHONE_NUMBER_TYPE'
      Lookup = True
    end
    object qMainIS_ACTIVE_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'IS_ACTIVE_NAME'
      LookupDataSet = qIsActive
      LookupKeyFields = 'IS_ACTIVE'
      LookupResultField = 'IS_ACTIVE_NAME'
      KeyFields = 'IS_ACTIVE'
      Lookup = True
    end
    object qMainDAYLY_PAYMENT: TFloatField
      FieldName = 'DAYLY_PAYMENT'
    end
    object qMainDAYLY_PAYMENT_LOCKED: TFloatField
      FieldName = 'DAYLY_PAYMENT_LOCKED'
    end
    object qMainMONTHLY_PAYMENT: TFloatField
      FieldName = 'MONTHLY_PAYMENT'
    end
    object qMainMONTHLY_PAYMENT_LOCKED: TFloatField
      FieldName = 'MONTHLY_PAYMENT_LOCKED'
    end
    object qMainCALC_KOEFF: TFloatField
      FieldName = 'CALC_KOEFF'
    end
    object qMainFREE_MONTH_MINUTES_CNT_FOR_RPT: TIntegerField
      FieldName = 'FREE_MONTH_MINUTES_CNT_FOR_RPT'
    end
    object qMainBALANCE_BLOCK: TFloatField
      FieldName = 'BALANCE_BLOCK'
    end
    object qMainBALANCE_UNBLOCK: TFloatField
      FieldName = 'BALANCE_UNBLOCK'
    end
    object qMainBALANCE_NOTICE: TFloatField
      FieldName = 'BALANCE_NOTICE'
    end
    object qMainTARIFF_ADD_COST: TFloatField
      FieldName = 'TARIFF_ADD_COST'
    end
    object qMainBALANCE_BLOCK_CREDIT: TFloatField
      DisplayLabel = #1055#1086#1088#1086#1075' '#1073#1083'. '#1082#1088'.'
      FieldName = 'BALANCE_BLOCK_CREDIT'
    end
    object qMainBALANCE_UNBLOCK_CREDIT: TFloatField
      DisplayLabel = #1055#1086#1088#1086#1075' '#1088#1072#1079#1073#1083'. '#1082#1088'.'
      FieldName = 'BALANCE_UNBLOCK_CREDIT'
    end
    object qMainBALANCE_NOTICE_CREDIT: TFloatField
      DisplayLabel = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076'. '#1082#1088'.'
      FieldName = 'BALANCE_NOTICE_CREDIT'
    end
    object qMainTARIFF_CODE_CRM: TStringField
      FieldName = 'TARIFF_CODE_CRM'
      Size = 200
    end
    object qMainTARIFF_PRIORITY: TFloatField
      DisplayLabel = #1055#1088#1080#1086#1088#1080#1090#1077#1090
      FieldName = 'TARIFF_PRIORITY'
    end
    object qMainFILIAL_ID: TFloatField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      FieldName = 'FILIAL_ID'
      LookupDataSet = qFilials
      LookupKeyFields = 'FILIAL_ID'
      LookupResultField = 'FILIAL_NAME'
      KeyFields = 'FILIAL_ID'
    end
    object qMainFILIAL_NAME: TStringField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      FieldKind = fkLookup
      FieldName = 'FILIAL_NAME'
      LookupDataSet = qFilials
      LookupKeyFields = 'FILIAL_ID'
      LookupResultField = 'FILIAL_NAME'
      KeyFields = 'FILIAL_ID'
      Size = 15
      Lookup = True
    end
    object qMainOPERATOR_MONTHLY_ABON_ACTIV: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083'. '#1084#1077#1089'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'OPERATOR_MONTHLY_ABON_ACTIV'
    end
    object qMainOPERATOR_MONTHLY_ABON_BLOCK: TFloatField
      DisplayLabel = #1040#1073'.'#1087#1083'. '#1084#1077#1089'. '#1074' '#1076#1086#1073#1088'.'#1073#1083'. '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      FieldName = 'OPERATOR_MONTHLY_ABON_BLOCK'
    end
    object qMainTRAFFIC_NOT_IGNOR_FOR_INACTIVE: TFloatField
      FieldName = 'TRAFFIC_NOT_IGNOR_FOR_INACTIVE'
    end
    object qMainTrafNotIgnor4InactName: TStringField
      FieldKind = fkLookup
      FieldName = 'TrafNotIgnor4InactName'
      LookupDataSet = qTRAFFICNOTIGNOR4INACTIVE
      LookupKeyFields = 'TRAFFIC_NOT_IGNOR_FOR_INACTIVE'
      LookupResultField = 'TRAFNOTIGNOR4INACTNAME'
      KeyFields = 'TRAFFIC_NOT_IGNOR_FOR_INACTIVE'
      Lookup = True
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N7: TMenuItem
      Caption = '-'
    end
    object H1: TMenuItem
      Action = aExtEdit
    end
  end
  inherited ActionList1: TActionList
    Images = MainForm.ImageList32
    object act1: TAction
      Caption = 'act1'
    end
    object aExtEdit: TAction
      Caption = #1058#1072#1088#1080#1092'-'#1054#1087#1094#1080#1080
      ImageIndex = 27
      ShortCut = 16453
      OnExecute = aExtEditExecute
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_TARIFF_ID'
    CommandStoredProcName = 'NEW_TARIFF_ID:0'
  end
  object qOperators: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM OPERATORS'
      'ORDER BY OPERATOR_NAME')
    Left = 184
    Top = 153
  end
  object qIsActive: TOraQuery
    SQL.Strings = (
      'SELECT 0 IS_ACTIVE, '#39#39' IS_ACTIVE_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 1 IS_ACTIVE, '#39#1044#1072#39' IS_ACTIVE_NAME FROM DUAL')
    Active = True
    Left = 184
    Top = 201
  end
  object qPhoneNumberTypes: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM PHONE_NUMBER_TYPES'
      'ORDER BY PHONE_NUMBER_TYPE')
    Active = True
    Left = 288
    Top = 161
  end
  object qFilials: TOraTable
    TableName = 'FILIALS'
    OrderFields = 'FILIAL_NAME'
    KeyFields = 'FILIAL_ID'
    Session = MainForm.OraSession
    Active = True
    Left = 112
    Top = 145
  end
  object spRecalcTarifBalUblck: TOraStoredProc
    StoredProcName = 'RECALC_TARIF'
    Session = MainForm.OraSession
    Left = 448
    Top = 224
    CommandStoredProcName = 'RECALC_TARIF'
  end
  object qTRAFFICNOTIGNOR4INACTIVE: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT 0 TRAFFIC_NOT_IGNOR_FOR_INACTIVE, '#39#39' TrafNotIgnor4InactNa' +
        'me FROM DUAL'
      'UNION ALL'
      
        'SELECT 1 TRAFFIC_NOT_IGNOR_FOR_INACTIVE, '#39#1044#1072#39' TrafNotIgnor4Inact' +
        'Name FROM DUAL')
    Left = 184
    Top = 264
  end
end
