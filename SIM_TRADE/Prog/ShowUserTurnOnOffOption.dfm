object ShowUserTurnOnOffOptionForm: TShowUserTurnOnOffOptionForm
  Left = 0
  Top = 0
  Caption = 'ShowUserTurnOnOffOptionForm'
  ClientHeight = 463
  ClientWidth = 480
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
  object pTurn: TPanel
    Left = 0
    Top = 393
    Width = 480
    Height = 70
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 136
    ExplicitWidth = 540
    ExplicitHeight = 327
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
      TabOrder = 1
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
    object cbExpDate: TCheckBox
      Left = 306
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
      TabOrder = 3
      OnClick = cbExpDateClick
    end
  end
  object pSpisok: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 393
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 1
    object lbSpisok: TListBox
      Left = 1
      Top = 25
      Width = 478
      Height = 367
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
      ExplicitWidth = 538
      ExplicitHeight = 28
    end
    object pAdmin: TPanel
      Left = 1
      Top = 1
      Width = 478
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 453
      object lSearch: TLabel
        Left = 120
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
        Width = 103
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
        Left = 161
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
    end
  end
  object qOptions: TOraQuery
    SQL.Strings = (
      'select * '
      '  from tariff_options'
      
        '  where ((NVL(CAN_BE_TURNED_BY_OPERATOR, 0) = 1) or (:IS_ADMIN =' +
        ' 1))'
      '    and ((OPTION_CODE = :OPTION_CODE) or (:OPTION_CODE is null))'
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
end
