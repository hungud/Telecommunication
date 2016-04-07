object repAutoTurnInternetCurr: TrepAutoTurnInternetCurr
  Left = 0
  Top = 0
  Caption = #1040#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1086#1087#1094#1080#1081' ('#1090#1077#1082#1091#1097#1080#1081' '#1084#1077#1089#1103#1094')'
  ClientHeight = 617
  ClientWidth = 1507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1507
    Height = 35
    Align = alTop
    TabOrder = 0
    object lAccount: TLabel
      Left = 8
      Top = 10
      Width = 48
      Height = 13
      Caption = #1053#1086#1084#1077#1088' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 194
      Top = 2
      Width = 150
      Height = 30
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 346
      Top = 2
      Width = 104
      Height = 30
      Action = aRefresh
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object EditPhone: TEdit
      Left = 62
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyDown = EditPhoneKeyDown
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 35
    Width = 1507
    Height = 582
    Align = alClient
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PHONE'
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_NUM'
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONTRACT_DATE'
        Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 68
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IS_ACTIVE_WORD'
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BEGIN_DATE'
        Title.Caption = #1044#1072#1090#1072' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOP_STATUS'
        Title.Caption = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_CODE'
        Title.Caption = #1050#1086#1076' '#1090#1072#1088#1080#1092#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF'
        Title.Caption = #1040#1073#1086#1085'.'#1087#1083#1072#1090#1072' '#1087#1086' '#1090#1072#1088#1080#1092#1077#1088#1091
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROFIT'
        Title.Caption = #1044#1086#1093#1086#1076#1085#1086#1089#1090#1100
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_OPER'
        Title.Caption = #1040#1073#1086#1085'.'#1041#1080#1083#1072#1081#1085
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FSG_TT1'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FSG_TT2'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FSG_TT3'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GPRS_20GB'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GPRS_30GB'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GPRS_20G'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GPRS_30G'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GPRS_U'
        Width = 54
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'GPRS_U_ON'
        Title.Caption = 'GPRS_U '#1042#1082#1083#1102#1095#1077#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1081' '#1088#1072#1079' ...'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNKNOWN'
        Title.Caption = #1053#1077#1080#1079#1074'.'#1086#1087#1094#1080#1080
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MGN500MIN'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL_TRAFF'
        Title.Caption = #1058#1088#1072#1092#1080#1082' '#1080#1085#1090#1077#1088#1085#1077#1090' ('#1086#1073#1097#1080#1081' '#1087#1086#1090#1088#1077#1073#1083#1077#1085#1085#1099#1081')'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OUTCOM_MI'
        Title.Caption = #1048#1089#1093'. '#1084#1080#1085#1091#1090' ('#1086#1073#1097#1077#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086')'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENTS'
        Title.Caption = #1057#1091#1084#1084#1072' '#1087#1086#1087#1086#1083#1085#1077#1085#1080#1081' '#1079#1072' '#1084#1077#1089#1103#1094
        Width = 92
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SPEED3B2B_WORD'
        Title.Caption = 'SPEED3B2B '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
        Width = 123
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTM41_W'
        Title.Caption = 'DTM41 '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
        Width = 96
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 64
    Top = 80
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
  object qReport: TOraQuery
    SQL.Strings = (
      'select qq.*, '
      
        '       qq.tariff-(qq.tariff_oper+FSG_TT1+FSG_TT2+FSG_TT3+GPRS_20' +
        'GB+GPRS_30GB+GPRS_20G+GPRS_30G+GPRS_U+MGN500MIN+unknown) profit,'
      '       case when DTM41 <> 0 then '#39#1042#1082#1083#1102#1095#1077#1085#1086#39' else '#39#39' end DTM41_w'
      
        'from table(beeline_rest_api_pckg.rep_gprs_autoturn_mon(:phone)) ' +
        'qq'
      'order by phone')
    FetchRows = 250
    ReadOnly = True
    Left = 64
    Top = 136
    ParamData = <
      item
        DataType = ftString
        Name = 'phone'
        ParamType = ptInput
        Value = ''
      end>
  end
  object DataSource1: TDataSource
    DataSet = qReport
    Left = 64
    Top = 184
  end
end
