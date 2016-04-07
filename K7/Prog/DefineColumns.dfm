object DefineColumnsForm: TDefineColumnsForm
  Left = 220
  Top = 111
  Width = 205
  Height = 233
  BorderStyle = bsSizeToolWin
  Caption = 'Видимые колонки'
  Color = clBtnFace
  Constraints.MinWidth = 205
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 152
    Width = 197
    Height = 54
    Align = alBottom
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnSetAll: TBitBtn
      Left = 12
      Top = 3
      Width = 87
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Установить все'
      Constraints.MaxWidth = 205
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSetAllClick
    end
    object btnClearAll: TBitBtn
      Left = 112
      Top = 3
      Width = 79
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Снять все'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnClearAllClick
    end
    object btnOK: TButton
      Left = 16
      Top = 24
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object btnCancel: TButton
      Left = 112
      Top = 24
      Width = 79
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Отмена'
      ModalResult = 2
      TabOrder = 3
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 197
    Height = 152
    Align = alClient
    TabOrder = 0
  end
end
