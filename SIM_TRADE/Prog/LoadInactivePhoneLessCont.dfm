object LoadInactivePhoneLessContForm: TLoadInactivePhoneLessContForm
  Left = 0
  Top = 0
  Caption = #1052#1072#1089#1089#1086#1074#1072#1103' '#1079#1072#1075#1088#1091#1079#1082#1072
  ClientHeight = 404
  ClientWidth = 893
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object ChangesGrid: TCRDBGrid
    Left = 0
    Top = 25
    Width = 893
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
        FieldName = 'Phone_Number'
        Title.Alignment = taCenter
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sim_Number'
        Title.Alignment = taCenter
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'System_Billing'
        Title.Alignment = taCenter
        Width = 127
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dop_Info'
        Title.Alignment = taCenter
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Paid'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Price'
        Title.Alignment = taCenter
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Itog'
        Title.Alignment = taCenter
        Width = 133
        Visible = True
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 388
    Width = 893
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 893
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
      Width = 891
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 85
      Caption = 'ToolBar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object tbAddPhones: TToolButton
        Left = 0
        Top = 0
        Action = aFileOpen
      end
      object tbAddChanges: TToolButton
        Left = 85
        Top = 0
        Action = aAddChanges
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100'...'
        Enabled = False
      end
      object tbClear: TToolButton
        Left = 170
        Top = 0
        Action = aClear
      end
    end
  end
  object vtChanges: TVirtualTable
    Left = 160
    Top = 120
    Data = {03000000000000000000}
    object vtChangesPhoneNumber: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'Phone_Number'
      Size = 10
    end
    object vtChangesSim_Number: TStringField
      DisplayLabel = #1057#1080#1084
      DisplayWidth = 20
      FieldName = 'Sim_Number'
    end
    object vtChangesDop_Info: TStringField
      DisplayLabel = #1044#1086#1087'.'#1080#1085#1092#1086
      FieldName = 'Dop_Info'
      Size = 300
    end
    object vtChangesSystem_Billing: TIntegerField
      Alignment = taCenter
      DisplayLabel = #1057#1080#1089#1090#1077#1084#1072' '#1088#1072#1089#1095#1077#1090#1086#1074
      FieldName = 'System_Billing'
    end
    object vtChangesPrice: TIntegerField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100
      FieldName = 'Price'
    end
    object vtChangesPaid: TIntegerField
      DisplayLabel = #1055#1083#1072#1090#1085#1099#1081
      FieldName = 'Paid'
    end
    object vtChangesItog: TStringField
      DisplayLabel = #1048#1090#1086#1075
      FieldName = 'Itog'
      Size = 100
    end
  end
  object dsChanges: TDataSource
    DataSet = vtChanges
    Left = 200
    Top = 128
  end
  object ActionList: TActionList
    Left = 360
    Top = 96
    object aFileOpen: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100'...'
      OnExecute = aFileOpenExecute
    end
    object aAddChanges: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1058#1055
      OnExecute = aAddChangesExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = aClearExecute
    end
  end
  object qAddChange: TOraQuery
    SQL.Strings = (
      'INSERT INTO INACTIVE_PHONE_LESS_CONTRACT'
      
        '(PHONE_NUMBER, SIM_NUMBER, SYSTEM_BILLING, DOP_INFO, PAID, PRICE' +
        ')'
      'VALUES'
      
        '(:PHONE_NUMBER, :SIM_NUMBER, :SYSTEM_BILLING, :DOP_INFO, :PAID, ' +
        ':PRICE)')
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'SIM_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'SYSTEM_BILLING'
      end
      item
        DataType = ftUnknown
        Name = 'DOP_INFO'
      end
      item
        DataType = ftUnknown
        Name = 'PAID'
      end
      item
        DataType = ftUnknown
        Name = 'PRICE'
      end>
  end
  object OpenDialog: TOpenDialog
    Left = 112
    Top = 288
  end
  object Transaction: TOraTransaction
    DefaultSession = MainForm.OraSession
    Left = 400
    Top = 280
  end
end
