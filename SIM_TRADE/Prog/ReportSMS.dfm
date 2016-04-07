object ReportSMSForm: TReportSMSForm
  Left = 0
  Top = 0
  Caption = ' '#1058#1077#1082#1091#1097#1072#1103' '#1086#1095#1077#1088#1077#1076#1100' SMS'
  ClientHeight = 300
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object GridSMS_Current: TCRDBGrid
    Left = 0
    Top = 0
    Width = 920
    Height = 300
    Align = alClient
    DataSource = ds1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = popupMenuSMSCurrent
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PROVIDER_ID'
        Title.Caption = #1050#1083#1102#1095' '#1087#1088#1086#1074#1072#1081#1076#1077#1088#1072
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE'
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MESSAGE'
        Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RESULT_STR'
        Title.Caption = #1057#1090#1088#1086#1082#1072' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS_CODE'
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPTION_STR'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMS_ID'
        Title.Caption = #1050#1083#1102#1095' SMS'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INSERT_DATE'
        Title.Caption = #1058#1077#1082#1091#1097#1072#1103' '#1044#1072#1090#1072
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UPDATE_DATE'
        Title.Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1085#1072#1103' '#1076#1072#1090#1072
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR_CODE'
        Title.Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REQ_COUNT'
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1087#1088#1086#1089#1086#1074
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_START'
        Title.Caption = #1044#1072#1090#1072' '#1047#1072#1087#1091#1089#1082#1072
        Width = 151
        Visible = True
      end>
  end
  object sms_current_query1: TOraQuery
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      
        'SELECT PROVIDER_ID, PHONE ,MESSAGE, RESULT_STR, STATUS_CODE, DES' +
        'CRIPTION_STR, SMS_ID,INSERT_DATE ,UPDATE_DATE ,ERROR_CODE ,REQ_C' +
        'OUNT ,DATE_START'
      'FROM SMS_CURRENT'
      'ORDER BY PHONE ASC')
    Left = 184
    Top = 80
  end
  object ds1: TDataSource
    DataSet = sms_current_query1
    Left = 256
    Top = 64
  end
  object popupMenuSMSCurrent: TPopupMenu
    Left = 424
    Top = 88
    object N1: TMenuItem
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      OnClick = aExcelExecute
    end
  end
end
