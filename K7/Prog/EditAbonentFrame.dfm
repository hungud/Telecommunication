object EditAbonentFrme: TEditAbonentFrme
  Left = 0
  Top = 0
  Width = 494
  Height = 313
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 130
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      494
      130)
    object Label1: TLabel
      Left = 9
      Top = 8
      Width = 61
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 30
      Width = 30
      Height = 13
      Caption = #1048#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 51
      Width = 60
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 261
      Top = 8
      Width = 65
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 257
      Top = 30
      Width = 70
      Height = 13
      Caption = #1043#1088#1072#1078#1076#1072#1085#1089#1090#1074#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 10
      Top = 83
      Width = 86
      Height = 13
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SURNAME: TDBEdit
      Left = 96
      Top = 4
      Width = 141
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      DataField = 'SURNAME'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = DoChange
    end
    object NAME: TDBEdit
      Left = 96
      Top = 26
      Width = 141
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      DataField = 'NAME'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = DoChange
    end
    object PATRONYMIC: TDBEdit
      Left = 96
      Top = 47
      Width = 141
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      DataField = 'PATRONYMIC'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = DoChange
    end
    object BDATE: TDBEdit
      Left = 348
      Top = 4
      Width = 89
      Height = 21
      Anchors = [akTop, akRight]
      DataField = 'BDATE'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = BDATEChange
    end
    object CITIZENSHIP: TDBLookupComboBox
      Left = 344
      Top = 26
      Width = 138
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'CITIZENSHIP'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      KeyField = 'COUNTRY_ID'
      ListField = 'COUNTRY_NAME'
      ListSource = dsCitizens
      ParentFont = False
      TabOrder = 4
      OnClick = DoChange
    end
    object IS_VIP: TCheckBox
      Left = 261
      Top = 47
      Width = 84
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'VIP '#1082#1083#1080#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = DoChange
    end
    object ToolBar1: TToolBar
      Left = 355
      Top = 47
      Width = 129
      Height = 29
      Align = alNone
      Anchors = [akTop, akRight]
      ButtonHeight = 30
      ButtonWidth = 129
      Caption = 'ToolBar1'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = MainForm.ImageList24
      List = True
      ShowCaptions = True
      TabOrder = 6
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = aFindAbonent
        ImageIndex = 17
      end
    end
    object DESCRIPTION: TDBMemo
      Left = 96
      Top = 82
      Width = 386
      Height = 46
      DataField = 'DESCRIPTION'
      DataSource = dsMain
      TabOrder = 7
    end
  end
  object pPassport: TPanel
    Left = 0
    Top = 130
    Width = 494
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      494
      59)
    object Label6: TLabel
      Left = 9
      Top = 17
      Width = 34
      Height = 13
      Caption = #1057#1077#1088#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 257
      Top = 39
      Width = 59
      Height = 13
      Caption = #1050#1077#1084' '#1074#1099#1076#1072#1085':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 9
      Top = 39
      Width = 68
      Height = 13
      Caption = #1050#1086#1075#1076#1072' '#1074#1099#1076#1072#1085':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 257
      Top = 17
      Width = 37
      Height = 13
      Caption = #1053#1086#1084#1077#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 3
      Top = 4
      Width = 510
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object Label5: TLabel
      Left = 10
      Top = -2
      Width = 130
      Height = 13
      Caption = ' '#1055#1072#1089#1087#1086#1088#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PASSPORT_SER: TDBEdit
      Left = 96
      Top = 13
      Width = 150
      Height = 21
      DataField = 'PASSPORT_SER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = DoChange
    end
    object PASSPORT_GET: TDBEdit
      Left = 328
      Top = 35
      Width = 154
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'PASSPORT_GET'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = DoChange
    end
    object PASSPORT_NUM: TDBEdit
      Left = 328
      Top = 13
      Width = 154
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'PASSPORT_NUM'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = DoChange
    end
    object PASSPORT_DATE: TDBEdit
      Left = 96
      Top = 35
      Width = 81
      Height = 21
      DataField = 'PASSPORT_DATE'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = BDATEChange
    end
  end
  object GroupBox2: TPanel
    Left = 0
    Top = 189
    Width = 494
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      494
      75)
    object Label9: TLabel
      Left = 9
      Top = 16
      Width = 39
      Height = 13
      Caption = #1057#1090#1088#1072#1085#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 257
      Top = 14
      Width = 39
      Height = 13
      Caption = #1056#1077#1075#1080#1086#1085':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 9
      Top = 37
      Width = 33
      Height = 13
      Caption = #1043#1086#1088#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 257
      Top = 37
      Width = 35
      Height = 13
      Caption = #1059#1083#1080#1094#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 9
      Top = 58
      Width = 26
      Height = 13
      Caption = #1044#1086#1084':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 153
      Top = 58
      Width = 42
      Height = 13
      Caption = #1050#1086#1088#1087#1091#1089' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 257
      Top = 58
      Width = 51
      Height = 13
      Caption = #1050#1074#1072#1088#1090#1080#1088#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 3
      Top = 4
      Width = 510
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object Label19: TLabel
      Left = 10
      Top = -2
      Width = 67
      Height = 13
      Caption = ' '#1055#1088#1086#1087#1080#1089#1082#1072' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object COUNTRY_ID: TDBLookupComboBox
      Left = 96
      Top = 12
      Width = 150
      Height = 21
      DataField = 'COUNTRY_ID'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      KeyField = 'COUNTRY_ID'
      ListField = 'COUNTRY_NAME'
      ListSource = dsCountry
      ParentFont = False
      TabOrder = 0
      OnClick = DoChange
    end
    object REGION_ID: TDBLookupComboBox
      Left = 328
      Top = 12
      Width = 154
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'REGION_ID'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      KeyField = 'REGION_ID'
      ListField = 'R.REGION_NAME||'#39'('#39'||C.COUNTRY_NAME||'#39')'#39
      ListSource = dsRegions
      ParentFont = False
      TabOrder = 1
      OnClick = DoChange
    end
    object CITY_NAME: TDBEdit
      Left = 96
      Top = 33
      Width = 150
      Height = 21
      DataField = 'CITY_NAME'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = DoChange
    end
    object STREET_NAME: TDBEdit
      Left = 328
      Top = 33
      Width = 154
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'STREET_NAME'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = DoChange
    end
    object HOUSE: TDBEdit
      Left = 96
      Top = 54
      Width = 55
      Height = 21
      DataField = 'HOUSE'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = DoChange
    end
    object KORPUS: TDBEdit
      Left = 200
      Top = 54
      Width = 46
      Height = 21
      DataField = 'KORPUS'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = DoChange
    end
    object APARTMENT: TDBEdit
      Left = 328
      Top = 54
      Width = 57
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'APARTMENT'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = DoChange
    end
  end
  object GroupBox3: TPanel
    Left = 0
    Top = 264
    Width = 494
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      494
      50)
    object Label16: TLabel
      Left = 9
      Top = 12
      Width = 129
      Height = 13
      Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 9
      Top = 33
      Width = 79
      Height = 13
      Caption = #1050#1086#1076#1086#1074#1086#1077' '#1089#1083#1086#1074#1086':'
      FocusControl = CODE_WORD
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 3
      Top = 4
      Width = 510
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object Label21: TLabel
      Left = 289
      Top = 33
      Width = 31
      Height = 13
      Caption = 'E-mail:'
      FocusControl = EMAIL
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CONTACT_INFO: TDBEdit
      Left = 168
      Top = 8
      Width = 314
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'CONTACT_INFO'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = DoChange
    end
    object CODE_WORD: TDBEdit
      Left = 112
      Top = 31
      Width = 145
      Height = 21
      DataField = 'CODE_WORD'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = DoChange
    end
    object EMAIL: TDBEdit
      Left = 333
      Top = 29
      Width = 149
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'EMAIL'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = DoChange
    end
  end
  object qCountries_Citizen: TOraQuery
    SQL.Strings = (
      'SELECT * '
      'FROM COUNTRIES'
      'ORDER BY NVL(IS_DEFAULT, 0) DESC, COUNTRY_NAME')
    Left = 216
    Top = 97
  end
  object qGetNewId: TOraStoredProc
    StoredProcName = 'NEW_ABONENT_ID'
    Left = 152
    Top = 97
    ParamData = <
      item
        DataType = ftFloat
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end>
    CommandStoredProcName = 'NEW_ABONENT_ID:0'
  end
  object qMain: TOraQuery
    KeyFields = 'ABONENT_ID'
    SQLInsert.Strings = (
      'INSERT INTO ABONENTS'
      
        '  (ABONENT_ID, SURNAME, NAME, PATRONYMIC, BDATE, PASSPORT_SER, P' +
        'ASSPORT_NUM, PASSPORT_DATE, PASSPORT_GET, CITIZENSHIP, COUNTRY_I' +
        'D, REGION_ID, REGION_NAME, CITY_NAME, STREET_NAME, HOUSE, KORPUS' +
        ', APARTMENT, CONTACT_INFO, CODE_WORD, IS_VIP, EMAIL)'
      'VALUES'
      
        '  (:ABONENT_ID, :SURNAME, :NAME, :PATRONYMIC, :BDATE, :PASSPORT_' +
        'SER, :PASSPORT_NUM, :PASSPORT_DATE, :PASSPORT_GET, :CITIZENSHIP,' +
        ' :COUNTRY_ID, :REGION_ID, :REGION_NAME, :CITY_NAME, :STREET_NAME' +
        ', :HOUSE, :KORPUS, :APARTMENT, :CONTACT_INFO, :CODE_WORD, :IS_VI' +
        'P, :EMAIL)'
      'RETURNING'
      
        '  ABONENT_ID, SURNAME, NAME, PATRONYMIC, BDATE, PASSPORT_SER, PA' +
        'SSPORT_NUM, PASSPORT_DATE, PASSPORT_GET, CITIZENSHIP, COUNTRY_ID' +
        ', REGION_ID, REGION_NAME, CITY_NAME, STREET_NAME, HOUSE, KORPUS,' +
        ' APARTMENT, CONTACT_INFO, CODE_WORD, IS_VIP, EMAIL'
      'INTO'
      
        '  :ABONENT_ID, :SURNAME, :NAME, :PATRONYMIC, :BDATE, :PASSPORT_S' +
        'ER, :PASSPORT_NUM, :PASSPORT_DATE, :PASSPORT_GET, :CITIZENSHIP, ' +
        ':COUNTRY_ID, :REGION_ID, :REGION_NAME, :CITY_NAME, :STREET_NAME,' +
        ' :HOUSE, :KORPUS, :APARTMENT, :CONTACT_INFO, :CODE_WORD, :IS_VIP' +
        ', :EMAIL')
    SQLDelete.Strings = (
      'DELETE FROM ABONENTS'
      'WHERE'
      '  ABONENT_ID = :Old_ABONENT_ID')
    SQLUpdate.Strings = (
      'UPDATE ABONENTS'
      'SET'
      
        '  ABONENT_ID = :ABONENT_ID, SURNAME = :SURNAME, NAME = :NAME, PA' +
        'TRONYMIC = :PATRONYMIC, BDATE = :BDATE, PASSPORT_SER = :PASSPORT' +
        '_SER, PASSPORT_NUM = :PASSPORT_NUM, PASSPORT_DATE = :PASSPORT_DA' +
        'TE, PASSPORT_GET = :PASSPORT_GET, CITIZENSHIP = :CITIZENSHIP, CO' +
        'UNTRY_ID = :COUNTRY_ID, REGION_ID = :REGION_ID, REGION_NAME = :R' +
        'EGION_NAME, CITY_NAME = :CITY_NAME, STREET_NAME = :STREET_NAME, ' +
        'HOUSE = :HOUSE, KORPUS = :KORPUS, APARTMENT = :APARTMENT, CONTAC' +
        'T_INFO = :CONTACT_INFO, CODE_WORD = :CODE_WORD, IS_VIP = :IS_VIP' +
        ', EMAIL = :EMAIL, DESCRIPTION = :DESCRIPTION'
      'WHERE'
      '  ABONENT_ID = :Old_ABONENT_ID'
      'RETURNING'
      
        '  ABONENT_ID, SURNAME, NAME, PATRONYMIC, BDATE, PASSPORT_SER, PA' +
        'SSPORT_NUM, PASSPORT_DATE, PASSPORT_GET, CITIZENSHIP, COUNTRY_ID' +
        ', REGION_ID, REGION_NAME, CITY_NAME, STREET_NAME, HOUSE, KORPUS,' +
        ' APARTMENT, CONTACT_INFO, CODE_WORD, IS_VIP, EMAIL, DESCRIPTION '
      'INTO'
      
        '  :ABONENT_ID, :SURNAME, :NAME, :PATRONYMIC, :BDATE, :PASSPORT_S' +
        'ER, :PASSPORT_NUM, :PASSPORT_DATE, :PASSPORT_GET, :CITIZENSHIP, ' +
        ':COUNTRY_ID, :REGION_ID, :REGION_NAME, :CITY_NAME, :STREET_NAME,' +
        ' :HOUSE, :KORPUS, :APARTMENT, :CONTACT_INFO, :CODE_WORD, :IS_VIP' +
        ', :EMAIL, :DESCRIPTION')
    SQLRefresh.Strings = (
      
        'SELECT ABONENT_ID, SURNAME, NAME, PATRONYMIC, BDATE, PASSPORT_SE' +
        'R, PASSPORT_NUM, PASSPORT_DATE, PASSPORT_GET, CITIZENSHIP, COUNT' +
        'RY_ID, REGION_ID, REGION_NAME, CITY_NAME, STREET_NAME, HOUSE, KO' +
        'RPUS, APARTMENT, CONTACT_INFO, CODE_WORD, IS_VIP, EMAIL FROM ABO' +
        'NENTS'
      'WHERE'
      '  ABONENT_ID = :ABONENT_ID')
    SQL.Strings = (
      'SELECT * '
      'FROM ABONENTS'
      'WHERE ABONENT_ID = :ABONENT_ID')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    IndexFieldNames = 'SURNAME, NAME, PATRONYMIC, BDATE'
    AfterOpen = qMainAfterOpen
    Left = 184
    Top = 97
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ABONENT_ID'
      end>
  end
  object qCountries: TOraQuery
    SQL.Strings = (
      'SELECT * '
      'FROM COUNTRIES'
      'ORDER BY NVL(IS_DEFAULT, 0) DESC, COUNTRY_NAME')
    Left = 248
    Top = 97
  end
  object qRegions: TOraQuery
    SQL.Strings = (
      
        'SELECT R.REGION_ID, R.REGION_NAME || '#39' ('#39' || C.COUNTRY_NAME || '#39 +
        ')'#39','
      '  R.COUNTRY_ID'
      'FROM REGIONS R, COUNTRIES C'
      'WHERE R.COUNTRY_ID = C.COUNTRY_ID(+)'
      'ORDER BY NVL(C.IS_DEFAULT, 0) DESC, C.COUNTRY_NAME,'
      '  NVL(R.IS_DEFAULT, 0) DESC, R.REGION_NAME')
    Left = 280
    Top = 97
  end
  object dsMain: TDataSource
    DataSet = qMain
    Left = 184
    Top = 128
  end
  object dsCitizens: TDataSource
    DataSet = qCountries_Citizen
    Left = 216
    Top = 128
  end
  object dsCountry: TDataSource
    DataSet = qCountries
    Left = 248
    Top = 128
  end
  object dsRegions: TDataSource
    DataSet = qRegions
    Left = 280
    Top = 128
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 328
    Top = 96
    object aFindAbonent: TAction
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1072#1073#1086#1085#1077#1085#1090#1072
      ImageIndex = 15
      OnExecute = aFindAbonentExecute
    end
  end
  object qAbonentID: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT ABONENT_ID'
      '  FROM CONTRACTS'
      '  WHERE CONTRACT_ID=:CONTRACT_ID')
    Left = 328
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACT_ID'
      end>
  end
end
