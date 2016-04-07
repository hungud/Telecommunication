inherited ReportForm1: TReportForm1
  Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103' '#1087#1086' '#1040#1055#1048
  ClientWidth = 1166
  Position = poScreenCenter
  ExplicitWidth = 1184
  PixelsPerInch = 120
  TextHeight = 17
  inherited pButtons: TPanel
    Width = 1166
    Height = 85
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitWidth = 1166
    ExplicitHeight = 85
    object lbl: TLabel [0]
      Left = 42
      Top = 10
      Width = 102
      Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
      Caption = #1055#1086#1095#1090#1072' '#1082#1083#1080#1077#1085#1090#1072':'
    end
    inherited btRefresh: TBitBtn
      Left = 1021
      Top = 1
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Visible = False
      ExplicitLeft = 1021
      ExplicitTop = 1
    end
    inherited btLoadInExcel: TBitBtn
      Left = 575
      Top = 1
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ExplicitLeft = 575
      ExplicitTop = 1
    end
    object btnSendToMail: TBitBtn [3]
      Left = 377
      Top = 1
      Width = 191
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = aSendToMail
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086' '#1087#1086#1095#1090#1077
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F29C9C9C7373738585
        85D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC9C9C91E473E1FAD9D2CE4DC27CBBE106A5A7F8080FFFFFFF3F3F3919191
        8080808080808080808080808080808080801D433429D29F5CE2BC8FEACFB8F6
        EB38E1B9107D58A4A4A44D555A007BC2008CDF008CDF008CDF008CDF008CDF00
        81D11BA87B20CD8918D69F16DAA872E2BCBCF1DE21C67C35483D11405900A8FE
        00A9FF00A9FF00A9FF00A9FF00A9FF0096EB2DB75F2DC37529CA8427CD8A4ED5
        9DEAF8F02EBD6813432110425A00A9FB00B1FD00B2FF00B2FF00B2FF00A4F200
        7BC43AAE584BBE6B68CE8FBEECD3CBEFDBBCE4C248B95D193E2010445A00B2FF
        00ADF700B9FD00BAFF00B2F700A9DB00E7FC27B88974C272C2E2BCF5FAF4BDE0
        B67AC57951AA59112C3B10455A00B9FF00B9FF00AFF100BDFA00A6DB00E0FE00
        E0FF02D3EF4AB67A9DCE8DB2D8A3A7D49A74B66D0F86A310445810485A00C1FF
        00C1FF00C0FE009DD400D6FD00D7FF00D7FF00D7FF00CFF810B6B92D9D901D9C
        9A03A2D600BFFD10485A104C5A00CCFF00CCFF00AEE300CCFC00CDFF00CDFF00
        CDFF00CDFF00CDFF00CDFF00CCFD00B8F300CCFF00CCFF104C5A104F5A00D7FF
        00BCEA00C0FA00C4FF00C4FF00C4FF00C4FF00C4FF00C4FF00C4FF00C4FF00C2
        FD00C4F800D7FF104F5A10525A00CCF200B8F800BBFF00BBFF00BBFF00BBFF00
        BBFF00BBFF00BBFF00BBFF00BBFF00BBFF00BBFD00D2FC10525A10444D009ED9
        009FDF009FDF009FDF009FDF009FDF009FDF009FDF009FDF009FDF009FDF009F
        DF009FDF00A1DE10455188888880808080808080808080808080808080808080
        8080808080808080808080808080808080808080808080888888FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object EmailAdress: TEdit [4]
      Left = 175
      Top = 7
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 3
      Text = #1087#1086#1095#1090#1072'@'#1082#1083#1080#1077#1085#1090#1072'.ru'
    end
    inherited btnShowUserStatInfo: TBitBtn
      Left = 760
      Top = 1
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 4
      Visible = False
      ExplicitLeft = 760
      ExplicitTop = 1
    end
  end
  object pDetailBill: TPanel [1]
    Left = 0
    Top = 85
    Width = 1166
    Height = 441
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 1
    ExplicitTop = 0
    ExplicitWidth = 1158
    ExplicitHeight = 409
    object gDetailBill: TCRDBGrid
      Left = 1
      Top = 1
      Width = 1164
      Height = 439
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      DataSource = dsDetailBill
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'USAGE_CONNECT_DATE'
          Title.Alignment = taCenter
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_CONNECT_TIME'
          Title.Alignment = taCenter
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_OTHER_NUMBER'
          Title.Alignment = taCenter
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_DIALED_DIGITS'
          Title.Alignment = taCenter
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_DATA_VOLUME'
          Title.Alignment = taCenter
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_DURATION'
          Title.Alignment = taCenter
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_FEATURE_DESCRIPTION'
          Title.Alignment = taCenter
          Width = 277
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_AT_CHARGE_AMT'
          Title.Alignment = taCenter
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_CELL_ID'
          Title.Alignment = taCenter
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_AT_NUM_MINS_TO_RATE'
          Title.Alignment = taCenter
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USAGE_CALL_ACTION_CODE'
          Title.Alignment = taCenter
          Width = 118
          Visible = True
        end>
    end
  end
  inherited pGrid: TPanel
    Top = 85
    Width = 1166
    Height = 441
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 1164
    ExplicitHeight = 83
    inherited gReport: TCRDBGrid
      Width = 1164
      Height = 439
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Columns = <
        item
          Expanded = False
          FieldName = 'CALLDATE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072'\'#1042#1088#1077#1084#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALLNUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1054#1090
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALLTONUMBER'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1091
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SERVICENAME'
          Title.Alignment = taCenter
          Title.Caption = #1059#1089#1083#1091#1075#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 156
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALLTYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1074#1099#1079#1086#1074#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAVOLUME'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084' '#1076#1072#1085#1085#1099#1093
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALLAMT'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CALLDURATION'
          Title.Alignment = taCenter
          Title.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 104
          Visible = True
        end>
    end
  end
  inherited qReport: TOraQuery
    SQL.Strings = (
      'select  callDate, '
      '              callNumber,'
      '              callToNumber, '
      '              serviceName,'
      '              callType, '
      '              dataVolume, '
      '              COST_STR_TO_NUMBER(callAmt) callAmt, '
      '              callDuration '
      '            from TABLE(GET_UNBILLED_CALLS_LIST_PIPE(:q_num))')
    FetchRows = 500
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'q_num'
      end>
    object qReportCALLDATE: TStringField
      FieldName = 'CALLDATE'
      Size = 26
    end
    object qReportCALLNUMBER: TStringField
      FieldName = 'CALLNUMBER'
      Size = 120
    end
    object qReportCALLTONUMBER: TStringField
      FieldName = 'CALLTONUMBER'
      Size = 30
    end
    object qReportSERVICENAME: TStringField
      FieldName = 'SERVICENAME'
      Size = 120
    end
    object qReportCALLTYPE: TStringField
      FieldName = 'CALLTYPE'
      Size = 120
    end
    object qReportDATAVOLUME: TStringField
      FieldName = 'DATAVOLUME'
      Size = 15
    end
    object qReportCALLAMT: TFloatField
      FieldName = 'CALLAMT'
    end
    object qReportCALLDURATION: TStringField
      FieldName = 'CALLDURATION'
      Size = 15
    end
  end
  inherited dsReport: TDataSource
    Left = 104
    Top = 160
  end
  inherited aList: TActionList
    Left = 40
    Top = 40
    object aSendToMail: TAction [2]
      Caption = 'aSendToMail'
      OnExecute = aSendToMailExecute
    end
  end
  object qDetailBill: TOraQuery
    SQL.Strings = (
      
        'SELECT X.USAGE_CONNECT_DATE, X.USAGE_CONNECT_TIME, X.USAGE_OTHER' +
        '_NUMBER,'
      
        '       X.USAGE_DIALED_DIGITS, X.USAGE_DATA_VOLUME, X.USAGE_DURAT' +
        'ION,'
      
        '       X.USAGE_FEATURE_DESCRIPTION, X.USAGE_AT_CHARGE_AMT, X.USA' +
        'GE_CELL_ID,'
      '       X.USAGE_AT_NUM_MINS_TO_RATE,'
      '       CASE'
      '         WHEN X.USAGE_CALL_ACTION_CODE = '#39'1'#39' THEN '#39#1048#1089#1093#1086#1076#1103#1097#1080#1081#39
      '         WHEN X.USAGE_CALL_ACTION_CODE = '#39'2'#39' THEN '#39#1042#1093#1086#1076#1103#1097#1080#1081#39
      '         ELSE '#39#1053#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086#39
      '       END USAGE_CALL_ACTION_CODE'
      
        '  FROM TABLE(COLLECTOR_PCKG.GET_BILLING_CALLS_PIPE(:PHONE_NUMBER' +
        ', :YEAR_MONTH)) X')
    FetchRows = 500
    Left = 72
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qDetailBillUSAGE_CONNECT_DATE: TStringField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'USAGE_CONNECT_DATE'
      Size = 60
    end
    object qDetailBillUSAGE_CONNECT_TIME: TStringField
      Alignment = taCenter
      DisplayLabel = #1042#1088#1077#1084#1103
      FieldName = 'USAGE_CONNECT_TIME'
      Size = 60
    end
    object qDetailBillUSAGE_OTHER_NUMBER: TStringField
      DisplayLabel = #1057#1086#1073#1077#1089#1077#1076#1085#1080#1082
      FieldName = 'USAGE_OTHER_NUMBER'
      Size = 120
    end
    object qDetailBillUSAGE_DIALED_DIGITS: TStringField
      DisplayLabel = #1057#1086#1073#1077#1089#1077#1076#1085#1080#1082'('#1094#1080#1092#1088')'
      FieldName = 'USAGE_DIALED_DIGITS'
      Size = 60
    end
    object qDetailBillUSAGE_DATA_VOLUME: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1044#1072#1085#1085#1099#1077'('#1052#1073')'
      FieldName = 'USAGE_DATA_VOLUME'
      Size = 60
    end
    object qDetailBillUSAGE_DURATION: TStringField
      Alignment = taCenter
      DisplayLabel = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
      FieldName = 'USAGE_DURATION'
      Size = 60
    end
    object qDetailBillUSAGE_FEATURE_DESCRIPTION: TStringField
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077
      FieldName = 'USAGE_FEATURE_DESCRIPTION'
      Size = 600
    end
    object qDetailBillUSAGE_AT_CHARGE_AMT: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100
      FieldName = 'USAGE_AT_CHARGE_AMT'
      Size = 60
    end
    object qDetailBillUSAGE_CELL_ID: TStringField
      Alignment = taCenter
      DisplayLabel = #1041#1057
      FieldName = 'USAGE_CELL_ID'
      Size = 60
    end
    object qDetailBillUSAGE_AT_NUM_MINS_TO_RATE: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1045#1076#1080#1085#1080#1094
      FieldName = 'USAGE_AT_NUM_MINS_TO_RATE'
      Size = 60
    end
    object qDetailBillUSAGE_CALL_ACTION_CODE: TStringField
      DisplayLabel = #1058#1080#1087' '#1079#1074#1086#1085#1082#1072
      FieldName = 'USAGE_CALL_ACTION_CODE'
      Size = 25
    end
  end
  object dsDetailBill: TDataSource
    DataSet = qDetailBill
    Left = 104
    Top = 248
  end
end
