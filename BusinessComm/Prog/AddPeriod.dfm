inherited AddPeriodForm: TAddPeriodForm
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1077#1088#1080#1086#1076
  ClientHeight = 107
  ClientWidth = 391
  OnCreate = FormCreate
  ExplicitWidth = 399
  ExplicitHeight = 134
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 64
    Top = 8
    Width = 38
    Height = 13
    Caption = #1052#1077#1089#1103#1094
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sLabel2: TsLabel
    Left = 201
    Top = 8
    Width = 22
    Height = 13
    Caption = #1043#1086#1076
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 73
    Width = 391
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    ExplicitLeft = -295
    ExplicitTop = 137
    ExplicitWidth = 726
    DesignSize = (
      391
      34)
    object sBsave: TsBitBtn
      Left = 100
      Top = 2
      Width = 99
      Height = 31
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
      ExplicitLeft = 435
    end
    object sBClose: TsBitBtn
      Left = 239
      Top = 2
      Width = 99
      Height = 31
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 8
      Images = Dm.ImageList24
      ExplicitLeft = 574
    end
  end
  object sComboBox1: TsComboBox
    Left = 8
    Top = 27
    Width = 145
    Height = 21
    Alignment = taLeftJustify
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    ItemIndex = 0
    TabOrder = 1
    Text = #1071#1085#1074#1072#1088#1100
    OnChange = sComboBox1Change
    Items.Strings = (
      #1071#1085#1074#1072#1088#1100
      #1060#1077#1074#1088#1072#1083#1100
      #1052#1072#1088#1090
      #1040#1087#1088#1077#1083#1100
      #1052#1072#1081
      #1048#1102#1085#1100
      #1048#1102#1083#1100
      #1040#1074#1075#1091#1089#1090
      #1057#1077#1085#1090#1103#1073#1088#1100
      #1054#1082#1090#1103#1073#1088#1100
      #1053#1086#1103#1073#1088#1100
      #1044#1077#1082#1072#1073#1088#1100)
  end
  object sEdit1: TsEdit
    Left = 183
    Top = 27
    Width = 40
    Height = 21
    TabOrder = 2
    Text = '2015'
    OnChange = sEdit1Change
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
  object sCheckBox1: TsCheckBox
    Left = 259
    Top = 28
    Width = 124
    Height = 20
    Caption = #1040#1082#1090#1080#1074#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = sCheckBox1Click
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sUpDown1: TsUpDown
    Left = 223
    Top = 27
    Width = 16
    Height = 21
    Associate = sEdit1
    Min = 2000
    Max = 3000
    Position = 2015
    TabOrder = 4
    Thousands = False
    OnClick = sUpDown1Click
  end
end
