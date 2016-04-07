object ChangePasswordForm: TChangePasswordForm
  Left = 100
  Top = 100
  BorderStyle = bsSingle
  Caption = #1057#1084#1077#1085#1072' '#1087#1072#1088#1086#1083#1103
  ClientHeight = 143
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 82
    Height = 13
    Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object Label2: TLabel
    Left = 8
    Top = 59
    Width = 76
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object Label3: TLabel
    Left = 8
    Top = 87
    Width = 87
    Height = 13
    Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
  end
  object Label4: TLabel
    Left = 8
    Top = 5
    Width = 271
    Height = 13
    Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1089#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1085#1072' '#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btConnect: TBitBtn
    Left = 32
    Top = 110
    Width = 89
    Height = 25
    Caption = #1054#1050
    Default = True
    DoubleBuffered = True
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
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = btConnectClick
  end
  object btCancel: TBitBtn
    Left = 160
    Top = 110
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object old_pwd: TEdit
    Left = 120
    Top = 24
    Width = 156
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object new_pwd: TEdit
    Left = 120
    Top = 51
    Width = 156
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object confirm_pwd: TEdit
    Left = 120
    Top = 78
    Width = 156
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
  end
  object alter_user_encrypt_pwd: TOraStoredProc
    StoredProcName = 'ALTER_USER_ENCRYPT_PWD'
    SQL.Strings = (
      'begin'
      '  ALTER_USER_ENCRYPT_PWD(:P_USER_NAME, :P_PASSWORD);'
      'end;')
    Left = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'P_USER_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'P_PASSWORD'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'ALTER_USER_ENCRYPT_PWD'
  end
end
