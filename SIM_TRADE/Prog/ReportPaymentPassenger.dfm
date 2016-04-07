object ReportPaymentPassengerForm: TReportPaymentPassengerForm
  Left = 0
  Top = 0
  Caption = #1055#1072#1089#1089#1072#1078#1080#1088#1089#1082#1080#1081
  ClientHeight = 431
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 484
    Height = 403
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 28
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 691
    object btLoadInExcel: TBitBtn
      Left = 0
      Top = 0
      Width = 121
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 121
      Top = 0
      Width = 83
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 204
      Top = 0
      Width = 93
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 208
    Top = 112
  end
  object qReport: TOraQuery
    SQL.Strings = (
      
        'SELECT phone, sum_pay, TO_CHAR(date_insert,'#39'dd.mm.yyyy'#39') date_in' +
        'sert, TO_CHAR(date_pay,'#39'dd.mm.yyyy'#39') date_pay'
      'FROM mob_pay'
      'ORDER BY 1')
    FetchRows = 250
    Left = 136
    Top = 96
    object qReportPhone: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'PHONE'
      Size = 11
    end
    object qReportSUM_PAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'SUM_PAY'
    end
    object qReportDATE_INSERT: TStringField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072
      DisplayWidth = 12
      FieldName = 'DATE_INSERT'
      Size = 12
    end
    object qReportDATE_PAY: TStringField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 12
      FieldName = 'DATE_PAY'
      Size = 12
    end
  end
  object alReport: TActionList
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
end
