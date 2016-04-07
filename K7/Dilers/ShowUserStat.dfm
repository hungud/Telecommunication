object ShowUserStatForm: TShowUserStatForm
  Left = 268
  Top = 314
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
  ClientHeight = 510
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 469
    Width = 886
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      886
      41)
    object btnClose: TBitBtn
      Left = 724
      Top = 4
      Width = 153
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      ModalResult = 2
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 886
    Height = 469
    ActivePage = tsBalanceRows
    Align = alClient
    TabOrder = 1
    object tsAbonent: TTabSheet
      Caption = #1055#1072#1089#1087#1086#1088#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 1
      inline EditAbonentFrame: TEditAbonentFrme
        Left = 8
        Top = 0
        Width = 561
        Height = 315
        TabOrder = 0
        ExplicitLeft = 8
        ExplicitWidth = 561
        ExplicitHeight = 315
        inherited Panel1: TPanel
          Width = 561
          ExplicitWidth = 561
          DesignSize = (
            561
            79)
          inherited Label4: TLabel
            Left = 328
            ExplicitLeft = 328
          end
          inherited Label20: TLabel
            Left = 329
            Anchors = [akTop, akRight]
            ExplicitLeft = 329
          end
          inherited SURNAME: TDBEdit
            Width = 208
            ExplicitWidth = 208
          end
          inherited NAME: TDBEdit
            Width = 208
            ExplicitWidth = 208
          end
          inherited PATRONYMIC: TDBEdit
            Width = 208
            ExplicitWidth = 208
          end
          inherited BDATE: TDBEdit
            Left = 415
            ExplicitLeft = 415
          end
          inherited CITIZENSHIP: TDBLookupComboBox
            Left = 415
            Width = 134
            Anchors = [akTop, akRight]
            ExplicitLeft = 415
            ExplicitWidth = 134
          end
          inherited IS_VIP: TCheckBox
            Left = 328
            ExplicitLeft = 328
          end
          inherited ToolBar1: TToolBar
            Left = 422
            ExplicitLeft = 422
          end
        end
        inherited pPassport: TPanel
          Width = 561
          ExplicitWidth = 561
          inherited Bevel1: TBevel
            Width = 577
            ExplicitWidth = 577
          end
          inherited PASSPORT_GET: TDBEdit
            Width = 221
            ExplicitWidth = 221
          end
          inherited PASSPORT_NUM: TDBEdit
            Width = 221
            ExplicitWidth = 221
          end
        end
        inherited GroupBox2: TPanel
          Width = 561
          ExplicitWidth = 561
          inherited Bevel2: TBevel
            Width = 577
            ExplicitWidth = 577
          end
          inherited REGION_ID: TDBLookupComboBox
            Width = 221
            ExplicitWidth = 221
          end
          inherited STREET_NAME: TDBEdit
            Width = 221
            ExplicitWidth = 221
          end
          inherited APARTMENT: TDBEdit
            Width = 124
            ExplicitWidth = 124
          end
        end
        inherited GroupBox3: TPanel
          Width = 561
          ExplicitWidth = 561
          inherited Bevel3: TBevel
            Width = 577
            ExplicitWidth = 577
          end
          inherited CONTACT_INFO: TDBEdit
            Width = 381
            ExplicitWidth = 381
          end
          inherited EMAIL: TDBEdit
            Width = 216
            ExplicitWidth = 216
          end
        end
        inherited qGetNewId: TOraStoredProc
          CommandStoredProcName = 'NEW_ABONENT_ID:0'
        end
      end
    end
    object tsTariffs: TTabSheet
      Caption = #1058#1072#1088#1080#1092' '#1080' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      ImageIndex = 2
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 878
        Height = 441
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          878
          441)
        object Label13: TLabel
          Left = 56
          Top = 40
          Width = 112
          Height = 16
          Alignment = taRightJustify
          Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText13: TDBText
          Left = 200
          Top = 38
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'CELL_PLAN_CODE'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText14: TDBText
          Left = 200
          Top = 58
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'TARIFF_NAME'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText15: TDBText
          Left = 200
          Top = 82
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'NEW_CELL_PLAN_CODE'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText16: TDBText
          Left = 200
          Top = 103
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'NEW_TARIFF_NAME'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 11
          Top = 84
          Width = 157
          Height = 16
          Alignment = taRightJustify
          Caption = #1053#1086#1074#1099#1081' '#1090#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 403
          Top = 84
          Width = 141
          Height = 16
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099' '#1090#1072#1088#1080#1092#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText17: TDBText
          Left = 576
          Top = 82
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'NEW_CELL_PLAN_DATE'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 60
          Top = 8
          Width = 108
          Height = 16
          Alignment = taRightJustify
          Caption = #1057#1090#1072#1090#1091#1089' '#1090#1072#1088#1080#1092#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object lTariffStatusText: TLabel
          Left = 200
          Top = 6
          Width = 70
          Height = 23
          Caption = #1057#1090#1072#1090#1091#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 490
          Top = 8
          Width = 54
          Height = 16
          Alignment = taRightJustify
          Caption = #1041#1072#1083#1072#1085#1089':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object lBalance: TLabel
          Left = 576
          Top = 6
          Width = 78
          Height = 23
          Caption = #1041#1072#1083#1072#1085#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 60
          Top = 127
          Width = 108
          Height = 16
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object DBText18: TDBText
          Left = 200
          Top = 127
          Width = 79
          Height = 18
          AutoSize = True
          DataField = 'LAST_CHECK_DATE_TIME'
          DataSource = dsTariffInfo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object dbtShowDateHB: TDBText
          Left = 435
          Top = 152
          Width = 78
          Height = 21
          DataField = 'HAND_BLOCK_DATE_END'
          DataSource = dsHandBlockDate
          Visible = False
        end
        object lBlockInfo: TLabel
          Left = 200
          Top = 146
          Width = 119
          Height = 23
          Caption = #1041#1083#1086#1082'.'#1080#1085#1092#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Panel8: TPanel
          Left = 0
          Top = 175
          Width = 876
          Height = 290
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Caption = 'Panel8'
          TabOrder = 0
          object gPhoneStatuses: TCRDBGrid
            Left = 0
            Top = 38
            Width = 876
            Height = 252
            OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
            DataSource = dsPhoneStatuses
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            Columns = <
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'BEGIN_DATE'
                Title.Caption = #1053#1072#1095#1072#1083#1086
                Width = 82
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'END_DATE'
                Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077
                Width = 102
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'PHONE_IS_ACTIVE'
                Title.Caption = #1057#1090#1072#1090#1091#1089
                Width = 113
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TARIFF_NAME'
                Title.Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085
                Width = 341
                Visible = True
              end>
          end
        end
        object BtUnBlock: TButton
          Left = 720
          Top = 33
          Width = 145
          Height = 25
          Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
          TabOrder = 1
          OnClick = BtUnBlockClick
        end
        object BtBlock: TButton
          Left = 720
          Top = 0
          Width = 145
          Height = 25
          Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
          TabOrder = 2
          OnClick = BtBlockClick
        end
        object CbHandBlock: TCheckBox
          Left = 403
          Top = 129
          Width = 161
          Height = 17
          Caption = #1056#1091#1095#1085#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = CbHandBlockClick
          OnExit = CbHandBlockExit
        end
        object BtSetPassword: TButton
          Left = 720
          Top = 159
          Width = 145
          Height = 25
          Caption = #1047#1072#1076#1072#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1086#1090' '#1082#1072#1073#1080#1085#1077#1090#1072
          TabOrder = 4
          OnClick = BtSetPasswordClick
        end
        object BtSetPasswordOk: TButton
          Left = 832
          Top = 159
          Width = 33
          Height = 25
          Caption = #1054#1082
          TabOrder = 5
          Visible = False
          OnClick = BtSetPasswordOkClick
        end
        object eSetPassword: TEdit
          Left = 720
          Top = 160
          Width = 106
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Visible = False
          OnKeyPress = eSetPasswordKeyPress
        end
        object btSetHandBlockDateEnd: TBitBtn
          Left = 467
          Top = 152
          Width = 36
          Height = 21
          Caption = #1054#1082
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 7
          Visible = False
          OnClick = btSetHandBlockDateEndClick
        end
        object emNewDateEnd: TMaskEdit
          Left = 403
          Top = 152
          Width = 53
          Height = 21
          EditMask = '!99/99/00;1;_'
          MaxLength = 8
          TabOrder = 8
          Text = '  .  .  '
          Visible = False
        end
      end
    end
    object tsBalanceRows: TTabSheet
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1072#1083#1072#1085#1089#1072
      ImageIndex = 6
      object CRDBGrid5: TCRDBGrid
        Left = 0
        Top = 0
        Width = 878
        Height = 441
        OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
        Align = alClient
        DataSource = dsBalanceRows
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = CRDBGrid5CellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ROW_DATE'
            Title.Caption = #1044#1072#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COST_PLUS'
            Title.Caption = #1055#1086#1089#1090#1091#1087#1080#1083#1086
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COST_MINUS'
            Title.Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1086
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ROW_COMMENT'
            Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 513
            Visible = True
          end>
      end
    end
    object tsPayments: TTabSheet
      Caption = #1055#1083#1072#1090#1077#1078#1080
      ImageIndex = 3
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 878
        Height = 441
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object gPayments: TCRDBGrid
          Left = 0
          Top = 41
          Width = 878
          Height = 400
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alClient
          DataSource = dsPayments
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'PAYMENT_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 116
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAYMENT_SUM'
              Title.Alignment = taCenter
              Title.Caption = #1057#1091#1084#1084#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 122
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAYMENT_NUMBER'
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 165
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PAYMENT_REMARK'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 285
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              Expanded = False
              FieldName = 'CONTRACT_ID'
              Title.Alignment = taCenter
              Title.Caption = #1055#1088#1080#1082#1088#1077#1087#1083#1105#1085
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 60
              Visible = True
            end>
        end
        object pPaymentsToolBar: TPanel
          Left = 0
          Top = 0
          Width = 878
          Height = 41
          Align = alTop
          TabOrder = 1
          object btnUsePayment: TButton
            Left = 32
            Top = 8
            Width = 122
            Height = 25
            Action = aLinkPayment
            TabOrder = 0
          end
          object Button2: TButton
            Left = 160
            Top = 8
            Width = 129
            Height = 25
            Action = aUnlinkPayment
            TabOrder = 1
          end
        end
      end
    end
    object tsDeposit: TTabSheet
      Caption = #1044#1077#1087#1086#1079#1080#1090#1099
      ImageIndex = 7
      object lDepositValue: TLabel
        Left = 16
        Top = 19
        Width = 151
        Height = 18
        Caption = #1058#1077#1082#1091#1097#1080#1081' '#1076#1077#1087#1086#1079#1080#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object lDepositOper: TLabel
        Left = 16
        Top = 69
        Width = 75
        Height = 18
        Caption = #1048#1089#1090#1086#1088#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object dbtDepositValue: TDBText
        Left = 175
        Top = 19
        Width = 65
        Height = 20
        DataField = 'CURRENT_DEPOSITE_VALUE'
        DataSource = dsDeposit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object dbDepositOper: TCRDBGrid
        Left = 16
        Top = 104
        Width = 859
        Height = 335
        DataSource = dsDepositOper
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'OPERATION_DATE_TIME'
            Title.Caption = #1044#1072#1090#1072' '#1076#1077#1087#1086#1079#1080#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DEPOSITE_VALUE'
            Title.Caption = #1057#1091#1084#1084#1072' '#1076#1077#1087#1086#1079#1080#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPERATOR_NAME'
            Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 2404
            Visible = True
          end>
      end
      object btAddDeposit: TBitBtn
        Left = 97
        Top = 65
        Width = 224
        Height = 29
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1091#1084#1084#1091' '#1076#1077#1087#1086#1079#1080#1090#1072
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
        OnClick = btAddDepositClick
      end
    end
    object tsBills: TTabSheet
      Caption = #1057#1095#1077#1090#1072
      ImageIndex = 4
      object CRDBGrid4: TCRDBGrid
        Left = 0
        Top = 0
        Width = 878
        Height = 441
        OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
        OnGetCellParams = CRDBGrid4GetCellParams
        Align = alClient
        DataSource = dsBills
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'DATE_BEGIN'
            Title.Caption = #1053#1072#1095#1072#1083#1086
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_END'
            Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BILL_SUM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Title.Caption = #1057#1091#1084#1084#1072' '#1089#1095#1105#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SUBSCRIBER_PAYMENT_MAIN'
            Title.Caption = #1040'/'#1087' '#1087#1086' '#1090#1072#1088#1080#1092#1091
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SUBSCRIBER_PAYMENT_ADD'
            Title.Caption = #1040'/'#1087' '#1079#1072' '#1076#1086#1087'.'#1091#1089#1083#1091#1075#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 114
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SINGLE_PAYMENTS'
            Title.Caption = #1056#1072#1079#1086#1074#1099#1077' '#1087#1083#1072#1090'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 91
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS_LOCAL_COST'
            Title.Caption = #1052#1077#1089#1090#1085#1099#1077' '#1079#1074#1086#1085#1082#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS_OTHER_CITY_COST'
            Title.Caption = #1052#1077#1078#1075#1086#1088#1086#1076
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS_OTHER_COUNTRY_COST'
            Title.Caption = #1052'/'#1085#1072#1088#1086#1076#1085#1099#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MESSAGES_COST'
            Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INTERNET_COST'
            Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OTHER_COUNTRY_ROAMING_COST'
            Title.Caption = #1052'/'#1085' '#1088#1086#1091#1084#1080#1085#1075
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NATIONAL_ROAMING_COST'
            Title.Caption = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PENI_COST'
            Title.Caption = #1064#1090#1088#1072#1092#1099
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DISCOUNT_VALUE'
            Title.Caption = #1057#1082#1080#1076#1082#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TARIFF_CODE'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end>
      end
    end
    object tsOptions: TTabSheet
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1091#1089#1083#1091#1075#1080
      ImageIndex = 5
      object CRDBGrid2: TCRDBGrid
        Left = 0
        Top = 0
        Width = 878
        Height = 441
        OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
        Align = alClient
        DataSource = dsOptions
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'OPTION_CODE'
            Title.Caption = #1050#1086#1076
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPTION_NAME'
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 208
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPTION_PARAMETERS'
            Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 143
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TURN_ON_DATE'
            Title.Caption = #1042#1082#1083#1102#1095#1077#1085#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TURN_OFF_DATE'
            Title.Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LAST_CHECK_DATE_TIME'
            Title.Caption = #1055#1086#1089#1083'. '#1087#1088#1086#1074#1077#1088#1082#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 118
            Visible = True
          end>
      end
    end
    object tsDetail: TTabSheet
      Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080
      OnShow = tsDetailShow
      object Splitter1: TSplitter
        Left = 0
        Top = 161
        Width = 878
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 878
        Height = 161
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object CRDBGrid1: TCRDBGrid
          Left = 0
          Top = 0
          Width = 289
          Height = 161
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alLeft
          DataSource = dsPeriods
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'MONTH'
              Title.Caption = #1052#1077#1089#1103#1094
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'YEAR'
              Title.Caption = #1043#1086#1076
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 77
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONE_NUMBER'
              Title.Caption = #1058#1077#1083#1077#1092#1086#1085
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = -1
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'ESTIMATE_SUM'
              Title.Caption = #1057#1091#1084#1084#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 110
              Visible = True
            end>
        end
        object Panel4: TPanel
          Left = 289
          Top = 0
          Width = 589
          Height = 161
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object DBText1: TDBText
            Left = 136
            Top = 8
            Width = 77
            Height = 18
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'ESTIMATE_SUM'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 11
            Top = 9
            Width = 91
            Height = 16
            Alignment = taRightJustify
            Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1086' :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 15
            Top = 41
            Width = 119
            Height = 13
            Alignment = taRightJustify
            Caption = #1041'/'#1087#1083#1072#1090#1085#1099#1093' '#1084#1080#1085#1091#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText2: TDBText
            Left = 152
            Top = 40
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'ZEROCOST_OUTCOME_MINUTES'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 65
            Top = 57
            Width = 69
            Height = 13
            Alignment = taRightJustify
            Caption = '- '#1079#1074#1086#1085#1082#1086#1074':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText3: TDBText
            Left = 152
            Top = 56
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'ZEROCOST_OUTCOME_COUNT'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 30
            Top = 89
            Width = 104
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1083#1072#1090#1085#1099#1093' '#1084#1080#1085#1091#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText4: TDBText
            Left = 152
            Top = 88
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'CALLS_MINUTES'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 65
            Top = 113
            Width = 69
            Height = 13
            Alignment = taRightJustify
            Caption = '- '#1079#1074#1086#1085#1082#1086#1074':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText5: TDBText
            Left = 152
            Top = 112
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'CALLS_COUNT'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label6: TLabel
            Left = 50
            Top = 137
            Width = 84
            Height = 13
            Alignment = taRightJustify
            Caption = ' - '#1089#1090#1086#1080#1084#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText6: TDBText
            Left = 152
            Top = 136
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'CALLS_COST'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 288
            Top = 41
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'SMS '#1080' MMS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText7: TDBText
            Left = 392
            Top = 40
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'SMS_MMS_COUNT'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 277
            Top = 57
            Width = 84
            Height = 13
            Alignment = taRightJustify
            Caption = ' - '#1089#1090#1086#1080#1084#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText8: TDBText
            Left = 392
            Top = 56
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'SMS_MMS_COST'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label9: TLabel
            Left = 270
            Top = 89
            Width = 91
            Height = 13
            Alignment = taRightJustify
            Caption = #1048#1085#1090#1077#1088#1085#1077#1090', '#1052#1073':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText9: TDBText
            Left = 392
            Top = 88
            Width = 61
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'INTERNET_MB'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 277
            Top = 105
            Width = 84
            Height = 13
            Alignment = taRightJustify
            Caption = ' - '#1089#1090#1086#1080#1084#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText10: TDBText
            Left = 383
            Top = 104
            Width = 70
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'INTERNET_COST'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 261
            Top = 137
            Width = 100
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1088#1086#1095#1080#1077' '#1091#1089#1083#1091#1075#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText11: TDBText
            Left = 383
            Top = 136
            Width = 70
            Height = 16
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'OTHER_COST'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBText12: TDBText
            Left = 397
            Top = 10
            Width = 56
            Height = 13
            Alignment = taRightJustify
            AutoSize = True
            DataField = 'LAST_CHECK_DATE_TIME'
            DataSource = dsPeriods
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 164
        Width = 878
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label12: TLabel
          Left = 8
          Top = 8
          Width = 71
          Height = 13
          Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103':'
        end
        object BitBtn1: TBitBtn
          Left = 256
          Top = 2
          Width = 145
          Height = 29
          Action = aSaveDetail
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
          DoubleBuffered = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00CCCC
            CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00F7F7F700F7F7F700CCCCCC00CCCC
            CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00FF00FF00C2A97500B782
            1800B6801400B37A0600D7CFD200D8CEC900CFCECD00C9BFAC00D9CFCE00D5CA
            C300D4CAC400D6CFD200B37A0600B6801400B7821800C2A97500B7821800F6CD
            8B00F2C67D00F0C17100FAF7FB00FFFFFF004C48480098939200FFFFFF00F7EF
            EA00F6EFEB00F9F6FA00F0C17100F2C67D00F6CD8B00B7821800B6811600F3CA
            8700EDBC6D00EBB76100F8F5F700FFFFFF004A454100948C8800FFFFFF00F1E8
            E000F0E7E000F7F4F700EBB76100EDBC6D00F3CA8700B6811600B6811600F1CB
            8900E9B76200E7B25700F9F8FB00FDF7F200877F79004A444100FEF7F200EEE3
            D800EDE2D900F8F7FB00E8B25700E9B76200F1CB8900B6811600B6811600F3CC
            8E00E8B25A00E7AE5100FCFFFF00ECE0D700F1E4DA00F1E5DA00EDE0D500EADD
            D300E9DED500FBFFFF00E7AE5100E8B25A00F3CC8E00B6811600B6811500F3CE
            9400E6AE5100E5AB4B00E6C9A400FFFFFF00FFFFFF00FFFFFF00FEFFFF00FDFF
            FF00FEFFFF00E6C9A400E5AC4B00E6AE5100F3CE9400B6811500B6811500F3D0
            9A00E5A84500E3A64000E2A13600E29E2F00E19D2D00E19D2C00E19D2C00E19D
            2D00E29E2F00E2A13600E3A64000E5A84500F3D09A00B6811500B6811400F4D4
            A000E1A13600F2DEB700FCFFFF00FBFFFD00FBFFFC00FBFFFD00FBFFFD00FBFF
            FD00FBFFFD00FBFFFF00F2DEB700E1A13600F4D4A000B6811400B6801400F6D8
            A700E09C2700FBFFFF00FCFBF300FCF9EF00FBF8EE00FCFAF000FCFAF000FBF9
            EE00F9F8ED00FAF9F100FAFEFE00E09B2700F6D8A700B6801400B6801400F8DC
            B000E0981C00FBFBF80079787B00A2A0A200FCF6EA0079787900A3A1A300A09F
            A100FAF4E9009D9DA000F9F9F600E0981C00F8DCB000B6801400B6811300FCE3
            BC009B610400FDFCF900FDF5E800FEF4E700FBF2E500FCF2E500FBF2E500FBF2
            E500FAF1E300F9F1E500FCFAF7009A610400FCE3BC00B6811300B6801200FEE9
            C60071410000FFFFFF0079797A007A7A7A00A2A1A1009F9F9F00F6ECDE007777
            7700A1A1A1009E9FA000FFFFFF0070410000FEE9C600B6801200B6801200FDEC
            D100DA860000FFFFFF00F1E5D800F2E5D800F2E5D700F0E3D600EFE2D500F1E4
            D700F1E4D600EFE3D600FFFFFF00DA860000FDECD100B6801200B7811500FFEC
            CD00FCE7C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FCE7C300FFECCD00B7811500DCC28F00B781
            1400B57E0F00B57C0B00B57C0900B57C0900B57C0900B57C0900B57C0900B57C
            0900B57C0900B57C0900B57C0B00B57E0F00B7811400DCC28F00}
          ParentDoubleBuffered = False
          TabOrder = 0
        end
        object BitBtn2: TBitBtn
          Left = 88
          Top = 2
          Width = 151
          Height = 29
          Action = aOpenDetailInExcel
          Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
          DoubleBuffered = True
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00535E54008694880046574900728574003C523F006E84
            710039533C0076907900506D54007D9A81003E5D420073927500325533006889
            67004C6A4D0089A08A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00839185002F40320074877600435946006C866F004764
            4B00739077002E4D320069886D003A5C3E00698B6D00315634007EAA81002852
            2900698C6A00304E3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00445547007D907F00E2F8E500EFFFF200EDFFF100E7FF
            EB00EAFFEE00EAFFEE00E8FFED00E8FFED00E8FFED00E4FFEA00D7FFDA00E1FF
            E300315B32006F906E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00738A74003B583E00ECFFED00D4F9D700E6FFEA00DDFF
            E200E4FFE900DEFFE400DFFFE500598A5E003A6B3F0062936500326735005B90
            5E0077A479002D532F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0040613E00608B5E00E1FFE000245E240065A268002666
            2B005C9E63001B5D220055975C0026692C00D8FFDB001F5D210058935900386D
            3B00214F2400658B6700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00678B610040713900DFFFD80061A25D00145A1400569E
            5800337C38005EA965002E773300D3FFD60019621A0067AD67003B773B00D1FF
            D40078A67B00486E4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF003D5E310068955C00DAFFCD00306C260072B16B002D70
            2B00468C46001F651F00D8FFD600185C15005799510023641F005C965B00D8FF
            D9001E4B20006D927000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00829F7800496F3F00DFFFD500E1FFD900255D2200528C
            51003A753B00DAFFDC002662260069A5680035713100669F6200265D2600E1FF
            E30069936A0035583600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF003043300065816300EAFFEA00E2FFE500E3FFE9004574
            4D00D0FFDB002F603A005F8E68002C5B340065936800DFFFE000DFFFE000DCFF
            DD00365D370079997A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0070836E0055715300EAFFEA00E4FFE70025502B00E3FF
            EA002C5A36006E9C7800335F3A00618D660039653C00719E7300E3FFE500E4FF
            E5005D815D004C6A4D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0049643C0072976500E5FFD80033622A00E4FFDF003365
            2F0071A26E001F501C0063945E0044753D006D9D630037662E0076A27300DCFF
            DD0053745200627D6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF007A9B6F00395F2D00E2FFD90070A16900366832005E8F
            5B00366735006B9C6A00E4FFE0006596600038652C0065915C002C522800ECFF
            EA0058775800455F4700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0038573C00698E6C00E1FFE700305F390053805F004A76
            57005A866900D8FFE500E4FFEE00DDFFE400678E68002F542E0070916E00E9FF
            E9003F5A40007F968000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0083A48900284F2F00E3FFEB00E1FFEB00E1FFEE00D9FF
            E800DDFFED00E1FFEF00E4FFF000E5FFEC00EAFFEB00ECFFEA00EFFFED00E7FF
            E400768E7600364B3500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0034582C0077A17100265524006798660039683A00618F
            64003A663D006E986F00244C2200668D5F00426637005F8053003C5736008197
            7F004F644E007C8F7C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF006A8962003F63370085AE8100244D2000557F5600436C
            460074987400375835007B9C77004A683F00708C610047623A0083997D004154
            3F007184710039493800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentDoubleBuffered = False
          TabOrder = 1
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 197
        Width = 878
        Height = 244
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object dbgDetail: TCRDBGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 244
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alClient
          DataSource = dsDetail
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'SELF_NUMBER'
              Title.Caption = #1057#1074#1086#1081' '#1085#1086#1084#1077#1088
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVICE_DATE'
              Title.Caption = #1044#1072#1090#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVICE_TIME'
              Title.Caption = #1042#1088#1077#1084#1103
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVICE_TYPE'
              Title.Caption = #1058#1080#1087' '#1091#1089#1083#1091#1075#1080
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 107
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVICE_DIRECTION'
              Title.Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'OTHER_NUMBER'
              Title.Caption = #1057#1086#1073#1077#1089#1077#1076#1085#1080#1082
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 93
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION'
              Title.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVICE_COST'
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'IS_ROAMING'
              Title.Caption = #1056#1086#1091#1084#1080#1085#1075
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ROAMING_ZONE'
              Title.Caption = #1047#1086#1085#1072' '#1088#1086#1091#1084#1080#1085#1075#1072
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ADD_INFO'
              Title.Caption = #1044#1086#1087'.'#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 193
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BASE_STATION_CODE'
              Title.Caption = #1041#1072#1079#1086#1074#1072#1103' '#1089#1090#1072#1085#1094#1080#1103
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 106
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COST_NO_VAT'
              Title.Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 99
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BS_PLACE'
              Title.Caption = #1047#1086#1085#1072' '#1041#1057
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 304
              Visible = True
            end>
        end
        object mDetailText: TMemo
          Left = 672
          Top = 40
          Width = 104
          Height = 203
          ScrollBars = ssBoth
          TabOrder = 0
          Visible = False
          WordWrap = False
        end
      end
    end
    object tsDiscount: TTabSheet
      Caption = #1057#1082#1080#1076#1082#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      ImageIndex = 8
      object dbtEndDate: TDBText
        Left = 88
        Top = 92
        Width = 83
        Height = 16
        AutoSize = True
        DataField = 'DISCOUNT_END_DATE'
        DataSource = dsDiscount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbtBeginDate: TDBText
        Left = 88
        Top = 70
        Width = 96
        Height = 16
        AutoSize = True
        DataField = 'DISCOUNT_BEGIN_DATE'
        DataSource = dsDiscount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lBegin: TLabel
        Left = 66
        Top = 70
        Width = 15
        Height = 16
        Caption = #1057':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lEnd: TLabel
        Left = 57
        Top = 92
        Width = 25
        Height = 16
        Caption = #1055#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lDate: TLabel
        Left = 268
        Top = 70
        Width = 126
        Height = 16
        Caption = #1044#1072#1090#1072' '#1074#1082#1083#1102#1095#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lLength: TLabel
        Left = 280
        Top = 92
        Width = 114
        Height = 16
        Caption = #1057#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dtpNewBeginDate: TDateTimePicker
        Left = 400
        Top = 65
        Width = 97
        Height = 21
        Date = 40834.475470636570000000
        Time = 40834.475470636570000000
        TabOrder = 0
      end
      object btSetDiscount: TBitBtn
        Left = 345
        Top = 35
        Width = 75
        Height = 25
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btSetDiscountClick
      end
      object cbDiscount: TCheckBox
        Left = 40
        Top = 39
        Width = 161
        Height = 17
        Caption = #1057#1082#1080#1076#1082#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = cbDiscountClick
      end
      object eLength: TDBEdit
        Left = 400
        Top = 92
        Width = 97
        Height = 21
        DataField = 'DISCOUNT_VALIDITY'
        DataSource = dsDiscount
        TabOrder = 3
      end
    end
    object tsContractInfo: TTabSheet
      Caption = #1044#1086#1075#1086#1074#1086#1088
      ImageIndex = 9
      object Label18: TLabel
        Left = 112
        Top = 32
        Width = 91
        Height = 23
        Alignment = taRightJustify
        Caption = #1044#1086#1075#1086#1074#1086#1088':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object DBText19: TDBText
        Left = 224
        Top = 32
        Width = 273
        Height = 25
        DataField = 'ACCOUNT_NUMBER'
        DataSource = dsContractInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 24
        Top = 61
        Width = 179
        Height = 23
        Alignment = taRightJustify
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1083#1102#1095#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 80
        Top = 90
        Width = 123
        Height = 23
        Alignment = taRightJustify
        Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object DBText20: TDBText
        Left = 224
        Top = 61
        Width = 273
        Height = 25
        DataField = 'CONTRACT_DATE'
        DataSource = dsContractInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 74
        Top = 119
        Width = 129
        Height = 23
        Alignment = taRightJustify
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object DBText21: TDBText
        Left = 224
        Top = 90
        Width = 273
        Height = 25
        DataField = 'CONTRACT_TYPE'
        DataSource = dsContractInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btRefreshCI: TBitBtn
        Left = 74
        Top = 151
        Width = 129
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        OnClick = btRefreshCIClick
      end
      object DBMemo1: TDBMemo
        Left = 224
        Top = 120
        Width = 405
        Height = 221
        DataField = 'COMMENTS'
        DataSource = dsContractInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = DBMemo1Change
      end
      object btPostComments: TBitBtn
        Left = 74
        Top = 182
        Width = 129
        Height = 25
        Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 2
        OnClick = btPostCommentsClick
      end
    end
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  TRUNC(DB_LOADER_PHONE_STAT.YEAR_MONTH / 100) YEAR,'
      
        '  DB_LOADER_PHONE_STAT.YEAR_MONTH - TRUNC(DB_LOADER_PHONE_STAT.Y' +
        'EAR_MONTH / 100)*100 MONTH,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM,'
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES,'
      '  DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_COUNT,'
      '  DB_LOADER_PHONE_STAT.CALLS_MINUTES,'
      '  DB_LOADER_PHONE_STAT.CALLS_COST,'
      '  DB_LOADER_PHONE_STAT.SMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.SMS_COST,'
      '  DB_LOADER_PHONE_STAT.MMS_COUNT,'
      '  DB_LOADER_PHONE_STAT.MMS_COST,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COUNT + DB_LOADER_PHONE_STAT.MMS_COUN' +
        'T SMS_MMS_COUNT,'
      
        '  DB_LOADER_PHONE_STAT.SMS_COST + DB_LOADER_PHONE_STAT.MMS_COST ' +
        'SMS_MMS_COST,'
      '  DB_LOADER_PHONE_STAT.INTERNET_MB,'
      '  DB_LOADER_PHONE_STAT.INTERNET_COST,'
      '  DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_PHONE_STAT.ESTIMATE_SUM'
      '   - DB_LOADER_PHONE_STAT.CALLS_COST'
      '   - DB_LOADER_PHONE_STAT.SMS_COST'
      '   - DB_LOADER_PHONE_STAT.MMS_COST'
      '   - DB_LOADER_PHONE_STAT.INTERNET_COST   OTHER_COST'
      'FROM'
      '  DB_LOADER_PHONE_STAT'
      'WHERE '
      '  DB_LOADER_PHONE_STAT.PHONE_NUMBER=:PHONE_NUMBER'
      'ORDER BY '
      '  DB_LOADER_PHONE_STAT.YEAR_MONTH DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 40
    Top = 177
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsPeriods: TDataSource
    DataSet = qPeriods
    OnDataChange = dsPeriodsDataChange
    Left = 68
    Top = 185
  end
  object spGetPhoneDetail: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.GET_PHONE_DETAIL'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER3_PCKG.GET_PHONE_DETAIL(:PYEAR, :PMONTH, :PPH' +
        'ONE_NUMBER);'
      'end;')
    Left = 160
    Top = 184
    ParamData = <
      item
        DataType = ftOraClob
        Name = 'RESULT'
        ParamType = ptOutput
        Value = ''
        IsResult = True
      end
      item
        DataType = ftFloat
        Name = 'PYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMONTH'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER3_PCKG.GET_PHONE_DETAIL:0'
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList16
    Left = 184
    Top = 249
    object aSaveDetail: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1102' '#1074' '#1092#1072#1081#1083
      ImageIndex = 8
      Visible = False
      OnExecute = aSaveDetailExecute
    end
    object aOpenDetailInExcel: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
      OnExecute = aOpenDetailInExcelExecute
    end
    object aLinkPayment: TAction
      Category = 'Payments'
      Caption = #1055#1088#1080#1082#1088#1077#1087#1080#1090#1100' '#1087#1083#1072#1090#1105#1078
      OnExecute = aLinkPaymentExecute
    end
    object aUnlinkPayment: TAction
      Category = 'Payments'
      Caption = #1054#1090#1082#1088#1077#1087#1080#1090#1100' '#1087#1083#1072#1090#1105#1078
      OnExecute = aUnlinkPaymentExecute
    end
  end
  object sdDetail: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1060#1072#1081#1083#1099' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1060#1072#1081#1083' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080
    Left = 288
    Top = 148
  end
  object qTariffInfo: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,'
      '  DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '  TARIFFS.TARIFF_NAME,'
      '  DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_CODE,'
      '  NEW_TARIFFS.TARIFF_NAME NEW_TARIFF_NAME,'
      '  DB_LOADER_ACCOUNT_PHONES.NEW_CELL_PLAN_DATE,'
      
        '  GET_ABONENT_BALANCE(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,:pBA' +
        'LANCE_DATE) CURRENT_BALANCE,'
      '  DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME,'
      '  DB_LOADER_ACCOUNT_PHONES.SYSTEM_BLOCK,'
      '  DB_LOADER_ACCOUNT_PHONES.CONSERVATION'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONES,'
      '  TARIFFS,'
      '  TARIFFS NEW_TARIFFS'
      'WHERE'
      '  DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME'
      '        )'
      '  AND NEW_TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME'
      '        )'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC')
    DetailFields = '.'
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 24
    Top = 225
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'pBALANCE_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsTariffInfo: TDataSource
    DataSet = qTariffInfo
    OnDataChange = dsTariffInfoDataChange
    Left = 52
    Top = 233
  end
  object qOptions: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_PARAMETERS, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE, '
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.LAST_CHECK_DATE_TIME'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS'
      'WHERE'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH = ('
      '    SELECT MAX(YEAR_MONTH) '
      '    FROM DB_LOADER_ACCOUNT_PHONE_OPTS'
      
        '    WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=:PHONE_NUMBE' +
        'R)'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE DESC NULLS FIRST,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE ASC,'
      '  DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME ASC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 32
    Top = 281
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsOptions: TDataSource
    DataSet = qOptions
    Left = 60
    Top = 289
  end
  object qPayments: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  *'
      'FROM'
      '  V_FULL_BALANCE_PAYMENTS'
      'WHERE'
      '  V_FULL_BALANCE_PAYMENTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND V_FULL_BALANCE_PAYMENTS.PAYMENT_TYPE IN (1, 2)'
      'ORDER BY'
      '  V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    AfterOpen = qPaymentsAfterOpen
    Left = 304
    Top = 265
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsPayments: TDataSource
    DataSet = qPayments
    Left = 332
    Top = 273
  end
  object qBills: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_BILLS.ACCOUNT_ID,'
      '  DB_LOADER_BILLS.YEAR_MONTH,'
      '  DB_LOADER_BILLS.PHONE_NUMBER,'
      '  DB_LOADER_BILLS.DATE_BEGIN,'
      '  DB_LOADER_BILLS.DATE_END,'
      '  DB_LOADER_BILLS.BILL_SUM,'
      '  DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN, '
      '  DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD, '
      '  DB_LOADER_BILLS.SINGLE_PAYMENTS, '
      '  DB_LOADER_BILLS.CALLS_LOCAL_COST, '
      '  DB_LOADER_BILLS.CALLS_OTHER_CITY_COST, '
      '  DB_LOADER_BILLS.CALLS_OTHER_COUNTRY_COST, '
      '  DB_LOADER_BILLS.MESSAGES_COST, '
      '  DB_LOADER_BILLS.INTERNET_COST, '
      '  DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_COST, '
      '  DB_LOADER_BILLS.NATIONAL_ROAMING_COST, '
      '  DB_LOADER_BILLS.PENI_COST,'
      '  DB_LOADER_BILLS.DISCOUNT_VALUE,'
      '  DB_LOADER_BILLS.TARIFF_CODE'
      'FROM'
      '  DB_LOADER_BILLS'
      'WHERE'
      '  DB_LOADER_BILLS.PHONE_NUMBER=:PHONE_NUMBER'
      
        '  --AND DB_LOADER_BILLS.YEAR_MONTH = TO_CHAR(DB_LOADER_BILLS.PAY' +
        'MENT_DATE, '#39'YYYYMM'#39')'
      'ORDER BY'
      '  DB_LOADER_BILLS.DATE_END DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 256
    Top = 201
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsBills: TDataSource
    DataSet = qBills
    Left = 284
    Top = 209
  end
  object qBalanceRows: TOraQuery
    SQL.Strings = (
      'SELECT * FROM'
      '('
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  ABONENT_BALANCE_ROWS.ROW_COST AS COST_PLUS,'
      '  TO_NUMBER(NULL) AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST > 0'
      'UNION ALL'
      'SELECT'
      '  ABONENT_BALANCE_ROWS.ROW_DATE, '
      '  TO_NUMBER(NULL) AS COST_PLUS,'
      '  -ABONENT_BALANCE_ROWS.ROW_COST AS COST_MINUS,'
      '  ABONENT_BALANCE_ROWS.ROW_COMMENT'
      'FROM'
      '  ABONENT_BALANCE_ROWS'
      '  WHERE ABONENT_BALANCE_ROWS.ROW_COST < 0'
      ')'
      'ORDER BY'
      '  ROW_DATE')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 24
    Top = 337
  end
  object dsBalanceRows: TDataSource
    DataSet = qBalanceRows
    Left = 52
    Top = 345
  end
  object spCalcBalanceRows: TOraStoredProc
    StoredProcName = 'CALC_BALANCE_ROWS'
    SQL.Strings = (
      'begin'
      '  CALC_BALANCE_ROWS(:PPHONE_NUMBER, :PBALANCE_DATE);'
      'end;')
    Left = 80
    Top = 352
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PBALANCE_DATE'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'CALC_BALANCE_ROWS:0'
  end
  object vtDetailFile: TVirtualTable
    FieldDefs = <
      item
        Name = 'SELF_NUMBER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVICE_DATE'
        DataType = ftDate
      end
      item
        Name = 'SERVICE_TIME'
        DataType = ftTime
      end
      item
        Name = 'SERVICE_TYPE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVICE_DIRECTION'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'OTHER_NUMBER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DURATION'
        DataType = ftFloat
      end
      item
        Name = 'SERVICE_COST'
        DataType = ftFloat
      end
      item
        Name = 'IS_ROAMING'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ROAMING_ZONE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ADD_INFO'
        DataType = ftString
        Size = 100
      end>
    Left = 516
    Top = 264
    Data = {
      03000B000B0053454C465F4E554D42455201001400000000000C005345525649
      43455F4441544509000000000000000C00534552564943455F54494D450A0000
      00000000000C00534552564943455F5459504501001400000000001100534552
      564943455F444952454354494F4E01001400000000000C004F544845525F4E55
      4D424552010014000000000008004455524154494F4E06000000000000000C00
      534552564943455F434F535406000000000000000A0049535F524F414D494E47
      01000500000000000C00524F414D494E475F5A4F4E4501003200000000000800
      4144445F494E464F0100640000000000000000000000}
    object vtDetailFileSELF_NUMBER: TStringField
      FieldName = 'SELF_NUMBER'
    end
    object vtDetailFileSERVICE_DATE: TDateField
      FieldName = 'SERVICE_DATE'
    end
    object vtDetailFileSERVICE_TIME: TTimeField
      FieldName = 'SERVICE_TIME'
    end
    object vtDetailFileSERVICE_TYPE: TStringField
      FieldName = 'SERVICE_TYPE'
    end
    object vtDetailFileSERVICE_DIRECTION: TStringField
      FieldName = 'SERVICE_DIRECTION'
    end
    object vtDetailFileOTHER_NUMBER: TStringField
      FieldName = 'OTHER_NUMBER'
    end
    object vtDetailFileDURATION: TFloatField
      FieldName = 'DURATION'
    end
    object vtDetailFileSERVICE_COST: TFloatField
      FieldName = 'SERVICE_COST'
    end
    object vtDetailFileIS_ROAMING: TStringField
      FieldName = 'IS_ROAMING'
      Size = 5
    end
    object vtDetailFileROAMING_ZONE: TStringField
      FieldName = 'ROAMING_ZONE'
      Size = 50
    end
    object vtDetailFileADD_INFO: TStringField
      FieldName = 'ADD_INFO'
      Size = 100
    end
    object vtDetailFileBASE_STATION_CODE: TStringField
      FieldName = 'BASE_STATION_CODE'
      Size = 10
    end
    object vtDetailFileCOST_NO_VAT: TFloatField
      FieldName = 'COST_NO_VAT'
    end
    object vtDetailFileBS_PLACE: TStringField
      FieldName = 'BS_PLACE'
      Size = 50
    end
  end
  object dsDetail: TDataSource
    DataSet = vtDetailFile
    Left = 548
    Top = 273
  end
  object qServiceCodes: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  SERVICE_CODE,'
      '  SERVICE_NAME'
      'FROM'
      '  DB_LOADER_SERVICE_TYPES')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 480
    Top = 313
  end
  object qPhoneStatuses: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,'
      '  TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) as BEGIN_DATE,'
      '  CASE '
      
        '    WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE = TO_DATE('#39'01.01' +
        '.3000'#39', '#39'DD.MM.YYYY'#39') THEN'
      '      TO_DATE(NULL)'
      '    ELSE'
      '      TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)'
      '  END as END_DATE,'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE,'
      
        '  NVL(TARIFFS.TARIFF_NAME, DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PL' +
        'AN_CODE) TARIFF_NAME'
      'FROM'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS,'
      '  TARIFFS'
      'WHERE'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=:PHONE_NUMBER'
      '  AND TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID('
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,'
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,'
      '        DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE'
      '        )'
      'ORDER BY'
      '  DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC NULLS FIRST')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 272
    Top = 321
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qPhoneStatusesPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 400
    end
    object qPhoneStatusesBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
    end
    object qPhoneStatusesEND_DATE: TDateTimeField
      FieldName = 'END_DATE'
    end
    object qPhoneStatusesPHONE_IS_ACTIVE: TIntegerField
      FieldName = 'PHONE_IS_ACTIVE'
      OnGetText = qPhoneStatusesPHONE_IS_ACTIVEGetText
    end
    object qPhoneStatusesTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
  end
  object dsPhoneStatuses: TDataSource
    DataSet = qPhoneStatuses
    Left = 300
    Top = 329
  end
  object LoaderUnBlockPhoneNum: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.UNLOCK_PHONE'
    SQL.Strings = (
      'begin'
      '  :RESULT := LOADER3_PCKG.UNLOCK_PHONE(:PPHONE_NUMBER);'
      'end;')
    Left = 728
    Top = 72
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
      end>
  end
  object LoaderBlockPhoneNum: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.LOCK_PHONE'
    SQL.Strings = (
      'begin'
      '  :RESULT := LOADER3_PCKG.LOCK_PHONE(:PPHONE_NUMBER);'
      'end;')
    Left = 728
    Top = 24
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
      end>
  end
  object qSelBalDate: TOraQuery
    SQL.Strings = (
      'Select contract_cancel_date,CONTRACT_ID,abonent_id '
      'from V_CONTRACTS '
      'where PHONE_NUMBER_FEDERAL=:PHONE_NUMBER'
      'and (:CONTRACT_ID=0 or CONTRACT_ID=:CONTRACT_ID)')
    Left = 628
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qHandBlock: TOraQuery
    Left = 524
    Top = 112
  end
  object qHandBlockStart: TOraQuery
    SQL.Strings = (
      'Select 1  from v_contracts'
      
        'WHERE v_contracts.CONTRACT_ID=:CONTRACT_ID and CONTRACT_CANCEL_D' +
        'ATE is Null'
      
        'and (v_contracts.PHONE_NUMBER_CITY=:PHONE_NUMBER or v_contracts.' +
        'PHONE_NUMBER_FEDERAL=:PHONE_NUMBER)')
    Left = 452
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object qPassword: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'UPDATE CONTRACTS SET USER_PASSWORD=:PASSWORD '
      '  WHERE CONTRACT_ID=:CONTRACT_ID')
    Left = 664
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PASSWORD'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qDeposit: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CURRENT_DEPOSITE_VALUE '
      '  FROM CONTRACT_DEPOSITES'
      '  WHERE CONTRACT_ID=:CONTRACT_ID')
    Left = 264
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
    object qDepositCURRENT_DEPOSITE_VALUE: TFloatField
      FieldName = 'CURRENT_DEPOSITE_VALUE'
    end
  end
  object qDepositOper: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT OPERATION_DATE_TIME, DEPOSITE_VALUE, OPERATOR_NAME, NOTE'
      '  FROM CONTRACT_DEPOSITE_OPER'
      '  WHERE CONTRACT_DEPOSITE_OPER.CONTRACT_ID=:CONTRACT_ID'
      '  ORDER BY OPERATION_DATE_TIME DESC')
    Left = 360
    Top = 408
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
    object qDepositOperOPERATION_DATE_TIME: TDateTimeField
      FieldName = 'OPERATION_DATE_TIME'
    end
    object qDepositOperDEPOSITE_VALUE: TFloatField
      FieldName = 'DEPOSITE_VALUE'
    end
    object qDepositOperOPERATOR_NAME: TStringField
      FieldName = 'OPERATOR_NAME'
      Size = 120
    end
    object qDepositOperNOTE: TStringField
      FieldName = 'NOTE'
      Size = 400
    end
  end
  object qContractID: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CONTRACT_ID, CONTRACT_DATE'
      '  FROM CONTRACTS'
      
        '  WHERE (PHONE_NUMBER_CITY=:PHONE_NUMBER OR PHONE_NUMBER_FEDERAL' +
        '=:PHONE_NUMBER)'
      '  ORDER BY CONTRACT_DATE DESC')
    Left = 536
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
  object dsDepositOper: TDataSource
    DataSet = qDepositOper
    Left = 384
    Top = 416
  end
  object dsDeposit: TDataSource
    DataSet = qDeposit
    Left = 288
    Top = 416
  end
  object qContractInfo: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CONTRACTS'
      'SET'
      '  COMMENTS = :COMMENTS'
      'WHERE'
      '  CONTRACT_ID = :Old_CONTRACT_ID')
    SQLRefresh.Strings = (
      
        'SELECT CONTRACT_NUM, CONTRACT_DATE, FILIAL_ID, COMMENTS FROM CON' +
        'TRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    SQL.Strings = (
      'SELECT '
      '  CONTRACT_ID, '
      '  CONTRACT_DATE, '
      '  FILIAL_ID,'
      '  COMMENTS, '
      '  CASE '
      '    WHEN IS_CREDIT_CONTRACT=1 THEN '#39#1050#1088#1077#1076#1080#1090#39
      '    ELSE '#39#1040#1074#1072#1085#1089#39
      '  END CONTRACT_TYPE,'
      
        '  GET_ACCOUNT_NUMBER_BY_PHONE(PHONE_NUMBER_FEDERAL) ACCOUNT_NUMB' +
        'ER'
      'FROM'
      '  CONTRACTS'
      'WHERE'
      '  CONTRACT_ID = :CONTRACT_ID')
    Left = 536
    Top = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object qLinkPayment: TOraQuery
    SQL.Strings = (
      'UPDATE DB_LOADER_PAYMENTS'
      'SET CONTRACT_ID=:CONTRACT_ID'
      'WHERE PAYMENT_NUMBER=:PAYMENT_NUMBER'
      'AND PHONE_NUMBER=:PHONE_NUMBER'
      'AND PAYMENT_SUM=:PAYMENT_SUM')
    Left = 368
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'PAYMENT_SUM'
      end>
  end
  object qDiscount: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT IS_DISCOUNT_OPERATOR,'
      '       DISCOUNT_BEGIN_DATE,'
      '       DISCOUNT_VALIDITY,'
      
        '       ADD_MONTHS(DISCOUNT_BEGIN_DATE, DISCOUNT_VALIDITY) DISCOU' +
        'NT_END_DATE,'
      'case'
      'when IS_DISCOUNT_OPERATOR=1 then '#39'true'#39
      'else '#39'false'#39
      'end checked'
      '  FROM PHONE_NUMBER_ATTRIBUTES'
      '  WHERE PHONE_NUMBER=:PHONE_NUMBER')
    Left = 24
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qDiscountIS_DISCOUNT_OPERATOR: TIntegerField
      FieldName = 'IS_DISCOUNT_OPERATOR'
    end
    object qDiscountDISCOUNT_BEGIN_DATE: TDateTimeField
      FieldName = 'DISCOUNT_BEGIN_DATE'
    end
    object qDiscountDISCOUNT_VALIDITY: TFloatField
      FieldName = 'DISCOUNT_VALIDITY'
    end
    object qDiscountDISCOUNT_END_DATE: TDateTimeField
      FieldName = 'DISCOUNT_END_DATE'
    end
    object qDiscountCHECKED: TStringField
      FieldName = 'CHECKED'
      Size = 5
    end
  end
  object spSetDiscount: TOraStoredProc
    StoredProcName = 'SET_PHONE_ATTR_DISCOUNT'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      
        '  SET_PHONE_ATTR_DISCOUNT(:PPHONE_NUMBER, :PCHECK, :PDISCOUNT_VA' +
        'LIDITY, :PDISCOUNT_BEGIN_DATE);'
      'end;')
    Left = 80
    Top = 432
    ParamData = <
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PCHECK'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PDISCOUNT_VALIDITY'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PDISCOUNT_BEGIN_DATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SET_PHONE_ATTR_DISCOUNT'
  end
  object dsDiscount: TDataSource
    DataSet = qDiscount
    Left = 52
    Top = 425
  end
  object qHandBlockEndDate: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CONTRACTS.HAND_BLOCK,'
      '       CONTRACTS.HAND_BLOCK_DATE_END'
      '  FROM CONTRACTS'
      '  WHERE CONTRACTS.CONTRACT_ID=:CONTRACT_ID'
      '  ORDER BY CONTRACTS.CONTRACT_DATE DESC')
    Left = 472
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
  object spSetHandBlockEndDate: TOraStoredProc
    StoredProcName = 'SET_HAND_BLOCK_END_DATE'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  SET_HAND_BLOCK_END_DATE(:PCONTRACT_ID, :PHAND_BLOCK_END_DATE);'
      'end;')
    AfterExecute = spSetHandBlockEndDateAfterExecute
    Left = 440
    Top = 200
    ParamData = <
      item
        DataType = ftString
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PHAND_BLOCK_END_DATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'SET_HAND_BLOCK_END_DATE'
  end
  object dsHandBlockDate: TDataSource
    DataSet = qHandBlockEndDate
    Left = 504
    Top = 216
  end
  object dsContractInfo: TDataSource
    DataSet = qContractInfo
    Left = 568
    Top = 392
  end
  object qAccountNumber: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT GET_ACCOUNT_NUMBER_BY_PHONE(:PHONE_NUMBER) ACCOUNT_NUMBER' +
        ','
      '       NULL CONTRACT_ID, '
      '       NULL CONTRACT_DATE, '
      '       NULL FILIAL_ID,'
      '       NULL COMMENTS,'
      '       NULL CONTRACT_TYPE'
      '  FROM DUAL')
    Left = 536
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
  end
end
