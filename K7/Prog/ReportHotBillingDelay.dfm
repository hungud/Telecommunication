object ReportHotBillingDelayForm: TReportHotBillingDelayForm
  Left = 0
  Top = 0
  Caption = #1047#1072#1076#1077#1088#1078#1082#1080' '#1074' '#1092#1072#1081#1083#1072#1093' '#1075#1086#1088#1103#1095#1077#1075#1086' '#1073#1080#1083#1083#1080#1085#1075#1072
  ClientHeight = 383
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 752
    Height = 27
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 242
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
    object lAccount: TLabel
      Left = 8
      Top = 8
      Width = 28
      Height = 13
      Caption = #1051'/C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 391
      Top = 0
      Width = 120
      Height = 27
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 511
      Top = 0
      Width = 83
      Height = 27
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 594
      Top = 0
      Width = 81
      Height = 27
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Visible = False
    end
    object cbPeriod: TComboBox
      Left = 287
      Top = 4
      Width = 98
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 681
      Top = 5
      Width = 59
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object cbAccounts: TComboBox
      Left = 33
      Top = 4
      Width = 203
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 5
      OnChange = cbAccountsChange
    end
  end
  object PhoneNumberViolationsGrid: TCRDBGrid
    Left = 0
    Top = 27
    Width = 752
    Height = 356
    Align = alClient
    DataSource = dsReports
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'FILE_NAME'
        Title.Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
        Width = 179
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOAD_SDATE'
        Title.Caption = #1044#1072#1090#1072' '#1079#1072#1075#1088#1091#1079#1082#1080
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MD'
        Title.Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1088#1072#1089#1093#1086#1078#1076#1077#1085#1080#1103', '#1095'.'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MMD'
        Title.Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1088#1072#1089#1093#1086#1078#1076#1077#1085#1080#1103', '#1095'.'
        Width = 116
        Visible = True
      end>
  end
  object qAccounts: TOraQuery
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, '
      '       LOGIN||'#39': '#39'||COMPANY_NAME LOGIN'
      '  FROM ACCOUNTS '
      '  ORDER BY LOGIN ASC')
    Left = 240
    Top = 80
  end
  object qPeriods: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      
        'select to_char(trunc(to_date(substr(hbf.file_name,-19,15),'#39'yyyym' +
        'mdd-hh24miss'#39'),'#39'mm'#39'),'#39'yyyymm'#39') as   YEAR_MONTH,to_char(trunc(to_' +
        'date(substr(hbf.file_name,-19,15),'#39'yyyymmdd-hh24miss'#39'),'#39'mm'#39'),'#39'mm' +
        #39')||'#39' - '#39'||to_char(trunc(to_date(substr(hbf.file_name,-19,15),'#39'y' +
        'yyymmdd-hh24miss'#39'),'#39'mm'#39'),'#39'yyyy'#39') as YEAR_MONTH_NAME from hot_bil' +
        'ling_files hbf'
      'where substr(hbf.file_name,-3)='#39'dbf'#39
      
        'group by trunc(to_date(substr(hbf.file_name,-19,15),'#39'yyyymmdd-hh' +
        '24miss'#39'),'#39'mm'#39')'
      'ORDER BY 1 DESC')
    Left = 240
    Top = 128
  end
  object alReports: TActionList
    Images = MainForm.ImageList24
    Left = 80
    Top = 80
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qReports: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select /*+rule*/ hbf.file_name,'
      '       hbf.load_sdate,'
      '       min(round((to_date(substr(hbf.file_name, -19, 15),'
      
        '                          '#39'yyyymmdd-hh24miss'#39') - hb.start_time) ' +
        '* 24,'
      '                 2)) as md,'
      '       max(round((to_date(substr(hbf.file_name, -19, 15),'
      
        '                          '#39'yyyymmdd-hh24miss'#39') - hb.start_time) ' +
        '* 24,'
      '                 2)) as mmd'
      '  from call_11_2012              hb,'
      '       hot_billing_files        hbf,'
      '       DB_LOADER_ACCOUNT_PHONES PH_NEW'
      ' where hb.dbf_id = hbf.hbf_id'
      ' and ((PH_NEW.ACCOUNT_ID=:PACCOUNT_ID) or (:PACCOUNT_ID=-1))'
      
        'and to_date(to_char(:PYEAR_MONTH)||'#39'01'#39','#39'yyyymmdd'#39')=trunc(to_dat' +
        'e(substr(hbf.file_name, -19, 15), '#39'yyyymmdd-hh24miss'#39'),'#39'mm'#39')'
      '   and (PH_NEW.YEAR_MONTH) IN'
      
        '       (SELECT FIRST_VALUE(year_month) OVER(ORDER BY year_month ' +
        'DESC)'
      '          FROM DB_LOADER_ACCOUNT_PHONES PH_OLD'
      '         WHERE PH_OLD.PHONE_NUMBER IS NOT NULL'
      '           AND PH_NEW.ACCOUNT_ID = PH_OLD.ACCOUNT_ID)'
      '   and PH_NEW.PHONE_NUMBER = hb.subscr_no'
      ' group by           hbf.file_name,'
      '          hbf.load_sdate'
      'order by 1')
    FetchRows = 250
    Left = 56
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'PYEAR_MONTH'
      end>
    object qReportsFILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 50
    end
    object qReportsLOAD_SDATE: TDateTimeField
      FieldName = 'LOAD_SDATE'
    end
    object qReportsMD: TFloatField
      FieldName = 'MD'
    end
    object qReportsMMD: TFloatField
      FieldName = 'MMD'
    end
  end
  object dsReports: TDataSource
    DataSet = qReports
    Left = 112
    Top = 136
  end
end
