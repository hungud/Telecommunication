object UnBlockListFrm_Ivideon: TUnBlockListFrm_Ivideon
  Left = 225
  Top = 232
  Caption = #1057#1087#1080#1089#1086#1082' '#1073#1083#1086#1082#1072' '#1080' '#1088#1072#1079#1073#1083#1086#1082#1072
  ClientHeight = 441
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 573
    Height = 28
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 12
      Top = 0
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 163
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 268
      Top = 0
      Width = 111
      Height = 29
      Action = aShowUserStatInfo
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Visible = False
    end
    object cbSearch: TCheckBox
      Left = 385
      Top = 6
      Width = 60
      Height = 17
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbSearchClick
    end
    object cbPhoneForUnBlock: TCheckBox
      Left = 450
      Top = 6
      Width = 124
      Height = 17
      Caption = #1054#1095#1077#1088#1077#1076#1100' '#1088#1072#1079#1073#1083'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = cbPhoneForUnBlockClick
    end
  end
  object AbonentForUnBlockGrid: TCRDBGrid
    Left = 0
    Top = 28
    Width = 573
    Height = 413
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    DataSource = dsUnblockList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'FIO'
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BALANCE'
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HISTORY_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACTION_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087' '#1079#1072#1103#1074#1082#1080
        Width = 153
        Visible = True
      end>
  end
  object qUnblockList: TOraQuery
    SQL.Strings = (
      'SELECT IA.FIO,AH.BALANCE,AT.ACTION_NAME,AH.HISTORY_DATE'
      '  FROM IVIDEON.ABONENT_BLOCK_UNLOCK_HISTORY AH, '
      '       IVIDEON.ACTION_TYPE AT,'
      '       IVIDEON.IVIDEON_ABONENTS IA '
      '  WHERE IA.ABONENT_ID = :ABONENT'
      '  AND AH.ABONENT_ID = IA.ABONENT_ID'
      '  AND AT.ACTION_TYPE_ID = AH.ACTION_TYPE_ID'
      '  ORDER BY AH.HISTORY_DATE DESC')
    FetchRows = 250
    Left = 64
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ABONENT'
      end>
  end
  object dsUnblockList: TDataSource
    DataSet = qUnblockList
    Left = 96
    Top = 136
  end
  object ActionList1: TActionList
    Images = MainForm.ImageList24
    Left = 64
    Top = 80
    object aExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      ImageIndex = 12
      OnExecute = aExcelExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefreshExecute
    end
    object aShowUserStatInfo: TAction
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1072#1073#1086#1085#1077#1085#1090#1091
      ImageIndex = 22
      ShortCut = 13
      OnExecute = aShowUserStatInfoExecute
    end
  end
end
