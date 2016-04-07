object RepAllPhonesFrm: TRepAllPhonesFrm
  Left = 0
  Top = 0
  Caption = #1042#1089#1077' '#1090#1077#1083#1077#1092#1086#1085#1099
  ClientHeight = 427
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 877
    Height = 97
    Align = alTop
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      Left = 232
      Top = 10
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
      Top = 10
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
    object BitBtn1: TBitBtn
      Left = 391
      Top = 3
      Width = 151
      Height = 31
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 548
      Top = 3
      Width = 105
      Height = 31
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 659
      Top = 3
      Width = 134
      Height = 30
      Action = aShowUserStatInfo
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 286
      Top = 7
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 799
      Top = 9
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object CLB_Accounts: TsCheckListBox
      Left = 76
      Top = 6
      Width = 150
      Height = 79
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = CLB_AccountsClick
      OnExit = CLB_AccountsExit
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
    object CB_cancel: TCheckBox
      Left = 232
      Top = 66
      Width = 289
      Height = 17
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1080#1077' '#1074#1089#1077#1093' '#1083#1080#1094#1077#1074#1099#1093' '#1089#1095#1077#1090#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = CB_cancelClick
    end
  end
  object GRData: TCRDBGrid
    Left = 0
    Top = 97
    Width = 877
    Height = 330
    Align = alClient
    DataSource = dsReport
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ACCOUNT_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1057#1095#1077#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'YEAR_MONTH'
        Title.Alignment = taCenter
        Title.Caption = #1043#1086#1076'/'#1052#1077#1089#1103#1094
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end
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
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_CHECK_DATE_TIME'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1089#1090#1072#1090#1091#1089#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TARIFF_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1082#1091#1097#1080#1081' '#1090#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 202
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONSERVATION'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080' '#1083#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SYSTEM_BLOCK'
        Title.Alignment = taCenter
        Title.Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 196
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IS_CONTRACT'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1083#1080#1095#1080#1077' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 196
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS_CONTRACT'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTRACT_CANCEL_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1084#1077#1085#1099' '#1082#1086#1085#1090#1088'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 168
    Top = 128
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ImageIndex = 12
      OnExecute = BitBtn1Click
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = BitBtn2Click
    end
    object aShowUserStatInfo: TAction
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      OnExecute = BitBtn3Click
    end
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'select '
      '    a.account_number, '
      '    db.year_month, '
      '    db.phone_number, '
      '    decode(nvl(db.phone_is_active,0),1,'#39#1044#1072#39','#39#1053#1077#1090#39') as Status, '
      '    db.last_check_date_time, '
      '    NVL (t.tariff_name, db.cell_plan_code) AS tariff_name, '
      
        '    decode(nvl(db.CONSERVATION,0),1,'#39#1044#1072#39','#39#1053#1077#1090#39') as CONSERVATION,' +
        ' '
      
        '    decode(nvl(db.system_block,0),1,'#39#1044#1072#39','#39#1053#1077#1090#39') as system_block,' +
        ' '
      '    decode(nvl(vc.CONTRACT_ID,0),0,'#39#1053#1077#1090#39','#39#1044#1072#39') is_contract, '
      '    case '
      
        '      when vc.CONTRACT_CANCEL_DATE <= last_day(to_date(201512,'#39'Y' +
        'YYYDD'#39')) then '
      '        '#39#1047#1072#1082#1088#1099#1090#39' '
      '    else '
      '      decode(nvl(vc.CONTRACT_ID,0),0,'#39#39','#39#1044#1077#1081#1089#1090#1074#1091#1077#1090#39' ) '
      '    end as status_contract, '
      '    vc.CONTRACT_CANCEL_DATE '
      '  from '
      '    ACCOUNTS a, '
      '    db_loader_account_phones db, '
      '    tariffs t, '
      '    v_contracts vc '
      '  where db.year_month=201512'
      '--and db.account_id in ()'
      'and a.account_id=db.account_id'
      ' AND t.tariff_id(+) =  '
      '            get_phone_tariff_id( '
      '                                 db.phone_number, '
      '                                 db.cell_plan_code, '
      '                                 db.last_check_date_time) '
      ' and db.phone_number=vc.PHONE_NUMBER_FEDERAL(+)')
    Left = 360
    Top = 154
    object qReportACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 32
    end
    object qReportLAST_CHECK_DATE_TIME: TDateTimeField
      FieldName = 'LAST_CHECK_DATE_TIME'
    end
    object qReportTARIFF_NAME: TStringField
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qReportCONSERVATION: TStringField
      FieldName = 'CONSERVATION'
      Size = 32
    end
    object qReportSYSTEM_BLOCK: TStringField
      FieldName = 'SYSTEM_BLOCK'
      Size = 32
    end
    object qReportIS_CONTRACT: TStringField
      FieldName = 'IS_CONTRACT'
      Size = 32
    end
    object qReportSTATUS_CONTRACT: TStringField
      FieldName = 'STATUS_CONTRACT'
      Size = 18
    end
    object qReportCONTRACT_CANCEL_DATE: TDateTimeField
      FieldName = 'CONTRACT_CANCEL_DATE'
    end
  end
  object dsReport: TOraDataSource
    DataSet = qReport
    Left = 419
    Top = 167
  end
end
