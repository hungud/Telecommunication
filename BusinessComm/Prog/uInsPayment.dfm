inherited InsPaymentFrm: TInsPaymentFrm
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
  ClientHeight = 200
  ClientWidth = 607
  KeyPreview = True
  ShowHint = True
  OnCreate = FormCreate
  ExplicitWidth = 613
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 607
    Height = 166
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sBevel1: TsBevel
      Left = 5
      Top = 0
      Width = 597
      Height = 53
    end
    object sBevel2: TsBevel
      Left = 5
      Top = 56
      Width = 597
      Height = 53
    end
    object sBevel3: TsBevel
      Left = 5
      Top = 108
      Width = 597
      Height = 53
    end
    object cbVirtAccount: TsComboBox
      Left = 111
      Top = 25
      Width = 454
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1074#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1081' '#1089#1095#1077#1090
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 1
      OnExit = cbVirtAccountExit
    end
    object deDatePayment: TsDateEdit
      Left = 14
      Top = 25
      Width = 86
      Height = 21
      Hint = #1059#1082#1072#1078#1080' '#1076#1072#1090#1091' '#1087#1083#1072#1090#1077#1078#1072
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnExit = deDatePaymentExit
      BoundLabel.Active = True
      BoundLabel.Caption = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072' '
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
      DefaultToday = True
      DialogTitle = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091' '#1087#1083#1072#1090#1077#1078#1072
    end
    object seBIK: TsEdit
      Left = 175
      Top = 77
      Width = 115
      Height = 21
      Hint = #1059#1082#1072#1078#1080#1090#1077' '#1041#1048#1050
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 4
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = #1041#1048#1050' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082#1072
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Font.Quality = fqAntialiased
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object sCurrencyEdit: TsCurrencyEdit
      Left = 311
      Top = 77
      Width = 114
      Height = 21
      Hint = #1059#1082#1072#1078#1080#1090#1077' '#1089#1091#1084#1084#1091' '#1087#1083#1072#1090#1077#1078#1072
      AutoSize = False
      TabOrder = 2
      OnExit = sCurrencyEditExit
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
    object seDocNumber: TsEdit
      Left = 448
      Top = 77
      Width = 147
      Height = 21
      Hint = #1059#1082#1072#1078#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      MaxLength = 10
      TabOrder = 5
      OnChange = seDocNumberChange
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object sePAYMENT_PURPOSE: TsEdit
      Left = 311
      Top = 129
      Width = 284
      Height = 21
      Hint = #1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      MaxLength = 500
      TabOrder = 6
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1072#1090#1077#1078#1072
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Font.Quality = fqAntialiased
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object bbShowVirt_Acc: TsBitBtn
      Left = 568
      Top = 24
      Width = 27
      Height = 24
      Hint = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1077' '#1089#1095#1077#1090#1072' - '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
      Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1099#1077' '#1089#1095#1077#1090#1072
      Margin = 1
      TabOrder = 7
      OnClick = bbShowVirt_AccClick
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 36
      Images = Dm.ImageList24
      ShowCaption = False
    end
    object sePhone: TsEdit
      Left = 14
      Top = 77
      Width = 119
      Height = 21
      Hint = #1059#1082#1072#1078#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      MaxLength = 16
      NumbersOnly = True
      TabOrder = 3
      OnExit = sePhoneExit
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object bbShowPhone: TsBitBtn
      Left = 135
      Top = 78
      Width = 27
      Height = 24
      Hint = #1053#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' - '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
      Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      Margin = 1
      TabOrder = 8
      OnClick = bbShowPhoneClick
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 36
      Images = Dm.ImageList24
      ShowCaption = False
    end
    object sBitBtn1: TsBitBtn
      Left = 274
      Top = 129
      Width = 27
      Height = 24
      Hint = #1058#1080#1087#1099' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081' - '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
      Caption = #1058#1080#1087#1099' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081
      Margin = 1
      TabOrder = 9
      OnClick = sBitBtn1Click
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 36
      Images = Dm.ImageList24
      ShowCaption = False
    end
    object cbTypePayments: TsComboBox
      Left = 16
      Top = 129
      Width = 252
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081
      AutoDropDown = True
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = #1058#1080#1087' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      BoundLabel.Indent = 4
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = [fsBold]
      BoundLabel.Layout = sclTopCenter
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Style = csDropDownList
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 10
      OnExit = cbVirtAccountExit
    end
  end
  object btnPanel: TsPanel
    Left = 0
    Top = 166
    Width = 607
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      607
      34)
    object sBsave: TsBitBtn
      Left = 342
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
      Left = 467
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
  object qPhone: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'SELECT count(PHONE_ID) cnt'
      'FROM PHONES'
      'where PHONE_ID = :PHONE_ID')
    Left = 500
    Top = 65532
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_ID'
      end>
    object qPhoneCNT: TFloatField
      FieldName = 'CNT'
    end
  end
end
