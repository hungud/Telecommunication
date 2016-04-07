inherited RefAgentForm: TRefAgentForm
  Caption = 'RefAgentForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CRGrid: TCRDBGrid
    DataSource = Dm.dsqAgent
    Columns = <
      item
        Expanded = False
        FieldName = 'AGENT_NAME'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_1'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' | '#1087#1077#1088#1074#1099#1081
        Width = 146
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_2'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' | '#1074#1090#1086#1088#1086#1081
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_3'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' | '#1090#1088#1077#1090#1080#1081
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_4'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' | '#1095#1077#1090#1074#1077#1088#1090#1099#1081
        Width = 115
        Visible = True
      end>
  end
  inherited actlst1: TActionList
    Left = 528
    Top = 116
  end
  inherited pm1: TPopupMenu
    Left = 480
    Top = 108
  end
end
