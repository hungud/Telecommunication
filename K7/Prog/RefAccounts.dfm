inherited RefAccountsForm: TRefAccountsForm
  Left = 44
  Top = 118
  VertScrollBar.Style = ssFlat
  VertScrollBar.Tracking = True
  Caption = #1051#1080#1094#1077#1074#1099#1077' '#1089#1095#1077#1090#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 906
  ClientWidth = 1038
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  ExplicitWidth = 1054
  ExplicitHeight = 944
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 1038
    Height = 45
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 1038
    ExplicitHeight = 45
    inherited ToolBar1: TToolBar
      Width = 1038
      Height = 44
      ButtonHeight = 44
      ButtonWidth = 93
      ShowCaptions = True
      ExplicitWidth = 1038
      ExplicitHeight = 44
      inherited ToolButton1: TToolButton
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      inherited ToolButton2: TToolButton
        Left = 93
        ExplicitLeft = 93
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      inherited ToolButton3: TToolButton
        Left = 186
        ExplicitLeft = 186
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      inherited ToolButton7: TToolButton
        Left = 279
        ExplicitLeft = 279
        ExplicitHeight = 44
      end
      inherited ToolButton4: TToolButton
        Left = 287
        ExplicitLeft = 287
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      inherited ToolButton5: TToolButton
        Left = 380
        ExplicitLeft = 380
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      inherited ToolButton8: TToolButton
        Left = 473
        ExplicitLeft = 473
        ExplicitHeight = 44
      end
      inherited ToolButton6: TToolButton
        Left = 481
        ExplicitLeft = 481
        ExplicitWidth = 93
        ExplicitHeight = 44
      end
      object ToolButton9: TToolButton
        Left = 574
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object tbLoadPayments: TToolButton
        Left = 582
        Top = 0
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1083#1072#1090#1077#1078#1080' '#1087#1088#1086#1096#1083#1086#1075#1086' '#1084#1077#1089#1103#1094#1072
        Caption = #1047#1072#1075#1088#1091#1079'. '#1087#1083#1072#1090#1077#1078#1080
        ImageIndex = 20
        OnClick = tbLoadPaymentsClick
      end
      object ToolButton10: TToolButton
        Left = 675
        Top = 0
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 21
        Style = tbsSeparator
      end
      object tbJobOn: TToolButton
        Left = 683
        Top = 0
        Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1080' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103
        Caption = #1042#1082#1083'. '#1079#1072#1075'. '#1080' '#1086#1087'-'#1103
        ImageIndex = 25
        OnClick = tbJobOnClick
      end
      object tbJobOff: TToolButton
        Left = 776
        Top = 0
        Hint = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1080' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103
        Caption = #1042#1099#1082#1083'. '#1079#1072#1075'. '#1080' '#1086#1087'-'#1103
        ImageIndex = 26
        OnClick = tbJobOffClick
      end
    end
  end
  inherited Panel2: TPanel
    Top = 45
    Width = 683
    Height = 861
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 45
    ExplicitWidth = 683
    ExplicitHeight = 861
    object Splitter1: TSplitter [0]
      Left = 1
      Top = 193
      Width = 681
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 676
    end
    inherited CRDBGrid1: TCRDBGrid
      Width = 681
      Height = 192
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
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
        end
        item
          Expanded = False
          FieldName = 'FILIAL_NAME'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 214
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SMS_SENDER_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1077' "'#1054#1090' '#1082#1086#1075#1086'", '#1087#1088#1080' '#1088#1072#1089#1089#1099#1083#1082#1077' '#1089#1084#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 214
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PROVIDER_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1086#1074#1072#1081#1076#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 124
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 1
      Top = 196
      Width = 681
      Height = 664
      Align = alClient
      TabOrder = 1
      object dgLoadingLogs: TCRDBGrid
        Left = 1
        Top = 81
        Width = 679
        Height = 582
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
        OnKeyUp = dgLoadingLogsKeyUp
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
      object RGLoadLogTypes: TRadioGroup
        Left = 1
        Top = 1
        Width = 679
        Height = 80
        Align = alTop
        BiDiMode = bdRightToLeftNoAlign
        Caption = #1060#1080#1083#1100#1090#1088' '#1079#1072#1075#1088#1091#1079#1086#1082
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          #1042#1089#1077' '#1079#1072#1075#1088#1091#1079#1082#1080)
        ParentBiDiMode = False
        TabOrder = 1
        OnClick = RGLoadLogTypesClick
      end
    end
  end
  object Panel6: TPanel [2]
    Left = 683
    Top = 45
    Width = 355
    Height = 861
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 0
      Top = 613
      Width = 355
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 599
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 355
      Height = 613
      Align = alClient
      TabOrder = 0
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 353
        Height = 33
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 0
        object cbAllTurnOnOff: TCheckBox
          Left = 10
          Top = 10
          Width = 322
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1082#1083'/'#1074#1099#1082#1083' '#1087#1086' '#1074#1089#1077#1084' '#1051'/'#1057' '#1072#1074#1090#1086#1073#1083'. '#1080' '#1087#1088#1077#1076'. '#1086' '#1073#1072#1083#1072#1085#1089#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = cbAllTurnOnOffClick
        end
      end
      object gbParametrs: TGroupBox
        Left = 1
        Top = 34
        Width = 353
        Height = 578
        Align = alClient
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object PageControl2: TPageControl
          Left = 2
          Top = 18
          Width = 349
          Height = 558
          ActivePage = tsUSSD
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #1054#1087#1086#1074#1077#1097#1077#1085#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 173
            ExplicitHeight = 60
            object PageControl1: TPageControl
              Left = 3
              Top = 3
              Width = 332
              Height = 534
              ActivePage = tsAvans
              MultiLine = True
              ScrollOpposite = True
              TabOrder = 0
              object tsAvans: TTabSheet
                Caption = #1040#1074#1072#1085#1089
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object GroupBoxBalanceBlock: TGroupBox
                  Left = 3
                  Top = 3
                  Width = 318
                  Height = 130
                  TabOrder = 0
                  object LabelBalanceBlock: TLabel
                    Left = 11
                    Top = 34
                    Width = 122
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBlockNoticeLength: TLabel
                    Left = 298
                    Top = 103
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object LabelBlockNEM: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBCheckBoxAutoBlock: TDBCheckBox
                    Left = 10
                    Top = 8
                    Width = 222
                    Height = 17
                    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
                    DataField = 'DO_AUTO_BLOCK'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEditBalanceBlock: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_BLOCK'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBlockNotice: TDBMemo
                    Left = 11
                    Top = 56
                    Width = 270
                    Height = 63
                    DataField = 'BLOCK_NOTICE_TEXT'
                    DataSource = DataSource1
                    TabOrder = 2
                    OnChange = DBMemoBlockNoticeChange
                  end
                end
                object GroupBoxBalanceNotice: TGroupBox
                  Left = 3
                  Top = 139
                  Width = 318
                  Height = 226
                  TabOrder = 1
                  object LabelBalanceNotice: TLabel
                    Left = 11
                    Top = 34
                    Width = 165
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103' 1'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeLength: TLabel
                    Left = 298
                    Top = 103
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object LabelBalanceN: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object LabelBalanceNotice2: TLabel
                    Left = 11
                    Top = 129
                    Width = 165
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103' 2'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label2: TLabel
                    Left = 283
                    Top = 129
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeLength2: TLabel
                    Left = 298
                    Top = 200
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object DBCheckBoxBalanceNotice: TDBCheckBox
                    Left = 11
                    Top = 11
                    Width = 221
                    Height = 17
                    Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1077' '#1086' '#1073#1072#1083#1072#1085#1089#1077
                    DataField = 'DO_BALANCE_NOTICE'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEditBalanceNotice: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBalanceNotice: TDBMemo
                    Left = 11
                    Top = 56
                    Width = 270
                    Height = 63
                    DataField = 'BALANCE_NOTICE_TEXT'
                    DataSource = DataSource1
                    TabOrder = 2
                    OnChange = DBMemoBalanceNoticeChange
                  end
                  object DBEditBalanceNotice2: TDBEdit
                    Left = 238
                    Top = 127
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE2'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 3
                  end
                  object DBMemoBalanceNotice2: TDBMemo
                    Left = 11
                    Top = 155
                    Width = 270
                    Height = 63
                    DataField = 'BALANCE_NOTICE_TEXT2'
                    DataSource = DataSource1
                    TabOrder = 4
                    OnChange = DBMemoBalanceNotice2Change
                  end
                end
                object GroupBoxBalanceNoticeEndMonth: TGroupBox
                  Left = 3
                  Top = 371
                  Width = 318
                  Height = 130
                  TabOrder = 2
                  object LabelBalanceNoticeEndMonth: TLabel
                    Left = 11
                    Top = 34
                    Width = 155
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeEndMonthLength: TLabel
                    Left = 298
                    Top = 103
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object LabelBalanceNEM: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBCheckBoxBalanceNoticeEndMonth: TDBCheckBox
                    Left = 11
                    Top = 11
                    Width = 294
                    Height = 17
                    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072' '#1086' '#1082#1086#1085#1094#1077' '#1084#1077#1089#1103#1094#1072
                    DataField = 'DO_BALANCE_NOTICE_MONTH'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEditBalanceNoticeEndMonth: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE_END_MONTH'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBalanceNoticeEndMonth: TDBMemo
                    Left = 11
                    Top = 56
                    Width = 270
                    Height = 63
                    DataField = 'NEXT_MONTH_NOTICE_TEXT'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                    OnChange = DBMemoBalanceNoticeEndMonthChange
                  end
                end
              end
              object tsCredit: TTabSheet
                Caption = #1050#1088#1077#1076#1080#1090
                ImageIndex = 1
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object GroupBox1: TGroupBox
                  Left = 3
                  Top = 3
                  Width = 318
                  Height = 130
                  TabOrder = 0
                  object Label1: TLabel
                    Left = 11
                    Top = 34
                    Width = 122
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBlockNoticeCreditLength: TLabel
                    Left = 295
                    Top = 104
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label3: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBCheckBox1: TDBCheckBox
                    Left = 10
                    Top = 8
                    Width = 222
                    Height = 17
                    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
                    DataField = 'DO_AUTO_BLOCK'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEdit1: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_BLOCK_CREDIT'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBlockNoticeCredit: TDBMemo
                    Left = 11
                    Top = 56
                    Width = 270
                    Height = 63
                    DataField = 'TEXT_NOTICE_BLOCK_CREDIT'
                    DataSource = DataSource1
                    TabOrder = 2
                    OnChange = DBMemoBlockNoticeCreditChange
                  end
                end
                object GroupBox2: TGroupBox
                  Left = 3
                  Top = 139
                  Width = 318
                  Height = 226
                  TabOrder = 1
                  object Label4: TLabel
                    Left = 11
                    Top = 34
                    Width = 165
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103' 1'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeCreditLength: TLabel
                    Left = 295
                    Top = 104
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label5: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label6: TLabel
                    Left = 11
                    Top = 129
                    Width = 165
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103' 2'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeCreditLength2: TLabel
                    Left = 295
                    Top = 200
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label8: TLabel
                    Left = 283
                    Top = 129
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBCheckBox2: TDBCheckBox
                    Left = 11
                    Top = 11
                    Width = 221
                    Height = 17
                    Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1077' '#1086' '#1073#1072#1083#1072#1085#1089#1077
                    DataField = 'DO_BALANCE_NOTICE'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEdit2: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE_CREDIT'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBalanceNoticeCredit: TDBMemo
                    Left = 3
                    Top = 58
                    Width = 278
                    Height = 63
                    DataField = 'TEXT_NOTICE_BALANCE_CREDIT'
                    DataSource = DataSource1
                    TabOrder = 2
                    OnChange = DBMemoBalanceNoticeCreditChange
                  end
                  object DBMemoBalanceNoticeCredit2: TDBMemo
                    Left = 3
                    Top = 157
                    Width = 278
                    Height = 63
                    DataField = 'TEXT_NOTICE_BALANCE_CREDIT2'
                    DataSource = DataSource1
                    TabOrder = 3
                    OnChange = DBMemoBalanceNoticeCredit2Change
                  end
                  object DBEditBalanceNoticeCredit2: TDBEdit
                    Left = 238
                    Top = 127
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE_CREDIT2'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 4
                  end
                end
                object GroupBox3: TGroupBox
                  Left = 3
                  Top = 371
                  Width = 318
                  Height = 130
                  TabOrder = 2
                  object Label7: TLabel
                    Left = 11
                    Top = 34
                    Width = 155
                    Height = 16
                    Caption = #1055#1086#1088#1086#1075' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lBalanceNoticeEndMonthCreditLength: TLabel
                    Left = 295
                    Top = 104
                    Width = 17
                    Height = 16
                    Alignment = taRightJustify
                    Caption = '70'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object Label9: TLabel
                    Left = 283
                    Top = 34
                    Width = 11
                    Height = 16
                    Caption = #1088'.'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                  end
                  object DBCheckBox3: TDBCheckBox
                    Left = 11
                    Top = 11
                    Width = 294
                    Height = 17
                    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1088#1072#1089#1089#1099#1083#1082#1072' '#1086' '#1082#1086#1085#1094#1077' '#1084#1077#1089#1103#1094#1072
                    DataField = 'DO_BALANCE_NOTICE_MONTH'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    ValueChecked = '1'
                    ValueUnchecked = '0'
                  end
                  object DBEdit3: TDBEdit
                    Left = 238
                    Top = 31
                    Width = 43
                    Height = 24
                    DataField = 'BALANCE_NOTICE_MONTH_CREDIT'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object DBMemoBalanceNoticeEndMonthCredit: TDBMemo
                    Left = 3
                    Top = 61
                    Width = 278
                    Height = 63
                    DataField = 'TEXT_NOTICE_END_MONTH_CREDIT'
                    DataSource = DataSource1
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                    OnChange = DBMemoBalanceNoticeEndMonthCreditChange
                  end
                end
              end
            end
          end
          object TabSheet2: TTabSheet
            Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ImageIndex = 1
            ParentFont = False
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 345
            ExplicitHeight = 550
            object GroupBoxSettingsConnection: TGroupBox
              Left = 15
              Top = 21
              Width = 299
              Height = 212
              TabOrder = 0
              object LabelLoadInterval: TLabel
                Left = 11
                Top = 45
                Width = 179
                Height = 16
                Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1076#1072#1085#1085#1099#1093
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelPayLoadInterval: TLabel
                Left = 11
                Top = 70
                Width = 196
                Height = 16
                Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1087#1083#1072#1090#1077#1078#1077#1081
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelChangePassword: TLabel
                Left = 11
                Top = 95
                Width = 49
                Height = 16
                Caption = #1055#1072#1088#1086#1083#1100
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelDetailThreadCount: TLabel
                Left = 11
                Top = 176
                Width = 182
                Height = 16
                Caption = #1050#1086#1083'-'#1074#1086' '#1087#1072#1088#1072#1083#1083#1077#1083#1100#1085#1099#1093' '#1089#1077#1089#1080#1081
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelLoadDetailPoolSize: TLabel
                Left = 11
                Top = 151
                Width = 223
                Height = 16
                Caption = #1050#1086#1083'-'#1074#1086' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' '#1074' '#1086#1076#1085#1086#1081' '#1089#1077#1089#1089#1080#1080
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblnewpass: TLabel
                Left = 11
                Top = 125
                Width = 184
                Height = 16
                Caption = #1055#1072#1088#1086#1083#1100'  '#1086#1090' '#1085#1086#1074#1086#1075#1086' '#1082#1072#1073#1080#1085#1077#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object DBCheckBoxAutoLoad: TDBCheckBox
                Left = 12
                Top = 22
                Width = 269
                Height = 17
                Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1079#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
                DataField = 'DO_AUTO_LOAD_DATA'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                ValueChecked = '1'
                ValueUnchecked = '0'
              end
              object DBEditLoadInterval: TDBEdit
                Left = 245
                Top = 42
                Width = 43
                Height = 24
                DataField = 'LOAD_INTERVAL'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object DBEditPayLoadInterval: TDBEdit
                Left = 245
                Top = 67
                Width = 43
                Height = 24
                DataField = 'PAY_LOAD_INTERVAL'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object DBEditChangePassword: TDBEdit
                Left = 207
                Top = 92
                Width = 81
                Height = 24
                DataField = 'PASSWORD'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                PasswordChar = '*'
                TabOrder = 3
              end
              object DBEditLoadDetailPoolSize: TDBEdit
                Left = 245
                Top = 148
                Width = 43
                Height = 24
                DataField = 'LOAD_DETAIL_POOL_SIZE'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object DBEditLoadDetailThreadCount: TDBEdit
                Left = 245
                Top = 173
                Width = 43
                Height = 24
                DataField = 'LOAD_DETAIL_THREAD_COUNT'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object DBEditChangeNewPassword: TDBEdit
                Left = 207
                Top = 122
                Width = 81
                Height = 24
                DataField = 'NEW_PSWD'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                PasswordChar = '*'
                TabOrder = 6
              end
            end
            object GroupBoxStatusLoad: TGroupBox
              Left = 16
              Top = 248
              Width = 297
              Height = 97
              Caption = #1047#1072#1075#1088#1091#1079#1082#1080
              TabOrder = 1
              Visible = False
              object lbBlockJob: TLabel
                Left = 15
                Top = 23
                Width = 61
                Height = 13
                Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
              end
              object lbUnBlockJob: TLabel
                Left = 14
                Top = 37
                Width = 79
                Height = 13
                Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072
              end
              object lbPaymentsJob: TLabel
                Left = 15
                Top = 51
                Width = 45
                Height = 13
                Caption = #1055#1083#1072#1090#1077#1078#1080
              end
              object lbStatusJob: TLabel
                Left = 15
                Top = 66
                Width = 42
                Height = 13
                Caption = #1057#1090#1072#1090#1091#1089#1099
              end
              object lbBlockJobStatus: TDBText
                Left = 127
                Top = 23
                Width = 145
                Height = 17
                DataField = 'BLOCK'
                DataSource = dsJobs
              end
              object lbUnBlockJobStatus: TDBText
                Left = 127
                Top = 37
                Width = 130
                Height = 17
                DataField = 'UNBLOCK'
                DataSource = dsJobs
              end
              object lbPaymentsJobStatus: TDBText
                Left = 127
                Top = 51
                Width = 130
                Height = 17
                DataField = 'PAYMENTS'
                DataSource = dsJobs
              end
              object lbStatusJobStatus: TDBText
                Left = 127
                Top = 66
                Width = 130
                Height = 17
                DataField = 'PHONES'
                DataSource = dsJobs
              end
            end
            object DBCheckBoxIsCollector: TDBCheckBox
              Left = 16
              Top = 360
              Width = 129
              Height = 17
              Caption = #1050#1086#1083#1083#1077#1082#1090#1086#1088#1089#1082#1080#1081' '#1089#1095#1077#1090
              DataField = 'IS_COLLECTOR'
              DataSource = DataSource1
              TabOrder = 2
              ValueChecked = '1'
              ValueUnchecked = '0'
              Visible = False
            end
          end
          object tsUSSD: TTabSheet
            Caption = 'USSD '#1096#1072#1073#1083#1086#1085#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ImageIndex = 2
            ParentFont = False
            object GroupBox4: TGroupBox
              Left = 3
              Top = 3
              Width = 318
              Height = 152
              Caption = #1047#1072#1087#1088#1086#1089' '#1073#1072#1083#1072#1085#1089#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object lUSSDBalanceLen: TLabel
                Left = 298
                Top = 103
                Width = 17
                Height = 16
                Alignment = taRightJustify
                Caption = '73'
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGreen
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object lUSSDMaxlen: TLabel
                Left = 12
                Top = 125
                Width = 284
                Height = 14
                Caption = #1055#1056#1045#1042#1067#1064#1045#1053#1040' '#1052#1040#1050#1057#1048#1052#1040#1051#1068#1053#1040#1071' '#1044#1051#1048#1053#1040' '#1057#1054#1054#1041#1065#1045#1053#1048#1071
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Visible = False
              end
              object dbUSSDBalance: TDBMemo
                Left = 11
                Top = 25
                Width = 270
                Height = 94
                DataField = 'BALANCE_USSD_TEXT'
                DataSource = DataSource1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnChange = dbUSSDBalanceChange
              end
            end
          end
        end
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 616
      Width = 355
      Height = 245
      Align = alBottom
      TabOrder = 1
      object gJob: TCRDBGrid
        Left = 1
        Top = 25
        Width = 353
        Height = 219
        Align = alClient
        DataSource = dsJob
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = gJobDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'JOB_NAME'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SACCOUNT_NUM'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATE'
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 50
            Visible = True
          end>
      end
      object Panel7: TPanel
        Left = 1
        Top = 1
        Width = 353
        Height = 24
        Align = alTop
        Caption = #1058#1077#1082#1091#1097#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1075#1088#1091#1079#1086#1082' '#1080' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = 'ACCOUNTS'
    KeyFields = 'ACCOUNT_ID'
    SQLInsert.Strings = (
      'begin'
      '--'#1074#1089#1090#1072#1074#1082#1072' '#1074' '#1090#1072#1073#1083'. ACCOUNTS'
      'INSERT INTO ACCOUNTS'
      '  (ACCOUNT_ID,'
      '   OPERATOR_ID,'
      '   ACCOUNT_NUMBER,'
      '   LOGIN,'
      '   PASSWORD,'
      '   DO_AUTO_LOAD_DATA,'
      '   LOAD_INTERVAL,'
      '   PAY_LOAD_INTERVAL,'
      '   BALANCE_NOTICE_TEXT,'
      '   BLOCK_NOTICE_TEXT,'
      '   NEXT_MONTH_NOTICE_TEXT,'
      '   LOAD_DETAIL_POOL_SIZE,'
      '   LOAD_DETAIL_THREAD_COUNT,'
      '   BALANCE_BLOCK,'
      '   DO_AUTO_BLOCK,'
      '   BALANCE_NOTICE,'
      '   DO_BALANCE_NOTICE,'
      '   DO_BALANCE_NOTICE_MONTH,'
      '   BALANCE_NOTICE_END_MONTH,'
      '   BALANCE_NOTICE_CREDIT,'
      '   TEXT_NOTICE_BALANCE_CREDIT,'
      '   BALANCE_BLOCK_CREDIT,'
      '   TEXT_NOTICE_BLOCK_CREDIT,'
      '   BALANCE_NOTICE_MONTH_CREDIT,'
      '   TEXT_NOTICE_END_MONTH_CREDIT,'
      '   DILER_PAYMETS,'
      '   BALANCE_NOTICE2,'
      '   BALANCE_NOTICE_TEXT2,'
      '   BALANCE_NOTICE_CREDIT2,'
      '   TEXT_NOTICE_BALANCE_CREDIT2,'
      '   COMPANY_NAME,'
      '   FILIAL_ID,'
      '   new_pswd,'
      '   SMS_SENDER_NAME_ID,'
      '   BALANCE_USSD_TEXT'
      '   )'
      'VALUES'
      '  (:ACCOUNT_ID,'
      '  :OPERATOR_ID,'
      '  :ACCOUNT_NUMBER,'
      '  :LOGIN, :PASSWORD,'
      '  :DO_AUTO_LOAD_DATA,'
      '  :LOAD_INTERVAL, '
      '  :PAY_LOAD_INTERVAL,'
      '  :BALANCE_NOTICE_TEXT,'
      '  :BLOCK_NOTICE_TEXT,'
      '  :NEXT_MONTH_NOTICE_TEXT,'
      '  :LOAD_DETAIL_POOL_SIZE,'
      '  :LOAD_DETAIL_THREAD_COUNT,'
      '  :BALANCE_BLOCK,'
      '  :DO_AUTO_BLOCK,'
      '  :BALANCE_NOTICE,'
      '  :DO_BALANCE_NOTICE,'
      '  :DO_BALANCE_NOTICE_MONTH,'
      '  :BALANCE_NOTICE_END_MONTH,'
      '  :BALANCE_NOTICE_CREDIT,'
      '  :TEXT_NOTICE_BALANCE_CREDIT,'
      '  :BALANCE_BLOCK_CREDIT,'
      '  :TEXT_NOTICE_BLOCK_CREDIT,'
      '  :BALANCE_NOTICE_MONTH_CREDIT,'
      '  :TEXT_NOTICE_END_MONTH_CREDIT,'
      '  :DILER_PAYMETS,'
      '  :BALANCE_NOTICE2,'
      '  :BALANCE_NOTICE_TEXT2,'
      '  :BALANCE_NOTICE_CREDIT2,'
      '  :TEXT_NOTICE_BALANCE_CREDIT2,'
      '  :COMPANY_NAME,'
      '  :FILIAL_ID,'
      '  :new_pswd,'
      '  :SMS_SENDER_NAME_ID,'
      '  :BALANCE_USSD_TEXT'
      '  );'
      ''
      '  --'#1074#1089#1090#1072#1074#1082#1072' '#1074' '#1090#1072#1073#1083'. SMS_SEND_PARAM_BY_ACCOUNT'
      '  if (:PROVIDER_ID is not null) and (:PROVIDER_ID <> 0) then'
      '    INSERT INTO SMS_SEND_PARAM_BY_ACCOUNT '
      '      (ACCOUNT_ID, PROVIDER_ID) '
      '    VALUES '
      '      (:ACCOUNT_ID, :PROVIDER_ID);'
      '  end if;'
      'end;')
    SQLDelete.Strings = (
      'begin'
      '--'#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080' '#1080#1079' '#1090#1072#1073#1083'. ACCOUNTS'
      'DELETE FROM ACCOUNTS'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID;'
      ''
      '--'#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080' '#1080#1079' '#1090#1072#1073#1083'. SMS_SEND_PARAM_BY_ACCOUNT'
      'DELETE FROM SMS_SEND_PARAM_BY_ACCOUNT'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID;'
      'end;')
    SQLUpdate.Strings = (
      'declare'
      '  vProv integer;'
      'begin'
      '--'#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1090#1072#1073#1083'. ACCOUNTS'
      'UPDATE ACCOUNTS'
      'SET'
      '  ACCOUNT_ID = :ACCOUNT_ID,'
      '  OPERATOR_ID = :OPERATOR_ID,'
      '  ACCOUNT_NUMBER = :ACCOUNT_NUMBER,'
      '  LOGIN = :LOGIN,'
      '  PASSWORD = :PASSWORD,'
      '  DO_AUTO_LOAD_DATA = :DO_AUTO_LOAD_DATA,'
      '  LOAD_INTERVAL = :LOAD_INTERVAL,'
      '  PAY_LOAD_INTERVAL = :PAY_LOAD_INTERVAL,'
      '  BALANCE_NOTICE_TEXT = :BALANCE_NOTICE_TEXT,'
      '  BLOCK_NOTICE_TEXT = :BLOCK_NOTICE_TEXT,'
      '  NEXT_MONTH_NOTICE_TEXT = :NEXT_MONTH_NOTICE_TEXT,'
      '  LOAD_DETAIL_POOL_SIZE = :LOAD_DETAIL_POOL_SIZE,'
      '  LOAD_DETAIL_THREAD_COUNT = :LOAD_DETAIL_THREAD_COUNT,'
      '  BALANCE_BLOCK = :BALANCE_BLOCK,'
      '  DO_AUTO_BLOCK = :DO_AUTO_BLOCK,'
      '  BALANCE_NOTICE = :BALANCE_NOTICE,'
      '  DO_BALANCE_NOTICE = :DO_BALANCE_NOTICE,'
      '  DO_BALANCE_NOTICE_MONTH = :DO_BALANCE_NOTICE_MONTH,'
      '  BALANCE_NOTICE_END_MONTH = :BALANCE_NOTICE_END_MONTH,'
      '  BALANCE_NOTICE_CREDIT = :BALANCE_NOTICE_CREDIT,'
      '  TEXT_NOTICE_BALANCE_CREDIT = :TEXT_NOTICE_BALANCE_CREDIT,'
      '  BALANCE_BLOCK_CREDIT = :BALANCE_BLOCK_CREDIT,'
      '  TEXT_NOTICE_BLOCK_CREDIT = :TEXT_NOTICE_BLOCK_CREDIT,'
      '  BALANCE_NOTICE_MONTH_CREDIT = :BALANCE_NOTICE_MONTH_CREDIT,'
      '  TEXT_NOTICE_END_MONTH_CREDIT = :TEXT_NOTICE_END_MONTH_CREDIT,'
      '  DILER_PAYMETS = :DILER_PAYMETS,'
      '  BALANCE_NOTICE2 = :BALANCE_NOTICE2,'
      '  BALANCE_NOTICE_TEXT2 = :BALANCE_NOTICE_TEXT2,'
      '  BALANCE_NOTICE_CREDIT2 = :BALANCE_NOTICE_CREDIT2,'
      '  TEXT_NOTICE_BALANCE_CREDIT2 = :TEXT_NOTICE_BALANCE_CREDIT2,'
      '  COMPANY_NAME=:COMPANY_NAME,'
      '  FILIAL_ID=:FILIAL_ID,'
      '  new_pswd=:new_pswd, '
      '  SMS_SENDER_NAME_ID = :SMS_SENDER_NAME_ID,'
      '  BALANCE_USSD_TEXT = :BALANCE_USSD_TEXT'
      'WHERE'
      '  ACCOUNT_ID = :Old_ACCOUNT_ID;'
      ''
      '--'#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083'. SMS_SEND_PARAM_BY_ACCOUNT'
      'if (:PROVIDER_ID is null) or (:PROVIDER_ID = 0) then'
      '  --'#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080' '#1080#1079' '#1090#1072#1073#1083'. SMS_SEND_PARAM_BY_ACCOUNT'
      '  DELETE FROM SMS_SEND_PARAM_BY_ACCOUNT'
      '  WHERE'
      '    ACCOUNT_ID = :Old_ACCOUNT_ID;  '
      'else'
      '  select count(*) '
      '  into vProv'
      '  from SMS_SEND_PARAM_BY_ACCOUNT smac'
      '  where smac.ACCOUNT_ID = :Old_ACCOUNT_ID;  '
      ' '
      '  if (vProv) = 0 then'
      '    --'#1074#1089#1090#1072#1074#1082#1072
      '    INSERT INTO SMS_SEND_PARAM_BY_ACCOUNT '
      '      (ACCOUNT_ID, PROVIDER_ID) '
      '    VALUES '
      '      (:ACCOUNT_ID, :PROVIDER_ID);'
      '  else'
      '    --'#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      '    UPDATE SMS_SEND_PARAM_BY_ACCOUNT'
      '    SET '
      '      ACCOUNT_ID  = :ACCOUNT_ID,'
      '      PROVIDER_ID = :PROVIDER_ID'
      '    WHERE'
      '      ACCOUNT_ID = :Old_ACCOUNT_ID;'
      '  end if;'
      'end if;'
      'end;')
    SQLLock.Strings = (
      'SELECT ac.*, SM.PROVIDER_ID'
      'FROM ACCOUNTS ac'
      
        'LEFT JOIN SMS_SEND_PARAM_BY_ACCOUNT sm ON SM.ACCOUNT_ID = ac.ACC' +
        'OUNT_ID'
      'WHERE'
      '  ac.ACCOUNT_ID = :Old_ACCOUNT_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT '
      '  ac.ACCOUNT_ID, ac.OPERATOR_ID, ac.ACCOUNT_NUMBER, ac.LOGIN, '
      
        '  ac.PASSWORD, ac.DO_AUTO_LOAD_DATA, ac.LOAD_INTERVAL, ac.PAY_LO' +
        'AD_INTERVAL, '
      
        '  ac.BALANCE_NOTICE_TEXT, ac.BLOCK_NOTICE_TEXT, ac.NEXT_MONTH_NO' +
        'TICE_TEXT, '
      
        '  ac.LOAD_DETAIL_POOL_SIZE, ac.LOAD_DETAIL_THREAD_COUNT, ac.BALA' +
        'NCE_BLOCK, '
      
        '  ac.DO_AUTO_BLOCK, ac.BALANCE_NOTICE, ac.DO_BALANCE_NOTICE, ac.' +
        'DO_BALANCE_NOTICE_MONTH, '
      
        '  ac.BALANCE_NOTICE_END_MONTH, ac.BALANCE_NOTICE_CREDIT, ac.TEXT' +
        '_NOTICE_BALANCE_CREDIT, '
      
        '  ac.BALANCE_BLOCK_CREDIT, ac.TEXT_NOTICE_BLOCK_CREDIT, ac.BALAN' +
        'CE_NOTICE_MONTH_CREDIT, '
      
        '  ac.TEXT_NOTICE_END_MONTH_CREDIT, ac.BALANCE_NOTICE2, ac.BALANC' +
        'E_NOTICE_TEXT2, '
      
        '  ac.BALANCE_NOTICE_CREDIT2, ac.TEXT_NOTICE_BALANCE_CREDIT2, ac.' +
        'COMPANY_NAME, ac.FILIAL_ID,'
      '  ac.SMS_SENDER_NAME_ID, SM.PROVIDER_ID, ac.BALANCE_USSD_TEXT'
      ' FROM ACCOUNTS ac'
      
        ' LEFT JOIN SMS_SEND_PARAM_BY_ACCOUNT sm ON SM.ACCOUNT_ID = ac.AC' +
        'COUNT_ID'
      'WHERE'
      '  ac.ACCOUNT_ID = :ACCOUNT_ID')
    SQL.Strings = (
      'SELECT ac.*, SM.PROVIDER_ID'
      'FROM ACCOUNTS ac'
      
        'LEFT JOIN SMS_SEND_PARAM_BY_ACCOUNT sm ON SM.ACCOUNT_ID = AC.ACC' +
        'OUNT_ID')
    IndexFieldNames = 'OPERATOR_NAME, ACCOUNT_NUMBER'
    AfterOpen = qMainAfterOpen
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
      Size = 30
    end
    object qMainPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Size = 30
    end
    object qMainOPERATOR_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'OPERATOR_NAME'
      LookupDataSet = qOperators
      LookupKeyFields = 'OPERATOR_ID'
      LookupResultField = 'OPERATOR_NAME'
      KeyFields = 'OPERATOR_ID'
      Lookup = True
    end
    object qMainDO_AUTO_LOAD_DATA: TIntegerField
      FieldName = 'DO_AUTO_LOAD_DATA'
      OnValidate = qMainDO_AUTO_LOAD_DATAValidate
    end
    object qMainLOAD_INTERVAL: TFloatField
      FieldName = 'LOAD_INTERVAL'
      OnGetText = qMainLOAD_INTERVALGetText
      OnSetText = qMainLOAD_INTERVALSetText
    end
    object qMainPAY_LOAD_INTERVAL: TFloatField
      FieldName = 'PAY_LOAD_INTERVAL'
      OnGetText = qMainLOAD_INTERVALGetText
      OnSetText = qMainLOAD_INTERVALSetText
    end
    object qMainBALANCE_NOTICE_TEXT: TStringField
      FieldName = 'BALANCE_NOTICE_TEXT'
      Size = 350
    end
    object qMainBLOCK_NOTICE_TEXT: TStringField
      FieldName = 'BLOCK_NOTICE_TEXT'
      Size = 350
    end
    object qMainNEXT_MONTH_NOTICE_TEXT: TStringField
      FieldName = 'NEXT_MONTH_NOTICE_TEXT'
      Size = 350
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
      Size = 350
    end
    object qMainBALANCE_BLOCK_CREDIT: TFloatField
      FieldName = 'BALANCE_BLOCK_CREDIT'
    end
    object qMainTEXT_NOTICE_BLOCK_CREDIT: TStringField
      FieldName = 'TEXT_NOTICE_BLOCK_CREDIT'
      Size = 350
    end
    object qMainBALANCE_NOTICE_MONTH_CREDIT: TFloatField
      FieldName = 'BALANCE_NOTICE_MONTH_CREDIT'
    end
    object qMainTEXT_NOTICE_END_MONTH_CREDIT: TStringField
      FieldName = 'TEXT_NOTICE_END_MONTH_CREDIT'
      Size = 350
    end
    object qMainDILER_PAYMETS: TFloatField
      FieldName = 'DILER_PAYMETS'
    end
    object qMainUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 30
    end
    object qMainDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qMainUSER_LAST_UPDATED: TStringField
      FieldName = 'USER_LAST_UPDATED'
      Size = 30
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
      Size = 350
    end
    object qMainBALANCE_NOTICE_CREDIT2: TFloatField
      FieldName = 'BALANCE_NOTICE_CREDIT2'
    end
    object qMainTEXT_NOTICE_BALANCE_CREDIT2: TStringField
      FieldName = 'TEXT_NOTICE_BALANCE_CREDIT2'
      Size = 350
    end
    object qMainCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 30
    end
    object qMainFILIAL_ID: TFloatField
      FieldName = 'FILIAL_ID'
    end
    object qMainFILIAL_NAME: TStringField
      DisplayLabel = #1060#1080#1083#1080#1072#1083
      FieldKind = fkLookup
      FieldName = 'FILIAL_NAME'
      LookupDataSet = qFilials
      LookupKeyFields = 'FILIAL_ID'
      LookupResultField = 'FILIAL_NAME'
      KeyFields = 'FILIAL_ID'
      Size = 30
      Lookup = True
    end
    object qMainNEW_PSWD: TStringField
      FieldName = 'NEW_PSWD'
      Size = 30
    end
    object qMainIS_COLLECTOR: TIntegerField
      FieldName = 'IS_COLLECTOR'
    end
    object qMainSMS_SENDER_NAME_ID: TIntegerField
      FieldName = 'SMS_SENDER_NAME_ID'
    end
    object qMainSMS_SENDER_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'SMS_SENDER_NAME'
      LookupDataSet = qSMS_SENDER_NAME
      LookupKeyFields = 'SMS_SENDER_NAME_ID'
      LookupResultField = 'SMS_SENDER_NAME'
      KeyFields = 'SMS_SENDER_NAME_ID'
      Lookup = True
    end
    object qMainPROVIDER_ID: TFloatField
      FieldName = 'PROVIDER_ID'
    end
    object qMainPROVIDER_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'PROVIDER_NAME'
      LookupDataSet = qSMS_SEND_PARAMETRS
      LookupKeyFields = 'PROVIDER_ID'
      LookupResultField = 'PROV_NAME'
      KeyFields = 'PROVIDER_ID'
      Lookup = True
    end
    object qMainBALANCE_USSD_TEXT: TStringField
      FieldName = 'BALANCE_USSD_TEXT'
      Size = 2000
    end
  end
  inherited DataSource1: TDataSource
    OnDataChange = DataSource1DataChange
    Left = 304
    Top = 65
  end
  inherited PopupMenu1: TPopupMenu
    Left = 256
    Top = 132
  end
  inherited ActionList1: TActionList
    Top = 132
  end
  inherited qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_ACCOUNT_ID'
    Left = 192
    Top = 65
    CommandStoredProcName = 'NEW_ACCOUNT_ID:0'
  end
  object qOperators: TOraQuery
    SQL.Strings = (
      'SELECT *'
      'FROM OPERATORS')
    Left = 192
    Top = 129
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
    BeforePost = qMainBeforePost
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
    Left = 938
    Top = 23
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PNEW_STATE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'CHANGE_ROBOT_ALL_ACCOUNTS'
  end
  object qFilials: TOraTable
    TableName = 'FILIALS'
    OrderFields = 'FILIAL_NAME'
    KeyFields = 'FILIAL_ID'
    Left = 392
    Top = 137
  end
  object qJobs: TOraQuery
    SQL.Strings = (
      'select '
      ' account_id, '
      ' case '
      '  when block=0 then '#39#1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1072'!!!'#39' '
      '  when block=1 then '#39#1042#1082#1083#1102#1095#1077#1085#1086' '#1074' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077#39' '
      '  when block=2 then '#39#1047#1072#1087#1091#1097#1077#1085#1086#39' '
      ' end block, '
      ' case '
      '  when unblock=0 then '#39#1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1072'!!!'#39' '
      '  when unblock=1 then '#39#1042#1082#1083#1102#1095#1077#1085#1086' '#1074' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077#39' '
      '  when unblock=2 then '#39#1047#1072#1087#1091#1097#1077#1085#1086#39' '
      ' end unblock, '
      ' case '
      '  when payments=0 then '#39#1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1072'!!!'#39' '
      '  when payments=1 then '#39#1042#1082#1083#1102#1095#1077#1085#1086' '#1074' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077#39' '
      '  when payments=2 then '#39#1047#1072#1087#1091#1097#1077#1085#1086#39' '
      ' end payments, '
      ' case '
      '  when phones=0 then '#39#1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1072'!!!'#39' '
      '  when phones=1 then '#39#1042#1082#1083#1102#1095#1077#1085#1086' '#1074' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077#39' '
      '  when phones=2 then '#39#1047#1072#1087#1091#1097#1077#1085#1086#39' '
      ' end phones '
      ' from '
      '(select * from '
      '(select'
      ' case '
      
        '  when substr(job_name,1,13)='#39'J_BLOCK_LOYAL'#39' then regexp_substr(' +
        'job_name,'#39'[^_]+'#39',1,5) '
      '  else regexp_substr(job_name,'#39'[^_]+'#39',1,4)  '
      '  end account_id,'
      ' case '
      
        '  when substr(job_name,1,13)='#39'J_BLOCK_LOYAL'#39' then regexp_substr(' +
        'job_name,'#39'[^_]+'#39',1,2) '
      
        '  when substr(job_name,1,14)='#39'J_BLOCK_CLIENT'#39' then regexp_substr' +
        '(job_name,'#39'[^_]+'#39',1,2) '
      
        '  when substr(job_name,1,16)='#39'J_UNBLOCK_CLIENT'#39' then regexp_subs' +
        'tr(job_name,'#39'[^_]+'#39',1,2)'
      '  else regexp_substr(job_name,'#39'[^_]+'#39',1,3) '
      ' end name,'
      ' STATE from DBA_SCHEDULER_JOBS'
      
        'where ((job_name like '#39'J_BLOCK%CLIENT%'#39' AND job_name not like '#39'J' +
        '_%LOCK%CLIENT%WITH%'#39' AND job_name not like '#39'J_BLOCK_FRAUD%'#39') OR ' +
        'job_name like '#39'J_UNBLOCK_CLIENT%'#39' OR job_name like '#39'J_LOAD_PAYME' +
        'NTS%'#39' OR job_name like '#39'J_LOAD_PHONES%'#39' and job_name not like '#39'%' +
        'J_LOAD_PHONES_COLLECT%'#39') AND OWNER=(select sys_context('#39'userenv'#39 +
        ','#39'CURRENT_SCHEMA'#39') from dual)'
      'and job_name not like '#39'J_BLOCK_LOYAL_CLIENT_STREAM%'#39') '
      'pivot '
      '('
      
        'max(decode(state, '#39'SCHEDULED'#39','#39'1'#39','#39'RUNNING'#39','#39'2'#39','#39'DISABLED'#39','#39'0'#39',0' +
        ')) '
      
        'for name IN ('#39'BLOCK'#39' BLOCK,'#39'UNBLOCK'#39' UNBLOCK, '#39'PAYMENTS'#39' PAYMENT' +
        'S,'#39'PHONES'#39' PHONES)'
      ')'
      ')'
      'where account_id= :paccount_id')
    MasterSource = DataSource1
    DetailFields = 'ACCOUNT_ID'
    Left = 528
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'paccount_id'
      end>
  end
  object dsJobs: TDataSource
    DataSet = qJobs
    OnStateChange = DataSource1StateChange
    Left = 568
    Top = 417
  end
  object spStartStopJob: TOraStoredProc
    Left = 376
    Top = 488
  end
  object osStartStopJob: TOraSQL
    SQL.Strings = (
      'begin'
      ':str := F_JOB_START_STOP(:ENB);'
      'end;')
    Left = 192
    Top = 496
    ParamData = <
      item
        DataType = ftString
        Name = 'str'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ENB'
        ParamType = ptInput
      end>
  end
  object qSMS_SENDER_NAME: TOraQuery
    SQL.Strings = (
      'Select * from SMS_SENDER_NAME')
    Left = 472
    Top = 72
  end
  object dsJob: TDataSource
    DataSet = qJob
    Left = 744
    Top = 560
  end
  object OraQuery1: TOraQuery
    Left = 272
    Top = 496
  end
  object qJob: TOraQuery
    SQL.Strings = (
      'select  JOB_NAME,'
      '   SACCOUNT_NUM,'
      '   STATE'
      '   from CLIENT_JOBS'
      '   order by 1,2')
    Left = 792
    Top = 560
    object qJobJOB_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'JOB_NAME'
      Size = 71
    end
    object qJobSACCOUNT_NUM: TStringField
      DisplayLabel = #8470' '#1089#1095#1077#1090#1072
      FieldName = 'SACCOUNT_NUM'
      Size = 40
    end
    object qJobSTATE: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      FieldName = 'STATE'
      Size = 15
    end
  end
  object qSMS_SEND_PARAMETRS: TOraQuery
    SQL.Strings = (
      'SELECT 0 PROVIDER_ID, '#39#39' PROV_NAME FROM DUAL'
      'UNION ALL'
      
        'SELECT T.PROVIDER_ID, T.PROVIDER_NAME||'#39'('#39'||T.SENDER_NAME||'#39')'#39' P' +
        'ROV_NAME'
      'FROM SMS_SEND_PARAMETRS T'
      'ORDER BY PROVIDER_ID')
    Left = 488
    Top = 136
  end
end
