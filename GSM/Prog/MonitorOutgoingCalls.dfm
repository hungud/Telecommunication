object MonitorOutgoingCallsFrm: TMonitorOutgoingCallsFrm
  Left = 0
  Top = 0
  Caption = #1052#1086#1085#1080#1090#1086#1088' '#1080#1089#1093#1086#1076#1103#1097#1077#1081' '#1089#1074#1103#1079#1080
  ClientHeight = 627
  ClientWidth = 1143
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pMAIN: TPanel
    Left = 0
    Top = 0
    Width = 1143
    Height = 627
    Align = alClient
    TabOrder = 0
    object spl1: TSplitter
      Left = 657
      Top = 99
      Width = 2
      Height = 527
      ExplicitLeft = 457
      ExplicitTop = 73
      ExplicitHeight = 558
    end
    object pInfoPanel: TPanel
      Left = 1
      Top = 1
      Width = 1141
      Height = 98
      Align = alTop
      TabOrder = 0
      object lbl1: TLabel
        Left = 32
        Top = 10
        Width = 112
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1084#1086#1085#1080#1090#1086#1088#1072': '
      end
      object lbl2: TLabel
        Left = 32
        Top = 36
        Width = 288
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1089#1073#1086#1088#1072' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' '#1074' '#1090#1077#1082#1091#1097#1077#1084' '#1087#1077#1088#1080#1086#1076#1077':'
      end
      object lblDateLastRun: TLabel
        Left = 369
        Top = 36
        Width = 5
        Height = 13
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStateMonitorInfo: TLabel
        Left = 190
        Top = 10
        Width = 5
        Height = 13
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object p1: TPanel
        Left = 1
        Top = 59
        Width = 1139
        Height = 38
        Align = alBottom
        TabOrder = 0
        object tlb1: TToolBar
          Left = 1
          Top = 0
          Width = 210
          Height = 38
          Align = alNone
          AutoSize = True
          BorderWidth = 1
          ButtonHeight = 30
          ButtonWidth = 31
          Caption = 'tlb1'
          EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
          Images = MainForm.ImageList24
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object btnInsert: TToolButton
            Left = 0
            Top = 0
            ImageIndex = 4
            OnClick = btnInsertClick
          end
          object btnEdit: TToolButton
            Left = 31
            Top = 0
            ImageIndex = 6
            OnClick = btnEditClick
          end
          object btnDelete: TToolButton
            Left = 62
            Top = 0
            ImageIndex = 5
            OnClick = btnDeleteClick
          end
          object btnPost: TToolButton
            Left = 93
            Top = 0
            ImageIndex = 7
            OnClick = btnPostClick
          end
          object btn4: TToolButton
            Left = 124
            Top = 0
            Width = 8
            Caption = 'btn4'
            ImageIndex = 10
            Style = tbsSeparator
          end
          object btnCancel: TToolButton
            Left = 132
            Top = 0
            ImageIndex = 8
            Visible = False
            OnClick = btnCancelClick
          end
          object btn7: TToolButton
            Left = 163
            Top = 0
            Width = 8
            Caption = 'btn7'
            ImageIndex = 10
            Style = tbsSeparator
          end
          object btnRefresh: TToolButton
            Left = 171
            Top = 0
            Hint = #1054#1073#1085#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1088#1072#1074#1080#1083
            ImageIndex = 9
            OnClick = btnRefreshClick
          end
        end
        object btRefreshMonitor: TBitBtn
          Left = 594
          Top = 3
          Width = 208
          Height = 30
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1084#1086#1085#1080#1090#1086#1088#1072
          DoubleBuffered = False
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
          TabOrder = 1
          OnClick = btRefreshMonitorClick
        end
        object chkGroupPhone: TCheckBox
          Left = 234
          Top = 10
          Width = 279
          Height = 17
          Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1087#1086' '#1087#1088#1072#1074#1080#1083#1072#1084
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          OnClick = chkGroupPhoneClick
        end
        object btLoadInExcel: TBitBtn
          Left = 830
          Top = 3
          Width = 169
          Height = 30
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
          TabOrder = 3
          OnClick = btLoadInExcelClick
        end
      end
    end
    object pRulePanel: TPanel
      Left = 1
      Top = 99
      Width = 656
      Height = 527
      Align = alLeft
      TabOrder = 1
      object grpRule: TGroupBox
        Left = 1
        Top = 1
        Width = 654
        Height = 525
        Align = alClient
        Caption = #1055#1088#1072#1074#1080#1083#1072' '#1088#1072#1073#1086#1090#1099' '#1084#1086#1085#1080#1090#1086#1088#1072': '
        TabOrder = 0
        ExplicitWidth = 550
        object g1: TCRDBGrid
          Left = 2
          Top = 15
          Width = 650
          Height = 508
          Align = alClient
          DataSource = dsRules
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'TARIFF_NAME'
              Title.Alignment = taCenter
              Title.Caption = #1058#1040#1056#1048#1060
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TURN_ON_NAME'
              Title.Alignment = taCenter
              Title.Caption = #1055#1088#1072#1074#1080#1083#1086' '#1076#1077#1081#1089#1090#1074#1091#1077#1090
              Width = 104
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_NO_PAY_ALL'
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1073#1077#1089#1087#1083#1072#1090#1085#1099#1093' | '#1042#1089#1077
              Width = 41
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_NO_PAY_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1073#1077#1089#1087#1083#1072#1090#1085#1099#1093' | '#1090#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
              Width = 82
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_NO_PAY_OTHER'
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1073#1077#1089#1087#1083#1072#1090#1085#1099#1093' | '#1076#1088#1091#1075#1080#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1099
              Width = 102
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_PAY_ALL'
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1087#1083#1072#1090#1085#1099#1093' | '#1042#1089#1077
              Width = 44
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_PAY_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1087#1083#1072#1090#1085#1099#1093' | '#1090#1086#1083#1100#1082#1086'  '#1041#1080#1083#1072#1081#1085
              Width = 89
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_CALL_PAY_OTHER'
              Title.Caption = '   '#1051#1080#1084#1080#1090#1099' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1084#1080#1085#1091#1090' | '#1087#1083#1072#1090#1085#1099#1093' | '#1076#1088#1091#1075#1080#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1099
              Width = 111
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_OUT_SMS'
              Title.Alignment = taCenter
              Title.Caption = #1051#1080#1084#1080#1090#1099' '#1080#1089#1093'. '#1057#1052#1057
              Width = 102
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIMIT_INET_TRAFFIC'
              Title.Alignment = taCenter
              Title.Caption = #1051#1080#1084#1080#1090' '#1080#1085#1090#1077#1088#1085#1077#1090' '#1090#1088#1072#1092#1080#1082#1072' |'#1043#1080#1075#1072#1073#1072#1081#1090
              Width = 141
              Visible = True
            end>
        end
      end
    end
    object pPhoneList: TPanel
      Left = 659
      Top = 99
      Width = 483
      Height = 527
      Align = alClient
      TabOrder = 2
      ExplicitLeft = 555
      ExplicitWidth = 587
      object grpPhoneList: TGroupBox
        Left = 1
        Top = 1
        Width = 481
        Height = 525
        Align = alClient
        Caption = #1057#1087#1080#1089#1086#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1087#1088#1072#1074#1080#1083#1072': '
        TabOrder = 0
        ExplicitWidth = 585
        object g2: TCRDBGrid
          Left = 2
          Top = 15
          Width = 477
          Height = 508
          Align = alClient
          DataSource = dsPhoneList
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
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1088
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CONTRACT_CANCEL_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072
              Width = 69
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TARIFF_NAME'
              Title.Alignment = taCenter
              Title.Caption = #1058#1072#1088#1080#1092
              Width = 116
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_IN_NO_PAID'
              Title.Alignment = taCenter
              Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
              Width = 71
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_IN_NO_PAID_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085' '
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_OUT_NO_PAID'
              Title.Alignment = taCenter
              Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_OUT_NO_PAID_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = #1041#1077#1089#1087#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
              Width = 99
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_IN_YES_PAID'
              Title.Alignment = taCenter
              Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
              Width = 77
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_IN_YES_PAID_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1042#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_OUT_YES_PAID'
              Title.Alignment = taCenter
              Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1042#1089#1077' '
              Width = 79
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DURATION_OUT_YES_PAID_ONLY_BEE'
              Title.Alignment = taCenter
              Title.Caption = #1055#1083#1072#1090#1085#1086' | '#1048#1089#1093#1086#1076#1103#1097#1080#1077' ('#1084#1080#1085') | '#1058#1086#1083#1100#1082#1086' '#1041#1080#1083#1072#1081#1085
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SMS_OUT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' ('#1096#1090'.) | '#1057#1052#1057' '
              Width = 62
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MMS_OUT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' ('#1096#1090'.) | '#1052#1052#1057' '
              Width = 74
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INTERNET_TRAFFIC'
              Title.Caption = #1048#1085#1090#1077#1088#1085#1077#1090' '#1090#1088#1072#1092#1080#1082' ('#1043#1041')'
              Width = 122
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
    end
  end
  object dsRules: TDataSource
    DataSet = qRules
    OnDataChange = dsRulesDataChange
    Left = 176
    Top = 264
  end
  object dsPhoneList: TDataSource
    DataSet = qPhoneList
    Left = 688
    Top = 328
  end
  object qRules: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT '
      '  CM.RULE_FOR_CALLS_MONITOR_ID,'
      '  CM.TARIFF_ID,'
      '  CM.LIMIT_OUT_CALL_NO_PAY_ALL,  '
      '  CM.LIMIT_OUT_CALL_NO_PAY_ONLY_BEE, '
      '  CM.LIMIT_OUT_CALL_NO_PAY_OTHER,'
      '  CM.LIMIT_OUT_CALL_PAY_ALL,'
      '  CM.LIMIT_OUT_CALL_PAY_ONLY_BEE, '
      '  CM.LIMIT_OUT_CALL_PAY_OTHER, '
      '  CM.LIMIT_OUT_SMS, '
      '  CM.LIMIT_INET_TRAFFIC,'
      '  CM.TURN_ON,'
      '  decode(CM.TURN_ON, 1, '#39#1044#1072#39', 0, '#39#1053#1077#1090#39') TURN_ON_Name,'
      '  TAR.TARIFF_NAME'
      'FROM RULE_FOR_CALLS_MONITOR CM'
      '    ,TARIFFS TAR'
      'WHERE CM.TARIFF_ID = TAR.TARIFF_ID'
      'order by TAR.TARIFF_NAME desc')
    BeforeClose = qRulesBeforeClose
    BeforePost = qRulesBeforePost
    Left = 176
    Top = 200
    object qReportRulesRULE_FOR_CALLS_MONITOR_ID: TFloatField
      FieldName = 'RULE_FOR_CALLS_MONITOR_ID'
      Required = True
    end
    object qReportRulesTARIFF_ID: TFloatField
      FieldName = 'TARIFF_ID'
    end
    object qReportRulesLIMIT_INET_TRAFFIC: TFloatField
      FieldName = 'LIMIT_INET_TRAFFIC'
    end
    object intgrfldRulesTURN_ON: TIntegerField
      FieldName = 'TURN_ON'
    end
    object qRulesTARIFF_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'TARIFF_NAME'
      LookupDataSet = qTariffs
      LookupKeyFields = 'TARIFF_ID'
      LookupResultField = 'TARIFF_NAME'
      KeyFields = 'TARIFF_ID'
      Size = 150
      Lookup = True
    end
    object qReportRulesLIMIT_OUT_SMS: TFloatField
      FieldName = 'LIMIT_OUT_SMS'
    end
    object qRulesTURN_ON_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'TURN_ON_NAME'
      LookupDataSet = qYesNo
      LookupKeyFields = 'TURN_ON'
      LookupResultField = 'TURN_ON_NAME'
      KeyFields = 'TURN_ON'
      Size = 6
      Lookup = True
    end
    object qReportRulesLIMIT_OUT_CALL_NO_PAY_ONLY_BEE: TFloatField
      FieldName = 'LIMIT_OUT_CALL_NO_PAY_ONLY_BEE'
    end
    object qReportRulesLIMIT_OUT_CALL_NO_PAY_OTHER: TFloatField
      FieldName = 'LIMIT_OUT_CALL_NO_PAY_OTHER'
    end
    object qReportRulesLIMIT_OUT_CALL_PAY_ONLY_BEE: TFloatField
      FieldName = 'LIMIT_OUT_CALL_PAY_ONLY_BEE'
    end
    object qReportRulesLIMIT_OUT_CALL_PAY_OTHER: TFloatField
      FieldName = 'LIMIT_OUT_CALL_PAY_OTHER'
    end
    object qReportRulesLIMIT_OUT_CALL_NO_PAY_ALL: TFloatField
      FieldName = 'LIMIT_OUT_CALL_NO_PAY_ALL'
    end
    object qReportRulesLIMIT_OUT_CALL_PAY_ALL: TFloatField
      FieldName = 'LIMIT_OUT_CALL_PAY_ALL'
    end
  end
  object qPhoneList: TOraQuery
    SQL.Strings = (
      'select V.CONTRACT_DATE, '
      '       V.CONTRACT_CANCEL_DATE, '
      '       V.CONTRACT_ID, '
      '       V.TARIFF_ID, '
      '       V.DURATION_OUT_NO_PAID, '
      '       V.DURATION_OUT_NO_PAID_ONLY_BEE, '
      '       V.DURATION_IN_NO_PAID, '
      '       V.DURATION_IN_NO_PAID_ONLY_BEE, '
      '       V.DURATION_IN_YES_PAID, '
      '       V.DURATION_IN_YES_PAID_ONLY_BEE, '
      '       V.DURATION_OUT_YES_PAID, '
      '       V.DURATION_OUT_YES_PAID_ONLY_BEE, '
      '       v.INTERNET_TRAFFIC,'
      '       V.SMS_OUT, '
      '       V.MMS_OUT, '
      '       V.PHONE_NUMBER_FEDERAL, '
      '       V.TARIFF_NAME, '
      '       V.PHONE_IS_ACTIVE'
      'from V_MONITOR_OUTCALL_DATA  v'
      'where  ('
      
        '        (:pSHOW_ALL = 0 and v.RULE_FOR_CALLS_MONITOR_ID = :pMONI' +
        'TOR_ID)'
      '      or'
      '        (:pSHOW_ALL = 1)'
      '      )'
      '  '
      'ORDER BY V.TARIFF_NAME')
    Left = 680
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pSHOW_ALL'
      end
      item
        DataType = ftUnknown
        Name = 'pMONITOR_ID'
      end>
  end
  object qTariffs: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT TARIFF_ID, TARIFF_NAME'
      'FROM TARIFFS'
      'WHERE OPERATOR_ID=:OPERATOR_ID'
      'ORDER BY TARIFF_NAME')
    Left = 256
    Top = 200
    ParamData = <
      item
        DataType = ftInteger
        Name = 'OPERATOR_ID'
        Value = 3
      end>
  end
  object spGetNEW_RULE_FOR_CALL_MONITOR_ID: TOraStoredProc
    StoredProcName = 'NEW_RULE_FOR_CALL_MONITOR_ID'
    Session = MainForm.OraSession
    Left = 400
    Top = 200
    CommandStoredProcName = 'NEW_RULE_FOR_CALL_MONITOR_ID'
  end
  object spRunMonitor: TOraStoredProc
    StoredProcName = 'run_MONITOR_OUTGOING_CALLS'
    Session = MainForm.OraSession
    SQL.Strings = (
      'begin'
      '  run_MONITOR_OUTGOING_CALLS;'
      'end;')
    Left = 400
    Top = 256
    CommandStoredProcName = 'run_MONITOR_OUTGOING_CALLS'
  end
  object qDateLastRunMonitor: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'select TO_CHAR(MAX(CSC.DATE_LAST_UPDATED), '#39'YYYY.MM.DD HH24:MI:S' +
        'S '#39') DATE_LAST_UPDATED'
      'FROM CALL_SUMMARY_STAT CSC'
      'WHERE CSC.YEAR_MONTH = :pYEAR_MONTH')
    Left = 256
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pYEAR_MONTH'
      end>
  end
  object qMonitorStateInfo: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'select decode(DJ.STATE, '#39'SCHEDULED'#39', '
      
        '                        '#39#1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1084#1086#1085#1080#1090#1086#1088#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1086 +
        ' '#39' || to_char(from_tz( to_timestamp (to_char(DJ.LAST_START_DATE,' +
        #39'dd.mm.yyyy hh24:mi:ss'#39'),'#39'dd.mm.yyyy hh24:mi:ss'#39'),'#39'UTC'#39'),'#39'YYYY.M' +
        'M.DD HH24:MI:SS '#39'),'
      '                        '#39'RUNNING'#39','
      
        '                        '#39#1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1084#1086#1085#1080#1090#1086#1088#1072' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103'! '#1047#1072#1087#1091#1097#1077 +
        #1085#1086' '#1074' '#39'||to_char(from_tz( to_timestamp (to_char(DJ.LAST_START_DAT' +
        'E,'#39'dd.mm.yyyy hh24:mi:ss'#39'),'#39'dd.mm.yyyy hh24:mi:ss'#39'),'#39'UTC'#39'),'#39'YYYY' +
        '.MM.DD HH24:MI:SS '#39'),'
      '                        '#39#1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39
      '             ) State_info'
      '      ,dj.state'
      'from DBA_SCHEDULER_JOBS dj'
      'where DJ.JOB_NAME like '#39'J_CALC_CALL_SUMMARY_STAT'#39)
    Left = 256
    Top = 336
  end
  object qYesNo: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT TURN_ON, TURN_ON_Name'
      'FROM'
      '('
      '  SELECT 0 TURN_ON, '#39#1053#1077#1090#39' TURN_ON_Name FROM DUAL'
      '  UNION ALL'
      '  SELECT 1 TURN_ON, '#39#1044#1072#39' TURN_ON_Name FROM DUAL'
      ')')
    Left = 256
    Top = 264
  end
  object qGetCurrentPeriod: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'select CONVERT_PCKG.MONTH_NAME(mod(YEAR_MONTH, 100))||'#39' '#39'||trunc' +
        '(YEAR_MONTH/100) as MONTH_YEAR_STRING'
      'from '
      '  ('
      '    SELECT to_number( to_char(sysdate,'#39'yyyymm'#39') ) YEAR_MONTH '
      '    FROM DUAL'
      '  )')
    Left = 384
    Top = 336
  end
end
