object ReportMobPaymentsForm: TReportMobPaymentsForm
  Left = 0
  Top = 0
  Caption = 'MobPay'
  ClientHeight = 401
  ClientWidth = 691
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
    Width = 691
    Height = 373
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsReport
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 28
    Align = alTop
    TabOrder = 1
    object btLoadInExcel: TBitBtn
      Left = 0
      Top = 0
      Width = 121
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
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
      DoubleBuffered = True
      ParentDoubleBuffered = False
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
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 291
      Top = 0
      Width = 81
      Height = 28
      Hint = #1059#1076#1072#1083#1077#1085#1080#1077' '#1072#1073#1086#1085#1077#1085#1090#1072' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1074#1086#1079#1084#1086#1078#1085#1099#1093' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1087#1083#1072#1090#1077#1078#1072'.'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 371
      Top = 0
      Width = 81
      Height = 28
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1087#1083#1072#1090#1077#1078' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      Caption = #1054#1087#1083#1072#1090#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BitBtn2Click
    end
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 208
    Top = 112
  end
  object qReport: TOraQuery
    SQL.Strings = (
      
        'select ul.msisdn,ul.ussd_date,ul.text_res,count(mpl.phone),nvl(m' +
        'p.sum_pay*(select count(mpl1.phone) from mob_pay_log mpl1'
      'where ul.msisdn=mpl1.phone'
      
        'and mpl1.error_text='#39'OK {"success":true}'#39'),0) as ss  from ussd_l' +
        'og ul,mob_pay_log mpl,mob_pay mp'
      'where ul.ussd='#39'*132*122#'#39
      'and ul.type_log=1'
      'and mpl.phone=ul.msisdn'
      'and mp.phone(+)=mpl.phone'
      'and mpl.date_insert between mp.date_insert(+) and mp.date_pay(+)'
      'group by ul.msisdn,ul.ussd_date,ul.text_res,mp.sum_pay'
      'order by 2')
    Left = 136
    Top = 96
    object qReportMSISDN: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'MSISDN'
      Size = 11
    end
    object qReportUSSD_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' USSD '#1079#1072#1087#1088#1086#1089#1072
      FieldName = 'USSD_DATE'
    end
    object qReportTEXT_RES: TStringField
      DisplayLabel = #1056#1077#1079#1091#1083#1100#1090#1072#1090' USSD '#1079#1072#1087#1088#1086#1089#1072
      DisplayWidth = 50
      FieldName = 'TEXT_RES'
      Size = 200
    end
    object qReportCOUNTMPLPHONE: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1089#1072#1081#1090
      FieldName = 'COUNT(MPL.PHONE)'
    end
    object SS: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1077#1081
      FieldName = 'SS'
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
  object pMOBPAYDEL: TOraStoredProc
    StoredProcName = 'GET_MOB_PAY_DELTXT'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := GET_MOB_PAY_DELTXT(:PPHONEA);'
      'end;')
    Left = 280
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONEA'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'GET_MOB_PAY_DELTXT'
  end
  object pMOBPAY: TOraStoredProc
    StoredProcName = 'GET_MOB_PAY_TXT'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  :RESULT := GET_MOB_PAY_TXT(:PPHONEA);'
      'end;')
    Left = 360
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONEA'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'GET_MOB_PAY_TXT'
  end
end
