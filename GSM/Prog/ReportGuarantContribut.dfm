inherited ReportGuarantContributForm: TReportGuarantContributForm
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1099#1084' '#1074#1079#1085#1086#1089#1072#1084
  ClientHeight = 571
  ClientWidth = 982
  Position = poScreenCenter
  ExplicitWidth = 998
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 13
  inherited pButtons: TPanel
    Width = 982
    Height = 129
    ExplicitWidth = 982
    ExplicitHeight = 129
    object Label1: TLabel [0]
      Left = 400
      Top = 7
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
    object Label2: TLabel [1]
      Left = 3
      Top = 7
      Width = 74
      Height = 13
      Caption = #1051#1086#1075#1080#1085'/ '#1057#1095#1077#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRefresh: TBitBtn
      Left = 575
      Width = 130
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1080#1079' '#1073#1072#1079#1099
      ExplicitLeft = 575
      ExplicitWidth = 130
    end
    inherited btLoadInExcel: TBitBtn
      Left = 711
      ExplicitLeft = 711
    end
    object CLB_Accounts: TsCheckListBox
      Left = 92
      Top = 7
      Width = 286
      Height = 96
      BorderStyle = bsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = CLB_AccountsExit
      OnMouseMove = CLB_AccountsMouseMove
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
      OnClickCheck = CLB_AccountsClickCheck
    end
    object btInfoAbonent: TBitBtn
      Left = 852
      Top = 1
      Width = 117
      Height = 28
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000FF00FF00FF00
        FF00FFFFFF00F7F7F700EFEFEF00EFEFEF00E7E7E700E7E7E700DEDEDE00DEDE
        DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7E7E700E7E7
        E700EFEFEF00EFEFEF00F7F7F700FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00E7E7E700CECECE00BDBDBD00B5B5AD00ADA58C00B59C7300B59C6300BD94
        5200BD944A00BD944A00BD944A00BD944A00B5945A00B59C6300AD9C7B00ADAD
        A500ADB5B500BDBDBD00CECECE00EFEFEF00FF00FF00FF00FF00FF00FF00FF00
        FF00FFFFFF00E7DED600C6AD7B00B58C3900B58C3900BD944200BD944200BD94
        4200C69C4A00C69C4A00C69C4A00C69C4A00BD944200BD944200BD9442005A8C
        8C00008CDE00A5C6D600FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00CEB58400AD843100B58C3900B58C3900BD944200BD944200C69C4A00C69C
        4A00C69C4A00C69C4A00C69C4A00C69C4A00C69C4A00C69C4A00BD9442005294
        9C00008CE7005A8C8400BD9C5A00F7EFDE00FF00FF00FF00FF00FF00FF00FF00
        FF00BD9C5A00AD8C3900B58C3900BD944200BD944200C69C4A00C69C4A00CE9C
        4A00CEA55200CEA55200CEA55200CEA55200CE9C4A00C69C4A00C69C4200BD94
        4A0084946B00B58C3900AD8C3900CEAD7B00FF00FF00FF00FF00FF00FF00FF00
        FF00CEB58400B58C3900B58C3900BD944200BD944200C69C4A00CE9C4A00CEA5
        5200CEA55200D6A55200D6A55200CEA55200CEA55200CE9C4A00C69C4A006B9C
        9400009CE7008C946300B58C3900CEB57B00FF00FF00FF00FF00FF00FF00FF00
        FF00F7EFDE00B58C3900B58C3900BD944200C69C4200C69C4A00CEA55200CEA5
        5200D6A55200D6AD5A00D6AD5A00D6A55200CEA55200CEA55200C69C4A00639C
        9400009CEF00429CA500B58C3900E7DEC600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00E7D6B500BD944A00BD944200C69C4A00C69C4A00CEA55200D6A5
        5200D6AD5A00DEAD5A00DEAD5A00D6AD5A00D6A55200CEA55200C69C4A00AD9C
        5A0008A5E70000A5EF006BB5C600FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00EFE7CE00C6A56300C69C4A00C69C4A00CEA55200D6AD
        5A00E7BD7B00EFCE8400EFCE8400E7BD7300D6AD5A00CEA55200C69C4A00C69C
        4A009CA57B0018ADEF0000A5F7006BCEF700FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FFFFF700DEC69C00CEA55200E7C67B00FFD6
        9C00FFD69C00EFD6A500EFD6A500FFD69C00F7D69C0042ADC6007BA58C00D6C6
        9400F7F7EF00DEF7FF0008B5F70000ADF700CEEFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7EF00FFE7B500DED6
        C600C6DEEF00C6DEF700C6DEF700C6DEEF00ADCED60008B5F70018B5F700FFFF
        FF00FF00FF00FF00FF0031C6FF0000B5F700B5E7FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF00C6DE
        F700BDDEF700BDDEF700BDDEF700BDDEF700CEEFFF004ACEFF0000B5FF0052CE
        FF00BDEFFF007BDEFF0000B5FF0018BDFF00E7FFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7EF
        FF00B5D6F700D6E7F700CEE7F700B5D6F700FFFFFF00E7F7FF0052CEFF0010BD
        FF0000BDFF0008BDFF0031C6FF00BDEFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFF7
        FF00DEEFF700DEEFFF00DEEFFF00DEEFF700FFFFFF00FF00FF00FFFFFF00D6F7
        FF00C6EFFF00CEF7FF00F7FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF00D6E7
        F700CEE7F700CEE7F700CEE7F700CEE7F700D6E7F700FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7F7FF00C6DE
        F700C6DEF700C6DEF700C6DEF700C6DEF700C6DEF700E7EFEF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5CEE700B5D6
        F700B5D6F700B5D6F700B5D6F700B5D6F700B5D6F7008494AD00FFFFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6DE0094B5DE00A5CE
        EF00A5CEEF00A5CEEF00A5CEEF00A5CEEF00A5CEEF00637B9400BDC6CE00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C9CAD0084ADD60094C6
        EF0094C6EF0094C6EF0094C6EF0094C6EF0094BDE700394A6B0084849400FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B738C0052739C0084BD
        E7008CBDEF007BADD6005A7B9C00526B8C00394A630029314A005A6B7B00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007384940031426300425A
        7B006384AD0031425A0029394A0029394A0029394A0029394A00636B7B00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6CED600314263002939
        520029314A0029395200293952002939520029395200293952009CA5AD00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADB5BD003942
        5A0029314A002939520029395200293952003139520084849400FFFFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7E7
        EF009C9CAD006B738400636B7B00848C9400CED6D600FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cbPeriod: TComboBox
      Left = 465
      Top = 4
      Width = 104
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
    object BitBtn1: TBitBtn
      Left = 576
      Top = 35
      Width = 129
      Height = 29
      Action = aLoadFromSite
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089' '#1089#1072#1081#1090#1072
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400BD733900C673
        3900C6733900C67B4200C6733900BD6B3100BD7B4A00BD9C8400FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00D6AD9C00BD6B3100C6844A00DE9C5A00DE9C
        5A00DE9C5200DE9C5200DE944A00DE8C4200D6843900C6733100BD734200B5AD
        A500BD9C8C00BD6B3100BD6B3100FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00D6AD9C00BD6B3900DEAD7300E7B57300E7AD7300DEAD
        6B00E7B57B00E7BD8C00E7BD8C00DEA56300D68C4200DE8C3900CE7B3100B563
        2900B5632900C66B1800BD5A1800B58C7300FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00DEBDAD00B5633100E7B57B00E7BD8400E7B57B00E7B58400DEAD
        7B00D6A56B00D6945A00DEA57300E7BD9400EFCEA500DEA56300D68C3900D684
        3100CE7B2100CE731800B55A1800B57B5200FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00B55A3100DEB58400E7BD8C00E7BD8400D6A56B00BD6B3900AD52
        2100BD7B5200CE9C7B00BD6B4200AD522100C6733900DEA56300D68C4200CE84
        2900CE7B2100CE7B1800B55A1800AD633900FF00FF00FF00FF00FF00FF00FF00
        FF00CE947B00CE946B00EFC69C00E7BD8C00CE946300AD5A2900C69C8400FF00
        FF00FF00FF00FF00FF00FF00FF00D6B5A500A54A1800CE7B3100D6843100CE84
        2900CE7B2100CE7B1800BD631800AD522100FF00FF00FF00FF00FF00FF00FF00
        FF00A5522900EFCEA500EFC69400CE946300AD5A2900BD9C8C00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00A5522100CE8C4A00D68C3900D6843100CE84
        2900CE7B2100CE7B1800C66B2100A54A1800FF00FF00FF00FF00FF00FF00FF00
        FF00B56B4200F7D6B500E7BD8C00C67B4A00A5633900FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00D6A59400BD734200F7E7CE00EFC69C00D6944200CE84
        2900CE7B2100CE7B1800C66B2100A54A1800BDADA500FF00FF00FF00FF00CEA5
        8C00CE9C7B00F7DEBD00D69C6B00B56B4200AD8C7B00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00B56B4A00A54A2100D69C6B00EFCEAD00DEAD
        7300CE842900CE7B1800CE732100A54A1800B5948C00FF00FF00FF00FF00CEA5
        9400CE947300F7DEC600D6945A00AD633900B59C8C00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEC600A55A3100A5522100D69C
        6300E7BD8400D6944200CE7B2100AD521000A57B6B00FF00FF00FF00FF00CEAD
        9C00C68C6B00F7E7CE00D69C6300AD633900AD8C8400FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBDAD009C4A
        2100A5522100D6945200DEA56300B5631800A56B5200FF00FF00FF00FF00D6AD
        A500BD7B5A00FFF7E700DEA56B00C67B4A009C5A4200FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00CEA5940094391800AD521800B55A1800A5634A00FF00FF00FF00FF00FF00
        FF008C311800FFEFE700EFCEAD00D6844A008C311000ADA59C00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00C6948400A55A3900FF00FF00FF00FF00FF00FF00FF00
        FF00AD735A00D6AD8C00FFEFDE00DE9C6300C6844A0084311000AD9C9C00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BDB500AD8C8400B5A5A500FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008C391800FFF7EF00EFD6B500D6945200C6844A00842908009452
        4200A58C8400AD948C00A5847B008C422900842908009439100084210800A584
        7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00A5635200B57B5A00FFF7F700EFCEA500DE9C5A00CE844A00BD73
        39009C4A29009C4A21009C4A2100BD6B3100C67B3100B55A2100A55218008C39
        1800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF009C523900BD846300FFF7E700F7E7CE00E7B58400DE9C
        5A00D6945200CE8C4A00D6944A00D6944A00D6944200D68C4200AD5A29008C39
        2100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00AD6B520094392100DEBD9C00F7E7D600FFEF
        E700F7DEC600EFC69C00E7BD8400E7C69400DEAD7B00BD7B4A0084290800CEAD
        A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00D6BDB500944229007B1800009439
        1800B57B5200CE9C7B00BD845A00A55A310084290800A5634A00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEA5
        9C00B5847300AD735A00BD8C8400CEADA500FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  inherited pGrid: TPanel
    Top = 129
    Width = 982
    Height = 442
    ExplicitTop = 129
    ExplicitWidth = 982
    ExplicitHeight = 442
    inherited gReport: TCRDBGrid
      Width = 980
      Height = 440
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'LOGIN'
          Title.Alignment = taCenter
          Title.Caption = #1051#1086#1075#1080#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACCOUNT_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1051#1080#1094'. '#1057#1095#1077#1090
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'STATUS_GUARANT_FEE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1074#1079#1085#1086#1089#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 175
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUM_GUARANT_FEE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1074#1079#1085#1086#1089#1072' '#1089' '#1053#1044#1057
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 204
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAID'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1083#1072#1095#1077#1085#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RETURNED'
          Title.Alignment = taCenter
          Title.Caption = #1042#1086#1079#1074#1088#1072#1097#1077#1085#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'YEAR_MONTH'
          Title.Alignment = taCenter
          Title.Caption = #1055#1077#1088#1080#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BILL_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1074#1099#1089#1090'. '#1089#1095#1077#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CREATED'
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1079#1076#1072#1085#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_CREATED'
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1079#1076#1072#1083
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_UPDATE'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_UPDATE'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1085#1086#1074#1080#1083
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 193
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'SELECT '
      '    ACCOUNT_ID, '
      '    to_char(BILL_NUMBER) BILL_NUMBER, '
      '    DATE_CREATED,'
      '    DATE_UPDATE,'
      '    GUARANTEE_FEES_ID,'
      '    NOT_PAID, '
      '    PAID,'
      '    PHONE_NUMBER,'
      '    RETURNED,'
      '    STATUS_GUARANT_FEE,'
      '    SUM_GUARANT_FEE,'
      '    USER_CREATED,'
      '    USER_UPDATE,'
      '    WITHDRAWN,'
      '    YEAR_MONTH,'
      '    ACCOUNT_NUMBER,'
      '    LOGIN'
      ''
      '  FROM  '
      '  V_GUARANTEE_FEES'
      ''
      'where YEAR_MONTH = :Period')
    Left = 312
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'Period'
      end>
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 11
    end
    object qReportSTATUS_GUARANT_FEE: TStringField
      FieldName = 'STATUS_GUARANT_FEE'
      Size = 120
    end
    object qReportSUM_GUARANT_FEE: TFloatField
      FieldName = 'SUM_GUARANT_FEE'
    end
    object qReportPAID: TFloatField
      FieldName = 'PAID'
    end
    object qReportRETURNED: TFloatField
      FieldName = 'RETURNED'
    end
    object qReportWITHDRAWN: TFloatField
      FieldName = 'WITHDRAWN'
    end
    object qReportNOT_PAID: TFloatField
      FieldName = 'NOT_PAID'
    end
    object qReportDATA_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
    end
    object qReportUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Size = 120
    end
    object qReportDATA_UPDATE: TDateTimeField
      FieldName = 'DATE_UPDATE'
    end
    object qReportUSER_UPDATE: TStringField
      FieldName = 'USER_UPDATE'
      Size = 120
    end
    object qReportBILL_NUMBER: TStringField
      FieldName = 'BILL_NUMBER'
      Size = 40
    end
    object qReportYEAR_MONTH: TFloatField
      FieldName = 'YEAR_MONTH'
    end
    object qReportACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 120
    end
  end
  inherited dsReport: TDataSource
    Left = 368
    Top = 248
  end
  inherited aList: TActionList
    Left = 264
    Top = 248
    object aShowUserStatInfo: TAction
      Caption = 'aShowUserStatInfo'
      OnExecute = aShowUserStatInfoExecute
    end
    object aLoadFromSite: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089' '#1089#1072#1081#1090#1072
      OnExecute = aLoadFromSiteExecute
    end
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, ACCOUNT_NUMBER, LOGIN FROM ACCOUNTS '
      'where '
      ' ACCOUNT_ID <> 225 --'#1091#1073#1080#1088#1072#1077#1084' '#1101#1082#1086#1084#1086#1073#1072#1081#1083
      ''
      'ORDER BY LOGIN ASC')
    Left = 312
    Top = 320
  end
  object qDistYear: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT DISTINCT YEAR_MONTH FROM  V_GUARANTEE_FEES'
      'order by YEAR_MONTH DESC')
    Left = 392
    Top = 312
  end
  object spLOAD_DEPOSITS_FROM_SITE: TOraStoredProc
    StoredProcName = 'LOAD_DEPOSITS_FROM_SITE'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  LOAD_DEPOSITS_FROM_SITE;'
      'end;')
    Left = 512
    Top = 248
    CommandStoredProcName = 'LOAD_DEPOSITS_FROM_SITE'
  end
end