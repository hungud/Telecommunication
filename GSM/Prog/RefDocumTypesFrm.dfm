inherited RefDocumTypesForm: TRefDocumTypesForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'DOCUM_TYPE_ID'
          Title.Caption = #1050#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOCUM_TYPE_NAME'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
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
    IndexFieldNames = 'DOCUM_TYPE_ID'
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
