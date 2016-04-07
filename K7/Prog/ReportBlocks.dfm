object ReportBlocksForm: TReportBlocksForm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1088#1091#1095#1085#1086#1081' '#1086#1090#1083#1086#1078#1077#1085#1085#1086#1081' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1077
  ClientHeight = 429
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pButtons: TPanel
    Left = 0
    Top = 0
    Width = 837
    Height = 33
    Align = alTop
    TabOrder = 0
    object btRefresh: TBitBtn
      Left = 1
      Top = 1
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btLoadInExcel: TBitBtn
      Left = 112
      Top = 1
      Width = 135
      Height = 29
      Action = aLoadInExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object bShowUserStatInfo: TBitBtn
      Left = 289
      Top = 1
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object gReport: TCRDBGrid
    Left = 0
    Top = 33
    Width = 837
    Height = 396
    OptionsEx = [dgeRecordCount]
    Align = alClient
    DataSource = dsReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'phone_number'
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'block_date_time'
        Title.Caption = #1044#1072#1090#1072' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'user_name'
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100', '#1091#1089#1090#1072#1085#1086#1074#1080#1074#1096#1080#1081
        Width = 158
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unblock_date_time'
        Title.Caption = #1076#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unblock_user_name'
        Title.Caption = #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' , '#1086#1090#1082#1083#1102#1095#1080#1074#1096#1080#1081
        Width = 163
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ballance'
        Title.Caption = #1041#1072#1083#1072#1085#1089' '#1085#1072' '#1084#1086#1084#1077#1085#1090' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103
        Width = 172
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ballance_unlock'
        Title.Caption = #1073#1072#1083#1072#1085#1089' '#1085#1072' '#1084#1086#1084#1077#1085#1090' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Width = 169
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE_NOTICE_HAND_BLOCK'
        Title.Caption = #1041#1072#1083#1072#1085#1089' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'block_balance'
        Title.Caption = #1041#1072#1083#1072#1085#1089' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
        Width = 126
        Visible = True
      end>
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 128
    Top = 88
  end
  object qReport: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT *'
      'FROM V_REPORT_HAND_DELAYED_LOCK')
    Left = 72
    Top = 88
  end
  object aList: TActionList
    Images = MainForm.ImageList24
    Left = 24
    Top = 88
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aLoadInExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aLoadInExcelExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ImageIndex = 22
      OnExecute = aShowUserStatInfoExecute
    end
  end
end
