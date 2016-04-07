inherited RefTariffsForm: TRefTariffsForm
  Caption = 'RefTariffsForm'
  ExplicitWidth = 823
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 799
      ExplicitHeight = 352
      inherited TlBr: TsToolBar
        object btn2: TToolButton
          Left = 549
          Top = 0
          Width = 8
          Caption = 'btn2'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object btnRecalcTarifBalUblck: TToolButton
          Left = 557
          Top = 0
          Action = aRecalcTarifBalUblck
        end
        object btnExtEditExecute: TToolButton
          Left = 592
          Top = 0
          Action = aExtEditExecute
        end
        object btn3: TToolButton
          Left = 627
          Top = 0
          Width = 8
          Caption = 'btn3'
          ImageIndex = 20
          Style = tbsSeparator
        end
        object tbRecommendedTariffOptions: TToolButton
          Left = 635
          Top = 0
          Action = aRecommendedTariffOptions
        end
      end
    end
  end
  inherited actlst1: TActionList
    object aRecalcTarifBalUblck: TAction
      Caption = #1055#1077#1088#1077#1089#1095#1105#1090' '#1073#1072#1083#1072#1085#1089#1072' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      Hint = #1055#1077#1088#1077#1089#1095#1105#1090' '#1073#1072#1083#1072#1085#1089#1072' '#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      ImageIndex = 19
      OnExecute = aRecalcTarifBalUblckExecute
    end
    object aExtEditExecute: TAction
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1072#1088#1080#1092#1085#1099#1093' '#1086#1087#1094#1080#1080' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1072#1088#1080#1092#1072
      Hint = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1072#1088#1080#1092#1085#1099#1093' '#1086#1087#1094#1080#1080' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1072#1088#1080#1092#1072
      ImageIndex = 27
      OnExecute = aExtEditExecuteExecute
    end
    object aRecommendedTariffOptions: TAction
      Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1099#1077' '#1086#1087#1094#1080#1080' '#1082' '#1090#1072#1088#1080#1092#1091
      Hint = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1099#1077' '#1086#1087#1094#1080#1080' '#1082' '#1090#1072#1088#1080#1092#1091
      ImageIndex = 49
      OnExecute = aRecommendedTariffOptionsExecute
    end
  end
  inherited pm1: TPopupMenu
    object N11: TMenuItem
      Action = aExtEditExecute
    end
    object pmRecommendedTariffOptions: TMenuItem
      Action = aRecommendedTariffOptions
    end
  end
  object spRecalcTarifBalUblck: TOraStoredProc
    StoredProcName = 'RECALC_TARIF'
    Session = Dm.OraSession
    Left = 640
    Top = 120
    CommandStoredProcName = 'RECALC_TARIF'
  end
end
