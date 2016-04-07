inherited RefParametersForm: TRefParametersForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
  OnClose = nil
  OnShow = nil
  ExplicitWidth = 720
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited ToolBar1: TToolBar
      inherited ToolButton1: TToolButton
        Action = nil
        Enabled = False
        OnClick = nil
      end
      inherited ToolButton3: TToolButton
        Action = nil
        Enabled = False
        OnClick = nil
      end
    end
  end
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      OnDrawColumnCell = CRDBGrid1DrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
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
          FieldName = 'VALUE'
          Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCR'
          ReadOnly = True
          Title.Caption = #1048#1084#1103
          Width = 2404
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'PARAMS'
    KeyFields = 'PARAM_ID'
    SQLInsert.Strings = ()
    SQLDelete.Strings = ()
    SQLUpdate.Strings = (
      'UPDATE PARAMS'
      'SET'
      '  VALUE = :VALUE'
      'WHERE'
      '  PARAM_ID = :Old_PARAM_ID')
    SQLRefresh.Strings = (
      'SELECT PARAM_ID, NAME, VALUE, TYPE, DESCR FROM PARAMS'
      'WHERE'
      '  PARAM_ID = :PARAM_ID')
    SQL.Strings = (
      'SELECT * FROM PARAMS')
    IndexFieldNames = 'PARAM_ID'
    object qMainPARAM_ID: TFloatField
      FieldName = 'PARAM_ID'
      Required = True
    end
    object qMainNAME: TStringField
      DisplayWidth = 40
      FieldName = 'NAME'
      Required = True
      Size = 30
    end
    object qMainVALUE: TStringField
      DisplayWidth = 20
      FieldName = 'VALUE'
      Size = 256
    end
    object qMainTYPE: TStringField
      FieldName = 'TYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qMainDESCR: TStringField
      FieldName = 'DESCR'
      Size = 400
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
