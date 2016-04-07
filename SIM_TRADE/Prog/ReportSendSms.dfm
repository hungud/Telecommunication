object ReportSendSmsFrm: TReportSendSmsFrm
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1085#1099#1093' '#1089#1084#1089
  ClientHeight = 346
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrData: TCRDBGrid
    Left = 0
    Top = 33
    Width = 1015
    Height = 313
    Align = alClient
    DataSource = dsSendSms
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABONENT_FIO'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1060'.'#1048'.'#1054'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 248
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SEND_DATE_TIME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 181
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1015
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 868
    object pAccount: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 33
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 632
      ExplicitTop = 16
      ExplicitHeight = 41
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
      object cbAccounts: TComboBox
        Left = 76
        Top = 6
        Width = 98
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbAccountsChange
      end
    end
    object pPeriod: TPanel
      Left = 185
      Top = 0
      Width = 288
      Height = 33
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 1
        Top = 8
        Width = 56
        Height = 13
        Caption = #1055#1077#1088#1080#1086#1076' '#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 164
        Top = 8
        Width = 15
        Height = 13
        Caption = #1087#1086
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dtFrom: TDateTimePicker
        Left = 63
        Top = 6
        Width = 95
        Height = 21
        Date = 41904.632102939820000000
        Time = 41904.632102939820000000
        TabOrder = 0
      end
      object dtTo: TDateTimePicker
        Left = 186
        Top = 6
        Width = 95
        Height = 21
        Date = 41904.632102939820000000
        Time = 41904.632102939820000000
        TabOrder = 1
      end
    end
    object pButton: TPanel
      Left = 473
      Top = 0
      Width = 542
      Height = 33
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = 257
      ExplicitTop = 1
      ExplicitWidth = 344
      ExplicitHeight = 26
      object BitBtn1: TBitBtn
        Left = 6
        Top = 2
        Width = 151
        Height = 29
        Action = aExcel
        Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object BitBtn2: TBitBtn
        Left = 163
        Top = 2
        Width = 105
        Height = 29
        Action = aRefresh
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 274
        Top = 2
        Width = 111
        Height = 29
        Action = aShowUserStatInfo
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object cbSearch: TCheckBox
        Left = 405
        Top = 8
        Width = 60
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
    end
  end
  object dsSendSms: TDataSource
    DataSet = qSendSms
    Left = 88
    Top = 144
  end
  object qSendSms: TOraQuery
    SQLRefresh.Strings = (
      
        'SELECT PHONE_NUMBER,CLIENT_NAME,CLIENT_SURNAME,DATE_OF_SEND,TIME' +
        '_OF_SEND FROM Block_SEND_SMS'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID,'
      '       BLOCK_SEND_SMS.PHONE_NUMBER, '
      '       BLOCK_SEND_SMS.ABONENT_FIO, '
      '       BLOCK_SEND_SMS.SEND_DATE_TIME '
      '  FROM BLOCK_SEND_SMS,'
      '       DB_LOADER_ACCOUNT_PHONES'
      
        '  WHERE BLOCK_SEND_SMS.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHONES.PHO' +
        'NE_NUMBER(+)'
      
        '    AND TO_NUMBER(TO_CHAR(BLOCK_SEND_SMS.SEND_DATE_TIME,'#39'YYYYMM'#39 +
        '))=DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH(+) '
      
        '    AND ((:ACCOUNT_ID=-1)OR(:ACCOUNT_ID IS NULL)OR(DB_LOADER_ACC' +
        'OUNT_PHONES.ACCOUNT_ID=:ACCOUNT_ID))'
      '    AND ('
      '          (:DATE_FROM IS NULL AND :DATE_TO IS NULL) OR '
      
        '          (to_date(to_char(BLOCK_SEND_SMS.SEND_DATE_TIME, '#39'ddmmy' +
        'yyy'#39'), '#39'dd.mm.yyyy'#39') BETWEEN to_date(to_char(:DATE_FROM, '#39'ddmmyy' +
        'yy'#39'), '#39'dd.mm.yyyy'#39') AND to_date(to_char(:DATE_TO, '#39'ddmmyyyy'#39'), '#39 +
        'dd.mm.yyyy'#39'))'
      '        )  '
      ''
      '  ORDER BY SEND_DATE_TIME DESC')
    FetchRows = 250
    Left = 48
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_FROM'
      end
      item
        DataType = ftUnknown
        Name = 'DATE_TO'
      end>
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select -1 as ACCOUNT_ID,'#39#1042#1089#1077#39' as LOGIN  from dual'
      'union '
      'SELECT a.ACCOUNT_ID, a.LOGIN '
      'FROM ACCOUNTS a'
      'ORDER BY 2 ASC')
    Left = 136
    Top = 80
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
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
end
