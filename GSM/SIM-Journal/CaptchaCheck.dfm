object CapchaCheckForm: TCapchaCheckForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1087#1086#1079#1085#1072#1085#1080#1077' '#1082#1072#1087#1090#1095
  ClientHeight = 166
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Image: TImage
    Left = 8
    Top = 8
    Width = 105
    Height = 105
  end
  object seValue: TsEdit
    Left = 104
    Top = 135
    Width = 89
    Height = 24
    Alignment = taRightJustify
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = seValueKeyPress
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object sbtCheck: TsBitBtn
    Left = 199
    Top = 135
    Width = 97
    Height = 24
    Caption = #1043#1086#1090#1086#1074#1086
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
    OnClick = sbtCheckClick
    SkinData.SkinSection = 'BUTTON'
  end
  object qCaptcha: TOraQuery
    SQLUpdate.Strings = (
      'UPDATE CAPTCHA_IMAGE'
      'SET'
      '  STR_VALUE = :STR_VALUE'
      'WHERE'
      '  IMAGE_ID = :Old_IMAGE_ID')
    SQL.Strings = (
      'select *'
      '  from captcha_image'
      '  where str_value is null'
      '    and DATE_CHECK > sysdate - 5/24/60')
    Left = 136
    Top = 48
    object qCaptchaIMAGE_ID: TFloatField
      FieldName = 'IMAGE_ID'
      Required = True
    end
    object qCaptchaDATE_CHECK: TDateTimeField
      FieldName = 'DATE_CHECK'
    end
    object qCaptchaDATE_VERITY: TDateTimeField
      FieldName = 'DATE_VERITY'
    end
    object qCaptchaSTR_VALUE: TStringField
      FieldName = 'STR_VALUE'
      Size = 120
    end
    object qCaptchaIMAGE_BLOB: TBlobField
      FieldName = 'IMAGE_BLOB'
      BlobType = ftOraBlob
    end
  end
  object dsCaptcha: TDataSource
    DataSet = qCaptcha
    Left = 168
    Top = 56
  end
end
