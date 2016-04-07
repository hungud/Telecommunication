object FrmLogProtokObPlat: TFrmLogProtokObPlat
  Left = 0
  Top = 0
  Caption = #1087#1088#1086#1090#1086#1082#1086#1083' '#1086#1073#1077#1097#1072#1085#1085#1099#1093' '#1087#1083#1072#1090#1077#1078#1077#1081
  ClientHeight = 379
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gPromisedPayments: TCRDBGrid
    Left = 0
    Top = 0
    Width = 714
    Height = 379
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsLogObPlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'PAYMENT_DATE'
        Title.Caption = #1044#1072#1090#1072
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_SUM'
        Title.Caption = #1057#1091#1084#1084#1072
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_NUMBER'
        Title.Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
        Width = 146
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAYMENT_STATUS_TEXT'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1072
        Width = 156
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMM_TXT'
        Width = 203
        Visible = True
      end>
  end
  object qLogObPlat: TOraQuery
    SQL.Strings = (
      'select * from PROMISED_PAYMENTS_CHANGE_LOG t '
      'where t.phone_number=:p_phone_number '
      'order by t.payment_date desc')
    Left = 224
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'p_phone_number'
      end>
    object qLogObPlatPAYMENT_DATE: TDateTimeField
      DisplayLabel = #1044#1040#1058#1040' '#1055#1051#1040#1058#1045#1046#1040
      FieldName = 'PAYMENT_DATE'
    end
    object qLogObPlatPAYMENT_SUM: TCurrencyField
      DisplayLabel = #1057#1059#1052#1052#1040' '#1055#1051#1040#1058#1045#1046#1040
      FieldName = 'PAYMENT_SUM'
    end
    object qLogObPlatPAYMENT_NUMBER: TStringField
      DisplayLabel = #1053#1054#1052#1045#1056' '#1055#1051#1040#1058#1045#1046#1040
      FieldName = 'PAYMENT_NUMBER'
      Size = 50
    end
    object qLogObPlatPAYMENT_STATUS_TEXT: TStringField
      DisplayLabel = #1054#1055#1048#1057#1040#1053#1048#1045' '#1057#1058#1040#1058#1059#1057#1040' '#1055#1051#1040#1058#1045#1046#1040
      FieldName = 'PAYMENT_STATUS_TEXT'
      Size = 50
    end
    object qLogObPlatCOMM_TXT: TStringField
      DisplayLabel = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      FieldName = 'COMM_TXT'
      Size = 50
    end
  end
  object dsLogObPlat: TDataSource
    DataSet = qLogObPlat
    Left = 304
    Top = 256
  end
end
