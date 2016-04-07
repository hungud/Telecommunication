object EditContractForm: TEditContractForm
  Left = 174
  Top = 217
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1076#1086#1075#1086#1074#1086#1088#1072
  ClientHeight = 609
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 28
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 72
      Height = 13
      Caption = #1044#1086#1075#1086#1074#1086#1088' '#8470' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 216
      Top = 7
      Width = 14
      Height = 13
      Caption = #1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 343
      Top = 7
      Width = 52
      Height = 13
      Caption = #1060#1080#1083#1080#1072#1083':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CONTRACT_NUM: TDBEdit
      Left = 88
      Top = 3
      Width = 113
      Height = 22
      DataField = 'CONTRACT_NUM'
      DataSource = dsContracts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = CONTRACT_NUMChange
    end
    object CONTRACT_DATE: TDateTimePicker
      Left = 240
      Top = 3
      Width = 97
      Height = 22
      Date = 40488.649711909730000000
      Time = 40488.649711909730000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
    end
    object FILIAL_ID: TDBLookupComboBox
      Left = 400
      Top = 3
      Width = 169
      Height = 22
      DataField = 'FILIAL_ID'
      DataSource = dsContracts
      DropDownRows = 35
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
    Top = 576
    Width = 575
    Height = 33
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitTop = 565
    object btnOK: TBitBtn
      Left = 360
      Top = 4
      Width = 97
      Height = 25
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      Left = 472
      Top = 4
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
    Top = 28
    Width = 575
    Height = 548
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    Caption = 'Panel4'
    TabOrder = 2
    ExplicitHeight = 537
    object Panel5: TPanel
      Left = 1
      Top = 460
      Width = 573
      Height = 87
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 449
      DesignSize = (
        573
        87)
      object Bevel2: TBevel
        Left = 3
        Top = 4
        Width = 567
        Height = 2
        Anchors = [akLeft, akTop, akRight]
      end
      object Label16: TLabel
        Left = 8
        Top = 14
        Width = 80
        Height = 13
        Caption = #1047#1086#1083#1086#1090#1086#1081' '#1085#1086#1084#1077#1088':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 10
        Top = -2
        Width = 77
        Height = 13
        Caption = ' '#1057#1090#1086#1080#1084#1086#1089#1090#1100': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 8
        Top = 51
        Width = 97
        Height = 13
        Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1073#1072#1083#1072#1085#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object START_BALANCE: TDBText
        Left = 136
        Top = 51
        Width = 113
        Height = 17
        Alignment = taRightJustify
        DataField = 'START_BALANCE'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 8
        Top = 35
        Width = 72
        Height = 13
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object CONNECT_PRICE: TDBText
        Left = 136
        Top = 35
        Width = 113
        Height = 17
        Alignment = taRightJustify
        DataField = 'CONNECT_PRICE'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 8
        Top = 67
        Width = 100
        Height = 13
        Caption = #1040#1074#1072#1085#1089#1086#1074#1099#1081' '#1087#1083#1072#1090#1077#1078':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ADVANCE_PAYMENT: TDBText
        Left = 128
        Top = 67
        Width = 121
        Height = 17
        Alignment = taRightJustify
        DataField = 'ADVANCE_PAYMENT'
        DataSource = dsTariffs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 317
        Top = 33
        Width = 100
        Height = 13
        Alignment = taRightJustify
        Caption = #1042#1079#1085#1086#1089' '#1072#1073#1086#1085#1077#1085#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lRealBalance: TLabel
        Left = 424
        Top = 51
        Width = 103
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 317
        Top = 11
        Width = 99
        Height = 13
        Alignment = taRightJustify
        Caption = #1051#1080#1084#1080#1090' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 328
        Top = 52
        Width = 90
        Height = 13
        Alignment = taRightJustify
        Caption = #1041#1072#1083#1072#1085#1089' '#1072#1073#1086#1085#1077#1085#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DISCONNECT_LIMIT: TDBEdit
        Left = 423
        Top = 8
        Width = 104
        Height = 22
        DataField = 'DISCONNECT_LIMIT'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = DISCONNECT_LIMITChange
      end
      object RECEIVED_SUM: TDBEdit
        Left = 423
        Top = 27
        Width = 105
        Height = 26
        DataField = 'RECEIVED_SUM'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnChange = RECEIVED_SUMChange
      end
      object GOLD_NUMBER_SUM: TDBEdit
        Left = 136
        Top = 8
        Width = 111
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'GOLD_NUMBER_SUM'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
      end
      object cbDailyAbonPay: TCheckBox
        Left = 314
        Top = 69
        Width = 243
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1089#1091#1090#1086#1095#1085#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077' '#1072#1073#1086#1085' '#1087#1083#1072#1090#1099'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
    end
    object pPhoneInfo: TPanel
      Left = 1
      Top = 349
      Width = 573
      Height = 111
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 100
      DesignSize = (
        573
        111)
      object Label4: TLabel
        Left = 8
        Top = 7
        Width = 101
        Height = 13
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088' '#1089#1074#1103#1079#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 29
        Width = 63
        Height = 13
        Caption = #1042#1080#1076' '#1085#1086#1084#1077#1088#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 255
        Top = 27
        Width = 126
        Height = 13
        Caption = #1060#1077#1076#1077#1088#1072#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
        FocusControl = PHONE_NUMBER_FEDERAL
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 256
        Top = 7
        Width = 43
        Height = 13
        Caption = #1058#1072#1088#1080#1092':'
        FocusControl = cbTariffNameold
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 8
        Top = 51
        Width = 96
        Height = 13
        Caption = #1053#1086#1084#1077#1088' SIM - '#1082#1072#1088#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 288
        Top = 51
        Width = 89
        Height = 13
        Caption = #1043#1086#1088#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
        FocusControl = PHONE_NUMBER_CITY
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lClientTariffOption: TLabel
        Left = 8
        Top = 73
        Width = 98
        Height = 13
        Caption = #1040#1073#1086#1085'. '#1090#1072#1088#1080#1092'. '#1086#1087#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object OPERATOR_ID: TDBLookupComboBox
        Left = 112
        Top = 3
        Width = 137
        Height = 22
        DataField = 'OPERATOR_ID'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
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
        Left = 112
        Top = 25
        Width = 137
        Height = 22
        DataField = 'PHONE_NUMBER_TYPE'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
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
        Left = 386
        Top = 27
        Width = 153
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'PHONE_NUMBER_FEDERAL'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 6
        OnKeyPress = PHONE_NUMBER_FEDERALKeyPress
        OnKeyUp = PHONE_NUMBER_FEDERALKeyUp
      end
      object TARIFF_ID_: TDBLookupComboBox
        Left = 305
        Top = -1
        Width = 256
        Height = 22
        DataField = 'TARIFF_ID'
        DataSource = dsContracts
        DropDownRows = 25
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
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
        Left = 112
        Top = 47
        Width = 154
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        DataField = 'SIM_NUMBER'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object PHONE_NUMBER_CITY: TDBEdit
        Left = 386
        Top = 49
        Width = 78
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'PHONE_NUMBER_CITY'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 7
        OnKeyPress = PHONE_NUMBER_CITYKeyPress
        OnKeyUp = PHONE_NUMBER_CITYKeyUp
      end
      object cbTariffNameold: TComboBox
        Left = 547
        Top = 27
        Width = 22
        Height = 21
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
        Left = 305
        Top = 3
        Width = 252
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 25
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnChange = cbTariffNameoldChange
      end
      object ABONENT_TARIFF_OPTION: TDBEdit
        Left = 112
        Top = 69
        Width = 447
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        DataField = 'ABONENT_TARIFF_OPTION'
        DataSource = dsContracts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnChange = ABONENT_TARIFF_OPTIONChange
      end
      object DBCheckBox1: TDBCheckBox
        Left = 112
        Top = 93
        Width = 239
        Height = 17
        Caption = #1056#1091#1095#1085#1086#1081' '#1073#1080#1083#1083#1080#1085#1075' '#1094#1080#1082#1083'  ('#1090#1086#1083#1100#1082#1086' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1072')'
        DataField = 'HANDS_BILLING'
        DataSource = dsContracts
        TabOrder = 9
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object pcAbonent: TTabControl
      Left = 1
      Top = 1
      Width = 573
      Height = 348
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
        Caption = #1053#1086#1074#1099#1081' '#1072#1073#1086#1085#1077#1085#1090
      end
      object tsEditAbonent: TTabSheet
        Caption = 'tsEditAbonent'
        ImageIndex = 1
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 565
          Height = 34
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            Left = 0
            Top = 0
            Width = 193
            Height = 33
            Caption = #1053#1072#1081#1090#1080' '#1072#1073#1086#1085#1077#1085#1090#1072
          end
        end
      end
      inline EditAbonent: TEditAbonentFrme
        Left = 4
        Top = 28
        Width = 565
        Height = 314
        Align = alTop
        TabOrder = 2
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 565
        ExplicitHeight = 314
        inherited Panel1: TPanel
          Width = 565
          ExplicitWidth = 565
          DesignSize = (
            565
            130)
          inherited Label1: TLabel
            Font.Height = -12
          end
          inherited Label2: TLabel
            Font.Height = -12
          end
          inherited Label3: TLabel
            Font.Height = -12
          end
          inherited Label4: TLabel
            Left = 260
            Font.Height = -12
            ExplicitLeft = 260
          end
          inherited Label20: TLabel
            Left = 262
            Top = 31
            Font.Height = -12
            ExplicitLeft = 262
            ExplicitTop = 31
          end
          inherited Label22: TLabel
            Font.Height = -12
          end
          inherited SURNAME: TDBEdit
            Width = 151
            Height = 22
            Font.Height = -12
            ExplicitWidth = 151
            ExplicitHeight = 22
          end
          inherited NAME: TDBEdit
            Width = 151
            Height = 22
            Font.Height = -12
            ExplicitWidth = 151
            ExplicitHeight = 22
          end
          inherited PATRONYMIC: TDBEdit
            Width = 151
            Height = 22
            Font.Height = -12
            ExplicitWidth = 151
            ExplicitHeight = 22
          end
          inherited BDATE: TDBEdit
            Left = 338
            Width = 117
            Height = 22
            Font.Height = -12
            ExplicitLeft = 338
            ExplicitWidth = 117
            ExplicitHeight = 22
          end
          inherited CITIZENSHIP: TDBLookupComboBox
            Left = 340
            Width = 171
            Height = 22
            Font.Height = -12
            ExplicitLeft = 340
            ExplicitWidth = 171
            ExplicitHeight = 22
          end
          inherited IS_VIP: TCheckBox
            Left = 260
            Top = 52
            Width = 85
            Caption = 'VIP '#1082#1083#1080#1077#1085#1090'     '
            Font.Height = -12
            ExplicitLeft = 260
            ExplicitTop = 52
            ExplicitWidth = 85
          end
          inherited ToolBar1: TToolBar
            Left = 360
            Top = 50
            Width = 167
            Height = 30
            ButtonWidth = 157
            ExplicitLeft = 360
            ExplicitTop = 50
            ExplicitWidth = 167
            ExplicitHeight = 30
            inherited ToolButton1: TToolButton
              ExplicitWidth = 157
            end
          end
        end
        inherited pPassport: TPanel
          Width = 565
          ExplicitWidth = 565
          DesignSize = (
            565
            59)
          inherited Label6: TLabel
            Font.Height = -12
          end
          inherited Label8: TLabel
            Font.Height = -12
          end
          inherited Label7: TLabel
            Font.Height = -12
          end
          inherited Label18: TLabel
            Font.Height = -12
          end
          inherited Bevel1: TBevel
            Width = 581
            ExplicitWidth = 581
          end
          inherited Label5: TLabel
            Font.Height = -12
          end
          inherited PASSPORT_SER: TDBEdit
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
          inherited PASSPORT_GET: TDBEdit
            Width = 225
            Height = 22
            Font.Height = -12
            ExplicitWidth = 225
            ExplicitHeight = 22
          end
          inherited PASSPORT_NUM: TDBEdit
            Width = 225
            Height = 22
            Font.Height = -12
            ExplicitWidth = 225
            ExplicitHeight = 22
          end
          inherited PASSPORT_DATE: TDBEdit
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
        end
        inherited GroupBox2: TPanel
          Width = 565
          ExplicitWidth = 565
          DesignSize = (
            565
            75)
          inherited Label9: TLabel
            Font.Height = -12
          end
          inherited Label10: TLabel
            Font.Height = -12
          end
          inherited Label11: TLabel
            Font.Height = -12
          end
          inherited Label12: TLabel
            Font.Height = -12
          end
          inherited Label13: TLabel
            Font.Height = -12
          end
          inherited Label14: TLabel
            Font.Height = -12
          end
          inherited Label15: TLabel
            Font.Height = -12
          end
          inherited Bevel2: TBevel
            Width = 581
            ExplicitWidth = 581
          end
          inherited Label19: TLabel
            Font.Height = -12
          end
          inherited COUNTRY_ID: TDBLookupComboBox
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
          inherited REGION_ID: TDBLookupComboBox
            Width = 225
            Height = 22
            Font.Height = -12
            ExplicitWidth = 225
            ExplicitHeight = 22
          end
          inherited CITY_NAME: TDBEdit
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
          inherited STREET_NAME: TDBEdit
            Width = 225
            Height = 22
            Font.Height = -12
            ExplicitWidth = 225
            ExplicitHeight = 22
          end
          inherited HOUSE: TDBEdit
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
          inherited KORPUS: TDBEdit
            Height = 22
            Font.Height = -12
            ExplicitHeight = 22
          end
          inherited APARTMENT: TDBEdit
            Width = 129
            Height = 22
            Font.Height = -12
            ExplicitWidth = 129
            ExplicitHeight = 22
          end
        end
        inherited GroupBox3: TPanel
          Width = 565
          ExplicitWidth = 565
          DesignSize = (
            565
            50)
          inherited Label16: TLabel
            Font.Height = -12
          end
          inherited Label17: TLabel
            Font.Height = -12
          end
          inherited Bevel3: TBevel
            Width = 581
            ExplicitWidth = 581
          end
          inherited Label21: TLabel
            Left = 369
            Font.Height = -12
            ExplicitLeft = 369
          end
          inherited CONTACT_INFO: TDBEdit
            Left = 144
            Width = 409
            Height = 22
            Font.Height = -12
            ExplicitLeft = 144
            ExplicitWidth = 409
            ExplicitHeight = 22
          end
          inherited CODE_WORD: TDBEdit
            Left = 144
            Width = 193
            Height = 22
            Font.Height = -12
            ExplicitLeft = 144
            ExplicitWidth = 193
            ExplicitHeight = 22
          end
          inherited EMAIL: TDBEdit
            Left = 410
            Width = 143
            Height = 22
            Font.Height = -12
            ExplicitLeft = 410
            ExplicitWidth = 143
            ExplicitHeight = 22
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
      'SELECT * FROM TARIFFS t'
      'WHERE '
      '  (  ( '
      '        T.SHOW_TO_USER_FOR_ADD_CONTR = 1'
      '        AND :IS_INSERT = 1'
      '        AND :IS_ADMIN = 0'
      '    )'
      '    OR'
      '    (:IS_ADMIN = 1)'
      '    OR '
      '    (nvl(:IS_INSERT, 0) = 0)'
      '    )'
      'ORDER BY TARIFF_NAME')
    FetchAll = True
    Left = 240
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IS_INSERT'
      end
      item
        DataType = ftUnknown
        Name = 'IS_ADMIN'
      end>
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
