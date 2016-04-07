object RefCopyDataBaseForm: TRefCopyDataBaseForm
  Left = 0
  Top = 0
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1089#1090#1088#1091#1082#1090#1091#1088#1099' '#1041#1044
  ClientHeight = 464
  ClientWidth = 863
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 863
    Height = 45
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -167
    ExplicitWidth = 1030
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 863
      Height = 44
      AutoSize = True
      ButtonHeight = 44
      ButtonWidth = 86
      Caption = 'ToolBar1'
      Images = MainForm.ImageList24
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      ExplicitWidth = 1030
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = aInsert
      end
      object ToolButton2: TToolButton
        Left = 86
        Top = 0
        Action = aEdit
      end
      object ToolButton3: TToolButton
        Left = 172
        Top = 0
        Action = aDelete
      end
      object ToolButton7: TToolButton
        Left = 258
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 266
        Top = 0
        Action = aPost
      end
      object ToolButton5: TToolButton
        Left = 352
        Top = 0
        Action = aCancel
      end
      object ToolButton8: TToolButton
        Left = 438
        Top = 0
        Width = 8
        Caption = 'ToolButton8'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 446
        Top = 0
        Action = aRefresh
      end
      object ToolButton9: TToolButton
        Left = 532
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 11
        Style = tbsSeparator
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 45
    Width = 656
    Height = 419
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitTop = -150
    ExplicitWidth = 678
    ExplicitHeight = 614
    object Splitter1: TSplitter
      Left = 1
      Top = 193
      Width = 654
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 676
    end
    object CRDBGrid1: TCRDBGrid
      Left = 1
      Top = 1
      Width = 654
      Height = 192
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      DataSource = DataSource1
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'OPERATOR_NAME'
          Title.Caption = #1054#1087#1077#1088#1072#1090#1086#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 105
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COMPANY_NAME'
          Title.Caption = #1050#1086#1084#1087#1072#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGIN'
          Title.Caption = #1051#1086#1075#1080#1085' '#1076#1083#1103' '#1089#1072#1081#1090#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 182
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DILER_PAYMETS'
          Title.Alignment = taCenter
          Title.Caption = #1040#1075#1077#1085#1090#1089#1082#1080#1081'(1 - '#1044#1072', 0 - '#1053#1077#1090')'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 184
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 1
      Top = 196
      Width = 654
      Height = 222
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 676
      ExplicitHeight = 417
      object dgLoadingLogs: TCRDBGrid
        Left = 1
        Top = 1
        Width = 652
        Height = 220
        Align = alClient
        DataSource = dsLogs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'LOAD_DATE_TIME'
            Title.Caption = #1044#1072#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACCOUNT_LOAD_TYPE_NAME'
            Title.Caption = #1042#1080#1076' '#1079#1072#1075#1088#1091#1079#1082#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 120
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IS_SUCCESS'
            Title.Caption = #1059#1089#1087#1077#1093
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
            FieldName = 'ERROR_TEXT'
            Title.Caption = #1058#1077#1082#1089#1090' '#1086#1096#1080#1073#1082#1080
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 500
            Visible = True
          end>
      end
    end
  end
  object Panel4: TPanel
    Left = 656
    Top = 45
    Width = 207
    Height = 419
    Align = alRight
    TabOrder = 2
  end
  object qMain: TOraQuery
    UpdatingTable = 'ACCOUNTS'
    KeyFields = 'ACCOUNT_ID'
    SQLInsert.Strings = (
      'INSERT INTO ACCOUNTS'
      
        '  (ACCOUNT_ID, OPERATOR_ID, ACCOUNT_NUMBER, LOGIN, PASSWORD, DO_' +
        'AUTO_LOAD_DATA, LOAD_INTERVAL, PAY_LOAD_INTERVAL, BALANCE_NOTICE' +
        '_TEXT, BLOCK_NOTICE_TEXT, NEXT_MONTH_NOTICE_TEXT, LOAD_DETAIL_PO' +
        'OL_SIZE, LOAD_DETAIL_THREAD_COUNT, BALANCE_BLOCK, DO_AUTO_BLOCK,' +
        ' BALANCE_NOTICE, DO_BALANCE_NOTICE, DO_BALANCE_NOTICE_MONTH, BAL' +
        'ANCE_NOTICE_END_MONTH, BALANCE_NOTICE_CREDIT, TEXT_NOTICE_BALANC' +
        'E_CREDIT, BALANCE_BLOCK_CREDIT, TEXT_NOTICE_BLOCK_CREDIT, BALANC' +
        'E_NOTICE_MONTH_CREDIT, TEXT_NOTICE_END_MONTH_CREDIT, DILER_PAYME' +
        'TS,BALANCE_NOTICE2,BALANCE_NOTICE_TEXT2,BALANCE_NOTICE_CREDIT2,T' +
        'EXT_NOTICE_BALANCE_CREDIT2,COMPANY_NAME)'
      'VALUES'
      
        '  (:ACCOUNT_ID, :OPERATOR_ID, :ACCOUNT_NUMBER, :LOGIN, :PASSWORD' +
        ', :DO_AUTO_LOAD_DATA, :LOAD_INTERVAL, :PAY_LOAD_INTERVAL, :BALAN' +
        'CE_NOTICE_TEXT, :BLOCK_NOTICE_TEXT, :NEXT_MONTH_NOTICE_TEXT, :LO' +
        'AD_DETAIL_POOL_SIZE, :LOAD_DETAIL_THREAD_COUNT, :BALANCE_BLOCK, ' +
        ':DO_AUTO_BLOCK, :BALANCE_NOTICE, :DO_BALANCE_NOTICE, :DO_BALANCE' +
        '_NOTICE_MONTH, :BALANCE_NOTICE_END_MONTH, :BALANCE_NOTICE_CREDIT' +
        ', :TEXT_NOTICE_BALANCE_CREDIT, :BALANCE_BLOCK_CREDIT, :TEXT_NOTI' +
        'CE_BLOCK_CREDIT, :BALANCE_NOTICE_MONTH_CREDIT, :TEXT_NOTICE_END_' +
        'MONTH_CREDIT, :DILER_PAYMETS, :BALANCE_NOTICE2, :BALANCE_NOTICE_' +
        'TEXT2, :BALANCE_NOTICE_CREDIT2, :TEXT_NOTICE_BALANCE_CREDIT2,:CO' +
        'MPANY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM ACCOUNTS'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID')
    SQLUpdate.Strings = (
      'UPDATE ACCOUNTS'
      'SET'
      
        '  ACCOUNT_ID = :ACCOUNT_ID, OPERATOR_ID = :OPERATOR_ID, ACCOUNT_' +
        'NUMBER = :ACCOUNT_NUMBER, LOGIN = :LOGIN, PASSWORD = :PASSWORD, ' +
        'DO_AUTO_LOAD_DATA = :DO_AUTO_LOAD_DATA, LOAD_INTERVAL = :LOAD_IN' +
        'TERVAL, PAY_LOAD_INTERVAL = :PAY_LOAD_INTERVAL, BALANCE_NOTICE_T' +
        'EXT = :BALANCE_NOTICE_TEXT, BLOCK_NOTICE_TEXT = :BLOCK_NOTICE_TE' +
        'XT, NEXT_MONTH_NOTICE_TEXT = :NEXT_MONTH_NOTICE_TEXT, LOAD_DETAI' +
        'L_POOL_SIZE = :LOAD_DETAIL_POOL_SIZE, LOAD_DETAIL_THREAD_COUNT =' +
        ' :LOAD_DETAIL_THREAD_COUNT, BALANCE_BLOCK = :BALANCE_BLOCK, DO_A' +
        'UTO_BLOCK = :DO_AUTO_BLOCK, BALANCE_NOTICE = :BALANCE_NOTICE, DO' +
        '_BALANCE_NOTICE = :DO_BALANCE_NOTICE, DO_BALANCE_NOTICE_MONTH = ' +
        ':DO_BALANCE_NOTICE_MONTH, BALANCE_NOTICE_END_MONTH = :BALANCE_NO' +
        'TICE_END_MONTH, BALANCE_NOTICE_CREDIT = :BALANCE_NOTICE_CREDIT, ' +
        'TEXT_NOTICE_BALANCE_CREDIT = :TEXT_NOTICE_BALANCE_CREDIT, BALANC' +
        'E_BLOCK_CREDIT = :BALANCE_BLOCK_CREDIT, TEXT_NOTICE_BLOCK_CREDIT' +
        ' = :TEXT_NOTICE_BLOCK_CREDIT, BALANCE_NOTICE_MONTH_CREDIT = :BAL' +
        'ANCE_NOTICE_MONTH_CREDIT, TEXT_NOTICE_END_MONTH_CREDIT = :TEXT_N' +
        'OTICE_END_MONTH_CREDIT, DILER_PAYMETS = :DILER_PAYMETS,BALANCE_N' +
        'OTICE2 = :BALANCE_NOTICE2,BALANCE_NOTICE_TEXT2 = :BALANCE_NOTICE' +
        '_TEXT2,BALANCE_NOTICE_CREDIT2 = :BALANCE_NOTICE_CREDIT2,TEXT_NOT' +
        'ICE_BALANCE_CREDIT2 = :TEXT_NOTICE_BALANCE_CREDIT2,COMPANY_NAME=' +
        ':COMPANY_NAME'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID')
    SQLLock.Strings = (
      'SELECT * FROM ACCOUNTS'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT ACCOUNT_ID, OPERATOR_ID, ACCOUNT_NUMBER, LOGIN, PASSWORD,' +
        ' DO_AUTO_LOAD_DATA, LOAD_INTERVAL, PAY_LOAD_INTERVAL, BALANCE_NO' +
        'TICE_TEXT, BLOCK_NOTICE_TEXT, NEXT_MONTH_NOTICE_TEXT, LOAD_DETAI' +
        'L_POOL_SIZE, LOAD_DETAIL_THREAD_COUNT, BALANCE_BLOCK, DO_AUTO_BL' +
        'OCK, BALANCE_NOTICE, DO_BALANCE_NOTICE, DO_BALANCE_NOTICE_MONTH,' +
        ' BALANCE_NOTICE_END_MONTH, BALANCE_NOTICE_CREDIT, TEXT_NOTICE_BA' +
        'LANCE_CREDIT, BALANCE_BLOCK_CREDIT, TEXT_NOTICE_BLOCK_CREDIT, BA' +
        'LANCE_NOTICE_MONTH_CREDIT, TEXT_NOTICE_END_MONTH_CREDIT,BALANCE_' +
        'NOTICE2,BALANCE_NOTICE_TEXT2,BALANCE_NOTICE_CREDIT2,TEXT_NOTICE_' +
        'BALANCE_CREDIT2,COMPANY_NAME'
      ' FROM ACCOUNTS'
      'WHERE'
      '  ACCOUNT_ID = :ACCOUNT_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM DATABASE_COPIES')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    IndexFieldNames = 'OPERATOR_NAME, ACCOUNT_NUMBER'
    Left = 240
    Top = 65
    object qMainACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qMainOPERATOR_ID: TFloatField
      FieldName = 'OPERATOR_ID'
    end
    object qMainACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qMainLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 120
    end
    object qMainPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Size = 120
    end
    object qMainOPERATOR_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPERATOR_NAME'
      LookupKeyFields = 'OPERATOR_ID'
      LookupResultField = 'OPERATOR_NAME'
      KeyFields = 'OPERATOR_ID'
      Lookup = True
    end
    object qMainDO_AUTO_LOAD_DATA: TIntegerField
      FieldName = 'DO_AUTO_LOAD_DATA'
    end
    object qMainLOAD_INTERVAL: TFloatField
      FieldName = 'LOAD_INTERVAL'
    end
    object qMainPAY_LOAD_INTERVAL: TFloatField
      FieldName = 'PAY_LOAD_INTERVAL'
    end
    object qMainBALANCE_NOTICE_TEXT: TStringField
      FieldName = 'BALANCE_NOTICE_TEXT'
      Size = 800
    end
    object qMainBLOCK_NOTICE_TEXT: TStringField
      FieldName = 'BLOCK_NOTICE_TEXT'
      Size = 800
    end
    object qMainNEXT_MONTH_NOTICE_TEXT: TStringField
      FieldName = 'NEXT_MONTH_NOTICE_TEXT'
      Size = 800
    end
    object qMainLOAD_DETAIL_POOL_SIZE: TFloatField
      FieldName = 'LOAD_DETAIL_POOL_SIZE'
    end
    object qMainLOAD_DETAIL_THREAD_COUNT: TFloatField
      FieldName = 'LOAD_DETAIL_THREAD_COUNT'
    end
    object qMainBALANCE_BLOCK: TFloatField
      FieldName = 'BALANCE_BLOCK'
    end
    object qMainDO_AUTO_BLOCK: TIntegerField
      FieldName = 'DO_AUTO_BLOCK'
    end
    object qMainBALANCE_NOTICE: TFloatField
      FieldName = 'BALANCE_NOTICE'
    end
    object qMainDO_BALANCE_NOTICE: TIntegerField
      FieldName = 'DO_BALANCE_NOTICE'
    end
    object qMainDO_BALANCE_NOTICE_MONTH: TIntegerField
      FieldName = 'DO_BALANCE_NOTICE_MONTH'
    end
    object qMainBALANCE_NOTICE_END_MONTH: TFloatField
      FieldName = 'BALANCE_NOTICE_END_MONTH'
    end
    object qMainBALANCE_NOTICE_CREDIT: TFloatField
      FieldName = 'BALANCE_NOTICE_CREDIT'
    end
    object qMainTEXT_NOTICE_BALANCE_CREDIT: TStringField
      FieldName = 'TEXT_NOTICE_BALANCE_CREDIT'
      Size = 800
    end
    object qMainBALANCE_BLOCK_CREDIT: TFloatField
      FieldName = 'BALANCE_BLOCK_CREDIT'
    end
    object qMainTEXT_NOTICE_BLOCK_CREDIT: TStringField
      FieldName = 'TEXT_NOTICE_BLOCK_CREDIT'
      Size = 800
    end
    object qMainBALANCE_NOTICE_MONTH_CREDIT: TFloatField
      FieldName = 'BALANCE_NOTICE_MONTH_CREDIT'
    end
    object qMainTEXT_NOTICE_END_MONTH_CREDIT: TStringField
      FieldName = 'TEXT_NOTICE_END_MONTH_CREDIT'
      Size = 800
    end
    object qMainDILER_PAYMETS: TFloatField
      FieldName = 'DILER_PAYMETS'
    end
    object qMainUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qMainDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qMainUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 120
    end
    object qMainDATE_LAST_UPDATED: TDateTimeField
      FieldName = 'DATE_LAST_UPDATED'
    end
    object qMainNEXT_MONTH_NOTICE_BALANCE: TFloatField
      FieldName = 'NEXT_MONTH_NOTICE_BALANCE'
    end
    object qMainBALANCE_NOTICE2: TFloatField
      FieldName = 'BALANCE_NOTICE2'
    end
    object qMainBALANCE_NOTICE_TEXT2: TStringField
      FieldName = 'BALANCE_NOTICE_TEXT2'
      Size = 800
    end
    object qMainBALANCE_NOTICE_CREDIT2: TFloatField
      FieldName = 'BALANCE_NOTICE_CREDIT2'
    end
    object qMainTEXT_NOTICE_BALANCE_CREDIT2: TStringField
      FieldName = 'TEXT_NOTICE_BALANCE_CREDIT2'
      Size = 800
    end
    object qMainCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
  end
  object DataSource1: TDataSource
    DataSet = qMain
    Left = 304
    Top = 65
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.ImageList24
    Left = 256
    Top = 132
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
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 320
    Top = 132
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
  object qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_ACCOUNT_ID'
    SQL.Strings = (
      'begin'
      '  :RESULT := NEW_ACCOUNT_ID;'
      'end;')
    Left = 192
    Top = 65
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_ACCOUNT_ID:0'
  end
  object qLogs: TOraQuery
    SQLRefresh.Strings = (
      'SELECT'
      '  LOAD_DATE_TIME,'
      '   IS_SUCCESS,'
      '  ERROR_TEXT'
      'WHERE'
      '  ACCOUNT_ID=:ACCOUNT_ID')
    LocalUpdate = True
    SQL.Strings = (
      'SELECT'
      '  ACCOUNT_LOAD_LOGS.LOAD_DATE_TIME,'
      '  ACCOUNT_LOAD_TYPES.ACCOUNT_LOAD_TYPE_NAME,'
      
        '  CASE WHEN ACCOUNT_LOAD_LOGS.IS_SUCCESS = 1 THEN '#39'+'#39' ELSE '#39'-'#39' E' +
        'ND as IS_SUCCESS,'
      '  ACCOUNT_LOAD_LOGS.ERROR_TEXT'
      'FROM'
      '  ACCOUNT_LOAD_LOGS,'
      '  ACCOUNT_LOAD_TYPES'
      'WHERE'
      '  (ACCOUNT_LOAD_LOGS.ACCOUNT_ID=:ACCOUNT_ID) and'
      
        '  (ACCOUNT_LOAD_LOGS.ACCOUNT_LOAD_TYPE_ID=ACCOUNT_LOAD_TYPES.ACC' +
        'OUNT_LOAD_TYPE_ID)'
      
        '   AND (:VIEW_TYPE=0 OR :VIEW_TYPE=ACCOUNT_LOAD_LOGS.ACCOUNT_LOA' +
        'D_TYPE_ID)'
      'ORDER BY'
      '  ACCOUNT_LOAD_LOGS.LOAD_DATE_TIME DESC')
    MasterSource = DataSource1
    MasterFields = 'ACCOUNT_ID'
    DetailFields = 'ACCOUNT_ID'
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 176
    Top = 385
    ParamData = <
      item
        DataType = ftFloat
        Name = 'ACCOUNT_ID'
        ParamType = ptInput
        Value = 45.000000000000000000
      end
      item
        DataType = ftInteger
        Name = 'VIEW_TYPE'
        ParamType = ptInput
      end>
  end
  object dsLogs: TDataSource
    AutoEdit = False
    DataSet = qLogs
    Left = 224
    Top = 388
  end
  object spLoadPayment: TOraStoredProc
    StoredProcName = 'LOADER2_PCKG.LOAD_PREV_PAYMENTS'
    SQL.Strings = (
      'begin'
      
        '  LOADER2_PCKG.LOAD_PREV_PAYMENTS(:PACCOUNT_ID, :PYEAR, :PMONTH)' +
        ';'
      'end;')
    Left = 368
    Top = 80
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PACCOUNT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PYEAR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PMONTH'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'LOADER2_PCKG.LOAD_PREV_PAYMENTS:0'
  end
  object qLoadLogTypes: TOraQuery
    SQL.Strings = (
      'Select * from ACCOUNT_LOAD_TYPES'
      'order by ACCOUNT_LOAD_TYPE_id')
    Left = 360
    Top = 392
  end
  object DsRadioGroup: TOraDataSource
    DataSet = qLoadLogTypes
    Left = 424
    Top = 376
  end
  object spAllTurnOnOff: TOraStoredProc
    StoredProcName = 'CHANGE_ROBOT_ALL_ACCOUNTS'
    SQL.Strings = (
      'begin'
      '  CHANGE_ROBOT_ALL_ACCOUNTS(:PNEW_STATE);'
      'end;')
    Left = 920
    Top = 64
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PNEW_STATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'CHANGE_ROBOT_ALL_ACCOUNTS'
  end
end
