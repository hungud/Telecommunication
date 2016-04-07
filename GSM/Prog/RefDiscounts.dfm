inherited RefDiscountsForm: TRefDiscountsForm
  Caption = #1057#1082#1080#1076#1082#1072' '#1054#1087#1077#1088#1072#1090#1086#1088#1072' '#1057#1074#1103#1079#1080
  ClientHeight = 446
  OnCreate = FormCreate
  ExplicitHeight = 491
  PixelsPerInch = 120
  TextHeight = 16
  inherited Panel1: TPanel
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    inherited ToolBar1: TToolBar
      Width = 694
      Height = 31
      ExplicitHeight = 31
      object ToolButton9: TToolButton
        Left = 202
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 10
        Style = tbsSeparator
      end
      object ToolButton10: TToolButton
        Left = 210
        Top = 0
        Action = aImportExcel
      end
      object ToolButton11: TToolButton
        Left = 241
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object cbFilter: TCheckBox
        Left = 249
        Top = 0
        Width = 74
        Height = 31
        Hint = #1042#1082#1083'/'#1074#1099#1082#1083' '#1092#1080#1083#1100#1090#1088
        Caption = #1060#1080#1083#1100#1090#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = cbFilterClick
      end
      object CheckBox1: TCheckBox
        Left = 323
        Top = 0
        Width = 97
        Height = 31
        Caption = #1048#1089#1090#1077#1082#1072#1102#1097#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = CheckBox1Click
      end
    end
  end
  inherited Panel2: TPanel
    Height = 405
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitWidth = 694
    ExplicitHeight = 405
    inherited CRDBGrid1: TCRDBGrid
      Width = 692
      Height = 403
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      OnGetCellParams = CRDBGrid1GetCellParams
      Columns = <
        item
          Expanded = False
          FieldName = 'PHONE_NUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 154
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IS_DISCOUNT_OPERATOR'
          Title.Alignment = taCenter
          Title.Caption = #1057#1082#1080#1076#1082#1072' (1-'#1044#1072'/0-'#1053#1077#1090')'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DISCOUNT_BEGIN_DATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 132
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DISCOUNT_VALIDITY'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103'('#1084#1077#1089'.)'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 152
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO PHONE_NUMBER_ATTRIBUTES'
      
        '  (PHONE_NUMBER, IS_DISCOUNT_OPERATOR, DISCOUNT_BEGIN_DATE, DISC' +
        'OUNT_VALIDITY)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :IS_DISCOUNT_OPERATOR, :DISCOUNT_BEGIN_DATE, :' +
        'DISCOUNT_VALIDITY)')
    SQLDelete.Strings = (
      'DELETE FROM PHONE_NUMBER_ATTRIBUTES'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE PHONE_NUMBER_ATTRIBUTES'
      'SET'
      
        '  PHONE_NUMBER = :PHONE_NUMBER, IS_DISCOUNT_OPERATOR = :IS_DISCO' +
        'UNT_OPERATOR, DISCOUNT_BEGIN_DATE = :DISCOUNT_BEGIN_DATE, DISCOU' +
        'NT_VALIDITY = :DISCOUNT_VALIDITY'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER')
    SQLLock.Strings = (
      'SELECT * FROM PHONE_NUMBER_ATTRIBUTES'
      'WHERE'
      '  PHONE_NUMBER = :Old_PHONE_NUMBER'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT PHONE_NUMBER, IS_DISCOUNT_OPERATOR, DISCOUNT_BEGIN_DATE, ' +
        'DISCOUNT_VALIDITY FROM PHONE_NUMBER_ATTRIBUTES'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'SELECT PHONE_NUMBER,'
      '       IS_DISCOUNT_OPERATOR,'
      '       DISCOUNT_BEGIN_DATE,'
      
        '       DISCOUNT_VALIDITY --,TRUNC(ADD_MONTHS(DISCOUNT_BEGIN_DATE' +
        ', DISCOUNT_VALIDITY)) DATE_END'
      '  FROM PHONE_NUMBER_ATTRIBUTES'
      
        '  WHERE (TRUNC(ADD_MONTHS(DISCOUNT_BEGIN_DATE, DISCOUNT_VALIDITY' +
        '))-5<=:PDATE)OR(:PDATE IS NULL)'
      '  ORDER BY PHONE_NUMBER ASC')
    BeforePost = nil
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PDATE'
      end>
    object qMainPHONE_NUMBER: TStringField
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 40
    end
    object qMainIS_DISCOUNT_OPERATOR: TIntegerField
      FieldName = 'IS_DISCOUNT_OPERATOR'
    end
    object qMainDISCOUNT_VALIDITY: TFloatField
      FieldName = 'DISCOUNT_VALIDITY'
    end
    object qMainDISCOUNT_BEGIN_DATE: TDateTimeField
      FieldName = 'DISCOUNT_BEGIN_DATE'
      EditMask = '!99/99/00;1;_'
    end
  end
  inherited ActionList1: TActionList
    object aImportExcel: TAction
      Caption = 'aImportExcel'
      ImageIndex = 12
      OnExecute = aImportExcelExecute
    end
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
  object OpenDialog1: TOpenDialog
    Left = 192
    Top = 120
  end
  object vtLoad: TVirtualTable
    FieldDefs = <
      item
        Name = 'cellnum'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DateBegin'
        DataType = ftDate
      end>
    Left = 176
    Top = 168
    Data = {
      03000200070063656C6C6E756D01000A0000000000090044617465426567696E
      0900000000000000000000000000}
    object vtLoadCellNum: TStringField
      FieldName = 'CellNum'
      Size = 10
    end
    object vtLoadDateBegin: TDateTimeField
      FieldName = 'DateBegin'
    end
    object vtLoadDateEnd: TDateTimeField
      FieldName = 'DateEnd'
    end
  end
end
