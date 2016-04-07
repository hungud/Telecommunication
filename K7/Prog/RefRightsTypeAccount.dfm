inherited RefRightsTypeAccountForm: TRefRightsTypeAccountForm
  Caption = #1058#1080#1087#1099' '#1087#1088#1072#1074' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1080' '#1076#1086#1089#1090#1091#1087#1085#1099#1077' '#1083'/'#1089
  ClientHeight = 343
  ClientWidth = 364
  ExplicitWidth = 372
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 364
    Height = 59
    ExplicitWidth = 704
    ExplicitHeight = 59
    inherited ToolBar1: TToolBar
      Width = 364
      Height = 31
      ExplicitWidth = 704
      ExplicitHeight = 31
    end
    object Panel3: TPanel
      Left = 0
      Top = 31
      Width = 364
      Height = 28
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 37
      ExplicitWidth = 712
      object Label1: TLabel
        Left = 1
        Top = 6
        Width = 153
        Height = 13
        Caption = #1058#1080#1087' '#1087#1088#1072#1074' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbRightNames: TComboBox
        Left = 160
        Top = 4
        Width = 153
        Height = 21
        TabOrder = 0
        OnChange = cbRightNamesChange
      end
    end
  end
  inherited Panel2: TPanel
    Top = 59
    Width = 364
    Height = 284
    ExplicitTop = 59
    ExplicitWidth = 704
    ExplicitHeight = 224
    inherited CRDBGrid1: TCRDBGrid
      Width = 362
      Height = 282
      Columns = <
        item
          Expanded = False
          FieldName = 'RIGHT_NAME'
          Title.Caption = #1058#1080#1087' '#1087#1088#1072#1074
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGIN'
          Title.Caption = #1051'/'#1057
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'RIGHTS_TYPE_ACCOUNT_ALLOW'
    KeyFields = 'ID'
    KeySequence = 'S_RIGHTS_TYPE_ACCOUNT_ALLOW_ID'
    SQLInsert.Strings = (
      'INSERT INTO RIGHTS_TYPE_ACCOUNT_ALLOW'
      '  (ID, RIGHTS_TYPE, ACCOUNT_ID)'
      'VALUES'
      '  (:ID, :RIGHTS_TYPE, :ACCOUNT_ID)')
    SQLDelete.Strings = (
      'DELETE FROM RIGHTS_TYPE_ACCOUNT_ALLOW'
      'WHERE ID = :ID')
    SQLUpdate.Strings = (
      'UPDATE RIGHTS_TYPE_ACCOUNT_ALLOW'
      'SET'
      ' ID = :ID,'
      ' RIGHTS_TYPE = :RIGHTS_TYPE,'
      ' ACCOUNT_ID = :ACCOUNT_ID'
      'WHERE'
      ' ID = :OLD_ID')
    SQLLock.Strings = (
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT ID, RIGHTS_TYPE, ACCOUNT_ID '
      'FROM RIGHTS_TYPE_ACCOUNT_ALLOW'
      'WHERE ID = :ID')
    SQL.Strings = (
      'SELECT * FROM RIGHTS_TYPE_ACCOUNT_ALLOW'
      'WHERE ((:RIGHTS_TYPE IS NULL)OR(RIGHTS_TYPE = :RIGHTS_TYPE))')
    Left = 48
    Top = 97
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RIGHTS_TYPE'
      end>
    object qMainID: TFloatField
      FieldName = 'ID'
    end
    object qMainRIGHTS_TYPE: TFloatField
      FieldName = 'RIGHTS_TYPE'
    end
    object qMainRIGHT_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'RIGHT_NAME'
      LookupDataSet = qRightNames
      LookupKeyFields = 'RIGHT_ID'
      LookupResultField = 'RIGHT_NAME'
      KeyFields = 'RIGHTS_TYPE'
      Size = 30
      Lookup = True
    end
    object qMainACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
    end
    object qMainLOGIN: TStringField
      FieldKind = fkLookup
      FieldName = 'LOGIN'
      LookupDataSet = qAccount
      LookupKeyFields = 'ACCOUNT_ID'
      LookupResultField = 'LOGIN'
      KeyFields = 'ACCOUNT_ID'
      Size = 30
      Lookup = True
    end
  end
  inherited DataSource1: TDataSource
    Left = 96
    Top = 201
  end
  inherited PopupMenu1: TPopupMenu
    Left = 96
    Top = 100
  end
  inherited ActionList1: TActionList
    Left = 88
    Top = 148
  end
  object qAccount: TOraTable [6]
    TableName = 'accounts'
    OrderFields = 'account_id'
    Left = 40
    Top = 145
  end
  object qRightNames: TOraQuery [7]
    SQL.Strings = (
      'SELECT 1 RIGHT_ID, '#39#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#39' RIGHT_NAME FROM DUAL'
      'UNION ALL'
      'SELECT 2, '#39#1055#1088#1086#1089#1084#1086#1090#1088#39' FROM DUAL'
      'UNION ALL'
      'SELECT 3, '#39#1058#1086#1083#1100#1082#1086' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092'. '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091#39' FROM DUAL')
    Left = 40
    Top = 193
  end
  inherited qGetNewId: TOraStoredProc
    Left = 40
    Top = 249
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
