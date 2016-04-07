object ShowUserStatForm: TShowUserStatForm
  Left = 268
  Top = 314
  Caption = #1048#1085#1092'. '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
  ClientHeight = 609
  ClientWidth = 1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 568
    Width = 1082
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1082
      41)
    object btnClose: TBitBtn
      Left = 920
      Top = 4
      Width = 153
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1082
    Height = 568
    ActivePage = tsTariffs
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object tsAbonent: TTabSheet
      Caption = #1055#1072#1089#1087#1086#1088#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 1
      DesignSize = (
        1074
        540)
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
            Left = 328
            Font.Height = -12
            ExplicitLeft = 328
          end
          inherited Label20: TLabel
            Left = 329
            Anchors = [akTop, akRight]
            Font.Height = -12
            ExplicitLeft = 329
          end
          inherited Label22: TLabel
            Font.Height = -12
          end
          inherited SURNAME: TDBEdit
            Width = 208
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameSURNAMEChange
            ExplicitWidth = 208
            ExplicitHeight = 22
          end
          inherited NAME: TDBEdit
            Width = 208
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameNAMEChange
            ExplicitWidth = 208
            ExplicitHeight = 22
          end
          inherited PATRONYMIC: TDBEdit
            Width = 208
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFramePATRONYMICChange
            ExplicitWidth = 208
            ExplicitHeight = 22
          end
          inherited BDATE: TDBEdit
            Left = 415
            Top = -2
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameBDATEChange
            ExplicitLeft = 415
            ExplicitTop = -2
            ExplicitHeight = 22
          end
          inherited CITIZENSHIP: TDBLookupComboBox
            Left = 415
            Width = 134
            Height = 22
            Anchors = [akTop, akRight]
            Font.Height = -12
            OnClick = EditAbonentFrameCITIZENSHIPClick
            ExplicitLeft = 415
            ExplicitWidth = 134
            ExplicitHeight = 22
          end
          inherited IS_VIP: TCheckBox
            Left = 325
            Top = 49
            Font.Height = -12
            OnClick = EditAbonentFrameIS_VIPClick
            ExplicitLeft = 325
            ExplicitTop = 49
          end
          inherited ToolBar1: TToolBar
            Left = 422
            ExplicitLeft = 422
            inherited ToolButton1: TToolButton
              ExplicitWidth = 157
            end
          end
        end
        inherited pPassport: TPanel
          Width = 561
          ExplicitWidth = 561
          DesignSize = (
            561
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
            Width = 577
            ExplicitWidth = 577
          end
          inherited Label5: TLabel
            Font.Height = -12
          end
          inherited PASSPORT_SER: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFramePASSPORT_SERChange
            ExplicitHeight = 22
          end
          inherited PASSPORT_GET: TDBEdit
            Left = 322
            Width = 221
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFramePASSPORT_GETChange
            ExplicitLeft = 322
            ExplicitWidth = 221
            ExplicitHeight = 22
          end
          inherited PASSPORT_NUM: TDBEdit
            Left = 322
            Top = 11
            Width = 221
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFramePASSPORT_NUMChange
            ExplicitLeft = 322
            ExplicitTop = 11
            ExplicitWidth = 221
            ExplicitHeight = 22
          end
          inherited PASSPORT_DATE: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFramePASSPORT_DATEChange
            ExplicitHeight = 22
          end
        end
        inherited GroupBox2: TPanel
          Width = 561
          ExplicitWidth = 561
          DesignSize = (
            561
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
            Width = 577
            ExplicitWidth = 577
          end
          inherited Label19: TLabel
            Font.Height = -12
          end
          inherited COUNTRY_ID: TDBLookupComboBox
            Height = 22
            Font.Height = -12
            OnClick = EditAbonentFrameCOUNTRY_IDClick
            ExplicitHeight = 22
          end
          inherited REGION_ID: TDBLookupComboBox
            Left = 329
            Width = 221
            Height = 22
            Font.Height = -12
            OnClick = EditAbonentFrameREGION_IDClick
            ExplicitLeft = 329
            ExplicitWidth = 221
            ExplicitHeight = 22
          end
          inherited CITY_NAME: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameCITY_NAMEChange
            ExplicitHeight = 22
          end
          inherited STREET_NAME: TDBEdit
            Width = 221
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameSTREET_NAMEChange
            ExplicitWidth = 221
            ExplicitHeight = 22
          end
          inherited HOUSE: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameHOUSEChange
            ExplicitHeight = 22
          end
          inherited KORPUS: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameKORPUSChange
            ExplicitHeight = 22
          end
          inherited APARTMENT: TDBEdit
            Width = 124
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameAPARTMENTChange
            ExplicitWidth = 124
            ExplicitHeight = 22
          end
        end
        inherited GroupBox3: TPanel
          Width = 561
          ExplicitWidth = 561
          DesignSize = (
            561
            50)
          inherited Label16: TLabel
            Font.Height = -12
          end
          inherited Label17: TLabel
            Font.Height = -12
          end
          inherited Bevel3: TBevel
            Width = 577
            ExplicitWidth = 577
          end
          inherited Label21: TLabel
            Font.Height = -12
          end
          inherited CONTACT_INFO: TDBEdit
            Width = 381
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameCONTACT_INFOChange
            ExplicitWidth = 381
            ExplicitHeight = 22
          end
          inherited CODE_WORD: TDBEdit
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameCODE_WORDChange
            ExplicitHeight = 22
          end
          inherited EMAIL: TDBEdit
            Width = 216
            Height = 22
            Font.Height = -12
            OnChange = EditAbonentFrameEMAILChange
            ExplicitWidth = 216
            ExplicitHeight = 22
          end
        end
        inherited qGetNewId: TOraStoredProc
          CommandStoredProcName = 'NEW_ABONENT_ID:0'
        end
      end
      object SaveBtn: TBitBtn
        Left = 619
        Top = 310
        Width = 153
        Height = 29
        Anchors = [akTop, akRight]
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
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
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        OnClick = SaveBtnClick
      end
    end
    object tsSummaryPhone: TTabSheet
      Caption = #1057#1074#1086#1076#1082#1072' '#1087#1086' '#1085#1086#1084#1077#1088#1091
      ImageIndex = 11
      OnShow = tsSummaryPhoneShow
      object gSummaryPhone: TCRDBGrid
        Left = 0
        Top = 0
        Width = 1074
        Height = 540
        Align = alClient
        DataSource = dmShowUserSt.dsSummaryPhone
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = gSummaryPhoneCellClick
        OnDrawColumnCell = gSummaryPhoneDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'IMAGE_BMP'
            Title.Alignment = taCenter
            Title.Caption = '*'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EVENT_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072
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
            FieldName = 'INCOME'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1080#1093#1086#1076
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
            FieldName = 'OUTCOME'
            Title.Alignment = taCenter
            Title.Caption = #1056#1072#1089#1093#1086#1076
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
            FieldName = 'BALANCE'
            Title.Alignment = taCenter
            Title.Caption = #1041#1072#1083#1072#1085#1089
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
            FieldName = 'EVENT'
            Title.Alignment = taCenter
            Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 500
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 500
            Visible = True
          end>
      end
    end
    object tsTariffs: TTabSheet
      Caption = #1058#1072#1088#1080#1092' '#1080' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      ImageIndex = 2
      OnShow = tsTariffsShow
      object Panel8: TPanel
        Left = 0
        Top = 233
        Width = 1074
        Height = 307
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel8'
        TabOrder = 0
        object gPhoneStatuses: TCRDBGrid
          Left = 0
          Top = 0
          Width = 1074
          Height = 307
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alClient
          DataSource = dmShowUserSt.dsPhoneStatuses
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
              Expanded = False
              FieldName = 'BEGIN_DATE'
              Title.Caption = #1053#1072#1095#1072#1083#1086
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'END_DATE'
              Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077
              Width = 120
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
            end
            item
              Expanded = False
              FieldName = 'DATE_LAST_UPDATED'
              Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
              Width = 181
              Visible = True
            end>
        end
      end
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 233
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 680
          Height = 233
          Align = alClient
          BevelOuter = bvSpace
          TabOrder = 0
          object Image1: TImage
            Left = 10
            Top = 130
            Width = 46
            Height = 25
          end
          object Label13: TLabel
            Left = 54
            Top = 38
            Width = 127
            Height = 18
            Alignment = taRightJustify
            Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
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
            DataField = 'V_TARIFF'
            DataSource = dmShowUserSt.dsTariffInfo
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object DB_TXT_NEW_TARIF_INFO: TDBText
            Left = 295
            Top = 38
            Width = 222
            Height = 18
            AutoSize = True
            DataField = 'V_NEW_TARIF'
            DataSource = dmShowUserSt.dsTariffInfo
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object LblState: TLabel
            Left = 55
            Top = 10
            Width = 129
            Height = 18
            Alignment = taRightJustify
            Caption = #1057#1090#1072#1090#1091#1089' '#1090#1072#1088#1080#1092#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = [fsBold, fsItalic, fsUnderline]
            ParentFont = False
            OnClick = LblStateClick
            OnMouseEnter = LblBlueOn
            OnMouseLeave = LblBlueOff
          end
          object lTariffStatusText: TLabel
            Left = 200
            Top = 9
            Width = 70
            Height = 23
            Caption = #1057#1090#1072#1090#1091#1089
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmStatus
          end
          object Label19: TLabel
            Left = 63
            Top = 82
            Width = 121
            Height = 18
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object DBText18: TDBText
            Left = 200
            Top = 82
            Width = 79
            Height = 18
            AutoSize = True
            DataField = 'LAST_CHECK_DATE_TIME'
            DataSource = dmShowUserSt.dsTariffInfo
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object lBlockInfo: TLabel
            Left = 200
            Top = 152
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
          object lCloseNumber: TLabel
            Left = 200
            Top = 176
            Width = 150
            Height = 23
            Caption = 'lCloseNumber'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label25: TLabel
            Left = 45
            Top = 178
            Width = 136
            Height = 18
            Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1075#1086#1074#1086#1088#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label24: TLabel
            Left = 62
            Top = 152
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
          object ContractType: TLabel
            Left = 439
            Top = 9
            Width = 143
            Height = 23
            Alignment = taRightJustify
            Caption = 'ContractType'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Visible = False
          end
          object lCreditLimit: TLabel
            Left = 42
            Top = 106
            Width = 139
            Height = 18
            Hint = 'PhoneDisconnectionLimit'
            Caption = #1050#1088#1077#1076#1080#1090#1085#1099#1081' '#1083#1080#1084#1080#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clPurple
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object vip_group: TLabel
            Left = 498
            Top = 172
            Width = 143
            Height = 25
            Alignment = taRightJustify
            Caption = #1042#1048#1055' '#1075#1088#1091#1087#1087#1072
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -21
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Visible = False
          end
          object pFrame: TPanel
            Left = 110
            Top = 127
            Width = 163
            Height = 25
            BevelOuter = bvNone
            Color = clRed
            ParentBackground = False
            TabOrder = 0
            object lbContract: TLabel
              Left = 5
              Top = 5
              Width = 67
              Height = 16
              Caption = #1044#1086#1075#1086#1074#1086#1088':'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
          end
          object pSpititTelecom: TPanel
            Left = 390
            Top = 89
            Width = 284
            Height = 51
            Color = clRed
            ParentBackground = False
            TabOrder = 1
            Visible = False
            object lSpiritTelecom: TLabel
              Left = 1
              Top = 1
              Width = 282
              Height = 49
              Align = alClient
              Alignment = taCenter
              Caption = 'SpiritTelecom'
              Color = clRed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -35
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ExplicitLeft = 2
              ExplicitTop = 3
              ExplicitWidth = 270
              ExplicitHeight = 42
            end
          end
        end
        object Panel14: TPanel
          Left = 680
          Top = 0
          Width = 394
          Height = 233
          Align = alRight
          Alignment = taRightJustify
          BevelOuter = bvNone
          TabOrder = 1
          object Panel19: TPanel
            Left = 0
            Top = 0
            Width = 240
            Height = 233
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object pBalanceInfo: TPanel
              Left = 0
              Top = 0
              Width = 240
              Height = 48
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              BevelOuter = bvSpace
              TabOrder = 0
              object lBalance: TLabel
                Left = 142
                Top = 4
                Width = 78
                Height = 23
                Alignment = taRightJustify
                Caption = #1041#1072#1083#1072#1085#1089
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object LblBalance: TLabel
                Left = 5
                Top = 9
                Width = 67
                Height = 18
                Hint = #1048#1089#1090#1086#1088#1080#1103' '#1073#1072#1083#1072#1085#1089#1086#1074' '#1089' '#1090#1080#1087#1072#1084#1080' '#1087#1086' '#1087#1088#1072#1074#1086#1081' '#1082#1085#1086#1087#1082#1077' '#1084#1099#1096#1080
                Alignment = taRightJustify
                Caption = #1041#1072#1083#1072#1085#1089':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Verdana'
                Font.Style = [fsBold, fsItalic, fsUnderline]
                ParentFont = False
                ParentShowHint = False
                PopupMenu = PopupMenuBalanceHistory
                ShowHint = False
                OnClick = LblBalanceClick
                OnMouseEnter = LblBlueOn
                OnMouseLeave = LblBlueOff
              end
            end
            object pHandBlock: TPanel
              Left = 0
              Top = 133
              Width = 240
              Height = 100
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              BevelOuter = bvSpace
              TabOrder = 1
              object CbHandBlock: TCheckBox
                Left = 5
                Top = 5
                Width = 175
                Height = 17
                Caption = #1056#1091#1095#1085#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Verdana'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnExit = CbHandBlockExit
              end
            end
            object Panel20: TPanel
              Left = 0
              Top = 48
              Width = 240
              Height = 85
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BevelOuter = bvSpace
              TabOrder = 2
              object RGBlock: TRadioGroup
                Left = 1
                Top = 1
                Width = 238
                Height = 28
                Align = alTop
                BiDiMode = bdRightToLeftNoAlign
                Caption = #1041#1083#1086#1082' '#1092#1091#1085#1082#1094#1080#1080
                Columns = 3
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -9
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentBiDiMode = False
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
              end
              object cbDailyAbonPay: TCheckBox
                Left = 5
                Top = 35
                Width = 178
                Height = 14
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = #1055#1086#1089#1091#1090#1086#1095#1085#1072#1103' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                OnClick = cbDailyAbonPayClick
              end
              object cbDailyAbonPayBanned: TCheckBox
                Left = 5
                Top = 54
                Width = 184
                Height = 13
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = #1047#1072#1087#1088#1077#1090' '#1087#1086#1089#1091#1090'.'#1072#1073#1086#1085'.'#1087#1083#1072#1090#1099
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                OnClick = cbDailyAbonPayBannedClick
              end
            end
          end
          object pTariffInfoButton: TPanel
            Left = 240
            Top = 0
            Width = 154
            Height = 233
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alRight
            BevelOuter = bvSpace
            TabOrder = 1
            object BtBlock: TButton
              Left = 4
              Top = 4
              Width = 146
              Height = 25
              Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
              TabOrder = 0
              OnClick = BtBlockClick
            end
            object BtUnBlock: TButton
              Left = 4
              Top = 32
              Width = 146
              Height = 25
              Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
              TabOrder = 1
              OnClick = BtUnBlockClick
            end
            object BlockListBt: TButton
              Left = 4
              Top = 59
              Width = 146
              Height = 25
              Caption = #1057#1087#1080#1089#1086#1082' '#1073#1083#1086#1082'. '#1085#1086#1084#1077#1088#1086#1074
              TabOrder = 2
              OnClick = BlockListBtClick
            end
            object BtSendSms: TButton
              Left = 5
              Top = 115
              Width = 146
              Height = 25
              Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1084#1089
              TabOrder = 3
              OnClick = BtSendSmsClick
            end
            object BtSetPassword: TButton
              Left = 5
              Top = 170
              Width = 146
              Height = 25
              Caption = #1047#1072#1076#1072#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1086#1090' '#1082#1072#1073#1080#1085#1077#1090#1072
              TabOrder = 4
              OnClick = BtSetPasswordClick
            end
            object BtSetPasswordOk: TButton
              Left = 116
              Top = 170
              Width = 34
              Height = 25
              Caption = #1054#1082
              TabOrder = 5
              Visible = False
              OnClick = BtSetPasswordOkClick
            end
            object UnBlockListBt: TButton
              Left = 5
              Top = 87
              Width = 146
              Height = 25
              Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1079#1073#1083#1086#1082'. '#1085#1086#1084#1077#1088#1086#1074
              TabOrder = 6
              OnClick = UnBlockListBtClick
            end
            object eSetPassword: TEdit
              Left = 9
              Top = 170
              Width = 107
              Height = 24
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              Visible = False
              OnKeyPress = eSetPasswordKeyPress
            end
          end
        end
      end
    end
    object tsBalanceRows: TTabSheet
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1072#1083#1072#1085#1089#1072
      ImageIndex = 6
      OnShow = tsBalanceRowsShow
      object CRDBGrid5: TCRDBGrid
        Left = 0
        Top = 40
        Width = 1074
        Height = 500
        OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
        Align = alClient
        DataSource = dmShowUserSt.dsBalanceRows
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
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 40
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        object Ds: TBitBtn
          Left = 13
          Top = 7
          Width = 111
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
          TabOrder = 0
          OnClick = DsClick
        end
        object cbEXCLUDE_DETAIL: TsCheckBox
          Left = 584
          Top = 14
          Width = 204
          Height = 20
          Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080' '#1080#1079' '#1073#1072#1083#1072#1085#1089#1072
          Enabled = False
          TabOrder = 1
          Visible = False
          OnClick = cbEXCLUDE_DETAILValueChanged
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
    end
    object tsPayments: TTabSheet
      Caption = #1055#1083#1072#1090#1077#1078#1080
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 1074
        Height = 540
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = tsPaymentsReal
        Align = alClient
        TabOrder = 0
        object tsPaymentsReal: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1083#1072#1090#1077#1078#1080' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          OnShow = tsPaymentsRealShow
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 1066
            Height = 512
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object gPayments: TCRDBGrid
              Left = 0
              Top = 0
              Width = 1066
              Height = 512
              OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
              Align = alClient
              DataSource = dmShowUserSt.dsPayments
              PopupMenu = PopupMenu1
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnCellClick = gPaymentsCellClick
              OnDblClick = gPaymentsDblClick
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
                  Width = 100
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
                  Width = 100
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
                  Width = 200
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
                  Width = 53
                  Visible = True
                end
                item
                  ButtonStyle = cbsEllipsis
                  Expanded = False
                  FieldName = 'CREATED_DATE'
                  Title.Alignment = taCenter
                  Title.Caption = #1042#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1074' '#1058#1072#1088#1080#1092#1077#1088
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = [fsBold]
                  Width = 203
                  Visible = True
                end>
            end
            object MonthCalendar1: TMonthCalendar
              Left = 128
              Top = 64
              Width = 191
              Height = 160
              Date = 41584.469618865740000000
              TabOrder = 1
              TabStop = True
              Visible = False
              OnDblClick = MonthCalendar1DblClick
              OnMouseLeave = MonthCalendar1MouseLeave
            end
          end
        end
      end
    end
    object tsBills: TTabSheet
      Caption = #1057#1095#1077#1090#1072
      ImageIndex = 4
      object PageControl4: TPageControl
        Left = 0
        Top = 0
        Width = 1074
        Height = 540
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = tsBillsNewFormat
        Align = alClient
        TabOrder = 0
        object tsBillsNewFormat: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1086#1074#1099#1081' '#1092#1086#1088#1084#1072#1090'('#1089' '#1072#1074#1075#1091#1089#1090#1072' 2012)'
          ImageIndex = 1
          OnShow = tsBillsNewFormatShow
          object PageControl5: TPageControl
            Left = 0
            Top = 0
            Width = 1066
            Height = 512
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ActivePage = tsBillClientNew
            Align = alClient
            TabOrder = 0
            object tsBillBeeline: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1057#1095#1077#1090#1072' '#1041#1080#1083#1072#1081#1085#1072
              OnShow = tsBillBeelineShow
              object pBillBeeline: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 0
                object btBillBeeline: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = btBillBeelineClick
                end
              end
              object grBillBeeline: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                DataSource = dmShowUserSt.dsBillBeeline
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = [fsBold]
              end
            end
            object tsBillClientNew: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1057#1095#1077#1090#1072' '#1082#1083#1080#1077#1085#1090#1091
              ImageIndex = 1
              OnShow = tsBillClientNewShow
              object pBillClientNew: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 0
                object btBillClientNew: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = btBillClientNewClick
                end
              end
              object grBillClientNew: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                DataSource = dmShowUserSt.dsBillClientNew
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = [fsBold]
              end
            end
            object tsAbonPeriodList: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1055#1077#1088#1080#1086#1076#1099' '#1072#1073#1086#1085'. '#1072#1082#1090'.'
              ImageIndex = 2
              OnShow = tsAbonPeriodListShow
              object pAbonPeriodList: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 0
                object btAbonPeriodList: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = btAbonPeriodListClick
                end
              end
              object grAbonPeriodList: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                DataSource = dmShowUserSt.dsAbonPeriodList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = [fsBold]
              end
            end
            object tsRouming: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1056#1086#1091#1084#1080#1085#1075
              ImageIndex = 3
              OnShow = tsRoumingShow
              object pRouming: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 0
                object btRouming: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = btRoumingClick
                end
              end
              object grRouming: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                DataSource = dmShowUserSt.dsRouming
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = [fsBold]
              end
            end
          end
        end
        object tsBillsOldFormat: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1090#1072#1088#1099#1081' '#1092#1086#1088#1084#1072#1090'('#1076#1086' '#1080#1102#1083#1103' 2012)'
          object PageControl3: TPageControl
            Left = 0
            Top = 0
            Width = 1066
            Height = 512
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ActivePage = tsOperatorBills
            Align = alClient
            TabOrder = 0
            object tsOperatorBills: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1057#1095#1077#1090#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
              OnShow = tsOperatorBillsShow
              object CRDBGrid4: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
                OnGetCellParams = CRDBGrid4GetCellParams
                Align = alClient
                DataSource = dmShowUserSt.dsBills
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
                    FieldName = 'OTHER_COUNTRY_ROAMING_CALLS'
                    Title.Alignment = taCenter
                    Title.Caption = #1052'/'#1085' '#1088'. '#1079#1074'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'OTHER_COUNTRY_ROAMING_MESSAGES'
                    Title.Alignment = taCenter
                    Title.Caption = #1052'/'#1085' '#1088'. '#1057#1052#1057'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'OTHER_COUNTRY_ROAMING_INTERNET'
                    Title.Alignment = taCenter
                    Title.Caption = #1052'/'#1085' '#1088'. '#1080#1085#1090'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
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
                    FieldName = 'NATIONAL_ROAMING_CALLS'
                    Title.Alignment = taCenter
                    Title.Caption = #1053#1072#1094'.'#1088'. '#1079#1074'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'NATIONAL_ROAMING_MESSAGES'
                    Title.Alignment = taCenter
                    Title.Caption = #1053#1072#1094'.'#1088'. '#1057#1052#1057'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'NATIONAL_ROAMING_INTERNET'
                    Title.Alignment = taCenter
                    Title.Caption = #1053#1072#1094'.'#1088'. '#1080#1085#1090'.('#1087#1072#1088'.)'
                    Title.Font.Charset = DEFAULT_CHARSET
                    Title.Font.Color = clWindowText
                    Title.Font.Height = -12
                    Title.Font.Name = 'MS Sans Serif'
                    Title.Font.Style = [fsBold]
                    Width = 60
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
              object Panel13: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 1
                object BitBtn6: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = BitBtn6Click
                end
              end
            end
            object tsClientBills: TTabSheet
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1057#1095#1077#1090#1072' '#1082#1083#1080#1077#1085#1090#1072
              ImageIndex = 10
              OnShow = tsClientBillsShow
              object CRDBGridClientBills: TCRDBGrid
                Left = 0
                Top = 40
                Width = 1058
                Height = 444
                OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
                OnGetCellParams = CRDBGrid4GetCellParams
                Align = alClient
                DataSource = dmShowUserSt.dsClientBills
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = [fsBold]
              end
              object Panel10: TPanel
                Left = 0
                Top = 0
                Width = 1058
                Height = 40
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alTop
                TabOrder = 1
                object btBillClient: TBitBtn
                  Left = 13
                  Top = 7
                  Width = 111
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
                  TabOrder = 0
                  OnClick = btBillClientClick
                end
              end
            end
          end
        end
      end
    end
    object tsOptions: TTabSheet
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1091#1089#1083#1091#1075#1080
      ImageIndex = 5
      OnShow = tsOptionsShow
      object SplitterOptions: TSplitter
        Left = 0
        Top = 254
        Width = 1074
        Height = 4
        Cursor = crVSplit
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        ExplicitWidth = 960
      end
      object pCurrentOptions: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 254
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'pCurrentOptions'
        TabOrder = 0
        object pOptions: TPanel
          Left = 1
          Top = 1
          Width = 1072
          Height = 53
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 0
          object cbPeriodsOpt: TComboBox
            Left = 7
            Top = 2
            Width = 130
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            DropDownCount = 25
            TabOrder = 0
            OnChange = cbPeriodsOptChange
          end
          object btRefreshOptionList: TBitBtn
            Left = 142
            Top = 0
            Width = 201
            Height = 25
            Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1091#1089#1083#1091#1075#1080
            TabOrder = 1
            OnClick = BGet_api_servicesClick
          end
          object btAPITurnOnServises: TBitBtn
            Left = 342
            Top = 0
            Width = 177
            Height = 25
            Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100' '#1091#1089#1083#1091#1075#1091
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = btAPITurnOnServisesClick
          end
        end
        object CRDBGrid2: TCRDBGrid
          Left = 1
          Top = 54
          Width = 1072
          Height = 199
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          OnGetCellParams = CRDBGrid2GetCellParams
          Align = alClient
          DataSource = dmShowUserSt.dsOptions
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnCellClick = CRDBGrid2CellClick
          OnColEnter = CRDBGrid2ColEnter
          OnDblClick = CRDBGrid2DblClick
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
      object pOptionHistory: TPanel
        Left = 0
        Top = 258
        Width = 1074
        Height = 282
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Caption = 'pOptionHistory'
        TabOrder = 1
        object CRDBGridOptionHistory: TCRDBGrid
          Left = 1
          Top = 1
          Width = 1072
          Height = 280
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          OnGetCellParams = CRDBGridOptionHistoryGetCellParams
          Align = alClient
          DataSource = dmShowUserSt.dsAPIOptionHistory
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -14
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
        end
      end
    end
    object tsDetail: TTabSheet
      Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080
      OnShow = tsDetailShow
      object Splitter1: TSplitter
        Left = 0
        Top = 224
        Width = 1074
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 960
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 224
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object CRDBGrid1: TCRDBGrid
          Left = 0
          Top = 0
          Width = 313
          Height = 224
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alLeft
          DataSource = dmShowUserSt.dsPeriods
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
          Left = 313
          Top = 0
          Width = 761
          Height = 224
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Panel16: TPanel
            Left = 558
            Top = 0
            Width = 203
            Height = 224
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
          end
          object Panel17: TPanel
            Left = 0
            Top = 0
            Width = 558
            Height = 224
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object gStatistic: TStringGrid
              Left = 0
              Top = 26
              Width = 558
              Height = 198
              Align = alClient
              ColCount = 2
              DefaultColWidth = 120
              FixedRows = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object Panel18: TPanel
              Left = 0
              Top = 0
              Width = 558
              Height = 26
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object Label1: TLabel
                Left = 8
                Top = 5
                Width = 104
                Height = 18
                Alignment = taRightJustify
                Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1086' :'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Verdana'
                Font.Style = [fsBold, fsItalic, fsUnderline]
                ParentFont = False
                OnClick = Label1Click
                OnMouseEnter = LblBlueOn
                OnMouseLeave = LblBlueOff
              end
              object DBText1: TDBText
                Left = 118
                Top = 6
                Width = 77
                Height = 18
                Alignment = taRightJustify
                AutoSize = True
                DataField = 'ESTIMATE_SUM'
                DataSource = dmShowUserSt.dsPeriods
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBText12: TDBText
                Left = 375
                Top = 6
                Width = 60
                Height = 14
                Alignment = taRightJustify
                AutoSize = True
                DataField = 'LAST_CHECK_DATE_TIME'
                DataSource = dmShowUserSt.dsPeriods
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Verdana'
                Font.Style = []
                ParentFont = False
              end
            end
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 227
        Width = 1074
        Height = 67
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
          Left = 737
          Top = 3
          Width = 145
          Height = 29
          Action = aSaveDetail
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
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
          TabOrder = 0
        end
        object BitBtn2: TBitBtn
          Left = 85
          Top = 3
          Width = 146
          Height = 29
          Action = aOpenDetailInExcel
          Align = alCustom
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
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
          TabOrder = 1
        end
        object BitBtn3: TBitBtn
          Left = 440
          Top = 3
          Width = 219
          Height = 29
          Align = alCustom
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1102' '#1079#1072' '#1090#1077#1082'. '#1087#1077#1088#1080#1086#1076
          TabOrder = 2
          OnClick = BitBtn3Click
        end
        object BitBtn5: TBitBtn
          Left = 665
          Top = 3
          Width = 75
          Height = 29
          Caption = 'SMS/USSD'
          TabOrder = 3
          OnClick = BitBtn5Click
        end
        object btUnload: TBitBtn
          Left = 266
          Top = 32
          Width = 145
          Height = 29
          Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1102' '#1074' '#1092#1072#1081#1083
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00CECE
            CE00CECECE00CECECE00CECECE00CECECE00F7F7F700F7F7F700CECECE00CECE
            CE00CECECE00CECECE00CECECE00CECECE00CECECE00FF00FF00C6AD7300B584
            1800B5841000B57B0000D6CED600DECECE00CECECE00CEBDAD00DECECE00D6CE
            C600D6CEC600D6CED600B57B0000B5841000B5841800C6AD7300B5841800F7CE
            8C00F7C67B00F7C67300FFF7FF00FFFFFF004A4A4A009C949400FFFFFF00F7EF
            EF00F7EFEF00FFF7FF00F7C67300F7C67B00F7CE8C00B5841800B5841000F7CE
            8400EFBD6B00EFB56300FFF7F700FFFFFF004A424200948C8C00FFFFFF00F7EF
            E700F7E7E700F7F7F700EFB56300EFBD6B00F7CE8400B5841000B5841000F7CE
            8C00EFB56300E7B55200FFFFFF00FFF7F700847B7B004A424200FFF7F700EFE7
            DE00EFE7DE00FFF7FF00EFB55200EFB56300F7CE8C00B5841000B5841000F7CE
            8C00EFB55A00E7AD5200FFFFFF00EFE7D600F7E7DE00F7E7DE00EFE7D600EFDE
            D600EFDED600FFFFFF00E7AD5200EFB55A00F7CE8C00B5841000B5841000F7CE
            9400E7AD5200E7AD4A00E7CEA500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00E7CEA500E7AD4A00E7AD5200F7CE9400B5841000B5841000F7D6
            9C00E7AD4200E7A54200E7A53100E79C2900E79C2900E79C2900E79C2900E79C
            2900E79C2900E7A53100E7A54200E7AD4200F7D69C00B5841000B5841000F7D6
            A500E7A53100F7DEB500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00F7DEB500E7A53100F7D6A500B5841000B5841000F7DE
            A500E79C2100FFFFFF00FFFFF700FFFFEF00FFFFEF00FFFFF700FFFFF700FFFF
            EF00FFFFEF00FFFFF700FFFFFF00E79C2100F7DEA500B5841000B5841000FFDE
            B500E79C1800FFFFFF007B7B7B00A5A5A500FFF7EF007B7B7B00A5A5A500A59C
            A500FFF7EF009C9CA500FFFFF700E79C1800FFDEB500B5841000B5841000FFE7
            BD009C630000FFFFFF00FFF7EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7
            E700FFF7E700FFF7E700FFFFF7009C630000FFE7BD00B5841000B5841000FFEF
            C60073420000FFFFFF007B7B7B007B7B7B00A5A5A5009C9C9C00F7EFDE007373
            7300A5A5A5009C9CA500FFFFFF0073420000FFEFC600B5841000B5841000FFEF
            D600DE840000FFFFFF00F7E7DE00F7E7DE00F7E7D600F7E7D600EFE7D600F7E7
            D600F7E7D600EFE7D600FFFFFF00DE840000FFEFD600B5841000B5841000FFEF
            CE00FFE7C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFE7C600FFEFCE00B5841000DEC68C00B584
            1000B57B0800B57B0800B57B0800B57B0800B57B0800B57B0800B57B0800B57B
            0800B57B0800B57B0800B57B0800B57B0800B5841000DEC68C00}
          TabOrder = 4
          OnClick = btUnloadClick
        end
        object BUnbilledCallsList: TButton
          Left = 746
          Top = 36
          Width = 145
          Height = 25
          Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1076#1077#1090#1072#1083'. '#1080#1079' '#1040#1055#1048' '
          TabOrder = 5
          OnClick = BUnbilledCallsListClick
        end
        object cbHideZeroCall: TCheckBox
          Tag = 1
          Left = 422
          Top = 44
          Width = 170
          Height = 17
          Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1087#1083#1072#1090#1085#1099#1077
          TabOrder = 6
          OnClick = cbHideZeroCallClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 294
        Width = 1074
        Height = 246
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object dbgDetail: TCRDBGrid
          Left = 0
          Top = 0
          Width = 1074
          Height = 246
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alClient
          DataSource = dmShowUserSt.dsDetail
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
              FieldName = 'DURATION_MIN'
              Title.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100'('#1084#1080#1085')'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 120
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
              FieldName = 'BS_PLACE'
              Title.Caption = #1047#1086#1085#1072' '#1041#1057
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 304
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INSERT_DATE'
              Title.Caption = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
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
              FieldName = 'SOURCE_FILE_NAME'
              Title.Caption = #1048#1089#1090#1086#1095#1085#1080#1082
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 60
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
    object tsRest: TTabSheet
      Caption = #1054#1089#1090#1072#1090#1082#1080' '#1087#1086' '#1087#1072#1082#1077#1090#1072#1084
      ImageIndex = 12
      object gRest: TCRDBGrid
        Left = 0
        Top = 41
        Width = 1074
        Height = 499
        Align = alClient
        DataSource = dmShowUserSt.dsRests
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
            FieldName = 'REST_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1055#1072#1082#1077#1090
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1059#1089#1083#1091#1075#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SOC'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1091#1089#1083#1091#1075#1080' ('#1074' '#1041#1080#1083#1072#1081#1085#1077')'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SPENT'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1090#1088#1072#1095#1077#1085#1086
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
            FieldName = 'CURR_VALUE'
            Title.Alignment = taCenter
            Title.Caption = #1054#1089#1090#1072#1090#1086#1082
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INITIAL_SIZE'
            Title.Alignment = taCenter
            Title.Caption = #1042#1089#1077#1075#1086
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 64
            Visible = True
          end>
      end
      object pRest: TPanel
        Left = 0
        Top = 0
        Width = 1074
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        object btnaOpenDetailInExcel: TBitBtn
          Left = 553
          Top = 0
          Width = 521
          Height = 41
          Action = aOpenDetailInExcel
          Align = alClient
          Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
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
          TabOrder = 0
        end
        object btRefresh: TBitBtn
          Left = 0
          Top = 0
          Width = 553
          Height = 41
          Align = alLeft
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
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
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400BD733900C673
            3900C6733900C67B4200C6733900BD6B3100BD7B4A00BD9C8400FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00D6AD9C00BD6B3100C6844A00DE9C5A00DE9C
            5A00DE9C5200DE9C5200DE944A00DE8C4200D6843900C6733100BD734200B5AD
            A500BD9C8C00BD6B3100BD6B3100FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00D6AD9C00BD6B3900DEAD7300E7B57300E7AD7300DEAD
            6B00E7B57B00E7BD8C00E7BD8C00DEA56300D68C4200DE8C3900CE7B3100B563
            2900B5632900C66B1800BD5A1800B58C7300FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00DEBDAD00B5633100E7B57B00E7BD8400E7B57B00E7B58400DEAD
            7B00D6A56B00D6945A00DEA57300E7BD9400EFCEA500DEA56300D68C3900D684
            3100CE7B2100CE731800B55A1800B57B5200FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00B55A3100DEB58400E7BD8C00E7BD8400D6A56B00BD6B3900AD52
            2100BD7B5200CE9C7B00BD6B4200AD522100C6733900DEA56300D68C4200CE84
            2900CE7B2100CE7B1800B55A1800AD633900FF00FF00FF00FF00FF00FF00FF00
            FF00CE947B00CE946B00EFC69C00E7BD8C00CE946300AD5A2900C69C8400FF00
            FF00FF00FF00FF00FF00FF00FF00D6B5A500A54A1800CE7B3100D6843100CE84
            2900CE7B2100CE7B1800BD631800AD522100FF00FF00FF00FF00FF00FF00FF00
            FF00A5522900EFCEA500EFC69400CE946300AD5A2900BD9C8C00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00A5522100CE8C4A00D68C3900D6843100CE84
            2900CE7B2100CE7B1800C66B2100A54A1800FF00FF00FF00FF00FF00FF00FF00
            FF00B56B4200F7D6B500E7BD8C00C67B4A00A5633900FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00D6A59400BD734200F7E7CE00EFC69C00D6944200CE84
            2900CE7B2100CE7B1800C66B2100A54A1800BDADA500FF00FF00FF00FF00CEA5
            8C00CE9C7B00F7DEBD00D69C6B00B56B4200AD8C7B00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00B56B4A00A54A2100D69C6B00EFCEAD00DEAD
            7300CE842900CE7B1800CE732100A54A1800B5948C00FF00FF00FF00FF00CEA5
            9400CE947300F7DEC600D6945A00AD633900B59C8C00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEC600A55A3100A5522100D69C
            6300E7BD8400D6944200CE7B2100AD521000A57B6B00FF00FF00FF00FF00CEAD
            9C00C68C6B00F7E7CE00D69C6300AD633900AD8C8400FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBDAD009C4A
            2100A5522100D6945200DEA56300B5631800A56B5200FF00FF00FF00FF00D6AD
            A500BD7B5A00FFF7E700DEA56B00C67B4A009C5A4200FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00CEA5940094391800AD521800B55A1800A5634A00FF00FF00FF00FF00FF00
            FF008C311800FFEFE700EFCEAD00D6844A008C311000ADA59C00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00C6948400A55A3900FF00FF00FF00FF00FF00FF00FF00
            FF00AD735A00D6AD8C00FFEFDE00DE9C6300C6844A0084311000AD9C9C00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BDB500AD8C8400B5A5A500FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF008C391800FFF7EF00EFD6B500D6945200C6844A00842908009452
            4200A58C8400AD948C00A5847B008C422900842908009439100084210800A584
            7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00A5635200B57B5A00FFF7F700EFCEA500DE9C5A00CE844A00BD73
            39009C4A29009C4A21009C4A2100BD6B3100C67B3100B55A2100A55218008C39
            1800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF009C523900BD846300FFF7E700F7E7CE00E7B58400DE9C
            5A00D6945200CE8C4A00D6944A00D6944A00D6944200D68C4200AD5A29008C39
            2100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00AD6B520094392100DEBD9C00F7E7D600FFEF
            E700F7DEC600EFC69C00E7BD8400E7C69400DEAD7B00BD7B4A0084290800CEAD
            A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00D6BDB500944229007B1800009439
            1800B57B5200CE9C7B00BD845A00A55A310084290800A5634A00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEA5
            9C00B5847300AD735A00BD8C8400CEADA500FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          TabOrder = 1
          OnClick = btRefreshClick
        end
      end
    end
    object tsDiscount: TTabSheet
      Caption = #1057#1082#1080#1076#1082#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
      ImageIndex = 8
      OnShow = tsDiscountShow
      object dbtEndDate: TDBText
        Left = 88
        Top = 92
        Width = 83
        Height = 16
        AutoSize = True
        DataField = 'DISCOUNT_END_DATE'
        DataSource = dmShowUserSt.dsDiscount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
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
        DataSource = dmShowUserSt.dsDiscount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
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
        Font.Height = -15
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
        Font.Height = -15
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
        Font.Height = -15
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
        Font.Height = -15
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
        Font.Height = -15
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
        DataSource = dmShowUserSt.dsDiscount
        TabOrder = 3
      end
    end
    object tsDopInfo: TTabSheet
      Caption = #1044#1086#1087'.'#1080#1085#1092#1086
      ImageIndex = 10
      OnShow = tsDopInfoShow
      DesignSize = (
        1074
        540)
      object blCaptionHLR: TLabel
        Left = 64
        Top = 27
        Width = 54
        Height = 23
        Alignment = taRightJustify
        Caption = 'IMSI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object lbIMSI_NUMBER: TDBText
        Left = 124
        Top = 27
        Width = 446
        Height = 22
        DataField = 'IMSI_NUMBER'
        DataSource = dmShowUserSt.dsDopPhoneInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbCaptionSIM: TLabel
        Left = 72
        Top = 63
        Width = 46
        Height = 23
        Alignment = taRightJustify
        Caption = 'SIM:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object LChangeSIM: TLabel
        Left = 5
        Top = 118
        Width = 113
        Height = 23
        Alignment = taRightJustify
        Caption = #1057#1084#1077#1085#1072' SIM:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object lZayavkiAPI: TLabel
        Left = 4
        Top = 159
        Width = 226
        Height = 18
        Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1103#1074#1086#1082' '#1074' API '#1087#1086' '#1085#1086#1084#1077#1088#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblAPI_LOG: TLabel
        Left = 834
        Top = 159
        Width = 226
        Height = 18
        Anchors = [akTop]
        Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1103#1074#1086#1082' '#1074' API '#1087#1086' '#1085#1086#1084#1077#1088#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = lblAPI_LOGClick
        OnMouseEnter = LblBlueOn
        OnMouseLeave = LblBlueOff
        ExplicitLeft = 732
      end
      object EChangeSIM: TEdit
        Left = 124
        Top = 118
        Width = 257
        Height = 32
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 18
        ParentFont = False
        TabOrder = 0
        OnKeyPress = eNewBlockHBKeyPress
      end
      object BChangeSIM: TButton
        Left = 385
        Top = 118
        Width = 88
        Height = 32
        Caption = #1057#1084#1077#1085#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BChangeSIMClick
      end
      object BChangeSIMHist: TButton
        Left = 475
        Top = 118
        Width = 89
        Height = 32
        Caption = #1048#1089#1090#1086#1088#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = BChangeSIMHistClick
      end
      object DBEdit1: TDBEdit
        Left = 124
        Top = 63
        Width = 417
        Height = 24
        BorderStyle = bsNone
        DataField = 'SIM_NUMBER'
        DataSource = dmShowUserSt.dsDopPhoneInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object pnlAPI: TPanel
        Left = 0
        Top = 209
        Width = 1074
        Height = 331
        Align = alBottom
        TabOrder = 4
        object crgApiTickets: TCRDBGrid
          Left = 1
          Top = 1
          Width = 726
          Height = 329
          Align = alClient
          DataSource = dmShowUserSt.dsApiTickets
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          Columns = <
            item
              Expanded = False
              FieldName = 'TYPE_REQ'
              Title.Caption = #1058#1080#1087
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STATE_REQ'
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COMMENTS'
              Title.Caption = #1055#1086#1076#1088#1086#1073#1085#1086
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'USER_CREATED'
              Title.Caption = #1057#1086#1079#1076#1072#1090#1077#1083#1100
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATE_CREATE'
              Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATE_UPDATE'
              Title.Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
              Width = 100
              Visible = True
            end>
        end
        object dbgAPI_LOG: TCRDBGrid
          Left = 727
          Top = 1
          Width = 346
          Height = 329
          Align = alRight
          DataSource = dmShowUserSt.dsApi_log
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dbgAPI_LOGDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'INSERT_DATE'
              Title.Caption = #1042#1088#1077#1084#1103
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
              FieldName = 'REQ_SOURCE'
              Title.Caption = #1044#1077#1090#1072#1083#1100#1085#1086#1089#1090#1100
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOAD_TYPE'
              Title.Caption = #1058#1080#1087' '#1079#1072#1075#1088#1091#1079#1082#1080
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 120
              Visible = True
            end>
        end
      end
      object DpLogAPI: TsDateEdit
        Left = 648
        Top = 160
        Width = 109
        Height = 21
        AutoSize = False
        EditMask = '!99/99/9999;1; '
        MaxLength = 10
        TabOrder = 5
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'EDIT'
        GlyphMode.Blend = 0
        GlyphMode.Grayed = False
        DefaultToday = True
        DialogTitle = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
        Weekends = []
      end
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList16
    Left = 80
    Top = 97
    object aSaveDetail: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1102' '#1074' '#1092#1072#1081#1083
      ImageIndex = 8
      Visible = False
    end
    object aOpenDetailInExcel: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
      OnExecute = aOpenDetailInExcelExecute
    end
    object aLinkPayment: TAction
      Category = 'Payments'
      Caption = #1055#1088#1080#1082#1088#1077#1087#1080#1090#1100' '#1087#1083#1072#1090#1105#1078
    end
    object aUnlinkPayment: TAction
      Category = 'Payments'
      Caption = #1054#1090#1082#1088#1077#1087#1080#1090#1100' '#1087#1083#1072#1090#1105#1078
    end
    object aAddPayment: TAction
      Category = 'Payments'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100'...'
    end
  end
  object sdDetail: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1060#1072#1081#1083#1099' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1060#1072#1081#1083' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080
    Left = 160
    Top = 148
  end
  object MainMenu1: TMainMenu
    Left = 512
    Top = 608
  end
  object OpenDialog1: TOpenDialog
    Left = 160
    Top = 96
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ImageList24
    Left = 592
    Top = 616
    object B1: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1090#1091' '#1087#1083#1072#1090#1077#1078#1072
      ImageIndex = 6
      OnClick = B1Click
    end
  end
  object pmStatus: TPopupMenu
    Left = 168
    Top = 288
    object RemoveStatusMenu: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      OnClick = RemoveStatusMenuClick
    end
  end
  object PopupMenuBalanceHistory: TPopupMenu
    Left = 160
    Top = 208
    object N1: TMenuItem
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1073#1072#1083#1072#1085#1089#1086#1074' '#1087#1086' '#1074#1080#1076#1072#1084' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    end
  end
end
