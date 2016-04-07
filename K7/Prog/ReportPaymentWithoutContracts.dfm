object ReportPaymentWithoutContractsForm: TReportPaymentWithoutContractsForm
  Left = 0
  Top = 0
  Caption = #1055#1083#1072#1090#1077#1078#1080' '#1073#1077#1079' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  ClientHeight = 535
  ClientWidth = 872
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object ReportGrid: TCRDBGrid
    Left = 0
    Top = 37
    Width = 872
    Height = 498
    Align = alClient
    DataSource = dsReport
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 872
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 1
    object btLoadInExcel: TBitBtn
      Left = 0
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
      Left = 161
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
      Left = 272
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
      Left = 388
      Top = 8
      Width = 79
      Height = 23
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
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 208
    Top = 112
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT P.*,'
      '       (SELECT MAX(C.CONTRACT_DATE)'
      '          FROM CONTRACTS C'
      '          WHERE C.PHONE_NUMBER_FEDERAL=P.PHONE_NUMBER'
      '            AND C.CONTRACT_ID NOT IN ('
      '                  SELECT CC.CONTRACT_ID'
      '                   FROM CONTRACT_CANCELS CC'
      '                 )) CONTRACT_DATE,'
      '       (SELECT PH.CELL_PLAN_CODE'
      '          FROM DB_LOADER_ACCOUNT_PHONES PH'
      '          WHERE PH.PHONE_NUMBER = P.PHONE_NUMBER'
      
        '            AND PH.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, '#39'YYYY' +
        'MM'#39'))'
      '            AND ROWNUM <= 1) TARIFF_CODE'
      '  FROM DB_LOADER_PAYMENTS P'
      '  WHERE P.PAYMENT_DATE>=SYSDATE-4'
      '    AND (P.PHONE_NUMBER NOT IN ('
      '           SELECT C.PHONE_NUMBER_FEDERAL'
      '             FROM CONTRACTS C'
      '             WHERE C.CONTRACT_ID NOT IN (SELECT CC.CONTRACT_ID'
      
        '                                           FROM CONTRACT_CANCELS' +
        ' CC)'
      '           )'
      '      OR P.PHONE_NUMBER IN ('
      '           SELECT PH.PHONE_NUMBER'
      '             FROM DB_LOADER_ACCOUNT_PHONES PH'
      '             WHERE PH.CONSERVATION=1'
      '               AND PH.LAST_CHECK_DATE_TIME>P.PAYMENT_DATE'
      
        '               AND PH.PHONE_NUMBER IN (SELECT C1.PHONE_NUMBER_FE' +
        'DERAL'
      '                                         FROM CONTRACTS C1'
      
        '                                         WHERE C1.CONTRACT_DATE>' +
        'SYSDATE-4)'
      '           )'
      '       )'
      '  ORDER BY P.PAYMENT_DATE DESC')
    FetchAll = True
    Left = 136
    Top = 96
    object qReportPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportPAYMENT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 12
      FieldName = 'PAYMENT_DATE'
    end
    object qReportPAYMENT_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'PAYMENT_SUM'
    end
    object qReportPAYMENT_NUMBER: TStringField
      DisplayLabel = #1053#1086#1080#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 30
      FieldName = 'PAYMENT_NUMBER'
      Size = 120
    end
    object qReportCONTRACT_DATE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 12
      FieldName = 'CONTRACT_DATE'
    end
    object qReportTARIFF_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1090#1072#1088#1080#1092#1072
      DisplayWidth = 12
      FieldName = 'TARIFF_CODE'
      Size = 200
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
