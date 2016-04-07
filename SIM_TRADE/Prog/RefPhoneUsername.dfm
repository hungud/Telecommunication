inherited RefPhoneUsernameForm: TRefPhoneUsernameForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1090#1077#1083'.'#1089#1074#1103#1079#1080
  ClientWidth = 810
  ExplicitWidth = 826
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 810
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 810
    ExplicitHeight = 31
    inherited ToolBar1: TToolBar
      Width = 810
      Align = alClient
      ExplicitWidth = 810
      object ToolButton9: TToolButton
        Left = 202
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 10
        Style = tbsSeparator
      end
    end
  end
  inherited Panel2: TPanel
    Top = 31
    Width = 810
    Height = 252
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 31
    ExplicitWidth = 810
    ExplicitHeight = 252
    inherited CRDBGrid1: TCRDBGrid
      Width = 808
      Height = 250
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      OnDblClick = aShowGroupStatExecute
      OnKeyDown = nil
      Columns = <
        item
          Expanded = False
          FieldName = 'USERNAME'
          Title.Caption = #1051#1086#1075#1080#1085
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
          FieldName = 'PASSWORD'
          Title.Caption = #1055#1072#1088#1086#1083#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 224
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'CRM_PHONEUNREF'
    KeyFields = 'ID'
    KeySequence = 'S_NEW_CRM_PHONEUNREF_ID'
    SQLInsert.Strings = (
      'INSERT INTO CRM_PHONEUNREF'
      
        '  (ID, USERNAME, PASSWORD, USER_CREATED, DATE_CREATED, USER_LAST' +
        '_UPDATED, DATE_LAST_UPDATED)'
      'VALUES'
      
        '  (:ID, :USERNAME, :PASSWORD, :USER_CREATED, :DATE_CREATED, :USE' +
        'R_LAST_UPDATED, :DATE_LAST_UPDATED)')
    SQLDelete.Strings = (
      'DELETE FROM CRM_PHONEUNREF'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE CRM_PHONEUNREF'
      'SET'
      
        '  ID = :ID, USERNAME = :USERNAME, PASSWORD = :PASSWORD, USER_CRE' +
        'ATED = :USER_CREATED, DATE_CREATED = :DATE_CREATED, USER_LAST_UP' +
        'DATED = :USER_LAST_UPDATED, DATE_LAST_UPDATED = :DATE_LAST_UPDAT' +
        'ED'
      'WHERE'
      '  ID = :Old_ID')
    SQLLock.Strings = (
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT ID, USERNAME, PASSWORD, USER_CREATED, DATE_CREATED, USER_' +
        'LAST_UPDATED, DATE_LAST_UPDATED FROM CRM_PHONEUNREF'
      'WHERE USERNAME=:USERNAME AND PASSWORD=:PASSWORD')
    SQL.Strings = (
      'SELECT *'
      'FROM CRM_PHONEUNREF ORDER BY USERNAME')
    IndexFieldNames = 'ID'
    Top = 57
    object qMainID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object qMainUSERNAME: TStringField
      FieldName = 'USERNAME'
      Size = 120
    end
    object qMainPASSWORD: TStringField
      FieldName = 'PASSWORD'
      OnGetText = qMainPASSWORDGetText
      Size = 32
    end
  end
  inherited DataSource1: TDataSource
    Left = 376
    Top = 97
  end
  inherited PopupMenu1: TPopupMenu
    object Oracle1: TMenuItem
      Action = aShowGroupStat
    end
  end
  inherited ActionList1: TActionList
    object aShowGroupStat: TAction
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1075#1088#1091#1087#1087#1077
      OnExecute = aShowGroupStatExecute
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
