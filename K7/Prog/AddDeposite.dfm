object AddDepositeFrm: TAddDepositeFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1076#1077#1087#1086#1079#1080#1090#1072
  ClientHeight = 178
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lAddDepositValue: TLabel
    Left = 18
    Top = 24
    Width = 141
    Height = 18
    Alignment = taRightJustify
    Caption = #1057#1091#1084#1084#1072' '#1076#1077#1087#1086#1079#1080#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object lAddDepositNote: TLabel
    Left = 49
    Top = 59
    Width = 110
    Height = 18
    Alignment = taRightJustify
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 255
    Top = 24
    Width = 35
    Height = 18
    Caption = #1088#1091#1073'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object eAddDepositValue: TEdit
    Left = 165
    Top = 21
    Width = 76
    Height = 26
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = eAddDepositValueKeyPress
  end
  object btCancel: TBitBtn
    Left = 304
    Top = 134
    Width = 87
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 3
    OnClick = btCancelClick
  end
  object mAddDepositNote: TMemo
    Left = 165
    Top = 56
    Width = 226
    Height = 72
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    Lines.Strings = (
      'mAddDepositNote')
    ParentFont = False
    TabOrder = 1
  end
  object btOK: TBitBtn
    Left = 211
    Top = 134
    Width = 87
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 2
    OnClick = btOKClick
  end
  object qAddDepositOper: TOraStoredProc
    StoredProcName = 'ADD_DEPOSITE_OPER'
    SQL.Strings = (
      'begin'
      '  ADD_DEPOSITE_OPER(:PCONTRACT_ID, :PDEPOSITE_VALUE, :PNOTE);'
      'end;')
    Left = 72
    Top = 104
    ParamData = <
      item
        DataType = ftFloat
        Name = 'PCONTRACT_ID'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PDEPOSITE_VALUE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PNOTE'
        ParamType = ptInput
      end>
    CommandStoredProcName = 'ADD_DEPOSITE_OPER'
  end
end
