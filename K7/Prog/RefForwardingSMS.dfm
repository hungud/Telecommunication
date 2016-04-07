object RefForwardingSMSForm: TRefForwardingSMSForm
  Left = 0
  Top = 0
  Caption = #1055#1077#1088#1077#1072#1076#1088#1077#1089#1072#1094#1080#1103' '#1057#1052#1057
  ClientHeight = 353
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 623
    Height = 31
    AutoSize = True
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = MainForm.ImageList24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ExplicitLeft = -220
    ExplicitWidth = 843
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = aInsert
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
  object CRDBGrid1: TCRDBGrid
    Left = 0
    Top = 31
    Width = 623
    Height = 322
    Align = alClient
    DataSource = dsMain
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
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 122
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER_RECIPIENT'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085'-'#1072#1076#1088#1077#1089#1072#1090
        Width = 153
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORWARDING_ENABLE'
        Title.Alignment = taCenter
        Title.Caption = #1042#1082#1083'.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMS_TEXT_ADD'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1073'. '#1090#1077#1082#1089#1090' '#1057#1052#1057
        Width = 147
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_LAST_UPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 143
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_LAST_UPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 269
        Visible = True
      end>
  end
  object ActionList1: TActionList
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
  object dsMain: TDataSource
    DataSet = qMain
    Left = 272
    Top = 81
  end
  object qMain: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM FORWARDING_PHONE_NUMBER')
    Left = 240
    Top = 72
    object qMainPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qMainPHONE_NUMBER_RECIPIENT: TStringField
      FieldName = 'PHONE_NUMBER_RECIPIENT'
      Size = 40
    end
    object qMainFORWARDING_ENABLE: TFloatField
      FieldName = 'FORWARDING_ENABLE'
    end
    object qMainSMS_TEXT_ADD: TStringField
      FieldName = 'SMS_TEXT_ADD'
      Size = 400
    end
    object qMainDATE_LAST_UPDATE: TDateTimeField
      FieldName = 'DATE_LAST_UPDATE'
    end
    object qMainUSER_LAST_UPDATE: TStringField
      FieldName = 'USER_LAST_UPDATE'
      Size = 120
    end
  end
end
