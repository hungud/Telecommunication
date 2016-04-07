object RefAllSendMailForm: TRefAllSendMailForm
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1086#1073#1097#1080#1093' '#1086#1090#1087#1088#1072#1074#1086#1082' '#1085#1072' e-mail'
  ClientHeight = 389
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RGLoadLogTypes: TRadioGroup
    Left = 0
    Top = 49
    Width = 738
    Height = 56
    Align = alTop
    BiDiMode = bdRightToLeftNoAlign
    Caption = #1060#1080#1083#1100#1090#1088' '#1086#1090#1087#1088#1072#1074#1086#1082
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      #1042#1089#1077' '#1086#1090#1087#1088#1072#1074#1082#1080)
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = RGLoadLogTypesClick
  end
  object CRDBGrid1: TCRDBGrid
    Left = 0
    Top = 105
    Width = 738
    Height = 284
    Align = alClient
    DataSource = DsLogs
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'LOAD_DATE_TIME'
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072
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
        FieldName = 'LOAD_TYPE_NAME'
        ReadOnly = True
        Title.Caption = #1042#1080#1076' '#1086#1090#1087#1088#1072#1074#1082#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        ReadOnly = True
        Title.Caption = 'E-MAIL'
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
        FieldName = 'IS_SUCCESS'
        ReadOnly = True
        Title.Caption = #1059#1089#1087#1077#1093
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR_TEXT'
        ReadOnly = True
        Title.Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1090#1087#1088#1072#1074#1082#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 500
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 738
    Height = 49
    Align = alTop
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 97
      Height = 35
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object DsRadioGroup: TOraDataSource
    DataSet = qLoadLogTypes
    Left = 448
    Top = 56
  end
  object qLoadLogTypes: TOraQuery
    SQL.Strings = (
      'Select load_type_id, load_type_name from ALL_LOAD_TYPES'
      'order by LOAD_TYPE_id')
    Left = 416
    Top = 56
  end
  object qLogs: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  ALL_LOAD_LOGS.LOAD_DATE_TIME,'
      '  ALL_LOAD_TYPES.LOAD_TYPE_NAME,'
      '  ALL_LOAD_LOGS.Email,'
      
        '  CASE WHEN ALL_LOAD_LOGS.IS_SUCCESS = 1 THEN '#39'+'#39' ELSE '#39'-'#39' END a' +
        's IS_SUCCESS,'
      '  ALL_LOAD_LOGS.ERROR_TEXT'
      'FROM'
      '  ALL_LOAD_LOGS,'
      '  ALL_LOAD_TYPES'
      'WHERE'
      '  (ALL_LOAD_LOGS.LOAD_TYPE_ID=ALL_LOAD_TYPES.LOAD_TYPE_ID)'
      
        '  AND (nvl(:load_type_id,0)=0 OR :load_type_id=ALL_LOAD_LOGS.LOA' +
        'D_TYPE_ID)'
      'ORDER BY'
      '  ALL_LOAD_LOGS.LOAD_DATE_TIME DESC')
    Left = 96
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'load_type_id'
      end>
  end
  object DsLogs: TOraDataSource
    DataSet = qLogs
    Left = 152
    Top = 200
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 592
    Top = 64
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ImageIndex = 12
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = BitBtn1Click
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
    end
  end
end
