object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1040#1085#1072#1083#1080#1079' '#1080' '#1086#1094#1077#1085#1082#1072' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 263
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 558
    Height = 263
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1055#1086#1076#1073#1086#1088
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 24
        Top = 45
        Width = 84
        Height = 13
        Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083':'
      end
      object Label2: TLabel
        Left = 24
        Top = 93
        Width = 66
        Height = 13
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' 1:'
      end
      object Label3: TLabel
        Left = 24
        Top = 112
        Width = 66
        Height = 13
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' 2:'
      end
      object lbResFile1: TLabel
        Left = 96
        Top = 93
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = lbResFile1Click
        OnMouseEnter = lbResFile2MouseEnter
        OnMouseLeave = lbResFile2MouseLeave
      end
      object lbResFile2: TLabel
        Left = 96
        Top = 112
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = lbResFile1Click
        OnMouseEnter = lbResFile2MouseEnter
        OnMouseLeave = lbResFile2MouseLeave
      end
      object lbProgress: TLabel
        Left = 24
        Top = 181
        Width = 30
        Height = 13
        Caption = '          '
      end
      object sbOpenFile: TSpeedButton
        Left = 512
        Top = 60
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = sbOpenFileClick
      end
      object Label4: TLabel
        Left = 24
        Top = 2
        Width = 97
        Height = 13
        Caption = #1060#1072#1081#1083' '#1089' '#1096#1072#1073#1083#1086#1085#1072#1084#1080':'
      end
      object sbOpenSettings: TSpeedButton
        Left = 512
        Top = 17
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = sbOpenSettingsClick
      end
      object edFileName: TEdit
        Left = 24
        Top = 61
        Width = 489
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object bStart: TButton
        Left = 24
        Top = 142
        Width = 75
        Height = 25
        Caption = #1053#1072#1095#1072#1090#1100
        TabOrder = 1
        OnClick = bStartClick
      end
      object pb: TProgressBar
        Left = 24
        Top = 205
        Width = 511
        Height = 17
        TabOrder = 2
      end
      object edSettingsFile: TEdit
        Left = 24
        Top = 18
        Width = 489
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1096#1072#1073#1083#1086#1085#1086#1074
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 550
        Height = 29
        Caption = 'ToolBar1'
        TabOrder = 0
        object SpeedButton3: TSpeedButton
          Left = 0
          Top = 0
          Width = 73
          Height = 22
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          OnClick = SpeedButton3Click
        end
        object SpeedButton1: TSpeedButton
          Left = 73
          Top = 0
          Width = 73
          Height = 22
          Caption = #1054#1090#1084#1077#1085#1080#1090#1100
          OnClick = SpeedButton1Click
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 29
        Width = 550
        Height = 206
        Align = alClient
        DataSource = dsTemplates
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' Excel (*.xls;*.xlsx)|*.xls;*.xlsx|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 440
    Top = 8
  end
  object vtTemplates: TVirtualTable
    AfterPost = vtTemplatesAfterPost
    OnCalcFields = vtTemplatesCalcFields
    FieldDefs = <
      item
        Name = 'Template'
        DataType = ftString
        Size = 20
      end>
    Left = 376
    Top = 8
    Data = {03000100080054656D706C6174650100140000000000000000000000}
    object vtTemplatesNameWithSeparators: TStringField
      DisplayLabel = #1064#1072#1073#1083#1086#1085
      FieldName = 'NameWithSeparators'
    end
    object vtTemplatesTemplate: TStringField
      DisplayLabel = #1064#1072#1073#1083#1086#1085
      FieldKind = fkCalculated
      FieldName = 'Template'
      Required = True
      Visible = False
      Calculated = True
    end
    object vtTemplatesPrice: TFloatField
      DisplayLabel = #1062#1077#1085#1072
      FieldName = 'Price'
      Required = True
    end
  end
  object dsTemplates: TDataSource
    DataSet = vtTemplates
    Left = 408
    Top = 8
  end
end
