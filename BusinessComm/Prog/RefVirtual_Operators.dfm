inherited RefVirtual_OperatorsForm: TRefVirtual_OperatorsForm
  Caption = 'RefVirtual_OperatorsForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBr: TsToolBar
    object ToolButton1: TToolButton
      Left = 549
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 557
      Top = 0
      Action = aTranscriptBalance
    end
  end
  inherited CRGrid: TCRDBGrid
    DataSource = Dm.dsvirtual_operator
    Columns = <
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_ID'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_NAME'
        Title.Alignment = taCenter
        Width = 304
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INN'
        Title.Alignment = taCenter
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VIRTUAL_ACCOUNTS_IS_ACTIVE'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'IS_ACTIVE_NAME'
        Title.Alignment = taCenter
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMMENTS'
        Title.Alignment = taCenter
        Width = 1504
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED_'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATED_FIO'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED_'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end>
  end
  inherited actlst1: TActionList
    Left = 523
    Top = 71
    object aTranscriptBalance: TAction
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072
      Hint = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1072#1083#1072#1085#1089#1072' '
      ImageIndex = 48
      OnExecute = aTranscriptBalanceExecute
    end
  end
  inherited pm1: TPopupMenu
    Top = 63
  end
  inherited qGetNewId: TOraStoredProc
    Left = 690
    Top = 81
  end
end
