object RefTariffOptionBenefitsForm: TRefTariffOptionBenefitsForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1075#1088#1091#1087#1087' '#1083#1100#1075#1086#1090#1085#1099#1093' '#1090#1072#1088#1080#1092#1085#1099#1093' '#1091#1089#1083#1091#1075'/'#1086#1087#1094#1080#1081
  ClientHeight = 411
  ClientWidth = 841
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
  object Splitter1: TSplitter
    Left = 345
    Top = 0
    Height = 411
    ExplicitLeft = 32
    ExplicitTop = 248
    ExplicitHeight = 100
  end
  object pTOBenefits: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 411
    Align = alLeft
    Caption = 'pTOBenefits'
    TabOrder = 0
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 343
      Height = 64
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 32
        Width = 341
        Height = 31
        Align = alBottom
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
          Action = aTOBInsert
        end
        object ToolButton2: TToolButton
          Left = 31
          Top = 0
          Action = aTOBEdit
        end
        object ToolButton3: TToolButton
          Left = 62
          Top = 0
          Action = aTOBDelete
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
          Action = aTOBPost
        end
        object ToolButton5: TToolButton
          Left = 132
          Top = 0
          Action = aTOBCancel
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
          Action = aTOBRefresh
        end
        object ToolButton9: TToolButton
          Left = 202
          Top = 0
          Caption = 'ToolButton9'
          ImageIndex = 12
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 65
        Width = 341
        Height = 31
        Align = alClient
        Caption = #1043#1088#1091#1087#1087#1099' '#1091#1089#1083#1091#1075
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 341
        Height = 64
        Align = alTop
        TabOrder = 2
        object ToolBar2: TToolBar
          Left = 1
          Top = 32
          Width = 339
          Height = 31
          Align = alBottom
          AutoSize = True
          ButtonHeight = 31
          ButtonWidth = 31
          Caption = 'ToolBar1'
          Images = MainForm.ImageList24
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton10: TToolButton
            Left = 0
            Top = 0
            Action = aTOBInsert
          end
          object ToolButton11: TToolButton
            Left = 31
            Top = 0
            Action = aTOBEdit
          end
          object ToolButton12: TToolButton
            Left = 62
            Top = 0
            Action = aTOBDelete
          end
          object ToolButton13: TToolButton
            Left = 93
            Top = 0
            Width = 8
            Caption = 'ToolButton7'
            ImageIndex = 10
            Style = tbsSeparator
          end
          object ToolButton14: TToolButton
            Left = 101
            Top = 0
            Action = aTOBPost
          end
          object ToolButton15: TToolButton
            Left = 132
            Top = 0
            Action = aTOBCancel
          end
          object ToolButton16: TToolButton
            Left = 163
            Top = 0
            Width = 8
            Caption = 'ToolButton8'
            ImageIndex = 10
            Style = tbsSeparator
          end
          object ToolButton17: TToolButton
            Left = 171
            Top = 0
            Action = aTOBRefresh
          end
          object ToolButton18: TToolButton
            Left = 202
            Top = 0
            Action = aTOBExcel
          end
        end
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 339
          Height = 31
          Align = alClient
          Caption = #1043#1088#1091#1087#1087#1099' '#1091#1089#1083#1091#1075
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object CRDBGridTOB: TCRDBGrid
      Left = 1
      Top = 65
      Width = 343
      Height = 345
      Align = alClient
      DataSource = dsTOBenefits
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
          FieldName = 'OPTION_GROUP_NAME'
          Title.Alignment = taCenter
          Width = 214
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_ACTIVE'
          Title.Alignment = taCenter
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_CREATED'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_LAST_UPDATED'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_LAST_UPDATED'
          ReadOnly = True
          Title.Alignment = taCenter
          Width = 130
          Visible = True
        end>
    end
  end
  object pTOBenefitCosts: TPanel
    Left = 348
    Top = 0
    Width = 493
    Height = 411
    Align = alClient
    Caption = 'pTOBenefitCosts'
    TabOrder = 1
    object CRDBGridTOBCost: TCRDBGrid
      Left = 1
      Top = 65
      Width = 491
      Height = 345
      Align = alClient
      DataSource = dsTOBenefitCosts
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
      OnEnter = CRDBGridTOBCostEnter
      Columns = <
        item
          Expanded = False
          FieldName = 'OPTION_CODE'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TURN_ON_COST'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MONTHLY_COST'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BILL_TURN_ON_COST'
          Width = 126
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BILL_MONTHLY_COST'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_CREATED'
          ReadOnly = True
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          ReadOnly = True
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_LAST_UPDATED'
          ReadOnly = True
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_LAST_UPDATED'
          ReadOnly = True
          Width = 130
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 491
      Height = 64
      Align = alTop
      TabOrder = 1
      object ToolBar3: TToolBar
        Left = 1
        Top = 32
        Width = 489
        Height = 31
        Align = alBottom
        AutoSize = True
        ButtonHeight = 31
        ButtonWidth = 31
        Caption = 'ToolBar1'
        Images = MainForm.ImageList24
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ToolButton19: TToolButton
          Left = 0
          Top = 0
          Action = aTOBCostInsert
        end
        object ToolButton20: TToolButton
          Left = 31
          Top = 0
          Action = aTOBCostEdit
        end
        object ToolButton21: TToolButton
          Left = 62
          Top = 0
          Action = aTOBCostDelete
        end
        object ToolButton22: TToolButton
          Left = 93
          Top = 0
          Width = 8
          Caption = 'ToolButton7'
          ImageIndex = 10
          Style = tbsSeparator
        end
        object ToolButton23: TToolButton
          Left = 101
          Top = 0
          Action = aTOBCostPost
        end
        object ToolButton24: TToolButton
          Left = 132
          Top = 0
          Action = aTOBCostCancel
        end
        object ToolButton25: TToolButton
          Left = 163
          Top = 0
          Width = 8
          Caption = 'ToolButton8'
          ImageIndex = 10
          Style = tbsSeparator
        end
        object ToolButton26: TToolButton
          Left = 171
          Top = 0
          Action = aTOBCostRefresh
        end
        object ToolButton27: TToolButton
          Left = 202
          Top = 0
          Action = aTOBCostExcel
        end
      end
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 489
        Height = 31
        Align = alClient
        Caption = #1059#1089#1083#1091#1075#1080' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1075#1088#1091#1087#1087#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic, fsUnderline]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object qTOBenefit: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO TARIFF_OPTION_GROUP'
      '  (OPTION_GROUP_ID, OPTION_GROUP_NAME, IS_ACTIVE)'
      'VALUES'
      '  (:OPTION_GROUP_ID, :OPTION_GROUP_NAME, :IS_ACTIVE)')
    SQLDelete.Strings = (
      'DELETE FROM TARIFF_OPTION_GROUP'
      'WHERE'
      '  OPTION_GROUP_ID = :Old_OPTION_GROUP_ID')
    SQLUpdate.Strings = (
      'UPDATE TARIFF_OPTION_GROUP'
      'SET'
      '  OPTION_GROUP_NAME = :OPTION_GROUP_NAME, IS_ACTIVE = :IS_ACTIVE'
      'WHERE'
      '  OPTION_GROUP_ID = :Old_OPTION_GROUP_ID')
    SQLLock.Strings = (
      
        'SELECT OPTION_GROUP_ID, OPTION_GROUP_NAME, IS_ACTIVE, USER_CREAT' +
        'ED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED FROM TARI' +
        'FF_OPTION_GROUP'
      'WHERE'
      '  OPTION_GROUP_ID = :Old_OPTION_GROUP_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT OPTION_GROUP_ID, OPTION_GROUP_NAME, IS_ACTIVE, USER_CREAT' +
        'ED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED FROM TARI' +
        'FF_OPTION_GROUP'
      'WHERE'
      '  OPTION_GROUP_ID = :OPTION_GROUP_ID')
    SQL.Strings = (
      'SELECT *'
      '  FROM TARIFF_OPTION_GROUP'
      '  ORDER BY DATE_CREATED ASC')
    BeforePost = qTOBenefitBeforePost
    Left = 32
    Top = 304
    object qTOBenefitOPTION_GROUP_ID: TFloatField
      DisplayLabel = 'ID'
      DisplayWidth = 3
      FieldName = 'OPTION_GROUP_ID'
      Required = True
    end
    object qTOBenefitOPTION_GROUP_NAME: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      DisplayWidth = 30
      FieldName = 'OPTION_GROUP_NAME'
      Size = 200
    end
    object qTOBenefitIS_ACTIVE: TIntegerField
      DisplayLabel = #1042#1082#1083'/'#1074#1099#1082#1083
      DisplayWidth = 5
      FieldName = 'IS_ACTIVE'
    end
    object qTOBenefitUSER_CREATED: TStringField
      Alignment = taCenter
      DisplayLabel = #1057#1086#1079#1076#1072#1090#1077#1083#1100
      DisplayWidth = 20
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qTOBenefitDATE_CREATED: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'DATE_CREATED'
    end
    object qTOBenefitUSER_LAST_UPDATED: TStringField
      Alignment = taCenter
      DisplayLabel = #1055#1086#1089#1083' '#1088#1077#1076#1072#1082#1090#1086#1088
      DisplayWidth = 20
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qTOBenefitDATE_LAST_UPDATED: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1072#1074#1082#1080
      FieldName = 'DATE_LAST_UPDATED'
    end
  end
  object qTOBenefitCosts: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO TARIFF_OPTION_GROUP_COSTS'
      
        '  (TARIFF_OPT_GROUP_COST_ID, OPTION_GROUP_ID, OPTION_CODE, TURN_' +
        'ON_COST, MONTHLY_COST, BILL_TURN_ON_COST, BILL_MONTHLY_COST)'
      'VALUES'
      
        '  (:TARIFF_OPT_GROUP_COST_ID, :OPTION_GROUP_ID, :OPTION_CODE, :T' +
        'URN_ON_COST, :MONTHLY_COST, :BILL_TURN_ON_COST, :BILL_MONTHLY_CO' +
        'ST)')
    SQLDelete.Strings = (
      'DELETE FROM TARIFF_OPTION_GROUP_COSTS'
      'WHERE'
      '  TARIFF_OPT_GROUP_COST_ID = :Old_TARIFF_OPT_GROUP_COST_ID')
    SQLUpdate.Strings = (
      'UPDATE TARIFF_OPTION_GROUP_COSTS'
      'SET'
      
        '  OPTION_CODE = :OPTION_CODE, TURN_ON_COST = :TURN_ON_COST, MONT' +
        'HLY_COST = :MONTHLY_COST, BILL_TURN_ON_COST = :BILL_TURN_ON_COST' +
        ', BILL_MONTHLY_COST = :BILL_MONTHLY_COST'
      'WHERE'
      '  TARIFF_OPT_GROUP_COST_ID = :Old_TARIFF_OPT_GROUP_COST_ID')
    SQLLock.Strings = (
      
        'SELECT TARIFF_OPT_GROUP_COST_ID, OPTION_GROUP_ID, OPTION_CODE, T' +
        'URN_ON_COST, MONTHLY_COST, BILL_TURN_ON_COST, BILL_MONTHLY_COST,' +
        ' USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATE' +
        'D FROM TARIFF_OPTION_GROUP_COSTS'
      'WHERE'
      '  TARIFF_OPT_GROUP_COST_ID = :Old_TARIFF_OPT_GROUP_COST_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT TARIFF_OPT_GROUP_COST_ID, OPTION_GROUP_ID, OPTION_CODE, T' +
        'URN_ON_COST, MONTHLY_COST, BILL_TURN_ON_COST, BILL_MONTHLY_COST,' +
        ' USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATE' +
        'D FROM TARIFF_OPTION_GROUP_COSTS'
      'WHERE'
      '  TARIFF_OPT_GROUP_COST_ID = :TARIFF_OPT_GROUP_COST_ID')
    SQL.Strings = (
      'SELECT *'
      '  FROM TARIFF_OPTION_GROUP_COSTS'
      '  where OPTION_GROUP_ID = :pOPTION_GROUP_ID'
      '  ORDER BY DATE_CREATED ASC')
    BeforePost = qTOBenefitCostsBeforePost
    Left = 360
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pOPTION_GROUP_ID'
      end>
    object qTOBenefitCostsTARIFF_OPT_GROUP_COST_ID: TFloatField
      FieldName = 'TARIFF_OPT_GROUP_COST_ID'
      Required = True
    end
    object qTOBenefitCostsOPTION_GROUP_ID: TFloatField
      FieldName = 'OPTION_GROUP_ID'
    end
    object qTOBenefitCostsOPTION_CODE: TStringField
      Alignment = taCenter
      DisplayLabel = #1050#1086#1076' '#1091#1089#1083#1091#1075#1080
      DisplayWidth = 10
      FieldName = 'OPTION_CODE'
      Required = True
      Size = 200
    end
    object qTOBenefitCostsTURN_ON_COST: TFloatField
      DisplayLabel = #1062#1077#1085#1072' '#1087#1086#1076#1082#1083'('#1084#1086#1076#1077#1083')'
      FieldName = 'TURN_ON_COST'
      Required = True
    end
    object qTOBenefitCostsMONTHLY_COST: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'.('#1084#1086#1076#1077#1083')'
      FieldName = 'MONTHLY_COST'
      Required = True
    end
    object qTOBenefitCostsBILL_TURN_ON_COST: TFloatField
      DisplayLabel = #1062#1077#1085#1072' '#1087#1086#1076#1082#1083'('#1089#1095#1077#1090')'
      FieldName = 'BILL_TURN_ON_COST'
      Required = True
    end
    object qTOBenefitCostsBILL_MONTHLY_COST: TFloatField
      DisplayLabel = #1040#1073'. '#1087#1083'.('#1089#1095#1077#1090')'
      FieldName = 'BILL_MONTHLY_COST'
      Required = True
    end
    object qTOBenefitCostsUSER_CREATED: TStringField
      Alignment = taCenter
      DisplayLabel = #1057#1086#1079#1076#1072#1090#1077#1083#1100
      DisplayWidth = 20
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qTOBenefitCostsDATE_CREATED: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'DATE_CREATED'
    end
    object qTOBenefitCostsUSER_LAST_UPDATED: TStringField
      Alignment = taCenter
      DisplayLabel = #1055#1086#1089#1083'. '#1088#1077#1076#1072#1082#1090#1086#1088
      DisplayWidth = 20
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qTOBenefitCostsDATE_LAST_UPDATED: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1088#1072#1074#1082#1080
      FieldName = 'DATE_LAST_UPDATED'
    end
  end
  object dsTOBenefits: TDataSource
    DataSet = qTOBenefit
    OnDataChange = dsTOBenefitsDataChange
    Left = 64
    Top = 312
  end
  object dsTOBenefitCosts: TDataSource
    DataSet = qTOBenefitCosts
    Left = 392
    Top = 272
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 320
    Top = 108
    object aTOBInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aTOBInsertExecute
    end
    object aTOBEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aTOBEditExecute
    end
    object aTOBDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aTOBDeleteExecute
    end
    object aTOBPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = aTOBPostExecute
    end
    object aTOBCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 8
      ShortCut = 27
      OnExecute = aTOBCancelExecute
    end
    object aTOBRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aTOBRefreshExecute
    end
    object aTOBExcel: TAction
      Caption = 'aTOBExcel'
      ImageIndex = 12
      OnExecute = aTOBExcelExecute
    end
    object aTOBCostInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 45
      OnExecute = aTOBCostInsertExecute
    end
    object aTOBCostEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      ShortCut = 113
      OnExecute = aTOBCostEditExecute
    end
    object aTOBCostDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 5
      ShortCut = 16430
      OnExecute = aTOBCostDeleteExecute
    end
    object aTOBCostPost: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = aTOBCostPostExecute
    end
    object aTOBCostCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 8
      ShortCut = 27
      OnExecute = aTOBCostCancelExecute
    end
    object aTOBCostRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      ShortCut = 116
      OnExecute = aTOBCostRefreshExecute
    end
    object aTOBCostExcel: TAction
      Caption = 'aTOBExcel'
      ImageIndex = 12
      OnExecute = aTOBCostExcelExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ImageList24
    Left = 264
    Top = 108
    object N1: TMenuItem
      Action = aTOBInsert
    end
    object N2: TMenuItem
      Action = aTOBEdit
    end
    object N3: TMenuItem
      Action = aTOBDelete
    end
    object N4: TMenuItem
      Action = aTOBPost
    end
    object N5: TMenuItem
      Action = aTOBCancel
    end
    object N6: TMenuItem
      Action = aTOBRefresh
    end
  end
  object spNewOptionGroupId: TOraStoredProc
    StoredProcName = 'NEW_OPTION_GROUP_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_OPTION_GROUP_ID;'
      'end;')
    Left = 96
    Top = 320
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_OPTION_GROUP_ID'
  end
  object spNewOptionGroupCostId: TOraStoredProc
    StoredProcName = 'NEW_TARIFF_OPT_GROUP_COST_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_TARIFF_OPT_GROUP_COST_ID;'
      'end;')
    Left = 464
    Top = 288
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_TARIFF_OPT_GROUP_COST_ID'
  end
  object qTOBCostsDELETE: TOraQuery
    SQL.Strings = (
      'DELETE'
      '  FROM TARIFF_OPTION_GROUP_COSTS'
      '  where OPTION_GROUP_ID = :pOPTION_GROUP_ID')
    Left = 448
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pOPTION_GROUP_ID'
      end>
  end
end
