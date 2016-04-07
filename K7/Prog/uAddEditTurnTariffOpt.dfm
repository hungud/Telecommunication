object frmAddEditTurnTariffOpt: TfrmAddEditTurnTariffOpt
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'/'#1076#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
  ClientHeight = 207
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 31
    Height = 13
    Caption = #1053#1086#1084#1077#1088
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 32
    Height = 13
    Caption = #1054#1087#1094#1080#1103
  end
  object Label3: TLabel
    Left = 8
    Top = 110
    Width = 49
    Height = 13
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
  end
  object Label4: TLabel
    Left = 8
    Top = 137
    Width = 56
    Height = 13
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
  end
  object Label5: TLabel
    Left = 8
    Top = 78
    Width = 53
    Height = 13
    Caption = #1050#1086#1076' '#1086#1087#1094#1080#1080
  end
  object ePhone: TEdit
    Left = 68
    Top = 21
    Width = 200
    Height = 21
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 8
    Top = 172
    Width = 75
    Height = 25
    Caption = #1054#1050
    ModalResult = 1
    TabOrder = 1
  end
  object btnCalcel: TButton
    Left = 192
    Top = 174
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object cbOptionName: TComboBox
    Left = 68
    Top = 48
    Width = 200
    Height = 21
    Style = csDropDownList
    TabOrder = 3
    OnChange = cbOptionNameChange
  end
  object cbAction_TYPE: TComboBox
    Left = 67
    Top = 107
    Width = 200
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      #1054#1090#1082#1083#1102#1095#1080#1090#1100
      #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100)
  end
  object dtActionDate: TDateTimePicker
    Left = 68
    Top = 134
    Width = 109
    Height = 21
    Date = 42166.672995474540000000
    Time = 42166.672995474540000000
    TabOrder = 5
  end
  object cbOptionCode: TComboBox
    Left = 67
    Top = 75
    Width = 200
    Height = 21
    Style = csDropDownList
    TabOrder = 6
    OnChange = cbOptionCodeChange
  end
  object dtActionTime: TDateTimePicker
    Left = 183
    Top = 134
    Width = 81
    Height = 21
    Date = 42171.564916145840000000
    Time = 42171.564916145840000000
    Kind = dtkTime
    TabOrder = 7
  end
  object qTarffOptions: TOraQuery
    Session = MainForm.OraSession
    SQL.Strings = (
      'SELECT option_code, option_name FROM tariff_options')
    FetchAll = True
    Left = 216
    Top = 16
  end
  object qCheck: TOraQuery
    SQL.Strings = (
      'SELECT '
      '  count(*) ct '
      'FROM '
      '  DELAYED_ON_OFF_TARIFF_OPTIONS d'
      'WHERE phone_number = :phone_number '
      '      AND option_code = :option_code'
      '      AND ACTION_TYPE = :ACTION_TYPE'
      '      AND (ACTION_DATE is null or ACTION_DATE = :ACTION_DATE)')
    Left = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone_number'
      end
      item
        DataType = ftUnknown
        Name = 'option_code'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end>
  end
  object qAdd: TOraQuery
    SQL.Strings = (
      'INSERT INTO DELAYED_ON_OFF_TARIFF_OPTIONS '
      
        '  (PHONE_NUMBER, OPTION_CODE, ACTION_TYPE, ACTION_DATE, DATE_CRE' +
        'ATED, USER_CREATED)'
      'VALUES'
      
        '  (:PHONE_NUMBER, :OPTION_CODE, :ACTION_TYPE, :ACTION_DATE, SYSD' +
        'ATE, USER)')
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 72
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end>
  end
  object qUpdate: TOraQuery
    SQL.Strings = (
      'UPDATE DELAYED_ON_OFF_TARIFF_OPTIONS'
      'set  '
      '  OPTION_CODE = :OPTION_CODE,'
      '  ACTION_TYPE = :ACTION_TYPE,'
      '  ACTION_DATE = :ACTION_DATE'
      'where '
      'DELAYED_TURN_TO_ID = :DELAYED_TURN_TO_ID')
    IndexFieldNames = 'PHONE_NUMBER'
    Left = 104
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OPTION_CODE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_TYPE'
      end
      item
        DataType = ftUnknown
        Name = 'ACTION_DATE'
      end
      item
        DataType = ftUnknown
        Name = 'DELAYED_TURN_TO_ID'
      end>
  end
end
