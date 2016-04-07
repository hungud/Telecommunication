inherited ReportDiffBetweenBillsFrm: TReportDiffBetweenBillsFrm
  Caption = #1054#1090#1095#1077#1090' "'#1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1089#1095#1077#1090#1086#1074' ('#1087#1086' '#1079#1074#1086#1085#1082#1072#1084')"'
  ClientHeight = 562
  ClientWidth = 836
  Position = poScreenCenter
  ExplicitWidth = 852
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 836
    Height = 145
    BevelOuter = bvNone
    ExplicitLeft = 1
    ExplicitTop = -5
    ExplicitWidth = 836
    ExplicitHeight = 145
    object lAccount: TLabel [0]
      Left = 16
      Top = 8
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPeriod: TLabel [1]
      Left = 312
      Top = 8
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRefresh: TBitBtn
      Left = 522
      Top = 1
      ExplicitLeft = 522
      ExplicitTop = 1
    end
    inherited btLoadInExcel: TBitBtn
      Left = 633
      Top = 1
      ExplicitLeft = 633
      ExplicitTop = 1
    end
    object CLB_Accounts: TsCheckListBox [4]
      Left = 92
      Top = 8
      Width = 197
      Height = 129
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CLB_AccountsClick
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
    object cbbPeriod: TComboBox [5]
      Left = 399
      Top = 5
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbbPeriodChange
    end
    object rgFilter: TRadioGroup [6]
      Left = 295
      Top = 35
      Width = 226
      Height = 105
      Caption = #1056#1072#1079#1085#1080#1094#1072' '#1087#1086' '#1089#1095#1077#1090#1072#1084'("'#1047#1074#1086#1085#1082#1080'" '#1080#1083#1080' "'#1057#1095#1077#1090'"):'
      ItemIndex = 1
      Items.Strings = (
        #1042#1089#1077
        #1041#1086#1083#1100#1096#1077' '#1085#1091#1083#1103
        #1052#1077#1085#1100#1096#1077' '#1080#1083#1080' '#1088#1072#1074#1085#1086' '#1085#1091#1083#1102)
      TabOrder = 4
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 633
      Top = 36
      TabOrder = 5
      ExplicitLeft = 633
      ExplicitTop = 36
    end
  end
  inherited pGrid: TPanel
    Top = 145
    Width = 836
    Height = 417
    ExplicitTop = 145
    ExplicitWidth = 839
    ExplicitHeight = 417
    inherited gReport: TCRDBGrid
      Width = 834
      Height = 415
      Columns = <
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
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BEELINE_CALL'
          Title.Alignment = taCenter
          Title.Caption = #1047#1074#1086#1085#1082#1080' "'#1041#1080#1083#1072#1081#1085'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFER_CALL'
          Title.Alignment = taCenter
          Title.Caption = #1047#1074#1086#1085#1082#1080' "'#1058#1072#1088#1080#1092#1077#1088'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BEELINE_BILL'
          Title.Alignment = taCenter
          Title.Caption = #1057#1095#1077#1090' "'#1041#1080#1083#1072#1081#1085'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFER_BILL'
          Title.Alignment = taCenter
          Title.Caption = #1057#1095#1077#1090' "'#1058#1072#1088#1080#1092#1077#1088'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAZN_CALL'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' "'#1047#1074#1086#1085#1082#1080'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 113
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAZN_BILL'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' "'#1057#1095#1077#1090'"'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 141
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select '
      '                   D.ACCOUNT_ID,'
      '                   t.phone_number,'
      '                    round(d.bill_sum, 2) beeline_bill,'
      '                    round(t.bill_summ, 2) tarifer_bill,'
      
        '                    round((d.bill_sum  - t.bill_summ), 2) as raz' +
        'n_bill, '
      '                    round(D.CALLS, 2) as beeline_call,'
      '                    round(T.CALLS, 2) as tarifer_call, '
      '                    round((D.CALLS  - T.CALLS), 2) as razn_call'
      '                 from '
      '                    TARIFER_BILL_FOR_CLIENTS t, '
      '                    db_loader_full_finance_bill d '
      '                 where '
      '                   T.PHONE_NUMBER = D.PHONE_NUMBER(+)'
      '                   and T.YEAR_MONTH = D.YEAR_MONTH(+)'
      '                  and T.YEAR_MONTH = :pYear_month'
      'order by razn_call desc')
    Left = 656
    Top = 96
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pYEAR_MONTH'
      end>
  end
  inherited dsReport: TDataSource
    Left = 600
    Top = 96
  end
  inherited aList: TActionList
    Left = 8
    Top = 48
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
    Left = 768
    Top = 96
  end
  object qPeriods: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      '  distinct(year_month) '
      'from  '
      '  db_loader_full_finance_bill'
      'order by YEAR_MONTH desc')
    Left = 712
    Top = 96
  end
end
