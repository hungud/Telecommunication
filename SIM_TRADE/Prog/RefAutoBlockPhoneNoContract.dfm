object RefAutoBlockPhoneNoContractForm: TRefAutoBlockPhoneNoContractForm
  Left = 0
  Top = 0
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1085#1086#1084#1077#1088#1086#1074' '#1073#1077#1079' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  ClientHeight = 478
  ClientWidth = 701
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 478
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 345
      Height = 217
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 0
      object Label1: TLabel
        Left = 28
        Top = 58
        Width = 13
        Height = 16
        Caption = 'C:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 79
        Top = 58
        Width = 19
        Height = 16
        Caption = #1087#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 173
        Top = 33
        Width = 119
        Height = 16
        Caption = #1057#1052#1057' '#1080#1079#1074#1077#1097#1077#1085#1080#1077' '#1085#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 24
        Top = 85
        Width = 207
        Height = 16
        Caption = 'URL '#1089#1087#1080#1089#1082#1072' '#1085#1086#1084#1077#1088#1086#1074' '#1085#1072' '#1072#1082#1090#1080#1074#1072#1094#1080#1080':'
      end
      object cbNigthWork: TCheckBox
        Left = 24
        Top = 32
        Width = 145
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1085#1086#1095#1100#1102
        TabOrder = 0
        OnClick = cbNigthWorkClick
      end
      object eBeginHour: TEdit
        Left = 47
        Top = 55
        Width = 26
        Height = 24
        Alignment = taCenter
        TabOrder = 1
        Text = '9'
      end
      object eEndHour: TEdit
        Left = 104
        Top = 55
        Width = 27
        Height = 24
        Alignment = taCenter
        TabOrder = 2
        Text = '21'
      end
      object memoURL: TMemo
        Left = 24
        Top = 107
        Width = 306
        Height = 65
        Enabled = False
        Lines.Strings = (
          'Memo1')
        TabOrder = 3
      end
      object btSave: TBitBtn
        Left = 215
        Top = 178
        Width = 86
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 4
        OnClick = btSaveClick
      end
      object btChange: TBitBtn
        Left = 123
        Top = 178
        Width = 86
        Height = 25
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 5
        OnClick = btChangeClick
      end
      object ePhoneForNotice: TEdit
        Left = 173
        Top = 55
        Width = 157
        Height = 24
        Alignment = taCenter
        TabOrder = 6
      end
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 231
      Width = 345
      Height = 66
      Caption = #1057#1087#1080#1089#1086#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1089' '#1079#1072#1087#1088#1077#1090#1086#1084' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      TabOrder = 1
      object btAdd: TBitBtn
        Left = 14
        Top = 24
        Width = 75
        Height = 25
        Hint = #1058#1086#1083#1100#1082#1086' 1'#1081' '#1089#1090#1086#1083#1073#1077#1094' '#1074#1080#1076#1072' 9*********'
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        OnClick = btAddClick
      end
      object btClear: TBitBtn
        Left = 255
        Top = 24
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
        OnClick = btClearClick
      end
      object btRefresh: TBitBtn
        Left = 95
        Top = 24
        Width = 75
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 2
        OnClick = btRefreshClick
      end
      object btDel: TBitBtn
        Left = 176
        Top = 24
        Width = 73
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 3
        OnClick = btDelClick
      end
    end
  end
  object Panel2: TPanel
    Left = 377
    Top = 0
    Width = 324
    Height = 478
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitLeft = 345
    ExplicitWidth = 257
    object CRDBGrid1: TCRDBGrid
      Left = 1
      Top = 1
      Width = 181
      Height = 476
      Align = alClient
      DataSource = dsPhoneNoAccess
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
    end
    object Panel3: TPanel
      Left = 182
      Top = 1
      Width = 141
      Height = 476
      Align = alRight
      Caption = 'Panel3'
      TabOrder = 1
      ExplicitLeft = 256
      object memoURLBody: TMemo
        Left = 1
        Top = 25
        Width = 139
        Height = 450
        Align = alClient
        Lines.Strings = (
          'memoURLBody')
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = -1
        ExplicitWidth = 120
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 139
        Height = 24
        Align = alTop
        Caption = #1047#1072#1087#1088#1077#1090' '#1089' '#1089#1072#1081#1090#1072
        TabOrder = 1
        ExplicitWidth = 118
      end
    end
  end
  object qBlockNoContractSettings: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM BLOCK_NO_CONTRACTS_SETTINGS')
    Left = 264
    Top = 96
    object qBlockNoContractSettingsCHECK_TIME: TFloatField
      FieldName = 'CHECK_TIME'
    end
    object qBlockNoContractSettingsTIME_END: TFloatField
      FieldName = 'TIME_END'
    end
    object qBlockNoContractSettingsTIME_BEGIN: TFloatField
      FieldName = 'TIME_BEGIN'
    end
    object qBlockNoContractSettingsURL_ACCESS_LIST: TStringField
      FieldName = 'URL_ACCESS_LIST'
      Size = 2000
    end
    object qBlockNoContractSettingsPHONE_FOR_NOTICE: TStringField
      FieldName = 'PHONE_FOR_NOTICE'
      Size = 40
    end
  end
  object qPhoneNoAccess: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM PHONE_NUMBER_BLOCK_DENIED')
    FetchRows = 250
    FetchAll = True
    Left = 408
    Top = 232
    object qPhoneNoAccessPHONE_NUMBER: TStringField
      Alignment = taCenter
      DisplayLabel = #1056#1091#1095#1085#1086#1081' '#1079#1072#1087#1088#1077#1090
      DisplayWidth = 14
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
  end
  object dsPhoneNoAccess: TDataSource
    DataSet = qPhoneNoAccess
    Left = 440
    Top = 240
  end
  object qDeleteList: TOraQuery
    SQL.Strings = (
      'DELETE FROM PHONE_NUMBER_BLOCK_DENIED'
      '  WHERE :ALL_PHONE = 1'
      '    OR (:ALL_PHONE = 0 AND PHONE_NUMBER = :PHONE)')
    Left = 280
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ALL_PHONE'
      end
      item
        DataType = ftUnknown
        Name = 'PHONE'
      end>
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 288
  end
  object qAutoListNoAccess: TOraQuery
    SQL.Strings = (
      'SELECT LIST_NO_BLOCK FROM BLOCK_NO_CONTRACTS_SETTINGS')
    Left = 544
    Top = 72
    object qAutoListNoAccessLIST_NO_BLOCK: TMemoField
      FieldName = 'LIST_NO_BLOCK'
      BlobType = ftOraClob
    end
  end
end
