inherited ShowBalanceChangeForm: TShowBalanceChangeForm
  Caption = 'ShowBalanceChangeForm'
  ClientHeight = 485
  ClientWidth = 743
  ExplicitWidth = 751
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 13
  inherited sSplitter1: TsSplitter
    Width = 743
    ExplicitWidth = 743
  end
  inherited sStatusBar1: TsStatusBar
    Top = 466
    Width = 743
    ExplicitTop = 466
    ExplicitWidth = 743
  end
  inherited sPanel1: TsPanel
    Width = 743
    ExplicitWidth = 743
    inherited sPanel2: TsPanel
      Left = 386
      Top = 12
      ExplicitLeft = 386
      ExplicitTop = 12
      inherited sBitBtn3: TsBitBtn
        Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086
        ImageIndex = 25
      end
    end
    inherited sPanel3: TsPanel
      Left = 453
      Top = 58
      ExplicitLeft = 453
      ExplicitTop = 58
    end
    inherited cbPeriod: TsComboBox
      Left = 633
      Top = 64
      ExplicitLeft = 633
      ExplicitTop = 64
    end
  end
  inherited cRGrid: TCRDBGrid
    Width = 743
    Height = 353
  end
  object qUpdate: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'UPDATE balance_change SET user_last_updated = USER'
      'WHERE account_id = :ACCOUNT_ID AND user_last_updated IS NULL AND'
      'NVL(date_last_updated,date_created) = :record_date')
    Left = 248
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'record_date'
      end>
  end
end
