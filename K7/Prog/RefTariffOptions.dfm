inherited RefTariffOptionsForm: TRefTariffOptionsForm
  Caption = #1058#1072#1088#1080#1092#1085#1099#1077' '#1086#1087#1094#1080#1080
  ClientHeight = 502
  ClientWidth = 1146
  Position = poScreenCenter
  OnCreate = FormCreate
  ExplicitWidth = 1154
  ExplicitHeight = 529
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 304
    Width = 5
    Height = 1139
    Align = alNone
  end
  inherited Panel1: TPanel
    Width = 1146
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 1146
    inherited ToolBar1: TToolBar
      Width = 1146
      ExplicitWidth = 1146
    end
  end
  inherited Panel2: TPanel
    Width = 1146
    Height = 282
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 1146
    ExplicitHeight = 282
    object Splitter3: TSplitter [0]
      Left = 940
      Top = 1
      Height = 280
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
    end
    inherited CRDBGrid1: TCRDBGrid
      Width = 939
      Height = 280
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ParentFont = False
      TitleFont.Style = [fsBold]
      OnCellClick = CRDBGrid1CellClick
      OnDrawColumnCell = CRDBGrid1DrawColumnCell
      OnKeyUp = CRDBGrid1KeyUp
      OnMouseUp = CRDBGrid1MouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'OPERATOR_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPTION_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KOEF_KOMISS'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1101#1092'. '#1076#1080#1083#1077#1088#1072#1084
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPTION_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 305
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DISCR_SPISANIE'
          Title.Alignment = taCenter
          Width = 143
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAN_BE_TURNED_BY_OPERATOR'
          Title.Alignment = taCenter
          Width = 151
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPTION_NAME_FOR_AB'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1094#1080#1080' '#1076#1083#1103' SMS'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAN_BE_TURNED_BY_ABONENT'
          Title.Alignment = taCenter
          Title.Caption = #1059#1089#1083#1091#1075#1072' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1072' '#1072#1073#1086#1085#1077#1085#1090#1086#1084' '#1089#1072#1084#1086#1089#1090#1086#1103#1090#1077#1083#1100#1085#1086
          Width = 366
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USSD_TURN_ON_COMMAND'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1072#1085#1076#1072' USSD '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1091#1089#1083#1091#1075#1080
          Width = 245
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USSD_TURN_OFF_COMMAND'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1072#1085#1076#1072' USSD '#1076#1083#1103' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1091#1089#1083#1091#1075#1080
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_AUTO_INTERNET'
          Title.Caption = #1040#1074#1090'.'#1076#1086#1087'.'#1087#1072#1082'.'#1080#1085#1090#1077#1088#1085#1077#1090
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'internet_volume'
          Title.Caption = #1054#1073#1098#1105#1084' '#1076#1086#1089#1090'.'#1090#1088#1072#1092#1080#1082#1072
          Width = 138
          Visible = True
          FloatFormat = ffNumber
        end
        item
          Expanded = False
          FieldName = 'IS_UNLIM_INTERNET'
          Title.Caption = #1041#1077#1079#1083#1080#1084#1080#1090#1085#1099#1081' '#1080#1085#1090#1077#1088#1085#1077#1090
          Width = 143
          Visible = True
          FloatFormat = ffNumber
        end
        item
          Expanded = False
          FieldName = 'SHOW_IN_PRIVATE_OFFICE_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1074' '#1051#1050' '#1072#1073#1086#1085#1077#1085#1090#1072
          Width = 174
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 943
      Top = 1
      Width = 202
      Height = 280
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'Panel3'
      TabOrder = 1
      object CRDBGrid2: TCRDBGrid
        Left = 1
        Top = 33
        Width = 200
        Height = 246
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsTariffOptNo
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'OPTION_CODE'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -14
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPTION_NAME'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -14
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 200
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 200
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        object btFindOptions: TBitBtn
          Left = 4
          Top = 5
          Width = 100
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1072#1081#1090#1080' '#1091#1089#1083#1091#1075#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btFindOptionsClick
        end
        object btSaveSpisok: TBitBtn
          Left = 109
          Top = 5
          Width = 81
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btSaveSpisokClick
        end
      end
    end
  end
  object pcOptionsCost: TPageControl [3]
    Left = 0
    Top = 309
    Width = 1146
    Height = 193
    ActivePage = tOptionCost
    Align = alBottom
    TabOrder = 2
    object tOptionCost: TTabSheet
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1072#1088#1080#1092#1085#1099#1093' '#1086#1087#1094#1080#1081
      object Splitter2: TSplitter
        Left = 722
        Top = 0
        Width = 4
        Height = 165
        ExplicitHeight = 168
      end
      object gTariffOptionCosts: TCRDBGrid
        Left = 0
        Top = 0
        Width = 722
        Height = 165
        Align = alLeft
        DataSource = dsTariffOptionCosts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnDblClick = CRDBGrid1DblClick
        OnKeyDown = CRDBGrid1KeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'BEGIN_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1074#1082#1083#1102#1095#1077#1085#1080#1103
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'END_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1074#1099#1082#1083#1102#1095#1077#1085#1080#1103
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TURN_ON_COST'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
            Width = 117
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTHLY_COST'
            Title.Alignment = taCenter
            Title.Caption = #1040#1073#1086#1085#1055#1083#1072#1090#1072
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPERATOR_TURN_ON_COST'
            Title.Caption = #1055#1086#1076#1082#1083' '#1091' '#1054#1087#1077#1088#1072#1090#1086#1088#1072
            Width = 119
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPERATOR_MONTHLY_COST'
            Title.Caption = #1040#1073#1086#1085#1055#1083#1072#1090#1072' '#1091' '#1054#1087#1077#1088#1072#1090#1086#1088#1072
            Width = 147
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATE_LAST_UPDATED'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
            Width = 112
            Visible = True
          end>
      end
      object gTariffOptionCostNew: TCRDBGrid
        Left = 726
        Top = 0
        Width = 412
        Height = 165
        Align = alClient
        DataSource = dsTariffOptionCostNew
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnDblClick = CRDBGrid1DblClick
        OnKeyDown = CRDBGrid1KeyDown
        Columns = <
          item
            DropDownRows = 30
            Expanded = False
            FieldName = 'TARIFF_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1058#1072#1088#1080#1092
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 177
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TURN_ON_COST'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1076#1082#1083'.'
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
            FieldName = 'MONTHLY_COST'
            Title.Alignment = taCenter
            Title.Caption = #1040#1073'. '#1087#1083'.'
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
            FieldName = 'TURN_ON_COST_FOR_BILLS'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 87
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTHLY_COST_FOR_BILLS'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 92
            Visible = True
          end>
      end
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'TARIFF_OPTIONS'
    KeyFields = 'TARIFF_OPTION_ID'
    SQLInsert.Strings = (
      'INSERT INTO TARIFF_OPTIONS'
      
        '  (TARIFF_OPTION_ID, OPERATOR_ID, OPTION_CODE, OPTION_NAME, KOEF' +
        '_KOMISS, DISCR_SPISANIE, CAN_BE_TURNED_BY_OPERATOR, OPTION_NAME_' +
        'FOR_AB,IS_AUTO_INTERNET, CAN_BE_TURNED_BY_ABONENT,USSD_TURN_ON_C' +
        'OMMAND,USSD_TURN_OFF_COMMAND, internet_volume, is_unlim_internet' +
        ', show_in_private_office)'
      'VALUES'
      
        '  (:TARIFF_OPTION_ID, :OPERATOR_ID, :OPTION_CODE, :OPTION_NAME, ' +
        ':KOEF_KOMISS, :DISCR_SPISANIE, :CAN_BE_TURNED_BY_OPERATOR, :OPTI' +
        'ON_NAME_FOR_AB, :IS_AUTO_INTERNET, :CAN_BE_TURNED_BY_ABONENT,:US' +
        'SD_TURN_ON_COMMAND,:USSD_TURN_OFF_COMMAND, :internet_volume, :is' +
        '_unlim_internet, :show_in_private_office)')
    SQLDelete.Strings = (
      'DELETE FROM TARIFF_OPTIONS'
      'WHERE'
      '  TARIFF_OPTION_ID = :Old_TARIFF_OPTION_ID')
    SQLUpdate.Strings = (
      'UPDATE TARIFF_OPTIONS'
      'SET'
      
        '  TARIFF_OPTION_ID = :TARIFF_OPTION_ID, OPERATOR_ID = :OPERATOR_' +
        'ID, '
      '  OPTION_CODE = :OPTION_CODE, OPTION_NAME = :OPTION_NAME, '
      '  KOEF_KOMISS = :KOEF_KOMISS, DISCR_SPISANIE = :DISCR_SPISANIE,'
      'OPTION_NAME_FOR_AB = :OPTION_NAME_FOR_AB, '
      'CAN_BE_TURNED_BY_OPERATOR=:CAN_BE_TURNED_BY_OPERATOR,'
      'CAN_BE_TURNED_BY_ABONENT = :CAN_BE_TURNED_BY_ABONENT,'
      'USSD_TURN_ON_COMMAND = :USSD_TURN_ON_COMMAND,'
      'USSD_TURN_OFF_COMMAND = :USSD_TURN_OFF_COMMAND,'
      'IS_AUTO_INTERNET=:IS_AUTO_INTERNET,'
      'internet_volume=:internet_volume,'
      'is_unlim_internet=:is_unlim_internet,'
      'show_in_private_office=:show_in_private_office'
      'WHERE'
      '  TARIFF_OPTION_ID = :Old_TARIFF_OPTION_ID')
    SQLLock.Strings = (
      'SELECT * FROM TARIFF_OPTIONS'
      'WHERE'
      '  TARIFF_OPTION_ID = :Old_TARIFF_OPTION_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT TARIFF_OPTION_ID, OPERATOR_ID, OPTION_CODE, OPTION_NAME, ' +
        'KOEF_KOMISS, DISCR_SPISANIE, CAN_BE_TURNED_BY_OPERATOR, IS_AUTO_' +
        'INTERNET, CAN_BE_TURNED_BY_ABONENT,USSD_TURN_ON_COMMAND,USSD_TUR' +
        'N_OFF_COMMAND, internet_volume, is_unlim_internet, show_in_priva' +
        'te_office'
      'FROM TARIFF_OPTIONS'
      'WHERE'
      '  TARIFF_OPTION_ID = :TARIFF_OPTION_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM TARIFF_OPTIONS')
    Options.StrictUpdate = False
    AfterCancel = qMainBeforePost
    Left = 256
    Top = 57
    object qMainTARIFF_OPTION_ID: TFloatField
      FieldName = 'TARIFF_OPTION_ID'
      Required = True
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
    object qMainOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
      Required = True
    end
    object qMainOPTION_CODE: TStringField
      FieldName = 'OPTION_CODE'
      Required = True
      Size = 120
    end
    object qMainOPTION_NAME: TStringField
      FieldName = 'OPTION_NAME'
      Required = True
      Size = 400
    end
    object qMainKOEF_KOMISS: TFloatField
      FieldName = 'KOEF_KOMISS'
    end
    object qMainDISCR_SPISANIE: TIntegerField
      DisplayLabel = #1044#1080#1089#1082#1088#1077#1090#1085#1086#1077' '#1089#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'DISCR_SPISANIE'
    end
    object qMainOPTION_NAME_FOR_AB: TStringField
      FieldName = 'OPTION_NAME_FOR_AB'
      Size = 400
    end
    object qMainCAN_BE_TURNED_BY_OPERATOR: TIntegerField
      DisplayLabel = #1044#1086#1089#1090#1091#1087' '#1086#1087#1077#1088#1072#1090#1086#1088#1072#1084
      FieldName = 'CAN_BE_TURNED_BY_OPERATOR'
    end
    object qMainUSSD_TURN_ON_COMMAND: TStringField
      FieldName = 'USSD_TURN_ON_COMMAND'
      Size = 100
    end
    object qMainUSSD_TURN_OFF_COMMAND: TStringField
      FieldName = 'USSD_TURN_OFF_COMMAND'
      Size = 100
    end
    object qMainCAN_BE_TURNED_BY_ABONENT: TIntegerField
      FieldName = 'CAN_BE_TURNED_BY_ABONENT'
    end
    object qMainIS_AUTO_INTERNET: TSmallintField
      FieldName = 'IS_AUTO_INTERNET'
    end
    object qMaininternet_volume: TFloatField
      FieldName = 'internet_volume'
    end
    object qMainIS_UNLIM_INTERNET: TIntegerField
      FieldName = 'IS_UNLIM_INTERNET'
    end
    object qMainSHOW_IN_PRIVATE_OFFICE: TIntegerField
      FieldName = 'SHOW_IN_PRIVATE_OFFICE'
    end
    object qMainSHOW_IN_PRIVATE_OFFICE_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'SHOW_IN_PRIVATE_OFFICE_NAME'
      LookupDataSet = qShowPO
      LookupKeyFields = 'SHOW_IN_PRIVATE_OFFICE_ID'
      LookupResultField = 'SHOW_IN_PRIVATE_OFFICE_NAME'
      KeyFields = 'SHOW_IN_PRIVATE_OFFICE'
      Lookup = True
    end
  end
  inherited DataSource1: TDataSource
    OnDataChange = DataSource1DataChange
    Left = 368
    Top = 57
  end
  inherited PopupMenu1: TPopupMenu
    Left = 120
    Top = 204
  end
  inherited ActionList1: TActionList
    Left = 120
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_TARIFF_OPTION_ID'
    Left = 120
    Top = 57
    CommandStoredProcName = 'NEW_TARIFF_OPTION_ID:0'
  end
  object qOperators: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM OPERATORS'
      'ORDER BY OPERATOR_NAME ASC')
    Left = 256
    Top = 105
  end
  object dsTariffOptionCosts: TDataSource
    DataSet = qTariffOptionCosts
    OnStateChange = DataSource1StateChange
    OnDataChange = dsTariffOptionCostsDataChange
    Left = 368
    Top = 153
  end
  object qTariffOptionCosts: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO TARIFF_OPTION_COSTS'
      
        '  (TARIFF_OPTION_COST_ID, TARIFF_OPTION_ID, BEGIN_DATE, END_DATE' +
        ', TURN_ON_COST, MONTHLY_COST, OPERATOR_TURN_ON_COST, OPERATOR_MO' +
        'NTHLY_COST)'
      'VALUES'
      
        '  (:TARIFF_OPTION_COST_ID, :TARIFF_OPTION_ID, :BEGIN_DATE, :END_' +
        'DATE, :TURN_ON_COST, :MONTHLY_COST, :OPERATOR_TURN_ON_COST, :OPE' +
        'RATOR_MONTHLY_COST)')
    SQLDelete.Strings = (
      'DELETE FROM TARIFF_OPTION_COSTS'
      'WHERE'
      '  TARIFF_OPTION_COST_ID = :Old_TARIFF_OPTION_COST_ID')
    SQLUpdate.Strings = (
      'UPDATE TARIFF_OPTION_COSTS'
      'SET'
      
        '  TARIFF_OPTION_COST_ID = :TARIFF_OPTION_COST_ID, TARIFF_OPTION_' +
        'ID = :TARIFF_OPTION_ID, BEGIN_DATE = :BEGIN_DATE, END_DATE = :EN' +
        'D_DATE, TURN_ON_COST = :TURN_ON_COST, MONTHLY_COST = :MONTHLY_CO' +
        'ST, OPERATOR_TURN_ON_COST = :OPERATOR_TURN_ON_COST, OPERATOR_MON' +
        'THLY_COST = :OPERATOR_MONTHLY_COST'
      'WHERE'
      '  TARIFF_OPTION_COST_ID = :Old_TARIFF_OPTION_COST_ID')
    SQLLock.Strings = (
      'SELECT * FROM TARIFF_OPTION_COSTS'
      'WHERE'
      '  TARIFF_OPTION_COST_ID = :Old_TARIFF_OPTION_COST_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT TARIFF_OPTION_COST_ID, TARIFF_OPTION_ID, BEGIN_DATE, END_' +
        'DATE, TURN_ON_COST, MONTHLY_COST, OPERATOR_TURN_ON_COST, OPERATO' +
        'R_MONTHLY_COST FROM TARIFF_OPTION_COSTS'
      'WHERE'
      '  TARIFF_OPTION_COST_ID = :TARIFF_OPTION_COST_ID')
    SQL.Strings = (
      'SELECT TARIFF_OPTION_COSTS.*,'
      
        '  NVL(USER_NAMES.USER_FIO, TARIFF_OPTION_COSTS.USER_LAST_UPDATED' +
        ') USER_NAME'
      'FROM '
      '  TARIFF_OPTION_COSTS,'
      '  USER_NAMES'
      'WHERE '
      '  TARIFF_OPTION_COSTS.TARIFF_OPTION_ID=:TARIFF_OPTION_ID'
      
        '  AND TARIFF_OPTION_COSTS.USER_LAST_UPDATED=USER_NAMES.USER_NAME' +
        '(+)')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    BeforeClose = qTariffOptionCostsBeforeClose
    BeforePost = qTariffOptionCostsBeforePost
    Left = 256
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TARIFF_OPTION_ID'
      end>
    object qTariffOptionCostsTARIFF_OPTION_COST_ID: TFloatField
      FieldName = 'TARIFF_OPTION_COST_ID'
      Required = True
    end
    object qTariffOptionCostsTARIFF_OPTION_ID: TFloatField
      FieldName = 'TARIFF_OPTION_ID'
      Required = True
    end
    object qTariffOptionCostsBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
      Required = True
    end
    object qTariffOptionCostsEND_DATE: TDateTimeField
      FieldName = 'END_DATE'
      Required = True
    end
    object qTariffOptionCostsTURN_ON_COST: TFloatField
      FieldName = 'TURN_ON_COST'
    end
    object qTariffOptionCostsMONTHLY_COST: TFloatField
      FieldName = 'MONTHLY_COST'
    end
    object qTariffOptionCostsUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qTariffOptionCostsDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qTariffOptionCostsUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qTariffOptionCostsDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
    end
    object qTariffOptionCostsOPERATOR_TURN_ON_COST: TFloatField
      FieldName = 'OPERATOR_TURN_ON_COST'
    end
    object qTariffOptionCostsOPERATOR_MONTHLY_COST: TFloatField
      FieldName = 'OPERATOR_MONTHLY_COST'
    end
    object qTariffOptionCostsUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Size = 1600
    end
  end
  object qTariffs: TOraQuery
    SQL.Strings = (
      'SELECT TARIFF_ID, TARIFF_NAME'
      'FROM TARIFFS'
      'WHERE OPERATOR_ID=:OPERATOR_ID'
      'ORDER BY TARIFF_NAME')
    Left = 256
    Top = 201
    ParamData = <
      item
        DataType = ftInteger
        Name = 'OPERATOR_ID'
        Value = 3
      end>
  end
  object qGetNewTariffOptionCostId: TOraStoredProc
    StoredProcName = 'NEW_TARIFF_OPTION_ID'
    Left = 120
    Top = 153
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_TARIFF_OPTION_ID:0'
  end
  object qTariffOptionNewCost: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO TARIFF_OPTION_NEW_COST'
      
        '  (TARIFF_OPTION_NEW_COST_ID, TARIFF_OPTION_COST_ID, TARIFF_ID, ' +
        'TURN_ON_COST, MONTHLY_COST, USER_CREATED, DATE_CREATED)'
      'VALUES'
      
        '  (:TARIFF_OPTION_NEW_COST_ID, :TARIFF_OPTION_COST_ID, :TARIFF_I' +
        'D, :TURN_ON_COST, :MONTHLY_COST, :USER_CREATED, :DATE_CREATED)')
    SQL.Strings = (
      'SELECT TARIFF_OPTION_NEW_COST.*, TARIFFS.TARIFF_NAME '
      '  FROM TARIFF_OPTION_NEW_COST, TARIFFS '
      '  WHERE TARIFF_OPTION_COST_ID=:TARIFF_OPTION_COST_ID'
      '    AND TARIFFS.TARIFF_ID=TARIFF_OPTION_NEW_COST.TARIFF_ID')
    BeforeClose = qTariffOptionCostsBeforeClose
    BeforePost = qTariffOptionNewCostBeforePost
    Left = 256
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TARIFF_OPTION_COST_ID'
      end>
    object qTariffOptionNewCostTARIFF_OPTION_NEW_COST_ID: TFloatField
      FieldName = 'TARIFF_OPTION_NEW_COST_ID'
    end
    object qTariffOptionNewCostTARIFF_OPTION_COST_ID: TFloatField
      FieldName = 'TARIFF_OPTION_COST_ID'
      Required = True
    end
    object qTariffOptionNewCostTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
    end
    object qTariffOptionNewCostTURN_ON_COST: TFloatField
      FieldName = 'TURN_ON_COST'
    end
    object qTariffOptionNewCostMONTHLY_COST: TFloatField
      FieldName = 'MONTHLY_COST'
    end
    object qTariffOptionNewCostUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qTariffOptionNewCostDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qTariffOptionNewCostUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qTariffOptionNewCostDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
    end
    object qTariffOptionNewCostTARIFF_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'TARIFF_NAME'
      LookupDataSet = qTariffs
      LookupKeyFields = 'TARIFF_ID'
      LookupResultField = 'TARIFF_NAME'
      KeyFields = 'TARIFF_ID'
      Size = 50
      Lookup = True
    end
    object qTariffOptionNewCostTURN_ON_COST_FOR_BILLS: TFloatField
      DisplayLabel = #1055#1086#1076#1082#1083'.('#1089#1095#1077#1090')'
      FieldName = 'TURN_ON_COST_FOR_BILLS'
    end
    object qTariffOptionNewCostMONTHLY_COST_FOR_BILLS: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'.('#1089#1095#1077#1090')'
      FieldName = 'MONTHLY_COST_FOR_BILLS'
    end
  end
  object dsTariffOptionCostNew: TDataSource
    DataSet = qTariffOptionNewCost
    OnStateChange = DataSource1StateChange
    Left = 368
    Top = 248
  end
  object qGetNewTariffOptionNewCostID: TOraStoredProc
    StoredProcName = 'NEW_TARIFF_OPTION_NEW_COST_ID'
    Left = 120
    Top = 248
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_TARIFF_OPTION_NEW_COST_ID'
  end
  object qTariffOptNo: TOraQuery
    SQL.Strings = (
      'SELECT O.OPTION_CODE, O.OPTION_NAME'
      '  FROM DB_LOADER_ACCOUNT_PHONE_OPTS O'
      '  WHERE O.YEAR_MONTH=TO_NUMBER(TO_CHAR(SYSDATE, '#39'YYYYMM'#39'))'
      '    AND O.OPTION_CODE NOT IN (SELECT TARIFF_OPTIONS.OPTION_CODE'
      '                                FROM TARIFF_OPTIONS)'
      '  GROUP BY O.OPTION_CODE, O.OPTION_NAME'
      '  ORDER BY O.OPTION_CODE')
    FetchAll = True
    Left = 1264
    Top = 144
    object qTariffOptNoOPTION_CODE: TStringField
      DisplayLabel = #1053#1077#1086#1087#1080#1089#1072#1085#1085#1099#1081' '#1082#1086#1076
      DisplayWidth = 12
      FieldName = 'OPTION_CODE'
      Size = 120
    end
    object qTariffOptNoOPTION_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      DisplayWidth = 18
      FieldName = 'OPTION_NAME'
      Size = 800
    end
  end
  object dsTariffOptNo: TDataSource
    DataSet = qTariffOptNo
    Left = 1296
    Top = 152
  end
  object qShowPO: TOraQuery
    SQL.Strings = (
      
        'SELECT 1 show_in_private_office_id, '#39#1044#1072#39' show_in_private_office_' +
        'name FROM dual'
      'UNION'
      'SELECT 0, '#39#1053#1077#1090#39' FROM dual')
    Left = 440
    Top = 56
  end
end
