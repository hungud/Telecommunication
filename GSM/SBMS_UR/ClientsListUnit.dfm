object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SBMS_UR'
  ClientHeight = 562
  ClientWidth = 996
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 996
    Height = 90
    Align = alBottom
    TabOrder = 0
    object PhoneNumber: TLabel
      Left = 16
      Top = 34
      Width = 3
      Height = 13
    end
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object MemoLog: TMemo
      Left = 296
      Top = 5
      Width = 418
      Height = 76
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object DoMainWork: TButton
      Left = 720
      Top = 30
      Width = 75
      Height = 25
      Caption = #1047#1072#1081#1090#1080
      TabOrder = 1
      OnClick = DoMainWorkClick
    end
    object StopProcess: TCheckBox
      Left = 16
      Top = 72
      Width = 145
      Height = 17
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089
      TabOrder = 2
    end
    object AddNextBut: TButton
      Left = 801
      Top = 30
      Width = 120
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1077#1076'. '#1085#1086#1084#1077#1088
      Enabled = False
      TabOrder = 3
      OnClick = AddNextButClick
    end
    object SpinEdit1: TSpinEdit
      Left = 80
      Top = 5
      Width = 81
      Height = 22
      MaxValue = 10
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = SpinEdit1Change
    end
    object SaveBut: TButton
      Left = 927
      Top = 30
      Width = 61
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      TabOrder = 5
      OnClick = SaveButClick
    end
    object AddAllNext: TButton
      Left = 776
      Top = 61
      Width = 145
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1089#1077' '#1086#1089#1090#1072#1083#1100#1085#1099#1077
      Enabled = False
      TabOrder = 6
      OnClick = AddAllNextClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 996
    Height = 472
    Align = alClient
    TabOrder = 1
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 1
      Width = 994
      Height = 470
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitWidth = 927
      ControlData = {
        4C000000BC660000933000000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Access|*.mdb'
    Left = 584
    Top = 248
  end
end
