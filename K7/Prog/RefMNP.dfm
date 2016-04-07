inherited MNP_NUMBERS: TMNP_NUMBERS
  Caption = 'MNP_NUMBERS'
  ClientHeight = 398
  ClientWidth = 1087
  ExplicitWidth = 1095
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 13
  inherited sPanel1: TsPanel
    Top = 364
    Width = 1087
    ExplicitTop = 364
    ExplicitWidth = 1087
    inherited sBsave: TsBitBtn
      Left = 796
      ExplicitLeft = 796
    end
    inherited sBClose: TsBitBtn
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited PageControl1: TPageControl
    Width = 1087
    Height = 364
    ActivePage = TabSheet2
    ExplicitWidth = 1087
    ExplicitHeight = 364
    inherited TabSheet1: TTabSheet
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074
      TabVisible = True
      ExplicitTop = 24
      ExplicitWidth = 1079
      ExplicitHeight = 336
      inherited TlBr: TsToolBar
        Width = 1079
        ExplicitWidth = 1079
      end
      inherited CRGrid: TCRDBGrid
        Width = 1079
        Height = 307
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1046#1091#1088#1085#1072#1083' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074
      ImageIndex = 1
      object sToolBar1: TsToolBar
        Left = 0
        Top = 0
        Width = 1079
        Height = 31
        ButtonHeight = 30
        ButtonWidth = 35
        DoubleBuffered = True
        Images = Dm.ImageList24
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        SkinData.SkinSection = 'TOOLBAR'
        object ToolButton8: TToolButton
          Left = 0
          Top = 0
          Action = aRefresh1
        end
        object ToolButton1: TToolButton
          Left = 35
          Top = 0
          Width = 8
          Caption = 'btn7'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object ToolButton9: TToolButton
          Left = 43
          Top = 0
          Action = aFind1
        end
        object ToolButton10: TToolButton
          Left = 78
          Top = 0
          Action = aFiltr1
        end
        object ToolButton11: TToolButton
          Left = 113
          Top = 0
          Action = aToExcel1
        end
        object ToolButton12: TToolButton
          Left = 148
          Top = 0
          Width = 8
          Caption = 'btn1'
          ImageIndex = 16
          Style = tbsSeparator
        end
        object ToolButton13: TToolButton
          Left = 156
          Top = 0
          Action = aFirst1
        end
        object ToolButton14: TToolButton
          Left = 191
          Top = 0
          Action = aMovePrev1
        end
        object ToolButton15: TToolButton
          Left = 226
          Top = 0
          Action = aPrev
        end
        object ToolButton16: TToolButton
          Left = 261
          Top = 0
          Action = aNext1
        end
        object ToolButton17: TToolButton
          Left = 296
          Top = 0
          Action = aMoveNext1
        end
        object ToolButton18: TToolButton
          Left = 331
          Top = 0
          Action = aLast1
        end
        object ToolButton7: TToolButton
          Left = 366
          Top = 0
          Width = 12
          Caption = 'ToolButton7'
          ImageIndex = 21
          Style = tbsSeparator
        end
        object RadioGroup1: TRadioGroup
          Left = 378
          Top = 0
          Width = 259
          Height = 30
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086':'
          Columns = 2
          ItemIndex = 1
          Items.Strings = (
            #1074#1088#1077#1084#1077#1085#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091
            #1086#1089#1085#1086#1074#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091)
          TabOrder = 0
        end
        object ToolButton2: TToolButton
          Left = 637
          Top = 0
          Action = aShowInfo
        end
        object ToolButton3: TToolButton
          Left = 672
          Top = 0
          Width = 12
          Caption = 'ToolButton3'
          ImageIndex = 18
          Style = tbsSeparator
        end
        object Shape4: TShape
          Left = 684
          Top = 0
          Width = 47
          Height = 30
          Hint = 
            '                 1'#1089#1086#1073#1099#1090#1080#1077'.'#13#10'  '#1053#1086#1074#1099#1077', '#1089#1086#1079#1076#1072#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' '#1074' '#1090#1072#1073#1083#1080#1094#1077' ' +
            #1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074' '#13#10#1087#1091#1090#1077#1084' '#1088#1091#1095#1085#1086#1075#1086' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1080#1083#1080' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1072 +
            #1084#1080'.'#13#10'  '#1059' '#1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089#1077#1081' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1072' '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#13#10#1074' '#1085#1077 +
            #1072#1082#1090#1080#1074#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077'.  '#13#10'  '#1062#1074#1077#1090' '#1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089#1077#1081' - '#1089#1080#1085#1080#1081'.|1'#1089#1086#1073#1099#1090#1080#1077'.'#13#10 +
            #1053#1086#1074#1099#1077', '#1089#1086#1079#1076#1072#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' '#1074' '#1090#1072#1073#1083#1080#1094#1077' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074' '#1087#1091#1090#1077#1084' '#1088#1091#1095#1085#1086#1075#1086' '#1076#1086#1073#1072 +
            #1074#1083#1077#1085#1080#1103' '#1080#1083#1080' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1072#1084#1080'. '#1059' '#1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089#1077#1081' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100' '#1052 +
            #1053#1055' '#1085#1086#1084#1077#1088#1072' '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1074' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077'.  '#1062#1074#1077#1090' '#1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089 +
            #1077#1081' - '#1089#1080#1085#1080#1081'.'
          Brush.Color = clBlue
          Brush.Style = bsHorizontal
          Pen.Color = clBlue
        end
        object ToolButton4: TToolButton
          Left = 731
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 19
          Style = tbsSeparator
        end
        object Shape5: TShape
          Left = 739
          Top = 0
          Width = 47
          Height = 30
          Hint = 
            '          2 '#1089#1086#1073#1099#1090#1080#1077'.'#13#10'  '#1055#1088#1080' '#1087#1086#1083#1091#1095#1077#1085#1080#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1089#1090#1072#1090#1091#1089#1072' '#1085#1086#1084#1077#1088#1072', ' +
            #13#10#1077#1089#1083#1080' '#1085#1086#1084#1077#1088' '#1089#1090#1072#1085#1086#1074#1080#1090#1089#1103' '#1072#1082#1090#1080#1074#1085#1099#1081', '#1080#1097#1077#1084' '#1101#1090#1086#1090' '#1085#1086#1084#1077#1088' '#1074' '#13#10#1090#1072#1073#1083#1080#1094#1077' '#1052#1053 +
            #1055' '#1085#1086#1084#1077#1088#1086#1074'. '#13#10'  '#1045#1089#1083#1080' '#1085#1072#1093#1086#1076#1080#1084', '#1090#1086' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1091' '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1084' '#1079#1072#1087#1080#1089#1100' '#1072#1082#1090 +
            #1080#1074#1085#1099#1081'. '#13#10'  '#1062#1074#1077#1090' '#1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089#1077#1081' - '#1082#1088#1072#1089#1085#1099#1081'.|          2 '#1089#1086#1073#1099#1090#1080#1077'.'#13#10' ' +
            ' '#1055#1088#1080' '#1087#1086#1083#1091#1095#1077#1085#1080#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1089#1090#1072#1090#1091#1089#1072' '#1085#1086#1084#1077#1088#1072', '#13#10#1077#1089#1083#1080' '#1085#1086#1084#1077#1088' '#1089#1090#1072#1085#1086#1074#1080#1090#1089#1103 +
            ' '#1072#1082#1090#1080#1074#1085#1099#1081', '#1080#1097#1077#1084' '#1101#1090#1086#1090' '#1085#1086#1084#1077#1088' '#1074' '#13#10#1090#1072#1073#1083#1080#1094#1077' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074'. '#13#10'  '#1045#1089#1083#1080' '#1085#1072#1093 +
            #1086#1076#1080#1084', '#1090#1086' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1091' '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1084' '#1079#1072#1087#1080#1089#1100' '#1072#1082#1090#1080#1074#1085#1099#1081'. '#13#10'  '#1062#1074#1077#1090' '#1090#1072#1082#1080#1093' '#1079 +
            #1072#1087#1080#1089#1077#1081' - '#1082#1088#1072#1089#1085#1099#1081'.'
          Brush.Color = clRed
          Brush.Style = bsHorizontal
          Pen.Color = clRed
        end
        object ToolButton5: TToolButton
          Left = 786
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 20
          Style = tbsSeparator
        end
        object Shape6: TShape
          Left = 794
          Top = 0
          Width = 47
          Height = 30
          Hint = 
            '                3 '#1089#1086#1073#1099#1090#1080#1077#13#10'  '#1063#1077#1088#1077#1079' 3 '#1076#1085#1103' '#1072#1082#1090#1080#1074#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1087#1077#1088#1077#1093#1086#1076 +
            #1103#1090' '#1074' '#1080#1089#1090#1086#1088#1080#1102' '#1052#1053#1055' '#1080' '#13#10#1086#1089#1074#1086#1073#1086#1078#1076#1072#1102#1090' '#1090#1072#1073#1083#1080#1094#1091' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1086#1074'.  '#13#10'  '#1062#1074#1077#1090' ' +
            #1090#1072#1082#1080#1093' '#1079#1072#1087#1080#1089#1077#1081' - '#1095#1077#1088#1085#1099#1081'.'
          Brush.Color = clBlack
          Brush.Style = bsHorizontal
        end
        object ToolButton6: TToolButton
          Left = 841
          Top = 0
          Width = 16
          Caption = 'ToolButton6'
          ImageIndex = 21
          Style = tbsSeparator
        end
        object CheckBox1: TCheckBox
          Left = 857
          Top = 0
          Width = 109
          Height = 30
          Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1072
          TabOrder = 1
          WordWrap = True
          OnClick = CheckBox1Click
        end
      end
      object CRDBGrid1: TCRDBGrid
        Left = 0
        Top = 61
        Width = 1079
        Height = 275
        Align = alClient
        DataSource = dsqReport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = pm2
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        TitleFont.Quality = fqClearTypeNatural
        OnDrawColumnCell = CRDBGrid1DrawColumnCell
        OnMouseMove = CRDBGrid1MouseMove
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'PHONE_NUMBER'
            Title.Alignment = taCenter
            Width = 117
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'TEMP_PHONE_NUMBER'
            Title.Alignment = taCenter
            Width = 115
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SB'
            Title.Alignment = taCenter
            Width = 200
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATE_CREATED_'
            Title.Alignment = taCenter
            Width = 121
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATE_ACTIVATE'
            Title.Alignment = taCenter
            Width = 149
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATE_INSERTED'
            Title.Alignment = taCenter
            Width = 139
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_CREATED_FIO'
            Title.Alignment = taCenter
            Width = 200
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 31
        Width = 1079
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        object Bevel2: TBevel
          Left = 1
          Top = 1
          Width = 687
          Height = 29
        end
        object Label1: TLabel
          Left = 5
          Top = 8
          Width = 68
          Height = 13
          Caption = '1 '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1072
        end
        object Label2: TLabel
          Left = 292
          Top = 8
          Width = 68
          Height = 13
          Caption = '2 '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1072
        end
        object ComboBox1: TComboBox
          Left = 76
          Top = 5
          Width = 207
          Height = 21
          ItemIndex = 1
          TabOrder = 0
          Text = #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1089#1086#1073#1099#1090#1080#1102
          OnChange = ComboBox1Change
          Items.Strings = (
            #1085#1077' '#1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
            #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1089#1086#1073#1099#1090#1080#1102
            #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1086#1089#1085#1086#1074#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091
            #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091)
        end
        object ComboBox2: TComboBox
          Left = 365
          Top = 6
          Width = 207
          Height = 21
          ItemIndex = 1
          TabOrder = 1
          Text = #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1086#1089#1085#1086#1074#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091
          Items.Strings = (
            #1085#1077' '#1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
            #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1086#1089#1085#1086#1074#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091
            #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091)
        end
        object sBitBtn1: TsBitBtn
          Left = 577
          Top = 4
          Width = 105
          Height = 23
          Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1091
          Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
          Glyph.Data = {
            76060000424D760600000000000036000000280000001A000000140000000100
            1800000000004006000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFF0C35AE59600F7E2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFBF4E0E59800E8A200EFA700F4AA00F3A900E8A200E69B00F5
            D68FFFFFFFF7FEF80000FFFFFFFFFFFFFFFFFFFFFFFFFCF5E3E69B00E79F00E9
            A912FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF4E0E59800EFA700
            A47450805B7D855E76F3A900E69B00F5D68FFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFFFFFFFEEBB45E69D00E8A200E59900F6DDA3FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFBF4E0E59800F7AC005940AB0C0CFF1813FBFEB100E69B00F5
            D68FFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFDF7E9E69A00E7A100F4AA00E8
            A200E39100FDFAF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF4E0E59800F7AC00
            6146A11914FA231BEDFEB100E69B00F5D68FFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFFE49400E7A000FEB1006A4C97FEB100E79E00EDB83DFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFBF4E0E59800F7AC006146A11914FA231BEDFEB100E69B00F5
            D68FFFFFFFFFFFFF0000FFFFFFFFFFFFF5D691E69B00F6AC00A473510000FFA1
            7155F3A900E49500FCF7EAFFFFFFFFFFFFFFFFFFFFFFFFFBF4E0E59800F7AC00
            6146A11914FA231BEDFEB100E69B00F5D68FFFFFFFFFFFFF0000FFFFFFFFFFFF
            E59600ECA400D293190F0EFF1E18F33225DBEFA600E99F00EDB537FFFFFFFFFF
            FFFFFFFFFFFFFFFBF4E0E59800F7AC006146A11914FA231BEDFEB100E69B00F5
            D68FFFFFFFFFFFFF0000FFFFFFF4D48AE69B00FDB0005840AC1A15F8241CED11
            0FFF9D6F59F4AA00E49500FCF5E3FFFFFFFFFFFFFFFFFFFDFDFAE59800F7AC00
            6146A11914FA231BEDFEB100E69B00F7DCA0FFFFFFFFFFFF0000FFFFFFE39300
            EDA500C58A290709FF211AEF241CED1F19F1251DEAE49F04E9A000EBB430FFFF
            FFFFFEFDF0C25AE49400E8A200F7AC006146A11914FA231BEDFEB100E8A200E6
            9B00E28F00FDF6E80000EDB639E79E00EDA500B98237896172231BED221BEE11
            0FFF6C4D94DE9B0BEAA300E59800F5D792EBAF24E69A00E8A200EAA300FFB600
            6A4B971914FA241CECFFB900EDA500E8A200E8A100E596000000E59600E8A100
            E8A200EDA500FFB900241CEC1914FA6A4B97FFB600EAA300E8A200E69A00EBAF
            24F5D792E59800EAA300DE9B0B6C4D94110FFF221BEE231BED896172B98237ED
            A500E79E00EDB6390000FDF6E8E28F00E69B00E8A200FEB100231BED1914FA61
            46A1F7AC00E8A200E49400F0C25AFFFEFDFFFFFFEBB430E9A000E49F04251DEA
            1F19F1241CED211AEF0709FFC58A29EDA500E39300FFFFFF0000FFFFFFFFFFFF
            F7DCA0E69B00FEB100231BED1914FA6146A1F7AC00E59800FDFDFAFFFFFFFFFF
            FFFFFFFFFCF5E3E49500F4AA009D6F59110FFF241CED1A15F85840ACFDB000E6
            9B00F4D48AFFFFFF0000FFFFFFFFFFFFF5D68FE69B00FEB100231BED1914FA61
            46A1F7AC00E59800FBF4E0FFFFFFFFFFFFFFFFFFFFFFFFEDB537E99F00EFA600
            3225DB1E18F30F0EFFD29319ECA400E59600FFFFFFFFFFFF0000FFFFFFFFFFFF
            F5D68FE69B00FEB100231BED1914FA6146A1F7AC00E59800FBF4E0FFFFFFFFFF
            FFFFFFFFFFFFFFFCF7EAE49500F3A900A171550000FFA47351F6AC00E69B00F5
            D691FFFFFFFFFFFF0000FFFFFFFFFFFFF5D68FE69B00FEB100231BED1914FA61
            46A1F7AC00E59800FBF4E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDB83DE79E00
            FEB1006A4C97FEB100E7A000E49400FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            F5D68FE69B00FEB100231BED1914FA6146A1F7AC00E59800FBF4E0FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFDFAF1E39100E8A200F4AA00E7A100E69A00FDF7E9FF
            FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFF5D68FE69B00FEB1001813FB0C0CFF59
            40ABF7AC00E59800FBF4E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6DDA3
            E59900E8A200E69D00EEBB45FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            F5D68FE69B00F3A900855E76805B7DA47450EFA700E59800FBF4E0FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9A912E79F00E69B00FCF5E3FFFFFFFF
            FFFFFFFFFFFFFFFF0000F7FEF8FFFFFFF5D68FE69B00E8A200F3A900F4AA00EF
            A700E8A200E59800FBF4E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            F7E2AFE59600F0C35AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
          TabOrder = 2
          OnClick = aSortExecute
          SkinData.SkinSection = 'BUTTON'
        end
        object DateTimePicker1: TDateTimePicker
          Left = 908
          Top = 6
          Width = 81
          Height = 21
          Date = 42285.575843946760000000
          Time = 42285.575843946760000000
          TabOrder = 3
          OnChange = DateTimePicker1Change
        end
        object RadioGroup2: TRadioGroup
          Left = 696
          Top = -1
          Width = 209
          Height = 30
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = #1060#1080#1083#1100#1090#1088#1086#1074#1072#1090#1100' '#1087#1086':'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #1076#1072#1090#1077' '#1087#1077#1088#1077#1093#1086#1076#1072
            #1076#1072#1090#1077' '#1089#1086#1079#1076#1072#1085#1080#1103)
          TabOrder = 4
          OnClick = RadioGroup2Click
        end
        object CheckBox2: TCheckBox
          Left = 1002
          Top = 3
          Width = 71
          Height = 25
          Caption = #1060#1080#1083#1100#1090#1088' '#1074#1082#1083#1102#1095#1077#1085
          TabOrder = 5
          WordWrap = True
          OnClick = CheckBox2Click
        end
      end
    end
  end
  inherited actlst1: TActionList
    Top = 100
    object aRefresh1: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 9
      OnExecute = aRefresh1Execute
    end
    object aFind1: TAction
      AutoCheck = True
      Caption = #1055#1086#1080#1089#1082
      Hint = #1055#1086#1080#1089#1082
      ImageIndex = 15
      OnExecute = aFind1Execute
    end
    object aFiltr1: TAction
      AutoCheck = True
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' '
      ImageIndex = 13
      OnExecute = aFiltr1Execute
    end
    object aNext1: TAction
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 2
      OnExecute = aNext1Execute
    end
    object aPrev1: TAction
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 1
      OnExecute = aPrev1Execute
    end
    object aFirst1: TAction
      Caption = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 0
      OnExecute = aFirstExecute
    end
    object aLast1: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      ImageIndex = 3
      OnExecute = aLastExecute
    end
    object aMoveNext1: TAction
      Caption = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1042#1087#1077#1088#1077#1076' '#1085#1072' 1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 42
      OnExecute = aMoveNext1Execute
    end
    object aMovePrev1: TAction
      Caption = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      Hint = #1053#1072#1079#1072#1076' '#1085#1072'  1000 '#1079#1072#1087#1080#1089#1077#1081
      ImageIndex = 43
      OnExecute = aMovePrev1Execute
    end
    object aToExcel1: TAction
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' Excel'
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' Excel'
      ImageIndex = 45
      OnExecute = aToExcel1Execute
    end
    object aShowInfo: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      ImageIndex = 17
      OnExecute = aShowInfoExecute
    end
    object aSort: TAction
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1091
      ImageIndex = 52
      OnExecute = aSortExecute
    end
  end
  inherited pm1: TPopupMenu
    Left = 480
    Top = 76
  end
  inherited qGetNewId: TOraStoredProc
    Left = 616
    Top = 177
  end
  object qReport: TOraQuery
    Session = Dm.OraSession
    SQL.Strings = (
      'select '
      'phone_number, '
      'temp_phone_number,  '
      'date_activate, '
      'user_created, '
      'date_created,'
      'Date_Inserted,'
      'is_active,'
      'clr,'
      'CASE WHEN clr = 0 THEN '#39'1 '#1089#1086#1073#1099#1090#1080#1077'; '#1087#1086#1083#1091#1095#1077#1085#1080#1077' '#1052#1053#1055' '#1085#1086#1084#1077#1088#1072#39
      '     WHEN clr = 1 THEN '#39'2 '#1089#1086#1073#1099#1090#1080#1077'; '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1072' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100#39'   '
      '     ELSE '#39'3 '#1089#1086#1073#1099#1090#1080#1077'; '#1085#1086#1084#1077#1088' '#1087#1077#1088#1077#1096#1077#1083' '#1074' '#1080#1089#1090#1086#1088#1080#1102#39' END sb,'
      'USER_CREATED_FIO,'
      'DATE_CREATED_'
      ' from V_ACTIVE_MNP_REMOVE'
      'order by clr, temp_phone_number')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 448
    Top = 121
    object qReportPHONE_NUMBER: TStringField
      DisplayLabel = #1054#1089#1085#1086#1074#1085#1086#1081' '#1085#1086#1084#1077#1088
      DisplayWidth = 24
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qReportTEMP_PHONE_NUMBER: TStringField
      DisplayLabel = #1042#1088#1077#1084#1077#1085#1085#1099#1081' '#1085#1086#1084#1077#1088
      DisplayWidth = 23
      FieldName = 'TEMP_PHONE_NUMBER'
      Size = 40
    end
    object qReportSB: TStringField
      DisplayLabel = #1057#1086#1073#1099#1090#1080#1077
      FieldName = 'SB'
      Size = 61
    end
    object qReportDATE_CREATED_: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      DisplayWidth = 22
      FieldName = 'DATE_CREATED_'
    end
    object qReportDATE_ACTIVATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1077#1088#1077#1093#1086#1076#1072' ('#1092#1072#1082#1090'.)'
      DisplayWidth = 27
      FieldName = 'DATE_ACTIVATE'
    end
    object qReportDATE_INSERTED: TDateTimeField
      DisplayLabel = #1055#1077#1088#1077#1093#1086#1076' '#1087#1088#1086#1080#1079#1086#1096#1105#1083
      DisplayWidth = 24
      FieldName = 'DATE_INSERTED'
    end
    object qReportUSER_CREATED_FIO: TStringField
      DisplayLabel = #1047#1072#1087#1080#1089#1100' '#1089#1086#1079#1076#1072#1083
      DisplayWidth = 1920
      FieldName = 'USER_CREATED_FIO'
      Size = 1600
    end
    object qReportUSER_CREATED: TStringField
      FieldName = 'USER_CREATED'
      Visible = False
      Size = 50
    end
    object qReportDATE_CREATED: TDateTimeField
      FieldName = 'DATE_CREATED'
      Visible = False
    end
    object qReportIS_ACTIVE: TFloatField
      FieldName = 'IS_ACTIVE'
      Visible = False
    end
    object qReportCLR: TFloatField
      FieldName = 'CLR'
      Visible = False
    end
  end
  object dsqReport: TOraDataSource
    DataSet = qReport
    Left = 447
    Top = 183
  end
  object pm2: TPopupMenu
    Images = Dm.ImageList24
    Left = 128
    Top = 116
    object MenuItem1: TMenuItem
      Action = aShowInfo
    end
  end
end
