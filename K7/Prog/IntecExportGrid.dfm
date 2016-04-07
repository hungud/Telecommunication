object SelectPrintColumnsForm: TSelectPrintColumnsForm
  Left = 364
  Top = 153
  Caption = #1042#1099#1073#1086#1088' '#1082#1086#1083#1086#1085#1086#1082' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
  ClientHeight = 92
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pBottom: TPanel
    Left = 0
    Top = 53
    Width = 337
    Height = 39
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      337
      39)
    object BitBtn1: TBitBtn
      Left = 135
      Top = 5
      Width = 97
      Height = 30
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 240
      Top = 5
      Width = 97
      Height = 30
      Anchors = [akRight, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object clbColumns: TCheckListBox
    Left = 0
    Top = 0
    Width = 337
    Height = 53
    Align = alClient
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
  end
end
