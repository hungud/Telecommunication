object ReportReplaceSIMFrm: TReportReplaceSIMFrm
  Left = 0
  Top = 0
  Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1086#1084#1077#1088#1086#1074' '#1085#1072' '#1083#1080#1094#1077#1074#1086#1084' '#1089#1095#1105#1090#1077
  ClientHeight = 401
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrData: TCRDBGrid
    Left = 0
    Top = 28
    Width = 822
    Height = 335
    Align = alClient
    DataSource = dsReplaceSIM
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'OLD_SIM'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1088#1072#1103' SIM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NEW_SIM'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1074#1072#1103' SIM'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REP_USER'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REP_DATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1079#1072#1084#1077#1085#1099
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ERROR'
        Title.Alignment = taCenter
        Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOG_TYPE'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 822
    Height = 28
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 740
    object BitBtn1: TBitBtn
      Left = 2
      Top = 0
      Width = 151
      Height = 29
      Action = aExcel
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' MS Excel'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 153
      Top = 0
      Width = 105
      Height = 29
      Action = aRefresh
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 363
    Width = 822
    Height = 38
    Align = alBottom
    TabOrder = 2
    ExplicitWidth = 835
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 68
      Height = 13
      Caption = 'SOAP '#1079#1072#1087#1088#1086#1089':'
    end
    object Label2: TLabel
      Left = 409
      Top = 9
      Width = 64
      Height = 13
      Caption = 'SOAP '#1086#1090#1074#1077#1090':'
    end
    object DBTQuery: TDBEdit
      Left = 82
      Top = 6
      Width = 321
      Height = 22
      AutoSize = False
      DataField = 'SOAP_REQUEST'
      DataSource = dsReplaceSIM
      ReadOnly = True
      TabOrder = 0
    end
    object DBTAnswer: TDBEdit
      Left = 488
      Top = 6
      Width = 321
      Height = 22
      AutoSize = False
      DataField = 'ANSWER'
      DataSource = dsReplaceSIM
      ReadOnly = True
      TabOrder = 1
    end
  end
  object dsReplaceSIM: TDataSource
    DataSet = qReplaceSIM
    Left = 128
    Top = 144
  end
  object qReplaceSIM: TOraQuery
    SQLRefresh.Strings = (
      
        'SELECT PHONE_NUMBER,CLIENT_NAME,CLIENT_SURNAME,DATE_OF_SEND,TIME' +
        '_OF_SEND FROM Block_SEND_SMS'
      'WHERE'
      '  PHONE_NUMBER = :PHONE_NUMBER')
    SQL.Strings = (
      'select '
      '  rsl.old_sim,'
      '  rsl.new_sim,'
      '  rsl.rep_user,'
      '  rsl.rep_date,'
      '  (select ert.sim_error_type_name'
      '   from sim_error_type ert'
      '   where ert.sim_error_type_id = err) error,'
      '  bsl.soap_request,'
      '  nvl(bsl.soap_answer.GETstringval(),'#39#39') as answer,'
      '  (select lt.sim_log_type_name'
      '   from sim_log_type lt'
      '   where  lt.sim_log_type_id = rsl.sim_log_type_id) log_type'
      'from replace_sim_log rsl, '
      '        BEELINE_SOAP_API_log bsl'
      'where bsl.bsal_id(+)=rsl.bsal_id'
      'and rsl.phone=:pphone')
    FetchRows = 250
    Left = 56
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pphone'
      end>
    object qReplaceSIMOLD_SIM: TStringField
      FieldName = 'OLD_SIM'
      Size = 18
    end
    object qReplaceSIMNEW_SIM: TStringField
      FieldName = 'NEW_SIM'
      Size = 18
    end
    object qReplaceSIMREP_USER: TStringField
      FieldName = 'REP_USER'
      Size = 200
    end
    object qReplaceSIMREP_DATE: TDateTimeField
      FieldName = 'REP_DATE'
    end
    object qReplaceSIMERROR: TStringField
      FieldName = 'ERROR'
      Size = 32
    end
    object qReplaceSIMSOAP_REQUEST: TStringField
      FieldName = 'SOAP_REQUEST'
      Size = 4000
    end
    object qReplaceSIMANSWER: TStringField
      FieldName = 'ANSWER'
      Size = 4000
    end
    object qReplaceSIMLOG_TYPE: TStringField
      DisplayLabel = #1058#1080#1087
      FieldName = 'LOG_TYPE'
      Size = 300
    end
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
