object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SBMS'
  ClientHeight = 619
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 484
    Width = 929
    Height = 135
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      929
      135)
    object MemoLog: TMemo
      Left = 510
      Top = 1
      Width = 418
      Height = 133
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Button3: TButton
      Left = 272
      Top = 6
      Width = 228
      Height = 27
      Caption = #1047#1072#1081#1090#1080
      TabOrder = 1
      OnClick = Button3Click
    end
    object bInputCurrentRecord: TButton
      Left = 215
      Top = 50
      Width = 131
      Height = 31
      Caption = #1042#1074#1077#1089#1090#1080' '#1090#1077#1082#1091#1097#1080#1081' '#1085#1086#1084#1077#1088
      TabOrder = 2
      OnClick = bInputCurrentRecordClick
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 5
      Width = 240
      Height = 25
      DataSource = DataSource1
      Kind = dbnHorizontal
      TabOrder = 3
    end
    object Button1: TButton
      Left = 369
      Top = 50
      Width = 131
      Height = 31
      Caption = #1042#1074#1077#1089#1090#1080' '#1074#1089#1077' '#1085#1086#1084#1077#1088#1072
      TabOrder = 4
      OnClick = Button1Click
    end
    object StopLoad: TCheckBox
      Left = 235
      Top = 96
      Width = 182
      Height = 17
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 36
      Width = 185
      Height = 93
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      TabOrder = 6
      object cbSave: TCheckBox
        Left = 16
        Top = 20
        Width = 145
        Height = 17
        Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1076#1072#1085#1085#1099#1077
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 66
        Width = 130
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1085#1077' '#1074#1074#1077#1076#1105#1085#1085#1099#1077
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object cbReportSave: TCheckBox
        Left = 16
        Top = 43
        Width = 166
        Height = 17
        Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1073#1086#1085#1077#1085#1090#1072' '#1074' PDF'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 484
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 322
      Top = 1
      Height = 482
      ExplicitLeft = 320
      ExplicitTop = 304
      ExplicitHeight = 100
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 321
      Height = 482
      Align = alLeft
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = #1076#1072#1090#1072' '#1076#1077#1085#1100
          Width = 31
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1072#1090#1072' '#1084#1077#1089#1103#1094
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1072#1090#1072' '#1075#1086#1076
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1092#1080#1079' '#1083#1080#1094#1086
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1092#1072#1084#1080#1083#1080#1103
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1080#1084#1103
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1086#1090#1095#1077#1089#1090#1074#1086
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1072#1090#1072' '#1088' '#1076#1077#1085#1100
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1090#1072' '#1088' '#1084#1077#1089#1103#1094
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1072#1090#1072' '#1088' '#1075#1086#1076
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087#1086#1083' '#1084
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087#1086#1083' '#1078
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087#1072#1089#1087#1086#1088#1090
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1089#1077#1088#1080#1103
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1085#1086#1084#1077#1088
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1074#1099#1076#1072#1085
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1076#1072#1090#1072' '#1076#1077#1085#1100
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1076#1072#1090#1072' '#1084#1077#1089#1103#1094
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087' '#1076#1072#1090#1072' '#1075#1086#1076
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1075#1086#1088#1086#1076
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1091#1083#1080#1094#1072
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1086#1084
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1082#1086#1088#1087#1091#1089
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1082#1074#1072#1088#1090#1080#1088#1072
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1080#1085#1080#1094#1080#1072#1083' '#1048
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1080#1085#1080#1094#1080#1072#1083' '#1054
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1082' '#1090#1077#1083
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1084#1086#1076#1077#1083#1100' '#1090#1077#1083
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1089#1077#1088' '#1085#1086#1084#1077#1088
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087#1083#1072#1085
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1085#1086#1084#1077#1088' '#1089#1080#1084' '#1082#1072#1088#1090#1099
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1090#1077#1083' '#1082#1086#1076
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1090#1077#1083' '#1085#1086#1084#1077#1088
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'puk'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1085#1086#1084#1077#1088' '#1076#1080#1083#1083#1077#1088#1072
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1076#1080#1083#1083#1077#1088
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1087#1088#1080#1085#1103#1083
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #8470' '#1090' '#1090
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #8470' '#1076#1086#1075#1086#1074#1086#1088#1072
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1084#1077#1089#1090#1086' '#1088#1086#1078#1076
          Width = 30
          Visible = True
        end>
    end
    object PageControl1: TPageControl
      Left = 325
      Top = 1
      Width = 603
      Height = 482
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 322
      ExplicitWidth = 606
      object TabSheet1: TTabSheet
        Caption = #1054#1089#1085#1086#1074#1085#1072#1103
        ExplicitWidth = 598
        object WebBrowser1: TWebBrowser
          Left = 0
          Top = 0
          Width = 595
          Height = 454
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 606
          ExplicitHeight = 475
          ControlData = {
            4C0000007F3D0000EC2E00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1054#1090#1095#1077#1090
        ImageIndex = 1
        ExplicitWidth = 598
        object WebBrowser2: TWebBrowser
          Left = 0
          Top = 0
          Width = 595
          Height = 454
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 803
          ExplicitHeight = 563
          ControlData = {
            4C0000007F3D0000EC2E00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\tempWork\SBMS\ba' +
      'se\Megafon # + '#1080#1085#1090#1077#1088#1082#1086#1084'.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 56
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from '#1082#1086#1085#1090#1088#1072#1082#1090)
    Left = 200
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 272
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Access|*.mdb'
    Left = 584
    Top = 248
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = Timer1Timer
    Left = 688
    Top = 320
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = Save_PDF
    Left = 456
    Top = 288
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Button4Click
    Left = 552
    Top = 368
  end
end
