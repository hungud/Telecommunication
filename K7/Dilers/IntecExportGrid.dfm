object SelectPrintColumnsForm: TSelectPrintColumnsForm
  Left = 364
  Top = 153
  Caption = #1042#1099#1073#1086#1088' '#1082#1086#1083#1086#1085#1086#1082' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
  ClientHeight = 113
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object pBottom: TPanel
    Left = 0
    Top = 65
    Width = 415
    Height = 48
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      415
      48)
    object BitBtn1: TBitBtn
      Left = 166
      Top = 6
      Width = 120
      Height = 37
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 295
      Top = 6
      Width = 120
      Height = 37
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akRight, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object clbColumns: TCheckListBox
    Left = 0
    Top = 0
    Width = 415
    Height = 65
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
