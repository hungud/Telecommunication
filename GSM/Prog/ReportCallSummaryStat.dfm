object ReportCallSummaryStatFrm: TReportCallSummaryStatFrm
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1072#1085#1072#1083#1080#1079#1091' '#1080#1089#1093#1086#1076#1103#1097#1077#1075#1086' '#1075#1086#1083#1086#1089#1086#1074#1086#1075#1086' '#1090#1088#1072#1092#1080#1082#1072
  ClientHeight = 518
  ClientWidth = 956
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
  object pFiltr: TPanel
    Left = 0
    Top = 0
    Width = 956
    Height = 89
    Align = alTop
    TabOrder = 0
    object lbl3: TLabel
      Left = 18
      Top = 57
      Width = 119
      Height = 13
      Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1077#1088#1080#1086#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 18
      Top = 16
      Width = 99
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dblkcbbPeriodBegin: TDBLookupComboBox
      Left = 167
      Top = 12
      Width = 145
      Height = 21
      DataField = 'YEAR_MONTH'
      KeyField = 'YEAR_MONTH'
      ListField = 'MONTH_YEAR_STRING'
      ListSource = dsPeriod
      TabOrder = 0
    end
    object dblkcbbPeriodEnd: TDBLookupComboBox
      Left = 167
      Top = 53
      Width = 145
      Height = 21
      DataField = 'YEAR_MONTH'
      KeyField = 'YEAR_MONTH'
      ListField = 'MONTH_YEAR_STRING'
      ListSource = dsPeriod2
      TabOrder = 1
    end
    object btLoadInExcel: TBitBtn
      Left = 426
      Top = 9
      Width = 151
      Height = 29
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
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
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00525A520084948C0042524A0073847300395239006B84
        73003952390073947B00526B52007B9C8400395A420073947300315231006B8C
        63004A6B4A008CA58C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00849484002942310073847300425A42006B846B004263
        4A0073947300294A31006B8C6B00395A39006B8C6B00315231007BAD84002952
        29006B8C6B00314A3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00425242007B947B00E7FFE700EFFFF700EFFFF700E7FF
        EF00EFFFEF00EFFFEF00EFFFEF00EFFFEF00EFFFEF00E7FFEF00D6FFDE00E7FF
        E700315A31006B946B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00738C7300395A3900EFFFEF00D6FFD600E7FFEF00DEFF
        E700E7FFEF00DEFFE700DEFFE7005A8C5A00396B390063946300316331005A94
        5A0073A57B0029522900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0042633900638C5A00E7FFE700215A210063A56B002163
        29005A9C6300185A210052945A00216B2900DEFFDE00185A21005A945A00396B
        3900214A2100638C6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00638C630042733900DEFFDE0063A55A00105A1000529C
        5A00317B39005AAD630029733100D6FFD6001863180063AD630039733900D6FF
        D6007BA57B004A6B4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00395A31006B945A00DEFFCE00316B210073B56B002973
        2900428C420018631800DEFFD600185A1000529C5200216318005A945A00DEFF
        DE00184A21006B947300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00849C7B004A6B3900DEFFD600E7FFDE00215A2100528C
        520039733900DEFFDE00216321006BA56B0031733100639C6300215A2100E7FF
        E7006B946B00315A3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF003142310063846300EFFFEF00E7FFE700E7FFEF004273
        4A00D6FFDE00296339005A8C6B00295A310063946B00DEFFE700DEFFE700DEFF
        DE00315A31007B9C7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0073846B0052735200EFFFEF00E7FFE70021522900E7FF
        EF00295A31006B9C7B00315A3900638C630039633900739C7300E7FFE700E7FF
        E7005A845A004A6B4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF004A63390073946300E7FFDE0031632900E7FFDE003163
        290073A56B001852180063945A00427339006B9C63003163290073A57300DEFF
        DE0052735200637B6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF007B9C6B00395A2900E7FFDE0073A56B00316B31005A8C
        5A00316331006B9C6B00E7FFE700639463003963290063945A0029522900EFFF
        EF005A735A00425A4200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00395239006B8C6B00E7FFE700315A390052845A004A73
        52005A846B00DEFFE700E7FFEF00DEFFE700638C6B002952290073946B00EFFF
        EF00395A42007B948400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0084A58C00294A2900E7FFEF00E7FFEF00E7FFEF00DEFF
        EF00DEFFEF00E7FFEF00E7FFF700E7FFEF00EFFFEF00EFFFEF00EFFFEF00E7FF
        E700738C7300314A3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00315A290073A5730021522100639C6300396B3900638C
        6300396339006B9C6B00214A2100638C5A00426331005A845200395231008494
        7B004A634A007B8C7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF006B8C63003963310084AD8400214A2100527B5200426B
        4200739C7300315A31007B9C73004A6B3900738C630042633900849C7B004252
        390073847300394A3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btLoadInExcelClick
    end
    object btRefresh: TBitBtn
      Left = 426
      Top = 44
      Width = 151
      Height = 29
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
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
      TabOrder = 3
      OnClick = btRefreshClick
    end
    object bAbonentInfo: TBitBtn
      Left = 642
      Top = 44
      Width = 151
      Height = 29
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Glyph.Data = {
        36090000424D3609000000000000360000002800000018000000180000000100
        2000000000000009000000000000000000000000000000000000FF00FF00FF00
        FF00FBFBFB00F4F4F400EEEEEE00E8E8E800E5E5E500E0E0E000DEDEDE00DFDF
        DF00DFDFDF00DFDFDF00DEDEDE00DFDFDF00DEDEDE00DFDFDF00E1E1E100E6E6
        E600EAEAEA00EFEFEF00F5F5F500FDFDFD00FF00FF00FF00FF00FF00FF00FF00
        FF00E5E5E500C8C8C800BCBCBC00B3B1AB00ADA18800B09B7000B4996100B897
        5500BB974E00BC974A00BC974B00BB974F00B7975800B29A6700AF9E7D00AFAA
        A000AAB2B700BDBDBE00CBCBCB00EFEFEF00FF00FF00FF00FF00FF00FF00FF00
        FF00FFFFFE00E4DDD000C1AB7D00B38E3F00B68F3F00BA924200BD954500BF97
        4700C1984900C2994A00C1994A00C1984900BF974700BC954500B99242005B8D
        8F000189DE00A2C4D600FCFCFC00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00CBB58300AD873600B18B3A00B68E3F00B9924100BD954500C0984900C39A
        4A00C69C4C00C79D4D00C79D4E00C69C4C00C39A4B00C0984800BD9545005590
        9900008EE1005E8C8700BD9F5E00F1EBDE00FF00FF00FF00FF00FF00FF00FF00
        FF00BD9F5F00AF893800B48D3C00B8914100BC944400C0984800C49B4C00C89E
        4E00CBA05000CCA15100CCA15200CBA05000C89E4F00C49B4B00C0984700B894
        480087916B00B28D3D00AF893900C8AF7A00FF00FF00FF00FF00FF00FF00FF00
        FF00CDB78600B18A3A00B58E3E00BA924300BE964700C39A4B00C89E4F00CCA1
        5200CFA45500D1A55700D1A55700CFA45500CCA15200C89E4F00C39A4B006898
        91000198E7008A906600B18A3A00CAB27D00FF00FF00FF00FF00FF00FF00FF00
        FF00F1EADC00B48E3F00B78F3F00BB944400C0984700C59C4C00CAA05100CFA4
        5400D3A75700D5A95A00D5A95B00D3A75700CFA35500CAA05000C59C4B00659B
        9600009DEB004698A700B28C3D00E7DBC300FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00E2D3B200BC974B00BC944500C1984800C69C4C00CBA15200D0A5
        5500D5A95A00D9AD5D00D9AD5E00D5A95900D0A55600CBA15100C69C4C00AA99
        5C000CA1E20000A2ED0069B1C000FEFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00ECE2CC00C7A66100C1994B00C69C4D00CBA05200D3AA
        5D00E5BF7900EFC98400EEC88300E4BD7700D2A95C00CBA05100C69C4D00C199
        4A009DA37A001BAEEE0001A7F1006FCDF700FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FBF8F300DCC69900C8A15400E5C17E00FDD7
        9800FBD59800EFD4A500EFD4A600FAD59900F0D59C0043ACC50079A38E00D6C1
        9200F7F5EE00DCF2FA000DB0F50001ACF400CEEFFD00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FBF4E800FBE0B500D9D5
        C500C3DAED00C4DDF300C4DDF300C3DAEE00ADCFD50008B3F7001BB7F200F9FC
        FD00FF00FF00FF00FF0033C1F80003B1F700B0E7FC00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FEFEFE00C7DF
        F400BAD8F100BAD8F100BAD8F100BAD8F100CCE8F80048C9FA0000B5F90056CF
        FC00B8EBFE007EDAFC0002B6F9001FBEF900E7F8FE00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E2EE
        F900B5D5F000D0E4F500CFE4F500B6D6F000FBFDFE00E2F7FE0055CFFC0016BF
        FC0003BAFC000DBDFC0034C7FB00BCECFD00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EEF5
        FB00D8E8F700DCEBF800DCEBF800D8E8F700F8FBFE00FF00FF00FEFFFF00D5F4
        FE00C0EEFE00C9F0FE00F6FCFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FDFDFE00D3E6
        F600CEE3F500CEE3F500CEE3F500CEE3F500D5E7F600FEFEFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7F1FA00C0DB
        F200C0DBF200C0DBF200C0DBF200C0DBF200C0DBF200E2E8EF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5CDE300B2D4
        F000B2D4F000B2D4F000B2D4F000B2D4F000B2D4F0008295A900FCFCFC00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D3D7DE0093B7D800A5CC
        ED00A5CCED00A5CCED00A5CCED00A5CCED00A5CCED00667D9700BFC2C800FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008E98AA0084ABD20097C3
        EA0097C3EA0097C3EA0097C3EA0097C3EA0092BCE4003E4E690081869300FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006A778E005573980087B8
        E40089BBE8007DA8D3005E7B9F00526C8E003A4A66002B354C005F687800FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0074809400314464004258
        7A006184AD0032405A002C384F002C384F002C384F002C384F00636B7C00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C5C9D100334361002C39
        53002B354C002C3851002D3952002C3851002D3952002D3951009EA3AE00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AAB1BB003843
        5A002B364D002D3A54002D3B55002D3A5400323F570080879600FCFCFC00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E4E5
        E8009A9FAA0068728500616B7E0080899700CFD2D700FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = bAbonentInfoClick
    end
  end
  object pGrid: TPanel
    Left = 0
    Top = 89
    Width = 956
    Height = 429
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 313
    object g1: TCRDBGrid
      Left = 1
      Top = 1
      Width = 954
      Height = 427
      Align = alClient
      DataSource = dsMain
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER_FEDERAL'
          Title.Caption = #1053#1086#1084#1077#1088
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_DATE'
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONTRACT_CANCEL_DATE'
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TARIFF_NAME'
          Title.Caption = #1058#1072#1088#1080#1092
          Width = 105
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_IN_NO_PAID'
          Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_IN_NO_PAID_ONLY_BEE'
          Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085' '
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_OUT_NO_PAID'
          Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_OUT_NO_PAID_ONLY_BEE'
          Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_IN_YES_PAID'
          Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_IN_YES_PAID_ONLY_BEE'
          Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_OUT_YES_PAID'
          Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DURATION_OUT_YES_PAID_ONLY_BEE'
          Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SMS_OUT'
          Title.Caption = #1050#1086#1083'-'#1074#1086' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' ('#1096#1090'.) | '#1057#1052#1057' '
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MMS_OUT'
          Title.Caption = #1050#1086#1083'-'#1074#1086' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' ('#1096#1090'.) | '#1052#1052#1057' '
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INTERNET_TRAFFIC'
          Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090' '#1090#1088#1072#1092#1080#1082' ('#1043#1041')'
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE_IS_ACTIVE'
          Title.Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
          Width = 73
          Visible = True
        end>
    end
  end
  object qMain: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select '
      '       V.CONTRACT_ID'
      '     , V.PHONE_NUMBER_FEDERAL'
      '     , V.CONTRACT_DATE'
      '     , V.CONTRACT_CANCEL_DATE'
      '     , TAR.TARIFF_NAME'
      '     , TRUNC(q.DURATION_OUT_NO_PAID, 2) DURATION_OUT_NO_PAID'
      
        '     , TRUNC(q.DURATION_OUT_NO_PAID_ONLY_BEE, 2) DURATION_OUT_NO' +
        '_PAID_ONLY_BEE'
      '     , TRUNC(q.DURATION_IN_NO_PAID, 2) DURATION_IN_NO_PAID'
      
        '     , TRUNC(q.DURATION_IN_NO_PAID_ONLY_BEE, 2) DURATION_IN_NO_P' +
        'AID_ONLY_BEE'
      '     , TRUNC(q.DURATION_IN_YES_PAID, 2) DURATION_IN_YES_PAID'
      
        '     , TRUNC(q.DURATION_IN_YES_PAID_ONLY_BEE, 2) DURATION_IN_YES' +
        '_PAID_ONLY_BEE'
      '     , TRUNC(q.DURATION_OUT_YES_PAID, 2) DURATION_OUT_YES_PAID'
      
        '     , TRUNC(q.DURATION_OUT_YES_PAID_ONLY_BEE, 2) DURATION_OUT_Y' +
        'ES_PAID_ONLY_BEE'
      
        '     , TRUNC((q.INTERNET_TRAFFIC/(1024*1024)), 3) INTERNET_TRAFF' +
        'IC     -- '#1091#1082#1072#1079#1072#1085#1086' '#1074' '#1075#1080#1075#1072#1073#1072#1081#1090#1072#1093
      '     , Q.SMS_OUT'
      '     , Q.MMS_OUT   '
      
        '     , DECODE (DLA.PHONE_IS_ACTIVE, 0, '#39#1053#1077' '#1072#1082#1090#1080#1074#1077#1085#39', 1, '#39#1040#1082#1090#1080#1074#1077#1085 +
        #39', '#39#1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090#39') PHONE_IS_ACTIVE'
      'from'
      '      v_contracts v'
      '    , DB_LOADER_ACCOUNT_PHONES dla'
      '    , TARIFFS tar'
      '    , (select'
      '               css.contract_id       '
      
        '             , SUM( NVL(css.DURATION_OUT_NO_PAID, 0) ) DURATION_' +
        'OUT_NO_PAID'
      
        '             , SUM( NVL(css.DURATION_OUT_NO_PAID_ONLY_BEE, 0) ) ' +
        'DURATION_OUT_NO_PAID_ONLY_BEE'
      
        '             , SUM( NVL(css.DURATION_IN_NO_PAID, 0) ) DURATION_I' +
        'N_NO_PAID'
      
        '             , SUM( NVL(css.DURATION_IN_NO_PAID_ONLY_BEE, 0) ) D' +
        'URATION_IN_NO_PAID_ONLY_BEE'
      
        '             , SUM( NVL(css.DURATION_IN_YES_PAID, 0) ) DURATION_' +
        'IN_YES_PAID'
      
        '             , SUM( NVL(css.DURATION_IN_YES_PAID_ONLY_BEE, 0) ) ' +
        'DURATION_IN_YES_PAID_ONLY_BEE'
      
        '             , SUM( NVL(css.DURATION_OUT_YES_PAID, 0) ) DURATION' +
        '_OUT_YES_PAID'
      
        '             , SUM( NVL(css.DURATION_OUT_YES_PAID_ONLY_BEE, 0) )' +
        ' DURATION_OUT_YES_PAID_ONLY_BEE'
      
        '             , SUM( NVL(css.INTERNET_TRAFFIC, 0) ) INTERNET_TRAF' +
        'FIC'
      '             , SUM( NVL(css.SMS_OUT, 0) ) SMS_OUT'
      '             , SUM( NVL(css.MMS_OUT, 0) ) MMS_OUT       '
      '        from  CALL_SUMMARY_STAT css    '
      '        where css.YEAR_MONTH >= :pYEAR_MONTH_BEGIN '
      '          and css.YEAR_MONTH <= :pYEAR_MONTH_END          '
      '        group by css.CONTRACT_ID'
      '      ) Q'
      'where       '
      '      q.CONTRACT_ID = V.CONTRACT_ID'
      '  and V.CONTRACT_DATE = '
      '                    ('
      '                     select max(CN.CONTRACT_DATE)'
      '                       from contracts cn'
      
        '                      where CN.PHONE_NUMBER_FEDERAL = V.PHONE_NU' +
        'MBER_FEDERAL'
      '                      group by CN.PHONE_NUMBER_FEDERAL'
      '                    )       '
      '  and V.PHONE_NUMBER_FEDERAL = DLA.PHONE_NUMBER '
      '  and DLA.YEAR_MONTH = to_number( to_char(sysdate,'#39'yyyymm'#39') )  '
      '  and V.TARIFF_ID = TAR.TARIFF_ID  (+)')
    Left = 96
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH_BEGIN'
      end
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH_END'
      end>
  end
  object dsMain: TDataSource
    DataSet = qMain
    Left = 96
    Top = 224
  end
  object qPeriod: TOraQuery
    SQL.Strings = (
      
        'select YEAR_MONTH, CONVERT_PCKG.MONTH_NAME(mod(YEAR_MONTH, 100))' +
        '||'#39' '#39'||trunc(YEAR_MONTH/100) MONTH_YEAR_STRING'
      'from'
      '('
      '    SELECT distinct FFB.YEAR_MONTH'
      '    FROM DB_LOADER_FULL_FINANCE_BILL FFB'
      '    union'
      '    SELECT to_number( to_char(sysdate,'#39'yyyymm'#39') )  '
      '    FROM DUAL'
      ')'
      'ORDER BY YEAR_MONTH DESC')
    Left = 256
    Top = 184
  end
  object dsPeriod: TOraDataSource
    DataSet = qPeriod
    Left = 256
    Top = 248
  end
  object qPeriod2: TOraQuery
    SQL.Strings = (
      
        'select YEAR_MONTH, CONVERT_PCKG.MONTH_NAME(mod(YEAR_MONTH, 100))' +
        '||'#39' '#39'||trunc(YEAR_MONTH/100) MONTH_YEAR_STRING'
      'from'
      '('
      '    SELECT distinct FFB.YEAR_MONTH'
      '    FROM DB_LOADER_FULL_FINANCE_BILL FFB'
      '    union'
      '    SELECT to_number( to_char(sysdate,'#39'yyyymm'#39') )  '
      '    FROM DUAL'
      ')'
      'ORDER BY YEAR_MONTH DESC')
    Left = 320
    Top = 184
  end
  object dsPeriod2: TOraDataSource
    DataSet = qPeriod2
    Left = 320
    Top = 248
  end
  object spCALC_CALL_SUMMARY_STAT: TOraStoredProc
    StoredProcName = 'CALC_CALL_SUMMARY_STAT'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  CALC_CALL_SUMMARY_STAT(:PYEAR_MONTH, :CALC_CUR_CALL);'
      'end;')
    Left = 456
    Top = 184
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PYEAR_MONTH'
        ParamType = ptInput
        HasDefault = True
      end
      item
        DataType = ftFloat
        Name = 'CALC_CUR_CALL'
        ParamType = ptInput
        HasDefault = True
      end>
    CommandStoredProcName = 'CALC_CALL_SUMMARY_STAT'
  end
end
