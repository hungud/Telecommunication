object ReportPhonePaymentsFrmLC: TReportPhonePaymentsFrmLC
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1083#1072#1090#1077#1078#1072#1084' '#1089' '#1086#1073#1097#1077#1075#1086' '#1051#1057
  ClientHeight = 440
  ClientWidth = 1172
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1172
    Height = 73
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 324
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
      Width = 62
      Height = 13
      Caption = #1051#1080#1094'. '#1089#1095#1077#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 0
      Width = 135
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      Glyph.Data = {
        C2040000424DC204000000000000420000002800000018000000180000000100
        1000030000008004000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C6A29504648250E3A471D0D3A471D4E3EAA29
        6F4267214E3A46192D32A92591461F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C5042
        05190E3A68210D3688254E3A25192D36671D2D364619AF4245152D3626191F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C48214F3EFC73FD7BFD7BFC77FD77FD77FD77
        FD77FD77FC77FA6FFC7366194D361F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C2E3A
        671DFD77FA6BFC77FB73FC77FB73FB732B2EA71D4C3286194B2E8E3E45151F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C881D2C2EFC7364118C3684156B3263114A2E
        A415FB6F63114B2EA71D24112C321F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C2C32
        C81DFB6F8C2E62096A2EE61DAB32C519FA6B830DAC32C71DFA6B8F3EA9251F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C67194D2EFB67A611CE36C5152822830DFB6B
        63096A2A840D4B2EFB6F23114D3A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C703E
        A91DFB6BFC6F64112A2AC71DFB6F84118D36C6196C326411FC734D3666191F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C06190C32FD77FC73FC77C825FA6F851D2B36
        65194C36FB73FB73FB6F66196F3E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0E36
        CA29FD77FC734415FC7765196D3E661D2C32871D6E3AFC73FC730B2EA9251F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C891D4E32FC6F8615FC6F86158E36430D4C2E
        C81D6D3286158E3AFB6FCA29EC311F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C6F36
        6715FC6F8E36A6192B2E86196D36FC734C3287154C2E4515FD77CB2D68211F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C471D2D36FC73661D0A2EC9290B36FB73FC77
        FB732C3645154E36FD7767214F421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C9046
        2515FC77FC77FC77FB77FB77FC77FC7BFC77FD77FD77FD77FC732E3A26191F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C66158E3A44116C32A71D2C32871D6D362411
        2C2E88190B2A4719503E89252F3E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C2D32
        8719B0422411EA29A8216E3A66196F3AA91D2E32881D703E481D0E3A271D1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 619
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Glyph.Data = {
        C2040000424DC204000000000000420000002800000018000000180000000100
        1000030000008004000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C7842D71DD81DD81DF821D81DB719F72577421F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CBA4EB71918267B2E7B2E7B2A7B2A5B26
        3B221A1ED819D721B6527746B719B7191F7C1F7C1F7C1F7C1F7C1F7C1F7CBA4E
        B71DBB3ADC3ABC3ABB36DC3EFC46FC469B323A223B1EF91996159615B80D770D
        363A1F7C1F7C1F7C1F7C1F7CFB569619DC3EFC42DC3EDC42BB3E9A365A2E9B3A
        FC4A3D539B323A1E1A1AF911D90D760DF6291F7C1F7C1F7C1F7C1F7C7619DB42
        FC46FC429A36B71D5511F729793EB7215511D81D9B323A221916F911F90D760D
        951D1F7C1F7C1F7C1F7C593E59361D4FFC465932751578421F7C1F7C1F7C1F7C
        DA52340DF9191A1A1916F911F90D970D55111F7C1F7C1F7C1F7C54153D531D4B
        5932751577461F7C1F7C1F7C1F7C1F7C541139263A1E1A1A1916F911F90DB811
        340D1F7C1F7C1F7C1F7CB6215E5BFC46F825941D1F7C1F7C1F7C1F7C1F7C9A4A
        D7219E671D4F5A221916F911F90DB811340DB7521F7C1F7C9946793E7E5F7A36
        B621353E1F7C1F7C1F7C1F7C1F7C1F7CB62534117A363D57BB3A1916F90DD911
        340D56461F7C1F7C994A593A7E635A2E951D76461F7C1F7C1F7C1F7C1F7C1F7C
        1F7C3C63741954117A32FC425A22F9115509F4351F7C1F7CB94E38369E677A32
        951D35421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFB56331154115A2A9B32
        960DB4291F7C1F7CBA52F72DDF739B36F82573211F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C994AF20C550D760D94251F7C1F7C1F7CD10CBF733D57
        1A26D108954E1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C5842
        741D1F7C1F7C1F7C1F7CD52DBA46BF6F7B321826D008754E1F7C1F7C1F7C1F7C
        1F7CF85A354296521F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CF10CDF77
        5D5B5A2A1826B004522134425546143E1115B004F2089004143E1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C9429F62DDF7B3D537B2E1926D71D331533113311
        B719F8197611540DF10C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C531D
        1732DF739E67DC427B2E5A2A39265A265A265A223A227515F1101F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CB529F210FB4E9E6BBF737E631D4FFC42
        1C4BBB3EF725B004B9521F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7CFA5A12156F00F20CF629793E172E7419B00494251F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C994E163AD52D3742
        B9521F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 725
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Glyph.Data = {
        C2040000424DC204000000000000420000002800000018000000180000000100
        1000030000008004000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7CFF7FDE7BBD77BD779C739C737B6F7B6F7B6F7B6F7B6F
        7B6F7B6F7B6F9C739C73BD77BD77DE7BFF7F1F7C1F7C1F7C1F7C9C733967F75E
        D6569546763A7632572A5726572657265726562E7632753EB552D55AF75E3967
        BD771F7C1F7C1F7C1F7CFF7F7C6BB83E361E361E572257225722782678267826
        78265722572257222B46206E146BFF7F1F7C1F7C1F7C1F7C1F7CD942151A361E
        361E572257227826782678267826782678267826782657224A4E20722B42772E
        BE6F1F7C1F7C1F7C1F7C772E351E361E57225722782678267926992A992A992A
        992A79267826782257265036361E351EB93E1F7C1F7C1F7C1F7CD942361E361E
        5722572278267926992A992A9A2A9A2A992A992A792678266D4A60725132361E
        D93E1F7C1F7C1F7C1F7CBE6F361E361E572278227826992A992A9A2ABA2EBA2E
        9A2A992A992A78266C4A60766852361E7C631F7C1F7C1F7C1F7C1F7C5C5B5726
        572278267826992A9A2ABA2EBB2EBB2EBA2E9A2A992A7826752E81728076CD62
        FF7F1F7C1F7C1F7C1F7C1F7C1F7C9D67983278267826992ABA2EFC3E3D433D43
        FC3ABA2E992A78267826933EA376807A2D7B1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        FF7B1B4F992A1C3F5F4F5F4F5D535D535F4F5E4FA8628F461A4BDE77DB7FC17A
        A07AB97F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CDF779F5B5B637877787B787B
        7877356BC17AC37AFF7F1F7C1F7C067FC07A967F1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7CFF7F787B777B777B777B777BB97F297FC07E2A7FB77F6F7FC07E
        E37EFC7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CBC7F567B9A7B997B
        567BFF7FDC7F2A7FE27EE07EE17E067FB77F1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7CDD7FBB7BBB7FBB7FBB7BFF7F1F7CFF7FDA7FB87FD97FFE7F
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CFF7F9A7B997B997B997B
        997B9A7BFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7CDC7F787B787B787B787B787B787BBC771F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C3673567B567B567B567B
        567B567B5056FF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C5A6FD26E347734773477347734773477EC4917671F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C7156B06A1277127712771277
        1277F2722735104A1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7CCD45CA4DF072F176AF6AEB4DAA452731C524AB3D1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0E4A0631683D0C56062DE524
        E524E524E524AC3D1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C386B0631E528C524E528E528E528E528E52893561F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CD55E072DC524E528E528
        E528E628104AFF7F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C9C777356CD41AC3D304A596B1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cbPeriod: TComboBox
      Left = 378
      Top = 4
      Width = 99
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object cbSearch: TCheckBox
      Left = 842
      Top = 6
      Width = 60
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
    object CLB_Accounts: TsCheckListBox
      Left = 76
      Top = 2
      Width = 242
      Height = 65
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
      TabOrder = 5
      OnExit = CLB_AccountsExit
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
  end
  object Payments: TCRDBGrid
    Left = 0
    Top = 73
    Width = 1172
    Height = 367
    Align = alClient
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Caption = #1051#1080#1094'. '#1089#1095#1077#1090
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPANY_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1055#1089#1077#1074#1076#1086#1085#1080#1084
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACCOUNT_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072'|'#1087#1083#1072#1090#1077#1078#1072
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_ACTIVATE_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072'|'#1072#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1083#1072#1090#1077#1078#1072
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_ORIGINAL_AMT'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072'|'#1074#1085#1077#1089#1077#1085#1085#1072#1103
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_CURRENT_AMT'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072'|'#1079#1072#1095#1080#1089#1083#1077#1085#1085#1072#1103
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BANK_PAYMENT_ID'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_STATUS'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089' '#1087#1083#1072#1090#1077#1078#1072
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_TYPE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087' '#1087#1083#1072#1090#1077#1078#1072
        Width = 100
        Visible = True
      end>
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  YEAR_MONTH,'
      '  '#39'  '#39' || TO_CHAR(YEAR_MONTH - (TRUNC(YEAR_MONTH / 100) * 100)) '
      '    || '#39' - '#39
      '    || TRUNC(YEAR_MONTH / 100) YEAR_MONTH_NAME'
      'FROM DB_LOADER_PAYMENTS'
      'GROUP BY YEAR_MONTH'
      'ORDER BY YEAR_MONTH DESC')
    ReadOnly = True
    Left = 176
    Top = 136
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 112
    Top = 112
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
  object qReport: TOraQuery
    SQL.Strings = (
      'select '
      '  ACC.LOGIN,'
      '  ACC.COMPANY_NAME,'
      '  ACC.ACCOUNT_NUMBER,'
      '  P.PHONE_NUMBER,'
      '  P.PAYMENT_DATE,'
      '  P.PAYMENT_ACTIVATE_DATE,'
      '  P.PAYMENT_ORIGINAL_AMT,'
      '  P.PAYMENT_CURRENT_AMT,'
      '  P.BANK_PAYMENT_ID,'
      '  '
      '  case P.PAYMENT_STATUS'
      '    when '#39'Funds transfer to'#39' then '#39#1055#1077#1088#1077#1085#1077#1089#1077#1085#1086' '#1085#1072' '#1089#1095#1077#1090#39
      '    when '#39'Funds transfer from'#39' then '#39#1055#1077#1088#1077#1085#1077#1089#1077#1085#1086' '#1089#1086' '#1089#1095#1077#1090#1072#39
      '  else'
      '    P.PAYMENT_STATUS  '
      '  end PAYMENT_STATUS,'
      '  '
      '  P.PAYMENT_TYPE'
      ''
      'from DB_LOADER_PAYMENT_TRANSFERS p,'
      '     accounts acc'
      'WHERE '
      '      p.account_id = acc.account_id(+)'
      
        '      and trunc(P.PAYMENT_DATE, '#39'mm'#39') = to_date(:YEAR_MONTH||'#39'01' +
        #39', '#39'yyyy.mm.dd'#39')'
      '      %WHERE_STATMENT%'
      
        'ORDER BY P.PHONE_NUMBER, payment_date DESC, P.PAYMENT_ORIGINAL_A' +
        'MT asc, p.account_id asc')
    FetchRows = 250
    Left = 128
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qReportLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 120
    end
    object qReportCOMPANY_NAME: TStringField
      FieldName = 'COMPANY_NAME'
      Size = 120
    end
    object qReportACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 60
    end
    object qReportPAYMENT_DATE: TDateTimeField
      FieldName = 'PAYMENT_DATE'
    end
    object qReportPAYMENT_ACTIVATE_DATE: TDateTimeField
      FieldName = 'PAYMENT_ACTIVATE_DATE'
    end
    object qReportPAYMENT_ORIGINAL_AMT: TStringField
      FieldName = 'PAYMENT_ORIGINAL_AMT'
      Size = 120
    end
    object qReportPAYMENT_CURRENT_AMT: TStringField
      FieldName = 'PAYMENT_CURRENT_AMT'
      Size = 120
    end
    object qReportBANK_PAYMENT_ID: TStringField
      FieldName = 'BANK_PAYMENT_ID'
      Size = 120
    end
    object qReportPAYMENT_STATUS: TStringField
      FieldName = 'PAYMENT_STATUS'
      Size = 800
    end
    object qReportPAYMENT_TYPE: TStringField
      FieldName = 'PAYMENT_TYPE'
      Size = 800
    end
  end
  object DataSource1: TDataSource
    DataSet = qReport
    Left = 128
    Top = 184
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ACCOUNT_ID, LOGIN '
      'FROM ACCOUNTS '
      'ORDER BY LOGIN ASC')
    Left = 176
    Top = 88
  end
  object qReportTemplate: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      '  ACC.LOGIN,'
      '  ACC.COMPANY_NAME,'
      '  ACC.ACCOUNT_NUMBER,'
      '  P.PHONE_NUMBER,'
      '  P.PAYMENT_DATE,'
      '  P.PAYMENT_ACTIVATE_DATE,'
      '  P.PAYMENT_ORIGINAL_AMT,'
      '  P.PAYMENT_CURRENT_AMT,'
      '  P.BANK_PAYMENT_ID,'
      '  case P.PAYMENT_STATUS'
      '    when '#39'Funds transfer to'#39' then '#39#1055#1077#1088#1077#1085#1077#1089#1077#1085#1086' '#1085#1072' '#1089#1095#1077#1090#39
      '    when '#39'Funds transfer from'#39' then '#39#1055#1077#1088#1077#1085#1077#1089#1077#1085#1086' '#1089#1086' '#1089#1095#1077#1090#1072#39
      '  else'
      '    P.PAYMENT_STATUS  '
      '  end PAYMENT_STATUS,'
      '  '
      '  P.PAYMENT_TYPE'
      ''
      'from DB_LOADER_PAYMENT_TRANSFERS p,'
      '     accounts acc'
      'WHERE '
      '      p.account_id = acc.account_id(+)'
      
        '      and trunc(P.PAYMENT_DATE, '#39'mm'#39') = to_date(:YEAR_MONTH||'#39'01' +
        #39', '#39'yyyy.mm.dd'#39')'
      '      %WHERE_STATMENT%'
      
        'ORDER BY P.PHONE_NUMBER, payment_date DESC, P.PAYMENT_ORIGINAL_A' +
        'MT asc, p.account_id asc')
    FetchRows = 250
    Left = 208
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
  end
end
