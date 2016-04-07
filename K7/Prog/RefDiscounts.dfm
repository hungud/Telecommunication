inherited RefDiscountsForm: TRefDiscountsForm
  Caption = 'RefDiscountsForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBr: TsToolBar
    ButtonHeight = 31
    inherited btnInsert: TToolButton
      ExplicitHeight = 31
    end
    inherited btnEdit: TToolButton
      ExplicitHeight = 31
    end
    inherited btnDelete: TToolButton
      ExplicitHeight = 31
    end
    inherited btn4: TToolButton
      ExplicitHeight = 31
    end
    inherited btnPost: TToolButton
      ExplicitHeight = 31
    end
    inherited btnCancel: TToolButton
      ExplicitHeight = 31
    end
    inherited btn7: TToolButton
      ExplicitHeight = 31
    end
    inherited btnRefresh: TToolButton
      ExplicitHeight = 31
    end
    inherited btnFind: TToolButton
      ExplicitHeight = 31
    end
    inherited btnFiltr: TToolButton
      ExplicitHeight = 31
    end
    inherited btnExcel: TToolButton
      ExplicitHeight = 31
    end
    inherited btn1: TToolButton
      ExplicitHeight = 31
    end
    inherited btnFirst: TToolButton
      ExplicitHeight = 31
    end
    inherited btnMovePrev: TToolButton
      ExplicitHeight = 31
    end
    inherited btnPrev: TToolButton
      ExplicitHeight = 31
    end
    inherited btnNext: TToolButton
      ExplicitHeight = 31
    end
    inherited btnMoveNext: TToolButton
      ExplicitHeight = 31
    end
    inherited btnLast: TToolButton
      ExplicitHeight = 31
    end
    object btn2: TToolButton
      Left = 549
      Top = 0
      Width = 8
      Caption = 'btn2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnFromExcel: TToolButton
      Left = 557
      Top = 0
      Action = aFromExcel
    end
    object btn3: TToolButton
      Left = 592
      Top = 0
      Width = 8
      Caption = 'btn3'
      ImageIndex = 13
      Style = tbsDivider
    end
    object CheckBox1: TCheckBox
      Left = 600
      Top = 0
      Width = 97
      Height = 31
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' '#1089' '#1080#1089#1090#1077#1082#1096#1080#1084#1080' '#1089#1088#1086#1082#1072#1084#1080' '#1089#1082#1080#1076#1086#1082
      Caption = #1048#1089#1090#1077#1082#1072#1102#1097#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBox1Click
    end
  end
  inherited actlst1: TActionList
    object aFromExcel: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093' '#1080#1079' Excel'
      Hint = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093' '#1086' '#1089#1082#1080#1076#1082#1072#1093' '#1087#1086' '#1085#1086#1084#1077#1088#1072#1084' '#1080#1079' '#1092#1072#1081#1083#1072' Excel'
      ImageIndex = 12
      OnExecute = aFromExcelExecute
    end
  end
  object vtLoad: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
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
