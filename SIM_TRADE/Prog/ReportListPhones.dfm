object fReportListPhones: TfReportListPhones
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1082#1086#1074#1099#1081' '#1086#1090#1095#1077#1090
  ClientHeight = 446
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 601
    Height = 129
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 519
    object lAccount: TLabel
      Left = 8
      Top = 7
      Width = 119
      Height = 13
      Caption = #1053#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 215
      Top = 7
      Width = 87
      Height = 13
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1083#1077#1081':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnCalculate: TButton
      Left = 427
      Top = 4
      Width = 130
      Height = 25
      Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
      TabOrder = 0
      OnClick = btnCalculateClick
    end
    object memPhoneList: TMemo
      Left = 8
      Top = 26
      Width = 180
      Height = 95
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object cbListFields: TCheckListBox
      Left = 215
      Top = 26
      Width = 186
      Height = 95
      ItemHeight = 13
      TabOrder = 2
    end
    object btLoadInExcel: TBitBtn
      Left = 427
      Top = 35
      Width = 130
      Height = 29
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btLoadInExcelClick
    end
  end
  object grReport: TCRDBGrid
    Left = 0
    Top = 129
    Width = 601
    Height = 292
    Align = alClient
    DataSource = dsRepoprt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
        Width = 158
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 421
    Width = 601
    Height = 25
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitWidth = 519
    object Gauge1: TGauge
      Left = 1
      Top = 1
      Width = 599
      Height = 23
      Align = alClient
      BorderStyle = bsNone
      ForeColor = clNavy
      Progress = 0
      ExplicitLeft = 208
      ExplicitTop = -7
      ExplicitWidth = 814
      ExplicitHeight = 41
    end
  end
  object vtListFields: TVirtualTable
    FieldDefs = <
      item
        Name = 'phone_report_column_id'
        DataType = ftInteger
      end
      item
        Name = 'fsql'
        DataType = ftString
        Size = 3000
      end
      item
        Name = 'fname'
        DataType = ftString
        Size = 100
      end>
    Left = 416
    Top = 80
    Data = {
      03000300160070686F6E655F7265706F72745F636F6C756D6E5F696403000000
      0000000004006673716C0100B80B000000000500666E616D6501006400000000
      00000000000000}
  end
  object dsRepoprt: TOraDataSource
    DataSet = vtReport
    Left = 184
    Top = 256
  end
  object vtReport: TVirtualTable
    Options = [voPersistentData]
    FieldDefs = <
      item
        Name = 'PHONE_NUMBER'
        DataType = ftString
        Size = 50
      end>
    Left = 96
    Top = 264
  end
end
