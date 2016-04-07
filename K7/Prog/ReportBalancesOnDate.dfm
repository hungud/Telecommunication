object ReportBalancesOnDateForm: TReportBalancesOnDateForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1083#1091#1095#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1086#1074' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 460
  ClientWidth = 976
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
    Width = 976
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
    object btLoadInExcel: TBitBtn
      Left = 201
      Top = 0
      Width = 161
      Height = 37
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
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 362
      Top = 0
      Width = 111
      Height = 37
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
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 473
      Top = 0
      Width = 108
      Height = 37
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 589
      Top = 7
      Width = 78
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object dtpDateTime: TDateTimePicker
      Left = 8
      Top = 6
      Width = 186
      Height = 24
      Date = 41465.629869849540000000
      Time = 41465.629869849540000000
      TabOrder = 4
      OnChange = dtpDateTimeChange
    end
    object cbFilter: TCheckBox
      Left = 669
      Top = 8
      Width = 78
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1060#1080#1083#1100#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = cbFilterClick
    end
  end
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 37
    Width = 976
    Height = 423
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
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_DATE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BILL_SUM_DATE_NEW_MONTH'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 126
        Visible = True
      end>
  end
  object aReport: TActionList
    Images = MainForm.ImageList24
    Left = 40
    Top = 128
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
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT T1.PHONE_NUMBER,'
      '       GET_ABONENT_BALANCE(T1.PHONE_NUMBER, :pDATE) BALANCE,'
      '       (SELECT FB.BILL_SUM'
      '          FROM DB_LOADER_FULL_FINANCE_BILL FB'
      '          WHERE FB.PHONE_NUMBER = T1.PHONE_NUMBER'
      
        '            AND FB.YEAR_MONTH = TO_NUMBER(TO_CHAR(:pDATE, '#39'YYYYM' +
        'M'#39'))) BILL_SUM_DATE, '
      '       (SELECT FB.BILL_SUM'
      '          FROM DB_LOADER_FULL_FINANCE_BILL FB'
      '          WHERE FB.PHONE_NUMBER = T1.PHONE_NUMBER'
      
        '            AND FB.YEAR_MONTH = TO_NUMBER(TO_CHAR(ADD_MONTHS(:pD' +
        'ATE, 1), '#39'YYYYMM'#39'))) BILL_SUM_DATE_NEW_MONTH '
      '  FROM (SELECT PHONE_NUMBER'
      '          FROM DB_LOADER_ACCOUNT_PHONES'
      
        '          WHERE YEAR_MONTH = TO_NUMBER(TO_CHAR(:pDATE, '#39'YYYYMM'#39')' +
        ')) T1')
    FetchRows = 500
    Left = 128
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pDATE'
      end>
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportBALANCE: TFloatField
      DisplayLabel = #1041#1072#1083#1072#1085#1089
      FieldName = 'BALANCE'
    end
    object qReportBILL_SUM_DATE: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1074' '#1084#1077#1089#1103#1094' '#1076#1072#1090#1099
      DisplayWidth = 15
      FieldName = 'BILL_SUM_DATE'
    end
    object qReportBILL_SUM_DATE_NEW_MONTH: TFloatField
      DisplayLabel = #1057#1095#1077#1090' '#1089#1083#1077#1076' '#1084#1077#1089#1103#1094#1072
      DisplayWidth = 15
      FieldName = 'BILL_SUM_DATE_NEW_MONTH'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 128
    Top = 128
  end
end
