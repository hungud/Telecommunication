inherited FindDataForm: TFindDataForm
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 329
  ClientWidth = 407
  Font.Style = [fsBold]
  KeyPreview = True
  ShowHint = True
  OnCreate = FormCreate
  ExplicitWidth = 413
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 13
  object sgbPeriods: TsGroupBox
    Left = 0
    Top = 0
    Width = 407
    Height = 140
    Align = alTop
    Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1077#1088#1072#1094#1080#1080
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object sLabel3: TsLabel
      Left = 299
      Top = 21
      Width = 93
      Height = 13
      Caption = #1087#1077#1088#1080#1086#1076' '#1074' '#1076#1072#1090#1072#1093
    end
    object sLabel4: TsLabel
      Left = 299
      Top = 56
      Width = 9
      Height = 13
      Caption = #1089' '
    end
    object sLabel5: TsLabel
      Left = 294
      Top = 89
      Width = 14
      Height = 13
      Caption = #1087#1086
    end
    object sBevel4: TsBevel
      Left = 285
      Top = 5
      Width = 2
      Height = 133
    end
    object sdeBegin: TsDateEdit
      Left = 310
      Top = 53
      Width = 86
      Height = 21
      AutoSize = False
      Enabled = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 0
      Text = '07.11.2010'
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
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
      Date = 40489.000000000000000000
    end
    object srbToday: TsRadioButton
      Left = 10
      Top = 23
      Width = 70
      Height = 20
      Caption = #1057#1077#1075#1086#1076#1085#1103
      TabOrder = 1
      OnClick = srbTodayClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbYestoDay: TsRadioButton
      Left = 165
      Top = 23
      Width = 55
      Height = 20
      Caption = #1042#1095#1077#1088#1072
      TabOrder = 2
      OnClick = srbYestoDayClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbLastWeek: TsRadioButton
      Left = 165
      Top = 52
      Width = 119
      Height = 20
      Caption = #1055#1088#1086#1096#1083#1072#1103' '#1085#1077#1076#1077#1083#1103
      TabOrder = 3
      OnClick = srbLastWeekClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbThisWeek: TsRadioButton
      Left = 10
      Top = 52
      Width = 119
      Height = 20
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1085#1077#1076#1077#1083#1103
      TabOrder = 4
      OnClick = srbThisWeekClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbAl: TsRadioButton
      Left = 165
      Top = 111
      Width = 40
      Height = 20
      Caption = #1042#1089#1077
      Checked = True
      TabOrder = 5
      TabStop = True
      OnClick = srbAlClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbThisMonth: TsRadioButton
      Left = 10
      Top = 81
      Width = 109
      Height = 20
      Caption = #1058#1077#1082#1091#1097#1080#1081' '#1084#1077#1089#1103#1094
      TabOrder = 6
      OnClick = srbThisMonthClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object srbLastMonth: TsRadioButton
      Left = 165
      Top = 81
      Width = 113
      Height = 20
      Caption = #1055#1088#1086#1096#1083#1099#1081' '#1084#1077#1089#1103#1094
      TabOrder = 7
      OnClick = srbLastMonthClick
      SkinData.SkinSection = 'CHECKBOX'
    end
    object sdeEnd: TsDateEdit
      Left = 309
      Top = 85
      Width = 86
      Height = 21
      AutoSize = False
      Enabled = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 8
      Text = '07.11.2010'
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
      GlyphMode.Blend = 0
      GlyphMode.Grayed = False
      Date = 40489.000000000000000000
    end
    object srbCalendar: TsRadioButton
      Left = 10
      Top = 111
      Width = 147
      Height = 20
      Caption = #1042#1099#1073#1086#1088' '#1087#1086' '#1082#1072#1083#1077#1085#1076#1072#1088#1102
      TabOrder = 9
      OnClick = srbCalendarClick
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 295
    Width = 407
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      407
      34)
    object sBsave: TsBitBtn
      Left = 127
      Top = 2
      Width = 99
      Height = 31
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = sBsaveClick
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 275
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
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 140
    Width = 407
    Height = 155
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object sBevel1: TsBevel
      Left = 0
      Top = 47
      Width = 405
      Height = 106
    end
    object sBevel3: TsBevel
      Left = 1
      Top = 4
      Width = 404
      Height = 45
    end
    object sBevel2: TsBevel
      Left = 1
      Top = 47
      Width = 404
      Height = 54
    end
    object scbFilials: TsComboBox
      Left = 87
      Top = 14
      Width = 281
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1060#1080#1083#1080#1072#1083
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      ItemIndex = -1
      TabOrder = 0
    end
    object seVirtAccount: TsEdit
      Left = 113
      Top = 65
      Width = 191
      Height = 21
      Enabled = False
      TabOrder = 1
      OnChange = seVirtAccountChange
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1083#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object schbShowAll: TsCheckBox
      Left = 278
      Top = 114
      Width = 115
      Height = 27
      Hint = 
        #1055#1086' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091' '#1080#1097#1077#1090#1089#1103' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090', '#1079#1072#1090#1077#1084' '#1087#1086' '#1085#1072#1081#1076#1077#1085#1085#1086#1084 +
        #1091' '#1089#1095#1077#1090#1091' '#1087#1086#1082#1072#1079#1099#1074#1072#1102#1090#1089#1103' '#1074#1089#1077' '#1076#1072#1085#1085#1099#1077
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072' '#1082#1083#1080#1077#1085#1090#1072
      AutoSize = False
      Enabled = False
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      WordWrap = True
    end
    object sChBVirtAccount: TsCheckBox
      Left = 10
      Top = 59
      Width = 98
      Height = 33
      Hint = #1059#1095#1077#1089#1090#1100' '#1074' '#1087#1086#1080#1089#1082#1077' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1083#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1083#1080#1094#1077#1074#1086#1081' '#1089#1095#1077#1090
      AutoSize = False
      TabOrder = 3
      OnClick = sChBVirtAccountClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      WordWrap = True
    end
    object schbPhone: TsCheckBox
      Left = 10
      Top = 113
      Width = 79
      Height = 30
      Hint = 
        #1059#1095#1077#1089#1090#1100' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1074' '#1087#1086#1080#1089#1082#1077'. '#1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1090#1086#1083#1100#1082#1086' '#1094#1080#1092#1088#1099' '#1080' '#1090#1086 +
        #1083#1100#1082#1086' 10 '#1079#1085#1072#1082#1086#1074
      Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      AutoSize = False
      TabOrder = 4
      OnClick = schbPhoneClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
      WordWrap = True
    end
    object sePhone: TsEdit
      Left = 113
      Top = 114
      Width = 134
      Height = 21
      Hint = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1090#1086#1083#1100#1082#1086' '#1094#1080#1092#1088#1099' '#1080' '#1090#1086#1083#1100#1082#1086' 10 '#1079#1085#1072#1082#1086#1074
      MaxLength = 10
      NumbersOnly = True
      TabOrder = 5
      OnChange = sePhoneChange
      OnKeyDown = sePhoneKeyDown
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
  end
end
