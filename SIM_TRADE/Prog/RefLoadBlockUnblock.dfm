object RefLoadBlockUnblockForm: TRefLoadBlockUnblockForm
  Left = 0
  Top = 0
  Caption = #1054#1095#1077#1088#1077#1076#1100' '#1084#1072#1089#1089#1086#1074#1086#1081' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080'/'#1088#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
  ClientHeight = 274
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 752
    Height = 28
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 729
    object btLoadInExcel: TBitBtn
      Left = 0
      Top = 0
      Width = 132
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 134
      Top = 0
      Width = 103
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 238
      Top = 0
      Width = 109
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbSearch: TCheckBox
      Left = 353
      Top = 6
      Width = 58
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
    object cbFilter: TComboBox
      Left = 416
      Top = 5
      Width = 113
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = #1042#1089#1077
      OnChange = cbFilterChange
      Items.Strings = (
        #1042#1089#1077
        #1040#1082#1090#1080#1074#1085#1099#1077)
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 28
    Width = 752
    Height = 246
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsRef
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TYPE_ACTION_STR'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Width = 114
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATEB'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1076#1077#1081#1089#1090#1074#1080#1103
        Width = 109
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATE_INSERT'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUCCESS_STR'
        Title.Alignment = taCenter
        Title.Caption = #1059#1089#1087#1077#1096#1085#1086
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RESULT_STR'
        Title.Alignment = taCenter
        Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        Width = 219
        Visible = True
      end>
  end
  object dsRef: TDataSource
    DataSet = qRef
    Left = 240
    Top = 144
  end
  object qRef: TOraQuery
    SQL.Strings = (
      
        'SELECT phone_number, type_action, dateb, date_insert, success, r' +
        'esult_str,'
      '       CASE '
      '         WHEN type_action = 0 THEN'
      '           '#39#1041#1083#1086#1082#1080#1088#1086#1074#1082#1072#39
      '         WHEN type_action = 1 THEN           '
      '           '#39#1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072#39
      '       END type_action_str,'
      '       CASE '
      '         WHEN success = 0 THEN'
      '           '#39#1053#1077#1090#39
      '         WHEN success = 1 THEN           '
      '           '#39#1044#1072#39
      '         ELSE TO_CHAR(success)  '
      '       END success_str'
      'FROM queue_load_block_unblock'
      'WHERE NVL2(success, -1, 1) = :success OR :success = 0'
      'ORDER BY dateb DESC')
    FetchRows = 500
    Left = 208
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'success'
      end>
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 80
    Top = 64
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
