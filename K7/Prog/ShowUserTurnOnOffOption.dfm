object ShowUserTurnOnOffOptionForm: TShowUserTurnOnOffOptionForm
  Left = 0
  Top = 0
  Caption = 'ShowUserTurnOnOffOptionForm'
  ClientHeight = 520
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object pSpisok: TPanel
    Left = 0
    Top = 0
    Width = 546
    Height = 368
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 501
    object lbSpisok: TListBox
      Left = 1
      Top = 25
      Width = 544
      Height = 342
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      ItemHeight = 12
      Items.Strings = (
        'lxjgfh'
        'slkjl;zgsf')
      TabOrder = 0
      OnClick = lbSpisokClick
      ExplicitWidth = 499
    end
    object pAdmin: TPanel
      Left = 1
      Top = 1
      Width = 544
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 499
      object lSearch: TLabel
        Left = 176
        Top = 5
        Width = 37
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taRightJustify
        Caption = #1055#1086#1080#1089#1082':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbAdmin: TCheckBox
        Left = 5
        Top = 5
        Width = 124
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = cbAdminClick
      end
      object eSearch: TEdit
        Left = 217
        Top = 2
        Width = 140
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnChange = eSearchChange
      end
      object cbRecommended: TCheckBox
        Left = 362
        Top = 2
        Width = 159
        Height = 17
        Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1099#1077' '#1086#1087#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnClick = cbAdminClick
      end
    end
  end
  object pTurn: TPanel
    Left = 0
    Top = 368
    Width = 546
    Height = 152
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 501
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 544
      Height = 150
      ActivePage = tsBeeline
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 499
      object tsBeeline: TTabSheet
        Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1077#1085#1080#1077' '#1095#1077#1088#1077#1079' '#1041#1080#1083#1072#1081#1085
        ExplicitWidth = 491
        object Label3: TLabel
          Left = 53
          Top = 4
          Width = 105
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1086#1087#1077#1088#1072#1094#1080#1080':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lExpDate: TLabel
          Left = 2
          Top = 24
          Width = 156
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1072#1074#1090#1086#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103':'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btTurn: TBitBtn
          Left = 162
          Top = 47
          Width = 140
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'btTurn'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btTurnClick
        end
        object cbExpDate: TCheckBox
          Left = 303
          Top = 27
          Width = 167
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1077' '#1076#1085#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = cbExpDateClick
        end
        object dtpEffDate: TDateTimePicker
          Left = 162
          Top = 5
          Width = 140
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Date = 0.356006631947821000
          Time = 0.356006631947821000
          TabOrder = 2
        end
        object dtpExpDate: TDateTimePicker
          Left = 162
          Top = 25
          Width = 140
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Date = 0.356006631947821000
          Time = 0.356006631947821000
          Enabled = False
          TabOrder = 3
        end
      end
      object tsDELAYED_ON_OFF_TARIFF_OPTIONS: TTabSheet
        Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1086#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
        ImageIndex = 1
        ExplicitWidth = 491
        object lActionDate: TLabel
          Left = 6
          Top = 20
          Width = 161
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1072#1074#1090#1086#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lOffDealedOpt: TLabel
          Left = 6
          Top = 69
          Width = 151
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = #1044#1072#1090#1072' '#1072#1074#1090#1086#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dtActionDate: TDateTimePicker
          Left = 172
          Top = 16
          Width = 109
          Height = 24
          Date = 42166.672995474540000000
          Time = 42166.672995474540000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object dtActionTime: TDateTimePicker
          Left = 295
          Top = 16
          Width = 81
          Height = 24
          Date = 42171.564916145840000000
          Time = 42171.564916145840000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 1
        end
        object btDealedTurn: TBitBtn
          Left = 2
          Top = 94
          Width = 374
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1086#1095#1077#1088#1077#1076#1100' '#1085#1072' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btDealedTurnClick
        end
        object dtOffActionDate: TDateTimePicker
          Left = 172
          Top = 65
          Width = 109
          Height = 24
          Date = 42166.672995474540000000
          Time = 42166.672995474540000000
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object dtOFFActionTime: TDateTimePicker
          Left = 295
          Top = 65
          Width = 81
          Height = 24
          Date = 42171.564916145840000000
          Time = 42171.564916145840000000
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Kind = dtkTime
          ParentFont = False
          TabOrder = 4
        end
        object cbOff: TCheckBox
          Left = 6
          Top = 47
          Width = 171
          Height = 17
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = cbOffClick
        end
      end
    end
  end
  object qOptions: TOraQuery
    SQL.Strings = (
      'select * '
      '  from tariff_options t_o'
      
        '  where ((NVL(CAN_BE_TURNED_BY_OPERATOR, 0) = 1) or (:IS_ADMIN =' +
        ' 1))'
      '    and ((OPTION_CODE = :OPTION_CODE) or (:OPTION_CODE is null))'
      '    AND ( ( :SHOW_ALL = 1 ) OR'
      '          ('
      '          ( :SHOW_ALL = 0) AND'
      '          ( EXISTS (SELECT 1 FROM recommended_tariff_options r '
      
        '                    WHERE r.tariff_option_id = t_o.tariff_option' +
        '_id'
      '                     AND  r.tariff_id = :TARIFF_ID) )'
      '           ) '
      '        )'
      '  order by OPTION_CODE')
    Left = 16
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IS_ADMIN'
      end
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'SHOW_ALL'
      end
      item
        DataType = ftUnknown
        Name = 'TARIFF_ID'
      end>
  end
  object spTurn: TOraStoredProc
    StoredProcName = 'API_TURN_TARIFF_OPTION'
    Left = 32
    Top = 80
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
        DataType = ftString
        Name = 'POPTION_CODE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PTURN_ON'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'PEFF_DATE'
        ParamType = ptInput
        HasDefault = True
      end
      item
        DataType = ftDateTime
        Name = 'PEXP_DATE'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'API_TURN_TARIFF_OPTION'
  end
  object qCheck: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  DELAYED_TURN_TO_ID,'
      '  ACTION_DATE '
      'FROM '
      '  DELAYED_ON_OFF_TARIFF_OPTIONS d'
      'WHERE phone_number = :phone_number '
      '      AND option_code = :option_code'
      '      AND ACTION_TYPE = :ACTION_TYPE')
    Left = 152
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone_number'
      end
      item
        DataType = ftUnknown
        Name = 'option_code'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end>
  end
  object qAdd: TOraQuery
    SQL.Strings = (
      'INSERT INTO DELAYED_ON_OFF_TARIFF_OPTIONS '
      
        '  (PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, ACTION_DATE, DATE_CRE' +
        'ATED, USER_CREATED)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :OPTION_CODE, :ACTION_TYPE, :ACTION_DATE, SYSD' +
        'ATE, USER)')
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 152
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end>
  end
  object qUpdate: TOraQuery
    SQL.Strings = (
      'UPDATE DELAYED_ON_OFF_TARIFF_OPTIONS'
      'set  '
      '  ACTION_DATE = :ACTION_DATE'
      'where '
      'DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID')
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 152
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end
      item
        DataType = ftUnknown
        Name = 'DELAYED_TURN_TO_ID'
      end>
  end
end
