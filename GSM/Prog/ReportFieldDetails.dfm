object ReportFieldDetailsForm: TReportFieldDetailsForm
  Left = 0
  Top = 0
  Caption = 'ReportFieldDetailsForm'
  ClientHeight = 367
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 553
    Height = 367
    ActivePage = tsMain
    Align = alClient
    TabOrder = 0
    object tsMain: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1086#1077
      object grData: TCRDBGrid
        Left = 0
        Top = 31
        Width = 545
        Height = 309
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 545
        Height = 31
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        object lPeriod: TLabel
          Left = 158
          Top = 11
          Width = 49
          Height = 13
          Caption = #1055#1077#1088#1080#1086#1076':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object BitBtn1: TBitBtn
          Left = 6
          Top = 7
          Width = 68
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
          TabOrder = 0
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 78
          Top = 7
          Width = 67
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
          TabOrder = 1
          OnClick = BitBtn2Click
        end
        object cbPeriod: TComboBox
          Left = 212
          Top = 6
          Width = 99
          Height = 20
          Style = csDropDownList
          TabOrder = 2
          Visible = False
        end
      end
    end
    object tsSearch: TTabSheet
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1086#1073#1077#1089#1077#1076#1085#1080#1082#1091
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 545
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Left = 192
          Top = 37
          Width = 101
          Height = 13
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 7
          Top = 37
          Width = 80
          Height = 13
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 93
          Top = 5
          Width = 129
          Height = 13
          Caption = #1053#1086#1084#1077#1088' '#1089#1086#1073#1077#1089#1077#1076#1085#1080#1082#1072': '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object eEndDate: TsDateEdit
          Left = 299
          Top = 31
          Width = 86
          Height = 21
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          MaxLength = 10
          TabOrder = 2
          Text = '  .  .    '
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
        object eBeginDate: TsDateEdit
          Left = 93
          Top = 31
          Width = 86
          Height = 21
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          MaxLength = 10
          TabOrder = 1
          Text = '  .  .    '
          BoundLabel.Indent = 0
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
          CheckOnExit = True
          DialogTitle = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
        end
        object BitBtn3: TBitBtn
          Left = 7
          Top = 4
          Width = 68
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100
          TabOrder = 3
          OnClick = BitBtn3Click
        end
        object eCalling_no: TEdit
          Left = 224
          Top = 2
          Width = 121
          Height = 20
          TabOrder = 0
        end
        object btInfoAbonent: TBitBtn
          Left = 410
          Top = 2
          Width = 103
          Height = 20
          Caption = #1055#1086#1076#1088#1086#1073#1085#1086
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btInfoAbonentClick
        end
      end
      object CRDBGrid1: TCRDBGrid
        Left = 0
        Top = 57
        Width = 545
        Height = 283
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        DataSource = dsSearch
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'subscr_no'
            Title.Alignment = taCenter
            Width = 104
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'exists_contract'
            Title.Alignment = taCenter
            Width = 139
            Visible = True
          end>
      end
    end
  end
  object qReportJSM: TOraQuery
    FetchRows = 1000
    FetchAll = True
    Left = 216
    Top = 104
    object qReportJSM_CALLING_NO: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1089#1086#1073#1077#1089#1077#1076#1085#1080#1082#1072
      FieldName = 'CALLING_NO'
      Required = True
      Size = 120
    end
  end
  object dsMain: TDataSource
    Left = 168
    Top = 104
  end
  object qPeriods: TOraQuery
    SQL.Strings = (
      'SELECT substr(object_name,9,4)||substr(object_name,6,2),'
      '       substr(object_name,6,7) period,'
      
        '       substr(object_name,6,2)||'#39'-'#39'||substr(object_name,9,4) per' +
        'iod_name'
      
        'FROM all_objects o WHERE o.object_name like '#39'CALL_%'#39' AND o.objec' +
        't_type='#39'TABLE'#39
      
        'AND substr(object_name,9,4)||substr(object_name,6,2) <= TO_CHAR(' +
        'SYSDATE,'#39'yyyymm'#39')'
      'ORDER BY 1')
    FetchAll = True
    Left = 312
    Top = 104
  end
  object dsSearch: TDataSource
    DataSet = qSearch
    Left = 272
    Top = 176
  end
  object qSearch: TOraQuery
    FetchAll = True
    Left = 320
    Top = 176
    object qSearchsubscr_no: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'subscr_no'
    end
    object qSearchexists_contract: TStringField
      DisplayLabel = #1053#1072#1083#1080#1095#1080#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'exists_contract'
    end
  end
  object qAllTables: TOraQuery
    SQL.Strings = (
      'SELECT * FROM all_tables WHERE table_name = :CALL')
    FetchAll = True
    Left = 368
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CALL'
      end>
  end
end
