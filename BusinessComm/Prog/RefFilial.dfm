inherited RefFilialForm: TRefFilialForm
  Caption = 'RefFilialForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CRGrid: TCRDBGrid
    DataSource = Dm.dsqFilials
    Columns = <
      item
        Expanded = False
        FieldName = 'FILIAL_ID'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME_ID'
        Title.Alignment = taCenter
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FILIAL_NAME'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRANCH'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME'
        Title.Alignment = taCenter
        Width = 124
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
end
