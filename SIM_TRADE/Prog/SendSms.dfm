object SendSmsFrm: TSendSmsFrm
  Left = 916
  Top = 240
  Width = 347
  Height = 371
  Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1089#1084#1089
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 103
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1088#1072#1089#1089#1099#1083#1082#1080
  end
  object Label3: TLabel
    Left = 32
    Top = 64
    Width = 53
    Height = 13
    Caption = #1058#1077#1082#1089#1090' '#1089#1084#1089
  end
  object BtSendSms: TButton
    Left = 16
    Top = 248
    Width = 129
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1084#1089
    TabOrder = 0
    OnClick = BtSendSmsClick
  end
  object TEdMailingName: TEdit
    Left = 32
    Top = 32
    Width = 193
    Height = 21
    TabOrder = 1
  end
  object MTextSms: TMemo
    Left = 32
    Top = 80
    Width = 193
    Height = 161
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object BtSendSmsClose: TButton
    Left = 152
    Top = 248
    Width = 129
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object spLoaderSendSms: TOraStoredProc
    StoredProcName = 'LOADER3_PCKG.SEND_SMS'
    SQL.Strings = (
      'begin'
      
        '  :RESULT := LOADER3_PCKG.SEND_SMS(:PPHONE_NUMBER, :PMAILING_NAM' +
        'E, :PSMS_TEXT);'
      'end;')
    Left = 28
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'RESULT'
        ParamType = ptOutput
        IsResult = True
      end
      item
        DataType = ftString
        Name = 'PPHONE_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PMAILING_NAME'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PSMS_TEXT'
        ParamType = ptInput
      end>
  end
end
