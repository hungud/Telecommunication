inherited InsBalanceVirtFrm: TInsBalanceVirtFrm
  Caption = 'InsBalanceVirtFrm'
  ClientHeight = 87
  ClientWidth = 304
  ExplicitWidth = 312
  ExplicitHeight = 114
  PixelsPerInch = 96
  TextHeight = 13
  object sBevel1: TsBevel
    Left = 5
    Top = 0
    Width = 292
    Height = 53
  end
  object btnPanel: TsPanel
    Left = 0
    Top = 53
    Width = 304
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      304
      34)
    object sBsave: TsBitBtn
      Left = 39
      Top = 3
      Width = 99
      Height = 31
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Margin = 1
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 164
      Top = 3
      Width = 99
      Height = 31
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 8
      Images = Dm.ImageList24
    end
  end
  object deDateBalance: TsDateEdit
    Left = 14
    Top = 25
    Width = 86
    Height = 21
    Hint = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1073#1072#1083#1072#1085#1089#1072
    AutoSize = False
    EditMask = '!99/99/9999;1; '
    MaxLength = 10
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '  .  .    '
    OnChange = deDateBalanceChange
    BoundLabel.Active = True
    BoundLabel.Caption = #1044#1072#1090#1072' '#1073#1072#1083#1072#1085#1089#1072
    BoundLabel.Indent = 4
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = [fsBold]
    BoundLabel.Layout = sclTopCenter
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
    DialogTitle = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091' '#1073#1072#1083#1072#1085#1089#1072
  end
  object sCurrencyEdit: TsCurrencyEdit
    Left = 167
    Top = 25
    Width = 114
    Height = 21
    Hint = #1059#1082#1072#1078#1080#1090#1077' '#1089#1091#1084#1084#1091' '#1087#1083#1072#1090#1077#1078#1072
    AutoSize = False
    TabOrder = 2
    OnChange = sCurrencyEditChange
    BoundLabel.Active = True
    BoundLabel.Caption = #1057#1091#1084#1084#1072
    BoundLabel.Indent = 4
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = [fsBold]
    BoundLabel.Layout = sclTopCenter
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
  end
end
