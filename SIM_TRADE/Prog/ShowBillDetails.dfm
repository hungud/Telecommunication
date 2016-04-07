object ShowBillDetailsForm: TShowBillDetailsForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1082#1072#1076#1088#1086#1074#1082#1072' '#1089#1095#1077#1090#1072
  ClientHeight = 315
  ClientWidth = 1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1084
    Height = 35
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 4
      Width = 89
      Height = 25
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object CRDBGrid1: TCRDBGrid
    Left = 0
    Top = 35
    Width = 1084
    Height = 280
    Align = alClient
    DataSource = dsBillDetails
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
  end
  object qBillDetails: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT v.*'
      '  FROM V_BILL_FOR_CLIENT_DETAILS V'
      '  WHERE v.PHONE_NUMBER=:PHONE_NUMBER'
      '    AND v.YEAR_MONTH=:YEAR_MONTH')
    Left = 160
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end
      item
        DataType = ftUnknown
        Name = 'YEAR_MONTH'
      end>
    object qBillDetailsDATE_BEGIN: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 10
      FieldName = 'DATE_BEGIN'
    end
    object qBillDetailsDATE_END: TDateTimeField
      DisplayLabel = #1050#1086#1085#1077#1094
      DisplayWidth = 10
      FieldName = 'DATE_END'
    end
    object qBillDetailsPHONE_NUMBER: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      DisplayWidth = 12
      FieldName = 'PHONE_NUMBER'
      Size = 40
    end
    object qBillDetailsBILL_SUM: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1089#1095#1077#1090#1072
      FieldName = 'BILL_SUM'
    end
    object qBillDetailsSUBSCRIBER_PAYMENT_NEW: TFloatField
      DisplayLabel = #1040#1073#1086#1085'. '#1087#1083#1072#1090#1072
      FieldName = 'SUBSCRIBER_PAYMENT_NEW'
    end
    object qBillDetailsSUBSCRIBER_PAYMENT_ADD_NEW: TFloatField
      DisplayLabel = #1059#1089#1083#1091#1075#1080
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_NEW'
    end
    object qBillDetailsCALLS_LOCAL_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1089#1090#1085#1099#1077
      FieldName = 'CALLS_LOCAL_COST'
    end
    object qBillDetailsCALLS_OTHER_CITY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1075#1086#1088'.'
      FieldName = 'CALLS_OTHER_CITY_COST'
    end
    object qBillDetailsCALLS_OTHER_COUNTRY_COST: TFloatField
      DisplayLabel = #1047#1074'. '#1084#1077#1078'./'#1085#1072#1088'.'
      FieldName = 'CALLS_OTHER_COUNTRY_COST'
    end
    object qBillDetailsINTERNET_COST: TFloatField
      DisplayLabel = #1048#1085#1090#1077#1088#1085#1077#1090
      FieldName = 'INTERNET_COST'
    end
    object qBillDetailsMESSAGES_COST: TFloatField
      DisplayLabel = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      FieldName = 'MESSAGES_COST'
    end
    object qBillDetailsNATIONAL_ROAMING_COST: TFloatField
      DisplayLabel = #1053#1072#1094'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'NATIONAL_ROAMING_COST'
    end
    object qBillDetailsOTHER_COUNTRY_ROAMING_COST: TFloatField
      DisplayLabel = #1052'. '#1085#1072#1088'. '#1088#1086#1091#1084#1080#1085#1075
      FieldName = 'OTHER_COUNTRY_ROAMING_COST'
    end
    object qBillDetailsSINGLE_PAYMENTS: TFloatField
      DisplayLabel = #1056#1072#1079'. '#1074#1099#1087#1083#1072#1090#1099
      FieldName = 'SINGLE_PAYMENTS'
    end
    object qBillDetailsSUBSCRIBER_PAYMENT_ADD_VOZVRAT: TFloatField
      DisplayLabel = #1057#1082#1080#1076#1082#1072'(+, '#1057#1052#1057'300)'
      FieldName = 'SUBSCRIBER_PAYMENT_ADD_VOZVRAT'
    end
  end
  object dsBillDetails: TDataSource
    DataSet = qBillDetails
    Left = 264
    Top = 120
  end
  object qServiceParam: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'SELECT sv.volume_exceeded,'
      '  case'
      
        '    when (sv.volume_exceeded-to_number(substr(DB_LOADER_PCKG.GET' +
        '_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.service_volume_id),1,de' +
        'code(instr(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MO' +
        'NT,sv.service_volume_id),'#39' '#39')-1,-1,length(DB_LOADER_PCKG.GET_VOL' +
        'UME_SERVICE(:phone_num,:Year_MONT,sv.service_volume_id)),instr(D' +
        'B_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.servic' +
        'e_volume_id),'#39' '#39')-1))))>0 then'
      
        '     to_char(sv.volume_exceeded-to_number(substr(DB_LOADER_PCKG.' +
        'GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.service_volume_id),1' +
        ',decode(instr(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year' +
        '_MONT,sv.service_volume_id),'#39' '#39')-1,-1,length(DB_LOADER_PCKG.GET_' +
        'VOLUME_SERVICE(:phone_num,:Year_MONT,sv.service_volume_id)),inst' +
        'r(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.ser' +
        'vice_volume_id),'#39' '#39')-1))))'
      '    else '#39'0'#39
      '      end case,'
      
        '  substr(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MONT' +
        ',sv.service_volume_id),1,decode(instr(DB_LOADER_PCKG.GET_VOLUME_' +
        'SERVICE(:phone_num,:Year_MONT,sv.service_volume_id),'#39' '#39')-1,-1,le' +
        'ngth(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.' +
        'service_volume_id)),instr(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:pho' +
        'ne_num,:Year_MONT,sv.service_volume_id),'#39' '#39')-1)),'
      
        '  case when length(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,' +
        ':Year_MONT,sv.service_volume_id))>20 then substr(DB_LOADER_PCKG.' +
        'GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.service_volume_id),i' +
        'nstr(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:phone_num,:Year_MONT,sv.' +
        'service_volume_id),'#39' '#39')+4,19)'
      '    else '#39#39
      '      end case'
      '      FROM     service_volume sv'
      '      where sv.option_code=:opt_code')
    Left = 160
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'phone_num'
      end
      item
        DataType = ftUnknown
        Name = 'Year_MONT'
      end
      item
        DataType = ftUnknown
        Name = 'opt_code'
      end>
    object qServiceParamVOLUME_EXCEEDED: TFloatField
      DisplayLabel = #1055#1086#1088#1086#1075' '#1091#1089#1083#1091#1075#1080
      FieldName = 'VOLUME_EXCEEDED'
    end
    object qServiceParamCASE: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1054#1089#1090#1072#1083#1086#1089#1100
      DisplayWidth = 10
      FieldName = 'CASE'
      Size = 76
    end
    object qServiceParamSUBSTRDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTSVSERVICE_VOLUME_ID1DECODEINSTRDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTSVSERVICE_VOLUME_ID11LENGTHDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTS: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1055#1086#1090#1088#1072#1095#1077#1085#1086
      DisplayWidth = 10
      FieldName = 
        'SUBSTR(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:PHONE_NUM,:YEAR_MONT,S' +
        'V.SERVICE_VOLUME_ID),1,DECODE(INSTR(DB_LOADER_PCKG.GET_VOLUME_SE' +
        'RVICE(:PHONE_NUM,:YEAR_MONT,SV.SERVICE_VOLUME_ID),'#39#39')-1,-1,LENGT' +
        'H(DB_LOADER_PCKG.GET_VOLUME_SERVICE(:PHONE_NUM,:YEAR_MONT,S'
      Size = 4000
    end
    object qServiceParamCASE_1: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
      DisplayWidth = 18
      FieldName = 'CASE_1'
      Size = 76
    end
  end
  object qSMSUSSD: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select * from '
      
        '(select lss.date_send,'#39'SMS'#39',lss.sms_text,lss.date_send as insert' +
        '_date,lss.date_send as update_date,lss.note as status_desc,lss.n' +
        'ote as error_desc,null as err_all from log_send_sms lss'
      'where lss.phone_number=:PHONE_NUMBER'
      
        '--and trunc(lss.date_send,'#39'mm'#39')=to_date('#39'01'#39'||to_char(:YEAR_MONT' +
        'H),'#39'ddyyyymm'#39')'
      'and not exists (select 1 from SMS_SEND_PARAM_BY_ACCOUNT ssa'
      'where ssa.account_id=GET_ACCOUNT_ID_BY_PHONE(:PHONE_NUMBER))'
      'union all'
      
        'select null,'#39'SMS'#39',sl.message,sl.insert_date,sl.update_date,st.de' +
        'scriptions,se.descriptions,sl.description_str from SMS_current s' +
        'l, sms_status st, sms_error se'
      'where sl.phone=:PHONE_NUMBER'
      'and sl.error_code=se.slerror_code'
      'and sl.status_code=st.status_code'
      
        '--and trunc(sl.insert_date,'#39'mm'#39')=to_date('#39'01'#39'||to_char(:YEAR_MON' +
        'TH),'#39'ddyyyymm'#39')'
      'and exists (select 1 from SMS_SEND_PARAM_BY_ACCOUNT ssa'
      'where ssa.account_id=GET_ACCOUNT_ID_BY_PHONE(:PHONE_NUMBER))'
      'union all'
      
        'select sl.send_date,'#39'SMS'#39',sl.message,nvl(sl.submition_date,sl.in' +
        'sert_date),nvl(sl.last_status_change_date,sl.insert_date),st.des' +
        'criptions,se.descriptions,sl.slerror from SMS_log sl, sms_status' +
        ' st, sms_error se'
      'where sl.phone=:PHONE_NUMBER'
      'and sl.slerror_code=se.slerror_code'
      'and sl.status_code=st.status_code'
      
        '--and trunc(sl.insert_date,'#39'mm'#39')=to_date('#39'01'#39'||to_char(:YEAR_MON' +
        'TH),'#39'ddyyyymm'#39')'
      'and exists (select 1 from SMS_SEND_PARAM_BY_ACCOUNT ssa'
      'where ssa.account_id=GET_ACCOUNT_ID_BY_PHONE(:PHONE_NUMBER))'
      'union all'
      
        'select ul.ussd_date,'#39'USSD'#39',ul.text_res,ul.insert_date,ul.insert_' +
        'date,ul.xcpastatus,ul.error_text,null from ussd_log ul'
      'where '
      
        '--trunc(ul.ussd_date,'#39'mm'#39')=to_date('#39'01'#39'||to_char(:YEAR_MONTH),'#39'd' +
        'dyyyymm'#39')'
      '--and '
      'ul.msisdn=:PHONE_NUMBER'
      'and ul.type_log=1'
      'union all'
      
        'select sm.date_send,'#39'MAIL'#39',sm.mail_subject||'#39' '#39'||sm.note,sm.date' +
        '_send,sm.date_send,sm.note,sm.note,null from log_send_mail sm'
      'where sm.phone_number=:PHONE_NUMBER)'
      'order by 1 desc')
    Left = 160
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PHONE_NUMBER'
      end>
    object qSMSUSSDDATE_SEND: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080
      FieldName = 'DATE_SEND'
    end
    object qSMSUSSDSMS: TStringField
      DisplayLabel = #1058#1080#1087
      FieldName = #39'SMS'#39
      Size = 4
    end
    object qSMSUSSDSMS_TEXT: TStringField
      DisplayLabel = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      DisplayWidth = 50
      FieldName = 'SMS_TEXT'
      Size = 1200
    end
    object qSMSUSSDINSERT_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
      FieldName = 'INSERT_DATE'
    end
    object qSMSUSSDUPDATE_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      FieldName = 'UPDATE_DATE'
    end
    object qSMSUSSDSTATUS_DESC: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      DisplayWidth = 30
      FieldName = 'STATUS_DESC'
      Size = 2000
    end
    object qSMSUSSDERROR_DESC: TStringField
      DisplayLabel = #1054#1096#1080#1073#1082#1072
      DisplayWidth = 30
      FieldName = 'ERROR_DESC'
      Size = 2000
    end
    object qSMSUSSDERR_ALL: TStringField
      DisplayLabel = #1055#1088#1080#1095#1080#1085#1072
      DisplayWidth = 30
      FieldName = 'ERR_ALL'
      Size = 200
    end
  end
end
