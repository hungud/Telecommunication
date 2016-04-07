inherited RefUserNamesForm: TRefUserNamesForm
  Caption = 'RefUserNamesForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBr: TsToolBar
    object btn2: TToolButton
      Left = 549
      Top = 0
      Width = 8
      Caption = 'btn2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnLock: TToolButton
      Left = 557
      Top = 0
      Action = aLock
    end
    object btnUnLock: TToolButton
      Left = 592
      Top = 0
      Action = aUnLock
    end
  end
  inherited actlst1: TActionList
    inherited aPost: TAction [2]
    end
    inherited aCancel: TAction [3]
    end
    inherited aRefresh: TAction [4]
    end
    inherited aFind: TAction [5]
    end
    inherited aFiltr: TAction [6]
    end
    inherited aDelete: TAction [7]
    end
    object aLock: TAction
      Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Enabled = False
      Hint = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 48
      ShortCut = 16460
      OnExecute = aLockExecute
    end
    object aUnLock: TAction
      Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Enabled = False
      Hint = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 19
      ShortCut = 16469
      OnExecute = aUnLockExecute
    end
  end
  inherited pm1: TPopupMenu
    object N7: TMenuItem
      Action = aLock
    end
    object N8: TMenuItem
      Action = aUnLock
    end
  end
  object ChangeOracleUserState: TOraStoredProc
    StoredProcName = 'ChangeOracleUserState'
    Session = Dm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := ChangeOracleUserState(:AUTHID, :EVENT);'
      'end;')
    Left = 264
    Top = 169
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptResult
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'AUTHID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'EVENT'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'ChangeOracleUserState'
  end
end
