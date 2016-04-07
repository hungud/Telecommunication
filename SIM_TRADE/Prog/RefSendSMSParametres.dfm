object RefProvidersFrm: TRefProvidersFrm
  Left = 150
  Top = 288
  Caption = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1074#1072#1081#1076#1077#1088#1086#1074' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1057#1052#1057
  ClientHeight = 442
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 912
    Height = 31
    AutoSize = True
    ButtonHeight = 31
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = MainForm.ImageList24
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
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
      Action = aDelete
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
  object RefSMSProviderGrid: TCRDBGrid
    Left = 0
    Top = 31
    Width = 912
    Height = 411
    Align = alClient
    DataSource = DSProvider
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PROVIDER_ID'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PROVIDER_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103' '#1087#1088#1086#1074#1072#1081#1076#1077#1088#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SENDER_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Caption = #1051#1086#1075#1080#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PASSWORD'
        Title.Alignment = taCenter
        Title.Caption = #1055#1072#1088#1086#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end>
  end
  object DSProvider: TDataSource
    DataSet = qProvider
    Left = 192
    Top = 80
  end
  object qProvider: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO SMS_SEND_PARAMETRS'
      '  (LOGIN, PASSWORD, STATUS, SENDER_NAME, PROVIDER_NAME)'
      'VALUES'
      '  (:LOGIN, :PASSWORD, :STATUS, :SENDER_NAME, :PROVIDER_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM SMS_SEND_PARAMETRS'
      'WHERE'
      '  PROVIDER_ID = :Old_PROVIDER_ID')
    SQLUpdate.Strings = (
      'UPDATE SMS_SEND_PARAMETRS'
      'SET'
      
        '  LOGIN = :LOGIN, PASSWORD = :PASSWORD, STATUS = :STATUS, SENDER' +
        '_NAME = :SENDER_NAME, PROVIDER_NAME = :PROVIDER_NAME'
      'WHERE'
      '  PROVIDER_ID = :Old_PROVIDER_ID')
    SQLLock.Strings = (
      'SELECT * FROM SMS_SEND_PARAMETRS'
      'WHERE'
      '  PROVIDER_ID = :Old_PROVIDER_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT LOGIN, PASSWORD, STATUS, SENDER_NAME, PROVIDER_NAME FROM ' +
        'SMS_SEND_PARAMETRS'
      'WHERE'
      '  PROVIDER_ID = :PROVIDER_ID')
    SQL.Strings = (
      'SELECT PROVIDER_ID,'
      '       PROVIDER_NAME,'
      '       SENDER_NAME,'
      '       LOGIN,'
      '       PASSWORD,'
      '       STATUS'
      'from SMS_SEND_PARAMETRS')
    IndexFieldNames = 'PROVIDER_ID'
    Left = 136
    Top = 80
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 240
    Top = 84
    object aInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 45
    end
    object aEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      ShortCut = 113
    end
    object aDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16430
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
    end
    object aCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 8
      ShortCut = 27
    end
  end
end
