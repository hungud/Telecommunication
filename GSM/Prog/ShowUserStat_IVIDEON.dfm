object ShowUserIvideonForm: TShowUserIvideonForm
  Left = 0
  Top = 0
  Caption = #1048#1085#1092'. '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
  ClientHeight = 284
  ClientWidth = 785
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 785
    Height = 284
    ActivePage = tsTariffs
    Align = alClient
    TabOrder = 0
    object tsTariffs: TTabSheet
      Caption = #1058#1072#1088#1080#1092' '#1080' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
      ImageIndex = 2
      object Panel8: TPanel
        Left = 0
        Top = 65
        Width = 777
        Height = 191
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel8'
        TabOrder = 0
        object gPhoneStatuses: TCRDBGrid
          Left = 0
          Top = 0
          Width = 777
          Height = 191
          OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
          Align = alClient
          DataSource = dsAbonentStatus
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          Columns = <
            item
              Expanded = False
              FieldName = 'DATE_CREATED'
              Title.Caption = #1053#1072#1095#1072#1083#1086
              Width = 120
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ACTION_NAME'
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 113
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TARIFF_NAME'
              Title.Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085
              Width = 193
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATE_LAST_UPDATED'
              Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
              Width = 181
              Visible = True
            end>
        end
      end
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 777
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 383
          Height = 65
          Align = alClient
          BevelOuter = bvSpace
          TabOrder = 0
          object Label13: TLabel
            Left = 54
            Top = 38
            Width = 127
            Height = 18
            Alignment = taRightJustify
            Caption = #1058#1072#1088#1080#1092#1085#1099#1081' '#1087#1083#1072#1085':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object DBText13: TDBText
            Left = 200
            Top = 38
            Width = 79
            Height = 18
            AutoSize = True
            DataField = 'TARIFF_NAME'
            DataSource = dsTariffInfo_IV
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object LblState: TLabel
            Left = 55
            Top = 10
            Width = 129
            Height = 18
            Alignment = taRightJustify
            Caption = #1057#1090#1072#1090#1091#1089' '#1090#1072#1088#1080#1092#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = [fsBold, fsItalic, fsUnderline]
            ParentFont = False
          end
          object lTariffStatusText: TLabel
            Left = 200
            Top = 9
            Width = 70
            Height = 23
            Caption = #1057#1090#1072#1090#1091#1089
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel14: TPanel
          Left = 383
          Top = 0
          Width = 394
          Height = 65
          Align = alRight
          Alignment = taRightJustify
          BevelOuter = bvNone
          TabOrder = 1
          object Panel19: TPanel
            Left = 0
            Top = 0
            Width = 240
            Height = 65
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object pBalanceInfo: TPanel
              Left = 0
              Top = 0
              Width = 240
              Height = 129
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              BevelOuter = bvSpace
              TabOrder = 0
              object lBalance: TLabel
                Left = 142
                Top = 4
                Width = 78
                Height = 23
                Alignment = taRightJustify
                Caption = #1041#1072#1083#1072#1085#1089
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'Verdana'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object LblBalance: TLabel
                Left = 22
                Top = 8
                Width = 67
                Height = 18
                Hint = #1048#1089#1090#1086#1088#1080#1103' '#1073#1072#1083#1072#1085#1089#1086#1074' '#1089' '#1090#1080#1087#1072#1084#1080' '#1087#1086' '#1087#1088#1072#1074#1086#1081' '#1082#1085#1086#1087#1082#1077' '#1084#1099#1096#1080
                Alignment = taRightJustify
                Caption = #1041#1072#1083#1072#1085#1089':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Verdana'
                Font.Style = [fsBold, fsItalic, fsUnderline]
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                OnClick = LblBalanceClick
                OnMouseEnter = LblBlueOn
                OnMouseLeave = LblBlueOff
              end
            end
          end
          object pTariffInfoButton: TPanel
            Left = 240
            Top = 0
            Width = 154
            Height = 65
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alRight
            BevelOuter = bvSpace
            TabOrder = 1
            object BtUnBlock: TButton
              Left = 5
              Top = 28
              Width = 146
              Height = 25
              Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1072#1090#1100
              TabOrder = 0
              Visible = False
            end
            object UnBlockListBt: TButton
              Left = 5
              Top = 1
              Width = 146
              Height = 25
              Caption = #1057#1087#1080#1089#1086#1082' '#1073#1083#1086#1082#1072'/'#1088#1072#1079#1073#1083#1086#1082#1072
              TabOrder = 1
              OnClick = UnBlockListBtClick
            end
          end
        end
      end
    end
    object tsPayments: TTabSheet
      Caption = #1055#1083#1072#1090#1077#1078#1080
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 777
        Height = 256
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ActivePage = tsPaymentsReal
        Align = alClient
        TabOrder = 0
        object tsPaymentsReal: TTabSheet
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1083#1072#1090#1077#1078#1080' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 769
            Height = 228
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object gPayments: TCRDBGrid
              Left = 0
              Top = 0
              Width = 769
              Height = 228
              OptionsEx = [dgeEnableSort, dgeLocalFilter, dgeLocalSorting]
              Align = alClient
              DataSource = dsPayment
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'PAYMENT_DATE'
                  Title.Alignment = taCenter
                  Title.Caption = #1044#1072#1090#1072
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = [fsBold]
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PAYMENT_SUM'
                  Title.Alignment = taCenter
                  Title.Caption = #1057#1091#1084#1084#1072
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = [fsBold]
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PAYKEEPER_PAYMENT_ID'
                  Title.Alignment = taCenter
                  Title.Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = [fsBold]
                  Width = 165
                  Visible = True
                end
                item
                  ButtonStyle = cbsEllipsis
                  Expanded = False
                  FieldName = 'DATE_CREATED'
                  Title.Alignment = taCenter
                  Title.Caption = #1042#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1074' '#1058#1072#1088#1080#1092#1077#1088
                  Title.Font.Charset = DEFAULT_CHARSET
                  Title.Font.Color = clWindowText
                  Title.Font.Height = -11
                  Title.Font.Name = 'MS Sans Serif'
                  Title.Font.Style = [fsBold]
                  Width = 203
                  Visible = True
                end>
            end
            object MonthCalendar1: TMonthCalendar
              Left = 128
              Top = 64
              Width = 191
              Height = 160
              Date = 41584.720466192130000000
              TabOrder = 1
              TabStop = True
              Visible = False
            end
          end
        end
      end
    end
  end
  object dsAbonentStatus: TDataSource
    DataSet = qAbonentStatus
    Left = 140
    Top = 145
  end
  object qAbonentStatus: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  TH.DATE_CREATED,'
      '  ACTION_TYPE.ACTION_NAME,'
      '  TARIFFS.TARIFF_NAME,'
      '  TH.DATE_LAST_UPDATED'
      'FROM'
      '  IVIDEON.TARIFF_ON_OFF_HISTORY TH,'
      '  IVIDEON.TARIFFS,'
      '  IVIDEON.ACTION_TYPE'
      'WHERE'
      '  TH.ABONENT_ID = :ABONENT_ID'
      '  AND TARIFFS.TARIFF_ID(+)= TH.TARIFF_ID'
      '  AND ACTION_TYPE.ACTION_TYPE_ID = TH.ACTION_TYPE_ID'
      'ORDER BY'
      '  TH.DATE_LAST_UPDATED DESC')
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 64
    Top = 145
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ABONENT_ID'
      end>
  end
  object dsAbonentInfo: TDataSource
    DataSet = qAbonentInfo
    Left = 288
    Top = 144
  end
  object qAbonentInfo: TOraQuery
    SQLRefresh.Strings = (
      'SELECT '
      '  ABONENT_ID,'
      '  FIO,'
      '  E_MAIL,'
      '  IVIDEON_USER_ID,'
      '  USER_CREATED,'
      '  DATE_CREATED,'
      '  USER_LAST_UPDATED,'
      '  DATE_LAST_UPDATED,'
      '  PASSWORD,'
      '  IVIDEON_PASSWORD'
      'FROM '
      '  IVIDEON_ABONENTS'
      'WHERE'
      '  E_MAIL = :ABONENT')
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '  ABONENT_ID,'
      '  FIO,'
      '  E_MAIL,'
      '  IVIDEON_USER_ID,'
      '  USER_CREATED,'
      '  DATE_CREATED,'
      '  USER_LAST_UPDATED,'
      '  DATE_LAST_UPDATED,'
      '  PASSWORD,'
      '  IVIDEON_PASSWORD'
      'FROM '
      '  IVIDEON.IVIDEON_ABONENTS'
      'WHERE'
      '  ABONENT_ID = :ABONENT_ID')
    Left = 224
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ABONENT_ID'
      end>
  end
  object dsTariffInfo_IV: TDataSource
    DataSet = qTariffInfo_IV
    Left = 284
    Top = 201
  end
  object qTariffInfo_IV: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  TH.TARIFF_ID,'
      '  TH.ACTION_TYPE_ID,'
      '  ACT.ACTION_NAME,'
      '  TH.ABONENT_ID,'
      '  TARIFFS.TARIFF_NAME,'
      '  NVL(AB.BALANCE, 0) BALANCE'
      'FROM'
      '  IVIDEON.TARIFF_ON_OFF_HISTORY TH,'
      '  IVIDEON.ACTION_TYPE ACT,'
      '  IVIDEON.TARIFFS,'
      '  IVIDEON.ABONENT_BALANCE AB'
      'WHERE'
      '  TH.ABONENT_ID = :ABONENT_ID'
      '  AND TH.ACTION_TYPE_ID = ACT.ACTION_TYPE_ID'
      '  AND TARIFFS.TARIFF_ID = TH.TARIFF_ID'
      '  AND AB.ABONENT_ID = TH.ABONENT_ID'
      
        '  AND TH.DATE_LAST_UPDATED = (SELECT MAX(D.DATE_LAST_UPDATED) FR' +
        'OM IVIDEON.TARIFF_ON_OFF_HISTORY D WHERE D.ABONENT_ID = TH.ABONE' +
        'NT_ID)')
    DetailFields = '.'
    ReadOnly = True
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 200
    Top = 201
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ABONENT_ID'
      end>
  end
  object dsPayment: TDataSource
    DataSet = qPayment
    Left = 136
    Top = 200
  end
  object qPayment: TOraQuery
    SQLRefresh.Strings = (
      'SELECT '
      '  ABONENT_ID,'
      '  FIO,'
      '  E_MAIL,'
      '  IVIDEON_USER_ID,'
      '  USER_CREATED,'
      '  DATE_CREATED,'
      '  USER_LAST_UPDATED,'
      '  DATE_LAST_UPDATED,'
      '  PASSWORD,'
      '  IVIDEON_PASSWORD'
      'FROM '
      '  IVIDEON_ABONENTS'
      'WHERE'
      '  E_MAIL = :ABONENT')
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '  ABONENT_ID,'
      '  PAYMENT_SUM,'
      '  PAYMENT_DATE,'
      '  PAYKEEPER_PAYMENT_ID,'
      '  DATE_CREATED '
      'FROM '
      '  IVIDEON.PAYMENT_HISTORY'
      'WHERE'
      '  ABONENT_ID = :ABONENT_ID')
    Left = 56
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ABONENT_ID'
      end>
  end
  object qBalance: TOraQuery
    SQLRefresh.Strings = (
      'SELECT '
      '  ABONENT_ID,'
      '  FIO,'
      '  E_MAIL,'
      '  IVIDEON_USER_ID,'
      '  USER_CREATED,'
      '  DATE_CREATED,'
      '  USER_LAST_UPDATED,'
      '  DATE_LAST_UPDATED,'
      '  PASSWORD,'
      '  IVIDEON_PASSWORD'
      'FROM '
      '  IVIDEON_ABONENTS'
      'WHERE'
      '  E_MAIL = :ABONENT')
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT'
      '  NVL(AB.BALANCE, 0) BALANCE'
      'FROM'
      ''
      '  IVIDEON.ABONENT_BALANCE AB'
      'WHERE'
      '  AB.ABONENT_ID = :ABONENT_ID')
    Left = 368
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ABONENT_ID'
      end>
  end
end
