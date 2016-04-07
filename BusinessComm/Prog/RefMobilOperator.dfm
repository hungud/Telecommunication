inherited RefMobilOperatorForm: TRefMobilOperatorForm
  Caption = 'RefMobilOperatorForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CRGrid: TCRDBGrid
    DataSource = Dm.dsqMob_Operators
    Columns = <
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME_ID'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOBILE_OPERATOR_NAME_FOR_URL'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_CREATED_FIO'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATE_CREATED_'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATED_FIO'
        Width = -1
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATED_'
        Width = -1
        Visible = False
      end>
  end
end
