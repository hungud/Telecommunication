inherited RefStartBalancesForm: TRefStartBalancesForm
  Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1073#1072#1083#1072#1085#1089#1086#1074' '#1072#1073#1086#1085#1077#1085#1090#1086#1074
  ClientWidth = 630
  OnCreate = FormCreate
  ExplicitWidth = 648
  PixelsPerInch = 120
  TextHeight = 16
  inherited Panel1: TPanel
    Width = 630
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitWidth = 630
    inherited ToolBar1: TToolBar
      Width = 630
      Height = 31
      ExplicitWidth = 630
      ExplicitHeight = 31
    end
  end
  inherited Panel2: TPanel
    Width = 630
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitWidth = 630
    ExplicitHeight = 224
    inherited CRDBGrid1: TCRDBGrid
      Width = 628
      Height = 222
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 143
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_DATE'
          Title.Caption = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 117
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BALANCE_VALUE'
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_LAST_UPDATED'
          ReadOnly = True
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_LAST_UPDATED'
          ReadOnly = True
          Title.Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 132
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'PHONE_BALANCES'
    KeyFields = 'PHONE_BALANCE_ID'
    SQLInsert.Strings = (
      'INSERT INTO PHONE_BALANCES'
      '  (PHONE_BALANCE_ID, PHONE_NUMBER, BALANCE_DATE, BALANCE_VALUE)'
      'VALUES'
      
        '  (:PHONE_BALANCE_ID, :PHONE_NUMBER, :BALANCE_DATE, :BALANCE_VAL' +
        'UE)')
    SQLDelete.Strings = (
      'DELETE FROM PHONE_BALANCES'
      'WHERE'
      '  PHONE_BALANCE_ID = :Old_PHONE_BALANCE_ID')
    SQLUpdate.Strings = (
      'UPDATE PHONE_BALANCES'
      'SET'
      
        '  PHONE_BALANCE_ID = :PHONE_BALANCE_ID, PHONE_NUMBER = :PHONE_NU' +
        'MBER, BALANCE_DATE = :BALANCE_DATE, BALANCE_VALUE = :BALANCE_VAL' +
        'UE'
      'WHERE'
      '  PHONE_BALANCE_ID = :Old_PHONE_BALANCE_ID')
    SQLLock.Strings = (
      'SELECT * FROM PHONE_BALANCES'
      'WHERE'
      '  PHONE_BALANCE_ID = :Old_PHONE_BALANCE_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT PHONE_BALANCE_ID, PHONE_NUMBER, BALANCE_DATE, BALANCE_VAL' +
        'UE, USER_LAST_UPDATED, DATE_LAST_UPDATED FROM PHONE_BALANCES'
      'WHERE'
      '  PHONE_BALANCE_ID = :PHONE_BALANCE_ID')
    SQL.Strings = (
      'SELECT *'
      'FROM PHONE_BALANCES')
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_PHONE_BALANCE_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_PHONE_BALANCE_ID;'
      'end;')
    CommandStoredProcName = 'NEW_PHONE_BALANCE_ID:0'
  end
end
