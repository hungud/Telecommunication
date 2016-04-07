object BeelineLoadForm: TBeelineLoadForm
  Left = 0
  Top = 0
  Caption = 'BeelineLoadForm'
  ClientHeight = 358
  ClientWidth = 924
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
  object mData: TMemo
    Left = 0
    Top = 97
    Width = 924
    Height = 244
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 924
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pAccountCaption: TPanel
      Left = 0
      Top = 0
      Width = 57
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      Caption = #1051'/'#1089#1095#1105#1090':'
      TabOrder = 0
    end
    object lbAccount: TListBox
      Left = 57
      Top = 0
      Width = 176
      Height = 97
      Align = alLeft
      ItemHeight = 13
      TabOrder = 1
    end
    object pPeriodCaption: TPanel
      Left = 233
      Top = 0
      Width = 64
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      Caption = #1055#1077#1088#1080#1086#1076':'
      TabOrder = 2
    end
    object lbPeriods: TListBox
      Left = 297
      Top = 0
      Width = 96
      Height = 97
      Align = alLeft
      ItemHeight = 13
      TabOrder = 3
    end
    object Panel4: TPanel
      Left = 393
      Top = 0
      Width = 344
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      object btnLoad: TButton
        Left = 8
        Top = 50
        Width = 145
        Height = 41
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100'!'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnLoadClick
      end
      object GroupBox2: TGroupBox
        Left = 6
        Top = 3
        Width = 299
        Height = 41
        TabOrder = 1
        Visible = False
        object Label2: TLabel
          Left = 3
          Top = 17
          Width = 73
          Height = 13
          Caption = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DSComboBox: TDBLookupComboBox
          Left = 81
          Top = 12
          Width = 215
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          KeyField = 'DOP_STATUS_ID'
          ListField = 'DOP_STATUS_NAME'
          ListSource = dsDopSt
          TabOrder = 0
        end
      end
      object BitBtn1: TBitBtn
        Left = 159
        Top = 50
        Width = 146
        Height = 41
        Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
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
          FF00FF00FF00FF00FF00535E54008694880046574900728574003C523F006E84
          710039533C0076907900506D54007D9A81003E5D420073927500325533006889
          67004C6A4D0089A08A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00839185002F40320074877600435946006C866F004764
          4B00739077002E4D320069886D003A5C3E00698B6D00315634007EAA81002852
          2900698C6A00304E3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00445547007D907F00E2F8E500EFFFF200EDFFF100E7FF
          EB00EAFFEE00EAFFEE00E8FFED00E8FFED00E8FFED00E4FFEA00D7FFDA00E1FF
          E300315B32006F906E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00738A74003B583E00ECFFED00D4F9D700E6FFEA00DDFF
          E200E4FFE900DEFFE400DFFFE500598A5E003A6B3F0062936500326735005B90
          5E0077A479002D532F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0040613E00608B5E00E1FFE000245E240065A268002666
          2B005C9E63001B5D220055975C0026692C00D8FFDB001F5D210058935900386D
          3B00214F2400658B6700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00678B610040713900DFFFD80061A25D00145A1400569E
          5800337C38005EA965002E773300D3FFD60019621A0067AD67003B773B00D1FF
          D40078A67B00486E4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF003D5E310068955C00DAFFCD00306C260072B16B002D70
          2B00468C46001F651F00D8FFD600185C15005799510023641F005C965B00D8FF
          D9001E4B20006D927000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00829F7800496F3F00DFFFD500E1FFD900255D2200528C
          51003A753B00DAFFDC002662260069A5680035713100669F6200265D2600E1FF
          E30069936A0035583600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF003043300065816300EAFFEA00E2FFE500E3FFE9004574
          4D00D0FFDB002F603A005F8E68002C5B340065936800DFFFE000DFFFE000DCFF
          DD00365D370079997A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0070836E0055715300EAFFEA00E4FFE70025502B00E3FF
          EA002C5A36006E9C7800335F3A00618D660039653C00719E7300E3FFE500E4FF
          E5005D815D004C6A4D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0049643C0072976500E5FFD80033622A00E4FFDF003365
          2F0071A26E001F501C0063945E0044753D006D9D630037662E0076A27300DCFF
          DD0053745200627D6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF007A9B6F00395F2D00E2FFD90070A16900366832005E8F
          5B00366735006B9C6A00E4FFE0006596600038652C0065915C002C522800ECFF
          EA0058775800455F4700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0038573C00698E6C00E1FFE700305F390053805F004A76
          57005A866900D8FFE500E4FFEE00DDFFE400678E68002F542E0070916E00E9FF
          E9003F5A40007F968000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0083A48900284F2F00E3FFEB00E1FFEB00E1FFEE00D9FF
          E800DDFFED00E1FFEF00E4FFF000E5FFEC00EAFFEB00ECFFEA00EFFFED00E7FF
          E400768E7600364B3500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0034582C0077A17100265524006798660039683A00618F
          64003A663D006E986F00244C2200668D5F00426637005F8053003C5736008197
          7F004F644E007C8F7C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF006A8962003F63370085AE8100244D2000557F5600436C
          460074987400375835007B9C77004A683F00708C610047623A0083997D004154
          3F007184710039493800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
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
        TabOrder = 2
        WordWrap = True
        OnClick = BitBtn1Click
      end
      object pBlockUnblock: TPanel
        Left = 4
        Top = 0
        Width = 341
        Height = 44
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 3
        object Label1: TLabel
          Left = 214
          Top = 4
          Width = 100
          Height = 13
          Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1074' 10:00'
        end
        object Label3: TLabel
          Left = 214
          Top = 22
          Width = 117
          Height = 13
          Caption = #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1074' 13:00'
        end
        object rgBlockUnblock: TRadioGroup
          Left = 1
          Top = -4
          Width = 200
          Height = 42
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
            #1056#1072#1079#1073#1083#1086#1082#1080#1088#1086#1074#1082#1072)
          TabOrder = 0
        end
      end
    end
    object BitBtn2: TBitBtn
      Left = 716
      Top = 50
      Width = 203
      Height = 41
      Caption = #1047#1072#1082#1088#1099#1090#1100' 9999 '#1082#1086#1085#1090#1088#1072#1082#1090#1086#1074
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Visible = False
      OnClick = BitBtn2Click
    end
  end
  object pProgress: TProgressBar
    Left = 0
    Top = 341
    Width = 924
    Height = 17
    Align = alBottom
    Style = pbstMarquee
    MarqueeInterval = 3
    TabOrder = 2
  end
  object qAccounts: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  ACCOUNTS.ACCOUNT_ID,'
      '  ACCOUNTS.LOGIN '
      'FROM '
      '  ACCOUNTS, '
      '  OPERATORS'
      'WHERE '
      '  ACCOUNTS.OPERATOR_ID=OPERATORS.OPERATOR_ID'
      '  AND OPERATORS.LOADER_SCRIPT_NAME='#39'beeline'#39
      'ORDER BY '
      '  ACCOUNTS.LOGIN')
    ReadOnly = True
    Left = 120
    Top = 120
  end
  object dgOpen: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080'|*.xls;*.csv;*.zip;*.xlsx'
    Left = 328
    Top = 120
  end
  object dsContarct: TDataSource
    DataSet = qContract
    Left = 456
    Top = 128
  end
  object qContract: TOraQuery
    SQL.Strings = (
      'SELECT '
      
        '  TRIM(A.SURNAME) || '#39' '#39' || TRIM(A.NAME) || '#39' '#39' || TRIM(A.PATRON' +
        'YMIC) || '#39' ('#1076'.'#1088'. '#39' ||  TO_CHAR(A.BDATE, '#39'DD.MM.YYYY'#39') || '#39')'#39' ABO' +
        'NENT_INFO,'
      '  O.OPERATOR_NAME,'
      '  C.CONTRACT_NUM,'
      '  C.CONTRACT_DATE,'
      '  C.PHONE_NUMBER_FEDERAL,'
      '  C.ABONENT_ID,'
      '  C.CONTRACT_ID,'
      '  C.CONTRACT_CHANGE_DATE,'
      '  C.CONTRACT_CANCEL_DATE'
      ' FROM V_CONTRACTS C'
      '     ,ABONENTS A'
      '     ,OPERATORS O'
      'WHERE C.ABONENT_ID = A.ABONENT_ID (+)'
      '  AND C.OPERATOR_ID = O.OPERATOR_ID (+)'
      '  AND C.CONTRACT_ID = :CONTRACT_ID')
    Left = 456
    Top = 184
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CONTRACT_ID'
        Value = 21
      end>
  end
  object qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_CONTRACT_CANCEL_ID'
    Left = 552
    Top = 241
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_CONTRACT_CANCEL_ID:0'
  end
  object qContractCancel: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT CC.*'
      ' FROM CONTRACT_CANCELS CC'
      'WHERE CC.CONTRACT_CANCEL_ID = :CONTRACT_CANCEL_ID')
    Left = 552
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_CANCEL_ID'
      end>
  end
  object dsContractCancel: TDataSource
    DataSet = qContractCancel
    Left = 552
    Top = 128
  end
  object qDopSt: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT NULL dop_status_id, '#39'   '#39' dop_status_name'
      '  FROM DUAL'
      'UNION ALL'
      
        'select ds.dop_status_id,ds.dop_status_name from CONTRACT_DOP_STA' +
        'TUSES ds')
    Left = 112
    Top = 256
  end
  object dsDopSt: TOraDataSource
    DataSet = qDopSt
    Left = 152
    Top = 256
  end
  object qChangeDS: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'UPDATE contracts SET dop_status = :DOP_STATUS'
      'WHERE contract_id = :CONTRACT_ID')
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOP_STATUS'
      end
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
end
