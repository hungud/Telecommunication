inherited RefMailRecipientsFrm: TRefMailRecipientsFrm
  Caption = #1040#1076#1088#1077#1089#1085#1072#1103' '#1082#1085#1080#1075#1072' e-Mail '#1088#1072#1089#1089#1099#1083#1086#1082
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited ToolBar1: TToolBar
      Height = 31
      ExplicitHeight = 31
    end
  end
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MAIL_ADRESS'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 134
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REPORT_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1054#1090#1089#1099#1083#1072#1077#1084#1099#1081' '#1086#1090#1095#1077#1090
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 488
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO REPORT_MAIL_RECIPIENTS'
      '  (TYPE_REPORT, MAIL_ADRESS)'
      'VALUES'
      '  (:TYPE_REPORT, :MAIL_ADRESS)')
    SQLDelete.Strings = ()
    SQLUpdate.Strings = ()
    SQLRefresh.Strings = ()
    SQL.Strings = (
      'SELECT REPORT_MAIL_RECIPIENTS.MAIL_ADRESS,'
      '       REPORT_MAIL_RECIPIENTS.TYPE_REPORT,'
      '       REPORT_TYPES.REPORT_NAME'
      'FROM REPORT_MAIL_RECIPIENTS, REPORT_TYPES'
      
        'WHERE REPORT_MAIL_RECIPIENTS.TYPE_REPORT=REPORT_TYPES.TYPE_REPOR' +
        'T')
    object qMainMAIL_ADRESS: TStringField
      FieldName = 'MAIL_ADRESS'
      Required = True
      Size = 400
    end
    object qMainTYPE_REPORT: TStringField
      FieldName = 'TYPE_REPORT'
      Required = True
      Size = 400
    end
    object qMainREPORT_NAME: TStringField
      DisplayWidth = 100
      FieldKind = fkLookup
      FieldName = 'REPORT_NAME'
      LookupDataSet = qReportType
      LookupKeyFields = 'TYPE_REPORT'
      LookupResultField = 'REPORT_NAME'
      KeyFields = 'TYPE_REPORT'
      Size = 100
      Lookup = True
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_RECORD_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_RECORD_ID;'
      'end;')
    CommandStoredProcName = 'NEW_RECORD_ID'
  end
  object qReportType: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM REPORT_TYPES')
    Left = 200
    Top = 192
  end
end
