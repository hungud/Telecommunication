object frmHotBilling: TfrmHotBilling
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' "'#1055#1088#1086#1087#1072#1078#1080' '#1075#1086#1088'. '#1073#1080#1083#1083#1080#1085#1075#1072' ('#1079#1074#1086#1085#1082#1080')"'
  ClientHeight = 462
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grData: TCRDBGrid
    Left = 0
    Top = 41
    Width = 848
    Height = 421
    Align = alClient
    DataSource = DSHotBillDiff
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'account_number'
        Title.Caption = #1051#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'phone_number'
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'calls'
        Title.Caption = #1089#1091#1084#1084#1072' '#1087#1086' DB_LOADER_FULL_FINANCE_BILL'
        Width = 246
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'call_cost'
        Title.Caption = #1057#1091#1084#1084#1099' '#1074' '#1092#1072#1081#1083#1072#1093
        Width = 165
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sum_diff'
        Title.Caption = #1056#1072#1079#1085#1080#1094#1072
        Width = 104
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 14
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
    object BitBtn2: TBitBtn
      Left = 330
      Top = 4
      Width = 122
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 173
      Top = 4
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cbPeriod: TComboBox
      Left = 68
      Top = 5
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbPeriodChange
    end
  end
  object DSHotBillDiff: TDataSource
    DataSet = QHotBillDiff
    Left = 152
    Top = 160
  end
  object QHotBillDiff: TOraQuery
    SQL.Strings = (
      'select q.*, q.calls-q.call_cost as sum_diff '
      ' from (                                                 '
      ' select ( select a.account_number                       '
      '            from accounts a                             '
      '            where a.account_id=t.account_id             '
      '        ) as account_number,                            '
      '        phone_number,                                   '
      '        year_month,                                     '
      
        '        round(t.calls, 2) calls,                                ' +
        '        '
      '        round((select sum(T1.CALLS_COST_WITHOUT_API)         '
      '           from db_loader_phone_stat t1                 '
      '          where t1.phone_number = t.phone_number        '
      '            and t1.year_month = t.year_month    '
      '          ), 2) as call_cost                                '
      '   from DB_LOADER_FULL_FINANCE_BILL t                   '
      '  where year_month = :pyear_month                       '
      ' ) q where q.calls-q.call_cost> 0                    '
      '  order by phone_number'
      ''
      '-- -1 row(s) affected.')
    Left = 80
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pyear_month'
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 16
    Top = 160
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
  end
  object qPeriods: TOraQuery
    Left = 248
    Top = 160
  end
  object qCheckTable: TOraQuery
    Left = 312
    Top = 160
  end
end
