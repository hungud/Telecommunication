inherited RefDealersForm: TRefDealersForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1089#1090#1072#1090#1091#1089#1086#1074
  ClientHeight = 396
  ClientWidth = 734
  ExplicitWidth = 750
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 734
    ExplicitWidth = 700
    inherited ToolBar1: TToolBar
      Width = 734
      ExplicitWidth = 700
    end
  end
  inherited Panel2: TPanel
    Width = 734
    Height = 363
    ExplicitWidth = 700
    ExplicitHeight = 308
    inherited CRDBGrid1: TCRDBGrid
      Width = 732
      Height = 361
      Columns = <
        item
          Expanded = False
          FieldName = 'DEALER_KOD'
          Title.Caption = #1050#1086#1076' '#1076#1080#1083#1083#1077#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DEALER_NAME'
          Title.Caption = #1044#1080#1083#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PATTERN'
          Title.Caption = #1064#1072#1073#1083#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REPLACEMENT'
          Title.Caption = #1047#1072#1084#1077#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 204
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SENDER_NAME'
          Title.Caption = #1057#1052#1057' '#1087#1089#1077#1074#1076#1086#1085#1080#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WELCOME_SMS'
          Title.Caption = 'SMS '#1087#1088#1080' '#1079#1072#1074#1077#1076#1077#1085#1080#1080' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'DEALERS'
    KeyFields = 'DEALER_KOD'
    SQLInsert.Strings = (
      'INSERT INTO DEALERS'
      
        '  (DEALER_KOD, PATTERN, REPLACEMENT, DEALER_NAME, SENDER_NAME, W' +
        'ELCOME_SMS)'
      'VALUES'
      
        '  (:DEALER_KOD, :PATTERN, :REPLACEMENT, :DEALER_NAME, :SENDER_NA' +
        'ME, :WELCOME_SMS)'
      'RETURNING'
      
        '  DEALER_KOD, PATTERN, REPLACEMENT, DEALER_NAME, SENDER_NAME, WE' +
        'LCOME_SMS'
      'INTO'
      
        '  :DEALER_KOD, :PATTERN, :REPLACEMENT, :DEALER_NAME, :SENDER_NAM' +
        'E, :WELCOME_SMS')
    SQLDelete.Strings = (
      'DELETE FROM DEALERS'
      'WHERE'
      '  DEALER_KOD = :Old_DEALER_KOD')
    SQLUpdate.Strings = (
      'UPDATE DEALERS'
      'SET'
      
        '  DEALER_KOD = :DEALER_KOD, PATTERN = :PATTERN, REPLACEMENT = :R' +
        'EPLACEMENT, DEALER_NAME = :DEALER_NAME, SENDER_NAME = :SENDER_NA' +
        'ME, WELCOME_SMS= :WELCOME_SMS'
      'WHERE'
      '  DEALER_KOD = :Old_DEALER_KOD'
      'RETURNING'
      
        '  DEALER_KOD, PATTERN, REPLACEMENT, DEALER_NAME, SENDER_NAME, WE' +
        'LCOME_SMS'
      'INTO'
      
        '  :DEALER_KOD, :PATTERN, :REPLACEMENT, :DEALER_NAME, :SENDER_NAM' +
        'E, :WELCOME_SMS')
    SQLRefresh.Strings = (
      
        'SELECT DEALER_KOD, PATTERN, REPLACEMENT, DEALER_NAME, SENDER_NAM' +
        'E, WELCOME_SMS FROM DEALERS'
      'WHERE'
      '  DEALER_KOD = :DEALER_KOD')
    SQL.Strings = (
      'SELECT * '
      'FROM DEALERS')
    IndexFieldNames = 'DEALER_KOD'
    object qMainDEALER_KOD: TFloatField
      FieldName = 'DEALER_KOD'
    end
    object qMainDEALER_NAME: TStringField
      FieldName = 'DEALER_NAME'
      Size = 400
    end
    object qMainPATTERN: TStringField
      FieldName = 'PATTERN'
      Size = 40
    end
    object qMainREPLACEMENT: TStringField
      FieldName = 'REPLACEMENT'
      Size = 400
    end
    object qMainSENDER_NAME: TStringField
      FieldName = 'SENDER_NAME'
      Size = 10
    end
    object qMainWELCOME_SMS: TStringField
      FieldName = 'WELCOME_SMS'
    end
  end
  inherited DataSource1: TDataSource
    Left = 328
  end
  inherited ActionList1: TActionList
    Left = 328
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
