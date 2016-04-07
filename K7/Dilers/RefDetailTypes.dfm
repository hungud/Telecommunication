object RefDetailTypesForm: TRefDetailTypesForm
  Left = 0
  Top = 0
  Caption = #1058#1080#1088#1099' '#1076#1072#1085#1085#1099#1093' '#1074' '#1076#1077#1090#1072#1083#1080#1079#1072#1094#1080#1080
  ClientHeight = 431
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 744
    Height = 31
    AutoSize = True
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = MainForm.ImageList24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ExplicitLeft = -138
    ExplicitWidth = 696
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = aInsert
      Enabled = False
    end
    object ToolButton2: TToolButton
      Left = 31
      Top = 0
      Action = aEdit
    end
    object ToolButton3: TToolButton
      Left = 62
      Top = 0
      Action = aDelete
      Enabled = False
    end
    object ToolButton7: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 101
      Top = 0
      Action = aPost
    end
    object ToolButton5: TToolButton
      Left = 132
      Top = 0
      Action = aCancel
    end
    object ToolButton8: TToolButton
      Left = 163
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 171
      Top = 0
      Action = aRefresh
    end
  end
  object grData: TCRDBGrid
    Left = 0
    Top = 31
    Width = 744
    Height = 400
    Align = alClient
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = grDataDblClick
    OnKeyDown = grDataKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'TYPE_CONNECTION'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TYPE_CALL'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMMENT_CALL'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DILER_PAY'
        Title.Alignment = taCenter
        Width = 165
        Visible = True
      end>
  end
  object ActionList: TActionList
    Images = MainForm.ImageList24
    Left = 320
    Top = 108
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aInsertExecute
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aEditExecute
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aDeleteExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = aPostExecute
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 8
      ShortCut = 27
      OnExecute = aCancelExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ImageList24
    Left = 264
    Top = 108
    object N1: TMenuItem
      Action = aInsert
    end
    object N2: TMenuItem
      Action = aEdit
    end
    object N3: TMenuItem
      Action = aDelete
    end
    object N4: TMenuItem
      Action = aPost
    end
    object N5: TMenuItem
      Action = aCancel
    end
    object N6: TMenuItem
      Action = aRefresh
    end
  end
  object dsMain: TDataSource
    DataSet = qMain
    OnStateChange = dsMainStateChange
    Left = 320
    Top = 49
  end
  object qMain: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE DETAIL_TYPES'
      'SET'
      '  DILER_PAY = :DILER_PAY'
      'WHERE'
      '  DETAIL_TYPE_ID = :Old_DETAIL_TYPE_ID')
    SQLRefresh.Strings = (
      
        'SELECT DETAIL_TYPE_ID, TYPE_CONNECTION, TYPE_CALL, COMMENT_CALL,' +
        ' DILER_PAY FROM DETAIL_TYPES'
      'WHERE'
      '  DETAIL_TYPE_ID = :DETAIL_TYPE_ID')
    SQL.Strings = (
      'SELECT DETAIL_TYPES.*'
      '  FROM DETAIL_TYPES'
      '  ORDER BY DETAIL_TYPES.TYPE_CONNECTION,'
      '           DETAIL_TYPES.TYPE_CALL, '
      '           DETAIL_TYPES.COMMENT_CALL ASC')
    FetchRows = 250
    FetchAll = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 264
    Top = 49
    object qMainTYPE_CONNECTION: TStringField
      DisplayLabel = #1058#1080#1087' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
      DisplayWidth = 30
      FieldName = 'TYPE_CONNECTION'
      Required = True
      Size = 400
    end
    object qMainTYPE_CALL: TStringField
      DisplayLabel = #1058#1080#1087' '#1079#1074#1086#1085#1082#1072
      DisplayWidth = 30
      FieldName = 'TYPE_CALL'
      Size = 400
    end
    object qMainCOMMENT_CALL: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077' '#1079#1074#1086#1085#1082#1072
      DisplayWidth = 30
      FieldName = 'COMMENT_CALL'
      Required = True
      Size = 400
    end
    object qMainDILER_PAY: TIntegerField
      DisplayLabel = #1055#1083#1072#1090#1072' '#1076#1080#1083#1077#1088#1091'(1-'#1044#1072', 0-'#1053#1077#1090')'
      FieldName = 'DILER_PAY'
    end
  end
end
