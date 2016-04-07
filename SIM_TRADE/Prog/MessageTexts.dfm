object MessageTextsFrm: TMessageTextsFrm
  Left = 0
  Top = 0
  Caption = #1058#1077#1082#1089#1090#1099' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
  ClientHeight = 393
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 588
    Height = 393
    Align = alClient
    TabOrder = 0
    ExplicitTop = 33
    ExplicitWidth = 759
    ExplicitHeight = 334
    object DBMemoNoticeMonth: TDBMemo
      Left = 24
      Top = 56
      Width = 297
      Height = 89
      DataField = 'TEXT_NOTICE_MONTH'
      DataSource = DSMessageTexts
      TabOrder = 0
    end
    object DBMemoNoticeBalance: TDBMemo
      Left = 24
      Top = 176
      Width = 297
      Height = 89
      DataField = 'TEXT_NOTIFY_SMS'
      DataSource = DSMessageTexts
      TabOrder = 1
    end
    object DBMemoNoticeBlock: TDBMemo
      Left = 24
      Top = 288
      Width = 297
      Height = 89
      DataField = 'TEXT_BLOCK_SMS'
      DataSource = DSMessageTexts
      TabOrder = 2
    end
  end
  object qMessageList: TOraQuery
    SQL.Strings = (
      'SELECT * FROM MESSAGE_TEXTS')
    Left = 440
    Top = 40
  end
  object DSMessageTexts: TDataSource
    DataSet = qMessageList
    Left = 440
    Top = 88
  end
end
