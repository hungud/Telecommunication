object BeelineLoadForm: TBeelineLoadForm
  Left = 0
  Top = 0
  Caption = 'BeelineLoadForm'
  ClientHeight = 358
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mData: TMemo
    Left = 0
    Top = 97
    Width = 678
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
    Width = 678
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
      Width = 128
      Height = 97
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      object btnLoad: TButton
        Left = 16
        Top = 16
        Width = 97
        Height = 65
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
    end
  end
  object pProgress: TProgressBar
    Left = 0
    Top = 341
    Width = 678
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
    Filter = #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080'|*.xls;*.csv;*.zip'
    Left = 328
    Top = 120
  end
end
