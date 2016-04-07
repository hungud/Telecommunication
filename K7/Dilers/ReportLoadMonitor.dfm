object ReportLoadMonitorForm: TReportLoadMonitorForm
  Left = 0
  Top = 0
  Caption = #1052#1086#1085#1080#1090#1086#1088' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 658
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 863
    Height = 41
    Align = alTop
    TabOrder = 0
    object cbPeriod: TComboBox
      Left = 16
      Top = 9
      Width = 137
      Height = 24
      TabOrder = 0
      Text = 'cbPeriod'
      OnChange = cbPeriodChange
    end
    object btLoadInExcel: TBitBtn
      Left = 160
      Top = 2
      Width = 176
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btRefresh: TBitBtn
      Left = 337
      Top = 2
      Width = 138
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 41
    Width = 863
    Height = 617
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNT_PHONE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNT_BILLS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOAD_SUM_CALLS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_CALLS'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DETAIL_SUM_NO_LOAD'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 137
        Visible = True
      end>
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT V.*,'
      '       V.BILL_SUM_CALLS - V.LOAD_SUM_CALLS AS DETAIL_SUM_NO_LOAD'
      '  FROM V_DILER_ACCOUNT_DETAL_STAT V'
      '  WHERE V.YEAR_MONTH = :YEAR_MONTH'
      '  ORDER BY V.ACCOUNT_ID ASC')
    FetchAll = True
    Left = 72
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReportLOGIN: TStringField
      Alignment = taCenter
      DisplayLabel = #1051#1086#1075#1080#1085' '#1083'/'#1089
      DisplayWidth = 20
      FieldName = 'LOGIN'
      Size = 120
    end
    object qReportCOUNT_PHONE: TFloatField
      DisplayLabel = #1050#1086#1083'-'#1074#1086' '#1085#1086#1084#1077#1088#1086#1074
      DisplayWidth = 12
      FieldName = 'COUNT_PHONE'
    end
    object qReportCOUNT_BILLS: TFloatField
      DisplayLabel = #1050#1086#1083'-'#1074#1086' '#1085#1077#1085#1091#1083'. '#1089#1095#1077#1090#1086#1074
      DisplayWidth = 12
      FieldName = 'COUNT_BILLS'
    end
    object qReportLOAD_SUM_CALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080'('#1076#1077#1090#1072#1083'.)'
      DisplayWidth = 12
      FieldName = 'LOAD_SUM_CALLS'
    end
    object qReportBILL_SUM_CALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080'('#1089#1095#1077#1090#1072')'
      DisplayWidth = 12
      FieldName = 'BILL_SUM_CALLS'
    end
    object qReportDETAIL_SUM_NO_LOAD: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080'('#1085#1077' '#1079#1072#1075#1088#1091#1078'.)'
      DisplayWidth = 12
      FieldName = 'DETAIL_SUM_NO_LOAD'
    end
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT DI.YEAR_MONTH,'
      
        '       TRUNC(DI.YEAR_MONTH/100) || '#39' - '#39' || (DI.YEAR_MONTH - TRU' +
        'NC(DI.YEAR_MONTH/100)*100) YEAR_MONTH_NAME'
      '  FROM DETAILS_INFO DI'
      '  GROUP BY DI.YEAR_MONTH'
      '  ORDER BY DI.YEAR_MONTH DESC')
    FetchAll = True
    Left = 200
    Top = 80
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 104
    Top = 96
  end
  object ActionList: TActionList
    Images = MainForm.ImageList24
    Left = 320
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
  end
end
