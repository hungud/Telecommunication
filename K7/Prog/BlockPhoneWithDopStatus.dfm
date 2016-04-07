object BlockPhoneWithDopStatusForm: TBlockPhoneWithDopStatusForm
  Left = 0
  Top = 0
  Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1085#1086#1084#1077#1088#1086#1074' '#1089' '#1076#1086#1087'.'#1089#1090#1072#1090#1091#1089#1086#1084'.'
  ClientHeight = 404
  ClientWidth = 928
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 25
    Width = 928
    Height = 363
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsChanges
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PhoneNumber'
        Title.Alignment = taCenter
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DopStatusName'
        Title.Alignment = taCenter
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CommentClient'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 262
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Itog'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 928
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Step = 1
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 928
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 2
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 926
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 93
      Caption = 'ToolBar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object tbReport: TToolButton
        Left = 0
        Top = 0
        Action = aRefresh
      end
      object tbBlock: TToolButton
        Left = 93
        Top = 0
        Action = aBlock
        Enabled = False
      end
      object tbStopBlock: TToolButton
        Left = 186
        Top = 0
        Action = aStop
        Enabled = False
      end
      object tbClear: TToolButton
        Left = 279
        Top = 0
        Action = aClear
        Enabled = False
      end
      object tbImportExcel: TToolButton
        Left = 372
        Top = 0
        Action = aExcel
        Enabled = False
      end
    end
  end
  object vtChanges: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    Left = 144
    Top = 120
    Data = {03000000000000000000}
    object vtChangesPhoneNumber: TStringField
      Alignment = taCenter
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PhoneNumber'
      Size = 10
    end
    object vtChangesDopStatusName: TStringField
      DisplayLabel = #1044#1086#1087'.'#1089#1090#1072#1090#1091#1089
      DisplayWidth = 20
      FieldName = 'DopStatusName'
      Size = 50
    end
    object vtChangesDopStatusId: TIntegerField
      FieldName = 'DopStatusId'
      Visible = False
    end
    object vtChangesCommentClient: TStringField
      FieldName = 'CommentClient'
      Visible = False
      Size = 100
    end
    object vtChangesIsActive: TIntegerField
      FieldName = 'IsActive'
      Visible = False
    end
    object vtChangesItog: TStringField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'Itog'
      Size = 100
    end
  end
  object dsChanges: TDataSource
    DataSet = vtChanges
    Left = 208
    Top = 120
  end
  object ActionList: TActionList
    Left = 32
    Top = 120
    object aRefresh: TAction
      Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100'...'
      OnExecute = aRefreshExecute
    end
    object aBlock: TAction
      Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
      OnExecute = aBlockExecute
    end
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      OnExecute = aExcelExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
    object aStop: TAction
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      OnExecute = aStopExecute
    end
  end
  object qReport: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT * FROM V_BLOCK_PHONE_WITH_DOPSTATUS')
    FetchAll = True
    Left = 88
    Top = 120
  end
  object LoaderBlockPhone: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.LOCK_PHONE'
    Session = MainForm.OraSession
    Left = 374
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_BLOCK'
        ParamType = ptInput
        HasDefault = True
      end
      item
        DataType = ftString
        Name = 'PCODE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.LOCK_PHONE'
  end
  object LoaderUnlockPhone: TOraStoredProc
    StoredProcName = 'BEELINE_API_PCKG.UNLOCK_PHONE'
    Session = MainForm.OraSession
    Left = 486
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMANUAL_UNLOCK'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'BEELINE_API_PCKG.UNLOCK_PHONE'
  end
end
