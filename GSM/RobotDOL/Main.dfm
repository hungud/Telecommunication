object MainFrm: TMainFrm
  Left = 0
  Top = 0
  Caption = #1056#1086#1073#1086#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1082#1086#1085#1090#1088#1072#1082#1090#1086#1074' '#1074' DOL Beeline'
  ClientHeight = 648
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object p1: TPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 648
    Align = alClient
    TabOrder = 0
    object pMainPanel: TPanel
      Left = 1
      Top = 171
      Width = 1018
      Height = 476
      Align = alClient
      TabOrder = 0
      object grp1: TGroupBox
        Left = 1
        Top = 1
        Width = 1016
        Height = 474
        Align = alClient
        Caption = #1044#1072#1085#1085#1099#1077' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1077' '#1080#1079' '#1092#1072#1081#1083#1072': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object grdLoadedContractList: TCRDBGrid
          Left = 2
          Top = 18
          Width = 1012
          Height = 454
          Align = alClient
          DataSource = ds1
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ERROR_TEXT'
              Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1077
              Width = 350
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_NUM'
              Title.Caption = #8470' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_DAY'
              Title.Caption = #1044#1077#1085#1100' '#1082#1086#1085'-'#1090#1072
              Width = 84
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_MONTH'
              Title.Caption = #1052#1077#1089#1103#1094' '#1082#1086#1085'-'#1090#1072
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_YEAR'
              Title.Caption = #1043#1086#1076' '#1082#1086#1085'-'#1090#1072
              Width = 71
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERSON_SEX'
              Title.Caption = #1055#1086#1083' '#1072#1073#1086#1085#1077#1085#1090#1072
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERSON_SURNAME'
              Title.Caption = #1060#1072#1084#1080#1083#1080#1103
              Width = 138
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERSON_NAME'
              Title.Caption = #1048#1084#1103
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERSON_PATRONYMIC'
              Title.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUM_NAME'
              Title.Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
              Width = 354
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUM_SER'
              Title.Caption = #1057#1077#1088#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
              Width = 79
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUM_NUM'
              Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUM_ISSUE'
              Title.Caption = #1050#1077#1084' '#1074#1099#1076#1072#1085
              Width = 221
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ISSUE_DAY'
              Title.Caption = #1044#1077#1085#1100' '#1074#1099#1076#1072#1095#1080
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ISSUE_MONTH'
              Title.Caption = #1052#1077#1089#1103#1094' '#1074#1099#1076#1072#1095#1080
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ISSUE_YEAR'
              Title.Caption = #1043#1086#1076' '#1074#1099#1076#1072#1095#1080
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BIRTH_DAY'
              Title.Caption = #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BIRTH_MONTH'
              Title.Caption = #1052#1077#1089#1103#1094' '#1088#1086#1078#1076#1077#1085#1080#1103
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BIRTH_YEAR'
              Title.Caption = #1043#1086#1076' '#1088#1086#1078#1076#1077#1085#1080#1103
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CITY'
              Title.Caption = #1043#1086#1088#1086#1076
              Width = 354
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STREET_TYPE'
              Title.Caption = #1058#1080#1087' '#1091#1083#1080#1094#1099
              Width = 214
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STREET_NAME'
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1083#1080#1094#1099
              Width = 564
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'HOUSE'
              Title.Caption = #1044#1086#1084
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'APPARTMENT'
              Title.Caption = #1050#1074#1072#1088#1090#1080#1088#1072
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONEINFO_PREFIX'
              Title.Caption = #1055#1088#1077#1092#1080#1082#1089' '#1085#1086#1084#1077#1088#1072
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONEINFO_NUMBER'
              Title.Caption = #1053#1086#1084#1077#1088
              Width = 144
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PHONEINFO_FULL_NUMBER'
              Title.Caption = #1055#1086#1083#1085#1099#1081' '#1085#1086#1084#1077#1088
              Width = 144
              Visible = True
            end>
        end
        object edt2: TEdit
          Left = 640
          Top = -32
          Width = 121
          Height = 24
          TabOrder = 1
          Text = 'edt2'
        end
      end
    end
    object b1: TBitBtn
      Left = 64
      Top = 432
      Width = 81
      Height = 34
      Caption = #1055#1080#1085#1075
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = b1Click
    end
    object edt1: TEdit
      Left = 64
      Top = 463
      Width = 313
      Height = 21
      TabOrder = 2
      Visible = False
    end
    object p2: TPanel
      Left = 1
      Top = 1
      Width = 1018
      Height = 170
      Align = alTop
      TabOrder = 3
      DesignSize = (
        1018
        170)
      object btLoadExcel: TBitBtn
        Left = 18
        Top = 8
        Width = 231
        Height = 35
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083' '#1089' '#1082#1086#1085#1090#1088#1072#1082#1090#1072#1084#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
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
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btLoadExcelClick
      end
      object bSendContracts: TBitBtn
        Left = 18
        Top = 49
        Width = 231
        Height = 35
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1074' DOL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000007F0001007B0009007C0008007E00040080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000004E5429B677533DE6045A024F0076
          0013007D00050080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000965C4EFAD5A188FF976050F80A4F
          056D00740017007C0007007F0001008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000995E4FFBEAB394FFDFAC92FFA268
          57FC1C480E900072001B007B0009007F00010080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000009A5E4FFBE9AD8DFFE9A988FFE5B2
          96FFAE7160FF2B4616A6006F0022007A000B007F000200800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000009B6050FBE9AD8DFFE8A381FFE8A6
          85FFE9B699FFB77C68FF4A4A25C5006A002B0079000D007E0003008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000009D614FFBE9AD8DFFE8A381FFE8A3
          81FFE8A583FFEBB698FFC18972FF625132D60161003D00780010007E00040080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000A56452FFE9AE8EFFE8A381FFE8A3
          81FFE8A381FFE8A382FFEBB596FFCC967DFF7E593FE8035B014B00760013007D
          0005008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFEAB191FFE8A784FFE8A7
          84FFE8A784FFE8A784FFE8A784FFEBB393FFD6A288FF99644DF5095204660075
          0016007D00060080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFE8AE8BFFE8AE8BFFE8AE
          8BFFE8AE8BFFE8AE8BFFE8AE8BFFE8AE8BFFEAB594FFDEAB8FFFA86C56FB134D
          097D00760014007E000400800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFE8B591FFE8B591FFE8B5
          91FFE8B591FFE8B591FFE8B591FFE8B591FFE8B591FFE9B896FFE4B396FFB677
          5FFF1F4C0F8D007D000600800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFEEBD9AFFEEBD9AFFEEBD
          9AFFEEBD9AFFEEBD9AFFEEBD9AFFEEBD9AFFEEBD9AFFEEBD9AFFF1C3A3FFE0AE
          91FF996849F0007E000400800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFF2C2A0FFF2C2A0FFF2C2
          A0FFF2C2A0FFF2C2A0FFF2C2A0FFF2C2A0FFF2C2A0FFF5CBACFFE5B69AFFA870
          52F7116309500080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFF2C4A3FFF2C4A3FFF2C4
          A3FFF2C4A3FFF2C4A3FFF2C4A3FFF2C4A4FFF6CEB1FFDDAB8EFF926944E80B68
          063E008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFF4CAADFFF0C5A6FFF0C5
          A6FFF0C5A6FFF0C5A6FFF1C6A7FFF6CFB3FFD5A083FF86683FDC046F02250080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B77555FFEFC3A5FFF0C5A7FFF0C5
          A7FFF0C5A7FFF1C7AAFFF5CFB4FFCD9575FF696533C001760013008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B97654FFEFC3A5FFF0C6A8FFF0C6
          A8FFF2C9ACFFF2CAAFFFC78C6BFF506126A8007B000900800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000BB7754FFEFC3A5FFF0C6A8FFF3CA
          AEFFEFC6AAFFC48562FF35601A87007F00010080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000BC7954FFEFC3A5FFF4CDB1FFEABE
          A1FFB67C57F91C620E6200800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000BA7A52FCF2C9ADFFE4B596FFAB76
          4DF1106608490080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          000000800000008000000080000000800000B3774FF7DCA988FF967143E2056E
          022A008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000003260178260652AB40272011D0080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000008000000080000000800000}
        ParentFont = False
        TabOrder = 1
        OnClick = bSendContractsClick
      end
      object grp2: TGroupBox
        Left = 312
        Top = 0
        Width = 691
        Height = 75
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1079#1072#1075#1088#1091#1079#1082#1080': '
        TabOrder = 2
        object lbl1: TLabel
          Left = 16
          Top = 19
          Width = 252
          Height = 16
          Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1086#1074', '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1080#1079' '#1092#1072#1081#1083#1072': '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl2: TLabel
          Left = 16
          Top = 47
          Width = 228
          Height = 16
          Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1086#1074', '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1074' DOL: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblLoadedDOL: TLabel
          Left = 294
          Top = 47
          Width = 8
          Height = 16
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblLoadedContract: TLabel
          Left = 294
          Top = 19
          Width = 8
          Height = 16
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 377
          Top = 47
          Width = 169
          Height = 16
          Caption = #1054#1096#1080#1073#1082#1080' ('#1085#1077' '#1079#1072#1075#1088#1091#1078#1077#1085#1086'): '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblERROR_COUNT: TLabel
          Left = 569
          Top = 47
          Width = 8
          Height = 16
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object btnPrintContract: TBitBtn
        Left = 18
        Top = 90
        Width = 231
        Height = 35
        Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFC89662CA9865CA9765CA9765CA9765CA9764C99764C99764CA9865C895
          62FFFFFFFFFFFFFFFFFFA1A1A17A7A7A585858C79561F9F7F6F9F1ECF9F1EBF8
          F0E9F7EDE6F4EAE1F2E8DEFAF8F6C794612424244B4B4B9696966B6B6BA7A7A7
          B5B5B5818181AFACAAC5C0BDC5C0BDC5C0BDC5C0BDC5C0BDC5C0BDADAAA82C2C
          2CB5B5B59B9B9B232323707070B5B5B5B5B5B59595958181818181817979796E
          6E6E6161615252524343434242426E6E6EB5B5B5B5B5B5252525757575BBBBBB
          BBBBBB8D8D8DD4D4D4B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9B9D3D3D38383
          83BBBBBBBBBBBB2A2A2A7A7A7AD7D7D7D7D7D7979797D8D8D8BFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFD7D7D78E8E8ED7D7D7D7D7D73F3F3F7E7E7EF9F9F9
          F9F9F9ABABABDFDFDFCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBDFDFDFA3A3
          A3F9F9F9F9F9F9616161848484FCFCFCFCFCFCCBCBCBF2F2F2F2F2F2F2F2F2F2
          F2F2F2F2F2F2F2F2F2F2F2F2F2F2C6C6C6FCFCFCFCFCFC717171979797D2D2D2
          E8E8E87D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D
          7DE8E8E8C4C4C46D6D6DDDDDDD9A9A9ACCCCCCC78B4EF9F4EDFEE8D8FEE8D7FD
          E5D3FCE4D1FAE0C7F9DDC3FAF4EDC7854AC3C3C3747474CDCDCDFFFFFFCECECE
          878787C5894CF9F4EFFEE7D7FDE7D5FCE6D2FBE1CCF8DCC2F6DABDFAF4EFC483
          48616161BCBCBCFFFFFFFFFFFFFFFFFFFBFBFBC68C4FF9F4F0FCE6D3FDE7D3FB
          E3CDFAE0C8F5D6BBF3D4B5F8F4F0C4854AF9F9F9FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFC88D51F9F5F1FCE3CFFCE4CFFAE1CAF9DDC4F4E9DFF7F2ECF5EFE9C380
          48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC88D52F9F5F1FCE3CDFBE3CDF9
          E0C8F8DCC2FDFBF8FCE6CDE2B684D5A884FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFC5884DF7F2ECF8F4EEF8F3EDF8F3EDF8F2ECF2E6D7E2B27DDB9569FDFB
          FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8CEB9D7AA7CC88C50C88C4FCA
          9155CB9055C5894DDDAF8DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 3
        OnClick = btnPrintContractClick
      end
      object grp3: TGroupBox
        Left = 312
        Top = 83
        Width = 691
        Height = 79
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1056#1077#1078#1080#1084' '#1087#1077#1095#1072#1090#1080': '
        TabOrder = 4
        object lbl3: TLabel
          Left = 319
          Top = 50
          Width = 11
          Height = 16
          Caption = #1089' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 435
          Top = 50
          Width = 34
          Height = 16
          Caption = '-  '#1087#1086' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rb1: TRadioButton
          Left = 16
          Top = 51
          Width = 265
          Height = 17
          Caption = #1055#1086' '#1076#1080#1072#1087#1086#1079#1086#1085#1091' '#1085#1086#1084#1077#1088#1086#1074' '#1082#1086#1085#1090#1088#1072#1082#1090#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object rb2: TRadioButton
          Left = 16
          Top = 23
          Width = 353
          Height = 17
          Caption = #1055#1086' '#1089#1087#1080#1089#1082#1091' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1080#1079' '#1092#1072#1081#1083#1072' ('#1073#1077#1079' '#1086#1096#1080#1073#1086#1082')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object edt3: TEdit
          Left = 344
          Top = 47
          Width = 72
          Height = 21
          TabOrder = 2
          OnKeyPress = edt3KeyPress
        end
        object edt4: TEdit
          Left = 475
          Top = 47
          Width = 70
          Height = 21
          TabOrder = 3
          OnKeyPress = edt3KeyPress
        end
      end
    end
  end
  object dlgOpen1: TOpenDialog
    Left = 40
    Top = 256
  end
  object qData: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    FieldDefs = <
      item
        Name = 'ERROR_TEXT'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'CONTRACT_NUM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CONTRACT_DAY'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CONTRACT_MONTH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CONTRACT_YEAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PERSON_SEX'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PERSON_SURNAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PERSON_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PERSON_PATRONYMIC'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DOCUM_SER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DOCUM_NUM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DOCUM_ISSUE'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'ISSUE_DAY'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ISSUE_MONTH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ISSUE_YEAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BIRTH_DAY'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BIRTH_MONTH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BIRTH_YEAR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CITY'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'STREET_TYPE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'STREET_NAME'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'HOUSE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'APPARTMENT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PHONEINFO_PREFIX'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PHONEINFO_NUMBER'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PHONEINFO_FULL_NUMBER'
        DataType = ftString
        Size = 20
      end>
    Left = 152
    Top = 256
    Data = {
      03001A000A004552524F525F544558540100C800000000000C00434F4E545241
      43545F4E554D01001400000000000C00434F4E54524143545F44415901001400
      000000000E00434F4E54524143545F4D4F4E544801001400000000000D00434F
      4E54524143545F5945415201001400000000000A00504552534F4E5F53455801
      001400000000000E00504552534F4E5F5355524E414D4501003200000000000B
      00504552534F4E5F4E414D4501003200000000001100504552534F4E5F504154
      524F4E594D494301003200000000000900444F43554D5F534552010014000000
      00000900444F43554D5F4E554D01001400000000000B00444F43554D5F495353
      55450100960000000000090049535355455F44415901001400000000000B0049
      535355455F4D4F4E544801001400000000000A0049535355455F594541520100
      140000000000090042495254485F44415901001400000000000B004249525448
      5F4D4F4E544801001400000000000A0042495254485F59454152010014000000
      000004004349545901003200000000000B005354524545545F5459504501001E
      00000000000B005354524545545F4E414D4501005000000000000500484F5553
      4501001400000000000A004150504152544D454E540100140000000000100050
      484F4E45494E464F5F5052454649580100140000000000100050484F4E45494E
      464F5F4E554D4245520100140000000000150050484F4E45494E464F5F46554C
      4C5F4E554D4245520100140000000000000000000000}
    object qDataERROR_TEXT: TStringField
      FieldName = 'ERROR_TEXT'
      Size = 200
    end
    object qDataCONTRACT_NUM: TStringField
      FieldName = 'CONTRACT_NUM'
    end
    object qDataCONTRACT_DAY: TStringField
      FieldName = 'CONTRACT_DAY'
    end
    object qDataCONTRACT_MONTH: TStringField
      FieldName = 'CONTRACT_MONTH'
    end
    object qDataCONTRACT_YEAR: TStringField
      FieldName = 'CONTRACT_YEAR'
    end
    object qDataPERSON_SEX: TStringField
      FieldName = 'PERSON_SEX'
    end
    object qDataPERSON_SURNAME: TStringField
      FieldName = 'PERSON_SURNAME'
      Size = 50
    end
    object qDataPERSON_NAME: TStringField
      FieldName = 'PERSON_NAME'
      Size = 50
    end
    object qDataPERSON_PATRONYMIC: TStringField
      FieldName = 'PERSON_PATRONYMIC'
      Size = 50
    end
    object qDataDOCUM_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'DOCUM_NAME'
      Size = 50
    end
    object qDataDOCUM_SER: TStringField
      FieldName = 'DOCUM_SER'
    end
    object qDataDOCUM_NUM: TStringField
      FieldName = 'DOCUM_NUM'
    end
    object qDataDOCUM_ISSUE: TStringField
      FieldName = 'DOCUM_ISSUE'
      Size = 150
    end
    object qDataISSUE_DAY: TStringField
      FieldName = 'ISSUE_DAY'
    end
    object qDataISSUE_MONTH: TStringField
      FieldName = 'ISSUE_MONTH'
    end
    object qDataISSUE_YEAR: TStringField
      FieldName = 'ISSUE_YEAR'
    end
    object qDataBIRTH_DAY: TStringField
      FieldName = 'BIRTH_DAY'
    end
    object qDataBIRTH_MONTH: TStringField
      FieldName = 'BIRTH_MONTH'
    end
    object qDataBIRTH_YEAR: TStringField
      FieldName = 'BIRTH_YEAR'
    end
    object qDataCITY: TStringField
      FieldName = 'CITY'
      Size = 50
    end
    object qDataSTREET_TYPE: TStringField
      FieldName = 'STREET_TYPE'
      Size = 30
    end
    object qDataSTREET_NAME: TStringField
      FieldName = 'STREET_NAME'
      Size = 80
    end
    object qDataHOUSE: TStringField
      FieldName = 'HOUSE'
    end
    object qDataAPPARTMENT: TStringField
      FieldName = 'APPARTMENT'
    end
    object qDataPHONEINFO_PREFIX: TStringField
      FieldName = 'PHONEINFO_PREFIX'
    end
    object qDataPHONEINFO_NUMBER: TStringField
      FieldName = 'PHONEINFO_NUMBER'
    end
    object qDataPHONEINFO_FULL_NUMBER: TStringField
      FieldName = 'PHONEINFO_FULL_NUMBER'
    end
  end
  object ds1: TDataSource
    DataSet = qData
    Left = 96
    Top = 256
  end
  object qSendedContract: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    Left = 808
    Top = 592
    Data = {03000000000000000000}
  end
  object ds2: TDataSource
    DataSet = qSendedContract
    Left = 808
    Top = 544
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 896
    Top = 432
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.RootCertFile = 'C:\1\my2.pem'
    SSLOptions.CertFile = 'C:\1\my2.pem'
    SSLOptions.KeyFile = 'C:\1\my2.pem'
    SSLOptions.Method = sslvSSLv3
    SSLOptions.SSLVersions = [sslvSSLv3]
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = [sslvrfClientOnce]
    SSLOptions.VerifyDepth = 0
    SSLOptions.VerifyDirs = 'c:\1'
    OnVerifyPeer = IdSSLIOHandlerSocketOpenSSL1VerifyPeer
    Left = 896
    Top = 488
  end
  object HTTPRIO1: THTTPRIO
    OnAfterExecute = HTTPRIO1AfterExecute
    OnBeforeExecute = HTTPRIO1BeforeExecute
    WSDLLocation = 'C:\WORK\Lontana\trunk\RobotDOL\DOLBeline.wsdl'
    Service = 'DOLService'
    Port = 'DOLServiceSoap12'
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    HTTPWebNode.WebNodeOptions = []
    HTTPWebNode.ClientCertificate.CertName = 'c:\1\ExportCert.cer'
    HTTPWebNode.ClientCertificate.Issuer = 'Vimpelcom ExternalCA'
    HTTPWebNode.OnBeforePost = HTTPRIO1HTTPWebNode1BeforePost
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Converter.TempDir = 'c:\1\'
    Left = 896
    Top = 592
  end
  object HTTPReqResp1: THTTPReqResp
    UseUTF8InHeader = True
    InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    WebNodeOptions = []
    Left = 896
    Top = 544
  end
  object con1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=DB.md' +
      'b;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB:Sys' +
      'tem database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Pa' +
      'ssword="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mod' +
      'e=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Tr' +
      'ansactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create' +
      ' System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLED' +
      'B:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without R' +
      'eplica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 288
    Top = 264
  end
  object qryInsertContract: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pDateCreate'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pUserId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPointCode'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCode'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pABSCode'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pStatus'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pShortName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pClientVersion'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPaysystemsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBillcyclesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCustomerTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCustomerResident'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCustomerRatepayer'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCustomerSpheresId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCountry'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPlaceTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPlaceName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pStreetTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pStreetName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pHouse'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBuildingTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRoomTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRoom'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDeliveryTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pContactSexTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pContactFIO'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pContactPhonePrefix'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pContactPhoneNumber'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCorpConnStartId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCorpConnEndId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPhone'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pAddOption'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pIsTransferNumber'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDate'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO CONTRACTS( DateCreate,UserId,PointCode,Code,ABSCode,' +
        'Status,ShortName,ClientVersion,PaysystemsId,BillcyclesId,Custome' +
        'rTypesId,CustomerResident,CustomerRatepayer,CustomerSpheresId,Co' +
        'untry,PlaceTypesId,PlaceName,StreetTypesId,StreetName,House,Buil' +
        'dingTypesId,RoomTypesId,Room,DeliveryTypesId,ContactSexTypesId,C' +
        'ontactFIO,ContactPhonePrefix,ContactPhoneNumber, CorpConnStartId' +
        ', CorpConnEndId, Phone, AddOption,IsTransferNumber, [Date])'
      
        'VALUES( :pDateCreate,:pUserId,:pPointCode,:pCode,:pABSCode,:pSta' +
        'tus,:pShortName,:pClientVersion,:pPaysystemsId,:pBillcyclesId,:p' +
        'CustomerTypesId,:pCustomerResident,:pCustomerRatepayer,:pCustome' +
        'rSpheresId,:pCountry,:pPlaceTypesId,:pPlaceName,:pStreetTypesId,' +
        ':pStreetName,:pHouse,:pBuildingTypesId,:pRoomTypesId,:pRoom,:pDe' +
        'liveryTypesId,:pContactSexTypesId,:pContactFIO,:pContactPhonePre' +
        'fix, :pContactPhoneNumber, :pCorpConnStartId, :pCorpConnEndId, :' +
        'pPhone, :pAddOption,:pIsTransferNumber, :pDate)')
    Left = 432
    Top = 176
  end
  object qDeleteContract: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'delete from CONTRACTS'
      'where id = :pContractsID')
    Left = 744
    Top = 176
  end
  object qryGetContractID: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pCode'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pContactFIO'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDATE'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select cn.ID'
      'from  CONTRACTS cn'
      'where cn.Code = :pCode'
      '  and cn.ContactFIO = :pContactFIO'
      '  and cn.Date = :pDATE')
    Left = 544
    Top = 176
  end
  object qryInserCustomer_INFO: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pINN'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pSexTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pLastName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pFirstName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pSecondName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDocTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDocSeria'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDocNumber'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDocGivenBy'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pDocDate'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBirthday'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO CUSTOMER_PERSON ( ContractsId, TypesId, INN, SexType' +
        'sId, LastName, FirstName, SecondName, DocTypesId, DocSeria, DocN' +
        'umber, DocGivenBy, DocDate, Birthday)'
      
        'VALUES (:pContractsId,  :pTypesId, :pINN, :pSexTypesId, :pLastNa' +
        'me, :pFirstName, :pSecondName, :pDocTypesId, :pDocSeria, :pDocNu' +
        'mber, :pDocGivenBy, :pDocDate, :pBirthday)')
    Left = 432
    Top = 232
  end
  object qryInsertDeleveryAddres: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pZIP'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCountry'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRegion'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pArea'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPlaceTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPlaceName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pStreetTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pStreetName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pHouse'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBuildingTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBuilding'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRoomTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRoom'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO DELIVERYADDRESSES ( ContractsId, ZIP, Country, Regio' +
        'n, Area, PlaceTypesId, PlaceName, StreetTypesId, StreetName, Hou' +
        'se, BuildingTypesId, Building, RoomTypesId, Room )'
      
        'VALUES (:pContractsId, :pZIP, :pCountry, :pRegion, :pArea, :pPla' +
        'ceTypesId, :pPlaceName, :pStreetTypesId, :pStreetName, :pHouse, ' +
        ':pBuildingTypesId, :pBuilding, :pRoomTypesId, :pRoom)')
    Left = 432
    Top = 288
  end
  object qryInsertConnection: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pCellnetsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pProductsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pPhoneOwner'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pSerNumberTA'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pSimLock'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pIMSI'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO CONNECTIONS ( ContractsId, CellnetsId, ProductsId, P' +
        'honeOwner, SerNumberTA, SimLock, IMSI )'
      
        'VALUES (:pContractsId, :pCellnetsId, :pProductsId, :pPhoneOwner,' +
        ' :pSerNumberTA, :pSimLock, :pIMSI)')
    Left = 432
    Top = 360
  end
  object qryInsertLOGPARAMS: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pLogParamId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO LOGPARAMS(ContractsId, LogParamId) '
      'values(:pContractsId, :pLogParamId) ')
    Left = 436
    Top = 416
  end
  object qryGetIMSI: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pPHONE'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select l.SerNum, '
      '           (select b.id '
      '              from L_BILLPLANS_7 b'
      '             where b.code = l.SOC '
      '           ) as tariff_code'
      'from l_links_9 l'
      'where l.snb = :pPHONE ')
    Left = 552
    Top = 288
  end
  object qryGetConnectionID: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select cn.ID'
      'from  CONNECTIONS cn'
      'where cn.ContractsId = :pContractsId')
    Left = 552
    Top = 352
  end
  object qryInsertMobile: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pConnectionsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pChannelTypesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pChannelLensId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pSNB'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBillplansId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pBillPlanSclad'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pTransferSNB'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pHLR'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pOperator'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pOperatorID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pRegion'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO MOBILES ( ConnectionsId, ChannelTypesId, ChannelLens' +
        'Id, SNB, BillplansId, BillPlanSclad, TransferSNB, HLR, Operator,' +
        ' OperatorID, Region )'
      
        'VALUES (:pConnectionsId, :pChannelTypesId, :pChannelLensId, :pSN' +
        'B, :pBillplansId, :pBillPlanSclad, :pTransferSNB, :pHLR, :pOpera' +
        'tor, :pOperatorID, :pRegion)')
    Left = 436
    Top = 480
  end
  object qryInsertServices: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pMobilesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pServicesId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO SERVICES ( MobilesId, ServicesId )'
      'VALUES (:pMobilesId, :pServicesId);')
    Left = 436
    Top = 552
  end
  object qryGetTP_Services: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pbillplansid'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select lb.ServicesID'
      'from L_BPLANSERVICES lb'
      'where lb.billplansid = :pBillPlansID'
      '   and  lb.MANDATORY = 1')
    Left = 552
    Top = 552
  end
  object qryGetMobilesID: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pConnectionsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select m.ID'
      'from  MOBILES m'
      'where m.ConnectionsId = :pConnectionsId')
    Left = 552
    Top = 480
  end
  object qDeleteСustomerInfo: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pContractsID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'delete from CUSTOMER_PERSON'
      'where ContractsID = :pContractsID')
    Left = 744
    Top = 240
  end
  object qDeleteDeleveryAddres: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pContractsId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'DELETE FROM DELIVERYADDRESSES WHERE ContractsId= :pContractsId')
    Left = 744
    Top = 296
  end
  object qDeleteConnection: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pContracstId'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'DELETE FROM CONNECTIONS'
      'WHERE ContractsId = :pContracstId')
    Left = 744
    Top = 360
  end
  object qDeleteLOGPARAMS: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pContractsId'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'delete from LOGPARAMS'
      'where ContractsId = :pContractsId')
    Left = 744
    Top = 416
  end
  object qDeleteMobile: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pMobilesID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'delete from MOBILES where id = :pMobilesID')
    Left = 744
    Top = 472
  end
  object qDeleteServices: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pMobilesID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'delete from SRVICES'
      'where MobilesID = :pMobilesID')
    Left = 744
    Top = 536
  end
  object qryPrintContracts: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'PCODE'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'SELECT (SELECT L.NAME'
      #9#9' FROM L_SPHERES L'
      #9#9' WHERE L.ID = C.CUSTOMERSPHERESID'
      #9'   ) AS SPHERES_NAME'
      #9'  ,CP.LASTNAME AS SURNAME'#9'  '
      #9'  ,CP.FIRSTNAME AS NAME'
      #9'  ,CP.SECONDNAME AS PATRONYMIC'
      #9'  ,DT.NAME AS DOCUM_NAME'
      #9'  ,CP.DOCSERIA AS DOC_SER'
      #9'  ,CP.DOCNUMBER AS DOC_NUM'
      #9'  ,CP.DOCGIVENBY AS DOC_ISSUE'
      #9'  ,CP.DOCDATE AS DOC_DATE'#9'  '
      #9'  ,CP.BIRTHDAY AS BIRTH_DATE'#9'  '
      
        #9'  ,C.POINTCODE, C.CODE, C.STATUS, C.DATE, C.ABSCODE, C.ABSDATE,' +
        ' C.COMMENTS, C.CLIENTVERSION, C.PAYSYSTEMSID, C.BILLCYCLESID'
      
        #9'  ,C.CUSTOMERTYPESID, C.CUSTOMERRESIDENT, C.CUSTOMERRATEPAYER, ' +
        'C.CUSTOMERSPHERESID'
      #9'  ,C.ZIP'
      #9'  ,C.COUNTRY'
      #9'  ,C.REGION'
      #9'  ,C.AREA'
      #9'  ,(select l.NAME '
      ' '#9#9'  from L_PLACETYPES l'
      #9#9' where l.id = c.PLACETYPESID'
      #9'   ) as PLACE_TYPES_NAME'
      #9'  ,C.PLACENAME'#9'   '
      #9'  ,(SELECT L.NAME'
      #9'      FROM L_STREETTYPES L'
      #9#9' WHERE L.ID = C.STREETTYPESID'
      #9'  ) AS STREET_TYPE_NAME'
      #9'  ,C.STREETNAME'
      #9'  ,(select name'
      #9#9'  from l_BUILDINGTYPES l'
      #9#9' where l.id = c.BUILDINGTYPESID'
      #9'   ) as BUILDINGTYPESNAME'
      #9'  ,C.HOUSE'
      #9'  ,C.BUILDING'
      #9'  ,C.ROOMTYPESID'
      #9'  ,C.ROOM'
      #9'  ,C.DELIVERYNOTES'
      #9'  ,(SELECT L.NAME'
      #9'      FROM L_DELIVERYTYPES L'
      #9#9' WHERE C.DELIVERYTYPESID = L.ID'
      #9'   ) AS DELIVERY_TYPES_NAME'
      #9'  ,C.CONTACTSEXTYPESID'
      #9'  ,C.CONTACTFIO AS FIO'
      #9'  ,C.CONTACTPHONEPREFIX AS PHONE_PREFIX'
      #9'  ,C.CONTACTPHONENUMBER AS PHONE_NUMBER'
      #9'  ,(SELECT l.SerNum'
      #9'      FROM L_LINKS l'
      #9#9' WHERE l.snb = c.Phone'
      #9'  ) as SIM_ID'
      #9'  ,(select l.NAME+'#39'['#39'+L.CODE +'#39']'#39
      #9'      from L_BILLPLANS_7 l'#9
      #9#9#9'  ,MOBILES MOB'#9#9#9'  '
      #9#9' where MOB.CONNECTIONSID = CON.ID'
      #9#9'   AND MOB.BILLPLANSID = L.ID'
      #9'  ) AS TARIFF_PLAN'
      #9'  ,C.CONTACTFAXPREFIX'
      #9'  ,C.CONTACTFAXNUMBER'
      #9'  ,C.CONTACTEMAIL'
      #9'  ,C.CONTACTNOTES'
      #9'  ,C.BAN'
      #9'  ,C.CORPBILLPLANID'
      #9'  ,C.CORPCONNSTARTID'
      #9'  ,C.CORPCONNENDID'
      #9'  ,C.BEN'
      #9'  ,C.ADDOPTION'
      #9'  ,c.id'
      '                  ,C.ISTRANSFERNUMBER'
      'FROM CONTRACTS C'
      #9',CUSTOMER_PERSON CP'
      #9',L_DOCTYPES DT'
      #9',CONNECTIONS CON'
      'WHERE c.CODE = :PCODE'
      '  and  c.id = cp.contractsid'
      '  AND DT.ID = CP.DOCTYPESID'
      '  AND C.ID = CON.ContractsID')
    Left = 40
    Top = 368
  end
  object qryServicesList: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pContractID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select l.CODE'
      '  FROM CONTRACTS C'
      #9'  ,CONNECTIONS CON'
      #9'  ,MOBILES MOB'#9#9
      #9'  ,SERVICES SER'#9#9'  '
      #9'  ,L_SERVICES L'
      ' WHERE C.ID = :pContractID'
      '   AND C.ID = CON.CONTRACTSID'
      '   AND CON.ID = MOB.CONNECTIONSID'
      '   AND MOB.ID = SER.MOBILESID'
      '   AND SER.SERVICESID = L.ID'
      ' ORDER BY L.ID')
    Left = 128
    Top = 368
  end
  object qryContractListInterval: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pStartNum'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'pEndNum'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select cn.code'
      'from contracts cn'
      'where int(cn.code) >= int(:pStartNum)'
      '    and int(cn.code) <= int(:pEndNum)')
    Left = 232
    Top = 368
  end
  object qGetDocTypeID: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'pDocTypeName'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select ID'
      'from L_DOCTYPES LD'
      'where LD.NAME = :pDocTypeName')
    Left = 309
    Top = 552
  end
end
