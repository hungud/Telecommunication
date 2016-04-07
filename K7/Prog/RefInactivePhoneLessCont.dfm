inherited RefInactivePhoneLessContForm: TRefInactivePhoneLessContForm
  Caption = #1053#1077#1072#1082#1090#1080#1074#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1073#1077#1079' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
  ClientHeight = 300
  ClientWidth = 960
  ExplicitWidth = 968
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 960
    Height = 30
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 960
    ExplicitHeight = 30
    inherited ToolBar1: TToolBar
      Width = 960
      Height = 30
      ButtonHeight = 30
      ExplicitWidth = 960
      ExplicitHeight = 30
      inherited ToolButton1: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton2: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton3: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton7: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton4: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton5: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton8: TToolButton
        ExplicitHeight = 30
      end
      inherited ToolButton6: TToolButton
        ExplicitHeight = 30
      end
      object ToolButton9: TToolButton
        Left = 202
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object btLoad: TBitBtn
        Left = 210
        Top = 0
        Width = 75
        Height = 30
        Caption = #1047#1072#1075#1088#1091#1079#1082#1072
        TabOrder = 0
        OnClick = btLoadClick
      end
      object btMask: TBitBtn
        Left = 285
        Top = 0
        Width = 75
        Height = 30
        Caption = #1052#1072#1089#1082#1080' '
        TabOrder = 1
        WordWrap = True
        OnClick = btMaskClick
      end
      object btExcel: TBitBtn
        Left = 360
        Top = 0
        Width = 97
        Height = 30
        Action = aExcel
        Caption = #1042#1099#1075#1088#1091#1079#1082#1072
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
  end
  inherited Panel2: TPanel
    Top = 30
    Width = 960
    Height = 270
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 30
    ExplicitWidth = 960
    ExplicitHeight = 270
    inherited CRDBGrid1: TCRDBGrid
      Width = 958
      Height = 268
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      OnGetCellParams = CRDBGrid1GetCellParams
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088
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
          FieldName = 'SIM_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1057#1080#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SYSTEM_BILLING_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1057#1080#1089#1090#1077#1084#1072' '#1088#1072#1089#1095#1077#1090#1086#1074
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOP_INFO'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1087'.'#1080#1085#1092#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAID'
          Title.Alignment = taCenter
          Title.Caption = #1055#1083#1072#1090#1085#1099#1081
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
          FieldName = 'PATTERN'
          Title.Alignment = taCenter
          Title.Caption = #1050#1088#1072#1089#1086#1090#1072
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
          FieldName = 'PRICE'
          Title.Alignment = taCenter
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
          FieldName = 'EXISTS_CONTRACT'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1083#1080#1095#1080#1077' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 143
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'inactive_phone_less_contract'
    KeyFields = 'INACTIVE_PHONE_ID'
    SQLInsert.Strings = (
      'INSERT INTO INACTIVE_PHONE_LESS_CONTRACT'
      
        '(INACTIVE_PHONE_ID, PHONE_NUMBER, SIM_NUMBER, SYSTEM_BILLING, DO' +
        'P_INFO, PAID, PRICE, MASK_BEAUTY_ID)'
      'VALUES'
      
        '(:INACTIVE_PHONE_ID, :PHONE_NUMBER, :SIM_NUMBER, :SYSTEM_BILLING' +
        ', :DOP_INFO, :PAID, :PRICE, :MASK_BEAUTY_ID)'
      
        'RETURNING INACTIVE_PHONE_ID, PHONE_NUMBER, SIM_NUMBER, SYSTEM_BI' +
        'LLING, DOP_INFO, PAID, PRICE, MASK_BEAUTY_ID'
      
        'INTO :INACTIVE_PHONE_ID, :PHONE_NUMBER, :SIM_NUMBER, :SYSTEM_BIL' +
        'LING, :DOP_INFO, :PAID, :PRICE, :MASK_BEAUTY_ID')
    SQLDelete.Strings = (
      'DELETE INACTIVE_PHONE_LESS_CONTRACT '
      'WHERE INACTIVE_PHONE_ID = :INACTIVE_PHONE_ID')
    SQLUpdate.Strings = (
      'UPDATE INACTIVE_PHONE_LESS_CONTRACT SET'
      ' PHONE_NUMBER = :PHONE_NUMBER, '
      ' SIM_NUMBER = :SIM_NUMBER,'
      ' SYSTEM_BILLING = :SYSTEM_BILLING,'
      ' DOP_INFO = :DOP_INFO,'
      ' PAID = :PAID,'
      ' PRICE = :PRICE,'
      ' MASK_BEAUTY_ID = :MASK_BEAUTY_ID'
      'WHERE INACTIVE_PHONE_ID = :Old_INACTIVE_PHONE_ID')
    SQLLock.Strings = (
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT a.inactive_phone_id, a.phone_number, a.sim_number,'
      
        '       a.date_created, a.system_billing, a.paid, a.dop_info, a.m' +
        'ask_beauty_id, a.price,'
      ' CASE '
      '   WHEN a.vv > SYSDATE THEN '#39#1077#1089#1090#1100' '#1082#1086#1085#1090#1088#1072#1082#1090#39
      '   WHEN a.vv IS NULL THEN '#39#1085#1077' '#1073#1099#1083#1086' '#1082#1086#1085#1090#1088#1072#1082#1090#1086#1074#39
      '   ELSE '#39#1073#1099#1083' '#1082#1086#1085#1090#1088#1072#1082#1090#39'  '
      ' END exists_contract   '
      ' FROM'
      '('
      
        'SELECT inactive_phone_id, phone_number, TO_CHAR(sim_number) sim_' +
        'number,'
      
        '  TRUNC(date_created) date_created, system_billing, paid, dop_in' +
        'fo, mask_beauty_id, price,'
      
        '  (SELECT MAX(NVL(v.contract_cancel_date,SYSDATE+1)) FROM v_cont' +
        'racts v'
      '   WHERE v.phone_number_federal = i.phone_number) vv'
      'FROM inactive_phone_less_contract i'
      'WHERE i.inactive_phone_id = :inactive_phone_id'
      ') a')
    SQL.Strings = (
      'SELECT a.inactive_phone_id, a.phone_number, a.sim_number,'
      
        '       a.date_created, a.system_billing, a.paid, a.dop_info, a.m' +
        'ask_beauty_id, a.price,'
      ' CASE '
      '   WHEN a.vv > SYSDATE THEN '#39#1077#1089#1090#1100' '#1082#1086#1085#1090#1088#1072#1082#1090#39
      '   WHEN a.vv IS NULL THEN '#39#1085#1077' '#1073#1099#1083#1086' '#1082#1086#1085#1090#1088#1072#1082#1090#1086#1074#39
      '   ELSE '#39#1073#1099#1083' '#1082#1086#1085#1090#1088#1072#1082#1090#39'  '
      ' END exists_contract   '
      ' FROM'
      '('
      
        'SELECT inactive_phone_id, phone_number, TO_CHAR(sim_number) sim_' +
        'number,'
      
        '  TRUNC(date_created) date_created, system_billing, paid, dop_in' +
        'fo, mask_beauty_id, price,'
      
        '  (SELECT MAX(NVL(v.contract_cancel_date,SYSDATE+1)) FROM v_cont' +
        'racts v'
      '   WHERE v.phone_number_federal = i.phone_number) vv'
      'FROM inactive_phone_less_contract i'
      ') a')
    IndexFieldNames = 'INACTIVE_PHONE_ID'
    Top = 57
    object qMainPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 10
    end
    object qMainSIM_NUMBER: TStringField
      FieldName = 'SIM_NUMBER'
      Required = True
      Size = 40
    end
    object qMainDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qMainSYSTEM_BILLING: TFloatField
      FieldName = 'SYSTEM_BILLING'
    end
    object qMainSYSTEM_PAID_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'SYSTEM_BILLING_NAME'
      LookupDataSet = qSystemBilling
      LookupKeyFields = 'SYSTEM_BILLING'
      LookupResultField = 'SYSTEM_BILLING_NAME'
      KeyFields = 'SYSTEM_BILLING'
      Lookup = True
    end
    object qMainPAID: TFloatField
      FieldName = 'PAID'
    end
    object qMainDOP_INFO: TStringField
      FieldName = 'DOP_INFO'
      Size = 300
    end
    object qMainMASK_BEAUTY_ID: TFloatField
      FieldName = 'MASK_BEAUTY_ID'
    end
    object qMainPATTERN: TStringField
      FieldKind = fkLookup
      FieldName = 'PATTERN'
      LookupDataSet = qMaskBeauty
      LookupKeyFields = 'MASK_BEAUTY_ID'
      LookupResultField = 'PATTERN'
      KeyFields = 'MASK_BEAUTY_ID'
      Size = 300
      Lookup = True
    end
    object qMainPRICE: TFloatField
      FieldName = 'PRICE'
      Required = True
    end
    object qMainEXISTS_CONTRACT: TStringField
      FieldName = 'EXISTS_CONTRACT'
      Size = 34
    end
    object qMainINACTIVE_PHONE_ID: TFloatField
      FieldName = 'INACTIVE_PHONE_ID'
    end
  end
  inherited DataSource1: TDataSource
    Left = 376
    Top = 97
  end
  inherited ActionList1: TActionList
    object aLock: TAction [5]
      Caption = #1047#1072#1073#1083#1086#1082'.'#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' Oracle'
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 19
      ShortCut = 16469
    end
    object aUnLock: TAction [6]
      Caption = #1056#1072#1079#1073#1083#1086#1082'.'#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' Oracle'
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 19
      ShortCut = 16469
    end
    object aExcel: TAction
      Caption = 'aExcel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
  end
  object qSystemBilling: TOraQuery [6]
    SQL.Strings = (
      'SELECT NULL SYSTEM_BILLING, '#39#39' SYSTEM_BILLING_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 1, '#39'PREPAID'#39' FROM DUAL'
      'UNION ALL'
      'SELECT 2, '#39'POSTPAID'#39' FROM DUAL')
    Active = True
    Left = 168
    Top = 177
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_INACTIVE_PHONE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_INACTIVE_PHONE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_INACTIVE_PHONE_ID'
  end
  object OpenDialog: TOpenDialog
    Left = 112
    Top = 96
  end
  object qMaskBeauty: TOraQuery
    SQL.Strings = (
      'SELECT null mask_beauty_id, '#39#39' pattern FROM DUAL'
      'UNION ALL'
      'SELECT  mask_beauty_id, pattern  FROM mask_beauty')
    Active = True
    Left = 272
    Top = 160
  end
end
