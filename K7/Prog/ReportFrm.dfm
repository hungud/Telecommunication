object ReportForm: TReportForm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090
  ClientHeight = 402
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pButtons: TPanel
    Left = 0
    Top = 0
    Width = 690
    Height = 29
    Align = alTop
    TabOrder = 0
    object btRefresh: TBitBtn
      Left = 1
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btLoadInExcel: TBitBtn
      Left = 105
      Top = 0
      Width = 135
      Height = 29
      Action = aLoadInExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btnShowUserStatInfo: TBitBtn
      Left = 239
      Top = 0
      Width = 135
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object pGrid: TPanel
    Left = 0
    Top = 29
    Width = 690
    Height = 373
    Align = alClient
    TabOrder = 1
    object gReport: TCRDBGrid
      Left = 1
      Top = 1
      Width = 688
      Height = 371
      Align = alClient
      DataSource = dsReport
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object qReport: TOraQuery
    Session = MainForm.OraSession
    Left = 72
    Top = 88
  end
  object dsReport: TDataSource
    DataSet = qReport
    Left = 128
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
    end
  end
end
