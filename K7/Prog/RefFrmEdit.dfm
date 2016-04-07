object RefFormEdit: TRefFormEdit
  Left = 0
  Top = 0
  Caption = 'RefFormEdit'
  ClientHeight = 563
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnPanel: TsPanel
    Left = 0
    Top = 528
    Width = 953
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      953
      35)
    object sBsave: TsBitBtn
      Left = 530
      Top = 3
      Width = 99
      Height = 31
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1080' Ctrl+S'
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 7
      Images = Dm.ImageList24
    end
    object sBClose: TsBitBtn
      Left = 655
      Top = 3
      Width = 99
      Height = 31
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' -  '#1082#1083#1072#1074#1080#1096#1072' Esc'
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Default = True
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
      ImageIndex = 8
      Images = Dm.ImageList24
    end
  end
  object ScrollBox: TsScrollBox
    Left = 0
    Top = 0
    Width = 953
    Height = 528
    Align = alClient
    AutoMouseWheel = True
    TabOrder = 1
    SkinData.SkinSection = 'PANEL_LOW'
  end
end
