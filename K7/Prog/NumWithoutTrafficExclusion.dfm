inherited NumWithoutTrafficExclusionFrm: TNumWithoutTrafficExclusionFrm
  Caption = #1053#1086#1084#1077#1088#1072' '#1080#1089#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1080#1079' '#1086#1090#1095#1077#1090#1072' '#1086' '#1085#1086#1084#1077#1088#1072#1093' '#1073#1077#1079' '#1090#1088#1072#1092#1080#1082#1072' '
  Position = poScreenCenter
  ExplicitWidth = 712
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 29
    ExplicitHeight = 29
    inherited ToolBar1: TToolBar
      Height = 30
      ButtonHeight = 30
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
        Action = aShowUserStatInfo
      end
      object ToolButton12: TToolButton
        Left = 233
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object ToolButton10: TToolButton
        Left = 241
        Top = 0
        Action = aLoadAdd
      end
      object ToolButton11: TToolButton
        Left = 272
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086' '#1089#1087#1080#1089#1082#1091
        Action = aLoadDelete
      end
    end
  end
  inherited Panel2: TPanel
    Top = 29
    Height = 254
    ExplicitTop = 29
    ExplicitHeight = 254
    inherited CRDBGrid1: TCRDBGrid
      Height = 252
      OnDblClick = aShowUserStatInfoExecute
      OnKeyDown = nil
      Columns = <
        item
          Expanded = False
          FieldName = 'ROWN'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 36
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 250
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'NUM_WITHOUT_TRAFFIC_EXCLUSION'
    KeyFields = 'EXCLUSION_ID'
    SQLInsert.Strings = (
      'INSERT INTO NUM_WITHOUT_TRAFFIC_EXCLUSION'
      '  (EXCLUSION_ID, PHONE_NUMBER)'
      'VALUES'
      '  (:EXCLUSION_ID, :PHONE_NUMBER)'
      'RETURNING'
      '  EXCLUSION_ID, PHONE_NUMBER'
      'INTO'
      '  :EXCLUSION_ID, :PHONE_NUMBER')
    SQLDelete.Strings = (
      'DELETE FROM NUM_WITHOUT_TRAFFIC_EXCLUSION'
      'WHERE'
      '  EXCLUSION_ID = :Old_EXCLUSION_ID')
    SQLUpdate.Strings = (
      'UPDATE NUM_WITHOUT_TRAFFIC_EXCLUSION'
      'SET'
      '  EXCLUSION_ID = :EXCLUSION_ID, PHONE_NUMBER = :PHONE_NUMBER'
      'WHERE'
      '  EXCLUSION_ID = :Old_EXCLUSION_ID'
      'RETURNING'
      '  EXCLUSION_ID, PHONE_NUMBER'
      'INTO'
      '  :EXCLUSION_ID, :PHONE_NUMBER')
    SQLRefresh.Strings = (
      'SELECT * FROM NUM_WITHOUT_TRAFFIC_EXCLUSION'
      'WHERE'
      '  EXCLUSION_ID = :EXCLUSION_ID')
    SQL.Strings = (
      'SELECT N.*, ROWNUM as ROWN '
      'FROM (select * from NUM_WITHOUT_TRAFFIC_EXCLUSION '
      'ORDER BY EXCLUSION_ID ) N')
    FetchAll = True
    IndexFieldNames = 'EXCLUSION_ID'
  end
  inherited PopupMenu1: TPopupMenu
    object N7: TMenuItem
      Action = aShowUserStatInfo
    end
  end
  inherited ActionList1: TActionList
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      OnExecute = aShowUserStatInfoExecute
    end
    object aLoadAdd: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ImageIndex = 24
      OnExecute = aLoadAddExecute
    end
    object aLoadDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086' '#1089#1087#1080#1089#1082#1091
      ImageIndex = 26
      OnExecute = aLoadDeleteExecute
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_EXCLUSION_ID'
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object OpenDialog: TOpenDialog
    Left = 144
    Top = 152
  end
  object Transaction: TOraTransaction
    DefaultSession = Dm.OraSession
    DefaultCloseAction = taRollback
    Left = 392
    Top = 160
  end
end
