object ReportBillViolsForm: TReportBillViolsForm
  Left = 0
  Top = 0
  Caption = #1053#1072#1088#1091#1096#1077#1085#1080#1103' '#1074' '#1057#1095#1077#1090#1072#1093' '#1080' '#1054#1090#1095#1077#1090#1077' '#1086' '#1090#1077#1082' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103#1093
  ClientHeight = 457
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 832
    Height = 28
    Align = alTop
    TabOrder = 0
    object lPeriod: TLabel
      Left = 242
      Top = 8
      Width = 49
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lAccount: TLabel
      Left = 8
      Top = 8
      Width = 28
      Height = 13
      Caption = #1051'/C:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btLoadInExcel: TBitBtn
      Left = 390
      Top = 0
      Width = 121
      Height = 28
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btRefresh: TBitBtn
      Left = 511
      Top = 0
      Width = 83
      Height = 28
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btInfoAbonent: TBitBtn
      Left = 594
      Top = 0
      Width = 81
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object cbPeriod: TComboBox
      Left = 287
      Top = 4
      Width = 98
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 3
      OnChange = cbPeriodChange
    end
    object cbSearch: TCheckBox
      Left = 681
      Top = 5
      Width = 59
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cbSearchClick
    end
    object cbAccounts: TComboBox
      Left = 33
      Top = 4
      Width = 203
      Height = 20
      Style = csDropDownList
      DropDownCount = 50
      TabOrder = 5
      OnChange = cbAccountsChange
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 28
    Width = 832
    Height = 429
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1077#1085#1091#1083'. '#1089#1095#1077#1090#1072' '#1087#1086' '#1073#1083'. '#1085#1086#1084#1077#1088#1072#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnShow = TabSheet1Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object BillViolGrid: TCRDBGrid
        Left = 0
        Top = 0
        Width = 824
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsBillViolBl
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
      end
    end
    object TabSheet2: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1095#1077#1090#1072' '#1074#1085#1077' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ImageIndex = 1
      ParentFont = False
      object BillViolNoContrGrid: TCRDBGrid
        Left = 0
        Top = 0
        Width = 824
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsBillViolNoContr
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
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BILL_SUM'
            Title.Alignment = taCenter
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ABONKA'
            Title.Alignment = taCenter
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS'
            Title.Alignment = taCenter
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SINGLE_PAYMENTS'
            Title.Alignment = taCenter
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DISCOUNTS'
            Title.Alignment = taCenter
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACCOUNT_NUMBER'
            Title.Alignment = taCenter
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DOP_STATUS_NAME'
            Title.Alignment = taCenter
            Width = 184
            Visible = True
          end>
      end
    end
    object TabSheet3: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1090#1095#1077#1090' '#1086' '#1090#1077#1082' '#1085#1072#1095#1080#1089#1083
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ReportDataGrid: TCRDBGrid
        Left = 0
        Top = 0
        Width = 824
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsReportData
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -10
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tsCallInSave: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1047#1074#1086#1085#1082#1080' '#1074' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 223
        Top = 0
        Width = 2
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 223
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'Panel2'
        TabOrder = 0
        object GridCIS: TCRDBGrid
          Left = 1
          Top = 1
          Width = 221
          Height = 400
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          DataSource = dsCallInSave
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
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
      end
      object Panel3: TPanel
        Left = 225
        Top = 0
        Width = 599
        Height = 402
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 1
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 597
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          TabOrder = 0
          object btCISSave: TBitBtn
            Left = 107
            Top = 6
            Width = 135
            Height = 19
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1079#1074#1086#1085#1082#1080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = btCISSaveClick
          end
          object cbCISDetailFilter: TCheckBox
            Left = 252
            Top = 9
            Width = 61
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1060#1080#1083#1100#1090#1088
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = cbCISDetailFilterClick
          end
          object btCISDetailRefresh: TBitBtn
            Left = 4
            Top = 6
            Width = 99
            Height = 19
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1053#1072#1081#1090#1080' '#1079#1074#1086#1085#1082#1080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = btCISDetailRefreshClick
          end
        end
        object GridCISDetalis: TCRDBGrid
          Left = 1
          Top = 32
          Width = 597
          Height = 369
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          DataSource = dsCISDetals
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
        end
      end
    end
  end
  object alBillViols: TActionList
    Images = MainForm.ImageList24
    Left = 40
    Top = 128
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, '
      '       LOGIN||'#39': '#39'||COMPANY_NAME LOGIN'
      '  FROM ACCOUNTS '
      '  ORDER BY LOGIN ASC')
    Left = 216
    Top = 80
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM DB_LOADER_ACCOUNT_PHONES'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    Left = 216
    Top = 128
  end
  object qBillViolBl: TOraQuery
    SQL.Strings = (
      'select v1.*, '
      '       v2.option_code option_code_PERIOD, '
      '       v4.option_code option_code_NOW,'
      '       v3.OPTION_NAME, '
      '       v3.TURN_ON_DATE,'
      '       v3.TURN_OFF_DATE    '
      'from '
      '    V_BILLS_VIOL_NO_ACTIV_ALL V1,'
      '    (select OPT.ACCOUNT_ID, '
      '            OPT.phone_number, '
      
        '            listagg(option_code,'#39', '#39') WITHIN GROUP (ORDER BY opt' +
        'ion_code) option_code '
      '       from DB_LOADER_ACCOUNT_PHONE_OPTS OPT '
      '      where YEAR_MONTH=:YEAR_MONTH '
      '        AND OPT.OPTION_CODE IN (select option_code '
      '                                  from TARIFF_OPTIONS TOP '
      '                                 where TOP.DISCR_SPISANIE=1) '
      '      GROUP BY OPT.ACCOUNT_ID, phone_number) V2,'
      '    (select OPT.ACCOUNT_ID, '
      '            OPT.phone_number, '
      
        '            listagg(option_code,'#39', '#39') WITHIN GROUP (ORDER BY opt' +
        'ion_code) option_code '
      '       from DB_LOADER_ACCOUNT_PHONE_OPTS OPT '
      
        '      where YEAR_MONTH=(SELECT MAX(year_month) FROM DB_LOADER_AC' +
        'COUNT_PHONE_OPTS'
      '                        WHERE phone_number = opt.phone_number)'
      '        AND OPT.OPTION_CODE IN (select option_code '
      '                                  from TARIFF_OPTIONS TOP '
      '                                 where TOP.DISCR_SPISANIE=1) '
      '      GROUP BY OPT.ACCOUNT_ID, phone_number) V4,      '
      '     (SELECT T.ACCOUNT_ID, '
      '             T.PHONE_NUMBER, '
      '             T.OPTION_NAME,'
      '             MAX(T.TURN_ON_DATE) TURN_ON_DATE, '
      '             T.TURN_OFF_DATE'
      '        FROM DB_LOADER_ACCOUNT_PHONE_OPTS T'
      '       WHERE T.OPTION_CODE IN ('#39'RCRBTN'#39', '
      '                               '#39'RRBTPRPOS'#39', '
      '                               '#39'RCRBT1'#39', '
      '                               '#39'R01CRBTN'#39', '
      '                               '#39'RCRBTNC'#39')'
      '         AND T.YEAR_MONTH=:YEAR_MONTH'
      
        '       GROUP BY T.ACCOUNT_ID, T.PHONE_NUMBER, T.OPTION_NAME, T.T' +
        'URN_OFF_DATE) v3'
      '  WHERE YEAR_MONTH=:YEAR_MONTH'
      '      AND V1.PHONE_NUMBER =V2.PHONE_NUMBER(+)'
      '      AND V1.ACCOUNT_ID=V2.ACCOUNT_ID(+)'
      '      AND V1.PHONE_NUMBER =V3.PHONE_NUMBER(+)'
      '      AND V1.ACCOUNT_ID=V3.ACCOUNT_ID(+)'
      '      AND V1.PHONE_NUMBER =V4.PHONE_NUMBER(+)'
      '      AND V1.ACCOUNT_ID=V4.ACCOUNT_ID(+)'
      '      AND ((:ACCOUNT_ID IS NULL)OR(V1.ACCOUNT_ID=:ACCOUNT_ID))')
    FetchRows = 500
    Left = 56
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qBillViolBlPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 30
      FieldName = 'PHONE_NUMBER'
      Size = 30
    end
    object qBillViolBlBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BILL_SUM'
    end
    object qBillViolBlABONKA: TFloatField
      DisplayLabel = #1040#1073#1086#1085' '#1087#1083#1072#1090#1072
      FieldName = 'ABONKA'
    end
    object qBillViolBlCALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080
      FieldName = 'CALLS'
    end
    object qBillViolBlSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079#1086#1074#1099#1077' '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
    end
    object qBillViolBlDISCOUNTS: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      FieldName = 'DISCOUNTS'
    end
    object qBillViolBlaccount_number: TFloatField
      DisplayLabel = #1051'/'#1057
      DisplayWidth = 10
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qBillViolBlOPTION_CODE_PERIOD: TStringField
      DisplayLabel = #1050#1086#1076' '#1076#1080#1089#1082#1088'. '#1086#1087#1094#1080#1080' '#1074' '#1087#1077#1088#1080#1086#1076#1077
      DisplayWidth = 25
      FieldName = 'OPTION_CODE_PERIOD'
      Size = 300
    end
    object qBillViolBlOPTION_CODE_NOW: TStringField
      DisplayLabel = #1050#1086#1076' '#1076#1080#1089#1082#1088'. '#1086#1087#1094#1080#1080' '#1089#1077#1081#1095#1072#1089
      DisplayWidth = 25
      FieldName = 'OPTION_CODE_NOW'
      Size = 300
    end
    object qBillViolBlOPTION_NAME: TStringField
      DisplayLabel = #1059#1089#1083#1091#1075#1072
      DisplayWidth = 40
      FieldName = 'OPTION_NAME'
      Size = 200
    end
    object qBillViolBlTURN_ON_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      FieldName = 'TURN_ON_DATE'
    end
    object qBillViolBlTURN_OFF_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      FieldName = 'TURN_OFF_DATE'
    end
  end
  object dsBillViolBl: TDataSource
    DataSet = qBillViolBl
    Left = 88
    Top = 192
  end
  object qBillViolNoContr: TOraQuery
    SQL.Strings = (
      'SELECT V.*, '
      '            ('
      '                SELECT DOP.DOP_STATUS_NAME'
      '                FROM V_CONTRACTS C'
      
        '                LEFT JOIN CONTRACT_DOP_STATUSES DOP ON C.DOP_STA' +
        'TUS = DOP.DOP_STATUS_ID'
      '                WHERE C.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER'
      
        '                AND NVL(C.CONTRACT_CANCEL_DATE, to_date('#39'01.01.3' +
        '000'#39', '#39'DD.MM.YYYY'#39')) = ('
      
        '                                                                ' +
        '                          SELECT MAX(NVL(VC.CONTRACT_CANCEL_DATE' +
        ', to_date('#39'01.01.3000'#39', '#39'DD.MM.YYYY'#39')))'
      
        '                                                                ' +
        '                          FROM V_CONTRACTS VC'
      
        '                                                                ' +
        '                          WHERE VC.PHONE_NUMBER_FEDERAL = C.PHON' +
        'E_NUMBER_FEDERAL'
      
        '                                                                ' +
        '                       )'
      '            ) DOP_STATUS_NAME'
      '  FROM V_BILLS_VIOL_NO_CONTRACT V'
      'WHERE YEAR_MONTH=:YEAR_MONTH'
      '    AND ((:ACCOUNT_ID IS NULL)OR(ACCOUNT_ID=:ACCOUNT_ID))'
      'ORDER BY PHONE_NUMBER')
    Left = 64
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qBillViolNoContrPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 30
      FieldName = 'PHONE_NUMBER'
      Size = 30
    end
    object qBillViolNoContrBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'BILL_SUM'
    end
    object qBillViolNoContrABONKA: TFloatField
      DisplayLabel = #1040#1073#1086#1085' '#1087#1083#1072#1090#1072
      FieldName = 'ABONKA'
    end
    object qBillViolNoContrCALLS: TFloatField
      DisplayLabel = #1047#1074#1086#1085#1082#1080
      FieldName = 'CALLS'
    end
    object qBillViolNoContrSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079#1086#1074#1099#1077' '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
    end
    object qBillViolNoContrDISCOUNTS: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1080
      FieldName = 'DISCOUNTS'
    end
    object qBillViolNoContrACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1051'/'#1057
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qBillViolNoContrDOP_STATUS_NAME: TStringField
      DisplayLabel = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089
      FieldName = 'DOP_STATUS_NAME'
      Size = 30
    end
  end
  object dsBillViolNoContr: TDataSource
    DataSet = qBillViolNoContr
    Left = 136
    Top = 256
  end
  object qReportData: TOraQuery
    SQL.Strings = (
      'SELECT v1.*, V2.option_code'
      '  FROM V_BILLS_VIOL_REPORT_DATA V1,'
      '        (select OPT.ACCOUNT_ID, OPT.phone_number, '
      
        '        listagg(option_code,'#39', '#39') WITHIN GROUP (ORDER BY option_' +
        'code) option_code '
      '     from DB_LOADER_ACCOUNT_PHONE_OPTS OPT '
      '     where YEAR_MONTH=to_char(sysdate, '#39'YYYYMM'#39') '
      '     AND OPT.OPTION_CODE IN '
      '                        (select option_code '
      '                            from TARIFF_OPTIONS TOP '
      '                            where TOP.DISCR_SPISANIE=1) '
      '     GROUP BY OPT.ACCOUNT_ID, phone_number) V2'
      ' where V1.PHONE_NUMBER =V2.PHONE_NUMBER(+)')
    Left = 64
    Top = 320
    object qReportDataPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 80
    end
    object qReportDataDETAIL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      FieldName = 'DETAIL_SUM'
      Required = True
    end
    object qReportDataACCOUNT_NUMBER: TFloatField
      DisplayLabel = #1051'/'#1057
      FieldName = 'ACCOUNT_NUMBER'
      Required = True
    end
    object qReportDataOPTION_CODE: TStringField
      DisplayLabel = #1050#1086#1076' '#1076#1080#1089#1082#1088'. '#1086#1087#1094#1080#1080
      FieldName = 'OPTION_CODE'
      Size = 4000
    end
  end
  object dsReportData: TDataSource
    DataSet = qReportData
    Left = 96
    Top = 328
  end
  object qCallInSave: TOraQuery
    SQL.Strings = (
      'SELECT AP.ACCOUNT_ID,'
      '       AP.YEAR_MONTH,'
      '       AP.PHONE_NUMBER,'
      '       (SELECT PS.ESTIMATE_SUM'
      '          FROM DB_LOADER_PHONE_STAT PS'
      
        '          WHERE PS.ACCOUNT_ID = AP.ACCOUNT_ID AND PS.YEAR_MONTH ' +
        '= AP.YEAR_MONTH'
      '            AND PS.PHONE_NUMBER = AP.PHONE_NUMBER) DETAIL_SUM,'
      '       (SELECT SUM(FB.BILL_SUM)'
      '          FROM DB_LOADER_FULL_FINANCE_BILL FB'
      
        '          WHERE FB.ACCOUNT_ID = AP.ACCOUNT_ID AND FB.YEAR_MONTH ' +
        '= AP.YEAR_MONTH'
      
        '            AND FB.PHONE_NUMBER = AP.PHONE_NUMBER AND FB.COMPLET' +
        'E_BILL = 1) BILL_SUM,'
      
        '       (SELECT TO_CHAR(SUM(FB.ABON_MAIN))||'#39'/'#39'||TO_CHAR(SUM(FB.S' +
        'INGLE_MAIN))'
      '          FROM DB_LOADER_FULL_FINANCE_BILL FB'
      
        '          WHERE FB.ACCOUNT_ID = AP.ACCOUNT_ID AND FB.YEAR_MONTH ' +
        '= AP.YEAR_MONTH'
      
        '            AND FB.PHONE_NUMBER = AP.PHONE_NUMBER AND FB.COMPLET' +
        'E_BILL = 1) ABON_TP,'
      '       (SELECT LOGIN'
      '          FROM ACCOUNTS FB'
      
        '          WHERE FB.ACCOUNT_ID = AP.ACCOUNT_ID AND ROWNUM <= 1) L' +
        'OGIN'
      '  FROM V_BILLS_VIOL_COST_IN_BLOCK AP'
      '  WHERE AP.YEAR_MONTH = :YEAR_MONTH'
      '    AND (:ACCOUNT_ID IS NULL OR :ACCOUNT_ID = AP.ACCOUNT_ID)'
      '    AND EXISTS (SELECT 1'
      '                  FROM CALL_06_2013 HB'
      '                  WHERE HB.SUBSCR_NO = AP.PHONE_NUMBER)')
    FetchRows = 250
    FetchAll = True
    Left = 248
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qCallInSaveLOGIN: TStringField
      DisplayLabel = #1051#1086#1075#1080#1085
      DisplayWidth = 14
      FieldName = 'LOGIN'
      Size = 14
    end
    object qCallInSavePHONE_NUMBER: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qCallInSaveDETAIL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'DETAIL_SUM'
    end
    object qCallInSaveBILL_SUM: TFloatField
      DisplayLabel = #1057#1095#1077#1090
      FieldName = 'BILL_SUM'
    end
    object qCallInSaveABON_TP: TStringField
      Alignment = taCenter
      DisplayLabel = #1040#1073#1086#1085' '#1087#1083'/'#1042#1086#1079#1074#1088#1072#1090
      DisplayWidth = 17
      FieldName = 'ABON_TP'
      Size = 112
    end
  end
  object dsCallInSave: TDataSource
    DataSet = qCallInSave
    Left = 280
    Top = 232
  end
  object qCISDetals: TOraQuery
    SQL.Strings = (
      'SELECT HB.SUBSCR_NO,'
      '       HB.CALL_COST,'
      '       HB.AT_FT_DE,'
      '       NVL(HB.DIALED_DIG, HB.CALLING_NO) DIALED_DIG,'
      '       COUNT(1) CNT'
      '  FROM CALL_06_2013 HB'
      '  WHERE HB.SUBSCR_NO IN (SELECT AP.PHONE_NUMBER'
      '                           FROM V_BILLS_VIOL_COST_IN_BLOCK AP'
      '                           WHERE AP.YEAR_MONTH = :YEAR_MONTH'
      '                             AND (:ACCOUNT_ID IS NULL '
      
        '                                   OR :ACCOUNT_ID = AP.ACCOUNT_I' +
        'D)) '
      
        '  GROUP BY HB.SUBSCR_NO , HB.CALL_COST , HB.AT_FT_DE, NVL(HB.DIA' +
        'LED_DIG, HB.CALLING_NO)'
      '  ORDER BY HB.AT_FT_DE DESC, HB.CALL_COST DESC')
    FetchRows = 250
    FetchAll = True
    Left = 424
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end
      item
        DataType = ftUnknown
        Name = 'ACCOUNT_ID'
      end>
    object qCISDetalsSUBSCR_NO: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 12
      FieldName = 'SUBSCR_NO'
      Size = 11
    end
    object qCISDetalsCALL_COST: TFloatField
      DisplayLabel = #1062#1077#1085#1072' '#1079#1074#1086#1085#1082#1072
      FieldName = 'CALL_COST'
    end
    object qCISDetalsAT_FT_DE: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      DisplayWidth = 30
      FieldName = 'AT_FT_DE'
      Size = 240
    end
    object qCISDetalsDIALED_DIG: TStringField
      DisplayLabel = #1057#1086#1073#1077#1089#1077#1076#1085#1080#1082
      DisplayWidth = 12
      FieldName = 'DIALED_DIG'
      Size = 21
    end
    object qCISDetalsCNT: TFloatField
      DisplayLabel = #1050#1086#1083'-'#1074#1086' '#1079#1074#1086#1085#1082#1086#1074
      FieldName = 'CNT'
    end
  end
  object dsCISDetals: TDataSource
    DataSet = qCISDetals
    Left = 456
    Top = 344
  end
end
