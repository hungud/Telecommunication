object frmRepRaschodPhones: TfrmRepRaschodPhones
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1086' '#1088#1072#1089#1093#1086#1076#1072#1093', '#1085#1077' '#1074#1082#1083#1102#1095#1077#1085#1085#1099#1093' '#1074' '#1072#1073#1086#1085'.'#1087#1083#1072#1090#1091
  ClientHeight = 540
  ClientWidth = 1128
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1128
    Height = 540
    ActivePage = tsRepDays
    Align = alClient
    TabOrder = 0
    object tsRepMonths: TTabSheet
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084
      object grData: TCRDBGrid
        Left = 0
        Top = 41
        Width = 1120
        Height = 471
        Align = alClient
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'ACCOUNT_NUMBER'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Alignment = taCenter
            Title.Caption = #1058#1077#1083'.'#1085#1086#1084#1077#1088
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTRACT_DATE'
            Title.Alignment = taCenter
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TARIFF_NAME'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BALANCE'
            Title.Alignment = taCenter
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATUS'
            Title.Alignment = taCenter
            Width = 107
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTRACT_TYPE'
            Title.Alignment = taCenter
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BALANCE_BLOCK_HAND_BLOCK'
            Title.Alignment = taCenter
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS_COST'
            Title.Alignment = taCenter
            Title.Caption = #1047#1074#1086#1085#1082#1080', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SMS_COST'
            Title.Alignment = taCenter
            Title.Caption = #1057#1052#1057', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MMS_COST'
            Title.Alignment = taCenter
            Title.Caption = 'MMS, '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INTERNET_COST'
            Title.Alignment = taCenter
            Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 130
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1120
        Height = 41
        Align = alTop
        TabOrder = 1
        object lPeriod: TLabel
          Left = 401
          Top = 13
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
        object cbPeriod: TComboBox
          Left = 460
          Top = 10
          Width = 100
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbPeriodChange
        end
        object btLoadInExcel: TBitBtn
          Left = 813
          Top = 5
          Width = 172
          Height = 30
          Action = aExcel
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
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
        object btRefresh: TBitBtn
          Left = 702
          Top = 5
          Width = 105
          Height = 30
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
        object btCheckAll: TButton
          Left = 209
          Top = 5
          Width = 90
          Height = 30
          Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
          TabOrder = 3
          OnClick = btCheckAllClick
        end
        object btUnCheckAll: TButton
          Left = 305
          Top = 5
          Width = 90
          Height = 30
          Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
          TabOrder = 4
          OnClick = btUnCheckAllClick
        end
      end
      object cbAccParam: TComboBox
        Left = 566
        Top = 10
        Width = 130
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = #1042#1089#1077' '#1089#1095#1077#1090#1072
        Items.Strings = (
          #1042#1089#1077' '#1089#1095#1077#1090#1072
          #1050#1086#1083#1083#1077#1082#1090#1086#1088
          #1050#1088#1086#1084#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072)
      end
    end
    object tsRepDays: TTabSheet
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1076#1085#1103#1084
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1120
        Height = 41
        Align = alTop
        TabOrder = 0
        object lPeriod_call_start: TLabel
          Left = 393
          Top = 15
          Width = 9
          Height = 13
          Caption = 'C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lPeriod_call_end: TLabel
          Left = 506
          Top = 14
          Width = 15
          Height = 13
          Caption = #1087#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btLoadInExcel_call: TBitBtn
          Left = 870
          Top = 5
          Width = 172
          Height = 29
          Action = aExcel
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
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
          TabOrder = 0
        end
        object btRefresh_call: TBitBtn
          Left = 759
          Top = 5
          Width = 105
          Height = 30
          Action = aRefresh_call
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
          TabOrder = 1
        end
        object btCheckAll_call: TButton
          Left = 205
          Top = 5
          Width = 90
          Height = 30
          Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
          TabOrder = 2
          OnClick = btCheckAll_callClick
        end
        object btUnCheckAll_call: TButton
          Left = 297
          Top = 5
          Width = 90
          Height = 30
          Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
          TabOrder = 3
          OnClick = btUnCheckAll_callClick
        end
        object cbAccParam_call: TComboBox
          Left = 623
          Top = 10
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = #1042#1089#1077' '#1089#1095#1077#1090#1072
          Items.Strings = (
            #1042#1089#1077' '#1089#1095#1077#1090#1072
            #1050#1086#1083#1083#1077#1082#1090#1086#1088
            #1050#1088#1086#1084#1077' '#1082#1086#1083#1083#1077#1082#1090#1086#1088#1072)
        end
        object dtDateStart: TDateTimePicker
          Left = 408
          Top = 10
          Width = 88
          Height = 21
          Date = 41983.000000000000000000
          Time = 41983.000000000000000000
          TabOrder = 5
        end
        object dtDateEnd: TDateTimePicker
          Left = 527
          Top = 10
          Width = 90
          Height = 21
          Date = 41983.000000000000000000
          Time = 41983.000000000000000000
          TabOrder = 6
        end
      end
      object grData_call: TCRDBGrid
        Left = 0
        Top = 41
        Width = 1120
        Height = 471
        Align = alClient
        DataSource = DataSource2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'ACCOUNT_NUMBER'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Alignment = taCenter
            Title.Caption = #1058#1077#1083'.'#1085#1086#1084#1077#1088
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTRACT_DATE'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TARIFF_NAME'
            Title.Alignment = taCenter
            Title.Caption = #1058#1072#1088#1080#1092
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BALANCE'
            Title.Alignment = taCenter
            Title.Caption = #1041#1072#1083#1072#1085#1089
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATUS'
            Title.Alignment = taCenter
            Title.Caption = #1057#1090#1072#1090#1091#1089
            Width = 107
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTRACT_TYPE'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BALANCE_BLOCK_HAND_BLOCK'
            Title.Alignment = taCenter
            Title.Caption = #1051#1080#1084#1080#1090' '#1073#1072#1083#1072#1085#1089#1072
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CALLS_COST'
            Title.Alignment = taCenter
            Title.Caption = #1047#1074#1086#1085#1082#1080', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SMS_COST'
            Title.Alignment = taCenter
            Title.Caption = #1057#1052#1057', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MMS_COST'
            Title.Alignment = taCenter
            Title.Caption = 'MMS, '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INTERNET_COST'
            Title.Alignment = taCenter
            Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090', '#1088#1091#1073'.'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -12
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 130
            Visible = True
          end>
      end
    end
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 32
    Top = 104
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
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
    end
    object aRefresh_call: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefresh_callExecute
    end
  end
  object qReport: TOraQuery
    SQL.Strings = (
      'SELECT '
      '       VC.CONTRACT_DATE,'
      '       T.TARIFF_NAME,'
      '       ICB.BALANCE,'
      '       (CASE'
      '          WHEN VC.IS_CREDIT_CONTRACT = 1 THEN '#39#1050#1088#1077#1076#1080#1090#39
      '          ELSE '#39#1040#1074#1072#1085#1089#39
      '       END) CONTRACT_TYPE,'
      '       CASE'
      '         WHEN P.PHONE_IS_ACTIVE = 0'
      '         THEN'
      '         CASE'
      '           WHEN P.CONSERVATION = 1 THEN '#39#1055#1086' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1102#39
      '           ELSE '#39#1055#1086' '#1078#1077#1083#1072#1085#1080#1102#39
      '         END'
      '         ELSE'
      '            '#39#1040#1082#1090#1080#1074#1085#1099#1081#39
      '       END'
      '         AS STATUS,'
      '       VC.BALANCE_BLOCK_HAND_BLOCK,'
      '       OAP.ACCOUNT_NUMBER,'
      '       OAP.PHONE_NUMBER,'
      '       OAP.CALLS_COST,'
      '       OAP.SMS_COST,'
      '       OAP.MMS_COST,'
      '       OAP.INTERNET_COST'
      '  FROM OVERRUN_ABON_PAY OAP,'
      '       V_CONTRACTS VC,'
      '       TARIFFS T,'
      '       IOT_CURRENT_BALANCE ICB,'
      '       DB_LOADER_ACCOUNT_PHONES P'
      ' WHERE OAP.YEAR_MONTH = :PYEAR_MONTH'
      '   AND OAP.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL(+)     '
      '   AND (NVL (vc.contract_date, TO_DATE ('#39'199001'#39', '#39'yyyymm'#39')) <='
      
        '            ADD_MONTHS (TO_DATE (OAP.YEAR_MONTH, '#39'yyyymm'#39'), 1) -' +
        ' 1)'
      
        '   AND NVL (vc.CONTRACT_CANCEL_DATE, TO_DATE ('#39'205012'#39', '#39'yyyymm'#39 +
        ')) >='
      '                  TO_DATE (OAP.YEAR_MONTH, '#39'yyyymm'#39')  '
      '   AND VC.TARIFF_ID = T.TARIFF_ID(+)'
      '   AND OAP.PHONE_NUMBER = ICB.PHONE_NUMBER(+)'
      '   AND OAP.PHONE_NUMBER = P.PHONE_NUMBER(+)'
      '   AND OAP.YEAR_MONTH = P.YEAR_MONTH(+)'
      '   AND OAP.ACCOUNT_ID = P.ACCOUNT_ID(+)'
      
        '   AND (:PACCOUNT_ID LIKE( '#39'%,'#39'||OAP.ACCOUNT_ID||'#39',%'#39') OR :PACCO' +
        'UNT_ID IS NULL)'
      
        '   AND ((NVL(OAP.IS_COLLECTOR, 0) = :PIS_COLLECTOR) OR (:PIS_COL' +
        'LECTOR IS NULL))')
    FetchRows = 250
    ReadOnly = True
    Left = 32
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'PYEAR_MONTH'
        ParamType = ptInput
        Value = '201407'
      end
      item
        DataType = ftUnknown
        Name = 'pAccount_id'
      end
      item
        DataType = ftUnknown
        Name = 'pIs_collector'
      end>
    object qReportACCOUNT_NUMBER: TFloatField
      FieldName = 'ACCOUNT_NUMBER'
    end
    object qReportPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportCALLS_COST: TFloatField
      FieldName = 'CALLS_COST'
    end
    object qReportSMS_COST: TFloatField
      FieldName = 'SMS_COST'
    end
    object qReportMMS_COST: TFloatField
      FieldName = 'MMS_COST'
    end
    object qReportINTERNET_COST: TFloatField
      FieldName = 'INTERNET_COST'
    end
    object qReportCONTRACT_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'CONTRACT_DATE'
    end
    object qReportTARIFF_NAME: TStringField
      DisplayLabel = #1058#1072#1088#1080#1092
      FieldName = 'TARIFF_NAME'
      Size = 400
    end
    object qReportBALANCE: TFloatField
      DisplayLabel = #1041#1072#1083#1072#1085#1089
      FieldName = 'BALANCE'
    end
    object qReportCONTRACT_TYPE: TStringField
      DisplayLabel = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
      FieldName = 'CONTRACT_TYPE'
      Size = 12
    end
    object qReportSTATUS: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      FieldName = 'STATUS'
      FixedChar = True
      Size = 16
    end
    object qReportBALANCE_BLOCK_HAND_BLOCK: TFloatField
      DisplayLabel = #1051#1080#1084#1080#1090' '#1073#1072#1083#1072#1085#1089#1072
      FieldName = 'BALANCE_BLOCK_HAND_BLOCK'
    end
  end
  object DataSource1: TDataSource
    DataSet = qReport
    Left = 24
    Top = 216
  end
  object qAccounts: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT ACCOUNT_ID, ACCOUNT_NUMBER||'#39' - '#39' ||COMPANY_NAME ACCOUNT_' +
        'NUMBER_NAME'
      'FROM ACCOUNTS '
      'ORDER BY LOGIN ASC')
    Left = 152
    Top = 160
    object qAccountsACCOUNT_ID: TFloatField
      FieldName = 'ACCOUNT_ID'
      Required = True
    end
    object qAccountsACCOUNT_NUMBER_NAME: TStringField
      FieldName = 'ACCOUNT_NUMBER_NAME'
      Size = 160
    end
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'select '
      '    YEAR_MONTH, '
      '    CONVERT_PCKG.YEAR_MONTH_NAME(YEAR_MONTH) YEAR_MONTH_NAME'
      'from '
      '('
      '  SELECT '
      '    distinct YEAR_MONTH '
      '    '
      '  FROM DB_LOADER_PHONE_STAT'
      '  WHERE    (ZEROCOST_OUTCOME_MINUTES <> 0)'
      '         OR (CALLS_COUNT <> 0)'
      '         OR (CALLS_COST <> 0)'
      '         OR (SMS_COUNT <> 0)'
      '         OR (MMS_COUNT <> 0)'
      '         OR (INTERNET_MB <> 0)'
      ')'
      'order by YEAR_MONTH  desc')
    ReadOnly = True
    Left = 88
    Top = 160
  end
  object qReport_call: TOraQuery
    Left = 232
    Top = 160
  end
  object DataSource2: TDataSource
    DataSet = qReport_call
    Left = 232
    Top = 216
  end
  object ActionList2: TActionList
    Left = 88
    Top = 104
  end
end
