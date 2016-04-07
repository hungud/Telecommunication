object OperationFilterFrame: TOperationFilterFrame
  Left = 0
  Top = 0
  Width = 250
  Height = 338
  TabOrder = 0
  object sLabel1: TsLabel
    Left = 32
    Top = 89
    Width = 63
    Height = 16
    Caption = #1057#1091#1073#1040#1075#1077#1085#1090
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel2: TsLabel
    Left = 32
    Top = 40
    Width = 39
    Height = 16
    Caption = #1040#1075#1077#1085#1090
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel3: TsLabel
    Left = 32
    Top = 138
    Width = 41
    Height = 16
    Caption = #1058#1072#1088#1080#1092
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel4: TsLabel
    Left = 24
    Top = 7
    Width = 141
    Height = 19
    Caption = #1043#1077#1085#1077#1088#1072#1094#1080#1103' '#1080#1079' '#1041#1044
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel5: TsLabel
    Left = 32
    Top = 187
    Width = 48
    Height = 16
    Caption = #1041#1072#1083#1072#1085#1089
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel6: TsLabel
    Left = 114
    Top = 212
    Width = 25
    Height = 13
    Caption = '<X<'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sBitBtn1: TsBitBtn
    Left = 110
    Top = 296
    Width = 115
    Height = 25
    Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    OnClick = sBitBtn1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object eBalanceMin: TsEdit
    Left = 24
    Top = 209
    Width = 84
    Height = 21
    Alignment = taRightJustify
    TabOrder = 1
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object eBalanceMax: TsEdit
    Left = 145
    Top = 209
    Width = 80
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object DBLookupComboboxEh1: TDBLookupComboboxEh
    Left = 24
    Top = 64
    Width = 201
    Height = 21
    DropDownBox.Rows = 25
    EditButtons = <>
    KeyField = 'ID'
    ListField = 'NAME'
    ListSource = dsAgents
    TabOrder = 3
    Visible = True
  end
  object DBLookupComboboxEh2: TDBLookupComboboxEh
    Left = 24
    Top = 111
    Width = 201
    Height = 21
    DropDownBox.Rows = 25
    EditButtons = <>
    KeyField = 'ID'
    ListField = 'NAME'
    ListSource = dsSubAgents
    TabOrder = 4
    Visible = True
  end
  object DBLookupComboboxEh3: TDBLookupComboboxEh
    Left = 24
    Top = 160
    Width = 201
    Height = 21
    DropDownBox.Rows = 25
    EditButtons = <>
    KeyField = 'ID'
    ListField = 'NAME'
    ListSource = dsTariff
    TabOrder = 5
    Visible = True
  end
  object qSubAgents: TOraQuery
    SQL.Strings = (
      'select -1 id, '#39#1042#1089#1077#39' name from dual'
      'union all'
      'select * from (select sub_agent_id subagent_id, '
      '                      sub_agent_name name '
      '                 from sub_agents order by name)')
    Left = 80
    Top = 72
  end
  object dsSubAgents: TDataSource
    DataSet = qSubAgents
    Left = 112
    Top = 80
  end
  object qAgents: TOraQuery
    SQL.Strings = (
      'select -1 id, '#39#1042#1089#1077#39' name from dual'
      'union all'
      'select * '
      '  from ('
      '    select agent_id, '
      '           agent_name name'
      '      from agents '
      '      order by name)')
    Left = 80
    Top = 24
  end
  object qTariff: TOraQuery
    SQL.Strings = (
      'select -1 id, '#39#1042#1089#1077#39' name from dual'
      'union all'
      'select * '
      '  from ('
      '    select tariff_id, '
      '           tariff_name '
      '      from tariffs '
      '      where is_active = 1 '
      '      order by tariff_name)')
    Left = 80
    Top = 120
  end
  object dsAgents: TDataSource
    DataSet = qAgents
    Left = 112
    Top = 32
  end
  object dsTariff: TDataSource
    DataSet = qTariff
    Left = 112
    Top = 128
  end
  object qGenerator: TOraQuery
    Left = 24
    Top = 288
  end
end
