object fmConn: TfmConn
  Left = 299
  Top = 317
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 193
  ClientWidth = 302
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
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbUsername: TLabel
      Left = 8
      Top = 12
      Width = 116
      Height = 13
      Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' :'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object lbPassword: TLabel
      Left = 8
      Top = 46
      Width = 52
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100' :'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object edUsername: TEdit
      Left = 128
      Top = 8
      Width = 153
      Height = 21
      TabOrder = 0
    end
    object edPassword: TMaskEdit
      Left = 128
      Top = 42
      Width = 153
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object pServerSchema: TPanel
    Left = 0
    Top = 70
    Width = 302
    Height = 82
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbServer: TLabel
      Left = 8
      Top = 8
      Width = 53
      Height = 13
      Caption = #1057#1077#1088#1074#1077#1088' :'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 38
      Width = 71
      Height = 13
      Caption = #1048#1084#1103' '#1089#1093#1077#1084#1099' :'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object edServer: TComboBox
      Left = 128
      Top = 3
      Width = 153
      Height = 21
      TabOrder = 0
    end
    object eSchema: TEdit
      Left = 128
      Top = 34
      Width = 153
      Height = 21
      TabOrder = 1
      OnChange = eSchemaChange
    end
    object cbEncrypt_pwd: TCheckBox
      Left = 128
      Top = 60
      Width = 136
      Height = 17
      Caption = #1064#1080#1092#1088#1086#1074#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 152
    Width = 302
    Height = 41
    Align = alTop
    TabOrder = 2
    object btnAdd: TBitBtn
      Left = 201
      Top = 6
      Width = 89
      Height = 25
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btConnect: TBitBtn
      Left = 9
      Top = 6
      Width = 89
      Height = 25
      Caption = #1054#1050
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btConnectClick
    end
    object btCancel: TBitBtn
      Left = 105
      Top = 6
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
