object ReportKolNomFrm: TReportKolNomFrm
  Left = 0
  Top = 0
  Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1086#1084#1077#1088#1086#1074' '#1085#1072' '#1083#1080#1094#1077#1074#1086#1084' '#1089#1095#1105#1090#1077
  ClientHeight = 452
  ClientWidth = 1038
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object GrData: TCRDBGrid
    Left = 0
    Top = 37
    Width = 1038
    Height = 415
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    DataSource = dsKolNom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'acclogin'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1051#1086#1075#1080#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'accnumber'
        Title.Alignment = taCenter
        Title.Caption = #1057#1095#1105#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUMACTIVE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1040#1082#1090#1080#1074#1085#1099#1093
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
        FieldName = 'sumblock'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1085#1085#1099#1093
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sumsohr'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1072' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'summosh'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1052#1086#1096#1077#1085#1085#1080#1082#1080' ('#1089#1080#1089'.'#1073#1083'.)'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 136
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNT_PHONES'
        Title.Alignment = taCenter
        Title.Caption = #1042#1089#1077#1075#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 72
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1038
    Height = 37
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 968
    object BitBtn1: TBitBtn
      Left = 3
      Top = 0
      Width = 197
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 200
      Top = 0
      Width = 137
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
      TabOrder = 1
    end
    object cbSearch: TCheckBox
      Left = 350
      Top = 7
      Width = 79
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
      TabOrder = 2
      OnClick = cbSearchClick
    end
  end
  object dsKolNom: TDataSource
    DataSet = qKolNom
    Left = 128
    Top = 144
  end
  object qKolNom: TOraQuery
    SQLRefresh.Strings = (
      
        'SELECT PHONE_NUMBER,CLIENT_NAME,CLIENT_SURNAME,DATE_OF_SEND,TIME' +
        '_OF_SEND FROM Block_SEND_SMS'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'select * from v_account_stat_by_status_now')
    FetchRows = 250
    Left = 56
    Top = 136
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
