inherited RefPhonesOnAccFrm: TRefPhonesOnAccFrm
  Caption = 'RefPhonesOnAccFrm'
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
      Action = aShowHist
    end
    object ToolButton3: TToolButton
      Left = 592
      Top = 0
      Action = aShowDeleting
    end
  end
  inherited actlst1: TActionList
    object aShowHist: TAction
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1079#1072#1087#1080#1089#1080
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1089#1090#1086#1088#1080#1080' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 51
      OnExecute = aShowHistExecute
    end
    object aShowDeleting: TAction
      Caption = #1059#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1074#1089#1077#1093' '#1091#1076#1072#1083#1077#1085#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 52
      OnExecute = aShowDeletingExecute
    end
  end
end
