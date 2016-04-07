inherited PhonesWithDailyAbonForm: TPhonesWithDailyAbonForm
  Caption = #1053#1086#1084#1077#1088#1072' '#1089' '#1087#1086#1089#1091#1090#1086#1095#1085#1099#1084' '#1089#1087#1080#1089#1072#1085#1080#1077#1084' '#1072#1073#1086#1085'. '#1087#1083#1072#1090#1099'.'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      ParentFont = False
      TitleFont.Height = -12
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 244
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_LAST_UPDATE'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_LAST_UPDATE'
          Width = 112
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'PHONE_NUMBER_WITH_DAILY_ABON'
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO PHONE_NUMBER_WITH_DAILY_ABON'
      '  (PHONE_NUMBER)'
      'VALUES'
      '  (:PHONE_NUMBER)')
    SQLDelete.Strings = (
      'DELETE FROM PHONE_NUMBER_WITH_DAILY_ABON'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE PHONE_NUMBER_WITH_DAILY_ABON'
      'SET'
      '  PHONE_NUMBER = :PHONE_NUMBER'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLRefresh.Strings = (
      'SELECT PHONE_NUMBER FROM PHONE_NUMBER_WITH_DAILY_ABON'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'SELECT * '
      'FROM PHONE_NUMBER_WITH_DAILY_ABON')
    Left = 256
    Top = 41
    object qMainPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qMainUSER_LAST_UPDATE: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      FieldName = 'USER_LAST_UPDATE'
      Size = 200
    end
    object qMainDATE_LAST_UPDATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
      FieldName = 'DATE_LAST_UPDATE'
    end
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = ''
    SQL.Strings = ()
    ParamData = <>
  end
end
