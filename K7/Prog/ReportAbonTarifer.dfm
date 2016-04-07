inherited ReportAbonTariferFrm: TReportAbonTariferFrm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1072#1073#1086#1085'.'#1087#1083#1072#1090#1072#1084', '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1085#1099#1084' '#1090#1072#1088#1080#1092#1077#1088#1086#1084' '#1079#1072' '#1084#1077#1089#1103#1094
  ClientHeight = 630
  ClientWidth = 956
  Position = poScreenCenter
  ExplicitWidth = 972
  ExplicitHeight = 668
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 956
    Height = 161
    ExplicitWidth = 956
    ExplicitHeight = 161
    object lbl1: TLabel [0]
      Left = 328
      Top = 16
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel [1]
      Left = 1
      Top = 16
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel [2]
      Left = 478
      Top = 16
      Width = 89
      Height = 13
      Caption = #1055#1088#1080#1079#1085#1072#1082' '#1089#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRefresh: TBitBtn
      Left = 681
      Top = 9
      Width = 115
      ExplicitLeft = 681
      ExplicitTop = 9
      ExplicitWidth = 115
    end
    inherited btLoadInExcel: TBitBtn
      Left = 809
      Top = 9
      ExplicitLeft = 809
      ExplicitTop = 9
    end
    object CLB_Accounts: TsCheckListBox [5]
      Left = 69
      Top = 16
      Width = 253
      Height = 129
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = CLB_AccountsExit
      OnMouseMove = CLB_AccountsMouseMove
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      OnClickCheck = CLB_AccountsClickCheck
    end
    object cbbPeriod: TComboBox [6]
      Left = 383
      Top = 13
      Width = 89
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object cbbPrCollector: TComboBox [7]
      Left = 573
      Top = 13
      Width = 89
      Height = 21
      Style = csDropDownList
      TabOrder = 4
      Items.Strings = (
        #1042#1089#1077
        #1050#1086#1083#1083#1077#1082#1090#1086#1088
        #1053#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088)
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 809
      Top = 44
      TabOrder = 5
      ExplicitLeft = 809
      ExplicitTop = 44
    end
  end
  inherited pGrid: TPanel
    Top = 161
    Width = 956
    Height = 469
    ExplicitTop = 161
    ExplicitWidth = 956
    ExplicitHeight = 469
    inherited gReport: TCRDBGrid
      Width = 954
      Height = 467
      Columns = <
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 137
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGIN'
          Title.Alignment = taCenter
          Title.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 161
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COLLECTOR'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1080#1079#1085#1072#1082'  '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 176
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1040#1073#1086#1085'. '#1058#1055
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1040#1073#1086#1085'. '#1091#1089#1083
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 149
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select '
      'AC.ACCOUNT_NUMBER,  ac.login,  '
      ' t.phone_number, '
      't.abon_tp as "'#1040#1073#1086#1085'. '#1058#1055'",'
      't.abon_add as "'#1040#1073#1086#1085'. '#1091#1089#1083'" ,'
      'case '
      'when AC.IS_COLLECTOR = 1 then '#39#1050#1086#1083#1083#1077#1082#1090#1086#1088#39
      'else '#39#1053#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#39
      'end as collector'
      ''
      
        'from TARIFER_BILL_FOR_CLIENTS t,  db_loader_account_phones d, ac' +
        'counts ac'
      'where t.year_month = :pYear_month'
      'and '
      'T.PHONE_NUMBER = D.PHONE_NUMBER '
      'and T.YEAR_MONTH = D.YEAR_MONTH'
      'and D.ACCOUNT_ID = AC.ACCOUNT_ID')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYear_month'
      end>
  end
  inherited aList: TActionList
    inherited aShowUserStatInfo: TAction
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, decode(COMPANY_NAME,null,login, login||'#39' : '#39'|' +
        '|COMPANY_NAME) as login, COMPANY_NAME  FROM ACCOUNTS '
      'ORDER BY 2 ASC')
    Left = 176
    Top = 88
  end
  object qPeriod: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'select distinct(year_month) from TARIFER_BILL_FOR_CLIENTS order ' +
        'by year_month')
    Left = 240
    Top = 88
  end
end
