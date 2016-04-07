object RecommendedTariffOptionsForm: TRecommendedTariffOptionsForm
  Left = 0
  Top = 0
  Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1099#1077' '#1086#1087#1094#1080#1080' '#1082' '#1090#1072#1088#1080#1092#1091
  ClientHeight = 532
  ClientWidth = 838
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
  object Splitter1: TSplitter
    Left = 345
    Top = 0
    Height = 532
    ExplicitLeft = 368
    ExplicitTop = 160
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 532
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 346
    object clbAllow: TsCheckListBox
      Left = 1
      Top = 26
      Width = 343
      Height = 505
      Align = alClient
      BorderStyle = bsSingle
      TabOrder = 0
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      ExplicitWidth = 292
      ExplicitHeight = 319
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 343
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 292
      object Label1: TLabel
        Left = 8
        Top = 6
        Width = 61
        Height = 13
        Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077':'
      end
    end
  end
  object Panel2: TPanel
    Left = 348
    Top = 0
    Width = 127
    Height = 532
    Align = alLeft
    TabOrder = 1
    ExplicitLeft = 297
    ExplicitHeight = 346
    object btnAdd: TBitBtn
      Left = 24
      Top = 88
      Width = 75
      Height = 25
      Caption = '-->'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnDelete: TBitBtn
      Left = 24
      Top = 119
      Width = 75
      Height = 25
      Caption = '<--'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
  end
  object Panel3: TPanel
    Left = 475
    Top = 0
    Width = 363
    Height = 532
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 424
    ExplicitWidth = 293
    ExplicitHeight = 346
    object clbRecommended: TsCheckListBox
      Left = 1
      Top = 26
      Width = 361
      Height = 505
      Align = alClient
      BorderStyle = bsSingle
      TabOrder = 0
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
      ExplicitWidth = 291
      ExplicitHeight = 319
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 361
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 291
      object Label2: TLabel
        Left = 8
        Top = 6
        Width = 85
        Height = 13
        Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1091#1077#1084#1099#1077':'
      end
    end
  end
  object qRecommended: TOraQuery
    SQL.Strings = (
      'SELECT'
      '  o.tariff_option_id,'
      '  o.option_name,'
      '  o.option_code'
      'FROM'
      '  recommended_tariff_options r,'
      '  tariff_options o'
      'WHERE r.tariff_id = :TARIFF_ID '
      '  AND r.tariff_option_id = o.tariff_option_id')
    Left = 248
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TARIFF_ID'
      end>
  end
  object qAllow: TOraQuery
    SQL.Strings = (
      'SELECT'
      ' o.tariff_option_id,'
      ' o.option_name,'
      ' o.option_code'
      'FROM'
      ' tariff_options o'
      'WHERE'
      ' o.tariff_option_id NOT IN (SELECT'
      '                                  r.tariff_option_id'
      '                            FROM'
      '                              recommended_tariff_options r'
      '                            WHERE'
      '                              r.tariff_id = :TARIFF_ID'
      '                            )')
    Left = 312
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TARIFF_ID'
      end>
  end
  object qChange: TOraQuery
    Left = 280
    Top = 168
  end
end
