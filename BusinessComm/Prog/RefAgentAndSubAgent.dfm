inherited frmRefAgentAndSubAgent: TfrmRefAgentAndSubAgent
  Caption = 'frmRefAgentAndSubAgent'
  ExplicitWidth = 823
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 13
  inherited CRGrid: TCRDBGrid
    DataSource = Dm.dsqAgentSubAgent
    Columns = <
      item
        Expanded = False
        FieldName = 'AGENTS_AND_SUBAGENT_ID'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'AGENT_ID'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'Agent_Name'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PH_N1'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUB_AGENT_ID'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SubAgent_Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED_'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATED_FIO'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED_'
        Width = 112
        Visible = True
      end>
  end
end
