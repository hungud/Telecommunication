object Tariff_option: TTariff_option
  Left = 0
  Top = 0
  Caption = #1058#1072#1088#1080#1092': %tariff'
  ClientHeight = 604
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 137
    Align = alTop
    TabOrder = 0
    object lbl18: TLabel
      Left = 16
      Top = 29
      Width = 73
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FocusControl = dbedt1
    end
    object dbtxtTARIFF_CODE: TDBText
      Left = 16
      Top = 8
      Width = 177
      Height = 17
      DataField = 'TARIFF_CODE'
      DataSource = dsTariffs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl19: TLabel
      Left = 16
      Top = 72
      Width = 71
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      FocusControl = dbedtCONNECT_PRICE
    end
    object lbl20: TLabel
      Left = 96
      Top = 72
      Width = 95
      Height = 13
      Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1073#1072#1083#1072#1085#1089
      FocusControl = dbedtSTART_BALANCE
    end
    object lbl21: TLabel
      Left = 200
      Top = 29
      Width = 55
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072
      FocusControl = dbedtMONTHLY_PAYMENT
    end
    object lbl22: TLabel
      Left = 200
      Top = 72
      Width = 97
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072' '#1074' '#1073#1083#1086#1082#1077
      FocusControl = dbedtMONTHLY_PAYMENT_LOCKED
    end
    object lbl23: TLabel
      Left = 304
      Top = 29
      Width = 83
      Height = 13
      Caption = #1050#1086#1101#1092'.'#1087#1077#1088#1077#1089#1095#1105#1090#1072
      FocusControl = dbedtCALC_KOEFF
    end
    object lbl24: TLabel
      Left = 304
      Top = 72
      Width = 93
      Height = 13
      Caption = 'K'#39' '#1087#1077#1088#1077#1089#1095'.'#1076#1077#1090#1072#1083#1086#1082
      FocusControl = dbedtCALC_KOEFF_DETAL
    end
    object lbl25: TLabel
      Left = 408
      Top = 29
      Width = 96
      Height = 13
      Caption = #1055#1088#1077#1074#1099#1096'.'#1073#1077#1089#1087#1083'.'#1084#1080#1085
      FocusControl = dbedt2
    end
    object lbl26: TLabel
      Left = 520
      Top = 29
      Width = 66
      Height = 13
      Caption = #1041#1072#1083#1072#1085#1089' '#1073#1083#1086#1082'.'
      FocusControl = dbedtBALANCE_BLOCK
    end
    object lbl27: TLabel
      Left = 600
      Top = 29
      Width = 71
      Height = 13
      Caption = #1041#1072#1083#1072#1085#1089' '#1088#1072#1079#1073#1083'.'
      FocusControl = dbedtBALANCE_UNBLOCK
    end
    object lbl28: TLabel
      Left = 687
      Top = 29
      Width = 81
      Height = 13
      Caption = #1041#1072#1083#1072#1085#1089' '#1086#1087#1086#1074#1077#1097'.'
      FocusControl = dbedtBALANCE_NOTICE
    end
    object lbl29: TLabel
      Left = 408
      Top = 72
      Width = 93
      Height = 13
      Caption = #1044#1086#1073#1072#1074#1086#1095#1085#1072#1103' '#1072#1073#1086#1085'.'
      FocusControl = dbedtTARIFF_ADD_COST
    end
    object lbl30: TLabel
      Left = 520
      Top = 72
      Width = 83
      Height = 13
      Caption = #1050#1088'.'#1041#1072#1083#1072#1085#1089' '#1073#1083#1086#1082'.'
      FocusControl = dbedtBALANCE_BLOCK_CREDIT
    end
    object lbl31: TLabel
      Left = 600
      Top = 72
      Width = 88
      Height = 13
      Caption = #1050#1088'.'#1041#1072#1083#1072#1085#1089' '#1088#1072#1079#1073#1083'.'
      FocusControl = dbedtBALANCE_UNBLOCK_CREDIT
    end
    object Label3: TLabel
      Left = 687
      Top = 72
      Width = 83
      Height = 13
      Caption = #1050#1088'.'#1073#1072#1083#1072#1085#1089' '#1086#1087#1086#1074'.'
      FocusControl = dbedtBALANCE_NOTICE_CREDIT
    end
    object Label4: TLabel
      Left = 776
      Top = 29
      Width = 94
      Height = 13
      Caption = #1045#1078#1077#1076#1085#1077#1074#1085#1072#1103' '#1072#1073#1086#1085'.'
      FocusControl = dbedtTARIFF_ABON_DAILY_PAY
    end
    object lbl32: TLabel
      Left = 776
      Top = 72
      Width = 30
      Height = 13
      Caption = #1057#1052#1057'+'
      FocusControl = dbedtTARIFF_ACTION_PLUS_SMS
    end
    object dbedt1: TDBEdit
      Left = 16
      Top = 45
      Width = 177
      Height = 21
      DataField = 'TARIFF_NAME'
      DataSource = dsTariffs
      TabOrder = 0
    end
    object dbchkIS_ACTIVE: TDBCheckBox
      Left = 200
      Top = 8
      Width = 81
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
      DataField = 'IS_ACTIVE'
      DataSource = dsTariffs
      TabOrder = 1
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbedtCONNECT_PRICE: TDBEdit
      Left = 16
      Top = 88
      Width = 73
      Height = 21
      DataField = 'CONNECT_PRICE'
      DataSource = dsTariffs
      TabOrder = 2
    end
    object dbedtSTART_BALANCE: TDBEdit
      Left = 96
      Top = 88
      Width = 97
      Height = 21
      DataField = 'START_BALANCE'
      DataSource = dsTariffs
      TabOrder = 3
    end
    object dbchkPHONE_NUMBER_TYPE: TDBCheckBox
      Left = 304
      Top = 8
      Width = 113
      Height = 17
      Caption = #1043#1086#1088#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
      DataField = 'PHONE_NUMBER_TYPE'
      DataSource = dsTariffs
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbedtMONTHLY_PAYMENT: TDBEdit
      Left = 200
      Top = 45
      Width = 97
      Height = 21
      DataField = 'MONTHLY_PAYMENT'
      DataSource = dsTariffs
      TabOrder = 5
    end
    object dbedtMONTHLY_PAYMENT_LOCKED: TDBEdit
      Left = 200
      Top = 88
      Width = 97
      Height = 21
      DataField = 'MONTHLY_PAYMENT_LOCKED'
      DataSource = dsTariffs
      TabOrder = 6
    end
    object dbedtCALC_KOEFF: TDBEdit
      Left = 304
      Top = 45
      Width = 97
      Height = 21
      DataField = 'CALC_KOEFF'
      DataSource = dsTariffs
      TabOrder = 7
    end
    object dbedtCALC_KOEFF_DETAL: TDBEdit
      Left = 304
      Top = 88
      Width = 97
      Height = 21
      DataField = 'CALC_KOEFF_DETAL'
      DataSource = dsTariffs
      TabOrder = 8
    end
    object dbedt2: TDBEdit
      Left = 408
      Top = 45
      Width = 105
      Height = 21
      DataField = 'FREE_MONTH_MINUTES_CNT_FOR_RPT'
      DataSource = dsTariffs
      TabOrder = 9
    end
    object dbedtBALANCE_BLOCK: TDBEdit
      Left = 520
      Top = 45
      Width = 73
      Height = 21
      DataField = 'BALANCE_BLOCK'
      DataSource = dsTariffs
      TabOrder = 10
    end
    object dbedtBALANCE_UNBLOCK: TDBEdit
      Left = 600
      Top = 45
      Width = 73
      Height = 21
      DataField = 'BALANCE_UNBLOCK'
      DataSource = dsTariffs
      TabOrder = 11
    end
    object dbedtBALANCE_NOTICE: TDBEdit
      Left = 687
      Top = 45
      Width = 81
      Height = 21
      DataField = 'BALANCE_NOTICE'
      DataSource = dsTariffs
      TabOrder = 12
    end
    object dbedtTARIFF_ADD_COST: TDBEdit
      Left = 408
      Top = 88
      Width = 105
      Height = 21
      DataField = 'TARIFF_ADD_COST'
      DataSource = dsTariffs
      TabOrder = 13
    end
    object dbedtBALANCE_BLOCK_CREDIT: TDBEdit
      Left = 520
      Top = 88
      Width = 73
      Height = 21
      DataField = 'BALANCE_BLOCK_CREDIT'
      DataSource = dsTariffs
      TabOrder = 14
    end
    object dbedtBALANCE_UNBLOCK_CREDIT: TDBEdit
      Left = 600
      Top = 88
      Width = 73
      Height = 21
      DataField = 'BALANCE_UNBLOCK_CREDIT'
      DataSource = dsTariffs
      TabOrder = 15
    end
    object dbedtBALANCE_NOTICE_CREDIT: TDBEdit
      Left = 687
      Top = 88
      Width = 81
      Height = 21
      DataField = 'BALANCE_NOTICE_CREDIT'
      DataSource = dsTariffs
      TabOrder = 16
    end
    object dbchkTARIFF_PRIORITY: TDBCheckBox
      Left = 424
      Top = 8
      Width = 97
      Height = 17
      Caption = #1055#1088#1080#1086#1088#1077#1090#1077#1090#1085#1099#1081
      DataField = 'TARIFF_PRIORITY'
      DataSource = dsTariffs
      TabOrder = 17
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbedtTARIFF_ABON_DAILY_PAY: TDBEdit
      Left = 776
      Top = 45
      Width = 97
      Height = 21
      DataField = 'TARIFF_ABON_DAILY_PAY'
      DataSource = dsTariffs
      TabOrder = 18
    end
    object dbedtTARIFF_ACTION_PLUS_SMS: TDBEdit
      Left = 776
      Top = 88
      Width = 97
      Height = 21
      DataField = 'TARIFF_ACTION_PLUS_SMS'
      DataSource = dsTariffs
      TabOrder = 19
    end
    object NVTariff: TDBNavigator
      Left = 560
      Top = 3
      Width = 312
      Height = 25
      DataSource = dsTariffs
      VisibleButtons = [nbPost, nbCancel, nbRefresh]
      Kind = dbnHorizontal
      TabOrder = 20
    end
    object Button1: TButton
      Left = 656
      Top = 112
      Width = 217
      Height = 17
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1087#1094#1080#1080
      TabOrder = 21
      OnClick = Button1Click
    end
  end
  object Ctrl_Options: TDBCtrlGrid
    Left = 0
    Top = 137
    Width = 900
    Height = 467
    Align = alClient
    DataSource = dsTariff_opt
    PanelBorder = gbNone
    PanelHeight = 116
    PanelWidth = 884
    TabOrder = 1
    RowCount = 4
    OnPaintPanel = Ctrl_OptionsPaintPanel
    ExplicitTop = 121
    ExplicitHeight = 483
    object lblBEGIN_DATE: TDBText
      Left = 468
      Top = 25
      Width = 65
      Height = 17
      DataField = 'BEGIN_DATE'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtCALC_UNBLOCK_O: TDBText
      Left = 104
      Top = 104
      Width = 129
      Height = 17
      DataField = 'CALC_UNBLOCK_O'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtCALC_UNBLOCK_O1: TDBText
      Left = 104
      Top = 88
      Width = 137
      Height = 17
      DataField = 'DISCR_SPISANIE'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtCALC_UNBLOCK_O2: TDBText
      Left = 468
      Top = 41
      Width = 65
      Height = 17
      DataField = 'END_DATE'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtCALC_UNBLOCK_O8: TDBText
      Left = 104
      Top = 24
      Width = 105
      Height = 17
      Color = clBtnFace
      DataField = 'OPTION_CODE'
      DataSource = dsTariff_opt
      ParentColor = False
      Transparent = True
    end
    object lbl1: TLabel
      Left = 16
      Top = 24
      Width = 53
      Height = 13
      Caption = #1050#1086#1076' '#1086#1087#1094#1080#1080
      Transparent = True
    end
    object lbl2: TLabel
      Left = 16
      Top = 40
      Width = 73
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Transparent = True
    end
    object dbtxtCALC_UNBLOCK_O9: TDBText
      Left = 104
      Top = 40
      Width = 145
      Height = 17
      DataField = 'OPTION_NAME'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object lbl3: TLabel
      Left = 304
      Top = 24
      Width = 66
      Height = 13
      Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1089' '
      Transparent = True
    end
    object lbl4: TLabel
      Left = 304
      Top = 40
      Width = 73
      Height = 13
      Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1087#1086' '
      Transparent = True
    end
    object lbl5: TLabel
      Left = 16
      Top = 88
      Width = 59
      Height = 13
      Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
      Transparent = True
    end
    object lbl6: TLabel
      Left = 16
      Top = 56
      Width = 82
      Height = 13
      Caption = #1053#1072#1080#1084'. '#1076#1083#1103' '#1072#1073#1086#1085'.'
      Transparent = True
    end
    object dbtxtOPTION_NAME_FOR_AB: TDBText
      Left = 104
      Top = 56
      Width = 145
      Height = 17
      DataField = 'OPTION_NAME_FOR_AB'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object lbl7: TLabel
      Left = 16
      Top = 104
      Width = 75
      Height = 13
      Caption = #1059#1089#1083#1086#1074#1080#1077' '#1073#1083#1086#1082#1072
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 291
      Top = 2
      Width = 4
      Height = 113
    end
    object bvl1: TBevel
      Left = 595
      Top = 2
      Width = 4
      Height = 113
    end
    object lbl8: TLabel
      Left = 304
      Top = 8
      Width = 133
      Height = 13
      Caption = #1062#1077#1085#1086#1074#1099#1077' '#1087#1088#1072#1074#1080#1083#1072': '#1054#1073#1097#1080#1077
      Transparent = True
    end
    object lbl9: TLabel
      Left = 608
      Top = 8
      Width = 206
      Height = 13
      Caption = #1062#1077#1085#1086#1074#1099#1077' '#1087#1088#1072#1074#1080#1083#1072': '#1055#1086' '#1090#1077#1082#1091#1097#1077#1084#1091' '#1090#1072#1088#1080#1092#1091
      Transparent = True
    end
    object lbl10: TLabel
      Left = 16
      Top = 72
      Width = 76
      Height = 13
      Caption = #1050#1086#1101#1092'.'#1082#1086#1084#1080#1089#1089#1080#1080
      Transparent = True
    end
    object dbtxtKOEF_KOMISS_O: TDBText
      Left = 104
      Top = 72
      Width = 145
      Height = 17
      DataField = 'KOEF_KOMISS_O'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object lbl11: TLabel
      Left = 16
      Top = 8
      Width = 111
      Height = 13
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1087#1094#1080#1080
      Transparent = True
    end
    object lbl12: TLabel
      Left = 304
      Top = 56
      Width = 71
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      Transparent = True
    end
    object lbl13: TLabel
      Left = 304
      Top = 72
      Width = 55
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072
      Transparent = True
    end
    object lbl14: TLabel
      Left = 304
      Top = 88
      Width = 137
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      Transparent = True
    end
    object lbl15: TLabel
      Left = 304
      Top = 104
      Width = 121
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072' ('#1094#1077#1085#1072' '#1086#1087#1077#1088'.)'
      Transparent = True
    end
    object dbtxtTURN_ON_COST: TDBText
      Left = 468
      Top = 57
      Width = 65
      Height = 17
      DataField = 'TURN_ON_COST_o'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtMONTHLY_COST: TDBText
      Left = 468
      Top = 73
      Width = 65
      Height = 17
      DataField = 'MONTHLY_COST_o'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtOPERATOR_TURN_ON_COST: TDBText
      Left = 468
      Top = 89
      Width = 65
      Height = 17
      DataField = 'OPERATOR_TURN_ON_COST'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object dbtxtOPERATOR_MONTHLY_COST: TDBText
      Left = 468
      Top = 105
      Width = 65
      Height = 17
      DataField = 'OPERATOR_MONTHLY_COST'
      DataSource = dsTariff_opt
      Transparent = True
    end
    object Label1: TLabel
      Left = 608
      Top = 32
      Width = 71
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      Transparent = True
    end
    object lbl16: TLabel
      Left = 608
      Top = 56
      Width = 55
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072
      Transparent = True
    end
    object lbl17: TLabel
      Left = 608
      Top = 80
      Width = 125
      Height = 13
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1076#1083#1103' '#1089#1095#1105#1090#1072
      Transparent = True
    end
    object Label2: TLabel
      Left = 608
      Top = 104
      Width = 109
      Height = 13
      Caption = #1040#1073#1086#1085#1087#1083#1072#1090#1072' '#1076#1083#1103' '#1089#1095#1105#1090#1072
      Transparent = True
    end
    object lblSave: TLabel
      Left = 824
      Top = 8
      Width = 55
      Height = 13
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
      OnClick = lblSaveClick
    end
    object dbedtTURN_ON_COST_FOR_BILLS: TDBEdit
      Left = 744
      Top = 72
      Width = 121
      Height = 21
      DataField = 'TURN_ON_COST_FOR_BILLS'
      DataSource = dsTariff_opt
      TabOrder = 0
      OnEnter = dbedtTURN_ON_COSTEnter
      OnExit = dbedtTURN_ON_COSTExit
      OnKeyPress = dbedtTURN_ON_COSTKeyPress
    end
    object dbedtMONTHLY_COST_FOR_BILLS: TDBEdit
      Left = 744
      Top = 96
      Width = 121
      Height = 21
      DataField = 'MONTHLY_COST_FOR_BILLS'
      DataSource = dsTariff_opt
      TabOrder = 1
      OnEnter = dbedtTURN_ON_COSTEnter
      OnExit = dbedtTURN_ON_COSTExit
      OnKeyPress = dbedtTURN_ON_COSTKeyPress
    end
    object dbedtTURN_ON_COST: TDBEdit
      Left = 744
      Top = 24
      Width = 121
      Height = 21
      DataField = 'TURN_ON_COST'
      DataSource = dsTariff_opt
      TabOrder = 2
      OnEnter = dbedtTURN_ON_COSTEnter
      OnExit = dbedtTURN_ON_COSTExit
      OnKeyPress = dbedtTURN_ON_COSTKeyPress
    end
    object dbedtMONTHLY_COST: TDBEdit
      Left = 744
      Top = 48
      Width = 121
      Height = 21
      DataField = 'MONTHLY_COST'
      DataSource = dsTariff_opt
      TabOrder = 3
      OnEnter = dbedtTURN_ON_COSTEnter
      OnExit = dbedtTURN_ON_COSTExit
      OnKeyPress = dbedtTURN_ON_COSTKeyPress
    end
  end
  object qOptions: TOraQuery
    UpdatingTable = 'TARIFF_OPTION_NEW_COST'
    SQLInsert.Strings = (
      'begin'
      'null;'
      'end;')
    SQLDelete.Strings = (
      
        'delete TARIFF_OPTION_NEW_COST where tariff_option_new_cost_id=:t' +
        'ariff_option_new_cost_id')
    SQLUpdate.Strings = (
      'begin'
      'UPDATE TARIFF_OPTION_NEW_COST set '
      'TURN_ON_COST=:TURN_ON_COST,MONTHLY_COST=:MONTHLY_COST,'
      
        'TURN_ON_COST_FOR_BILLS=:TURN_ON_COST_FOR_BILLS,MONTHLY_COST_FOR_' +
        'BILLS=:MONTHLY_COST_FOR_BILLS'
      'where tariff_option_new_cost_id=:tariff_option_new_cost_id;'
      'if sql%rowcount=0 then '
      'INSERT INTO TARIFF_OPTION_NEW_COST'
      
        '  (TARIFF_OPTION_COST_ID, TARIFF_ID, TURN_ON_COST, MONTHLY_COST,' +
        ' TURN_ON_COST_FOR_BILLS, MONTHLY_COST_FOR_BILLS)'
      'VALUES'
      
        '  (:TARIFF_OPTION_COST_ID, :TARIFF_ID, :TURN_ON_COST, :MONTHLY_C' +
        'OST, :TURN_ON_COST_FOR_BILLS, :MONTHLY_COST_FOR_BILLS);'
      'end if;'
      'end;')
    SQLRefresh.Strings = (
      'select '
      '--'#1086#1087#1094#1080#1080
      'tro.tariff_option_id,'
      'tro.option_code,'
      'tro.option_name,'
      'tro.koef_komiss koef_komiss_o,'
      
        'decode(tro.calc_unblock ,'#39'1'#39','#39#1053#1077' '#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080' '#1089#1087#1080#1089#1072#1085#1080#1080#39','#39#1053#1077' '#1074 +
        #1083#1080#1103#1077#1090' '#1085#1072' '#1073#1083#1086#1082#39')calc_unblock_o,'
      
        'decode (tro.discr_spisanie,'#39'1'#39','#39#1044#1080#1089#1082#1088#1077#1090#1085#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077#39','#39#1055#1077#1088#1080#1086#1076#1080#1095#1077#1089 +
        #1082#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077#39')discr_spisanie,'
      'tro.option_name_for_ab,'
      '--'#1094#1077#1085#1099
      'toc.tariff_option_cost_id,'
      'toc.begin_date,'
      'toc.end_date,'
      'toc.turn_on_cost turn_on_cost_o,'
      'toc.monthly_cost monthly_cost_o,'
      'toc.operator_turn_on_cost,'
      'toc.operator_monthly_cost,'
      '--'#1048#1085#1076#1080#1074#1080#1076#1091#1083#1100#1085#1099#1077' '#1087#1086' '#1090#1072#1088#1080#1092#1072#1084
      'tonc.tariff_option_new_cost_id,'
      'tonc.tariff_id,'
      'tonc.tariff_option_cost_id trf_otp_cost_id,'
      'tonc.turn_on_cost,'
      'tonc.monthly_cost,'
      'tonc.turn_on_cost_for_bills,'
      'tonc.monthly_cost_for_bills'
      ''
      '         from tariff_options tro,'
      '              tariff_option_costs toc,'
      '              tariff_option_new_cost tonc'
      'where tro.tariff_option_id=toc.tariff_option_id'
      'and toc.tariff_option_cost_id=tonc.tariff_option_cost_id(+)'
      '--'
      'and (tonc.tariff_id=:STariffID or tonc.tariff_id is null)'
      '--and toc.tariff_option_cost_id=286'
      ''
      'order by tonc.tariff_option_new_cost_id asc')
    DataTypeMap = <>
    SQL.Strings = (
      'select '
      '--'#1086#1087#1094#1080#1080
      'tro.tariff_option_id,'
      'tro.option_code,'
      'tro.option_name,'
      'tro.koef_komiss koef_komiss_o,'
      
        'decode(tro.calc_unblock ,'#39'1'#39','#39#1053#1077' '#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080' '#1089#1087#1080#1089#1072#1085#1080#1080#39','#39#1053#1077' '#1074 +
        #1083#1080#1103#1077#1090' '#1085#1072' '#1073#1083#1086#1082#39')calc_unblock_o,'
      
        'decode (tro.discr_spisanie,'#39'1'#39','#39#1044#1080#1089#1082#1088#1077#1090#1085#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077#39','#39#1055#1077#1088#1080#1086#1076#1080#1095#1077#1089 +
        #1082#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077#39')discr_spisanie,'
      'tro.option_name_for_ab,'
      '--'#1094#1077#1085#1099
      'toc.tariff_option_cost_id,'
      'toc.begin_date,'
      'toc.end_date,'
      'toc.turn_on_cost turn_on_cost_o,'
      'toc.monthly_cost monthly_cost_o,'
      'toc.operator_turn_on_cost,'
      'toc.operator_monthly_cost,'
      '--'#1048#1085#1076#1080#1074#1080#1076#1091#1083#1100#1085#1099#1077' '#1087#1086' '#1090#1072#1088#1080#1092#1072#1084
      'tonc.tariff_option_new_cost_id,'
      'tonc.tariff_id,'
      'tonc.tariff_option_cost_id trf_otp_cost_id,'
      'tonc.turn_on_cost,'
      'tonc.monthly_cost,'
      'tonc.turn_on_cost_for_bills,'
      'tonc.monthly_cost_for_bills'
      ''
      '         from tariff_options tro,'
      '              tariff_option_costs toc,'
      '              tariff_option_new_cost tonc'
      'where tro.tariff_option_id=toc.tariff_option_id'
      'and toc.tariff_option_cost_id=tonc.tariff_option_cost_id(+)'
      '--'
      'and (tonc.tariff_id=:STariffID or tonc.tariff_id is null)'
      '--and toc.tariff_option_cost_id=286'
      ''
      'order by tonc.tariff_option_new_cost_id asc')
    AutoCommit = False
    OnUpdateRecord = qOptionsUpdateRecord
    BeforePost = qOptionsBeforePost
    Left = 536
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'STariffID'
        Value = ''
      end>
    object TARIFF_OPTION_ID: TFloatField
      FieldName = 'TARIFF_OPTION_ID'
      Required = True
    end
    object OPTION_CODE: TStringField
      FieldName = 'OPTION_CODE'
      Required = True
      Size = 120
    end
    object OPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Required = True
      Size = 400
    end
    object KOEF_KOMISS_O: TFloatField
      FieldName = 'KOEF_KOMISS_O'
    end
    object CALC_UNBLOCK_O: TStringField
      FieldName = 'CALC_UNBLOCK_O'
      Size = 51
    end
    object DISCR_SPISANIE: TStringField
      FieldName = 'DISCR_SPISANIE'
      Size = 43
    end
    object OPTION_NAME_FOR_AB: TStringField
      FieldName = 'OPTION_NAME_FOR_AB'
      Size = 400
    end
    object qOptionsBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
    end
    object qOptionsEND_DATE: TDateTimeField
      FieldName = 'END_DATE'
    end
    object TURN_ON_COST_O: TFloatField
      FieldName = 'TURN_ON_COST_o'
    end
    object MONTHLY_COST_O: TFloatField
      FieldName = 'MONTHLY_COST_o'
    end
    object OPERATOR_TURN_ON_COST: TFloatField
      FieldName = 'OPERATOR_TURN_ON_COST'
    end
    object OPERATOR_MONTHLY_COST: TFloatField
      FieldName = 'OPERATOR_MONTHLY_COST'
    end
    object TURN_ON_COST: TFloatField
      FieldName = 'TURN_ON_COST'
    end
    object MONTHLY_COST: TFloatField
      FieldName = 'MONTHLY_COST'
    end
    object TURN_ON_COST_FOR_BILLS: TFloatField
      FieldName = 'TURN_ON_COST_FOR_BILLS'
    end
    object MONTHLY_COST_FOR_BILLS: TFloatField
      FieldName = 'MONTHLY_COST_FOR_BILLS'
    end
    object TRF_OTP_COST_ID: TFloatField
      FieldName = 'TRF_OTP_COST_ID'
    end
    object TARIFF_OPTION_COST_ID: TFloatField
      FieldName = 'TARIFF_OPTION_COST_ID'
    end
    object TARIFF_OPTION_NEW_COST_ID: TFloatField
      FieldName = 'TARIFF_OPTION_NEW_COST_ID'
    end
    object TCN_TARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
    end
  end
  object dsTariff_opt: TDataSource
    DataSet = qOptions
    Left = 552
    Top = 264
  end
  object qTarrifs: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select t.*,rowid from tariffs t where t.tariff_id=:STariffID')
    Left = 472
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'STariffID'
        Value = ''
      end>
    object qTarrifsTARIFF_CODE: TStringField
      FieldName = 'TARIFF_CODE'
      Size = 120
    end
    object qTarrifsTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qTarrifsIS_ACTIVE: TIntegerField
      FieldName = 'IS_ACTIVE'
    end
    object qTarrifsSTART_BALANCE: TFloatField
      FieldName = 'START_BALANCE'
    end
    object qTarrifsCONNECT_PRICE: TFloatField
      FieldName = 'CONNECT_PRICE'
    end
    object qTarrifsADVANCE_PAYMENT: TFloatField
      FieldName = 'ADVANCE_PAYMENT'
    end
    object qTarrifsPHONE_NUMBER_TYPE: TIntegerField
      FieldName = 'PHONE_NUMBER_TYPE'
      Required = True
    end
    object qTarrifsDAYLY_PAYMENT: TFloatField
      FieldName = 'DAYLY_PAYMENT'
    end
    object qTarrifsDAYLY_PAYMENT_LOCKED: TFloatField
      FieldName = 'DAYLY_PAYMENT_LOCKED'
    end
    object qTarrifsMONTHLY_PAYMENT: TFloatField
      FieldName = 'MONTHLY_PAYMENT'
    end
    object qTarrifsMONTHLY_PAYMENT_LOCKED: TFloatField
      FieldName = 'MONTHLY_PAYMENT_LOCKED'
    end
    object qTarrifsCALC_KOEFF: TFloatField
      FieldName = 'CALC_KOEFF'
    end
    object qTarrifsFREE_MONTH_MINUTES_CNT_FOR_RPT: TIntegerField
      FieldName = 'FREE_MONTH_MINUTES_CNT_FOR_RPT'
    end
    object qTarrifsBALANCE_BLOCK: TFloatField
      FieldName = 'BALANCE_BLOCK'
    end
    object qTarrifsBALANCE_UNBLOCK: TFloatField
      FieldName = 'BALANCE_UNBLOCK'
    end
    object qTarrifsBALANCE_NOTICE: TFloatField
      FieldName = 'BALANCE_NOTICE'
    end
    object qTarrifsTARIFF_ADD_COST: TFloatField
      FieldName = 'TARIFF_ADD_COST'
    end
    object qTarrifsBALANCE_BLOCK_CREDIT: TFloatField
      FieldName = 'BALANCE_BLOCK_CREDIT'
    end
    object qTarrifsBALANCE_UNBLOCK_CREDIT: TFloatField
      FieldName = 'BALANCE_UNBLOCK_CREDIT'
    end
    object qTarrifsBALANCE_NOTICE_CREDIT: TFloatField
      FieldName = 'BALANCE_NOTICE_CREDIT'
    end
    object qTarrifsTARIFF_CODE_CRM: TStringField
      FieldName = 'TARIFF_CODE_CRM'
      Size = 200
    end
    object qTarrifsTARIFF_PRIORITY: TFloatField
      FieldName = 'TARIFF_PRIORITY'
    end
    object qTarrifsTARIFF_ABON_DAILY_PAY: TFloatField
      FieldName = 'TARIFF_ABON_DAILY_PAY'
    end
    object qTarrifsTARIFF_ACTION_PLUS_SMS: TFloatField
      FieldName = 'TARIFF_ACTION_PLUS_SMS'
    end
    object qTarrifsOPERATOR_MONTHLY_ABON_BLOCK: TFloatField
      FieldName = 'OPERATOR_MONTHLY_ABON_BLOCK'
    end
    object qTarrifsCALC_KOEFF_DETAL: TFloatField
      FieldName = 'CALC_KOEFF_DETAL'
    end
    object fldTarrifsOPERATOR_MONTHLY_ABON_ACTIV: TFloatField
      FieldName = 'OPERATOR_MONTHLY_ABON_ACTIV'
    end
    object TARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
      Required = True
    end
  end
  object dsTariffs: TDataSource
    DataSet = qTarrifs
    Left = 488
    Top = 264
  end
end
