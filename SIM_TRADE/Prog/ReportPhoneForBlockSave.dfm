object ReportPhoneForBlockSaveForm: TReportPhoneForBlockSaveForm
  Left = 0
  Top = 0
  Caption = #1053#1086#1084#1077#1088#1072' '#1074' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1091' '#1085#1072' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
  ClientHeight = 402
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 28
    Align = alTop
    TabOrder = 0
    object lAccount: TLabel
      Left = 8
      Top = 8
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
      Left = 180
      Top = 0
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 331
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 436
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbAccounts: TComboBox
      Left = 76
      Top = 3
      Width = 98
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      OnChange = cbAccountsChange
    end
    object cbSearch: TCheckBox
      Left = 553
      Top = 6
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
      OnClick = cbSearchClick
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 28
    Width = 697
    Height = 374
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'BEGIN_DATE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABONENT_FIO'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1060'.'#1048'.'#1054'.'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOP_STATUS'
        Title.Caption = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
        Width = 76
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 56
    Top = 72
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
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qAccounts: TOraQuery
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN FROM ACCOUNTS ORDER BY LOGIN ASC')
    Left = 152
    Top = 72
  end
  object qReport: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT * '
      '  from V_PHONE_NUMBER_FOR_BLOCK_SAVE'
      '  WHERE ((:ACCOUNT_ID IS NULL)OR(ACCOUNT_ID=:ACCOUNT_ID))')
    FetchRows = 500
    Left = 56
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 88
    Top = 144
  end
end
