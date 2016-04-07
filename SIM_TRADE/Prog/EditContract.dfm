object EditContractForm: TEditContractForm
  Left = 174
  Top = 217
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1076#1086#1075#1086#1074#1086#1088#1072
  ClientHeight = 736
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 708
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 9
      Width = 86
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1044#1086#1075#1086#1074#1086#1088' '#8470' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 266
      Top = 9
      Width = 18
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 422
      Top = 9
      Width = 62
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1060#1080#1083#1080#1072#1083':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CONTRACT_NUM: TDBEdit
      Left = 108
      Top = 4
      Width = 139
      Height = 26
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'CONTRACT_NUM'
      DataSource = dsContracts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = CONTRACT_NUMChange
    end
    object CONTRACT_DATE: TDateTimePicker
      Left = 295
      Top = 4
      Width = 120
      Height = 26
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Date = 40488.649711909730000000
      Time = 40488.649711909730000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
    end
    object FILIAL_ID: TDBLookupComboBox
      Left = 492
      Top = 4
      Width = 208
      Height = 26
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'FILIAL_ID'
      DataSource = dsContracts
      DropDownRows = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      KeyField = 'FILIAL_ID'
      ListField = 'FILIAL_NAME'
      ListSource = dsFilials
      ParentFont = False
      TabOrder = 2
      TabStop = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 695
    Width = 708
    Height = 41
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object btnOK: TBitBtn
      Left = 443
      Top = 5
      Width = 119
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnEnter = WinControlEnter
      OnExit = WinControlExit
    end
    object btnCancel: TBitBtn
      Left = 581
      Top = 5
      Width = 109
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      Kind = bkCancel
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 34
    Width = 708
    Height = 661
    Align = alClient
    Caption = 'Panel4'
    TabOrder = 2
    object Panel5: TPanel
      Left = 1
      Top = 552
      Width = 706
      Height = 108
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        706
        108)
      object Bevel2: TBevel
        Left = 4
        Top = 5
        Width = 698
        Height = 2
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        ExplicitWidth = 700
      end
      object Label16: TLabel
        Left = 10
        Top = 17
        Width = 103
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1047#1086#1083#1086#1090#1086#1081' '#1085#1086#1084#1077#1088':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 12
        Top = -2
        Width = 92
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = ' '#1057#1090#1086#1080#1084#1086#1089#1090#1100': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 10
        Top = 63
        Width = 125
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1073#1072#1083#1072#1085#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object START_BALANCE: TDBText
        Left = 167
        Top = 63
        Width = 139
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        DataField = 'START_BALANCE'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 10
        Top = 43
        Width = 94
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object CONNECT_PRICE: TDBText
        Left = 167
        Top = 43
        Width = 139
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        DataField = 'CONNECT_PRICE'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 10
        Top = 82
        Width = 127
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1040#1074#1072#1085#1089#1086#1074#1099#1081' '#1087#1083#1072#1090#1077#1078':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ADVANCE_PAYMENT: TDBText
        Left = 158
        Top = 82
        Width = 148
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        DataField = 'ADVANCE_PAYMENT'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 388
        Top = 40
        Width = 125
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1042#1079#1085#1086#1089' '#1072#1073#1086#1085#1077#1085#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lRealBalance: TLabel
        Left = 522
        Top = 63
        Width = 127
        Height = 19
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        AutoSize = False
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 386
        Top = 13
        Width = 126
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1051#1080#1084#1080#1090' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 397
        Top = 64
        Width = 117
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taRightJustify
        Caption = #1041#1072#1083#1072#1085#1089' '#1072#1073#1086#1085#1077#1085#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DISCONNECT_LIMIT: TDBEdit
        Left = 520
        Top = 10
        Width = 129
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'DISCONNECT_LIMIT'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = DISCONNECT_LIMITChange
      end
      object RECEIVED_SUM: TDBEdit
        Left = 521
        Top = 33
        Width = 129
        Height = 33
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'RECEIVED_SUM'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnChange = RECEIVED_SUMChange
      end
      object GOLD_NUMBER_SUM: TDBEdit
        Left = 167
        Top = 10
        Width = 137
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        DataField = 'GOLD_NUMBER_SUM'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
      end
      object cbDailyAbonPay: TCheckBox
        Left = 386
        Top = 85
        Width = 299
        Height = 17
        Caption = #1055#1086#1089#1091#1090#1086#1095#1085#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077' '#1072#1073#1086#1085' '#1087#1083#1072#1090#1099'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
    end
    object pPhoneInfo: TPanel
      Left = 1
      Top = 430
      Width = 706
      Height = 122
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        706
        122)
      object Label4: TLabel
        Left = 10
        Top = 9
        Width = 125
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088' '#1089#1074#1103#1079#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 10
        Top = 36
        Width = 80
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1042#1080#1076' '#1085#1086#1084#1077#1088#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 314
        Top = 33
        Width = 153
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
        FocusControl = PHONE_NUMBER_FEDERAL
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 315
        Top = 9
        Width = 54
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1058#1072#1088#1080#1092':'
        FocusControl = cbTariffNameold
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 10
        Top = 63
        Width = 118
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1053#1086#1084#1077#1088' SIM - '#1082#1072#1088#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 354
        Top = 63
        Width = 113
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1043#1086#1088#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
        FocusControl = PHONE_NUMBER_CITY
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lTariffCodeCaption: TLabel
        Left = 580
        Top = 63
        Width = 27
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1050#1086#1076':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lTariffCode: TLabel
        Left = 610
        Top = 63
        Width = 77
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lClientTariffOption: TLabel
        Left = 10
        Top = 90
        Width = 127
        Height = 16
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1040#1073#1086#1085'. '#1090#1072#1088#1080#1092'. '#1086#1087#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object OPERATOR_ID: TDBLookupComboBox
        Left = 138
        Top = 4
        Width = 168
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'OPERATOR_ID'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        KeyField = 'OPERATOR_ID'
        ListField = 'OPERATOR_NAME'
        ListSource = dsOperators
        ParentFont = False
        TabOrder = 0
        OnClick = OPERATOR_IDClick
      end
      object PHONE_NUMBER_TYPE: TDBLookupComboBox
        Left = 138
        Top = 31
        Width = 168
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'PHONE_NUMBER_TYPE'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        KeyField = 'PHONE_TYPE'
        ListField = 'PHINE_TYPE_NAME'
        ListSource = dsPhoneTypes
        ParentFont = False
        TabOrder = 1
        OnClick = PHONE_NUMBER_TYPEClick
      end
      object PHONE_NUMBER_FEDERAL: TDBEdit
        Left = 475
        Top = 33
        Width = 188
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        DataField = 'PHONE_NUMBER_FEDERAL'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 6
        OnChange = PHONE_NUMBER_FEDERALChange
      end
      object TARIFF_ID_: TDBLookupComboBox
        Left = 375
        Top = -1
        Width = 315
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'TARIFF_ID'
        DataSource = dsContracts
        DropDownRows = 25
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        KeyField = 'TARIFF_ID'
        ListField = 'TARIFF_NAME'
        ListSource = dsTariffs
        NullValueKey = 16462
        ParentFont = False
        TabOrder = 3
        Visible = False
      end
      object SIM_NUMBER: TDBEdit
        Left = 138
        Top = 58
        Width = 189
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        DataField = 'SIM_NUMBER'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object PHONE_NUMBER_CITY: TDBEdit
        Left = 475
        Top = 60
        Width = 96
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        DataField = 'PHONE_NUMBER_CITY'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 7
      end
      object cbTariffNameold: TComboBox
        Left = 673
        Top = 33
        Width = 27
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        DoubleBuffered = False
        DropDownCount = 25
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Visible = False
        OnChange = cbTariffNameoldChange
      end
      object cbTariffName: TComboBox
        Left = 375
        Top = 4
        Width = 310
        Height = 24
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 25
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnChange = cbTariffNameoldChange
      end
      object ABONENT_TARIFF_OPTION: TDBEdit
        Left = 138
        Top = 85
        Width = 550
        Height = 26
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        DataField = 'ABONENT_TARIFF_OPTION'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnChange = ABONENT_TARIFF_OPTIONChange
      end
    end
    object pcAbonent: TTabControl
      Left = 1
      Top = 1
      Width = 706
      Height = 429
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Style = tsButtons
      TabOrder = 2
      Tabs.Strings = (
        '&1. '#1053#1086#1074#1099#1081' '#1072#1073#1086#1085#1077#1085#1090
        '&2. '#1057#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1081' '#1072#1073#1086#1085#1077#1085#1090)
      TabIndex = 0
      OnChanging = pcAbonentChanging
      object tsNewAbonent: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1053#1086#1074#1099#1081' '#1072#1073#1086#1085#1077#1085#1090
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
      object tsEditAbonent: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'tsEditAbonent'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 698
          Height = 42
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            Left = 0
            Top = 0
            Width = 238
            Height = 41
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1053#1072#1081#1090#1080' '#1072#1073#1086#1085#1077#1085#1090#1072
          end
        end
      end
      inline EditAbonent: TEditAbonentFrme
        Left = 4
        Top = 32
        Width = 698
        Height = 387
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        TabOrder = 2
        ExplicitLeft = 4
        ExplicitTop = 32
        ExplicitWidth = 698
        ExplicitHeight = 387
        inherited Panel1: TPanel
          Width = 698
          Height = 160
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitWidth = 698
          ExplicitHeight = 160
          DesignSize = (
            698
            160)
          inherited Label1: TLabel
            Left = 11
            Top = 10
            Width = 71
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 10
            ExplicitWidth = 71
            ExplicitHeight = 16
          end
          inherited Label2: TLabel
            Left = 11
            Top = 37
            Width = 34
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 37
            ExplicitWidth = 34
            ExplicitHeight = 16
          end
          inherited Label3: TLabel
            Left = 11
            Top = 63
            Width = 76
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 63
            ExplicitWidth = 76
            ExplicitHeight = 16
          end
          inherited Label4: TLabel
            Left = 320
            Top = 10
            Width = 78
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 322
            ExplicitTop = 10
            ExplicitWidth = 78
            ExplicitHeight = 16
          end
          inherited Label20: TLabel
            Left = 322
            Top = 37
            Width = 89
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 322
            ExplicitTop = 37
            ExplicitWidth = 89
            ExplicitHeight = 16
          end
          inherited Label22: TLabel
            Left = 12
            Top = 102
            Width = 105
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 12
            ExplicitTop = 102
            ExplicitWidth = 105
            ExplicitHeight = 16
          end
          inherited SURNAME: TDBEdit
            Left = 118
            Top = 5
            Width = 186
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 5
            ExplicitWidth = 186
            ExplicitHeight = 26
          end
          inherited NAME: TDBEdit
            Left = 118
            Top = 32
            Width = 186
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 32
            ExplicitWidth = 186
            ExplicitHeight = 26
          end
          inherited PATRONYMIC: TDBEdit
            Left = 118
            Top = 58
            Width = 186
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 58
            ExplicitWidth = 186
            ExplicitHeight = 26
          end
          inherited BDATE: TDBEdit
            Left = 416
            Top = 5
            Width = 144
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 416
            ExplicitTop = 5
            ExplicitWidth = 144
            ExplicitHeight = 26
          end
          inherited CITIZENSHIP: TDBLookupComboBox
            Left = 418
            Top = 32
            Width = 211
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 418
            ExplicitTop = 32
            ExplicitWidth = 211
            ExplicitHeight = 26
          end
          inherited IS_VIP: TCheckBox
            Left = 320
            Top = 62
            Width = 104
            Height = 21
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'VIP '#1082#1083#1080#1077#1085#1090'     '
            Font.Height = -15
            ExplicitLeft = 320
            ExplicitTop = 62
            ExplicitWidth = 104
            ExplicitHeight = 21
          end
          inherited ToolBar1: TToolBar
            Left = 454
            Top = 60
            Width = 175
            Height = 32
            ButtonWidth = 175
            ExplicitLeft = 454
            ExplicitTop = 60
            ExplicitWidth = 175
            ExplicitHeight = 32
            inherited ToolButton1: TToolButton
              ExplicitWidth = 175
            end
          end
          inherited DESCRIPTION: TDBMemo
            Left = 118
            Top = 101
            Width = 475
            Height = 57
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ExplicitLeft = 118
            ExplicitTop = 101
            ExplicitWidth = 475
            ExplicitHeight = 57
          end
        end
        inherited pPassport: TPanel
          Top = 160
          Width = 698
          Height = 73
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitTop = 160
          ExplicitWidth = 698
          ExplicitHeight = 73
          DesignSize = (
            698
            73)
          inherited Label6: TLabel
            Left = 11
            Top = 21
            Width = 43
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 21
            ExplicitWidth = 43
            ExplicitHeight = 16
          end
          inherited Label8: TLabel
            Left = 316
            Top = 48
            Width = 72
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 316
            ExplicitTop = 48
            ExplicitWidth = 72
            ExplicitHeight = 16
          end
          inherited Label7: TLabel
            Left = 11
            Top = 48
            Width = 85
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 48
            ExplicitWidth = 85
            ExplicitHeight = 16
          end
          inherited Label18: TLabel
            Left = 316
            Top = 21
            Width = 46
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 316
            ExplicitTop = 21
            ExplicitWidth = 46
            ExplicitHeight = 16
          end
          inherited Bevel1: TBevel
            Left = 4
            Top = 5
            Width = 715
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ExplicitLeft = 4
            ExplicitTop = 5
            ExplicitWidth = 717
          end
          inherited Label5: TLabel
            Left = 12
            Width = 159
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 12
            ExplicitWidth = 159
            ExplicitHeight = 16
          end
          inherited PASSPORT_SER: TDBEdit
            Left = 118
            Top = 16
            Width = 185
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 16
            ExplicitWidth = 185
            ExplicitHeight = 26
          end
          inherited PASSPORT_GET: TDBEdit
            Left = 404
            Top = 43
            Width = 277
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 404
            ExplicitTop = 43
            ExplicitWidth = 277
            ExplicitHeight = 26
          end
          inherited PASSPORT_NUM: TDBEdit
            Left = 404
            Top = 16
            Width = 277
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 404
            ExplicitTop = 16
            ExplicitWidth = 277
            ExplicitHeight = 26
          end
          inherited PASSPORT_DATE: TDBEdit
            Left = 118
            Top = 43
            Width = 100
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 43
            ExplicitWidth = 100
            ExplicitHeight = 26
          end
        end
        inherited GroupBox2: TPanel
          Top = 233
          Width = 698
          Height = 92
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitTop = 233
          ExplicitWidth = 698
          ExplicitHeight = 92
          DesignSize = (
            698
            92)
          inherited Label9: TLabel
            Left = 11
            Top = 20
            Width = 51
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 20
            ExplicitWidth = 51
            ExplicitHeight = 16
          end
          inherited Label10: TLabel
            Left = 316
            Top = 17
            Width = 50
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 316
            ExplicitTop = 17
            ExplicitWidth = 50
            ExplicitHeight = 16
          end
          inherited Label11: TLabel
            Left = 11
            Top = 46
            Width = 42
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 46
            ExplicitWidth = 42
            ExplicitHeight = 16
          end
          inherited Label12: TLabel
            Left = 316
            Top = 46
            Width = 44
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 316
            ExplicitTop = 46
            ExplicitWidth = 44
            ExplicitHeight = 16
          end
          inherited Label13: TLabel
            Left = 11
            Top = 71
            Width = 29
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 71
            ExplicitWidth = 29
            ExplicitHeight = 16
          end
          inherited Label14: TLabel
            Left = 188
            Top = 71
            Width = 53
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 188
            ExplicitTop = 71
            ExplicitWidth = 53
            ExplicitHeight = 16
          end
          inherited Label15: TLabel
            Left = 316
            Top = 71
            Width = 66
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 316
            ExplicitTop = 71
            ExplicitWidth = 66
            ExplicitHeight = 16
          end
          inherited Bevel2: TBevel
            Left = 4
            Top = 5
            Width = 715
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ExplicitLeft = 4
            ExplicitTop = 5
            ExplicitWidth = 717
          end
          inherited Label19: TLabel
            Left = 12
            Width = 81
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 12
            ExplicitWidth = 81
            ExplicitHeight = 16
          end
          inherited COUNTRY_ID: TDBLookupComboBox
            Left = 118
            Top = 15
            Width = 185
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 15
            ExplicitWidth = 185
            ExplicitHeight = 26
          end
          inherited REGION_ID: TDBLookupComboBox
            Left = 404
            Top = 15
            Width = 277
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 404
            ExplicitTop = 15
            ExplicitWidth = 277
            ExplicitHeight = 26
          end
          inherited CITY_NAME: TDBEdit
            Left = 118
            Top = 41
            Width = 185
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 41
            ExplicitWidth = 185
            ExplicitHeight = 26
          end
          inherited STREET_NAME: TDBEdit
            Left = 404
            Top = 41
            Width = 277
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 404
            ExplicitTop = 41
            ExplicitWidth = 277
            ExplicitHeight = 26
          end
          inherited HOUSE: TDBEdit
            Left = 118
            Top = 66
            Width = 68
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 118
            ExplicitTop = 66
            ExplicitWidth = 68
            ExplicitHeight = 26
          end
          inherited KORPUS: TDBEdit
            Left = 246
            Top = 66
            Width = 57
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 246
            ExplicitTop = 66
            ExplicitWidth = 57
            ExplicitHeight = 26
          end
          inherited APARTMENT: TDBEdit
            Left = 404
            Top = 66
            Width = 158
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 404
            ExplicitTop = 66
            ExplicitWidth = 158
            ExplicitHeight = 26
          end
        end
        inherited GroupBox3: TPanel
          Top = 325
          Width = 698
          Height = 61
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitTop = 325
          ExplicitWidth = 698
          ExplicitHeight = 61
          DesignSize = (
            698
            61)
          inherited Label16: TLabel
            Left = 11
            Top = 15
            Width = 165
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 15
            ExplicitWidth = 165
            ExplicitHeight = 16
          end
          inherited Label17: TLabel
            Left = 11
            Top = 41
            Width = 101
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 11
            ExplicitTop = 41
            ExplicitWidth = 101
            ExplicitHeight = 16
          end
          inherited Bevel3: TBevel
            Left = 4
            Top = 5
            Width = 715
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ExplicitLeft = 4
            ExplicitTop = 5
            ExplicitWidth = 717
          end
          inherited Label21: TLabel
            Left = 454
            Top = 41
            Width = 41
            Height = 16
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 454
            ExplicitTop = 41
            ExplicitWidth = 41
            ExplicitHeight = 16
          end
          inherited CONTACT_INFO: TDBEdit
            Left = 177
            Top = 10
            Width = 504
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 177
            ExplicitTop = 10
            ExplicitWidth = 504
            ExplicitHeight = 26
          end
          inherited CODE_WORD: TDBEdit
            Left = 177
            Top = 36
            Width = 238
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 177
            ExplicitTop = 36
            ExplicitWidth = 238
            ExplicitHeight = 26
          end
          inherited EMAIL: TDBEdit
            Left = 505
            Top = 36
            Width = 176
            Height = 26
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Font.Height = -15
            ExplicitLeft = 505
            ExplicitTop = 36
            ExplicitWidth = 176
            ExplicitHeight = 26
          end
        end
        inherited qGetNewId: TOraStoredProc
          CommandStoredProcName = 'NEW_ABONENT_ID:0'
        end
        inherited qRegions: TOraQuery
          SQL.Strings = (
            
              'SELECT R.REGION_ID, R.REGION_NAME || '#39' ('#39' || C.COUNTRY_NAME || '#39 +
              ')'#39','
            '  R.COUNTRY_ID'
            'FROM REGIONS R, COUNTRIES C'
            'WHERE R.COUNTRY_ID = C.COUNTRY_ID(+)'
            'ORDER BY NVL(C.IS_DEFAULT, 0) DESC, C.COUNTRY_NAME,'
            '  R.ORDER_NUMBER NULLS LAST, R.REGION_NAME')
        end
      end
      object rgTypePaid: TRadioGroup
        Left = 446
        Top = -12
        Width = 244
        Height = 43
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #1040#1074#1072#1085#1089#1086#1074#1099#1081
          #1050#1088#1077#1076#1080#1090#1085#1099#1081)
        TabOrder = 3
      end
    end
  end
  object qContracts: TOraQuery
    SQL.Strings = (
      'SELECT C.*       '
      '      ,T.START_BALANCE TARIFF_START_BALANCE'
      '      ,T.CONNECT_PRICE'
      '      ,T.ADVANCE_PAYMENT'
      '  FROM CONTRACTS C'
      '      ,TARIFFS T'
      ' WHERE C.TARIFF_ID = T.TARIFF_ID (+)'
      '   AND C.CONTRACT_ID = :CONTRACT_ID')
    AfterOpen = qContractsAfterOpen
    AfterInsert = qContractsAfterInsert
    Left = 80
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qFilials: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM FILIALS'
      'ORDER BY FILIAL_NAME')
    Left = 120
    Top = 368
  end
  object qOperators: TOraQuery
    SQL.Strings = (
      'SELECT OPERATOR_ID, OPERATOR_NAME'
      'FROM OPERATORS'
      'ORDER BY ORDER_NUMBER, OPERATOR_NAME')
    Left = 160
    Top = 368
  end
  object qPhoneTypes: TOraQuery
    SQL.Strings = (
      'SELECT 0 PHONE_TYPE, '#39#1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081#39' PHINE_TYPE_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 1 PHONE_TYPE, '#39#1043#1086#1088#1086#1076#1089#1082#1086#1081#39' PHINE_TYPE_NAME FROM DUAL')
    Left = 200
    Top = 368
  end
  object qTariffs: TOraQuery
    SQL.Strings = (
      'SELECT * '
      'FROM TARIFFS'
      'ORDER BY TARIFF_NAME')
    FetchAll = True
    Left = 240
    Top = 368
  end
  object dsContracts: TDataSource
    DataSet = qContracts
    OnDataChange = dsContractsDataChange
    Left = 80
    Top = 400
  end
  object dsFilials: TDataSource
    DataSet = qFilials
    Left = 120
    Top = 400
  end
  object dsOperators: TDataSource
    DataSet = qOperators
    OnDataChange = dsOperatorsDataChange
    Left = 160
    Top = 399
  end
  object dsPhoneTypes: TDataSource
    DataSet = qPhoneTypes
    Left = 200
    Top = 400
  end
  object dsTariffs: TDataSource
    DataSet = qTariffs
    OnDataChange = dsTariffsDataChange
    Left = 240
    Top = 400
  end
  object qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_CONTRACT_ID'
    Left = 40
    Top = 369
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_CONTRACT_ID:0'
  end
  object tCheckContractNum: TTimer
    Enabled = False
    Interval = 300
    OnTimer = tCheckContractNumTimer
    Left = 112
    Top = 20
  end
  object qNumDouble: TOraQuery
    SQL.Strings = (
      'SELECT COUNT(*) CNT'
      'FROM CONTRACTS C'
      'WHERE C.CONTRACT_NUM = :CONTRACT_NUM'
      
        '  AND ((:CONTRACT_ID IS NULL) OR (C.CONTRACT_ID <> :CONTRACT_ID)' +
        ')')
    Left = 152
    Top = 20
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_NUM'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qNextNum: TOraStoredProc
    StoredProcName = 'GET_NEXT_VALUE'
    Left = 200
    Top = 20
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PVALUE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'GET_NEXT_VALUE:0'
  end
  object qSaveContractPayment: TOraStoredProc
    StoredProcName = 'SAVE_CONTRACT_PAYMENT'
    Left = 272
    Top = 452
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PPAYMENT_SUM'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SAVE_CONTRACT_PAYMENT:0'
  end
  object DoublePhoneNum: TOraQuery
    SQL.Strings = (
      'Select  1 FROM v_contracts'
      '      WHERE  CONTRACT_CANCEL_DATE is null  '
      
        '      and (PHONE_NUMBER_FEDERAL=:phoneNumber  or  PHONE_NUMBER_C' +
        'ITY=:phoneNumber) '
      '      and contract_num <> :contract_new_num')
    Left = 528
    Top = 305
    ParamData = <
      item
        DataType = ftString
        Name = 'phoneNumber'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'contract_new_num'
        ParamType = ptInput
      end>
  end
  object qExistPhoneNum: TOraQuery
    SQL.Strings = (
      'Select CONTRACT_ID  FROM CONTRACTS'
      'WHERE '
      '(CONTRACTS.PHONE_NUMBER_FEDERAL=:phoneNumber'
      'OR CONTRACTS.PHONE_NUMBER_CITY=:phoneNumber)')
    Left = 488
    Top = 313
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phoneNumber'
      end>
  end
  object qPhoneTariff: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CELL_PLAN_CODE FROM DB_LOADER_ACCOUNT_PHONES'
      'WHERE PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY YEAR_MONTH DESC')
    Left = 280
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object spSendNotice: TOraStoredProc
    StoredProcName = 'SEND_NOTICE_ON_NEW_CONTRACT'
    Session = MainForm.OraSession
    Left = 96
    Top = 496
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SEND_NOTICE_ON_NEW_CONTRACT'
  end
  object spDailyPay: TOraStoredProc
    StoredProcName = 'CHECK_PHONE_DAILY_ABON_PAY'
    Session = MainForm.OraSession
    Left = 408
    Top = 664
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PACTION_TYPE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'CHECK_PHONE_DAILY_ABON_PAY'
  end
end
