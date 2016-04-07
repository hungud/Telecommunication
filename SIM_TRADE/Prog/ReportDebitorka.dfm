object ReportDebitorkaForm: TReportDebitorkaForm
  Left = 0
  Top = 0
  Caption = #1044#1077#1073#1080#1090#1086#1088#1089#1082#1072#1103' '#1079#1072#1076#1086#1083#1078#1077#1085#1085#1086#1089#1090#1100
  ClientHeight = 332
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 377
    Top = 28
    Width = 2
    Height = 304
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ExplicitLeft = 235
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 28
    Align = alTop
    TabOrder = 0
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
      Width = 81
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 291
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
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object cbOnlyMinus: TCheckBox
      Left = 356
      Top = 5
      Width = 161
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1077
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = cbOnlyMinusClick
    end
  end
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 377
    Height = 304
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel2: TPanel
    Left = 379
    Top = 28
    Width = 444
    Height = 304
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 2
    object CRDBGrid2: TCRDBGrid
      Left = 1
      Top = 1
      Width = 442
      Height = 156
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      DataSource = dsReportRows
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -10
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object alReports: TActionList
    Images = MainForm.ImageList24
    Left = 96
    Top = 176
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
      'select V.PHONE_NUMBER,'
      '       V.CELL_PLAN_CODE,'
      '       CASE'
      '         WHEN :CHECK_MINUS = 1 THEN V.PAYMENTS_ALL_MINUS'
      '         ELSE V.PAYMENTS_ALL'
      '       END AS PAYMENTS_ALL,'
      '       CASE'
      '         WHEN :CHECK_MINUS = 1 THEN V.BILLS_ALL_MINUS'
      '         ELSE V.BILLS_ALL'
      '       END AS BILLS_ALL,'
      '       CASE'
      '         WHEN :CHECK_MINUS = 1 THEN V.DEBITORKA_MINUS'
      '         ELSE V.DEBITORKA'
      '       END AS DEBITORKA,'
      '       CASE'
      '         WHEN :CHECK_MINUS = 1 THEN V.DEBITORKA_BEELINE_MINUS'
      '         ELSE V.DEBITORKA_BEELINE'
      '       END AS DEBITORKA_BEELINE'
      '  from V_DEBITORKA V'
      '  WHERE (:CHECK_MINUS = 0) '
      '    OR (:CHECK_MINUS = 1 AND PAYMENTS_ALL_MINUS IS NOT NULL)')
    FetchAll = True
    ReadOnly = True
    Left = 216
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CHECK_MINUS'
      end>
    object qReportPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportCELL_PLAN_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1058#1055
      DisplayWidth = 12
      FieldName = 'CELL_PLAN_CODE'
      Size = 50
    end
    object qReportPAYMENTS_ALL: TFloatField
      DisplayLabel = #1055#1083#1072#1090#1077#1078#1080
      DisplayWidth = 12
      FieldName = 'PAYMENTS_ALL'
    end
    object qReportBILLS_ALL: TFloatField
      DisplayLabel = #1057#1095#1077#1090#1072
      DisplayWidth = 12
      FieldName = 'BILLS_ALL'
    end
    object qReportDEBITORKA: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090
      DisplayWidth = 12
      FieldName = 'DEBITORKA'
    end
    object qReportDEBITORKA_BEELINE: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090' '#1041#1080#1083#1072#1081#1085#1072
      DisplayWidth = 12
      FieldName = 'DEBITORKA_BEELINE'
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    OnDataChange = dsReportDataChange
    Left = 256
    Top = 96
  end
  object qReportRows: TOraQuery
    SQL.Strings = (
      'select * '
      '  from contract_statistics'
      '  where phone_number = :PHONE_NUMBER')
    ReadOnly = True
    Left = 456
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qReportRowsPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qReportRowsDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      FieldName = 'DATE_BEGIN'
      Required = True
    end
    object qReportRowsDATE_CANCEL: TDateTimeField
      DisplayLabel = #1056#1072#1089#1090#1086#1088#1078#1077#1085#1080#1077
      FieldName = 'DATE_CANCEL'
    end
    object qReportRowsBILLS_SUMM_ALL: TFloatField
      DisplayLabel = #1057#1095#1077#1090#1072' '#1082#1083'.'
      FieldName = 'BILLS_SUMM_ALL'
    end
    object qReportRowsPAYMENTS_SUMM_ALL: TFloatField
      DisplayLabel = #1042#1089#1077' '#1087#1083#1072#1090#1077#1078#1080
      FieldName = 'PAYMENTS_SUMM_ALL'
    end
    object qReportRowsBILLS_SUMM_BEELINE: TFloatField
      DisplayLabel = #1057#1095#1077#1090#1072' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'BILLS_SUMM_BEELINE'
    end
    object qReportRowsPAYMENTS_SUMM_BEELINE: TFloatField
      DisplayLabel = #1055#1083#1072#1090#1077#1078#1080' '#1041#1080#1083#1072#1081#1085#1072
      FieldName = 'PAYMENTS_SUMM_BEELINE'
    end
    object qReportRowsDEBITORKA: TFloatField
      DisplayLabel = #1044#1077#1073#1080#1090
      FieldName = 'DEBITORKA'
    end
    object qReportRowsSTAT_COMPLETE: TFloatField
      DisplayLabel = #1047#1072#1074#1077#1088#1096#1077#1085
      FieldName = 'STAT_COMPLETE'
    end
  end
  object dsReportRows: TDataSource
    DataSet = qReportRows
    Left = 504
    Top = 136
  end
end
