object PayKeeperFrm: TPayKeeperFrm
  Left = 206
  Top = 77
  Caption = #1055#1083#1072#1090#1077#1078#1080' '#1087#1088#1080#1096#1077#1076#1096#1080#1077' '#1080#1079' PayKeeper'
  ClientHeight = 349
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object p1: TPanel
    Left = 0
    Top = 0
    Width = 776
    Height = 349
    Align = alClient
    TabOrder = 0
    object pFilter: TPanel
      Left = 1
      Top = 1
      Width = 774
      Height = 72
      Align = alTop
      TabOrder = 0
      object lbl1: TLabel
        Left = 24
        Top = 16
        Width = 61
        Height = 13
        Caption = #1053#1072#1095#1080#1085#1072#1103' '#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 68
        Top = 44
        Width = 17
        Height = 13
        Caption = #1087#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dtDateBegin: TDateTimePicker
        Left = 104
        Top = 13
        Width = 97
        Height = 21
        Date = 42194.000000000000000000
        Time = 42194.000000000000000000
        TabOrder = 0
      end
      object dtDateEnd: TDateTimePicker
        Left = 104
        Top = 40
        Width = 97
        Height = 21
        Date = 42194.000000000000000000
        Time = 42194.000000000000000000
        TabOrder = 1
      end
      object btRefresh: TBitBtn
        Left = 257
        Top = 9
        Width = 105
        Height = 29
        Action = aRefresh
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object btLoadInExcel: TBitBtn
        Left = 364
        Top = 9
        Width = 135
        Height = 29
        Action = aLoadInExcel
        Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object btShowUserStat: TBitBtn
        Left = 501
        Top = 9
        Width = 116
        Height = 29
        Action = aShowUSerStat
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
    end
    object pMain: TPanel
      Left = 1
      Top = 73
      Width = 774
      Height = 275
      Align = alClient
      TabOrder = 1
      object pgc1: TPageControl
        Left = 1
        Top = 1
        Width = 772
        Height = 273
        ActivePage = ts1
        Align = alClient
        Images = MainForm.ImageList24
        TabOrder = 0
        object ts1: TTabSheet
          Caption = #1055#1083#1072#1090#1077#1078#1080', '#1087#1088#1080#1096#1077#1076#1096#1080#1077' '#1080#1079' PayKeeper'
          ImageIndex = -1
          object gPayments: TCRDBGrid
            Left = 0
            Top = 0
            Width = 764
            Height = 236
            Align = alClient
            DataSource = dsPayments
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ACCOUNT_NUMBER'
                Title.Alignment = taCenter
                Width = 87
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PHONE_NUMBER'
                Title.Alignment = taCenter
                Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
                Width = 101
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAYMENT_SUM'
                Title.Alignment = taCenter
                Title.Caption = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1072
                Width = 111
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAYMENT_NUMBER'
                Title.Alignment = taCenter
                Title.Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1072' PayKeeper'
                Width = 152
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAYMENT_DATE'
                Title.Alignment = taCenter
                Title.Caption = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
                Width = 93
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAYMENT_STATUS_TEXT'
                Title.Alignment = taCenter
                Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080' '#1082' '#1087#1083#1072#1090#1077#1078#1091
                Width = 137
                Visible = True
              end>
          end
        end
        object ts2: TTabSheet
          Caption = #1051#1086#1075' POST '#1079#1072#1087#1088#1086#1089#1086#1074' PayKeeper '#1085#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
          ImageIndex = -1
          object gLog: TCRDBGrid
            Left = 0
            Top = 0
            Width = 764
            Height = 236
            Align = alClient
            DataSource = dsLog
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CLIENT_ID'
                Title.Caption = #1058#1077#1083#1077#1092#1086#1085
                Width = 85
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATE_CREATED'
                Title.Caption = #1044#1072#1090#1072' '#1079#1072#1087#1088#1086#1089#1072
                Width = 94
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAYKEEPER_ID'
                Title.Caption = #8470' '#1087#1083#1072#1090#1077#1078#1072' PayKeeper'
                Width = 122
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PAY_SUM'
                Title.Caption = #1057#1091#1084#1084#1072' '#1087#1083#1072#1090#1077#1078#1072
                Width = 86
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'KEY_HASH'
                Title.Caption = #1050#1083#1102#1095
                Width = 112
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ANSWER'
                Title.Caption = #1054#1090#1074#1077#1090' '#1058#1072#1088#1080#1092#1077#1088#1072
                Width = 114
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ORDER_ID'
                Title.Caption = #8470' '#1079#1072#1082#1072#1079#1072
                Width = 78
                Visible = True
              end>
          end
        end
      end
    end
  end
  object actlstList: TActionList
    Images = MainForm.ImageList24
    Left = 40
    Top = 152
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aLoadInExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aLoadInExcelExecute
    end
    object aShowUSerStat: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ImageIndex = 22
      OnExecute = aShowUSerStatExecute
    end
  end
  object qPayments: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '       DP.ACCOUNT_ID, '
      '       DP.CONTRACT_ID, '
      '       DP.DATE_CREATED, '
      '       DP.PAYMENT_DATE, '
      '       DP.PAYMENT_NUMBER, '
      '       DP.PAYMENT_STATUS_IS_VALID, '
      '       DP.PAYMENT_STATUS_TEXT, '
      '       DP.PAYMENT_SUM, '
      '       DP.PHONE_NUMBER, '
      '       DP.YEAR_MONTH,'
      '       acc.account_number'
      '  FROM DB_LOADER_PAYMENTS DP,'
      '       accounts acc        '
      ' WHERE DP.PAYMENT_STATUS_TEXT LIKE '#39'GSM PayKeeper'#39
      '   and DP.PAYMENT_DATE >= :pDateBegin'
      '   and DP.PAYMENT_DATE <= :pDateEnd'
      '   and DP.ACCOUNT_ID = acc.account_id')
    Left = 136
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pDateBegin'
      end
      item
        DataType = ftUnknown
        Name = 'pDateEnd'
      end>
    object qPaymentsACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
    end
    object qPaymentsCONTRACT_ID: TFloatField
      FieldName = 'CONTRACT_ID'
    end
    object qPaymentsDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qPaymentsPAYMENT_DATE: TDateTimeField
      FieldName = 'PAYMENT_DATE'
    end
    object qPaymentsPAYMENT_NUMBER: TStringField
      FieldName = 'PAYMENT_NUMBER'
      Size = 120
    end
    object qPaymentsPAYMENT_STATUS_IS_VALID: TIntegerField
      FieldName = 'PAYMENT_STATUS_IS_VALID'
    end
    object qPaymentsPAYMENT_STATUS_TEXT: TStringField
      FieldName = 'PAYMENT_STATUS_TEXT'
      Size = 800
    end
    object qPaymentsPAYMENT_SUM: TFloatField
      FieldName = 'PAYMENT_SUM'
    end
    object qPaymentsPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qPaymentsYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qPaymentsACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
      FieldName = 'ACCOUNT_NUMBER'
    end
  end
  object qLog: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      '      PL.CLIENT_ID, '
      '      PL.PAYKEEPER_ID, '
      '      PL.PAYKEEPER_PAYMENT_ID, '
      '      PL.ANSWER, '
      '      PL.DATE_CREATED, '
      '      PL.KEY_HASH, '
      '      PL.ORDER_ID, '
      '      PL.PAY_SUM, '
      '      PL.PAYKEEPER_PAYMENT_ID            '
      'from PAYKEEPER_PAYMENT_LOG pl'
      'where trunc(PL.DATE_CREATED) >= :pDateBegin'
      '  and trunc(PL.DATE_CREATED) <= :pDateEnd')
    Left = 312
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pDateBegin'
      end
      item
        DataType = ftUnknown
        Name = 'pDateEnd'
      end>
  end
  object dsPayments: TDataSource
    DataSet = qPayments
    Left = 200
    Top = 160
  end
  object dsLog: TDataSource
    DataSet = qLog
    Left = 360
    Top = 160
  end
end
